<?php
if (!defined('_MARICMS_')) exit;
/************************************************
Model
************************************************/
header('Content-Type: text/html; charset=utf-8');
@extract($_GET);
@extract($_POST);
@extract($_SERVER);
$timetoday = mktime();
$date = date("Y-m-d H:i:s", $timetoday); 
$ip=$_SERVER['REMOTE_ADDR'];

// 기본환경설정
// 기본적으로 사용하는 필드만 얻은 후 상황에 따라 필드를 추가로 얻음
$config = sql_fetch(" select * from mari_config ");
$popup = sql_fetch(" select * from mari_popup where po_openchk='1' order by po_start_date desc");
$popuproof = sql_query(" select * from mari_popup where po_openchk='1' order by po_start_date desc");
$pageexe = sql_query(" select * from mari_content where p_page_use='Y' and p_type='page'");
$pageexe_tpl = sql_query(" select * from mari_content where p_type='page'");
$incexe = sql_query(" select * from mari_content where p_page_use='Y' and p_type='inc'");
$incexe_tpl = sql_query(" select * from mari_content where p_type='inc'");
$pageexe_view = sql_fetch(" select * from mari_content where p_id='$p_id'");
$sql = " select  * from  mari_board order by bo_subject asc";
$bo_view = sql_query($sql, false);
$sql = " select  * from  mari_board";
$bo_lnb = sql_query($sql, false);
$sql = " select  * from  mari_board";
$board = sql_fetch($sql, false);
$sql = " select  * from  mari_mysevice_config";
$default = sql_fetch($sql, false);
$member_ck=$_SESSION['ss_m_id'];
$sql = " select  * from  mari_member where m_id='$member_ck'";
$user = sql_fetch($sql, false);
/*회원나이*/
$now_year = date("Y");
$now_age = (int)substr($user['m_birth'],0,4);
$m_age = $now_year - $now_age + 1;
/*입찰합계구하기*/
$sql="select sum(i_pay) from mari_invest"; 
$top=sql_query($sql, false);
$t_pay = mysql_result($top, 0, 0);

/*누적대출금*/
$sql="select sum(i_loan_pay) from mari_loan where i_loanapproval='Y'"; 
$l_top=sql_query($sql, false);
if($l_top){
	$t_loan_pay = mysql_result($l_top, 0, 0);
}

/*상환중인대출
$sql="select sum(i_loan_pay) from mari_order where user_id = '$user[m_id]'"; 
$o_top=sql_query($sql, false);
$t_order_pay = mysql_result($o_top, 0, 0);
*/

/*약관 노출여부*/
$sql ="select * from mari_config";
$conf = sql_fetch($sql,false);

/*대출이율합계구하기*/
$sql="select sum(i_year_plus) from mari_loan where i_view='Y'";
$top_p=sql_query($sql, false);
$t_plus = mysql_result($top_p, 0, 0);
/*대출건수구하기*/
$sql = " select count(*) as cnt from mari_loan where i_view='Y'";
$laons_plus = sql_fetch($sql);
$total_plus= $laons_plus['cnt'];
/*평균내기*/
if($laons_plus['cnt']){
	$top_plus=$t_plus/$total_plus;
}

/*개인입찰합계구하기*/
$sql="select sum(i_pay) from mari_invest where m_id = '$user[m_id]'"; 
$top2=sql_query($sql, false);
$t_pay2 = mysql_result($top2, 0, 0);

/*개인누적대출금*/
$sql="select sum(i_loan_pay) from mari_loan where m_id = '$user[m_id]' and i_loanapproval='Y'"; 
$l_top2=sql_query($sql, false);
if($l_top2){
	$t_loan_pay2 = mysql_result($l_top2, 0, 0);
}

/*개인 대출건수구하기*/
$sql = " select count(*) as cnt from mari_loan where m_id = '$user[m_id]'";
$laons_plus2 = sql_fetch($sql);
$total_plus2= $laons_plus2['cnt'];

/*개인대출이율합계구하기*/
$sql="select sum(i_year_plus) from mari_loan where m_id = '$user[m_id]'";
$top_p2=sql_query($sql, false);
$t_plus2 = mysql_result($top_p2, 0, 0);

/*평균내기*/
if($laons_plus2['cnt']){
	$top_plus2=floor($t_plus2/$total_plus2);
}

/*누적 대출상환금*/
$sql="select sum(o_investamount) from mari_order where o_status='입금완료'"; 
$lb_top=sql_query($sql, false);
if($lb_top){
$Loanrepayments = mysql_result($lb_top, 0, 0);
}




if($member_ck){
/*개인 투자건수구하기*/
$sql = " select count(*) as cnt from mari_invest where m_id = '$user[m_id]'";
$invest_plus2 = sql_fetch($sql);
$total_invest_plus2= $invest_plus2['cnt'];

/*개인투자이율합계구하기*/
$sql="select sum(i_profit_rate) from mari_invest where m_id = '$user[m_id]'";
$top_invest_p2=sql_query($sql, false);
$t_invest_plus2 = mysql_result($top_invest_p2, 0, 0);

/*평균내기*/
if($invest_plus2['cnt']){
	$top_invest_plus2=floor($t_invest_plus2/$total_invest_plus2);
}
}


/*관리권한*/
$sql = "select * from mari_authority where m_id = '$user[m_id]'";
$au = sql_fetch($sql, false);
/*회원관리권한*/
$au_member_sub = explode("|",$au[au_member_sub]);
/*슈퍼관리자설정*/
$SuperAdministrator="webmaster@admin.com";

$au_member_sub01 = $au_member_sub[0]; //회원목록
$au_member_sub02 = $au_member_sub[1]; //회원등급
$au_member_sub03 = $au_member_sub[2]; //탈퇴회원&복구
$au_member_sub04 = $au_member_sub[3]; //e-머니관리
$au_member_sub05 = $au_member_sub[4]; //로그분석
$au_member_sub06 = $au_member_sub[5]; //회원권한관리


/*대출관리권한*/
$au_loan_sub = explode("|",$au[au_loan_sub]);

$au_loan_sub01 = $au_loan_sub[0]; //대출현황
$au_loan_sub02 = $au_loan_sub[1]; //투자진행 설정

/*투자관리권한*/
$au_invest_sub = explode("|",$au[au_invest_sub]);

$au_invest_sub01 = $au_invest_sub[0]; //투자현황
$au_invest_sub02 = $au_invest_sub[1]; //결제관리
$au_invest_sub03 = $au_invest_sub[2]; //투자/결제설정
$au_invest_sub04 = $au_invest_sub[3]; //출금신청
$au_invest_sub05 = $au_invest_sub[4]; //충전내역
$au_invest_sub06 = $au_invest_sub[5]; //매출리포트

/*회계관리권한*/
$au_sales_sub = explode("|",$au[au_sales_sub]);
$au_sales_sub01 = $au_sales_sub[0]; //매출현황
$au_sales_sub02 = $au_sales_sub[1]; //대출자산
$au_sales_sub03 = $au_sales_sub[2]; //수납처리
$au_sales_sub04 = $au_sales_sub[3]; //정산완료
$au_sales_sub05 = $au_sales_sub[4]; //투자결제완료

/*관리권한 체크*/
$sql = "select m_id from mari_authority where m_id='".$user[m_id]."'";
$admin_ck = sql_fetch($sql, false);

if($mode){
	$sql = " select i_payment, i_subject, i_regdatetime, i_id, m_name from mari_loan order by i_regdatetime desc";
	$realloan = sql_query($sql, false);
	$sql = " select i_goods, i_subject, i_regdatetime, loan_id, m_name from mari_invest order by i_regdatetime desc";
	$realinvest = sql_query($sql, false);
	$sql = " select o_status, o_salestatus, o_payment, o_subject, o_datetime, o_collectiondate, o_count, loan_id, sale_name, user_name from mari_order order by o_datetime desc, o_collectiondate desc";
	$realorder = sql_query($sql, false);

		/*노출항목*/
		$realtimeitem_display = explode("|",$config[c_realtimeitem_display]);
		$realtimeitem_display_01 = $realtimeitem_display[0]; //투자
		$realtimeitem_display_02 = $realtimeitem_display[1]; //대출
		$realtimeitem_display_03 = $realtimeitem_display[2]; //입금
		$realtimeitem_display_04 = $realtimeitem_display[3]; //정산

		/*이름, 상품(분류), 날짜노출여부*/
		$displayprofile_use = explode("|",$config[c_displayprofile_use]);
		$displayprofile_use_01 = $displayprofile_use[0]; //이름
		$displayprofile_use_02 = $displayprofile_use[1]; //상품(분류)
		$displayprofile_use_03 = $displayprofile_use[2]; //날짜노출여부
}
/*로그인체크*/
if(!$member_ck){
	if($login_ck=="YES"){
		alert('로그인후 이용하실 수 있습니다.', MARI_HOME_URL.'/?mode=login&url=' . urlencode($_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING']));
	}
}

/*세션만 남아있을경우 로그인해제*/
if($session=="ck"){
}else{
	if($member_ck){
		if(!$member_ck){
			alert('세션이 만료 되었습니다. 다시 로그인 하여주십시오.', MARI_HOME_URL.'/?mode=logout&session=ck');
		}
	}
}

/*다음투자 오늘날짜기준 가까운날짜출력*/
$sql = " select  i_invest_sday from  mari_invest_progress where date_format(i_invest_sday,'%Y-%m-%d% %hh') > '$date' order by i_invest_sday asc";
$today = sql_fetch($sql, false);

/*날짜 자르기*/
$datetime=$today['i_invest_sday'];
$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
$Y_date = date("Y", strtotime( $datetime ) );
$M_date = date("m", strtotime( $datetime ) );
$D_date = date("d", strtotime( $datetime ) );
$H_date = date("H", strtotime( $datetime ) );
$I_date = date("i", strtotime( $datetime ) );
$A_date = date("a", strtotime( $datetime ) );
if($A_date=="pm"){
	$A_date="오후";
}else if($A_date=="am"){
	$A_date="오전";
}

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

/*페이게이트 잔액전용nonce체크시 숫자변경*/
$nonce_lnq = time().rand(111,99);

/*페이게이트 주문번호 생성*/
$g_code = "P".time().rand(111,999);




/*********************************************************************************
HOME SELECT START
**********************************************************************************/
switch ($mode){


/************************************************
main 메인테스트
************************************************/
	case "main":

		$sql = " select * from mari_loan where i_view='Y'  order by i_id desc limit 3";
		$result = sql_query($sql, false);

		
		$sql = " select  * from mari_write where w_table ='media' order by w_datetime desc limit 2";
		$result1 = sql_query($sql, false);
		
		$sql = " select * from mari_loan where i_recom='Y' and i_view='Y' order by i_regdatetime desc limit 3";
		$result3 = sql_query($sql, false);
	
	
		/*누적 대출상환금*/
		$sql="select sum(o_investamount) from mari_order where o_status='입금완료'"; 
		$lb_top=sql_query($sql, false);
		$Loanrepayments = mysql_result($lb_top, 0, 0);

		/*개인누적 대출상환금*/
		$sql="select sum(o_investamount) from mari_order where o_status='입금완료' and user_id = '$user[m_id]'"; 
		$lb_top2=sql_query($sql, false);
		$Loanrepayments2 = mysql_result($lb_top2, 0, 0);
	

		/*투자인원 구하기*/
		$sql = " select count(*) as cnt from mari_invest where loan_id='$loan_id' order by i_pay desc";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];


		$sql = "select * from  mari_inset";
		$allpay = sql_fetch($sql, false);
		
		$sql = "select * from mari_advice";
		$adv = sql_query($sql);
			$header = "main";


		/*2017.11.07  투자상품이 상환완료인것만 누적상환금에 원금표시*/
		$sql = "SELECT SUM(i_pay) FROM mari_invest_progress A LEFT JOIN mari_invest B ON A.loan_id = B.loan_id WHERE A.i_look = 'F' ";
		$Payments=sql_query($sql,false);
		$acc_Payments=mysql_result($Payments,0,0);


		/*입찰합계구하기*/
		$sql="select sum(i_pay) from mari_invest"; 
		$top=sql_query($sql, false);
		$t_pay = mysql_result($top, 0, 0);



/*2018-01-03 평균 수익률 이경희*/
		$sql  = "SELECT i_id, i_loan_pay, i_year_plus, i_subject, i_loanexecutiondate, i_look 
				FROM mari_loan 
				WHERE i_loan_pay != '0' AND i_year_plus != '0'
				  AND (i_look = 'C' OR i_look = 'D' OR i_look = 'F') ";
		$totalAverage = sql_query($sql, false);

		$sql = "SELECT COUNT(*) AS cnt FROM mari_loan WHERE i_loan_pay!='0' AND i_year_plus!=0 AND (i_look='C' OR i_look='D' OR i_look='F') ";
		$y_count = sql_fetch($sql);
		$total_y_count = $y_count['cnt'];
		
//		if($totalAverage['i_look']=="C" || $totalAverage['i_look']=="D" || $totalAverage['i_look']=="F"){
			for($a=0; $average_t = sql_fetch_array($totalAverage); $a++){
				if($average_t['i_loanexecutiondate']=="0000-00-00 00:00:00"){
				}else{
					$y_average += $average_t['i_year_plus'];
					
					$Result_average = $y_average / $total_y_count;
				}
			}
//		}

/*2018-01-03 평균 수익률 이경희*/

	break;

/************************************************
회원가입 STEP
************************************************/
case "join1":
    session_start(); 
		if ($member_ck) alert('이미 로그인 중입니다.'); 
//		if(!extension_loaded('IPINClient')) { 
//			dl('IPINClient.' . PHP_SHLIB_SUFFIX); 
//		} 
//		$module = 'IPINClient'; 
//		$sSiteCode = "BF960"; 
//		$sSitePw = "FVaPgJqa5nCY"; 
//		$sReturnURL = "".MARI_HOME_URL."/?mode=join-ipin-return&retInfo=Y&agreement1=".$agreement1."&agreement2=".$agreement2.""; 
//		$sCPRequest = "".MARI_HOME_URL."/?mode=join-ipin-return"; 
//		if (extension_loaded($module)) { 
//			$sCPRequest = get_request_no($sSiteCode); 
//		} else { 
//			$sCPRequest = "Module get_request_no is not compiled into PHP"; 
//		} 
//		$_SESSION['CPREQUEST'] = $sCPRequest; 
//		$sEncData = ""; 
//		$sRtnMsg = ""; 
//		if (extension_loaded($module)) { 
//			$sEncData = get_request_data($sSiteCode, $sSitePw, $sCPRequest, $sReturnURL); 
//		} else { 
//			$sEncData = "Module get_request_data is not compiled into PHP"; 
//		} 
//		if ($sEncData == -9) { 
//			$sRtnMsg = "입력값 오류 : 암호화 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다."; 
//		} else { 
//			$sRtnMsg = "$sEncData 변수에 암호화 데이타가 확인되면 정상, 정상이 아닌 경우 리턴코드 확인 후 NICE평가정보 개발 담당자에게 문의해 주세요."; 
//		} 
		if(!extension_loaded('CPClient')) { 
			dl('CPClient.' . PHP_SHLIB_SUFFIX); 
		} 
		$module = 'CPClient'; 
		$sitecode = "BE429"; 
		$sitepasswd = "52OzHsPatLhc"; 
		$authtype = ""; 
		$popgubun = "N"; 
		$customize = ""; 
		$reqseq = "REQ_0123456789"; 
		if (extension_loaded($module)) { 
			//$reqseq = get_cprequest_no($sitecode); 
		} else {
			$reqseq = "Module get_request_no is not compiled into PHP"; 
		} 
		$returnurl = "".MARI_HOME_URL."/?mode=join-self-return&retInfo=Y&agreement1=".$agreement1."&agreement2=".$agreement2.""; 
		$errorurl = "".MARI_HOME_URL."/?mode=join-self-return"; 
		$_SESSION["REQ_SEQ"] = $reqseq; 
		$plaindata = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "8:SITECODE" . strlen($sitecode) . ":" . $sitecode . "9:AUTH_TYPE" . strlen($authtype) . ":". $authtype . "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl . "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl . "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun . "9:CUSTOMIZE" . strlen($customize) . ":" . $customize ; 
		//$enc_data = get_encode_data($sitecode, $sitepasswd, $plaindata); 
		if( $enc_data == -1 ) { 
			$returnMsg = "암/복호화 시스템 오류입니다."; 
			$enc_data = ""; 
		} else if( $enc_data== -2 ) { 
			$returnMsg = "암호화 처리 오류입니다."; 
			$enc_data = ""; 
		} else if( $enc_data== -3 ) { 
			$returnMsg = "암호화 데이터 오류 입니다."; 
			$enc_data = ""; 
		} else if( $enc_data== -9 ) { 
			$returnMsg = "입력값 오류 입니다."; 
			$enc_data = ""; 
		}

break;

/************************************************
회원가입 STEP II
************************************************/
	case "join2":
	session_start();


		if ($member_ck)
			alert('이미 로그인 중입니다.');

		//if($_POST[agreement1] == 'yes'){}else{ alert('이용약관에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
		//if($_POST[agreement2] =='yes'){ }else{alert('개인정보 수집 및 이용에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
		//아이핀용
		/*$RandNo = rand(1000000000, 9999999999);*/
		//본인확인용(휴대폰)
		/*$RandNo2 = rand(100000, 999999);*/


	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		
		[ PHP 확장모듈 설치 안내 ]
		1.	Php.ini 파일의 설정 내용 중 확장모듈 경로(extension_dir)로 지정된 위치에 첨부된 IPINClient.so 파일을 복사합니다.
		2.	Php.ini 파일에 다음과 같은 설정을 추가 합니다.
				extension=IPINClient.so
		3.	아파치 재 시작 합니다.
		
	*********************************************************************************************************************************************/
	/*****************************

	*****************************/
	//아파치에서 모듈 로드가 되지 않았을경우 동적으로 모듈을 로드합니다.

//	if(!extension_loaded('IPINClient')) {
//	dl('IPINClient.' . PHP_SHLIB_SUFFIX);
//	}
	//$module = 'IPINClient';

	//$sSiteCode					= "AK24";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	//$sSitePw					= "Sodi1234";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
	$sSiteCode					= "BY60";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	$sSitePw					= "Kingk19!";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
	
	$sReturnURL					= "".MARI_HOME_URL."/?mode=join-ipin-return&retInfo=Y&agreement1=".$agreement1."&agreement2=".$agreement2."";			// 하단내용 참조
	$sCPRequest					= "".MARI_HOME_URL."/?mode=join-ipin-return";			// 하단내용 참조
	
//	if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
//		$sCPRequest = get_request_no($sSiteCode);
//	} else {
//		$sCPRequest = "Module get_request_no is not compiled into PHP";
//	}
	
	// 현재 예제로 저장한 세션은 ipin_result.php 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	$_SESSION['CPREQUEST'] = $sCPRequest;
    
    $sEncData					= "";			// 암호화 된 데이타
	$sRtnMsg					= "";			// 처리결과 메세지
	
    // 리턴 결과값에 따라, 프로세스 진행여부를 파악합니다.

  
//		if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
//			$sEncData = get_request_data($sSiteCode, $sSitePw, $sCPRequest, $sReturnURL);
//		} else {
//			$sEncData = "Module get_request_data is not compiled into PHP";
//		}
    
    // 리턴 결과값에 따른 처리사항
    if ($sEncData == -9)
    {
    	$sRtnMsg = "입력값 오류 : 암호화 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
    } else {
    	$sRtnMsg = "$sEncData 변수에 암호화 데이타가 확인되면 정상, 정상이 아닌 경우 리턴코드 확인 후 NICE평가정보 개발 담당자에게 문의해 주세요.";
    }

	/*
	
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다. (최대 30byte 까지만 가능)
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└─────────


    /**************************************************************************************************************
    NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
    
    서비스명 :  체크플러스 - 안심본인인증 서비스
    페이지명 :  체크플러스 - 메인 호출 페이지
    보안을 위해 제공해드리는 샘플페이지는 서비스 적용 후 서버에서 삭제해 주시기 바랍니다. 
    
    [ PHP 확장모듈 설치 안내 ]
		1.	Php.ini 파일의 설정 내용 중 확장모듈 경로(extension_dir)로 지정된 위치에 첨부된 CPClient.so 파일을 복사합니다.
		2.	Php.ini 파일에 다음과 같은 설정을 추가 합니다.
				extension=CPClient.so
		3.	아파치 재 시작 합니다.
    **************************************************************************************************************/
    

	  //아파치에서 모듈 로드가 되지 않았을경우 동적으로 모듈을 로드합니다.

    //$sitecode = "AD150";				// NICE로부터 부여받은 사이트 코드
    //$sitepasswd = "1oTqvwP9oZZs";			// NICE로부터 부여받은 사이트 패스워드
    $sitecode = "BC600";				// NICE로부터 부여받은 사이트 코드
    $sitepasswd = "RmtejQLO7WNH";			// NICE로부터 부여받은 사이트 패스워드
    
    $authtype = "";      	// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 카드
    	
		$popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		$customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
		 
    $reqseq = "REQ_0123456789";     // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
    
    // 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
//		if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
//			$reqseq = get_cprequest_no($sitecode);
//		} else {
//			$reqseq = "Module get_request_no is not compiled into PHP";
//		}
    
    
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    $returnurl = "".MARI_HOME_URL."/?mode=join-self-return&retInfo=Y&agreement1=".$agreement1."&agreement2=".$agreement2."";	// 성공시 이동될 URL
    $errorurl = "".MARI_HOME_URL."/?mode=join-self-return";		// 실패시 이동될 URL
	
    // reqseq값은 성공페이지로 갈 경우 검증을 위하여 세션에 담아둔다.
    
    $_SESSION["REQ_SEQ"] = $reqseq;

    // 입력될 plain 데이타를 만든다.
    $plaindata =  "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq .
			    			  "8:SITECODE" . strlen($sitecode) . ":" . $sitecode .
			    			  "9:AUTH_TYPE" . strlen($authtype) . ":". $authtype .
			    			  "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl .
			    			  "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl .
			    			  "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun .
			    			  "9:CUSTOMIZE" . strlen($customize) . ":" . $customize ;
    
    
		//if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
			//$enc_data = get_encode_data($sitecode, $sitepasswd, $plaindata);
		//} else {
		//	$enc_data = "Module get_request_data is not compiled into PHP";
		//}

    if( $enc_data == -1 )
    {
        $returnMsg = "암/복호화 시스템 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -2 )
    {
        $returnMsg = "암호화 처리 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -3 )
    {
        $returnMsg = "암호화 데이터 오류 입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -9 )
    {
        $returnMsg = "입력값 오류 입니다.";
        $enc_data = "";
    }





	break;










/************************************************
회원가입 STEP II
************************************************/
	case "join_auth":
	session_start();


		if ($member_ck)
			alert('이미 로그인 중입니다.');

		//if($_POST[agreement1] == 'yes'){}else{ alert('이용약관에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
		//if($_POST[agreement2] =='yes'){ }else{alert('개인정보 수집 및 이용에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
		//아이핀용
		/*$RandNo = rand(1000000000, 9999999999);*/
		//본인확인용(휴대폰)
		/*$RandNo2 = rand(100000, 999999);*/


	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		
		[ PHP 확장모듈 설치 안내 ]
		1.	Php.ini 파일의 설정 내용 중 확장모듈 경로(extension_dir)로 지정된 위치에 첨부된 IPINClient.so 파일을 복사합니다.
		2.	Php.ini 파일에 다음과 같은 설정을 추가 합니다.
				extension=IPINClient.so
		3.	아파치 재 시작 합니다.
		
	*********************************************************************************************************************************************/
	/*****************************

	*****************************/
    

	  //아파치에서 모듈 로드가 되지 않았을경우 동적으로 모듈을 로드합니다.
	
		/*
		if(!extension_loaded('CPClient')) {
			dl('CPClient.' . PHP_SHLIB_SUFFIX);
		}
		$module = 'CPClient';
		*/

    $sitecode = "BC600";				// NICE로부터 부여받은 사이트 코드
    $sitepasswd = "RmtejQLO7WNH";			// NICE로부터 부여받은 사이트 패스워드
    
    
    $authtype = "";      	// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 카드
    	
		$popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		$customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
		 
    $reqseq = "REQ_0123456789";     // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
    
    // 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
			$reqseq = get_cprequest_no($sitecode);
		} else {
			$reqseq = "Module get_request_no is not compiled into PHP";
		}
    
    
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    $returnurl = "".MARI_HOME_URL."/?mode=join-self-return&retInfo=Y&agreement1=".$agreement1."&agreement2=".$agreement2."";	// 성공시 이동될 URL
    $errorurl = "".MARI_HOME_URL."/?mode=join-self-return";		// 실패시 이동될 URL
	
    // reqseq값은 성공페이지로 갈 경우 검증을 위하여 세션에 담아둔다.
    
    $_SESSION["REQ_SEQ"] = $reqseq;

    // 입력될 plain 데이타를 만든다.
    $plaindata =  "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq .
			    			  "8:SITECODE" . strlen($sitecode) . ":" . $sitecode .
			    			  "9:AUTH_TYPE" . strlen($authtype) . ":". $authtype .
			    			  "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl .
			    			  "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl .
			    			  "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun .
			    			  "9:CUSTOMIZE" . strlen($customize) . ":" . $customize ;
    
    
		//if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
			$enc_data = get_encode_data($sitecode, $sitepasswd, $plaindata);
		//} else {
		//	$enc_data = "Module get_request_data is not compiled into PHP";
		//}

    if( $enc_data == -1 )
    {
        $returnMsg = "암/복호화 시스템 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -2 )
    {
        $returnMsg = "암호화 처리 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -3 )
    {
        $returnMsg = "암호화 데이터 오류 입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -9 )
    {
        $returnMsg = "입력값 오류 입니다.";
        $enc_data = "";
    }



	break;






/************************************************
회원가입 STEP III
************************************************/
//	case "join3":
//
//		session_start();
//		/*
//		ini_set("session.cache_expire", 3600);
//		ini_set("session.gc_maxlifetime", 3600);  // 세션 만료시간을 한시간으로 설정
//		*/
//		/* 인증 후 세션값 */
//		/*
//		$agr1 = $_SESSION['INHA_ENTER_AUTH_AGR1'];
//		$agr2 = $_SESSION['INHA_ENTER_AUTH_AGR2'];
//		$auth_type	= $_SESSION['INHA_ENTER_AUTH_TYPE'];
//		$auth_name	= $_SESSION['INHA_ENTER_AUTH_NAME'];
//		$auth_sex	= $_SESSION['INHA_ENTER_AUTH_SEX'];
//		$auth_fgn	= $_SESSION['INHA_ENTER_AUTH_FGN'];
//		$auth_brth	= $_SESSION['INHA_ENTER_AUTH_BRTH'];
//		*/
//		/*
//		if(!$auth_type)
//		{
//
//		alert('접근오류입니다.(오류:001)\n처음부터 다시 시작해주세요.'); location('?mode=join1'); exit;
//		}
//*/
//	 $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
//	/*모바일 모드일 경우*/
//	if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){
//		
//	}else{
//		//if($agreement1 == 'yes'){}else{ alert('이용약관에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
//		//if($agreement2 =='yes'){ }else{alert('개인정보 수집 및 이용에 동의하셔야 합니다.'); location('?mode=join1'); exit; }
//	}
//
//    //**************************************************************************************************************
//    //NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
//    
//    //서비스명 :  체크플러스 - 안심본인인증 서비스
//    //페이지명 :  체크플러스 - 결과 페이지
//    
//    //보안을 위해 제공해드리는 샘플페이지는 서비스 적용 후 서버에서 삭제해 주시기 바랍니다. 
//    //**************************************************************************************************************
//    
//		/*
//		if(!extension_loaded('CPClient')) {
//			dl('CPClient.' . PHP_SHLIB_SUFFIX);
//		}
//		$module = 'CPClient';
//		*/
//	
//    $sitecode = "AD150";					// NICE로부터 부여받은 사이트 코드
//    $sitepasswd = "1oTqvwP9oZZs";				// NICE로부터 부여받은 사이트 패스워드
//    
//    
//    $enc_data = $_POST["EncodeData"];		// 암호화된 결과 데이타
//    $sReserved1 = $_POST['param_r1'];		
//		$sReserved2 = $_POST['param_r2'];
//		$sReserved3 = $_POST['param_r3'];
//
//		//////////////////////////////////////////////// 문자열 점검///////////////////////////////////////////////
//    if(preg_match('~[^0-9a-zA-Z+/=]~', $enc_data, $match)) {echo "입력 값 확인이 필요합니다 : ".$match[0]; exit;} // 문자열 점검 추가. 
//    if(base64_encode(base64_decode($enc_data))!=$enc_data) {echo "입력 값 확인이 필요합니다"; exit;}
//    
//    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved1, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
//    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved2, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
//    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved3, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
//		///////////////////////////////////////////////////////////////////////////////////////////////////////////
//		
//    if ($enc_data != "") {
//
//				if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
//					$plaindata = get_decode_data($sitecode, $sitepasswd, $enc_data);// 암호화된 결과 데이터의 복호화
//				} else {
//					$plaindata = "Module get_response_data is not compiled into PHP";
//				}
//        
//        //echo "[plaindata]  " . $plaindata . "<br>";
//
//        if ($plaindata == -1){
//            $returnMsg  = "암/복호화 시스템 오류";
//        }else if ($plaindata == -4){
//            $returnMsg  = "복호화 처리 오류";
//        }else if ($plaindata == -5){
//            $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
//        }else if ($plaindata == -6){
//            $returnMsg  = "복호화 데이터 오류";
//        }else if ($plaindata == -9){
//            $returnMsg  = "입력값 오류";
//        }else if ($plaindata == -12){
//            $returnMsg  = "사이트 비밀번호 오류";
//        }else{
//            // 복호화가 정상적일 경우 데이터를 파싱합니다.
//              
//            $requestnumber = GetValue($plaindata , "REQ_SEQ");
//            $responsenumber = GetValue($plaindata , "RES_SEQ");
//            $authtype = GetValue($plaindata , "AUTH_TYPE");
//            $name = GetValue($plaindata , "NAME");
//            $birthdate = GetValue($plaindata , "BIRTHDATE");
//            $gender = GetValue($plaindata , "GENDER");
//            $nationalinfo = GetValue($plaindata , "NATIONALINFO");	//내/외국인정보(사용자 매뉴얼 참조)
//            $dupinfo = GetValue($plaindata , "DI");
//            $conninfo = GetValue($plaindata , "CI");
//
//            if(strcmp($_SESSION["REQ_SEQ"], $requestnumber) != 0)
//            {
//            	echo "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.<br>";
//                $requestnumber = "";
//                $responsenumber = "";
//                $authtype = "";
//                $name = "";
//            		$birthdate = "";
//            		$gender = "";
//            		$nationalinfo = "";
//            		$dupinfo = "";
//            		$conninfo = "";
//            }
//        }
//    }
//
//	/********************************************************************************************************************************************
//		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
//		
//		서비스명 : 가상주민번호서비스 (IPIN) 서비스
//		페이지명 : 가상주민번호서비스 (IPIN) 사용자 인증 정보 결과 페이지
//		
//				   수신받은 데이터(인증결과)를 복호화하여 사용자 정보를 확인합니다.
//				   
//			   
//	*********************************************************************************************************************************************/
//	/*****************************
//
//	*****************************/
//	
////아파치에서 모듈 로드가 되지 않았을경우 동적으로 모듈을 로드합니다.
//
//	if(!extension_loaded('IPINClient')) {
//		dl('IPINClient.' . PHP_SHLIB_SUFFIX);
//	}
//
//	$module = 'IPINClient';
//
//	$sSiteCode					= "AK24";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
//	$sSitePw					= "Sodi1234";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
//	
//	$sEncData					= "";			// 암호화 된 사용자 인증 정보
//	$sDecData					= "";			// 복호화 된 사용자 인증 정보
//	
//	$sRtnMsg					= "";			// 처리결과 메세지
//		
//  $sEncData = $_POST['enc_data'];	// ipin_process.php 에서 리턴받은 암호화 된 사용자 인증 정보
//  
///*
//		//////////////////////////////////////////////// 문자열 점검///////////////////////////////////////////////
//    if(preg_match('~[^0-9a-zA-Z+/=]~', $sEncData, $match)) {echo "입력 값 확인이 필요합니다"; exit;}
//    if(base64_encode(base64_decode($sEncData))!=$sEncData) {echo "입력 값 확인이 필요합니다!"; exit;}
//    ///////////////////////////////////////////////////////////////////////////////////////////////////////////  
//	
//	// ipin_main.php 에서 저장한 세션 정보를 추출합니다.
//	// 데이타 위변조 방지를 위해 확인하기 위함이므로, 필수사항은 아니며 보안을 위한 권고사항입니다.
//	$sCPRequest = $_SESSION['CPREQUEST'];
//    
//    if ($sEncData != "") {
//    */
//    	// 사용자 정보를 복호화 합니다.
//    	/*
//			if (extension_loaded($module)) {  // 동적으로 모듈 로드 했을경우 
//				$sDecData = get_response_data($sSiteCode, $sSitePw, $sEncData);
//			} else {
//				$sDecData = "Module get_response_data is not compiled into PHP";
//			}
//			
//    	if ($sDecData == -9) {
//    		$sRtnMsg = "입력값 오류 : 복호화 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
//    	} else if ($sDecData == -12) {
//    		$sRtnMsg = "NICE평가정보에서 발급한 개발정보가 정확한지 확인해 보세요.";
//    	} else {
//    	*/
//    		// 복호화된 데이타 구분자는 ^ 이며, 구분자로 데이타를 파싱합니다.
//    		/*
//    			- 복호화된 데이타 구성
//    			가상주민번호확인처리결과코드^가상주민번호^성명^중복확인값(DupInfo)^연령정보^성별정보^생년월일(YYYYMMDD)^내외국인정보^고객사 요청 Sequence
//    		*/
//			/*
//    		$arrData = split("\^", $sDecData);
//    		$iCount = count($arrData);
//    		
//    		if ($iCount >= 5) {
//				*/
//    		
//    			/*
//					다음과 같이 사용자 정보를 추출할 수 있습니다.
//					사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.
//				
//					사용자 정보를 다른 페이지에서 이용하실 경우에는
//					보안을 위하여 암호화 데이타($sEncData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)
//					
//					만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
//					form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
//				*/
//				/*
//				$strResultCode	= $arrData[0];			// 결과코드
//				if ($strResultCode == 1) {
//					$strCPRequest	= $arrData[8];			// CP 요청번호
//					
//					if ($sCPRequest == $strCPRequest) {
//				
//						$sRtnMsg = "사용자 인증 성공";
//						
//						$strVno      		= $arrData[1];	// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
//						$strUserName		= $arrData[2];	// 이름
//						$strDupInfo			= $arrData[3];	// 중복가입 확인값 (64Byte 고유값)
//						$strAgeInfo			= $arrData[4];	// 연령대 코드 (개발 가이드 참조)
//					    $strGender			= $arrData[5];	// 성별 코드 (개발 가이드 참조)
//					    $strBirthDate		= $arrData[6];	// 생년월일 (YYYYMMDD)
//					    $strNationalInfo	= $arrData[7];	// 내/외국인 정보 (개발 가이드 참조)
//					
//					} else {
//						$sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 $sCPRequest 데이타를 확인해 주시기 바랍니다.";
//					}
//				} else {
//					$sRtnMsg = "리턴값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요. [$strResultCode]";
//				}
//    		
//    		} else {
//    			$sRtnMsg = "리턴값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
//    		}
//    	
//    	}
//    } else {
//    	$sRtnMsg = "처리할 암호화 데이타가 없습니다.";
//    }
//
//*/
//
//		/*인증결과*/
//		$m_blindness_use=$m_blindness;
//		$m_ipin_use=$m_ipin_use;
//		
//		setcookie('m_name',$m_name,time()+1,'/');
//		setcookie('m_id',$m_id,time()+1,'/');
//		setcookie('m_nick',$m_nick,time()+1,'/');
//		setcookie('m_companynum',$m_companynum,time()+1,'/');
//		setcookie('birth1',$birth1,time()+1,'/');
//		setcookie('birth2',$birth2,time()+1,'/');
//		setcookie('birth3',$birth3,time()+1,'/');
//		setcookie('m_sex',$m_sex,time()+1,'/');
//		setcookie('hp1',$hp1,time()+1,'/');
//		setcookie('hp2',$hp2,time()+1,'/');
//		setcookie('hp3',$hp3,time()+1,'/');
//		setcookie('m_sms',$m_sms,time()+1,'/');
//		setcookie('tel1',$tel1,time()+1,'/');
//		setcookie('tel2',$tel2,time()+1,'/');
//		setcookie('tel3',$tel3,time()+1,'/');
//		setcookie('m_zip',$m_zip,time()+1,'/');
//		setcookie('m_addr1',$m_addr1,time()+1,'/');
//		setcookie('m_addr2',$m_addr2,time()+1,'/');
//		setcookie('m_homepage',$m_homepage,time()+1,'/');
//		setcookie('m_signpurpose',$m_signpurpose,time()+1,'/');
//		setcookie('m_joinpath',$m_joinpath,time()+1,'/');
//		setcookie('m_referee',$m_referee,time()+1,'/');
//		setcookie('m_newsagency',$m_newsagency,time()+1,'/');


	break;

 /************************************************
회원가입(법인)
************************************************/
	case "join3_enterprise":
		
		setcookie('m_name',$m_name,time()+1,'/');
		setcookie('m_id',$m_id,time()+1,'/');
		setcookie('m_nick',$m_nick,time()+1,'/');
		setcookie('m_companynum',$m_companynum,time()+1,'/');
		setcookie('birth1',$birth1,time()+1,'/');
		setcookie('birth2',$birth2,time()+1,'/');
		setcookie('birth3',$birth3,time()+1,'/');
		setcookie('m_sex',$m_sex,time()+1,'/');
		setcookie('hp1',$hp1,time()+1,'/');
		setcookie('hp2',$hp2,time()+1,'/');
		setcookie('hp3',$hp3,time()+1,'/');
		setcookie('m_sms',$m_sms,time()+1,'/');
		setcookie('tel1',$tel1,time()+1,'/');
		setcookie('tel2',$tel2,time()+1,'/');
		setcookie('tel3',$tel3,time()+1,'/');
		setcookie('m_zip',$m_zip,time()+1,'/');
		setcookie('m_addr1',$m_addr1,time()+1,'/');
		setcookie('m_addr2',$m_addr2,time()+1,'/');
		setcookie('m_homepage',$m_homepage,time()+1,'/');
		setcookie('m_signpurpose',$m_signpurpose,time()+1,'/');
		setcookie('m_joinpath',$m_joinpath,time()+1,'/');
		setcookie('m_referee',$m_referee,time()+1,'/');
		setcookie('m_referee',$m_referee,time()+1,'/');
		setcookie('m_referee',$m_referee,time()+1,'/');
		setcookie('m_newsagency',$m_newsagency,time()+1,'/');
		setcookie('m_company_name',$m_company_name,time()+1,'/');

	break;

/************************************************
회원정보수정
************************************************/
	case "info_modify":

		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);

		/*휴대폰번호 분리*/
		$m_hp = $mmo['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);



		/*전화번호 분리*/
		$m_tel = $mmo['m_tel'];
		$tel1=substr($m_tel,0,3);
		$tel2=substr($m_tel,3,-4);
		$tel3=substr($m_tel,-4);


		/*우편번호 분리*/
		$m_zip = $mmo['m_zip'];
		$m_zip1=substr($m_zip,0,3);
		$m_zip2=substr($m_zip,3,3);


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						$requestPath = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);



				}
	break;





/************************************************
회원정보수정 new
************************************************/
	case "mypage_basic":
		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);

		/*휴대폰번호 분리*/
		$m_hp = $mmo['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);



		/*전화번호 분리*/
		$m_tel = $mmo['m_tel'];		
		if(substr($m_tel,0,2)=="02"){
			$tel1=substr($m_tel,0,2);
			$tel2=substr($m_tel,2,4);
			$tel3=substr($m_tel,-4);
		}else{
			$tel1=substr($m_tel,0,3);
			$tel2=substr($m_tel,3,-4);
			$tel3=substr($m_tel,-4);
		}


		/*우편번호 분리*/
		$m_zip = $mmo['m_zip'];
		$m_zip1=substr($m_zip,0,3);
		$m_zip2=substr($m_zip,3,3);


		/*생년월일*/
		$m_birth = explode("-",$mmo[m_birth]);
		$m_birth1 = $m_birth[0]; //생년
		$m_birth2 = $m_birth[1]; //월
		$m_birth3 = $m_birth[2]; //일

		/*투자자구분*/
		if($user['m_level']=="2"){
			if($user['m_signpurpose'] =="N"){
				$invest_flag = '일반 개인투자자';
			}else if($user['m_signpurpose'] =="L"){
				$invest_flag = '대출회원';
			}else if($user['m_signpurpose'] == "P"){
				$invest_flag = '전문 투자자';
			}else if($user['m_signpurpose'] == "I"){
				$invest_flag = '소득적격 개인투자자';
			}
		}else{
				$invest_flag = '법인투자자';
		}
				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*일반 계좌*/
						$requestPath = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);

						/*증권 계좌*/
						$requestPath_secu = "https://v5.paygate.net/v5/code/listOf/securities/ko?_method=GET";

						$curl_handlebank_secu = curl_init();

						curl_setopt($curl_handlebank_secu, CURLOPT_URL, $requestPath_secu);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_secu, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_secu, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_secu, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_secu, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/securities/ko');
						$result_secu = curl_exec($curl_handlebank_secu);
						curl_close($curl_handlebank_secu);

						/*파싱*/

						$decode_secu = json_decode($result_secu, true);



				}
	break;

/************************************************
정보수정
************************************************/
	case "mypage_confirm_center":
		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');

						/*일반 계좌*/
						$requestPath = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);

						/*증권 계좌*/
						$requestPath_secu = "https://v5.paygate.net/v5/code/listOf/securities/ko?_method=GET";

						$curl_handlebank_secu = curl_init();

						curl_setopt($curl_handlebank_secu, CURLOPT_URL, $requestPath_secu);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_secu, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_secu, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_secu, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_secu, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/securities/ko');
						$result_secu = curl_exec($curl_handlebank_secu);
						curl_close($curl_handlebank_secu);

						/*파싱*/

						$decode_secu = json_decode($result_secu, true);


						/*계좌검증시 시간체크해서 검증후 4분전까지 재검증진행하지 않도록 처리 2016-12-05 임근호 start*/

						$sql = "select * from mari_seyfert_order where m_id='$user[m_id]' and s_type='3' order by s_date desc";
						$vtimecheckview = sql_fetch($sql, false);

						/*+4분후시간*/
						$now_time_and = date("Y-m-d H:i:s", strtotime("".$vtimecheckview['s_date']."")+240);

						/*계좌검증시 시간체크해서 검증후 4분전까지 재검증진행하지 않도록 처리 2016-12-05 임근호 end*/
				}
	break;

/************************************************
예치금관리
************************************************/
	case "mypage_balance":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
		$seyck = sql_fetch($sql, false);


		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);


			/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						$requestPath = "https://v5.paygate.net/v5/code/listOf/availableVABanks/p2p/charge/ko?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/availableVABanks/p2p/charge/ko');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);



				}
				

				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq."&refId=".$g_code."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);


