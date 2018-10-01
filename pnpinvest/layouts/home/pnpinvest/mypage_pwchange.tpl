<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<div id="container">
	<div id="sub_content">
		<div class="mypage" >
			<div class="mypage_inner">
					<div class="left_menu mt30">
						<ul>
							<li class="first current"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li> 
							<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney" ><span></span><p>거래내역</p></a></li>
							
							<li class=""><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_withdrawal"><span></span><p>출금 신청</p></a></li>
						</ul>
					</div><!--//left_menu e -->
				<div class="right_content mt30 ml22">
					<div class="right1">
						<h5 class="present charge">
							<a href="{MARI_HOME_URL}/?mode=mypage_basic"><span class="list">개인 정보 관리</span></a><span class="bar">｜ </span><a href="{MARI_HOME_URL}/?mode=mypage_pwchange">비밀번호 변경</a><span class="bar">｜ </span><a href="{MARI_HOME_URL}/?mode=mypage_out"><span class="list">회원탈퇴</span></a>
						</h5>
						<div class="right1_inner2 pb200">
							<ul class="pt20">
							<form name="member_form"  method="post" enctype="multipart/form-data">
								<input type="hidden" name="m_no" value="{_mmo["m_no"]}">
								<input type="hidden" name="m_id" value="{_user["m_id"]}"/>
								<li><p class="txt9 mt7  pr10" style="" >현재 비밀번호</p><input type="password" class="mail" name="password" id="" placeholder="현재 비밀번호를 입력해주세요"></li>
								<li><p class="txt9 mt17  pr10" style="" >변경 비밀번호</p><input type="password" class="pw mt10 mb10" name="m_password" id="" placeholder="변경하실 비밀번호를 입력해주세요"></li>
								<li><p class="txt9 mt17 pr10" style="" >변경 비밀번호 확인</p><input type="password" class="pw mt10 mb10" name="m_password_re" id="" placeholder="변경 비밀번호를 한번 더 입력해주세요"></li>
								</form>
								<li><a href="#"><img class="mt25" src="{MARI_HOMESKIN_URL}/img/btn_ok.png"  id="member_form_add" alt="변경완료"/></a></li>
							</ul>
						</div>
						<!--//right1_inner e -->
					</div>
					<!--//right1 e -->
				</div>
				<!--//right_content e -->
			</div>
			<!--//mypage_inner e -->
		</div>
		<!--//mapage e -->
	</div>
	<!--//main_content e -->
</div>
<!--//container e -->




<script>
/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok(f)
{
	if(!f.password.value){alert('\n현재 비밀번호를 입력하여 주십시오.');f.m_password.focus();return false;}
	if(!f.m_password.value){alert('\n변경하실 비밀번호를 입력하여 주십시오.');f.m_password_re.focus();return false;}
	if(f.m_password_re.value != f.m_password.value){ alert('\n변경하실 비밀번호가 일치하지 않습니다.'); return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=change_pw';
	f.submit();
}
</script>



{#footer}