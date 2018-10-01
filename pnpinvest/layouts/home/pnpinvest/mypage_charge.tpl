<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
<div id="container">
	<div id="sub_content">
		<div class="mypage">
			<form name="form_chk" method="post"  enctype="multipart/form-data">
			<div class="mypage_inner">
				<div class="left_menu mt30">
						<ul>
							<li class="first"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
							<li>
								<a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p class="realestate_title">부동산 담보 대출</p></a>
								<ul class="sub_menu">
									<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info_realestate">대출 정보</a></li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info_realestate">투자 정보</a></li>
								</ul>
							</li>
							<li>
								<a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>일반 대출</p></a>
								<ul class="sub_menu">
									<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info_credit">대출 정보</a></li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info_credit">투자 정보</a></li>
								</ul>
							</li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_withdrawal"><span></span><p>출금 신청</p></a></li>
							
						</ul>
					</div><!--//left_menu e -->
				<div class="right_content mt30 ml22">
					<div class="right1 ">
						<h5 class="present charge"><a href="{MARI_HOME_URL}/?mode=mypage_charge">충전 신청</a></h5>
						<p class="txt16 mt90 ml45">이름</p>
						<p class="txt17 pt20 ml45"><?php echo $user['m_name']; ?></p>
						<p class="txt16 pt20 ml45">충전 금액</p>
						<input class="b_i mt20 ml45 mr10" type="text" name="AMOUNT"><p class="won mt20 mr20">원</p><p class="notice mt20">※ 충전하실 금액을 정확히 입력해 주세요. 입력하신 금액만큼 충전 신청됩니다.</p>
						<div class="btn">
							<img class="mt35" src="{MARI_HOMESKIN_URL}/img/btn_charge.png" alt="신청하기" id="fnPopup_add"  style="cursor:pointer;"/>
						</div>
					</div>
					<!--//right1 e-->
				</div>
				<!--//right_content e -->

			</div>
			<!--//mypage_inner e -->
			</form>
		</div>
		<!--//mapage e -->
	</div>
	<!--//main_content e -->
</div>
<!--//container e -->

<script language='javascript'>
/*필수체크*/
$(function(){
	$('#fnPopup_add').click(function(){
		FnPopup_Ok(document.form_chk);
	});
});

function FnPopup_Ok(f){	

var loann_pattern = /[^(0-9)]/;//숫자
if(loann_pattern.test(f.AMOUNT.value)){alert('\n충전금액은 숫자만 입력하실수 있습니다');f.AMOUNT.value='';f.AMOUNT.focus();return false;}	
if(!f.AMOUNT.value){alert('\n충전하실 금액을 입력하여 주십시오.');f.AMOUNT.focus();return false;}

window.open('', 'popupChk', 'width=749, height=520, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
f.action = "{MARI_HOME_URL}/?mode=virtualaccount_input";
f.target = "popupChk";
f.submit();
}
</script>
{#footer}