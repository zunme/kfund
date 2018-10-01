<?php
include_once('./_Common_execute_class.php');

		/*다날 플러그인*/
		include_once(MARI_PLUGIN_PATH.'/pg/danal/function.php');

	/****************************************************************************
	 * 가상계좌 결과 통보. 
	 *  - Noti.php
	 *     
	 * 결제시스템 연동에 대한 문의사항 있으시면 기술지원팀으로 연락 주십시오.
	 * DANAL Commerce Division Technique supporting Team 
	 * EMAIL : tech@danal.co.kr
	 ****************************************************************************/

		error_reporting(0);
		$old_error_handler = set_error_handler("userErrorHandler", E_ERROR|E_PARSE|E_CORE_ERROR|E_COMPILE_ERROR);

		// Ready.php : ISNOTICRYPTO - Y( NOTI 암호화 전송 )
		$Out = "";
		$Out .= Arr2Str(str2data(Decrypt($_POST['DATA'])));
		
		$data = Decrypt($_POST['DATA']);
		/*$data = Decrypt($_POST['DATA']);*/
		$REQ_DATA 	= str2data($data);
		// Ready.php : ISNOTICRYPTO - N( NOTI 암호화 미전송 )
		// $Out = "";
		// $Out .= Arr2Str($_POST);



		$RETURNCODE=$REQ_DATA["RETURNCODE"];//결과코드
		$RETURNMSG=$REQ_DATA["RETURNMSG"];//결과메세지
		$TID=$REQ_DATA["TID"];//다날거래번호
		$ORDERID=$REQ_DATA["ORDERID"];//CP주문번호
		$AMOUNT=$REQ_DATA["AMOUNT"];//입금 요청 금액
		$TRANDATE=$REQ_DATA["TRANDATE"];//가상계좌 발급 일자
		$TRANTIME=$REQ_DATA["TRANTIME"];//가상게좌 발급 시간
		$VIRTUALACCOUNT=$REQ_DATA["VIRTUALACCOUNT"];//가상계좌 번호
		$ACCOUNTHOLDER=$REQ_DATA["ACCOUNTHOLDER"];//예금주명(업체 명 or 고객명+업체 명)
		$USERNAME=$REQ_DATA["USERNAME"];//구매자 이름 (입금 의뢰자 명)2번째자리 Masking 
		$USERID=$REQ_DATA["USERID"];//구매자 ID
		$USERMAIL=$REQ_DATA["USERMAIL"];//구매자 EMAIL
		$ITEMNAME=$REQ_DATA["ITEMNAME"];//상품명
		$BYPASSVALUE=$REQ_DATA["BYPASSVALUE"];//추가필드 값 
		$EXPIREDATE=$REQ_DATA["EXPIREDATE"];//입금 마감 기한 (미 설정 시 요청일로 +10일로 설정)
		$EXPIRETIME=$REQ_DATA["EXPIRETIME"];//입금 마감 시간
		$ITEMNAME=$REQ_DATA["ITEMNAME"];//상품명
		$BANKCODE=$REQ_DATA["BANKCODE"];//은행코드
		$ISTAXSAVE=$REQ_DATA["ISTAXSAVE"];//현금영수증 설정 유무 (Y or N)
		$DEPOSIDATE=$REQ_DATA["DEPOSIDATE"];//입금처리 일자
		$DEPOSITTIME=$REQ_DATA["DEPOSITTIME"];//입금처리 시간

		/*은행코드 설정*/
		if($BANKCODE=="003"){
			$BANKCODEADD="기업은행";
		}else if($BANKCODE=="004"){
			$BANKCODEADD="국민은행";
		}else if($BANKCODE=="005"){
			$BANKCODEADD="외환은행";
		}else if($BANKCODE=="011"){
			$BANKCODEADD="농협은행";
		}else if($BANKCODE=="020"){
			$BANKCODEADD="우리은행";
		}else if($BANKCODE=="023"){
			$BANKCODEADD="Standard Chartered은행";
		}else if($BANKCODE=="031"){
			$BANKCODEADD="대구은행";
		}else if($BANKCODE=="032"){
			$BANKCODEADD="부산은행";
		}else if($BANKCODE=="034"){
			$BANKCODEADD="광주은행";
		}else if($BANKCODE=="039"){
			$BANKCODEADD="경남은행";
		}else if($BANKCODE=="071"){
			$BANKCODEADD="우체국";
		}else if($BANKCODE=="081"){
			$BANKCODEADD="하나은행";
		}else if($BANKCODE=="088"){
			$BANKCODEADD="신한은행";
		}

				/*가상계좌 내역 DB에저장*/
				$sql = " update mari_virtualaccount 
							set RETURNCODE = '$RETURNCODE', 
							RETURNMSG = '$RETURNMSG',
							TID = '$TID',
							ORDERID = '$ORDERID',
							AMOUNT = '$AMOUNT',
							TRANDATE = '$TRANDATE',
							TRANTIME = '$TRANTIME',
							VIRTUALACCOUNT = '$VIRTUALACCOUNT',
							ACCOUNTHOLDER = '$ACCOUNTHOLDER',
							USERNAME = '$USERNAME',
							USERID = '$USERID',
							USERMAIL = '$USERMAIL',
							ITEMNAME = '$ITEMNAME',
							BYPASSVALUE = '$BYPASSVALUE',						
							DEPOSIDATE = '$DEPOSIDATE',	
							DEPOSITTIME = '$DEPOSITTIME',
							BANKCODE = '$BANKCODEADD',
							ISTAXSAVE = '$ISTAXSAVE',
							v_regdatetime = '$date',
							v_ip = '$ip' where USERID='".$USERID."' and ORDERID='".$ORDERID."'";
					sql_query($sql);


			/*회원정보 찾기 포인트합 때문에*/
				$sql = " select * from mari_member where m_id='".$USERID."'";
				$em = sql_fetch($sql, false);

			/*포인트 합산*/
				$p_top_emoney=$AMOUNT+$em['m_emoney'];


				/*회원가상계좌정보에 DB에저장*/
				$sql = " update mari_member 
							set m_my_bankcode = '$BANKCODEADD', 
							m_my_bankname = '$USERNAME',
							m_paymentamount = '$AMOUNT',
							m_emoney = '".$p_top_emoney."',
							m_my_bankendtime = '".$EXPIREDATE."".$EXPIRETIME."',
							m_my_bankacc = '".$VIRTUALACCOUNT."' where m_id='".$USERID."'";
				sql_query($sql);

				/*충전 내역 DB에 UPDATE*/
				$sql = " update mari_char 
							set m_id = '$USERID', 
							m_name = '$ACCOUNTHOLDER',
							c_pay = '$AMOUNT',
							c_fin = 'Y',
							c_regdatetime = '$date',
							c_ip = '$ip' where m_id='".$USERID."'";
				sql_query($sql);

		
		if(!file_exists(MARI_DATA_PATH."/log")){
			echo ("Fail-Cannot open log file");
			exit();
		}

		$fp = fopen(MARI_DATA_PATH."/log/noti_".date("Ymd").".log","a+");
		fputs($fp,"[".date("Y-m-d H:i:s")."]".$Out."\n");
		fclose($fp);

		echo("OK");
		/***************************************************
		 * Noti 성공 시 결제 완료에 대한 작업
		 * - Noti의 결과에 따라 DB작업등의 코딩을 삽입하여 주십시오. 
		 * - ORDERID, AMOUNT 등 결제 거래내용에 대한 검증을 반드시 하시기 바랍니다.
		 ****************************************************/


?>