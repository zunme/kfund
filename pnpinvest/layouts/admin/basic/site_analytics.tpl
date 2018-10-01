<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_PLUGIN_PATH.'/jquery-ui/datepicker.php');

?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 사이트 로그분석
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
			<div class="title01">로그분석</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">로그분석</div>

		<ul class="tab_btn1 pl20">
			<li class="<?php echo $stype=='time' || $stype=='day' || $stype=='month' || $stype=='year' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time">접속자분석</a></li>
			<li class="<?php echo $stype=='os' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=os">OS</a></li>
			<li class="<?php echo $stype=='bw' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=bw">브라우저</a></li>
			<li class="<?php echo $stype=='log' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=log">접속경로</a></li>
			<li class="<?php echo $cms=='sales_report'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=sales_report">매출리포트</a></li>
		</ul>
		<?php if($stype=='time' || $stype=='day' || $stype=='month'|| $stype=='year'){?>
		<ul class="tab_btn1 pl20">
			<li class="<?php echo $stype=='time' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time">시간대별</a></li>
			<li class="<?php echo $stype=='day' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=day">일별</a></li>
			<li class="<?php echo $stype=='month' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=month">월별</a></li>
			<li class="<?php echo $stype=='year' && $cms=='site_analytics'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=year">년별</a></li>
		</ul>
		<?php }?>
		<?php if($stype=='os' || $stype=='bw'){?>
		<?php }else{?>
		<form name="reportFrm" method="post" class="local_sch01 local_sch">
		<input type="hidden" name="inquiry" value="Y">
			<span class="fb" style="display:inline;">조회 기간 :</span>
			<input type="text" name="s_date" value="<?php echo $s_date ?>" id="s_date" class="frm_input" size="11" maxlength="10">
			<label for="s_date" class="sound_only">시작일</label>
		~
			<input type="text" name="e_date" value="<?php echo $e_date ?>" id="e_date" class="frm_input" size="11" maxlength="10">
			<label for="e_date" class="sound_only">종료일</label>
			<input type="image" src="{MARI_ADMINSKIN_URL}/img/inquiry3_btn.png" alt="조회"  onclick="submit();" />
		</form>
		<?php }?>
