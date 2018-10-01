<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script>
/* Kurien / Kurien's Blog / http://blog.kurien.co.kr */
/* 주석만 제거하지 않는다면, 어떤 용도로 사용하셔도 좋습니다. */

function kCalendar(id, date) {
	var kCalendar = document.getElementById(id);
	
	if( typeof( date ) !== 'undefined' ) {
		date = date.split('-');
		date[1] = date[1] - 1;
		date = new Date(date[0], date[1], date[2]);
	} else {
		var date = new Date();
	}
	var currentYear = date.getFullYear();
	//년도를 구함
	
	var currentMonth = date.getMonth() + 1;
	//연을 구함. 월은 0부터 시작하므로 +1, 12월은 11을 출력
	
	var currentDate = date.getDate();
	//오늘 일자.
	
	date.setDate(1);
	var currentDay = date.getDay();
	//이번달 1일의 요일은 출력. 0은 일요일 6은 토요일
	
	var dateString = new Array('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
	var lastDate = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if( (currentYear % 4 === 0 && currentYear % 100 !== 0) || currentYear % 400 === 0 )
		lastDate[1] = 29;
	//각 달의 마지막 일을 계산, 윤년의 경우 년도가 4의 배수이고 100의 배수가 아닐 때 혹은 400의 배수일 때 2월달이 29일 임.
	
	var currentLastDate = lastDate[currentMonth-1];
	var week = Math.ceil( ( currentDay + currentLastDate ) / 7 );
	//총 몇 주인지 구함.
	
	if(currentMonth != 1)
		var prevDate = currentYear + '-' + ( currentMonth - 1 ) + '-' + currentDate;
	else
		var prevDate = ( currentYear - 1 ) + '-' + 12 + '-' + currentDate;
	//만약 이번달이 1월이라면 1년 전 12월로 출력.
	
	if(currentMonth != 12) 
		var nextDate = currentYear + '-' + ( currentMonth + 1 ) + '-' + currentDate;
	else
		var nextDate = ( currentYear + 1 ) + '-' + 1 + '-' + currentDate;
	//만약 이번달이 12월이라면 1년 후 1월로 출력.

	
	if( currentMonth < 10 )
		var currentMonth = '0' + currentMonth;
	//10월 이하라면 앞에 0을 붙여준다.
	
	var calendar = '';
	
	calendar += '<div id="header">';
	calendar += '			<span><a href="#" class="button left" onclick="kCalendar(\'' +  id + '\', \'' + prevDate + '\')"><</a></span>';
	calendar += '			<span id="date">' + currentYear + '년 ' + currentMonth + '월</span>';
	calendar += '			<span><a href="#" class="button right" onclick="kCalendar(\'' + id + '\', \'' + nextDate + '\')">></a></span>';
	calendar += '		</div>';
	calendar += '		<table border="0" cellspacing="0" cellpadding="0">';
	calendar += '		<colgroup>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		<col width="14%"/>';
	calendar += '		</colgroup>';
	calendar += '			<thead>';
	calendar += '				<tr>';
	calendar += '				  <th class="sun" scope="row">일</th>';
	calendar += '				  <th class="mon" scope="row">월</th>';
	calendar += '				  <th class="tue" scope="row">화</th>';
	calendar += '				  <th class="wed" scope="row">수</th>';
	calendar += '				  <th class="thu" scope="row">목</th>';
	calendar += '				  <th class="fri" scope="row">금</th>';
	calendar += '				  <th class="sat" scope="row">토</th>';
	calendar += '				</tr>';
	calendar += '			</thead>';
	calendar += '			<tbody>';
	
	var dateNum = 1 - currentDay;
	
	for(var i = 0; i < week; i++) {
		calendar += '			<tr>';

		for(var j = 0; j < 7; j++, dateNum++) {

		var i_repay_day = "<?php echo $schedule[mari_loan]?>";
		/*년월*/
		var YearandMonth = currentYear+''+ currentMonth;

			if( dateNum < 1 || dateNum > currentLastDate ) {
				calendar += '<td class="' + dateString[j] + '"> </td>';
				continue;
			}
			calendar += '<td class="' + dateString[j] + '">'+ dateNum +'<br/>';
		<?php


		  for ($i=0; $scdview=sql_fetch_array($scdlist); $i++) {

			/*투자자 투자한 대출건의 대출시작일, 대출기간, 상환일 가져오기*/
			$sql = " select i_subject, i_loan_day, i_repay_day,  i_loanexecutiondate from mari_loan where i_id='$myloan[loan_id]'";
			$loanmonth = sql_fetch($sql, false);

			$sql = " select * from mari_order where loan_id='$scdview[loan_id]' and sale_id='$user[m_id]' order by o_datetime desc";
			$orderview = sql_fetch($sql, false);

			$sql = " select loan_id from mari_invest where loan_id='$scdview[loan_id]' and m_id='$user[m_id]' order by i_regdatetime desc";
			$investview = sql_fetch($sql, false);

			$o_count=$orderview[o_count];

			$end_loanexecutiondate = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$loanmonth[i_loan_day]."month"));



			$Y_sdate = date("Y", strtotime( $scdview[r_orderdate] ) );
			$M_sdate = date("m", strtotime( $scdview[r_orderdate] ) );
			$D_sdate = date("d", strtotime( $scdview[r_orderdate] ) );

			$YearandMonth = "".$Y_sdate."".$M_sdate."";

			/*대출기간 뽑아오기*/
			/*
			$sql = " select * from mari_loan, i_repay_day where i_id='$myloan[loan_id]' and i_loanexecutiondate between '$loanmonth[i_loanexecutiondate]' and '".$end_loanexecutiondate."'";
			$schedule = sql_fetch($sql, false);
			*/
			/*선택한 달력의 년월과 상환마지막일자와 비교를 위한 시작날짜*/
			$Y_date = date("Y", strtotime( $loanmonth[i_loanexecutiondate] ) );
			$M_date = date("m", strtotime( $loanmonth[i_loanexecutiondate] ) );
			$start_loanexecutiondates = "".$Y_date."".$M_date."";
			/*선택한 달력의 년월과 상환마지막일자와 비교를 위한 종료날짜*/
			$end_loanexecutiondates = date("Ym", strtotime($loanmonth[i_loanexecutiondate]."+".$loanmonth[i_loan_day]."month"));
		?>
	<?php if($scdview[r_view]=="Y" && $investview[loan_id]){?>
		if(YearandMonth == <?php echo $YearandMonth?> && dateNum == <?php echo $D_sdate?>){

			calendar += "<?php if($scdview[r_salestatus]=='정산완료'){?><p><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?><?php echo $scdview[r_count]?>회차 <b>정산완료</b></p><?php }else if($scdview[r_salestatus]=='연체중'){?><p class=color_re2><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?> <?php echo $scdview[r_count]?>회차<b>연체중</b></p><?php }else{?><p><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?> <?php echo $scdview[r_count]?>회차<b>상환예정</b><?php }?></p>"+ '';
		}else{
			calendar +=  ""+ '';
		}
	<?php }else{?>
			calendar +=  ""+ '';

	<?php }?>

		<?php 
		  }
		?>
			calendar += '			</td>';
		}
		calendar += '			</tr>';
	}
	
	calendar += '			</tbody>';
	calendar += '		</table>';	

	kCalendar.innerHTML = calendar;
}
</script>

