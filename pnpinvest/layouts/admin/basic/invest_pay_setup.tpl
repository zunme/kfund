<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">투자관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">투자/결제 설정</div>

		<h2 class="bo_title"><span>투자설정</span></h2>
	<form name="inset_form"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="is"/>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>투자설정</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
					<tbody>
						<tr>
							<th>법인투자자 가능한도</th>
							<td><input type="text" name="i_maximum_v" value="<?php echo number_format($inv['i_maximum_v']);?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
							<th>일반개인투자자 가능한도</th>
							<td><input type="text" name="i_maximum" value="<?php echo number_format($inv['i_maximum']);?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>							
						</tr>
						<tr>
							<th>전문투자자 가능한도</th>
							<td><input type="text" name="i_maximum_pro" value="<?php echo number_format($inv['i_maximum_pro']);?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>							
							<th>소득적격 개인투자자 가능한도</th>
							<td><input type="text" name="i_maximum_in" value="<?php echo number_format($inv['i_maximum_in']);?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>							
						</tr>
						<tr>							
							<th>부도율설정</th>
							<td ><input type="text" name="i_default_rates" value="<?php echo $inv['i_default_rates'];?>" id="" class="frm_input " size="15" required size="" /> %</td>
							<th>연체율설정</th>
							<td ><input type="text" name="i_over_per" value="<?php echo $inv['i_over_per'];?>" id="" class="frm_input " size="15" required size="" /> %</td>
						</tr>
						<!--NEW★ 가이드라인에 따른 전문/소득적격 세금,수수료 추가OR 이자소득,주민세분리 설정 2017-10-10 START-->
						<tr>
							<th>수수료설정(개인)</th>
							<td ><input type="text" name="i_profit" value="<?php echo $inv['i_profit'];?>" id="" class="frm_input " required size="" /> <label for="">예)0.04=4%</label></td>
							<th>원천징수설정(투자회원-개인)</th>
							<td >소득세 : <input type="text" name="i_withholding_personal" value="<?php echo $inv['i_withholding_personal'];?>" id="" class="frm_input " size="15" required size="" /> 주민세 : <input type="text" name="i_withholding_personal_v" value="<?php echo $inv['i_withholding_personal_v'];?>" id="" class="frm_input " size="15" required size="" /> <label for="">원천징수+지방소득세</label></td>
						</tr>
						<tr>
							<th>수수료설정(법인)</th>
							<td ><input type="text" name="i_profit_v" value="<?php echo $inv['i_profit_v'];?>" id="" class="frm_input " required size="" /> <label for="">예)0.04=4%</label></td>
							<th>원천징수설정(투자회원-법인)</th>
							<td >소득세 : <input type="text" name="i_withholding_burr" value="<?php echo $inv['i_withholding_burr'];?>" id="" class="frm_input " size="15" required size="" /> 주민세 :  <input type="text" name="i_withholding_burr_v" value="<?php echo $inv['i_withholding_burr_v'];?>" id="" class="frm_input " size="15" required size="" /> <label for="">원천징수+지방소득세</label></td>
						</tr>
						<tr>
							<th>수수료설정(전문)</th>
							<td ><input type="text" name="i_profit_pro" value="<?php echo $inv['i_profit_pro'];?>" id="" class="frm_input " required size="" /> <label for="">예)0.04=4%</label></td>
							<th>원천징수설정(투자회원-전문)</th>
							<td >소득세 : <input type="text" name="i_withholding_pro" value="<?php echo $inv['i_withholding_pro'];?>" id="" class="frm_input " size="15" required size="" /> 주민세 : <input type="text" name="i_withholding_pro_v" value="<?php echo $inv['i_withholding_pro_v'];?>" id="" class="frm_input " size="15" required size="" /> <label for="">원천징수+지방소득세</label></td>
						</tr>
						<tr>
							<th>수수료설정(소득적격)</th>
							<td ><input type="text" name="i_profit_in" value="<?php echo $inv['i_profit_in'];?>" id="" class="frm_input " required size="" /> <label for="">예)0.04=4%</label></td>
							<th>원천징수설정(투자회원-소득적격)</th>
							<td >소득세 : <input type="text" name="i_withholding_in" value="<?php echo $inv['i_withholding_in'];?>" id="" class="frm_input " size="15" required size="" /> 주민세 :  <input type="text" name="i_withholding_in_v" value="<?php echo $inv['i_withholding_in_v'];?>" id="" class="frm_input " size="15" required size="" /> <label for="">원천징수+지방소득세</label></td>
						</tr>
					<!--NEW★ 가이드라인에 따른 전문/소득적격 세금,수수료 추가OR 이자소득,주민세분리 설정 2017-10-10 END-->
						<!--<tr>
							<th>누적투자액설정</th>
							<td ><input type="text" name="i_allpay" value="<?php echo number_format($inv['i_allpay']);?>" id="" class="frm_input " size="" required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
							<th>연체이자율</th>
							<td>
							<input type="text" name="i_overint" value="<?php echo $inv['i_overint'];?>" id="" class="frm_input " required size="15" /> <label for="">%</label>
							</td>
						</tr>-->
						<tr>
							<th>원천징수면제사용</th>
							<td>
							<input type="radio" name="i_exemption_use"  value="Y" <?php echo $inv['i_exemption_use']=='Y'?'checked':'';?> onclick="write_on(1)"> <label for="">사용함</label>
							<input type="radio" name="i_exemption_use"  value="N" <?php echo $inv['i_exemption_use']=='N'?'checked':'';?> onclick="write_on(2)"> <label for="">사용안함</label>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" name="i_exemption_pay" value="<?php echo number_format($inv['i_exemption_pay']);?>" id="write" class="frm_input " size=""  size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  <?php if($inv[i_exemption_use]=="N"){?>disabled<?php }?>/> <label for="">원</label>
							</td>
							<td></td>
							<td></td>
							<!--<th>누적상환액설정</th>
							<td ><input type="text" name="i_repayment" value="<?php echo $inv['i_repayment'];?>" id="" class="frm_input " size="30" required size="" /> </td>-->
						</tr>
						<script>
						function write_on(index){
							if(index=="1"){
								document.getElementById("write").disabled = false; 
							}else if(index=="2"){
								document.getElementById("write").disabled = true; 
								//document.getElementById("write").value = '';
							}
								
						}
						</script>
					</tbody>
			</table>
		</div>
	</form>
		<div class="local_desc02">
			<p>
				1. 투자가능한도 설정시 1회입찰 한도가 입력하신 금액이상 투자가 불가합니다.<br />
				2. 전체 연체이자를 설정할 수 있습니다.<br />
				3. 사이트 정산시 수수료설정이 가능하며 설정 값에따라 수수료로를 제외한 나머지금액이 투자자에게 정산됩니다.
			</p>
		</div>
		 
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="save_btn" title="저장" id="inset_form_add" />
		</div>
		 


		<h2 class="bo_title"><span>투자금액추가</span></h2>
