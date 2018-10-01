<?php
	/******************************************************
	 * 다날 가상계좌 발급
	 ******************************************************/
	
	/******************************************************
	 * 결제 연동에 필요한 Function 및 변수값 설정
     	 *
	 * 결제시스템 연동에 대한 문의사항 있으시면 기술지원팀으로 연락 주십시오.
	 * DANAL Commerce Division Technique supporting Team 
	 * EMail : tech@danal.co.kr	 
	 ******************************************************/
?>
<?php
	/******************************************************
	 * 결제서버 URL 정의.
     *
	 *   - https://vaccount.teledit.com:8443/vaccount/
	 ******************************************************/
	define("DN_ACCOUNT_URL", "https://vaccount.teledit.com:8443/vaccount/");
	
	define("DN_CONNECT_TIMEOUT"		, "5");
	define("DN_TIMEOUT"				, "30");
	define("ERC_NETWORK_ERROR"		, "-1");	
	define("ERC_NOTFOUND_CURL"		, "-9");
	define("ERM_NETWORK"			, "Network Error");
	
	 /******************************************************
	 * curl의 전체경로
	 ******************************************************/
	//$CP_CURL_PATH = "C:\curl\curl";
	$CP_CURL_PATH = "/usr/bin/curl";

	/******************************************************
	 * SEED Binary Path
	 ******************************************************/
	$SEED_PATH = "/Danal/bin";

	/******************************************************
	 * SEED KEY 
	 ******************************************************/
	$SeedKey = "3ad7259f4d7ab151f32acab3254c7d61866062cb89f843e3242a7029700db032";

	/******************************************************
	 *  ID, PWD : 다날에서 제공해 드린 CPID, CPPWD
	 ******************************************************/
	$ID 	= "A810031369";
	$PWD 	= "7h65Fl6Edy";
	
	/******************************************************
	 *  AMOUNT : 상품가격
	******************************************************/
	$AMOUNT	= $AMOUNT;
	
	/******************************************************
	 *  BizNo : 가맹점 사업자 번호
	******************************************************/
	$BizNo	= "1258199378";
	
	/******************************************************
	 *  CHARSET : OUTPUT CHARSET ( EUC-KR:Default or UTF-8) 
	******************************************************/
	$CHARSET	= "UTF-8";
	//$CHARSET	= "UTF-8";

     /******************************************************
	 * 다날 서버와 통신함수 CallTrans
	 *    - 다날 서버와 통신하는 함수입니다.
	 *    - $Debug가 true일경우 웹브라우져에 debuging 메시지를 출력합니다.
	 ******************************************************/

	function CallTrans( $REQ_DATA , $Debug=false ){
		global $CP_CURL_PATH, $ID_MERCHANT, $PW_MERCHANT, $CHARSET;
		
		$REQ_STR = data2str($REQ_DATA);
		
		$REQ_CMD .= $CP_CURL_PATH;
		$REQ_CMD .= " -k --connect-timeout " . DN_CONNECT_TIMEOUT;
		$REQ_CMD .= " --max-time " . DN_TIMEOUT;
		$REQ_CMD .= " --header 'Content-type:application/x-www-form-urlencoded;charset=".$CHARSET."'";
		$REQ_CMD .= " --data '" . $REQ_STR . "'";
		$REQ_CMD .= " '". DN_ACCOUNT_URL . "'";
		
		exec($REQ_CMD, $RES_STR, $CURL_VAL);
		
		if($Debug){
			echo "Request : " . $REQ_CMD . "<BR>\n";
			echo "Ret : " . $CURL_VAL . "<BR>\n";
			echo "Out : " . $RES_STR[0] . "<BR>\n";
		}

		if($CURL_VAL != 0)
			$RES_STR = "RETURNCODE=" . ERC_NETWORK_ERROR ."&RETURNMSG=" . ERM_NETWORK ."( " . $CURL_VAL . " )";

		return str2data($RES_STR);
	}
	
	function str2data($str){
	
		$in = "";
	
		if((string)$str == "Array"){
			for($i=0; $i<count($str);$i++){
				$in .= $str[$i];
			}
		}else{
			$in = $str;
		}
	
		$pairs = explode("&", $in);
	
		foreach($pairs as $line){
			$parsed = explode("=", $line);
	
			if(count($parsed) == 2){
				$data[$parsed[0]] = urldecode($parsed[1]);
			}
		}
	
		return $data;
	}
	
	function data2str($data){
	
		$pairs = array();
		foreach($data as $key => $value){
			array_push($pairs, $key . '=' . urlencode($value));
		}
	
		return implode('&', $pairs);
	}
	
	function result2str($data){
	
		$pairs = array();
		foreach($data as $key => $value){
			array_push($pairs, $key . '=' . urldecode($value));
		}
	
		return implode('&', $pairs);
	}

	function MakeDataArray($inputarr, $outputarr, $ext=array(), $Prefix="", $date, $encFlag=false) {

		$PreLen = strlen(trim($Prefix));
		$keys = array_keys($inputarr);

		for($i=0;$i<count($keys);$i++){

			$key = $keys[$i];
			if( trim($key) == "" ) continue;

			if( !in_array($key,$ext) && substr($key,0,$PreLen) == $Prefix ){
				if( $encFlag ) {
					$outputarr[$key] = Encrypt($inputarr[$key], $date);
				} else {
					$outputarr[$key] = $inputarr[$key];
				}
			}
		}

		return $outputarr;
	}

	function MakeDataString($arr, $ext=array(), $Prefix="", $date, $encFlag=false) {

		$str = "";

		$PreLen = strlen(trim($Prefix));
		$keys = array_keys($arr);

		for($i=0;$i<count($keys);$i++){

			$key = $keys[$i];
			if( trim($key) == "" ) continue;

			if( !in_array($key,$ext) && substr($key,0,$PreLen) == $Prefix ){
				$str .= $key."=".$arr[$key]."&";
			}
		}

		$str = substr( $str, 0, strlen($str) - 1 );

		if( $encFlag ) {
			$str = Encrypt( $str, $date );
		}

		return $str;
	}
	
	function Arr2Str($arr){
	
		$key = array_keys($arr);
	
		$cnt = count($key);
		$Out ="";
	
		for($i=0;$i<count($key);$i++){
			$KEY = $key[$i];
			$Out .="{".$KEY."=".urldecode($arr[$KEY])."}";
		}
	
		return $Out;
	}
	
	function userErrorHandler($errno, $errmsg, $filename, $linenum, $vars){
	
		// timestamp for the error entry
		$dt = date("Y-m-d H:i:s (T)");
	
		// define an assoc array of error string
		// in reality the only entries we should
		// consider are E_WARNING, E_NOTICE, E_USER_ERROR,
		// E_USER_WARNING and E_USER_NOTICE
		$errortype = array (
				E_ERROR		 	=> "Error",
				E_WARNING		=> "Warning",
				E_PARSE		 	=> "Parsing Error",
				E_NOTICE		=> "Notice",
				E_CORE_ERROR	    	=> "Core Error",
				E_CORE_WARNING	  	=> "Core Warning",
				E_COMPILE_ERROR	 	=> "Compile Error",
				E_COMPILE_WARNING       => "Compile Warning",
				E_USER_ERROR	    	=> "User Error",
				E_USER_WARNING	  	=> "User Warning",
				E_USER_NOTICE	   	=> "User Notice",
				E_STRICT		=> "Runtime Notice"
		);
	
		// set of errors for which a var trace will be saved
		$user_errors = array(E_USER_ERROR, E_USER_WARNING, E_USER_NOTICE);
	
		$err = "[" . $dt . "] ";
		$err .= "errornum[" . $errno . "] ";
		$err .= "errortype[" . $errortype[$errno] . "] ";
		$err .= "errormsg[" . $errmsg . "] ";
		$err .= "scriptname[" . $filename . "] ";
		$err .= "scriptlinenum[" . $linenum . "] ";
	
		if (in_array($errno, $user_errors)) {
			$err .= "vartrace[" . wddx_serialize_value($vars, "Variables") . "]";
		}
		$err .= "\n";
	
		// save to the error log, and e-mail me if there is a critical user error
		error_log($err, 3, "./log/error.".date("Ymd").".log");
	
		echo("Fail-" . $errmsg . "(" . $errno . ")");
		exit();
	}
	
	function GetCharSet($IsCharSet) {
	
		if( strtoupper($IsCharSet) == "EUC-KR" || strtoupper($IsCharSet) == "UTF-8" )
		{
			return $IsCharSet;
		}
		else
		{
			return "EUC-KR";
		}
	}
	
	function Encrypt( $str, $date="" ) {
		global $SEED_PATH, $SeedKey;
		
		$CryptoKey = $SeedKey.$date;

		$cmd = $SEED_PATH."/dnencrypt ".$CryptoKey." '".$str."'";
		exec( $cmd, $Out, $Ret );
		$res = $Out[0];

		return urlencode( $res );	
	}

	function Decrypt( $str, $date="" ) {
		global $SEED_PATH, $SeedKey;

		$CryptoKey = $SeedKey.$date;
		
		$str = urldecode( $str );

		$cmd = $SEED_PATH."/dndecrypt ".$CryptoKey." '".$str."'";
		exec( $cmd, $Out, $Ret );
		$res = $Out[0];

		return $res;
	}
?>