/*
						print_r($requestPath_lnq);
						echo"<br/><br/>";
						print_r($result_lnq);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_lnq);


						echo"<br/><br/>데이터";
						print_r($decode_lnq);
						echo"<br/><br/>";
*/

				}
	break;



/************************************************
faq
************************************************/
	case "faq":

		$sql = " select  * from  mari_faq";
		$faq = sql_query($sql, false);
	break;



/************************************************
비밀번호변경
************************************************/
	case "change_pw":

		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);
	break;




/************************************************
비밀번호변경 new
************************************************/
	case "mypage_pwchange":

		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);
	break;



/************************************************
회원탈퇴
************************************************/
	case "leave":

		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);
	break;


	case "main":
		$sql = " select  * from  mari_goods  where g_info='yes' order by g_datetime ASC";
		$product = sql_query($sql, false);
	break;







/************************************************
회원탈퇴 new
************************************************/
	case "mypage_out":
		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$mmo = sql_fetch($sql, false);
	break;


	case "main":
		$sql = " select  * from  mari_goods  where g_info='yes' order by g_datetime ASC";
		$product = sql_query($sql, false);
	break;


/************************************************
이용안내
************************************************/

	case "guide":

		
		if($sort=="invest" || !$sort){
			$sql = "select * from mari_faq where f_sort = '1'";
			$ff = sql_query($sql,false);
		}else if($sort == "loan"){
			$sql = "select * from mari_faq where f_sort = '2'";
			$ff = sql_query($sql,false);
		}else if($sort == "base"){
			$sql = "select * from mari_faq where f_sort = '3'";
			$ff = sql_query($sql,false);
		}

	break;






















/************************************************
아이핀 join-ipin-pcc
************************************************/

	case "join-ipin-pcc":
		session_start();

		mb_http_output ('UTF-8');
		$reqNum		= $_POST["reqnum"];
		$id			= "아이디";
		$srvNo		= "서비스번호";
		//01. reqNum 쿠키 생성
		setcookie("REQNUM", $reqNum, time()+600);
		$exVar = "0000000000000000";        // 확장임시 필드입니다. 수정하지 마세요..
		//02. 암호화 파라미터 생성
		$enc_reqInfo = $reqNum . "/" . $id . "/" . $srvNo . "/" . $exVar;
		//03. 본인확인 요청정보 1차암호화
		$enc_reqInfo = exec("/usr/local/ipin/SciSecuX SEED 1 1 $enc_reqInfo ");
		//04. 요청정보 위변조검증값 생성
		$hash_reqInfo = exec("/usr/local/ipin/SciSecuX HMAC 1 1 $enc_reqInfo ");    // 요청정보 위변조검증값 생성
		//05. 요청정보 2차암호화
		//데이터 생성 규칙 : "요청정보 1차 암호화/위변조검증값/암복화 확장 변수"
		$enc_reqInfo = $enc_reqInfo. "/" .$hash_reqInfo. "/" ."00000000";
		$enc_reqInfo = exec("/usr/local/ipin/SciSecuX SEED 1 1 $enc_reqInfo ");
		$returnval = "{'enc_reqInfo':'".$enc_reqInfo."','msg':'2'}";
		header("Content-Type: text/html; charset=euc-kr");
		echo $returnval; 
	break;

/************************************************
아이핀 join-ipin-return
************************************************/

	case "join-ipin-return":


	//보안을 위해 제공해드리는 샘플페이지는 서비스 적용 후 서버에서 삭제해 주시기 바랍니다. 

		/********************************************************************************************************************************************
			NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
			
			서비스명 : 가상주민번호서비스 (IPIN) 서비스
			페이지명 : 가상주민번호서비스 (IPIN) 사용자 인증 정보 처리 페이지
			
					   수신받은 데이터(인증결과)를 메인화면으로 되돌려주고, close를 하는 역활을 합니다.
		*********************************************************************************************************************************************/
		
		// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다. (ipin_main.php 페이지에서 암호화된 데이타와는 다릅니다.)
		$sResponseData = $_POST['enc_data'];
		
		// ipin_main.php 페이지에서 설정한 데이타가 있다면, 아래와 같이 확인가능합니다.
		$sReservedParam1  = $_POST['param_r1'];
		$sReservedParam2  = $_POST['param_r2'];
		$sReservedParam3  = $_POST['param_r3'];
		
			//////////////////////////////////////////////// 문자열 점검///////////////////////////////////////////////
		if(preg_match('~[^0-9a-zA-Z+/=]~', $sResponseData, $match)) {echo "입력 값 확인이 필요합니다"; exit;}
		if(base64_encode(base64_decode($sResponseData))!=$sResponseData) {echo "입력 값 확인이 필요합니다!"; exit;}
		
		if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReservedParam1, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
		if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReservedParam2, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
		if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReservedParam3, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 암호화된 사용자 정보가 존재하는 경우
		if ($sResponseData != "") {


		$enc_retInfo =  $_GET["retInfo"];
		$agreement1 =  $_GET["agreement1"];
		$agreement2 =  $_GET["agreement2"];

		if($enc_retInfo=="Y"){
		echo"
		<script type=\"text/javascript\">
			opener.location.href = '?mode=join3&agreement1=".$agreement1."&agreement2=".$agreement2."&m_ipin=Y';
			window.close();
		</script>
		";
		}else{
			alert_close('인증실패 하였습니다. 다시한번 확인후 입력하여주십시오.');

		}

		} else {
			alert_close('인증실패 하였습니다. 다시한번 확인후 입력하여주십시오.');
		}
	break;



/************************************************
아이핀 join-ipin-values
************************************************/

	case "join-ipin-values":

		session_start();
		//01. 쿠키값 확인
		if (isset($_COOKIE["REQNUM"])) {
			$iv = $_COOKIE["REQNUM"];
			//쿠키 삭제
			setcookie("REQNUM", "", time()-600);
		} else {
			alert('세션이 만료되었습니다.!!','?mode=join1');
			exit;
		}
		// 파라메터로 받은 요청결과
		$enc_retInfo = $_GET["retInfo"];
		//02. 요청결과 복호화
		$dec_retInfo = exec("/usr/local/ipin/SciSecuX SEED 2 0 $iv $enc_retInfo ");

		//데이터 조합 : "본인확인1차암호화값/위변조검증값/암복화확장변수"
		$totInfo = split("/", $dec_retInfo);

		$encPara  = $totInfo[0];		//암호화된 통합 파라미터
		$encMsg   = $totInfo[1];		//암호화된 통합 파라미터의 Hash값

		//03. 위변조검증값 생성
		$hmac_str = exec("/usr/local/ipin/SciSecuX HMAC 1 0 $encPara");

		if($hmac_str != $encMsg){
				alert('비정상적인 접근입니다.!!','?mode=join1');
			exit;
		}
		//04. 본인확인1차암호화값 복호화
		$decPara  = exec("/usr/local/ipin/SciSecuX SEED 2 0 $iv $encPara ");

		//05. 파라미터 분리
		$split_dec_retInfo = split("/", $decPara);

		$reqNum    = $split_dec_retInfo[0];   //요청번호
		$vDiscrNo  = $split_dec_retInfo[1];   //아이핀번호
		$name      = $split_dec_retInfo[2];   //성명
		$result    = $split_dec_retInfo[3];   //인증결과
		$age	   = $split_dec_retInfo[4];   //연령대
		$sex       = $split_dec_retInfo[5];   //성별
		$ip        = $split_dec_retInfo[6];   //Client IP
		$authInfo  = $split_dec_retInfo[7];   //발급수단정보
		$birYMD    = $split_dec_retInfo[8];   //생년월일
		$fgn       = $split_dec_retInfo[9];   //내/외국인구분
		$discrHash = $split_dec_retInfo[10];  //중복가입확인정보

		$discrHash = exec("/usr/local/ipin/SciSecuX SEED 2 0 $iv $discrHash ");    //중복가입확인정보는 구분자인 "/"가 나올수 있으므로 한번더 복호화


		if($result  == '1') {//정상처리(아이핀 인증성공)
			$fgn		= ($fgn == '1')?'2':'1'; // 내국인: 1, 외국인: 2 (이 부분이 본인확인과 아이핀이 각각 달라 일치 시켜줌)

			$_SESSION['INHA_ENTER_AUTH_TYPE']	= 'ipin';
			$_SESSION['INHA_ENTER_AUTH_NAME']	= $name;				//이름
			$_SESSION['INHA_ENTER_AUTH_SEX']	= strtolower($sex);		//성별
			$_SESSION['INHA_ENTER_AUTH_FGN']	= $fgn;					//내/외국인
			$_SESSION['INHA_ENTER_AUTH_BRTH']	= $birYMD;				//생년월일(8자리)
			$_SESSION['INHA_ENTER_AUTH_IPIN']	= $vDiscrNo;			//아이핀등록번호(13)
			$_SESSION['INHA_ENTER_AUTH_AGR1']	= 'yes';
			$_SESSION['INHA_ENTER_AUTH_AGR2']	= 'yes';
				goto_url(MARI_HOME_URL.'/?mode=join3');
			} else {
				alert('아이핀 인증 실패!!','?mode=join1');
			exit;				
		}
	break;



/************************************************
실명인증 join-self-pcc
************************************************/

	case "join-self-pcc":
		session_start(); 

		mb_http_output ('UTF-8');
		$reqNum		= $_POST["reqnum"];
		$certDate	= $_POST["certdate"];
		$certGb		= "H";
		$id			= "아이디";
		$srvNo		= "서비스번호";
		$addVar		= "";
		//01. reqNum 쿠키 생성
		setcookie("REQNUM", $reqNum, time()+600);
		$exVar       = "0000000000000000";        // 확장임시 필드입니다. 수정하지 마세요..
		//02. 암호화 파라미터 생성
		$reqInfo = $id . "^" . $srvNo . "^" . $reqNum . "^" . $certDate . "^" . $certGb . "^" . $addVar . "^" . $exVar;
		//03. 본인확인 요청정보 1차암호화
		$iv = "";
		$enc_reqInfo = exec("/usr/local/pccV3/SciSecuX SEED 1 1 $reqInfo ");//암호화모듈 설치시 생성된 SciSecuX 파일이 있는 리눅스 경로를 설정해주세요.
		//04. 요청정보 위변조검증값 생성
		$hmac_str = exec("/usr/local/pccV3/SciSecuX HMAC 1 1 $enc_reqInfo ");
		//05. 요청정보 2차암호화
		//데이터 생성 규칙 : "요청정보 1차 암호화^위변조검증값^암복화 확장 변수"
		$enc_reqInfo = $enc_reqInfo. "^" .$hmac_str. "^" ."0000000000000000";
		$enc_reqInfo = exec("/usr/local/pccV3/SciSecuX SEED 1 1 $enc_reqInfo ");
		$returnval = "{'enc_reqInfo':'".$enc_reqInfo."','msg':'1'}";

		header("Content-Type: text/html; charset=euc-kr");
		echo $returnval; 
	break;


/************************************************
실명인증 join-self-return
************************************************/

	case "join-self-return":
		$enc_retInfo =  $_GET["retInfo"];
		$agreement1 =  $_GET["agreement1"];
		$agreement2 =  $_GET["agreement2"];

		if($enc_retInfo=="Y"){
		echo"
		<script type=\"text/javascript\">
			opener.location.href = '?mode=join3&agreement1=".$agreement1."&agreement2=".$agreement2."&m_blindness=Y';
			window.close();
		</script>
		";
		}else{
			alert_close('인증실패 하였습니다. 다시한번 확인후 입력하여주십시오.');
		}
	break;


/************************************************
실명인증 join-self-values
************************************************/

	case "join-self-values":

		session_start();
		//01. 쿠키값 확인
		$iv = "";
		if (isset($_COOKIE["REQNUM"])) {
			$iv = $_COOKIE["REQNUM"]; 
			//쿠키 삭제
			setcookie("REQNUM", "", time()-600);
		} else {
			alert('세션이 만료되었습니다.!!','?mode=join1');
			exit;
		}

		// 파라메터로 받은 요청결과
		$enc_retInfo = $_REQUEST["retInfo"];       

		//02. 요청결과 복호화	
		$dec_retInfo = exec("/usr/local/pccV3/SciSecuX SEED 2 0 $iv $enc_retInfo ");//암호화모듈 설치시 생성된 SciSecuX 파일이 있는 리눅스 경로를 설정해주세요.

		//데이터 조합 : "본인확인1차암호화값/위변조검증값/암복화확장변수"
		$totInfo = split("\\^", $dec_retInfo);

		$encPara  = $totInfo[0];		//본인확인1차암호화값
		$encMsg   = $totInfo[1];		//암호화된 통합 파라미터의 위변조검증값

		//03. 위변조검증값 생성
		$hmac_str = exec("/usr/local/pccV3/SciSecuX HMAC 1 0 $encPara ");

		if($hmac_str != $encMsg){
			alert('비정상적인 접근입니다.!!','?mode=join1');
			exit;
		}

		//04. 본인확인1차암호화값 복호화
		$decPara = exec("/usr/local/pccV3/SciSecuX SEED 2 0 $iv $encPara ");

		//05. 파라미터 분리
		$split_dec_retInfo = split("\\^", $decPara);

		$name		= $split_dec_retInfo[0];		//성명
		$birYMD		= $split_dec_retInfo[1];		//생년월일
		$sex		= $split_dec_retInfo[2];		//성별
		$fgnGbn		= $split_dec_retInfo[3];		//내외국인 구분값
		$di			= $split_dec_retInfo[4];		//DI
		$ci1		= $split_dec_retInfo[5];		//CI1
		$ci2		= $split_dec_retInfo[6];		//CI2	
		$civersion	= $split_dec_retInfo[7];		//CI Version
		$reqNum		= $split_dec_retInfo[8];		//요청번호
		$result		= $split_dec_retInfo[9];		//본인확인 결과 (Y/N)
		$certGb		= $split_dec_retInfo[10];		//인증수단
		$cellNo		= $split_dec_retInfo[11];		//핸드폰 번호
		$cellCorp	= $split_dec_retInfo[12];		//이동통신사
		$certDate	= $split_dec_retInfo[13];		//검증시간
		$addVar		= $split_dec_retInfo[14];		//추가 파라메터

		//예약 필드
		$ext1		= $split_dec_retInfo[15];
		$ext2		= $split_dec_retInfo[16];
		$ext3		= $split_dec_retInfo[17];
		$ext4		= $split_dec_retInfo[18];
		$ext5		= $split_dec_retInfo[19];


		if($result  == 'Y') {//정상처리(아이핀 인증성공)
			$_SESSION['INHA_ENTER_AUTH_TYPE']	= 'self';
			$_SESSION['INHA_ENTER_AUTH_NAME']	= $name;				//이름
			$_SESSION['INHA_ENTER_AUTH_SEX']	= strtolower($sex);		//성별
			$_SESSION['INHA_ENTER_AUTH_FGN']	= $fgnGbn;				//내/외국인
			$_SESSION['INHA_ENTER_AUTH_BRTH']	= $birYMD;				//생년월일(8자리)
			$_SESSION['INHA_ENTER_AUTH_IPIN']	= '';
			$_SESSION['INHA_ENTER_AUTH_AGR1']	= 'yes';
			$_SESSION['INHA_ENTER_AUTH_AGR2']	= 'yes';
			goto_url(MARI_HOME_URL.'/?mode=join3');
		} else {
			alert('본인확인(휴대폰 인증) 실패!!','?mode=join1');
			exit;				
		}
	break;


/************************************************
로그인 login
************************************************/
	case "pay24_login":

		$url = $_GET['url'];

		$p = parse_url($url);
		if ((isset($p['scheme']) && $p['scheme']) || (isset($p['host']) && $p['host'])) {
			//print_r2($p);
			if ($p['host'].(isset($p['port']) ? ':'.$p['port'] : '') != $_SERVER['HTTP_HOST'])
				alert('url에 타 도메인을 지정할 수 없습니다.');
		}

		// 이미 로그인 중이라면
		if ($member_ck) {
			if ($url)
				goto_url($url);
			else
				goto_url(MARI_HOME_URL.'/?mode=main');
		}

		$login_url        = login_url($url);
		$login_action_url = MARI_HOME_URL."/?mode=login_ck";
	break;



/************************************************
로그아웃
************************************************/
	case "logout":
		session_unset(); // 모든 세션변수를 언레지스터 시켜줌
		session_destroy(); // 세션해제함

		set_cookie('ck_m_id', '', 0);
		set_cookie('ck_auto', '', 0);

		if ($url) {
			$p = parse_url($url);
			if ($p['scheme'] || $p['host']) {
				alert('url에 도메인을 지정할 수 없습니다.');
			}

		} else {
			$link = MARI_HOME_URL.'/?mode=main';
		}

		goto_url($link);
	break;