<form name="schedule_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="w">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">상품선택</th>
						<td>
							<select name="loan_id">
								<option>상품을 선택하세요</option>
								<?php
								    for ($i=0; $row=sql_fetch_array($myloanlist); $i++) {
								?>
								<option value="<?php echo $row['i_id']; ?>"><?php echo $row['i_subject'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">금액</th>
						<td>
							<input type="text" name="i_pay"  id=""    onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="frm_input" size="" class="mr5" />
						</td>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" id="schedule_form_add" title="확인"  />
		</div>
<script>
/*필수체크*/
$(function() {
	$('#schedule_form_add').click(function(){
		Schedule_form_Ok(document.schedule_form);
	});
});


function Schedule_form_Ok(f)
{
	if(f.loan_id[0].selected == true){alert('\n투자상품을 선택하여 주십시오.');return false;}
	if(!f.i_pay.value){alert('\n투자금액을 입력하여 주십시오.');f.i_pay.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=admin_setup';
	f.submit();
}
</script>



		<h2 class="bo_title mt30"><span>결제설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>결제설정</caption>
				<colgroup>
					<col width="150px;" />
					<col width="200px" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
	<form name="invest_pay_setup_pg"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="pg"/>
					<tr>
					  <th>PG사용여부</th>
					  <td colspan="5">
						<p class="color_re fb">*사용체크를 하셔야만 PG사 이용이 가능합니다.</p>
						<ul>
							<li class="mb3"><input type="radio" name="c_seyfertck"  value="Y" <?php echo $config['c_seyfertck']=='Y'?'checked':'';?>> <label for="">사용함</label> <input type="radio" name="c_seyfertck"  value="N" <?php echo $config['c_seyfertck']=='N'?'checked':'';?>> <label for="">사용안함</label></li>
						</ul>
					  </td>
					</tr>
					<tr>
					  <th>PG사</th>
					  <td colspan="5">

						<select name="i_pgcom">
								<option>선택</option>
								<option value="seyfert" <?php echo $pg['i_pgcom']=='seyfert'?'selected':'';?>>페이게이트(seyfert)</option>
						</select>
					  </td>
					 </tr>

					<tr>
					  <th>PG정보 입력</th>
					  <td colspan="5">
						<p class="color_re fb">*발급받으신 GUID와 MEMKEY를 입력하여 주십시오.</p>
						<ul class="mt7">
							<li class="mb3">
								<label for=""><b>GUID :</b> </label> <input type="text" name="c_reqMemGuid" value="<?php echo $config['c_reqMemGuid'];?>" id="" class="frm_input " required size="30" /> 
							</li>
							<li>
								<label for=""><b>KEY :</b> </label> <input type="text" name="c_reqMemKey" value="<?php echo $config['c_reqMemKey'];?>" id="" class="frm_input " required size="100" /> 
							</li>
						</ul>
					  </td>
					</tr>

					<tr>
						<th>상환 계좌</th>
						<td>
							<select name="i_not_bank">
								<option>선택</option>
								<option value="KEB_005"  <?php echo $pg['i_not_bank']=="KEB_005"?'selected':'';?>>외환은행</option>
								<option value="KIUP_003"  <?php echo $pg['i_not_bank']=="KIUP_003"?'selected':'';?>>기업은행</option>
								<option value="NONGHYUP_011"  <?php echo $pg['i_not_bank']=="NONGHYUP_011"?'selected':'';?>>농협중앙회</option>
								<option value="SC_023"  <?php echo $pg['i_not_bank']=="SC_023"?'selected':'';?>>SC제일은행</option>
								<option value="SHINHAN_088"  <?php echo $pg['i_not_bank']=="SHINHAN_088"?'selected':'';?>>신한은행</option>
							</select>
						</td>
						<th>예금주</th>
						<td><input type="text" name="i_not_bankname" value="<?php echo $pg['i_not_bankname'];?>" id="" class="frm_input " size="20" /></td>
						<th>계좌번호</th>
						<td><input type="text" name="i_not_bankacc" value="<?php echo $pg['i_not_bankacc'];?>" id="" class="frm_input " size="50" /></td>
					</tr>
	</form>
<?php if(!$pg['i_not_bankacc']){?>
	<form name="facc" method="post">
					<tr>
						<th>상점계좌생성</th>
						 <td colspan="5">
													<select name="i_not_bank" required style="width:130px; height:25px; ">
														<option>은행선택</option>
														<option value="KEB_005"  <?php echo $pg['i_not_bank']=="KEB_005"?'selected':'';?>>외환은행</option>
														<option value="KIUP_003"  <?php echo $pg['i_not_bank']=="KIUP_003"?'selected':'';?>>기업은행</option>
														<option value="NONGHYUP_011"  <?php echo $pg['i_not_bank']=="NONGHYUP_011"?'selected':'';?>>농협중앙회</option>
														<option value="SC_023"  <?php echo $pg['i_not_bank']=="SC_023"?'selected':'';?>>SC제일은행</option>
														<option value="SHINHAN_088"  <?php echo $pg['i_not_bank']=="SHINHAN_088"?'selected':'';?>>신한은행</option>
													</select>
						<b>
						
						<?php if($pg['i_not_bankacc']){?> 현재 상점가상 계좌 생성됨 <?php }else{?>보유하신 계좌가 없습니다. <a href="javascript:void(0);" onclick="sendit_acc()" >[가상계좌 생성하기]</a><?php }?>

						</td>
					</tr>
	</form>
<?php }?>
				</tbody>
			</table>
		</div>






		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="save_btn" title="저장" id="invest_pay_setup_pg" />
		</div>


	<h2 class="bo_title"><span>출금신청</span></h2>
	<form name="f" method="post">
	<input type="hidden" name="type" value="w"/>
	<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>"/>
	<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>"/>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>출금신청</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
					<tbody>
						<tr>
							<th>출금금액</th>
							<td>출금가능액 : 							<?php
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
						원 <input type="text" name="o_pay" id="" class="frm_input " required size="" /> <label for="">원 *출금하실 금액을 정확히 입력하여 주십시오. 입력하신 금액만큼 출금 신청 됩니다.</label></td>
							<th></th>
							<td ></td>
						</tr>

					</tbody>
			</table>
		</div>
	</form>
		<div class="local_desc02">
			<p>
				1. 출금 전 해당 pg사 계약 시 상점 통장 사본을 보내주셨는지 확인해야 합니다.<br />
				2. pg 사에 상점 계좌가 등록되어야만 출금이 가능합니다.<br />
			</p>
		</div>
		 
		<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/save2_btn.png"/></a>
		</div>
		 

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>

function sendit_acc(){
	if(document.facc.i_not_bank[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
								
	document.facc.action='{MARI_HOME_URL}/?update=virtualaccountissue_admin';
	document.facc.submit();
}


/*투자설정*/
$(function() {
	$('#inset_form_add').click(function(){
		Inset_form_Ok(document.inset_form);
	});
});


function Inset_form_Ok(f)
{	 

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=invest_pay_setup';
	f.submit();
}


/*결제설정*/
$(function() {
	$('#invest_pay_setup_pg').click(function(){
		Invest_pay_setup_pg(document.invest_pay_setup_pg);
	});
});


function Invest_pay_setup_pg(f){

	//PG사
	if(f.i_pgcom[0].selected == true){alert('\nPG사를 선택하세요');return false;}




	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=invest_pay_setup';
	f.submit();
 }



function sendit(){
	if(!document.f.o_pay.value){
		alert('출금신청하실 금액을 입력하여 주십시오 예)300000');f.o_pay.focus();return false;
	}
	
	var ipay_pattern = /[^(0-9)]/;//숫자
	if(ipay_pattern.test(f.o_pay.value)){alert('\n출금액은 숫자만 입력하실수 있습니다');f.o_pay.value='';f.o_pay.focus();return false;}	 


	document.f.action='{MARI_HOME_URL}/?update=withdrawl_ok';
	document.f.submit();
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

{# s_footer}<!--하단-->