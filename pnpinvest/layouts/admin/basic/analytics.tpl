<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<?php if($naver_login=="Y"){?>
<script type="text/javascript">
  var openNewWindow = window.open("about:blank");
  openNewWindow.location.href="http://analytics.naver.com/summary/dashboard.html" ;
  window.close();
</script>
<?php }?>

<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">플러그인/위젯</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">

<form name="seo_config"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="w"/>
			<fieldset>
				<div class="log_wrap pt20">
					<div class="log_top">		
						<div class="log_info_area">
							<table class="type_l" >
									<colgroup>
										<col width="1px"/>
										<col width="80px"/>
										<col width="100px"/>
									</colgroup>
									<tbody>
										<tr>
											<td class="title_tri"></td> <td class="log">ID</td> <td><?php echo $at['login_form_login'];?></td> 
										</tr>
										<tr>
											<td class="title_tri" style="height:26px;"></td> <td class="log">시크릿</td> <td><?php echo $at['form_password'];?></td>
										</tr>
										<tr>
											<td class="title_tri"></td> <td class="log">바로가기</td>
											<td>
<?php if($naver_login=="Y"){?>
<a href="http://analytics.naver.com/realtime/display.html" target="_blank"><img src="{MARI_ADMINSKIN_URL}/img/logsite_btn.png"  alt="에널리틱스 바로가기" /></a>
<?php }else{?>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>
<div id="naver_id_login"></div>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("{_at['login_form_login']}", "{MARI_HOME_URL}/?cms=analytics&naver_login=Y");
	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain(".{MARI_HOME_URL}");
	naver_id_login.setState("{_at['login_form_login']}");
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
</script>
<?php }?>
											</td>
										</tr>							
									</tbody>
								</table>						
						</div>
						<div class="log_info_area2">
							<img src="{MARI_ADMINSKIN_URL}/img/logsite_main.jpg" width="440px" style="border:1px solid #d5d5d5;" alt="로그사이트 메인이미지" />
						</div>
					</div>
					<section id ="server_info">
						<h2 class="bo_title"><span>네이버 에널리틱스</span></h2>
				<div class="bo_text">
					<p>
				*애널리틱스 로그분석을 이용하기 위해서는 먼저 NAVER 애널리틱스 가입하신후 로그분석 스크립트를 해당 <a href="{MARI_HOME_URL}/?cms=seo_config" class="color_bl ml10 fb">SEO설정메뉴</a> > 로그분석 스크립트설정에서 삽입하셔야만 정상적으로 사용가능 합니다.
					</p>
				</div>
						<div class="tbl_frm01 tbl_wrap">
								 <table>
									<colgroup>
										<col class="grid_4" />
										<col>						
									</colgroup>
									<tbody>
										<tr scope="row">
											<th>네이버 앱 ID</th><td> <input type="text" name="login_form_login" value="{_at['login_form_login']}" size="30" class="frm_input" id="login_form_login">
												<a href="https://nid.naver.com/devcenter/register.nhn" target="_blank">
													<img src="{MARI_ADMINSKIN_URL}/img/app_btn.png" alt="앱등록하기" />
												</a>											
											</td>
										</tr>
									</tbody>
								</table>
						</div>

					</section>
				</div>
				<div class="btn_confirm01 btn_confirm">

					<input type="submit" value="" class="confirm_btn" accesskey="s" id="analytics_config_add">


				</div>
			</fieldset>


		</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
/*필수체크*/
$(function() {
	$('#analytics_config_add').click(function(){
		Seo_config_Ok(document.seo_config);
	});
});


function Seo_config_Ok(f)
{
	if(!f.login_form_login){alert('\n네이버 앱 ID 를 입력하여 주십시오.');f.login_form_login.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=analytics';
	f.submit();
}



</script>

{# s_footer}<!--하단-->