/************************************************
로그인 login검사
************************************************/
	case "login_ck":
		$m_id       = trim($_POST['m_id']);
		$m_password = trim($_POST['m_password']);

		if (!$m_id || !$m_password)
			alert('비밀번호를 입력하여 주십시오.');

		$mem = get_member($m_id);

	/*슈퍼관리자는 그냥 로그인할 수 있도록 2017-03-27 임근호*/
	if($ip=="211.104.172.29" || $ip=="211.104.172.30" || $ip=="121.166.61.89" || $ip=="121.138.48.217" || $ip=="221.148.164.115" || $ip=="183.98.35.124" || $ip=="220.76.16.87" || $ip =="220.75.232.137"){
	}else{

		if (!$mem['m_id'] || (md5($m_password) != $mem['m_password']) || (hash('sha256',$m_password) != $mem['m_password'])) {
			/*기존비밀번호가 md5일경우*/
			if((md5($m_password) == $mem['m_password'])){
			/*기존비밀번호를 SHA256으로변경*/
			$m_password_SHA256=hash('sha256',$m_password);

				$sql = "update mari_member
							set m_password = '".$m_password_SHA256."'
							where m_id = '".$mem[m_id]."'";
				sql_query($sql);
			}else if((hash('sha256',$m_password) == $mem['m_password'])){
			}else{

			alert('존재하지 않거나 잘못된 계정 또는 \\n계정과 비밀번호가 일치하지 않습니다. ','?mode=login&m_id='.$m_id.'');
			}
		}
	}




		// 차단된 아이디인지 검사
		if ($mem['m_intercept_date']=="0000-00-00"){
		}else{
			$date = preg_replace("/([0-9]{4})([0-9]{2})([0-9]{2})/", "\\1년 \\2월 \\3일", $mem['m_intercept_date']);
			alert('회원님은 현재 차단상태 입니다.\n차단일 : '.$date);
		}

		set_session('ss_m_id', $mem['m_id']);
		set_session('ss_m_key', hash('sha256',$mem['m_datetime'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT']));


		/*170302 자동로그인 수정 동욱*/
		if($auto_login == "Y"){
			$key = hash('sha256',$_SERVER['SERVER_ADDR'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT'] . $m_password);
			setcookie('id_save',$m_id,time()+864000,'/');
			setcookie('pw_save',$m_password,time()+864000,'/');
			setcookie('auto_login',$auto_login,time()+864000,'/');
		}else{
			setcookie('id_save','',0,'/');
			setcookie('pw_save','',0,'/');
			setcookie('auto_login','',0,'/');
		}      




			foreach($_POST as $key=>$value) {
				if ($key != 'm_id' && $key != 'm_password' && $key != 'x' && $key != 'y' && $key != 'url') {
					$link .= "$split$key=$value";
					$split = "&amp;";
				}
			}
		/*회원의 레벨이 10레벨과 같거나 높을경우 어드민페이지로*/
		 if($admin=="Y" || $mem['m_level']>=10){
			goto_url(MARI_HOME_URL.'/?cms=admin');
		 }else{
			/*2017-05-29 가이드라인 때문에 발급여부확인*/
			$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y' and guide='N'";
			$seyfck = sql_fetch($sql, false);

			if($seyfck['s_bnkCd']=="SC_023"){
				goto_url(MARI_HOME_URL.'/?mode=mypage');
			}else{
				goto_url(MARI_HOME_URL.'/?up=guide_update');
			}
		 }


	break;



/************************************************
페이스북로그인 login검사
************************************************/
	case "callback":
				$m_id       = trim($_GET['m_id']);

				if (!$m_id)
					alert('키가 없습니다.');

				$mem = get_member($m_id);

				if (!$mem['m_id']) {
					alert('존재하지 않거나 잘못된 계정 또는 \\n계정과 비밀번호가 일치하지 않습니다. ');
				}

				// 차단된 아이디인지 검사
				if ($mem['m_intercept_date']=="0000-00-00"){
				}else{
					$date = preg_replace("/([0-9]{4})([0-9]{2})([0-9]{2})/", "\\1년 \\2월 \\3일", $mem['m_intercept_date']);
					alert('회원님은 현재 차단상태 입니다.\n차단일 : '.$date);
				}

				set_session('ss_m_id', $mem['m_id']);
				set_session('ss_m_key', hash('sha256',$mem['m_datetime'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT']));


				if ($auto_login) {


					$key = hash('sha256',$_SERVER['SERVER_ADDR'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT'] . $mem['m_password']);
					set_cookie('ck_m_id', $mem['m_id'], 86400 * 31);
					set_cookie('ck_auto', $key, 86400 * 31);

				} else {
					set_cookie('ck_m_id', $mem['m_id'], 86400 * 31);
					set_cookie('ck_auto', $key, 86400 * 31);
				}



					foreach($_POST as $key=>$value) {
						if ($key != 'm_id' && $key != 'x' && $key != 'y' && $key != 'url') {
							$link .= "$split$key=$value";
							$split = "&amp;";
						}
					}
				/*회원의 레벨이 10레벨과 같거나 높을경우 어드민페이지로*/
				 if($admin=="Y" || $mem['m_level']>=10){
					goto_url(MARI_HOME_URL.'/?cms=admin');
				 }else{
					goto_url(MARI_HOME_URL.'/?mode=main');
				 }

	break;
/************************************************
회원가입시 idsearch
************************************************/
	case "id_search":
		if($_POST[call]=='idChk'&&$_POST[val]){
				$sql="select m_id from mari_member where m_id='".$val."' limit 1 ";
				$dd = sql_fetch($sql, false);
				if($dd[m_id])echo $dd[m_id];		
				else echo '';
		}
	break;

/************************************************
투자리스트
************************************************/

	case "invest":

		/*투자리스트 1차 카테고리*/
		$sql="select * from mari_category order by ca_pk asc"; 
		$depth_list=sql_query($sql, false);

		/*투자리스트 2차 카테고리*/
		$sql="select * from mari_category where ca_id='$ca_id' order by ca_pk asc"; 
		$depth_sublist=sql_query($sql, false);

		/*투자리스트 3차 카테고리*/
		$sql="select * from mari_category where ca_id='$ca_id' and ca_sub_id='$ca_sub_id' order by ca_pk asc"; 
		$depth_ssublist=sql_query($sql, false);

		$sql = "select * from mari_invest_progress where loan_id = '$i_id'";
		$money = sql_fetch($sql,false);

		$sql_common = " from mari_loan ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

//					$sql_search .= " ($sfl like '$stx%')";
				$sql_search .= " (i_subject like '%$stx%')";

			$sql_search .= " ) ";
			$list_view= "and (  i_view='Y' )";
		}else{
			$list_view= " and (  i_view='Y' )";
		}

		if($ca_id){
			$cate_sort = "and (ca_id='$ca_id' or ca_sub_id='$ca_id' or ca_ssub_id='$ca_id')";
		}
		/*카테고리 검색시 조건값*/
		if($ca_id){
			if(!$ca_sub_id){
				$cate_sorting="&ca_id=$ca_id&ca_pk=$ca_pk";
			}else if(!$ca_ssub_id){
				$cate_sorting="&ca_id=$ca_id&ca_sub_id=$ca_sub_id&ca_pk=$ca_pk&page=$page";
			}else{
				$cate_sorting="&ca_id=$ca_id&ca_sub_id=$ca_sub_id&ca_ssub_id=$ca_ssub_id&ca_pk=$ca_pk&page=$page";
			}
		}

		if($look){
			$look_sort = "and i_look = '".$look."'";
		}

		$sst = "i_id";
		$sod = "desc";
		
		$sql_order = "order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common  $sql_search ".$list_view." $cate_sort ".$look_sort." $sql_order ";
		$row = sql_fetch($sql, false);
		$total_count = $row['cnt'];

		$rows = $config['c_display_subcount'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
										
		$sql = " select * $sql_common  $sql_search ".$list_view." $cate_sort ".$look_sort." $sql_order limit $from_record, $rows ";
		$result = sql_query($sql, false);

		/*상품개수*/
		$sql = "select count(*) as cnt from mari_loan where i_view = 'Y'";
		$pro_cnt = sql_fetch($sql, false);
		$total_pro = $pro_cnt['cnt'];

		$colspan = 16;
					
		$sql = "select * from mari_loan where i_id = '$loan_id'";
		$stest = sql_fetch($sql, false);


/*2018-01-03 평균 수익률 이경희*/
		$sql  = "SELECT i_id, i_loan_pay, i_year_plus, i_subject, i_loanexecutiondate, i_look 
				FROM mari_loan 
				WHERE i_loan_pay != '0' AND i_year_plus != '0'
				  AND (i_look = 'C' OR i_look = 'D' OR i_look = 'F') ";
		$totalAverage = sql_query($sql, false);

		$sql = "SELECT COUNT(*) AS cnt FROM mari_loan WHERE i_loan_pay!='0' AND i_year_plus!=0 AND (i_look='C' OR i_look='D' OR i_look='F') ";
		$y_count = sql_fetch($sql);
		$total_y_count = $y_count['cnt'];
		
//		if($totalAverage['i_look']=="C" || $totalAverage['i_look']=="D" || $totalAverage['i_look']=="F"){
			for($a=0; $average_t = sql_fetch_array($totalAverage); $a++){
				if($average_t['i_loanexecutiondate']=="0000-00-00 00:00:00"){
				}else{
					$y_average += $average_t['i_year_plus'];
					
					$Result_average = $y_average / $total_y_count;
				}
			}
//		}

/*2018-01-03 평균 수익률 이경희*/



	break;




/************************************************
마이페이지 입찰/정산 현황(모바일)
************************************************/

	case "invest_info":		
		
		/*입찰정보
		$sql = " select * from mari_invest where m_id='$user[m_id]'  order by i_regdatetime desc limit 6";
		$laon = sql_query($sql);*/

		/*입찰정보*/
		$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
		$laon_count = sql_fetch($sql);
		$total_laon= $laon_count['cnt'];
		$rows ="10";
		$total_laon_page  = ceil($total_laon / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_invest where m_id='$user[m_id]'  order by i_regdatetime desc limit $from_record, $rows ";
		$laon = sql_query($sql);

		/*투자 정산정보
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit 6";
		$order_s = sql_query($sql);*/

		/*투자정산정보*/
		$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
		$order_s_count = sql_fetch($sql);
		$total_order_s = $order_s_count['cnt'];
		$rows ="10";
		$total_orders_page  = ceil($total_order_s / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
		$order_s = sql_query($sql);		
	
		/*투자 정산정보*/		
		//$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit 6";
		//$order_s = sql_query($sql);

		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
		$order_w = sql_query($sql);

		/*수수료,원천징수,연체설정정보*/
		$sql = "select * from  mari_inset";
		$is_ck = sql_fetch($sql, false);

		/*개인,법인 수수료&원천징수 수수료설정*/
		if($user[m_level]=="2"){
			$i_profit=$is_ck['i_withholding_personal'];
		}else if($user[m_level]>=3){
			$i_profit=$is_ck['i_withholding_burr'];
		}

	break;

/************************************************
마이페이지 대출/상환 현황(모바일)
************************************************/

	case "loan_info":		
		
		/*대출현황
		$sql = " select * from mari_loan where m_id='$user[m_id]'  order  by i_regdatetime desc limit 6";
		$laons = sql_query($sql);
		*/

		/*대출신청정보*/
		$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
		$laons_count = sql_fetch($sql);
		$total_laons= $laons_count['cnt'];
		$rows ="10";
		$total_laons_page  = ceil($total_laons / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_loan where m_id='$user[m_id]'  order  by i_regdatetime desc limit $from_record, $rows ";
		$laons = sql_query($sql);
		
		/*입금현황
		$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit 6";
		$order = sql_query($sql);
		*/
		
		/*입금현황*/
		$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
		$order_count = sql_fetch($sql);
		$total_order = $order_count['cnt'];
		$rows ="10";
		$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
		$order = sql_query($sql);
	break;

/************************************************
투자정보
************************************************/

	case "emoney":
		
		/*적립금내역*/
		$sql = " select count(*) as cnt from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc";
		$emoney_count = sql_fetch($sql);
		$total_emoney = $emoney_count['cnt'];
		$rows ="10";
		$total_emoney_page  = ceil($total_emoney / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc limit  $rows ";
		$emoney = sql_query($sql);
	break;


/************************************************
투자정보
************************************************/

	case "invest_view":
		/*대출 상세정보*/
		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loa = sql_fetch($sql, false);

		/*부체내역*/
		$sql = "select  * from  mari_debt where m_id='".$loa[m_id]."' limit 1";
		$deb = sql_fetch($sql, false);

		/*위시리스트에 등록내역*/
		$sql = " select  loan_id from  mari_wishlist where m_id='$user[m_id]' and loan_id='$loan_id'";
		$wish = sql_fetch($sql, false);
		
		
		/*제출가능 서류 나눔*/
		$out_paper = explode("|",$loa[i_out_paper]);
		/*공통*/
		$out_paper_01 = $out_paper[0]; //신분증
		$out_paper_02 = $out_paper[1]; //등본
		$out_paper_03 = $out_paper[2]; //원초본
		$out_paper_04 = $out_paper[3]; //가족관계증명서
		$out_paper_05 = $out_paper[4]; //주거래통장
		/*소득서류*/
		$out_paper_06 = $out_paper[5]; //원천징수영수증
		$out_paper_07 = $out_paper[6]; //갑종근로소득세
		$out_paper_08 = $out_paper[7]; //직장의료보험 납부확인서
		$out_paper_09 = $out_paper[8]; //급여통장 거래내역서
		/*재직서류*/
		$out_paper_10 = $out_paper[9]; //재직증명서
		$out_paper_11 = $out_paper[10]; //직작의료보험 자격득실확인서
		/*대출 투자 상세정보*/
		$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
		$iv = sql_fetch($sql, false);

		/*투자인원 구하기*/
		$sql = " select count(*) as cnt from mari_invest where loan_id='$loan_id' order by i_pay desc";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];

		/*투자참여인원 리스트*/
		$sql="select m_name, i_pay, i_regdatetime from mari_invest  where loan_id='$loan_id' order by i_regdatetime desc"; 
		$play_list=sql_query($sql, false);


		/*성별 생년월일*/
		$sql = " select  * from  mari_member where m_id='$loa[m_id]'";
		$sex = sql_fetch($sql, false);

		/*나이구하기*/

		/*날짜 자르기*/
		$datetime=$sex['m_birth'];
		$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
		$Y_date = date("Y", strtotime( $datetime ) );
		$M_date = date("m", strtotime( $datetime ) );
		$D_date = date("d", strtotime( $datetime ) );

		$birthday = "".$Y_date."".$M_date."".$D_date."";
		$birthyear = date("Y", strtotime( $birthday )); //생년
		$nowyear = date("Y"); //현재년도
		$age2 = $nowyear-$birthyear+1; //한국나이

		$face_subject=cut_str(strip_tags($iv[i_invest_name]),22,"…");
		$face_url= "".MARI_HOME_URL."/?mode=invest_view&loan_id=$iv[i_id]";
		$face_content = cut_str(strip_tags($loa[i_loan_pose]),22,"…");
		$face_img = "".MARI_HOMESKIN_URL."/img/invest_img1.png";

		/*대출총액의 투자금액 백분율구하기*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'"; 
		$top=sql_query($sql, false);
		$order = mysql_result($top, 0, 0);
		$total=$loa[i_loan_pay];
		/*투자금액이 0보다클경우에만 연산*/
		if($order>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($order/$total*100);
		}else{
			$order_pay="0";
		}
		/*모집마감일 체크*/
		if($iv ['i_invest_eday']<$date){
			$invest_set="Y";
		}
		if($order_pay=="100"){
			$invest_max="Y";
		}
		/*모집 남은 일수 구하기*/
		$edate = $iv['i_invest_eday'];
		$ddy = ( strtotime($edate) - strtotime($date) ) / 86400;
		$dday=floor($ddy);

		$ln_money=$loa['i_loan_pay']; //대출금액 
		$ln_kigan=$loa['i_loan_day']; //대출기간 
		$ln_iyul=$loa['i_year_plus']; //대출이율 


		/*매월이율*/
		$month_eja= ($ln_iyul/100)*(1/12); 

		/*월불입금*/ 
	if($ln_iyul){
		$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money )/( pow(1+$month_eja,$ln_kigan) - 1); 
	}

	/*월이자계산*/
	if($loa['i_repay']=="원리금균등상환"){

		$일년이자 = $ln_money*($ln_iyul/100);
		$첫달이자 = substr(floor($일년이자/12),0,-1)."0";
		$rate = (($ln_iyul/100)/12); 
		$상환금 = floor($ln_money*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 

	}else if($loa['i_repay']=="만기일시상환"){
		$일년이자 = $ln_money*($ln_iyul/100);
		$상환금 = substr(floor($일년이자/12),0,-1)."0";
	}



		/*총이자금액*/ 
		//q *12-p0 = {12*r*(1+r)^12/[(1+r)^12-1]-1} * p0 
			//매달내야하는금액 * 12 - 대출원금 = {12*월이율*(1+월이율)^12/[(1+월이율)^12-1]-1} * 대출원금 
		//($month_money*12)-$ln_money = ( (12*$month_eja*pow(1+$month_eja,12)) / ((pow(1+$month_eja,12)-1)) -1) * $ln_money; 
	if($ln_iyul){
		$all_eja = ( (12 * $month_eja * pow(1+$month_eja,12) ) / ( (pow(1+$month_eja,12) -1)) -1 ) * $ln_money; 
	}
		/*소수점이하 제거*/
		/*월불입금*/ 
		$mh_money=floor($month_money);


		/*invest_comment*/
		$sql = " select count(*) as cnt from mari_viewcomment where loan_id='$loan_id'";
		$co_count = sql_fetch($sql);
		$total_co= $co_count['cnt'];
		$rows ="15";
		$total_co_page  = ceil($total_co / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = "select * from mari_viewcomment  where loan_id='$loan_id' order by co_regdatetime desc limit $from_record, $rows ";
		$co_list = sql_query($sql);

		$sql = "select  * from  mari_category order by ca_subject asc";
		$cate1 = sql_query($sql, false);

		/*구글 지도주소,위도,경도값*/
		$g_t2=explode("-",$loa['i_locaty']);
		$g_t3=explode("-",$loa['i_locaty_01']);
		$g_t4=explode("-",$loa['i_locaty_02']);

		$sql = " select  * from  mari_category where ca_id= '$loa[i_payment]'";
		$cate = sql_fetch($sql, false);
		
		
					
		/*상품*/
		$sql = " select  * from  mari_category where ca_id= '$loa[i_payment]'";
		$cate = sql_fetch($sql, false);

	
		if($loa['i_creditpoint_two']=="1"){
			$gauge = 98;
		}else if($loa['i_creditpoint_two']=="2"){
			$gauge = 87;
		}else if($loa['i_creditpoint_two']=="3"){
			$gauge = 76;
		}else if($loa['i_creditpoint_two']=="4"){
			$gauge = 64;
		}else if($loa['i_creditpoint_two']=="5"){
			$gauge = 54;
		}else if($loa['i_creditpoint_two']=="6"){
			$gauge = 44;
		}else if($loa['i_creditpoint_two']=="7"){
			$gauge = 32;
		}else if($loa['i_creditpoint_two']=="8"){
			$gauge = 21;
		}else if($loa['i_creditpoint_two']=="9"){
			$gauge = 10;
		}else if($loa['i_creditpoint_two']=="10"){
			$gauge = 0;
		}
		
		/*평수계산*/
		$area_num = $loa['i_area'] / 3.305785;
		
		//별
		$half = '<img src="'.MARI_HOMESKIN_URL.'/img/half.png" >';
		$full = '<img src="'.MARI_HOMESKIN_URL.'/img/selected.png" >';
		$empty = '<img src="'.MARI_HOMESKIN_URL.'/img/not-selected.png" >';
		
		 /*신용등급 게이지*/
		if($iv['i_grade']=="A1") $per = 7;
		else if($iv['i_grade']=="A2") $per = 39.7;
		else if($iv['i_grade']=="A3") $per = 73.2;

		else if($iv['i_grade']=="B1") $per = 105.5;
		else if($iv['i_grade']=="B2") $per = 139;
		else if($iv['i_grade']=="B3") $per = 171;

		else if($iv['i_grade']=="C1") $per = 205;
		else if($iv['i_grade']=="C2") $per = 238;
		else if($iv['i_grade']=="C3") $per = 271;

		else if($iv['i_grade']=="D1") $per = 304.5;
		else if($iv['i_grade']=="D2") $per = 337.5;
		else if($iv['i_grade']=="D3") $per = 371;

		else if($iv['i_grade']=="E1") $per = 403;
		else if($iv['i_grade']=="E2") $per = 437;
		else if($iv['i_grade']=="E3") $per = 470;


		/*첨부파일*/
		$sql = "select file_name, loan_id from mari_invest_file where loan_id = '$loan_id'";
		$file_list = sql_query($sql);

		$sql = "select count(file_idx) as cnt from mari_invest_file where loan_id = '$loan_id'";
		$file_cnt = sql_fetch($sql);
		$total_file = $file_cnt['cnt'];

		/*증빙서류파일 리스트 추가 - 20170904  전인성*/
		$sql = "select count(*) as cnt from mari_invest_file where loan_id = '$loan_id' and file_type != ''";
		$proof_file_cnt = sql_fetch($sql);
		$total_proof = $proof_file_cnt['cnt'];

		/*증빙서류파일*/
		$sql = "select * from mari_invest_file where loan_id = '$loan_id' and file_type != '' order by file_idx asc" ;
		$proof_file = sql_query($sql);

	
	break;


/************************************************
투자시뮬레이션 계산기
************************************************/

	case "invest_calculation":

		/*콤마제거*/
		$loan_pay = (string)$loan_pay;
		$loan_pay = preg_replace("/[^0-9]/", "",$loan_pay);
		$loan_pay = (int)$loan_pay;

		/*대출 상세정보*/
		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loa = sql_fetch($sql, false);
		
		$ln_kigan=$loa['i_loan_day']; //대출기간 
		$ln_iyul=$loa['i_year_plus']; //대출이율 

		if(!$loan_pay){
			$loan_pay="10000000";
		}
		$loan_pay_p=$loan_pay;

	break;


/************************************************
투자정보 new
************************************************/

	case "invest_info_detail":
		/*대출 상세정보*/
		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loa = sql_fetch($sql, false);

		/*부체내역*/
		$sql = "select  * from  mari_debt where m_id='".$loa[m_id]."' limit 1";
		$deb = sql_fetch($sql, false);

		/*제출가능 서류 나눔*/
		$out_paper = explode("|",$loa[i_out_paper]);
		/*공통*/
		$out_paper_01 = $out_paper[0]; //신분증
		$out_paper_02 = $out_paper[1]; //등본
		$out_paper_03 = $out_paper[2]; //원초본
		$out_paper_04 = $out_paper[3]; //가족관계증명서
		$out_paper_05 = $out_paper[4]; //주거래통장
		/*소득서류*/
		$out_paper_06 = $out_paper[5]; //원천징수영수증
		$out_paper_07 = $out_paper[6]; //각종근로소득세
		$out_paper_08 = $out_paper[7]; //직장의료보험 납부확인서
		$out_paper_09 = $out_paper[8]; //급여통장 거래내역서
		/*재직서류*/
		$out_paper_10 = $out_paper[9]; //재직증명서
		$out_paper_11 = $out_paper[10]; //직작의료보험 자격득실확인서
		/*대출 투자 상세정보*/
		$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
		$iv = sql_fetch($sql, false);

		/*투자인원 구하기*/
		$sql = " select count(*) as cnt from mari_invest where loan_id='$loan_id' order by i_pay desc";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];

		/*투자참여인원 리스트*/
		$sql="select m_name, i_pay, i_regdatetime from mari_invest  where loan_id='$loan_id' order by i_regdatetime desc"; 
		$play_list=sql_query($sql, false);


		/*성별 생년월일*/
		$sql = " select  * from  mari_member where m_id='$loa[m_id]'";
		$sex = sql_fetch($sql, false);

		/*나이구하기*/

		/*날짜 자르기*/
		$datetime=$sex['m_birth'];
		$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
		$Y_date = date("Y", strtotime( $datetime ) );
		$M_date = date("m", strtotime( $datetime ) );
		$D_date = date("d", strtotime( $datetime ) );

		$birthday = "".$Y_date."".$M_date."".$D_date."";
		$birthyear = date("Y", strtotime( $birthday )); //생년
		$nowyear = date("Y"); //현재년도
		$age2 = $nowyear-$birthyear+1; //한국나이

		$face_subject=cut_str(strip_tags($iv[i_invest_name]),22,"…");
		$face_url= "".MARI_HOME_URL."/?mode=invest_view&loan_id=$iv[i_id]";
		$face_content = cut_str(strip_tags($loa[i_loan_pose]),22,"…");
		$face_img = "".MARI_HOMESKIN_URL."/img/invest_img1.png";

		/*대출총액의 투자금액 백분율구하기*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'"; 
		$top=sql_query($sql, false);
		$order = mysql_result($top, 0, 0);
		$total=$loa[i_loan_pay];
		/*투자금액이 0보다클경우에만 연산*/
		if($order>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($order/$total*100);
		}else{
			$order_pay="0";
		}
		/*모집마감일 체크*/
		if($iv ['i_invest_eday']<$date){
			$invest_set="Y";
		}
		if($order_pay=="100"){
			$invest_max="Y";
		}
		/*모집 남은 일수 구하기*/
		$edate = $iv['i_invest_eday'];
		$ddy = ( strtotime($edate) - strtotime($date) ) / 86400;
		$dday=floor($ddy);

		$ln_money=$loa['i_loan_pay']; //대출금액 
		$ln_kigan=$loa['i_loan_day']; //대출기간 
		$ln_iyul=$loa['i_year_plus']; //대출이율 


		/*매월이율*/
		$month_eja= ($ln_iyul/100)*(1/12); 

		/*월불입금*/ 
		$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money )/( pow(1+$month_eja,$ln_kigan) - 1); 


		/*총이자금액*/ 
		//q *12-p0 = {12*r*(1+r)^12/[(1+r)^12-1]-1} * p0 
			//매달내야하는금액 * 12 - 대출원금 = {12*월이율*(1+월이율)^12/[(1+월이율)^12-1]-1} * 대출원금 
		//($month_money*12)-$ln_money = ( (12*$month_eja*pow(1+$month_eja,12)) / ((pow(1+$month_eja,12)-1)) -1) * $ln_money; 
		$all_eja = ( (12 * $month_eja * pow(1+$month_eja,12) ) / ( (pow(1+$month_eja,12) -1)) -1 ) * $ln_money; 

		/*소수점이하 제거*/
		/*월불입금*/ 
		$mh_money=floor($month_money);


		/*invest_comment*/
		$sql = " select count(*) as cnt from mari_viewcomment where loan_id='$loan_id'";
		$co_count = sql_fetch($sql);
		$total_co= $co_count['cnt'];
		$rows ="15";
		$total_co_page  = ceil($total_co / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = "select * from mari_viewcomment  where loan_id='$loan_id' order by co_regdatetime desc limit $from_record, $rows ";
		$co_list = sql_query($sql);

		$sql = "select  * from  mari_category order by ca_subject asc";
		$cate1 = sql_query($sql, false);
		
		$sql = " select  * from  mari_category where ca_id= '$loa[i_payment]'";
		$cate = sql_fetch($sql, false);
	
		/*위시리스트에 등록내역*/
		$sql = " select  loan_id from  mari_wishlist where m_id='$user[m_id]' and loan_id='$loan_id'";
		$wish = sql_fetch($sql, false);
		
		/*신용등급 게이지*/
		$sql = "select * from mari_loan where i_id = '$loan_id'";
		$loa2 = sql_fetch($sql);
		
		if($loa2['i_creditpoint_one'] == 1000){
			$gauge1 = 98;
		}else{
			$gauge1 = $loa2['i_creditpoint_one'] / 10 ;
		}

		if($loa2['i_creditpoint_two'] == 1){
			$gauge2 = 98;
		}else if($loa2['i_creditpoint_two'] == 2){
			$gauge2 = 87;
		}else if($loa2['i_creditpoint_two'] == 3){
			$gauge2 = 76;
		}else if($loa2['i_creditpoint_two'] == 4){
			$gauge2 = 66;
		}else if($loa2['i_creditpoint_two'] == 5){
			$gauge2 = 55;
		}else if($loa2['i_creditpoint_two'] == 6){
			$gauge2 = 44;
		}else if($loa2['i_creditpoint_two'] == 7){
			$gauge2 = 33;
		}else if($loa2['i_creditpoint_two'] == 8){
			$gauge2 = 22;
		}else if($loa2['i_creditpoint_two'] == 9){
			$gauge2 = 11;
		}else{
			$gauge2 = 0;
		}
		
		/*신용등급*/
		if($loa2['i_creditpoint_two'] == 1 || $loa2['i_creditpoint_two'] == 2){
			$credit_grade = 'A';
		}else if($loa2['i_creditpoint_two'] == 3 || $loa2['i_creditpoint_two'] == 4){
			$credit_grade = 'B';
		}else if($loa2['i_creditpoint_two'] == 5 || $loa2['i_creditpoint_two'] == 6){
			$credit_grade = 'C';
		}else if($loa2['i_creditpoint_two'] == 7 || $loa2['i_creditpoint_two'] == 8){
			$credit_grade = 'D';
		}else if($loa2['i_creditpoint_two'] == 9 || $loa2['i_creditpoint_two'] == 10){
			$credit_grade = 'E';
		}

		/*구글 지도주소,위도,경도값*/
		$g_t2=explode("-",$loa['i_locaty']);
		$g_t3=explode("-",$loa['i_locaty_01']);
		$g_t4=explode("-",$loa['i_locaty_02']);

	break;



/************************************************
투자신청
************************************************/

	case "invest2":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*대출 상세정보*/
		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loa = sql_fetch($sql, false);

		/*대출 투자 상세정보*/
		$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
		$iv = sql_fetch($sql, false);

		/*수수료설정*/
		$sql = "select  i_profit, i_withholding_personal, i_withholding_burr from  mari_inset";
		$inv = sql_fetch($sql, false);
			
		/*현재투자금액*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'"; 
		$top=sql_query($sql, false);
		$orders = mysql_result($top, 0, 0);

		$total=$loa[i_loan_pay];
		/*투자금액이 0보다클경우에만 연산*/
		if($orders>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($orders/$total*100);
		}else{
			$order_pay="0";
		}

		/*대출총액-현재투자금액=투자가능금액*/
		$invest_pay=$loa['i_loan_pay']-$orders;

		/*포인트합계구하기*/
		$sql="select sum(p_emoney) from mari_emoney where  m_id='$user[m_id]'"; 
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
				/*출금가능 은행목록조회*/

						$requestPath = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);


				}
	break;




/************************************************
투자신청 new


	if ((hash('sha256',$m_password) != $mem['m_password'])) {
			alert('존재하지 않거나 잘못된 계정 또는 \\n계정과 비밀번호가 일치하지 않습니다. ');
		}
************************************************/

	case "investment":
		 
		
		/*대출 상세정보*/
		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loa = sql_fetch($sql, false);

		/*대출 투자 상세정보*/
		$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
		$iv = sql_fetch($sql, false);

		/*수수료설정*/
		$sql = "select  i_profit, i_withholding_personal, i_withholding_burr from  mari_inset";
		$inv = sql_fetch($sql, false);
		/*현재투자금액*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'"; 
		$top=sql_query($sql, false);
		$orders = mysql_result($top, 0, 0);

		/*대출총액-현재투자금액=투자가능금액*/
		$invest_pay=$loa['i_loan_pay']-$orders;

		/*포인트합계구하기*/
		$sql="select sum(p_emoney) from mari_emoney where  m_id='$user[m_id]'"; 
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);
		
break;





















/************************************************
투자신청확인서
************************************************/

	case "invest_complete":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*대출 상세정보*/
		$sql = "select  i_invest_name from  mari_invest_progress where loan_id='$loan_id'";
		$complete = sql_fetch($sql, false);
		if(!$complete['i_invest_name']){
				alert('정상적인 접근이 아닙니다.');
				exit;
		}
	break;



/************************************************
대출신청
************************************************/

	case "loan_real":
	case "loan_credit":
	case "loan_business":
		
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*키발급조회 가장최신것*/
		$sql = "select  sSafekey from  mari_safekey where m_id='".$user[m_id]."' order by sAuthTime desc";
		$keyck = sql_fetch($sql, false);

		/*휴대폰번호 분리*/
		$m_hp = $user['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);

		/*전화번호 분리*/
		$m_tel = $user['m_tel'];
		$tel1=substr($m_tel,0,3);
		$tel2=substr($m_tel,3,-4);
		$tel3=substr($m_tel,-4);


		/*우편번호 분리*/
		$m_zip = $user['m_zip'];
		$m_zip1=substr($m_zip,0,3);
		$m_zip2=substr($m_zip,3,3);

		/*부체내역*/
		$sql = "select  * from  mari_debt where m_id='".$user[m_id]."' limit 1";
		$deb = sql_fetch($sql, false);

		/*성별 생년월일*/
		$sql = " select  * from  mari_member where m_id='".$user[m_id]."'";
		$sex = sql_fetch($sql, false);

		/*나이구하기*/

		/*날짜 자르기*/
		$datetime=$sex['m_birth'];
		$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
		$Y_dates = date("Y", strtotime( $datetime ) );
		$M_dates = date("m", strtotime( $datetime ) );
		$D_dates = date("d", strtotime( $datetime ) );

		$birthday = "".$Y_dates."".$M_dates."".$D_dates."";
		$birthyear = date("Y", strtotime( $birthday )); //생년
		$nowyear = date("Y"); //현재년도
		$age2 = $nowyear-$birthyear+1; //한국나이

		$sql = "select  * from  mari_category where ca_num='1' order by ca_id asc";
		$cate1 = sql_query($sql, false);




/*신용정보 안심키발급 성공시*/
if($nice=="2"){

	session_start();

	if(!extension_loaded('CPClient')) {
			dl('CPClient.' . PHP_SHLIB_SUFFIX);
		}
	$module = 'CPClient';

	$sitecode = $config[c_company_code];				// NICE로부터 부여받은 사이트 코드
	$sitepasswd = $config[c_pw_code];			// NICE로부터 부여받은 사이트 패스워드
    
    $enc_data = $_POST["EncodeData"];		// 암호화된 결과 데이타
    $sReserved1 = $_POST['param_r1'];		
		$sReserved2 = $_POST['param_r2'];
		$sReserved3 = $_POST['param_r3'];

		//////////////////////////////////////////////// 문자열 점검///////////////////////////////////////////////
    if(preg_match('~[^0-9a-zA-Z+/=]~', $enc_data, $match)) {echo "입력 값 확인이 필요합니다 : ".$match[0]; exit;} // 문자열 점검 추가. 
    if(base64_encode(base64_decode($enc_data))!=$enc_data) {echo "입력 값 확인이 필요합니다"; exit;}
    
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved1, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved2, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved3, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
    if ($enc_data != "") {

				if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
					$plaindata = get_decode_data($sitecode, $sitepasswd, $enc_data);// 암호화된 결과 데이터의 복호화
				} else {
					$plaindata = "Module get_response_data is not compiled into PHP";
				}
        
        //echo "[plaindata]  " . $plaindata . "<br>";

        if ($plaindata == -1){
            $returnMsg  = "암/복호화 시스템 오류";
        }else if ($plaindata == -4){
            $returnMsg  = "복호화 처리 오류";
        }else if ($plaindata == -5){
            $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
        }else if ($plaindata == -6){
            $returnMsg  = "복호화 데이터 오류";
        }else if ($plaindata == -9){
            $returnMsg  = "입력값 오류";
        }else if ($plaindata == -12){
            $returnMsg  = "사이트 비밀번호 오류";
        }else{
            // 복호화가 정상적일 경우 데이터를 파싱합니다.
            
            $sRequestNumber = GetValue($plaindata , "REQ_SEQ");
            $sResponseNumber = GetValue($plaindata , "RES_SEQ");
            $sReturnCode = GetValue($plaindata , "RETURN_CODE");
            $sRequestTime = GetValue($plaindata , "REQ_DATETIME");
            $sAuthTime = GetValue($plaindata , "AUTH_DATETIME");          
            $sAuthType = GetValue($plaindata , "AUTH_TYPE");
            $sAgree1Map = GetValue($plaindata , "AGREE1_MAP");
            $sAgree2Map = GetValue($plaindata , "AGREE2_MAP");
            $sAgree3Map = GetValue($plaindata , "AGREE3_MAP");
            $sCi = GetValue($plaindata , "CI");	
            $sSafekey = GetValue($plaindata , "SAFE_KEY");
            
            
            

            if(strcmp($_SESSION["REQ_SEQ"], $sRequestNumber) != 0)
            {
            	echo "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.<br>";
                  $sSafekey = "";
		         		  $sRequestNumber = "";
			            $sResponseNumber = "";
			            $sReturnCode = "";
			            $sReturnMsg = "";
			            $sRequestTime = "";
			            $sAuthTime = "";          
			            $sAuthType = "";
			            $sAgree1Map = "";
			            $sAgree2Map = "";
			            $sAgree3Map = "";
			            $sCi = "";	
            }
        }
    }


/*성공 결과저장*/
						$sql="insert into mari_safekey
									set m_id ='$user[m_id]',
									m_name ='$user[m_name]',
									sCipherTime ='$sCipherTime',
									sRequestNumber ='$sRequestNumber',
									sResponseNumber ='$sResponseNumber',
									sReturnCode ='$sReturnCode',
									sReturnMsg ='$sReturnMsg',
									sAuthType ='$sAuthType',
									sRequestTime ='$sRequestTime',
									sAuthTime ='$sAuthTime',
									sSafekey ='$sSafekey',
									sAgree1Map ='$sAgree1Map',
									sAgree2Map ='$sAgree2Map',
									sAgree3Map ='$sAgree3Map',
									sCi ='$sCi',
									sReserved1 ='$sReserved1',
									sReserved2 ='$sReserved2',
									sReserved3 ='$sReserved3',
									sReserved4 ='$sReserved4',
									cust_key ='$nonce_ap',
									sMessage ='$sMessage',
									ss_ip ='$ip'
									";
						sql_query($sql);
						/*키발급조회 가장최신것*/
						$sql = "select  sSafekey, cust_key from  mari_safekey where m_id='".$user[m_id]."' order by sAuthTime desc";
						$sskey = sql_fetch($sql, false);

						echo"
						<form name=f method=post  target=\"sSafekey\">
						<input type=hidden name='user_id' value='".$config[c_nice_id]."'/>
						<input type=hidden name='login_id' value='".$config[c_nice_login]."'/>
						<input type=password name='passwd' value='".$config[c_nice_pw]."' style='display:none;'/>
						<input type=hidden name='safekey' value='".$sskey[sSafekey]."'/>
						<input type=hidden name='cust_key' value='".$sskey[cust_key]."'/>
						<!--<input type=hidden name='name' value='".$sskey[m_name]."'/>-->
						<input type=hidden name='return_url' value='".MARI_HOME_URL."'>
						</form>
						<script>
							var opt = \"status=yes,toolbar=no,scrollbars=yes,width=700,height=750,left=0,top=0\";
							window.open(\"about:blank\", \"sSafekey\", opt);
							document.f.action=\"https://www.creditinfo.co.kr/nicecredit/web_link/jsp/auth/npacAuthReq.jsp\";
							document.f.submit();
						</script>
						";

						alert_close('고객님의 개별 식별번호는 '.$sskey[sSafekey].' 입니다.');
						/*nicecredit form전송*/

/*신용정보 안심키발급 실패시*/
}else if($nice=="3"){

	if(!extension_loaded('CPClient')) {
		dl('CPClient.' . PHP_SHLIB_SUFFIX);
	}
	$module = 'CPClient';

	$sitecode = $config[c_company_code];				// NICE로부터 부여받은 사이트 코드
	$sitepasswd = $config[c_pw_code];			// NICE로부터 부여받은 사이트 패스워드

		
    $enc_data = $_POST["EncodeData"];		// 암호화된 결과 데이타
    $sReserved1 = $_POST['param_r1'];		
		$sReserved2 = $_POST['param_r2'];
		$sReserved3 = $_POST['param_r3'];

		//////////////////////////////////////////////// 문자열 점검///////////////////////////////////////////////
    if(preg_match('~[^0-9a-zA-Z+/=]~', $enc_data, $match)) {echo "입력 값 확인이 필요합니다 : ".$match[0]; exit;} // 문자열 점검 추가. 
    if(base64_encode(base64_decode($enc_data))!=$enc_data) {echo "입력 값 확인이 필요합니다"; exit;}
    
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved1, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved2, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
    if(preg_match("/[#\&\\+\-%@=\/\\\:;,\.\'\"\^`~\_|\!\/\?\*$#<>()\[\]\{\}]/i", $sReserved3, $match)) {echo "문자열 점검 : ".$match[0]; exit;}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
    if ($enc_data != "") {

				//if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
					$plaindata = get_decode_data($sitecode, $sitepasswd, $enc_data);// 암호화된 결과 데이터의 복호화
				//} else {
				//	$plaindata = "Module get_response_data is not compiled into PHP";
				//}
        //echo "[plaindata] " . $plaindata . "<br>";

        if ($plaindata == -1){
            $returnMsg  = "암/복호화 시스템 오류";
        }else if ($plaindata == -4){
            $returnMsg  = "복호화 처리 오류";
        }else if ($plaindata == -5){
            $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
        }else if ($plaindata == -6){
            $returnMsg  = "복호화 데이터 오류";
        }else if ($plaindata == -9){
            $returnMsg  = "입력값 오류";
        }else if ($plaindata == -12){
            $returnMsg  = "사이트 비밀번호 오류";
        }else{
            // 복호화가 정상적일 경우 데이터를 파싱합니다.
            
            $sRequestNumber = GetValue($plaindata , "REQ_SEQ");
            $sReturnCode = GetValue($plaindata , "RETURN_CODE");
            $sReturnMsg = GetValue($plaindata , "RETURN_MSG");
            $sReturnMsg = GetValue($plaindata , "REQ_DATETIME");
            $sAuthType = GetValue($plaindata , "AUTH_TYPE");
            
        }
    }



/*실패 결과저장*/
						$sql="insert into mari_safekey
									set m_id ='$user[m_id]',
									m_name ='$user[m_name]',
									sCipherTime ='$sCipherTime',
									sRequestNumber ='$sRequestNumber',
									sResponseNumber ='$sResponseNumber',
									sReturnCode ='$sReturnCode',
									sReturnMsg ='$sReturnMsg',
									sAuthType ='$sAuthType',
									sRequestTime ='$sRequestTime',
									sAuthTime ='$sAuthTime',
									sSafekey ='$sSafekey',
									sAgree1Map ='$sAgree1Map',
									sAgree2Map ='$sAgree2Map',
									sAgree3Map ='$sAgree3Map',
									sCi ='$sCi',
									sReserved1 ='$sReserved1',
									sReserved2 ='$sReserved2',
									sReserved3 ='$sReserved3',
									sReserved4 ='$sReserved4',
									sMessage ='$sMessage',
									ss_ip ='$ip'
									";
						sql_query($sql);


					alert_close('인증 실패 하였습니다! 다시 확인하신후 조회해 주시기 바랍니다.');
					exit;

}else{

/*나이스 신용정보 SET1*/

	session_start();

	$m_birth = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $user[m_birth]); 

	$m_name = iconv("UTF-8", "EUC-KR", $user[m_name]);

	/*성별*/
	if($user[m_sex]=="m"){
		$m_sex="1";
	}else{
		$m_sex="0";
	}
	
	/*
	if(!extension_loaded('CPClient')) {
		dl('CPClient.' . PHP_SHLIB_SUFFIX);
	}
	*/
		$module = 'CPClient';

	$sitecode = $config[c_company_code];				// NICE로부터 부여받은 사이트 코드
	$sitepasswd = $config[c_pw_code];			// NICE로부터 부여받은 사이트 패스워드

	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	$reqseq = "REQ_0123456789";     // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
	$reqseq = get_cprequest_no($sitecode);
	} else {
		$reqseq = "Module get_request_no is not compiled into PHP";
	}

	// reqseq값은 성공페이지로 갈 경우 검증을 위하여 세션에 담아둔다.
	$_SESSION["REQ_SEQ"] = $reqseq;

	/*
		요청일시 생성 yyyyMMddHHmmss		
	*/
	$req_datetime  = date("YmdHis");

	/*
		값은 총 3자리로 첫번째자리는 휴대폰인증사용여부, 두번째자리는 신용카드인증사용여부, 세번째자리는 공인인증서인증사용여부를 입력합니다.
		값은 반드시 3자리로 입력해 주셔야 됩니다.
		사용인 경우는 1,미사용인 경우는 0으로 표기합니다.
		예) 휴대폰인증사용,신용카드인증미사용,공인인증서인증사용 인 경우 
		    sAuthType = "101";
	*/
	$sAuthType = "101";
	/*
		생년월일 정보로 8자리로 입력합니다.(년 4자리, 월 2자리, 일 2자리)
		예) 생년월일이 '9999년 1월 20일' 인 경우
		    birthdate = "99990120";
	*/
	$birthdate = $m_birth;

	/*
		성별정보 남자는 1, 여자는 0으로 입력합니다.
		예) '남자' 인 경우
		    gender = "1";
	*/
	$gender = $m_sex;

	/*
		안심키 대상에 성명을 적어주시면 됩니다.
		예) 이름이 '홍길동' 인 경우
		    username = "홍길동";
	*/
	$username = $m_name;

	
	/*
		동의문에 대한 사용여부를 결정하는 코드입니다.		
		동의문종류 
		- 신용인증송부 서비스 신청 동의
		
		예) 신용인증송부 서비스 신청 동의를 원하는 경우 
			agree1_map = "1000000000";
			신용인증송부 서비스 신청 동의 원하지 않을 경우
			agree1_map = "0000000000";
	*/
	$agree1_map = "0000000000"; // 신용인증송부 서비스 신청 동의

	/*
		동의문에 대한 사용여부를 결정하는 코드입니다.
		업체에서 사전에 등록한 동의문정보를 기준으로 작성해주시면됩니다.
		동의문종류 		
		- 업체 필수 동의 (업체에서 제공하는 필수 동의문)
		- 업체 선택 동의 (업체에서 제공하는 선택 동의문)
		각 동의문은 최대 10개까지 등록이 가능합니다.
		입력 값은 등록하신 동의문이 없어도 반드시 10자리 입력해 주셔야 됩니다.
		사용여부는 사용인 경우 1, 미사용인 경우 0로 표기합니다.
		예) 등록된 동의문 중 동의문 중 1,3,5,6,번째 동의문만 사용하고 싶은 경우
			agree2_map = "1010110000";
			동록뢴 동의문이 없는 경우
			agree3_map = "0000000000";
	*/
	$agree2_map = "0000000000"; // 업체 필수 동의문
	$agree3_map = "0000000000"; // 업체 선택 동의문
	
	/*
		결과로 CI값을 결과값으로 받을지를 결정
		Y : CI를 결과값으로 받음, N : CI를 결과값으로 받지 않음
		
		CI는 본인확인을 정상적으로 성공한 경우만 받을 수 있습니다.
	*/
	$cigubun 	= "N";

	/*
		팝업창을 구분하는 입력값으로 제공되는 페이지에 취소버튼 즉 팝업창을 닫는 버튼이 없어집니다.
		Y : 취소버튼 있음, N : 취소버튼 없음
	*/
	$popgubun 	= "N";

	/*
		안심키 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		받을 page는 https://~, http://~ 부터 입력해 주시기 바랍니다.
		부모창에 페이지와 결과페이지에 도메인은 반드시 일치하도록 입력해 주시기 바랍니다.
	*/ 
	$sReturnUrl = MARI_HOME_URL."/?mode=loan&nice=2";      // 성공시 이동될 URL
	$sErrorUrl = MARI_HOME_URL."/?mode=loan&nice=3";         // 실패시 이동될 URL

	// 입력될 plain 데이타를 만든다.
	$sPlainData =	"7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq .  
					"12:REQ_DATETIME" . strlen($req_datetime) . ":" . $req_datetime .
					"8:SITECODE" . strlen($sitecode) . ":" . $sitecode .
					"9:AUTH_TYPE" . strlen($sAuthType) . ":" . $sAuthType .
					"10:AGREE1_MAP"  . strlen($agree1_map) . ":" . $agree1_map .
					"10:AGREE2_MAP"  . strlen($agree2_map) . ":" . $agree2_map .
					"10:AGREE3_MAP"  . strlen($agree3_map) . ":" . $agree3_map .
					"8:USERNAME"  . strlen($username) . ":" . $username .
					"9:BIRTHDATE"  . strlen($birthdate) . ":" . $birthdate .
					"6:GENDER"  . strlen($gender) . ":" . $gender .
					"8:CI_GUBUN" . strlen($cigubun) . ":" . $cigubun .
					"11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun .
					"7:RTN_URL" . strlen($sReturnUrl) . ":" . $sReturnUrl .
					"7:ERR_URL" . strlen($sErrorUrl) . ":" . $sErrorUrl;


	if (extension_loaded($module)) {// 동적으로 모듈 로드 했을경우
	$enc_data = get_encode_data($sitecode, $sitepasswd, $sPlainData);
	} else {
		$enc_data = "Module get_request_data is not compiled into PHP";
	}

	if( $enc_data == -1 )
	{
		$returnMsg = "암/복호화 시스템 오류입니다.";
		$enc_data = "";
	}
	else if( $enc_data== -2 )
	{
		$returnMsg = "암호화 처리 오류입니다.";
		$enc_data = "";
	}
	else if( $enc_data== -3 )
	{
		$returnMsg = "암호화 데이터 오류 입니다.";
		$enc_data = "";
	}
	else if( $enc_data== -9 )
	{
		$returnMsg = "입력값 오류 입니다.";
		$enc_data = "";
	}

}

	break;

/************************************************
마이페이지
************************************************/

	case "mypage":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*계좌정보*/
		$sql = "select i_not_bank, i_not_bankacc from  mari_pg";
		$bk = sql_fetch($sql, false);

		if($my=="loanstatus"){
			/*대출신청정보*/
			$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
			$laons_count = sql_fetch($sql);
			$total_laons= $laons_count['cnt'];
			$rows ="15";
			$total_laons_page  = ceil($total_laons / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함
			$sql = " select * from mari_loan where m_id='$user[m_id]'  order  by i_regdatetime desc limit $from_record, $rows ";
			$laons = sql_query($sql);
		}else if($my=="depositstatus"){
			/*입금현황*/
			$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
			$order_count = sql_fetch($sql);
			$total_order = $order_count['cnt'];
			$rows ="15";
			$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함
			$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
			$order = sql_query($sql);
		}else if($my=="tenderstatus"){
			/*입찰정보*/
			$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
			$laon_count = sql_fetch($sql);
			$total_laon= $laon_count['cnt'];
			$rows ="15";
			$total_laon_page  = ceil($total_laon / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함
			$sql = " select * from mari_invest where m_id='$user[m_id]'  order by i_regdatetime desc limit $from_record, $rows ";
			$laon = sql_query($sql);
		}else if($my=="investment"){
			/*투자 정산정보*/
			$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
			$order_s_count = sql_fetch($sql);
			$total_order_s = $order_s_count['cnt'];
			$rows ="15";
			$total_orders_page  = ceil($total_order_s / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함
			$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
			$order_s = sql_query($sql);
		}else if($my=="investmentinterest"){

			/*관심투자정보*/
			$sql = " select count(*) as cnt from mari_wishlist where m_id='$user[m_id]'";
			$wish_count = sql_fetch($sql);
			$total_wish= $wish_count['cnt'];
			$rows ="100";
			$total_wish_page  = ceil($total_wish / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함

			$sql = "select * from mari_loan order by i_regdatetime desc limit $rows ";
			$wish = sql_query($sql);

		}else if($my=="emoney_list"){
			/*적립금내역*/
			$sql = " select count(*) as cnt from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc";
			$emoney_count = sql_fetch($sql);
			$total_emoney = $emoney_count['cnt'];
			$rows ="15";
			$total_emoney_page  = ceil($total_emoney / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함

			$sql = " select * from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc limit  $rows ";
			$emoney = sql_query($sql);

		}else{
		/*입찰정보*/
		$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
		$laon_count = sql_fetch($sql);
		$total_laon= $laon_count['cnt'];
		$rows ="100";
		$sql = " select * from mari_invest where m_id='$user[m_id]' limit  $rows ";
		$laon = sql_query($sql);


		/*대출정보*/
		$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
		$order_count = sql_fetch($sql);
		$total_order = $order_count['cnt'];
		$rows ="100";
		$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit  $rows ";
		$order = sql_query($sql);



		/*대출신청정보*/
		$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
		$laons_count = sql_fetch($sql);
		$total_laons= $laons_count['cnt'];
		$rows ="100";
		$sql = " select * from mari_loan where m_id='$user[m_id]' order  by i_regdatetime desc limit  $rows";
		$laons = sql_query($sql);



		/*투자 정산정보*/
		$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
		$order_s_count = sql_fetch($sql);
		$total_order_s = $order_s_count['cnt'];
		$rows ="100";
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit  $rows ";
		$order_s = sql_query($sql);


		/*사용충전내역*/
		$sql = " select count(*) as cnt from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc";
		$emoney_count = sql_fetch($sql);
		$total_emoney = $emoney_count['cnt'];
		$rows ="100";
		$sql = " select * from mari_emoney where  m_id='$user[m_id]' order by m_id asc, p_datetime desc limit  $rows ";
		$emoney = sql_query($sql);

		/*포인트합계구하기*/
		$sql="select sum(p_emoney) from mari_emoney where  m_id='$user[m_id]'"; 
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);

		}
		/*
		실현수익률(%) = 실현수익금(회수이자-수수료)/투자원금*100

		연환산수익률(%) = 실현수익률 * 365/투자일수

		연체율(%) = 연체건 / 투자건 *100

		총자산 =  투자원금+실현수익금(회수이자-수수료)

		*/
		/*실현수익률/연환산수익률/연체율/총자산*/

		/*수수료설정*/
		$sql = "select  i_profit, i_withholding_personal, i_withholding_burr from  mari_inset";
		$inset = sql_fetch($sql, false);
		/*월투자수익금*/
		$sql="select sum(o_investamount) from mari_order where sale_id='$user[m_id]' and o_salestatus='정산완료'"; 
		$order_sum=sql_query($sql, false);
		$totalsum = mysql_result($order_sum, 0, 0);

		/*투자원금*/
		$sql="select sum(i_pay) from mari_invest where m_id='$user[m_id]'"; 
		$order_sum_a=sql_query($sql, false);
		$totalsum_a = mysql_result($order_sum_a, 0, 0);

		/*투자일수구하기*/
		$sql="select sum(i_max_pay) from mari_invest where m_id='$user[m_id]'"; 
		$order_sum_day=sql_query($sql, false);
		$totalsum_day = mysql_result($order_sum_day, 0, 0);
		$day_sum=$totalsum_day*30;
		/*연체건수구하기*/
		$sql = " select count(*) as cnt  from mari_order where sale_id='$user[m_id]' and o_salestatus='연체중'";
		$ovcn = sql_fetch($sql);
		$overdue_count = $ovcn['cnt'];

		/*투자건수구하기*/
		$sql = " select count(*) as cnt  from mari_invest where m_id='$user[m_id]'";
		$invest = sql_fetch($sql);
		$invest_count = $invest['cnt'];

		/*실현수익금*/
		if($totalsum){
			$a_sum_plus=$totalsum*$inset['i_profit'];
			$a_sum=$totalsum-$a_sum_plus;
		}
		/*실현수익률(%)*/
		if($totalsum_a){
			$aa_sum=floor($a_sum/$totalsum_a*100);
			//$aa_sum_t=ceil($aa_sum);
		}
		/*연환산수익률(%)*/
		if($day_sum){
			$bb_sum=floor($aa_sum*365/$day_sum);
			//$bb_sum_t=ceil($bb_sum);
		}
		/*연체율(%)*/
		if($invest_count){
			$cc_sum=floor($overdue_count/$invest_count*100);
			//$cc_sum=ceil($cc_sum);
		}
		/*총자산*/
		if($totalsum_a){
			$dd_sum=$totalsum_a+$a_sum;
			//$dd_sum=ceil($dd_sum);
		}

		/*입찰합계구하기*/
		$sql="select sum(i_pay) from mari_invest where m_id='$user[m_id]'"; 
		$top=sql_query($sql, false);
		$t_pay = mysql_result($top, 0, 0);

		/*누적투자회수금*/
		$sql="select sum(o_mh_money) from mari_order where user_id = '$user[m_id]'"; 
		$e_top=sql_query($sql, false);
		$e_pay = mysql_result($e_top, 0, 0);

		/*대출이율합계구하기*/
		$sql="select sum(i_year_plus) from mari_loan where i_view = 'Y'"; 
		$top_p=sql_query($sql, false);
		$t_plus = mysql_result($top_p, 0, 0);
		
		/*대출건수구하기*/
		$sql = " select count(*) as cnt from mari_loan where i_view='Y'";
		$laons_plus = sql_fetch($sql);
		$total_plus= $laons_plus['cnt'];
		/*평균내기*/	
		if($total_plus=="0"){
		}else{
			if($top_plus){
				$top_plus=$t_plus/$total_plus;
			}
		}

		/*누적투자회원금*/
		$sql="select sum(o_ln_money_to) from mari_order where sale_id='$user[m_id]'"; 
		$f_top=sql_query($sql, false);
		$Recoveryofprincipal = mysql_result($f_top, 0, 0);

		/*누적수익금*/
		$sql="select sum(o_investamount) from mari_order where sale_id='$user[m_id]'"; 
		$g_top=sql_query($sql, false);
		$Cumulativeearnings = mysql_result($g_top, 0, 0);

		/*잔여상환금*/
		$sql="select sum(o_investamount) from mari_order where sale_id='$user[m_id]' and (o_salestatus='정산대기' or o_salestatus='연체중')"; 
		$h_top=sql_query($sql, false);
		$Theremainingprincipal = mysql_result($h_top, 0, 0);

		//2차수정 161130동욱
		$sql = "select  * from mari_invest where m_id='$user[m_id]'";
		$top_play = sql_query($sql, false);

		for($i=0; $t_cnt = sql_fetch_array($top_play); $i++){

			/*상환중인투자건 2016-11-14 임근호 변경 현재 상환중이고 접속자의 투자내역이 있을경우*/
			//2차수정 161130동욱
			$sql = " select * from mari_invest_progress  where loan_id='$t_cnt[loan_id]' and i_look='D'";
			$i_top = sql_fetch($sql);
			if($i_top[loan_id]){
				$Ofrepayment_count++;
			}

			/*상환완료자건  2016-11-14 임근호 변경 현재 상환완료됬으며 접속자의 투자내역이 있을경우*/
			//2차수정 161130동욱
			$sql = " select * from mari_invest_progress  where loan_id='$t_cnt[loan_id]' and i_look='F'";
			$j_top = sql_fetch($sql);	
			if($j_top[loan_id]){
				$Ofrepaymentout_count++;
			}
		}

		/*연체건수*/
		$sql = " select count(*) as cnt from mari_order  where sale_id='$user[m_id]' and o_salestatus='연체중'";
		$k_top = sql_fetch($sql);
		$Overdue_count = $k_top['cnt'];

		/*체권발행건수*/
		$sql = " select count(*) as cnt from mari_invest  where m_id='$user[m_id]'";
		$l_top = sql_fetch($sql);
		$bond_count = $l_top['cnt'];


		/*누적 대출금액*/
		$sql="select sum(i_loan_pay) from mari_loan where m_id='$user[m_id]' and i_look='Y'"; 
		$la_top=sql_query($sql, false);
		$Loanamount = mysql_result($la_top, 0, 0);

		/*누적 대출상환금*/
		$sql="select sum(o_investamount) from mari_order where user_id='$user[m_id]' and o_status='입금완료'"; 
		$lb_top=sql_query($sql, false);
		$Loanrepayments = mysql_result($lb_top, 0, 0);


		/*잔여상환금*/
		$sql = "select sum(o_mh_money) from mari_order  where user_id='$user[m_id]' and o_status='연체'";
		$ld_top = sql_query($sql, false);
		$remainingpayments = mysql_result($ld_top, 0, 0);



		/*상환중인대출건*/
		$sql = " select count(*) as cnt from mari_order  where user_id='$user[m_id]' and o_status='연체'";
		$lc_top = sql_fetch($sql);
		$Loanrepayment_count = $lc_top['cnt'];

		
		/*상환완료대출건*/
		$sql = " select count(*) as cnt from mari_order  where user_id='$user[m_id]' and o_status='입금완료'";
		$rec_c = sql_fetch($sql);
		$repaycomplete_count = $rec_c['cnt'];

		/*상환중인대출건*/
		$sql = " select count(*) as cnt from mari_order  where user_id='$user[m_id]' and o_status='연체' group by loan_id";
		$rei_c = sql_fetch($sql);
		$repaying_count = $rei_c['cnt'];

		

		/*투자한 이력이 있을경우 본인계좌는 등록되므로 체크가능*/
		$sql = "select  i_pay from mari_invest where m_id='$user[m_id]'";
		$bankckmy = sql_fetch($sql, false);

		/*마이페이지 누적 대출건수*/
		$sql = "select count(*) as cnt from mari_loan where m_id = '$user[m_id]'";
		$a_loan = sql_fetch($sql);
		$total_loan = $a_loan['cnt'];

		/*마이페이지 누적 대출연체 건수*/
		$sql = "select count(*) as cnt from mari_order where user_id = '$user[m_id]' and o_status = '연체'";
		$a_over = sql_fetch($sql);
		$total_over = $a_over['cnt'];

		/*가상계좌정보*/
		$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
		$seyck = sql_fetch($sql, false);
		
		/*알림메시지*/
		$sql = " select * from mari_push_msg where m_id='".$user[m_id]."'  order by pm_redatetime desc limit 1";
		$push_list = sql_query($sql, false);

		/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						$requestPath = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";

						$curl_handlebank = curl_init();

						curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
						$result = curl_exec($curl_handlebank);
						curl_close($curl_handlebank);

						/*파싱*/

						$decode = json_decode($result, true);



				}
				

				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq."&refId=".$g_code."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);
				}
	break;


/************************************************
마이페이지 대출 / 입금 현황
************************************************/
	case "mypage_loan":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*계좌정보*/
		$sql = "select i_not_bank, i_not_bankacc from  mari_pg";
		$bk = sql_fetch($sql, false);

		/*my계좌정보*/
		$sql = "select * from  mari_char where m_id='$user[m_id]' and c_fin='N' order by c_regdatetime desc limit 1";
		$myemoney = sql_fetch($sql, false);


		/*대출신청정보*/
			
		$sql = " select * from mari_loan where m_id='$user[m_id]'  order  by i_regdatetime desc limit 6";
		$laons = sql_query($sql);
	
		/*입금현황*/
			
		$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
		$order = sql_query($sql);
		
	break;

/************************************************
마이페이지 정산현황  
************************************************/
	case "mypage_investment":
		/*로그인 체크여부*/
		$login_ck="YES";
	break;

/************************************************
마이페이지 입찰현황  
************************************************/
	case "mypage_tenderstatus":
		/*로그인 체크여부*/
		$login_ck="YES";
	break;

/************************************************
마이페이지 대출현황 자세히
************************************************/
	case "mypage_loanstatus":
		/*로그인 체크여부*/
		$login_ck="YES";
		
	break;

/************************************************
마이페이지 투자현황 자세히
************************************************/
	case "mypage_depositstatus":
		/*로그인 체크여부*/
		$login_ck="YES";
		
	break;

/************************************************
마이페이지 입금현황
************************************************/
	case "mypage_loan_info":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*대출신청현황*/
		$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
		$laons_count = sql_fetch($sql);
		$total_laons= $laons_count['cnt'];
		$rows ="10";
		$total_laons_page  = ceil($total_laons / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_loan where m_id='$user[m_id]' order by i_regdatetime desc limit $from_record, $rows ";
		$laons = sql_query($sql);
		
		/*입금현황*/
		$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
		$order_count = sql_fetch($sql);
		$total_order = $order_count['cnt'];
		$rows ="10";
		$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
		$order = sql_query($sql);

		$sql = "select * from mari_pg";
		$pg = sql_fetch($sql);

	break;

/************************************************
마이페이지 투자현황
************************************************/
	case "mypage_invest_info":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*입찰정보*/
		$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
		$laon_count = sql_fetch($sql);
		$total_laon= $laon_count['cnt'];
		$rows ="10";
		$total_laon_page  = ceil($total_laon / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_invest where m_id='$user[m_id]' order by i_regdatetime desc limit $from_record, $rows ";
		$laon = sql_query($sql);

		/*투자정산정보*/
		$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
		$order_s_count = sql_fetch($sql);
		$total_order_s = $order_s_count['cnt'];
		$rows ="10";
		$total_orders_page  = ceil($total_order_s / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
		$order_s = sql_query($sql);	
		
		/*원천징수현황*/
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
		$order_w = sql_query($sql);


		/*my계좌정보*/
		$sql = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
		$seyck = sql_fetch($sql, false);

		/************************************************************************
		step1 정산스케쥴>메인>투자관리리스트 2017-02-01 전체업데이트예정
		************************************************************************/

		/*개인 투자입찰정보*/
		$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
		$invest_count = sql_fetch($sql);
		$total_invest= $invest_count['cnt'];

		/*투자자 총 투자금액*/
		$sql="select sum(i_pay) from mari_invest where m_id='$user[m_id]'"; 
		$player_top=sql_query($sql, false);
		$playeramount = mysql_result($player_top, 0, 0);

		/*개인투자이율합계구하기*/
		$sql="select sum(i_profit_rate) from mari_invest where m_id = '$user[m_id]'";
		$top_invest=sql_query($sql, false);
		$t_invest_plus = mysql_result($top_invest, 0, 0);

		/*평균내기*/
		if($invest_plus['cnt']){
			$top_invest_plus=floor($t_invest_plus/$total_invest);
		}

	break;


/************************************************************************
step2 정산스케쥴>메인>정산스케쥴리스트 2017-02-01 전체업데이트예정
************************************************************************/

	case "mypage_calculate_schedule":

		/*로그인 체크여부*/
		$login_ck="YES";

		$sql = " select * from mari_repay_schedule";
		$scdlist = sql_query($sql, false);
		/*투자자 투자한 대출건가져오기*/


	break;

/************************************************************************
step3 정산스케쥴>메인>정산스케쥴상세 2017-02-01 전체업데이트예정
************************************************************************/

	case "mypage_schedule":

		/*로그인 체크여부*/
		$login_ck="YES";

		/*투자자 투자한 대출건가져오기*/
		$sql = " select * from mari_invest where m_id='$user[m_id]'";
		$myloanlist = sql_query($sql, false);


	break;

/************************************************
마이페이지 원천징수현황
************************************************/
	case "mypage_withholding_list":
		/*로그인 체크여부*/
		$login_ck="YES";
						
		/*원천징수현황*/
		$sql = " select count(*) as cnt from mari_order  where sale_id='$user[m_id]' order by o_collectiondate desc";
		$order_count = sql_fetch($sql);
		$total_order = $order_count['cnt'];
		$rows ="20";
		$total_page  = ceil($total_order / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order where sale_id='$user[m_id]' order by o_collectiondate desc limit $from_record, $rows ";
		$order_w = sql_query($sql);

	break;





/************************************************
마이페이지 신용대출 입금현황
************************************************/
	case "mypage_loan_info_credit":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*대출신청현황*/
		$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
		$laons_count = sql_fetch($sql);
		$total_laons= $laons_count['cnt'];
		$rows ="10";
		$total_laons_page  = ceil($total_laons / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_loan where m_id='$user[m_id]' and i_loan_type = 'credit' order  by i_regdatetime desc limit $from_record, $rows ";
		$laons = sql_query($sql);
		
		/*입금현황*/
		$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
		$order_count = sql_fetch($sql);
		$total_order = $order_count['cnt'];
		$rows ="10";
		$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order   where  user_id='$user[m_id]' and i_loan_type = 'credit' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
		$order = sql_query($sql);

	break;

/************************************************
마이페이지 신용대출 투자현황
************************************************/
	case "mypage_invest_info_credit":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*입찰정보*/
		$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
		$laon_count = sql_fetch($sql);
		$total_laon= $laon_count['cnt'];
		$rows ="10";
		$total_laon_page  = ceil($total_laon / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_invest where m_id='$user[m_id]' and i_loan_type = 'credit' order by i_regdatetime desc limit $from_record, $rows ";
		$laon = sql_query($sql);

		/*투자정산정보*/
		$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
		$order_s_count = sql_fetch($sql);
		$total_order_s = $order_s_count['cnt'];
		$rows ="10";
		$total_orders_page  = ceil($total_order_s / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_order where  sale_id='$user[m_id]' and i_loan_type = 'credit' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
		$order_s = sql_query($sql);	
		
		/*원천징수현황*/
		$sql = " select * from mari_order where  sale_id='$user[m_id]' and i_loan_type = 'credit' order by o_collectiondate desc limit 6";
		$order_w = sql_query($sql);

	break;


/************************************************
마이페이지 입찰/정산 현황(모바일)
************************************************/

	case "mypage_invest":						

		/*입찰정보*/		
		$sql = " select * from mari_invest where m_id='$user[m_id]'  order by i_regdatetime desc limit 6";
		$laon = sql_query($sql);

		/*투자 정산정보*/
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit 6";
		$order_s = sql_query($sql);

		
		/*계좌정보*/
		$sql = "select i_not_bank, i_not_bankacc from  mari_pg";
		$bk = sql_fetch($sql, false);

		/*my계좌정보*/
		$sql = "select * from  mari_char where m_id='$user[m_id]' and c_fin='N' order by c_regdatetime desc limit 1";
		$myemoney = sql_fetch($sql, false);		

		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
		$order_w = sql_query($sql);

		/*수수료,원천징수,연체설정정보*/
		$sql = "select * from  mari_inset";
		$is_ck = sql_fetch($sql, false);

		/*개인,법인 수수료&원천징수 수수료설정*/
		if($user[m_level]=="2"){
			$i_profit=$is_ck['i_withholding_personal'];
		}else if($user[m_level]>=3){
			$i_profit=$is_ck['i_withholding_burr'];
		}

	break;
/************************************************
매월납입금액
************************************************/
	case "payment_check":

		if($stype=="invest"){
			if($i_pay==50000){
			}else if(50000>$i_pay){
						alert_close('50,000원 이상만 투자하실 수 있습니다.');
						exit;
			}
			/*mypage일경우 계산및 체크하지않도록*/
			if($mtype=="mypage"){
			}else{
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
					alert_close('투자금액이 100%이상 초과하여 해당금액으로 투자가 불가능합니다.남은 투자가능 금액을 확인하신후 계산하여 주시기 바랍니다.');
				}
			}
			$ln_money=$i_pay; //투자금액 
			$ln_kigan=$i_loan_day; //대출기간 
			$ln_iyul=$i_year_plus; //대출이율 


			/*매월이율*/
			$month_eja= ($ln_iyul/100)*(1/12); 

			/*월불입금*/ 
			$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money)/( pow(1+$month_eja,$ln_kigan) - 1); 

			/*월불입금 총계*/
			$month_total=$month_money*$ln_kigan;

			/*소수점이하 제거*/
			/*월불입금*/ 
			$mh_money=ceil($month_money);
			/*월불입금 총계*/ 
			$mh_total=ceil($month_total);

			$psale_money=$mh_money-$month_profit;
			$psale_totalmoney=$mh_total-$total_profit;
			/*월불입금, 수익총계 소수점이하제거*/
			$sale_money=ceil($psale_money);
			$sale_totalmoney=ceil($psale_totalmoney);
		}else if($stype=="loan"){
			$ln_money=$i_loan_pay; //대출금액 
			$ln_kigan=$i_loan_day; //대출기간 
			$ln_iyul=$i_year_plus; //대출이율 


			/*매월이율*/
			$month_eja= ($ln_iyul/100)*(1/12); 

			/*월불입금*/ 
			$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money)/( pow(1+$month_eja,$ln_kigan) - 1); 

			/*월불입금 총계*/
			$month_total=$month_money*$ln_kigan;

			/*소수점이하 제거*/
			/*월불입금*/ 
			$mh_money=ceil($month_money);
			/*월불입금 총계*/ 
			$mh_total=ceil($month_total);

			/*월불입 수익금계산*/
			$month_profit=$mh_money*$is_ck['i_profit'];
			/*월불입 수익총계계산*/
			$total_profit=$mh_total*$is_ck['i_profit'];
			
			$psale_money=$mh_money-$month_profit;
			$psale_totalmoney=$mh_total-$total_profit;
			/*월불입금, 수익총계 소수점이하제거*/
			$sale_money=ceil($psale_money);
			$sale_totalmoney=ceil($psale_totalmoney);
		}
	break;


/************************************************
매월투자수익금액
************************************************/
	case "invest_income":
		if($stype=="invest"){
			if($i_pay==50000){
			}else if(50000>$i_pay){
						alert_close('50,000원 이상만 투자하실 수 있습니다.');
						exit;
			}
			/*mypage일경우 계산및 체크하지않도록*/
			if($mtype=="mypage"){
			}else{
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
					alert_close('투자금액이 100%이상 초과하여 해당금액으로 투자가 불가능합니다.남은 투자가능 금액을 확인하신후 계산하여 주시기 바랍니다.');
				}
			}
			$ln_money=$i_pay; //투자금액 
			$ln_kigan=$i_loan_day; //대출기간 
			$ln_iyul=$i_year_plus; //대출이율 


			/*매월이율*/
			$month_eja= ($ln_iyul/100)*(1/12); 

			/*월불입금*/ 
			$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money)/( pow(1+$month_eja,$ln_kigan) - 1); 

			/*월불입금 총계*/
			$month_total=$month_money*$ln_kigan;

			/*소수점이하 제거*/
			/*월불입금*/ 
			$mh_money=ceil($month_money);
			/*월불입금 총계*/ 
			$mh_total=ceil($month_total);

			$psale_money=$mh_money-$month_profit;
			$psale_totalmoney=$mh_total-$total_profit;
			/*월불입금, 수익총계 소수점이하제거*/
			$sale_money=ceil($psale_money);
			$sale_totalmoney=ceil($psale_totalmoney);
		}
	break;


/************************************************
마이페이지 관심투자 --동욱
************************************************/

	case "mypage_interest_invest":

		/*관심투자정보*/
			$sql = " select count(*) as cnt from mari_wishlist where m_id='$user[m_id]'";
			$wish_count = sql_fetch($sql);
			$total_wish= $wish_count['cnt'];
			$rows ="100";
			$total_wish_page  = ceil($total_wish / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함

			$sql = "select * from mari_loan order by i_regdatetime desc limit $rows ";
			$wish = sql_query($sql);

	break;




 /************************************************
마이페이지 입찰 / 정산 현황
************************************************/
	case "withholding_list2":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*계좌정보*/
		$sql = "select i_not_bank, i_not_bankacc from  mari_pg";
		$bk = sql_fetch($sql, false);

		/*my계좌정보*/
		$sql = "select * from  mari_char where m_id='$user[m_id]' and c_fin='N' order by c_regdatetime desc limit 1";
		$myemoney = sql_fetch($sql, false);

		/*입찰정보*/

		$sql = " select * from mari_invest where m_id='$user[m_id]'  order by i_regdatetime desc limit 6";
		$laon = sql_query($sql);
	
		/*투자 정산정보*/
	
		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit 6";
		$order_s = sql_query($sql);

		$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
		$order_w = sql_query($sql);

		/*수수료,원천징수,연체설정정보*/
		$sql = "select * from  mari_inset";
		$is_ck = sql_fetch($sql, false);

		/*개인,법인 수수료&원천징수 수수료설정*/
		if($user[m_level]=="2"){
			$i_profit=$is_ck['i_withholding_personal'];
		}else if($user[m_level]>=3){
			$i_profit=$is_ck['i_withholding_burr'];
		}
	break;


 /************************************************
마이페이지 원천징수내역
************************************************/
	case "withholding_list_more":
		/*로그인 체크여부*/
		$login_ck="YES";





		/*로그인 체크여부*/
		$login_ck="YES";

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(sale_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = "order by $sst $sod ";
		}else{
			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search and sale_id='$user[m_id]' $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search and sale_id='$user[m_id]' $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		/*emoney거래합계*/
		$sql= "select sum(m_emoney) from mari_member where m_id='$user[m_id]'";
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);


		/*수수료,원천징수,연체설정정보*/
		$sql = "select * from  mari_inset";
		$is_ck = sql_fetch($sql, false);



		/*개인,법인 수수료&원천징수 수수료설정*/
		if($user[m_level]=="2"){
			$i_profit=$is_ck['i_withholding_personal'];
		}else if($user[m_level]>=3){
			$i_profit=$is_ck['i_withholding_burr'];
		}
	break;


/************************************************
개인정보 관리
************************************************/

	case "personal_info_pw":
		/*로그인 체크여부*/
		$login_ck="YES";

	break;


/************************************************
사용자 게시판 리스트(공통)
************************************************/

	case "bbs_list":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		/*권한체크*/


		$sql_common = " from mari_write ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}



		if (!$sst) {
			$sst = $bbs_config['bo_sort_field'];
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search  and (w_table='$table') $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		/*게시판환경설정에 설정값이있는경우 환경설정대신 게시판환경설정값을 불러오도록*/
		if(!$bbs_config['bo_page_rows']){
			$rows = $config['c_page_rows'];
		}else{
			$rows = $bbs_config['bo_page_rows'];
		}
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search and (w_table='$table') $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;
	break;

/************************************************
사용자 게시판 상세(공통)
************************************************/
	case "bbs_view":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_read_level']>$user['m_level']){
				alert('글읽기 권한이 없습니다.');
				exit;
			}
		}

		if($type=="view"){

			/*조회수증가 COOKIE담기
			if ($_COOKIE['ck_id'] != $id)
			{
				$sql = " update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
				sql_query($sql);
				// 하루 동안만
				set_cookie("ck_id", $id, 60*60*24);
			}
			*/
		$sql = " select  * from  mari_write  where w_table='$table' and w_id='$id'";
		$w = sql_fetch($sql, false);

		/*휴대폰번호 분리*/
		$w_hp = $bo['w_hp'];
		$hp1=substr($w_hp,0,3);
		$hp2=substr($w_hp,3,-4);
		$hp3=substr($w_hp,-4);
		}else{
			alert('정상적인 접근이 아닙니다.');
		}
		/*첨부파일*/
		$dw_file = MARI_DATA_URL."/$table/".$w[file_img]."";

		/*댓글*/
		$sql = " select * from mari_comment where w_id='$id' ";
		$ment = sql_query($sql);
		
		/*수정할 댓글*/
		$sql = "select * from mari_comment where co_id = '$co_id' and w_id = '$id' and w_table = '$table'";
		$ment_modi = sql_fetch($sql);

	break;

/************************************************
사용자 게시판 쓰기(공통)
************************************************/
	case "bbs_write":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_write_level']>$user['m_level']){
				alert('글쓰기 권한이 없습니다.');
				exit;
			}

			if($bbs_config['bo_reply_level']>$user['m_level']){
				alert('글답변 권한이 없습니다.');
				exit;
			}
		}

		if($type=="m"){

		$sql = " select  * from  mari_write  where w_table='$table' and w_id='$id'";
		$w = sql_fetch($sql, false);
		if(!$member_ck){
				/*휴대폰번호 분리*/
				$w_hp = $w['w_hp'];
				$hp1=substr($w_hp,0,3);
				$hp2=substr($w_hp,3,-4);
				$hp3=substr($w_hp,-4);
		}else{
				/*휴대폰번호 분리*/
				$w_hp = $w['w_hp'];
				$hp1=substr($w_hp,0,3);
				$hp2=substr($w_hp,3,-4);
				$hp3=substr($w_hp,-4);
		}
		}else if($type=="w"){
		}else{
			alert('정상적인 접근이 아닙니다.');
		}
	break;
/************************************************
인터뷰게시판 리스트
************************************************/

	case "interview_list":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		/*권한체크*/	

		$sql = "select * from mari_write where w_table = 'interview' order by w_datetime desc";
		$result = sql_query($sql);
	break;

/************************************************
인터뷰게시판 작성폼
************************************************/

	case "interview_view":

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_write_level']>$user['m_level']){
				alert('글쓰기 권한이 없습니다.');
				exit;
			}

			if($bbs_config['bo_reply_level']>$user['m_level']){
				alert('글답변 권한이 없습니다.');
				exit;
			}
		}


		if($type=="view"){
			$sql = "select * from mari_write where w_table = 'interview' and w_id = '$id'";
			$w = sql_fetch($sql);
		}else if($type=="w"){

		}
	break;

/************************************************
사용자 코멘트 쓰기(공통)
************************************************/
	case "bbs_comment":
		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_comment_level']>$user['m_level']){
				alert('코멘트쓰기 권한이 없습니다.');
				exit;
			}
		}
	break;


/************************************************
투자/대출 월수익/납입금액 계산기
************************************************/
	case "calculation":

	/*콤마제거*/
	$i_pay = (string)$i_pay;
	$i_pay = preg_replace("/[^0-9]/", "",$i_pay);
	$i_pay = (int)$i_pay;
			
	$i_loan_pay = (string)$i_loan_pay;
	$i_loan_pay = preg_replace("/[^0-9]/", "",$i_loan_pay);
	$i_loan_pay = (int)$i_loan_pay;

	if($stype=="invest"){

			/*최소투자금액설정*/
			$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
			$iv_pay = sql_fetch($sql, false);

			if($iv_pay['i_invest_mini' ] == $i_pay){
			}else if($iv_pay['i_invest_mini' ] > $i_pay){
						alert_close($iv_pay['i_invest_mini'].'원 이상만 투자하실 수 있습니다.');
						exit;
			}

			/*mypage일경우 계산및 체크하지않도록*/
			if($mtype=="mypage"){
			}else{
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
					alert_close('투자금액이 100%이상 초과하여 해당금액으로 투자가 불가능합니다.남은 투자가능 금액을 확인하신후 계산하여 주시기 바랍니다.');
				}
			}
			$ln_money=$i_pay; //투자금액 
			$ln_kigan=$i_loan_day; //대출기간 
			$ln_iyul=$i_year_plus; //대출이율 


			/*매월이율*/
			$month_eja= ($ln_iyul/100)*(1/12); 

			/*월불입금*/ 
			$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money)/( pow(1+$month_eja,$ln_kigan) - 1); 

			/*월불입금 총계*/
			$month_total=$month_money*$ln_kigan;

			/*소수점이하 제거*/
			/*월불입금*/ 
			$mh_money=ceil($month_money);
			/*월불입금 총계*/ 
			$mh_total=ceil($month_total);

			$psale_money=$mh_money-$month_profit;
			$psale_totalmoney=$mh_total-$total_profit;
			/*월불입금, 수익총계 소수점이하제거*/
			$sale_money=ceil($psale_money);
			$sale_totalmoney=ceil($psale_totalmoney);
		}else if($stype=="loan"){
			$ln_money=$i_loan_pay; //대출금액 
			$ln_kigan=$i_loan_day; //대출기간 
			$ln_iyul=$i_year_plus; //대출이율 


			/*매월이율*/
			$month_eja= ($ln_iyul/100)*(1/12); 

			/*월불입금*/ 
			$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money)/( pow(1+$month_eja,$ln_kigan) - 1); 

			/*월불입금 총계*/
			$month_total=$month_money*$ln_kigan;

			/*소수점이하 제거*/
			/*월불입금*/ 
			$mh_money=ceil($month_money);
			/*월불입금 총계*/ 
			$mh_total=ceil($month_total);

			/*월불입 수익금계산*/
			$month_profit=$mh_money*$is_ck['i_profit'];
			/*월불입 수익총계계산*/
			$total_profit=$mh_total*$is_ck['i_profit'];
			
			$psale_money=$mh_money-$month_profit;
			$psale_totalmoney=$mh_total-$total_profit;
			/*월불입금, 수익총계 소수점이하제거*/
			$sale_money=ceil($psale_money);
			$sale_totalmoney=ceil($psale_totalmoney);
		}
	break;



/************************************************
DANAL PG를이용한 가상계좌발급진행
************************************************/
	case "virtualaccount_input":
		/*다날 플러그인*/
		include_once(MARI_PLUGIN_PATH.'/pg/danal/function.php');
		
		/*주문번호생성*/
		$ORDERCODE = "bank".time().rand(111,999);

		$REQ_DATA = array();
		
		/*
		 * CP 정보
		 * CPID						: 다날에서 발급 한 CPID
		 * CPPWD					: 다날에서 발급 한 CPPWD
		 * ACCOUNTHOLDER			: 예금주 명
		 */
		$REQ_DATA["CPID"]			= $ID;
		$REQ_DATA["CPPWD"]			= $PWD;
		$REQ_DATA["ACCOUNTHOLDER"]	= $user['m_name'];
		
		/*
		 * 결제 정보
		 * AMOUNT					: 입금 요청 금액
		 * ITEMNAME					: 상품명
		 * EXPIREDATE				: 입금 마감 기한( 미 설정 시 요청일 + 10일 / 최소 D + 1 일 ~ 최대 D + 30 일 )
		 * 							  ( 데이터 형식 : YYYYMMDD / 예 : 2015년 3월 30일 설정 시 20150330 )
		 * ORDERID					: 가맹점 주문번호
		 * BYPASSVALUE				: 추가 필드 값(ex) Field1=abc;Field2=def; )
		 */	
		$REQ_DATA["AMOUNT"]			= $AMOUNT;
		$REQ_DATA["ITEMNAME"]		= "상품결제";
		$REQ_DATA["EXPIREDATE"]		= date("Ymd", strtotime(" + 10 day ") );
		$REQ_DATA["ORDERID"]		= $ORDERCODE;
		$REQ_DATA["BYPASSVALUE"]	= "Field1=abc;Field2=def";
		
		/*
		 * 고객 정보
		 * ISNOTICRYPTO				: Noti 암호화 유무(Default : Y / N)
		 * USERID					: 구매자 ID
		 * USERIP					: 구매자 접속 IP( IPv4 허용 )
		 */
		$REQ_DATA["ISNOTICRYPTO"]	= "Y";
		$REQ_DATA["USERID"]			= $user['m_id'];
		$REQ_DATA["USERIP"]			= $ip;
		
		/*
		 * URL 정보
		 * RETURNURL				: 결제 완료 시 호출 페이지( Full URL )
		 * NOTIURL					: Noti 데이터 수신 페이지 ( Full URL )
		 * CANCELURL				: 결제 취소 시 호출 페이지( Full URL )
		 */
		$REQ_DATA["CANCELURL"]		= "https://crowdbank.kr:6017/BackURL.php";
		$REQ_DATA["RETURNURL"]		= "https://www.crowdbank.kr:6017/banknloan/index.php";
		$REQ_DATA["NOTIURL"]		= "https://www.crowdbank.kr:6017/banknloan/plugin/pg/danal/Noti.php";

		/*
		 * 기본 정보
		 * TXTYPE					: "AUTH" 고정
		 * CHARSET					: Output CharSet( Default - EUC-KR / UTF-8 )
		 */
		$REQ_DATA["TXTYPE"]			= "AUTH";
		$REQ_DATA["CHARSET"]		= $CHARSET;
		
		$RES_DATA = CallTrans($REQ_DATA, false);
		
		if($RES_DATA['RETURNCODE'] == "0000"){

		echo"<form name=\"Ready\" action=\"https://web.teledit.com/Danal/VAccount/web/Start.php\" method=\"post\">";

		$IssueDate = date("YmdHis");
		$data = array();
		$data = MakeDataArray($REQ_DATA, $data, array("TXTYPE"), "", $IssueDate, false);
		$data = MakeDataArray($RES_DATA, $data, array("RETURNCODE", "RETURNMSG"), "", $IssueDate, false);
		
		/*
		 * 부가 데이터
		 * BgColor					: 결제 화면 색깔 설정( 상세 색깔 번호는 매뉴얼 참고 )
		 * IsUseCI					: 가맹점 C.I 사용 여부(Y/N)
		 * CIURL					: 가맹점 C.I 이미지 페이지 FULL URL (https 주소만 허용 / Size : 89px * 34px)
		 * ExceptBank				: 발급 화면 처리 불가 은행 설정( 구분자 : ‘:’ )
		 * USERMAIL					: 구매자 메일 주소( 입력 시 표준 발급 창 내 표기 )
		 */
		
		/*
			$data["BgColor"] 		= "";
			$data["USERMAIL"] 		= "";
			$data["IsUseCI"] 		= "N";
			$data["ExceptBank"] 	= "";
			$data["CIURL"] 			= "https://localhost/VAccount/img/CI.png";
		*/
		
		$datastr =  MakeDataString($data, array(), "", $IssueDate, true);

		/*파라메타*/
		$CPID=$REQ_DATA['CPID'];
		$CPPWD=$REQ_DATA['CPPWD'];
		$ACCOUNTHOLDER=$REQ_DATA['ACCOUNTHOLDER'];
		$ITEMNAME=$REQ_DATA['ITEMNAME'];
		$EXPIREDATE=$REQ_DATA['EXPIREDATE'];
		$USERID=$REQ_DATA['USERID'];
		$USERIP=$REQ_DATA['USERIP'];
		$RETURNURL=$REQ_DATA['RETURNURL'];
		$NOTIURL=$REQ_DATA['NOTIURL'];
		$CANCELURL=$REQ_DATA['CANCELURL'];
		$ORDERID=$REQ_DATA['ORDERID'];

		echo"
			<input type='hidden' name='mode' value='virtualaccount_out'/><!--결제결과페이지 mode-->
			<input type='hidden' name='data' value='$datastr'/><!--암호화코드-->
			<input type='hidden' name='BizNo' value='$BizNo' >
			<input type='hidden' name='Date' value='$IssueDate' >
			<input type='hidden' name='CPID' value='$CPID' ><!--CP ID -->
			<input type='hidden' name='CPPWD' value='$CPPWD' ><!--CP PWD -->
			<input type='hidden' name='ACCOUNTHOLDER' value='$ACCOUNTHOLDER' ><!--예금주명 -->
			<input type='hidden' name='AMOUNT' value='$AMOUNT' ><!--입금요청금액-->
			<input type='hidden' name='ITEMNAME' value='$ITEMNAME' ><!--상품명-->
			<input type='hidden' name='EXPIREDATE' value='$EXPIREDATE' ><!--입금마감기한-->
			<input type='hidden' name='USERID' value='$USERID' ><!--구매자아이디-->
			<input type='hidden' name='USERIP' value='$USERIP' ><!--구매자아이피-->
			<input type='hidden' name='RETURNURL' value='$RETURNURL' ><!--결제완료시호출페이지-->
			<input type='hidden' name='NOTIURL' value='$NOTIURL' ><!--데이터 수신페이지-->
			<input type='hidden' name='CANCELURL' value='$CANCELURL' ><!--결제 취소 시 호출 페이지-->
			<input type='hidden' name='ORDERID' value='$ORDERID' ><!--CP주문번호-->

			<script Language=\"JavaScript\">
				document.Ready.submit();
			</script>
		";

		} else {
			// CP 인증 에러 발생 시 가맹점 내부 처리
			// 에러 코드 : $RES_DATA["RETURNCODE"] / 에러 메시지 : $RES_DATA['RETURNMSG']
			echo "[".$RES_DATA["RETURNCODE"]."] ".$RES_DATA['RETURNMSG'];
		}
	break;






/************************************************
대출신청 new1
************************************************/
case "loan_step1":
	
	/*로그인 체크여부*/
	$login_ck="YES";

	$sql = " select * from mari_loan where m_id='$user[m_id]' and i_sep='1' and i_step3_ck='N' order by i_id desc";
	$at= sql_fetch($sql, false);
		

		/*우편번호 분리*/
		$m_zip = $user['m_zip'];
		$m_zip1=substr($m_zip,0,3);
		$m_zip2=substr($m_zip,3,3);


		/*제출가능 서류 나눔*/
		$out_paper = explode("|",$at[i_out_paper]);
		/*공통*/
		$out_paper_01 = $out_paper[0]; //신분증
		$out_paper_02 = $out_paper[1]; //등본
		$out_paper_03 = $out_paper[2]; //원초본
		$out_paper_04 = $out_paper[3]; //가족관계증명서
		$out_paper_05 = $out_paper[4]; //주거래통장
		$out_paper_06 = $out_paper[5]; //주거래통장
		$out_paper_07 = $out_paper[6]; //주거래통장
		$out_paper_08 = $out_paper[7]; //주거래통장
		$out_paper_09 = $out_paper[8]; //주거래통장
		$out_paper_10 = $out_paper[9]; //주거래통장
		$out_paper_11 = $out_paper[10]; //주거래통장

		/*성별 생년월일*/
		$sql = " select  * from  mari_member where m_id='$user[m_id]'";
		$sex = sql_fetch($sql, false);

		/*날짜 자르기*/
		$datetime=$sex['m_birth'];
		$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
		$Y_dates = date("Y", strtotime( $datetime ) );
		$M_dates = date("m", strtotime( $datetime ) );
		$D_dates = date("d", strtotime( $datetime ) );

		$birthday = "".$Y_dates."".$M_dates."".$D_dates."";
		$birthyear = date("Y", strtotime( $birthday )); //생년
		$nowyear = date("Y"); //현재년도
		$age2 = $nowyear-$birthyear+1; //한국나이
break;












/************************************************
대출신청 new3
************************************************/
case "loan_step3":
 
		
	/*로그인 체크여부*/
	$login_ck="YES";

	$sql = " select * from mari_loan where m_id='$user[m_id]' and i_sep='1' and i_step3_ck='N' order by i_id desc";
	$at3= sql_fetch($sql, false);

	/*부체내역*/
	$sql = "select  * from  mari_debt where m_id='".$user[m_id]."' limit 1";
	$deb = sql_fetch($sql, false);

 
break;





	/************************************************
대출신청 new2
************************************************/
	case "loan_step2":

	/*로그인 체크여부*/
	$login_ck="YES";

	$sql = " select * from mari_loan where m_id='$user[m_id]' and i_sep='1' and i_step3_ck='N' order by i_id desc";
	$at2= sql_fetch($sql, false);


	$sql = "select  * from  mari_category where ca_num='1' order by ca_subject asc";
	$cate1 = sql_query($sql, false);

	
		if($type=="o"){
		}else if($type=="y"){
			if($bbs_config['bo_comment_level']>$user['m_level']){
				alert('코멘트쓰기 권한이 없습니다.');
				exit;
		}else{
		}
	}
	break;


/************************************************
출금신청
************************************************/
	case "withdrawl":
		if($user['m_verifyaccountuse']=="Y"){
		}else{
			alert('계좌주 검증후 이용하실 수 있습니다. 마이페이지>계좌검증을 눌러 검증을 진행하여 주십시오.', MARI_HOME_URL.'/?mode=mypage');
		}


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq."&refId=".$g_code."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);


/*
						print_r($requestPath_lnq);
						echo"<br/><br/>";
						print_r($result_lnq);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_lnq);


						echo"<br/><br/>데이터";
						print_r($decode_lnq);
						echo"<br/><br/>";
*/

				}


	break;



/************************************************
출금신청
************************************************/
	case "mypage_withdrawal":
		if($user['m_verifyaccountuse']=="Y"){
		}else{
			alert('계좌주 검증후 이용하실 수 있습니다. 마이페이지>계좌검증을 눌러 검증을 진행하여 주십시오.', MARI_HOME_URL.'/?mode=mypage');
		}


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq."&refId=".$g_code."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);


/*
						print_r($requestPath_lnq);
						echo"<br/><br/>";
						print_r($result_lnq);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_lnq);


						echo"<br/><br/>데이터";
						print_r($decode_lnq);
						echo"<br/><br/>";
*/

				}


	break;


/************************************************
임시 비밀번호 발급
************************************************/


	case "login":

		$sql = " select * from mari_member where m_id='".$m_id."'";
		$mailck = sql_fetch($sql, false);

		$m_pwcertify = hash('sha256',$chpassword);

			/*패스워드 일치검사*/
			if($mailck[m_pwcertify]==$m_pwcertify){

				/*일치할 경우 임시비밀번호로 변경처리*/
				$sql="update mari_member
							set m_password ='".$m_pwcertify."'
							where m_id = '".$m_id."'
						";
				sql_query($sql);

			}

		$url = $_GET['url'];

		$p = parse_url($url);
		if ((isset($p['scheme']) && $p['scheme']) || (isset($p['host']) && $p['host'])) {
			//print_r2($p);
			if ($p['host'].(isset($p['port']) ? ':'.$p['port'] : '') != $_SERVER['HTTP_HOST'])
				alert('url에 타 도메인을 지정할 수 없습니다.');
		}

		// 이미 로그인 중이라면
		if ($member_ck) {
			if ($url)
				goto_url($url);
			else
				goto_url(MARI_HOME_URL.'/?mode=main');
		}

		$login_url        = login_url($url);
		$login_action_url = MARI_HOME_URL."/?mode=login_ck";


	break;

/************************************************
json 데이터제공 1.투모다
************************************************/


	case "invest_json":


		/*대출건수구하기*/
		$sql = " select count(*) as cnt from mari_loan where i_view='Y'";
		$laons_result = sql_fetch($sql);
		$total_result= $laons_result['cnt'];

		$sql = " select * from mari_loan where i_view='Y'  order by i_id desc";
		$result = sql_query($sql, false);

	break;



/************************************************
대출정보 마이페이지(170201동욱)
************************************************/
	case "mypage_loan_manage":
		
		//상환정보
		$sql = "select * from mari_pg";
		$pg = sql_fetch($sql);

		//대출금액합산
		$sql="select sum(i_loan_pay) from mari_loan where m_id = '$user[m_id]'"; 
		$l_pay=sql_query($sql, false);
		$total_loan_pay = mysql_result($l_pay, 0, 0);
		
		//대출횟수 카운트
		$sql = "select count(*) as cnt from mari_loan where m_id = '$user[m_id]'";
		$l_cnt = sql_fetch($sql);
		$total_loan_cnt = $l_cnt['cnt'];
		
		//연체금액합산
		$sql="select sum(o_odinterest) from mari_order where user_id = '$user[m_id]' and o_status = '연체중' "; 
		$over_pay=sql_query($sql, false);
		$total_over_pay = mysql_result($over_pay, 0, 0);

		//대출상환금액합산
		$sql="select sum(o_ln_money_to) from mari_order where user_id='$user[m_id]' and o_status='입금완료'"; 
		$lb_pay=sql_query($sql, false);
		$total_lb_pay = mysql_result($lb_pay, 0, 0);

		//잔여상환금
		$sql = "select sum(o_mh_money) from mari_order  where user_id='$user[m_id]' and o_status='연체'";
		$ld_pay = sql_query($sql, false);
		$total_ld_pay = mysql_result($ld_pay, 0, 0);

		$sql = "select * from mari_order where user_id = '$user[m_id]'  group by loan_id, o_count order by o_id desc";
		$order_list = sql_query($sql);

	break;


/************************************************************************
step2 상환스케쥴>메인>상환스케쥴리스트 2017-02-01 전체업데이트예정
************************************************************************/

	case "mypage_loan_schedule":

		/*로그인 체크여부*/
		$login_ck="YES";

		/*대출자가 대출신청한 대출건가져오기*/
		/*
		$sql = " select * from mari_loan where m_id='$user[m_id]'";
		$myloanlist = sql_query($sql, false);
		*/
		$sql = " select * from mari_repay_schedule";
		$scdlist = sql_query($sql, false);
		/*투자자 투자한 대출건가져오기*/
		$sql = "select * from mari_pg";
		$pg = sql_fetch($sql);

	break;

/************************************************************************
step3 상환스케쥴>메인>상환스케쥴상세 2017-02-01 전체업데이트예정
************************************************************************/

	case "mypage_loan_schedule_more":

		/*로그인 체크여부*/
		$login_ck="YES";

		/*대출자가 대출신청한 대출건가져오기*/
		/*
		$sql = " select * from mari_loan where m_id='$user[m_id]'";
		$myloanlist = sql_query($sql, false);
		*/
		$sql = " select * from mari_repay_schedule";
		$scdlist = sql_query($sql, false);
		/*투자자 투자한 대출건가져오기*/

		$sql = "select * from mari_pg";
		$pg = sql_fetch($sql);

	break;


/****************************************************
MYPAGE SMS 알림메세지내역 2017-02-08 임근호
****************************************************/

	case "mypage_alert":

		$sql = " select * from mari_push_msg where m_id='".$user[m_id]."'  order by pm_redatetime desc";
		$push_list = sql_query($sql, false);

	break;

/****************************************************
투자지수그래프 2017-02-20 강동욱
****************************************************/

	case "invest_new":

		//누적투자건
		$sql = "select count(*) as cnt from mari_invest";
		$acc_iv_cnt = sql_fetch($sql);
		$acc_iv_total = $acc_iv_cnt['cnt'];

		//누적투자자수
		$sql = "select count(distinct m_id) as cnt from mari_invest";
		$acc_iv_mem = sql_fetch($sql);
		$acc_iv_mem_total = $acc_iv_mem['cnt'];

		//누적투자금액
		$sql="select sum(i_pay) from mari_invest"; 
		$acc_iv_pay=sql_query($sql, false);
		$acc_iv_pay_total = mysql_result($acc_iv_pay, 0, 0);

		//평균투자금액(인당)
		$sql = "select m_id from mari_invest group by m_id";
		$acc_iv_avg = sql_query($sql);
		for($i=0; $row=sql_fetch_array($acc_iv_avg); $i++){
			//개인별 투자건수
			$sql = "select count(m_id) as cnt from mari_invest where m_id = '$row[m_id]'";
			$iv_avg_cnt = sql_fetch($sql);
			$iv_avg_total = $iv_avg_cnt['cnt'];

			//개인별 투자금액 합산
			$sql = "select sum(i_pay) from mari_invest where m_id = '$row[m_id]'";
			$iv_pay_avg = sql_query($sql, false);
			$iv_pay_avg_sum = mysql_result($iv_pay_avg, 0, 0);
			
			//개인별 평균투자금액
			$iv_avg_indi = $iv_pay_avg_sum / $iv_avg_total;
			
			//개인별 평균투자금액 합산
			$iv_avg_sum += $iv_avg_indi;
		}
		//평균투자금액(인당) = 개인별 평균투자금액 합산 / 투자자수
		//$iv_avg_total_res = $iv_avg_sum / $acc_iv_mem_total;
		
		$iv_avg_total_res = $iv_avg_sum / $acc_iv_mem_total;
		//누적대출건수
		$sql = "select count(*) as cnt from mari_loan";
		$acc_loa_cnt = sql_fetch($sql);
		$acc_loa_total = $acc_loa_cnt['cnt'];

		//평균투자금액(건당)
		$sql = "select * from mari_invest group by loan_id";
		$acc_iv_avg_pdt = sql_query($sql);
		for($j=0; $row=sql_fetch_array($acc_iv_avg_pdt); $j++){
			//상품별 투자건수
			$sql = "select count(*) as cnt from mari_invest where loan_id = '$row[loan_id]'";
			$iv_pdt_cnt = sql_fetch($sql);
			$iv_pdt_total = $iv_pdt_cnt['cnt'];

			//상품별 투자금액 합산
			$sql = "select sum(i_pay) from mari_invest where loan_id = '$row[loan_id]'";
			$iv_pdt_pay = sql_query($sql, false);
			$iv_pdt_sum = mysql_result($iv_pdt_pay, 0, 0);
			
			//상품별 평균투자금액
			$iv_avg_pdt = $iv_pdt_sum / $iv_pdt_total;
			
			//상품별 평균투자금액 합산
			$iv_avg_pdt_sum += $iv_avg_pdt;
		}
		//평균투자금액(건수) = 상품별투자금액합산 / 대출건수
		$iv_pdt_avg_res = $iv_avg_pdt_sum / $acc_loa_total;

		
		//수익률 합산
		$sql = "select sum(i_year_plus) from mari_loan";
		$profit_sum = sql_query($sql, false);
		$profit_total = mysql_result($profit_sum, 0, 0);
		
		//평균수익률 = 수익률합산 / 누적대출건
		$profit_avg = $profit_total / $acc_loa_total;

		//누적대출자수
		$sql = "select count(distinct m_id) as cnt from mari_loan";
		$acc_loa_mem = sql_fetch($sql);
		$acc_loa_mem_total = $acc_loa_mem['cnt'];

		//누적대출금액
		$sql = "select sum(i_loan_pay) from mari_loan";
		$loa_pay_sum = sql_query($sql, false);
		$loa_pay_total = mysql_result($loa_pay_sum, 0, 0);

		//누적상환금액
		$sql="select sum(o_investamount) from mari_order where o_status='입금완료'"; 
		$repay_sum=sql_query($sql, false);
		$repay_total = mysql_result($repay_sum, 0, 0);

		//대출상환률
		$repay_per = $repay_total / $acc_loa_total * 100;

		//대출승인건수
		$sql = "select count(i_id) as cnt from mari_loan where i_loanapproval = 'Y'";
		$agree_loa = sql_fetch($sql);
		$agree_total = $agree_loa['cnt'];
		
		//대출승인률 = (승인건수 / 대출건수) * 100
		$agree_per = ($agree_total / $acc_loa_total) * 100;
		
		//펀딩마감 상품건수
		$sql = "select count(i_id) as cnt from mari_loan where i_look = 'C'";
		$end_loa_cnt = sql_fetch($sql);
		$end_loa_total = $end_loa_cnt['cnt'];

		//상환중인 상품건수
		$sql = "select count(i_id) as cnt from mari_loan where i_look = 'D'";
		$doing_loa_cnt = sql_fetch($sql);
		$doing_loa_total = $doing_loa_cnt['cnt'];

		//상환완료된 상품건수
		$sql = "select count(i_id) as cnt from mari_loan where i_look = 'F'";
		$finish_loa_cnt = sql_fetch($sql);
		$finish_loa_total = $finish_loa_cnt['cnt'];
		
		//투자자연령비율(20대)
		$sql = "select * from mari_invest group by m_id";
		$age_per = sql_query($sql);

		for($i=0; $row=sql_fetch_array($age_per); $i++){
			$sql = "select * from mari_member where m_id = '$row[m_id]' and (m_birth < '1999-01-01' and m_birth >= '1989-01-01')";
			$age_20th = sql_fetch($sql);
			//20대 카운트
			if($age_20th[m_id]){
				$age_20th_cnt++;
			}

			$sql = "select * from mari_member where m_id = '$row[m_id]' and (m_birth < '1989-01-01' and m_birth >= '1979-01-01')";
			$age_30th = sql_fetch($sql);
			//30대 카운트
			if($age_30th[m_id]){
				$age_30th_cnt++;
			}
			
			$sql = "select * from mari_member where m_id = '$row[m_id]' and (m_birth < '1979-01-01' and m_birth >= '1969-01-01')";
			$age_40th = sql_fetch($sql);
			//40대 카운트
			if($age_40th[m_id]){
				$age_40th_cnt++;
			}

			
			$sql = "select * from mari_member where m_id = '$row[m_id]' and (m_birth < '1969-01-01' and m_birth >= '1959-01-01')";
			$age_50th = sql_fetch($sql);
			//50대 카운트
			if($age_50th[m_id]){
				$age_50th_cnt++;
			}

			$sql = "select * from mari_member where m_id = '$row[m_id]' and (m_birth < '1959-01-01' and m_birth >= '1949-01-01')";
			$age_60th = sql_fetch($sql);
			//60대 카운트
			if($age_60th[m_id]){
				$age_60th_cnt++;
			}							
		}
		
		$age_20th_per =  floor(($age_20th_cnt / $acc_iv_mem_total) * 100);
		$age_30th_per =  floor(($age_30th_cnt / $acc_iv_mem_total) * 100);
		$age_40th_per =  floor(($age_40th_cnt / $acc_iv_mem_total) * 100);
		$age_50th_per =  floor(($age_50th_cnt / $acc_iv_mem_total) * 100);
		$age_60th_per =  floor(($age_60th_cnt / $acc_iv_mem_total) * 100);

		//투자수익지수 비율
		$sql = "select count(o_id) as cnt from mari_order";
		$order_cnt = sql_fetch($sql);
		$order_total_cnt = $order_cnt['cnt'];
		
		//투자수익금액 100이상 200이하 카운트 (단위 : 만원)
		$sql = "select count(*) as cnt from mari_order where (o_mh_money >= 1000000 and o_mh_money < 2000000)";
		$profits_cnt_1 = sql_fetch($sql);

		//투자수익금액 200이상 300이하 카운트 (단위 : 만원)
		$sql = "select count(*) as cnt from mari_order where (o_mh_money >= 2000000 and o_mh_money < 3000000)";
		$profits_cnt_2 = sql_fetch($sql);

		//투자수익금액 300이상 500이하 카운트 (단위 : 만원)
		$sql = "select count(*) as cnt from mari_order where (o_mh_money >= 3000000 and o_mh_money < 5000000)";
		$profits_cnt_3 = sql_fetch($sql);

		//투자수익금액 500이상 카운트 (단위 : 만원)
		$sql = "select count(*) as cnt from mari_order where (o_mh_money >= 5000000)";
		$profits_cnt_4 = sql_fetch($sql);

		$profits_1 = ($profits_cnt_1['cnt'] / $order_total_cnt) * 100; 
		$profits_2 = ($profits_cnt_2['cnt'] / $order_total_cnt) * 100; 
		$profits_3 = ($profits_cnt_3['cnt'] / $order_total_cnt) * 100; 
		$profits_4 = ($profits_cnt_4['cnt'] / $order_total_cnt) * 100; 
		
		/*대시보드 날짜검색*/
		if($searchlogs=="Y"){
			$ltimetoday = "".$loydate."-".$lomdate."-".$loddate."";
			$logdate = $ltimetoday; 
			$baklogdate=date("Y-m-d", strtotime($ltimetoday."-1day"));
		}else{
			$logM = date("m", $timetoday);
			$logD = date("d", $timetoday);
		}

		/*해당월 마지막날짜 구하기*/
		$jinday_count = date('t', strtotime("".$logdate.""));

		/*금일 방문자수*/
		$sql = "select * from  mari_log_sum where ls_date='".$logdate."'";
		$logsum = sql_fetch($sql, false);

		/*전일 방문자수*/
		$sql = "select * from  mari_log_sum where ls_date='".$baklogdate."'";
		$logsum_b = sql_fetch($sql, false);

		/*전일대비 투자건수 비교*/
		if(!$logsum_b['ls_count']){
			$daysum="0";
		}else{
			$daysum=floor($logsum['ls_count']/$logsum_b['ls_count']*100);
		}



		if(!$Year || $Year==""){$Year = date("Y");}
		if(!$Month || $Month==""){$Month = date("m");}
		if(!$Day || $Day==""){$Day = date("d");}
		$maxDate = date("t",strtotime($Year."-01-01"));

	break;

/************************************************
자동투자 신청 170308 -동욱-
************************************************/

	case "mypage_auto_invest_apply":

		$sql = "select * from mari_auto_info where m_id = '$user[m_id]'";
		$auto = sql_fetch($sql);

		/*모집금액*/
		$rec_pay = explode("|",$auto[au_rec_pay]);

		$rec_pay_01 = $rec_pay[0]; //1순위
		$rec_pay_02 = $rec_pay[1]; //2순위
		$rec_pay_03 = $rec_pay[2]; //3순위

		/*모집기간*/
		$term = explode("|",$auto[au_term]);

		$term_01 = $term[0]; //1순위
		$term_02 = $term[1]; //2순위
		$term_03 = $term[2]; //3순위

		/*이자지급방식*/
		$give_way = explode("|",$auto[au_give_way]);

		$give_way_01 = $give_way[0]; //1순위
		$give_way_02 = $give_way[1]; //2순위
		$give_way_03 = $give_way[2]; //3순위

		/*포트폴리오*/
		$portfolio = explode("|",$auto[au_portfolio]);

		$portfolio_01 = $portfolio[0]; //1순위
		$portfolio_02 = $portfolio[1]; //2순위
		$portfolio_03 = $portfolio[2]; //3순위

		/*자체평가등급*/
		$grade = explode("|",$auto[au_grade]);

		$grade_01 = $grade[0]; //1순위
		$grade_02 = $grade[1]; //2순위
		$grade_03 = $grade[2]; //3순위

		/*투자상품*/
		$product = explode("|",$auto[au_product]);

		$product_01 = $product[0]; //1순위
		$product_02 = $product[1]; //2순위
		$product_03 = $product[2]; //3순위

	break;

/************************************************
자동투자정보 팝업 170308 -동욱-
************************************************/

	case "mypage_auto_invest_info_pop":

		$sql = "select * from mari_auto_info where m_id = '$user[m_id]'";
		$auto = sql_fetch($sql);

		/*모집금액*/
		$rec_pay = explode("|",$auto[au_rec_pay]);

		$rec_pay_01 = $rec_pay[0]; //1순위
		$rec_pay_02 = $rec_pay[1]; //2순위
		$rec_pay_03 = $rec_pay[2]; //3순위

		/*모집기간*/
		$term = explode("|",$auto[au_term]);

		$term_01 = $term[0]; //1순위
		$term_02 = $term[1]; //2순위
		$term_03 = $term[2]; //3순위

		/*이자지급방식*/
		$give_way = explode("|",$auto[au_give_way]);

		$give_way_01 = $give_way[0]; //1순위
		$give_way_02 = $give_way[1]; //2순위
		$give_way_03 = $give_way[2]; //3순위

		/*포트폴리오*/
		$portfolio = explode("|",$auto[au_portfolio]);

		$portfolio_01 = $portfolio[0]; //1순위
		$portfolio_02 = $portfolio[1]; //2순위
		$portfolio_03 = $portfolio[2]; //3순위

		/*자체평가등급*/
		$grade = explode("|",$auto[au_grade]);

		$grade_01 = $grade[0]; //1순위
		$grade_02 = $grade[1]; //2순위
		$grade_03 = $grade[2]; //3순위

		/*투자상품*/
		$product = explode("|",$auto[au_product]);

		$product_01 = $product[0]; //1순위
		$product_02 = $product[1]; //2순위
		$product_03 = $product[2]; //3순위

	break;

}//switch

/*사용자 로그인체크*/
if(!$member_ck){
	if($cms=="admin"){
		goto_url(MARI_HOME_URL.'/?cms=admin_login');
	}else if($login_ck=="YES"){
		alert('로그인 후 이용하실 수 있습니다.', MARI_HOME_URL.'/?mode=login&url=' . urlencode($_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING']));
	}
}
/*세션만 남아있을경우 로그인해제*/
if($session=="ck"){
}else{
	if($member_ck){
		if(!$member_ck){
			alert('세션이 만료 되었습니다. 다시 로그인 하여주십시오.', MARI_HOME_URL.'/?mode=logout&session=ck');
		}
	}
}



/*********************************************************************************
ADMIN SELECT START
**********************************************************************************/
/*ADMIN 로그인 페이지 제외*/
if($cms=="admin_login"){
}else{
	if(!$cms==""){
		// 관리자인지 검사
		if (!$member_ck){
			if($cms=="admin"){
				goto_url(MARI_HOME_URL.'/?cms=admin_login&m_id='.$m_id.'');
			}else{
				alert('로그인후 이용하실 수 있습니다.', MARI_HOME_URL.'/?mode=login&url=' . urlencode($_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING']));
			}
		}else if ($member_ck==$config['c_admin'] || $member_ck=="$SuperAdministrator" || $member_ck=="bethel" || $member_ck=="intowin" || $member_ck==$admin_ck[m_id] || $member_ck){
		/*관리자 권한체크 imwork접속이슈 2017-10-24 추가 start*/
			$sql = " select m_id from mari_authority where m_id='".$member_ck."'";
			$adminck = sql_fetch($sql, false);
			if(!$adminck['m_id']){
				if($member_ck=="$SuperAdministrator" || $table){
				}else{
					alert('관리자만 접근이 가능합니다.', MARI_HOME_URL.'/?mode=login');
				}
			}
			/*관리자 권한체크 imwork접속이슈 2017-10-24 추가 end*/
		}else{
				alert('관리자만 접근이 가능합니다.', MARI_HOME_URL.'/?mode=login');
		}
	}
}
switch ($cms){


/************************************************
ADMIN MAINPAGE
************************************************/

	case "admin":
		/*신규회원가입목록*/
		$sql = "select  m_no, m_id, m_name, m_nick, m_level, m_emoney, m_intercept_date from  mari_member order by m_datetime desc, m_name asc limit 7";
		$new_member = sql_query($sql, false);

		/*신규 게시물목록*/
		$sql = "select  w_id, w_table, w_subject from  mari_write order by w_datetime desc, w_subject asc limit 5";
		$new_board = sql_query($sql, false);
		/*생성된 게시판*/
		$sql = " select  bo_table, bo_subject from  mari_board order by bo_subject asc";
		$all_bbs = sql_query($sql, false);
		/*서비스정보*/
		$sql = " select  * from mari_mysevice_config";
		$mysv = sql_fetch($sql, false);
		/*스위치 start*/
		/*pg사용여부*/
		$sql = "select  i_pg_use from  mari_pg";
		$pg = sql_fetch($sql, false);
		/*페이스북 로그인, SMS, I-PIN, 휴대폰인증 사용여부*/
		$sql = "select  c_facebooklogin_use, c_sms_use, c_cert_ipin, c_cert_use, c_nice_use from  mari_config";
		$qsw = sql_fetch($sql, false);



		if (empty($s_date)) $s_date = MARI_TIME_YMD;
		if (empty($e_date)) $e_date = MARI_TIME_YMD;

		$sqlstr = "s_date=".$s_date."&amp;e_date=".$e_date;
		$sql_string = $sqlstr ? '?'.$sqlstr : '';

		$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')), 1, intval(date('Y'))  ));
		$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))  ));
		$max = 0;
		$sum_count = 0;
		$sql = " select ls_date, ls_count as cnt
					from mari_log_sum
					where ls_date between '$s_date' and '$e_date'
					order by ls_date desc ";
		$result = sql_query($sql);

		for ($i=0; $row=sql_fetch_array($result); $i++) {
			$arr[$row['ls_date']] = $row['cnt'];

			if ($row['cnt'] > $max) $max = $row['cnt'];

			$sum_count += $row['cnt'];
		}

		/*전체회원 구하기*/
		$sql = " select count(*) as cnt from mari_log where lo_date between '$s_date' and '$e_date'";
		$incn = sql_fetch($sql, false);
		$logtop_cn = $incn['cnt'];

		/*비회원 구하기*/
		$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
		$incn = sql_fetch($sql, false);
		$lognon_cn = $incn['cnt'];
		/*회원접속구하기*/
		$mem_con=$logtop_cn-$lognon_cn;
		
		/*플레이플랫폼 연결
		include_once(MARI_SQL_PATH.'/master_connect.php');
		
		$sql = "select * from mari_write where w_table = 'notice' order by w_datetime desc";
		$noti = mysql_query($sql);
		*/
	break;


/************************************************
게시판 리스트
************************************************/
	case "user_board_list":


		$sql_common = " from mari_write ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}



		if (!$sst) {
			$sst = "w_id";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search and (w_table='$table') $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search and (w_table='$table') $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;
	break;


/************************************************
게시판 작성폼
************************************************/
	case "user_board_form":
		if($type=="m"){
		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		$sql = " select  * from  mari_write  where w_table='$table' and w_id='$id'";
		$w = sql_fetch($sql, false);

		/*휴대폰번호 분리*/
		$w_hp = $w['w_hp'];
		$hp1=substr($w_hp,0,3);
		$hp2=substr($w_hp,3,-4);
		$hp3=substr($w_hp,-4);
		}
	break;


/************************************************
게시판설정 작성폼
************************************************/

	case "board_form":
		$sql = " select  * from  mari_board  where bo_table='$table'";
		$bo = sql_fetch($sql, false);

		$sql = " select  * from  mari_board_group order by gr_subject asc ";
		$gr_view = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_01 = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_02 = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_03 = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_04 = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_05 = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level asc";
		$lv_06 = sql_query($sql, false);

		/*게시글수 구하기*/
		$sql = " select count(*) as cnt from mari_board where bo_table='$table'";
		$boardcn = sql_fetch($sql, false);
		$board_count = $boardcn['cnt'];
	break;



/************************************************
게시판설정 리스트
************************************************/

	case "board_list":
		$sql = " select  * from  mari_board";
		$board = sql_fetch($sql, false);

		$sql_common = " from mari_board ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}



		if (!$sst) {
			$sst = "bo_subject";
			$sod = "asc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];

		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;
	break;


/************************************************
게시판 그룹 작성폼
************************************************/

	case "boardgroup_form":
		$sql = " select  * from  mari_board_group  where gr_id='$gr_id'";
		$gro = sql_fetch($sql, false);
	break;


/************************************************
게시판 그룹 리스트
************************************************/
	case "boardgroup_list":

		$sql = " select  * from  mari_board_group";
		$group = sql_fetch($sql, false);

		$sql_common = " from mari_board_group ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}


		if (!$sst) {
			$sst = "gr_subject";
			$sod = "asc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$grolist = sql_query($sql, false);

		$colspan = 16;
	break;







/************************************************
회원 리스트 
************************************************/

	case "member_list":
		
		/*접근권한
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);*/
		if($au[au_member]=='1' && $au_member_sub01 == '1'){
		
	
		$sql_common = " from mari_member ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '%$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "m_datetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		//탈퇴회원수
		$sql = "select count(*) as cnt from mari_member_leave";
		$cnt_leave = sql_fetch($sql);
		$leave_count = $cnt_leave['cnt'];

		//차단회원수
		$sql = "select count(*) as cnt from mari_member $sql_search and m_intercept_date='' ";
		$cnt_cut = sql_fetch($sql);
		$intercept_count = $cnt_cut['cnt'];


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		/*회원넘버링*/
		$sql = "select count(*) as cnt from mari_member";
		$m_cnt = sql_fetch($sql);
		$total_member = $m_cnt['cnt'];

		

		}else{
			alert('접근권한이 없습니다.','?cms=admin');
		}
	break;

/************************************************
탈퇴회원 리스트
************************************************/

	case "leave_list":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1' && $au_member_sub03 == '3'){
		
		$sql_common = " from mari_member_leave ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "s_leave_date";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		}else{
			alert('접근권한이 없습니다.','?cms=admin');
		}
	break;



/************************************************
e-머니 리스트
************************************************/

	case "emoney_list":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1' && $au_member_sub04 == '4'){

		$sql_common = " from mari_emoney ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "p_datetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		/*포인트합계구하기*/
		$sql="select sum(p_emoney) from mari_emoney;"; 
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);

		}else{
			alert('접근권한이 없습니다.','?cms=admin');
		}
	break;


/************************************************
회원수정폼 
************************************************/

	case "member_form":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1'  && $au_member_sub01 == '1'){

		$sql = " select  * from  mari_member  where m_no='$m_no'";
		$mem = sql_fetch($sql, false);

		$sql = "select  * from  mari_level order by lv_level desc";
		$lv = sql_query($sql, false);

		/*휴대폰번호 분리*/
		$m_hp = $mem['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);

		/*전화번호 분리*/
		$m_tel = $mem['m_tel'];		
		if(substr($m_tel,0,2)=="02"){
			$tel1=substr($m_tel,0,2);
			$tel2=substr($m_tel,2,4);
			$tel3=substr($m_tel,-4);
		}else{
			$tel1=substr($m_tel,0,3);
			$tel2=substr($m_tel,3,-4);
			$tel3=substr($m_tel,-4);
		}


		/*우편번호 분리*/
		$m_zip = $mem['m_zip'];
		$m_zip1=substr($m_zip,0,3);
		$m_zip2=substr($m_zip,3,3);

		/*생년월일*/
		$m_birth = explode("-",$mem[m_birth]);
		$m_birth1 = $m_birth[0]; //생년
		$m_birth2 = $m_birth[1]; //월
		$m_birth3 = $m_birth[2]; //일


		/*누적투자금액(입찰후 결제완료 합계구하기)*/
		$sql="select sum(i_pay) from mari_invest where m_id='$mem[m_id]'"; 
		$top=sql_query($sql, false);
		$order_pay = mysql_result($top, 0, 0);

		/*누적대출금액*/
		$sql="select sum(i_loan_pay) from mari_loan where m_id='$mem[m_id]'"; 
		$la_top=sql_query($sql, false);
		$loan_pay = mysql_result($la_top, 0, 0);
		}else{
			alert('접근권한이 없습니다.', '?cms=admin');
		}

	break;

/************************************************
나의 서비스정보
************************************************/
	case "service_config":
		$sql = " select  * from mari_mysevice_config ";
		$sv = sql_fetch($sql, false);
	break;


	case "member_grade":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1'  && $au_member_sub02 == '2'){

		$sql = "select  * from  mari_level order by lv_level desc";
		$lv = sql_query($sql, false);
		}else{
			alert('접근권한이 없습니다.');
		}

		/*신규,수정*/
		$sql = "select  * from  mari_level where lv_id='$lv_id'";
		$lv_m = sql_fetch($sql, false);
	break;

/************************************************
SMS 예약발송리스트
************************************************/

	case "reservation_send":
		$sql = "select * from mari_sms_send order by sms_datetime desc";
		$send = sql_query($sql, false);

		$sql = "select  * from  mari_level order by lv_level desc";
		$lv = sql_query($sql, false);
	break;



/************************************************
발송메일 리스트
************************************************/

	case "mail_list":

		$sql_common = " from mari_mail ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "mr_sentime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;
	break;
	
	case "mail_form":

		$sql = " select  * from  mari_mail  where mr_id='$mr_id'";
		$mv = sql_fetch($sql, false);

	break;
 


/************************************************
신용 대출신청 리스트
************************************************/
	case "loan_list":
	
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_loan]=='1' && $au_loan_sub01 =='1'){
			
		$sql_common = " from mari_loan ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "i_id";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";


		
		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		

		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
			$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
			$result = sql_query($sql);

		$sql = "select  * from  mari_category where ca_num='1' order by ca_subject asc";
		$cate1 = sql_query($sql, false);

		$colspan = 16;

		}else{
			alert('접근권한이 없습니다.'); 
		}
	break;



