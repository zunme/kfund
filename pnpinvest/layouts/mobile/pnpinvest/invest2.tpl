<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶투자정보
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#header} 



	<section id="container">
		<section id="sub_content">
			<div class="invest_wrap">
				<div class="container">
					<h3 class="s_title1">투자 신청</h3>
	<form name="inset_form"  method="post" enctype="multipart/form-data" target="calculation">
	<input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
	<input type="hidden" name="m_no" value="<?php echo $user[m_no]; ?>">
	<input type="hidden" name="m_id" value="<?php echo $user[m_id]; ?>">
	<input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
	<input type="hidden" name="i_loan_day" value="<?php echo $loa[i_loan_day]; ?>">
	<input type="hidden" name="i_year_plus" value="<?php echo $loa[i_year_plus]; ?>">
	<input type="hidden" name="i_repay" value="<?php echo $loa[i_repay]; ?>">
	<input type="hidden" name="type" value="w"/>
	<input type="hidden" name="stype" value="invest"/>
	<?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>
	<input type="hidden" name="bank_update" value="Y"/>
	<?php }?>
					
					<div class="invest2_cont1">
						 <h4 class="invest_title4">투자하실 상품 정보</h4>
						 <p>투자하실 상품  : <?php echo $iv['i_id'];?>호 <?php echo $iv['i_invest_name'];?></p>
						<table class="type3">
							<colgroup>
								<col width="35%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>대출신청금액</th>
									<td><?php echo number_format($loa[i_loan_pay]) ?>원</td>
								</tr>
								<tr>
									<th>투자가능금액</th>
									<td class="color_re fb"><?php echo number_format($invest_pay) ?>원</td>
								</tr>
								<tr>
									<th>수익률</th>
									<td>연 <?php echo $loa['i_year_plus']; ?>%</td>
								</tr>
									<th>{_config['c_title']} 등급</th>
									<td><?php echo $iv['i_grade'];?>등급</td>
								</tr>
								<tr>
									<th>만기</th>
									<td><?php echo number_format($loa['i_loan_day']) ?>개월</td>
								</tr>
								<tr>
									<th>투자수익확인</th>
									<td><a href="javascript:void(0);"><span alt="투자수익금액" onclick="Calculation()"  class="inquiry1"/>투자수익금액</span></td>
								</tr>
								<tr>	
								</tr>
							</tbody>
						</table><!-- /type6 -->
						 <table class="type9 mt20">
						    <colgroup>
							<col width="25%" />
							<col width="" />
						    </colgroup>
							<tr>
							 <th>투자 금액</th>
							<td><input type="text" name="i_pay" id="" required size="35" class="invest_add"/>&nbsp;&nbsp;원</td>
							</tr>
						</table>
						<span class="invest_am">(최소 <?php echo unit2($iv['i_invest_mini']); ?>원 이상 부터투자하실 수 있습니다.)</span>
						<h4 class="invest_title5">투자 위험 안내</h4>
						<!--<p class="invest2_txt1">당사는 원금 및 수익을 보장하지 않습니다. 다만, 채권 추심에 도의적 책임을 다합니다. 상환일정 및 상환액 안내, 연체 시 연체이율 안내, 연체 시 불이익 안내에 최선을 다하며 장기 연체시 채권 추심(매각 등) 후 투자자에게 배분합니다. <br />
						매월 상환일에 상환금액에서 당사 서비스 수수료 <?php echo $inv['i_profit'];?>% 를 제외한 나머지 금액을 입금해드립니다.<br />
						<span>* 단, 베타서비스 기간 동안 서비스 수수료 없습니다.</span>
						</p>-->
						<p class="invest_txt2">
							
							온라인을 통한 금융투자상품의 투자는 회사의 권유 없이 고객님의 판단에 의해 이루어집니다.<br />
							부동산 건축 자금의 특성상, 상환 예정일 이전에 중도상환될 수 있습니다.<br />
							만기시 채무자의 상황에 따라 연체가 발생할 수 있고 채권추심 등을 통해 투자금 회수에 상당기간 소요될 수 있습니다.<br />
							부동산이 담보로 제공되나 채무 불이행시 경,공매등의 환가절차 과정에서 원금의 일부 손실이 발생할 수 있습니다.<br />
							당사는 원금 및 수익률을 보장하지 않으므로 투자시 신중한 결정 바랍니다.
						</p>
				 
							
						 <div class="invest_chk1">
							<p class="chk2">
								<label for="agreement1"> <input type="checkbox"  name="agreement1" id="agreement1" />
								위의 투자위험을 확인하고 인지하였습니다.</label>
							</p>
							<p class="chk2">
								<label for="agreement2"> <input type="checkbox"  name="agreement2" id="agreement2" />
								개인정보 수집 이용 제공 동의서의 내용을 읽었으며, 동의합니다.</label>
								<span class="access ml23"><a href="{MARI_HOME_URL}/?mode=common2" >개인정보처리</a></span>
							</p>
							<p class="chk2">
								<label for="agreement3"> <input type="checkbox"  name="agreement3" id="agreement3"  />
								투자자 이용약관의 내용을 읽고 동의합니다.</label>
								<span class="access ml23"><a href="{MARI_HOME_URL}/?mode=common1" >투자자이용약관</a></span>
							</p>
						
			   
			   
			   <div class="info5">		
					<div>
						<h4 class="click_pop_back"><a href="javascript:;" class="danger01">투자위험고지 보기</a></h4>
					</div>
				</div>
               <div class="danger02">
					 <p>투자위험 고지 </p>
					 <p>본 투자상품은 원금이 보장되지 않습니다.<br/>
						모든 투자 상품은 현행 법률 상 ‘유사수신행위의 규제에 관한 법률’에 의거하여<br/>
						원금과 수익을 보장할 수 없습니다.<br/>
						또한 차입자가 원금의 전부 또는 일부를 상환하지 못할 경우<br/>
						발생하게 되는 투자금 손실 등 투자 위험은 투자자가 부담하게 됩니다.
					 </p>
					 <p>본인(투자자)은 상기 내용을 확인 하였으며, 그내용에</p>
                     <input type="text" placeholder="동의함(직접입력)" name="i_danger"  id="i_danger" onkeyup="danger(this);" onchange="danger(this);"  />
				
				<a href="javascript:;" class="ex_hide02">접기</a>
				</div>
			  
			  </div>
				 
				

				 <script>

				$(function(){
				  var ex_show = $('.danger01');
				  var ex_hide = $('.ex_hide02');
				  var ex_box = $('.danger02');
				  ex_show.click(function(){
					ex_box.slideDown(1000);
					/*ex_show.hide();*/
				  });
				  ex_hide.click(function(){
					ex_box.slideUp(1000);
					ex_show.show();
				  });
				});
			</script>
						<h4 class="invest_title4">나의 적립 현황</h4>
						<table class="type8">
							<colgroup>
								<col width="" />
							</colgroup>
							</thead>
							<tbody>
								<?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>

									<tr>
										<th>나의 적립금 입금계좌</th>
										<td class="pt10 pb60">
										<p class="">※ <b><?php echo $user['m_name'];?>님!</b>계좌 정보를 입력하여 주십시오.</p>
										<div class="cl_b">
										<div class="col-sm-3 col-xs-4" style="padding:0 3px">
											<select name="m_my_bankcode" required class="frm_input form-control col-xs-12">
														<option value="선택">은행을 선택해주세요</option>
														<option value="국민은행" <?php echo $user['m_my_bankcode']=='국민은행'?'selected':'';?>>국민은행</option>
														<option value="우리은행" <?php echo $user['m_my_bankcode']=='우리은행'?'selected':'';?>>우리은행</option>
														<option value="신한은행" <?php echo $user['m_my_bankcode']=='신한은행'?'selected':'';?>>신한은행</option>
														<option value="하나은행" <?php echo $user['m_my_bankcode']=='하나은행'?'selected':'';?>>하나은행</option>
														<option value="스탠다드차지은행" <?php echo $user['m_my_bankcode']=='스탠다즈차지은행'?'selected':'';?>>스탠다드차지은행</option>
														<option value="한국씨티은행" <?php echo $user['m_my_bankcode']=='한국씨티은행'?'selected':'';?>>한국씨티은행</option>
														<option value="농협" <?php echo $user['m_my_bankcode']=='농협'?'selected':'';?>>농협</option>
														<option value="수협" <?php echo $user['m_my_bankcode']=='수협'?'selected':'';?>>수협</option>
														<option value="신협" <?php echo $user['m_my_bankcode']=='신협'?'selected':'';?>>신협</option>
														<option value="우체국" <?php echo $user['m_my_bankcode']=='우체국'?'selected':'';?>>우체국</option>
														<option value="새마을금고" <?php echo $user['m_my_bankcode']=='새마을금고'?'selected':'';?>>새마을금고</option>
														<option value="기업은행" <?php echo $user['m_my_bankcode']=='기업은행'?'selected':'';?>>기업은행</option>
												</select> 
										</div>
										
										<div class="col-sm-3 col-xs-8" style="padding:0 3px">
											 <input type="text" name="m_my_bankacc" value="<?php echo $user['m_my_bankacc'];?>" id="" required size="50" onkeyup="warring(this);" onchange="warring(this);" placeholder="계좌번호를 입력해주세요" class="frm_input form-control col-xs-12"/>
											 <script>
										/*계좌번호 숫자만 입력이 가능하게*/
										function warring(cnj_str) { 
											var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
											var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
											var a_num = cnj_str.value;
											var cnjValue = ""; 
											var cnjValue2 = "";

											if ((t_num < "0" || "9" < t_num)){
												if(t_num ==""){
												}else{
													alert("숫자만 입력하십시오.");
													cnj_str.value="";
													cnj_str.focus();
													return false;
												}
											}

											if(a_num.indexOf(" ") >= 0 ){
											alert("공백은 입력하실 수 없습니다.");
											cnj_str.value="";
											cnj_str.focus();
											return false;
											}
										}
									</script>
										</div>
										</div>
										</td>
									</tr>
									<tr>
										<th>예금주</th>
										<td class="pb60">
											<div class="col-xs-12" style="padding:0 3px"><input type="text" name="m_my_bankname" value="<?php echo $user['m_my_bankname'];?>" id="" required size="30"  class="frm_input form-control col-xs-12" onkeyup="warring2(this);" onchange="warring2(this);"/></td>
											</div>
									</tr>
									<script>
										/*예금주 공백 입력이 불가능하게*/
										function warring2(cnj_str) { 
											var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
											var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
											var a_num = cnj_str.value;
											var cnjValue = ""; 
											var cnjValue2 = "";
											

											if(a_num.indexOf(" ") >= 0 ){
											alert("공백은 입력하실 수 없습니다.");
											cnj_str.value="";
											cnj_str.focus();
											return false;
											}
										}
									</script>
								<?php }else{?>
								<tr>
										<th>나의 적립금 입금계좌</th>
										<td>
										<?php echo bank_name($user['m_my_bankcode']);?> <?php echo $user['m_my_bankacc'];?>
										</td>
									</tr>
									<tr>
										<th>예금주</th>
										<td><?php echo $user['m_my_bankname'];?></td>
									</tr>

								<?php }?>
					

								
									<tr>
										<th>사용 가능한 적립금</th>
										<td class=""><strong><?php echo number_format($user[m_emoney]) ?>원</strong></td>
									</tr>
									<tr>
										<th>비밀번호</th>

										<td class="pb60">
										<div class="col-xs-12" style="padding:0 3px"><input type="password" name="m_password" value="" id="" required size="30"  class="frm_input form-control col-xs-12"/></td>
											</div>
									</tr>
								</tbody>
							</table>
						<p class="invest2_txt2">* 예치금 충전 후 투자에 참여하실 수 있습니다.</p>
						<div class="inve_btn_wrap2"><a href="javascript:;" id="inset_form_add" class="mobile_btn"/>투자하기</a></div>
					</div><!-- /invest_wrap -->
				</form>
				</div><!--container-->
			</div><!-- /invest_wrap-->
		</section><!-- /sub_content -->
	</section><!-- /container -->

















