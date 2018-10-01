<?php
include_once('./_Common_execute_class.php');

$timetoday = mktime();

$day1 = date("Y-m-d H:i:s", strtotime($timetoday)); 
$day2 = date("Y-m-d 23:59:59", strtotime($timetoday)); 



switch ($dwtype){
	case "emoney_list":

	$sql = "select * from mari_emoney order by p_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "NO")
					 ->setCellValue("B1", "지급아이디")
					 ->setCellValue("C1", "지급내용")
					 ->setCellValue("D1", "지급이머니")
					 ->setCellValue("E1", "회원현재이머니")
					 ->setCellValue("F1", "지급일");
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
		
		
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "$row[p_id]")
						 ->setCellValue("B$i", "$row[m_id]")
						 ->setCellValue("C$i", "$row[p_content]")
						 ->setCellValue("D$i", "".number_format($row[p_emoney])."")
						 ->setCellValue("E$i", "".number_format($row[p_top_emoney])."")
						 ->setCellValue("F$i", "$row[p_datetime]");
		 }

	break;



	case "member_list":

	$sql = "select * from mari_member order by m_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "NO")
					 ->setCellValue("B1", "아이디")
					 ->setCellValue("C1", "이름")
					 ->setCellValue("D1", "닉네임")
					 ->setCellValue("E1", "이메일")
					 ->setCellValue("F1", "성별")
					 ->setCellValue("G1", "생년월일")
					 ->setCellValue("H1", "전화번호")
					 ->setCellValue("I1", "휴대폰번호")
					 ->setCellValue("J1", "주소")
					 ->setCellValue("K1", "상세주소1")
					 ->setCellValue("L1", "상세주소2")
					 ->setCellValue("M1", "e머니")
					 ->setCellValue("N1", "최근접속일")
					 ->setCellValue("O1", "회원가입일")
					 ->setCellValue("P1", "사업자등록번호")
					 ->setCellValue("Q1", "가입목적")
					 ->setCellValue("R1", "출금계좌정보")
					 ->setCellValue("S1", "레벨");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
		
			if($row['m_my_bankcode']=="SHINHAN_088"){ $bankname="신한은행"; 
			}else if($row['m_my_bankcode']=="KIUP_003"){ $bankname="기업은행"; 
			}else if($row['m_my_bankcode']=="KUKMIN_004"){ $bankname="국민은행"; 
			}else if($row['m_my_bankcode']=="WOORI_020"){ $bankname="우리은행"; 
			}else if($row['m_my_bankcode']=="KEB_005"){ $bankname="외환은행"; 
			}else if($row['m_my_bankcode']=="NONGHYUP_011"){ $bankname="농협중앙회"; 
			}else if($row['m_my_bankcode']=="NONGHYUP_010"){ $bankname="농협"; 
			}else if($row['m_my_bankcode']=="HANA_081"){ $bankname="하나은행"; 
			}else if($row['m_my_bankcode']=="SC_023"){ $bankname="SC제일은행"; 
			}else if($row['m_my_bankcode']=="CITY_027"){ $bankname="한국씨티은행"; 
			}else if($row['m_my_bankcode']=="SAEMAEULGEUMGO_045"){ $bankname="새마을금고"; 
			}else if($row['m_my_bankcode']=="BUSAN_032"){ $bankname="부산은행"; 
			}else if($row['m_my_bankcode']=="DAEGU_031"){ $bankname="대구은행"; 
			}else if($row['m_my_bankcode']=="SANUP_002"){ $bankname="산업은행"; 
			}else if($row['m_my_bankcode']=="POSTOFFICE_071"){ $bankname="우체국"; 
			}else if($row['m_my_bankcode']=="SINHYUB_048"){ $bankname="신협"; 
			}else if($row['m_my_bankcode']=="KWANGJU_034"){ $bankname="광주은행"; 
			}else if($row['m_my_bankcode']=="SB_050"){ $bankname="상호저축은행"; 
			}else if($row['m_my_bankcode']=="NONGHYUP_012"){ $bankname="단위농협"; 
			}else if($row['m_my_bankcode']=="KYONGNAM_039"){ $bankname="경남은행"; 
			}else if($row['m_my_bankcode']=="JEONBUK_037"){ $bankname="전북은행"; 
			}else if($row['m_my_bankcode']=="SUHYUP_007"){ $bankname="수협"; 
			}else if($row['m_my_bankcode']=="HSBC_054"){ $bankname="HSBC"; 
			}else if($row['m_my_bankcode']=="SUCHULIB_008"){ $bankname="수출입"; 
			}else if($row['m_my_bankcode']=="CHOHUNG_021"){ $bankname="(구)조흥은행"; 
			}else if($row['m_my_bankcode']=="JEJU_035"){ $bankname="제주은행"; }

			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "$row[m_no]")
						 ->setCellValue("B$i", "$row[m_id]")
						 ->setCellValue("C$i", "$row[m_name]")
						 ->setCellValue("D$i", "$row[m_nick]")
						 ->setCellValue("E$i", "$row[m_email]")
						 ->setCellValue("F$i", "$row[m_sex]")
						 ->setCellValue("G$i", "$row[m_birth]")
						 ->setCellValue("H$i", "$row[m_tel]")
						 ->setCellValue("I$i", "".substr($row[m_hp],0,3)."-".substr($row[m_hp],3,4)."-".substr($row[m_hp],7,4)."")
						 ->setCellValue("J$i", "$row[m_zip]")
						 ->setCellValue("K$i", "$row[m_addr1]")
						 ->setCellValue("L$i", "$row[m_addr2]")
						 ->setCellValue("M$i", "".number_format($row[m_emoney])."")
						 ->setCellValue("N$i", "$row[m_today_login]")
						 ->setCellValue("O$i", "$row[m_datetime]")
						 ->setCellValue("P$i", "$row[m_companynum]")
						 ->setCellValue("Q$i", "$row[m_signpurpose]")
						 ->setCellValue("R$i", "$bankname  $row[m_my_bankname]  $row[m_my_bankacc]")
						 ->setCellValue("S$i", "$row[m_level]");
