<?php
class Webhook extends CI_Controller {
 function index() {
  if(isset($_POST['payload']) ) {
   $payload = json_decode($_POST['payload']);
   if( $payload->ref =="refs/heads/master"){
    	$ch = curl_init();
	curl_setopt($ch, CURLOPT_PORT, 8081);
	curl_setopt($ch, CURLOPT_URL, "http://www.kfunding.co.kr:8081/push");
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	//curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	$contents = curl_exec($ch);
	curl_close($ch);
   }
  }
 }
}
