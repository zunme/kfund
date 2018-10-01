<?php
if (!defined('_MARICMS_')) exit;
/************************************************
Controller
************************************************/
@extract($_GET);
@extract($_POST);
@extract($_SERVER);
$timetoday = mktime();
$date = date("Y-m-d H:i:s", $timetoday);
$ip=$_SERVER['REMOTE_ADDR'];
/*CONFIG설정*/
$config = sql_fetch(" select * from mari_config ");
/*SMS자동발송 메세지*/
$load = sql_fetch(" select * from mari_smsload ");
$member_msg=$load['member_msg'];
$loan_msg=$load['loan_msg'];
$invest_msg_01=$load['invest_msg_01'];
$invest_msg_02=$load['invest_msg_02'];
$invest_msg_03=$load['invest_msg_03'];
$invest_msg_04=$load['invest_msg_04'];


/*seyfert가상계좌 시스템 사용여부*/
if($config['c_seyfertck']=="Y"){
	/*페이게이트 전자결제 계정*/
	$KEY_ENC = $config[c_reqMemKey];
	$GUID = $config[c_reqMemGuid];
	$COMMON_ENC = "UTF-8";
}

/*페이게이트 nonce체크시 숫자변경*/
$nonce_ap = time().rand(111,999);
$nonce=$nonce_ap;
/*페이게이트 주문번호 생성*/
$g_code = "P".time().rand(111,999);



/****************************************************************************
신용인증송부 재조회를위한 리턴값중 certno값이 있을경우에만update
****************************************************************************/

		if($_GET[certno]){

								$sql="update mari_safekey
											set certno ='".$_GET[certno]."',
											deposit_gb ='".$_GET[deposit_gb]."',
											poss_cnt ='".$_GET[poss_cnt]."',
											cust_key ='".$_GET[cust_key]."',
											certnodate ='$date',
											ss_ip ='$ip'
											 where cust_key='".$_GET[cust_key]."'
											";
								sql_query($sql);
		}





/****************************************************************************************************************
HOME SQL START
*****************************************************************************************************************/
switch ($up){










/************************************************
코멘트 수정삭제
************************************************/

case "comment":

	$sql = "select * from mari_loan where i_id = '$loan_id'";
	$loa = sql_fetch($sql,false);

	if($type2=="m"){
		$sql = " update mari_viewcomment
		set co_content ='$co_content'
		where loan_id='$loan_id' and m_id = '$user[m_id]' and co_id='$co_id'";

		sql_query($sql);
		alert('정상적으로 수정 되었습니다.');
	}else if($type2=="d"){

			$sql = " delete from mari_viewcomment where loan_id='$loan_id' and m_id = '$user[m_id]' and co_id='$co_id'";
			sql_query($sql);
			alert('정상적으로 삭제되었습니다.');


	}else{
		alert('정상적인 접근이 아닙니다.');
	}

break;






/************************************************
코멘트 신고
************************************************/

case "comment_singo":

	if($si=="g"){
		$sql = " insert into mari_sin
						set s_id = '$user[m_id]',
						s_com = '$loan_id',
						s_date ='$date'";
					sql_query($sql);
					alert('신고접수 되었습니다.');

	}else{
		alert('정상적인 접근이 아닙니다.');
	}

break;

/************************************************
회원가입 (모바일)
************************************************/
	case "m_join3":
		if($mode=="join3"){


		$m_my_bankacc = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "",$m_my_bankacc);

			/*중복체크*/

			if ($m_id=="admin" || $m_id=="ADMIN"  || $m_id=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($m_name=="최고관리자" || $m_name=="관리자"  || $m_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');

			if ($m_nick=="최고관리자" || $m_nick=="관리자"  || $m_nick=="운영자" )
				alert('사용하실 수 없는 닉네임 입니다.\\n 다른 닉네임을 이용하여 주십시오.');

			$mb = get_member($m_id);
			if ($mb['m_id'])
				alert('이미 존재하는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.\\nＩＤ : '.$mb['m_id']);

			$sql = "select * from mari_seyfert where phoneNo = '$m_hp'";
			$sey_ck = sql_fetch($sql);
			if($sey_ck[phoneNo] == $m_hp){
				alert('이미 키가 발급된 번호입니다. .\\n 다른 번호를 입력하여 주십시오.\\n HP : '.$sey_ck['phoneNo']);
			}

			$sql = " select m_hp from mari_member where m_hp = '$m_hp' ";
			$row = sql_fetch($sql);
			if ($row['m_hp'] == $m_hp){
				alert('존재하는 휴대폰 번호 입니다.\\n 다른 번호를 입력하여 주십시오.\\n HP : '.$row['m_hp']);
			}


			if(!$m_password==""){
			/*패스워드 일치검사*/
			if($m_password==$m_password_re){
			}else{
				alert('패스워드가 일치하지 않습니다.');
				exit;
			}
				$pw_yes="m_password = '".hash('sha256',$m_password)."',";
			}
			$m_birth="".$birth1."-".$birth2."-".$birth3."";
			/*insert*/
				$sql = " insert into mari_member
							set m_id = '$m_id',
							".$pw_yes."
							m_name = '$m_name',
							m_email = '$m_id',
							m_hp = '$m_hp',
							m_zip = '$m_zip',
							m_addr1 = '$m_addr1',
							m_addr2 = '$m_addr2',
							m_sex = '$m_sex',
							m_datetime = '$date',
							m_ip = '$ip',
							m_joinpath = '$m_joinpath',
							m_birth = '$m_birth',
							m_level = '$config[c_memregi_level]',
							m_signpurpose = '$m_signpurpose',
							m_newsagency = '$m_newsagency'
							";
					sql_query($sql);


					/*신규가입시 전화번호 미분류그룹에 등록*/
					$sql = " insert into mari_smsbook
								set sg_no = '1',
								m_id = '$m_id',
								sb_name = '$m_name',
								sb_hp = '$m_hp',
								sb_receipt = '$m_sms',
								sb_memo ='가입시 등록됨'";
					sql_query($sql);



				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				/*데이터 암호화 복호화 플러그인 start*/
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);
				/*발급내역이 없을경우에만 실행*/
					if(!$seyfck['s_memGuid']){
					/*****Seyfert Create Member(멤버 생성) START*****/


						$ENCODE_PARAMS="&_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&nonce=".$nonce."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						$requestPath = "https://v5.paygate.net/v5a/member/createMember?".$requestString;

						$curl_handle = curl_init();
						//$ENCODE_PARAMS = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS);
						curl_setopt($curl_handle, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/createMember');
						$result = curl_exec($curl_handle);
						curl_close($curl_handle);
						/*파싱*/
						$decode = json_decode($result, true);
						/*전체 데이터 출력테스트
						print_r($decode);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode as $key=>$value){
							$memGuid=$value['memGuid'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['m_id']){
									$sql = " insert into  mari_seyfert
												set s_memGuid='$memGuid',
												m_id='$m_id',
												m_name='$m_name',
												phoneNo='$m_hp',
												s_memuse='Y',
												s_ip='$ip',
												s_redatetime='$date'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}
					/*****Seyfert Create Member(멤버 생성) END*****/
					}

					}





				if($config['c_sms_use']=="Y"){
					if($load['member_req']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$m_id'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$member_msg = str_replace("{이름}", $m_name, $member_msg);
						$member_msg = str_replace("{아이디}", $m_id, $member_msg);
						$member_msg = str_replace("{사이트명}", $config[c_title], $member_msg);


						/*80바이트 이상일경우 lms로 발송*/
						$message_msg=mb_strlen($member_msg, "euc-kr");
						if($message_msg <=80){
							$sendSms="sendSms";
						}else{
							$sendSms="sendSms_lms";
						}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$member_msg."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 회원가입 되었습니다.",
								 "returnurl" => "".MARI_HOME_URL."?mode=main"
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/

					}
				}

				alert('정상적으로 회원가입 되었습니다.','?mode=main');
		}


	break;
/************************************************
회원가입 STEP I
************************************************/
/************************************************
회원가입 STEP II
************************************************/
/************************************************
회원가입 STEP III
************************************************/
	case "join3":
		/*휴대폰번호 합침*/
		$m_hp="".$hp1."".$hp2."".$hp3."";
		if($m_hp == "선택"){	$m_hp = ""; }
		$m_birth="".$birth1."-".$birth2."-".$birth3."";
		//$m_zip="".$m_zip1."".$m_zip2."";
		$m_tel="".$tel1."".$tel2."".$tel3."";

		$m_my_bankacc = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "",$m_my_bankacc);

		if($m_tel == "선택"){	$m_tel = ""; }
		/*페스워드가 있을경우에만*/
		if(!$m_password==""){
			/*패스워드 일치검사*/
			if($m_password==$m_password_re){
			}else{
				alert('패스워드가 일치하지 않습니다.');
				exit;
			}
			$pw_yes="m_password = '".hash('sha256',$m_password)."',";
		}
		if($mode=="join3"){

			/*중복체크*/

			if ($m_id=="admin" || $m_id=="ADMIN"  || $m_id=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($m_name=="최고관리자" || $m_name=="관리자"  || $m_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');

			if ($m_nick=="최고관리자" || $m_nick=="관리자"  || $m_nick=="운영자" )
				alert('사용하실 수 없는 닉네임 입니다.\\n 다른 닉네임을 이용하여 주십시오.');

			$mb = get_member($m_id);
			if ($mb['m_id'])
				alert('이미 존재하는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.\\nＩＤ : '.$mb['m_id']);

			$sql = "select * from mari_seyfert where phoneNo = '$m_hp'";
			$sey_ck = sql_fetch($sql);
			if($sey_ck[phoneNo] == $m_hp){
				alert('이미 키가 발급된 번호입니다. .\\n 다른 번호를 입력하여 주십시오.\\n HP : '.$sey_ck['phoneNo']);
			}

			$sql = " select m_hp from mari_member where m_hp = '$m_hp' ";
			$row = sql_fetch($sql);
			if ($row['m_hp'] == $m_hp){
				alert('존재하는 휴대폰 번호 입니다.\\n 다른 번호를 입력하여 주십시오.\\n HP : '.$row['m_hp']);
			}


			/*insert*/
				$sql = " insert into mari_member
							set m_id = '$m_id',
							".$pw_yes."
							m_name = '$m_name',
							m_nick = '$m_nick',
							m_email = '$m_id',
							m_homepage = '$m_homepage',
							m_password_q = '',
							m_password_a = '',
							m_level = '$m_level',
							m_sex = '$m_sex',
							m_birth = '$m_birth',
							m_tel = '$m_tel',
							m_hp = '$m_hp',
							m_sms = '$m_sms',
							m_mailling = '$m_mailling',
							m_zip = '$m_zip',
							m_addr1 = '$m_addr1',
							m_addr2 = '$m_addr2',
							m_emoney = '$m_emoney',
							m_profile	 = '',
							m_memo_call = '$m_memo_call',
							m_memo_cnt = '',
							m_datetime = '$date',
							m_ip = '$ip',
							m_blindness = '$m_blindness',
							m_ipin = '$m_ipin',
							m_joinpath = '$m_joinpath',
							m_signpurpose = '$m_signpurpose',
							m_my_bankcode = '$m_my_bankcode',
							m_my_bankname = '$m_my_bankname',
							m_my_bankacc = '$m_my_bankacc',
							m_company_name = '$m_company_name',
							m_companynum = '$m_companynum',
							m_newsagency = '$m_newsagency',
							m_referee ='$m_referee'";
					sql_query($sql);

					/*신규가입시 전화번호 미분류그룹에 등록*/
					$sql = " insert into mari_smsbook
								set sg_no = '1',
								m_id = '$m_id',
								sb_name = '$m_name',
								sb_hp = '$m_hp',
								sb_receipt = '$m_sms',
								sb_memo ='가입시 등록됨'";
					sql_query($sql);



				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				/*데이터 암호화 복호화 플러그인 start*/
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);
				/*발급내역이 없을경우에만 실행*/
					if(!$seyfck['s_memGuid']){
					/*****Seyfert Create Member(멤버 생성) START*****/


						$ENCODE_PARAMS="&_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&nonce=".$nonce."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						$requestPath = "https://v5.paygate.net/v5a/member/createMember?".$requestString;

						$curl_handle = curl_init();
						//$ENCODE_PARAMS = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS);
						curl_setopt($curl_handle, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/createMember');
						$result = curl_exec($curl_handle);
						curl_close($curl_handle);
						/*파싱*/
						$decode = json_decode($result, true);
						/*전체 데이터 출력테스트
						print_r($decode);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode as $key=>$value){
							$memGuid=$value['memGuid'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['m_id']){
									$sql = " insert into  mari_seyfert
												set s_memGuid='$memGuid',
												m_id='$m_id',
												m_name='$m_name',
												phoneNo='$m_hp',
												s_memuse='Y',
												s_ip='$ip',
												s_redatetime='$date'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}
					/*****Seyfert Create Member(멤버 생성) END*****/
					}

					}




				if($config['c_sms_use']=="Y"){
					if($load['member_req']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$m_id'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$member_msg = str_replace("{이름}", $m_name, $member_msg);
						$member_msg = str_replace("{아이디}", $m_id, $member_msg);
						$member_msg = str_replace("{사이트명}", $config[c_title], $member_msg);


						/*80바이트 이상일경우 lms로 발송*/
						$message_msg=mb_strlen($member_msg, "euc-kr");
						if($message_msg <=80){
							$sendSms="sendSms";
						}else{
							$sendSms="sendSms_lms";
						}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$member_msg."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 회원가입 되었습니다.",
								 "returnurl" => "".MARI_HOME_URL."?mode=join4"
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/

					}
				}

				alert('정상적으로 회원가입 되었습니다.','?mode=join4');
		}else if($mode=="member_modify"){

		$m_birth = "".substr($birth,0,4)."-".substr($birth,4,2)."-".substr($birth,6,2)."";

		if($type=="mobile"){
			/*페스워드가 있을경우에만*/
				if(!$m_password==""){

					/*패스워드 일치검사*/
					if($m_password==$m_password_re){
					}else{
						alert('패스워드가 일치하지 않습니다.');
						exit;
					}

					$mem = get_member($m_id);

					if (!$mem['m_id'] || (hash('sha256',$password) != $mem['m_password'])) {
						alert('현재 패스워드가 일치하지 않습니다! 다시한번 확인하신후 입력하여 주십시오. ');
					}

					$pw_yes="m_password = '".hash('sha256',$m_password)."',";
				}


				/*update*/
					$sql = " update  mari_member
								set ".$pw_yes."
								m_hp = '$m_hp',
								m_birth = '$m_birth',
								m_sms = '$m_sms',
								m_company_name = '$m_company_name',
								m_companynum = '$m_companynum',
								m_tel = '$m_tel'
								where m_no='$m_no'";
						sql_query($sql);
			}else if($type=="withholding"){

				$m_hp = $user[m_hp];

				$m_reginum = "".$reginum1."".$reginum2."";

				/*인증센터*/
				$sql = "update mari_member
						set m_my_bankcode = '$m_my_bankcode',
						m_my_bankname = '$m_my_bankname',
						m_my_bankacc = '$m_my_bankacc',
						m_reginum = '$m_reginum',
						m_with_zip = '$m_with_zip',
						m_with_addr1 = '$m_with_addr1',
						m_with_addr2 = '$m_with_addr2'
						where m_no = '$m_no'";
				sql_query($sql);
			}else{

				/*페스워드가 있을경우에만*/
				if(!$m_password==""){

					/*패스워드 일치검사*/
					if($m_password==$m_password_re){
					}else{
						alert('패스워드가 일치하지 않습니다.');
						exit;
					}

					$mem = get_member($m_id);

					if (!$mem['m_id'] || (hash('sha256',$password) != $mem['m_password'])) {
						alert('현재 패스워드가 일치하지 않습니다! 다시한번 확인하신후 입력하여 주십시오. ');
					}

					$pw_yes="m_password = '".hash('sha256',$m_password)."',";
				}

				/*update*/
					$sql = " update  mari_member
								set ".$pw_yes."
								m_hp = '$m_hp',
								m_birth = '$m_birth',
								m_sms = '$m_sms',
								m_company_name = '$m_company_name',
								m_companynum = '$m_companynum',
								m_tel = '$m_tel'
								where m_no='$m_no'";
						sql_query($sql);
			}

				/*출금은행과 계좌번호변경시 재인증요청하도록 2016-11-07 추가*/
				if($user['m_my_bankacc']==$m_my_bankacc && $user['m_my_bankcode']==$m_my_bankcode){
				}else{
					$sql = " update  mari_member
								set m_verifyaccountuse = 'N'
								where m_no='$m_no'";
					sql_query($sql);

				}


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){

				/*데이터 암호화 복호화 플러그인 start*/
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*•해당값을 encReq 에 바인딩 하고 reqMemGuid 과 _method 를 추가*/
				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);

			if(!$seyfck['s_memGuid']){


				$ENCODE_PARAMS="&_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&nonce=".$nonce."&emailAddrss=".$user[m_id]."&emailTp=PERSONAL&fullname=".urlencode($user[m_name])."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE";

				$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
				$cipherEncoded = urlencode($cipher);
				$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;



					/*****Seyfert Create Member(멤버 생성) START*****/
						//header("Content-Type: text/html; charset=utf-8");
						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
						$requestPath = "https://v5.paygate.net/v5a/member/createMember?".$requestString;
						$curl_handle = curl_init();

						//$ENCODE_PARAMS = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS);
						curl_setopt($curl_handle, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/createMember');
						$result = curl_exec($curl_handle);
						curl_close($curl_handle);


						/*파싱*/
						$decode = json_decode($result, true);
						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode as $key=>$value){
							$memGuid=$value['memGuid'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['m_id']){
									$sql = " insert into  mari_seyfert
												set s_memGuid='$memGuid',
												m_id='$user[m_id]',
												phoneNo='$m_hp',
												m_name='$user[m_name]',
												s_memuse='Y',
												s_ip='$ip',
												s_redatetime='$date'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}


			}else{

			/*정보수정시 휴대폰번호가 다른경우 seyfck phoneNo 변경되도록 추가 2016-10-07 임근호*/
			if($seyfck['phoneNo']==$m_hp){
			}else{

				/*기업일경우*/
				if($m_company_name){
					$m_name=$m_company_name;
				}else{
					$m_name=$user['m_name'];
				}


						/*페이게이트 정산nonce체크시 숫자변경*/
						$modify_code = "M".time().rand(111,999);
						/*발급여부확인*/
						$sql = "select  * from mari_member where m_id='$user[m_id]'";
						$memseyfck = sql_fetch($sql, false);


						$ENCODE_PARAMS_modify="&_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&_lang=ko&dstMemGuid=".$seyfck[s_memGuid]."&nonce=".$modify_code."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE&addrss1=".urlencode($memseyfck[m_addr1])."&city=SEOUL&addrssCntryCd=KOR&firstname=".urlencode($user[m_name])."&lastname=".urlencode($user[m_name])."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS_modify, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString_modify = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						$requestPath_modify = "https://v5.paygate.net/v5a/member/allInfo?".$requestString_modify;

						$curl_handle_modify = curl_init();
						//$ENCODE_PARAMS_modify = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS_modify);
						curl_setopt($curl_handle_modify, CURLOPT_URL, $requestPath_modify);
						/*curl_setopt($curl_handle_modify, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle_modify, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle_modify, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle_modify, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle_modify, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/allInfo');
						$result_modify = curl_exec($curl_handle_modify);
						curl_close($curl_handle_modify);
						/*파싱*/
						$decode_modify = json_decode($result_modify, true);

						/*
						print_r($decode_modify);
						print_r($requestPath_modify);
						echo"<br/><br/>";
						print_r($result_modify);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_modify);
						echo"<br/><br/>";
						print_r($decode_modify);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode_modify)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode_modify as $key=>$value){
							$emailAddrss=$value['emailAddrss'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='".$user[m_id]."' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){
									$sql = " update mari_seyfert
												set phoneNo='$m_hp',
												m_name='$m_name',
												s_ip='$ip',
												s_redatetime='$date' where m_id='".$seyck[m_id]."'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}


			}


				/*개인정보수정 계좌등록*/
				$acc_nonce = "A".time().rand(111,999);

				/*세이퍼트 계좌등록*/
				/*가상계좌 세이퍼트멤버생성정보*/
				$sql = "select  * from mari_seyfert where m_id='".$user[m_id]."' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);

							$ENCODE_PARAMS_acc="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$acc_nonce."&dstMemGuid=".$seyfck[s_memGuid]."&accntNo=".$m_my_bankacc."&bnkCd=".$m_my_bankcode."&cntryCd=KOR";

							$cipher_acc = AesCtr::encrypt($ENCODE_PARAMS_acc, $KEY_ENC, 256);
							$cipherEncoded_acc = urlencode($cipher_acc);
							$requestString_acc = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_acc;

							/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

							$requestPath_acc = "https://v5.paygate.net/v5a/member/bnk?".$requestString_acc;

							$curl_handlebank_acc = curl_init();

							curl_setopt($curl_handlebank_acc, CURLOPT_URL, $requestPath_acc);
							/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
							curl_setopt($curl_handlebank_acc, CURLOPT_CONNECTTIMEOUT, 2);
							curl_setopt($curl_handlebank_acc, CURLOPT_RETURNTRANSFER, 1);
							curl_setopt($curl_handlebank_acc, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
							curl_setopt($curl_handlebank_acc, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/bnk');
							$result_acc = curl_exec($curl_handlebank_acc);
							curl_close($curl_handlebank_acc);


						/*파싱*/

						$decode_acc = json_decode($result_acc, true);

						/*
						print_r($requestPath_acc);
						echo"<br/><br/>";
						print_r($result_acc);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_acc);
						echo"<br/><br/>데이터투";
						print_r($decode_acc);
						*/


					}

					}


				alert('회원정보를 정상적으로 수정 하였습니다.');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;


/**************************************************************************************************
가이드라인 변경에따른 SC제일은행 외 사용하는가상계좌 강제변경 2017-05-29 임근호
***********************************************************************************************************/


	case "guide_update":
		/*seyfert가상계좌 시스템 사용여부*/
		if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);



				/*발급된 이력이 전혀없는 신규 회원일경우*/
				if(!$seyfck['s_bnkCd'] && !$seyfck['s_accntNo']){

				}else{

				if($seyfck['s_bnkCd']=="SC_023"){
				}else{

					/*기존계좌 삭제처리*/
					$sql = " update mari_seyfert
								set s_accntNo='',
								s_bnkCd=''
								where m_id='$user[m_id]'";
					sql_query($sql);




						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);

						$ENCODE_PARAMS="&_method=PUT&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$bankck[s_memGuid]."&bnkCd=SC_023&reset=true";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5a/member/assignVirtualAccount/p2p?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/assignVirtualAccount/p2p');
						$result1 = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$bankcode = json_decode($result1, true);

						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);

						*/
						if(!empty($bankcode)) {
						/*foreach 파싱 데이터출력*/
							foreach($bankcode as $key=>$value){
							$bnkCd=$value['bnkCd'];/*입금은행*/
							$accntNo=$value['accntNo'];/*가상계좌번호*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  s_accntNo from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['s_accntNo']){
									if($accntNo=="E" || $accntNo=="S"){
									}else{
									$sql = " update mari_seyfert
												set s_accntNo='$accntNo',
												s_bnkCd='$bnkCd',
												guide='Y'
												where m_id='$user[m_id]'";
									sql_query($sql);
									}
								}
							}
						}

						alert('P2P가이드라인에 따라 투자자의 투자금 보호를 위해 고객님의 가상 계좌가 \n\nSC제일은행 가상 계좌로 변경되어 예치금이 관리됩니다.\n\n가상계좌가 정상적으로 재발급 되었습니다.','?mode=mypage');

				}
				}
				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}

	break;



/************************************************
회원가입 STEP IIII
************************************************/




/************************************************
비밀번호 변경
************************************************/
	case "change_pw":

		$m_id       = trim($_POST['m_id']);
		$m_password = trim($_POST['m_password']);

		if (!$m_id || !$m_password)
			alert('비밀번호를 입력하여 주십시오.');

			/*패스워드 일치검사*/
			if($m_password==$m_password_re){
			}else{
				alert('패스워드가 일치하지 않습니다.');
				exit;
			}

		$mem = get_member($m_id);

		if (!$mem['m_id'] || (hash('sha256',$password) != $mem['m_password'])) {
			alert('현재 패스워드가 일치하지 않습니다! 다시한번 확인하신후 입력하여 주십시오. ');
		}

		$pw_yes="m_password = '".hash('sha256',$m_password_re)."'";

				$sql = " update  mari_member
							set ".$pw_yes."
							where m_no='$m_no'";
					sql_query($sql);
				alert('비밀번호를 정상적으로 수정 하였습니다.');

	break;

/************************************************
회원탈퇴
************************************************/
	case "leave":

		$m_id       = trim($_POST['m_id']);
		$m_password = trim($_POST['m_password']);

		$mem = get_member($m_id);

		if($type=="d"){
			/*회원정보 찾기*/
				$sql = " select * from mari_member where m_no='".$mem[m_no]."'";
				$leave = sql_fetch($sql, false);

			/*회원탈퇴 테이블에 정보저장*/
				$sql = " insert into mari_member_leave
							set s_id = '$mem[m_id]',
							s_password = '$mem[m_password]',
							s_name = '$mem[m_name]',
							s_email = '$mem[m_email]',
							s_level = '$mem[m_level]',
							s_sex = '$mem[m_sex]',
							s_tel = '$mem[m_tel]',
							s_hp = '$mem[m_hp]',
							s_zip = '$mem[m_zip]',
							s_addr1 = '$mem[m_addr1]',
							s_addr2 = '$mem[m_addr2]',
							s_emoney = '$mem[m_emoney]',
							s_datetime = '$mem[m_datetime]',
							s_ip = '$ip',
							s_reason = '$s_reason',
							s_leave_date = '$date'";
					sql_query($sql);


			/*회원테이블에서 해당회원 삭제*/
				$sql = " delete from mari_member where m_no='".$mem[m_no]."'   ";
				sql_query($sql);
		alert('정상적으로 탈퇴처리 하였습니다.','?mode=logout');
		}
	break;


/************************************************
세이퍼트 가상계좌발급(투자자)
************************************************/

	case "virtualaccountissue":
				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');



				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);
				/*발급내역이 없을경우에만 실행*/
					if(!$seyfck['s_accntNo']){

					if (!$s_bnkCd)
						alert('발급하실 가상계좌 은행을 선택하여 주십시오.');

						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);

						$ENCODE_PARAMS="&_method=PUT&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$bankck[s_memGuid]."&bnkCd=".$s_bnkCd."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5a/member/assignVirtualAccount/p2p?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/assignVirtualAccount/p2p');
						$result1 = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$bankcode = json_decode($result1, true);

						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);

						*/
						if(!empty($bankcode)) {
						/*foreach 파싱 데이터출력*/
							foreach($bankcode as $key=>$value){
							$bnkCd=$value['bnkCd'];/*입금은행*/
							$accntNo=$value['accntNo'];/*가상계좌번호*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  s_accntNo from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['s_accntNo']){
									if($accntNo=="E" || $accntNo=="S"){
									}else{
									$sql = " update mari_seyfert
												set s_accntNo='$accntNo',
												s_bnkCd='$bnkCd'
												where m_id='$user[m_id]'";
									sql_query($sql);
									}
								}
							}
						}
						alert('가상 계좌가 정상적으로 발급되었습니다.');
						}else{
						alert('이미 가상 계좌가 발급되었습니다.');
						}
				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}

	break;


/************************************************
세이퍼트 가상계좌발급(대출자)
************************************************/

	case "virtualaccountissue_loan":
				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


				/*발급여부확인*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);
				/*발급내역이 없을경우에만 실행*/
					if(!$seyfck['s_accntNo']){

					if (!$s_bnkCd)
						alert('발급하실 가상계좌 은행을 선택하여 주십시오.');

						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);

						$ENCODE_PARAMS="&_method=PUT&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$bankck[s_memGuid]."&bnkCd=".$s_bnkCd."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5a/member/assignPayVirtualAccount/p2p?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/assignPayVirtualAccount/p2p');
						$result1 = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$bankcode = json_decode($result1, true);


						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);


						if(!empty($bankcode)) {
						/*foreach 파싱 데이터출력*/
							foreach($bankcode as $key=>$value){
							$bnkCd=$value['bnkCd'];/*입금은행*/
							$accntNo=$value['accntNo'];/*가상계좌번호*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  s_accntNo from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['s_accntNo']){
									if($accntNo=="E" || $accntNo=="S"){
									}else{
									$sql = " update mari_seyfert
												set s_accntNo='$accntNo',
												s_bnkCd='$bnkCd'
												where m_id='$user[m_id]'";
									sql_query($sql);
									}
								}
							}
						}
						alert('대출자가상 계좌가 정상적으로 발급되었습니다.');
						}else{
						alert('이미 가상 계좌가 발급되었습니다.');
						}
				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}

	break;




/************************************************
세이퍼트 계좌주검증 및 권한프로세스
************************************************/

	case "verifyaccount":
				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

				/*계좌검증시 시간체크해서 검증후 4분전까지 재검증진행하지 않도록 처리 2016-12-05 임근호 start*/

				$sql = "select * from mari_seyfert_order where m_id='$user[m_id]' and s_type='3' order by s_date desc";
				$vtimecheckview = sql_fetch($sql, false);

				/*+4분후시간*/
				$now_time_and = date("Y-m-d H:i:s", strtotime("".$vtimecheckview['s_date']."")+240);

				if($now_time_and>$date){
					alert('현재 검증절차가 진행중입니다.\n\n검증요청후 최대4분이상 소요될 수 있습니다. 검증요청 SMS 회신번호 4자리를 입력하여 주십시오.');
				}else if($user['m_verifyaccountuse']=="Y"){
					alert('고객님의 계좌가 검증 되었습니다.');
					exit;
				}else{
				}
				/*계좌검증시 시간체크해서 검증후 4분전까지 재검증진행하지 않도록 처리 2016-12-05 임근호 end*/

				if(!$user[m_my_bankcode] || !$user[m_my_bankacc]){
					alert('출금계좌를 등록하신후 계좌검증이 가능합니다');
					exit;
				}

				/*계좌주검증여부확인*/
				$sql = "select  * from mari_member where m_id='$user[m_id]'";
				$verifya = sql_fetch($sql, false);
				/*검증내역이N,없을 경우에만 실행*/
					if($verifya['m_verifyaccountuse']=="N"){

						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);

						if($authType=="ARS"){
							$SENDTYPE="&authType=ARS_OUT&authSt=";
						}

						$ENCODE_PARAMS="&_method=POST&authOrg=015&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$bankck[s_memGuid]."".$SENDTYPE."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/checkbankcode?".$requestString;


						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfert/checkbankcode');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$bankcode = json_decode($result, true);
						/*주문번호저장*/
							$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){

									$sql = " insert into  mari_seyfert_order
												set s_refId='$g_code',
													m_id='$user[m_id]',
													m_name='$user[m_name]',
													s_subject='계좌주검증',
													s_type='3',
													s_date='$date'";
									sql_query($sql);
									/*s_type 3인경우 계좌주검증*/
									$sql = "select  * from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code' and s_type='3'";
									$orderseyck = sql_fetch($sql, false);

									if(!empty($bankcode)) {
									/*foreach 파싱 데이터출력*/
										foreach($bankcode as $key=>$value){
										/*1회만실행*/
										if(!$orderseyck['s_tid']){
											$tid=$value['tid'];/*생성된 맴버키*/
											if($tid=="S"  || $tid=="E" || !$tid){
											}else{
												$sql = " update  mari_seyfert_order
															set s_tid='$tid'
																where s_refId='$g_code'";
												sql_query($sql);
											/*
											print_r($tid);
											echo"<br/>test<br/>";
											*/
											}
										}
										}
									}

								}else{
									alert('결제멤버 생성후 검증요청을 진행해 주시기 바랍니다.','?mode=mypage');
								}

								/*tid가 없을경우 다시한번 출금계좌요청하고 저장된 요청건삭제처리 2016-09-23 추가*/
								$sql = "select s_tid from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code' and s_type='3' order by s_date desc";
								$tidck = sql_fetch($sql, false);

								if(!$tidck['s_tid']){
									$sql = "delete from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code' and s_type='3' order by s_date desc";
									sql_query($sql);

									alert('출금계좌가 등록되지 않았습니다. \\n\\n마이페이지>기본 정보 수정에서 출금계좌를 확인하신 후 다시 한번 등록하여 주시기 바랍니다.');
								}



/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($bankcode);

*/
						alert('검증요청 하였습니다. 검증완료시 출금신청이 가능합니다.');
					}else{
						alert('이미 계좌주가 확인되었습니다.');
					}
				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}

	break;


/************************************************
대출신청
************************************************/

	case "loan":

		/*콤마제거*/
		$i_loan_pay = (string)$i_loan_pay;
		$i_loan_pay = preg_replace("/[^0-9]/", "",$i_loan_pay);
		$i_loan_pay = (int)$i_loan_pay;

		$i_conni = (string)$i_conni;
		$i_conni = preg_replace("/[^0-9]/", "",$i_conni);
		$i_conni = (int)$i_conni;



		$i_gener = (string)$i_gener;
		$i_gener = preg_replace("/[^0-9]/", "",$i_gener);
		$i_gener = (int)$i_gener;

		$file_img=$_FILES['i_security']['name'];

			/*파일업로드*/
			if(!$file_img==""){
				$img_update="i_security = '".$file_img."',";
				if ($_FILES['i_security']['name']) upload_file($_FILES['i_security']['tmp_name'], $file_img, MARI_DATA_PATH."/photoreviewers");
			}

		/*제출가능 서류*/
		$i_out_paper = "$out_paper_01|$out_paper_02|$out_paper_03|$out_paper_04|$out_paper_05|$out_paper_06|$out_paper_07|$out_paper_08|$out_paper_09|$out_paper_10|$out_paper_11|";
		$i_ppdocuments="$ppdocuments_01|$ppdocuments_02|$ppdocuments_03|$ppdocuments_04|$ppdocuments_05|$ppdocuments_06";


			if($i_plus_pay_mon_a){
				$i_plus_pay_mon=$i_plus_pay_mon_a;
			}else if($i_plus_pay_mon_b){
				$i_plus_pay_mon=$i_plus_pay_mon_b;
			}else if($i_plus_pay_mon_c){
				$i_plus_pay_mon=$i_plus_pay_mon_c;
			}else if($i_plus_pay_mon_d){
				$i_plus_pay_mon=$i_plus_pay_mon_d;
			}

			/*DTI계산 DTI (월소득/월부채상환금액)*100*/
			if($i_plus_pay_mon && $i_credit_pay){
				$dti_add=ceil ($i_credit_pay/$i_plus_pay_mon*100);
			}
			/*거주지주소*/
			$home_address="".$zip1." ".$addr1." ".$addr2."";

			/*휴대폰번호*/
			$m_hp="".$hp1."".$hp2."".$hp3."";


			/*직장주소*/
			if($zip1r){
				$rectal_address="".$zip1r." ".$addr1r." ".$addr2r."";
			}else if($zip1a){
				$rectal_address="".$zip1a." ".$addr1a." ".$addr2a."";
			}else if($zip1b){
				$rectal_address="".$zip1b." ".$addr1b." ".$addr2b."";
			}else if($zip1c){
				$rectal_address="".$zip1c." ".$addr1c." ".$addr2c."";
			}else if($zip1d){
				$rectal_address="".$zip1d." ".$addr1d." ".$addr2d."";
			}

			/*직종*/
			if($i_occu_a){
				$i_occu=$i_occu_a;
			}else if($i_occu_b){
				$i_occu=$i_occu_b;
			}else if($i_occu_c){
				$i_occu=$i_occu_c;
			}else if($i_occu_d){
				$i_occu=$i_occu_d;
			}else if($i_occu_e){
				$i_occu=$i_occu_e;
			}

			/*직장명*/
			if($i_company_name_a){
				$i_company_name=$i_company_name_a;
			}else if($i_company_name_b){
				$i_company_name=$i_company_name_b;
			}else if($i_company_name_c){
				$i_company_name=$i_company_name_c;
			}

			/*직장전화&휴대폰*/
			if($i_businesshp_a){
				$i_businesshp=$i_businesshp_a;
			}else if($i_businesshp_b){
				$i_businesshp=$i_businesshp_b;
			}else if($i_businesshp_c){
				$i_businesshp=$i_businesshp_c;
			}else if($i_businesshp_d){
				$i_businesshp=$i_businesshp_d;
			}else if($i_businesshp_e){
				$i_businesshp=$i_businesshp_e;
			}
			/*고용형태*/
			if($i_employment_a){
				$i_employment=$i_employment_a;
			}else if($i_employment_b){
				$i_employment=$i_employment_b;
			}else if($i_employment_c){
				$i_employment=$i_employment_c;
			}else if($i_employment_d){
				$i_employment=$i_employment_d;
			}

			/*근무개월*/
			if($i_company_day_a){
				$i_company_day=$i_company_day_a;
			}else if($i_company_day_b){
				$i_company_day=$i_company_day_b;
			}else if($i_company_day_c){
				$i_company_day=$i_company_day_c;
			}else if($i_company_day_d){
				$i_company_day=$i_company_day_d;
			}

			/*소득금액 월&년*/
			if($i_plus_pay_mon_a && $i_plus_pay_year_a){
				$i_plus_pay_mon=$i_plus_pay_mon_a;
				$i_plus_pay_year=$i_plus_pay_year_a;
			}else if($i_plus_pay_mon_b && $i_plus_pay_year_b){
				$i_plus_pay_mon=$i_plus_pay_mon_b;
				$i_plus_pay_year=$i_plus_pay_year_b;
			}else if($i_plus_pay_mon_c && $i_plus_pay_year_c){
				$i_plus_pay_mon=$i_plus_pay_mon_c;
				$i_plus_pay_year=$i_plus_pay_year_c;
			}else if($i_plus_pay_mon_d && $i_plus_pay_year_d){
				$i_plus_pay_mon=$i_plus_pay_mon_d;
				$i_plus_pay_year=$i_plus_pay_year_d;
			}

			/*사업자명*/
			if($i_businessname_a){
				$i_businessname=$i_businessname_a;
			}else if($i_businessname_b){
				$i_businessname=$i_businessname_b;
			}else if($i_businessname_c){
				$i_businessname=$i_businessname_c;
			}

		/*등록*/
		if($type=="w"){


						$sql="insert into mari_loan
							set i_payment = '$i_payment',
							m_id = '$user[m_id]',
							m_name = '$user[m_name]',
							i_newsagency = '$i_newsagency',
							m_hp = '$m_hp',
							i_sex = '$i_sex',
							i_pmyeonguija = '$i_pmyeonguija',
							i_myeonguija = '$i_myeonguija',
							i_locaty = '$i_locaty',
							i_locaty_01 = '$i_locaty_01',
							i_locaty_02 = '$i_locaty_02',
							i_purpose = '$i_purpose',
							i_loan_pose = '$i_loan_pose',
							i_plan = '$i_plan',
							i_loan_pay = '$i_loan_pay',
							i_year_plus = '$i_year_plus',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_loan_day = '$i_loan_day',
							i_educa = '$i_educa',
							i_traffic = '$i_traffic',
							i_ltext = '$i_ltext',
							i_ltv = '$i_ltv',
							i_subject = '$i_subject',
							i_area = '$i_area',
							i_zone = '$i_zone',
							i_conni = '$i_conni',
							".$img_update."
							i_birth = '$i_birth',
							i_gener = '$i_gener',
							i_officeworkers = '$i_officeworkers',
							i_occu = '$i_occu',
							i_occu_scale = '$i_occu_scale',
							i_company_name = '$i_company_name',
							i_rectal_address = '$rectal_address',
							i_businesshp = '$i_businesshp',
							i_employment = '$i_employment',
							i_company_day = '$i_company_day',
							i_plus_pay_mon = '$i_plus_pay_mon',
							i_plus_pay_year = '$i_plus_pay_year',
							i_living_pay = '$i_living_pay',
							i_out_paper = '$i_out_paper',
							i_wedding = '$i_wedding',
							i_home_ok = '$i_home_ok',
							i_home_me = '$i_home_me',
							i_home_stay = '$i_home_stay',
							i_car_ok = '$i_car_ok',
							i_veteran = '$i_veteran',
							i_home_address = '$home_address',
							i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_security_type = '$i_security_type',
							i_loan_type = '$i_loan_type',
							i_motivation = '$i_motivation',
							i_business_num = '$i_business_num',
							i_company_name2 = '$i_company_name2',
							i_business_type = '$i_business_type',
							i_location = '$i_location',
							i_perating_period = '$i_perating_period',
							i_csectors = '$i_csectors',
							i_service_item = '$i_service_item',
							i_numberof_ep = '$i_numberof_ep',
							i_annual_sales = '$i_annual_sales',
							i_monthly_sales = '$i_monthly_sales',
							i_mtp_loan = '$i_mtp_loan',
							i_monthly_netprofit = '$i_monthly_netprofit',
							i_eamountof_01 = '$i_eamountof_01',
							i_eamountof_02 = '$i_eamountof_02',
							i_eamountof_03 = '$i_eamountof_03',
							i_eamountof_04 = '$i_eamountof_04',
							i_realestate_price = '$i_realestate_price',
							i_monthly_income = '$i_monthly_income',
							i_regdatetime = '$date'
							";



//					$sql="insert into mari_loan
//							set i_payment = '$i_payment',
//							m_id = '$user[m_id]',
//							m_name = '$user[m_name]',
//							i_newsagency = '$i_newsagency',
//							m_hp = '$m_hp',
//							i_pmyeonguija = '$i_pmyeonguija',
//							i_myeonguija = '$i_myeonguija',
//							i_locaty = '$i_locaty',
//							i_locaty_01 = '$i_locaty_01',
//							i_locaty_02 = '$i_locaty_02',
//							i_purpose = '$i_purpose',
//							i_loan_pose = '$i_loan_pose',
//							i_plan = '$i_plan',
//							i_loan_pay = '$i_loan_pay',
//							i_year_plus = '$i_year_plus',
//							i_repay = '$i_repay',
//							i_repay_day = '$i_repay_day',
//							i_loan_day = '$i_loan_day',
//							i_educa = '$i_educa',
//							i_traffic = '$i_traffic',
//							i_ltext = '$i_ltext',
//							i_ltv = '$i_ltv',
//							i_subject = '$i_subject',
//							i_area = '$i_area',
//							i_zone = '$i_zone',
//							i_conni = '$i_conni',
//							".$img_update."
//							i_birth = '$i_birth',
//							i_gener = '$i_gener',
//							i_officeworkers = '$i_officeworkers',
//							i_occu = '$i_occu',
//							i_company_name = '$i_company_name',
//							i_rectal_address = '$rectal_address',
//							i_businesshp = '$i_businesshp',
//							i_employment = '$i_employment',
//							i_company_day = '$i_company_day',
//							i_plus_pay_mon = '$i_plus_pay_mon',
//							i_plus_pay_year = '$i_plus_pay_year',
//							i_out_paper = '$i_out_paper',
//							i_wedding = '$i_wedding',
//							i_home_ok = '$i_home_ok',
//							i_home_me = '$i_home_me',
//							i_home_stay = '$i_home_stay',
//							i_car_ok = '$i_car_ok',
//							i_veteran = '$i_veteran',
//							i_home_address = '$home_address',
//							i_creditpoint_one = '$i_creditpoint_one',
//							i_creditpoint_two = '$i_creditpoint_two',
//							i_security_type = '$i_security_type',
//							i_loan_type = '$i_loan_type',
//							i_regdatetime = '$date'
//							";
				sql_query($sql);
				/*부체내역*/
				$tmp_g_option = array();
				if(count($i_debt_name) > 0)
				{
					for($i=0;$i<count($i_debt_name);$i++)
					{
						if($i_debt_name[$i]!="")
						{
							$i_debt_pay[$i] = (string)$i_debt_pay[$i];
							$i_debt_pay[$i] = preg_replace("/[^0-9]/", "",$i_debt_pay[$i]);
							$i_debt_pay[$i] = (int)$i_debt_pay[$i];

							$tmp_option = "".$i_debt_company[$i]."[FIELD]".$i_debt_name[$i]."[FIELD]".$i_debt_pay[$i]."[FIELD]".$i_debt_kinds[$i]."";
						}
						$tmp_g_option[] = $tmp_option;
					}
					$i_debt_list = implode("[RECORD]",$tmp_g_option);
				}

				if($uptype=="insert"){

						$sql="insert into mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$user[m_id]'
									";
						sql_query($sql);
				}else if($uptype="update"){
						$sql="update mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$user[m_id]'
									where m_id = '$user[m_id]'
									";
						sql_query($sql);
				}

				if($config['c_sms_use']=="Y"){
					if($load['loan_req']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$user[m_id]'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$loan_msg = str_replace("{이름}", $m_name, $loan_msg);
						$loan_msg = str_replace("{신청금액}", number_format($i_loan_pay), $loan_msg);



						/*80바이트 이상일경우 lms로 발송*/
						$message_msg=mb_strlen($loan_msg, "euc-kr");
						if($message_msg <=80){
							$sendSms="sendSms";
						}else{
							$sendSms="sendSms_lms";
						}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$loan_msg."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 대출신청 하였습니다.",
								 "returnurl" => "".MARI_HOME_URL."?mode=mypage"
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/


				}
			}
				alert('정상적으로 대출신청 하였습니다.','?mode=mypage');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}


	break;




/************************************************
비밀번호 변경요청
************************************************/

	case "personal_info_pw":

		$m_id       = trim($_POST['m_id']);
		$m_password = trim($_POST['m_password']);

		if (!$m_id || !$m_password)
			alert('비밀번호를 입력하여 주십시오.');

		$mem = get_member($m_id);

		if (!$mem['m_id'] || (hash('sha256',$m_password) != $mem['m_password'])) {
			alert('존재하지 않거나 잘못된 계정 또는 \\n계정과 비밀번호가 일치하지 않습니다. ');
		}else{
			goto_url(MARI_HOME_URL.'/?mode=info_modify');
		}
	break;




/************************************************
문의접수
************************************************/

	case "contact_update":
			/*insert*/
				$sql = " insert into mari_contact_reception
							set cs_user_name = '$cs_user_name',
								cs_customer_name = '$cs_customer_name',
								cs_subject = '$cs_subject',
								cs_content = '$cs_content',
								cs_state = '$cs_state',
								cs_rege_date = '$date',
								cs_course = '$cs_course'";
					sql_query($sql);
			goto_url(MARI_HOME_URL.'/golf.html?contact=Y');
	break;





/************************************************
투자신청및 접수
************************************************/
	case "invest2":

		/*콤마제거*/
		$i_pay = (string)$i_pay;
		$i_pay = preg_replace("/[^0-9]/", "",$i_pay);
		$i_pay = (int)$i_pay;

			$m_my_bankacc = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $m_my_bankacc);

			if($type=="w"){


			/*발급받은 s_accntNo 조회*/
			$sql = "select  s_accntNo from mari_seyfert where m_id='$user[m_id]'";
			$bankck = sql_fetch($sql, false);

			if(!$bankck['s_accntNo']){
				//태기테스트
				alert('가상계좌를 생성후 투자하실 수 있습니다.\\n 가상계좌를 생성하여 주십시오.','?mode=mypage_certification');
				exit;
			}


			if(!$user['m_reginum']){
				if ($user['m_level']=='2' && $user['m_signpurpose']== 'C2' ){
					; //법인대부는 원청징수정도등록 패스
				}else {
					alert('원천징수정보를 등록하셔야 투자가가능합니다.\\n 원천징수 정보를 등록하여 주십시오.','?mode=mypage_modify');
					exit;
				}
			}

			/*loan_id 값이 들어왔는지 체크 세션이끊키거나 새로고침시 발생하는문제 2016-10-04추가*/
			if(!$loan_id){
				alert('일시적인 오류로 정상적으로 투자가 진행되지 않았습니다.\\n 다시 시도해주시기 바랍니다.','?mode=invest_view&loan_id='.$loan_id.'');
				exit;
			}


			/*최소투자금액설정*/
				$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
				$iv_pay = sql_fetch($sql, false);


			if($iv_pay['i_invest_mini' ] == $i_pay){
			}else if($iv_pay['i_invest_mini' ] >= $i_pay){
						alert_close($iv_pay['i_invest_mini'].'원 이상만 투자하실 수 있습니다.');
						exit;
			}

			/*최대투자금액설정*/
			$sql = "select * from mari_loan where i_id = '$loan_id'";
			$lo_pay = sql_fetch($sql, false);

			/*최대투자금액 계산*/
			$max_pay = ($lo_pay['i_loan_pay'] / 100) * $iv_pay['i_invest_max'];

			/*최대투자금액설정*/
			if($i_pay > $max_pay){
					alert("해당상품의 투자가능 한도는 ".number_format(unit($max_pay))."만원 입니다. 한도를 초과하여 투자하실 수 없습니다.");
					exit;
			}


			if (!$user['m_id'] || (hash('sha256',$m_password) != $user['m_password'])) {
				alert('존재하지 않거나 잘못된 계정 또는 \\n계정과 비밀번호가 일치하지 않습니다. ');
				exit;
			}

/* 2018 07 10 임성택 회원분류추가 */
			include (getcwd().'/module/basic.php');
			$sameOwnerCheck = sameOwnerCheck ($user['m_id'], $loan_id);
			$getMemberlimit = getMemberlimitbyloan($user['m_id'], $loan_id);

			//$memberInvestmentNowProgress = memberInvestmentNowProgress($user['m_id']);
			//$a_total = ( (int)$getMemberlimit['insetpay'] - (int)$memberInvestmentNowProgress['investProgressTotal'] );

			$a_total = $getMemberlimit['avail'];
			$a_total2 = (int)$sameOwnerCheck['per_maximum'] - (int)$sameOwnerCheck['totalpay'];
			if ( $a_total2 < 0 ) $a_total2 = 0;
			$available_total = ($a_total > $a_total2) ? $a_total2 : $a_total;
			if( $i_pay > $available_total ) {
				//alert("일반 개인투자자는 채권당 " . number_format($iv_pay['i_maximum']) . "원이 초과하실경우 \\n투자를 하실 수 없습니다.");
				alert($getMemberlimit['invest_flag']." 회원님의 총투자한도는 ".number_format($getMemberlimit['insetpay'])."원이며\\n투자가능금액은" .number_format($available_total)."원 입니다.");
				exit;
			}
/* 2018 07 10 임성택 블럭 - 회원 분류가 안되어 있음으로 막음
//가이드라인 투자금액제한 START (2017-08-17 가이드라인 회원별 투자한도, 상환완료된 채권에대한 한도리셋, 관리자모드 회원별 한도조정)
			//해당 버전을 사용하기위해서는 mari_invest_progress테이블에 i_maximum_v, i_maximum, i_maximum_pro, i_maximum_in 레코드를 추가해야한다.

			//가이드라인 시행날짜구분 시행날짜보다 많을경우에만 한도측정
			$ssdate="2017-05-29 00:00:00";

			//신규 회원누적투자금액 투자, 투자진행설정 join
			//
			$sql="select sum(i_pay) from mari_invest A LEFT JOIN mari_invest_progress B ON A.loan_id = B.loan_id AND A.m_id = '$user[m_id]' where B.i_look='N' OR B.i_look='C' and  A.i_regdatetime between '".$ssdate."' and '".$date."'"; 			$accr_pay = sql_query($sql, false);			$accr_invest_pay = mysql_result($accr_pay, 0, 0);


			//신규 회원누적투자금액 투자, 투자진행설정 join
			$sql="select * from mari_invest
					where m_id = '$user[m_id]'
					and  i_regdatetime between '".$ssdate."' and '".$date."' ";
			$accr_pay = sql_query($sql, false);

			if(!empty($accr_pay)) {
			    for ($or=0; $row2=sql_fetch_array($accr_pay); $or++) {

				$sql = "select  * from  mari_invest_progress where loan_id='$row2[loan_id]'";
				$prs = sql_fetch($sql, false);

					if($row2['m_id']==$user['m_id'] && $prs['i_look']=="C" || $prs['i_look']=="D" ){
					$accr_invest_pay +=$row2['i_pay'];
					}
			    }
			}


			//투자가능한도 측정//
			$i_payck=$accr_invest_pay + $i_pay;



			//기존 회원누적투자금액
			//$sql="select sum(i_pay) from mari_invest where m_id = '$user[m_id]' and  i_regdatetime between '".$ssdate."' and '".$date."'"; $accr_pay = sql_query($sql, false);$accr_invest_pay = mysql_result($accr_pay, 0, 0);


			//회원누적투자금액 + 투자금액
			$accr_invest_max = $accr_invest_pay + $i_pay;


			//투자 가능한도체크
			$sql = "select  * from  mari_inset";
			$is_ck = sql_fetch($sql, false);

			//개인회원 투자금액 제한
			if($user['m_level']=="2"){

				//일반 개인투자자
				if($user['m_signpurpose']=="N" || $user['m_signpurpose']=="L"){

					//투자가능금액(일반 개인투자자 and 일단 대출회원)
					if($accr_invest_pay>$is_ck['i_maximum']){
						$poss_pay ="0";
					}else{
						$poss_pay = $is_ck['i_maximum']-$accr_invest_pay;
					}

					if($accr_invest_pay>$iv_pay['i_maximum']){
						$poss_pays ="0";
					}else{
						$poss_pays = $iv_pay['i_maximum']-$accr_invest_pay;
					}


					//일반 개인투자자 채권당 1회한도설정 가이드라인 최종반영 2017-08-09 임근호

					if($i_pay>$iv_pay['i_maximum'] || $i_payck>$is_ck['i_maximum']){
						//alert("일반 개인투자자는 채권당 ".number_format($iv_pay['i_maximum'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pays)."원 입니다.");
						alert("일반 개인투자자는 채권당 ".number_format($iv_pay['i_maximum'])."원이 초과하실경우 \\n투자를 하실 수 없습니다.");
						exit;
					}


					//일반 (일반 개인투자자 and 일단 대출회원)회원 누적투자금액이 관리자에서 제한한 금액보다 클경우 제한
					if($accr_invest_max >$is_ck['i_maximum']){
						alert("일반 개인투자자는 누적투자금액이 ".number_format($is_ck['i_maximum'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pay)."원 입니다.");
						exit;
					}


				//소득적격 개인투자자
				}else if($user['m_signpurpose']=="I"){

					//투자가능금액(소득적격 개인투자자)
					if($accr_invest_pay>$is_ck['i_maximum_in']){
						$poss_pay ="0";
					}else{
						$poss_pay = $is_ck['i_maximum_in']-$accr_invest_pay;
					}

					if($accr_invest_pay>$iv_pay['i_maximum_in']){
						$poss_pays ="0";
					}else{
						$poss_pays = $iv_pay['i_maximum_in']-$accr_invest_pay;
					}
					//소득적격 개인투자자회원 채권당 1회한도설정 가이드라인 최종반영 2017-08-09 임근호

					if($i_pay>$iv_pay['i_maximum_in'] || $i_payck>$is_ck['i_maximum_in']){
						alert("일반 개인투자자는 채권당 ".number_format($iv_pay['i_maximum_in'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pays)."원 입니다.");
						exit;
					}

					//소득적격 개인투자자회원 누적투자금액이 관리자에서 제한한 금액보다 클경우 제한
					if($accr_invest_max >$is_ck['i_maximum_in']){
						alert("소득적격 개인투자자는 누적투자금액이 ".number_format($is_ck['i_maximum_in'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pay)."원 입니다.");
						exit;
					}




				//전문 개인투자자
				}else if($user['m_signpurpose']=="P"){

					//투자가능금액(전문투자자)
					if($accr_invest_pay>$is_ck['i_maximum_pro']){
						$poss_pay ="0";
					}else{
						$poss_pay = $is_ck['i_maximum_pro']-$accr_invest_pay;
					}

					if($accr_invest_pay>$iv_pay['i_maximum_pro']){
						$poss_pays ="0";
					}else{
						$poss_pays = $iv_pay['i_maximum_pro']-$accr_invest_pay;
					}

					//전문투자자회원 채권당 1회한도설정 가이드라인 최종반영 2017-08-09 임근호

					if($i_pay>$iv_pay['i_maximum_pro'] || $i_payck>$is_ck['i_maximum_pro']){
						alert("전문투자자는 채권당 ".number_format($iv_pay['i_maximum_pro'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pays)."원 입니다.");
						exit;
					}

					//전문투자자 누적투자금액이 관리자에서 제한한 금액보다 클경우 제한
					if($accr_invest_max >$is_ck['i_maximum_pro']){
						alert("전문투자자는 누적투자금액이 ".number_format($is_ck['i_maximum_pro'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pay)."원 입니다.");
						exit;
					}




				}
			}

			//법인회원 투자금액 제한
			if($user['m_level']>="3"){

				//투자가능금액(법인)
					if($accr_invest_pay>$is_ck['i_maximum_v']){
						$poss_pay ="0";
					}else{
						$poss_pay = $is_ck['i_maximum_v']-$accr_invest_pay;
					}

					if($accr_invest_pay>$iv_pay['i_maximum_v']){
						$poss_pays ="0";
					}else{
						$poss_pays = $iv_pay['i_maximum_v']-$accr_invest_pay;
					}

					//법인회원은 채권당 1회한도설정 가이드라인 최종반영 2017-08-09 임근호
					if($i_pay>$iv_pay['i_maximum_v'] || $i_payck>$is_ck['i_maximum_v']){
						alert("법인회원은 누적투자금액이 ".number_format($iv_pay['i_maximum_v'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pays)."원 입니다.1");
						exit;
					}

				//법인회원 누적투자금액이 관리자에서 제한한 금액보다 클경우 제한
				if($accr_invest_max >$is_ck['i_maximum_v']){
					alert("법인회원은 누적투자금액이 ".number_format($is_ck['i_maximum_v'])."원이 초과하실경우 \\n투자를 하실 수 없습니다. \\n현재투가능 금액은 ".number_format($poss_pay)."원 입니다.");
					exit;
				}

			}
			// 가이드라인 투자금액제한 END (2017-08-17 가이드라인 회원별 투자한도, 상환완료된 채권에대한 한도리셋, 관리자모드 회원별 한도조정)
			*/

				/*계좌가 설정되지않은경우에만 저장*/
				if($bank_update=="Y"){

					/*적립금 입금계좌 저장*/
						$sql = "update mari_member
									set m_my_bankcode = '$m_my_bankcode',
									m_my_bankname = '$m_my_bankname',
									i_danger = '$i_danger',
									m_my_bankacc = '$m_my_bankacc'
									where m_no='$m_no'
									";
						sql_query($sql);

				}

				/*대출 상세정보*/
				$sql = "select  * from  mari_loan where i_id='$loan_id'";
				$loa = sql_fetch($sql, false);

				/*대출총액의 투자금액 백분율구하기*/
				$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'";
				$top=sql_query($sql, false);
				$order = mysql_result($top, 0, 0);
				$total=$loa[i_loan_pay];
				$order_p=$order+$i_pay;
				/* 투자금액 / 대출금액 * 100 */
				$order_pay=ceil ($order_p/$total*100);
				/*투자금액+현재투자총금액이 100%보다클경우에 투자불가하도록처리*/
				if($order_pay>100){
					alert_close('투자금액이 100%이상 초과하여 해당금액으로 투자가 불가능합니다.\n\n 남은 투자가능 금액을 확인하신후 투자해 주시기 바랍니다.');
					exit;
				}


				/*투자위험고지 가이드라인 2017-05-12 임근호*/
					$sql = "update mari_member
								set i_danger = '$i_danger'
								where m_no='$m_no'
								";
					sql_query($sql);



				/*투자내역확인*/

				$sql = "select  * from  mari_invest where m_id='$m_id' and loan_id='$loan_id'";
				$loa_ck = sql_fetch($sql, false);
				if(!$loa_ck[m_id]==""){
					alert_close('이미 투자하신 상품입니다. 중복하여 투자하실 수 없습니다.');
					exit;
				}



				/*투자 회원정보*/
				$sql = "select  * from  mari_member where m_no='$m_no'";
				$m_ck = sql_fetch($sql, false);

				if($m_ck[m_emoney] >=$i_pay){
				}else{
					alert('잔액이 부족합니다 마이페이지에서 가상계좌를 생성하신후 생성된 가상계좌로 입금해주시기 바랍니다.','?mode=mypage');
					exit;
				}


								/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

				/*가상계좌 세이퍼트멤버생성정보*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);


						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$i_subject="".$loa[i_subject]." 투자건 입찰";
						$ENCODE_PARAMS="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&title=".urlencode($i_subject)."&refId=".$g_code."&authType=SMS_MO&timeout=30&srcMemGuid=".$seyfck[s_memGuid]."&dstMemGuid=".$config[c_reqMemGuid]."&amount=".$i_pay."&crrncy=KRW&authSessionTimeout=0";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/transferPending?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/transferPending');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$decode = json_decode($result, true);

/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);


						echo"<br/><br/>데이터";
						print_r($decode);
						echo"<br/><br/>";
*/
						/*주문번호저장*/
							$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){

									$sql = " insert into  mari_seyfert_order
												set s_refId='$g_code',
													m_id='$user[m_id]',
													m_name='$user[m_name]',
													s_subject='$i_subject',
													loan_id='$loan_id',
													s_amount='$i_pay',
													s_date='$date'";
									sql_query($sql);

									$sql = "select  * from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code'";
									$orderseyck = sql_fetch($sql, false);

									if(!empty($decode)) {
									/*foreach 파싱 데이터출력*/
										foreach($decode as $key=>$value){
										/*1회만실행*/
										if(!$orderseyck['s_tid']){
											$tid=$value['tid'];/*생성된 맴버키*/
											if($tid=="S" || $tid=="E" || !$tid){
											}else{
												$sql = " update  mari_seyfert_order
															set s_tid='$tid'
																where s_refId='$g_code'";
												sql_query($sql);
											/*
											print_r($tid);
											echo"<br/>test<br/>";
											*/
											}
										}
										}
									}

								}else{
									alert('가상계좌 생성후 입금후 진행하여 주시기 바랍니다.','?mode=mypage_certification');
								}



				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}



				if($config['c_sms_use']=="Y"){
					if($load['invest_req_01']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$user[m_id]'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$invest_msg_01 = str_replace("{이름}", $m_name, $invest_msg_01);
						$invest_msg_01 = str_replace("{투자금액}", number_format($i_pay), $invest_msg_01);
						$invest_msg_01 = str_replace("{제목}", $loa[i_subject], $invest_msg_01);



						/*80바이트 이상일경우 lms로 발송*/
						$message_msg=mb_strlen($invest_msg_01, "euc-kr");

						if($message_msg <=80){
							$sendSms="sendSms";
						}else{
							$sendSms="sendSms_lms";
						}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$invest_msg_01."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 투자신청 하였습니다. 등록하신 휴대폰 번호로 투자금에 대한 회신 인증 문자를 확인하신 후 인증번호를 입력하셔야만 투자가 성사됩니다.",
								// "returnurl" => "".MARI_HOME_URL."?mode=mypage&i_pay=".$i_pay."&loan_id=".$loan_id.""
								"returnurl" => "https://www.kfunding.co.kr/pnpinvest/?mode=mypageinfo"
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/
					}
				}


					alert('정상적으로 투자신청 하였습니다. 등록하신 휴대폰 번호로 투자금에 대한 회신 인증 문자를 확인하신 후 인증번호를 입력하셔야만 투자가 성사됩니다.','/pnpinvest/?mode=mypageinfo');
			}else{
				alert('정상적인 접근이 아닙니다.');
				exit;
			}
	break;