;
		 }

	break;



	/*매출현황*/
	case "sales_results":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "정산일자")
					 ->setCellValue("B1", "아이디")
					 ->setCellValue("C1", "성명")
					 ->setCellValue("D1", "실거래금액")
					 ->setCellValue("E1", "원금")
					 ->setCellValue("F1", "이자수익")
					 ->setCellValue("G1", "수수료수익")
					 ->setCellValue("H1", "원천징수납부세액")
					 ->setCellValue("I1", "거래후잔액");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			$to_order=$row['o_ln_money_to']+$row['o_interest']+$row['o_saleodinterest'];

					$sql = "select i_year_plus from mari_loan where i_id='$row[loan_id]'";
					$plus = sql_fetch($sql, false);
					/*이자 소수점이하제거*/
					$o_saleodinterest=floor($row['o_saleodinterest']);
					/*투자자 정산후잔액정보*/
					$sql = "select m_id, p_top_emoney from  mari_emoney where m_id='$row[sale_id]' and o_id='$row[o_id]' and loan_id='$row[loan_id]' group by p_top_emoney ";
					$salemoney = sql_fetch($sql, false);

									/*수수료,원천징수,연체설정정보*/
									$sql = "select * from  mari_inset";
									$is_ck = sql_fetch($sql, false);

									/*투자자 정산후잔액정보*/
									$sql = "select * from  mari_member where m_id='$orders_list[sale_id]'";
									$memlvck = sql_fetch($sql, false);

										if($memlvck[m_level]=="2"){
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}else if($memlvck[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
											$i_withholding=$is_ck['i_withholding_burr'];
										}else{
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}



									/*수수료계산*/
									if($orders_list['o_paytype']=="원리금균등상환"){
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_ln_money_to']+$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else if($orders_list['o_paytype']=="만기일시상환"){

										$o_interest=$orders_list['o_interest']-$orders_list['o_ln_money_to'];

										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else{
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}


									if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
										$o_interestsum=$orders_list['o_interest']-$orders_list['o_ln_money_to'];
									}else{
										$o_interestsum=$orders_list['o_interest'];
									}
				if($orders_list['o_paytype']=="만기일시상환" || $orders_list['o_paytype']=="일만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
					$o_ln_money_to=$orders_list['o_ln_money_to'];
				}else{
					$o_ln_money_to="0";
				}
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".substr($row[o_collectiondate],0,10)."")
						 ->setCellValue("B$i", "".$row['sale_id']."")
						 ->setCellValue("C$i", "".$row['sale_name']."")
						 ->setCellValue("D$i", "".number_format($row['o_ipay'])."원")
						 ->setCellValue("E$i", "".number_format($o_ln_money_to)."원")
						 ->setCellValue("F$i", "".number_format($row['o_interest'])."원")
						 ->setCellValue("G$i", "".number_format($수수료)."원")
						 ->setCellValue("H$i", "".number_format($row['o_withholding'])."원")
						 ->setCellValue("I$i", "".number_format($salemoney['p_top_emoney'])."원");						 

		 }

	break;
	

	/*대출자산*/
	case "loans":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "번호")
					 ->setCellValue("B1", "아이디")
					 ->setCellValue("C1", "성명")
					 ->setCellValue("D1", "대출금")
					 ->setCellValue("E1", "약정일")
					 ->setCellValue("F1", "상태")
					 ->setCellValue("G1", "월상환금");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			$sql = "select i_repay_day from mari_loan where i_id='$row[loan_id]'";
			$rday = sql_fetch($sql, false);
		
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".$row['o_id']."")
						 ->setCellValue("B$i", "".$row['user_id']."")
						 ->setCellValue("C$i", "".$row['user_name']."")
						 ->setCellValue("D$i", "".number_format($row['o_ln_money'])."원")
						 ->setCellValue("E$i", "매월".number_format($rday['i_repay_day'])."일")
						 ->setCellValue("F$i", "".$row['o_status']."")
						 ->setCellValue("G$i", "".number_format($row['o_mh_money'])."원");			 
