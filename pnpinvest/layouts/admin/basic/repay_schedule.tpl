<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
/*START 일만기일시상환방식계산용*/
include (getcwd().'/module/calculation_base.php');
$ilmangitable= new ilmangitable();//변경사항적용
$ilmangidata = $ilmangitable->investInfoList();
//scdlist
$sql = "select a.*, b.i_repay from mari_repay_schedule a
join mari_loan b on a.loan_id = b.i_id and b.i_repay !='일만기일시상환'
order by r_orderdate desc";
$scdlist     = sql_query($sql, false);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<style>
#kCalendar table td p.ilmangip{background-color:#e5ebf3;margin-bottom: 3px;}
#kCalendar table td p.ilmangiendp{background-color:#FFCCFF;margin-bottom: 3px;}
</style>
<script src="{MARI_PLUGIN_URL}/chart/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/serial.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/pie.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/light.js" type="text/javascript"></script>
<script>

/*상환스케쥴 함수*/
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
		/*년월일*/
		var YearandMonthDay = currentYear+'-'+currentMonth+'-'+ dateNum;

			if( dateNum < 1 || dateNum > currentLastDate ) {
				calendar += '<td class="' + dateString[j] + '"> </td>';
				continue;
			}
			calendar += '<td class="' + dateString[j] + '"><b class="mb8">'+ dateNum +'일</b><br/>';
		<?php


		  for ($i=0; $scdview=sql_fetch_array($scdlist); $i++) {

			/*투자자 투자한 대출건의 대출시작일, 대출기간, 상환일 가져오기*/
			$sql = " select i_subject, i_loan_day, i_repay_day,  i_loanexecutiondate from mari_loan where i_id='$myloan[i_id]'";
			$loanmonth = sql_fetch($sql, false);

			$sql = " select * from mari_order where loan_id='$myloan[i_id]'  order by o_datetime desc";
			$orderview = sql_fetch($sql, false);

			$sql = " select count(*) as cnt from mari_order where  loan_id='$myloan[i_id]' and o_salestatus='정산완료'  order by o_datetime desc";
			$row = sql_fetch($sql);
			$order_count = $row[cnt];

			$o_count=$orderview[o_count];

			$end_loanexecutiondate = date("Y-m-d", strtotime($myloan[i_loanexecutiondate]."+".$myloan[i_loan_day]."month"));

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
			$Y_date = date("Y", strtotime( $myloan[i_loanexecutiondate] ) );
			$M_date = date("m", strtotime( $myloan[i_loanexecutiondate] ) );
			$start_loanexecutiondates = "".$Y_date."".$M_date."";
			/*선택한 달력의 년월과 상환마지막일자와 비교를 위한 종료날짜*/
			$end_loanexecutiondates = date("Ym", strtotime($myloan[i_loanexecutiondate]."+".$myloan[i_loan_day]."month"));
			if(!$scdview[r_orderdate]){
				$r_orderdate="0";
			}else{
				$r_orderdate=$scdview[r_orderdate];
			}
		?>
		<?php if($scdview[r_view]=="Y"){?>
			if(YearandMonth == <?php echo $YearandMonth?> && dateNum == <?php echo $D_sdate?>){

				calendar += "<?php if($scdview[r_salestatus]=='정산완료'){?><p><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?> <?php echo $scdview[r_count]?>회차<b>정산완료</b></p><?php }else if($scdview[r_salestatus]=='연체중'){?><p class=color_re2><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?> <?php echo $scdview[r_count]?>회차<b>연체중</b></p><?php }else{?><p><?=cut_str(strip_tags($scdview['r_subject']),22,'…')?> <?php echo $scdview[r_count]?>회차<b>상환예정</b><?php }?></p>"+ '';
			}else{
				calendar +=  ""+ '';
			}
		<?php }else{?>
				calendar +=  ""+ '';

		<?php }?>
		<?php
		  }
		?>
		<!-- start 일만기일시상환 추가-->
		<?php
			foreach( $ilmangidata as $myinvestInfoDate => $myinvestInfoRows) {
				foreach($myinvestInfoRows as $myinvestInfoRow){
		?>
		if(YearandMonth == <?php echo date("Ym", strtotime( $myinvestInfoDate ) );?> && dateNum == <?php echo date("d", strtotime( $myinvestInfoDate ) ) ;?> ){
			calendar += "<p class='<?php echo ($myinvestInfoRow['repaydate']==$myinvestInfoRow['enddate']) ? 'ilmangiendp': 'ilmangip';?>' title='<?php echo $myinvestInfoRow['days']?>일분 <?php echo number_format($myinvestInfoRow['inv']);?>원예상''><?php echo cut_str(strip_tags($myinvestInfoRow['i_subject']),22,'…')?><br> <?php echo $myinvestInfoRow['cnt']?>회차<?php echo ($myinvestInfoRow['repaydate']==$myinvestInfoRow['enddate']) ? '-만기': '';?>(<?php echo $myinvestInfoRow['days']?>일분)<b> <?php echo $myinvestInfoRow['status']?></b></p>";
		}
		<?php
				}
			}
		?>
		<!-- END 일만기일시상환 추가-->
			calendar += '			</td>';
		}
		calendar += '			</tr>';
	}

	calendar += '			</tbody>';
	calendar += '		</table>';

	kCalendar.innerHTML = calendar;
}
/* */
</script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02">상환스케쥴</div>
			<div class="dashboard_invest_info tbl_wrap ">
				<div>
					<div id="kCalendar"></div>
					<script>
						window.onload = function () {
							kCalendar('kCalendar');
						};
					</script>
				</div>


			</div><!--dashboard_interest-->

    </div><!-- /contaner -->
</div><!-- /wrapper -->
{# s_footer}<!--하단-->
