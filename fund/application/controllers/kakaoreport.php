<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class kakaoreport extends CI_Controller{
  function index() {
    header("Content-Type: application/json; charset=UTF-8");
    $inputJSON = file_get_contents('php://input');
    $arr = json_decode($inputJSON, TRUE);
    $this->db->set('resultCode',$arr['resultCode'])->set('errorText',$arr['errorText'])->where('messageId',$arr['messageId'])->update('z_alimitok');
    echo'{"messageId":"'.$arr['messageId'].'"}';
  }
  function test() {
    require getcwd()."/../pnpinvest/module/sendkakao.php";
    $msg = array(
			"code"=>"Enter0001"
			, "m_id"=>"zunme@nate.com"
		);
    sendkakao($msg);
  }
  /*
  function sendkakao($msgarr) {
		$loginpassw = "guest:guest";
		$url = "http://128.134.106.210/api/exchanges/%2f/amq.default/publish";
    if( !is_array($msgarr)) return false;
		$msg = addslashes(json_encode($msgarr));
		$data = array(
			"properties"=>array("delivery_mode"=>2)
			, "routing_key"=>"TOK"
			, "payload"=>$msg
			, "payload_encoding"=>"string"
		);
		$payload = json_encode( $data );
		$ch = curl_init( $url );
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );
		curl_setopt($ch, CURLOPT_PORT, 15672);
		curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
		curl_setopt($ch, CURLOPT_USERPWD, $loginpassw);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, 500);
		$result = curl_exec($ch);
		curl_close($ch);
	}
  */
}