<script>
/*투자신청*/
$(function() {
	$('#inset_form_add').click(function(){
		Inset_form_Ok(document.inset_form);
	});
});


function Inset_form_Ok(f)
{
	  if(!f.i_danger.value){alert('투자위험고지 동의해주세요.');f.i_danger.focus();return false;}
	if(!f.i_pay.value){alert('\n투자하실 금액을 입력하여 주십시오.');f.i_pay.focus();return false;}
	if(!$('#agreement1').is(':checked')){alert('투자위험을 확인하시고 체크하여 주십시오.'); return false;}
	if(!$('#agreement2').is(':checked')){alert('개인정보 수집 이용 제공 동의서에 체크하여 주십시오.'); return false;}
	if(!$('#agreement3').is(':checked')){alert('투자자 이용약관에 체크하여 주십시오.'); return false;}
/*
<?php if(!$user[m_my_bankcode] || !$user[m_my_bankacc]){?>

	if(f.m_my_bankcode[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
	if(!f.m_my_bankacc.value){alert('\n계좌번호를 입력하여 주십시오.');f.m_my_bankacc.focus();return false;}
	if(!f.m_my_bankname.value){alert('\n예금주를 입력하여 주십시오.');f.m_my_bankname.focus();return false;}

<?php }?>
*/
	if(!f.m_password.value){alert('\n비밀번호를 입력하여 주십시오'); f.m_password.focus(); return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=invest2';
	f.submit();
}
/*매월 투자수익계산*/
function Calculation() { 
  var f=document.inset_form;
  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
	if(!f.i_pay.value){alert('\n투자하실 금액을 입력하여 주십시오.');f.i_pay.focus();return false;}
 
  f.action="{MARI_HOME_URL}/?mode=calculation";
  f.submit();
}

function cnj_comma(cnj_str) { 
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = ""; 
		var cnjValue2 = "";

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		for(i=0; i<cnj_str.value.length; i++)      {   
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") { 
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2; 
		} 
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue; 
		} else { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue; 
		} 
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}

</script>
		
{# footer}<!--하단-->