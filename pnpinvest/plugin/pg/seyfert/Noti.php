<?php
include_once('./_Common_execute_class.php');
$timetoday = mktime();
$date = date("Y-m-d H:i:s", $timetoday);
$ip=$_SERVER['REMOTE_ADDR'];
/*페이게이트 nonce체크시 숫자변경*/
$nonce_ap = time().rand(111,999);
$nonce=$nonce_ap;
/*CONFIG설정*/
$config = sql_fetch(" select * from mari_config ");
/*seyfert가상계좌 시스템 사용여부*/
if($config['c_seyfertck']=="Y"){
	/*페이게이트 전자결제 계정*/
	$KEY_ENC = $config[c_reqMemKey];
	$GUID = $config[c_reqMemGuid];
	$COMMON_ENC = "UTF-8";
}
/* 임시 */
$sql = "insert into z_seyfert_unloged values (0, '$tid' , '$refId','$trnsctnSt','$trnsctnTp',now())";
sql_query($sql);

/*
지정한 URL로 세이퍼트 멤버의 가상계좌 입금 내역을 통지는 해당 url로 전송됨
http://업체도메인/업체폴더명/plugin/pg/seyfert/Noti.php
trnsctnTp : 거래종류
trnsctnSt : 거래상태
*/

/*상태,종류테스트
						$sql = "insert into mari_member
									set m_test = '".$trnsctnTp." / ".$trnsctnSt."'";
						sql_query($sql);
*/
/*가상계좌 입금처리*/
	if($dstMemGuid && $trnsctnTp=="SEYFERT_PAYIN_VACCNT" && $trnsctnSt=="SFRT_PAYIN_VACCNT_FINISHED"){
		/*
	if($trAmt && $trnsctnTp=="SEYFERT_PAYIN_VACCNT" && $trnsctnSt=="SFRT_PAYIN_VACCNT_FINISHED"){
		*/


				/*세이퍼트주문 회원정보*/
				$sql = "select  * from  mari_seyfert_order where s_tid='".$tid."'";
				$seyorder = sql_fetch($sql, false);

				/*가상계좌 내역 DB에저장*/
				$sql = " update mari_seyfert
							set custNm = '$custNm',
							inName = '$inName',
							totAmt = '$totAmt',
							trAmt = '$trAmt',
							orgAmt = '$orgAmt',
							trnsctnTp = '$trnsctnTp',
							trnsctnSt = '$trnsctnSt',
							trDate = '$trDate',
							trTime = '$trTime',
							redatetime = '$date'
							where s_memGuid='".$dstMemGuid."' order by s_redatetime desc";
					sql_query($sql);

			/*세이퍼트 계좌신청자중 회원정보찾기 */
				$sql = "select  * from mari_seyfert where s_memGuid='".$dstMemGuid."' and s_memuse='Y' order by s_redatetime desc";
				$seyck = sql_fetch($sql, false);


			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$seyck[m_id]."'";
				$em = sql_fetch($sql, false);

			/*포인트 합산*/
				$p_top_emoney=$trAmt+$em['m_emoney'];


				/*회원가상계좌정보에 DB에저장*/
				$sql = " update mari_member
							set m_inName = '".$inName."',
							m_trAmt = '".$trAmt."',
							m_emoney = '".$p_top_emoney."',
							m_my_bankendtime = '".$trDate."".$trTime."'
							where m_id='".$seyck[m_id]."'";
				sql_query($sql);

				/*포인트지급내용 저장*/
				$sql = " insert into mari_emoney
							set m_id = '".$seyck[m_id]."',
							p_datetime = '$date',
							p_content = 'E-머니 가상계좌 결제 충전',
							p_emoney = '".$trAmt."',
							p_ip = '$ip',
							p_top_emoney = '$p_top_emoney'";
							sql_query($sql);


				/*충전 내역 DB에 UPDATE*/
				$sql = " insert into mari_char
							set m_id = '".$seyck[m_id]."',
							m_name = '".$inName."',
							c_pay = '".$trAmt."',
							c_fin = 'Y',
							c_regdatetime = '$date',
							c_ip = '$ip'";
				sql_query($sql);
			/*충전에 성공했을시*/



					/* 충전내역 order 추가 insert 2017-08-29*/
					$sql="insert into mari_seyfert_order
								set s_release = 'N',
									s_tid = '".$tid."',
									m_id = '".$seyck[m_id]."',
									s_amount = '".$trAmt."',
									trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."',
									s_subject = '입금처리',
									m_name = '".$inName."',
									s_type = '4',
									s_date = '$date'";
					sql_query($sql);


				echo"SUCCESS";


/*결제용 가상계좌 입금처리(대출자)*/
	}else if($dstMemGuid && $trnsctnTp=="SEYFERT_PAYIN_PVACCNT" && $trnsctnSt=="SFRT_PAYIN_PVACCNT_FINISHED"){
		/*
	if($trAmt && $trnsctnTp=="SEYFERT_PAYIN_VACCNT" && $trnsctnSt=="SFRT_PAYIN_VACCNT_FINISHED"){
		*/

				/*가상계좌 내역 DB에저장*/
				$sql = " update mari_seyfert
							set custNm = '$custNm',
							inName = '$inName',
							totAmt = '$totAmt',
							trAmt = '$trAmt',
							orgAmt = '$orgAmt',
							trnsctnTp = '$trnsctnTp',
							trnsctnSt = '$trnsctnSt',
							trDate = '$trDate',
							trTime = '$trTime',
							redatetime = '$date'
							where s_memGuid='".$dstMemGuid."' order by s_redatetime desc";
					sql_query($sql);

			/*세이퍼트 계좌신청자중 회원정보찾기 */
				$sql = "select  * from mari_seyfert where s_memGuid='".$dstMemGuid."' and s_memuse='Y' order by s_redatetime desc";
				$seyck = sql_fetch($sql, false);


			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$seyck[m_id]."'";
				$em = sql_fetch($sql, false);

			/*포인트 합산*/
				$p_top_emoney=$trAmt+$em['m_emoney'];



				/*포인트지급내용 저장*/
				$sql = " insert into mari_emoney
							set m_id = '".$seyck[m_id]."',
							p_datetime = '$date',
							p_content = '대출금 상환 입금처리',
							p_emoney = '".$trAmt."',
							p_ip = '$ip',
							p_top_emoney = '$trAmt'";
							sql_query($sql);


				/*충전 내역 DB에 UPDATE*/
				$sql = " insert into mari_char
							set m_id = '".$seyck[m_id]."',
							m_name = '".$inName."',
							c_pay = '".$trAmt."',
							c_fin = 'Y',
							c_regdatetime = '$date',
							c_ip = '$ip'";
				sql_query($sql);
			/*충전에 성공했을시*/

					/* 충전내역 order 추가 insert 2017-08-29*/
					$sql="insert into mari_seyfert_order
								set s_release = 'N',
									s_tid = '".$tid."',
									m_id = '".$seyck[m_id]."',
									s_amount = '".$trAmt."',
									trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."',
									s_subject = '입금처리',
									m_name = '".$inName."',
									s_type = '4',
									s_date = '$date'";
					sql_query($sql);


				echo"SUCCESS";


	/*
	세이퍼트 펜딩 거래에 동의 된 경우 Notice when seyfert seyfert penfing agreement is completed
	세이퍼트펜딩이체 && 세이퍼트 펜딩 이체 완료 (낮은 금액에 대한 미인증 이체)
	*/
	/*
	}else if($trnsctnTp=="SEYFERT_TRANSFER_PND" && $trnsctnSt=="AGREE_FORCED_BY_MERCHANT" && $tid){
	*/


	/*
	세이퍼트 이체에 대한 동의를 완료한 직후 Notice when seyfert transfer request is finished or completed
	세이퍼트펜딩이체 && 세이퍼트 펜딩 이체 완료 (낮은 금액에 대한 미인증 이체)
	*/
	}else if($trnsctnTp=="SEYFERT_TRANSFER_PND" && $trnsctnSt=="SFRT_TRNSFR_PND_AGRREED" && $tid && $refId){


				/*세이퍼트주문 회원정보*/
				$sql = "select  * from  mari_seyfert_order where s_refId='".$refId."' and s_tid='".$tid."'";
				$seyorder = sql_fetch($sql, false);


				/*투자 회원정보*/
				$sql = "select  * from  mari_member where m_id='".$seyorder[m_id]."'";
				$m_ck = sql_fetch($sql, false);

				/*대출 상세정보*/
				$sql = "select  * from  mari_loan where i_id='".$seyorder[loan_id]."'";
				$loa = sql_fetch($sql, false);

				/*투자정보 상세정보 2017-02-21 임근호*/
				$sql = "select  * from  mari_invest where loan_id='".$seyorder[loan_id]."' and m_id='".$seyorder[m_id]."'";
				$investck = sql_fetch($sql, false);

				if(!isset($seyorder['s_id']) || (int)$seyorder['s_id'] < 1){
					/*관련 자료를 찾을 수 없을 경우 로그 남기고 종료처리 2018-01-19*/
					$sql = "insert into mari_seyfert_over (seyfert_order_id, refId, tid, status, regdate ) values ('0','".$refId."', '".$tid."','U', now() )";
					sql_query($sql);
					exit;
				}

				/*중복투자건으로 중복은 투자불가하도록 2017-02-21 임근호*/
				if(!$investck['i_pay']){



					//if(true){
						/* over funding
							- + 이백만원 오버펀딩 인정
							- lock 없음 - 일부 오버펀딩 인정함
							- mari_invest 와 1:1 매칭이 되지 않아서 중복투자안쪽에서 체크

							2018-01-12 임성택 */
						$sql = "select ifnull( sum(i_pay), 0) as total from mari_invest where loan_id = ".(int) $seyorder['loan_id'];
						$over = sql_fetch($sql, false);
						if( (int)$over['total'] + (int)$seyorder['s_amount'] > (int)$loa['i_loan_pay'] + 2000000){
							$sql = "insert into mari_seyfert_over (loan_id,seyfert_order_id, m_id,refId, tid, regdate ) values (".(int)$seyorder['loan_id']." ,'".$seyorder['s_id']."', '".$seyorder['m_id']."','".$refId."', '".$tid."', now() )";
							sql_query($sql, false);
							if(!isset($seyorder['s_id']) || (int)$seyorder['s_id'] < 1) exit;
							$url = "https://v5.paygate.net/v5/transaction/seyfertTransferPending/cancel";
							$_method = "POST";
							$nonce      = "CO" . time() . rand(111, 999);
							//$refId      = "COr" . time() . rand(111, 999);
							$cont ="[" .$loa['i_subject']. "] 펀딩 금액 초과로 인한 취소";
							$ENCODE_PARAMS   = "&_method=POST&desc=desc&_lang=ko&reqMemGuid=" . trim($config['c_reqMemGuid'])
																. "&nonce=" . $nonce . "&title=" . urlencode($cont) . "&refId=" . $refId
																. "&authType=SMS_MO&timeout=30&parentTid=".$tid;
							include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
							$cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC , 256);
							$cipherEncoded = urlencode($cipher);
							$requestString = "_method=POST&reqMemGuid=".$config['c_reqMemGuid']."&encReq=".$cipherEncoded;
							$requestPath = $url."?".$requestString;

							$curl_handlebank = curl_init();
							curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
							curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');
							curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
							curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
							curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
							curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
							$result = curl_exec($curl_handlebank);
							if( $result===false ) $curlerror = curl_error($curl_handlebank);
							curl_close($curl_handlebank);
							$decode = json_decode($result, true);
							if( !is_array( $decode) )  $res = false; // return array(false, $curlerror);
							else $res = true;
							if($res===true && $decode['status']=='SUCCESS'){
								$canceltid = isset($decode['data']['tid']) ? $decode['data']['tid'] : 'NONE_TID';
								$sql = "update mari_seyfert_over set status ='Y' ,  cancel_tid='".$canceltid."' where seyfert_order_id = ".$seyorder['s_id'];
								sql_query($sql, false);
								$sql = "update mari_seyfert_order set s_tid='".$canceltid."' ,o_funding_cancel='Y' where s_tid = '".$tid."' and s_refid ='".$refId."'";
								sql_query($sql, false);
								echo "SUCCESS";

								//sms
								$invest_msg_01 = "[" .$loa['i_subject']. "] 펀딩 금액 초과로 투자가 취소되었습니다.케이펀딩을 이용해 주셔서 감사합니다.";
								$message_msg   = mb_strlen($invest_msg_01, "euc-kr");
								$sendSms = ($message_msg <= 80) ? "sendSms" : "sendSms_lms";
								$post_data       = array(
										"cid" =>  $config['c_sms_id'] ,
										"from" => $config['c_sms_phone'],
										"to" => trim(str_replace(' ','',str_replace('-','',$m_ck['m_hp']))),
										"msg" => $invest_msg_01,
										"mode" => $sendSms,
										"smsmsg" => $invest_msg_01,
								);

								$requestPath_sms = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?smsload=Y";
								$curl_handlebank = curl_init();
								curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath_sms);
								curl_setopt($curl_handlebank, CURLOPT_ENCODING, 'UTF-8');
								curl_setopt($curl_handlebank, CURLOPT_POST, 1);
								curl_setopt($curl_handlebank, CURLOPT_POSTFIELDS, $post_data);
								curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
								curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
								curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
								$result = curl_exec($curl_handlebank);
								//SMS
							}else echo "OVER";
							exit;
						}
						/* END - over funding */


					$emoney=$m_ck[m_emoney]-$seyorder['s_amount'];
					$sql = "update mari_member
								set m_emoney = '".$emoney."'
								where m_id='".$seyorder[m_id]."'
								";
					sql_query($sql);



					/*대출 상세정보 insert*/
					$sql = "insert into mari_invest
								set i_pay = '".$seyorder[s_amount]."',
								i_goods = '$loa[i_payment]',
								m_id = '".$seyorder[m_id]."',
								loan_id = '".$seyorder[loan_id]."',
								m_name = '".$seyorder[m_name]."',
								user_name = '$loa[m_name]',
								user_id = '$loa[m_id]',
								i_subject = '$loa[i_subject]',
								i_loan_pay = '$loa[i_loan_pay]',
								i_pay_ment = 'Y',
								i_profit_rate = '$loa[i_year_plus]',
								i_max_pay = '$loa[i_loan_day]',
								i_day = '$loa[i_loan_pay]',
								i_level_dti = '$loa[i_level_dti]',
								i_invest_eday = '$loa[i_invest_eday]',
								i_ip = '$ip',
								i_regdatetime = '$date'
								";
					sql_query($sql);

					$sql = " select * from mari_member where m_id='".$seyorder[m_id]."'";
					$em = sql_fetch($sql, false);


					/*투자포인트 제외*/
					$p_top_emoney= $em['m_emoney'];

					/*포인트지급내용 저장*/
					$sql = " insert into mari_emoney
								set m_id = '".$seyorder[m_id]."',
								p_datetime = '$date',
								p_content = '".$seyorder[s_subject]."',
								p_emoney = '".$seyorder[s_amount]."',
								p_ip = '$ip',
								p_top_emoney = '$p_top_emoney'";
					sql_query($sql);

					/*결제동의여부 저장  2017-09-27 거래상태 trnsctnSt 거래종류 trnsctnTp 추가*/
					$sql = " update  mari_seyfert_order
								set s_payuse='Y',
									trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."'
								where s_refId='".$refId."' and s_tid='".$tid."'";
					sql_query($sql);



				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

				/*가상계좌 세이퍼트멤버생성정보*/
				$sql = "select  * from mari_seyfert where m_id='".$seyorder[m_id]."' and s_memuse='Y'";
				$seyfck = sql_fetch($sql, false);

							$ENCODE_PARAMS_acc="&_method=POST&desc=desc&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce."&dstMemGuid=".$seyfck[s_memGuid]."&accntNo=".$em[m_my_bankacc]."&bnkCd=".$em[m_my_bankcode]."&cntryCd=KOR";

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






				echo"SUCCESS";
				}

	/*CHECK_BNK_CD 은행 계좌에 1원을 송금하며 송금자 이름에 6자리의 인증코드를 전달하여 문자로 답변하여 계좌주를 인증한다.*/
	}else if($trnsctnTp=="CHECK_BNK_CD"){
			/*CHECK_BNK_CD_FINISHED 예금주 코드 검증 완료*/
			if($trnsctnSt=="CHECK_BNK_CD_FINISHED"){
					/*세이퍼트주문 회원정보*/
					$sql = "select  * from  mari_seyfert_order where  s_tid='".$tid."'";
					$sey = sql_fetch($sql, false);

						$sql = "update mari_member
									set m_verifyaccountuse = 'Y'
									where m_id='".$sey[m_id]."'";
						sql_query($sql);


					/*2017-09-27 계좌검증저장 거래상태 trnsctnSt 거래종류 trnsctnTp 추가*/
					$sql = " update  mari_seyfert_order
								set trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."'
								where s_tid='".$tid."'";
					sql_query($sql);



				echo"SUCCESS";

			}

	/*출금처리 프로세스
	SFRT_WITHDRAW_FINISHED 세이퍼트 출금 완료
	*/
	}else if($trnsctnSt=="SFRT_WITHDRAW_FINISHED"){


			/*세이퍼트주문 출금신청 회원정보*/
				$sql = "select  * from  mari_seyfert_order where s_refId='".$refId."' and s_tid='".$tid."'";
				$seyorder = sql_fetch($sql, false);

				$sql = "select  * from  mari_outpay where  o_refId='".$refId."'";
				$outpay_p = sql_fetch($sql, false);

					/*2017-09-27 출금결과저장 거래상태 trnsctnSt 거래종류 trnsctnTp 추가*/
					$sql = " update  mari_seyfert_order
								set trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."'
								where s_refId='".$refId."' and s_tid='".$tid."'";
					sql_query($sql);


		if($outpay_p['o_fin']=="N"){

			/*세이퍼트주문 출금신청 회원정보*/
				$sql = "select  * from  mari_seyfert_order where s_refId='".$refId."' and s_tid='".$tid."'";
				$seyorder = sql_fetch($sql, false);

			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$seyorder[m_id]."'";
				$em = sql_fetch($sql, false);

			/*포인트 합산*/
				$p_top_emoney=$em['m_emoney']-$seyorder[s_amount];

				/*회원e머니정보 DB에저장*/
				$sql = " update mari_member
							set m_emoney = '".$p_top_emoney."' where m_id='".$seyorder[m_id]."'";
				sql_query($sql);

			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$seyorder[m_id]."'";
				$emstory = sql_fetch($sql, false);


			/*포인트출금내용 저장*/
				$sql = " insert into mari_emoney
							set m_id = '".$em[m_id]."',
							p_datetime = '$date',
							p_content = '".$seyorder[s_amount]."원 출금 신청금액',
							p_ip = '$ip',
							p_emoney = '".$seyorder[s_amount]."',
							p_top_emoney = '".$emstory[m_emoney]."'";
				sql_query($sql);

					/* update*/
					$sql="update mari_outpay
								set o_fin = 'Y',
									o_paydatetime = '$date'
								where o_refId='".$refId."'";
					sql_query($sql);

				echo"SUCCESS";


		}

	/*펀딩해제처리*/
	}else if($trnsctnSt=="SFRT_TRNSFR_PND_RELEASED" && $trnsctnTp=="PENDING_RELEASE" && $tid && $refId){

					/* update 거래상태 trnsctnSt 거래종류 trnsctnTp 추가*/
					$sql="update mari_seyfert_order
								set s_release = 'Y',
									s_tid = '".$tid."',
									trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."',
									s_date = '$date'
									where s_refId='".$refId."' and s_tid='".$parentTid."'";
					sql_query($sql);


				echo"SUCCESS";

	/*정산시 투자자에게 상점잔액 에스크로이체*/
	}else if($trnsctnTp=="SEYFERT_TRANSFER" && $tid && $refId){

					/* update*/
					$sql="update mari_seyfert_order
								set o_orderuse = 'Y',
									s_tid = '".$tid."',
									trnsctnTp = '".$trnsctnTp."',
									trnsctnSt = '".$trnsctnSt."',
									s_date = '$date'
									where s_refId='".$refId."' and s_tid='".$parentTid."'";
					sql_query($sql);

				echo"SUCCESS";

	}else {
		$sql = "insert into z_seyfert_unloged values (0, '$tid' , '$refId','$trnsctnSt','U_".$trnsctnTp."',now())";
		sql_query($sql);
		echo "SUCCESS";
	}


?>
