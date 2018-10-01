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
					<form name="f" method="post">
					<input type="hidden" name="type" value="w"/>
					<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>"/>
					<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>"/>
					<?php if(!$user[m_reginum] || !$user[m_with_addr1] || !$user[m_with_addr2]){?>
					<input type="hidden" name="withholding_info" value="N">
					<?php }?>
						<div class="dashboard_my_info">
							<h3><span>예치금 관리</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_balance" class="info_current">입/출금 관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney">내역</a></li>
								</ul>
							</h3>
							<div class="dashboard_balance">
							   <ul class="my_tap_ul">
									<li class="my_tap_1 on">투자자가상계좌</li>
									<li class="my_tap_2">대출자가상계좌</li>
							  </ul>

								<div>
									<table>
										<colgroup>
											<col width=""/>
											<col width=""/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>입금 관리</th>
											</tr>
											<tr>
												<th colspan="2" class="caption">
												입금 전 본인 인증과 계좌 정보 등록이 필요합니다.(정보 수정 - 인증 센터)<br/>
												계좌이체 후 입금 반영하는 데에는 약 1~10분이 소요됩니다.<br/>
												예치금 입금은 가상계좌에 입금한 만큼 1:1로 충전이 이루어집니다.<br/>
												은행 전산 점검 시간인 23:30~01:00사이에는 이용에 제한이 있을 수 있습니다.
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>은행명</th>
												<td>
												<!--
													<select name="s_bnkCd" required class="s_bnkCd">
														<option>은행선택</option>
														<option value="KEB_005"  <?php echo $seyck['s_bnkCd']=="KEB_005"?'selected':'';?>>외환은행</option>
														<option value="KIUP_003"  <?php echo $seyck['s_bnkCd']=="KIUP_003"?'selected':'';?>>기업은행</option>
														<option value="NONGHYUP_011"  <?php echo $seyck['s_bnkCd']=="NONGHYUP_011"?'selected':'';?>>농협중앙회</option>
														<option value="SC_023"  <?php echo $seyck['s_bnkCd']=="SC_023"?'selected':'';?>>SC제일은행</option>
														<option value="SHINHAN_088"  <?php echo $seyck['s_bnkCd']=="SHINHAN_088"?'selected':'';?>>신한은행</option>
													</select>
													-->
										<select name="s_bnkCd"   required class="s_bnkCd">
													<option>은행선택</option>
							<?php
							   foreach($decode as $key=>$value){
								for($cnt=0; $cnt<count($value); $cnt++){
								if (!is_array($value)) $value = array(); 
							?>
									<option value="<?php echo $value[$cnt]['bankCode'];?>" <?php echo $seyck['s_bnkCd']==$value[$cnt][bankCode]?'selected':'';?>><?php echo bank_name($value[$cnt][bankCode]);?></option>
							<?php
								}
							   }
							?>
											</select>
													
												</td>
											</tr>
											<tr>
												<th>계좌 번호</th>
												<td><?php if($seyck['s_accntNo']){?> <?php echo $seyck['s_accntNo'];?> <?php }else{?>보유하신 계좌가 없습니다.<?php }?></td>
											</tr>
											<!--
											<tr>											
												<td colspan="2"><label><input type="checkbox" id="agreement" name="agreement">  투자자 이용 약관에 동의합니다.</label></td>
											</tr>
											-->
										</tbody>
									</table>
									  <div class="depositbox">
										   <a href="javascript:void(0);"class="my_tap_div1" onclick="sendit(1)">투자자가상계좌발급</a>
										  <a href="javascript:void(0);" class="my_tap_div2" style="display:none" onclick="sendit(4)">대출자가상계좌발급</a>
									   </div>
								</div>
								  <script>
                                $('.my_tap_1').click(function(){
                                     $('.my_tap_1').addClass("on");
                                    $('.my_tap_2').removeClass("on");
                                    $('.my_tap_div2').hide();
                                    $('.my_tap_div1').show();
                                });
                                $('.my_tap_2').click(function(){
                                   $('.my_tap_2').addClass("on");
                                   $('.my_tap_1').removeClass("on");
                                    $('.my_tap_div1').hide();
                                    $('.my_tap_div2').show();
                                });
                            </script>

								
								<div>
									<table>
										<colgroup>
											<col width=""/>
											<col width=""/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>출금 관리</th>
											</tr>
											<tr>
												<th colspan="2" class="caption">출금 수수료 : 무료/ 출금 최소 금액 : 1원 / 출금 최대 금액 : 무제한 (1일 기준)<br/>
												출금은 계좌 검증이 완료 된 본인 명의의 계좌로만 가능합니다.<br/>
												신청 후 약 20분 이내에 이체가 완료됩니다.<br/>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>출금액</th>
												<td><input type="" class="confirm_number" name="o_pay" value="" id=""  maxlength="" /></td>
											</tr>
											<tr>
												<th>은행명</th>
												<td>
												<?php echo bank_name($user[m_my_bankcode])?>
												</td>
											</tr>
											<tr>
												<th>예금주</th>
												<td>												
												<?php echo $user[m_my_bankname]?>
												</td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td>
												<?php echo $user[m_my_bankacc]?>
												</td>
											</tr>
										</tbody>
									</table>
									<!--거래내역이 있고 은행,예금주,계좌등록된 경우에만 검증가능-->
									<?php if($user['m_verifyaccountuse']=="Y"){?>
										<a href="javascript:void(0);" class="btn_info_account" onclick="sendit(2)" >출금신청</a>
									<?php }else{?>
										<a href="javascript:void(0);" class="btn_info_account" onclick="sendit(3)" >출금신청</a>
									<?php }?>
								</div>							
							</div>
						</div>
					</form>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->

<script type="text/javascript">
function sendit(index){
	if(index=="1"){
	//if(!$('#agreement').is(':checked')){alert('투자자이용약관에 체크를 해주시기 바립니다.'); return false;}

	if(document.f.s_bnkCd[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
								
	document.f.action='{MARI_HOME_URL}/?up=virtualaccountissue';
	document.f.submit();
	}else if(index=="2"){
		if(!document.f.o_pay.value){
		alert('출금신청하실 금액을 입력하여 주십시오 예)300000');f.o_pay.focus();return false;
		}	

		document.f.action='{MARI_HOME_URL}/?up=withdrawl';
		document.f.submit();
	}else if(index=="3"){
		alert('출금신청은 계좌검증이 필요합니다. 인증센터로 이동합니다.');
		location.href='{MARI_HOME_URL}/?mode=mypage_confirm_center';
	}else if(index=="4"){

	if(document.f.s_bnkCd[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
								
	document.f.action='{MARI_HOME_URL}/?up=virtualaccountissue_loan';
	document.f.submit();

	}
}
</script>

<script>
/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>


{# footer}<!--하단-->