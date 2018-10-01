<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
회원용 seyfert
*/
//define("PluginPath",'/home/pnpinvest/www/pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');

class Seyfert extends CI_Controller {
  var $seyfertinfo;
  var $realdb;
  var $user;
  var $islogin;
  var $Guid;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');

    //$this->db = $this->load->database('real',true);
    $this->load->model('mainbase');
    if(isset($_SESSION['ss_m_id'])){
        $user = $this->mainbase->meminfo($_SESSION['ss_m_id']);
        if($user['m_id'] == $_SESSION['ss_m_id']) {$this->user['info'] = $user;$this->islogin=TRUE;}
        else $this->islogin=FALSE;
    }else $this->islogin=FALSE;
    session_write_close();

    if($this->islogin===FALSE){ $this->json('login');return; }
    $this->user['seyfert'] = $this->mainbase->seyfertinfo($_SESSION['ss_m_id']);
    //$this->Guid = $this->mainbase->mariconfig('c_reqMemGuid');
    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
    $this->{$method}();

  }
  function index(){

  }
  // Check DB
  function preauthstatus($id=''){
    if($id=='') { $return = false;
      $id=($this->input->get('m_id')!='') ? $this->input->get('m_id'): $this->user['info']['m_id'];
      if(trim($this->user['seyfert']['s_accntNo']) =='' ) {
        $this->json(array('code'=>500, 'msg'=>'투자자가상계좌를 만드신 후 사용가능합니다.'));return;
      }
    }else {$return = true;}
    $ret = array();
    $tmp = $this->mainbase->preauthstatus($id);
    if(!isset( $tmp['m_id'] ) ) $ret = array('code'=>400, 'msg'=>'요청기록없음');
    else if($tmp['trnsctnSt']==''){
      if( $tmp['ntime'] < $tmp['expireDt'] ) $ret = array('code'=>202, 'msg'=>'seyfert에 인증 요청을 한 상태입니다.');
      else $ret= array('code'=>400, 'msg'=>'요청시간경과.', 'tmp'=>$tmp);//return false;//요청시간경과
    }
    else $ret = $this->preauthcodemap($tmp['trnsctnSt']);
    if($ret['code']==200 ){
      if( date('Y-m-d') > $tmp['expire'] )  $ret = array('code'=>400, 'msg'=>'요청기록없음');
       else $ret['expire'] = $tmp['expire'];
    }
    if($return) return $ret;
    else $this->json($ret);
  }
  //Check Seyfert
  function preauthcheck() {
    if ( !isset( $this->user['seyfert']['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $url = "https://v5.paygate.net/v5/transaction/pending/preAuth/register";
    $_method = "GET";
    $refId =$nonce = "PAul".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId."&dstMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&srcMemGuid=".$this->user['seyfert']['s_memGuid'];
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      $ret = array(); $code=500; $msg='';
      $trnsctnSt = isset($data['data']['detailList'][0]['trnsctnSt']) ? $data['data']['detailList'][0]['trnsctnSt'] :'';//PRE_AUTH_REG_FINISHED
      $tid = isset($data['data']['detailList'][0]['tid'] ) ? $data['data']['detailList'][0]['tid'] : '';
      // TODO id= , tid != 조건 삭제 필요
      if($tid != ''){
        if ($trnsctnSt != '') {
            $ret= $this->preauthcodemap($trnsctnSt);
            $this->json($ret);
        } else $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
      } else $this->json(array('code'=>400, 'msg'=>"요청가능"));
    } else {
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }
  }
  function preauth(){
    if ( !isset( $this->user['seyfert']['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
/*
    $authstatus = $this->preauthstatus($this->user['info']['m_id']);
    if( $authstatus['code']  != 400){
        $this->json($authstatus);
    }
    */
    $url = "https://v5.paygate.net/v5/transaction/pending/preAuth/register";
    $_method = "POST";
    $refId =$nonce = "PAur".time().rand(111,99);

    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&authOrg=015&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId."&dstMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&srcMemGuid=".$this->user['seyfert']['s_memGuid'];
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      echo json_encode(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));return;
    }else if ($data['status'] =='SUCCESS'){
      $expire = (int)($data['data']['info']['expireDt'] /1000);
      $this->db->insert('z_seyfert_preauth', array('m_id'=>$this->user['info']['m_id'],'tid'=>$data['data']['tid'], 'refId'=>$data['data']['info']['refId'], 'trnsctnSt'=>'','trnsctnTp'=>'','expireDt'=>$expire ));
      echo json_encode(array('code'=>201, 'msg'=>"요청을 완료하였습니다."));return;
    }else echo json_encode(array('code'=>501, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));return;
  }
  function preauthcancel(){
    if ( !isset( $this->user['seyfert']['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $url = "https://v5.paygate.net/v5/transaction/pending/preAuth/deregisterAll";
    $_method = "POST";
    $refId =$nonce = "PAuc".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId."&dstMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&srcMemGuid=".$this->user['seyfert']['s_memGuid'];
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      $this->json(array('code'=>200, 'msg'=>"요청을 완료하였습니다."));
    }else $this->json(array('code'=>501, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
  }

  /* seyfert 통신 */
  protected function getres($_method,$url, $ENCODE_PARAMS ){
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
  protected function deleteunneed(){
    $sql = "delete from z_seyfert_preauth where  expireDt+2400 < unix_timestamp( now() ) and trnsctnSt in('', 'PRE_AUTH_REG_DEREGED', 'PRE_AUTH_REG_DEREGED_SELF')";
    $this->db->query($sql);
  }
  protected function preauthcodemap($code){
    if($code=='PRE_AUTH_REG_FINISHED'){
      return array('code'=>200, 'msg'=>'인증완료.');
    }
    if($code=='REQUEST_HAS_TIME_OUT') {
      return array('code'=>400, 'msg'=>'요청시간경과.');//return false; //요청시간 경과
    }
    if($code=='PRE_AUTH_REG_TRYING'){
      return array('code'=>203, 'msg'=>'seyfert에서 받은 문자에서 code 4자리를 찾으신 후 받으신 번호로 4자리의 숫자를 전송해주세요.');
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
  protected function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
		echo json_encode( $data );
		exit;
	}
}
