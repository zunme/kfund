<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<div id="container">
	<div id="sub_content">
		<div class="title_wrap title_bg2">
			<div class="title_wr_inner">
				<h3 class="title2_1">비밀번호 찾기</h3>
					<p class="title_add1">비밀번호를 잃어버리셨나요?</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
			</div><!-- /title_wr_inner -->
		</div><!-- /title_wrap -->
	<form name="pw_find"  method="post" enctype="multipart/form-data">
		<div class="login_wrap">
			<div class="login_section1 pw_find_section">
				<h4 class="login_title1 pw_find"><?php echo $config['c_title'];?><span> MEMBERS<span></h4>
				<p class="pw_txt1">가입 시 등록한 이메일 주소로 초기화된 비밀번호를 발송해 드립니다.</p>
				<ul>
					<li><input type="text"  class="mail" name="m_email" id="" placeholder="E-mail address"></li>
					<li class="mt30 mb50"><a href="javascript:void(0);" onclick="pw_sendit()"><span>초기화 비밀번호 전송</span></a></li>
				</ul>	
			</div>	
	</form>
		</div><!-- /login_wrap -->
	</div>
	<!--//sub_content e -->
</div>
<!--//container e -->
<script type="text/javascript">
function pw_sendit(){
	 
	var f=document.pw_find;

	if(!f.m_email.value){alert('\n가입 시 등록하신 이메일주소를 입력하여 주십시오.');f.m_email.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=changepassword';
 
	f.submit();
}
</script>

{# footer}