/************************************************
대출신청 폼
************************************************/
	case "loan_form":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_loan]=='1' && $au_loan_sub01 == '1'){

		$sql = "select  * from  mari_loan where i_id='$i_id'";
		$loa = sql_fetch($sql, false);

		/*제출가능 서류 나눔*/
		$out_paper = explode("|",$loa[i_out_paper]);
		/*공통*/
		$out_paper_01 = $out_paper[0]; //신분증
		$out_paper_02 = $out_paper[1]; //등본
		$out_paper_03 = $out_paper[2]; //원초본
		$out_paper_04 = $out_paper[3]; //가족관계증명서
		$out_paper_05 = $out_paper[4]; //주거래통장
		/*소득서류*/
		$out_paper_06 = $out_paper[5]; //원천징수영수증
		$out_paper_07 = $out_paper[6]; //각종근로소득세
		$out_paper_08 = $out_paper[7]; //직장의료보험 납부확인서
		$out_paper_09 = $out_paper[8]; //급여통장 거래내역서
		/*재직서류*/
		$out_paper_10 = $out_paper[9]; //재직증명서
		$out_paper_11 = $out_paper[10]; //직작의료보험 자격득실확인서


		/*소득서류&제직서류*/
		$ppdocuments = explode("|",$loa[i_ppdocuments]);
		/*소득서류*/
		$ppdocuments_01 = $ppdocuments[0]; //부가가치세과세표준증명
		$ppdocuments_02 = $ppdocuments[1]; //소득금액증명원
		$ppdocuments_03 = $ppdocuments[2]; //지역의료보험
		$ppdocuments_04 = $ppdocuments[3]; //카드매출내역
		/*재직서류*/
		$ppdocuments_05 = $ppdocuments[4]; //사업자등록증
		$ppdocuments_06 = $ppdocuments[6]; //각종허가증


		/*부체내역*/
		$sql = "select  * from  mari_debt where m_id='".$loa[m_id]."' limit 1";
		$deb = sql_fetch($sql, false);


		$ln_money=$loa['i_loan_pay']; //대출금액 
	if($loa['i_repay']=="만기일시상환선취"){
		$ln_kigan=$loa['i_loan_day']+1; //대출기간 
	}else{
		$ln_kigan=$loa['i_loan_day']; //대출기간 
	}
		$ln_iyul=$loa['i_year_plus']; //대출이율 

		if($type=="m"){
		/*매월이율*/
		$month_eja= ($ln_iyul/100)*(1/12); 

		/*월불입금*/ 
		$month_money = floor($month_eja * pow(1+$month_eja,$ln_kigan) * $ln_money )/( pow(1+$month_eja,$ln_kigan) - 1); 

		/*월불입금 총계*/
		$month_total=$month_money*$loa['i_loan_day'];

		/*총이자금액*/ 
		//q *12-p0 = {12*r*(1+r)^12/[(1+r)^12-1]-1} * p0 
			//매달내야하는금액 * 12 - 대출원금 = {12*월이율*(1+월이율)^12/[(1+월이율)^12-1]-1} * 대출원금 
		//($month_money*12)-$ln_money = ( (12*$month_eja*pow(1+$month_eja,12)) / ((pow(1+$month_eja,12)-1)) -1) * $ln_money; 
		$all_eja = ( (12 * $month_eja * pow(1+$month_eja,12) ) / ( (pow(1+$month_eja,12) -1)) -1 ) * $ln_money; 
		
		$ln_type=$loa['i_loan_type']; //대출금액 

		/*소수점이하 제거*/
		/*월불입금*/ 
		$mh_money=floor($month_money);
		/*월불입금 총계*/ 
		$mh_total=floor($month_total);
		}

		$sql = "select  * from  mari_category where ca_num='1' order by ca_subject asc";
		$cate1 = sql_query($sql, false);
		$sql = "select  * from  mari_category where ca_num='2' order by ca_subject asc";
		$cate2 = sql_query($sql, false);
		$sql = "select  * from  mari_category where ca_num='3' order by ca_subject asc";
		$cate3 = sql_query($sql, false);

		/*휴대폰번호 분리*/
		$m_hp = $loa['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);

		}else{
			alert('접근권한이 없습니다.');
		}
	break;
	



	/*부채내역*/
	case "loan_form_debt":
		$sql = "select  * from  mari_debt order by ";
		$deb = sql_query($sql, false);
	break;

/************************************************
투자진행 상품추가폼
************************************************/
	case "product_add_pop":
		$sql = " select  * from  mari_contact_item ";
		$result = sql_query($sql, false);

		/*신규,수정*/
		$sql = " select  * from  mari_contact_item where it_id='$it_id'";
		$it_view = sql_fetch($sql, false);
	break;


/************************************************
투자진행 폼
************************************************/
	case "invest_setup_form":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if(($au[au_loan]=='1' && $au_loan_sub02 == '2') || ($au[au_invest]=='1' && $au_invest_sub01 == '1')){

		$sql = "select  * from  mari_invest_progress where loan_id='$loan_id'";
		$iv = sql_fetch($sql, false);
		/*대출정보*/
		$sql = "select  i_id, i_loan_pay, i_payment,i_year_plus, i_level_dti, i_subject, m_id, i_creditpoint_two, i_creditpoint_one, ca_id from  mari_loan where i_id='$loan_id'";
		$loan = sql_fetch($sql, false);

		/*투자인원 구하기*/
		$sql = " select count(*) as cnt from mari_invest where loan_id='$loan_id' order by i_pay desc";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];

		/*투자참여인원 리스트*/
		$sql="select m_name, i_pay, i_regdatetime from mari_invest  where loan_id='$loan_id' order by i_regdatetime desc"; 
		$play_list=sql_query($sql, false);

		$sql = " select it_id, it_item_name from mari_contact_item  order by it_item_name asc";
		$result = sql_query($sql, false);

		/*대출총액의 투자금액 백분율구하기*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$loan_id'"; 
		$top=sql_query($sql, false);
		$order = mysql_result($top, 0, 0);
		$total=$iv['i_invest_pay'];
		/*투자금액이 0보다클경우에만 연산*/
		if($order>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($order/$total*100);
		}else{
			$order_pay="0";
		}

		/*대출총액-현재투자금액=투자가능금액*/
		$invest_pay=$loan['i_loan_pay']-$order;

		/*키발급조회 가장최신것*/

		$sql = "select  * from  mari_safekey where m_id='".$loan[m_id]."' order by certnodate desc";
		$sskey = sql_fetch($sql, false);

		$sql = "select  * from  mari_category where ca_num='1' order by ca_subject asc";
		$cate1 = sql_query($sql, false);
		
		/*변호사 리스트 출력*/
		$sql = "select * from mari_lawyer order by ly_id desc";
		$lawyer = sql_query($sql);
		
		/*변호사 리스트 출력*/
		$sql = "select * from mari_lawyer_appr where loan_id = '$loan_id' order by la_id desc";
		$ly_appr = sql_query($sql);

		}else{
			alert('접근권한이 없습니다.');
		}


		/*첨부파일리스트*/
		$sql = "select * from mari_invest_file where loan_id = '$loan_id'";
		$file_list = sql_query($sql);

		/*첨부파일카운트*/
		$sql = "select count(file_idx) as cnt from mari_invest_file where loan_id = '$loan_id'";
		$file_cnt = sql_fetch($sql);
		$total_file = $file_cnt['cnt'];


	break;