;
		 }

	break;

	/*수납처리*/
	case "receiving_treatment":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "번호")
					 ->setCellValue("B1", "수납일시처리")
					 ->setCellValue("C1", "아이디")
					 ->setCellValue("D1", "성명")
					 ->setCellValue("E1", "대출금")
					 ->setCellValue("F1", "약정일")
					 ->setCellValue("G1", "상태")
					 ->setCellValue("H1", "월상환금");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			$sql = "select i_repay_day from mari_loan where i_id='$row[loan_id]'";
			$rday = sql_fetch($sql, false);
			/*월상환금-원금=이자*/
			$plusmoney=$row['o_mh_money']-$row['o_ln_money'];
		
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".$row['o_id']."")
						 ->setCellValue("B$i", "".substr($row[o_datetime],0,10)."")
						 ->setCellValue("C$i", "".$row['user_id']."")
						 ->setCellValue("D$i", "".$row['user_name']."")
						 ->setCellValue("E$i", "".number_format($row['o_ln_money'])."원")
						 ->setCellValue("F$i", "매월".number_format($rday['i_repay_day'])."일")
						 ->setCellValue("G$i", "".$row['o_status']."")
						 ->setCellValue("H$i", "".number_format($row['o_mh_money'])."원");		 
;
		 }

	break;

	
	/*정산완료*/
	case "complete_settlement":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "정산완료일시")
					 ->setCellValue("B1", "아이디")
					 ->setCellValue("C1", "성명")
					 ->setCellValue("D1", "이자수익")
					 ->setCellValue("E1", "원금")
					 ->setCellValue("F1", "수수료수익")
					 ->setCellValue("G1", "원천징수납부세액")
					 ->setCellValue("H1", "정산완료금액")
					 ->setCellValue("I1", "거래후잔액");

	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			$to_order=$row['o_ln_money_to']+$row['o_interest']+$row['o_saleodinterest'];
			$sql = "select i_year_plus from mari_loan where i_id='$row[loan_id]'";
			$plus = sql_fetch($sql, false);
			/*이자 소수점이하제거*/
			$o_saleodinterest=floor($row['o_saleodinterest']);
			/*투자자 정산후잔액정보*/
			$sql = "select p_top_emoney, p_emoney from  mari_emoney where  m_id='$row[sale_id]' and o_id='$row[o_id]' and loan_id='$row[loan_id]'";
			$salemoney = sql_fetch($sql, false);

									/*수수료,원천징수,연체설정정보*/
									$sql = "select * from  mari_inset";
									$is_ck = sql_fetch($sql, false);

									/*투자자 정산후잔액정보*/
									$sql = "select * from  mari_member where m_id='$orders_list[sale_id]'";
									$memlvck = sql_fetch($sql, false);

										if($memlvck[m_level]=="2"){
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}else if($memlvck[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
											$i_withholding=$is_ck['i_withholding_burr'];
										}else{
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}



									/*수수료계산*/
									if($orders_list['o_paytype']=="원리금균등상환"){
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_ln_money_to']+$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else if($orders_list['o_paytype']=="만기일시상환"){

										$o_interest=$orders_list['o_interest']-$orders_list['o_ln_money_to'];

										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else{
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}


									if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
										$o_interestsum=$orders_list['o_interest']-$orders_list['o_ln_money_to'];
									}else{
										$o_interestsum=$orders_list['o_interest'];
									}
				if($orders_list['o_paytype']=="만기일시상환" || $orders_list['o_paytype']=="일만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
					$o_ln_money_to=$orders_list['o_ln_money_to'];
				}else{
					$o_ln_money_to="0";
				}
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".substr($row[o_collectiondate],0,10)."")
						 ->setCellValue("B$i", "".$row['sale_id']."")
						 ->setCellValue("C$i", "".$row['sale_name']."")
						 ->setCellValue("D$i", "".number_format($row['o_interest'])."원")
						 ->setCellValue("E$i", "".number_format($o_ln_money_to)."원")
						 ->setCellValue("F$i", "".number_format($수수료)."원")
						 ->setCellValue("G$i", "".number_format($row['o_withholding'])."원")
						 ->setCellValue("H$i", "".number_format($salemoney['p_emoney'])."원")
						 ->setCellValue("I$i", "".number_format($salemoney['p_top_emoney'])."원");		 
		 }

	break;

	
	/*투자결제완료*/
	case "investment_payment":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 
	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "번호")
					 ->setCellValue("B1", "투자결제완료일시")
					 ->setCellValue("C1", "아이디")
					 ->setCellValue("D1", "성명")
					 ->setCellValue("E1", "대출금")
					 ->setCellValue("F1", "약정일")
					 ->setCellValue("G1", "낙찰여부")
					 ->setCellValue("H1", "모집종료일")
					 ->setCellValue("I1", "월상환금");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			$to_order=$row['o_ln_money_to']+$row['o_interest']+$row['o_saleodinterest'];
			$sql = "select i_year_plus, i_repay_day from mari_loan where i_id='$row[loan_id]'";
			$plus = sql_fetch($sql, false);
			$sql = "select i_invest_eday from mari_invest_progress where loan_id='$row[loan_id]'";
			$endday = sql_fetch($sql, false);

			/*이자 소수점이하제거*/
			$o_saleodinterest=floor($row['o_saleodinterest']);

			/*투자자 정산후잔액정보*/
			$sql = "select p_top_emoney, p_emoney from  mari_emoney where  m_id='$row[sale_id]' and o_id='$row[o_id]' and loan_id='$row[loan_id]'";
			$salemoney = sql_fetch($sql, false);

			/*수수료,원천징수,연체설정정보*/
			$sql = "select * from  mari_inset";
			$is_ck = sql_fetch($sql, false);

			/*수수료계산*/
			$수수료=$to_order*$is_ck['i_profit'];
			$원천징수수수료=$row['o_interest']*$i_profit;
	
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".$row['o_id']."")
						 ->setCellValue("B$i", "".전자결제에맞는처리."")
						 ->setCellValue("C$i", "".$row['sale_id']."")
						 ->setCellValue("D$i", "".$row['sale_name']."")
						 ->setCellValue("E$i", "".number_format($row['o_ln_money'])."원")
						 ->setCellValue("F$i", "매월".number_format($plus['i_repay_day'])."일")
						 ->setCellValue("G$i", "".$row['o_salestatus']."")
						 ->setCellValue("H$i", "".substr($endday['i_invest_eday'],0,10)."")
						 ->setCellValue("I$i", "".number_format($row['o_investamount'])."원");		 
