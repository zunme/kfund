<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');

class Nice extends CI_Controller {
  var $userid;
  var $sitecode;
  var $sitepasswd;
  var $reqseq;

  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    if(isset($_SESSION['ss_m_id']) && trim($_SESSION['ss_m_id']) !=''){
      $this->user_info = $this->db->get_where('mari_member', array('m_id'=>$_SESSION['ss_m_id']) )->row_array();
      $this->userid = (isset($this->user_info['m_id']) && $this->user_info['m_id']==$_SESSION['ss_m_id']) ? $_SESSION['ss_m_id']:'';

    } else $this->userid ='';
    $this->reqseq = (isset($_SESSION["REQ_SEQ"])) ? $_SESSION["REQ_SEQ"]:'';
    //session_write_close();

    $this->sitecode   = 'BH481';
    $this->sitepasswd = 'eAlGvup5Gp7W';

    $this->{$method}();
  }
  function getcode() {

  }
  function index(){
    $this->load->view('nice_fail');
return;
    //$actiontype = ($this->input->post("actiontype")=='change'|| $this->input->get("actiontype")=='change' ? "change":"join" );
    $actiontype = (!in_array($this->input->post("actiontype") , array('join','change','findemail','findpw') ) ) ? "join" : $this->input->post("actiontype");
    $this->load->library('encrypt');
    $param = $this->encrypt->encode( date("sHis").":actiontype:".$actiontype.":".date("sisYm"),"ankey2039");

    if (!extension_loaded('CPClient')) {
      echo "load ".'CPClient.' . PHP_SHLIB_SUFFIX."...";
        dl('CPClient.' . PHP_SHLIB_SUFFIX);
    }
    $module     = 'CPClient';

    $authtype   = "";
    $popgubun   = "N";
    $customize  = "";
    $reqseq     = "REQ_0123456789";
    if (extension_loaded($module)) {
        $reqseq = get_cprequest_no($this->sitecode);
    } else {
        $reqseq = "Module get_request_no is not compiled into PHP";
    }
    $_SESSION["REQ_SEQ"] = $reqseq;
    $req_datetime        = date("YmdHis");

    $returnurl          = "https://www.kfunding.co.kr/api/index.php/nice/authed";
    $errorurl           = "https://www.kfunding.co.kr/api/index.php/nice/authederr";

    //$sPlainData          = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "12:REQ_DATETIME" . strlen($req_datetime) . ":" . $req_datetime . "8:SITECODE" . strlen($sitecode) . ":" . $sitecode . "9:AUTH_TYPE" . strlen($sAuthType) . ":" . $sAuthType . "10:AGREE1_MAP" . strlen($agree1_map) . ":" . $agree1_map . "10:AGREE2_MAP" . strlen($agree2_map) . ":" . $agree2_map . "10:AGREE3_MAP" . strlen($agree3_map) . ":" . $agree3_map . "8:USERNAME" . strlen($username) . ":" . $username . "9:BIRTHDATE" . strlen($birthdate) . ":" . $birthdate . "6:GENDER" . strlen($gender) . ":" . $gender . "8:CI_GUBUN" . strlen($cigubun) . ":" . $cigubun . "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun . "7:RTN_URL" . strlen($sReturnUrl) . ":" . $sReturnUrl . "7:ERR_URL" . strlen($sErrorUrl) . ":" . $sErrorUrl;
    $sPlainData  = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "8:SITECODE" . strlen($this->sitecode) . ":" . $this->sitecode . "9:AUTH_TYPE" . strlen($authtype)
                    . ":" . $authtype . "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl . "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl . "11:POPUP_GUBUN" . strlen($popgubun)
                    . ":" . $popgubun . "9:CUSTOMIZE" . strlen($customize) . ":" . $customize;
    $returnMsg ='';
    if( $actiontype =="join" && $this->userid !='' ){
      $returnMsg = $enc_data = "이미 회원가입후 로그인 상태입니다.";
    }
    /*
    else if( $actiontype =="change" && $this->userid =='' ){
      $returnMsg = $enc_data = "로그인 후 사용해주세요.";
    }
    */
    else if (extension_loaded($module)) {
        $enc_data = get_encode_data($this->sitecode, $this->sitepasswd, $sPlainData);
        if ($enc_data == -1) {
            $returnMsg = "암/복호화 시스템 오류입니다.";
            $enc_data  = "";
        } else if ($enc_data == -2) {
            $returnMsg = "암호화 처리 오류입니다.";
            $enc_data  = "";
        } else if ($enc_data == -3) {
            $returnMsg = "암호화 데이터 오류 입니다.";
            $enc_data  = "";
        } else if ($enc_data == -9) {
            $returnMsg = "입력값 오류 입니다.";
            $enc_data  = "";
        }else {
          ;
        }
    } else {
        $returnMsg="Module get_request_data is not compiled into PHP";
        $enc_data ='';
    }

    if($this->input->get('usecode')=='true') {
      $this->json(array("enc_data"=>$enc_data,"returnMsg"=>$returnMsg,"param"=>$param));
    }else {
      $this->load->view("nicecheckform", array("enc_data"=>$enc_data,"returnMsg"=>$returnMsg,"param"=>$param) );
    }
  }
  function join() {
    $this->actiontype = "join";
    $this->authed();
  }
  function authed(){
    if( $this->actiontype == '') $this->actiontype="change";
    $retdata = array();
    $EncodeData = $this->input->post('EncodeData');

//임시
/*
if($EncodeData=='') {
$EncodeData = "AgAFQkg0ODFm/qBu3q7WbSnM+dVduoxXwIo9rt5Z9GUtKxUTQYExGjMnDpZZfOJu+uDV4CbAMoAnNUWbD29k0ZqgiNetLRTpc0oxhYoZJtHJSJmmqEs49VWyKCsXuPmd9hPWotEKXEB5KAX/Ix9t5Ffz829bSv/MEwz3ryC9qGGC4ngUhS5Eczu3Yr7WhRLnx8BT26sBvYqOy7guaS9cGcR2W/Jj9oSQ7NPDdv+ykkoO25UMkl+W9wheZYDTfNBfYMbIudyZlVz/AV7QFcdqaatT5U7La8dT641xOd46bQzOGelvtsHVrojPirwXVWEG+NecH1U+OUHsjIJ0njfKSLzuSpewI4LqfAIqpXrW4g8yb7vKwHZIg1kSdQpPyXgcBjedGz2zijUc/fHfT7wpOv+O9UPCP76tX8ZbOId6bIV2Pi4MoirkZH3i1Qd6fDYhwJj3nPvF0k6rlLoOOnkbtILOdsXsu/ZQ3Z41kmids9yRNSDfuGuaNx6wpvvfOeQcUWyCQar/bHSmo/WaflCNJgnnyqjN3c/3iLd/Nkew67FF/Fi9xoncx+3uO5Jkjw1iv5yAAyliVpo=";
}
*/


if(preg_match('~[^0-9a-zA-Z+/=]~', $EncodeData, $match)) {echo "입력 값 확인이 필요합니다(1) : ".$match[0]; exit;} // 문자열 점검 추가.
if(base64_encode(base64_decode($EncodeData))!=$EncodeData) {echo "입력 값 확인이 필요합니다(2)"; exit;}

    if (!extension_loaded('CPClient')) {
        dl('CPClient.' . PHP_SHLIB_SUFFIX);
    }
    $plaindata = get_decode_data($this->sitecode, $this->sitepasswd, $EncodeData);
    if ($plaindata == -1){
        $returnMsg  = "암/복호화 시스템 오류";
    }else if ($plaindata == -4){
        $returnMsg  = "복호화 처리 오류";
    }else if ($plaindata == -5){
        $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
    }else if ($plaindata == -6){
        $returnMsg  = "복호화 데이터 오류";
    }else if ($plaindata == -9){
        $returnMsg  = "입력값 오류";
    }else if ($plaindata == -12){
        $returnMsg  = "사이트 비밀번호 오류";
    }else{
      $returnMsg  ="";
      $retdata['m_id'] = $this->userid;
      $retdata['REQ_SEQ'] = $this->GetValue($plaindata , "REQ_SEQ");
    //  $retdata['RES_SEQ'] = $this->GetValue($plaindata , "RES_SEQ");
    //  $retdata['authtype'] = $this->GetValue($plaindata , "AUTH_TYPE");
      //$retdata['name'] = $this->GetValue($plaindata , "NAME");
      $retdata['name'] = urldecode($this->GetValue($plaindata , "UTF8_NAME")); //charset utf8 사용시 주석 해제 후 사용
      $retdata['birthdate'] = $this->GetValue($plaindata , "BIRTHDATE");
      $retdata['gender'] = $this->GetValue($plaindata , "GENDER");
      $retdata['nationalinfo'] = $this->GetValue($plaindata , "NATIONALINFO");	//내/외국인정보(사용자 매뉴얼 참조)
      $retdata['dupinfo'] = $this->GetValue($plaindata , "DI");
      //$retdata['conninfo'] = $this->GetValue($plaindata , "CI");
      $retdata['mobileno'] = $this->GetValue($plaindata , "MOBILE_NO");
      $retdata['ip'] = $this->input->ip_address();
      //$retdata['mobileco'] = $this->GetValue($plaindata , "MOBILE_CO");

      $this->load->library('encrypt');
      $actiontype = $this->actiontype;

      $etc = array();
      for($i=1;$i < 10; $i++ ){
        if( isset($_POST['param_r'.$i]) && $_POST['param_r'.$i] !="" ){
          $param = $this->encrypt->decode( $this->input->post('param_r'.$i),"ankey2039");
          $tmp = explode(':', $param);
          if(count($tmp) != 4) continue;
          else {
            if($tmp[1]=='actiontype') {
              $actiontype = $tmp[2];
            }
            else $etc[$tmp[1]]= $tmp[2];
          }
        }else break;
      }
      $retdata['actiontype'] = $actiontype;

      //TODO 아이디 찾기 , 비번찾기
      if( $retdata['actiontype'] == "findemail"){

        return;
      }else if($retdata['actiontype'] == "findpw"){

        return;
      }else {
        ;
      }


      $url = ($actiontype=="join") ? "/pnpinvest/?mode=join03":"/pnpinvest/?mode=mypage_modify";
      //$retdata['etc'] = json_encode($etc);
      if ( ($_SESSION["REQ_SEQ"] != $retdata['REQ_SEQ']) ){
        $retdata = array();
        $returnMsg  ="인증비교 오류";
        $this->load->view('nicealert', array('alertmsg'=>$returnMsg,'reload'=>true) );return;
      }

      if( $actiontype =="join" && $this->userid !='' ){
        $this->load->view('nicealert', array('alertmsg'=>"이미 회원가입후 로그인 상태입니다.") );return;
      }else if( $actiontype =="change" && $this->userid =='' ){
        $this->load->view('nicealert', array('alertmsg'=>"로그인 후 사용해주세요.") );return;
      }

//중복검사
      $dupcheck = true;
      $sql = "select ifnull(count(1), 0) as cnt  from mari_member where m_id != ? and m_hp =?";
      $duprow = $this->db->query($sql, array($this->userid, $retdata['mobileno']) )->row_array();

      if( $duprow['cnt'] > 0 ) {
        $this->load->view('nicealert', array('alertmsg'=>"이미 가입되어있는 핸드폰 번호입니다.") );return;
      }else {
        $sql = "select ifnull(count(1), 0) as cnt from mari_seyfert where m_id != ? and phoneNo = ?";
        $duprow = $this->db->query($sql, array($this->userid, $retdata['mobileno']) )->row_array();
        if( $duprow['cnt'] > 0 ) {
          $this->load->view('nicealert', array('alertmsg'=>"기존 가입기록이 있는 핸드폰 번호 입니다.") );return;
        }
      }
// / 중복검사
      $this->db->insert("z_nice_log", $retdata);
      if ( $actiontype =="join"){
        echo"
        <script>
        window.opener.parent.location.href ='".$url."';
        self.close();
        </script>
        ";
        return;
      }
      if($actiontype=='change' && $this->userid != ''){
        $this->db->where('m_id', $this->userid )->set('m_hp', $retdata['mobileno'] )->update('mari_member');
        $this->db->where('m_id', $this->userid )->set('sb_hp', $retdata['mobileno'] )->update('mari_smsbook');
        /* seyfert 변경 */
        $seyfert = $this->rephone($retdata['mobileno']);
        if( $seyfert != true){
          $this->db->where('m_id', $retdata['REQ_SEQ'] )->set('cstatus','E')->update("z_nice_log");
        }

      }
      $this->load->view('nicealert', array('url'=>$url) );return;
    }

    $this->load->view('nicealert', array('alertmsg'=>"핸드폰 인증 오류(2)가 발생하였습니다.") );return;
  }

  function authederr(){
    $this->load->view('nicealert', array('alertmsg'=>"핸드폰 인증 오류(3)가 발생하였습니다.") );return;
  }
  private function rephone($phoneno) {
    $url = "https://v5.paygate.net/v5a/member/allInfo";

    $nonce_lnq_mem = time().rand(111,99);
    /*페이게이트 주문번호 생성*/
    $g_code_mem = "P".time().rand(111,999);
    $modify_code          = "M" . time() . rand(111, 999);
    include_once(PluginPath);
    $sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
    $bankck = $this->db->query($sql , $this->userid )->row_array();

    if ( !isset( $bankck['s_memGuid']) ) {
      return array('code'=>404 ,'msg'=>'member seyfert key error') ;
    }

    $config = $this->db->query(" select * from mari_config ")->row_array();
    $KEY_ENC    = $config['c_reqMemKey'];

    $ENCODE_PARAMS_modify = "&_method=PUT&reqMemGuid=" . $config['c_reqMemGuid'] . "&desc=desc&_lang=ko&dstMemGuid=" . $bankck['s_memGuid'] . "&nonce=" . $modify_code ."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$phoneno."&phoneTp=MOBILE"."";
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
      return  array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $curlerror) ;
    }else if ( $decode_lnq['status'] != 'SUCCESS') {
      return array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>array('status'=>$decode_lnq['status']) ) ;
    }else if( $decode_lnq['data']['result']['phone']['status'] == 'STORED' ) {
      return true ;
    }else {
      return array('code'=>500 ,'msg'=>'Unknown Error Occured');
    }
  }
  function getviewtest() {

  }

  protected function json( $data = '' ){
    //header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
    echo json_encode( $data );
    exit;
  }
  function GetValue($str , $name)
  {
      $pos1 = 0;  //length의 시작 위치
      $pos2 = 0;  //:의 위치

      while( $pos1 <= strlen($str) )
      {
          $pos2 = strpos( $str , ":" , $pos1);
          $len = substr($str , $pos1 , $pos2 - $pos1);
          if((int)$len>0) {
            $key = substr($str , $pos2 + 1 , $len);
          }else $key = null;

          $pos1 = $pos2 + $len + 1;
          if( $key == $name )
          {
              $pos2 = strpos( $str , ":" , $pos1);
              $len = substr($str , $pos1 , $pos2 - $pos1);
              $value = substr($str , $pos2 + 1 , $len);
              return $value;
          }
          else
          {
              // 다르면 스킵한다.
              $pos2 = strpos( $str , ":" , $pos1);
              $len = substr($str , $pos1 , $pos2 - $pos1);
              $pos1 = $pos2 + $len + 1;
          }
      }
  }
}
