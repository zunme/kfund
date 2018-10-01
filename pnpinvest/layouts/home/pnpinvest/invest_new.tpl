<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# header_sub}
<script src="{MARI_HOMESKIN_URL}/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_HOMESKIN_URL}/js/serial.js" type="text/javascript"></script>
<script src="{MARI_HOMESKIN_URL}/js/pie.js" type="text/javascript"></script>
<script src="{MARI_HOMESKIN_URL}/js/light.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
    $(".table_left li a ").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph_wrap2").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});
</script>

<main class="invest_new">
	
	<section class="play_1">
		<article class="play_2">
			<h2>플레이플랫폼 투자 지수</h2>

			<ul class="pFloat">
				<li class="pFloat_1">
					<span class="sapn_1">누적투자액</span><br/>
					<span class="sapn2"><?php echo number_format($t_pay);?>원</span>
				</li>
				<li class="pFloat_2">
					<span class="sapn_2">누적대출액</span><br/>
					<span class="sapn2"><?php echo number_format($t_loan_pay)?>원</span>
				</li>
				<li class="pFloat_3">
					<span class="sapn_3">누적상환액</span><br/>
					<span class="sapn2"><?php echo number_format($Loanrepayments);?>원</span>
				</li>
				<li class="pFloat_4">
					<span class="sapn_4">평균이자율(연)</span><br/>
					<span class="sapn2"><?php echo number_format($profit_avg,2)?>%</span>
				</li>
			</ul>

			<p class="time"><?php echo substr($date,0,4).'.'.substr($date,5,2).'.'.substr($date,8,2).' '.substr($date,11,5);?> 기준</p>
		</article>
	</section>
	
	<section class="backC">
	
		<div class="auto">
		<h3>투자현황</h3>
		<ul class="left_1">
			<li class="to_1">
				<p class="box-1">누적투자건</p>
				<p class="box-2"><?php echo number_format($acc_iv_total);?>건</p>
			</li>

			<li class="to_2">
				<p class="box-1">누적투자자수</p>
				<p class="box-2"><?php echo number_format($acc_iv_mem_total);?>명</p>
			</li>

			<li class="to_3">
				<p class="box-1">누적투자금액</p>
				<p class="box-2"><?php echo number_format($acc_iv_pay_total);?>원</p>
			</li>

			<li class="to_4">
				<p class="box-1">평균 투자 금액(인당)</p>
				<p class="box-2"><?php echo number_format($iv_avg_total_res);?>원</p>
			</li>

			<li class="to_5">
				<p class="box-1">평균 투자 금액(건당)</p>
				<p class="box-2"><?php echo number_format($iv_pdt_avg_res);?>원</p>
			</li>

			<li class="to_6">
				<p class="box-1">평균 수익률(연)</p>
				<p class="box-2"><?php echo number_format($profit_avg,2)?>%</p>
			</li>
		</ul>

		<div class="table_box">
		<p class="backimg"></p>
		<h4 class="h4img">조건별 투자 금액 통계</h4>

		
