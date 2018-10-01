<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script src="{MARI_PLUGIN_URL}/chart/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/serial.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/pie.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/light.js" type="text/javascript"></script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">매출리포트</div>
		<ul class="tab_btn1 pl20">
			<li class="<?php echo $stype=='time' || $stype=='day' || $stype=='month' || $stype=='year' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time">접속자분석</a></li>
			<li class="<?php echo $stype=='os' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=os">OS</a></li>
			<li class="<?php echo $stype=='bw' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=bw">브라우저</a></li>
			<li class="<?php echo $stype=='log' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=log">접속경로</a></li>
			<li class="<?php echo $cms=='sales_report'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=sales_report">매출리포트</a></li>
		</ul>
		 <div class="local_ov01 local_ov">
			<a href="{MARI_HOME_URL}/?cms=sales_report" class="ov_listall">전체목록</a>  투자 : <?php echo $invest_cn;?>명
		</div>

		<form name="reportFrm" method="post" class="local_sch01 local_sch">
			<span class="fb" style="display:inline;">조회 기간 :</span>
			<input type="text"  name="Year" value="<?=$Year?>" id=""  class="frm_input" size="10" /> <label for="">년</label>
			<input type="text" name="Month" value="<?=$Month?>" id=""  class="frm_input" size="10" /> <label for="">월</label>
			<input type="image" src="{MARI_ADMINSKIN_URL}/img/inquiry3_btn.png" alt="조회"  onclick="submit();" />
		</form>




			<ul class="m_cont1">	
				<li style="position:relative;">
					   <script>

					var chart1;
					var chart2;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1) {
						chart1.clear();
					    }
					    if (chart2) {
						chart2.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1 = AmCharts.makeChart("chartdiv1", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=$maxDate;$j++){
	$regdatetime=date("Y-m-d",strtotime($Year."-".$Month."-".$j));
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime' and i_pay_ment='N'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime' and i_pay_ment='Y'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime'";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
	if(!$pg_pay){
		$pg_pay="0";
	}
	if(!$totalpay){
		$totalpay="0";
	}
    ?>

						{
						    "year": <?php echo date("md",strtotime($Year."-".$Month."-".$j))?>,
						    "income": <?php echo $pg_pay ?>,
						    "expenses": <?php echo $totalpay ?>
						}, 
	<?php
	   }
	?>

						],
						categoryField: "year",
						startDuration: 1,

						categoryAxis: {
						    gridPosition: "start"
						},
						valueAxes: [{
						    title: ""
						}],
						graphs: [{
						    type: "column",
						    title: "결제완료",
						    valueField: "income",
						    lineAlpha: 0,
						    fillAlphas: 0.8,
						    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>원"
						}, {
						    type: "line",
						    title: "일합계",
						    valueField: "expenses",
						    lineThickness: 2,
						    fillAlphas: 0,
						    bullet: "round",
						    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>원(합)"
						}],
						legend: {
						    useGraphSettings: true
						}

					    });


					}


					</script>



					<div id="chartdiv1" style="width: 100%; height: 350px;"></div>
				</li><!-- /접속로그 -->
			</ul><!-- /m_cont1 -->

		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="100px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>날짜</th>

						<th>결제대기(입찰)</th>
						<th>결제완료</th>

						<th>일합계</th>
					</tr>
				</thead>
				<tbody>
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=$maxDate;$j++){
	$regdatetime=date("Y-m-d",strtotime($Year."-".$Month."-".$j));
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime' and i_pay_ment='N'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime' and i_pay_ment='Y'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where date(i_regdatetime) = '$regdatetime'";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
    ?>
					<tr>
						<td ><?=date("m-d",strtotime($Year."-".$Month."-".$j))?></td>

						<td><?=number_format($i_pay)?>원</td>
						<td><?=number_format($pg_pay)?>원</td>

						<td class="fb"><?=number_format($totalpay)?>원(합)</td>
					</tr>
	<?php
	   }
	?>
				</tbody>
			</table>
		</div>

		<div class="tbl_head01 tbl_wrap mt50">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="100px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="2">합계</th>
						<th>결제대기(입찰)</th>
						<th>결제완료</th>
						<th>총합계</th>
					</tr>
					<tr>
						<td><?php echo number_format($iamount) ?>원</td>
						<td><?php echo number_format($pgamount) ?>원</td>
						<td class="fb"><?php echo number_format($totalamount) ?>원</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="local_desc02">
			<p>
				1. 기본적으로 오늘날짜기준의 리포트를 보여줍니다.<br />
				2. 년,월단위 검색시 해당 월의 일짜별 매출을 보여줍니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->