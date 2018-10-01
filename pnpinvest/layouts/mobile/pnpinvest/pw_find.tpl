<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#sub_header}<!--상단-->

<section id="container">
	<section id="sub_content">
		<div class="mypage_wrap">
			<div class="container">
				<div class="find_box1">					
					<div>
						<h3 class="s_title2 txt_c">비밀번호 찾기</h3>
						<p class="txt_c">회원가입시 등록한 이메일 주소를<br/>입력하여 주시면 <strong>초기화 된 비밀번호를<br/>발송</strong> 해 드립니다.</p>
						<form name="pw_find"  method="post" enctype="multipart/form-data">	
						<ul class="loan_cont1 mt50">
							<li class="mt30">
							<div class="loan_frm1" >
								<input type="text" name="m_email" value="" id="" required  class="frm_input form-control col-xs-12 mb20" size="40" placeholder="이메일 주소를 입력해주세요"/>
							</div>
							</li>
						</ul>
						
						<div class="container" style="padding:0; ">
							<a href="javascript:void(0);" onclick="pw_sendit()" class="mobile_btn mt20">초기화 비밀번호 전송</a>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div><!-- /mypage_wrap -->
	</section><!-- /sub_content -->
</section><!-- /container -->
<script type="text/javascript">
function pw_sendit(){
	 
	var f=document.pw_find;

	if(!f.m_email.value){alert('\n가입 시 등록하신 이메일주소를 입력하여 주십시오.');f.m_email.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=changepassword';
 
	f.submit();
}
</script>
{# footer}<!--하단-->