;
		 }

	break;



	/*원천징수내역*/
	case "withholding_list":

	$sql = "select * from mari_order order by o_datetime desc"; 
	$result  = sql_query($sql); 

	/*emoney거래합계*/
	$sql= "select sum(m_emoney) from mari_member";
	$top=sql_query($sql);
	$t_emoney = mysql_result($top, 0, 0);

	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "발생기간")
					 ->setCellValue("B1", "아이디")
					 ->setCellValue("C1", "성명")
					 ->setCellValue("D1", "주민등록번호")
					 ->setCellValue("E1", "실거래금액")
					 ->setCellValue("F1", "원금")
					 ->setCellValue("G1", "이자수익")
					 ->setCellValue("H1", "수수료")
					 ->setCellValue("I1", "원천징수납부세액")
					 ->setCellValue("J1", "거래후잔액");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $orders_list=sql_fetch_array($result); $i++)
		 {    
			$to_order=$orders_list['o_ln_money_to']+$orders_list['o_interest']+$orders_list['o_saleodinterest'];
			$sql = "select i_year_plus from mari_loan where i_id='$orders_list[loan_id]'";
			$plus = sql_fetch($sql, false);
			/*이자 소수점이하제거*/
			$o_saleodinterest=floor($orders_list['o_saleodinterest']);
			/*투자자 정산후잔액정보*/
			$sql = "select p_top_emoney from  mari_emoney where o_id='$orders_list[o_id]' and loan_id='$orders_list[loan_id]'";
			$salemoney = sql_fetch($sql, false);

									/*수수료,원천징수,연체설정정보*/
									$sql = "select * from  mari_inset";
									$is_ck = sql_fetch($sql, false);

									/*투자자 정산후잔액정보*/
									$sql = "select * from  mari_member where m_id='$orders_list[sale_id]'";
									$memlvck = sql_fetch($sql, false);

										if($memlvck[m_level]=="2"){
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}else if($memlvck[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
											$i_withholding=$is_ck['i_withholding_burr'];
										}else{
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}



									/*수수료계산*/
									if($orders_list['o_paytype']=="원리금균등상환"){
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_ln_money_to']+$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else if($orders_list['o_paytype']=="만기일시상환"){

										$o_interest=$orders_list['o_interest']-$orders_list['o_ln_money_to'];

										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else{
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}


									if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
										$o_interestsum=$orders_list['o_interest']-$orders_list['o_ln_money_to'];
									}else{
										$o_interestsum=$orders_list['o_interest'];
									}
	
				if($orders_list['o_paytype']=="만기일시상환" || $orders_list['o_paytype']=="일만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
					$o_ln_money_to=$orders_list['o_ln_money_to'];
				}else{
					$o_ln_money_to="0";
				}

			/*회원정보*/
			$sql = "select m_reginum from mari_member where m_id = '".$orders_list[sale_id]."' ";
			$withholding_reginum = sql_fetch($sql,false);

			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".substr($orders_list[o_collectiondate],0,10)."")
						 ->setCellValue("B$i", "".$orders_list['sale_id']."")
						 ->setCellValue("C$i", "".$orders_list['sale_name']."")
						 ->setCellValue("D$i", "".substr($withholding_reginum['m_reginum'],0,6)."-".substr($withholding_reginum['m_reginum'],6,7)."")
						 ->setCellValue("E$i", "".number_format($orders_list['o_ipay'])."")
						 ->setCellValue("F$i", "".number_format($o_ln_money_to)."원")
						 ->setCellValue("G$i", "".number_format($orders_list['o_interest'])."원")
						 ->setCellValue("H$i", "".number_format($수수료)."")
						 ->setCellValue("I$i", "".number_format($orders_list['o_withholding'])."")
						 ->setCellValue("J$i", "".number_format($salemoney['p_top_emoney'])."원");
		 }

	break;

	/*가상계좌리스트*/
	case "illusion_acc_list":

	if($sfl){
		$sort = "and ".$sfl." like '%".$stx."%' ";
	}

	$sql = "select * from mari_seyfert where (1) ".$sort." order by s_id desc";
	$result = sql_query($sql);

	$wr_count  = mysql_num_rows($result); 

					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "번호")
					 ->setCellValue("B1", "회원아이디")
					 ->setCellValue("C1", "이름")
					 ->setCellValue("D1", "멤버키")
					 ->setCellValue("E1", "가상계좌")
					 ->setCellValue("F1", "휴대폰번호");