<!--시간대별-->
<?php if($stype=="time"){?>
       <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


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
    $k = 0;
    if ($i) {
        for ($i=0; $i<24; $i++) {
            $realtime = sprintf("%02d", $i);
            $count = (int)$arr[$realtime];

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);
    ?>
		{
                    "year": <?php echo $realtime ?>,
                    "income": <?php echo number_format($count) ?>,
                    "expenses": <?php echo $r_connection ?>
                }, 
    <?php
        }
    } else {

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
                    title: "접속인원",
                    valueField: "income",
                    lineAlpha: 0,
                    fillAlphas: 0.8,
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>명"
                }, {
                    type: "line",
                    title: "접속비율",
                    valueField: "expenses",
                    lineThickness: 2,
                    fillAlphas: 0,
                    bullet: "round",
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>%"
                }],
                legend: {
                    useGraphSettings: true
                }

            });

            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "회원",
                    "litres": <?php echo $mem_con?>
                }, 
		{
                    "country": "비회원",
                    "litres": <?php echo $lognon_cn?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>



        <div id="chartdiv1" style="width: 100%; height: 400px;"></div>
        <div id="chartdiv2" style="width: 100%; height: 400px;"></div>

<!--일별-->
<?php }else if($stype=="day"){?>
       <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


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
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
					    if (count($arr)) {
						foreach ($arr as $key=>$value) {
						$day+=1;
						    $count = $value;

						    $connection = ($count / $sum_count * 100);
						    $r_connection = number_format($connection, 1);
						    $order_month = date("Y-m-d", strtotime($key."+".$key."month"));
						    $jinday_count = date('t', strtotime("".$order_month.""));
						    $key_day=$jinday_count-($jinday_count)+$day;
						    $monthday= date("Ymd", strtotime( $key ) );
						    $sunday= date("d", strtotime( $key ) );

							/*로그분석 일별제대로안되서 수정 2017-03-02 임근호*/
							$sql ="select * from mari_log_sum where ls_date='$monthday'";
							$logsum = sql_fetch($sql,false);

					    ?>
							{
							    "year": <?php echo $sunday ?>,
							    "income": <?php echo $logsum['ls_count'] ?>,
							    "expenses": <?php echo $r_connection ?>
							}, 
					    <?php
						}
					    } else {

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
                    title: "접속인원",
                    valueField: "income",
                    lineAlpha: 0,
                    fillAlphas: 0.8,
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>명"
                }, {
                    type: "line",
                    title: "접속비율",
                    valueField: "expenses",
                    lineThickness: 2,
                    fillAlphas: 0,
                    bullet: "round",
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>%"
                }],
                legend: {
                    useGraphSettings: true
                }

            });

            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "회원",
                    "litres": <?php echo $mem_con?>
                }, 
		{
                    "country": "비회원",
                    "litres": <?php echo $lognon_cn?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>



        <div id="chartdiv1" style="width: 100%; height: 400px;"></div>
        <div id="chartdiv2" style="width: 100%; height: 400px;"></div>

<!--월별-->
<?php }else if($stype=="month"){?>
       <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


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
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
    if (count($arr)) {
        foreach ($arr as $key=>$value) {
            $count = $value;

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);
		$key=$Y_date = date("Ymd", strtotime( $key ) );
    ?>
		{
                    "year": <?php echo $key ?>,
                    "income": <?php echo number_format($value) ?>,
                    "expenses": <?php echo $r_connection ?>
                }, 
    <?php
        }
    } else {

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
                    title: "접속인원",
                    valueField: "income",
                    lineAlpha: 0,
                    fillAlphas: 0.8,
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>명"
                }, {
                    type: "line",
                    title: "접속비율",
                    valueField: "expenses",
                    lineThickness: 2,
                    fillAlphas: 0,
                    bullet: "round",
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>%"
                }],
                legend: {
                    useGraphSettings: true
                }

            });

            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "회원",
                    "litres": <?php echo $mem_con?>
                }, 
		{
                    "country": "비회원",
                    "litres": <?php echo $lognon_cn?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>
        <div id="chartdiv1" style="width: 100%; height: 400px;"></div>
        <div id="chartdiv2" style="width: 100%; height: 400px;"></div>
<!--년별-->
<?php }else if($stype=="year"){?>
       <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


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
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
    if (count($arr)) {
        foreach ($arr as $key=>$value) {
            $count = $value;

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);
		$key=$Y_date = date("Ymd", strtotime( $key ) );
    ?>
		{
                    "year": <?php echo $key ?>,
                    "income": <?php echo $value ?>,
                    "expenses": <?php echo $r_connection ?>
                }, 
    <?php
        }
    } else {

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
                    title: "접속인원",
                    valueField: "income",
                    lineAlpha: 0,
                    fillAlphas: 0.8,
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>명"
                }, {
                    type: "line",
                    title: "접속비율",
                    valueField: "expenses",
                    lineThickness: 2,
                    fillAlphas: 0,
                    bullet: "round",
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>%"
                }],
                legend: {
                    useGraphSettings: true
                }

            });

            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "회원",
                    "litres": <?php echo $mem_con?>
                }, 
		{
                    "country": "비회원",
                    "litres": <?php echo $lognon_cn?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>
        <div id="chartdiv1" style="width: 100%; height: 400px;"></div>
        <div id="chartdiv2" style="width: 100%; height: 400px;"></div>
<?php }else if($stype=="os"){?>

		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>OS</th>
						<th>접속자수</th>
						<th>비율</th>
					</tr>
				</thead>
				<tbody>
    <?php
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
    if (count($arr)) {
        arsort($arr);
        foreach ($arr as $key=>$value) {
            $count = $arr[$key];
            if ($save_count != $count) {
                $i++;
                $no = $i;
                $save_count = $count;
            } else {
                $no = '';
            }

            if (!$key) {
                $key = '직접입력';
            }

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);

    ?>
		    <tr>
			<td><?php echo $key ?></td>
			<td><?php echo $count ?></td>
			<td><?php echo $r_connection ?>%</td>
		    </tr>
    <?php
        }
    } else {
        echo '<tr><td colspan="3">OS 로그자료가 없습니다.</td></tr>';
    }
    ?>
        <tr>
			<td colspan="3" >
				<script>
				    var chart;
				    var legend;

				    var chartData = [
			    <?php
			    $i = 0;
			    $k = 0;
			    $save_count = -1;
			    $tot_count = 0;
			    if (count($arr)) {
				arsort($arr);
				foreach ($arr as $key=>$value) {
				    $count = $arr[$key];
				    if ($save_count != $count) {
					$i++;
					$no = $i;
					$save_count = $count;
				    } else {
					$no = '';
				    }

				    if (!$key) {
					$key = '직접입력';
				    }

				    $connection = ($count / $sum_count * 100);
				    $r_connection = number_format($connection, 1);

			    ?>
					{
					    "country": "<?php echo $key ?>",
					    "value": <?php echo $r_connection ?>
					},
			    <?php
				}
			    } else {

			    }
			    ?>
				    ];

				    AmCharts.ready(function () {
					// PIE CHART
					chart = new AmCharts.AmPieChart();
					chart.dataProvider = chartData;
					chart.titleField = "country";
					chart.valueField = "value";
					chart.outlineColor = "#FFFFFF";
					chart.outlineAlpha = 0.8;
					chart.outlineThickness = 2;
					chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
					// this makes the chart 3D
					chart.depth3D = 15;
					chart.angle = 30;

					// WRITE
					chart.write("chartdiv");
				    });
				</script>
				<div id="chartdiv" style="width: 100%; height: 400px;"></div>
			</td>
	</tr>
				</tbody>
			</table>
		</div>