/************************************************
투자신청및 접수 new
************************************************/
	case "investment":




			if($type=="w"){

			if($i_pay=="50000"){
			}else if(50000>$i_pay){
						alert_close('50,000원 이상만 투자하실 수 있습니다.');
						exit;
			}
				/*계좌가 설정되지않은경우에만 저장*/
				if($bank_update=="Y"){

					/*적립금 입금계좌 저장*/
						$sql = "update mari_member
									set m_my_bankcode = '$m_my_bankcode',
									m_my_bankname = '$m_my_bankname',
									m_my_bankacc = '$m_my_bankacc'
									where m_no='$m_no'
									";
						sql_query($sql);
				}

				/*대출 상세정보*/
				$sql = "select  * from  mari_loan where i_id='$loan_id'";
				$loa = sql_fetch($sql, false);

				/*대출총액의 투자금액 백분율구하기*/
				$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'";
				$top=sql_query($sql, false);
				$order = mysql_result($top, 0, 0);
				$total=$loa[i_loan_pay];
				$order_p=$order+$i_pay;
				/* 투자금액 / 대출금액 * 100 */
				$order_pay=ceil ($order_p/$total*100);
				/*투자금액+현재투자총금액이 100%보다클경우에 투자불가하도록처리*/
				if($order_pay>100){
					alert_close('투자금액이 100%이상 초과하여 해당금액으로 투자가 불가능합니다.\n\n 남은 투자가능 금액을 확인하신후 투자해 주시기 바랍니다.');
					exit;
				}


				/*투자내역확인*/
				$sql = "select  * from  mari_invest where m_id='$m_id' and loan_id='$loan_id'";
				$loa_ck = sql_fetch($sql, false);
				if(!$loa_ck[m_id]==""){
					alert_close('이미 투자하신 상품입니다. 중복하여 투자하실 수 없습니다.');
					exit;
				}

				/*투자 가능한도체크*/
				$sql = "select  * from  mari_inset";
				$is_ck = sql_fetch($sql, false);
				if($is_ck['i_maximum']<$i_pay){
					alert_close("현재 투자가능 한도는 ".$is_ck[i_maximum]."입니다. 한도를 초과하여 투자하실 수 없습니다.");
					exit;
				}

				/*투자 회원정보*/
				$sql = "select  * from  mari_member where m_no='$m_no'";
				$m_ck = sql_fetch($sql, false);

				if($m_ck[m_emoney] >=$i_pay){
					$emoney=$m_ck[m_emoney]-$i_pay;
					$sql = "update mari_member
								set m_emoney = '".$emoney."'
								where m_no='$m_no'
								";
					sql_query($sql);
				}else{
					alert('적립금이 부족합니다! 적립금 충전후 신청하여 주십시오.','?mode=mypage_confirm_center');
					exit;
				}

					/*대출 상세정보 insert*/
					$sql = "insert into mari_invest
								set i_pay = '$i_pay',
								i_goods = '$loa[i_payment]',
								m_id = '$m_id',
								loan_id = '$loan_id',
								m_name = '$m_name',
								user_name = '$loa[m_name]',
								user_id = '$loa[m_id]',
								i_subject = '$loa[i_subject]',
								i_loan_pay = '$loa[i_loan_pay]',
								i_pay_ment = 'Y',
								i_profit_rate = '$loa[i_year_plus]',
								i_max_pay = '$loa[i_loan_day]',
								i_day = '$loa[i_loan_pay]',
								i_level_dti = '$loa[i_level_dti]',
								i_ip = '$ip',
								i_regdatetime = '$date',
								i_loan_type = '$loan'
								";
					sql_query($sql);

					$sql = " select * from mari_member where m_id='$user[m_id]'";
					$em = sql_fetch($sql, false);
					/*아이디 체크*/
					if(!$em['m_id']){
						alert('아이디가 존재하지 않습니다.');
						exit;
					}
					/*포인트 합산*/
					$p_top_emoney=$i_pay+$em['m_emoney'];

					/*포인트지급내용 저장*/
					$sql = " insert into mari_emoney
								set m_id = '$user[m_id]',
								p_datetime = '$date',
								p_content = '".$loa[i_subject]." 투자건 입찰',
								p_emoney = '$i_pay',
								p_ip = '$ip',
								p_top_emoney = '$p_top_emoney'";
					sql_query($sql);

				if($config['c_sms_use']=="Y"){
					if($load['invest_req_01']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$user[m_id]'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$invest_msg_01 = str_replace("{이름}", $m_name, $invest_msg_01);
						$invest_msg_01 = str_replace("{투자금액}", number_format($i_pay), $invest_msg_01);
						$invest_msg_01 = str_replace("{제목}", $loa[i_subject], $invest_msg_01);



						/*80바이트 이상일경우 lms로 발송*/
						$message_msg=mb_strlen($invest_msg_01, "euc-kr");

						if($message_msg <=80){
							$sendSms="sendSms";
						}else{
							$sendSms="sendSms_lms";
						}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$invest_msg_01."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 투자신청 하였습니다. 등록하신 휴대폰 번호로 투자금에 대한 회신 인증 문자를 확인하신 후 인증번호를 입력하셔야만 투자가 성사됩니다.",
								 "returnurl" => "https://www.kfunding.co.kr/pnpinvest/?mode=mypageinfo"
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/
					}
				}

					alert('정상적으로 투자신청 하였습니다. 등록하신 휴대폰 번호로 투자금에 대한 회신 인증 문자를 확인하신 후 인증번호를 입력하셔야만 투자가 성사됩니다.','?mode=mypageinfo');
			}else{
				alert('정상적인 접근이 아닙니다.');
				exit;
			}
	break;



























/************************************************
적립금 출금신청
************************************************/
	case "withdrawl":

		if($type=="w"){

			$o_pay = (string)$o_pay;
			$o_pay = preg_replace("/[^0-9]/", "",$o_pay);
			$o_pay = (int)$o_pay;


				/*출금가능한도체크*/
				$sql = "select  * from  mari_member where m_id='".$user[m_id]."'";
				$wit_ck = sql_fetch($sql, false);
				if($wit_ck['m_emoney']<$o_pay){
					alert("현재 고객님의 예치금 출금가능 잔액은 ".$wit_ck['m_emoney']."입니다. 한도를 초과하여 출금하실 수 없습니다.");
					exit;
				}


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

				/*가상계좌 세이퍼트멤버생성정보*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);


						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$i_subject="잔액 출금신청";
						$ENCODE_PARAMS="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&title=".urlencode($i_subject)."&refId=".$g_code."&authType=SMS_MO&timeout=30&dstMemGuid=".$seyfck[s_memGuid]."&amount=".$o_pay."&crrncy=KRW";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/withdraw?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfert/withdraw');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$decode = json_decode($result, true);

						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);


						echo"<br/><br/>데이터";
						print_r($decode);
						echo"<br/><br/>";
						*/

						/*주문번호저장*/
							$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){

									$sql = " insert into  mari_seyfert_order
												set s_refId='$g_code',
													m_id='$user[m_id]',
													m_name='$user[m_name]',
													s_subject='$i_subject',
													loan_id='$loan_id',
													s_amount='$o_pay',
													s_type='2',
													s_date='$date'";
									sql_query($sql);
									/*s_type 2인경우 출금신청*/
									$sql = "select  * from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code' and s_type='2'";
									$orderseyck = sql_fetch($sql, false);

									if(!empty($decode)) {
									/*foreach 파싱 데이터출력*/
										foreach($decode as $key=>$value){
										/*1회만실행*/
										if(!$orderseyck['s_tid']){
											$tid=$value['tid'];/*생성된 맴버키*/
											if($tid=="S"  || $tid=="E" ||  !$tid){
											}else{
												$sql = " update  mari_seyfert_order
															set s_tid='$tid'
																where s_refId='$g_code'";
												sql_query($sql);
											/*
											print_r($tid);
											echo"<br/>test<br/>";
											*/
											}
										}
										}
									}

								/*출금신청내용 추가*/
								$sql = " insert into mari_outpay
											set m_id = '$m_id',
											m_name = '$m_name',
											o_pay = '$o_pay',
											o_regdatetime = '$date',
											o_fin = 'N',
											o_refId = '$g_code',
											o_ip = '$ip'";
								sql_query($sql);

								}else{
									alert('결제멤버 생성후 출금신청을 진행해 주시기 바랍니다.','?mode=mypage');
								}

				}


		alert('정상적으로 출금신청 하였습니다.','?mode=mypage');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;




