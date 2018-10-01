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
					<div class="dashboard_my_info">
							<h3><span>정보수정</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_basic">기본 정보</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center" class="info_current">인증센터</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_out" class="">회원탈퇴</a></li>
								</ul>
							</h3>
							<form name="my_bank_info"  method="post" enctype="multipart/form-data">
							<input type="hidden" name="m_no" value="{_mmo['m_no']}"/>
							<input type="hidden" name="mode" value="member_modify"/>
							<input type="hidden" name="m_hp" value="<?php echo $user[m_hp]?>">
							<input type="hidden" name="type" value="withholding">
							<div class="dashboard_info_account">
								<div>
									<table>
										<colgroup>
											<col width="120px"/>
											<col width="276px"/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>출금 계좌 정보<a href="{MARI_HOME_URL}/?up=verifyaccount" class="account_verify">SMS계좌검증</a>
													<a href="{MARI_HOME_URL}/?up=verifyaccount&authType=ARS" class="account_verify">ARS계좌검증하기</a></th>
											</tr>
											<tr>
												<th colspan="2" class="caption">투자의 원리금 수취용 계좌 정보(본인 명의 필수)를 입력해 주세요.<br/>
												은행 전산망 점검 시간인 23:30~01:00 사이에는 이용에 제한이 있을 수 있습니다.<br/>
												계좌검증 시 최대 4분 정도 소요될 수 있으며, SMS로 4자리의 숫자를 회신 후<br/>
												처리안내 SMS 수신과 동시에 정상적으로 출금 하실 수 있습니다</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>은행명</th>
												<td>
													<select name="m_my_bankcode" required class="s_bnkCd">
													<option>===일반 계좌===</option>
													<?php
													   foreach($decode as $key=>$value){
														for($cnt=0; $cnt<count($value); $cnt++){
														if (!is_array($value)) $value = array(); 
													?>
														<option value="<?php echo $value[$cnt]['cdKey'];?>" <?php echo $mmo['m_my_bankcode']==$value[$cnt][cdKey]?'selected':'';?>><?php echo $value[$cnt]['cdNm'];?></option>
													<?php
														}
													   }
													?>
													<option>===증권 계좌===</option>
													<?php
													   foreach($decode_secu as $key=>$value){
														for($cnt=0; $cnt<count($value); $cnt++){
															if (!is_array($value)) $value = array(); 
													?>
															<option value="<?php echo $value[$cnt]['cdKey'];?>" <?php echo $mmo['m_my_bankcode']==$value[$cnt][cdKey]?'selected':'';?>><?php echo $value[$cnt]['cdNm'];?></option>
													<?php
															}
														   }
													?>
												</select> 
												</td>
											</tr>
											<tr>
												<th>계좌주</th>
												<td><input type="text" class="confirm_number" name="m_my_bankname" value="<?php echo $user[m_my_bankname];?>" id="" onkeyup="warring2(this);" onchange="warring2(this);"placeholder="계좌주를 입력해주세요"/></td>
											</tr>
											<tr>
												<th>계좌 번호</th>
												<td><input type="text" class="confirm_number" name="m_my_bankacc" value="<?php echo $user[m_my_bankacc];?>" id=""  maxlength="" onKeyDown = "javascript:onlyNumberInput()" placeholder="계좌번호를 입력해주세요" /></td>
											</tr>
										<script>
											/*계좌번호 숫자만 입력이 가능하게*/
											function onlyNumberInput(){
												 var code = window.event.keyCode;
												 
												 if ((code > 34 && code < 41) || (code > 47 && code < 58) || (code > 95 && code < 106) || code == 8 || code == 9 || code == 13 || code == 46)
												 {
												  window.event.returnValue = true;
												  return;
												 }
												 window.event.returnValue = false;
												
												  
											}
											/*예금주 공백입력 불가하게*/
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
										</tbody>
									</table>
										<a href="#" class="btn_info_account" id="member_form_add">확인</a>
								</div>

								<div>
									<table>
										<colgroup>
											<col width="120px"/>
											<col width="276px"/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>원천징수정보</th>
											</tr>
											<tr>
												<th colspan="2" class="caption">원천징수정보를 등록하셔야 투자가 가능합니다.<br/>
													<span><strong class="help">?<span>입력하신 주민등록번호와 주소는<br/>원천징수 시 사용됩니다.<br/>원천징수란, 투자 수익이 발생했을 시<br/>투자자가 부담해야 할 세액을<br/>'플랫폼 사이트'가 국가를 대신해<br/>미리 징수하고 투자자의 소득 정보를<br/>신고하는 것을 말합니다.<br/>정보를 입력하셔야 투자가 가능합니다.</span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;왜 주민등록번호를 입력해야 할까요?</span>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>주민등록번호</th>
												<td>
													<input type="text" class="confirm_number rrn1" name="reginum1" value="<?php echo substr($user[m_reginum],0,6)?>" id="6" onKeyDown = "javascript:onlyNumberInput()" maxlength="6" /><span class="">-</span>
													<input type="password" class="confirm_number rrn2" name="reginum2" value="<?php echo substr($user[m_reginum],6,7)?>" id="" onKeyDown = "javascript:onlyNumberInput()"  maxlength="7" />
												</td>
											</tr>
											<tr>
												<th>주소</th>
												<td>
													<input type="text" class="confirm_number post_number mb10" name="m_with_zip" value="<?php echo $user[m_with_zip]?>" id="post1"  maxlength="" placeholder="주소를 입력해주세요" />
													<span id="guide" style="color:#999; display:none;"></span>
													<a href="javascript:execDaumPostcode()" class="find_post">우편번호찾기</a>
													<input type="text" class="confirm_number address mb10" name="m_with_addr1" value="<?php echo $user[m_with_addr1]?>" id="addr1"  maxlength="" placeholder="상세주소를 입력해주세요"/>
													<input type="text" class="confirm_number address" name="m_with_addr2" value="<?php echo $user[m_with_addr2]?>" id="addr2"  maxlength="" placeholder="상세주소를 입력해주세요"/>
												</td>
											</tr>
										</tbody>
									</table>
									<a href="javascript:void(0);" onclick="test()" class="btn_info_account" >확인</a>									
								</div>
									
							</div>
						</form>
					</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullRoadAddr;
                document.getElementById('addr2').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
<script>
/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.my_bank_info);
	});
});


function Member_form_Ok(f)
{	

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
function test(){
	var f = document.my_bank_info;

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>


{# footer}<!--하단-->