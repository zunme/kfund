<?php
function sendrabbit($msg){
  $loginpassw = "guest:guest";
  	$url = "http://128.134.106.210:15672/api/exchanges/%2f/amq.default/publish";

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