/************************************************
적립금 충전결제
************************************************/
	case "charge":

		if($type=="w"){
			if($o_pay<10000){
				alert('10000원 이하로 충전신청하실 수 없습니다.');
			}else{
			/*회원탈퇴 테이블에 정보저장*/
				$sql = " insert into mari_char
							set m_id = '$m_id',
							m_name = '$m_name',
							c_pay = '$c_pay',
							c_regdatetime = '$date',
							c_fin = 'Y',
							c_ip = '$ip'";
				sql_query($sql);
			}

				if($config['c_sms_use']=="Y"){
					if($load['invest_req_03']=="Y"){
						/*SMS자동전송 시작*/
						$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$user[m_id]'");

						/*휴대폰번호 분리*/
						$m_hp = $loadmem['m_hp'];
						$hp1=substr($m_hp,0,3);
						$hp2=substr($m_hp,3,-4);
						$hp3=substr($m_hp,-4);
						$to_hp="".$hp1."".$hp2."".$hp3."";

						/*문자치환*/
						$invest_msg_03 = str_replace("{이름}", $m_name, $invest_msg_03);
						$invest_msg_03 = str_replace("{이머니}", $c_pay, $invest_msg_03);

						/*SMS전송 FORM submit*/
						echo"
						<form name=f method=post action='http://way21.co.kr/admin/sms/ajax_sms_proc_utf8.php?smsload=Y'>
						<input type=hidden name='cid' value='".$config[c_sms_id]."'/>/*sms코드*/
						<input type=hidden name='from' value='".$config[c_sms_phone]."'/>/*발신번호*/
						<input type=hidden name='to' value='".$to_hp."'/>/*수신번호*/
						<input type=hidden name='msg' value='".$invest_msg_03."'/>/*전송메세지*/
						<input type=hidden name='mode' value='sendSms'/>/*즉시발송모드*/
						<input type=hidden name='returnurl' value='".MARI_HOME_URL."?mode=mypage_loan_info'>/*returnurl*/
						</form>
						<script>
							document.f.submit();
						</script>
						";
					}
				}

		alert('정상적으로 충전 되었습니다.','?mode=mypage_loan_info');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;


/************************************************
사용자 게시판 상세(공통)
************************************************/
	case "bbs_view":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);

		if($type=="d"){
			/*delete*/
				$sql = " delete from mari_write where w_id='".$w_id."'   ";
				sql_query($sql);
				alert('정상적으로 삭제처리 하였습니다.','?mode=bbs_list&table='.$table.'&subject='.$subject.'');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;



/************************************************
사용자 게시판 쓰기(공통)
************************************************/
	case "bbs_write":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);

		if($bbs_config['bo_write_level']>$user['m_level']){
			alert('글쓰기 권한이 없습니다.');
			exit;
		}

		$timetoday = mktime();
		$now = date("Y-m-d H:i:s", $timetoday);
		/*디렉톡리생성*/
		@mkdir(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);

		$tmp_file  = $_FILES['u_img']['tmp_name'];
		$filesize  = $_FILES['u_img']['size'];
		$file_img=$_FILES['u_img']['name'];
		$file_img  = preg_replace('/(<|>|=)/', '', $file_img);



		if (is_uploaded_file($tmp_file)) {
			/*설정한 업로드 사이즈보다 크다면 건너뛰도록*/
			if (!$filesize > $bbs_config['bo_upload_size']) {
				$file_upload_msg .= '\"'.$file_img.'\" 파일의 용량('.number_format($filesize).' 바이트)이 게시판에 설정('.number_format($bbs_config['bo_upload_size']).' 바이트)된 값보다 크기때문에 업로드가 불가능합니다.\\n';
				continue;
			}

			/*이미지나 플래시 파일에 악성코드를 심어 업로드 하는 경우를 방지하기위함
			 에러메세지는 출력하지 않도록.*/
			//-----------------------------------------------------------------
			$timg = @getimagesize($tmp_file);
			// image type
			if ( preg_match("/\.(".$config['c_image_upload'].")$/i", $file_img) ||
				 preg_match("/\.(".$config['c_flash_upload'].")$/i", $file_img) ) {
				if ($timg['2'] < 1 || $timg['2'] > 16)
					continue;
			}

		}
		/*파일업로드*/
		if(!$file_img==""){
			$img_update="file_img	 = '".$file_img."',";
			if ($_FILES['u_img']['name']) upload_file($_FILES['u_img']['tmp_name'], $file_img, MARI_DATA_PATH."/$table");
		}
		/*휴대폰번호 합침*/
		$w_hp="".$hp1."".$hp2."".$hp3."";
		if($w_hp == "선택"){
			$w_hp = "";
		}
		/*페스워드가 있을경우에만*/

			$pw_yes="w_password = '".hash('sha256',$w_password)."',";

		if($type=="w"){

		/*중복체크 최고관리자또는 게시판관리자인경우에는 중복체크하지않음*/
		if($config[c_admin]==$user[m_id] || $config[c_admin]==$bbs_config[bo_admin]){
		}else{
			if ($m_id=="admin" || $m_id=="ADMIN"  || $m_id=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($w_name=="최고관리자" || $w_name=="관리자"  || $w_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');
		}
			$mb = get_member($m_id);
			/*insert*/
				$sql = " insert into mari_write
							set w_table = '$table',
							".$pw_yes."
							w_num = '$w_num',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							m_id = '$m_id',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',
							w_main_exposure = '$w_main_exposure',
							w_rink	 = '$w_rink',
							".$img_update."
							w_blank = '$w_blank',
							w_answer = '',
							w_datetime ='$date'";
					sql_query($sql);

				/*인터뷰게시판일 경우에만*/
				if($table=="interview"){
					alert('정상적으로 작성 하였습니다.','?mode=interview_list&table='.$table.'&subject='.$subject.'');
				}else{
					alert('정상적으로 작성 하였습니다.','?mode=bbs_list&table='.$table.'&subject='.$subject.'');
				}
		}else if($type=="m"){

		$sql = " select  file_img from  mari_write  where table='$table' and w_id='$w_id'";
		$d_file = sql_fetch($sql, false);
		/*file 삭제*/
		if($d_img=="1"){
			$img_update="file_img	 = '',";
			@unlink(MARI_DATA_PATH."/".$table."/".$d_file[file_img]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['file_img'])) {
				delete_board_thumbnail($table, $d_file['file_img']);
			}
		}

			/*update*/
				$sql = " update  mari_write
							set ".$pw_yes."
							w_num = '-".$w_id."',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							m_id = '$m_id',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',
							w_main_exposure = '$w_main_exposure',
							w_rink	 = '$w_rink',
							w_blank = '$w_blank',
							".$img_update."
							w_last ='$date',
							w_answer = '$w_answer'
							where w_table='$table' and w_id = '$w_id'";
					sql_query($sql);

				/*인터뷰게시판일 경우에만*/
				if($table=="interview"){
					alert('정상적으로 작성 하였습니다.','?mode=interview_list&table='.$table.'&subject='.$subject.'');
				}else{
					alert('정상적으로 작성 하였습니다.','?mode=bbs_list&table='.$table.'&subject='.$subject.'');
				}
		}else if($type=="d"){
			/*delete*/
				$sql = " delete from mari_write where w_id='".$w_id."'   ";
				sql_query($sql);
				/*인터뷰게시판일 경우에만*/
				if($table=="interview"){
					alert('정상적으로 작성 하였습니다.','?mode=interview_list&table='.$table.'&subject='.$subject.'');
				}else{
					alert('정상적으로 작성 하였습니다.','?mode=bbs_list&table='.$table.'&subject='.$subject.'');
				}
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;





/************************************************
댓글수정관리
************************************************/
	case "bbs_comment":

			if($type=="w"){
				$sql = "insert into mari_comment
						set w_table = '$table',
						w_id = '$w_id',
						m_id = '$m_id',
						co_name = '$m_name',
						co_level = '$user[m_level]',
						co_content = '$co_content',
						co_datetime = '$date'	,
						co_ip = '$ip'
						";
				sql_query($sql);
				alert('댓글을 등록하였습니다.');
			}else if($type=="m"){
				$sql = "update mari_comment
						set co_content = '$co_content',
						co_last = '$date'
						where co_id = '$co_id' and w_id = '$w_id' and w_table = '$table'
						";
				sql_query($sql);
				alert('댓글을 수정하였습니다.','?mode=bbs_view&type=view&table=qna&id='.$w_id.'');
			}else if($type=="d"){
				$sql = "delete from mari_comment where co_id = '$co_id' and w_id = '$w_id'";
				sql_query($sql);
				alert('댓글을 삭제하였습니다.');
			}


	break;

/************************************************
위시리스트 등록
************************************************/
	case "wishlist":
			if($type=="w"){
				$sql = " insert into mari_wishlist
							set loan_id = '$loan_id',
							m_id = '$user[m_id]',
							ws_datetime ='$date'";
				sql_query($sql);
				alert('관심상품으로 등록하였습니다.');
			}else if($type=="d"){
				$sql = "delete from mari_wishlist where loan_id='".$loan_id."' and m_id='".$user[m_id]."'";
				sql_query($sql);
				alert('관심상품을 해제하였습니다.');
			}else{
				alert('정상적인 접근이 아닙니다.');
				exit;
			}
	break;


/************************************************
invest comment
************************************************/
	case "invest_comment":

		/*로그인 체크여부*/
		$login_ck="YES";
		/*로그인체크*/
		if(!$member_ck){
			if($login_ck=="YES"){
				alert('로그인후 이용하실 수 있습니다.', MARI_HOME_URL.'/?mode=login&url=' . urlencode($_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING']));
			}
		}
		if($type=="w"){
		$sql = "insert into mari_viewcomment
				set loan_id = '$loan_id',
				m_id = '$m_id',
				m_name = '$m_name',
				co_content = '$co_content',
				co_password = '$co_password',
				co_regdatetime = '$date',
				co_ip = '$ip'
				";
		sql_query($sql);
			alert('정상적으로 등록 하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다');
		}

	break;



/************************************************
대출신청 new 1
************************************************/
	case "loan_step1":

	/*제출가능 서류*/
	$i_out_paper = "$out_paper_01|$out_paper_02|$out_paper_03|$out_paper_04|$out_paper_05|$out_paper_06|$out_paper_07|$out_paper_08|$out_paper_09|$out_paper_10|$out_paper_11|";
	$i_ppdocuments="$ppdocuments_01|$ppdocuments_02|$ppdocuments_03|$ppdocuments_04|$ppdocuments_05|$ppdocuments_06";


			if($i_plus_pay_mon_a){
				$i_plus_pay_mon=$i_plus_pay_mon_a;
			}else if($i_plus_pay_mon_b){
				$i_plus_pay_mon=$i_plus_pay_mon_b;
			}else if($i_plus_pay_mon_c){
				$i_plus_pay_mon=$i_plus_pay_mon_c;
			}else if($i_plus_pay_mon_d){
				$i_plus_pay_mon=$i_plus_pay_mon_d;
			}

			/*DTI계산 DTI (월소득/월부채상환금액)*100*/
			if($i_plus_pay_mon && $i_credit_pay){
				$dti_add=ceil ($i_credit_pay/$i_plus_pay_mon*100);
			}
			/*거주지주소*/
			$home_address="".$zip1."-".$zip2." ".$addr1." ".$addr2."";




			/*직장주소*/
			if($zip1r){
				$rectal_address="".$zip1r."-".$zip2r." ".$addr1r." ".$addr2r."";
			}else if($zip1a){
				$rectal_address="".$zip1a."-".$zip2a." ".$addr1a." ".$addr2a."";
			}else if($zip1b){
				$rectal_address="".$zip1b."-".$zip2b." ".$addr1b." ".$addr2b."";
			}else if($zip1c){
				$rectal_address="".$zip1c."-".$zip2c." ".$addr1c." ".$addr2c."";
			}else if($zip1d){
				$rectal_address="".$zip1d."-".$zip2d." ".$addr1d." ".$addr2d."";
			}

			/*직종*/
			if($i_occu_a){
				$i_occu=$i_occu_a;
			}else if($i_occu_b){
				$i_occu=$i_occu_b;
			}else if($i_occu_c){
				$i_occu=$i_occu_c;
			}else if($i_occu_d){
				$i_occu=$i_occu_d;
			}else if($i_occu_e){
				$i_occu=$i_occu_e;
			}

			/*직장명*/
			if($i_company_name_a){
				$i_company_name=$i_company_name_a;
			}else if($i_company_name_b){
				$i_company_name=$i_company_name_b;
			}else if($i_company_name_c){
				$i_company_name=$i_company_name_c;
			}

			/*직장전화&휴대폰*/
			if($i_businesshp_a){
				$i_businesshp=$i_businesshp_a;
			}else if($i_businesshp_b){
				$i_businesshp=$i_businesshp_b;
			}else if($i_businesshp_c){
				$i_businesshp=$i_businesshp_c;
			}else if($i_businesshp_d){
				$i_businesshp=$i_businesshp_d;
			}else if($i_businesshp_e){
				$i_businesshp=$i_businesshp_e;
			}
			/*고용형태*/
			if($i_employment_a){
				$i_employment=$i_employment_a;
			}else if($i_employment_b){
				$i_employment=$i_employment_b;
			}else if($i_employment_c){
				$i_employment=$i_employment_c;
			}else if($i_employment_d){
				$i_employment=$i_employment_d;
			}

			/*근무개월*/
			if($i_company_day_a){
				$i_company_day=$i_company_day_a;
			}else if($i_company_day_b){
				$i_company_day=$i_company_day_b;
			}else if($i_company_day_c){
				$i_company_day=$i_company_day_c;
			}else if($i_company_day_d){
				$i_company_day=$i_company_day_d;
			}

			/*소득금액 월&년*/
			if($i_plus_pay_mon_a && $i_plus_pay_year_a){
				$i_plus_pay_mon=$i_plus_pay_mon_a;
				$i_plus_pay_year=$i_plus_pay_year_a;
			}else if($i_plus_pay_mon_b && $i_plus_pay_year_b){
				$i_plus_pay_mon=$i_plus_pay_mon_b;
				$i_plus_pay_year=$i_plus_pay_year_b;
			}else if($i_plus_pay_mon_c && $i_plus_pay_year_c){
				$i_plus_pay_mon=$i_plus_pay_mon_c;
				$i_plus_pay_year=$i_plus_pay_year_c;
			}else if($i_plus_pay_mon_d && $i_plus_pay_year_d){
				$i_plus_pay_mon=$i_plus_pay_mon_d;
				$i_plus_pay_year=$i_plus_pay_year_d;
			}

			/*사업자명*/
			if($i_businessname_a){
				$i_businessname=$i_businessname_a;
			}else if($i_businessname_b){
				$i_businessname=$i_businessname_b;
			}else if($i_businessname_c){
				$i_businessname=$i_businessname_c;
			}

		if($type=="w"){
		$sql="insert into mari_loan
							set i_payment = '$i_payment',
							i_loan_pay = '$i_loan_pay',
							i_subject = '$i_subject',
							m_id = '$user[m_id]',
							m_name = '$user[m_name]',
							i_birth = '$i_birth',
							m_hp = '$m_hp',
							i_myeonguija = '$i_myeonguija',
							i_businessname = '$i_businessname',
							i_businesshp = '$i_businesshp',
							i_grade = '$i_grade',
							i_once = '$i_once',
							ca_id = '$ca_id',
							i_attendinguse = '$i_attendinguse',
							i_ppdocuments = '$i_ppdocuments',
							i_project_period = '$i_project_period',
							i_officeworkers = '$i_officeworkers',
							i_loan_day = '$i_loan_day',
							i_year_plus = '$i_year_plus',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_auction_day = '$i_auction_day',
							i_purpose = '$i_purpose',
							i_loan_pose = '$i_loan_pose',
							i_plan = '$i_plan',
							i_occu	= '$i_occu',
							i_company_name = '$i_company_name',
							i_company_day = '$i_company_day',
							i_plus_pay_mon = '$i_plus_pay_mon',
							i_plus_pay_year = '$i_plus_pay_year',
							i_out_paper = '$i_out_paper',
							i_wedding = '$i_wedding',
							i_home_many = '$i_home_many',
							i_home_ok = '$i_home_ok',
							i_home_me = '$i_home_me',
							i_home_stay = '$i_home_stay',
							i_car_ok = '$i_car_ok',
							i_pmyeonguija = '$i_pmyeonguija',
							i_newsagency = '$i_newsagency',
							i_veteran = '$i_veteran',
							i_home_address = '$home_address',
							i_rectal_address = '$rectal_address',
							i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_ip = '$ip',
							i_employment = '$i_employment',
							i_level_dti = '$dti_add',
							i_regdatetime = '$date',
							i_sep = '$i_sep',
							i_credit_pay	='$i_credit_pay'";
				sql_query($sql, false);
		goto_url(MARI_HOME_URL."/?mode=loan_step2");
		}else if($type=="m"){
			$sql="update mari_loan
							set m_id = '$user[m_id]',
							m_name = '$user[m_name]',
							i_birth = '$i_birth',
							m_hp = '$m_hp',
							i_myeonguija = '$i_myeonguija',
							i_businessname = '$i_businessname',
							i_businesshp = '$i_businesshp',
							i_grade = '$i_grade',
							i_once = '$i_once',
							ca_id = '$ca_id',
							i_attendinguse = '$i_attendinguse',
							i_ppdocuments = '$i_ppdocuments',
							i_project_period = '$i_project_period',
							i_officeworkers = '$i_officeworkers',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_auction_day = '$i_auction_day',
							i_purpose = '$i_purpose',
							i_occu	= '$i_occu',
							i_company_name = '$i_company_name',
							i_company_day = '$i_company_day',
							i_plus_pay_mon = '$i_plus_pay_mon',
							i_plus_pay_year = '$i_plus_pay_year',
							i_out_paper = '$i_out_paper',
							i_wedding = '$i_wedding',
							i_home_many = '$i_home_many',
							i_home_ok = '$i_home_ok',
							i_home_me = '$i_home_me',
							i_home_stay = '$i_home_stay',
							i_car_ok = '$i_car_ok',
							i_pmyeonguija = '$i_pmyeonguija',
							i_newsagency = '$i_newsagency',
							i_veteran = '$i_veteran',
							i_home_address = '$home_address',
							i_rectal_address = '$rectal_address',
							i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_ip = '$ip',
							i_employment = '$i_employment',
							i_level_dti = '$dti_add',
							i_regdatetime = '$date',
							i_sep = '$i_sep',
							i_credit_pay	='$i_credit_pay'
							where m_id='$user[m_id]' and i_sep = '1'";
					sql_query($sql, false);
		goto_url(MARI_HOME_URL."/?mode=loan_step2");
		}else{
			alert('정상적인 접근이 아닙니다');
		}
	break;




/************************************************
대출신청 new 2
************************************************/
	case "loan_step2":
		/*폴더생성*/
		@mkdir(MARI_DATA_PATH."/photoreviewers", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/photoreviewers", MARI_DIR_PERMISSION);

		$file_img=$_FILES['i_img']['name'];

		/*파일업로드*/
		if(!$file_img==""){
			$img_update="i_img = '".$file_img."',";
			if ($_FILES['i_img']['name']) upload_file($_FILES['i_img']['tmp_name'], $file_img, MARI_DATA_PATH."/photoreviewers");
		}

		if($type=="z"){
			$sql = " update  mari_loan
							set i_sep = '$i_sep2',
							i_payment = '$i_payment',
							i_loan_pay = '$i_loan_pay',
							i_loan_day = '$i_loan_day',
							i_purpose = '$i_purpose',
							i_year_plus = '$i_year_plus',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_subject = '$i_subject',
							i_plan = '$i_plan',
							i_loan_pose = '$i_loan_pose'
							where m_id='$user[m_id]' and i_sep = '1'";
					sql_query($sql);
		goto_url(MARI_HOME_URL."/?mode=loan_step1");
		}else if($type=="o"){

					$sql = " update  mari_loan
							set i_sep = '$i_sep2',
							i_payment = '$i_payment',
							i_loan_pay = '$i_loan_pay',
							i_loan_day = '$i_loan_day',
							i_year_plus = '$i_year_plus',
							i_purpose = '$i_purpose',
							i_repay = '$i_repay',
							".$img_update."
							i_repay_day = '$i_repay_day',
							i_subject = '$i_subject',
							i_plan = '$i_plan',
							i_loan_pose = '$i_loan_pose'
							where m_id='$user[m_id]' and i_sep = '1'";
					sql_query($sql);
		goto_url(MARI_HOME_URL."/?mode=loan_step3");

		}else{
			alert('정상적인 접근이 아닙니다');
		}

	break;


/************************************************
대출신청 new 3
************************************************/
	case "loan_step3":

		if($type=="z"){
			$sql = " update  mari_loan
							set i_sep = '$i_sep2',
							i_payment = '$i_payment',
							i_loan_pay = '$i_loan_pay',
							i_loan_day = '$i_loan_day',
							i_year_plus = '$i_year_plus',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_credit_pay = '$i_credit_pay',
							i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_subject = '$i_subject',
							i_plan = '$i_plan',
							i_step3_ck = 'Y',
							i_loan_pose = '$i_loan_pose'
							where m_id='$user[m_id]' and i_sep = '1'";
					sql_query($sql);
			alert('정상적으로 등록 하였습니다.','?mode=loan_step1');
		}else if($type=="end"){
					$sql = " update  mari_loan
							set i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_step3_ck = 'Y',
							i_credit_pay = '$i_credit_pay'
							where m_id='$user[m_id]' and i_sep = '1'";
					sql_query($sql);

						/*부체내역*/
				$tmp_g_option = array();
				if(count($i_debt_name) > 0)
				{
					for($i=0;$i<count($i_debt_name);$i++)
					{
						if($i_debt_name[$i]!="")

						{
							$tmp_option = "".$i_debt_company[$i]."[FIELD]".$i_debt_name[$i]."[FIELD]".$i_debt_pay[$i]."[FIELD]".$i_debt_kinds[$i]."";
						}
						$tmp_g_option[] = $tmp_option;
					}
					$i_debt_list = implode("[RECORD]",$tmp_g_option);
				}

				if($uptype=="insert"){

						$sql="insert into mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$user[m_id]'
									";
						sql_query($sql);
				}else if($uptype="update"){
						$sql="update mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$user[m_id]'
									where m_id = '$user[m_id]'
									";
						sql_query($sql);
				}
		goto_url(MARI_HOME_URL."/?mode=loan_step4");
		}else{
			alert('정상적인 접근이 아닙니다');
		}

	break;


/************************************************
임시 비밀번호 메일 변경발송
************************************************/
	case "changepassword":

		if($member_ck) {
			alert('이미 로그인 중입니다.');
		}

		$sql = " select * from mari_member where m_id='".$m_email."'";
		$mailck = sql_fetch($sql, false);

		$sql = " select count(*) as cnt from mari_member where m_id = '".$m_email."' ";
		$mailcnt = sql_fetch($sql);

		if(!$mailck){
			alert('요청하신 메일주소가 없습니다.');
		}

		if($mailcnt['cnt'] > 1){
			alert('동일한 메일주소가 있습니다. 고객센터에 문의해 주시기 바랍니다.');
		}
		/*임시비밀번호 난수변환*/
		srand(time());
		$chpassword = rand(100000, 999999);
		/*임시비밀번호 암호화*/
		$m_pwcertify = hash('sha256',$chpassword);


		/*임시 비밀번호 암호화 형태로 발급*/
		$sql="update mari_member
					set m_pwcertify ='".$m_pwcertify."'
					where m_id = '".$m_email."'
				";
		sql_query($sql);


		$mailchhref = MARI_HOME_URL.'/?mode=login&m_id='.$mailck['m_id'].'&chpassword='.$chpassword;

		$mailsubject = "[".$config[c_title]."] 임시비밀번호 안내메일 입니다.";

		$mailcontent = "";
		$mailcontent .= '['.$config[c_title].'] 임시비밀번호 안내메일입니다.';
		$mailcontent .= '<br /><br />';
		$mailcontent .= '임시비밀번호 : '.$chpassword.'';
		$mailcontent .= '<br /><br />';
		$mailcontent .= '아래의 링크로 접속하면 임시비밀번호로 변경됩니다.<br /><br />';
		$mailcontent .= ''.$mailchhref.'';
		$mailcontent .= '<br /><br /><br />';
		$mailcontent .= '----------------------------------------------<br />';
		$mailcontent .= ''.$config[c_title].'<br />';
		$mailcontent .= '----------------------------------------------<br />';


		mail_ok($mailck['m_name'], $mailck['m_id'], $mailck['m_id'], $mailsubject, $mailcontent, 1);

		alert('가입시 등록하신'.$mailck[m_id].' 메일로 임시 비밀번호가 발송되었습니다.');


	break;




/****************************************************************************
투자 알림 신청 2017-02-03 임근호
설명 : 알림신청시 투자진행설정에서 투자시자설정후 신청자에게 추가발송 됨
****************************************************************************/
	case "push_send":

	$sql = " select * from mari_push where p_email='".$m_email."' or p_hp='".$m_hp."' and p_push_use='Y'";
	$pushck = sql_fetch($sql, false);

	$sql = " select count(*) as cnt from mari_push where p_email = '".$m_email."' or p_hp='".$m_hp."' and p_push_use='Y'";
	$pushcnt = sql_fetch($sql);

	/*푸시설정 동의시*/
	if($type=="push_yes"){


		if($pushcnt['cnt'] > 1){

			/*푸쉬테이블에서 해당정보 알림받게끔 UPDATE*/
			$sql = " update mari_push set  p_push_use='Y' where p_hp='".$m_hp."' or p_email='".$m_email."'";
			sql_query($sql);

			alert('신청내역중 동일한 메일주소 또는 휴대폰번호가 이미 존재합니다. 기존에 해제처리시 알림신청 상태로 변경 됩니다.');
		}

		/*비회원일경우 guest*/
		if(!$member_ck){
			$m_name="guest";
		}else{
			$m_name=$user['m_name'];
		}
		/*신청내용 INSERT*/
		$sql="insert into mari_push
					set m_id ='".$m_id."',
					m_name = '".$m_name."',
					p_email = '".$m_email."',
					p_hp = '".$m_hp."',
					p_regdatetime = '".$date."',
					p_push_use = 'Y'";
		sql_query($sql);


		alert('등록하신'.$m_hp.' '.$m_email.' 의 알림설정이 정상적으로 설정 되었습니다 .');

	}else if($type=="push_no"){

		/*회원인경우*/
		if($m_id){

			/*푸쉬테이블에서 해당정보 삭제*/
			$sql = " update mari_push set  p_push_use='N' where m_id='".$m_id."' and p_hp='".$m_hp."' or p_email='".$m_email."'";
			sql_query($sql);

		/*비회원인경우*/
		}else{

			/*푸쉬테이블에서 해당정보 삭제*/
			$sql = " update mari_push set  p_push_use='N' where p_hp='".$m_hp."' or p_email='".$m_email."'";
			sql_query($sql);

		}

		alert('등록하신'.$m_hp.' '.$m_email.' 의 알림설정이 해지 되었습니다 .');

	}



	break;

/************************************************
자동분산투자 신청 170308 -동욱-
************************************************/
	case "auto_application":

		/*콤마제거*/
		$au_pay = (string)$au_pay;
		$au_pay = preg_replace("/[^0-9]/", "",$au_pay);
		$au_pay = (int)$au_pay;

		$au_rec_pay = $rec_pay_01."|".$rec_pay_02."|".$rec_pay_03;

		$au_term = $term_01."|".$term_02."|".$term_03;

		$au_give_way = $give_way_01."|".$give_way_02."|".$give_way_03;

		$au_portfolio = $portfolio_01."|".$portfolio_02."|".$portfolio_03;

		$au_grade = $grade_01."|".$grade_02."|".$grade_03;

		$au_product = $product_01."|".$product_02."|".$product_03;


		if($type=="w"){
			$sql = "insert into mari_auto_info
					set m_id = '$user[m_id]',
					m_name='$user[m_name]',
					au_pay = '$au_pay',
					au_iyul = '$au_iyul',
					au_rec_pay = '$au_rec_pay',
					au_term = '$au_term',
					au_give_way = '$au_give_way',
					au_portfolio = '$au_portfolio',
					au_grade = '$au_grade',
					au_product = '$au_product',
					au_regidate = '$date'
					";
			sql_query($sql);
			alert('자동분산투자가 설정되었습니다.');
		}else if($type=="m"){
			$sql = "update mari_auto_info
					set au_pay = '$au_pay',
					au_iyul = '$au_iyul',
					au_rec_pay = '$au_rec_pay',
					au_term = '$au_term',
					au_give_way = '$au_give_way',
					au_portfolio = '$au_portfolio',
					au_grade = '$au_grade',
					au_product = '$au_product'
					";
			sql_query($sql);
			alert('정상적으로 수정되었습니다.');
		}

	break;





}//user switch






/****************************************************************************************************************
ADMIN SQL START
*****************************************************************************************************************/
switch ($update){


/************************************************
ADMIN MAINPAGE
************************************************/
	case "admin":


		if($type=="pg"){
			$sql="update mari_pg
						set i_pg_use = '$i_pg_use'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="fb"){
			$sql="update mari_config
						set c_facebooklogin_use = '$c_facebooklogin_use'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="sms"){
			$sql="update mari_config
						set c_sms_use = '$c_sms_use'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="ipn"){
			$sql="update mari_config
						set c_cert_ipin = '$c_cert_ipin'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="hp"){
			$sql="update mari_config
						set c_cert_use = '$c_cert_use'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="pop"){
			$sql="update mari_popup
						set po_openchk = '$po_openchk'  order by po_start_date desc limit 1";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else if($type=="nice"){
			$sql="update mari_config
						set c_nice_use = '$c_nice_use'";
			sql_query($sql);
		goto_url(MARI_HOME_URL."/?cms=admin");
		}else{
		alert('정상적인 접근이 아닙니다.');
		exit;
		}
	break;
/************************************************
SEO설정
************************************************/
	case "seo_config":


		$sql = "update mari_config
					set c_title          = '$c_title',
						c_dot_type         = '$c_dot_type',
						c_analytics         = '$c_analytics',
						compatible         = '$compatible',
						c_add_meta         = '$c_add_meta'
						";
		sql_query($sql, false);


		alert('정상적으로 설정되었습니다.');


	break;


/************************************************
페이지 보안설정
************************************************/

	case "page_security":

		$sql = "update mari_config
					set right_mouse          = '$right_mouse',
						page_notdrag         = '$page_notdrag',
						frame_url         = '$frame_url'
						";
		sql_query($sql, false);


		alert('정상적으로 설정되었습니다.');


	break;


/************************************************
파비콘 설정
************************************************/

	case "favicon":

	if($type=="fv"){
		@mkdir(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);

		$bn_bimg=$_FILES['bn_bimg']['name'];

		/*파일업로드*/
		if(!$bn_bimg==""){
			$img_update="bn_id	 = '".$bn_bimg."'";
			if ($_FILES['bn_bimg']['name']) upload_file($_FILES['bn_bimg']['tmp_name'], $bn_bimg, MARI_DATA_PATH."/favicon");
		}

		/*file 삭제*/
		if($bn_bimg_del=="1"){
			$img_update="bn_id	 = ''";
			@unlink(MARI_DATA_PATH."/favicon/".$config[bn_id]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['bn_id'])) {
				delete_board_thumbnail('favicon', $config['bn_id']);
			}
		}

		$sql = " update  mari_config
					set ".$img_update."";
		sql_query($sql);
		alert('정상적으로 등록 하였습니다.','?cms=favicon');

	}else if($type=="lo"){

		@mkdir(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);

		$bn_bimg_01=$_FILES['bn_bimg_01']['name'];

		/*파일업로드*/
		if(!$bn_bimg_01==""){
			$img_update="c_logo	 = '".$bn_bimg_01."'";
			if ($_FILES['bn_bimg_01']['name']) upload_file($_FILES['bn_bimg_01']['tmp_name'], $bn_bimg_01, MARI_DATA_PATH."/favicon");
		}

		/*file 삭제*/
		if($bn_bimg_del_01=="1"){
			$img_update="c_logo	 = ''";
			@unlink(MARI_DATA_PATH."/favicon/".$config[c_logo]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['c_logo'])) {
				delete_board_thumbnail('favicon', $config['c_logo']);
			}
		}

				$sql = " update  mari_config
							set ".$img_update."";
					sql_query($sql);
				alert('정상적으로 등록 하였습니다.','?cms=favicon');
	}else if($type=="lobt"){

		@mkdir(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/favicon", MARI_DIR_PERMISSION);

		$bn_bimg_02=$_FILES['bn_bimg_02']['name'];

		/*파일업로드*/
		if(!$bn_bimg_02==""){
			$img_update="c_logo_bt	 = '".$bn_bimg_02."'";
			if ($_FILES['bn_bimg_02']['name']) upload_file($_FILES['bn_bimg_02']['tmp_name'], $bn_bimg_02, MARI_DATA_PATH."/favicon");
		}

		/*file 삭제*/
		if($bn_bimg_del_01=="1"){
			$img_update="c_logo_bt	 = ''";
			@unlink(MARI_DATA_PATH."/favicon/".$config[c_logo_bt]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['c_logo_bt'])) {
				delete_board_thumbnail('favicon', $config['c_logo_bt']);
			}
		}

				$sql = " update  mari_config
							set ".$img_update."";
					sql_query($sql);
				alert('정상적으로 등록 하였습니다.','?cms=favicon');
	}else if($type=="main"){


		@mkdir(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);

		$main_img1=$_FILES['c_main_img1']['name'];
		$main_img2=$_FILES['c_main_img2']['name'];
		$main_img3=$_FILES['c_main_img3']['name'];

		if(!$main_img1==""){
			$img_update_01="c_main_img1	 = '".$main_img1."', ";
			if ($_FILES['c_main_img1']['name']) upload_file($_FILES['c_main_img1']['tmp_name'], $main_img1, MARI_DATA_PATH."/favicon");
		}
		if(!$main_img2==""){
			$img_update_02="c_main_img2	 = '".$main_img2."',";
			if ($_FILES['c_main_img2']['name']) upload_file($_FILES['c_main_img2']['tmp_name'], $main_img2, MARI_DATA_PATH."/favicon");
		}
		if(!$main_img3==""){
			$img_update_03="c_main_img3	 = '".$main_img3."',";
			if ($_FILES['c_main_img3']['name']) upload_file($_FILES['c_main_img3']['tmp_name'], $main_img3, MARI_DATA_PATH."/favicon");
		}

		/*file 삭제*/
		if($d_main_01=="1"){
			$img_update_01="c_main_img1	 = '',";
			@unlink(MARI_DATA_PATH."/favicon/".$config[c_main_img1]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['c_main_img1'])) {
				delete_board_thumbnail('favicon', $config['c_main_img1']);
			}
		}
		if($d_main_02=="1"){
			$img_update_02="c_main_img2	 = '',";
			@unlink(MARI_DATA_PATH."/favicon/".$config[c_main_img2]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['c_main_img2'])) {
				delete_board_thumbnail('favicon', $config['c_main_img2']);
			}
		}
		if($d_main_03=="1"){
			$img_update_03="c_main_img3	 = '',";
			@unlink(MARI_DATA_PATH."/favicon/".$config[c_main_img3]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $config['c_main_img3'])) {
				delete_board_thumbnail('favicon', $config['c_main_img3']);
			}
		}

		$sql = " update  mari_config
				set ".$img_update_01."
				".$img_update_02."
				".$img_update_03."
				c_nice_use = '".$config['c_nice_use']."'
				";
		sql_query($sql);

		alert('정상적으로 등록 하였습니다.','?cms=favicon');

	}else{
		alert('정상적인 접근이 아닙니다.');
		exit;
	}

	break;