<div class="box1 loan_graph">
					<ul class="ulleft">
						<li class="current"><a href="#time2">시간대별</a></li>
						<li><a href="#day2">일별</a></li>
						<li><a href="#month2">월별</a></li>
						<li><a href="#year2">년별</a></li>
					</ul>
					<!--2016-11-14 임근호 사용보류
					<select>
						<option>선택하세요</option>
						<option>1</option>
						<option>2</option>
					</select>
					-->
					<div id="time2" class="graph_wrap2">
						<script>

					var chart1_4;
					var chart2_4;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_4) {
						chart1_4.clear();
					    }
					    if (chart2_4) {
						chart2_4.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_4 = AmCharts.makeChart("chartdiv5", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
      for ($i=0; $i<24; $i++) {
         $realtime = sprintf("%02d", $i);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59'";
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
						    "year": <?php echo $realtime ?>,
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
						    title: "시간대별합계",
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
<?php

?>

					}

					</script>
						<div id="chartdiv5" ></div>
					</div>
					<div id="day2" class="graph_wrap2">
						<script>

					var chart1_5;
					var chart2_5;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_5) {
						chart1_5.clear();
					    }
					    if (chart2_5) {
						chart2_5.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_5 = AmCharts.makeChart("chartdiv6", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=$maxDate;$j++){
	$regdatetime=date("Y-m-d",strtotime($Year."-".$Month."-".$j));
	$sql = "select sum(i_loan_pay) from mari_loan where date(i_regdatetime) = '$regdatetime'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where date(i_regdatetime) = '$regdatetime'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where date(i_regdatetime) = '$regdatetime'";
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
						    title: "일별합계",
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
<?php

?>

					}

					</script>
					<div id="chartdiv6" style="width: 95%; height: 350px;"></div>
					</div>
					<div id="month2" class="graph_wrap2">
						<script>

					var chart1_6;
					var chart2_6;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_6) {
						chart1_6.clear();
					    }
					    if (chart2_6) {
						chart2_6.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_6 = AmCharts.makeChart("chartdiv7", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=$maxDate;$j++){

	$order_month = date("Y-m-d", strtotime($date."+".$j."month"));
	$jinday_count = date('t', strtotime("".$order_month.""));

	$regdatetime=date("Y-m",strtotime($Year."-".$j.""));
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$regdatetime-01 00:00:00' and '$regdatetime-$jinday_count 00:00:00'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$regdatetime-01 00:00:00'  and '$regdatetime-$jinday_count 00:00:00'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '$regdatetime-01 00:00:00'  and '$regdatetime-$jinday_count 00:00:00'";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
	$pgdataview=date("ym",strtotime($Year."-".$j.""));
	if($pgdataview=="7001"){
	}else{
	if(!$pg_pay){
		$pg_pay="0";
	}
	if(!$totalpay){
		$totalpay="0";
	}
    ?>

						{
						    "year": <?php echo date("ym",strtotime($Year."-".$j.""))?>,
						    "income": <?php echo $pg_pay ?>,
						    "expenses": <?php echo $totalpay ?>
						}, 
	<?php
	}
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
						    title: "월별합계",
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
<?php

?>

					}

					</script>
					<div id="chartdiv7" style="width: 95%; height: 350px;"></div>
					</div>
					<div id="year2" class="graph_wrap2">
						<script>

					var chart1_7;
					var chart2_7;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_7) {
						chart1_7.clear();
					    }
					    if (chart2_7) {
						chart2_7.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_7 = AmCharts.makeChart("chartdiv8", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=9;$j++){


	$regdatetime=date("Y",strtotime($Year));
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_loan_pay) from mari_loan where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00' ";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
	$pgdataview=date("ym",strtotime($Year."-".$j.""));

	if(!$pg_pay){
		$pg_pay="0";
	}
	if(!$totalpay){
		$totalpay="0";
	}
    ?>


						{
						    "year": 201<?php echo $j?>,
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
						    title: "연별합계",
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
<?php

?>

					}

					</script>
						<div id="chartdiv8" style="width: 95%; height: 350px;"></div>
		</div>
		
</div>


							
							
		

<!--투자자비율 재투자 탭2016-11-07 박유나-->



</section>

<div class="backWrap">
	<section class="backWrap_center">

<div class="box2 box_mg tab_wrap3">
<div class="margin_1">
					<h4>투자자 비율 (단위 : %)</h4>
					<ul>
					<!--
						<li class="current"><a href="#tab5">연령</a></li>
						<li><a href="#tab6">재투자</a></li>	
					-->
					</ul>
			<canvas height="150" id="investor_age" width="330">.</canvas>		

</div>
</div>
<div class="box2 box_mg tab_wrap3">
					<h4>투자수익지수 (단위 : %)</h4>
					<ul>
					<!--
						<li class="current"><a href="#tab5">연령</a></li>
						<li><a href="#tab6">재투자</a></li>	
					-->
					</ul>
			<canvas height="150" id="investor" width="330">.</canvas>		

</div>

		
	</section>
</div>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js3/Chart.bundle.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js3/utils.js"></script>

<script>
/*투자자연령대비율*/
    var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };

    var config = {
        type: 'pie',
        data: {
            datasets: [{
              data : [<?php echo $age_20th_per;?>, <?php echo $age_30th_per;?>, <?php echo $age_40th_per;?>, <?php echo $age_50th_per;?>, <?php echo $age_60th_per;?>],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green,
                    window.chartColors.blue,
                ],
                label: '재투자 투자자비율'
            }],
            labels: [
                "20대",
                "30대",
                "40대",
                "50대",
                "60대"
            ]
        },
        options: {
            responsive: true
        }
    };
	 var ctx = $("#investor_age").get(0).getContext("2d");
        window.myPie = new Chart(ctx, config);

    </script>


