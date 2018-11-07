<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//require '5.3/vendor/autoload.php';
//use PhpAmqpLib\Connection\AMQPStreamConnection;
//use PhpAmqpLib\Message\AMQPMessage;

//require_once(getcwd()."/application/controllers/main.php");
//class Welcome extends main {

class Welcome extends CI_Controller{
	function _remap($method) {
		return;
		if ( ! session_id() ) @ session_start();
		$this->session = $_SESSION;
		$this->member_ck = ( isset($this->session['ss_m_id']) &&  $this->session['ss_m_id'] !='' ) ? true: false;

		$this->load->view("go_header");
		$this->load->view("go_left", array("menu", $method));
		$this->{$method}();
		$this->load->view("go_footer");
	}

	public function index()
	{
		$this->load->view("go_index");
	}


//================================================================
	public function alim(){
		$loginpassw = "guest:guest";
		$url = "http://128.134.106.210/api/exchanges/%2f/amq.default/publish";
		$msg = array(
			"code"=>"J0001"
			, "tel"=>"01025376460"
			, "data"=>array("emoney"=>10000)
		);
		$msg = array(
			"code"=>"Enter0001"
			, "m_id"=>"zunme@nate.com"
			//, "data"=>array("emoney"=>10000)
		);
		$msg = addslashes(json_encode($msg));
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
		# Return response instead of printing.
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
		curl_setopt($ch, CURLOPT_USERPWD, $loginpassw);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, 500);
		# Send request.
		$result = curl_exec($ch);
		curl_close($ch);
	}
	public function rabbit() {
		/*
		$connection = new AMQPStreamConnection('128.134.106.210', 5672, 'guest', 'guest');
		$channel = $connection->channel();
		$channel->queue_declare('SMS', false, true, false, false);
		$channel->close();
		$connection->close();
*/
		$loginpassw = "guest:guest";
		$url = "http://128.134.106.210/api/exchanges/%2f/amq.default/publish";
		/*
		array('toid'=>array('e9550dba-2b7c-43ce-bb88-64ee3f6ad5c9'))
		array('filter'=>array( 'key'=>'userId', 'value'=>'zunme@nate.com'))
		All
		*/

		$to = array('filter'=>array( 'key'=>'userId', 'value'=>'zunme@nate.com'));
		//$to = array('toid'=>array('e9550dba-2b7c-43ce-bb88-64ee3f6ad5c9', 'f3686bc9-1776-47bf-ac4a-1561db937dfa'));
		//$to = array();
		$msg= array("send_type"=>"SMS", "to"=>$to, "msg_type"=>"투자", "msg"=>"어쩌구 저쩌구");
sendrabbit($msg);return;
		$msg = addslashes(json_encode($msg));

		$data = array(
			"properties"=>array("delivery_mode"=>2)
			, "routing_key"=>"SMS"
			, "payload"=>$msg
			, "payload_encoding"=>"string"
		);
		$ch = curl_init( $url );
		# Setup request to send json via POST.
		$payload = json_encode( $data );
		//$payload = '{"properties":{"delivery_mode":2},"routing_key":"SMS","payload":"HI","payload_encoding":"string"}';
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );
		curl_setopt($ch, CURLOPT_PORT, 15672);
		curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
		# Return response instead of printing.
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
		curl_setopt($ch, CURLOPT_USERPWD, $loginpassw);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, 500);
		# Send request.
		$result = curl_exec($ch);
		curl_close($ch);
	}

	public function mypage(){
		$this->load->view('testmypage1');
	}
	public function cancel() {

		//$this->load->library('seyfertapi');
		//잔액조회
		//$balance = $this->seyfertapi->displaybalance($_SESSION['ss_m_id']);
		//$this->load->view('testbody');


		$this->load->library('seyfertapi');
		$cancel = $this->seyfertapi->canceltid('T1DiAFA','P1533797263523');
		var_dump($cancel);
	}
	public function info() {
		phpinfo();
	}
	public function kakao() {
		$url = "https://msg.supersms.co:9443/v1/send/kko";
		$header = array(
				'Content-Type: application/json; charset=utf-8',
				'X-IB-Client-Id: kfunding',
				'X-IB-Client-Passwd: rdNGE9MDuI7po6eCOi3A'
			);
		$friendkey ="";
		$postfield = array(
			"msg_type"=> "AL",
			"mt_failover"=> "N",
			"msg_data" =>
				array(
					"senderid"=> "15881234",
					"to"=> "821012345678",
					"content"=> "TEST MESSAGE"
				),
			"msg_attr" =>
				array(
					"sender_key"=> $friendkey,
					"template_code" => "1234",
					"response_method"=> "push",
					"ad_flag"=> "Y",
					"button" =>
							array(
									array(
										"name"=> "BUTTON1",
										"type"=> "WL",
										"url_pc"=> "http://www.kakao.com",
										"url_mobile"=> "http://www.kakao.com"
									)
							),
					//"image": array("img_url"=>$img_url, "img_link"=>$img_link) ,
				)
		);
		//var_dump($postfield);
	 json_encode($postfield);

	}
}
function sendrabbit($msg){
	$loginpassw = "guest:guest";
	$url = "http://128.134.106.210/api/exchanges/%2f/amq.default/publish";

	$msg = addslashes(json_encode($msg));
	$data = array(
		"properties"=>array("delivery_mode"=>2)
		, "routing_key"=>"SMS"
		, "payload"=>$msg
		, "payload_encoding"=>"string"
	);

	$ch = curl_init( $url );
	# Setup request to send json via POST.
	$payload = json_encode( $data );
	//$payload = '{"properties":{"delivery_mode":2},"routing_key":"SMS","payload":"HI","payload_encoding":"string"}';
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );
	curl_setopt($ch, CURLOPT_PORT, 15672);
	curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
	# Return response instead of printing.
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
	curl_setopt($ch, CURLOPT_USERPWD, $loginpassw);
	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
	curl_setopt($ch, CURLOPT_TIMEOUT_MS, 500);
	# Send request.
	$result = curl_exec($ch);
	curl_close($ch);
    var_dump($result);
	}
/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