/************************************************
회원가입 관리
************************************************/
	case "member_form":

		/*콤마제거*/
		$m_emoney = (string)$m_emoney;
		$m_emoney = preg_replace("/[^0-9]/", "",$m_emoney);
		$m_emoney = (int)$m_emoney;

		/*휴대폰번호 합침*/
		$m_hp="".$hp1."".$hp2."".$hp3."";
		$m_birth="".$birth1."-".$birth2."-".$birth3."";
		//$m_zip="".$m_zip1."".$m_zip2."";
		$m_tel="".$tel1."".$tel2."".$tel3."";
		$m_reginum="".$reginum1."".$reginum2."";
		if($m_tel=="선택"){
			$m_tel = "";
		}
		if($m_hp =="선택" || $m_hp =="010" || $m_hp == "011" || $m_hp == "016" || $m_hp == "017" || $m_hp == "019"){
			$m_hp = "";
		}
		/*페스워드가 있을경우에만*/
		if(!$m_password==""){
			$pw_yes="m_password = '".hash('sha256',$m_password)."',";
		}
		if($type=="w"){

			/*중복체크*/

			if ($m_id=="admin" || $m_id=="ADMIN"  || $m_id=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($m_name=="최고관리자" || $m_name=="관리자"  || $m_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');

			if ($m_nick=="최고관리자" || $m_nick=="관리자"  || $m_nick=="운영자" )
				alert('사용하실 수 없는 닉네임 입니다.\\n 다른 닉네임을 이용하여 주십시오.');

			$mb = get_member($m_id);
			if ($mb['m_id'])
				alert('이미 존재하는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.\\nＩＤ : '.$mb['m_id']);

			// 닉네임중복체크
			/*
			$sql = "select m_nick mari_member where m_nick='$m_nick'";
			$row = sql_fetch($sql);
			if ($row['m_id'])
				alert('이미 존재하는 닉네임 입니다.\\n 다른 닉네임을 이용하여 주십시오.\\n닉네임 : '.$row['m_nick']);
			*/
			// 이메일중복체크
			/*
			$sql = " select m_email from mari_member where m_email = '$m_email' ";
			$row = sql_fetch($sql);
			if ($row['m_id'])
				alert('이미 존재하는 이메일 입니다.\\n 다른 이메일을 이용하여 주십시오.\\n메일 : '.$row['m_email']);
			*/

			/*insert*/
				$sql = " insert into mari_member
							set m_id = '$m_id',
							".$pw_yes."
							m_name = '$m_name',
							m_nick = '$m_nick',
							m_email = '$m_email',
							m_homepage = '$m_homepage',
							m_password_q = '',
							m_password_a = '',
							m_level = '$m_level',
							m_sex = '$m_sex',
							m_tel = '$m_tel',
							m_hp = '$m_hp',
							m_sms = '$m_sms',
							m_mailling = '$m_mailling',
							m_zip = '$m_zip',
							m_addr1 = '$m_addr1',
							m_addr2 = '$m_addr2',
							m_emoney = '$m_emoney',
							m_profile	 = '',
							m_memo_call = '$m_memo_call',
							m_memo_cnt = '',
							m_datetime = '$date',
							m_ip = '$ip',
							m_blindness = '$m_blindness',
							m_my_bankcode = '$m_my_bankcode',
							m_my_bankacc = '$m_my_bankacc',
							m_my_bankname = '$m_my_bankname',
							m_business_type = '$m_business_type',
							m_ipin = '$m_ipin',
							m_joinpath = '$m_joinpath',
							m_companynum = '$m_companynum',
							m_company_name = '$m_company_name',
							m_signpurpose = '$m_signpurpose',
							m_reginum = '$m_reginum',
							m_newsagency = '$m_newsagency',
							m_with_zip = '$m_with_zip',
							m_with_addr1 = '$m_with_addr1',
							m_with_addr2 = '$m_with_addr2',

							m_referee ='$m_referee'";
					sql_query($sql);

					/*현재 추가된 아이디 셀렉*/
					$sql = "select * from mari_member order by m_no desc limit 1";
					$lately = sql_fetch($sql, false);

					if($m_emoney){
							/*포인트지급내용 저장*/
							$sql = " insert into mari_emoney
										set m_id = '$m_id',
										p_datetime = '$date',
										p_content = '관리자에서 지급',
										p_emoney = '$m_emoney',
										p_ip = '$ip',
										p_top_emoney = '$m_emoney'";
							sql_query($sql);
					}


				alert('정상적으로 추가 되었습니다.','?cms=member_list');
		}else if($type=="m"){

			/*e-money내역리스트 추가*/
				$sql = "select * from mari_member where m_no = '$m_no'";
				$add = sql_fetch($sql, false);

					if($add[m_emoney] != $m_emoney){

						if($add[m_emoney] < $m_emoney){
							$emoney =  $m_emoney - $add[m_emoney];

							/*포인트지급내용 저장*/
								$sql = " insert into mari_emoney
											set m_id = '$m_id',
											p_datetime = '$date',
											p_content = '관리자에서 지급',
											p_emoney = '$emoney',
											p_ip = '$ip',
											p_top_emoney = '$m_emoney'";
								sql_query($sql);
						}else{
								$emoney = $add[m_emoney] - $m_emoney;

							/*포인트지급내용 저장*/
								$sql = " insert into mari_emoney
											set m_id = '$m_id',
											p_datetime = '$date',
											p_content = '관리자에서 차감',
											p_emoney = '$emoney',
											p_ip = '$ip',
											p_top_emoney = '$m_emoney'";
								sql_query($sql);
						}
					}
			/*update*/
				$sql = " update  mari_member
							set m_id = '$m_id',
							".$pw_yes."
							m_name = '$m_name',
							m_nick = '$m_nick',
							m_email = '$m_email',
							m_homepage = '$m_homepage',
							m_password_q = '',
							m_password_a = '',
							m_level = '$m_level',
							m_sex = '$m_sex',
							m_sms = '$m_sms',
							m_tel = '$m_tel',
							m_hp = '$m_hp',
							m_mailling = '$m_mailling',
							m_zip = '$m_zip',
							m_addr1 = '$m_addr1',
							m_addr2 = '$m_addr2',
							m_emoney = '$m_emoney',
							m_profile	 = '',
							m_memo_call = '$m_memo_call',
							m_memo_cnt = '',
							m_blindness = '$m_blindness',
							m_ipin = '$m_ipin',
							m_joinpath = '$m_joinpath',
							m_my_bankcode = '$m_my_bankcode',
							m_business_type = '$m_business_type',
							m_my_bankacc = '$m_my_bankacc',
							m_my_bankname = '$m_my_bankname',
							m_signpurpose = '$m_signpurpose',
							m_companynum = '$m_companynum',
							m_company_name = '$m_company_name',
							m_referee ='$m_referee',
							m_reginum = '$m_reginum',
							m_newsagency = '$m_newsagency',
							m_with_zip = '$m_with_zip',
							m_with_addr1 = '$m_with_addr1',
							m_with_addr2 = '$m_with_addr2'
							where m_no='$m_no'";
					sql_query($sql);

					/*발급여부확인*/
			$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
			$seyfck = sql_fetch($sql, false);

			/*발급된 키중 같은 번호가 존재하는지 확인*/
			$sql = "select phoneNo from mari_seyfert where phoneNo = '$m_hp'";
			$seyfck_no = sql_fetch($sql, false);

			if(($m_id != trim($m_id)) || strpos($m_id, ' ')){
				alert('아이디에 공백이 존재합니다. 공백을 삭제한 후에 다시 시도해주시기 바랍니다.');
				exit;
			}else if(($m_name != trim($m_name)) || strpos($m_name, ' ')){
				alert('이름에 공백이 존재합니다. 공백을 삭제한 후에 다시 시도해주시기 바랍니다.');
				exit;
			}

			//같은 휴대폰번호로 발급된 키가 있는지 조회
			if($seyfck[phoneNo] == $m_hp){
			}else{
				if($seyfck_no[phoneNo] == $m_hp){
					alert('이미 같은 번호로 발급된 멤버키가 존재합니다. 다른번호로 변경한 후에 다시 시도해주시기바랍니다.');
					exit;
				}
			}

			/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){

				/*데이터 암호화 복호화 플러그인 start*/
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*•해당값을 encReq 에 바인딩 하고 reqMemGuid 과 _method 를 추가*/




			/*정보수정시 휴대폰번호가 다른경우 seyfck phoneNo 변경되도록 추가 2016-10-07 임근호*/
			if($seyfck['phoneNo']==$m_hp){
			}else{


						/*페이게이트 정산nonce체크시 숫자변경*/
						$modify_code = "M".time().rand(111,999);
						/*발급여부확인*/
						$sql = "select  * from mari_member where m_id='$m_id'";
						$memseyfck = sql_fetch($sql, false);


						$ENCODE_PARAMS_modify="&_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&_lang=ko&dstMemGuid=".$seyfck[s_memGuid]."&nonce=".$modify_code."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE&addrss1=".urlencode($memseyfck[m_addr1])."&city=SEOUL&addrssCntryCd=KOR&firstname=".urlencode($user[m_name])."&lastname=".urlencode($m_name)."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS_modify, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString_modify = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						$requestPath_modify = "https://v5.paygate.net/v5a/member/allInfo?".$requestString_modify;

						$curl_handle_modify = curl_init();
						//$ENCODE_PARAMS_modify = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS_modify);
						curl_setopt($curl_handle_modify, CURLOPT_URL, $requestPath_modify);
						/*curl_setopt($curl_handle_modify, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle_modify, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle_modify, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle_modify, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle_modify, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/allInfo');
						$result_modify = curl_exec($curl_handle_modify);
						curl_close($curl_handle_modify);
						/*파싱*/
						$decode_modify = json_decode($result_modify, true);

						/*
						print_r($decode_modify);
						print_r($requestPath_modify);
						echo"<br/><br/>";
						print_r($result_modify);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_modify);
						echo"<br/><br/>";
						print_r($decode_modify);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode_modify)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode_modify as $key=>$value){
							$emailAddrss=$value['emailAddrss'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='".$m_id."' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){
									$sql = " update mari_seyfert
												set phoneNo='$m_hp',
												s_ip='$ip',
												s_redatetime='$date' where m_id='".$seyck[m_id]."'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}


				}

			}

				alert('정상적으로 수정 하였습니다.');
		}else if($type=="d"){
			/*회원정보 찾기*/
				$sql = " select * from mari_member where m_no='".$m_no."'";
				$leave = sql_fetch($sql, false);

			/*회원탈퇴 테이블에 정보저장*/
				$sql = " insert into mari_member_leave
							set s_id = '$leave[m_id]',
							s_password = '$leave[m_password]',
							s_name = '$leave[m_name]',
							s_email = '$leave[m_email]',
							s_level = '$leave[m_level]',
							s_sex = '$leave[m_sex]',
							s_tel = '$leave[m_tel]',
							s_hp = '$leave[m_hp]',
							s_zip = '$leave[m_zip]',
							s_addr1 = '$leave[m_addr1]',
							s_addr2 = '$leave[m_addr2]',
							s_emoney = '$leave[m_emoney]',
							s_datetime = '$leave[m_datetime]',
							s_ip = '$ip',
							s_reason = '$s_reason',
							s_leave_date = '$date'";
					sql_query($sql);


			/*회원테이블에서 해당회원 삭제*/
				$sql = " delete from mari_member where m_no='".$m_no."'   ";
				sql_query($sql);
		alert('정상적으로 탈퇴처리 하였습니다.','?cms=member_list');

		}else if($type=="c"){
			/*yes intercept*/
				$sql = "update mari_member set m_intercept_date='".$date."' where m_no='".$m_no."'";
				sql_query($sql);
		alert('정상적으로 차단 하였습니다. \\n 차단해제시 [차단해제] 버튼을 눌러 해제하실 수 있습니다.');
		}else if($type=="cn"){
			/*no intercept*/
				$sql = " update mari_member set m_intercept_date='' where m_no='".$m_no."'";
				sql_query($sql);
		alert('정상적으로 차단해제 하였습니다.');
		}else{
		alert('정상적인 접근이 아닙니다.');
		exit;
		}
	break;

/************************************************
나의 서비스관리
************************************************/
	case "service_config":
		$sql = " update mari_mysevice_config
					set license_key          = '$license_key',
						ftp_host         = '$ftp_host',
						ftp_id         = '$ftp_id',
						ftp_pw         = '$ftp_pw',
						sale_code         = '$sale_code',
						service_name         = '$service_name',
						service_start_time         = '$service_start_time',
						service_end_time         = '$service_end_time',
						extension_methods         = '$extension_methods',
						service_ver         = '$service_ver',
						domain_url         = '$domain_url'
						";
		sql_query($sql);

		alert('정상적으로 설정되었습니다.');
	break;

/************************************************
회원리스트 수정,삭제
************************************************/

	case "member_list":
		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}
		if ($add_bt == "선택수정") {
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];

				/*콤마제거*/
				$m_emoney[$k] = (string)$m_emoney[$k];
				$m_emoney[$k] = preg_replace("/[^0-9]/", "",$m_emoney[$k]);
				$m_emoney[$k] = (int)$m_emoney[$k];

				/*e-money내역리스트 추가*/
				$sql = "select * from mari_member where m_id = '$m_id[$k]'";
				$add = sql_fetch($sql, false);

					if($add[m_emoney] != $m_emoney[$k]){

						if($add[m_emoney] < $m_emoney[$k]){
							$emoney =  $m_emoney[$k] - $add[m_emoney];

							/*포인트지급내용 저장*/
								$sql = " insert into mari_emoney
											set m_id = '$m_id[$k]',
											p_datetime = '$date',
											p_content = '관리자에서 지급',
											p_emoney = '$emoney',
											p_ip = '$ip',
											p_top_emoney = '$m_emoney[$k]'";
								sql_query($sql);
						}else{
								$emoney = $add[m_emoney] - $m_emoney[$k];

							/*포인트지급내용 저장*/
								$sql = " insert into mari_emoney
											set m_id = '$m_id[$k]',
											p_datetime = '$date',
											p_content = '관리자에서 차감',
											p_emoney = '$emoney',
											p_ip = '$ip',
											p_top_emoney = '$m_emoney[$k]'";
								sql_query($sql);
						}
					}

				$sql = " update mari_member
								set m_emoney = '$m_emoney[$k]'
								where m_id = '$m_id[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_member where m_id='".$m_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 탈퇴처리 하였습니다.');
		}

	break;

/************************************************
회원등급 리스트
************************************************/

	case "member_grade":
		/*수정모드*/
		if($type=="m"){

					$sql = " update mari_level
								set lv_name = '$lv_name',
									 lv_level = '$lv_level'
									 where lv_id = '$lv_id'";
						sql_query($sql);


			alert("수정 하였습니다.");
		/*작성모드*/
		}else if($type=="w"){
					$sql = " insert into mari_level
								set lv_name = '$lv_name',
									 lv_level = '$lv_level'";
						sql_query($sql);


			alert("정상적으로 등록 하였습니다.");
		/*삭제모드*/
		}else if($type=="d"){
					$sql = "delete from mari_level where lv_id='$lv_id'";
						sql_query($sql);
			alert('정상적으로 삭제 하였습니다.');

		}else{
			alert("정상적인 접근이 아닙니다.");
		}
	break;


/************************************************
탈퇴회원 리스트& 탈퇴회원 회원으로 복구처리
************************************************/

	case "leave_list":
		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}
		if ($add_bt == "선택복구") {
			for ($i=0; $i<count($check); $i++)
			{
			$k = $check[$i];
			/*탈퇴 회원정보 찾기*/
				$sql = " select * from mari_member_leave where s_id='$s_id[$k]'";
				$leave = sql_fetch($sql, false);

			/*회원 테이블에 정보복구및 저장*/
				$sql = " insert into mari_member
							set m_id = '$leave[s_id]',
							m_password = '$leave[s_password]',
							m_name = '$leave[s_name]',
							m_email = '$leave[s_email]',
							m_level = '$leave[s_level]',
							m_sex = '$leave[s_sex]',
							m_tel = '$leave[s_tel]',
							m_hp = '$leave[s_hp]',
							m_zip = '$leave[s_zip]',
							m_addr1 = '$leave[s_addr1]',
							m_addr2 = '$leave[s_addr2]',
							m_emoney = '$leave[s_emoney]',
							m_datetime = '$leave[s_datetime]',
							m_ip = '$ip',
							m_leave_date = '$date'";
					sql_query($sql);

			/*복구완료후 탈퇴회원테이블에서 삭제*/
					$sql = "delete from mari_member_leave where s_id='$s_id[$k]'";
					sql_query($sql);
			}
		alert('정상적으로 복구처리 하였습니다.');

		}else if ($add_bt == "선택삭제") {
				for ($i=0; $i<count($check); $i++)
				{
				$k = $check[$i];

				/* 삭제*/
						$sql = "delete from mari_member_leave where s_id='$s_id[$k]'";
						sql_query($sql);

						/*2017.09.26 seyfert 및 seyfert_loan의 DB삭제    이경희*/
						$sql = " delete from mari_seyfert where m_id='".$s_id[$k]."'";
						sql_query($sql);

						//$sql = " delete from mari_seyfert_loan where m_id='".$s_id[$k]."'";
						//sql_query($sql);

				}

			alert('정상적으로 삭제처리 하였습니다.');

		}else{
		alert('정상적인 접근이 아닙니다.');
		}

	break;

/************************************************
포인트 리스트 & 지급관리
************************************************/

	case "emoney_list":

		/*콤마제거*/
		$p_emoney = (string)$p_emoney;
		$p_emoney = preg_replace("/[^0-9]/", "",$p_emoney);
		$p_emoney = (int)$p_emoney;

		if($type=="w"){
			/*탈취 해킹방지를위해 IP가 있는지 검사*/
			if(!$ip){
				alert('경고! 해킹이 감지 되었습니다.');
				exit;
			}
			/*숫자만 입력 했는지 검사*/
			if (preg_match("/[^0-9]/i", $p_emoney)) {
				alert('숫자만 입력 가능합니다..');
				exit;
			}
			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='$m_id'";
				$em = sql_fetch($sql, false);
			/*아이디 체크*/
			if(!$em['m_id']){
				alert('아이디가 존재하지 않습니다.');
				exit;
			}
			/*포인트 합산*/
				$p_top_emoney=$p_emoney+$em['m_emoney'];
			/*포인트지급내용 저장*/
				$sql = " insert into mari_emoney
							set m_id = '$em[m_id]',
							p_datetime = '$date',
							p_content = '$p_content',
							p_emoney = '$p_emoney',
							p_ip = '$ip',
							p_top_emoney = '$p_top_emoney'";
				sql_query($sql);

			/*회원에게 포인트지급*/
				$sql = " update mari_member
							set m_emoney = '$p_top_emoney'
							where m_id = '$m_id'";
				sql_query($sql);

			alert('정상적으로 e-머니를 지급하였습니다.');
		}else if($type=="d"){
			if (!count($check)) {
				alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
			}
			if ($add_bt == "선택삭제") {
				for ($i=0; $i<count($check); $i++)
				{
				$k = $check[$i];

				/* 삭제*/
						$sql = "delete from mari_emoney where p_id='$p_id[$k]'";
						sql_query($sql);
				}
			alert('정상적으로 삭제처리 하였습니다.');
			}else{
			alert('정상적인 접근이 아닙니다.');
			}
		}else{
		alert('정상적인 접근이 아닙니다.');
		}

	break;


/************************************************
메일발송 리스트 (삭제)
************************************************/

	case "mail_list":

			if ($add_bt == "선택삭제") {

				if (!count($check)) {
					alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
				}
				for ($i=0; $i<count($check); $i++)
				{
				$k = $check[$i];

				/* 삭제*/
						$sql = "delete from mari_mail where mr_id='$mr_id[$k]'";
						sql_query($sql);
				}
			alert('정상적으로 삭제처리 하였습니다.');
			}else if($type="d"){
					$sql = " delete from mari_mail where mr_id='".$id."'   ";
					sql_query($sql);
			alert('정상적으로 삭제처리 하였습니다.');
			}else{
			alert('정상적인 접근이 아닙니다.');
			}

	break;


