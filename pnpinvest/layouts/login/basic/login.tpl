<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 로그인페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->



<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>
{#header} 
<script type="text/javascript">

//이메일값 가져오기
function getSelectValue(frm){
	frm.m_id3.value = frm.m_id2.options[frm.m_id2.selectedIndex].value;
}

function sendit(){
	
	if(!document.f.m_password.value){
		alert('패스워드를 입력해주세요');f.m_password.focus();return false;
	}


	document.f.action='{MARI_HOME_URL}/?mode=login_ck';
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


 


<section id="container">
		<section id="sub_content">
			<div class="login_wrap">
				<div class="container">
					<div class="login_box1">
						<img src="{MARI_HOMESKIN_URL}/img/login_img.png" alt="로그인"/>
						<!--<img src="{MARI_MOBILESKIN_URL}/img/img_login_box1.png" alt="img_login_box1" class="img_c wd25"/>-->
						<h3 class="login_title1">환영합니다!</h3> 
						<p>로그인 후 다양한 서비스를 이용해 보세요!</p>
					<form name="f" method="post">
					<input type="hidden" name="url" value='<?php echo $login_url ?>'>
					<input type="hidden" name="m_id" value="<?php echo $m_id;?>">
							<ul class="login_cont1">
								<li>
									<input type="text" name="m_id" id=""  title="아이디" value="<?=$_COOKIE["id_save"]?>" required placeholder="E-mail address" class="form-control col-xs-12 mb10 " />
								</li>
								<li>
									<input type="password" name="m_password" id="" value="<?=$_COOKIE["pw_save"]?>" title="비밀번호" required placeholder="PASSWORD" class="form-control col-xs-12 mb10  " / >
								</li>
								
								</ul><!-- /login_cont1 -->
						<div class="login_btn1"><input type="image"  style="cursor:pointer"  onclick="sendit()" src="{MARI_MOBILESKIN_URL}/img/btn_login1.png" alt="로그인" /></div>
							<?php if($config['c_facebooklogin_use']=="Y"){?>
								<div class="login_facebook1"><a href="<?=FACEBOOK_LOGIN?>"><img src="{MARI_MOBILESKIN_URL}/img/btn_facebook_login1.png" alt="facebook 로그인"/></a></div>
							<?php }?>
							
						</form>
						<div class="agree_box">
						<label><span><input type="checkbox"  style="width:15px; height:15px;" name="auto_login" value="Y"  <?php echo $_COOKIE["auto_login"]=='Y'?'checked':'';?> id="login_auto_login"/>
											</span>아이디를 저장합니다.</label>
						</div>
					 
							<div class="log_btn_wrap1">
								<a href="{MARI_HOME_URL}/?mode=join0" class="posi1 col-xs-6">회원가입</a>
								<a href="{MARI_HOME_URL}/?mode=pw_find" class="col-xs-6">비밀번호 찾기</a>
							</div>		 
					</div><!-- /login_box1-->
			</div>
			</div><!-- /login_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->

<?}else{?>
{#header_sub} 
<script type="text/javascript">
$(function(){
	$('body').css('background','#fafafa');
});
</script>

		<div id="container">
			<div id="sub_content sub_member">
				<div class="title_wrap">
					<!--<div class="title_wr_inner">
						<h3 class="title2_1"> 플레이플랫폼 로그인</h3>
							<p class="title_add1_1">로그인하시고 플레이플랫폼의 다양한 서비스를 이용해 보세요!</p>	
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
			
				<div class="login_wrap">
				<div class="login_com">
				<img src="{MARI_HOMESKIN_URL}/img/login_img.png" alt="로그인"/>
				<h5>환영합니다!</h5>
				<p>로그인 후 다양한 서비스를 이용해 보세요!</p>
				</div>
									<div class="login_section1">						
					<form name="f" method="post">
					<input type="hidden" name="url" value='<?php echo $login_url ?>'>
					<input type="hidden" name="m_id" value="<?php echo $m_id;?>">
							<ul class="login_cont1">
								<li><input type="text" name="m_id" id=""  title="아이디" value="<?=$_COOKIE["id_save"]?>" required placeholder="E-mail address" /></li>
								<li><input type="password" name="m_password" id="" value="<?=$_COOKIE["pw_save"]?>"  title="비밀번호" required placeholder="Password" /></li>
								<li class="">						
											<label><span><input type="checkbox"  style="width:15px; height:15px;" name="auto_login" value="Y"  <?php echo $_COOKIE["auto_login"]=='Y'?'checked':'';?> id="login_auto_login"/>
											</span>아이디를 저장합니다.</label>
								</li>
								<li><input type="image"  style="cursor:pointer"  onclick="sendit()" src="{MARI_HOMESKIN_URL}/img/btn_login1.png" alt="로그인" /></li>
							<?php if($config['c_facebooklogin_use']=="Y"){?>
								<li><a href="<?=FACEBOOK_LOGIN?>"><img src="{MARI_HOMESKIN_URL}/img/btn_facebook_login.png" alt="facebook 로그인"/></a></li>
							<?php }?>
							</ul><!-- /login_cont1 -->
					</form>
					<div class="search_cont1">
						<div class="log_box">
							<p>비밀번호가 기억나지 않으세요?</p>
							<div class="btn_wrap3">
								<p class="find"><a href="{MARI_HOME_URL}/?mode=pw_find" ><!--<img class="mr10"src="{MARI_HOMESKIN_URL}/img/icon_logbox1.png" alt="비밀번호 찾기" />-->비밀번호 찾기</a></p>
							</div>
						</div>
						<div class="log_box">
							<p> <!--<?php echo $config['c_title']; ?>-->인투윈소프트의 회원이 아니신가요?</p>
							<div class="btn_wrap5">
								<p class="find"><a href="{MARI_HOME_URL}/?mode=join1" ><!--<img class="mr10"src="{MARI_HOMESKIN_URL}/img/icon_logbox2.png" alt="회원가입" />-->회원가입</a></p>
							</div>
						</div>
					</div>	
					</div>
					
				</div><!-- /login_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->

<script type="text/javascript">
function sendit(){
	
	if(!document.f.m_password.value){
		alert('패스워드를 입력해주세요');f.m_password.focus();return false;
	}
	/*
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			
			if(exptext.test(document.f.m_id.value)==false){
				//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
				alert("이메일 형식이 올바르지 않습니다.");
				document.f.m_id.focus(); return false;
			}
	*/
	document.f.action='{MARI_HOME_URL}/?mode=login_ck';
	document.f.submit();
}
</script>
<script>
$(function(){
    $("#login_auto_login").click(function(){
        if (this.checked) {
            this.checked = confirm("자동로그인을 사용하시면\n다음부터 회원 E-mail 아이디와 비밀번호를 입력하실 필요가 없습니다.\n\n자동로그인을 사용하시겠습니까?");
        }
    });
});

function flogin_submit(f)
{
    return true;
}

</script>


<?}?>
{# footer}<!--하단-->