<?php }else if($stype=="bw"){?>

		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>브라우저</th>
						<th>접속자수</th>
						<th>비율</th>
					</tr>
				</thead>
				<tbody>
    <?php
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
    if (count($arr1)) {
        arsort($arr1);
        foreach ($arr1 as $key1=>$value) {
            $count = $arr1[$key1];
            if ($save_count != $count) {
                $i++;
                $no = $i;
                $save_count = $count;
            } else {
                $no = "";
            }

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);
    ?>
		    <tr>
			<td><?php echo $key1 ?></td>
			<td><?php echo $count ?></td>
			<td><?php echo $r_connection ?>%</td>
		    </tr>
    <?php
        }
    } else {
        echo '<tr><td colspan="3">브라우저 로그자료가 없습니다.</td></tr>';
    }
    ?>
    <tr>
			<td colspan="3" >
				<script>
				    var chart;
				    var legend;

				    var chartData = [
			    <?php
			    $i = 0;
			    $k = 0;
			    $save_count = -1;
			    $tot_count = 0;
			    if (count($arr1)) {
				arsort($arr1);
				foreach ($arr1 as $key1=>$value) {
				    $count = $arr1[$key1];
				    if ($save_count != $count) {
					$i++;
					$no = $i;
					$save_count = $count;
				    } else {
					$no = "";
				    }

				    $connection = ($count / $sum_count * 100);
				    $r_connection = number_format($connection, 1);
			    ?>
					{
					    "country": "<?php echo $key1 ?>",
					    "value": <?php echo $r_connection ?>
					},
			    <?php
				}
			    } else {

			    }
			    ?>
				    ];

				    AmCharts.ready(function () {
					// PIE CHART
					chart = new AmCharts.AmPieChart();
					chart.dataProvider = chartData;
					chart.titleField = "country";
					chart.valueField = "value";
					chart.outlineColor = "#FFFFFF";
					chart.outlineAlpha = 0.8;
					chart.outlineThickness = 2;
					chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
					// this makes the chart 3D
					chart.depth3D = 15;
					chart.angle = 30;

					// WRITE
					chart.write("chartdiv1");
				    });
				</script>
				<div id="chartdiv1" style="width: 100%; height: 400px;"></div>
			</td>
    </tr>
				</tbody>
			</table>
		</div>

