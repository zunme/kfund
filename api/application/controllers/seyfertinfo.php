<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
//ini_set("display_errors", 1);
//'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php'
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');

class Seyfertinfo extends CI_Controller {
  var $seyfertinfo;
  var $realdb;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    //$this->db = $this->load->database('real',true);
    session_write_close();
    $this->{$method}();
  }

  public function ipchaltest(){
    $id = 'zunme@nate.com';
    $subject = "선인증입찰테스트";
    $i_pay = 1000;

    /*test block*/
    exit;

    $url = "https://v5.paygate.net/v5/transaction/seyfert/transferPending";
    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
    $_method = "POST";
    $refId =$nonce = "Te" . time() . rand(111, 999);

    $from_info = $this->db->query('select * from mari_seyfert where m_id=? and s_memuse="Y"', array($id) )->row_array();

    $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=".$config['c_reqMemGuid'] . "&nonce=" . $nonce . "&title=" . urlencode($subject) . "&refId=" . $refId
     . "&authType=SMS_MO&timeout=30&srcMemGuid=" . $from_info['s_memGuid'] . "&dstMemGuid=" . $config['c_reqMemGuid'] . "&amount=" . $i_pay . "&crrncy=KRW&authSessionTimeout=0";
     list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
     var_dump($res);
     var_dump($data);
  }
  public function createmem() {

    $url ="https://v5.paygate.net/v5a/member/createMember";
    $_method = "POST";
    $nonce      = "VE" . time() . rand(111, 999);
    $refid      = "VEr" . time() . rand(111, 999);

    if ( $this->input->get('memid') !='' ){
      $mem = $this->db->query( "select * from mari_member where m_id= ? ", array($this->input->get('memid')))->row_array();
    }
    if( isset($mem['m_id']) && $mem['m_id'] !='' ){
    $this->seyfertinfo = $this->db->query(" select * from mari_config ")->row_array();

    $ENCODE_PARAMS = "&_method=POST&reqMemGuid=" . $this->seyfertinfo['c_reqMemGuid'] . "&desc=desc&nonce=" . $nonce . "&emailAddrss=" . $mem['m_id'] . "&emailTp=PERSONAL&fullname=" . urlencode($mem['m_name']) . "&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=" . $mem['m_hp'] . "&phoneTp=MOBILE";
    var_dump($ENCODE_PARAMS);
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    var_dump($data);
    }

  }
  /* ID 잔액조회 */
    public function lnq() {
      $url = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance";
      $_method = "POST";
      $nonce      = "VE" . time() . rand(111, 999);
      $refid      = "VEr" . time() . rand(111, 999);

      if ( !$this->input->post('mn') ) {
          $this->json( array('code'=>500 ,'msg'=>'POST ERROR') );return;
      }
      $this->seyfertinfo = $this->db->query(" select * from mari_config ")->row_array();
      if($this->input->post('mn') == 'angelfunding') {
        $s_memGuid = $this->seyfertinfo['c_reqMemGuid'];
      }else {
        $sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
        $bankck = $this->db->query($sql , $this->input->post('mn') )->row_array();
        if ( !isset( $bankck['s_memGuid']) ) {
          $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
          return;
        }
        $s_memGuid = $bankck['s_memGuid'];
      }
      $ENCODE_PARAMS ="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refid."&dstMemGuid=".$s_memGuid."&crrncy=KRW";
      list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
      if( !$res ) {
        $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );
      }else if ( $data['status'] != 'SUCCESS') {
        $this->json( array('code'=>203 ,'msg'=>"ERROR OCCURED", 'data'=>$data ) );
      }else {
        $amount = isset( $data['data']["moneyPair"]["amount"] ) ? (int) $data['data']["moneyPair"]["amount"] : '0';
        if($this->input->post('mn') == 'angelfunding') {
            $rows = $this->db->query('select * from z_balance_log order by regdate desc limit 2')->result_array();
            $row = $rows[0];
            $balance = (isset($row['balance']) ) ? $row['balance'] : '0' ;
            if ($balance != $amount ) $this->db->insert ('z_balance_log', array('balance'=>$amount) ) ;
            $data = array(
              'beforebalance'=>$rows[1]['balance'],'beforetime'=>$rows[1]['regdate'], 'amount2'=>number_format($amount - $rows[1]['balance'])
            );
        }
        $this->json( array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>array('amount'=>$amount,'han'=>$this->getConvertNumberToKorean($amount), 'data'=>$data) ) );
      }
  	}

  function preauthcheck() {
    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
    $sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
    $bankck = $this->db->query($sql , $this->input->get('mid') )->row_array();
    if ( !isset( $bankck['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $s_memGuid = $bankck['s_memGuid'];

    $url = "https://v5.paygate.net/v5/transaction/pending/preAuth/register";
    $_method = "GET";
    $refId =$nonce = "PAul".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId."&dstMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&srcMemGuid=".$s_memGuid;
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      $trnsctnSt = isset($data['data']['detailList'][0]['trnsctnSt']) ? $data['data']['detailList'][0]['trnsctnSt'] :'';//PRE_AUTH_REG_FINISHED
      $tid = isset($data['data']['detailList'][0]['tid'] ) ? $data['data']['detailList'][0]['tid'] : '';
        //            $ret['cmpltDt']  = date ("Y-m-d", (int)($row['cmpltDt']/1000) );
      if($tid != ''){
        if ($trnsctnSt != '') {
          $ret= $this->preauthcodemap($trnsctnSt);
          if($ret['code']==200){
            $ret['msg']  = '인증('.date ("m-d", (int)($data['data']['detailList'][0]['cmpltDt']/1000) ).')';
          }
        }else {
            $ret = array('msg'=>'에러발생 다시 시도해주세요');
        }
      }else {
        $ret = array('msg'=>'미인증');
      }
    }else {
      $ret = array('msg'=>'에러발생 다시 시도해주세요');
    }
        echo($ret['msg']);
//      return;


      /*
      $trnsctnSt = isset($data['data']['detailList'][0]['trnsctnSt']) ? $data['data']['detailList'][0]['trnsctnSt'] :'';//PRE_AUTH_REG_FINISHED
      $tid = isset($data['data']['detailList'][0]['tid'] ) ? $data['data']['detailList'][0]['tid'] : '';
      // TODO id= , tid != 조건 삭제 필요
      if($tid != ''){
        if ($trnsctnSt != '') {
            $ret= $this->preauthcodemap($trnsctnSt);
            if($ret['code']==200){
              $ret ['code']=200; $ret['msg']='인증완료';
              $ret['cmpltDt']  = date ("Y-m-d", (int)($row['cmpltDt']/1000) );
            }
            $this->json($ret);
        } else $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
      } else $this->json(array('code'=>400, 'msg'=>"요청가능"));
    } else {
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }
    */
  }

  /* 거래 */
  public function tranceit() {
    date_default_timezone_set('Asia/Seoul');
    $this->load->library('form_validation');
    //$this->form_validation->set_rules('from', '보내는사람', 'trim|required|min_length[5]|xss_clean');
    $this->form_validation->set_rules('to', '받는 이메일', 'trim|required|valid_email');
    $this->form_validation->set_rules('amount', '이체액수', 'trim|required|integer|greater_than[0]');
    $this->form_validation->set_rules('cont', '이체내용', 'trim|required|xss_clean');
    $this->form_validation->set_error_delimiters('', '');
    if ($this->form_validation->run() == FALSE) {
      echo json_encode( array("code"=>500, "msg"=>'이체내용을 확인해주세요'));//validation_errors()
      return;
    }

    //$from = $this->input->post('from');
    $from = "kfunding";
    $to = $this->input->post('to');
    $amount = $this->input->post('amount');
    $withholding = $this->input->post('withholding');
    $interest = $this->input->post('interest');
    $count = $this->input->post('count');

    $cont = htmlspecialchars($this->input->post('cont'));

    $loan_id = $this->input->post('loan_id');
    $loan_id = ( (int)$loan_id > 0 ) ? $loan_id : 0;


    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();

    if($from =='zunme'){
      $from_info = array(
        'm_name'=>'테스트','s_memGuid'=>'NwYqhfe7h52vUpAs8KRFBh'
      );
    }else if($from=='kfunding'){
      $from_info = array(
        'm_name'=>'케이펀딩','s_memGuid'=>$config['c_reqMemGuid']//'NwYqhfe7h52vUpAs8KRFBh'
      );
      /*
//test only
      $from_info = array(
        'm_name'=>'테스트','s_memGuid'=>'NwYqhfe7h52vUpAs8KRFBh'
      );
*/
    }else {
      $from_info = $this->db->query('select * from mari_seyfert where m_id=? and s_memuse="Y"', array($from) )->row_array();
    }
    $to_info = $this->db->query('select * from mari_seyfert where m_id=? and s_memuse="Y"', array($to) )->row_array();
    if(!isset($from_info['s_memGuid']) || $from_info['s_memGuid']==''){
      echo json_encode( array('code'=>404, 'msg'=>'보내는 사람 정보를 찾을 수 없습니다.') );return;
    }else if(!isset($to_info['s_memGuid']) || $to_info['s_memGuid']==''){
      echo json_encode( array('code'=>404, 'msg'=>'받는 사람 정보를 찾을 수 없습니다.') );return;
    }


    if($loan_id > 0){
      $loaninfo = $this->db->query('select * from mari_loan a where a.i_id = ? ', array($loan_id))->row_array();
      $invest = $this->db->query('select * from mari_invest a where a.loan_id = ? and a.m_id = ? ', array($loan_id, $to_info['m_id']) )->row_array();
      if( !isset($invest['i_pay']) ){
        $msg = $loaninfo['i_subject'].' 에 투자하지 않은 회원입니다. 진행할 수 없습니다.';
        echo json_encode( array('code'=>500, 'msg'=>$msg, 'title'=>'대상오류') ); return;
      }
    }

    if($this->input->get('confrim')!='Y') {
      $msg = $from_info['m_name']."(".$from.") 계좌에서 "
          .$to_info['m_name']."(".$to.") 계좌로 "
          .number_format($amount)."원을 이체합니다.";
      echo json_encode( array('code'=>200, 'msg'=>$msg, 'title'=>$cont) );
      return;
    }else{
      ;
    }
/* block */
//return;
    $order_code      = "SO" . time() . rand(111, 999);
    $ju_code         = "SR" . time() . rand(111, 999);

    $url = "https://v5.paygate.net/v5/transaction/seyfert/transfer";
    $_method = "POST";

    $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=" . $config['c_reqMemGuid']
                      . "&nonce=" . $order_code . "&title=" . urlencode($cont) . "&refId=" . $ju_code
                      . "&authType=SMS_MO&timeout=30&srcMemGuid=" . $from_info['s_memGuid'] . "&dstMemGuid=" . $to_info['s_memGuid']
                      . "&amount=" . $amount . "&crrncy=KRW";



    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );

    $savedata = array('refId'=>$ju_code,'tid'=>'', 'from'=>$from, 'to'=>$to, 'amount'=>$amount,'cont'=>$cont ,'completed'=>'Y','req_status'=>'E','req_desc'=>'','req_data'=>'');
    if( !$res ) {
      $savedata['req_status'] = 'G';
      $savedata['req_desc'] = 'GATE Connection Error';
      $this->db->insert('z_trance_log',$savedata);
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );return;
    }else if ( $data['status'] != 'SUCCESS') {
      $savedata['req_desc'] = $data['data']['cdDesc'];
      $savedata['req_data'] = serialize($data['data']);
      $this->db->insert('z_trance_log',$savedata);
      $this->json( array('code'=>203 ,'msg'=>$savedata['req_desc'], 'data'=>$data ) );return;
    }else {
      $savedata['req_status'] ='S';
      $savedata['tid'] =$tid = $data['data']['tid'];
      $savedata['req_data'] = serialize($data['data']);

      $this->db->insert('z_trance_log',$savedata);
      $log_id = $this->db->insert_id();
      $error_msg = '';

      $sey_orderdata_idx=$order_data_idx=$emoney_data_idx=0;

      if($this->input->post('ignore')!='Y'){
        $sey_orderdata = array(
          'm_id'=>$to_info['m_id'],'m_name'=>$to_info['m_name'],'s_amount'=>$amount,'loan_id'=>$loan_id,'s_subject'=>$cont,
          's_tid'=>$tid,'s_refId'=>$ju_code,'s_payuse'=>'N','s_type'=>1
        );
        if(!$this->db->insert('mari_seyfert_order',$sey_orderdata) ) {
          $error_msg .= 'syefert ins||';
        }else $sey_orderdata_idx = $this->db->insert_id();

        if($loan_id > 0 ) {
          $order_data = array(
            'loan_id'=>$loan_id,'o_payment'=>$loaninfo['i_payment'],'sale_id'=>$to_info['m_id'],'sale_name'=>$to_info['m_name'],
            'user_id'=>$loaninfo['m_id'],'user_name'=>$loaninfo['m_name'],'o_subject'=>$loaninfo['i_subject'],'o_count'=>$count,
            'o_ln_money_to'=>$invest['i_pay'],'o_investamount'=>$interest,'o_mh_money'=>0,
            'o_ln_iyul'=> ( (int)$loaninfo['i_year_plus'] > 0  ) ? (int)( (int)$loaninfo['i_year_plus']/10 ) : 0,
            'o_status'=>'입금완료','o_salestatus'=>'정산완료',
            'o_saleln_money'=>$invest['i_pay'],'o_saletotalamount'=>$interest,'o_ipay'=>$invest['i_pay'],'o_interest'=>$interest,
            'o_datetime'=>date('Y-m-d H:i:s'),'o_collectiondate'=>date('Y-m-d H:i:s'),
            'o_withholding'=>$withholding,
            'o_type'=>'sale', 'o_paytype'=>'만기일시상환', 'i_loan_type'=>'real'
          );

          if(!$this->db->insert('mari_order',$order_data) ) {
            $error_msg .= 'order ins||';
          }else $order_data_idx = $this->db->insert_id();
        }
        $emoney_real_data = $this->db->query('select p_top_emoney from mari_emoney where m_id = ? order by p_id desc limit 1', array($to_info['m_id']))->row_array();
        $top_emoney = isset( $emoney_real_data['p_top_emoney']) ? $emoney_real_data['p_top_emoney'] : 0;
        $emoney_data = array(
          'm_id'=>$to_info['m_id'], 'p_datetime'=>date('Y-m-d H:i:s'), 'p_content'=>$cont,'p_emoney'=>$amount, 'p_top_emoney'=>$amount + $top_emoney,
          'loan_id'=>$loan_id, 'o_id'=>$order_data_idx
        );
        if(!$this->db->insert('mari_emoney',$emoney_data) ) {
          $error_msg .= 'emoney ins||';
        }else $emoney_data_idx = $this->db->insert_id();

        if(!$this->db->query('update mari_member set m_emoney = ? where m_id = ? ', array( $amount + $top_emoney , $to_info['m_id']) ) ) {
          $error_msg .= 'update total||';
        }
      }
      $this->db->where('idx',$log_id )->update('z_trance_log', array('req_desc'=>$error_msg, 'order_idx'=>$order_data_idx, 'seyfert_o_idx'=>$sey_orderdata_idx,'emoney_idx'=>$emoney_data_idx));
      if($error_msg=='') $this->json( array('code'=>200 ,'msg'=>"success",'title'=>'이체완료', 'data'=>$data ) );
      else $this->json( array('code'=>202 ,'msg'=>"이체는 완료했으나 DB업데이트상에 에러가 발생했습니다 로그를 확인해주세요.".$error_msg,'title'=>'이체완료', 'data'=>$data ) );
      return;

    }

  }
 public function trancelistref() {
   //paygate.net/v5a/admin/transaction/total?reqMemGuid=merchantGuid
   $start = (int)($this->input->get('start'));
   $page =($start < 1) ? 1 : (  (int)($start/10)+1 );
   $this->seyfertinfo = $this->db->query(" select * from mari_config ")->row_array();
   //$url = "https://v5.paygate.net/v5a/admin/transaction/total";
   $url = "https://v5.paygate.net/v5a/admin/transaction/list";
   $_method = "GET";
   $nonce = 'List'.time().rand(111,99);

   $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce;
   //$ENCODE_PARAMS .= "&limit=10&page=".$page;
   $ENCODE_PARAMS .= "&refId=P1516342010734";//.$this->input->get('refId');
   list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
   $this->db->query('insert into z_tmp (data) values ("'.addslashes(json_encode($data)).'")');
   if( !$res ) {
     $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );return;
   }else var_dump($data);
 }
  /* 잔액변동내역 */
  public function trancebalance() {
    $mid = trim($this->input->get('mid'));
    $start = (int)($this->input->get('start'));
    //$type=($this->input->get('type')=='dst') ?'dst':'src';
    $type="dst";
    $page =($start < 1) ? 1 : (  (int)($start/10)+1 );
    $url = "https://v5.paygate.net/v5a/admin//seyfertList";
    $_method = "GET";

    $nonce = time().rand(111,99);
    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();

    if( $mid =='angel') {
        $bankck['s_memGuid'] = $config['c_reqMemGuid'];
    }else {
      $sql = "select  * from mari_seyfert where m_id = ?";
      $bankck = $this->db->query($sql , $mid )->row_array();

      if ( !isset( $bankck['s_memGuid']) ) {
        $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
        return;
      }
    }

    //$KEY_ENC    = $config['c_reqMemKey'];
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$config['c_reqMemGuid']."&nonce=".$nonce;
    $ENCODE_PARAMS .= "&limit=10&page=".$page;
    $ENCODE_PARAMS .=  ($type=="dst")? "&dstMemGuid=".$bankck['s_memGuid']:"&srcMemGuid=".$bankck['s_memGuid'];
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if( !$res ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );return;
    }else if ( $data['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>$data ) );return;
    }else {
        $ret['page'] = $page;
      $ret['draw'] = $this->input->get('draw');
      $ret['recordsFiltered'] =$ret['recordsTotal'] = $data['data']['totalCount'];
      $transactionList=array();
      date_default_timezone_set('Asia/Seoul');
      $date = date_create();
      $i=1;
      foreach($data['data']['list'] as $row){
        date_timestamp_set($date, $row['createDt']/1000 );
        $row['createDt'] = date_format($date, 'Y-m-d H:i:s');
        $row['createDt2'] = date_format($date, 'Y-m-d');
        $row['actcAmt'] =number_format( $row['actcAmt']).'원';
        $row['actcRsltAmt'] =number_format( $row['actcRsltAmt']).'원';
        $row['title'] = (!isset($row['title'])) ? ( ($row['trnsctnSt']=='SFRT_PAYIN_VACCNT_FINISHED' ) ? "입금완료":'') : $row['title'];
        $row['refId'] = (!isset($row['refId'])) ? '' : $row['refId'];
        $row['tid'] = (!isset($row['tid'])) ? '' : $row['tid'];
        $row['trnsctnSt'] = $this->code( $row['trnsctnSt'] );

        $transactionList[] = $row;
        $i++;
      }
      $ret['data'] = $transactionList;
      echo json_encode($ret);
      return;
    }
  }

  /* 거래목록조회 */
  public function trancelist() {
    $mid = trim($this->input->get('mid'));
    $start = (int)($this->input->get('start'));
    $type=($this->input->get('type')=='dst') ?'dst':'src';
    $page =($start < 1) ? 1 : (  (int)($start/10)+1 );
    $url = "https://v5.paygate.net/v5a/admin/transaction/list";
    $_method = "GET";

    $nonce = time().rand(111,99);
    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();

    if( $mid =='angel') {
        $bankck['s_memGuid'] = $config['c_reqMemGuid'];
    }else {
      $sql = "select  * from mari_seyfert where m_id = ?";
      $bankck = $this->db->query($sql , $mid )->row_array();

      if ( !isset( $bankck['s_memGuid']) ) {
        $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
        return;
      }
    }

    //$KEY_ENC    = $config['c_reqMemKey'];
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$config['c_reqMemGuid']."&nonce=".$nonce;
    $ENCODE_PARAMS .= "&limit=10&page=".$page;
    $ENCODE_PARAMS .=  ($type=="dst")? "&dstMemGuid=".$bankck['s_memGuid']:"&srcMemGuid=".$bankck['s_memGuid'];
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if( !$res ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );return;
    }else if ( $data['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>$data ) );return;
    }else {
      //$this->json( array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>$data['data'] ) );return;
      $ret['page'] = $page;
      $ret['draw'] = $this->input->get('draw');
      $ret['recordsFiltered'] =$ret['recordsTotal'] = $data['data']['totalRecord'];
      $transactionList=array();
      date_default_timezone_set('Asia/Seoul');
      $date = date_create();
      $i=1;
      foreach($data['data']['transactionList'] as $row){
        //if (!isset($row['title']) ) continue;
        date_timestamp_set($date, $row['trnsctnDt']/1000 );
        $row['trnsctnDt'] = date_format($date, 'Y-m-d H:i:s');
        date_timestamp_set($date, $row['updateDt']/1000 );
        $row['updateDt'] = date_format($date, 'Y-m-d H:i:s');
        date_timestamp_set($date, $row['createDt']/1000 );
        $row['createDt'] = date_format($date, 'Y-m-d H:i:s');
        $row['orgAmt'] =number_format( $row['orgAmt']).'원';
        $row['payAmt'] =number_format( $row['payAmt']).'원';
        $row['title'] = (!isset($row['title'])) ? '' : $row['title'];
        $row['refId'] = (!isset($row['refId'])) ? '' : $row['refId'];
        $row['trnsctnSt'] = $this->code( $row['trnsctnSt'] );
        $row['trnsctnTp'] = $this->code( $row['trnsctnTp'] );
        if( $row['dstMemGuid'] == $config['c_reqMemGuid']) {
          $row['dstMemGuid'] ='엔젤펀딩';
        } else if($type=='src') {
            $mem = $this->db->query('select m_id from mari_seyfert where s_memGuid=?', array($row['dstMemGuid']))->row_array();
            $row['dstMemGuid'] = (isset($mem['m_id']) ) ? $mem['m_id']:$row['dstMemGuid'];
        }
        if( $row['srcMemGuid'] == $config['c_reqMemGuid']) {
          $row['srcMemGuid'] ='엔젤펀딩';
        } else if($type=='dst') {

            $mem = $this->db->query('select m_id from mari_seyfert where s_memGuid=?', array($row['srcMemGuid']))->row_array();
            $row['srcMemGuid'] = (isset($mem['m_id']) ) ? $mem['m_id']:$row['srcMemGuid'];

        }
        $transactionList[] = $row;
        $i++;
      }
      $ret['data'] = $transactionList;
      echo json_encode($ret);
      return;
    }
  }
  /* 거래목록조회 화면*/
  public function tranceview(){
    $data['mid'] = trim($this->input->get('mid'));
    $data['type']=($this->input->get('type')=='dst') ?'dst':'src';
    $this->load->view('listsrcview',$data);
  }
  /* 잔액변동조회 화면*/
  public function trancebalanceview(){
    $data['mid'] = trim($this->input->get('mid'));
    $data['type']=($this->input->get('type')=='dst') ?'dst':'src';
    $this->load->view('adm_trancebalance',$data);
  }
  /* seyfert 통신 */
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