;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
				if($row['s_bnkCd']=="SHINHAN_088"){ $bankname="신한은행"; 
				}else if($row['s_bnkCd']=="KIUP_003"){ $bankname="기업은행"; 
				}else if($row['s_bnkCd']=="KUKMIN_004"){ $bankname="국민은행"; 
				}else if($row['s_bnkCd']=="WOORI_020"){ $bankname="우리은행"; 
				}else if($row['s_bnkCd']=="KEB_005"){ $bankname="외환은행"; 
				}else if($row['s_bnkCd']=="NONGHYUP_011"){ $bankname="농협중앙회"; 
				}else if($row['s_bnkCd']=="NONGHYUP_010"){ $bankname="농협"; 
				}else if($row['s_bnkCd']=="HANA_081"){ $bankname="하나은행"; 
				}else if($row['s_bnkCd']=="SC_023"){ $bankname="SC제일은행"; 
				}else if($row['s_bnkCd']=="CITY_027"){ $bankname="한국씨티은행"; 
				}else if($row['s_bnkCd']=="SAEMAEULGEUMGO_045"){ $bankname="새마을금고"; 
				}else if($row['s_bnkCd']=="BUSAN_032"){ $bankname="부산은행"; 
				}else if($row['s_bnkCd']=="DAEGU_031"){ $bankname="대구은행"; 
				}else if($row['s_bnkCd']=="SANUP_002"){ $bankname="산업은행"; 
				}else if($row['s_bnkCd']=="POSTOFFICE_071"){ $bankname="우체국"; 
				}else if($row['s_bnkCd']=="SINHYUB_048"){ $bankname="신협"; 
				}else if($row['s_bnkCd']=="KWANGJU_034"){ $bankname="광주은행"; 
				}else if($row['s_bnkCd']=="SB_050"){ $bankname="상호저축은행"; 
				}else if($row['s_bnkCd']=="NONGHYUP_012"){ $bankname="단위농협"; 
				}else if($row['s_bnkCd']=="KYONGNAM_039"){ $bankname="경남은행"; 
				}else if($row['s_bnkCd']=="JEONBUK_037"){ $bankname="전북은행"; 
				}else if($row['s_bnkCd']=="SUHYUP_007"){ $bankname="수협"; 
				}else if($row['s_bnkCd']=="HSBC_054"){ $bankname="HSBC"; 
				}else if($row['s_bnkCd']=="SUCHULIB_008"){ $bankname="수출입"; 
				}else if($row['s_bnkCd']=="CHOHUNG_021"){ $bankname="(구)조흥은행"; 
				}else if($row['s_bnkCd']=="JEJU_035"){ $bankname="제주은행"; 
				}else{
					$bankname="가상계좌미발급";
				}
				
				$num = $i -1;

			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".$num."")
						 ->setCellValue("B$i", "".$row['m_id']."")
						 ->setCellValue("C$i", "".$row['m_name']."")
						 ->setCellValue("D$i", "".$row['s_memGuid']."")
						 ->setCellValue("E$i", "[".$bankname."] ".$row['s_accntNo']."")
						 ->setCellValue("F$i", "".substr($row[phoneNo],0,3)."-".substr($row[phoneNo],3,4)."-".substr($row[phoneNo],7,4)."");		 
