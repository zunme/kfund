<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
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
			<div class="title01">관리자메인</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="main_cont_wrap">

			<ul class="m_cont1">	
				<li class="new_member">
					<h3 class="m_title1">신규가입회원 7건 목록</h3>
					<table class="type_main1 txt_c">
						<caption>신규가입회원</caption>
						<thead>
						<tr>
							<th scope="col">회원아이디</th>
							<th scope="col">이름</th>
							<th scope="col">닉네임</th>
							<th scope="col">회원등급</th>
							<th scope="col">e-머니</th>
							<th scope="col">차단여부</th>
						</tr>
						</thead>
						<tbody>
					<?php
						for ($i=0; $row=sql_fetch_array($new_member); $i++) {
							$sql = "select  * from  mari_level where lv_level='$row[m_level]'";
							$lv = sql_fetch($sql, false);
							if($row['m_id']=="webmaster@admin.com"){
							}else{
					?>
							<tr>
								<td ><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php echo $row['m_id'];?></a></td>
								<td><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php echo $row['m_name'];?></a></td>
								<td><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php echo $row['m_nick'];?></a></td>
								<td ><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php echo $lv['lv_name']; ?></a></td>
								<td><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php echo number_format($row['m_emoney']) ?>원</a></td>
								<td ><a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no'];?>&type=m"><?php if($row['m_intercept_date']=="0000-00-00"){?>
									이용중
									<?php }else{?>
									차단중
									<?php }?>
									</a>
								</td>
							</tr>
					<?php
					}
					   }
					  if ($i == 0)
					      echo "<tr><td colspan=\"6\">회원 리스트가 없습니다.</td></tr>";
					?>
						</tbody>
					</table>
					<div class="btn_style1">
						<a href="{MARI_HOME_URL}/?cms=member_list">+회원 전체보기</a>
					</div>
				</li><!-- /신규가입회원목록 -->

				<li class="service_info">
					<h3 class="m_title2">서비스 정보</h3>
					<ul class="service_cont1">
						<li>
							<h4>홈페이지</h4>
							<p>{_mysv['service_subject']}</p>
						</li>
						<li>
							<h4>라이센스</h4>
							<p><?php if($license_ms['k_license_key']==$lc_key_user){?>인증완료<?php }else{?>미인증<?php }?></p>
						</li>
						<li>
							<h4>도메인</h4>
							<p>{_mysv['domain_url']}</p>
						</li>
						<li>
							<h4>호스팅</h4>
							<p>{_mysv['service_host_name']}</p>
						</li>
						<li>
							<h4>결제방식</h4>
							<p>{_mysv['extension_methods']}</p>
						</li>
						<li>
							<h4>호스팅만료일</h4>
							<p><?php echo substr($mysv['service_end_time'],0,10); ?></p>
						</li>
						<li>
							<h4>상품명</h4>
							<p>{_mysv['service_name']}</p>
						</li>
						<li>
							<h4>현재버전</h4>
							<p>{_mysv['service_ver']}</p>
						</li>
						<li class="txt_c"><a href="{MARI_HOME_URL}/?mode=main" target="_blank"><img src="{MARI_ADMINSKIN_URL}/img/btn_homepage.png" alt="홈페이지 바로가기" /></a></li>
					</ul>
					<!-- <table class="type_main2">
						<colgroup>
							<col width="50%" />
							<col width="50%" />
						</colgroup>
						<tbody>
							<tr>
								<th class="pt15"><span>홈페이지</span></th>
								<td class="pt15">사용자명</td>
							</tr>
							<tr>
								<th><span>라이센스</span></th>
								<td><?php echo $mysv['license_key'];?></td>
							</tr>
							<tr>
								<th><span>도메인</span></th>
								<td><?php echo $mysv['domain_url'];?></td>
							</tr>
							<tr>
								<th><span>호스팅</span></th>
								<td>기본형 10GB</td>
							</tr>
							<tr>
								<th><span>호스팅만료일</span></th>
								<td><?php echo substr($mysv['service_end_time'],0,10); ?></td>
							</tr>
							<tr>
								<th><span>상품명</span></th>
								<td><?php echo $mysv['service_name'];?></td>
							</tr>
							<tr>
								<th><span>현재버전</span></th>
								<td>Ver 1.0</td>
							</tr>
							<tr>
								<td colspan="2" class="txt_c pb15 pl0"><a href="{MARI_HOME_URL}/?mode=main" target="_blank"><img src="{MARI_ADMINSKIN_URL}/img/btn_homepage.png" alt="홈페이지 바로가기" /></a></td>
							</tr>
						</tbody>
					</table> -->
				</li><!-- /서비스정보 -->
			</ul><!-- /m_cont1 -->






			<ul class="m_cont1">	
				<li style="position:relative;">
					<h3 class="m_title1">접속로그 </h3>
					<span class="btn_style2" style="position:absolute; top:0; right:0;"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time">+자세히 보기</a></span>
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
					    $i = 0;
					    $k = 0;
					    $save_count = -1;
					    $tot_count = 1;
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


					}


					</script>



					<div id="chartdiv1" style="width: 100%; height: 350px; border:1px solid #d4d4d4; border-radius:0.5em;"></div>
				</li><!-- /접속로그 -->
			</ul><!-- /m_cont1 -->

  

			<ul class="m_cont2">
				<li class="ml0">
					<h3 class="m_title1">소식</h3>
					<table class="type_main1">
						<colgroup>
							<col width="" />
							<col width="100px" />
						</colgroup>
						<thead>
							<tr>
								<th>게시판</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
					<?php
							/*관리자 서버접속*/
							include_once(MARI_SQL_PATH.'/master_connect.php');
							

							$sql = "select * from mari_write where w_table = 'news' order by w_datetime desc limit 5 ";
							$noti = mysql_query($sql);
							for($i=0; $row=sql_fetch_array($noti); $i++){
					?>
							<tr>
								<td><a href="javascript:void(0);" onclick="noticePop<?php  echo $i;?>()"><?php echo $row['w_subject']; ?></a></td>
								<td><?php echo substr($row['w_datetime'],0,10); ?></td>
							</tr>

						<script>
							/*플랫폼관리자페이지 게시판 뷰페이지 팝업창*/
							function noticePop<?php  echo $i;?>() { 
							 var opt = "status=yes,toolbar=no,scrollbars=yes,width=1000,height=850,left=0,top=0";
							window.open("{MARI_HOME_URL}/?cms=board_pop&w_table=news&w_id=<?php echo $row['w_id'];?>", "openPop", opt);
							}
						</script>
					<?php
					   }
					  if ($i == 0)
					      echo "<tr><td colspan=\"6\">최근게시물 리스트가 없습니다.</td></tr>";
					?>
						</tbody>
					</table>
					<div class="btn_style1">
						<a href="{MARI_HOME_URL}/?cms=board_list_pop&w_table=news"  onclick="window.open(this.href, '','width=1000, height=850, resizable=no, scrollbars=yes, status=no'); return false">+더보기</a>
					</div>
				</li>
				<li>
					<h3 class="m_title1">업데이트</h3>
					<table class="type_main1">
						<colgroup>
							<col width="" />
							<col width="100px" />
						</colgroup>
						<thead>
							<tr>
								<th>제목</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
						<?php					
							$sql = "select * from mari_write where w_table = 'up' order by w_datetime desc  limit 5 ";
							$noti = mysql_query($sql);
							for($i=0; $row=sql_fetch_array($noti); $i++){
						?>
							<tr>
								<td><a href="javascript:void(0);" onclick="openPop<?php  echo $i;?>()"><?php echo$row['w_subject']; ?></a></td>
								<td><?php echo substr($row['w_datetime'],0,10); ?></td>
							</tr>
						<script>
							/*플랫폼관리자페이지 게시판 뷰페이지 팝업창*/
							function openPop<?php  echo $i;?>() { 
							 var opt = "status=yes,toolbar=no,scrollbars=yes,width=1000,height=850,left=0,top=0";
							window.open("{MARI_HOME_URL}/?cms=board_pop&w_table=up&w_id=<?php echo $row['w_id'];?>", "openPop", opt);
							}
						</script>
						<?php }?>
						</tbody>
					</table>
					<div class="btn_style1">
						<a href="{MARI_HOME_URL}/?cms=board_list_pop&w_table=up" onclick="window.open(this.href, '','width=1000, height=850, resizable=no, scrollbars=yes, status=no'); return false">+더보기</a>
					</div>
				</li>
				<li>
					<h3 class="m_title1">QUICK SWITCH</h3>
				<form name="switch_setup"  method="post" enctype="multipart/form-data">
					<table class="type_main3">
						<colgroup>
							<col width="" />
							<col width="60%" />
						</colgroup>
						<tbody>
							<tr>
								<th>SMS 사용 (발신,수신)</th>
								<td>
								<?php if($qsw['c_sms_use']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="sms_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="sms_y"  style="cursor:pointer;"/>
								<?php }?>
								</td>
							</tr>
							<tr>
								<th>Facebook 로그인</th>
								<td>
								<?php if($qsw['c_facebooklogin_use']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="fb_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="fb_y"  style="cursor:pointer;"/>
								<?php }?>
								</td>
							</tr>
							<tr>
								<th>실명인증 (아이핀 / 휴대폰인증)</th>
								<td>
								<?php if($qsw['c_cert_ipin']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="ipn_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="ipn_y"  style="cursor:pointer;"/>
								<?php }?> / 
								<?php if($qsw['c_cert_use']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="hp_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="hp_y"  style="cursor:pointer;"/>
								<?php }?>								
								</td>
							</tr>
							<tr>
								<th>팝업</th>
								<td>
								<?php if($popup['po_openchk']=="1"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="pop_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="pop_y"  style="cursor:pointer;"/>
								<?php }?>
								</td>
							</tr>
							<tr>
								<th>전자결제 (PG)</th>
								<td>
								<?php if($pg['i_pg_use']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="pg_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="pg_y"  style="cursor:pointer;"/>
								<?php }?>
								</td>
							</tr>
							<tr>
								<th class="line1">나이스 신용정보조회</th>
								<td class="line1">
								<?php if($qsw['c_nice_use']=="Y"){?>
								<img src="{MARI_ADMINSKIN_URL}/img/on1.png" alt="on" id="nice_n"  style="cursor:pointer;"/>
								<?php }else{?>
								<img src="{MARI_ADMINSKIN_URL}/img/off1.png" alt="off" id="nice_y"  style="cursor:pointer;"/>
								<?php }?>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				</li>
			</ul><!-- /m_cont2 -->
			
			<?php
				/*유저서버접속*/
				include_once(MARI_SQL_PATH.'/user_connect.php');
			?>
			<ul class="m_cont3">
					<?php
						for ($i=0; $row=sql_fetch_array($all_bbs); $i++) {
							$sql = "select  w_table, w_id, w_subject, w_datetime from  mari_write where w_table='$row[bo_table]'";
							$bbs = sql_query($sql, false);
					?>
				<!--<li class="<?=$i%2==1?'':'ml0';?>">-->
				<li>
					<h3 class="m_title1"><?php echo $row['bo_subject'];?></h3>
					<table class="type_main1">
						<colgroup>
							<col width="" />
							<col width="100px" />
						</colgroup>
						<thead>
							<tr>
								<th>제목</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
					<?php
						for ($i=0; $list=sql_fetch_array($bbs); $i++) {
					?>
							<tr>
								<td><a href="{MARI_HOME_URL}/?cms=user_board_form&type=m&table=<?php echo $list[w_table];?>&subject=<?php echo $bbs['bo_subject']; ?>&id=<?php echo $list[w_id];?>"><?php echo $list['w_subject']; ?></a></td>
								<td><?php echo substr($list['w_datetime'],0,10); ?></td>
							</tr>
					<?php
					   }
					  if ($i == 0)
					      echo "<tr><td colspan=\"2\">게시물이 없습니다.</td></tr>";
					?>
						</tbody>
					</table>
					<div class="btn_style1">
						<a href="{MARI_HOME_URL}/?cms=user_board_list&table=<?php echo $row[bo_table];?>&subject=<?php echo $row['bo_subject'];?>">+더보기</a>
					</div>
				</li>
					<?php
					   }
					  if ($i == 0)
					      echo "<li>생성된 게시판이 없습니다.</li>";
					?>
			</ul><!-- /m_cont2 -->
		</div><!-- /m_cont_wrap -->
       </div><!-- /contaner -->
