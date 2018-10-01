<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">나의서비스관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">

		<form name="shop_config"  method="post" enctype="multipart/form-data">
			<fieldset>
				<div class="service_wrap pt20">
					<div class="service_top">
							<div class="ser_info_area">
									<table class="type_s" >
										<colgroup>
											<col width="1px"/>
											<col width="80px"/>
											<col width="120px"/>
											<col width="200px"/>
										</colgroup>
										<tbody>
											<tr>
												<td class="title_tri"></td> <td class="t">아이디</td> <td><?php echo $sv['sale_code']; ?></td></td>
											</tr>
											<tr>
												<td class="title_tri" style="height:26px;"></td> <td class="t">라이센스키</td> <td><input type="text" name="license_key" value="<?php echo $sv['license_key']; ?>" size="50" class="frm_input" id="license_key"> </td><td>키가 없을시 서비스를 이용하실 수 없습니다.</td>
											</tr>
											<tr>
												<td class="title_tri"></td> <td class="t">서비스명</td> <td><?php echo $sv['service_name']; ?></td><td><a href="#"><img src="{MARI_ADMINSKIN_URL}/img/service_btn1.png" alt="변경신청" /></a></td>
											</tr>
											<tr>
												<td class="title_tri"></td> <td class="t">서비스 기간</td> <td><?php echo $sv['service_start_time']; ?> ~ <?php echo $sv['service_end_time']; ?> 까지</td><td><a href="#"><img src="{MARI_ADMINSKIN_URL}/img/service_btn1.png" alt="변경신청" /></a></td>
											</tr>
											<tr>
												<td class="title_tri"></td> <td class="t">연장방식</td> <td><?php echo $sv['extension_methods']; ?></td><td><a href="#"><img src="{MARI_ADMINSKIN_URL}/img/service_btn1.png" alt="변경신청" /></a></td>
											</tr>
										</tbody>
									</table>
							</div>
					</div>

					<section id ="server_info">
						<h2 class="h2_frm"><span>FTP 정보설정</span></h2>
					 
						<div class="tbl_frm01 tbl_wrap">
							<table>
							<caption>FTP 정보설정 입력</caption>
							<colgroup>
								<col class="grid_4">
								<col>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">FTP 접속</th>
								<td>
								<img src="{MARI_ADMINSKIN_URL}/img/confirm_btn.png" id="ftp_addform"  style="cursor:pointer;" alt="FTP 바로가기">
								</td>
							</tr>
							<tr>
								<th scope="row">FTP 아이디</th>
								<td><input type="text" name="ftp_id" value="<?php echo $sv['ftp_id']; ?>" size="25" class="frm_input" id=""></td>
							</tr>
							<tr>
								<th scope="row">FTP 비밀번호</th>
								<td><input type="text" name="ftp_pw" value="<?php echo $sv['ftp_pw']; ?>" size="25" class="frm_input" id=""></td>
							</tr>
							</tbody>
							</table>
						</div>
					</section>

					<div class="service_content">
						<h2 class="h2_frm"><span>도메인 연결관리</span></h2>
						<div class="tbl_frm01 tbl_wrap">
								 <table>
									<colgroup>
										<col class="grid_4" />
										<col>						
									</colgroup>
									<tbody>
										<tr scope="row">
											<th>대표도메인</th><td> <input type="text" name="domain_url" value="<?php echo $sv['domain_url']; ?>" size="40" class="frm_input" id=""></td>
										</tr>
									</tbody>
								</table>
						</div>
						
					</div>

					<section id ="my_server_info">
						<h2 class="h2_frm"><span>SERVER 정보</span></h2>
					 
						<div class="tbl_frm01 tbl_wrap">
							<table>
							<caption>SERVER 정보</caption>
							<colgroup>
								<col class="grid_4">
								<col>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">MYSQL HOST</th>
								<td><?php echo $sv['mysql_host']; ?></td>
							</tr>
							<tr>
								<th scope="row">MYSQL 아이디</th>
								<td><?php echo $sv['mysql_user']; ?></td>
							</tr>
							<tr>
								<th scope="row">MYSQL 비밀번호</th>
								<td><?php echo $sv['mysql_password']; ?></td>
							</tr>
							<tr>
								<th scope="row">MYSQL DB</th>
								<td><?php echo $sv['mysql_db']; ?></td>
							</tr>
							</tbody>
							</table>
						</div>
					</section>

				<?php if($user['m_id']=="webmaster@admin.com"){?>
					<section class="service_admin">
						<h2 class="h2_frm"><span>나의 서비스관리 [업체 관리자모드]</span></h2>
						<div class="tbl_frm01 tbl_wrap">
								 <table>
									<colgroup>
										<col class="grid_4" />
										<col>						
									</colgroup>
									<tbody>
										<tr scope="row">
											<th>아이디[상점명]</th><td> <input type="text" name="sale_code" value="<?php echo $sv['sale_code']; ?>" size="30" class="frm_input" id="sale_code"></td>
										</tr>
										<tr scope="row">
											<th>서비스명</th><td> <input type="text" name="service_name" value="<?php echo $sv['service_name']; ?>" size="30" class="frm_input" id="service_name"></td>
										</tr>
										<tr scope="row">
											<th>서비스기간</th><td> <input type="text" name="service_start_time" value="<?php echo $sv['service_start_time']; ?>" size="20" class="frm_input calendar" id="service_start_time"> ~ <input type="text" name="service_end_time" value="<?php echo $sv['service_end_time']; ?>" size="20" class="frm_input calendar" id="service_end_time"> 까지</td>
										</tr>
										<tr scope="row">
											<th>연장방식</th><td> <input type="text" name="extension_methods" value="<?php echo $sv['extension_methods']; ?>" size="40" class="frm_input" id="extension_methods"></td>
										</tr>
										<tr scope="row">
											<th>FTP HOST설정</th><td> <input type="text" name="ftp_host" value="<?php echo $sv['ftp_host']; ?>" size="40" class="frm_input" id="ftp_host"></td>
										</tr>
										<tr scope="row">
											<th>버전설정</th><td> <input type="text" name="service_ver" value="<?php echo $sv['service_ver']; ?>" size="40" class="frm_input" id=""></td>
										</tr>
									</tbody>
								</table>
						</div>
						
					</section>
				<?php }?>

				</div>
				<!-- 확인버튼 -->
				<div class="btn_confirm01 btn_confirm">
					<input type="submit" value="" class="confirm_btn" id="shop_config_add" accesskey="s" id="">
					<a href="#" class="shop_btn"></a>
				</div>
			</fieldset>
		</form>