/* id 정보 */
  public function info() {
    $mid = trim($this->input->get('mid'));
  //  $url ="https://stg5.paygate.net/v5a/member/privateInfo";
  //  $url = "https://v5ns.paygate.net/v5a/member/createMember";
    $url = "https://v5.paygate.net/v5a/member/privateInfo";
    $nonce_lnq_mem = time().rand(111,99);
    /*페이게이트 주문번호 생성*/
    $g_code_mem = "P".time().rand(111,999);
    $realdb = $this->load->database('real',true);

    //include_once('/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');
    include_once(PluginPath);
    $sql = "select  * from mari_seyfert where m_id = ?";
  //	$qry = $this->db->query($sql , $this->input->get('mn') );
    $bankck = $realdb->query($sql , $mid )->row_array();

  //  $bankck['s_memGuid'] = 'ALfRf8ZhGzwRkohcmesRwU';
    if ( !isset( $bankck['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $config = $realdb->query(" select * from mari_config ")->row_array();
    $KEY_ENC    = $config['c_reqMemKey'];

    $ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config['c_reqMemGuid']."&nonce=".$nonce_lnq_mem."&refId=".$g_code_mem."&dstMemGuid=".$bankck['s_memGuid']."&crrncy=KRW";

    $cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
    $cipherEncoded_lnq = urlencode($cipher_lnq);
    $requestString_lnq = "_method=GET&reqMemGuid=".$config['c_reqMemGuid']."&encReq=".$cipherEncoded_lnq;

    /*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
    $requestPath_lnq = $url."?".$requestString_lnq;

    $curl_handlebank_lnq = curl_init();
    curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
    /*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
    curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
    curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, $url);
    $result_lnq = curl_exec($curl_handlebank_lnq);
    if( $result_lnq===false ) $curlerror = curl_error($curl_handlebank_lnq);
    curl_close($curl_handlebank_lnq);
    $decode_lnq = json_decode($result_lnq, true);
    date_default_timezone_set('Asia/Seoul') ;
    if($this->input->get('view')=='json'){
      echo $result_lnq;return;
    }
    if( !is_array( $decode_lnq) ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $curlerror) );return;
    }else if ( $decode_lnq['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>array('status'=>$decode_lnq['status']) ) );return;
    }else {
      $data = $decode_lnq['data']['result'];
      $data['mid'] = $mid;
      $data['accnt'] = array('s_accntNo'=>$bankck['s_accntNo'], 's_bnkCd'=>$bankck['s_bnkCd']);
      $this->load->view('seyfertinfo', $data);
      return;
    }
  }

/* 정보화면에서 이름 변경하기 */
  public function rename() {
    $mid=trim($this->input->post('mid'));
    $m_name=trim($this->input->post('sname'));

    $meminfo = $this->db->query('select * from mari_member where m_id = ?', array($mid))->row_array();
    if(!isset($meminfo['m_no'])){
      $this->json(array('code'=>'404', 'msg'=>'아이디를 찾을 수 없습니다.'));return;
    }

    $url = "https://v5.paygate.net/v5a/member/allInfo";

		$nonce_lnq_mem = time().rand(111,99);
		/*페이게이트 주문번호 생성*/
		$g_code_mem = "P".time().rand(111,999);
    $modify_code          = "M" . time() . rand(111, 999);

		include_once(PluginPath);
		$sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
		$bankck = $this->db->query($sql , $mid )->row_array();
		if ( !isset( $bankck['s_memGuid']) ) {
			$this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
			return;
		}
		$config = $this->db->query(" select * from mari_config ")->row_array();
		$KEY_ENC    = $config['c_reqMemKey'];

		$ENCODE_PARAMS_modify = "&_method=PUT&reqMemGuid=" . $config['c_reqMemGuid'] . "&desc=desc&_lang=ko&dstMemGuid=" . $bankck['s_memGuid'] . "&nonce=" . $modify_code . "&fullname=" . urlencode($m_name) ."&nmLangCd=ko"."";

		$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_modify, $KEY_ENC, 256);
		$cipherEncoded_lnq = urlencode($cipher_lnq);
		$requestString_lnq = "_method=PUT&reqMemGuid=".$config['c_reqMemGuid']."&encReq=".$cipherEncoded_lnq;

		/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
		$requestPath_lnq = $url."?".$requestString_lnq;

		$curl_handlebank_lnq = curl_init();
		curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
		/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
		curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
		curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, $url);
    		$result_lnq = curl_exec($curl_handlebank_lnq);
		if( $result_lnq===false ) $curlerror = curl_error($curl_handlebank_lnq);
		curl_close($curl_handlebank_lnq);
		$decode_lnq = json_decode($result_lnq, true);

		if( !is_array( $decode_lnq) ) {
			$this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $curlerror) );return;
		}else if ( $decode_lnq['status'] != 'SUCCESS') {
			$this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>array('status'=>$decode_lnq['status']) ) );return;
		}else if( isset($decode_lnq['data']['result']['name']['status']) == 'STORED' ) {
			$this->json( array('code'=>200 ,'msg'=>'SUCCESS') );return;
		}else {
      //echo $result_lnq;return;
      $this->json( array('code'=>500 ,'msg'=>'Unknown Error Occured') );return;
    }
	}