<script>
/*투자수익지수*/
    var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };

    var config = {
        type: 'pie',
        data: {
            datasets: [{
              data : [<?php echo number_format($profits_1);?>, <?php echo number_format($profits_2);?>, <?php echo number_format($profits_3);?>,<?php echo number_format($profits_4);?>],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green
                ],
                label: '재투자 투자자비율'
            }],
            labels: [
                "100 ~ 200",
                "200 ~ 300",
                "300 ~ 500",
                "500이상"
            ]
        },
        options: {
            responsive: true
        }
    };
	 var ctx = $("#investor").get(0).getContext("2d");
        window.myPie = new Chart(ctx, config);

    </script>

							
							
		

<!--투자자비율 재투자 탭2016-11-07 박유나-->












<section class="backC">
	
		<div class="auto">
		<h3>대출현황</h3>
		<ul class="left_1">
			<li class="to_1">
				<p class="box-1">누적대출건</p>
				<p class="box-2"><?php echo number_format($acc_loa_total);?>건</p>
			</li>

			<li class="to_2">
				<p class="box-1">누적대출자수</p>
				<p class="box-2"><?php echo number_format($acc_loa_mem_total);?>명</p>
			</li>

			<li class="to_3">
				<p class="box-1">누적대출금액</p>
				<p class="box-2"><?php echo number_format($loa_pay_total);?>원</p>
			</li>

			<li class="to_4">
				<p class="box-1">누적상환금액</p>
				<p class="box-2"><?php echo number_format($repay_total);?>원</p>
			</li>

			<li class="to_5">
				<p class="box-1">대출 상환률</p>
				<p class="box-2"><?php echo number_format($repay_per,2);?>%</p>
			</li>

			<li class="to_6">
				<p class="box-1">대출 승인률</p>
				<p class="box-2"><?php echo number_format($agree_per,2);?>%</p>
			</li>
		</ul>
		<div class="table_box">
		<p class="backimg"></p>
		<h4 class="h4img">조건별 투자 금액 통계</h4>
	
	

		

<!--투자자비율 재투자 탭2016-11-07 박유나-->