<!--FTP 정보전송-->
			<form name="ftp_goform"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="ftp_host" value="<?php echo $default['ftp_host']; ?>">
			<input type="hidden" name="ftp_user" value="<?php echo $default['ftp_id']; ?>">
			<input type="hidden" name="ftp_port" value="21">
			</form>
<!--//FTP 정보전송-->

    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#shop_config_add').click(function(){
		Shop_config_Ok(document.shop_config);
	});
});


function Shop_config_Ok(f)
{
	if(!f.license_key.value){alert('\n라이선스 키를 입력하여 주십시오 입력하지 않을시 \n서비스 이용이 불가합니다.');f.license_key.focus();return false;}

	if(!f.ftp_host.value){alert('\n호스트 연결주소를 입력하여 주십시오');f.ftp_host.focus();return false;}

	if(!f.ftp_id.value){alert('\nFTP 아이디를 입력하여 주십시오');f.ftp_id.focus();return false;}

	//if(!f.ftp_pw.value){alert('\nFTP 비밀번호를 입력하여 주십시오');f.ftp_pw.focus();return false;}

	if(!f.domain_url.value){alert('\n대표도메인을 입력하여 주십시오');f.domain_url.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=service_config';
	f.submit();
}


$(function() {
	$('#ftp_addform').click(function(){
		ftp_add_Ok(document.ftp_goform);
	});
});


function ftp_add_Ok(f)
{
	f.method = 'post';
	f.action = 'http://mplusmaster.wayhome.kr/admin/ftp_client.php';
	f.submit();
}

$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });
</script>
{# s_footer}<!--하단-->