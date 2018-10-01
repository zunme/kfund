<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶투자정보
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{# header_sub} 
		<div id="container">
			<div id="main_content">
				<div class="invest_view">
					<div class="invest_view_inner">
						<h3><?php echo $loa[i_subject]?></h3>
						<p class="p_date">
						<?php
						if($order_pay=="100" || $iv['i_invest_eday'] < $date){
							echo '모집종료';
						}else{
							 echo substr($iv[i_invest_sday],0,4).'.'.substr($iv[i_invest_sday],5,2).'.'.substr($iv[i_invest_sday],8,2).' ~ '.substr($iv[i_invest_eday],0,4).'.'.substr($iv[i_invest_eday],5,2).'.'.substr($iv[i_invest_eday],8,2);   
						}
						?>
						</p>
						<div  class="invest_view_box">
						<div class="investbarcontainer">
								<div class="investbar" style="width:100%" >
									<div class="investpecent" data-pro-bar-percent="<?php echo $order_pay?>%" data-pro-bar-delay="30" style="width:<?php echo $order_pay?>%" ></div>
								</div>
								<div class="loan_w">
								<p class="gauge g_left"><span class="mr5"><?php echo $order_pay?>%</span> 진행</p>
								<p class="gauge g_right">목표<span class="ml5"><?php echo change_pay($loa['i_loan_pay'])?>원</span></p>
								</div>
							</div>
							</div>
					</div><!-- invest_view_inner -->
				</div><!-- invest_view -->

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
	<input type="hidden" name="loan" value="<?php echo $loa['i_loan_type']?>">
	<?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>
	<input type="hidden" name="bank_update" value="Y"/>
	<?php }?>
				<div class="invest_wrap">
					<div class="invest2_section1">
						<h3 class="invest_list2 mb40"><p>투자하실 상품  : <?php echo $iv['i_id'];?>호 <?php echo $iv['i_invest_name'];?></p></h3>
						<table class="type6">
							<colgroup>
								<col width="14.2%" />
								<col width="14.2%" />
								<col width="14.2%" />
								<col width="14.2%" />
								<col width="14.2%" />								
							</colgroup>
							<thead>
								<tr>
									<th>대출 신청금액</th>
									<th>투자 가능 금액</th>
									<th>수익률</th>
									<!--<th>{_config['c_title']} 등급</th>-->
									<th>만기</th>
									<th>투자수익확인</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><?php echo number_format($loa[i_loan_pay]) ?>원</td>
									<td class="color_re fb"><?php echo number_format($invest_pay) ?>원</td>
									<td>연 <?php echo $loa['i_year_plus']; ?>%</td>
									<!--<td><?php echo $iv['i_grade'];?></td>-->
									<td><?php echo number_format($loa['i_loan_day']) ?>개월</td>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/invest_c_bt.png" alt="투자수익금액" onclick="Calculation()"/></a></td>
								</tr>
							</tbody>
						</table><!-- /type6 -->

						<p class="invest_txt3" style="text-align:right; ">
						<!--※ 최소 <?php echo number_format(unit($iv['i_invest_mini'])); ?>만원 이상부터 투자하실 수 있습니다.-->
						※ 최소 <?php echo unit2($iv['i_invest_mini']); ?>원 이상부터 투자하실 수 있습니다.
						</p>
						<p class="invest_txt1">
							<label for="" class="mr5">* 투자금액</label>
							<input type="text" name="i_pay" id="" required size="35" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="invest_add"/> 원
						</p>
					</div><!-- /invest2_section -->

					<div class="invest2_section2">
						<div class="invest2_section2_inner">
<!--2016.05.12추가-->
							<p class="invest_txt2">{_config['c_title']} 이용수수료(<?php echo $inv['i_profit'];?>%) 외에는 <strong>추가로 공제하는 비용이 없이</strong> 투자하시는 fund의 매월 원금 이자를 모두 지급 받게 되십니다. <br />							