;
		 }

	break;


	/*매출현황*/
	case "invest_setup_form":

	/*투자참여인원 리스트*/
	$sql="select m_id, m_name, i_pay, i_regdatetime from mari_invest  where loan_id='$loan_id' order by i_regdatetime desc"; 
	$result=sql_query($sql, false);
	
	/*투자참여인원 리스트*/
	$sql="select count(*) as cnt from mari_invest  where loan_id='$loan_id' order by i_regdatetime desc"; 
	$play_cnt = sql_fetch($sql, false);
	$wr_count = $play_cnt['cnt'];
					

	if (!$wr_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 
		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");

	 	 //$objPHPExcel->getActiveSheet()->getDefaultRowDimension()->setAutoSize(true);
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "NO")
					 ->setCellValue("B1", "회원명")
					 ->setCellValue("C1", "투자금액")
					 ->setCellValue("D1", "전화번호")
					 ->setCellValue("E1", "출금계좌정보")
					 ->setCellValue("F1", "예금주");

;
	
				 
	 
		// for 문을 이용해 DB에서 가져온 데이터를 순차적으로 입력한다.
		 // 변수 i의 값은 2부터 시작하도록 해야한다.
		 for ($i=2; $row=sql_fetch_array($result); $i++)
		 {    
			 	$num=$i - 1;
				$sql = "select * from mari_member where m_id = '$row[m_id]'";
				$out_info = sql_fetch($sql);

				if($out_info['m_my_bankcode']=="SHINHAN_088"){ $bankname="신한은행"; 
				}else if($out_info['m_my_bankcode']=="KIUP_003"){ $bankname="기업은행"; 
				}else if($out_info['m_my_bankcode']=="KUKMIN_004"){ $bankname="국민은행"; 
				}else if($out_info['m_my_bankcode']=="WOORI_020"){ $bankname="우리은행"; 
				}else if($out_info['m_my_bankcode']=="KEB_005"){ $bankname="외환은행"; 
				}else if($out_info['m_my_bankcode']=="NONGHYUP_011"){ $bankname="농협중앙회"; 
				}else if($out_info['m_my_bankcode']=="NONGHYUP_010"){ $bankname="농협"; 
				}else if($out_info['m_my_bankcode']=="HANA_081"){ $bankname="하나은행"; 
				}else if($out_info['m_my_bankcode']=="SC_023"){ $bankname="SC제일은행"; 
				}else if($out_info['m_my_bankcode']=="CITY_027"){ $bankname="한국씨티은행"; 
				}else if($out_info['m_my_bankcode']=="SAEMAEULGEUMGO_045"){ $bankname="새마을금고"; 
				}else if($out_info['m_my_bankcode']=="BUSAN_032"){ $bankname="부산은행"; 
				}else if($out_info['m_my_bankcode']=="DAEGU_031"){ $bankname="대구은행"; 
				}else if($out_info['m_my_bankcode']=="SANUP_002"){ $bankname="산업은행"; 
				}else if($out_info['m_my_bankcode']=="POSTOFFICE_071"){ $bankname="우체국"; 
				}else if($out_info['m_my_bankcode']=="SINHYUB_048"){ $bankname="신협"; 
				}else if($out_info['m_my_bankcode']=="KWANGJU_034"){ $bankname="광주은행"; 
				}else if($out_info['m_my_bankcode']=="SB_050"){ $bankname="상호저축은행"; 
				}else if($out_info['m_my_bankcode']=="NONGHYUP_012"){ $bankname="단위농협"; 
				}else if($out_info['m_my_bankcode']=="KYONGNAM_039"){ $bankname="경남은행"; 
				}else if($out_info['m_my_bankcode']=="JEONBUK_037"){ $bankname="전북은행"; 
				}else if($out_info['m_my_bankcode']=="SUHYUP_007"){ $bankname="수협"; 
				}else if($out_info['m_my_bankcode']=="HSBC_054"){ $bankname="HSBC"; 
				}else if($out_info['m_my_bankcode']=="SUCHULIB_008"){ $bankname="수출입"; 
				}else if($out_info['m_my_bankcode']=="CHOHUNG_021"){ $bankname="(구)조흥은행"; 
				}else if($out_info['m_my_bankcode']=="021"){ $bankname="(구)조흥은행"; 
				}else if($out_info['m_my_bankcode']=="088"){ $bankname="신한은행"; 
				}else if($out_info['m_my_bankcode']=="농협"){ $bankname="농협"; 
				}else if($out_info['m_my_bankcode']=="JEJU_035"){ $bankname="제주은행";
				}else{ $bankname="";}

					
			// Add some data
			 $objPHPExcel->setActiveSheetIndex(0)
						 ->setCellValue("A$i", "".$num."")
						 ->setCellValue("B$i", "".$row['m_name']."")
						 ->setCellValue("C$i", "".number_format($row['i_pay'])."원")
						 ->setCellValue("D$i", "".substr($out_info[m_hp],0,3)."-".substr($out_info[m_hp],3,4)."-".substr($out_info[m_hp],7,4)."")
						 ->setCellValue("E$i", "$bankname $out_info[m_my_bankacc]")
						 ->setCellValue("F$i", "".$out_info['m_my_bankname']."");						 
;
		 }

	break;