<div id="container">
	<div id="sub_content">
		<div class="mypage" >
			<div class="mypage_inner">

				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong>예치금 : <span class=""><?php echo number_format($user[m_emoney]) ?></span>원</strong>
						</div>

						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>투자정보</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info">투자관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_calculate_schedule" class="info_current">정산 스케줄</a></li>
								</ul>
							</h3>
							<div class="dashboard_invest_info">	
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 정산예정안내</h3>
								<span>현재까지 투자한 내역에 대한 정산스케줄입니다.</span>
								<div>
									<div id="kCalendar"></div>
									<script>
										window.onload = function () {
											kCalendar('kCalendar');
										};
									</script>
								</div>
								<div>
									<table>
										<colgroup>
											<col width="166px">
											<col width="93px">
											<col width="117px">
											<col width="127px">
											<col width="80px">
											<col width="100px">
										</colgroup>
										<thead>
											<tr>
												<th>정산일자</th>
												<th>투자원금</th>
												<th>상품명</th>
												<th>정산회차</th>
												<th>정산금액</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>
		<?php

		/*투자자 투자한 대출건가져오기*/
		$sql = " select * from mari_invest where m_id='$user[m_id]'";
		$myloanlist = sql_query($sql, false);

		  for ($i=0; $myloan=sql_fetch_array($myloanlist); $i++) {

			/*투자자 투자한 대출건의 대출시작일, 대출기간, 상환일 가져오기*/
			$sql = " select * from mari_loan where i_id='$myloan[loan_id]'";
			$loanmonth = sql_fetch($sql, false);



		?>

		<?php
		//원리금균등분할상환 
		if($loanmonth['i_repay']=="원리금균등상환"){
		?>
		<?php
			/*대출기간*/
			$ln_kigan=$loanmonth['i_loan_day'];
			/*투자금액*/
			$ln_money=$myloan['i_pay'];
			/*연이자율*/
			$ln_iyul=$loanmonth['i_year_plus'];

			$ln_kigan = $ln_kigan - $stop;

			$일년이자 = $ln_money*($ln_iyul/100);
			$첫달이자 = substr(($일년이자/12),0,-1)."0";
		?>
				<?php
				$sumPrice = "0"; 
				$rate = (($ln_iyul/100)/12); 
				$상환금 = ($ln_money*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 
				for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
					$납입원금계 += ($상환금-$첫달이자);
					$잔금 = $ln_money-$납입원금계;
					$납입원금 = $상환금-$첫달이자;
					$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
					/*정산일자 구하기*/
					$order_date = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$i."month"));
					$sql = " select * from mari_order where loan_id='$myloan[loan_id]' and sale_id='$user[m_id]' and o_count='".$i."' order by o_datetime desc";
					$orderview = sql_fetch($sql, false);

					$sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
					$scdview = sql_fetch($sql, false);
				?>
												<tr>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php echo $loanmonth[i_subject]?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i?>회</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }else{?>준비중<?php }?></td>												
												</tr>
				<?php
						$이자합산 += $첫달이자;
						$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
						$월불입금합산=$납입원금합산+$이자합산;
						$일년이자 = $잔금*($ln_iyul/100);
						$첫달이자 = substr(($일년이자/12),0,-1)."0";
				} 
				?>

		<?php
		}else{
		?> 
				<?php

				/*대출기간*/
				$ln_kigan=$loanmonth['i_loan_day'];
				/*투자금액*/
				$ln_money=$myloan['i_pay'];
				/*연이자율*/
				$ln_iyul=$loanmonth['i_year_plus'];

				$일년이자 = $ln_money*($ln_iyul/100);
				$첫달이자 = substr(($일년이자/12),0,-1)."0";
				$ln_kigan_con=$ln_kigan-1;
				$전체이자=$첫달이자*$ln_kigan_con;
				for($i=1; $i<=$ln_kigan; $i++){
				/*정산일자 구하기*/
				$order_date = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$i."month"));
				$sql = " select * from mari_order where loan_id='$myloan[loan_id]' and sale_id='$user[m_id]' and o_count='".$i."' order by o_datetime desc";
				$orderview = sql_fetch($sql, false);

				$sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
				$scdview = sql_fetch($sql, false);
				?>
												<tr>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php echo $loanmonth[i_subject]?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i?>회</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }else{?>준비중<?php }?></td>
												</tr>
				<?php
				$이자합산 += $첫달이자;
				$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
				$월불입금합산=$만기이자+$전체이자;
					} 
				?>
		<?php }?>
					</tr>
				<?php
					} 

				   if ($i == 0)
				      echo "<tr><td colspan=\"6\">스케줄 정보가 없습니다.</td></tr>";
				?>
										</tbody>
									</table>	
								<a href="{MARI_HOME_URL}/?mode=mypage_schedule" class="btn_more mt20 mb20">더보기</a>									
							</div><!--dashboard_interest-->
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}