<!--2016.05.12추가-->
							
							
							<h3 class="invest_list2 mt50 mb40"><p class="color_bl">투자위험 안내</p></h3>
							<p class="invest_txt2">
							
							온라인을 통한 금융투자상품의 투자는 회사의 권유 없이 고객님의 판단에 의해 이루어집니다.<br />
							부동산 건축 자금의 특성상, 상환 예정일 이전에 중도상환될 수 있습니다.<br />
							만기시 채무자의 상황에 따라 연체가 발생할 수 있고 채권추심 등을 통해 투자금 회수에 상당기간 소요될 수 있습니다.<br />
							부동산이 담보로 제공되나 채무 불이행시 경,공매등의 환가절차 과정에서 원금의 일부 손실이 발생할 수 있습니다.<br />
							당사는 원금 및 수익률을 보장하지 않으므로 투자시 신중한 결정 바랍니다.
							
							<p class="chk2">
								<label for="agreement1"><input type="checkbox"  name="agreement1" id="agreement1" />
								위의 투자위험을 확인하고 인지하였습니다.</label>
							</p>
							<p class="chk2 mt15">
								<label for="agreement2"><input type="checkbox"  name="agreement2" id="agreement2" />
								개인정보 수집 이용 제공 동의서의 내용을 읽었으며, 동의합니다.<span class="access"><a href="{MARI_HOME_URL}/?mode=common2" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false"">개인정보처리</a></span></label>
							</p>
							<p class="chk2 mt15">
								<label for="agreement3"><input type="checkbox"  name="agreement3" id="agreement3"  />
								투자자 이용약관의 내용을 읽고 동의합니다.<span class="access"><a href="{MARI_HOME_URL}/?mode=common1" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false"">투자자이용약관</a></span></label>
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
				


						</div><!-- /invest2_section2_inner -->
					</div><!-- /invest2_section2 -->

					<!--<div class="invest2_section2">
						<div class="invest2_section2_inner">
							<p class="chk2">
								<label for="agreement2"><input type="checkbox"  name="agreement2" id="agreement2" />
								개인정보 수집 이용 제공 동의서의 내용을 읽었으며, 동의합니다.</label>
							</p>
							<p class="chk2 mt15">
								<label for="agreement3"><input type="checkbox"  name="agreement3" id="agreement3"  />
								투자자 이용약관의 내용을 읽고 동의합니다.</label>
							</p>
						</div>
					</div><!-- /invest2_section2 -->

					<div class="invest2_section2">
						<div class="invest2_section2_inner">
							<h3 class="invest_list2 mb40"><p>나의 적립금 현황</p></h3>
							<table class="type13">
								<colgroup>
									<col width="190px" />
									<col width="" />
								</colgroup>
								<tbody>
								<?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>
									<tr>
										<th>나의 적립금 입금계좌</th>
										<td class="pt10 pb10">
										<p class="pb10">※ <b><?php echo $user['m_name'];?></b>님 께서는 은행/적립금 입금계좌가 설정되지 않았습니다. 정보를 입력하여 주십시오.</p>
										은행 <select name="m_my_bankcode" required>
													<option>선택</option>
							<?php
							   foreach($decode as $key=>$value){
								for($cnt=0; $cnt<count($value); $cnt++){
								if (!is_array($value)) $value = array(); 
							?>
									<option value="<?php echo $value[$cnt]['cdKey'];?>" <?php echo $user['m_my_bankcode']==$value[$cnt][cdKey]?'selected':'';?>><?php echo $value[$cnt]['cdNm'];?></option>
							<?php
								}
							   }
							?>
											</select> 
										 계좌번호 <input type="text" name="m_my_bankacc" value="<?php echo $user['m_my_bankacc'];?>" id="" onkeyup="warring(this);" onchange="warring(this);" required size="50"  class="invest_add"/>
										</td>
									</tr>
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
									<tr>
										<th>예금주</th>
										<td><input type="text" name="m_my_bankname"  id="" required size="30"  class="invest_add" onkeyup="warring2(this);" onchange="warring2(this);"/></td>
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
										<td class="color_re"><?php echo number_format($user[m_emoney]) ?>원</td>
									</tr>
									
					



								</tbody>
							</table>
								<table class="type13 mt50">
								<colgroup>
									<col width="190px" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
									<th>회원가입비밀번호</th>
										<td class="color_re">
									<input type="password" name="m_password" id="" value="" size="30" required/>
									</td>
									</tr>
								</tbody>
								</table>

							<p class="invest_txt3">* 예치금을 충전한 후 투자에 참여하실 수 있습니다.</p>
						</div><!-- /invest2_section2_inner -->
					</div><!-- /invest2_section2 -->
					
					<div class="invest2_section2">
						<div class="invest2_section2_inner">
							<div class="pb40 invest_btn5">
								<a href="javascript:void(0)" id="inset_form_add">투자하기</a>
							</div>
						</div>
					</div>

				</div><!-- /invest_wrap -->
	</form>
			</div><!-- /sub_content -->
		</div><!-- /container -->

<script>
/*투자신청*/
$(function() {
	$('#inset_form_add').click(function(){
		Inset_form_Ok(document.inset_form);
	});
});


function Inset_form_Ok(f)
{
	if(!f.i_pay.value){alert('\n투자하실 금액을 입력하여 주십시오.');f.i_pay.focus();return false;}
    
	//var lloan_pattern = /[^(0-9)]/;//숫자
	//if(lloan_pattern.test(f.i_pay.value)){alert('\n투자금액은 숫자만 입력하실수 있습니다');f.i_pay.value='';f.i_pay.focus();return false;}
	if(!f.i_danger.value){alert('투자위험고지 동의해주세요.');f.i_danger.focus();return false;}
	if(!$('#agreement1').is(':checked')){alert('투자위험을 확인하시고 체크하여 주십시오.'); return false;}
	if(!$('#agreement2').is(':checked')){alert('개인정보 수집 이용 제공 동의서에 체크하여 주십시오.'); return false;}
	if(!$('#agreement3').is(':checked')){alert('투자자 이용약관에 체크하여 주십시오.'); return false;}

<?php if(!$user[m_my_bankcode] || !$user[m_my_bankacc]){?>

	if(f.m_my_bankcode[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
	if(!f.m_my_bankacc.value){alert('\n계좌번호를 입력하여 주십시오.');f.m_my_bankacc.focus();return false;}
	if(!f.m_my_bankname.value){alert('\n예금주를 입력하여 주십시오.');f.m_my_bankname.focus();return false;}

<?php }?>
	
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
	//var lloan_pattern = /[^(0-9)]/;//숫자
	//if(lloan_pattern.test(f.i_pay.value)){alert('\n투자금액은 숫자만 입력하실수 있습니다');f.i_pay.value='';f.i_pay.focus();return false;}
  window.open("about:blank", "calculation", opt);
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