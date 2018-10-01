<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 로그인
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
	<div class="login_wrap">
		<div class="login_logo"><a href="{MARI_HOME_URL}/?mode=main"><?php if(!$config['c_logo']){?><img src="{MARI_ADMINSKIN_URL}/img/login_img1.png" /><?php }else{?><img src="{MARI_DATA_URL}/favicon/{_config['c_logo']}"  alt="{_config['c_title']}"/><?php }?></a></div>
		<div class="login_box">
			<div class="login_img1"><img src="{MARI_ADMINSKIN_URL}/img/login_img1.png" /></div>
			<h3 class="login_title1">관리자 <span>로그인</span></h3>
					<form name="f" method="post">
					<input type="hidden" name="url" value='<?php echo $login_url ?>'>
				<ul class="login_cont1">
					<li><input type="text" name="m_id" id="" value="<?=$_COOKIE["id_save"]?>" title="아이디" placeholder="아이디" required/></li>
					<li><input type="password" name="m_password" id="" value="<?=$_COOKIE["pw_save"]?>" title="비밀번호" placeholder="비밀번호"  placeholder="PASSWORD" required/></li>
					<li class="">
						<input type="checkbox"  name="auto_login"  value="Y"  <?php echo $_COOKIE["auto_login"]=='Y'?'checked':'';?> id="login_auto_login" />
						<label for="">아이디 저장</label>
					</li>
					<li><input type="image"  style="cursor:pointer"  onclick="sendit()" src="{MARI_ADMINSKIN_URL}/img/btn_login1.png" alt="로그인" /></li>
				</ul><!-- /login_cont1 -->
			</form>
		</div>
	</div><!-- /login_wrap -->

<script type="text/javascript">
function sendit(){
	if(!document.f.m_id.value){
		alert('아이디를 입력해주세요');f.m_id.focus();return false;
		return false;
	}
	if(!document.f.m_password.value){
		alert('패스워드를 입력해주세요');f.m_password.focus();return false;
	}

	document.f.action='{MARI_HOME_URL}/?mode=login_ck&admin=Y';
	document.f.submit();
}
</script>
<script>
$(function(){
    $("#login_auto_login").click(function(){
        if (this.checked) {
            this.checked = confirm("자동로그인을 사용하시면 다음부터 회원E-MAIL아이디와 비밀번호를 입력하실 필요가 없습니다.\n\n자동로그인을 사용하시겠습니까?");
        }
    });
});

function flogin_submit(f)
{
    return true;
}
</script>