</div><!-- /wrapper -->


<script>
/*PG*/
$(function() {
	$('#pg_n').click(function(){
		Pg_setup_NO(document.switch_setup);
	});
});


function Pg_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=pg&i_pg_use=N';
	f.submit();
}

$(function() {
	$('#pg_y').click(function(){
		Pg_setup_YES(document.switch_setup);
	});
});


function Pg_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=pg&i_pg_use=Y';
	f.submit();
}

/*Facebook login*/
$(function() {
	$('#fb_n').click(function(){
		Fb_setup_NO(document.switch_setup);
	});
});


function Fb_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=fb&c_facebooklogin_use=N';
	f.submit();
}

$(function() {
	$('#fb_y').click(function(){
		Fb_setup_YES(document.switch_setup);
	});
});


function Fb_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=fb&c_facebooklogin_use=Y';
	f.submit();
}

/*SMS*/
$(function() {
	$('#sms_n').click(function(){
		Sms_setup_NO(document.switch_setup);
	});
});


function Sms_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=sms&c_sms_use=N';
	f.submit();
}

$(function() {
	$('#sms_y').click(function(){
		Sms_setup_YES(document.switch_setup);
	});
});


function Sms_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=sms&c_sms_use=Y';
	f.submit();
}

/*I-PIN*/
$(function() {
	$('#ipn_n').click(function(){
		Ipn_setup_NO(document.switch_setup);
	});
});


