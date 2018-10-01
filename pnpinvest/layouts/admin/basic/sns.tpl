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
			<div class="title01">플러그인/위젯</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
		<div class="title02">소셜네트워크 (SNS) 설정</div>
			<fieldset>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="w"/>
			<!-- 소셜네트워크 서비스 -->
			<div id="anc_cf_sns">
				<h2 class="bo_title"><span>페이스북 로그인 설정</span></h2>
				<div class="bo_text">
					<p>
						페이스북 로그인 기타 SNS 서비스등을 설정하실 수 있습니다.(ver 2.4)
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>SNS 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for=" ">페이스북 앱 ID</label></th>
						<td>
							<input type="text" name="c_facebook_appid" value="{_config['c_facebook_appid']}" id=" " size="40" class="frm_input">
							<a href="https://developers.facebook.com/apps" target="_blank">
								<img src="{MARI_ADMINSKIN_URL}/img/app_btn.png" alt="앱등록하기" />
							</a>
						</td>
						<th scope="bo"><label for=" ">페이스북 앱 SECRET</label></th>
						<td>
							<input type="text" name="c_facebook_secret" value="{_config['c_facebook_secret']}" id=" " size="40" class="frm_input">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for=" ">페이스북로그인 사용여부</label></th>
						<td colspan="3">
							<input type="checkbox" name="c_facebooklogin_use" value="Y" <?php echo $config['c_facebooklogin_use']=='Y'?'checked':'';?>/> 사용
						</td>
					</tr>

					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>
		</form>
			</fieldset>


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script type="text/javascript">
function sendit(){
	var f=document.config_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=sns';
	f.submit();
}
</script>

{# s_footer}<!--하단-->