/************************************************
투자진행 리스트
************************************************/
	case "invest_setup_list":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_loan]=='1' && $au_loan_sub02 == '2'){

		$sql_common = " from mari_loan ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "i_id";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		
		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		

		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

			$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
			$result = sql_query($sql);

		$colspan = 16;

		$sql = "select  * from  mari_category order by ca_subject asc";
		$cate1 = sql_query($sql, false);
		}else{
			alert('접근권한이 없습니다.');
		}
	break;




/************************************************
투자신청 리스트
************************************************/
	
	case "invest_list":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_invest]=='1'){

		$sql_common = " from mari_invest ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "i_regdatetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql, false);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		/*입찰합계구하기*/
		$sql="select sum(i_pay) from mari_invest"; 
		$top=sql_query($sql, false);
		$t_pay = mysql_result($top, 0, 0);

		}else{
			alert('접근권한이 없습니다.');
		}
	break;




/************************************************
투자신청[결제] 리스트
************************************************/

	case "pay_list":

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_invest]=='1' && $au_invest_sub02 == '2'){

		$sql_common = " from mari_invest ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "i_regdatetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common  $sql_search  $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search  $sql_order limit $from_record, $rows ";
		$result = sql_query($sql, false);

		$colspan = 16;

		/*입찰후 결제완료 합계구하기*/
		$sql="select sum(i_pay) from mari_invest where i_pay_ment='Y'"; 
		$top=sql_query($sql, false);
		$order_pay = mysql_result($top, 0, 0);
		/*결제상세*/
		$sql = "select  * from  mari_invest where i_id='$ci_id'";
		$iv = sql_fetch($sql, false);

		$sql = "select  * from  mari_member where m_id='$iv[user_id]'";
		$mem = sql_fetch($sql, false);

		$sql = "select  * from  mari_inset";
		$inv = sql_fetch($sql, false);

		$sql = "select  * from  mari_loan where i_id='$loan_id'";
		$loan = sql_fetch($sql, false);

		/*연체설정정보*/
		$sql = "select  i_profit, i_withholding_personal, i_withholding_burr from  mari_inset";
		$is_ck = sql_fetch($sql, false);

		/*연체횟수 중복제외구하기(합계)*/
		$sql="select sum(distinct(o_odinterestcount)) from mari_order where loan_id='$loan_id' and user_id='$iv[user_id]' and o_status='연체' "; 
		$odinterestcount=sql_query($sql, false);
		$t_odinterestcount = mysql_result($odinterestcount, 0, 0);

		$ln_money=$loan['i_loan_pay']; //대출금액 
		$ln_kigan=$loan['i_loan_day']; //대출기간 
		$ln_iyul=$loan['i_year_plus']; //대출이율 
		$order_pay_add=$iv['i_pay']; //투자금액
		if(!$loan_id){
		}else{
		/*매월이율*/
		$month_eja= ($ln_iyul/100)*(1/12); 

		/*월불입금*/ 
		if($ln_iyul){
		$month_money = ($month_eja * pow(1+$month_eja,$ln_kigan) * $order_pay_add)/( pow(1+$month_eja,$ln_kigan) - 1); 
		}
		/*월불입금 총계*/
		$month_total=$month_money*$loan['i_loan_day'];

		/*총이자금액*/ 
		//q *12-p0 = {12*r*(1+r)^12/[(1+r)^12-1]-1} * p0 
			//매달내야하는금액 * 12 - 대출원금 = {12*월이율*(1+월이율)^12/[(1+월이율)^12-1]-1} * 대출원금 
		//($month_money*12)-$order_pay_add = ( (12*$month_eja*pow(1+$month_eja,12)) / ((pow(1+$month_eja,12)-1)) -1) * $order_pay_add; 
		if($ln_iyul){
		$all_eja = ( (12 * $month_eja * pow(1+$month_eja,12) ) / ( (pow(1+$month_eja,12) -1)) -1 ) * $order_pay_add; 
		}
		/*소수점이하 제거*/
		/*월불입금*/ 
		$mh_money=ceil($month_money);
		/*월불입금 총계*/ 
		$mh_total=ceil($month_total);

		/*월불입 수익금계산*/
		$month_profit=$mh_money*$is_ck['i_profit'];
		/*월불입 수익총계계산*/
		$total_profit=$mh_total*$is_ck['i_profit'];
		
		$psale_money=$mh_money-$month_profit;
		$psale_totalmoney=$mh_total-$total_profit;
		/*월불입금, 수익총계 소수점이하제거*/
		$sale_money=ceil($psale_money);
		$sale_totalmoney=ceil($psale_totalmoney);
		}

		}else{
			alert('접근권한이 없습니다.');
		}
	break;