/************************************************
메일발송 내용작성
************************************************/


	case "mail_form":
		if($type=="w"){
			$sql = "insert into mari_mail
						set mr_subject = '$mr_subject',
						mr_content = '$mr_content',
						mr_regtime = '$date',
						mr_ip = '$ip'";
				sql_query($sql);
				alert('정상적으로 저장 하였습니다.','?cms=mail_list');
		}else if($type=="m"){

				$sql = "update mari_mail
							set mr_subject = '$mr_subject',
							mr_content = '$mr_content',
							mr_regtime = '$date',
							mr_ip = '$ip'
							where mr_id='$mr_id'";
				sql_query($sql);
				alert('정상적으로 수정 하였습니다.');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;



/************************************************
SMS예약발송
************************************************/

	case "reservation_send":

		/*오늘날짜*/
		$timetoday = mktime();
		$date = date("Y-m-d H:i:s", $timetoday);

		$sms_no=$_POST['sms_no']; //SMS번호
		$sms_type_02=$_POST['sms_type_02']; //일반회원
		$sms_subject=$_POST['sms_subject']; //제목
		$sms_content=$_POST['sms_content']; //내용
		$sms_date=$_POST['sms_date']; //날짜
		$sms_time_01=$_POST[sms_time];
		$sms_time_02=$_POST[sms_time_01];
		$sms_time="".$_POST[sms_time]."".$_POST[sms_time_01]."000"; //시간,분




		$sql = "select * from mari_member where  m_level='".$mem_type_02."'";
		$send = sql_query($sql, false);

		/*수정모드*/
		if($mode=="send"){
		/*문자길이 확인*/
		$message_msg=mb_strlen("".$_POST[sms_content]."", "CP949");

		if($message_msg <=77){
			/*SMS*/
			$sms_type="S";
		}else{
			/*LMS*/
			$sms_type="L";
		}

		/*발송성공시 저장*/
					$sql = " update mari_sms_send
								set sms_time = '$sms_time_01',
									sms_time_01 = '$sms_time_02',
									sms_date = '$sms_date',
									sms_type_02 = '$sms_type_02',
									sms_datetime = '$date',
									sms_subject = '$sms_subject',
									sms_content = '$sms_content',
									sms_yes = 'Y',
									sms_type='$sms_type'
									where sms_no = '$sms_no'";
					sql_query($sql);



		for ($i=0;  $sdate=sql_fetch_array($send); $i++) {

						   /******************** 인증정보 ********************/
							$sms_url = "http://sslsms.cafe24.com/sms_sender.php"; // 전송요청 URL
							// $sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // HTTPS 전송요청 URL
							$sms['user_id'] = base64_encode(""); //SMS 아이디.
							$sms['secure'] = base64_encode("") ;//인증키
							$sms['msg'] = base64_encode(stripslashes($_POST['sms_content']));
							if($sms_type == 'L') {
								$sms['subject'] = base64_encode($_POST['sms_subject']); //제목
							}

							$sms['rphone'] = base64_encode($sdate['m_hp']);
							$sms['sphone1'] = base64_encode($_POST['sphone1']);
							$sms['sphone2'] = base64_encode($_POST['sphone2']);
							$sms['sphone3'] = base64_encode($_POST['sphone3']);
							$sms['rdate'] = base64_encode($sms_date);//예약날짜
							$sms['rtime'] = base64_encode($sms_time);//예약시간
							$sms['mode'] = base64_encode("1"); // base64 사용시 반드시 모드값을 1로 주셔야 합니다.
							$sms['returnurl'] = base64_encode($_POST['returnurl']);
							$sms['testflag'] = base64_encode($_POST['testflag']);
							$sms['destination'] = base64_encode($_POST['destination']);
							$returnurl = $_POST['returnurl'];
							$sms['repeatFlag'] = base64_encode($_POST['repeatFlag']);
							$sms['repeatNum'] = base64_encode($_POST['repeatNum']);
							$sms['repeatTime'] = base64_encode($_POST['repeatTime']);
							$sms['smsType'] = base64_encode($sms_type); // LMS일경우 L

							$nointeractive = $_POST['nointeractive']; //사용할 경우 : 1, 성공시 대화상자(alert)를 생략

							$host_info = explode("/", $sms_url);
							$host = $host_info[2];
							$path = $host_info[3];

							srand((double)microtime()*1000000);
							$boundary = "---------------------".substr(hash('sha256',rand(0,32000)),0,10);
							//print_r($sms);

							// 헤더 생성
							$header = "POST /".$path ." HTTP/1.0\r\n";
							$header .= "Host: ".$host."\r\n";
							$header .= "Content-type: multipart/form-data, boundary=".$boundary."\r\n";

							// 본문 생성
							foreach($sms AS $index => $value){
								$data .="--$boundary\r\n";
								$data .= "Content-Disposition: form-data; name=\"".$index."\"\r\n";
								$data .= "\r\n".$value."\r\n";
								$data .="--$boundary\r\n";
							}
							$header .= "Content-length: " . strlen($data) . "\r\n\r\n";

							$fp = fsockopen($host, 80);

							if ($fp) {
								fputs($fp, $header.$data);
								$rsp = '';
								while(!feof($fp)) {
									$rsp .= fgets($fp,8192);
								}
								fclose($fp);
								$msg = explode("\r\n\r\n",trim($rsp));
								$rMsg = explode(",", $msg[1]);
								$Result= $rMsg[0]; //발송결과
								$Count= $rMsg[1]; //잔여건수
								echo"[".$sdate[m_name]."";
								echo"".$sdate[m_hp]."";
								echo "발송결과 : ".$Result."]";

							}
		}

			alert("예약발송 설정 하였습니다.");

		}else{
			alert("정상적인 접근이 아닙니다.");
		}

	break;

/************************************************
게시판 리스트관리
************************************************/

	case "board_list":


		if ($add_bt == "선택수정") {
		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$sql = " update mari_board
								set bo_subject = '$bo_subject[$k]',
									gr_id = '$gr_id[$k]',
									bo_skin = '$bo_skin[$k]',
									bo_use_search = '$bo_use_search[$k]',
									bo_order_search = '$bo_order_search[$k]'
								where bo_table = '$bo_table[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_board where bo_table='".$bo_table[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				$sql = " delete from mari_board where bo_table='".$table."'   ";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}

	break;


/************************************************
게시판 설정관리
************************************************/

	case "board_form":

		if($type=="w"){
			/*폴더생성*/
			@mkdir(MARI_DATA_PATH."/$bo_table", MARI_DIR_PERMISSION);
			@chmod(MARI_DATA_PATH."/$bo_table", MARI_DIR_PERMISSION);
			/*insert*/
				$sql = " insert into mari_board
							set bo_table = '$bo_table',
							gr_id = '$gr_id',
							bo_subject = '$bo_subject',
							bo_count = '$bo_count',
							bo_admin = '$bo_admin',
							bo_list_level = '$bo_list_level',
							bo_read_level = '$bo_read_level',
							bo_write_level = '$bo_write_level',
							bo_reply_level = '$bo_reply_level',
							bo_comment_level = '$bo_comment_level',
							bo_upload_level = '$bo_upload_level',
							bo_download_level = '$bo_download_level',
							bo_count_modify = '$bo_count_modify',
							bo_count_delete = '$bo_count_delete',
							bo_use_rss = '$bo_use_rss',
							bo_use_sns = '$bo_use_sns',
							bo_use_comment = '$bo_use_comment',
							bo_use_category = '$bo_use_category',
							bo_category_list = '$bo_category_list',
							bo_use_sideview = '$bo_use_sideview',
							bo_use_secret = '$bo_use_secret',
							bo_use_editor = '$bo_use_editor',
							bo_use_name = '$bo_use_name',
							bo_use_ip_view = '$bo_use_ip_view',
							bo_use_list_view = '$bo_use_list_view',
							bo_use_email = '$bo_use_email',
							bo_use_extra = '$bo_use_extra',
							bo_use_syntax = '$bo_use_syntax',
							bo_skin = '$bo_skin',
							bo_page_rows	 = '$bo_page_rows',
							bo_page_rows_comt = '$bo_page_rows_comt',
							bo_subject_len = '$bo_subject_len',
							bo_new = '$bo_new',
							bo_hot = '$bo_hot',
							bo_image_width = '$bo_image_width',
							bo_image_height = '$bo_image_height',
							bo_reply_order = '$bo_reply_order',
							bo_sort_field = '$bo_sort_field',
							bo_upload_ext ='$bo_upload_ext',
							bo_upload_size = '$bo_upload_size',
							bo_head = '$bo_head',
							bo_tail  = '$bo_tail',
							bo_insert_content = '$bo_insert_content',
							bo_use_search = '$bo_use_search',
							bo_order_search ='$bo_order_search'";
					sql_query($sql);
				alert("정상적으로 적용되었습니다.");

		}else if($type=="m"){
			/*insert*/
				$sql = " update  mari_board
							set bo_admin = '$bo_admin',
							gr_id = '$gr_id',
							bo_subject = '$bo_subject',
							bo_count = '$bo_count',
							bo_list_level = '$bo_list_level',
							bo_read_level = '$bo_read_level',
							bo_write_level = '$bo_write_level',
							bo_reply_level = '$bo_reply_level',
							bo_comment_level = '$bo_comment_level',
							bo_upload_level = '$bo_upload_level',
							bo_download_level = '$bo_download_level',
							bo_count_modify = '$bo_count_modify',
							bo_count_delete = '$bo_count_delete',
							bo_use_rss = '$bo_use_rss',
							bo_use_sns = '$bo_use_sns',
							bo_use_comment = '$bo_use_comment',
							bo_use_category = '$bo_use_category',
							bo_category_list = '$bo_category_list',
							bo_use_sideview = '$bo_use_sideview',
							bo_use_secret = '$bo_use_secret',
							bo_use_editor = '$bo_use_editor',
							bo_use_name = '$bo_use_name',
							bo_use_ip_view = '$bo_use_ip_view',
							bo_use_list_view = '$bo_use_list_view',
							bo_use_email = '$bo_use_email',
							bo_use_extra = '$bo_use_extra',
							bo_use_syntax = '$bo_use_syntax',
							bo_skin = '$bo_skin',
							bo_page_rows	 = '$bo_page_rows',
							bo_page_rows_comt = '$bo_page_rows_comt',
							bo_subject_len = '$bo_subject_len',
							bo_new = '$bo_new',
							bo_hot = '$bo_hot',
							bo_image_width = '$bo_image_width',
							bo_image_height = '$bo_image_height',
							bo_reply_order = '$bo_reply_order',
							bo_sort_field = '$bo_sort_field',
							bo_upload_ext ='$bo_upload_ext',
							bo_upload_size = '$bo_upload_size',
							bo_head = '$bo_head',
							bo_tail  = '$bo_tail',
							bo_insert_content = '$bo_insert_content',
							bo_use_search = '$bo_use_search',
							bo_order_search ='$bo_order_search'
							where bo_table='$bo_table'";
					sql_query($sql);
				alert('정상적으로 적용되었습니다.');
		}else if($type=="d"){
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;

/************************************************
그룹리스트관리
************************************************/

	case "boardgroup_list":

		if ($add_bt == "선택수정") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$sql = " update mari_board_group
								set gr_subject = '$gr_subject[$k]',
									gr_admin = '$gr_admin[$k]'
								where gr_id = '$gr_id[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_board_group where gr_id='".$gr_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				$sql = " delete from mari_board_group where gr_id='".$id."'   ";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}
	break;

/************************************************
그룹작성폼
************************************************/

	case "boardgroup_form":
		if($type=="w"){
			$sql = "insert into mari_board_group
						set gr_id = '$gr_id',
						gr_subject = '$gr_subject',
						gr_admin = '$gr_admin'";
				sql_query($sql);
				alert('정상적으로 적용되었습니다.');
		}else if($type=="m"){

				$sql = "update mari_board_group
							set gr_subject = '$gr_subject',
							gr_admin = '$gr_admin'
							where gr_id='$gr_id'";
				sql_query($sql);
				alert('정상적으로 적용되었습니다.');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;


/************************************************
게시물입력 관리
************************************************/
	case "user_board_form":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);

		$timetoday = mktime();
		$now = date("Y-m-d H:i:s", $timetoday);

		@mkdir(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);

		$file_img=$_FILES['u_img']['name'];
		$file_img2=$_FILES['w_logo']['name'];

		/*파일업로드*/
		if(!$file_img==""){
			$img_update="file_img	 = '".$file_img."',";
			if ($_FILES['u_img']['name']) upload_file($_FILES['u_img']['tmp_name'], $file_img, MARI_DATA_PATH."/$table");
		}
		/*파일업로드*/
		if(!$file_img2==""){
			$img_update2="w_logo = '".$file_img2."',";
			if ($_FILES['w_logo']['name']) upload_file($_FILES['w_logo']['tmp_name'], $file_img2, MARI_DATA_PATH."/$table");
		}

		/*휴대폰번호 합침*/
		$w_hp="".$hp1."".$hp2."".$hp3."";
		if($w_hp == "선택"){
			$w_hp = "";
		}

		/*페스워드가 있을경우에만*/

			$pw_yes="w_password = '".hash('sha256',$w_password)."',";

		if($type=="w"){

		/*중복체크 최고관리자또는 게시판관리자인경우에는 중복체크하지않음*/
		if($config[c_admin]==$user[m_id] || $config[c_admin]==$bbs_config[bo_admin]){
		}else{
			if ($m_id=="admin" || $m_id=="ADMIN"  || $m_id=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($w_name=="최고관리자" || $w_name=="관리자"  || $w_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');
		}

			$mb = get_member($m_id);
			/*insert*/
				$sql = " insert into mari_write
							set w_table = '$table',
							".$pw_yes."
							w_num = '$w_num',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							m_id = '$m_id',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',
							w_main_exposure = '$w_main_exposure',
							w_rink	 = '$w_rink',
							".$img_update."
							".$img_update2."
							w_blank = '$w_blank',
							w_media_type = '$w_media_type',
							w_datetime ='$date'";
					sql_query($sql);

				alert('정상적으로 작성 하였습니다.','?cms=user_board_list&table='.$table.'&subject='.$subject.'');
		}else if($type=="m"){

		$sql = " select  file_img, w_logo from  mari_write  where table='$table' and w_id='$w_id'";
		$d_file = sql_fetch($sql, false);
		/*file 삭제*/
		if($d_img=="1"){
			$img_update="file_img	 = '',";
			@unlink(MARI_DATA_PATH."/".$table."/".$d_file[file_img]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['file_img'])) {
				delete_board_thumbnail($table, $d_file['file_img']);
			}
		}

		if($d_logo=="1"){
			$img_update2="w_logo	 = '',";
			@unlink(MARI_DATA_PATH."/".$table."/".$d_file[w_logo]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['w_logo'])) {
				delete_board_thumbnail($table, $d_file['w_logo']);
			}
		}


			/*update*/
				$sql = " update  mari_write
							set ".$pw_yes."
							w_num = '-".$w_id."',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							m_id = '$m_id',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',
							w_main_exposure = '$w_main_exposure',
							w_rink	 = '$w_rink',
							w_blank = '$w_blank',
							".$img_update."
							".$img_update2."
							w_media_type = '$w_media_type',
							w_last ='$date'
							where w_table='$table' and w_id = '$w_id'";
					sql_query($sql);
				alert('정상적으로 수정 되었습니다.','?cms=user_board_list&table='.$table.'&subject='.$subject.'');
		}else if($type=="d"){
			/*delete*/
				$sql = " delete from mari_write where w_id='".$w_id."'   ";
				sql_query($sql);
				alert('정상적으로 삭제처리 하였습니다.','?cms=user_board_list&table='.$table.'&subject='.$subject.'');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;


/************************************************
게시물 리스트
************************************************/
	case "user_board_list":

	if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_write where w_table='".$w_table[$k]."' and w_id='".$w_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				$sql = " delete from mari_write where w_table='".$table."' and w_id='".$id."'";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}

	break;





/************************************************
환경설정
************************************************/
	case "config_form":
		if($type=="setting1"){
		$sql = "update mari_config
				set c_admin = '$c_admin',
				c_admin_email = '$c_admin_email',
				c_possible_ip = '$c_possible_ip',
				c_intercept_ip = '$c_intercept_ip',
				c_filter = '$c_filter'
				";
		sql_query($sql);
			alert('정상적으로 설정 하였습니다.');
		}else if($type=="setting2"){
		$sql = "update mari_config
				set c_home_skin = '$c_home_skin',
				c_mobile_skin = '$c_mobile_skin',
				c_admin_skin = '$c_admin_skin',
				c_member_skin = '$c_member_skin',
				c_login_skin = '$c_login_skin',
				c_formmail_skin = '$c_formmail_skin',
				c_latest_skin = '$c_latest_skin',
				c_editor = '$c_editor',
				c_page_rows = '$c_page_rows',
				c_write_pages = '$c_write_pages',
				c_image_upload = '$c_image_upload',
				c_flash_upload = '$c_flash_upload',
				c_movie_upload = '$c_movie_upload',
				c_bo_filter = '$c_bo_filter'
				";
		sql_query($sql);
			alert('정상적으로 설정 하였습니다.');
		}else if($type=="setting3"){
		$sql = "update mari_config
				set c_use_homepage = '$c_use_homepage',
				c_req_homepage = '$c_req_homepage',
				c_use_addr = '$c_use_addr',
				c_req_addr = '$c_req_addr',
				c_use_tel = '$c_use_tel',
				c_req_tel = '$c_req_tel',
				c_use_hp = '$c_use_hp',
				c_req_hp = '$c_req_hp',
				c_use_email = '$c_use_email',
				c_req_email = '$c_req_email',
				c_use_nick = '$c_use_nick',
				c_companynum_use = '$c_companynum_use',
				c_req_nick = '$c_req_nick',
				c_memregi_level = '$c_memregi_level',
				c_email_use = '$c_email_use',
				c_use_member_icon = '$c_use_member_icon',
				c_member_icon_size = '$c_member_icon_size',
				c_member_icon_width = '$c_member_icon_width',
				c_member_icon_height = '$c_member_icon_height',
				c_use_recommend = '$c_use_recommend',
				c_prohibit_id = '$c_prohibit_id',
				c_prohibit_email = '$c_prohibit_email',
				c_stipulation = '$c_stipulation',
				c_privacy = '$c_privacy',
				c_cert_use = '$c_cert_use',
				c_cert_ipin = '$c_cert_ipin',
				c_email_refusal = '$c_email_refusal',
				c_company_code = '$c_company_code',
				c_pw_code = '$c_pw_code',
				c_nice_id = '$c_nice_id',
				c_nice_login = '$c_nice_login',
				c_nice_company = '$c_nice_company',
				c_nice_pw = '$c_nice_pw',
				c_map_api = '$c_map_api',
				c_invest_manage = '$c_invest_manage',
				c_auto_dangerous = '$c_auto_dangerous'
				";
		sql_query($sql);
			alert('정상적으로 설정 하였습니다.');
		}else if($type=="setting4"){
		$sql = "update mari_config
				set c_email_use = '$c_email_use',
				c_email_wr_administrator_admin = '$c_email_wr_administrator_admin',
				c_email_wr_group_admin = '$c_email_wr_group_admin',
				c_email_wr_board_admin = '$c_email_wr_board_admin',
				c_email_wr_write = '$c_email_wr_write',
				c_email_wr_comment_all = '$c_email_wr_comment_all',
				c_email_mb_administrator_admin = '$c_email_mb_administrator_admin',
				c_email_mb_member = '$c_email_mb_member',
				c_facebook_appid = '$c_facebook_appid',
				c_facebook_secret = '$c_facebook_secret',
				c_facebooklogin_use = '$c_facebooklogin_use'
				";
		sql_query($sql);
			alert('정상적으로 설정 하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다');
		}
	break;


/************************************************
sns 페이스북 연동설정
************************************************/
	case "sns":

		if($type=="w"){
		$sql = "update mari_config
				set c_facebook_appid = '$c_facebook_appid',
				c_facebook_secret = '$c_facebook_secret',
				c_facebooklogin_use = '$c_facebooklogin_use'
				";
		sql_query($sql);
			alert('정상적으로 설정 하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다');
		}

	break;

/************************************************
투자진행 리스트관리
************************************************/
	case "invest_setup_list":

				if ($add_bt == "선택수정") {
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

					$sql = " update mari_loan
									set i_stef = '$i_stef[$k]'
									where i_id = '".$loan_id[$k]."' ";
					sql_query($sql);
					}
				alert('정상적으로 수정 하였습니다.');
				}else if ($add_bt == "선택취소") {

					if (!count($check)) {
						alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
					}
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

					/*삭제된 투자건에 대해서 투자금환불*/
					$sql ="select * from mari_invest where loan_id = '".$loan_id[$k]."'";
					$del_mem = sql_fetch($sql,false);

					$sql = "update mari_member
							set m_emoney = '$del_mem[i_loan_pay]'
							where m_id = '$del_mem[m_id]'";
					sql_query($sql);

					/*투자금회수에 대한 e머니리스트 내역추가*/
					if($del_mem[i_loan_pay]){
						$sql = "select * from mari_member where m_id = '$del_mem[m_id]'";
						$d_mem2 = sql_fetch($sql,false);

						$re_money = $del_mem[i_loan_pay] + $d_mem2[m_emoney];

						$sql = "insert into mari_emoney
								set m_id = '$del_mem[m_id]',
								p_datetime = '$date',
								p_content = '투자 진행 중 종료로 인한 예치금 환불',
								p_emoney = '$del_mem[i_loan_pay]',
								p_ip = '$ip',
								p_top_emoney = '$re_emoney'";
						sql_query($sql);
					}

					/* 삭제*/
					$sql = "delete from mari_loan where i_id='$loan_id[$k]'";
					sql_query($sql);

					$sql ="delete from mari_invest_progress where loan_id = '$loan_id[$k]'";
					sql_query($sql);

					}
				alert('정상적으로 취소처리 하였습니다.');
				}else{
				alert('정상적인 접근이 아닙니다.');
				}
	break;


/************************************************
투자진행 설정폼
************************************************/
	case "invest_setup_form":



		/*콤마제거*/
		$i_invest_mini = (string)$i_invest_mini;
		$i_invest_mini = preg_replace("/[^0-9]/", "",$i_invest_mini);
		$i_invest_mini = (int)$i_invest_mini;

		$i_invest_pay = (string)$i_invest_pay;
		$i_invest_pay = preg_replace("/[^0-9]/", "",$i_invest_pay);
		$i_invest_pay = (int)$i_invest_pay;

		/*콤마제거*/
		$i_maximum_v = (string)$i_maximum_v;
		$i_maximum_v = preg_replace("/[^0-9]/", "",$i_maximum_v);
		$i_maximum_v = (int)$i_maximum_v;

		$i_maximum = (string)$i_maximum;
		$i_maximum = preg_replace("/[^0-9]/", "",$i_maximum);
		$i_maximum = (int)$i_maximum;

		$i_maximum_pro = (string)$i_maximum_pro;
		$i_maximum_pro = preg_replace("/[^0-9]/", "",$i_maximum_pro);
		$i_maximum_pro = (int)$i_maximum_pro;

		$i_maximum_in = (string)$i_maximum_in;
		$i_maximum_in = preg_replace("/[^0-9]/", "",$i_maximum_in);
		$i_maximum_in = (int)$i_maximum_in;


		$i_debts = (string)$i_debts;
		$i_debts = preg_replace("/[^0-9]/", "",$i_debts);
		$i_debts = (int)$i_debts;

		$i_credit_debt = (string)$i_credit_debt;
		$i_credit_debt = preg_replace("/[^0-9]/", "",$i_credit_debt);
		$i_credit_debt = (int)$i_credit_debt;

		$i_secured_debt = (string)$i_secured_debt;
		$i_secured_debt = preg_replace("/[^0-9]/", "",$i_secured_debt);
		$i_secured_debt = (int)$i_secured_debt;

		$i_guaranteed_debt = (string)$i_guaranteed_debt;
		$i_guaranteed_debt = preg_replace("/[^0-9]/", "",$i_guaranteed_debt);
		$i_guaranteed_debt = (int)$i_guaranteed_debt;






		/*첨부파일 저장폴더 생성*/
		@mkdir(MARI_DATA_PATH."/file/".$loan_id, MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/file/".$loan_id, MARI_DIR_PERMISSION);


		/*폴더생성*/
		@mkdir(MARI_DATA_PATH."/photoreviewers/".$loan_id, MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/photoreviewers/".$loan_id, MARI_DIR_PERMISSION);

		$file_img=$_FILES['i_photoreviewers']['name'];
		$file_img_01=$_FILES['i_creditratingviews']['name'];
		$file_img_02=$_FILES['i_img_detail1']['name'];
		$file_img_03=$_FILES['i_img_detail2']['name'];
		$file_img_04=$_FILES['i_img_detail3']['name'];
		$file_img_05=$_FILES['i_photoreviewers2']['name'];

		$file_img_09=$_FILES['i_file1']['name'];
		$file_img_10=$_FILES['i_file2']['name'];
		$file_img_11=$_FILES['i_file3']['name'];
		$file_img_12=$_FILES['i_file4']['name'];
		$file_img_13=$_FILES['i_file5']['name'];
		$file_img_06=$_FILES['i_photoreviewers_01']['name'];

		/*파일업로드*/
		if(!$file_img==""){
			$img_update="i_photoreviewers	 = '".$file_img."',";
			if ($_FILES['i_photoreviewers']['name']) upload_file($_FILES['i_photoreviewers']['tmp_name'], $file_img, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}

		/*파일업로드*/
		if(!$file_img_01==""){
			$img_update_01="i_creditratingviews	 = '".$file_img_01."',";
			if ($_FILES['i_creditratingviews']['name']) upload_file($_FILES['i_creditratingviews']['tmp_name'], $file_img_01, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}

		/*파일업로드*/
		if(!$file_img_02==""){
			$img_update_02="i_img_detail1	 = '".$file_img_02."',";
			if ($_FILES['i_img_detail1']['name']) upload_file($_FILES['i_img_detail1']['tmp_name'], $file_img_02, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}
		/*파일업로드*/
		if(!$file_img_03==""){
			$img_update_03="i_img_detail2	 = '".$file_img_03."',";
			if ($_FILES['i_img_detail2']['name']) upload_file($_FILES['i_img_detail2']['tmp_name'], $file_img_03, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}

		/*파일업로드*/
		if(!$file_img_04==""){
			$img_update_04="i_img_detail3	 = '".$file_img_04."',";
			if ($_FILES['i_img_detail3']['name']) upload_file($_FILES['i_img_detail3']['tmp_name'], $file_img_04, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}

		/*파일업로드*/
		if(!$file_img_05==""){
			$img_update_05="i_photoreviewers2	 = '".$file_img_05."',";
			if ($_FILES['i_photoreviewers2']['name']) upload_file($_FILES['i_photoreviewers2']['tmp_name'], $file_img_05, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}

		if(!$file_img_06==""){
			$img_update_06="i_photoreviewers_01	 = '".$file_img_06."',";
			if ($_FILES['i_photoreviewers_01']['name']) upload_file($_FILES['i_photoreviewers_01']['tmp_name'], $file_img_06, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}






		 /*첨부파일*/
		if(!$file_img_09==""){
			$img_update_09="i_file1	 = '".$file_img_09."',";
			if ($_FILES['i_file1']['name']) upload_file($_FILES['i_file1']['tmp_name'], $file_img_09, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}
		if(!$file_img_10==""){
			$img_update_10="i_file2	 = '".$file_img_10."',";
			if ($_FILES['i_file2']['name']) upload_file($_FILES['i_file2']['tmp_name'], $file_img_10, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}
		if(!$file_img_11==""){
			$img_update_11="i_file3	 = '".$file_img_11."',";
			if ($_FILES['i_file3']['name']) upload_file($_FILES['i_file3']['tmp_name'], $file_img_11, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}
		if(!$file_img_12==""){
			$img_update_12="i_file4	 = '".$file_img_12."',";
			if ($_FILES['i_file4']['name']) upload_file($_FILES['i_file4']['tmp_name'], $file_img_12, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}
		if(!$file_img_13==""){
			$img_update_13="i_file5	 = '".$file_img_13."',";
			if ($_FILES['i_file5']['name']) upload_file($_FILES['i_file5']['tmp_name'], $file_img_13, MARI_DATA_PATH."/photoreviewers/".$loan_id);
		}




		$sql = "update mari_loan
								set i_invest_eday = '$i_invest_eday',
								i_level_dti = '$i_level_dti'
								where  i_id='$loan_id'";
		sql_query($sql);

		if($type=="w"){
			$sql="insert into mari_invest_progress
						set i_invest_name = '$i_invest_name',
						loan_id = '$loan_id',
						i_invest_level = '$i_invest_level',
						i_level_point = '$i_level_point',
						i_invest_per = '$i_invest_per',
						i_invest_pay = '$i_invest_pay',
						i_current_day = '$i_current_day',
						i_look = '$i_look',
						i_view = '$i_view',
						i_recom = '$i_recom',
						i_invest_credit = '$i_invest_credit',
						i_invest_sday	 = '$i_invest_sday',
						i_invest_eday	 = '$i_invest_eday',
						i_people = '$i_people',
						i_level_dti = '$i_level_dti',
						".$img_update."
						".$img_update_01."
						".$img_update_02."
						".$img_update_03."
						".$img_update_04."
						".$img_update_05."
						".$img_update_06."
						".$img_update_09."
						".$img_update_10."
						".$img_update_11."
						".$img_update_12."
						".$img_update_13."
						i_company_name = '$i_company_name',
						i_reviewers_name = '$i_reviewers_name',
						i_reviewers_contact = '$i_reviewers_contact',
						i_rviewers_use = '$i_rviewers_use',
						i_grade = '$i_grade',
						i_charge_no = '$i_charge_no',
						i_certify = '$i_certify',
						i_regdatetime = '$date',
						i_ltv_point = '$i_ltv_point',
						i_stability = '$i_stability',
						i_refund = '$i_refund',
						i_income = '$i_income',
						i_position = '$i_position',
						i_credit_grade = '$i_credit_grade',
						i_evaluation = '$i_evaluation',
						i_weak_way = '$i_weak_way',
						i_bluechip = '$i_bluechip',
						i_debt_fail = '$i_debt_fail',
						i_product_info = '$i_product_info',
						i_ltv_point_info = '$i_ltv_point_info',
						i_stability_info = '$i_stability_info',
						i_refund_info = '$i_refund_info',
						i_income_info = '$i_income_info',
						i_position_info = '$i_position_info',
						i_invest_mini = '$i_invest_mini',
						i_invest_max = '$i_invest_max',
						i_borrower_info = '$i_borrower_info',
						i_credit_grade_info = '$i_credit_grade_info',
						i_grade_info = '$i_grade_info',
						i_ltv_per = '$i_ltv_per',
						i_binding = '$i_binding',
						i_invest_summary = '$i_invest_summary',
						i_invest_manage = '$i_invest_manage',
						i_security = '$i_security',
						i_summary = '$i_summary',
						i_debts = '$i_debts',
						i_credit_debt = '$i_credit_debt',
						i_secured_debt = '$i_secured_debt',
						i_guaranteed_debt = '$i_guaranteed_debt',
						i_repay_plan = '$i_repay_plan',
						i_repay_way = '$i_repay_way',
						i_repay_info = '$i_repay_info',
						i_maximum_v = '$i_maximum_v',
						i_maximum = '$i_maximum',
						i_maximum_pro = '$i_maximum_pro',
						i_maximum_in = '$i_maximum_in',
						investstart_msg = '$investstart_msg',
						investstart_req = '$investstart_req',
						i_reviewers_name_01 = '$i_reviewers_name_01',
						i_rviewers_use_01 = '$i_rviewers_use_01',
						i_reviewers_contact_01 = '$i_reviewers_contact_01',
						i_top_view = '$i_top_view'
						";
			sql_query($sql);


			$sql="update mari_loan
						set i_subject='$i_invest_name',
						ca_id = '$i_payment',
						i_payment = '$i_payment',
						i_view = '$i_view',
						i_look = '$i_look',
						i_recom = '$i_recom',
						i_year_plus = '$i_profit_rate',
						i_top_view = '$i_top_view'
						where i_id = '$loan_id'";
			sql_query($sql);

			if($f_type=="w"){
				/*첨부파일*/
					for ($i=0; $i<count($_FILES[file_name][name]); $i++)
					{
						if($_FILES[file_name][name][$i]!=""){
							$file_img[$i] = $_FILES['file_name']['name'][$i];

							/*파일업로드*/
							if(!$file_img==""){
								//$img_update="file_name = '".$file_img[$i]."'";
								if ($_FILES['file_name']['name'][$i]) upload_file($_FILES['file_name']['tmp_name'][$i], $file_img[$i], MARI_DATA_PATH."/file/".$loan_id);
							}

							$sql = " insert into mari_invest_file
										set loan_id = '".$loan_id."',
										file_name = '".$file_img[$i]."'
										";
							sql_query($sql);
							alert('파일이 설정 되었습니다.');
						}
					}
			}



			alert('해당 대출의 투자가 설정 되었습니다.','?cms=invest_setup_list');
		}else if($type=="m"){

			$sql = " select  * from  mari_invest_progress  where loan_id='$loan_id'";
			$d_file = sql_fetch($sql, false);

			/*file 삭제*/
			if($d_img=="1"){
				$img_update="i_photoreviewers	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_photoreviewers]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_photoreviewers'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_photoreviewers']);
				}
			}

			/*file 삭제*/
			if($d_img_01=="1"){
				$img_update_01="i_creditratingviews	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_creditratingviews]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_creditratingviews'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_creditratingviews']);
				}
			}

			/*file 삭제*/
			if($d_img_02=="1"){
				$img_update_02="i_img_detail1	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_img_detail1]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_img_detail1'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_img_detail1']);
				}
			}

			/*file 삭제*/
			if($d_img_03=="1"){
				$img_update_03="i_img_detail2	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_img_detail2]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_img_detail2'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_img_detail2']);
				}
			}

			/*file 삭제*/
			if($d_img_04=="1"){
				$img_update_04="i_img_detail3	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_img_detail3]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_img_detail3'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_img_detail3']);
				}
			}

			/*file 삭제*/
			if($d_img_05=="1"){
				$img_update_05="i_photoreviewers2	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_photoreviewers2]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_photoreviewers2'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_photoreviewers2']);
				}
			}

			/*file 삭제*/
			if($d_img_09=="1"){
				$img_update_09="i_file1	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_file1]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_file1'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_file1']);
				}
			}
			/*file 삭제*/
			if($d_img_10=="1"){
				$img_update_10="i_file2	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_file2]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_file2'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_file2']);
				}
			}
			/*file 삭제*/
			if($d_img_11=="1"){
				$img_update_11="i_file3	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_file3]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_file3'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_file3']);
				}
			}
			/*file 삭제*/
			if($d_img_12=="1"){
				$img_update_12="i_file4	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_file4]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_file4'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_file4']);
				}
			}
			/*file 삭제*/
			if($d_img_13=="1"){
				$img_update_13="i_file5	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$d_file[i_file5]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_file5'])) {
					delete_board_thumbnail('photoreviewers/'.$loan_id, $d_file['i_file5']);
				}
			}


			$sql="update mari_invest_progress
						set i_invest_name = '$i_invest_name',
						i_invest_level = '$i_invest_level',
						i_level_point = '$i_level_point',
						i_invest_per = '$i_invest_per',
						i_invest_pay = '$i_invest_pay',
						i_current_day = '$i_current_day',
						i_look = '$i_look',
						i_view = '$i_view',
						i_recom = '$i_recom',
						i_invest_credit = '$i_invest_credit',
						i_invest_sday	 = '$i_invest_sday',
						i_invest_eday	 = '$i_invest_eday',
						i_people = '$i_people',
						i_level_dti = '$i_level_dti',
						".$img_update."
						".$img_update_01."
						".$img_update_02."
						".$img_update_03."
						".$img_update_04."
						".$img_update_05."
						".$img_update_06."
						".$img_update_09."
						".$img_update_10."
						".$img_update_11."
						".$img_update_12."
						".$img_update_13."
						i_company_name = '$i_company_name',
						i_reviewers_name = '$i_reviewers_name',
						i_reviewers_contact = '$i_reviewers_contact',
						i_rviewers_use = '$i_rviewers_use',
						i_modidatetime = '$date',
						i_charge_no = '$i_charge_no',
						i_certify = '$i_certify',
						i_grade = '$i_grade',
						i_ltv_point = '$i_ltv_point',
						i_stability = '$i_stability',
						i_refund = '$i_refund',
						i_income = '$i_income',
						i_position = '$i_position',
						i_credit_grade = '$i_credit_grade',
						i_evaluation = '$i_evaluation',
						i_weak_way = '$i_weak_way',
						i_bluechip = '$i_bluechip',
						i_debt_fail = '$i_debt_fail',
						i_product_info = '$i_product_info',
						i_ltv_point_info = '$i_ltv_point_info',
						i_stability_info = '$i_stability_info',
						i_refund_info = '$i_refund_info',
						i_income_info = '$i_income_info',
						i_position_info = '$i_position_info',
						i_invest_mini = '$i_invest_mini',
						i_invest_max = '$i_invest_max',
						i_borrower_info = '$i_borrower_info',
						i_grade_info = '$i_grade_info',
						i_credit_grade_info = '$i_credit_grade_info',
						i_ltv_per = '$i_ltv_per',
						i_binding = '$i_binding',
						i_invest_summary = '$i_invest_summary',
						i_invest_manage = '$i_invest_manage',
						i_security = '$i_security',
						i_summary = '$i_summary',
						i_debts = '$i_debts',
						i_credit_debt = '$i_credit_debt',
						i_secured_debt = '$i_secured_debt',
						i_guaranteed_debt = '$i_guaranteed_debt',
						i_repay_plan = '$i_repay_plan',
						i_repay_way = '$i_repay_way',
						i_repay_info = '$i_repay_info',
						i_maximum_v = '$i_maximum_v',
						i_maximum = '$i_maximum',
						i_maximum_pro = '$i_maximum_pro',
						i_maximum_in = '$i_maximum_in',
						investstart_msg = '$investstart_msg',
						investstart_req = '$investstart_req',
						i_reviewers_name_01 = '$i_reviewers_name_01',
						i_rviewers_use_01 = '$i_rviewers_use_01',
						i_reviewers_contact_01 = '$i_reviewers_contact_01',
						i_top_view = '$i_top_view'
						where loan_id='$loan_id'";
			sql_query($sql);

			$sql="update mari_loan
						set i_subject='$i_invest_name',
						ca_id = '$i_payment',
						i_payment = '$i_payment',
						i_view = '$i_view',
						i_look = '$i_look',
						i_recom = '$i_recom',
						i_year_plus = '$i_profit_rate',
						i_top_view = '$i_top_view'
						where i_id = '$loan_id'";
			sql_query($sql);

			if($f_type=="w"){

				/*첨부파일*/
					for ($i=0; $i<count($_FILES[file_name][name]); $i++)
					{
						if($_FILES[file_name][name][$i]!=""){
							$file_img[$i] = $_FILES['file_name']['name'][$i];

							/*파일업로드*/
							if(!$file_img==""){
								//$img_update="file_name = '".$file_img[$i]."'";
								if ($_FILES['file_name']['name'][$i]) upload_file($_FILES['file_name']['tmp_name'][$i], $file_img[$i], MARI_DATA_PATH."/file/".$loan_id);
							}

							$sql = " insert into mari_invest_file
										set loan_id = '".$loan_id."',
										file_name = '".$file_img[$i]."'
										";
							sql_query($sql);
						}
					}
			}

			/*투자마감처리시 세이퍼트 펀딩해제처리*/
			if($i_look=="C"){

				if($i_invest_endtime == "0000-00-00 00:00:00"){
					$sql = "update mari_invest_progress
							set i_invest_endtime = '$date'
							where loan_id = '$loan_id'
							";
					sql_query($sql);
				}

				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y" && $member_ck){


					include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

					/*투자자정보 for*/
					$sql = "select * from  mari_seyfert_order where loan_id='$loan_id'  and s_type='1' and s_payuse='Y'  and s_release='N' order by s_date desc";
					$invest_up = sql_query($sql, false);

				for ($i=0; $row=sql_fetch_array($invest_up); $i++) {

					/*가상계좌 세이퍼트멤버생성정보*/
					$sql = "select * from mari_seyfert_order where loan_id='$loan_id'  and  m_id='$row[m_id]' and s_type='1' and s_payuse='Y'  and s_release='N' order by s_date desc";
					$release_roof = sql_query($sql, false);

					$sql = "select m_id from mari_seyfert_order where loan_id='$loan_id'  and  m_id='$row[m_id]' and s_type='1' and s_payuse='Y'  and s_release='N'";
					$releaseck = sql_fetch($sql, false);
					/*펀딩진행중인경우에만 해제처리가능*/
					if($releaseck['m_id']){
						for ($i=0; $release=sql_fetch_array($release_roof); $i++) {
								$nonce_pending = "R".time().rand(111,999);
								if($release[m_id]){
									if($release[s_tid]=="E" || $release[s_tid]=="S"  || !$release[s_tid]){
									}else{
										/*발급받은 memGuid 조회*/
										$sql = "select  s_memGuid from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
										$bankck = sql_fetch($sql, false);
										$ENCODE_PARAMS_re="&_method=POST&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_pending."".$i."&title=".urlencode($release[s_subject])."&refId=".$release[s_refId]."&authType=SMS_MO&timeout=30&parentTid=".$release[s_tid]."";

										$cipher_re = AesCtr::encrypt($ENCODE_PARAMS_re, $KEY_ENC, 256);
										$cipherEncoded_re = urlencode($cipher_re);
										$requestString_re = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_re;

										/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

										$requestPath_re = "https://v5.paygate.net/v5/transaction/pending/release?".$requestString_re;

										$curl_handlebank_re = curl_init();

										curl_setopt($curl_handlebank_re, CURLOPT_URL, $requestPath_re);
										/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
										curl_setopt($curl_handlebank_re, CURLOPT_CONNECTTIMEOUT, 2);
										curl_setopt($curl_handlebank_re, CURLOPT_RETURNTRANSFER, 1);
										curl_setopt($curl_handlebank_re, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
										curl_setopt($curl_handlebank_re, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/pending/release');
										$result_re = curl_exec($curl_handlebank_re);
										curl_close($curl_handlebank_re);

										/*파싱*/
										$decode_re = json_decode($result_re, true);


										print_r($requestPath);
										echo"<br/><br/>";
										print_r($result_re);
										echo"<br/><br/>";
										print_r($ENCODE_PARAMS);


										echo"<br/><br/>데이터";
										print_r($decode_re);
										echo"<br/><br/>";

									}
								}
						}

					}
				}
				}

			}



			/*투자시작 알림메세지 발송*/
			if($i_look=="Y"){

				if($config['c_sms_use']=="Y"){

					/*SMS푸시사용여부(시작시체크)*/
					$sql = "select i_smspush, investstart_msg, investstart_req from mari_invest_progress where  loan_id='$loan_id'";
					$smspush = sql_fetch($sql, false);
					$investstart_msg=$smspush['investstart_msg'];

					if($smspush['investstart_req']=="Y"){

					/*SMS수신체크 리스트*/
					$sql="select * from mari_member order by m_datetime desc";
					$Smssends=sql_query($sql, false);

					if($smspush['i_smspush']=="N"){
						for ($i=0; $row=sql_fetch_array($Smssends); $i++) {

						/*가상계좌 발급여부확인*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='".$row[m_id]."' and s_memuse='Y'";
						$seyfck = sql_fetch($sql, false);


							if(!$seyfck['s_memGuid']){

							}else{

								/*SMS자동전송 시작*/
								$loadmem = sql_fetch(" select m_hp from mari_member where m_id='".$row[m_id]."'");

								/*휴대폰번호 분리*/
								$m_hp = $loadmem['m_hp'];
								$hp1=substr($m_hp,0,3);
								$hp2=substr($m_hp,3,-4);
								$hp3=substr($m_hp,-4);
								$to_hp="".$hp1."".$hp2."".$hp3."";


								/*문자치환 사이트주소*/
								$investstart_msg = str_replace("{사이트주소}", MARI_HOME_URL, $investstart_msg);


								/*80바이트 이상일경우 lms로 발송*/
								$message_msg=mb_strlen($investstart_msg, "euc-kr");
								if($message_msg <=80){
									$sendSms="sendSms";

										/*POST전송할 데이터 SMS*/
										$post_data = array(
										 "cid" => "".$config[c_sms_id]."",
										 "from" => "".$config[c_sms_phone]."",
										 "to" => "".$to_hp."",
										 "msg" => "".$investstart_msg."",
										 "mode" => "".$sendSms."",
										 "smsmsg" => "투자 알림 메시지가 'SMS 수신 동의'한 회원들에게 정상적으로 발송되었습니다.",
										 "returnurl" => "".MARI_HOME_URL."?cms=".$update."&type=".$type."&loan_id=".$loan_id.""
										);

								}else{
									$sendSms="sendSms_lms";

										/*POST전송할 데이터 LMS*/
										$post_data = array(
										 "cid" => "".$config[c_sms_id]."",
										 "from" => "".$config[c_sms_phone]."",
										 "msg_title" => "".$i_invest_name."",
										 "to" => "".$to_hp."",
										 "msg" => "".$investstart_msg."",
										 "mode" => "".$sendSms."",
										 "smsmsg" => "투자 알림 메시지가 'SMS 수신 동의'한 회원들에게 정상적으로 발송되었습니다.",
										 "returnurl" => "".MARI_HOME_URL."?cms=".$update."&type=".$type."&loan_id=".$loan_id.""
										);

								}

										$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
										$curl_sms = curl_init();
										curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
										/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
										curl_setopt($curl_sms, CURLOPT_POST, 1);
										curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
										$result_sms = curl_exec($curl_sms);
										curl_close($curl_sms);
										/*SMS CURL전송*/
							}

						}//for
						/*투자시작시 발송된것으로 처리*/
						$sql="update mari_invest_progress
									set i_smspush = 'Y'
									where loan_id='$loan_id'";
						sql_query($sql);
					}//smspush

					}
				}

			}



			alert('해당 대출의 투자가 수정 되었습니다.');
		}else if($add_bt == "선택추가"){
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];

				$sql = "insert into mari_lawyer_appr
						set loan_id = '$loan_id',
						ly_id = '$ly_id[$k]',
						ly_name = '$ly_name[$k]',
						ly_lawyer_use = '$ly_lawyer_use[$k]',
						ly_appr = '$ly_appr[$k]' ";
				sql_query($sql);
			}
		alert('수정되었습니다.');
		}else if($add_bt2 == "선택수정"){
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];

				$sql = "update mari_lawyer_appr
						set ly_lawyer_use = '$ly_lawyer_use[$k]',
						ly_appr = '$ly_appr[$k]'
						where la_id = '$la_id[$k]'
						";
				sql_query($sql);
			}
		alert('수정되었습니다.');
		}else if($add_bt3 == "선택삭제"){
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];

				$sql = "delete from mari_lawyer_appr where la_id = '$la_id[$k]'";
				sql_query($sql);
			}
		alert('수정되었습니다.');
		}else{
			alert('정상적인 접근이 아닙니다.');
		}
	break;







/************************************************
대출신청 리스트관리
************************************************/
	case "loan_list":
				if ($add_bt == "선택수정") {
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];
					$sql = " update mari_loan
									set i_stef = '$i_stef[$k]'
									where i_id = '".$i_id[$k]."' ";
					sql_query($sql);
					}

				alert('정상적으로 수정 하였습니다.');
				}else if ($add_bt == "선택삭제") {

					if (!count($check)) {
						alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
					}
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];
						$sql = "delete from mari_loan where i_id= '".$i_id[$k]."'";
						sql_query($sql);

					}
				alert('정상적으로 삭제가 되었습니다.');
				}else if($type="d"){
						$sql = " delete from mari_loan where i_id='".$id."'   ";
						sql_query($sql);
				alert('정상적으로 삭제처리 하였습니다.');
				}else{
				alert('정상적인 접근이 아닙니다.');
				}
	break;

