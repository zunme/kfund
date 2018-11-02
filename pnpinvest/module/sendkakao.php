<?php
function sendkakao($msgarr) {
		$loginpassw = "guest:guest";
		$url = "http://128.134.106.210/api/exchanges/%2f/amq.default/publish";
    /*
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
    */
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