function Ipn_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=ipn&c_cert_ipin=N';
	f.submit();
}

$(function() {
	$('#ipn_y').click(function(){
		Ipn_setup_YES(document.switch_setup);
	});
});


function Ipn_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=ipn&c_cert_ipin=Y';
	f.submit();
}

/*휴대폰인증*/
$(function() {
	$('#hp_n').click(function(){
		Hp_setup_NO(document.switch_setup);
	});
});


function Hp_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=hp&c_cert_use=N';
	f.submit();
}

$(function() {
	$('#hp_y').click(function(){
		Hp_setup_YES(document.switch_setup);
	});
});


function Hp_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=hp&c_cert_use=Y';
	f.submit();
}

/*팝업사용여부*/
$(function() {
	$('#pop_n').click(function(){
		Pop_setup_NO(document.switch_setup);
	});
});


function Pop_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=pop&po_openchk=0';
	f.submit();
}

$(function() {
	$('#pop_y').click(function(){
		Pop_setup_YES(document.switch_setup);
	});
});


function Pop_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=pop&po_openchk=1';
	f.submit();
}

/*NICE신용정보*/
$(function() {
	$('#nice_n').click(function(){
		nice_setup_NO(document.switch_setup);
	});
});


function nice_setup_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=nice&c_nice_use=N';
	f.submit();
}

$(function() {
	$('#nice_y').click(function(){
		nice_setup_YES(document.switch_setup);
	});
});


function nice_setup_YES(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin&type=nice&c_nice_use=Y';
	f.submit();
}

</script>
{# s_footer}<!--하단-->