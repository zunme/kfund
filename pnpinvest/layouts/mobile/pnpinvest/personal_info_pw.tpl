<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 개인정보관리 
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->

		<section id="container">
		<section id="sub_content">
			<div class="login_wrap">
				<div class="container">
					<div class="login_box1">
						<h3 class="login_title1">로그인</h3>
						<form name="f" method="post">
						<!-- <p class="tit_add1"></p> -->
						<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>"/>
						<ul class="login_cont1">
							<li>
								<h4>회원ID</h4>
								<p><?php echo $user['m_id'];?></p>
							</li>
							<li>
								<h4>비밀번호</h4>
								<p>
							 
								<input type="password" name="m_password" id ="" placeholder="비밀번호를 입력해 주세요" title="비밀번호" class="form-control"/>
									
								</p>
							</li>
						</ul><!-- /join_cont1 -->
						<div class="login_btn1">
							
							<input type="image"  style="cursor:pointer"  onclick="sendit()" src="{MARI_MOBILESKIN_URL}/img/btn_login1.png" alt="확인" />
						</div>
					
					</form>
					</div><!-- /login_box1-->
				</div>
			</div><!-- /login_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
<script type="text/javascript">
function sendit(){
	if(!document.f.m_password.value){
		alert('패스워드를 입력해주세요');f.m_password.focus();return false;
	}

	document.f.action='{MARI_HOME_URL}/?up=personal_info_pw';
	document.f.submit();
}
</script>
{# skin1_footer}<!--하단-->