/************************************************
대출신청 본인정보
************************************************/


	case "loan_form":

		/*콤마제거*/
		$i_loan_pay = (string)$i_loan_pay;
		$i_loan_pay = preg_replace("/[^0-9]/", "",$i_loan_pay);
		$i_loan_pay = (int)$i_loan_pay;

		$i_conni = (string)$i_conni;
		$i_conni = preg_replace("/[^0-9]/", "",$i_conni);
		$i_conni = (int)$i_conni;

		$i_conni_admin = (string)$i_conni_admin;
		$i_conni_admin = preg_replace("/[^0-9]/", "",$i_conni_admin);
		$i_conni_admin = (int)$i_conni_admin;



		$i_gener = (string)$i_gener;
		$i_gener = preg_replace("/[^0-9]/", "",$i_gener);
		$i_gener = (int)$i_gener;


		$i_senior_price = (string)$i_senior_price;
		$i_senior_price = preg_replace("/[^0-9]/", "",$i_senior_price);
		$i_senior_price = (int)$i_senior_price;


		$file_img=$_FILES['i_security']['name'];

			/*파일업로드*/
			if(!$file_img==""){
				$img_update="i_security = '".$file_img."',";
				if ($_FILES['i_security']['name']) upload_file($_FILES['i_security']['tmp_name'], $file_img, MARI_DATA_PATH."/photoreviewers");
			}
		/*제출가능 서류*/
	$i_out_paper = "$out_paper_01|$out_paper_02|$out_paper_03|$out_paper_04|$out_paper_05|$out_paper_06|$out_paper_07|$out_paper_08|$out_paper_09|$out_paper_10|$out_paper_11|";
	$i_ppdocuments="$ppdocuments_01|$ppdocuments_02|$ppdocuments_03|$ppdocuments_04|$ppdocuments_05|$ppdocuments_06";
		/*등록*/


			/*직장주소*/
			if($rectal_address_a){
				$rectal_address=$rectal_address_a;
			}else if($rectal_address_b){
				$rectal_address=$rectal_address_b;
			}else if($rectal_address_c){
				$rectal_address=$rectal_address_c;
			}else if($rectal_address_d){
				$rectal_address=$rectal_address_d;
			}else if($rectal_address_e){
				$rectal_address=$rectal_address_e;
			}

			/*직종*/
			if($i_occu_a){
				$i_occu=$i_occu_a;
			}else if($i_occu_b){
				$i_occu=$i_occu_b;
			}else if($i_occu_c){
				$i_occu=$i_occu_c;
			}else if($i_occu_d){
				$i_occu=$i_occu_d;
			}else if($i_occu_e){
				$i_occu=$i_occu_e;
			}

			/*직장명*/
			if($i_company_name_a){
				$i_company_name=$i_company_name_a;
			}else if($i_company_name_b){
				$i_company_name=$i_company_name_b;
			}else if($i_company_name_c){
				$i_company_name=$i_company_name_c;
			}

			/*직장전화&휴대폰*/
			if($i_businesshp_a){
				$i_businesshp=$i_businesshp_a;
			}else if($i_businesshp_b){
				$i_businesshp=$i_businesshp_b;
			}else if($i_businesshp_c){
				$i_businesshp=$i_businesshp_c;
			}else if($i_businesshp_d){
				$i_businesshp=$i_businesshp_d;
			}else if($i_businesshp_e){
				$i_businesshp=$i_businesshp_e;
			}
			/*고용형태*/
			if($i_employment_a){
				$i_employment=$i_employment_a;
			}else if($i_employment_b){
				$i_employment=$i_employment_b;
			}else if($i_employment_c){
				$i_employment=$i_employment_c;
			}else if($i_employment_d){
				$i_employment=$i_employment_d;
			}

			/*근무개월*/
			if($i_company_day_a){
				$i_company_day=$i_company_day_a;
			}else if($i_company_day_b){
				$i_company_day=$i_company_day_b;
			}else if($i_company_day_c){
				$i_company_day=$i_company_day_c;
			}else if($i_company_day_d){
				$i_company_day=$i_company_day_d;
			}

			/*소득금액 월&년*/
			if($i_plus_pay_mon_a && $i_plus_pay_year_a){
				$i_plus_pay_mon=$i_plus_pay_mon_a;
				$i_plus_pay_year=$i_plus_pay_year_a;
			}else if($i_plus_pay_mon_b && $i_plus_pay_year_b){
				$i_plus_pay_mon=$i_plus_pay_mon_b;
				$i_plus_pay_year=$i_plus_pay_year_b;
			}else if($i_plus_pay_mon_c && $i_plus_pay_year_c){
				$i_plus_pay_mon=$i_plus_pay_mon_c;
				$i_plus_pay_year=$i_plus_pay_year_c;
			}else if($i_plus_pay_mon_d && $i_plus_pay_year_d){
				$i_plus_pay_mon=$i_plus_pay_mon_d;
				$i_plus_pay_year=$i_plus_pay_year_d;
			}

			/*사업자명*/
			if($i_businessname_a){
				$i_businessname=$i_businessname_a;
			}else if($i_businessname_b){
				$i_businessname=$i_businessname_b;
			}else if($i_businessname_c){
				$i_businessname=$i_businessname_c;
			}


		if(!$i_credit_pay==""){
		$dti_add=ceil ($i_credit_pay/$i_plus_pay_mon*100);
		}


		/*폴더생성*/
		@mkdir(MARI_DATA_PATH."/security", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/security", MARI_DIR_PERMISSION);

		$file_img=$_FILES['i_img']['name'];

		/*파일업로드*/
		if(!$file_img==""){
			$img_update="i_img = '".$file_img."',";
			if ($_FILES['i_img']['name']) upload_file($_FILES['i_img']['tmp_name'], $file_img, MARI_DATA_PATH."/security");
		}

		/*등록*/
		if($type=="w"){

						$sql="insert into mari_loan
								set i_payment = '$i_payment',
								m_id = '$m_id',
								m_name = '$m_name',
								i_newsagency = '$i_newsagency',
								m_hp = '$m_hp',
								i_pmyeonguija = '$i_pmyeonguija',
								i_myeonguija = '$i_myeonguija',
								i_locaty = '$i_locaty',
								i_locaty_01 = '$i_locaty_01',
								i_locaty_02 = '$i_locaty_02',
								i_purpose = '$i_purpose',
								i_loan_pay = '$i_loan_pay',
								i_year_plus = '$i_year_plus',
								i_repay = '$i_repay',
								i_repay_day = '$i_repay_day',
								i_loan_day = '$i_loan_day',
								i_educa = '$i_educa',
								i_traffic = '$i_traffic',
								i_loan_type = '$i_loan_type',
								i_ltext = '$i_ltext',
								i_ltv = '$i_ltv',
								i_subject = '$i_subject',
								i_area = '$i_area',
								i_zone = '$i_zone',
								i_conni = '$i_conni',
								i_conni_admin = '$i_conni_admin',
								".$img_update."
								i_gener = '$i_gener',
								i_loan_pose = '$i_loan_pose',
								i_plan = '$i_plan',
								i_birth = '$i_birth',
								i_senior_price = '$i_senior_price',
								i_officeworkers = '$i_officeworkers',
								i_occu = '$i_occu',
								i_company_name = '$i_company_name',
								i_rectal_address = '$rectal_address',
								i_businesshp = '$i_businesshp',
								i_employment = '$i_employment',
								i_company_day = '$i_company_day',
								i_plus_pay_mon = '$i_plus_pay_mon',
								i_plus_pay_year = '$i_plus_pay_year',
								i_out_paper = '$i_out_paper',
								i_wedding = '$i_wedding',
								i_home_ok = '$i_home_ok',
								i_home_me = '$i_home_me',
								i_home_stay = '$i_home_stay',
								i_car_ok = '$i_car_ok',
								i_veteran = '$i_veteran',
								i_home_address = '$home_address',
								i_creditpoint_one = '$i_creditpoint_one',
								i_creditpoint_two = '$i_creditpoint_two',
								i_loanexecutiondate = '$i_loanexecutiondate',
								i_loanapproval = '$i_loanapproval',
								i_security_type = '$i_security_type',
								i_regdatetime = '$date'
								";
					sql_query($sql);
					/*부체내역*/
					$tmp_g_option = array();
					if(count($i_debt_name) > 0)
					{
						for($i=0;$i<count($i_debt_name);$i++)
						{
							if($i_debt_name[$i]!="")
							{
								$i_debt_pay[$i] = (string)$i_debt_pay[$i];
								$i_debt_pay[$i] = preg_replace("/[^0-9]/", "",$i_debt_pay[$i]);
								$i_debt_pay[$i] = (int)$i_debt_pay[$i];

								$tmp_option = "".$i_debt_company[$i]."[FIELD]".$i_debt_name[$i]."[FIELD]".$i_debt_pay[$i]."[FIELD]".$i_debt_kinds[$i]."";
							}
							$tmp_g_option[] = $tmp_option;
						}
						$i_debt_list = implode("[RECORD]",$tmp_g_option);
					}

					if($uptype=="insert"){

							$sql="insert into mari_debt
										set i_debt_list='$i_debt_list',
										m_id ='$m_id'
										";
							sql_query($sql);
					}else if($uptype="update"){
							$sql="update mari_debt
										set i_debt_list='$i_debt_list',
										m_id ='$m_id'
										where m_id = '$m_id'
										";
							sql_query($sql);
					}

				alert('정상적으로 저장 하였습니다.','?cms=loan_list');
		}else if($type=="m"){
			$sql = " select i_img from mari_loan where i_id='$i_id'";
			$d_file = sql_fetch($sql, false);

			/*file 삭제*/
			if($d_img=="1"){
				$img_update="i_img	 = '',";
				@unlink(MARI_DATA_PATH."/security/".$d_file[i_img]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['i_img'])) {
					delete_board_thumbnail('security', $d_file['i_img']);
				}
			}


			/*수정*/

					$sql="update mari_loan
							set i_payment = '$i_payment',
							m_id = '$m_id',
							m_name = '$m_name',
							i_newsagency = '$i_newsagency',
							m_hp = '$m_hp',
							i_pmyeonguija = '$i_pmyeonguija',
							i_myeonguija = '$i_myeonguija',
							i_locaty = '$i_locaty',
							i_locaty_01 = '$i_locaty_01',
							i_locaty_02 = '$i_locaty_02',
							i_purpose = '$i_purpose',
							i_loan_pay = '$i_loan_pay',
							i_year_plus = '$i_year_plus',
							i_repay = '$i_repay',
							i_repay_day = '$i_repay_day',
							i_loan_day = '$i_loan_day',
							i_educa = '$i_educa',
							i_traffic = '$i_traffic',
							i_loan_type = '$i_loan_type',
							i_ltext = '$i_ltext',
							i_ltv = '$i_ltv',
							i_subject = '$i_subject',
							i_area = '$i_area',
							i_zone = '$i_zone',
							i_conni = '$i_conni',
							i_conni_admin = '$i_conni_admin',
							".$img_update."
							i_gener = '$i_gener',
							i_loan_pose = '$i_loan_pose',
							i_plan = '$i_plan',
							i_birth = '$i_birth',
							i_officeworkers = '$i_officeworkers',
							i_senior_price = '$i_senior_price',
							i_occu = '$i_occu',
							i_company_name = '$i_company_name',
							i_rectal_address = '$rectal_address',
							i_businesshp = '$i_businesshp',
							i_employment = '$i_employment',
							i_company_day = '$i_company_day',
							i_plus_pay_mon = '$i_plus_pay_mon',
							i_plus_pay_year = '$i_plus_pay_year',
							i_out_paper = '$i_out_paper',
							i_wedding = '$i_wedding',
							i_home_ok = '$i_home_ok',
							i_home_me = '$i_home_me',
							i_home_stay = '$i_home_stay',
							i_car_ok = '$i_car_ok',
							i_veteran = '$i_veteran',
							i_home_address = '$home_address',
							i_creditpoint_one = '$i_creditpoint_one',
							i_creditpoint_two = '$i_creditpoint_two',
							i_regdatetime = '$date',
							i_loanexecutiondate = '$i_loanexecutiondate',
							i_loanapproval = '$i_loanapproval',
							i_security_type = '$i_security_type'
						where i_id = '$i_id'
						";
				sql_query($sql);
				/*부체내역*/
				$tmp_g_option = array();
				if(count($i_debt_name) > 0)
				{
					for($i=0;$i<count($i_debt_name);$i++)
					{
						if($i_debt_name[$i]!="")
						{
							$i_debt_pay[$i] = (string)$i_debt_pay[$i];
							$i_debt_pay[$i] = preg_replace("/[^0-9]/", "",$i_debt_pay[$i]);
							$i_debt_pay[$i] = (int)$i_debt_pay[$i];

							$tmp_option = "".$i_debt_company[$i]."[FIELD]".$i_debt_name[$i]."[FIELD]".$i_debt_pay[$i]."[FIELD]".$i_debt_kinds[$i]."";
						}
						$tmp_g_option[] = $tmp_option;
					}
					$i_debt_list = implode("[RECORD]",$tmp_g_option);
				}


				if($uptype=="insert"){

						$sql="insert into mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$m_id'
									";
						sql_query($sql);
				}else if($uptype=="update"){
						$sql="update mari_debt
									set i_debt_list='$i_debt_list',
									m_id ='$m_id'
									where m_id = '$m_id'
									";
						sql_query($sql);
				}

				alert('정상적으로 수정 하였습니다.');
		/*월불입금정산*/
		}else if ($add_bt == "입금처리") {
				if (!count($check)) {
					alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
				}
					/*월원금 구하기*/
					/*$to_ln_money=$o_ln_money/$o_maturity;*/
					for ($i=0; $i<count($check); $i++)
					{
						$k = $check[$i];

						/*콤마제거*/
						$o_mh_money[$k] = preg_replace("/[^0-9]/", "",$o_mh_money[$k]);
						$o_odinterestcount[$k]=number_format($o_odinterestcount[$k]);/*월이자(투자자)*/
						$o_amount[$k] = preg_replace("/[^0-9]/", "",$o_amount[$k]);
						$o_odinterestcount[$k] = preg_replace("/[^0-9]/", "",$o_odinterestcount[$k]);
						if($o_status[$k]=="연체"){
							if(!$o_odinterestcount[$k]){
							alert('연체일수를 입력하여 주십시오.');
							exit;
							}
						}
						if(!$o_status[$k]){
							alert('채무자상태를 선택하여 주십시오.');
							exit;
						}

						/*투자자정보*/
						$sql = "select  m_id, m_name from  mari_invest where loan_id='$loan_id'";
						$loa = sql_fetch($sql, false);
						/*투자자정보 for*/
						$sql = "select * from  mari_invest where loan_id='$loan_id'";
						$invest_up = sql_query($sql, false);
						/*연체설정정보*/
						$sql = "select  i_overint from  mari_inset";
						$is_ck = sql_fetch($sql, false);
						/*연체횟수가 있을경우 연체이자합산*/
						if($o_status[$k]=="연체"){
							/*공식 연체이자=월원금 × 연체일수 ÷ 365 ÷ 연이율%*/
							$i_overint="".$is_ck[i_overint]."";
							$o_odinterest=$to_ln_money[$k]*$o_odinterestcount[$k]/365*$i_overint;
							$totalblackmh_money=$o_odinterest+$o_mh_money[$k];
							$topblackmh_money=ceil($totalblackmh_money);
							$o_blackmh_money="o_mh_money = '$topblackmh_money',";
							$o_odinterest_add="o_odinterest = '$o_odinterest',";
						}else{
							$o_blackmh_money="o_mh_money = '$o_mh_money[$k]',";
						}



						for ($i=0; $row=sql_fetch_array($invest_up); $i++) {
						/*정산정보*/
						$sql = "select  sale_id, o_id from  mari_order where loan_id='$loan_id' and sale_id='$row[m_id]' and o_count='$o_count[$k]'";
						$order_ck = sql_fetch($sql, false);

								if(!$order_ck['sale_id']){
									/*신규정산일경우 insert*/
									$sql = " insert into mari_order
													set loan_id = '$loan_id',
														user_id = '$user_id',
														user_name = '$user_name',
														sale_id = '$row[m_id]',
														sale_name = '$row[m_name]',
														o_ipay = '$row[i_pay]',
														o_subject = '$o_subject',
														o_maturity = '$o_maturity',
														o_payment = '$o_payment',
														o_count = '$o_count[$k]',
														".$o_blackmh_money."
														o_interestrate = '$o_interestrate[$k]',
														o_amount = '$o_amount[$k]',
														o_ln_iyul = '$o_ln_iyul[$k]',
														o_ln_money = '$to_ln_money[$k]',
														".$o_odinterest_add."
														o_odinterestcount = '$o_odinterestcount[$k]',
														o_datetime = '$date',
														o_totalamount = '$o_totalamount[$k]',
														o_type = 'user',
														o_salestatus = '$o_salestatus[$k]',
														o_status = '$o_status[$k]',
														i_loan_type = '$loan_type[$k]'
														";
									sql_query($sql);
								}else{
									/*이미정보가 있을경우 update*/
									$sql = " update mari_order
													set o_payment = '$o_payment',
														o_count = '$o_count[$k]',
														".$o_blackmh_money."
														o_amount = '$o_amount[$k]',
														o_ln_money = '$to_ln_money[$k]',
														".$o_odinterest_add."
														o_odinterestcount = '$o_odinterestcount[$k]',
														o_datetime = '$date',
														o_totalamount = '$o_totalamount[$k]',
														o_salestatus = '$o_salestatus[$k]',
														o_type = 'user',
														o_status = '$o_status[$k]'
														where loan_id='$loan_id' and sale_id='$order_ck[sale_id]' and o_count='$o_count[$k]'";
									sql_query($sql);
								}



										/*------------투자자정산-----------*/


										/*회원정보 찾기 원천징수때문에*/
										$sql = "select * from mari_member where m_id='$row[m_id]'";
										$wit = sql_fetch($sql, false);

										/*투자자정보*/
										$sql = "select * from  mari_invest where loan_id='$loan_id' and m_id='$row[m_id]'";
										$sloa = sql_fetch($sql, false);

										/*연체설정정보*/
										$sql = "select * from  mari_inset";
										$is_ck = sql_fetch($sql, false);


										/*NEW★ 가이드라인 투자자별 수수료설정 2017-10-10 START*/
										if($wit[m_level]=="2"){
											if($wit[m_signpurpose]=="I"){
												$i_profit=$is_ck['i_profit_in'];//소득적격투자자
											}else if($wit[m_signpurpose]=="P"){
												$i_profit=$is_ck['i_profit_pro'];//전문투자자
											}else{
												$i_profit=$is_ck['i_profit'];//개인투자자
											}
										}else if($wit[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
										}else{
											if($wit[m_signpurpose]=="I"){
												$i_profit=$is_ck['i_profit_in'];//소득적격투자자
											}else if($wit[m_signpurpose]=="P"){
												$i_profit=$is_ck['i_profit_pro'];//전문투자자
											}else{
												$i_profit=$is_ck['i_profit'];//개인투자자
											}
										}
										/*NEW★ 가이드라인 투자자별 수수료설정 2017-10-10 END*/

										$sql = "select  * from  mari_loan where i_id='$loan_id'";
										$loan = sql_fetch($sql, false);

										/*결제상세*/
										$sql = "select  * from  mari_invest where loan_id='$loan_id'";
										$iv = sql_fetch($sql, false);



										$ln_money=$loan['i_loan_pay']; //대출금액
									if($i_repay=="만기일시상환선취"){
										$sale_ln_kigan=$loan['i_loan_day']+1; //대출기간
									}else{
										$sale_ln_kigan=$loan['i_loan_day']; //대출기간
									}
										$sale_ln_iyul=$loan['i_year_plus']; //대출이율
										$sale_order_pay_add=$sloa['i_pay'];//투자원금
										if(!$loan_id){
										}else{
										/*$isale_order_pay=$sloa['i_pay']*$i_profit;
										$sale_order_pay_add=$sloa['i_pay']-$isale_order_pay;*/


										$sale_ln_kigan = $sale_ln_kigan - $stop;

										$일년이자 = $sale_order_pay_add*($sale_ln_iyul/100);

										if($i_repay=="일만기일시상환"){
											$첫달이자 = substr(($일년이자/365),0,-1)."0";
											/*일상환방식정용시 추가 start*/
											/*해당월 매회차 마지막날짜구하기*/
											$order_month = date("Y-m-d", strtotime($loan[i_loanexecutiondate]."+".$i_reday[$k]."month"));
											$jinday_count = date('t', strtotime("".$order_month.""));
											/*일자별 이자계산*/
											$첫달이자=$첫달이자*$jinday_count;

										}else{
											$첫달이자 = substr(($일년이자/12),0,-1)."0";
										}

										$maturity_money = $첫달이자;

										if($i_repay=="원리금균등상환"){

										$rate = (($sale_ln_iyul/100)/12);
										$sale_month_money = ($sale_order_pay_add*$rate*pow((1+$rate),$sale_ln_kigan)/(pow((1+$rate),$sale_ln_kigan)-1));

										}else if($i_repay=="일만기일시상환"){
											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*원금+1회이자*/
												$sale_month_money=$sale_order_pay_add+$maturity_money;
											}else{
												$sale_month_money = $첫달이자;
											}
										}else if($i_repay=="만기일시상환"){
											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*원금+1회이자*/
												$sale_month_money=$sale_order_pay_add+$maturity_money;
											}else{
												$sale_month_money = $첫달이자;
											}
										}else if($i_repay=="만기일시상환선취"){
											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*선취시 원금만*/
												$sale_month_money=$sale_order_pay_add;
											}else{
												$sale_month_money = $첫달이자;
											}
										}

										/*월불입금 총계*/
										$sale_month_total=$sale_month_money*$sale_ln_kigan;

										/*총이자금액*/
										//q *12-p0 = {12*r*(1+r)^12/[(1+r)^12-1]-1} * p0
											//매달내야하는금액 * 12 - 대출원금 = {12*월이율*(1+월이율)^12/[(1+월이율)^12-1]-1} * 대출원금
										//($sale_month_money*12)-$sale_order_pay_add = ( (12*$sale_month_eja*pow(1+$sale_month_eja,12)) / ((pow(1+$sale_month_eja,12)-1)) -1) * $sale_order_pay_add;


										/*소수점이하 제거*/
										/*월불입금*/
										$sale_mh_money=floor($sale_month_money);

										/*월불입금 총계*/
										$sale_mh_total=floor($sale_month_total);

										/*월불입 수익금계산*/
										$sale_month_profit=$sale_mh_money;
										/*월불입 수익총계계산*/
										$total_profit=$sale_mh_total;
										$total_profit=floor($total_profit);
										$psale_money=$sale_mh_money-$sale_month_profit;
										$psale_totalmoney=$total_profit;
										/*월불입금, 수익총계 소수점이하제거*/
										$sale_money=floor($psale_money);
										$sale_totalmoney=floor($psale_totalmoney);
										/*월수익금 원금+이자*/
										$calculate_money=$sale_totalmoney/$sale_ln_kigan;

										if($i_repay=="원리금균등상환"){



								/*원리금 균등상환 금액구하기 start*/

								$sale_ln_kigan = $sale_ln_kigan - $stop;

								$일년이자 = $sale_order_pay_add*($sale_ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$rate = (($sale_ln_iyul/100)/12);
								$상환금 = ($sale_order_pay_add*$rate*pow((1+$rate),$sale_ln_kigan)/(pow((1+$rate),$sale_ln_kigan)-1));

								   for($or =0 ; $or <$sale_ln_kigan; ++$or){

									$납입원금계[$i] += ($상환금-$첫달이자);
									$잔금 = $sale_order_pay_add-$납입원금계[$i];
									$납입원금 = $상환금-$첫달이자;
									$num=$or+1;

											/*회차별 원금*/
											$to_ln_money_a_data=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금);
											$to_ln_money_a_data = preg_replace("/[^0-9]/", "",$to_ln_money_a_data);

											/*회차별 이자*/
											$o_interest_data=number_format($첫달이자);
											$o_interest_data = preg_replace("/[^0-9]/", "",$o_interest_data);


										/*해당 회차 1개만 update하도록*/
										if($num==$o_count[$k]){
												/*회차별 원금*/
															$sql = "update  mari_invest
																			set to_ln_money_a_data = '".$to_ln_money_a_data."',
																				o_interest_data = '".$o_interest_data."',
																				i_count = '".$o_count[$k]."'
																				 where loan_id='$loan_id' and m_id='".$row[m_id]."'";
															sql_query($sql);
										}
								$이자합산 += $첫달이자;
								$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
								$월불입금합산=$납입원금합산+$이자합산;
								$일년이자 = $잔금*($sale_ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";

								   }

								/*원리금 균등상환 금액구하기 end*/




											/*현재 회차 정산내용 찾기*/
											$sql = "select * from mari_invest where  loan_id='$loan_id' and m_id='$row[m_id]' and i_count='$o_count[$k]'";
											$salecount = sql_fetch($sql, false);
											/*해당회차의 원금*/
											$to_ln_money_a=$salecount['to_ln_money_a_data'];

											$isale_order_pay=$to_ln_money_a*$i_profit;
											$to_ln_money=$to_ln_money_a-$isale_order_pay;

										}else if($i_repay=="일만기일시상환" || $i_repay=="만기일시상환"){

											/*월원금*/
											$to_ln_money_a=$sale_order_pay_add;
											/*마지막회차에만 플랫폼수수료 포함*/
											if($o_maturity==$o_count[$k]){
												$isale_order_pay=$sale_order_pay_add*$i_profit;
											}else{
											/*일반회차에도 수수료반영*/
												$isale_order_pay=$sale_order_pay_add*$i_profit;
											}

											$to_ln_money=$sale_order_pay_add-$isale_order_pay;


										}else if($i_repay=="만기일시상환선취"){

											/*월원금*/
											$to_ln_money_a=$sale_order_pay_add;
											$isale_order_pay=$to_ln_money_a*$i_profit;
											$to_ln_money=$to_ln_money_a-$isale_order_pay;
										}

											/*투자자정보*/

										$sql = "select o_status from  mari_order where loan_id='$loan_id' and o_count='$o_count[$k]' and sale_id='$row[m_id]'";
										$sale_o = sql_fetch($sql, false);

											/*연체횟수가 있을경우 연체이자합산*/
											if(!$o_odinterestcount[$k]){
												$s_o_blackmh_money="o_investamount = '$calculate_money',";
											}else{
												/*공식 연체이자=월원금 × 연체일수 ÷ 365 ÷ 연이율%*/
												$s_i_overint="".$is_ck[i_overint]."";
												$s_o_odinterest=$to_ln_money_a*$o_odinterestcount[$k]/365*$s_i_overint;
												$s_o_odinterest=floor($s_o_odinterest);
												$s_totalblackmh_money=$s_o_odinterest+$calculate_money;
												$s_topblackmh_money=floor($s_totalblackmh_money);
												$s_o_blackmh_money="o_investamount = '$s_topblackmh_money',";
												$s_o_saleodinterest="o_saleodinterest = '$s_o_odinterest',";
											}
										}

									if(!$o_odinterestcount[$k]){
										$s_o_salestatus="o_salestatus = '정산완료'";
									}else{
										$s_o_salestatus="o_salestatus = '연체중'";
									}


										if($i_repay=="원리금균등상환"){
											/*현재 회차 정산내용 찾기*/
											$sql = "select * from mari_invest where  loan_id='$loan_id' and m_id='$row[m_id]' and i_count='$o_count[$k]'";
											$salecount = sql_fetch($sql, false);
											/*해당회차의 이자*/
											$o_interest=$salecount['o_interest_data'];

										}else if($i_repay=="만기일시상환" || $i_repay=="일만기일시상환" || $i_repay=="만기일시상환선취"){

											/*이자계산*/
											$o_interest=$sale_order_pay_add;
										}

										/*NEW★ 가이드라인 투자자별 원천징수 설정 2017-10-10 START*/
										if($wit[m_level]=="2"){
											if($wit[m_signpurpose]=="I"){
												$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
												$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
											}else if($wit[m_signpurpose]=="P"){
												$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
												$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
											}else{
												$i_withholding=$is_ck['i_withholding_personal'];//개인투자자
												$i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
											}
										}else if($wit[m_level]>=3){
											$i_withholding=$is_ck['i_withholding_burr'];
											$i_withholding_v=$is_ck['i_withholding_burr_v'];
										}else{
											if($wit[m_signpurpose]=="I"){
												$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
												$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
											}else if($wit[m_signpurpose]=="P"){
												$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
												$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
											}else{
												$i_withholding=$is_ck['i_withholding_personal'];//개인투자자
												$i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
											}
										}
										/*NEW★ 가이드라인 투자자별 원천징수 설정 2017-10-10 END*/

										if($i_repay=="원리금균등상환"){
											/*연체이자가 있을경우 연체합산*/
											if($s_o_odinterest){
												$o_interest=$o_interest+$s_o_odinterest;
												$withholding_a=$o_interest*$i_withholding;
														$withholding_b=$o_interest*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($o_interest<$is_ck['i_exemption_pay']){
														$withholding="0";
													}else{
														$withholding_a=$o_interest*$i_withholding;
														$withholding_b=$o_interest*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
													}
												}else{
														$withholding_a=$o_interest*$i_withholding;
														$withholding_b=$o_interest*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}
											}else{
												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($o_interest<$is_ck['i_exemption_pay']){
														$withholding="0";
													}else{
														$withholding_a=$o_interest*$i_withholding;
														$withholding_b=$o_interest*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
													}
												}else{
														$withholding_a=$o_interest*$i_withholding;
														$withholding_b=$o_interest*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}

											}
												$withholding=func($withholding);

												$withholding_ok=$o_interest-$withholding;
										}else if($i_repay=="만기일시상환"){

											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*마지막회차수익 order*/
												$order_maturity_money=$sale_order_pay_add+$첫달이자;
												$maturity_money = $첫달이자;
												/*원금+1회이자*/




												/*연체이자가 있을경우 연체합산*/
												if($s_o_odinterest){
													$maturity_money=$maturity_money+$s_o_odinterest;
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}else{
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}
												if($is_ck['i_exemption_use']=="Y"){
													if($maturity_money<$is_ck['i_exemption_pay']){
														$withholding="0";
													}else{
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
													}
												}else{
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}


												$withholding=$withholding;
												$withholding=func($withholding);
												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($maturity_money<$is_ck['i_exemption_pay']){
														$withholding_ok=$maturity_money;
														$withholding="0";
													}else{
														$withholding_ok=$maturity_money-$withholding;
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
													}
												}else{
														$withholding_ok=$maturity_money-$withholding;
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
												}
												$o_interest_re="o_interest = '".$order_maturity_money."',";
											}else{
												$maturity_money = $첫달이자;

												/*연체이자가 있을경우 연체합산*/
												if($s_o_odinterest){
													$maturity_money=$maturity_money+$s_o_odinterest;
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}else{
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}

												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($maturity_money<$is_ck['i_exemption_pay']){
														$withholding_ok=$sale_month_money;
														$withholding="0";
													}else{
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
														$withholding_ok=$maturity_money-$withholding;
													}
												}else{
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
														$withholding_ok=$maturity_money-$withholding;
												}
												$o_interest_re="o_interest = '".$maturity_money."',";
											}
										}else if($i_repay=="일만기일시상환"){

											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*마지막회차수익 order*/
												$order_maturity_money=$sale_order_pay_add+$첫달이자;
												$maturity_money = $첫달이자;
												/*원금+1회이자*/




												/*연체이자가 있을경우 연체합산*/
												if($s_o_odinterest){
													$maturity_money=$maturity_money+$s_o_odinterest;
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}else{
													$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}
												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
														if($maturity_money<$is_ck['i_exemption_pay']){
															$withholding="0";
														}else{
															$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														}
												}else{
															$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}


												$withholding=$withholding;
												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($maturity_money<$is_ck['i_exemption_pay']){
														$withholding_ok=$maturity_money;
														$withholding="0";
													}else{
														$withholding_ok=$maturity_money-$withholding;
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
													}
												}else{
														$withholding_ok=$maturity_money-$withholding;
														$withholding_a=$maturity_money*$i_withholding;
														$withholding_b=$maturity_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
												}
												$o_interest_re="o_interest = '".$order_maturity_money."',";
											}else{

												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($sale_month_money<$is_ck['i_exemption_pay']){
														$withholding_ok=$sale_month_money;
														$withholding="0";
													}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
														$withholding_ok=$sale_month_money-$withholding;
													}
												}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
														$withholding=func($withholding);
														$withholding_ok=$sale_month_money-$withholding;
												}
												$o_interest_re="o_interest = '".$maturity_money."',";
											}
										}else if($i_repay=="만기일시상환선취"){

											/*정산시회차가 마지막회차랑 동일할경우 정산금액변동*/
											if($o_maturity==$o_count[$k]){
												/*마지막회차수익 order 선취시 원금만*/
												$order_maturity_money=$sale_order_pay_add;
												$o_interest_re="o_interest = '".$order_maturity_money."',";
											}else{
												/*연체이자가 있을경우 연체합산*/
												if($s_o_odinterest){
													$sale_month_money=$sale_month_money+$s_o_odinterest;

												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($sale_month_money<$is_ck['i_exemption_pay']){
														$withholding="0";
													}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
													}
												}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}

													$withholding=func($withholding);
													$withholdingtest=$sale_month_money+$s_o_odinterest;
												}else{


												/*원천징수 설정한금액 이하일경우 미발생하도록 */
												if($is_ck['i_exemption_use']=="Y"){
													if($sale_month_money<$is_ck['i_exemption_pay']){
														$withholding="0";
													}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
													}
												}else{
														$withholding_a=$sale_month_money*$i_withholding;
														$withholding_b=$sale_month_money*$i_withholding_v;
														/*이자소득세,주민세분리 2017-10-19 추가*/
														$withholding=$withholding_a+$withholding_b;
												}

													$withholding=func($withholding);
												}

												$withholding=func($withholding);

												$withholding_ok=$sale_month_money-$withholding;
												$o_interest_re="o_interest = '".$maturity_money."',";
											}
										}


									$o_interest=number_format($o_interest);/*월이자(투자자)*/
									$to_ln_money_a=number_format($to_ln_money_a);/*월원금(투자자)*/
									/*콤마제거*/
									$o_interest = preg_replace("/[^0-9]/", "",$o_interest);/*월이자(투자자)*/
									$to_ln_money_a = preg_replace("/[^0-9]/", "",$to_ln_money_a);/*월원금(투자자)*/


									/*이미 정산,연체 되었는지체크*/
									if($sale_o['o_salestatus']=="정산완료" || $o_status[$k]=="연체"){
									}else{
										if($i_repay=="원리금균등상환"){
										$sql = "update  mari_order
														set loan_id = '$loan_id',
															sale_id = '$row[m_id]',
															sale_name = '$row[m_name]',
															".$s_o_blackmh_money."
															o_interestrate = '$o_interestrate[$k]',
															o_saleln_money = '$to_ln_money_a',
															".$s_o_saleodinterest."
															o_odinterestcount = '$o_odinterestcount[$k]',
															o_interest = '$o_interest',
															o_ln_money_to = '$to_ln_money_a',
															o_collectiondate = '$date',
															o_saletotalamount = '$calculate_money',
															o_ipay = '$sale_order_pay_add',
															o_withholding = '$withholding',
															o_type = 'sale',
															o_paytype = '$i_repay',
															o_interestrate = '$o_interestrate[$k]',
															".$s_o_salestatus."
															where loan_id='$loan_id' and o_count='$o_count[$k]' and sale_id='$row[m_id]'";
										sql_query($sql);
										}else if($i_repay=="만기일시상환" || $i_repay=="일만기일시상환" || $i_repay=="만기일시상환선취"){
										$sql = "update  mari_order
														set loan_id = '$loan_id',
															sale_id = '$row[m_id]',
															sale_name = '$row[m_name]',
															".$s_o_blackmh_money."
															o_interestrate = '$o_interestrate[$k]',
															o_saleln_money = '$to_ln_money_a',
															".$s_o_saleodinterest."
															o_odinterestcount = '$o_odinterestcount[$k]',
															".$o_interest_re."
															o_ln_money_to = '$to_ln_money_a',
															o_collectiondate = '$date',
															o_saletotalamount = '$calculate_money',
															o_ipay = '$sale_order_pay_add',
															o_withholding = '$withholding',
															o_type = 'sale',
															o_paytype = '$i_repay',
															o_interestrate = '$o_interestrate[$k]',
															".$s_o_salestatus."
															where loan_id='$loan_id' and o_count='$o_count[$k]' and sale_id='$row[m_id]'";
										sql_query($sql);
										}
									}
									/*이미 정산,연체 되었는지체크*/
									if($sale_o['o_salestatus']=="정산완료" || $o_status[$k]=="연체"){
									}else{


										/*회원정보 찾기 e-머니정산 때문에*/
											$sql = "select * from mari_member where m_id='$row[m_id]'";
											$em = sql_fetch($sql, false);
										/*아이디 체크*/

												/*연체횟수가 있을경우 연체이자합산*/
												if(!$o_odinterestcount[$k]){
													$p_emoney=$calculate_money;
												}else{
													/*공식 연체이자=월원금 × 연체일수 ÷ 365 ÷ 연이율%*/
													$s_i_overint="".$is_ck[i_overint]."";
													$s_o_odinterest=$to_ln_money_a*$o_odinterestcount[$k]/365*$s_i_overint;
													if($i_repay=="만기일시상환" || $i_repay=="일만기일시상환" || $i_repay=="만기일시상환선취"){
														$maturity_money=$maturity_money;
													}else{
														$p_emoney=$calculate_money+$s_o_odinterest;
													}
												}

												/*상점 수수료를제외한 금액*/
												/*
												$수수료금액=$p_emoney*$i_profit;
												$수수료금액=floor($수수료금액);
												$수수료제외금액=$p_emoney-$수수료금액;
												*/
												/*수수료제외*/
												if($i_repay=="원리금균등상환"){
												/*원천징수수수료를 제외한 입금액*/
													$pw_emoney=$p_emoney-$withholding;
													$gpw_emoney=$pw_emoney-$isale_order_pay;
												}else if($i_repay=="만기일시상환"){


													/*원천징수 설정한금액 이하일경우 미발생하도록 */
													if($is_ck['i_exemption_use']=="Y"){
														if($maturity_money<$is_ck['i_exemption_pay']){
															$pw_emoney=$maturity_money;
														}else{
															$pw_emoney=$maturity_money-$withholding;
														}
													}else{
															$pw_emoney=$maturity_money-$withholding;
													}


													/*마지막회차 원금+계산된이자*/
													if($o_maturity==$o_count[$k]){
														$total_emoney=$sale_order_pay_add*$i_profit;
														$total_emoney=$total_emoney;
														$sale_order_pay_add_a=$sale_order_pay_add-$total_emoney;
														$gpw_emoney_last=$sale_order_pay_add_a+$pw_emoney;
														$gpw_emoney=$gpw_emoney_last;
													}else{
													$total_emoney=$maturity_money;
													$total_emoney_a=$sale_order_pay_add*$i_profit;
													$total_emoney=$total_emoney;
														$gpw_emoney=$pw_emoney-$total_emoney_a;
													}
												}else if($i_repay=="일만기일시상환"){


													/*원천징수 설정한금액 이하일경우 미발생하도록 */
													if($is_ck['i_exemption_use']=="Y"){
														if($maturity_money<$is_ck['i_exemption_pay']){
															$pw_emoney=$maturity_money;
														}else{
															$pw_emoney=$maturity_money-$withholding;
														}
													}else{
															$pw_emoney=$maturity_money-$withholding;
													}


													/*마지막회차 원금+계산된이자*/
													if($o_maturity==$o_count[$k]){
														$total_emoney=$sale_order_pay_add*$i_profit;
														$total_emoney=$total_emoney;
														$sale_order_pay_add_a=$sale_order_pay_add-$total_emoney;
														$gpw_emoney_last=$sale_order_pay_add_a+$pw_emoney;
														$gpw_emoney=$gpw_emoney_last;
													}else{
													$total_emoney=$maturity_money;
													$total_emoney=$total_emoney;
														$gpw_emoney=$pw_emoney;
													}

												}else if($i_repay=="만기일시상환선취"){


													$pw_emoney=$maturity_money-$withholding;
													/*$pw_emoney=$maturity_money-$atotal_emoney;*/

													$total_emoney=$maturity_money/365*$i_reday[$k];
													/*마지막회차 원금+계산된이자*/
													if($o_maturity==$o_count[$k]){
														$total_emoney=$sale_order_pay_add*$i_profit/365*$jinday_count;
														$gpw_emoney_last=$pw_emoney-$total_emoney;
														$gpw_emoney=$sale_order_pay_add-$total_emoney;
													}else{
														$gpw_emoney=$pw_emoney-$total_emoney;
													}
												}

											$gpw_emoney=number_format($gpw_emoney);/*최종정산금액(투자자)*/
											$gpw_emoney = preg_replace("/[^0-9]/", "",$gpw_emoney);/*월원금(투자자)*/
											/*포인트 합산*/
											$p_top_emoney=$gpw_emoney+$em['m_emoney'];

										/*투자자 정산후정보*/
										$sql = "select o_id from  mari_order where  loan_id='$loan_id' and o_count='$o_count[$k]' and sale_id='$row[m_id]'";
										$sale_num = sql_fetch($sql, false);
										/*포인트지급내용 저장*/
											$sql = " insert into mari_emoney
														set m_id = '$row[m_id]',
														p_datetime = '$date',
														p_content = '".$o_subject."투자건 ".$o_count[$k]."회차 정산금',
														p_emoney = '$gpw_emoney',
														loan_id = '$loan_id',
														o_id = '$sale_num[o_id]',
														p_ip = '$ip',
														p_top_emoney = '$p_top_emoney'";
											sql_query($sql);

										/*회원에게 포인트지급*/
											$sql = " update mari_member
														set m_emoney = '$p_top_emoney'
														where m_id = '$row[m_id]'";
											sql_query($sql);

						/*세이퍼트 투자자 에스크로이체하여 정산주기*/
						/*seyfert가상계좌 시스템 사용여부*/
						if($config['c_seyfertck']=="Y"){
						include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

						/*가상계좌 세이퍼트멤버생성정보*/
						$sql = "select  * from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
						$seyfck = sql_fetch($sql, false);

						/*페이게이트 정산nonce체크시 숫자변경*/
						$order_code = "O".time().rand(111,999);
						/*페이게이트 주문번호 생성*/
						$ju_code = "P".time().rand(111,999);

								/*발급받은 memGuid 조회*/
								$sql = "select  s_memGuid from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
								$bankck = sql_fetch($sql, false);
								$i_subject="".$loan_id."호 ".$o_subject." 투자건 정산";
								$ENCODE_PARAMS="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$order_code."&title=".urlencode($i_subject)."&refId=".$ju_code."&authType=SMS_MO&timeout=30&srcMemGuid=".$config[c_reqMemGuid]."&dstMemGuid=".$seyfck[s_memGuid]."&amount=".$gpw_emoney."&crrncy=KRW";

								$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
								$cipherEncoded = urlencode($cipher);
								$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

								/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

								$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/transfer?".$requestString;

								$curl_handlebank = curl_init();

								curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
								curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
								curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
								curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfert/transfer');
								$result = curl_exec($curl_handlebank);
								curl_close($curl_handlebank);

								/*파싱*/
								$decode = json_decode($result, true);


								print_r($requestPath);
								echo"<br/><br/>";
								print_r($result1);
								echo"<br/><br/>";
								print_r($ENCODE_PARAMS);


								echo"<br/><br/>데이터";
								print_r($decode);
								echo"<br/><br/>";

								/*주문번호저장*/
									$sql = "select  * from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
									$seyck = sql_fetch($sql, false);
										if($seyck['m_id']){

											$sql = " insert into mari_seyfert_order
														set s_refId='$ju_code',
															m_id='$row[m_id]',
															m_name='$row[m_name]',
															s_subject='$i_subject',
															loan_id='$loan_id',
															s_amount='$gpw_emoney',
															o_bankaccuse='Y',
															s_date='$date'";
											sql_query($sql);

											$sql = "select  * from mari_seyfert_order where m_id='$row[m_id]' and s_refId='$ju_code'";
											$orderseyck = sql_fetch($sql, false);

											if(!empty($decode)) {
											/*foreach 파싱 데이터출력*/
												foreach($decode as $key=>$value){
												/*1회만실행*/
												if(!$orderseyck['s_tid']){
													$tid=$value['tid'];/*생성된 맴버키*/
													if($tid=="S" || $tid=="E" || !$tid){
													}else{
														$sql = " update  mari_seyfert_order
																	set s_tid='$tid'
																		where s_refId='$ju_code'";
														sql_query($sql);
													/*
													print_r($tid);
													echo"<br/>test<br/>";
													*/
													}
												}
												}
											}

										}else{
										}



						}


						if($config['c_sms_use']=="Y"){
							if($load['invest_req_02']=="Y"){
								/*SMS자동전송 시작*/
								$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$row[m_id]'");

								/*휴대폰번호 분리*/
								$m_hp = $loadmem['m_hp'];
								$hp1=substr($m_hp,0,3);
								$hp2=substr($m_hp,3,-4);
								$hp3=substr($m_hp,-4);
								$to_hp="".$hp1."".$hp2."".$hp3."";

								/*문자치환*/
								$invest_msg_02 = str_replace("{이름}", $row[m_name], $invest_msg_02);
								$invest_msg_02 = str_replace("{제목}", $o_subject, $invest_msg_02);
								$invest_msg_02 = str_replace("{회차}", $o_count[$k], $invest_msg_02);


								/*80바이트 이상일경우 lms로 발송*/
								$message_msg=mb_strlen($invest_msg_02, "euc-kr");
								if($message_msg <=80){
									$sendSms="sendSms";
								}else{
									$sendSms="sendSms_lms";
								}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$invest_msg_02."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 ".$o_count[$k]."회차를 업데이트 하였습니다.",
								 "returnurl" => "".MARI_HOME_URL."?cms=".$update."&type=".$type."&i_id=".$loan_id.""
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/

							}
						}
									}
						}
					}
				alert('정상적으로 '.$o_count[$k].'회차를 업데이트 하였습니다.','?cms=loan_list');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;

/****************************************************************
대출실행처리 2017-07-05 임근호 가이드라인에 따른 업데이트
****************************************************************/
	case "loan_order":


					if($add_bt=="대출실행"){


						/*대출실행여부 확인*/
						$sql = "select i_pendingsf_use from mari_loan where m_id='$m_id' and i_id='$loan_id'";
						$pdsf = sql_fetch($sql, false);

						if($pdsf['i_pendingsf_use']=="Y"){
							alert('이미 대출이 실행 되었습니다!!');
							exit;
						}

						if($i_pendingsf_use=="N"){
							alert('지급여부를 선택하여 주시기바랍니다.');
							exit;
						}

						/*회원정보 찾기 e-머니정산 때문에*/
						$sql = "select * from mari_member where m_id='$m_id'";
						$em = sql_fetch($sql, false);

						/*포인트 합산*/
						$p_top_emoney=$i_loan_pay+$em['m_emoney'];

						/*포인트지급내용 저장*/
							$sql = " insert into mari_emoney
										set m_id = '$m_id',
										p_datetime = '$date',
										p_content = '".$o_subject." 대출건 ".$i_loan_pay."원 대출금 지급',
										p_emoney = '$i_loan_pay',
										loan_id = '$loan_id',
										o_id = '$loan_id',
										p_ip = '$ip',
										p_top_emoney = '$p_top_emoney'";
							sql_query($sql);

						/*회원에게 포인트지급*/
							$sql = " update mari_member
										set m_emoney = '$p_top_emoney'
										where m_id = '$m_id'";
							sql_query($sql);


						/*대출실행 update*/
							$sql = " update mari_loan
										set i_pendingsf_use ='Y'
										 where m_id = '$m_id' and i_id='$loan_id'";
							sql_query($sql);


						/*세이퍼트 투자자 에스크로이체하여 정산주기*/
						/*seyfert가상계좌 시스템 사용여부*/
						if($config['c_seyfertck']=="Y"){
						include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

						/*가상계좌 세이퍼트멤버생성정보*/
						$sql = "select  * from mari_seyfert where m_id='$m_id' and m_name='$m_name' and s_memuse='Y'";
						$seyfck = sql_fetch($sql, false);

						/*페이게이트 정산nonce체크시 숫자변경*/
						$loan_code_a = "O".time().rand(111,999);
						/*페이게이트 주문번호 생성*/
						$loan_code = "P".time().rand(111,999);


								$i_subject="".$m_name."대출자 ".$i_loan_pay."원 대출금지급";
								$ENCODE_PARAMS="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$loan_code_a."&title=".urlencode($i_subject)."&refId=".$loan_code."&authType=SMS_MO&timeout=30&srcMemGuid=".$config[c_reqMemGuid]."&dstMemGuid=".$seyfck[s_memGuid]."&amount=".$i_loan_pay."&crrncy=KRW";

								$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
								$cipherEncoded = urlencode($cipher);
								$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

								/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

								$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/transfer?".$requestString;

								$curl_handlebank = curl_init();

								curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
								curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
								curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
								curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfert/transfer');
								$result = curl_exec($curl_handlebank);
								curl_close($curl_handlebank);

								/*파싱*/
								$decode = json_decode($result, true);


								print_r($requestPath);
								echo"<br/><br/>";
								print_r($result1);
								echo"<br/><br/>";
								print_r($ENCODE_PARAMS);


								echo"<br/><br/>데이터";
								print_r($decode);
								echo"<br/><br/>";

								/*주문번호저장*/
									$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
									$seyck = sql_fetch($sql, false);
										if($seyck['m_id']){

											$sql = " insert into mari_seyfert_order
														set s_refId='$loan_code',
															m_id='$m_id',
															m_name='$m_name',
															s_subject='$i_subject',
															loan_id='$loan_id',
															s_amount='$i_loan_pay',
															o_bankaccuse='Y',
															s_date='$date'";
											sql_query($sql);

											$sql = "select  * from mari_seyfert_order where m_id='$m_id' and s_refId='$loan_code'";
											$orderseyck = sql_fetch($sql, false);

											if(!empty($decode)) {
											/*foreach 파싱 데이터출력*/
												foreach($decode as $key=>$value){
												/*1회만실행*/
												if(!$orderseyck['s_tid']){
													$tid=$value['tid'];/*생성된 맴버키*/
													if($tid=="S" || $tid=="E" || !$tid){
													}else{
														$sql = " update  mari_seyfert_order
																	set s_tid='$tid'
																		where s_refId='$loan_code'";
														sql_query($sql);
													/*
													print_r($tid);
													echo"<br/>test<br/>";
													*/
													}
												}
												}
											}

										}else{
										}



						}

						if($config['c_sms_use']=="Y"){
							if($load['invest_req_02']=="Y"){
								/*SMS자동전송 시작*/
								$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$m_id'");

								/*휴대폰번호 분리*/
								$m_hp = $loadmem['m_hp'];
								$hp1=substr($m_hp,0,3);
								$hp2=substr($m_hp,3,-4);
								$hp3=substr($m_hp,-4);
								$to_hp="".$hp1."".$hp2."".$hp3."";

								/*문자치환*/
								$invest_msg_02 = str_replace("{이름}", $row[m_name], $invest_msg_02);
								$invest_msg_02 = str_replace("{제목}", $o_subject, $invest_msg_02);
								$invest_msg_02 = str_replace("{회차}", $o_count[$k], $invest_msg_02);


								/*80바이트 이상일경우 lms로 발송*/
								$message_msg=mb_strlen($invest_msg_02, "euc-kr");
								if($message_msg <=80){
									$sendSms="sendSms";
								}else{
									$sendSms="sendSms_lms";
								}


								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$invest_msg_02."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "".$m_name."님 정상적으로 ".$i_loan_pay."원 대출금이 지급되었습니다.",
								 "returnurl" => "".MARI_HOME_URL."?cms=loan_form&type=".$type."&i_id=".$loan_id.""
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/

							}
						}

						alert(''.$m_name.'님 정상적으로 '.$i_loan_pay.'원 대출금이 지급되었습니다.');

					}else if($add_bt=="가상계좌해지"){

						alert(''.$m_name.'님의 가상계좌가 정상적으로 해지되었습니다.');
					}else{

						alert('정상적인 접근이 아닙니다.');
					}

	break;