/************************************************
투자/결제설정 투자가능한도,연체이자율,pg설정
************************************************/

	case "invest_pay_setup":
		
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_invest]=='1' && $au_invest_sub03 =='3'){


		$sql = "select  * from  mari_inset";
		$inv = sql_fetch($sql, false);

		$sql = "select  * from  mari_pg";
		$pg = sql_fetch($sql, false);

		}else{
			alert('접근권한이 없습니다.');
		}


				/*seyfert가상계좌 시스템 사용여부*/
				if($config['c_seyfertck']=="Y"){
				include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');


						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq."&refId=".$g_code."&dstMemGuid=".$config[c_reqMemGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);


/*
						print_r($requestPath_lnq);
						echo"<br/><br/>";
						print_r($result_lnq);
						echo"<br/><br/>";
						print_r($ENCODE_PARAMS_lnq);


						echo"<br/><br/>데이터";
						print_r($decode_lnq);
						echo"<br/><br/>";
*/

				}

	break;


/************************************************
출금신청 리스트관리
************************************************/

	case "withdrawal_list":
		
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_invest]=='1' && $au_invest_sub04 =='4'){


		$sql_common = " from mari_outpay ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "o_regdatetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql, false);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		}else{
			alert('접근권한이 없습니다.');
		}

	break;