/* 정보화면에서 핸드폰변경하기 */
  public function rephone() {
    $mid=trim($this->input->post('mid'));
    $m_phone=trim($this->input->post('sphone'));

    $meminfo = $this->db->query('select * from mari_member where m_id = ?', array($mid))->row_array();
    if(!isset($meminfo['m_no'])){
      $this->json(array('code'=>'404', 'msg'=>'아이디를 찾을 수 없습니다.'));return;
    }

    $url = "https://v5.paygate.net/v5a/member/allInfo";

    $nonce_lnq_mem = time().rand(111,99);
    /*페이게이트 주문번호 생성*/
    $g_code_mem = "P".time().rand(111,999);
    $modify_code          = "M" . time() . rand(111, 999);

    include_once(PluginPath);
    $sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
    $bankck = $this->db->query($sql , $mid )->row_array();
    if ( !isset( $bankck['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $config = $this->db->query(" select * from mari_config ")->row_array();
    $KEY_ENC    = $config['c_reqMemKey'];

    $ENCODE_PARAMS_modify = "&_method=PUT&reqMemGuid=" . $config['c_reqMemGuid'] . "&desc=desc&_lang=ko&dstMemGuid=" . $bankck['s_memGuid'] . "&nonce=" . $modify_code ."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_phone."&phoneTp=MOBILE"."";

    $cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_modify, $KEY_ENC, 256);
    $cipherEncoded_lnq = urlencode($cipher_lnq);
    $requestString_lnq = "_method=PUT&reqMemGuid=".$config['c_reqMemGuid']."&encReq=".$cipherEncoded_lnq;

    /*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
    $requestPath_lnq = $url."?".$requestString_lnq;

    $curl_handlebank_lnq = curl_init();
    curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
    /*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
    curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
    curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, $url);
        $result_lnq = curl_exec($curl_handlebank_lnq);
    if( $result_lnq===false ) $curlerror = curl_error($curl_handlebank_lnq);
    curl_close($curl_handlebank_lnq);
    $decode_lnq = json_decode($result_lnq, true);

    if( !is_array( $decode_lnq) ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $curlerror) );return;
    }else if ( $decode_lnq['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>array('status'=>$decode_lnq['status']) ) );return;
    }else if( $decode_lnq['data']['result']['phone']['status'] == 'STORED' ) {
      $this->json( array('code'=>200 ,'msg'=>'SUCCESS') );return;
    }else {
      $this->json( array('code'=>500 ,'msg'=>'Unknown Error Occured') );return;
    }
  }
/* 가상계좌 해지 */
  public function unsignaccnt() {
    $mid=trim($this->input->post('mid'));
    $s_bnkCd=trim($this->input->post('bnkCd'));
    $accntNo=trim($this->input->post('accntNo'));

    $s_bnkCd = 'SC_023';//제일은행만 가능

    if($accntNo =='') {
      $this->json( array('code'=>201 ,'msg'=>'accntNo error') );
      return;
    }
    $realdb = $this->load->database('real',true);

    $nonce = 'VD'.time().rand(111,99);
    $url = "https://v5.paygate.net/v5a/member/unassignVirtualAccount";
    $sql = "select * from mari_seyfert where m_id = ? and s_memuse='Y'";
		$bankck = $realdb->query($sql , $mid )->row_array();
		if ( !isset( $bankck['s_memGuid']) ) {
			$this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
			return;
		}

    $config = $realdb->query(" select * from mari_config ")->row_array();
		$KEY_ENC    = $config['c_reqMemKey'];

    include_once(PluginPath);

    $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=" . $config['c_reqMemGuid'] . "&nonce=" . $nonce . "&dstMemGuid=" . $bankck['s_memGuid'] . "&bnkCd=" . $s_bnkCd . "&accntNo=" .$accntNo;
    $cipher          = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
    $cipherEncoded   = urlencode($cipher);
    $requestString   = "_method=POST&reqMemGuid=" . $config['c_reqMemGuid'] . "&encReq=" . $cipherEncoded;
    $requestPath     = $url."?" . $requestString;
    $curl_handlebank = curl_init();
    curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
    curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
    $result = curl_exec($curl_handlebank);
		if( $result===false ) $curlerror = curl_error($curl_handlebank);
		curl_close($curl_handlebank);
		$decode = json_decode($result, true);
    if(!isset($decode['data']['tid']) ){
      $this->json( array('code'=>202 ,'msg'=>'false','data'=>$decode ) );
      return;
    }
    $tid = $decode['data']['tid'];
    $status = $decode['data']['status'];
    if($status ==  'ASSIGN_VACCNT_UNASSIGNED'){
      $sql = "update mari_seyfert set s_accntNo='' , s_bnkCd = '' where m_id = ?";
      $realdb->query($sql, array($mid) );
      $this->json(array('code'=>200 ,'msg'=>'ok') );
    }else $this->json( array('code'=>201 ,'msg'=>'false','data'=>$decode['data']) );


  }
  public function unsignpayaccnt() {
    $mid=trim($this->input->post('mid'));
    $s_bnkCd=trim($this->input->post('bnkCd'));
    $accntNo=trim($this->input->post('accntNo'));

    $s_bnkCd = 'SC_023';//제일은행만 가능

    if($accntNo =='') {
      $this->json( array('code'=>201 ,'msg'=>'accntNo error') );
      return;
    }
    $realdb = $this->load->database('real',true);

    $nonce = 'VD'.time().rand(111,99);
    $url = "https://v5.paygate.net/v5a/member/unassignPayVirtualAccount";
    $sql = "select * from mari_seyfert where m_id = ? and s_memuse='Y'";
    $bankck = $realdb->query($sql , $mid )->row_array();
    if ( !isset( $bankck['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }

    $config = $realdb->query(" select * from mari_config ")->row_array();
    $KEY_ENC    = $config['c_reqMemKey'];

    include_once(PluginPath);

    $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=" . $config['c_reqMemGuid'] . "&nonce=" . $nonce . "&dstMemGuid=" . $bankck['s_memGuid'] . "&bnkCd=" . $s_bnkCd . "&accntNo=" .$accntNo;
    $cipher          = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
    $cipherEncoded   = urlencode($cipher);
    $requestString   = "_method=POST&reqMemGuid=" . $config['c_reqMemGuid'] . "&encReq=" . $cipherEncoded;
    $requestPath     = $url."?" . $requestString;
    $curl_handlebank = curl_init();
    curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
    curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
    $result = curl_exec($curl_handlebank);
    if( $result===false ) $curlerror = curl_error($curl_handlebank);
    curl_close($curl_handlebank);
    $decode = json_decode($result, true);
    if(!isset($decode['data']['tid']) ){
      $this->json( array('code'=>202 ,'msg'=>'false','data'=>$decode ) );
      return;
    }
    $tid = $decode['data']['tid'];
    $status = $decode['data']['status'];
    if($status ==  'ASSIGN_PAY_VACCNT_UNASSIGNED'){
      $sql = "update mari_seyfert set s_accntNo='' , s_bnkCd = '' where m_id = ? and s_memuse='Y'";
      $realdb->query($sql, array($mid) );
      $this->json(array('code'=>200 ,'msg'=>'ok') );
    }else $this->json( array('code'=>201 ,'msg'=>'false','data'=>$decode['data']) );


  }
  //잔액조회
  public function emoney() {


  }


	private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
  protected function getConvertNumberToKorean($_number)
{
	$number_arr = array('','일','이','삼','사','오','육','칠','팔','구');
	$unit_arr1 = array('','십','백','천');
	$unit_arr2 = array('','만','억','조','경','해');
	$result = array();
	$reverse_arr = str_split(strrev($_number), 4);
  $result_idx =0;
	foreach($reverse_arr as $reverse_idx=>$reverse_number){
		$convert_arr = str_split($reverse_number);
		$convert_idx =0;
		foreach($convert_arr as $split_idx=>$split_number){
			if(!empty($number_arr[$split_number])){
				$result[$result_idx] = $number_arr[$split_number].$unit_arr1[$split_idx];
				if(empty($convert_idx)) $result[$result_idx] .= $unit_arr2[$reverse_idx];
				++$convert_idx;
			}
			++$result_idx;
		}
	}
	$result = implode('', array_reverse($result));
	return $result;
}
protected function preauthcodemap($code){
  if($code=='PRE_AUTH_REG_FINISHED'){
    return array('code'=>200, 'msg'=>'인증완료.');
  }
  if($code=='REQUEST_HAS_TIME_OUT') {
    return array('code'=>400, 'msg'=>'요청시간경과.');//return false; //요청시간 경과
  }
  if($code=='PRE_AUTH_REG_TRYING'){
    return array('code'=>203, 'msg'=>'문자수신대기중');
  }
  if($code=='PRE_AUTH_REG_DEREGED_SELF'){
    return array('code'=>400, 'msg'=>'문자로 해지요청.');//return false; //문자로 해지
  }
  if($code =='PRE_AUTH_REG_DEREGED'){
    return array('code'=>400, 'msg'=>'선인증해지.');//return false; //문자로 해지
  }
  else return array('code'=>400, 'msg'=>'구분없음');
  /*
  $map = array(
    'PRE_AUTH_REG_FINISHED'=>'인증완료','REQUEST_HAS_TIME_OUT'=>'요청시간경과','PRE_AUTH_REG_TRYING'=>'문자응답대기중','PRE_AUTH_REG_DEREGED_SELF'=>'문자로해지'
  );
  return (isset($map[$code])) ? $map[$code] : $code;
  */
}
  public function code($code=''){
/*
      $fp = fopen("/var/www/html/tmp/code.txt","r");
      while( !feof($fp) ) {
        $doc_data = fgets($fp);
        $tmp = explode(' ', trim($doc_data) );

        echo"'".array_shift($tmp)."'=>'".implode(' ', $tmp)."',
        ";
      }
      fclose($fp);
      return;*/
      $tcode =array('ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체', 'ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체',);
      $scode= array(
 'ACQUIRING_BANK_AGREEMENT'=> '세이퍼트 출금 동의',  'AGREE_FORCED_BY_MERCHANT'=> '세이퍼트 펜딩 이체 완료 (낮은 금액에 대한 미인증 이체) ',  'ARS_DENIED'=> 'ARS 인증 실패 ',  'ARS_FINISHED'=> 'ARS 인증 완료',  'ARS_INIT'=> 'ARS 인증 시작',  'ARS_TRYING'=> 'ARS 인증 고객 응답 대기',  'ASSIGN_VACCNT_FINISHED'=> '가상계좌 할당 성공',  'ASSIGN_VACCNT_INIT'=> '가상계좌 할당 시작',  'BANK_DEPOSIT_PAYIN_FINISHED'=> '은행 입금 입력 완료',  'BANK_DEPOSIT_PAYIN_INIT'=> '은행 입금 입력 시작 ',  'BANK_DEPOSIT_PAYOUT_FINISHED'=> '은행 출금 입력 완료 ',  'BANK_DEPOSIT_PAYOUT_INIT'=> '은행 출금 입력 시작 ',  'BANK_TRAN_ROLL_BACK'=> '세이퍼트 출금 실패에 따른 롤백',  'BANK_TRAN_ROLL_BACK_PASSBOOK'=> '세이퍼트 출금 실패에 따른 롤백',  'BATCH_RCRR_CANCELED'=> '자동이체 취소',  'BATCH_RCRR_ENOUGH_MONEY'=> '자동이체 2일전 잔고 충분 통보',  'BATCH_RCRR_INIT'=> '자동이체 초기화 ',  'BATCH_RCRR_NOTI_MONEY'=> '자동이체 2일전 잔고 부족 통보 ',  'BATCH_RCRR_RUN_DONE'=> '자동이체 완료 ',  'BATCH_RCRR_RUN_FAILED'=> '자동이체 실패',  'BATCH_RCRR_TRYING'=> '자동이체 진행 중',  'BATCH_UNLIMITED_RSRV_CANCELED'=> '무한 예약 이체 취소',  'BATCH_UNLIMITED_RSRV_TRYING'=> '무한 예약이체 처리 중 ',  'CHECK_BNK_ACCNT_FINISHED'=> '예금주 조회 완료',  'CHECK_BNK_EXISTANCE_CHECKED'=> '실계좌 확인 완료',  'CHECK_BNK_CD_FINISHED'=> '예금주 코드 검증 완료',  'CHECK_BNK_CD_INIT'=> '예금주 코드 검증 초기화 ',  'CHECK_BNK_NM_DENIED'=> '예금주명 조회 거절 ',  'CHECK_BNK_NM_FINISHED'=> '예금주명 조회 완료',  'CHECK_BNK_NM_INIT'=> '예금주명 조회 초기화',  'ESCROW_CANCELED'=> '에스크로 취소 ',  'ESCR_RELEASE_CANCELED'=> '에스크로 해제 취소',  'ESCR_RELEASE_CHLD_FINISHED'=> '에스크로 이체 원거래 해제됨',  'ESCR_RELEASE_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_APPROVED'=> '에스크로 해제 요청 승인',  'ESCR_RELEASE_REQ_AUTO_DONE'=> '에스크로 해제 자동 완료 ',  'ESCR_RELEASE_REQ_AUTO_ERROR'=> '에스크로 해제 자동 완료 에러',  'ESCR_RELEASE_REQ_AUTO_FINISHED'=> '에스크로 해제 요청 자동 완료',  'ESCR_RELEASE_REQ_AUTO_PROCESS'=> '에스크로 해제 자동 완료 진행 ',  'ESCR_RELEASE_REQ_CANCELED'=> '에스크로 해제 요청 취소',  'ESCR_RELEASE_REQ_DENIED'=> '에스크로 해제 요청 거부',  'ESCR_RELEASE_REQ_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_HOLD'=>'에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_INIT'=>'에스크로 해제 요청 시작',  'ESCR_RELEASE_REQ_TRYING'=>'에스크로 해제 요청 승인 시작',  'ESCR_RELEASE_REQ_TRY_FAILED'=>'에스크로 해제 요청 실패',  'EXCHANGE_MONEY_DENIED'=>'환전 거절',  'EXCHANGE_MONEY_FINISHED'=>'환전 완료',  'EXCHANGE_MONEY_INIT'=>'환전 시작',  'MO_DENIED'=>'MO 요청 거절',  'MO_DONE'=>'MO 요청 완료',  'MO_FINISHED'=>'MO 요청 완료',  'MO_INIT'=>'MO 요청 초기화',  'MO_TRYING'=>'MO 요청 진행중',  'NOT_ENOUGH_BAL_TO_PAY_FEE'=>'거래 실패 (충전금 부족)',  'NOT_VRFY_BNK_CD_KYC'=>'NOT_VRFY_BNK_CD_KYC',  'PAYIN_VACCNT_KYC_ACTIVATED'=>'KYC 가상계좌 입금 활성화',  'PAYIN_VACCNT_KYC_FAILED'=>'KYC 가상계좌 입금 실패',  'PAYIN_VACCNT_KYC_FINISHED'=>'KYC 가상계좌 입금 완료',  'PAYIN_VACCNT_KYC_INIT'=>'KYC 가상계좌 입금 초기화',  'PAYIN_VACCNT_KYC_REQ_TRYING'=>'KYC 가상계좌 입금 요청',  'PAYIN_VACCNT_KYC_SENDING_1WON'=>'KYC 가상계좌 입금 코드 전송',  'REG_RCRR_EXP_DT'=>'등록 중 최초거래보다 경과됨',  'REG_RCRR_INIT'=>'자동이체 등록 초기화',  'REG_RCRR_PARENT_CANCELED'=>'자동이체 부모 거래가 취소',  'REG_RCRR_REQ_FINISHED'=>'자동이체 등록 인증 완료',  'REG_RCRR_REQ_TRYING'=>'자동이체 등록 인증 진행 중',  'REG_RCRR_REQ_TRY_FAILED'=>'자동이체 등록 인증 실패',  'REQUEST_HAS_TIME_OUT'=>'요청 시간 경과',  'SEND_MONEY_FAILED'=>'송금 실패',  'SEND_MONEY_FINISHED'=>'송금 완료',  'SEND_MONEY_INIT'=>'송금 초기화',  'SEND_MONEY_ROLL_BACK'=>'송금 완료 후 은행 거절 반환 (입금 불능)',  'SEND_SMS_BNK_CD_FAILED'=>'SMS 수신 코드 매칭 실패',  'SFRT_PAYIN_RSRV_MATCHED'=>'세이퍼트 예약 입금 완료',  'SFRT_PAYIN_VACCNT_FAILED'=>'세이퍼트 입금 실패',  'SFRT_PAYIN_VACCNT_FINISHED'=>'세이퍼트 입금 완료',  'SFRT_PAYIN_VACCNT_INIT'=>'세이퍼트 입금 시작',  'SFRT_RSRV_PND_INIT'=>'예약 펜딩 거래 시작',  'SFRT_RSRV_PND_TRYING'=>'예약 펜딩 거래 고객 승인 대기',  'SFRT_TRNSFR_CANCELED'=>'세이퍼트 이체 취소',  'SFRT_TRNSFR_CHLD_CANCELED'=>'세이퍼트 펜딩 원거래 취소됨',  'SFRT_TRNSFR_ESCR_AUTO_DONE'=>'에스크로 해제 자동 완료',  'SFRT_TRNSFR_ESCR_DONE'=>'에스크로 해제 완료',  'SFRT_TRNSFR_FINISHED'=>'세이퍼트 이체 완료',  'SFRT_TRNSFR_INIT'=>'세이퍼트 이체 시작',  'SFRT_TRNSFR_PND_AGRREED'=>'세이퍼트 펜딩 거래 동의',  'SFRT_TRNSFR_PND_CANCELED'=>'세이퍼트 펜딩 거래 취소',  'SFRT_TRNSFR_PND_CHLD_RELEASED'=>'세이퍼트 펜딩 원거래 해제됨',  'SFRT_TRNSFR_PND_INIT'=>'세이퍼트 펜딩 거래 초기화',  'SFRT_TRNSFR_PND_RELEASED'=>'세이퍼트 펜딩 거래 해제',  'SFRT_TRNSFR_PND_RELEASE_INIT'=>'세이퍼트 펜딩 거래 해제 초기화',  'SFRT_TRNSFR_PND_TRYING'=>'세이퍼트 펜딩 거래 요청 중',  'SFRT_TRNSFR_REQ_APPROVED'=>'세이퍼트 이체 요청 승인',  'SFRT_TRNSFR_REQ_CANCELED'=>'세이퍼트 이체 요청 취소',  'SFRT_TRNSFR_REQ_DENIED'=>'세이퍼트 이체 요청 거부',  'SFRT_TRNSFR_REQ_FINISHED'=>'세이퍼트 이체 요청 완료',  'SFRT_TRNSFR_REQ_INIT'=>'세이퍼트 이체 요청 시작',  'SFRT_TRNSFR_REQ_TRYING'=>'세이퍼트 이체 요청 승인 처리중',  'SFRT_TRNSFR_REQ_TRY_FAILED'=>'세이퍼트 이체 요청 실패',  'SFRT_TRNSFR_RSRV_EXPIRED'=>'세이퍼트 예약입금이체 입금 시간 경과',  'SFRT_TRNSFR_RSRV_FINISHED'=>'세이퍼트 예약입금이체 실패',  'SFRT_TRNSFR_RSRV_INIT'=>'세이퍼트 예약입금이체 초기화',  'SFRT_TRNSFR_RSRV_MATCHED'=>'세이퍼트 예약입금이체 매칭',  'SFRT_TRNSFR_RSRV_TRYING'=>'세이퍼트 예약입금이체 진행 중',  'SFRT_WITHDRAW_CANCELED'=>'세이퍼트 출금 취소',  'SFRT_WITHDRAW_FAILED'=>'세이퍼트 출금 실패',  'SFRT_WITHDRAW_FINISHED'=>'세이퍼트 출금 완료',  'SFRT_WITHDRAW_FINISH_BNK_CD'=>'세이퍼트 출금 중 계좌주 코드 검증',  'SFRT_WITHDRAW_FINISH_BNK_NM'=>'세이퍼트 출금 중 예금주 이름 검증',  'SFRT_WITHDRAW_INIT'=>'세이퍼트 출금 시작',  'SFRT_WITHDRAW_MONEY_REQUSTED'=>'세이퍼트 출금 처리 전송됨',  'SFRT_WITHDRAW_REQ_TRYING'=>'세이퍼트 출금 요청 진행 중',  'SMS_API_FINISHED'=>'SMS API 완료',  'SMS_API_INIT'=>'SMS API 초기화',  'UNLIMITED_RESERVE_CANCELED'=>'무한 예약 이체 취소',  'UNLIMITED_RESERVE_INIT'=>'무한 예약 이체 초기화',  'UNLIMITED_RESERVE_MATCHED'=>'무한 예약 이체 매치',  'UNLIMITED_RESERVE_RUNNING'=>'무한 예약 이체 실행중',  'VRFY_BNK_CD_COUNT_EXCEED'=>'예금주 권한 검증을 위한 1원 송금 10회 초과',  'VRFY_BNK_CD_DONE'=>'예금주 권한 검증 완료',  'VRFY_BNK_CD_REQ_TRYING'=>'예금주 권한 검증 1원 송금 후 문자 발송',  'VRFY_BNK_CD_SENDING_1WON'=>'예금주 권한 검증을 위한 1원 송금',  'VRFY_BNK_NM_DONE'=>'예금주 이름 검증 완료',  'VRFY_BNK_NM_REQ_TRYING'=>'예금중 이름 검증 진행 중','ASSIGN_VACCNT_UNASSIGNED'=>'가상계좌해지','BNK_NM_NEED_REVIEW'=>'계좌주이름확인팰요'
    );

    return ( isset($scode[$code]) )? $scode[$code]."(".$code.")" :  ( ( isset( $tcode[$code]) ) ? $tcode[$code]."(".$code.")" : $code ) ;
  }
}
