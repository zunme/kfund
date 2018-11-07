<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class kakaoreport extends CI_Controller{
  function index() {
    $this->load->driver('cache', array('adapter' => 'file'));
    header("Content-Type: application/json; charset=UTF-8");
    $inputJSON = file_get_contents('php://input');
    $this->cache->save('kakaoreport', $inputJSON, 1800);
    $this->cache->save('kakaoreport_time', date('Y-m-d H:i:s'), 1800);
    $arr = json_decode($inputJSON, TRUE);
    $this->db->set('resultCode',$arr['resultCode'])->set('errorText',$arr['errorText'])->where('messageId',$arr['messageId'])->update('z_alimitok');
    $this->cache->save('kakaoreport_sql', $this->db->last_query(), 1800);
    echo'{"messageId":"'.$arr['messageId'].'"}';
  }
  function report() {
    $this->load->driver('cache', array('adapter' => 'file'));
    if ( $kakaoreport = $this->cache->get('kakaoreport')) var_dump($kakaoreport);
    else echo "nonereport";
    if ( $kakaoreport_time = $this->cache->get('kakaoreport_time')) var_dump($kakaoreport_time);
    if ( $kakaoreport_sql = $this->cache->get('kakaoreport_sql')) var_dump($kakaoreport_sql);
  }
  function resetreport(){
    $this->load->driver('cache', array('adapter' => 'file'));
    $this->cache->save('kakaoreport', '', 1800);
    $this->cache->save('kakaoreport_time', '', 1800);
  }
  function test() {
    require getcwd()."/../pnpinvest/module/sendkakao.php";
    $msg = array(
			"code"=>"Enter0001"
			, "m_id"=>"zunme@nate.com"
		);
    sendkakao($msg);
  }
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
}