/************************************************
충전내역 리스트관리
************************************************/

	case "charge_list":

		/*접근권한*/
		if($au[au_invest]=='1' && $au_invest_sub05 == '5'){


		$sql_common = " from mari_char ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "c_regdatetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql, false);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		}else{
			alert('접근권한이 없습니다.');
		}
	break;




/************************************************
기본환경설정
************************************************/

	case "setting1":

		
		$sql = "select  * from  mari_config";
		$conl = sql_fetch($sql, false);
	/*권한일단제거
		$sql = "select  * from  mari_config where c_admin='webmaster@admin.com'";
		$conl = sql_fetch($sql, false);
	*/
		$sql = "select  * from mari_mysevice_config";
		$sv = sql_fetch($sql, false);

		$sql = "select m_id from mari_member where m_level>9";
		$su_admin = sql_query($sql, false);
	break;


/************************************************
레이아웃/게시판설정
************************************************/
	case "setting2":

		if($user[m_id]=="$SuperAdministrator"){
		}else{
			alert('업체관리자만 사용하실 수 있습니다.');
			exit;
		}
		$sql = "select  * from  mari_config";
		$conl = sql_fetch($sql, false);
	/*권한일단제거
		$sql = "select  * from  mari_config where c_admin='webmaster@admin.com'";
		$conl = sql_fetch($sql, false);
	*/
		$sql = "select  * from mari_mysevice_config";
		$sv = sql_fetch($sql, false);

		$sql = "select m_id from mari_member where m_level<10";
		$su_admin = sql_query($sql, false);
	break;


/************************************************
회원가입/본인확인설정
************************************************/
	case "setting3":

		
		$sql = "select  * from  mari_config";
		$conl = sql_fetch($sql, false);
	/*권한일단제거
		$sql = "select  * from  mari_config where c_admin='webmaster@admin.com'";
		$conl = sql_fetch($sql, false);
	*/
		$sql = "select  * from mari_mysevice_config";
		$sv = sql_fetch($sql, false);

		$sql = "select m_id from mari_member where m_level<10";
		$su_admin = sql_query($sql, false);
	break;


/************************************************
SNS/메일수신설정
************************************************/
	case "setting4":

		
		$sql = "select  * from  mari_config";
		$conl = sql_fetch($sql, false);
	/*권한일단제거
		$sql = "select  * from  mari_config where c_admin='webmaster@admin.com'";
		$conl = sql_fetch($sql, false);
	*/
		$sql = "select  * from mari_mysevice_config";
		$sv = sql_fetch($sql, false);

		$sql = "select m_id from mari_member where m_level<10";
		$su_admin = sql_query($sql, false);
	break;

/************************************************
ADMIN 로그인 login
************************************************/
	case "admin_login":

		$url = $_GET['url'];

		$p = parse_url($url);
		if ((isset($p['scheme']) && $p['scheme']) || (isset($p['host']) && $p['host'])) {
			//print_r2($p);
			if ($p['host'].(isset($p['port']) ? ':'.$p['port'] : '') != $_SERVER['HTTP_HOST'])
				alert('url에 타 도메인을 지정할 수 없습니다.');
		}

		// 이미 로그인 중이라면
		if ($member_ck) {
			if ($url)
				goto_url($url);
			else
				goto_url(MARI_HOME_URL.'/?cms=admin');
		}

		$login_url        = login_url($url);
		$login_action_url = MARI_HOME_URL."/?mode=login_ck";
	break;

/************************************************
ADMIN 로그아웃
************************************************/
	case "admin_logout":
		session_unset(); // 모든 세션변수를 언레지스터 시켜줌
		session_destroy(); // 세션해제함

		set_cookie('ck_m_id', '', 0);
		set_cookie('ck_auto', '', 0);

		if ($url) {
			$p = parse_url($url);
			if ($p['scheme'] || $p['host']) {
				alert('url에 도메인을 지정할 수 없습니다.');
			}

		} else {
			$link = MARI_HOME_URL.'/?cms=admin_login';
		}

		goto_url($link);
	break;



/************************************************
매출리포트
************************************************/

	case "sales_report":
	/*
			$sql = "select o_investamount, o_collectiondate from mari_order where o_salestatus='정산완료' order by o_collectiondate desc";
			$order = sql_query($sql, false);
	*/
		
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_invest]=='1' && $au_invest_sub06 =='6'){


		if(!$Year || $Year==""){$Year = date("Y");}
		if(!$Month || $Month==""){$Month = date("m");}

		$maxDate = date("t",strtotime($Year."-".$Month."-01"));

		$sql = "select i_pay,i_regdatetime, i_pay_ment from mari_invest where 1 and (i_regdatetime >= '".date("Y-m-d",strtotime($Year."-".$Month."-01"))." 00:00:00' and i_regdatetime <= '".date("Y-m-d",strtotime($Year."-".$Month."-".$maxDate))." 23:59:59')";
		$rst = sql_query($sql, false);


		/*결제대기합계구하기*/
		$sql="select sum(i_pay) from mari_invest where  i_pay_ment='N' and (i_regdatetime >=  '".date("Y-m-d",strtotime($Year."-".$Month."-01"))." 00:00:00' and i_regdatetime <= '".date("Y-m-d",strtotime($Year."-".$Month."-".$maxDate))." 23:59:59')"; 
		$top1=sql_query($sql, false);
		$iamount = mysql_result($top1, 0, 0);
		/*결제완료합계구하기*/
		$sql="select sum(i_pay) from mari_invest where  i_pay_ment='Y' and (i_regdatetime >=  '".date("Y-m-d",strtotime($Year."-".$Month."-01"))." 00:00:00' and i_regdatetime <= '".date("Y-m-d",strtotime($Year."-".$Month."-".$maxDate))." 23:59:59')"; 
		$top2=sql_query($sql, false);
		$pgamount = mysql_result($top2, 0, 0);
		/*입찰합계구하기*/
		$sql="select sum(i_pay) from mari_invest where (i_regdatetime >=  '".date("Y-m-d",strtotime($Year."-".$Month."-01"))." 00:00:00' and i_regdatetime <= '".date("Y-m-d",strtotime($Year."-".$Month."-".$maxDate))." 23:59:59')"; 
		$top=sql_query($sql, false);
		$totalamount = mysql_result($top, 0, 0);

		/*전체투자인원 구하기*/
		$sql = " select count(*) as cnt from mari_invest";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];


		/*
		$sql="select sum(i_pay) from mari_invest"; 
		$top=sql_query($sql, false);
		$t_pay = mysql_result($top, 0, 0);
		*/
		/*대기 구하기*/
		$sql = " select count(*) as cnt from mari_cs where cs_status='대기' and date(cs_regdatetime) >= date_format(now(), '%Y-%m-01') and date(cs_regdatetime) <= last_day(now())";
		$cm_01 = sql_fetch($sql, false);
		$tll_01 = $cm_01['cnt'];

		}else{
			alert('접근권한이 없습니다.');
		}

	break;


/************************************************
팝업관리작성폼
************************************************/
	case "newpopup":
		/*게시판 환경설정*/
		$sql = " select  * from  mari_popup where po_id='$po_id'";
		$pop = sql_fetch($sql, false);
	break;



/************************************************
팝업관리작성폼
************************************************/
	case "popuplist":

		$sql_common = " from mari_popup";

		$sql_search = " where 1=1";
		if ($stx) {
			$sql_search .= " and ( ";
			switch ($sfl) {
				default :
					$sql_search .= " ($sfl like '$stx%') ";
					break;
			}
			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "po_datetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt
				 $sql_common
				 $sql_search
				 $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row[cnt];

		$rows = $config[c_page_rows];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if (!$page) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		// 사용중
		$sql = " select count(*) as cnt
				 $sql_common
				 $sql_search
					and po_openchk = '1'
				 $sql_order ";
		$row = sql_fetch($sql);
		$start_count = $row[cnt];

		// 미사용
		$sql = " select count(*) as cnt
				 $sql_common
				 $sql_search
					and po_openchk <> '1'
				 $sql_order ";
		$row = sql_fetch($sql);
		$end_count = $row[cnt];

		$listall = "<a href='$_SERVER[PHP_SELF]' class=tt>처음</a>";

		$sql = " select *
				  $sql_common
				  $sql_search
				  $sql_order
				  limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 15;
	break;

/************************************************
SMS관리
************************************************/
	case "sms_manage":
		$selected[syear][$syear] = $selected[smonth][$smonth] = "selected";

		$save_sql = " select count(*) as cnt from mari_smsmsg where sm_type='4' ";
		$save_row = sql_fetch($save_sql);
		$total_count = $save_row[cnt];

		$rows = 6;
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page == "") { $page = 1; } // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = "select * from mari_smsmsg where sm_type='4'  order by sm_idx desc limit $from_record, $rows";
		$result = sql_query($sql, false);

		$colspan = 16;
		/*sms그룹추가*/



		$res = sql_fetch("select count(*) as cnt from mari_smsgroup");
		$total_count = $res['cnt'];

		$no_group = sql_fetch("select * from mari_smsgroup where sg_no = 1");

		$group = array();
		$qry = sql_query("select * from mari_smsgroup where sg_no > 1 order by sg_name");
		while ($res = sql_fetch_array($qry)) array_push($group, $res);



		if($type=="gr"){

		if ($add_bt == "선택추가") {

		$group_b = array();

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$qry_b = sql_query("select * from mari_smsbook where sg_no='$sg_no[$k]' order by sb_name asc");

		while ($res = sql_fetch_array($qry_b)) array_push($group_b, $res);
			}
		}

		}else if($type=="book"){
		$book = array();
		$qry_a = sql_query("select * from mari_smsbook  order by sb_name");
		while ($res = sql_fetch_array($qry_a)) array_push($book, $res);
		}else if($booklist=="Y"){
			$sehp = sql_fetch("select sb_hp from mari_smsbook where sb_no='$sb_no'");
		}
		/*sms전송결과 검색*/
		$syear	= date("Y");
		$smonth = date("m");
		$selected[syear][$syear] = $selected[smonth][$smonth] = "selected";

		/*저장된 SMS메세지 불러오기*/
		$save_sql = " select count(*) as cnt from mari_smsmsg where sm_type=4 ";
		$save_row = sql_fetch($save_sql);
		$total_count = $save_row[cnt];

		$rows = 6;
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page == "") { $page = 1; } // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		// 출력할 레코드를 얻음
		$save_sql  = "select * from mari_smsmsg where sm_type=4  order by sm_idx desc limit $from_record, $rows";
		$result = sql_query($save_sql,FALSE);
		for ($i=0; $save_row=sql_fetch_array($result,FALSE); $i++) {
			$list[$i] = $save_row;
		}
					
		$list_total = count($list);

	break;


/************************************************
LMS관리
************************************************/
	case "lms_manage":
		$selected[syear][$syear] = $selected[smonth][$smonth] = "selected";

		$save_sql = " select count(*) as cnt from mari_smsmsg where sm_type='5' ";
		$save_row = sql_fetch($save_sql);
		$total_count = $save_row[cnt];

		$rows = 6;
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page == "") { $page = 1; } // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = "select * from mari_smsmsg where sm_type='5'  order by sm_idx desc limit $from_record, $rows";
		$result = sql_query($sql, false);

		$colspan = 16;
		/*sms그룹추가*/



		$res = sql_fetch("select count(*) as cnt from mari_smsgroup");
		$total_count = $res['cnt'];

		$no_group = sql_fetch("select * from mari_smsgroup where sg_no = 1");

		$group = array();
		$qry = sql_query("select * from mari_smsgroup where sg_no > 1 order by sg_name");
		while ($res = sql_fetch_array($qry)) array_push($group, $res);



		if($type=="gr"){

		if ($add_bt == "선택추가") {

		$group_b = array();

			for ($i=0; $i<count($check); $i++)
			{
				$k = $check[$i];
				$qry_b = sql_query("select * from mari_smsbook where sg_no='$sg_no[$k]' order by sb_name asc");

		while ($res = sql_fetch_array($qry_b)) array_push($group_b, $res);
			}
		}

		}else if($type=="book"){
		$book = array();
		$qry_a = sql_query("select * from mari_smsbook  order by sb_name");
		while ($res = sql_fetch_array($qry_a)) array_push($book, $res);
		}else if($booklist=="Y"){
			$sehp = sql_fetch("select sb_hp from mari_smsbook where sb_no='$sb_no'");
		}
		/*sms전송결과 검색*/
		$syear	= date("Y");
		$smonth = date("m");
		$selected[syear][$syear] = $selected[smonth][$smonth] = "selected";

		/*저장된 SMS메세지 불러오기*/
		$save_sql = " select count(*) as cnt from mari_smsmsg where sm_type=5 ";
		$save_row = sql_fetch($save_sql);
		$total_count = $save_row[cnt];

		$rows = 6;
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page == "") { $page = 1; } // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		// 출력할 레코드를 얻음
		$save_sql  = "select * from mari_smsmsg where sm_type=5  order by sm_idx desc limit $from_record, $rows";
		$result = sql_query($save_sql,FALSE);
		for ($i=0; $save_row=sql_fetch_array($result,FALSE); $i++) {
			$list[$i] = $save_row;
		}
					
		$list_total = count($list);

	break;