/************************************************
투자신청 리스트관리
************************************************/
	case "invest_list":
				if ($add_bt == "선택취소") {

					if (!count($check)) {
						alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
					}
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

					/* 삭제*/
							$sql = "delete from mari_invest where i_id='$i_id[$k]'";
							sql_query($sql);
					}
				alert('정상적으로 삭제처리 하였습니다.');
				}else{
				alert('정상적인 접근이 아닙니다.');
				}
	break;

/************************************************
투자신청결제 리스트관리
************************************************/
	case "pay_list":
				if ($add_bt == "선택취소") {

					if (!count($check)) {
						alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
					}
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

					$sql = "select * from mari_invest where i_id = '$i_id[$k]'";
					$ivm = sql_fetch($sql,false);

					$sql = "select * from mari_member where m_id = '$ivm[m_id]'";
					$imem = sql_fetch($sql, false);

					$top_emoney = $imem[m_emoney] + $ivm[i_pay];

					$sql = "update mari_member
							set m_emoney = '$top_emoney'
							where m_id = '$imem[m_id]'";
					sql_query($sql);

					/*e-money내역리스트 추가
					$sql = "select * from mari_member where m_id = '$imem[m_id]'";
					$add = sql_fetch($sql, false);
					*/

					$sql = " insert into mari_emoney
									set m_id = '$imem[m_id]',
									p_datetime = '$date',
									p_content = '투자실패로 인한 투자금액 반환',
									p_emoney = '$ivm[i_pay]',
									p_ip = '$ip',
									p_top_emoney = '$top_emoney'";
					sql_query($sql);


					/* 삭제*/
							$sql = "delete from mari_invest where i_id='$i_id[$k]'";
							sql_query($sql);

						/*세이퍼트 투자자 펀딩이체취소*/
						/*seyfert가상계좌 시스템 사용여부*/
						if($config['c_seyfertck']=="Y"){
						include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

						/*가상계좌 세이퍼트멤버생성정보*/
						$sql = "select  * from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
						$seyfck = sql_fetch($sql, false);

						/*거래 취소를 위하여 투자자 기존거래정보*/
						$sql = "select * from mari_seyfert_order where m_id = '$ivm[m_id]' and loan_id='$loan_id[$k]' and s_payuse='Y'";
						$seyorder = sql_fetch($sql, false);

						/*대출상품정보*/
						$sql = "select i_subject from mari_loan where i_id = '$loan_id[$k]'";
						$loa_info = sql_fetch($sql);

						$order_cancel = "OC".time().rand(111,999);


								/*발급받은 memGuid 조회*/
								$sql = "select  s_memGuid from mari_seyfert where m_id='$ivm[m_id]' and s_memuse='Y'";
								$bankck = sql_fetch($sql, false);
								$i_subject="".$loa_info[i_subject]." 투자건 투자실패로 인한 투자금액 반환";
								$ENCODE_PARAMS="&_method=POST&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$order_cancel."".$i."&title=".urlencode($i_subject)."&refId=".$seyorder[s_refId]."&authType=SMS_MO&timeout=30&parentTid=".$seyorder[s_tid]."";

								$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
								$cipherEncoded = urlencode($cipher);
								$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

								/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

								$requestPath = "https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel?".$requestString;

								$curl_handlebank = curl_init();

								curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
								curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
								curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
								curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel');
								$result = curl_exec($curl_handlebank);
								curl_close($curl_handlebank);

								/*파싱*/
								$decode = json_decode($result, true);

								/*
								print_r($requestPath);
								echo"<br/><br/>";
								print_r($result1);
								echo"<br/><br/>";
								print_r($ENCODE_PARAMS);


								echo"<br/><br/>데이터";
								print_r($decode);
								echo"<br/><br/>";
								*/
								/*주문번호저장*/
									$sql = "select  * from mari_seyfert where m_id='$ivm[m_id]' and s_memuse='Y'";
									$seyck = sql_fetch($sql, false);
										if($seyck['m_id']){

											$sql = "select  * from mari_seyfert_order where m_id='$ivm[m_id]' and s_tid='".$seyorder[s_tid]."'";
											$orderseyck = sql_fetch($sql, false);

											if(!empty($decode)) {
											/*foreach 파싱 데이터출력*/
												foreach($decode as $key=>$value){
												/*1회만실행*/
												if(!$orderseyck['s_tid']){
													$tid=$value['tid'];/*생성된 맴버키*/
													if($tid=="S" || $tid=="E" || !$tid){
													}else{
														$sql = " update  mari_seyfert_order
																	set o_canceldate='$date',
																		 o_funding_cancel='Y'
																		where s_tid='$tid'";
														sql_query($sql);
													/*
													print_r($tid);
													echo"<br/>test<br/>";
													*/
													}
												}
												}
											}

										}else{
										}

						}

					}



				alert('정상적으로 삭제처리 하였습니다.');
				}else if($type=="w"){

					/*콤마제거*/
					$i_pay = (string)$i_pay;
					$i_pay = preg_replace("/[^0-9]/", "",$i_pay);
					$i_pay = (int)$i_pay;

					$i_loan_pay = (string)$i_loan_pay;
					$i_loan_pay = preg_replace("/[^0-9]/", "",$i_loan_pay);
					$i_loan_pay = (int)$i_loan_pay;

					$i_profit_pay = (string)$i_profit_pay;
					$i_profit_pay = preg_replace("/[^0-9]/", "",$i_profit_pay);
					$i_profit_pay = (int)$i_profit_pay;

					$sql = "update mari_invest
								set i_pay = '$i_pay',
								i_goods = '$i_goods',
								i_bid = '$i_bid',
								i_bid_char = '$i_bid_char',
								i_loan_pay = '$i_loan_pay',
								i_pay_ment = '$i_pay_ment',
								i_over_pay = '$i_over_pay',
								i_over_num = '$i_over_num',
								i_profit_per = '$i_profit_per',
								i_profit_pay = '$i_profit_pay',
								i_over_money = '$i_over_money',
								i_total_pay = '$i_total_pay',
								i_max_pay = '$i_max_pay',
								i_day = '$i_day',
								i_modidatetime = '$date',
								i_memo = '$i_memo'
								where  i_id='$i_id'
								";
							sql_query($sql);

					$sql = "update mari_loan
								set i_pay_ment = '$i_pay_ment',
								i_regdatetime = '$i_regdatetime'
								where  i_id='$loan_id'
								";
							sql_query($sql);


				alert('정상적으로 수정 되었습니다.','?cms=pay_list&ci_id='.$i_id.'&loan_id='.$loan_id.'');

				}else if($type=="d"){

					/*콤마제거*/
					$i_pay = (string)$i_pay;
					$i_pay = preg_replace("/[^0-9]/", "",$i_pay);
					$i_pay = (int)$i_pay;

					$i_loan_pay = (string)$i_loan_pay;
					$i_loan_pay = preg_replace("/[^0-9]/", "",$i_loan_pay);
					$i_loan_pay = (int)$i_loan_pay;

					$i_profit_pay = (string)$i_profit_pay;
					$i_profit_pay = preg_replace("/[^0-9]/", "",$i_profit_pay);
					$i_profit_pay = (int)$i_profit_pay;

					$sql = "select * from mari_invest where i_id = '$i_id'";
					$ivm = sql_fetch($sql,false);

					$sql = "select * from mari_member where m_id = '$ivm[m_id]'";
					$imem = sql_fetch($sql, false);

					/*펀딩해제여부 환불처리 여부확인stert*/
					$sql = "select * from  mari_seyfert_order where m_id='".$imem[m_id]."' and loan_id='".$loan_id."'  and s_type='1' and s_payuse='Y'  and s_release='Y'";
					$invest_delete = sql_fetch($sql, false);

					if($invest_delete[s_tid]){
						alert('해당 투자건의 마감처리(펀딩해제)처리되어 펀딩취소 및 환불이 불가합니다.');
						exit;
					}

					/*펀딩해제여부 환불처리 여부확인end*/


					$emoney = $imem[m_emoney] + $ivm[i_pay];

					$sql = "update mari_member
							set m_emoney = '$emoney'
							where m_id = '$imem[m_id]'";
					sql_query($sql);

					/*e-money내역리스트 추가*/
					$sql = "select * from mari_member where m_id = '$imem[m_id]'";
					$add = sql_fetch($sql, false);


					$sql = " insert into mari_emoney
									set m_id = '$imem[m_id]',
									p_datetime = '$date',
									p_content = '투자실패로 인한 투자금액 반환',
									p_emoney = '$ivm[i_pay]',
									p_ip = '$ip',
									p_top_emoney = '$emoney'";
					sql_query($sql);

					/*투자내역삭제*/
					$sql = "delete from mari_invest where i_id = '$i_id' and m_id = '$imem[m_id]'";
					sql_query($sql);

					/*전자결제 order 투자내역 삭제하지않고 투자상태를 D로 변경하고 보존 (이후 거래내역 누적하기위한목적)2016-12-09 임근호*/
					$sql = " update  mari_seyfert_order
										set s_date='$date',
										s_payuse='D' where loan_id = '$i_id' and m_id = '$imem[m_id]' and s_payuse='Y'  order by s_date desc";
					sql_query($sql);




						/*세이퍼트 투자자 펀딩이체취소*/
						/*seyfert가상계좌 시스템 사용여부*/
						if($config['c_seyfertck']=="Y"){
						include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

						/*가상계좌 세이퍼트멤버생성정보*/
						$sql = "select  * from mari_seyfert where m_id='$ivm[m_id]' and s_memuse='Y'";
						$seyfck = sql_fetch($sql, false);

						/*대출상품정보*/
						$sql = "select i_subject from mari_loan where i_id = '$loan_id'";
						$loa_info = sql_fetch($sql);

						/*거래 취소를 위하여 투자자 기존거래정보*/
						$sql = "select * from mari_seyfert_order where m_id = '$ivm[m_id]' and loan_id='$loan_id' and s_payuse='Y' order by s_date desc";
						$seyorder = sql_fetch($sql, false);

						$order_cancel = "OC".time().rand(111,999);

								/*발급받은 memGuid 조회*/
								$sql = "select  s_memGuid from mari_seyfert where m_id='$ivm[m_id]' and s_memuse='Y'";
								$bankck = sql_fetch($sql, false);
								$i_subject="".$loa_info[i_subject]." 투자건 투자실패로 인한 투자금액 반환";
								$ENCODE_PARAMS="&_method=POST&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$order_cancel."&title=".urlencode($i_subject)."&refId=".$seyorder[s_refId]."&authType=SMS_MO&timeout=30&parentTid=".$seyorder[s_tid]."";

								$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
								$cipherEncoded = urlencode($cipher);
								$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

								/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

								$requestPath = "https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel?".$requestString;

								$curl_handlebank = curl_init();

								curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
								curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
								curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
								curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel');
								$result1 = curl_exec($curl_handlebank);
								curl_close($curl_handlebank);

								/*파싱*/
								$decode = json_decode($result1, true);


								print_r($requestPath);
								echo"<br/><br/>";
								print_r($result1);
								echo"<br/><br/>";
								print_r($ENCODE_PARAMS);


								echo"<br/><br/>데이터".$seyorder[s_tid]."";
								print_r($decode);
								echo"<br/><br/>";
								print_r($ivm[m_id]);
								echo"<br/><br/>";
								print_r($loan_id);
								echo"<br/><br/>";

								/*주문번호저장*/
									$sql = "select  * from mari_seyfert where m_id='$ivm[m_id]' and s_memuse='Y'";
									$seyck = sql_fetch($sql, false);
										if($seyck['m_id']){

											$sql = "select  * from mari_seyfert_order where m_id='$ivm[m_id]' and s_tid='".$seyorder[s_tid]."'";
											$orderseyck = sql_fetch($sql, false);

											if(!empty($decode)) {
											/*foreach 파싱 데이터출력*/
												foreach($decode as $key=>$value){
												/*1회만실행*/
												if(!$orderseyck['s_tid']){
													$tid=$value['tid'];/*생성된 맴버키*/
													if($tid=="S" || $tid=="E" || !$tid){
													}else{
														$sql = " update  mari_seyfert_order
																	set o_canceldate='$date',
																		 o_funding_cancel='Y'
																		where s_tid='$tid'";
														sql_query($sql);
													/*
													print_r($tid);
													echo"<br/>test<br/>";
													*/
													}
												}
												}
											}

										}else{
										}

						}


					alert('결제취소가 되었습니다.');

				}else if ($add_bt == "입금처리") {
						if (!count($check)) {
							alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
						}
							/*월원금 구하기*/
							$to_ln_money=$o_ln_money/$o_maturity;

							for ($i=0; $i<count($check); $i++)
							{
								$k = $check[$i];
								if(!$o_status[$k]){
									print_r($o_status[$k]);
									alert('채무자상태가 아직 처리되지 않았습니다.');
									exit;
								}
								if($o_salestatus[$k]=="정산완료" || $o_salestatus[$k]=="연체"){
								}else{
									alert('투자자상태를 선택하여 주십시오.');
									exit;
								}
								/*투자자정보*/
								$sql = "select  m_id, m_name from  mari_invest where loan_id='$loan_id'";
								$loa = sql_fetch($sql, false);
								/*연체설정정보*/
								$sql = "select  i_overint from  mari_inset";
								$is_ck = sql_fetch($sql, false);

								/*연체횟수가 있을경우 연체이자합산*/
								if($o_status[$k]=="연체"){
									/*공식 연체이자=월원금 × 연체일수 ÷ 365 ÷ 연이율*/
									$i_overint="0.".$is_ck[i_overint]."";
									$o_saleodinterest=$to_ln_money*$o_odinterestcount[$k]/365*$i_overint;
									$totalblackmh_money=$o_saleodinterest+$o_investamount[$k];
									$topblackmh_money=ceil($totalblackmh_money);
									$o_blackmh_money="o_investamount = '$topblackmh_money',";
									/*연체시 정산e-머니*/
									$p_emoney=$topblackmh_money;
								}else{
									$o_blackmh_money="o_investamount = '$o_investamount[$k]',";
									/*일반 정산e-머니*/
									$p_emoney=$o_investamount[$k];
								}
								/*이자공식*/
								$o_interest=$o_investamount[$k]-$to_ln_money;
								$sql = "update  mari_order
												set loan_id = '$loan_id',
													sale_id = '$sale_id',
													sale_name = '$sale_name',
													".$o_blackmh_money."
													o_interestrate = '$o_interestrate[$k]',
													o_saleamount = '$o_saleamount[$k]',
													o_saleln_money = '$o_saleln_money[$k]',
													o_saleodinterest = '$o_saleodinterest',
													o_odinterestcount = '$o_odinterestcount[$k]',
													o_interest = '$o_interest',
													o_ln_money_to = '$to_ln_money',
													o_collectiondate = '$date',
													o_saletotalamount = '$o_saletotalamount[$k]',
													o_ipay = '$o_ipay',
													o_interestrate = '$o_interestrate[$k]',
													o_salestatus = '$o_salestatus[$k]',
													o_status = '$o_status[$k]'
													where loan_id='$loan_id' and o_count='$o_count[$k]' and o_id='$o_id[$k]' and sale_id='$sale_id'";
								sql_query($sql);

								if($o_salestatus[$k]=="정산완료" || $o_salestatus[$k]=="연체"){
									/*회원정보 찾기 e-머니정산 때문에*/
										$sql = "select * from mari_member where m_id='$sale_id'";
										$em = sql_fetch($sql, false);
									/*아이디 체크*/
									if(!$em['m_id']){
										alert('아이디가 존재하지 않습니다.');
										exit;
									}
									/*포인트 합산*/
										$p_top_emoney=$p_emoney+$em['m_emoney'];
									/*포인트지급내용 저장*/
										$sql = " insert into mari_emoney
													set m_id = '$sale_id',
													p_datetime = '$date',
													p_content = '".$o_subject[$k]."투자건 ".$o_count[$k]."회차 정산금',
													p_emoney = '$p_emoney',
													p_ip = '$ip',
													p_top_emoney = '$p_top_emoney'";
										sql_query($sql);

									/*회원에게 포인트지급*/
										$sql = " update mari_member
													set m_emoney = '$p_top_emoney'
													where m_id = '$sale_id'";
										sql_query($sql);
								}

							}
					alert('정상적으로 정산을 완료 하였습니다.','?cms=pay_list&ci_id='.$i_id.'&loan_id='.$loan_id.'');
				}else{
				alert('정상적인 접근이 아닙니다.');
				}


	break;


/************************************************
부채내역
************************************************/


	case "loan_form_debt":
		if($type=="w"){

			$sql="insert into mari_debt
						set i_debt_company='$i_debt_company',
						i_debt_name ='$i_debt_name',
						i_debt_pay ='$i_debt_pay ',
						i_debt_kinds = '$i_debt_kinds'
						";
			sql_query($sql);
			alert('정상적으로 적용되었습니다.');
		}else if($type=="m"){

		}else{

		}
	break;






/************************************************
상품추가
************************************************/

	case "product_add_pop":
		/*수정모드*/
		if($type=="m"){

					$sql = " update mari_contact_item
								set it_item_name = '$it_item_name'
									 where it_id = '$it_id'";
						sql_query($sql);


			alert("수정 하였습니다.");
		/*작성모드*/
		}else if($type=="w"){
					$sql = " insert into mari_contact_item
								set it_item_name = '$it_item_name'";
						sql_query($sql);


			alert("정상적으로 등록 하였습니다.");
		/*삭제모드*/
		}else if($type=="d"){
					$sql = "delete from mari_contact_item where it_id='$it_id'";
						sql_query($sql);
			alert('정상적으로 삭제 하였습니다.');

		}else{
			alert("정상적인 접근이 아닙니다.");
		}
	break;





/************************************************
투자/결제설정
************************************************/

	case "invest_pay_setup":

		/*콤마제거*/
		$i_maximum = (string)$i_maximum;
		$i_maximum = preg_replace("/[^0-9]/", "",$i_maximum);
		$i_maximum = (int)$i_maximum;

		$i_maximum_v = (string)$i_maximum_v;
		$i_maximum_v = preg_replace("/[^0-9]/", "",$i_maximum_v);
		$i_maximum_v = (int)$i_maximum_v;

		$i_maximum_in = (string)$i_maximum_in;
		$i_maximum_in = preg_replace("/[^0-9]/", "",$i_maximum_in);
		$i_maximum_in = (int)$i_maximum_in;

		$i_maximum_pro = (string)$i_maximum_pro;
		$i_maximum_pro = preg_replace("/[^0-9]/", "",$i_maximum_pro);
		$i_maximum_pro = (int)$i_maximum_pro;

		$i_allpay = (string)$i_allpay;
		$i_allpay = preg_replace("/[^0-9]/", "",$i_allpay);
		$i_allpay = (int)$i_allpay;

		$i_exemption_pay = (string)$i_exemption_pay;
		$i_exemption_pay = preg_replace("/[^0-9]/", "",$i_exemption_pay);
		$i_exemption_pay = (int)$i_exemption_pay;


		/*투자설정*/
		if($type=="is"){

			$sql="update mari_inset
						 set i_maximum = '$i_maximum',
						 i_maximum_v = '$i_maximum_v',
						 i_maximum_in = '$i_maximum_in',
						 i_maximum_pro = '$i_maximum_pro',
						 i_overint = '$i_overint',
						  i_withholding_personal = '$i_withholding_personal',
						 i_withholding_personal_v = '$i_withholding_personal_v',
						 i_withholding_burr = '$i_withholding_burr',
						 i_withholding_burr_v = '$i_withholding_burr_v',
						 i_withholding_pro = '$i_withholding_pro',
						 i_withholding_pro_v = '$i_withholding_pro_v',
						 i_withholding_in = '$i_withholding_in',
						 i_withholding_in_v = '$i_withholding_in_v',
						 i_default_rates = '$i_default_rates',
						 i_over_per = '$i_over_per',
						 i_allpay = '$i_allpay',
						 i_repayment = '$i_repayment',
						 i_profit_v = '$i_profit_v',
						 i_profit = '$i_profit',
						 i_profit_pro = '$i_profit_pro',
						 i_profit_in = '$i_profit_in',
						 i_exemption_pay = '$i_exemption_pay',
						 i_exemption_use = '$i_exemption_use'
						";
			sql_query($sql);
		alert('정상적으로 설정 되었습니다.');
		/*결제설정*/
		}else if($type=="pg"){
			$sql="update mari_pg
						set i_pgcom = '$i_pgcom',
						i_payment_type_a = '$i_payment_type_a',
						i_payment_type_b = '$i_payment_type_b',
						i_payment_type_c = '$i_payment_type_c',
						i_not_bank = '$i_not_bank',
						i_not_bankacc = '$i_not_bankacc',
						i_not_bankname = '$i_not_bankname'";
			sql_query($sql);



			$sql="update mari_config
						set c_seyfertck = '$c_seyfertck',
						c_reqMemGuid = '$c_reqMemGuid',
						c_reqMemKey = '$c_reqMemKey'";
			sql_query($sql);
		alert('정상적으로 설정 되었습니다.');
		}else{

		}
	break;

/************************************************
관리자 잔액출금
************************************************/

	case "withdrawl_ok":
		if($type=="w"){
			/*
			$o_pay = (string)$o_pay;
			$o_pay = preg_replace("/[^0-9]/", "",$o_pay);
			$o_pay = (int)$o_pay;
			*/

				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

				/*가상계좌 세이퍼트멤버생성정보*/
				$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);


						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$i_subject="관리자 출금신청";
						$ENCODE_PARAMS="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&title=".urlencode($i_subject)."&refId=".$g_code."&authType=SMS_MO&timeout=30&dstMemGuid=".$config[c_reqMemGuid]."&amount=".$o_pay."&crrncy=KRW";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5/transaction/seyfert/withdraw?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/transaction/seyfert/withdraw');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$decode = json_decode($result, true);

						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);

						*/
						echo"<br/><br/><b>결과데이터 : </b>";
						print_r($decode);
						echo"<br/><br/>";


						/*주문번호저장*/
							$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);


									$sql = " insert into  mari_seyfert_order
												set s_refId='$g_code',
													m_id='$user[m_id]',
													m_name='$user[m_name]',
													s_subject='$i_subject',
													loan_id='$loan_id',
													s_amount='$o_pay',
													s_type='2',
													s_date='$date'";
									sql_query($sql);
									/*s_type 2인경우 출금신청*/
									$sql = "select  * from mari_seyfert_order where m_id='$user[m_id]' and s_refId='$g_code' and s_type='2'";
									$orderseyck = sql_fetch($sql, false);

									if(!empty($decode)) {
									/*foreach 파싱 데이터출력*/
										foreach($decode as $key=>$value){
										/*1회만실행*/
										if(!$orderseyck['s_tid']){
											$tid=$value['tid'];/*생성된 맴버키*/
											if($tid=="S" || !$tid){
											}else{
												$sql = " update  mari_seyfert_order
															set s_tid='$tid'
																where s_refId='$g_code'";
												sql_query($sql);
											/*
											print_r($tid);
											echo"<br/>test<br/>";
											*/
											}
										}
										}
									}

								/*출금신청내용 추가*/
								$sql = " insert into mari_outpay
											set m_id = '$user[m_id]',
											m_name = '$user[m_name]',
											o_pay = '$o_pay',
											o_regdatetime = '$date',
											o_fin = 'N',
											o_refId = '$g_code',
											o_ip = '$ip'";
								sql_query($sql);

				}

		alert('정상적으로 출금신청 하였습니다.');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	break;



/************************************************
출금신청 리스트관리
************************************************/

	case "withdrawal_list":
				if ($add_bt == "선택출금처리") {

					if (!count($check)) {
						alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
					}
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];


			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$m_id[$k]."'";
				$em = sql_fetch($sql, false);

			/*포인트 합산*/
				$p_top_emoney=$em['m_emoney']-$o_pay[$k];

				/*회원e머니정보 DB에저장*/
				$sql = " update mari_member
							set m_emoney = '".$p_top_emoney."' where m_id='".$m_id[$k]."'";
				sql_query($sql);


			/*포인트출금내용 저장*/
				$sql = " insert into mari_emoney
							set m_id = '".$em[m_id]."',
							p_datetime = '$date',
							p_emoney = '$o_pay[$k]',
							p_content = '".$o_pay[$k]."원 출금 신청금액',
							p_ip = '$ip',
							p_top_emoney = '$p_top_emoney'";
				sql_query($sql);


					/* update*/
					$sql="update mari_outpay
								set o_fin = 'Y',
									o_paydatetime = '$date'
								where o_no='$o_no[$k]'";
					sql_query($sql);




						if($config['c_sms_use']=="Y"){
							if($load['invest_req_04']=="Y"){
								/*SMS자동전송 시작*/
								$loadmem = sql_fetch(" select m_hp from mari_member where m_id='$em[m_id]'");

								/*휴대폰번호 분리*/
								$m_hp = $loadmem['m_hp'];
								$hp1=substr($m_hp,0,3);
								$hp2=substr($m_hp,3,-4);
								$hp3=substr($m_hp,-4);
								$to_hp="".$hp1."".$hp2."".$hp3."";

								/*문자치환*/
								$invest_msg_04 = str_replace("{이름}", $m_name[$k], $invest_msg_04);
								$invest_msg_04 = str_replace("{출금금액}", number_format($o_pay[$k]), $invest_msg_04);

								/*80바이트 이상일경우 lms로 발송*/
								$message_msg=mb_strlen($invest_msg_04, "euc-kr");
								if($message_msg <=80){
									$sendSms="sendSms";
								}else{
									$sendSms="sendSms_lms";
								}

								/*POST전송할 데이터*/
								$post_data = array(
								 "cid" => "".$config[c_sms_id]."",
								 "from" => "".$config[c_sms_phone]."",
								 "to" => "".$to_hp."",
								 "msg" => "".$invest_msg_04."",
								 "mode" => "".$sendSms."",
								 "smsmsg" => "정상적으로 출금처리 하였습니다.",
								 "returnurl" => "".MARI_HOME_URL."?cms=".$update.""
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_sms = curl_init();
								curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
								/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
								curl_setopt($curl_sms, CURLOPT_POST, 1);
								curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
								$result_sms = curl_exec($curl_sms);
								curl_close($curl_sms);
								/*SMS CURL전송*/

							}
						}

					}
				alert('정상적으로 출금처리 하였습니다.');
				}else{
				alert('정상적인 접근이 아닙니다.');
				}
	break;


/************************************************
팝업등록및 관리
************************************************/
	case "newpopup":
		$sql_common = " po_skin = '$po_skin',
								po_dir = '$po_dir',
								po_popstyle = '$po_popstyle',
								po_openchk = '$po_openchk',
								po_scrollbar = '$po_scrollbar',
								po_start_date = '$po_start_date',
								po_end_date = '$po_end_date',
								po_expirehours = '$po_expirehours',
								po_leftcenter = '$po_leftcenter',
								po_topcenter = '$po_topcenter',
								po_left = '$po_left',
								po_top = '$po_top',
								po_width = '$po_width',
								po_height = '$po_height',
								po_act = '$po_act',
								po_actc = '$po_actc',
								po_delay = '$po_delay',
								po_subject = '$po_subject',
								po_content = '$po_content' ";

		if ($type == 'm'){
			$sql = " update mari_popup set
						".$sql_common."
					  where po_id = '$po_id' ";
			sql_query($sql);
		alert('정상적으로 수정 되었습니다.');
		}else if ($type == 'w'){
			$sql = " insert into mari_popup set
						".$sql_common." ";
			sql_query($sql);
			$po_id = mysql_insert_id();
		alert('정상적으로 등록 되었습니다.');
		}else{
		alert('정상적인 접근이 아닙니다.');
		exit;
		}
	break;


/************************************************
팝업리스트 관리
************************************************/
	case "popuplist":
		if ($add_bt == "선택수정") {
		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$sql = " update mari_popup
								set po_openchk = '$po_openchk[$k]'
									where po_id = '$po_id[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_popup where po_id='".$po_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				$sql = " delete from mari_popup where po_id='".$po_id."'   ";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}
	break;



/************************************************
SMS그룹관리
************************************************/
	case "sms_group":
		if ($type == 'w') // 업데이트
		{
			for ($i=0; $i<count($_POST['chk']); $i++)
			{
				// 실제 번호를 넘김
				$k = $_POST['chk'][$i];
				$sg_no = $_POST['sg_no'][$k];
				$sg_name = $_POST['sg_name'][$k];

				if (!is_numeric($sg_no))
					alert('그룹 고유번호가 없습니다.');

				$res = sql_fetch("select * from mari_smsgroup where sg_no='$sg_no'");
				if (!$res)
					alert('존재하지 않는 그룹입니다.');

				if (!strlen(trim($sg_name)))
					alert('그룹명을 입력해주세요');

				$res = sql_fetch("select sg_name from mari_smsgroup where sg_no<>'$sg_no' and sg_name='$sg_name'");
				if ($res)
					alert('같은 그룹명이 존재합니다.');

				sql_query("update mari_smsgroup set sg_name='".addslashes($sg_name)."' where sg_no='$sg_no'");
			}
		alert('정상적으로 수정 되었습니다.');
		}
	else if ($type == 'de') // 그룹삭제
	{
		for ($i=0; $i<count($_POST['chk']); $i++)
		{
			// 실제 번호를 넘김
			$k = $_POST['chk'][$i];
			$sg_no = $_POST['sg_no'][$k];

			if (!is_numeric($sg_no))
				alert('그룹 고유번호가 없습니다.');

			$res = sql_fetch("select * from mari_smsgroup where sg_no='$sg_no'");
			if (!$res)
				alert('존재하지 않는 그룹입니다.');

			sql_query("delete from mari_smsgroup where sg_no='$sg_no'");
			sql_query("update mari_smsbook set sg_no=1 where sg_no='$sg_no'");
		}
		alert('그룹이 삭제 되었습니다.');
	}
	else if ($type == 'em') // 비우기
	{
		for ($i=0; $i<count($_POST['chk']); $i++)
		{
			// 실제 번호를 넘김
			$k = $_POST['chk'][$i];
			$sg_no = $_POST['sg_no'][$k];

			sql_query("update mari_smsgroup set sg_count = 0, sg_member = 0, sg_nomember = 0, sg_receipt = 0, sg_reject = 0 where sg_no='$sg_no'");
			sql_query("delete from mari_smsbook where sg_no='$sg_no'");
		}
		alert('그룹을 비웠습니다.');
	}
	else if ($type == 'move')
	{
		$res = sql_fetch("select * from mari_smsgroup where sg_no='$sg_no'");
		sql_query("update mari_smsgroup set sg_count = sg_count + $res[sg_count], sg_member = sg_member + $res[sg_member], sg_nomember = sg_nomember + $res[sg_nomember], sg_receipt = sg_receipt + $res[sg_receipt], sg_reject = sg_reject + $res[sg_reject] where sg_no='$move_no'");
		sql_query("update mari_smsgroup set sg_count = 0, sg_member = 0, sg_nomember = 0, sg_receipt = 0, sg_reject = 0 where sg_no='$sg_no'");
		sql_query("update mari_smsbook set sg_no='$move_no' where sg_no='$sg_no'");
		alert('정상적으로 이동 되었습니다.');
	}
	else // 등록
	{
		if (!strlen(trim($sg_name)))
			alert('그룹명을 입력해주세요');

		$res = sql_fetch("select sg_name from mari_smsgroup where sg_name='$sg_name'");
		if ($res)
			alert('같은 그룹명이 존재합니다.');

		sql_query("insert into mari_smsgroup set sg_name='".addslashes($sg_name)."'");

		alert('정상적으로 등록되었습니다.');
	}
	break;

/************************************************
SMS전화번호등록
************************************************/
	case "sms_book_w":

		$is_hp_exist = false;

		$sb_hp = get_hp($sb_hp);

		if ($type=='w') // 업데이트
		{
			if (!$sg_no) $sg_no = 0;

			if (!$sb_receipt) $sb_receipt = 0; else $sb_receipt = 1;

			if (!strlen(trim($sb_name)))
				alert('이름을 입력해주세요');

			if ($sb_hp == '')
				alert('휴대폰번호만 입력 가능합니다.');

			$res = sql_fetch("select * from mari_smsbook where sb_no='$sb_no'");
			if (!$res)
				alert('존재하지 않는 데이터 입니다.');

			if ($sg_no != $res['sg_no']) {
				if ($res['m_id']) $mem = "sg_member"; else $mem = "sg_nomember";
				if ($res['sb_receipt'] == 1) $sms = "sg_receipt"; else $sms = "sg_reject";
				sql_query("update mari_smsgroup set sg_count = sg_count - 1, $mem = $mem - 1, $sms = $sms - 1 where sg_no='$res[sg_no]'");
				sql_query("update mari_smsgroup set sg_count = sg_count + 1, $mem = $mem + 1, $sms = $sms + 1 where sg_no='$sg_no'");
			}

			if ($sb_receipt != $res['sb_receipt']) {
				if ($sb_receipt == 1)
					sql_query("update mari_smsgroup set sg_receipt = sg_receipt + 1, sg_reject = sg_reject - 1 where sg_no='$sg_no'");
				else
					sql_query("update mari_smsgroup set sg_receipt = sg_receipt - 1, sg_reject = sg_reject + 1 where sg_no='$sg_no'");
			}

			sql_query("update mari_smsbook set sg_no='$sg_no', sb_name='$sb_name', sb_hp='$sb_hp', sb_receipt='$sb_receipt', sb_datetime='".G5_TIME_YMDHIS."', sb_memo='".addslashes($sb_memo)."' where sb_no='$sb_no'");
			if ($res['m_id']){ //만약에 m_id가 있다면...
				// 휴대폰번호 중복체크
				$sql = " select m_id from mari_member where m_id <> '$res[m_id]' and m_hp = '$sb_hp' ";
				$m_hp_exist = sql_fetch($sql);
				if ($m_hp_exist['m_id']) { //중복된 회원 휴대폰번호가 있다면
					$is_hp_exist = true;
				} else {
					 sql_query("update mari_member set m_name='".addslashes($sb_name)."', m_hp='$sb_hp', mb_sms='$sb_receipt' where m_id='$res[m_id]'", false);
				}
			}
			$get_sg_no = $sg_no;

			$go_url = '?cms=sms_book_w&sb_no='.$sb_no.'&amp;w='.$w.'&amp;page='.$page;
			if( $is_hp_exist ){ //중복된 회원 휴대폰번호가 있다면
				//alert( "중복된 회원 휴대폰번호가 있어서 회원정보에는 반영되지 않았습니다.", $go_url );
				goto_url($go_url);
			} else {
				goto_url($go_url);
			}
			exit;
		}
		else if ($w=='d') // 삭제
		{
			if (!is_numeric($sb_no))
				alert('고유번호가 없습니다.');

			$res = sql_fetch("select * from mari_smsbook where sb_no='$sb_no'");
			if (!$res)
				alert('존재하지 않는 데이터 입니다.');

			if ($res['sb_receipt'] == 1) $sg_sms = 'sg_receipt'; else $sg_sms = 'sg_reject';
			if ($res['m_id']) $sg_mb = 'sg_member'; else $sg_mb = 'sg_nomember';

			sql_query("delete from mari_smsbook where sb_no='$sb_no'");
			sql_query("update mari_smsgroup set sg_count = sg_count - 1, $sg_mb = $sg_mb - 1, $sg_sms = $sg_sms - 1 where sg_no = '$res[sg_no]'");

		}
		else // 등록
		{
			if (!$sg_no) $sg_no = 1;

			if (!$sb_receipt) $sb_receipt = 0; else $sb_receipt = 1;

			if (!strlen(trim($sb_name)))
				alert('이름을 입력해주세요');

			if ($sb_hp == '')
				alert('휴대폰번호만 입력 가능합니다.');

			$res = sql_fetch("select * from mari_smsbook where sb_hp='$sb_hp'");
			if ($res)
				alert('같은 번호가 존재합니다.');

			if ($sb_receipt == 1)
				$sql_sms = "sg_receipt = sg_receipt + 1";
			else
				$sql_sms = "sg_reject = sg_reject + 1";

			sql_query("insert into mari_smsbook set sg_no='$sg_no', sb_name='".addslashes($sb_name)."', sb_hp='$sb_hp', sb_receipt='$sb_receipt', sb_datetime='".MARI_TIME_YMDHIS."', sb_memo='".addslashes($sb_memo)."'");
			sql_query("update mari_smsgroup set sg_count = sg_count + 1, sg_nomember = sg_nomember + 1, $sql_sms where sg_no = '$sg_no'");

			$get_sg_no = $sg_no;
		}

		$go_url = '?cms=sms_book&page='.$page.'&amp;sg_no='.$get_sg_no.'&amp;ap='.$ap;
		goto_url($go_url);

	break;




/************************************************
SMS회원추가
************************************************/
	case "sms_book_list":

		if ($add_bt == "선택삭제") {
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

						$sql = "delete from mari_smsbook where sb_no = '$sb_no[$k]'";
						sql_query($sql);
					}
				alert('정상적으로 수정 하였습니다.');
		}else if($add_bt == "수신허용"){
			for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

						$sql = "update mari_smsbook
								set sb_receipt = '1'
								where sb_no = '$sb_no[$k]'";
						sql_query($sql);

						$sql = "update mari_member
								set m_sms = '1'
								where m_id = '$m_id[$k]'";
						sql_query($sql);

					}
			alert('정상적으로 수정 하였습니다.');
		}else if($add_bt == "수신거부"){
			for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

						$sql = "update mari_smsbook
								set sb_receipt = '0'
								where sb_no = '$sb_no[$k]'";
						sql_query($sql);

						$sql = "update mari_member
								set m_sms = '0'
								where m_id = '$m_id[$k]'";
						sql_query($sql);
					}
				alert('정상적으로 수정 하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다');
			exit;
		}

	break;


