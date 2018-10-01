<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 
	<section id="container">
		<section id="sub_content">
			<div class="container">	
				<div class="mypage">
					<h3 class="s_title2 txt_c">출금 신청</h3>
					<p class="m_txt9">출금 신청 시 익일 오후 2시 이전에 계좌로 일괄 입금됩니다.</p>
				<form name="f" method="post">
				<input type="hidden" name="type" value="w"/>
				<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>"/>
				<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>"/>
					<ul class="loan_cont1 mt50">
						<li>
							<h4 class="loan_title1">이름</h4>
							<p class="mp_c_name"><?php echo $user[m_name];?></p>
						</li>
						<li class="mt20">
							<h4 class="loan_title1">출금 금액</h4>
							<div class="loan_frm1 col-xs-12 col-sm-12" style="padding:0; ">
								<input type="text" name="o_pay" value="" id="" required  class="frm_input form-control" size="40" class="col-xs-12" />
							</div>
							<p class="mp_c_txt">입력 금액만큼 출금됩니다.</p>
						</li>
						<li class="mt40">
							<h4 class="loan_title1">잔액(예치금)</h4>
							<div class="loan_frm1" style="margin-top:-10px; ">
								<p class="mp_c_name"><?php echo number_format($user[m_emoney]) ?></p>
							</div>
						</li>
						<li class="mt40">
							<h4 class="loan_title1">잔액(출금가능액)</h4>
							<div class="loan_frm1" style="margin-top:-10px; ">
								<p class="mp_c_name">
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
							</div>
						</li>
						<li>
							<h4 class="loan_title1">입금 계좌</h4>
							<div class="loan_frm1" style="margin-top:-10px; ">
								<p class="mp_c_name"><?php echo bank_name($user['m_my_bankcode']);?> <?php echo $user['m_my_bankacc'];?></p>
							</div>
						</li>
					</ul>
				</form>
					<div class="container mt60" style="padding:0; ">
						<a href="javascript:void(0);" onclick="sendit()"><img style="width:100%;" src="{MARI_MOBILESKIN_URL}/img/btn_mp_c.png" alt="" /></a>
					</div>
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
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
{# footer}<!--하단-->