/************************************************
SMS 저장메세지 ajax
************************************************/
	case "sms_manage_ajax":

		switch ($smode){
			//메세지저장
			case "save":
			$date = date("Y-m-d H:i:s");
			$sql_insert = "
			insert into mari_smsmsg set
				sm_type	= '$sm_type',
				msg		= '$msg',
				date	= '$date'
			";
			sql_query($sql_insert);
			break;
			//메세지수정
			case "modify":			
			$date = date("Y-m-d H:i:s");
			$sql_update = "
			UPDATE mari_smsmsg set 
				msg		= '$msg',
				date	= '$date'
			WHERE sm_idx=$idx
			";
			sql_query($sql_update);
			break;

			//메세지삭제
			case "del":			
			$sql_del = "
			DELETE FROM mari_smsmsg
			WHERE sm_idx=$idx
			";
			sql_query($sql_del);
			break;

		}

			if($sm_type > 4){
				$w_query = " where sm_type=$sm_type ";	
				$byte = 1500;
			}else{
				$w_query = " where sm_type=4 ";	
				$byte = 80;
			}
			
			$sql = " select count(*) as cnt from mari_smsmsg $w_query";
			$row = sql_fetch($sql);
			$total_count = $row[cnt];

			$rows = 6;
			$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
			if ($page == "") { $page = 1; } // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함

			// 출력할 레코드를 얻음
			$sql  = "select * from mari_smsmsg $w_query order by sm_idx desc limit $from_record, $rows";
			$result = sql_query($sql,FALSE);
			for ($i=0; $row=sql_fetch_array($result,FALSE); $i++) {
				$list[$i] = $row;
			}

			$list_total = count($list);

	break;



/************************************************
SMS그룹관리
************************************************/
	case "sms_group":

		$res = sql_fetch("select count(*) as cnt from mari_smsgroup");
		$total_count = $res['cnt'];

		$no_group = sql_fetch("select * from mari_smsgroup where sg_no = 1");
		/*미분류수*/
		$g_count = sql_fetch("select count(*) as cnt from mari_smsbook where sg_no = 1");
		$g_total_count = $g_count['cnt'];

		$group = array();
		$qry = sql_query("select * from mari_smsgroup where sg_no > 1 order by sg_name");
		while ($res = sql_fetch_array($qry)) array_push($group, $res);

	break;



/************************************************
SMS전화번호관리
************************************************/
	case "sms_book":

		$page_size = 20;
		$colspan = 9;

		if ($page < 1) $page = 1;

		if (is_numeric($sg_no))
			$sql_group = " and sg_no='$sg_no' ";
		else
			$sql_group = "";

		if ($st == 'all') {
			$sql_search = "and (sb_name like '%{$sv}%' or sb_hp like '%{$sv}%')";
		} else if ($st == 'name') {
			$sql_search = "and sb_name like '%{$sv}%'";
		} else if ($st == 'hp') {
			$sql_search = "and sb_hp like '%{$sv}%'";
		} else {
			$sql_search = '';
		}

		if ($ap > 0)
			$sql_korean = korean_index('sb_name', $ap-1);
		else {
			$sql_korean = '';
			$ap = 0;
		}

		if ($no_hp == 'yes') {
			set_cookie('cookie_no_hp', 'yes', 60*60*24*365);
			$no_hp_checked = 'checked';
		} else if ($no_hp == 'no') {
			set_cookie('cookie_no_hp', '', 0);
			$no_hp_checked = '';
		} else {
			if (get_cookie('cookie_no_hp') == 'yes')
				$no_hp_checked = 'checked';
			else
				$no_hp_checked = '';
		}

		if ($no_hp_checked == 'checked')
			$sql_no_hp = "and sb_hp <> ''";

		$total_res = sql_fetch("select count(*) as cnt from mari_smsbook where 1 $sql_group $sql_search $sql_korean $sql_no_hp");
		$total_count = $total_res['cnt'];

		$total_page = (int)($total_count/$page_size) + ($total_count%$page_size==0 ? 0 : 1);
		$page_start = $page_size * ( $page - 1 );

		$vnum = $total_count - (($page-1) * $page_size);

		$res = sql_fetch("select count(*) as cnt from mari_smsbook where sb_receipt=1 $sql_group $sql_search $sql_korean $sql_no_hp");
		$receipt_count = $res['cnt'];
		$reject_count = $total_count - $receipt_count;

		$res = sql_fetch("select count(*) as cnt from mari_smsbook where m_id='' $sql_group $sql_search $sql_korean $sql_no_hp");
		$no_member_count = $res['cnt'];
		$member_count = $total_count - $no_member_count;

		$no_group = sql_fetch("select * from mari_smsgroup where sg_no = 1");

		$group = array();
		$qry = sql_query("select * from mari_smsgroup where sg_no>1 order by sg_name");
		while ($res = sql_fetch_array($qry)) array_push($group, $res);
		/*미분류수*/
		$g_count = sql_fetch("select count(*) as cnt from mari_smsbook where sg_no = 1");
		$g_total_count = $g_count['cnt'];
	break;


/************************************************
SMS전화번호등록
************************************************/
	case "sms_book_w":

		$exist_hplist = array();

		if ($type == 'w' && is_numeric($sb_no)) {
			$write = sql_fetch("select * from mari_smsbook where sb_no='$sb_no'");
			if (!$write)
				alert('데이터가 없습니다.');

			if ($write['m_id']) {
				$res = sql_fetch("select m_id from mari_member where m_id='$write[m_id]'");
				$write['m_id'] = $res['m_id'];
				$sql = "select m_id from mari_member where m_hp = '$write[sb_hp]' and m_id <> '$write[m_id]' and m_hp <> '' ";
				$result = sql_query($sql);
				while($tmp = sql_fetch_array($result)){
					$exist_hplist[] = $tmp;
				}
				$exist_msg_1 = '(수정시 회원정보에 반영되지 않습니다.)';
				$exist_msg_2 = '(수정시 회원정보에 반영됩니다.)';
				$exist_msg = count($exist_hplist) ? $exist_msg_1 : $exist_msg_2;
			}
		}
		else  {
			$write['sg_no'] = $sg_no;
		}

		if (!is_numeric($write['sb_receipt']))
			$write['sb_receipt'] = 1;

		$no_group = sql_fetch("select * from mari_smsgroup where sg_no = 1");
		/*미분류수*/
		$g_count = sql_fetch("select count(*) as cnt from mari_smsbook where sg_no = 1");
		$g_total_count = $g_count['cnt'];
	break;

/************************************************
SMS 회원 전화번호검색
************************************************/
	case "sms_book_search":
		$res = sql_fetch("select count(*) as cnt from mari_member");
		$total_count = $res['cnt'];

		$result = sql_query("select * from mari_member");
	break;

/************************************************
SMS 설정, SMS 자동발송설정
************************************************/
	case "sms_setup":
		$sql = " select * from mari_smsload";
		$load= sql_fetch($sql, false);
	break;

/************************************************
사이트자체 로그분석
************************************************/
	case "site_analytics":
		
	/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1' && $au_member_sub05 == '5'){

		if (empty($s_date)) $s_date = MARI_TIME_YMD;
		if (empty($e_date)) $e_date = MARI_TIME_YMD;

		$sqlstr = "s_date=".$s_date."&amp;e_date=".$e_date;
		$sql_string = $sqlstr ? '?'.$sqlstr : '';

		/*시간대별 집계*/
		if($stype=="time"){
			$max = 0;
			$sum_count = 0;
			$sql = " select SUBSTRING(lo_time,1,2) as lo_hour, count(lo_id) as cnt
						from mari_log
						where lo_date between '$s_date' and '$e_date'
						group by lo_hour
						order by lo_hour ";
			$result = sql_query($sql);
			for ($i=0; $row=sql_fetch_array($result); $i++) {
				$arr[$row['lo_hour']] = $row['cnt'];

				if ($row['cnt'] > $max) $max = $row['cnt'];

				$sum_count += $row['cnt'];
			}

			/*전체회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$logtop_cn = $incn['cnt'];

			/*비회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$lognon_cn = $incn['cnt'];
			/*회원접속구하기*/
			$mem_con=$logtop_cn-$lognon_cn;
		/*일별집계*/
		}else if($stype=="day"){
			if($inquiry=="Y"){
			}else{
				$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')), 1, intval(date('Y'))  ));
				$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))  ));
			}
			$max = 0;
			$sum_count = 0;
			$sql = " select ls_date, ls_count as cnt
						from mari_log_sum
						where ls_date between '$s_date' and '$e_date'
						order by ls_date desc ";
			$result = sql_query($sql);

			for ($i=0; $row=sql_fetch_array($result); $i++) {
				$arr[$row['ls_date']] = $row['cnt'];

				if ($row['cnt'] > $max) $max = $row['cnt'];

				$sum_count += $row['cnt'];
			}

			/*전체회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$logtop_cn = $incn['cnt'];

			/*비회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$lognon_cn = $incn['cnt'];
			/*회원접속구하기*/
			$mem_con=$logtop_cn-$lognon_cn;

		/*월별 집계*/
		}else if($stype=="month"){
			$date = date("Y", $timetoday); 
			if($inquiry=="Y"){
			}else{
				$s_date="".$date."-01-01";
				$e_date="".$date."-12-31";
			}
			$max = 0;
			$sum_count = 0;
			$sql = " select SUBSTRING(ls_date,1,7) as ls_month, SUM(ls_count) as cnt
						from mari_log_sum
						where ls_date between '$s_date' and '$e_date'
						group by ls_month
						order by ls_month desc ";
			$result = sql_query($sql);
			for ($i=0; $row=sql_fetch_array($result); $i++) {
				$arr[$row['ls_month']] = $row['cnt'];

				if ($row['cnt'] > $max) $max = $row['cnt'];

				$sum_count += $row['cnt'];
			}

			/*전체회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$logtop_cn = $incn['cnt'];

			/*비회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$lognon_cn = $incn['cnt'];
			/*회원접속구하기*/
			$mem_con=$logtop_cn-$lognon_cn;

		/*년별 집계*/
		}else if($stype=="year"){
			$date = date("Y", $timetoday); 
			if($inquiry=="Y"){
			}else{
				$s_date="2014-01-01";
				$e_date="2020-12-31";
			}

			$max = 0;
			$sum_count = 0;
			$sql = " select SUBSTRING(ls_date,1,4) as ls_year, SUM(ls_count) as cnt
						from mari_log_sum
						where ls_date between '$s_date' and '$e_date'
						group by ls_year
						order by ls_year desc ";
			$result = sql_query($sql);
			for ($i=0; $row=sql_fetch_array($result); $i++) {
				$arr[$row['ls_year']] = $row['cnt'];

				if ($row['cnt'] > $max) $max = $row['cnt'];

				$sum_count += $row['cnt'];
			}

			/*전체회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$logtop_cn = $incn['cnt'];

			/*비회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$lognon_cn = $incn['cnt'];
			/*회원접속구하기*/
			$mem_con=$logtop_cn-$lognon_cn;
		/*OS */
		}else if($stype=="os"){
			$max = 0;
			$sum_count = 0;
			$sql = " select * from mari_log";
			$result = sql_query($sql);
			while ($row=sql_fetch_array($result)) {
				$s = get_os($row['lo_agent']);

				$arr[$s]++;

				if ($arr[$s] > $max) $max = $arr[$s];

				$sum_count++;
			}
		/*브라우저 */
		}else if($stype=="bw"){

			$max = 0;
			$sum_count = 0;
			$sql = " select * from mari_log";
			$result1 = sql_query($sql);
			while ($row1=sql_fetch_array($result1)) {
				$s1 = get_brow($row1['lo_agent']);

				$arr1[$s1]++;

				if ($arr1[$s1] > $max) $max = $arr1[$s1];

				$sum_count++;
			}
		/*접속경로 */
		}else if($stype=="log"){
			$sql_common = " from mari_log ";
			$sql_search = " where lo_date between '$s_date' and '$e_date' ";
			if (isset($domain))
				$sql_search .= " and lo_ccesspath like '%$domain%' ";

			$sql = " select count(*) as cnt
						{$sql_common}
						{$sql_search} ";
			$row = sql_fetch($sql);
			$total_count = $row['cnt'];

			$rows = $config['c_page_rows'];
			$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
			if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
			$from_record = ($page - 1) * $rows; // 시작 열을 구함

			$sql = " select *
						$sql_common
						$sql_search
						order by lo_id desc
						limit $from_record, $rows ";
			$result = sql_query($sql);
		}else{
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')), 1, intval(date('Y'))  ));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))  ));
			$max = 0;
			$sum_count = 0;
			$sql = " select ls_date, ls_count as cnt
						from mari_log_sum
						where ls_date between '$s_date' and '$e_date'
						order by ls_date desc ";
			$result = sql_query($sql);

			for ($i=0; $row=sql_fetch_array($result); $i++) {
				$arr[$row['ls_date']] = $row['cnt'];

				if ($row['cnt'] > $max) $max = $row['cnt'];

				$sum_count += $row['cnt'];
			}

			/*전체회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$logtop_cn = $incn['cnt'];

			/*비회원 구하기*/
			$sql = " select count(*) as cnt from mari_log where m_id='Non' and  lo_date between '$s_date' and '$e_date'";
			$incn = sql_fetch($sql, false);
			$lognon_cn = $incn['cnt'];
			/*회원접속구하기*/
			$mem_con=$logtop_cn-$lognon_cn;

		}
		}else{
			alert('접근권한이 없습니다.');
		}
	break;

/************************************************
디자인페이지 리스트관리
************************************************/
	case "management_page":

		$sql_common = " from mari_content ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}



		if (!$sst) {
			$sst = "p_subject";
			$sod = "asc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];

		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search and  p_type='page' $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

	break;


/************************************************
INCLUDE 리스트관리
************************************************/
	case "management_inc":

		$sql_common = " from mari_content ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}



		if (!$sst) {
			$sst = "p_subject";
			$sod = "asc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];

		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search and p_type='inc' $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;
	break;

/************************************************
INCLUDE 등록&수정
************************************************/
	case "include_form":
		$sql = " select  * from  mari_content where p_id='$p_id'";
		$page = sql_fetch($sql, false);
	break;

/************************************************
디자인페이지 등록&수정
************************************************/
	case "page_form":

		$sql = " select  * from  mari_content where p_id='$p_id'";
		$page = sql_fetch($sql, false);
		/*컨트롤러 select*/
		$sql = "select * from mari_content where  p_type='inc'";
		$incexe = sql_query($sql, false);

		$sql = "select * from mari_content where  p_type='inc'";
		$incexe_01 = sql_query($sql, false);

		$sql = "select * from mari_content where  p_type='inc'";
		$incexe_02 = sql_query($sql, false);
	break;

/************************************************
sns 페이스북 연동설정
************************************************/
	case "sns":


	break;


/************************************************
네이버 에널리틱스
************************************************/
	case "analytics":

		$sql = " select login_form_login, form_password  from mari_analytics_config";
		$at= sql_fetch($sql, false);
		session_start();
		set_session('state_add', $naver_login);
		$state=$_SESSION["state_add"];
	break;


/************************************************
최신글 위젯
************************************************/
	case "latest":
		$sql = " select w_table  from mari_write order by w_table asc";
		$view_list= sql_query($sql, false);
	break;


/************************************************
카테고리 작성폼
************************************************/

	case "category_form":
		
		if($type=="add"){
			$sql = " select  * from  mari_category  where ca_pk='$ca_pk' and ca_sub_id='$ca_sub_id'";
			$gro = sql_fetch($sql, false);
		}else{
			$sql = " select  * from  mari_category  where ca_pk='$ca_pk'";
			$gro = sql_fetch($sql, false);
		}
		/*하위 카테고리 추가일경우에만 트리넘버연산*/
		if($type=="add"){
				$site_num=$gro['ca_num']+1;
		}else{
			$site_num="1";
		}
	break;


/************************************************
카테고리 리스트
************************************************/
	case "category_list":

		$sql = " select  * from  mari_category";
		$group = sql_fetch($sql, false);

		$sql_common = " from mari_category ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}


		if (!$sst) {
			$sst = "ca_subject";
			$sod = "asc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search and ca_num='1' $sql_order limit $from_record, $rows ";
		$grolist = sql_query($sql, false);

		$colspan = 16;
	break;



/************************************************
디스플레이설정
************************************************/
	case "exposure_settings":

		/*노출항목*/
		$realtimeitem_display = explode("|",$config[c_realtimeitem_display]);
		$realtimeitem_display_01 = $realtimeitem_display[0]; //투자
		$realtimeitem_display_02 = $realtimeitem_display[1]; //대출
		$realtimeitem_display_03 = $realtimeitem_display[2]; //입금
		$realtimeitem_display_04 = $realtimeitem_display[3]; //정산

		/*이름, 상품(분류), 날짜노출여부*/
		$displayprofile_use = explode("|",$config[c_displayprofile_use]);
		$displayprofile_use_01 = $displayprofile_use[0]; //이름
		$displayprofile_use_02 = $displayprofile_use[1]; //상품(분류)
		$displayprofile_use_03 = $displayprofile_use[2]; //날짜노출여부
	break;


/************************************************
전자결제거래내역 - 20170927 전인성
************************************************/
case "payment_deal_list":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*접근권한*/
		if($au[au_sales]=='1' && $au_sales_sub04 =='4'){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}

		$sql_common = " from mari_seyfert_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				if($sfl=='m_name'){
					$stx_cs="(m_name like '%$stx%')";
				}else if ($sfl=='m_id'){
					$stx_cs="(m_id like '%$stx%')";
				}
			}else{
				$stx_cs="1=1";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if ($slid) {
			$sql_search .= " and ( ";

					$sql_search .= " (loan_id like '%$slid%') ";

			$sql_search .= " ) ";
			}

			if ($stid) {
			$sql_search .= " and ( ";

					$sql_search .= " (s_tid like '%$stid%') ";

			$sql_search .= " ) ";
			}

			if ($srefid) {
			$sql_search .= " and ( ";

					$sql_search .= " (s_refid like '%$srefid%') ";

			$sql_search .= " ) ";
			}

			if ($stype) {
			$sql_search .= " and ( ";

					$sql_search .= " (s_type like '%$stype%') ";

			$sql_search .= " ) ";
			}



			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and s_date > CURRENT_DATE()";
					}else{
						$date_y="and s_date between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" s_date > CURRENT_DATE()";
					}else{
						$date_y=" s_date '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			//$sst = "s_date";
			$sst = "s_id";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}else{
			//$sst = "s_date";
			$sst = "s_id";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		}else{
				alert('접근권한이 없습니다.');
		}
	break;



/************************************************
원천징수내역(회계관리)
************************************************/

	case "withholding_list":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*접근권한*/
		if($au[au_sales]=='1' && $au_sales_sub04 =='4'){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(sale_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}else{
			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		/*emoney거래합계*/
		$sql= "select sum(m_emoney) from mari_member";
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);

		}else{
				alert('접근권한이 없습니다.');
		}
	break;

/************************************************
매출현황(회계관리)
************************************************/
	case "sales_results":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_sales]=='1' && $au_sales_sub01 =='1' ){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(sale_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = "order by $sst $sod ";
		}else{
			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		/*emoney거래합계*/
		$sql= "select sum(m_emoney) from mari_member";
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);
		
		}else{
			alert('접근권한이 없습니다.');
		}
	break;



/************************************************
정산완료(회계관리)
************************************************/
	case "complete_settlement":
		/*로그인 체크여부*/
		$login_ck="YES";
		
		/*접근권한*/
		if($au[au_sales]=='1' && $au_sales_sub04 =='4'){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(sale_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}else{
			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		/*emoney거래합계*/
		$sql= "select sum(m_emoney) from mari_member";
		$top=sql_query($sql);
		$t_emoney = mysql_result($top, 0, 0);

		}else{
				alert('접근권한이 없습니다.');
		}
	break;



/************************************************
투자결재완료(회계관리)
************************************************/
	case "investment_payment":
		/*로그인 체크여부*/
		$login_ck="YES";

		/*접근권한*/
		if($au[au_sales]=='1' && $au_sales_sub05 =='5'){


		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(sale_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}else{
			$sst = "o_collectiondate";
			$sod = "desc";
			$sql_order = " order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search and o_type='sale' $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search and o_type='sale' $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);
		}else{
			alert('접근권한이 없습니다.', '?cms=admin');
		}

	break;

/************************************************
대출자산(회계관리)
************************************************/
	case "loans":
		/*로그인 체크여부*/

		$login_ck="YES";
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_sales]=='1' && $au_sales_sub02 =='2'){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(user_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_count asc, o_datetime";
			$sod = "desc";
			$sql_order = " group by o_count order by $sst $sod ";
		}else{
			$sst = "o_count asc, o_datetime";
			$sod = "desc";
			$sql_order = " group by o_count order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search and o_type='user' $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search  $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		}else{
			alert('접근권한이 없습니다.');
		}
	break;


/************************************************
수납처리(회계관리)
************************************************/
	case "receiving_treatment":
		/*로그인 체크여부*/
		$login_ck="YES";
		if($au[au_sales]=='1' && $au_sales_sub03 == '3'){

		if($date_m=="date_month"){
			$s_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m')),1, intval(date('Y'))));
			$e_date= date("Y-m-d", mktime(0, 0, 0, intval(date('m'))+1, 0, intval(date('Y'))));
		}else if($date_m=="date_today"){
			$s_date= date("Y-m-d", $timetoday); 
			$e_date= date("Y-m-d", $timetoday); 
		}else if($date_m=="date_lastmonth"){
			$y = date('Y');
			$t = time() - date("d")*86400;
			$m = date( "m", $t );
			$s = 1;
			$l = date( "d", $t);
			$s_date ="".$y."-".$m."-01";
			$e_date="".$y."-".$m."-".$l."";
		}
		$sql_common = " from mari_order ";

		if($_GET[cs_mb]=="Y"){
				$sql_search = " where ";
		}else{
				$sql_search = " where (1) ";
		}

		if ($_GET[sh]=="Y"){
			if($stx){
				$stx_cs="(user_name like '$stx%')";
			}

			if($cs_mb=="Y"){
				$and="";
			}else{
				$and="and";
			}

			if($_GET[s_date] || $_GET[e_date] || $_GET[date_m]){
				if($stx || $cs_hp){
					if($date_m=="date_today" ){
						$date_y="and o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y="and o_collectiondate between '$s_date' and '$e_date'";
					}
				}else{
					if($date_m=="date_today" ){
						$date_y=" o_collectiondate > CURRENT_DATE()";
					}else{
						$date_y=" o_collectiondate between '$s_date' and '$e_date'";
					}
				}
			}
			if($cs_mb=="Y"){

			}else{
				$sql_search .= " and ( ";

						$sql_search .= "".$stx_cs."".$date_y."";

				$sql_search .= " ) ";
			}

			$sst = "o_count asc, o_datetime";
			$sod = "desc";
			$sql_order = " group by o_count order by $sst $sod ";
		}else{
			$sst = "o_count asc, o_datetime";
			$sod = "desc";
			$sql_order = " group by o_count order by $sst $sod ";
		}

		$sql = " select count(*) as cnt $sql_common  $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];
		$rows = "31";
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($_GET[page] < 1) $_GET[page] = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($_GET[page] - 1) * $rows; // 시작 열을 구함


		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$order_w = sql_query($sql, false);

		}else{
				alert('접근권한이 없습니다.');
		}
	break;

/************************************************
회원권한 관리
************************************************/
	case "member_authority":
	
		

		/*접근권한*/
		$sql = "select * from mari_authority  where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		
		if($au['au_member']=='1' && $au_member_sub06 =='6'){
			$sql = "select * from mari_authority order by au_regidate desc";
			$au = sql_query($sql, false);
			
			$sql = "select * from mari_authority where au_id = '$au_id'";
			$au1 = sql_fetch($sql, false);
			/*회원관리권한*/
			$au_member_sub = explode("|",$au1[au_member_sub]);
					
			$au_member_sub01 = $au_member_sub[0]; //회원목록
			$au_member_sub02 = $au_member_sub[1]; //회원등급
			$au_member_sub03 = $au_member_sub[2]; //탈퇴회원&복구
			$au_member_sub04 = $au_member_sub[3]; //e-머니관리
			$au_member_sub05 = $au_member_sub[4]; //로그분석
			$au_member_sub06 = $au_member_sub[5]; //회원권한관리


			/*대출관리권한*/
			$au_loan_sub = explode("|",$au1[au_loan_sub]);

			$au_loan_sub01 = $au_loan_sub[0]; //대출현황
			$au_loan_sub02 = $au_loan_sub[1]; //투자진행 설정

			/*투자관리권한*/
			$au_invest_sub = explode("|",$au1[au_invest_sub]);

			$au_invest_sub01 = $au_invest_sub[0]; //투자현황
			$au_invest_sub02 = $au_invest_sub[1]; //결제관리
			$au_invest_sub03 = $au_invest_sub[2]; //투자/결제설정
			$au_invest_sub04 = $au_invest_sub[3]; //출금신청
			$au_invest_sub05 = $au_invest_sub[4]; //충전내역
			$au_invest_sub06 = $au_invest_sub[5]; //매출리포트

			/*회계관리권한*/
			$au_sales_sub = explode("|",$au1[au_sales_sub]);
			$au_sales_sub01 = $au_sales_sub[0]; //매출현황
			$au_sales_sub02 = $au_sales_sub[1]; //대출자산
			$au_sales_sub03 = $au_sales_sub[2]; //수납처리
			$au_sales_sub04 = $au_sales_sub[3]; //정산완료
			$au_sales_sub05 = $au_sales_sub[4]; //투자결제완료
			
		}else{
			alert('접근권한이 없습니다.');
		}
		
		
	break;
/************************************************
Q&A 리스트
************************************************/
	case "faq_list":
		
		$sql = "select count(*) as cnt from mari_faq";
		$faq_count = sql_fetch($sql);
		$total_faq= $faq_count['cnt'];
		$rows ="15";
		$total_faq_page  = ceil($total_faq / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = " select * from mari_faq order by f_id desc limit $from_record, $rows ";
		$faq = sql_query($sql);

	break;

/************************************************
Q&A 리스트
************************************************/
	case "faq_view":
	
		$sql = "select * from mari_faq where f_id = '$f_id'";
		$faq = sql_fetch($sql,false);
		
	break;


/************************************************
유지보수
************************************************/
	case "conservatism":		

		include_once(MARI_SQL_PATH.'/master_connect.php');

		$sql = "select * from mari_conservatism where ftp_id = '$ftp_id' and cv_id = '$cv_id'";
		$cv = mysql_query($sql);
		
	break;




/************************************************
플랫폼(관리자)게시판 팝업창
************************************************/
	case "board_pop":		

		include_once(MARI_SQL_PATH.'/master_connect.php');

		$sql = "select * from mari_write where w_table = '$w_table' and w_id = '$w_id'";
		$plat = sql_fetch($sql,false);
		
		
	break;

	case "board_pop2":

		/*관리자 서버접속*/
		include_once(MARI_SQL_PATH.'/master_connect.php');

		$sql = "select * from mari_conservatism where cv_id = '$cv_id' and ftp_id= '$ftp_id'";
		$cv = sql_fetch($sql,false);

	break;

/************************************************
회원조회 팝업창
************************************************/
	case "inquery_pop":				

		$sql_common = " from mari_member ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}
		
		$sql = "select count(*) as cnt from mari_member";
		$de_count = sql_fetch($sql);
		$total_de=$de_count['cnt'];
		$rows = "10";
		$total_de_page  = ceil($total_de/ $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함
		$sql = "select * from mari_member $sql_search order by m_no desc limit ".$from_record.", $rows";
		$imem = sql_query($sql,false);		

	break;

/************************************************
자문단 설정
************************************************/
	case "advice_view":
		$sql = "select * from mari_advice where ad_id = '$ad_id'";
		$adv = sql_fetch($sql, false);
	break;



	case "advice_list":
		$sql = "select * from mari_advice order by ad_id desc";
		$adv = sql_query($sql, false);
	break;

/************************************************
변호사 리스트
************************************************/
	case "lawyer_list":				

		$sql = "select * from mari_lawyer order by ly_regidate desc";
		$lay = sql_query($sql, false);

	break;

/************************************************
변호사 작성/수정
************************************************/
	case "lawyer_write":				

		$sql = "select * from mari_lawyer where ly_id = '$ly_id'";
		$lay = sql_fetch($sql, false);

	break;

/************************************************
가상계좌목록
************************************************/
	case "illusion_acc_list":				

	
		/*접근권한*/
		$sql = "select * from mari_authority where m_id = '$user[m_id]'";
		$au = sql_fetch($sql, false);
		if($au[au_member]=='1'){
		
		
		$sql_common = " from mari_seyfert ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '%$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "s_id";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt from mari_seyfert $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = 16;
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * from mari_seyfert $sql_search $sql_order limit $from_record, $rows ";
		$acc_list = sql_query($sql);

		
		}

	break;


/************************************************************************
관리자 정산스케쥴리스트 2017-02-01 임근호 전체업데이트예정
************************************************************************/

	case "repay_schedule":

		/*스케쥴 가져오기*/

		$sql = " select * from mari_repay_schedule order by r_orderdate desc";
		$scdlist = sql_query($sql, false);

	break;


/******************************************************************
관리자 정산스케쥴등록폼 2017-02-16 임근호 전체업데이트예정
******************************************************************/

	case "repay_schedule_form":



		$sql_common = " from mari_repay_schedule ";

		$sql_search = " where (1) ";
		if ($stx) {
			$sql_search .= " and ( ";

					$sql_search .= " ($sfl like '$stx%') ";

			$sql_search .= " ) ";
		}

		if (!$sst) {
			$sst = "r_regdatetime";
			$sod = "desc";
		}

		$sql_order = " order by $sst $sod ";

		$sql = " select count(*) as cnt $sql_common $sql_search $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		$rows = $config['c_page_rows'];
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;


		/*대출건 가져오기*/
		$sql = " select i_subject, i_id from mari_loan order by i_id desc";
		$myloanlist = sql_query($sql, false);

	break;

}
?>