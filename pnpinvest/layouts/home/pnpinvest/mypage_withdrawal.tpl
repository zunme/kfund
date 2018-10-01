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
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
						</ul>
					</div><!--//left_menu e -->
				<form name="f" method="post">
				<input type="hidden" name="type" value="w"/>
				<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>"/>
				<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>"/>
				<div class="right_content mt30 ml22">
					<div class="right1 ">
						<h5 class="present">출금 신청</h5>
						<p class="txt16 mt45 ml45">이름</p>
						<p class="txt17 mt15 ml45"><?php echo $user[m_name];?></p>
						<p class="txt16 mt40 ml45">출금 금액</p>
						<input class="b_i mt15 ml45 mr10" type="text" name="o_pay"><p class="won mt20 mr20">원</p><p class="notice mt20">※ 출금하실 금액을 정확히 입력해 주세요. 입력하신 금액만큼 출금 신청됩니다.</p>
						<p class="txt16 mt40 ml45">잔액(예치금)</p>
						<p class="txt17 mt15 ml45"><?php echo number_format($user[m_emoney]) ?>원</p>
						<p class="txt16 mt40 ml45">잔액(출금가능액)</p>
						<p class="txt17 mt15 ml45">
							<?php
							/*foreach 파싱 데이터출력*/
							foreach($decode_lnq as $key=>$value){
								$moneyPair=$value['moneyPair'];/*현재잔액*/

								$amount=$moneyPair['amount'];/*현재잔액*/
								if($amount=="S" || $amount=="E"){
								}else{
							?>
								<?php echo $amount;?>

							<?php
								}
							   }
							?>
										원
						</p>
						<p class="txt16 mt40 ml45">입금계좌</p>
						<p class="txt17 mt15 ml45"><?php echo bank_name($user['m_my_bankcode']);?> <?php echo $user['m_my_bankacc'];?></p>
					<div class="btn">
						<a href="javascript:void(0);" onclick="sendit()"><img class="mt35" src="{MARI_HOMESKIN_URL}/img/btn_charge.png" alt="신청하기"/></a>
					</div>
					</div>
					<!--//right1 e-->
				</div>
				<!--//right_content e -->

				</form>
			</div>
			<!--//mypage_inner e -->
		</div>
		<!--//mapage e -->
	</div>
	<!--//main_content e -->
</div>
<!--//container e -->
<script type="text/javascript">
function sendit(){
	if(!document.f.o_pay.value){
		alert('출금신청하실 금액을 입력하여 주십시오 예)300000');f.o_pay.focus();return false;
	}
	
	var ipay_pattern = /[^(0-9)]/;//숫자
	if(ipay_pattern.test(f.o_pay.value)){alert('\n대출금액은 숫자만 입력하실수 있습니다');f.o_pay.value='';f.o_pay.focus();return false;}	 
	if(f.o_pay.value.length < 4){alert('\n1000원 미만으로 출금신청하실 수 없습니다.');return false;}

	document.f.action='{MARI_HOME_URL}/?up=withdrawl';
	document.f.submit();
}
</script>

{#footer}