/************************************************
SMS회원추가
************************************************/
	case "sms_book_search":
		/*추가시 미분류로 등록*/
	if($type="gr"){


			if (!count($check)) {
				alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
			}

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];

				$sql = "select * from mari_smsbook sb_hp='".$m_hp[$k]."'";
				$hpck = sql_fetch($sql, false);

				if(!$hpck[m_id]){

				$sql = "insert into mari_smsbook
								set sg_no = '1',
									m_no = '$m_no[$k]',
									m_id = '$m_id[$k]',
									sb_name = '$m_name[$k]',
									sb_hp = '$m_hp[$k]',
									sb_datetime = '$date',
									sb_receipt = '$m_sms[$k]'";
				sql_query($sql);

				}
			}
		alert('정상적으로 추가 하였습니다.');


	}
	break;

/************************************************
SMS 설정
************************************************/
	case "sms_setup":
		if($type=="m"){
			$sql = " update mari_config
						set c_sms_id = '$c_sms_id',
						c_sms_phone = '$c_sms_phone'
						";
			sql_query($sql, false);
			alert('정상적으로 수정 하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다.');
		}
	break;

/************************************************
페이지 추가&수정
************************************************/
	case "management_page":

		if ($add_bt == "선택수정") {
		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$sql = " update mari_content
								set p_subject = '$p_subject[$k]',
									p_page_use = '$p_page_use[$k]'
								where p_id = '$p_id[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];

				/*기존파일삭제*/
				$string = MARI_HOMESKIN_PATH."/".$p_id[$k].".tpl";
				@unlink($string);
				$sql = " delete from mari_content where p_id='".$p_id[$k]."'";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				/*기존파일삭제*/
				$string = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
				@unlink($string);
				$sql = " delete from mari_content where p_id='".$p_id."'";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}
	break;
/************************************************
페이지 추가&수정 / INCLUDE 추가&수정
************************************************/
	case "page_form":

		/*include관리*/
		if($stype=="inc"){
			if($type=="w"){

					$sql = " insert into mari_content
								set p_id = '$p_id',
								p_subject = '$p_subject',
								p_content = '$p_content',
								p_type = 'inc',
								p_page_use = '$p_page_use'";
						sql_query($sql);

			/*파일생성*/
			$file = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			$f = @fopen($file, 'a');
			fwrite($f, "<?php include(MARI_VIEW_PATH.'/Common_select_class.php');?>\n");
			fwrite($f, "<!--\n");
			fwrite($f, "┏━━━━━━━━━━━━━━━━━━━━━━━┓\n");
			fwrite($f, "▶ $p_subject\n");
			fwrite($f, "┗━━━━━━━━━━━━━━━━━━━━━━━┛\n");
			fwrite($f, "-->\n");
			fwrite($f, "$pageexe_view[p_content]\n");
			fclose($f);
			@chmod($file, MARI_FILE_PERMISSION);

					alert("정상적으로 추가 되었습니다.");

			}else if($type=="m"){

				/*update*/
					$sql = " update  mari_content
								set p_subject = '$p_subject',
								p_content = '$p_content',
								p_type = 'inc',
								p_page_use = '$p_page_use'
								where p_id='$p_id'";
						sql_query($sql);

			/*수정시 기존파일삭제*/
			$string = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			@unlink($string);

			/*파일생성*/
			$file = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			$f = @fopen($file, 'a');
			fwrite($f, "<?php include(MARI_VIEW_PATH.'/Common_select_class.php');?>\n");
			fwrite($f, "<!--\n");
			fwrite($f, "┏━━━━━━━━━━━━━━━━━━━━━━━┓\n");
			fwrite($f, "▶ $p_subject\n");
			fwrite($f, "┗━━━━━━━━━━━━━━━━━━━━━━━┛\n");
			fwrite($f, "-->\n");
			fwrite($f, "$pageexe_view[p_content]\n");
			fclose($f);
			@chmod($file, MARI_FILE_PERMISSION);

					alert('정상적으로 수정 되었습니다.');
			}else if($type=="d"){
			}else{
			alert('정상적인 접근이 아닙니다.');
			}
		}else{
			if($type=="w"){

					$sql = " insert into mari_content
								set p_id = '$p_id',
								p_subject = '$p_subject',
								p_content = '$p_content',
								p_page_use = '$p_page_use',
								p_header = '$p_header',
								p_footer = '$p_footer',
								p_lnb = '$p_lnb'";
						sql_query($sql);

			/*파일생성*/
			$file = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			$f = @fopen($file, 'a');
			fwrite($f, "{# $p_header}<!--상단-->\n");
			fwrite($f, "<!--\n");
			fwrite($f, "┏━━━━━━━━━━━━━━━━━━━━━━━┓\n");
			fwrite($f, "▶ $p_subject\n");
			fwrite($f, "┗━━━━━━━━━━━━━━━━━━━━━━━┛\n");
			fwrite($f, "-->\n");
			fwrite($f, "<div id=\"container\">\n");
			fwrite($f, "<div id=\"sub_content\">\n");
			fwrite($f, "$pageexe_view[p_content]\n");
			fwrite($f, "</div><!-- /sub_content -->\n");
			fwrite($f, "</div><!-- /container -->\n");
			fwrite($f, "{# $p_footer}<!--하단-->\n");
			fclose($f);
			@chmod($file, MARI_FILE_PERMISSION);

					alert("정상적으로 추가 되었습니다.");

			}else if($type=="m"){

				/*update*/
					$sql = " update  mari_content
								set p_subject = '$p_subject',
								p_content = '$p_content',
								p_page_use = '$p_page_use',
								p_header = '$p_header',
								p_footer = '$p_footer',
								p_lnb = '$p_lnb'
								where p_id='$p_id'";
						sql_query($sql);

			/*수정시 기존파일삭제*/
			$string = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			@unlink($string);

			/*파일생성*/
			$file = MARI_HOMESKIN_PATH."/".$p_id.".tpl";
			$f = @fopen($file, 'a');
			fwrite($f, "{# $p_header}<!--상단-->\n");
			fwrite($f, "<!--\n");
			fwrite($f, "┏━━━━━━━━━━━━━━━━━━━━━━━┓\n");
			fwrite($f, "▶ $p_subject\n");
			fwrite($f, "┗━━━━━━━━━━━━━━━━━━━━━━━┛\n");
			fwrite($f, "-->\n");
			fwrite($f, "<div id=\"container\">\n");
			fwrite($f, "<div id=\"sub_content\">\n");
			fwrite($f, "$pageexe_view[p_content]");
			fwrite($f, "</div><!-- /sub_content -->\n");
			fwrite($f, "</div><!-- /container -->\n");
			fwrite($f, "{# $p_footer}<!--하단-->\n");
			fclose($f);
			@chmod($file, MARI_FILE_PERMISSION);

					alert('정상적으로 수정 되었습니다.');
			}else if($type=="d"){
			}else{
			alert('정상적인 접근이 아닙니다.');
			}
		}
	break;


/************************************************
네이버 에널리틱스
************************************************/


	case "analytics":
		if($type=="w"){

			$sql="update  mari_analytics_config
						set login_form_login='$login_form_login'
						";
			sql_query($sql);
			alert('정상적으로 설정되었습니다.');
		}else if($type=="m"){

		}else{
			alert('정상적인 접근이 아닙니다.');
		}
	break;

/************************************************
카피라이트, 기타관리
************************************************/


	case "copyright":
		if($type=="copy"){
			$sql = "update mari_config
						set c_copyright = '$c_copyright'";
				sql_query($sql);
				alert('카피라이트를 정상적으로 저장 하였습니다.');
		}else if($type=="info"){

				$sql = "update mari_config
							set c_information = '$c_information'";
				sql_query($sql);
				alert('부가정보를 정상적으로 저장 하였습니다.');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;


/************************************************
SMS 자동발송설정
************************************************/


	case "smsload_setup":

		if($type=="m"){
			$sql = "update mari_smsload
						set member_msg = '$member_msg_m',
						loan_msg = '$loan_msg_m',
						invest_msg_01 = '$invest_msg_01_m',
						invest_msg_02 = '$invest_msg_02_m',
						invest_msg_03 = '$invest_msg_03_m',
						invest_msg_04 = '$invest_msg_04_m',
						member_req = '$member_req',
						loan_req = '$loan_req',
						invest_req_01 = '$invest_req_01',
						invest_req_02 = '$invest_req_02',
						invest_req_03 = '$invest_req_03',
						invest_req_04 = '$invest_req_04'
						";
				sql_query($sql);
				alert('SMS자동발송 설정을 저장 하였습니다.');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}

	break;

/************************************************
카테고리스트관리
************************************************/

	case "category_list":

		if ($add_bt == "선택수정") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}
			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$sql = " update mari_category
								set ca_subject = '$ca_subject[$k]',
									ca_admin = '$ca_admin[$k]'
								where ca_pk = '$ca_pk[$k]' ";
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');

		} else if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_category where ca_pk='".$ca_pk[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if($type="d"){
				$sql = " delete from mari_category where ca_pk='".$id."'   ";
				sql_query($sql);
		alert('정상적으로 삭제처리 하였습니다.');
		}
	break;


/************************************************
카테고리작성폼
************************************************/

	case "category_form":

		if($type=="w"){
			$sql = "insert into mari_category
						set ca_id = '$ca_id',
						ca_num = '$ca_num',
						ca_sub_id = '$ca_sub_id',
						ca_subject = '$ca_subject',
						ca_admin = '$ca_admin'";
				sql_query($sql);
				alert(''.$ca_id.'가 정상적으로 추가 되었습니다.', MARI_HOME_URL.'/?cms=category_list');

		}else if($type=="m"){
				$sql = "update mari_category
							set ca_subject = '$ca_subject',
							ca_admin = '$ca_admin'
							where ca_pk='$ca_pk'";
				sql_query($sql);
				alert('정상적으로 수정 되었습니다.', MARI_HOME_URL.'/?cms=category_list');
		}else if($type=="add"){
			$sql = "insert into mari_category
						set ca_id = '$ca_id',
						ca_num = '$ca_num',
						ca_sub_id = '$ca_sub_id',
						ca_ssub_id = '$ca_ssub_id',
						ca_subject = '$ca_subject',
						ca_admin = '$ca_admin'";
				sql_query($sql);
				alert(''.$ca_id.'의 하위 카테고리가 정상적으로 추가 되었습니다.', MARI_HOME_URL.'/?cms=category_list');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;


/************************************************
디스플레이설정
************************************************/
	case "exposure_settings":
		if($type=="m"){
		$c_realtimeitem_display="$realtimeitem_display_01|$realtimeitem_display_02|$realtimeitem_display_03|$realtimeitem_display_04";
		$c_displayprofile_use="$displayprofile_use_01|$displayprofile_use_02|$displayprofile_use_03";
			$sql = "update mari_config
					set c_realtimeitem_display = '$c_realtimeitem_display',
						c_realtime_use = '$c_realtime_use',
						c_realtime_speed = '$c_realtime_speed',
						c_mainrealtime_use = '$c_mainrealtime_use',
						c_displayprofile_use = '$c_displayprofile_use',
						c_display_maincount = '$c_display_maincount',
						c_smscounseling_use = '$c_smscounseling_use',
						c_display_subcount = '$c_display_subcount',
						c_realtime_pause = '$c_realtime_pause',
						c_sms_number = '$c_sms_number'
						";
			sql_query($sql);
			alert('디스플레이를 정상적으로 설정 하였습니다.');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;

/************************************************
회원권한관리
************************************************/
	case "member_authority":

		$au_member_sub = "$au_member01|$au_member02|$au_member03|$au_member04|$au_member05|$au_member06";
		$au_loan_sub = "$au_loan01|$au_loan02";
		$au_invest_sub = "$au_invest01|$au_invest02|$au_invest03|$au_invest04|$au_invest05|$au_invest06";
		$au_sales_sub = "$au_sales01|$au_sales02|$au_sales03|$au_sales04|$au_sales05";

		if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_authority where au_id='".$au_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}

		if($type=="w"){

			$sql = "insert into mari_authority
					set m_id = '$m_id',
					au_member = '$au_member',
					au_loan = '$au_loan',
					au_invest = '$au_invest',
					au_sales = '$au_sales',
					au_member_sub = '$au_member_sub',
					au_loan_sub = '$au_loan_sub',
					au_invest_sub = '$au_invest_sub',
					au_sales_sub = '$au_sales_sub',
					au_regidate = '$date' ";
			sql_query($sql);
			alert('권한을 설정하였습니다.');
		}else if($type=="m"){
			$sql = "update mari_authority
					set au_member = '$au_member',
					au_loan = '$au_loan',
					au_invest = '$au_invest',
					au_sales = '$au_sales',
					au_member_sub = '$au_member_sub',
					au_loan_sub = '$au_loan_sub',
					au_invest_sub = '$au_invest_sub',
					au_sales_sub = '$au_sales_sub'
					where au_id = '$au_id'";
			sql_query($sql);
			alert('권한설정을 수정하였습니다.','?cms=member_authority');
		}else{

		alert('정상적인 접근이 아닙니다.');
		}
	break;

/************************************************
faq
************************************************/
	case "faq":

		if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_faq where f_id='".$f_id[$k]."'   ";
				sql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if ($add_bt == "선택수정") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = "update mari_faq
						set f_sort = '".$f_sort[$k]."'
						where f_id='".$f_id[$k]."'";
				print_r($sql);
				sql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');
		}

		if($type=="w"){

			$sql = "insert into mari_faq
				set f_question = '$f_question',
				f_answer = '$f_answer',
				f_sort = '$f_sort',
				f_regidate = '$date'";
			sql_query($sql);
			alert('정상적으로 질문등록을 하였습니다.','?cms=faq_list');

		}else if($type=="m"){
			$sql = "update mari_faq
				set f_question = '$f_question',
				f_answer = '$f_answer',
				f_sort = '$f_sort'
				where f_id = '$f_id' ";
			sql_query($sql);
			alert('정상적으로 수정하였습니다','?cms=faq_list');
		}else if($type=="d"){
			$sql = "delete from mari_faq where f_id = '$f_id'";
			sql_query($sql);
			alert('삭제처리하였습니다.');
		}else if($type=="view"){
			$sql = "update mari_config set c_faq_use = '$c_faq_use'";
			sql_query($sql);
			alert('노출설정이 완료되었습니다.');
		}else{
			alert('정상적인 접근이 아닙니다.');
		}


	break;

/************************************************
관리자연동(유지보수)
************************************************/
	case "conservatism":

		include_once(MARI_SQL_PATH.'/master_connect.php');

		$cv_hp = "".$hp1."".$hp2."".$hp3."";

		if ($add_bt == "선택삭제") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " delete from mari_conservatism where cv_id='".$cv_id[$k]."'   ";
				mysql_query($sql);
			}
		alert('정상적으로 삭제처리 하였습니다.');
		}else if ($add_bt == "선택수정") {

		if (!count($check)) {
			alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
		}

			for ($i=0; $i<count($check); $i++)
			{

				$k = $check[$i];
				$sql = " update mari_conservatism set cv_condition = '$cv_condition[$k]', cv_person = '$cv_person[$k]'  where cv_id='".$cv_id[$k]."'   ";
				mysql_query($sql);
			}
		alert('정상적으로 수정 하였습니다.');
		}



		if($type=="w"){
				$sql = " insert into mari_conservatism
							set cv_subject = '$cv_subject',
							cv_content = '$cv_content',
							m_id = '$user[m_id]',
							m_name = '$ftp_id',
							".$pw_yes."
							cv_email = '$cv_email',
							cv_datetime = '$date',
							cv_condition = '1',
							cv_webaddr = '$cv_webaddr',
							cv_hp  = '$cv_hp',
							ftp_id = '$ftp_id',
							cv_salecode = '$ftp_id'
							";
					mysql_query($sql);

				alert('정상적으로 작성 하였습니다.','?cms=conservatism');

			}else if($type=="m"){
				$sql = " update mari_conservatism
							set cv_subject = '$cv_subject',
							cv_content = '$cv_content',
							m_id = '$user[m_id]',
							".$pw_yes."
							cv_email = '$cv_email',
							cv_datetime = '$date',
							cv_condition = '1',
							cv_webaddr = '$cv_webaddr',
							cv_hp  = '$cv_hp',
							cv_person = '$cv_person'
							where cv_id = '$cv_id'
							";
					mysql_query($sql);

				alert('정상적으로 수정 하였습니다.','?cms=conservatism');

			}else if($type=="d"){
				$sql = "delete from mari_conservatism where cv_id = '$cv_id'";
				mysql_query($sql);
				alert('정상적으로 삭제 되었습니다.');
			}else{
				alert('정상적인 접근이 아닙니다.');
			}

	break;

/************************************************
자문단 설정
************************************************/
	case "advice_view":


		$file_img_01=$_FILES['ad_logo']['name'];

			/*파일업로드*/
		if(!$file_img_01==""){
			$img_update_01="ad_logo	 = '".$file_img_01."',";
			if ($_FILES['ad_logo']['name']) upload_file($_FILES['ad_logo']['tmp_name'], $file_img_01, MARI_DATA_PATH."/photoreviewers");
		}


		if($type=="w"){
			$sql = "insert into mari_advice
					set ad_name = '$ad_name',
					".$img_update_01."
					ad_link = '$ad_link',
					ad_regidate = '$date'";
			sql_query($sql);

			alert('정상적으로 추가하였습니다.', '?cms=advice_list');
		}else if($type=="m"){

			$sql = " select  ad_logo where ad_id='$ad_id'";
			$d_file = sql_fetch($sql, false);

			/*file 삭제*/
			if($d_img_01=="1"){
				$img_update_01="ad_logo	 = '',";
				@unlink(MARI_DATA_PATH."/photoreviewers/".$d_file[ad_logo]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['ad_logo'])) {
					delete_board_thumbnail('photoreviewers', $d_file['ad_logo']);
				}
			}


			$sql = "update mari_advice
					set ad_name = '$ad_name',
					".$img_update_01."
					ad_link = '$ad_link'
					where ad_id = '$ad_id'";
			sql_query($sql);

			alert('정상적으로 수정하였습니다.', '?cms=advice_list');
		}else if($type=="d"){
			$sql = "delete from mari_advice where ad_id = '$ad_id'";
			sql_query($sql);

			alert('정상적으로 삭제하였습니다.');
		}
	break;


/************************************************
세이퍼트 가상계좌발급[관리자]
************************************************/

	case "virtualaccountissue_admin":


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


				/*발급여부확인*/
				$sql = "select  * from mari_pg where i_bankacc_user='N'";
				$seyfck_adm = sql_fetch($sql, false);
				/*발급내역이 없을경우에만 실행*/
					if($seyfck_adm['i_bankacc_user']=="N"){

					if (!$i_not_bank)
						alert('발급하실 가상계좌 은행을 선택하여 주십시오.');

						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);

						$ENCODE_PARAMS="&_method=PUT&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$config[c_reqMemGuid]."&bnkCd=".$i_not_bank."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath = "https://v5.paygate.net/v5a/member/assignVirtualAccount?".$requestString;

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/assignVirtualAccount');
						$result1 = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/
						$bankcode = json_decode($result1, true);

						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);
						*/

						if(!empty($bankcode)) {
						/*foreach 파싱 데이터출력*/
							foreach($bankcode as $key=>$value){
							$bnkCd=$value['bnkCd'];/*입금은행*/
							$accntNo=$value['accntNo'];/*가상계좌번호*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_pg where i_bankacc_user='N'";
							$seyfck_adm = sql_fetch($sql, false);
								if($seyfck_adm['i_bankacc_user']=="N"){
									if($accntNo=="E" || $accntNo=="S"){
									}else{

									$sql="update mari_pg set
												i_not_bank = '$bnkCd',
												i_not_bankacc = '$accntNo',
												i_bankacc_user = 'Y' where i_bankacc_user='N'";
									sql_query($sql);

									}
								}
							}
						}
						alert('가상 계좌가 정상적으로 발급되었습니다.');
						}else{
						alert('이미 가상 계좌가 발급되었습니다.');
						}
				}else{
				alert('현재 세이퍼트 전자결제 미사용중입니다. 관리자>환경설정>세이퍼트 사용을 체크하여 주시기 바랍니다.');
				}

	break;

/************************************************
변호사 등록/수정
************************************************/
	case "lawyer_write":

		if($hp1 == "선택"){
			$ly_hp = "";
		}else{
			$ly_hp = "".$hp1."".$hp2."".$hp3."";
		}

		/*폴더생성*/
		@mkdir(MARI_DATA_PATH."/lawyer", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/lawyer", MARI_DIR_PERMISSION);

		$file_img_01=$_FILES['ly_img']['name'];
		$file_img_02=$_FILES['ly_company_logo']['name'];



		/*파일업로드*/
		if(!$file_img_01==""){
			$img_update_01="ly_img	 = '".$file_img_01."',";
			if ($_FILES['ly_img']['name']) upload_file($_FILES['ly_img']['tmp_name'], $file_img_01, MARI_DATA_PATH."/lawyer");
		}

		/*파일업로드*/
		if(!$file_img_02==""){
			$img_update_02="ly_company_logo	 = '".$file_img_02."',";
			if ($_FILES['ly_company_logo']['name']) upload_file($_FILES['ly_company_logo']['tmp_name'], $file_img_02, MARI_DATA_PATH."/lawyer");
		}




		if($type=="w"){

			$sql = "insert into mari_lawyer
				set ly_name = '$ly_name',
				ly_hp = '$ly_hp',
				ly_email = '$ly_email',
				ly_part = '$ly_part',
				ly_company = '$ly_company',
				ly_career = '$ly_career',
				".$img_update_01."
				".$img_update_02."
				ly_regidate = '$date'
				";
			sql_query($sql);
			alert('변호사 등록을 하였습니다.','?cms=lawyer_list');

		}else if($type=="m"){

			$sql = " select ly_img from mari_lawyer where ly_id='$ly_id'";
			$d_file2 = sql_fetch($sql, false);

			$sql = " select ly_company_logo from mari_lawyer where ly_id='$ly_id'";
			$d_file3 = sql_fetch($sql, false);


			/*file 삭제*/
			if($d_img_01=="1"){
				$img_update_01="ly_img	 = '',";
				@unlink(MARI_DATA_PATH."/lawyer/".$d_file2[ly_img]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file2['ly_img'])) {
					delete_board_thumbnail('lawyer', $d_file2['ly_img']);
				}
			}

			/*file 삭제*/
			if($d_img_02=="1"){
				$img_update_02="ly_company_logo	 = '',";
				@unlink(MARI_DATA_PATH."/lawyer/".$d_file3[ly_company_logo]."");
				// 썸네일삭제
				if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file3['ly_company_logo'])) {
					delete_board_thumbnail('lawyer', $d_file3['ly_company_logo']);
				}
			}

			$sql = "update mari_lawyer
				set ly_name = '$ly_name',
				ly_hp = '$ly_hp',
				ly_email = '$ly_email',
				ly_part = '$ly_part',
				ly_company = '$ly_company',
				ly_career = '$ly_career',
				".$img_update_01."
				".$img_update_02."
				ly_regidate = '$date'
				where ly_id = '$ly_id'
				";
			sql_query($sql);
			alert('정상적으로 수정하였습니다','?cms=lawyer_list');
		}else if($type=="d"){
			$sql = "delete from mari_lawyer where ly_id = '$ly_id'";
			sql_query($sql);
			alert('삭제처리하였습니다.');
		}else{
			alert('정상적인 접근이 아닙니다.');
		}


	break;

/************************************************
가상계좌목록
************************************************/
	case "illusion_acc_list":
		if ($add_bt == "선택삭제") {
					for ($i=0; $i<count($check); $i++)
					{
					$k = $check[$i];

					$sql = "select * from mari_seyfert where s_id = ".$s_id[$k]."";
					$memkey_chk = sql_fetch($sql);

					if($memkey_chk[s_accntNo]){
						alert('발급된 가상계좌가 있는경우에는 삭제가 불가능합니다.');
						exit;
					}
					if($memkey_chk[s_memGuid]){
						if($memkey_chk[s_memGuid]=="E"){
						}else{
						alert('정상적으로 발급된 멤버키가 있는경우에는 삭제가 불가능합니다.');
						exit;
						}
					}

					$sql = "delete from mari_seyfert where s_id = ".$s_id[$k]."";
					sql_query($sql);
					}
		alert('정상적으로 삭제 하였습니다.');
		//alert($sql);
	}
	break;

/************************************************
멤버키생성(관리자) 161205(동욱)
************************************************/
	case "member_key":

			/*발급여부확인*/
			$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
			$seyfck = sql_fetch($sql, false);

			$sql = "select phoneNo from mari_seyfert where phoneNo = '$m_hp'";
			$seyfck_no = sql_fetch($sql, false);

			if($seyfck[s_memGuid]){
				alert('이미 발급된 멤버키가 존재합니다.');
				exit;
			}else if(($m_id != trim($m_id)) || strpos($m_id, ' ')){
				alert('아이디에 공백이 존재합니다. 공백을 삭제한 후에 다시 시도해주시기 바랍니다.');
				exit;
			}else if(($m_name != trim($m_name)) || strpos($m_name, ' ')){
				alert('이름에 공백이 존재합니다. 공백을 삭제한 후에 다시 시도해주시기 바랍니다.');
				exit;
			}else if($m_hp != trim($m_hp)){
				alert('휴대폰번호에 공백이 존재합니다. 공백을 삭제한 후에 다시 시도해주시기 바랍니다.');
				exit;
			}else if($seyfck_no[phoneNo]){
				alert('이미 같은 번호로 발급된 멤버키가 존재합니다. 다른번호로 변경한 후에 다시 시도해주시기바랍니다.');
				exit;
			}

			/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){

				/*데이터 암호화 복호화 플러그인 start*/
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*•해당값을 encReq 에 바인딩 하고 reqMemGuid 과 _method 를 추가*/


			if(!$seyfck['s_memGuid']){


				$ENCODE_PARAMS="&_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&nonce=".$nonce."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE";

				$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
				$cipherEncoded = urlencode($cipher);
				$requestString = "_method=POST&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;



					/*****Seyfert Create Member(멤버 생성) START*****/
						//header("Content-Type: text/html; charset=utf-8");
						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_reqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
						$requestPath = "https://v5.paygate.net/v5a/member/createMember?".$requestString;
						$curl_handle = curl_init();

						//$ENCODE_PARAMS = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS);
						curl_setopt($curl_handle, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/createMember');
						$result = curl_exec($curl_handle);
						curl_close($curl_handle);


						/*파싱*/
						$decode = json_decode($result, true);
						/*
						print_r($requestPath);
						echo"<br/><br/>";
						print_r($result1);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS);
						echo"<br/><br/>";
						print_r($decode);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode as $key=>$value){
							$memGuid=$value['memGuid'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='$m_id' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if(!$seyck['m_id']){
									$sql = " insert into  mari_seyfert
												set s_memGuid='$memGuid',
												m_id='$m_id',
												phoneNo='$m_hp',
												m_name='$m_name',
												s_memuse='Y',
												s_ip='$ip',
												s_redatetime='$date'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}


			}else{


			/*정보수정시 휴대폰번호가 다른경우 seyfck phoneNo 변경되도록 추가 2016-10-07 임근호*/
			if($seyfck['phoneNo']==$m_hp){
			}else{


						/*페이게이트 정산nonce체크시 숫자변경*/
						$modify_code = "M".time().rand(111,999);
						/*발급여부확인*/
						$sql = "select  * from mari_member where m_id='$m_id'";
						$memseyfck = sql_fetch($sql, false);


						$ENCODE_PARAMS_modify="&_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&desc=desc&_lang=ko&dstMemGuid=".$seyfck[s_memGuid]."&nonce=".$modify_code."&emailAddrss=".$m_id."&emailTp=PERSONAL&fullname=".urlencode($m_name)."&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=".$m_hp."&phoneTp=MOBILE&addrss1=".urlencode($memseyfck[m_addr1])."&city=SEOUL&addrssCntryCd=KOR&firstname=".urlencode($user[m_name])."&lastname=".urlencode($m_name)."";

						$cipher = AesCtr::encrypt($ENCODE_PARAMS_modify, $KEY_ENC, 256);
						$cipherEncoded = urlencode($cipher);
						$requestString_modify = "_method=PUT&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded;

						$requestPath_modify = "https://v5.paygate.net/v5a/member/allInfo?".$requestString_modify;

						$curl_handle_modify = curl_init();
						//$ENCODE_PARAMS_modify = iconv("EUC-KR", "UTF-8", $ENCODE_PARAMS_modify);
						curl_setopt($curl_handle_modify, CURLOPT_URL, $requestPath_modify);
						/*curl_setopt($curl_handle_modify, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handle_modify, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handle_modify, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handle_modify, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handle_modify, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5a/member/allInfo');
						$result_modify = curl_exec($curl_handle_modify);
						curl_close($curl_handle_modify);
						/*파싱*/
						$decode_modify = json_decode($result_modify, true);

						/*
						print_r($decode_modify);
						print_r($requestPath_modify);
						echo"<br/><br/>";
						print_r($result_modify);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_modify);
						echo"<br/><br/>";
						print_r($decode_modify);
						*/
						/*array데이터가 없을경우 foreach을 실행하지 않는다.*/


						if(!empty($decode_modify)) {
						/*foreach 파싱 데이터출력*/
							foreach($decode_modify as $key=>$value){
							$emailAddrss=$value['emailAddrss'];/*생성된 맴버키*/
							/*$memGuid = preg_replace("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $memGuid);*/
							/*1회만실행*/
							$sql = "select  * from mari_seyfert where m_id='".$m_id."' and s_memuse='Y'";
							$seyck = sql_fetch($sql, false);
								if($seyck['m_id']){
									$sql = " update mari_seyfert
												set phoneNo='$m_hp',
												s_ip='$ip',
												s_redatetime='$date' where m_id='".$seyck[m_id]."'";
									sql_query($sql);
								}

							/*
							echo $memGuid;
							*/
							}
						}


				}
			}
			}
				alert('멤버키가 정상적으로 발급되었습니다.');
	break;



/************************************************
SMS/EMAIL 푸시알림
************************************************/

	case "pushlist_send":



					/*푸쉬 동의한 회원정보 불러오기*/
					$sql = "select  * from mari_push where p_push_use='Y'";
					$pushck_list = sql_query($sql, false);


						for ($i=0; $pushck=sql_fetch_array($pushck_list); $i++) {


								/*문자치환 사이트주소*/
								$investstart_msg = str_replace("{사이트주소}", MARI_HOME_URL, $msg);
								//$investstart_msg=nl2br($investstart_msg);
								$message_msg=mb_strlen($investstart_msg, "euc-kr");

								/*이메일 주소가 있을경우 발송*/
								if($pushck['p_email']){

									$mailsubject = "[".$config[c_title]."] ".$msg_title."";
									$mailcontent .= '<br /><br />';
									$mailcontent .= ''.$investstart_msg.'';
									$mailcontent .= '<br /><br /><br />';
									$mailcontent .= '----------------------------------------------<br />';
									$mailcontent .= ''.$config[c_title].'<br />';
									$mailcontent .= '----------------------------------------------<br />';


									mail_ok($pushck['m_name'], $pushck['p_email'], $pushck['p_email'], $mailsubject, $mailcontent, 1);
								}

								/*휴대폰번호가 있을경우 발송*/
								if($pushck['p_hp']){


									/*80바이트 이상일경우 lms로 발송*/
									if($message_msg <=80){
										$sendSms="sendSms";

											/*POST전송할 데이터 SMS*/
											$post_data = array(
											 "cid" => "".$config[c_sms_id]."",
											 "from" => "".$config[c_sms_phone]."",
											 "to" => "".$pushck['p_hp']."",
											 "msg" => "".$investstart_msg."",
											 "mode" => "".$sendSms."",
											 "smsmsg" => "투자 알림 메시지가 'SMS 수신 동의'한 회원들에게 정상적으로 발송되었습니다.",
											 "returnurl" => "".MARI_HOME_URL."?cms=reservation_send"
											);

									}else{
										$sendSms="sendSms_lms";

											/*POST전송할 데이터 LMS*/
											$post_data = array(
											 "cid" => "".$config[c_sms_id]."",
											 "from" => "".$config[c_sms_phone]."",
											 "msg_title" => "".$msg_title."",
											 "to" => "".$pushck['p_hp']."",
											 "msg" => "".$investstart_msg."",
											 "mode" => "".$sendSms."",
											 "smsmsg" => "투자 알림 메시지가 'SMS 수신 동의'한 회원들에게 정상적으로 발송되었습니다.",
											 "returnurl" => "".MARI_HOME_URL."?cms=reservation_send"
											);

									}

								}

								/*비회원인경우 guest로 등록*/
								if(!$row[m_id]){
									$m_name="guest";
								}else{
									$m_name=$pushck[m_name];
								}
								if($pushck['p_hp'] && $pushck['p_email']){
									$pm_push_type="SMS|EMAIL";
								}else if($pushck['p_hp']){
									$pm_push_type="SMS|";
								}else{
									$pm_push_type="EMAIL|";
								}


									$sql="insert into mari_push_msg
												 set m_id = '".$pushck[m_id]."',
												m_name = '$m_name',
												pm_push_type = '".$pm_push_type."',
												pm_msg_title = '".$msg_title."',
												pm_msg = '".$investstart_msg."',
												pm_redatetime = '$date'";
									sql_query($sql);


										/*회원 비회원 공통url발송처리*/
										$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y&rsend=Y";
										$curl_sms = curl_init();
										curl_setopt($curl_sms, CURLOPT_URL, $requestPath_sms);
										/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
										curl_setopt($curl_sms, CURLOPT_POST, 1);
										curl_setopt($curl_sms, CURLOPT_POSTFIELDS, $post_data);
										$result_sms = curl_exec($curl_sms);
										curl_close($curl_sms);
										/*SMS CURL전송*/


						}//for

		alert('정상적인 으로 푸쉬알림메세지를 전송 하였습니다.');

	break;



/******************************************************************
관리자 정산스케쥴등록폼 2017-02-17 임근호 전체업데이트예정
******************************************************************/

	case "repay_schedule_form":

		if($type=="w"){


			/*대출정보*/
				$sql = " select * from mari_loan where i_id='$loan_id'";
				$loanidck = sql_fetch($sql, false);

			/*스케쥴 정보*/
				$sql = " select * from mari_repay_schedule where loan_id='$loan_id' and r_count='$r_count'";
				$scdck = sql_fetch($sql, false);


			/*상품 체크*/
			if(!$loanidck['i_id']){
				alert('상품이 존재하지 않습니다.');
				exit;
			}



			/*스케쥴정보 insert*/
				$sql = " insert into mari_repay_schedule
							set loan_id = '$loan_id',
							r_subject = '".$loanidck[i_subject]."',
							r_salestatus = '$r_salestatus',
							r_count = '$r_count',
							r_view = '$r_view',
							r_orderdate = '$r_orderdate',
							r_regdatetime = '$date',
							r_ip = '$ip'";
				sql_query($sql);


			alert('정상적으로 스케쥴정보를 생성 하였습니다.');
		}else if($type=="d"){
			if (!count($check)) {
				alert($add_bt." 하실 리스트를 1개이상 체크하여 주십시오.");
			}
			if ($add_bt == "선택삭제") {
				for ($i=0; $i<count($check); $i++)
				{
				$k = $check[$i];

				/* 삭제*/
						$sql = "delete from mari_repay_schedule where r_id='$r_id[$k]'";
						sql_query($sql);
				}
			alert('정상적으로 삭제처리 하였습니다.');
			}else{
			alert('정상적인 접근이 아닙니다.');
			}
		}else{
		alert('정상적인 접근이 아닙니다.');
		}

	break;



/******************************************************************
투자상품 첨부파일삭제
******************************************************************/
	case "invest_file_setup":
		if($type=="d"){

			@unlink(MARI_DATA_PATH."/file/".$loan_id."/".$file_name."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $file_name)) {
				delete_board_thumbnail('file/'.$loan_id, $file_name);
			}

			$sql = "delete from mari_invest_file where file_idx = '$file_idx' and loan_id = '$loan_id'";
			sql_query($sql);

			alert('정상적으로 삭제하였습니다.');
		}
	break;










}
?>