<div class="box1 invest_graph">
					<ul class="ulleft">
						<li class="current"><a href="#time">시간대별</a></li>
						<li><a href="#day">일별</a></li>
						<li><a href="#month">월별</a></li>
						<li><a href="#year">년별</a></li>
					</ul>
					<!--2016-11-14 임근호 사용보류
					<select>
						<option>선택하세요</option>
						<option>1</option>
						<option>2</option>
					</select>
					-->
					<div id="time" class="graph_wrap">
						 <script>

					var chart1_0;
					var chart2_0;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_0) {
						chart1_0.clear();
					    }
					    if (chart2_0) {
						chart2_0.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_0 = AmCharts.makeChart("chartdiv1", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
      for ($i=0; $i<24; $i++) {
         $realtime = sprintf("%02d", $i);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59' and i_pay_ment='N'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59'  and i_pay_ment='Y'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$logdate $realtime:00:00' and '$logdate $realtime:59:59' ";
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
						    "year": <?php echo $realtime ?>,
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
						    title: "시간대별합계",
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
<?php

?>

					}

					</script>
						<div id="chartdiv1" ></div>

					</div>
					<div id="day" class="graph_wrap">
						<script>

					var chart1_1;
					var chart2_1;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_1) {
						chart1_1.clear();
					    }
					    if (chart2_1) {
						chart2_1.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_1 = AmCharts.makeChart("chartdiv2", {
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
						    title: "일별합계",
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
<?php

?>

					}

					</script>
					<div id="chartdiv2" style="width: 95%; height: 350px;"></div>
					</div>
					<div id="month" class="graph_wrap">
						 <script>

					var chart1_2;
					var chart2_2;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_2) {
						chart1_2.clear();
					    }
					    if (chart2_2) {
						chart2_2.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_2 = AmCharts.makeChart("chartdiv3", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=$maxDate;$j++){

	$order_month = date("Y-m-d", strtotime($date."+".$j."month"));
	$jinday_count = date('t', strtotime("".$order_month.""));

	$regdatetime=date("Y-m",strtotime($Year."-".$j.""));
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$regdatetime-01 00:00:00' and '$regdatetime-$jinday_count 00:00:00'  and i_pay_ment='N'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$regdatetime-01 00:00:00'  and '$regdatetime-$jinday_count 00:00:00' and i_pay_ment='Y'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '$regdatetime-01 00:00:00'  and '$regdatetime-$jinday_count 00:00:00'";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
	$pgdataview=date("ym",strtotime($Year."-".$j.""));
	if($pgdataview=="7001"){
	}else{
	if(!$pg_pay){
		$pg_pay="0";
	}
	if(!$totalpay){
		$totalpay="0";
	}
    ?>


						{
						    "year": <?php echo date("ym",strtotime($Year."-".$j.""))?>,
						    "income": <?php echo $pg_pay ?>,
						    "expenses": <?php echo $totalpay ?>
						}, 
	<?php
	}
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
						    title: "월별합계",
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
<?php

?>

					}

					</script>
					<div id="chartdiv3" style="width: 95%; height: 350px;"></div>
					</div>
					<div id="year" class="graph_wrap">
						<script>

					var chart1_3;
					var chart2_3;

					makeCharts("light", "");


					function makeCharts(theme, bgColor, bgImage) {

					    if (chart1_3) {
						chart1_3.clear();
					    }
					    if (chart2_3) {
						chart2_3.clear();
					    }

					    // background
					    if (document.body) {
						document.body.style.backgroundColor = bgColor;
						document.body.style.backgroundImage = "url(" + bgImage + ")";
					    }

					    // column chart
					    chart1_3 = AmCharts.makeChart("chartdiv4", {
						type: "serial",
						theme: theme,
						dataProvider: [
    <?php
	$subMonth = $Month > 9 ? $Month : substr($Month,1,1);
	for($j=1;$j<=9;$j++){


	$regdatetime=date("Y",strtotime($Year));
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00'  and i_pay_ment='N'";
	$pay=sql_query($sql, false);
	$i_pay = mysql_result($pay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00'  and i_pay_ment='Y'";
	$pgpay=sql_query($sql, false);
	$pg_pay = mysql_result($pgpay, 0, 0);
	$sql = "select sum(i_pay) from mari_invest where i_regdatetime between '201$j-1-1 00:00:00' and '201$j-12-$jinday_count 00:00:00' ";
	$toppay=sql_query($sql, false);
	$totalpay= mysql_result($toppay, 0, 0);
	$pgdataview=date("ym",strtotime($Year."-".$j.""));

	if(!$pg_pay){
		$pg_pay="0";
	}
	if(!$totalpay){
		$totalpay="0";
	}
    ?>


						{
						    "year": 201<?php echo $j?>,
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
						    title: "연별합계",
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
<?php

?>

					}
					
					</script>
					<div id="chartdiv4" style="width: 95%; height: 350px;"></div>
				</div>
				</div>
		
</section>























<div class="backWrap">
<div class="backWrap_center">
				<div class="box2 box_mg tab_wrap1">
					<h4>대출 상환 현황</h4>
					<!--<ul>
						<li class="current"><a href="#tab1">건수</a></li>
						<li class="current2"><a href="#tab2">금액</a></li>	
					</ul>-->
					<div class="graph1tab-content" id="tab1" >
						<canvas height="150" id="repay_number" width="330">.</canvas>
					</div>
					<div class="graph1tab-content" id="tab2" >
						<canvas height="150" id="repay_amount" width="330">.</canvas>
					</div>
				</div>
			
				<div class="box2 tab_wrap2" id="margin-5">
					<h4>대출 심사 현황</h4>
					<!--<ul>
						<li class="current3"><a href="#tab3">건수</a></li>
						<li class="current4"><a href="#tab4">금액</a></li>	
					</ul>-->
					<div class="graph2tab-content" id="tab3" >
						<canvas height="150" id="loan_number" width="330">.</canvas>
					</div>
					<div class="graph2 tab-content" id="tab4" >
						<canvas height="150" id="loan_amount" width="330">.</canvas>
					</div>
				</div>
				
</div>
</div>
<script>
$(function(){
	$("#tab2,#tab4").hide();
});
$(document).ready(function(){
	$(".current2").click(function(){
		$("#tab2").show();
		$("#tab1").hide();
	})
})
$(document).ready(function(){
	$(".current").click(function(){
		$("#tab1").show();
		$("#tab2").hide();
	})
})
$(document).ready(function(){
	$(".current4").click(function(){
		$("#tab4").show();
		$("#tab3").hide();
	})
})
$(document).ready(function(){
	$(".current3").click(function(){
		$("#tab3").show();
		$("#tab4").hide();
	})
})
</script>
 <script type="text/javascript">
 var data = {
  labels : ["1등급(S1)", "2등급(S2)", "3등급(S3)", "4등급(S4)", "5등급(S5)", "6등급(S6)", "7등급(S7)"],
  datasets : [{
   fillColor : "rgba(253,218,219,0.5)",
   strokeColor : "rgba(247,70,74,1)",
   pointColor : "rgba(247,70,74,1)",
   pointStrokeColor : "#fff",
   data : [65, 59, 90, 81, 56, 55,100]
  }, {
      fillColor : "rgba(204,237,253,0.5)",
   strokeColor : "rgba(0,163,244,1)",
   pointColor : "rgba(0,163,244,1)",
   pointStrokeColor : "#fff",
   data : [28, 48, 40, 19, 96, 27,80]
  }]
 };
 var ctx = $("#myChart3").get(0).getContext("2d");
 new Chart(ctx).Radar(data);
  
</script>

<!-- 투자 비율 분포 및 펀딩 성공률 금액 탭2016-11-07 박유나-->
<script type="text/javascript">
 var data = {
  labels : ["4등급(S1)", "2등급(S2)", "3등급(S3)", "4등급(S4)", "5등급(S5)", "6등급(S6)", "7등급(S7)"],
  datasets : [{
   fillColor : "rgba(253,218,219,0.5)",
   strokeColor : "rgba(247,70,74,1)",
   pointColor : "rgba(247,70,74,1)",
   pointStrokeColor : "#fff",
   data : [65, 59, 90, 81, 56, 55,100]
  }, {
      fillColor : "rgba(204,237,253,0.5)",
   strokeColor : "rgba(0,163,244,1)",
   pointColor : "rgba(0,163,244,1)",
   pointStrokeColor : "#fff",
   data : [28, 48, 40, 19, 96, 27,80]
  }]
 };
 var ctx = $("#myChart4").get(0).getContext("2d");
 new Chart(ctx).Radar(data);
  
</script>


<script type="text/javascript" src="{MARI_ADMINSKIN_URL}/js3/Chart.bundle.js"></script>
<script type="text/javascript" src="{MARI_ADMINSKIN_URL}/js3/utils.js"></script>
   
<!-- 대출상환현황 건수 탭2016-11-07 박유나-->





    <script>
    var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };

    var config = {
        type: 'bar',
        data: {
            datasets: [{
              data : [<?php echo $end_loa_total;?>, <?php echo $doing_loa_total;?>, <?php echo $finish_loa_total;?>,0],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow
                ],
                label: '마감, 상환중, 상환완료 건수'
            }],
            labels: [
                "펀딩마감",
                "상환중",
                "상환완료"
            ]
        },
        options: {
            responsive: true
        }
    };
	var ctx = document.getElementById("repay_number").getContext("2d");
        window.myPie = new Chart(ctx, config);

    </script>






<!-- 대출심사현황 건수 탭2016-11-07 박유나-->
   <script>
    var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };
    var config = {
        type: 'bar',
        data: {
            datasets: [{
              data : [<?php echo $acc_loa_total;?>, <?php echo $agree_total;?>, 0],
                backgroundColor: [
                    window.chartColors.green,
                    window.chartColors.red,

                ],
                label: '건수 별 대출 심사현황'
            }],
            labels: [
                "신청건수",
                "승인건수",

            ]
        },
        options: {
            responsive: true
        }
    };
	var ctx = document.getElementById("loan_number").getContext("2d");
        window.myPie = new Chart(ctx, config);

    </script>







</main>
 
{#footer}