<?php }else if($stype=="log"){?>
		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>접속IP</th>
						<th>접속자ID</th>
						<th>접속자NAME</th>
						<th>유입경로</th>
						<th>브라우저</th>
						<th>운영체제</th>
						<th>접속날짜</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        $brow = get_brow($row['lo_agent']);
        $os   = get_os($row['lo_agent']);

        $link = '';
        $link2 = '';
        $referer = '';
        $title = '';
        if ($row['lo_ccesspath']) {

            $referer = get_text(cut_str($row['lo_ccesspath'], 255, ''));
            $referer = urldecode($referer);

            if (!is_utf8($referer)) {
                $referer = iconv_utf8($referer);
            }

            $title = str_replace(array('<', '>', '&'), array("&lt;", "&gt;", "&amp;"), $referer);
            $link = '<a href="'.$row['lo_ccesspath'].'" target="_blank">';
            $link = str_replace('&', "&amp;", $link);
            $link2 = '</a>';
        }

        if ($brow == '기타') { $brow = '<span title="'.$row['lo_agent'].'">'.$brow.'</span>'; }
        if ($os == '기타') { $os = '<span title="'.$row['lo_agent'].'">'.$os.'</span>'; }


    ?>
		    <tr>
			<td><?php echo $row['lo_ip'] ?></td>
			<td><?php echo $row['m_id'] ?></td>
			<td><?php echo $row['m_name'] ?></td>
			<td><?php echo $link ?><?php echo $title ?><?php echo $link2 ?></td>
			<td><?php echo $brow ?></td>
			<td><?php echo $os ?></td>
			<td><?php echo $row['lo_date'] ?> <?php echo $row['lo_time'] ?></td>
		    </tr>
    <?php
    }
    if ($i == 0)
        echo '<tr><td colspan="7">로그자료가 없습니다.</td></tr>';
    ?>
				</tbody>
			</table>
		</div>
<div class="txt_c mb30">
	<?php
		if (isset($domain))
		$sqlstr .= "&amp;domain=$domain";
		$sqlstr .= "&amp;page=";

		$pagelist = get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&stype=log&s_date='.$s_date.'&e_date='.$e_date.''.$qstr.'&amp;page=');
		echo $pagelist;
	?>
</div>
<?php }else{?>
      <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


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
    $i = 0;
    $k = 0;
    $save_count = -1;
    $tot_count = 0;
    if (count($arr)) {
        foreach ($arr as $key=>$value) {
            $count = $value;

            $connection = ($count / $sum_count * 100);
            $r_connection = number_format($connection, 1);
		$key=$Y_date = date("Ymd", strtotime( $key ) );

    ?>
		{
                    "year": <?php echo $key ?>,
                    "income": <?php echo number_format($value) ?>,
                    "expenses": <?php echo $r_connection ?>
                }, 
    <?php
        }
    } else {

    }
    ?>
		],
                categoryField: "year",
                startDuration: 1,

                categoryAxis: {
                    gridPosition: "start"
                },
                valueAxes: [{
                    title: "Daily visitor"
                }],
                graphs: [{
                    type: "column",
                    title: "접속인원",
                    valueField: "income",
                    lineAlpha: 0,
                    fillAlphas: 0.8,
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>명"
                }, {
                    type: "line",
                    title: "접속일",
                    valueField: "expenses",
                    lineThickness: 2,
                    fillAlphas: 0,
                    bullet: "round",
                    balloonText: "[[title]] in [[category]]:<b>[[value]]</b>"
                }],
                legend: {
                    useGraphSettings: true
                }

            });

            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "회원",
                    "litres": <?php echo $mem_con?>
                }, 
		{
                    "country": "비회원",
                    "litres": <?php echo $lognon_cn?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>



        <div id="chartdiv1" style="width: 100%; height: 400px;"></div>
        <div id="chartdiv2" style="width: 100%; height: 400px;"></div>
<?php }?><!--stype-->
    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
$(function(){
    $("#s_date, #e_date").datepicker({ changeMonth: true, changeYear: true, dateFormat: "yy-mm-dd", showButtonPanel: true, yearRange: "c-99:c+99", maxDate: "+0d" });
});

function analytics_form_submit(act)
{
    var f = document.analytics_form;
    f.action = act;
    f.submit();
}
</script>

{# s_footer}<!--하단-->