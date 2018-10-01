<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');

class Seyfertbank extends CI_Controller {
  var $seyfertinfo;
  var $realdb;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    //$this->db = $this->load->database('real',true);
    session_write_close();
    $this->{$method}();
  }
/*출금ㄱㅖ좌검증요청*/
// 하루 허용 총 10원까지 가능 모든 타사계좌포함
public function sms(){
$mid = "zunme@nate.com";
$loan_id = "207";
  $loadmem = $this->db->query("select replace( replace(m_hp, '-', ''), ' ', '') as m_hp  from mari_member where m_id= ?", array($mid) )->row_array();
  $smsconf = $this->db->query('select * from mari_config limit 1', array($mid) )->row_array();
  $loan = $this->db->query('select * from mari_loan where i_id = ? ', array($loan_id) )->row_array();

  $to_hp = $loadmem['m_hp'];
  /*
  $invest_msg_02 = str_replace("{이름}", $row[m_name], $invest_msg_02);
  $invest_msg_02 = str_replace("{제목}", $o_subject, $invest_msg_02);
  $invest_msg_02 = str_replace("{회차}", $o_count[$k], $invest_msg_02);
  */
  $invest_msg = "[".$loan['i_subject']."] 상품";
  $invest_msg .= ($loan['i_look'] =="F") ? "이 상환완료 되었습니다.":"의 이자가 지급되었습니다.";
  $message_msg = mb_strlen($invest_msg, "euc-kr");
  if ($message_msg <= 80) {
    $sendSms = "sendSms";
  }
  else {
    $sendSms = "sendSms_lms";
  }

  $post_data = array(
    "cid" => "" . $smsconf['c_sms_id'] . "",
    "from" => "" . $smsconf['c_sms_phone'] . "",
    "to" => "" . $to_hp . "",
    "msg" => "" . $invest_msg . "",
    "mode" => "" . $sendSms . "",
    "smsmsg" => "정상적으로  문자발신 하였습니다.",
  );
  $requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";

  $curl_sms = curl_init();
  curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
  curl_setopt($curl_sms, CURLOPT_POST, 1);
  curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
  curl_setopt($curl_sms, CURLOPT_RETURNTRANSFER, 1 );
  curl_exec($curl_sms);
  curl_close($curl_sms);
}
  /* refid 취소 */
public function cancelusingref() {
  exit;
  $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
  $url = "https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel";
  $_method = "POST";
  $nonce      = "C" . time() . rand(111, 999);
  $refid      = "CR" . time() . rand(111, 999);
  $tid='TZRG9i';

  $info = $this->db->query('select * from mari_seyfert_order where s_tid = ? and s_payuse="Y" ' , array($tid))->row_array();
  if(!isset($info['s_tid'] ) ) {echo "TID: ".$tid. "데이터를 찾을 수 없습니다.";return;}

  $meminfo = $this->db->query('select * from mari_member where m_id = ? ', array($info['m_id']) )->row_array();
  $cont = $info['s_subject']."취소";

  $ENCODE_PARAMS   = "&_method=POST&desc=desc&_lang=ko&reqMemGuid=" . $config['c_reqMemGuid']
                    . "&nonce=" . $nonce . "&title=" . urlencode($cont) . "&refId=" . $info['s_refId']
                    . "&authType=SMS_MO&timeout=30&parentTid=".$tid;

  list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
  if(isset($data['data']['tid']) ){
      $result1 =  $this->db->set('s_payuse','N')->set('o_funding_cancel','Y')->where ('s_tid', $tid)->update('mari_seyfert_order');
      $result2 = $this->db->query('insert into mari_invest_moved select * from mari_invest where loan_id = ? and m_id = ? ', array($info['loan_id'],$info['m_id'] ));
      $result3 = $this->db->query('delete from mari_invest where loan_id = ? and m_id = ? ', array($info['loan_id'],$info['m_id'] ));
      $result4 = $this->db->query('update mari_member set m_emoney = m_emoney + ? where m_id = ?', array($info['s_amount'],$info['m_id']) );
      $result5 = $this->db->insert ('mari_emoney', array('m_id'=>$info['m_id'], 'p_content'=>$info['s_subject'].' 취소', 'p_emoney'=>$info['s_amount'], 'p_top_emoney'=>$meminfo['m_emoney']+$info['s_amount']) );
      var_dump($result1,$result2,$result3,$result4,$result5);

  }else {
    var_dump($res);
    var_dump($data);
  }
}
/* 계좌주 검증 요청 */
public function bank(){
  exit;
  $id = 'hsjjks@naver.com';
  $subject = "계좌주검증";
  $url="https://v5.paygate.net/v5/transaction/seyfert/checkbankcode";

  $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
  $_method = "POST";
  $nonce      = "bnkvn" . time() . rand(111, 999);
  $refId =$nonce = "bnkvr" . time() . rand(111, 999);
  $subject = "출금계좌검증";
  $from_info = $this->db->query('select * from mari_seyfert where m_id=? and s_memuse="Y"', array($id) )->row_array();
  $userinfo = $this->db->query('select * from mari_member where m_id=?', array($id) )->row_array();

  $ENCODE_PARAMS   = "&_method=POST&desc=desc&_lang=kr&reqMemGuid=".$config['c_reqMemGuid']. "&title=" . urlencode($subject) . "&nonce=" . $nonce . "&refId=" . $refId
   . "&authType=SMS_MO&timeout=30&dstMemGuid=" . $from_info['s_memGuid'] . "&crrncy=KRW&authSessionTimeout=0";

   list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
   var_dump($res);
   var_dump($data);

   if( !$res ) {
     $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );
   }else if ( $data['status'] != 'SUCCESS') {
     $this->json( array('code'=>203 ,'msg'=>"ERROR OCCURED", 'data'=>$data ) );
   }else {
     $tid = $data['data']['tid'];
     $this->db->insert('mari_seyfert_order', array('mid'=>$id, 's_subject'=>$subject, 'm_name'=> $userinfo['m_name'] ,'s_type'=>'3', 's_date'=>date('Y-m-d H:i:s') ));
     echo $this->db->last_query();
   }
}

private function getres($_method,$url, $ENCODE_PARAMS ){
  include_once(PluginPath);
  $cipher = AesCtr::encrypt($ENCODE_PARAMS, $this->seyfertinfo['c_reqMemKey'], 256);
  $cipherEncoded = urlencode($cipher);
  $requestString = "_method=".$_method."&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&encReq=".$cipherEncoded;
  $requestPath = $url."?".$requestString;
  $curl_handlebank = curl_init();
  curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
  /*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
  curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
  curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
  curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
  $result = curl_exec($curl_handlebank);
  if( $result===false ) $curlerror = curl_error($curl_handlebank);
  curl_close($curl_handlebank);
  $decode = json_decode($result, true);
  if( !is_array( $decode) )   return array(false, $curlerror);
  else return array(true, $decode);
}
}