/*전자결제거래내역 추가 - 20170927 전인성*/
	case "payment_deal_list":
	
	$sql = "SELECT A.*, B.s_accntNo FROM mari_seyfert_order A LEFT JOIN mari_seyfert B ON A.m_id = B.m_id";
	$result = sql_query($sql);
	$result_count  = mysql_num_rows($result);
	
	if (!$result_count)
	   alert("출력할 내역이 없습니다.");
	 
		/** PHPExcel */
		 require_once("../PHPExcel/Classes/PHPExcel.php");
		 

		 /*메모리 제한 해제*/
		 ini_set("memory_limit" , -1);

		// Create new PHPExcel object
		 $objPHPExcel = new PHPExcel();
		 
		// Set properties
		 $objPHPExcel->getProperties()->setCreator("작성자")
									  ->setLastModifiedBy("최종수정자")
									  ->setTitle("타이틀")
									  ->setSubject("제목")
									  ->setCategory("License Hama");
	 
	
	
		 $objPHPExcel->setActiveSheetIndex(0)
					 ->setCellValue("A1", "번호")
					 ->setCellValue("B1", "대출번호")
					 ->setCellValue("C1", "아이디")
					 ->setCellValue("D1", "가상계좌")
					 ->setCellValue("E1", "이름")
					 ->setCellValue("F1", "입찰금액")
					 ->setCellValue("G1", "거래메세지")
					 ->setCellValue("H1", "거래번호")
					 ->setCellValue("I1", "주문번호")
					 ->setCellValue("J1", "접수일자")
					 ->setCellValue("K1", "결제동의")
					 ->setCellValue("L1", "타입")
					 ->setCellValue("M1", "펀딩해제")			 
					 ->setCellValue("N1", "투자취소여부")
					 ;
		
		for ($i=2; $row=sql_fetch_array($result); $i++)
		{ 
			/*대출번호*/
			if(!$row['loan_id']){
				$loan_id = '없음';
			}else if($row['loan_id']){
				$loan_id = $row['loan_id'];
			}
			
			/*결제동의*/
			if($row['s_payuse']=='N'){
				$payuse = "N";
			}else if($row['s_payuse']=='Y'){
				$payuse = "Y";
			}else if($row['s_payuse']=='Y'){
				$payuse = "결제취소";
			}
			
			/*타입*/
			 if($row['s_type']=='1'){
				$type="투자출금";
			 }else if($row['s_type']=='2'){
				$type="잔액출금";
			 }else if($row['s_type']=='3'){
				$type="계좌주검증";
			 }else if($row['s_type']=='4'){
				$type="입금";
			 }
			
			/*펀딩해제*/
			 if($row['s_release']=='N'){
				$release = "N";
			 }else if($row['s_release']=='Y'){
				$release = "Y";
			 }

			/*투자취소여부*/
			if($row['o_funding_cancel']=="N"){
				$funding_cancel = "N";
			}else if($row['o_funding_cancel']=="Y"){
				$funding_cancel = "Y";
			}


			// Add some data
			$objPHPExcel->setActiveSheetIndex(0)
						->setCellValue("A$i","$row[s_id]" )
						->setCellValue("B$i", "$loan_id")
						->setCellValue("C$i", "$row[m_id]")
						->setCellValue("D$i", " ".$row[s_accntNo]."")
						->setCellValue("E$i", "$row[m_name]")
						->setCellValue("F$i", "$row[s_amount]원")
						->setCellValue("G$i", "$row[s_subject]")
						->setCellValue("H$i", "$row[s_tid]")
						->setCellValue("I$i", "$row[s_refId]")
						->setCellValue("J$i", "".substr($row['s_date'],0,10)."")
						->setCellValue("K$i", "$payuse")
						->setCellValue("L$i", "$type")
						->setCellValue("M$i", "$release")
						->setCellValue("N$i", "$funding_cancel")
						;
;
		 }
	
	break;




 }/*switch*/
// Rename sheet
 $objPHPExcel->getActiveSheet()->setTitle("".$dwtype."");
 
// Set active sheet index to the first sheet, so Excel opens this as the first sheet
 $objPHPExcel->setActiveSheetIndex(0);
 
$data = date("ymd", time());
 $filename = iconv("UTF-8", "EUC-KR", "".$dwtype."_$data");
 
// Redirect output to a client’s web browser (Excel5)
 header('Content-Type: application/vnd.ms-excel');
 header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
 header('Cache-Control: max-age=0');
 
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
$objWriter->save('php://output');

// Redirect output to a client’s web browser (Excel2007)
/*
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="01simple.xlsx"');
header('Cache-Control: max-age=0');

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('php://output');
*/

 exit;

    if ($i == 0)
        alert("자료가 없습니다.");

    exit;

?>