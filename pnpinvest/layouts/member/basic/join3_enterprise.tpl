<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 정보입력
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->



<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#header} 
<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
						<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>-->
						<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="join_wrap">
					<div class="join_inner">
					<h3>절차에 따라 회원가입을 진행해 주세요.</h3>
					<div class="join_step">
						<ul>
							<li >본인인증</li>
							<li class="list_on">정보입력</li>
							<li>가입완료</li>
						</ul>
					</div>
					
				
	<form name="member_form"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="m_no" value="<?php echo $mmo['m_no']; ?>">
	<input type="hidden" name="m_level" value="3">
	<input type="hidden" name="mode" value="join3">
	<input type="hidden" name="agreement1" value="yes">
	<input type="hidden" name="agreement2" value="yes">
	<input type="hidden" name="m_blindness" value="<?php echo $m_blindness_use;?>"><!--실명인증결과-->
	<input type="hidden" name="m_ipin" value="<?php echo $m_ipin_use;?>"><!--아이핀인증결과-->
					 <div class="table_wrap3">
						<table class="type9">
							<colgroup>
								<col width="200px" />
								<col width="" />
							</colgroup>
							<tbody>
								
								<tr>
									<!--<th><span class="bullet1">이메일 아이디</span></th>-->
									<td><input type="text" name="m_id" id="id" onkeyup="warring(this);" onchange="warring(this);" value="<?php echo $_COOKIE['m_id']; ?>" size="38" placeholder="이메일 아이디 (로그인시 아이디로 사용됩니다)"  maxlength="40" required/>									
									</td>
								</tr>
								<script>
								/*아이디 공백입력 못하게*/
								function warring(cnj_str) { 
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
								//이름 한글입력만 받기
								function warring2(cnj_str) { 

									if((event.keyCode < 12592) || (event.keyCode > 12687))
									event.returnValue = false
								}
								</script>								
								<tr>
									<!--<th><span class="bullet1">비밀번호</span></th>-->
									<td><input type="password" name="m_password" id="" size="38" placeholder="비밀번호(영문자 조합 8~20 자 이내)"  maxlength="20" required/></td>
								</tr>
								
								<tr>
									<!--<th><span class="bullet1">비밀번호 확인</span></th>-->
									<td><input type="password" name="m_password_re" id="pw_re" size="38" onblur="pwCheck(this);" placeholder="비밀번호를 한번 더 입력해 주세요" /></td>
								</tr>
								<tr>
									<td><input type="text"  name="m_companynum"  value="<?php echo $_COOKIE['m_companynum']; ?>"placeholder="사업자등록번호(법인/개인 사업자등록번호를 입력하세요.)"  size="38"required maxlength="40" <?php echo $config['c_req_nick']=='Y'?'required':'';?>/></td>
								</tr>
								<!--<tr>
								<?php if($config['c_companynum_use']=="Y"){?>
									<!--<th><span <?php echo $config['c_companynum_use']=='Y'?'class="bullet1"':'';?>>사업자등록번호</span></th>
									<td><input type="text" name="m_nick" id="id" onKeyup="idChk(this.value);" value="<?php echo $_COOKIE['m_companynum']; ?>" size="38" placeholder="사업자등록번호(법인/개인 사업자등록번호를 입력하세요.)"  maxlength="40" <?php echo $config['c_req_nick']=='Y'?'required':'';?>/>
								<?php }?>
								</tr>-->
								<tr>
									<td><input type="text"  name="m_company_name" value="<?php echo $_COOKIE['m_company_name'];?>" placeholder="기업명을 입력하세요"  size="38" required/></td>
								</tr>
								<tr>
									<td><input type="text"  name="m_name" value="<?php echo $_COOKIE['m_name'];?>" onKeyPress="warring2()" placeholder="담당자명(한글입력만 가능합니다.)"  size="38"required maxlength="10"/></td>
								</tr>

								<tr>
									<td>
										
									<span class="sub_name">생일</span>										
										<input type="text" name="birth1" id="birth_w"  title="년"  maxlength="4" required onKeyPress="warring4" placeholder="년(4자)"  class="form-control  " />
									
										<select name="birth2" id="bir_point">
											<option>월</option>
										<?php for($i=1; $i<=12; $i++){?>
											<option value="<?php echo $i;?>" <?php echo $_COOKIE['birth2']== $i ?'selected':'';?>><?php echo $i; ?></option>
										<?php }?>
										</select>
										
										<input type="text" name="birth3" id="birth_w"  title="년" required onKeyPress="warring4" placeholder="일"  class="form-control  " />
									</td>
								</tr>								
								
								<tr>
								<?php if($config['c_use_hp']=="Y"){?>
									<!--<th><span <?php echo $config['c_req_hp']=='Y'?'class="bullet1"':'';?>>휴대폰번호</span></th>-->
									<td>
										<!--<span class="sub_name1">휴대폰번호</span>-->
										<select name="m_newsagency" >
											<option>통신사선택</option>
											<option value="SKT" <?php echo $_COOKIE['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
											<option value="KT" <?php echo $_COOKIE['m_newsagency']=='KT'?'selected':'';?>>KT</option>
											<option value="LGT" <?php echo $_COOKIE['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
											<option value="기타" <?php echo $_COOKIE['m_newsagency']=='기타'?'selected':'';?>>기타</option>
										</select> 										
										<input type="text" name="hp2" placeholder="휴대폰번호" value="<?php echo $_COOKIE['hp2'];?><?php echo $_COOKIE['hp3'];?>" id="birth_ph"  class="frm_input " size="10" maxlength="11" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/> 
										<!--<input type="text" name="hp3" value="<?php echo $_COOKIE['hp3'];?>" id="birth_ph"  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/>
										<label for="m_sms">-->
									</td>
								<?php }?>
								</tr>
								<?php if($config['c_use_addr']=="Y"){?>
								<tr>
									<!--<th><span <?php echo $config['c_req_addr']=='Y'?'class="bullet1"':'';?>>주소</span></th>-->
									<td>
										<input type="text" name="m_zip" placeholder="사업장 주소" value="<?php echo $_COOKIE['m_zip']?>" style="width:56%" id="post1" <?php echo $config['c_req_addr']=='Y'?'required':'';?>>&nbsp&nbsp<a href="javascript:execDaumPostcode()" ><div class="addbox"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></div></a>
										<span id="guide" style="color:#999"></span>
										<p class="">
											<input type="text" name="m_addr1" id="addr1"   alt='주소'  value='<?=$_COOKIE['m_addr1']?>' size="30" placeholder="나머지 주소를 입력해주세요"  style="border-top:1px solid #dbdada;";required/>
											<!--<input type="text" name="m_addr2" id="addr2"  alt='주소'  value='<?=$_COOKIE['m_addr2']?>' size="30" required/>-->
										</p>
									</td>
								</tr>
								<?php }?>
								<!--<tr>-->
									<!--<th><span <?php echo $config['c_req_homepage']=='Y'?'class="bullet1"':'';?>>회원구분</span></th>-->
									<!--<td>
									<select name="birth2" id="membder_list" style="width:100%;">
											<option>회원구분</option>
											<option name="company_invest_m" id="general_member" value="N" >투자회원</option>
											<option name="company_invest_m" id="income_member" value="I" >대출회원</option>
									</select>-->
									<!--<span class="sub_name1">회원구분</span>
										<span class="membder_box">
										<label for="company_invest_m"><input type="radio" name="member" id="company_invest_m" value="company_invest_m" />/label>&nbsp;&nbsp;
										<label for="company_loan_m"><input type="radio" name="member" id="company_loan_m" value="company_loan_m"/>대출회원</label>&nbsp;&nbsp;
										</span>-->
<!-- 									</td> -->
<!-- 								</tr> -->
								<?php if($config['c_use_homepage']=="Y"){?>
								<!--<tr>
									<th><span <?php echo $config['c_req_homepage']=='Y'?'class="bullet1"':'';?>>홈페이지주소</span></th>
									<td>
										<input type="text" name="m_homepage" id="" value="<?php echo $_COOKIE['m_homepage']; ?>" size="64"  maxlength="50" <?php echo $config['c_req_homepage']=='Y'?'required':'';?>/>
									</td>
								</tr>-->
								<?php }?>
								<tr>
									<!--<th><span>추천인</span></th>-->
									<td><input type="text" name="m_referee" id="" value="<?php echo $_COOKIE['m_referee']; ?>" size="38"  maxlength="20" placeholder="추천인" required /></td>
								</tr>
							</tbody>
						</table>
						<div id="tab-1" class="tab-content2">
							<div class="part1">	
								<div class="faq1">								
									<p class="question">이용약관[필수]</p>
									<ul class="answer">
										<li class="clr">
											이용약관내용
										</li> 
									</div>
										<div class="chbox"><input type="checkbox" name="terms" id="terms1" value="terms"/> <label>이용약관에 동의합니다.</label></div>
									</ul>
									<div class="faq1">	
									<p class="question">개인 정보 수집 및 이용 안내[필수]</p>
									<ul class="answer">
										<li class="clr">
											이용약관내용
										</li>                        	  
									</ul>
									<div class="chbox"><input type="checkbox" name="terms" id="terms2" value="terms"/> <label>이용약관에 동의합니다.</label></div>	
								</div>						
							</div><!--//part1 e -->
						</div><!--tab-3-->
					</div>
					<div class="joun_btn">
						<a href="{MARI_HOME_URL}/?mode=join2"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" style="float:left; "/></a>
						<img src="{MARI_HOMESKIN_URL}/img/btn_next1.png" alt="다음" id="member_form_add" style="cursor:pointer; float:right;"/>
					</div>

						<script>
								$(function(){
									$(".answer").hide();
									$(".question").click(function(){
									$(".answer:visible").slideUp("middle");
									$(this).next('.answer:hidden').slideDown("middle");
									return false;
									})
								});
							</script>	
					 </div><!-- /table_wrap3 -->

	</form>
					

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
//                document.getElementById('addr2').focus();
                
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
//이메일값 가져오기
function getSelectValue(frm){
	//frm.email3.value = frm.email2.options[frm.email2.selectedIndex].text;

	frm.m_id2.value = frm.m_id3.options[frm.m_id3.selectedIndex].value;
}

$(function() {
	var languages = [
	"dd"
	];

	$( "#id" ).autocomplete({
		source: languages
	});
});

/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok(f)
{
	
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id1.focus();return false;}

	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test(f.m_id.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.m_id.focus(); return false;
	}
	
	
	if(!f.m_password.value){alert('\n비밀번호를 입력하여 주십시오.');f.m_password.focus();return false;}
	if(!f.m_password_re.value){alert('\n비밀번호확인을 입력하여 주십시오.');f.m_password_re.focus();return false;}


	if(f.m_password.value.indexOf(" ") >= 0 ) {alert('\n패스워드에 공백이 있습니다.\n\n공백을 제거해주세요');f.m_password.focus();return false;}

	if(f.m_password.value.length < 8 || f.m_password.value.length > 20 ){alert('\n패스워드는 [8자~20자]이내 이어야 합니다.');f.m_password.focus();return false;}


			   if(!f.m_password.value.match(/[^(a-zA-Z)]/)) {
				 alert("비밀번호는 [영문자]와 [숫자], 특수문자(!,@,$,^,&,*)중  2종류~3종류 이상의 조합만으로 입력하세요.");
				 return false;
			   }else if(!f.m_password.value.match(/[^(0-9)]/)) {
				 alert("비밀번호는 [영문자]와 [숫자], 특수문자(!,@,$,^,&,*)중  2종류~3종류 이상의 조합만으로 입력하세요.");
				 return false;
			   }else{
			   }
	
	if(f.m_password.value != f.m_password_re.value){alert('\n설정하신 비밀번호와 비밀번호확인이 일치하지않습니다. \n다시 입력하여주십시오.'); f.m_password_re.focus(); return false;}

	if(!f.m_companynum.value){alert('\n사업자등록번호를 입력하여 주십시오.'); f.m_companynum.focus(); return false;}

	if(!f.m_company_name.value){alert('\n기업명을 입력하여 주십시오.'); f.m_company_name.focus(); return false;}

	if(!f.m_name.value){alert('\n담당자명을 입력하여 주십시오.'); f.m_name.focus(); return false;}

	if(!f.birth1.value){alert('\n태어난 해를 입력하여 주십시오.'); return false;}
	if(!f.birth2[0].selected == false){alert('\n태어난 월을 선택하여 주십시오.'); return false;}
	if(!f.birth3.value){alert('\n태어난 일을 입력하여 주십시오.'); return false;}

	if(f.m_newsagency[0].selected == true){alert('\n통신사를 선택하세요');return false;}
	if(!f.hp2.value){alert('\n휴대폰 두번째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
	if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}

	if(!$('#terms1').is(':checked')){alert('<?php echo $config[c_title];?> 이용약관에 동의하셔야 합니다.'); return false;}
	
	if(!$('#terms2').is(':checked')){alert('개인정보 수집항목 및 수집방법에 동의하셔야 합니다.'); return false;}

	
//	if(f.birth1[0].selected == true){ alert('\n태어난 해를 선택하여주십시오.'); return false;}
//	if(f.birth2[0].selected == true){ alert('\n태어난 월을 선택하여주십시오.'); return false;}
//	if(f.birth3[0].selected == true){ alert('\n태어난 일을 선택하여주십시오.'); return false;}
//
//	if(f.m_sex[0].checked == false && f.m_sex[1].checked == false){ alert('\n성별을 선택하여 주십시오'); return false;}
//
//
//<?php if($config['c_req_hp']=="Y"){?>
//	if(f.hp1[0].selected == true){alert('\n휴대폰 첫번째자리를 선택하여 주십시오');return false;}
//	if(!f.hp2.value){alert('\n휴대폰 두번째자리를 입력하여 주십시오.');f.hp2.focus();return false;}
//	if(!f.hp3.value){alert('\n휴대폰 세번째자리를 입력하여 주십시오.');f.hp3.focus();return false;}
//<?php }?>
//<?php if($config['c_use_addr']=="Y"){?>
//		if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
//		if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}
//<?php }?>
//		if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
//
//		if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}
//
//	if(f.m_signpurpose[0].checked == false && f.m_signpurpose[1].checked == false && f.m_signpurpose[2].checked == false && f.m_signpurpose[3].checked == false){ alert('\n회원구분을 선택하여 주십시오'); return false;}



	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>
				</div>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->


{#footer}<!--하단-->
<?}else{?>
{#header_sub} 
	<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<!--<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
						<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>
						<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="join_wrap">
					<div class="join_inner">
					<h3>절차에 따라 회원가입을 진행해 주세요.</h3>
					<div class="join_step">
						<ul>
							<li >본인인증</li>
							<li class="list_on">정보입력</li>
							<li>가입완료</li>
						</ul>
					</div>
					
				
	<form name="member_form"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="m_no" value="<?php echo $mmo['m_no']; ?>">
	<input type="hidden" name="m_level" value="3">
	<input type="hidden" name="mode" value="join3">
	<input type="hidden" name="agreement1" value="yes">
	<input type="hidden" name="agreement2" value="yes">
	<input type="hidden" name="m_blindness" value="<?php echo $m_blindness_use;?>"><!--실명인증결과-->
	<input type="hidden" name="m_ipin" value="<?php echo $m_ipin_use;?>"><!--아이핀인증결과-->
					 <div class="table_wrap3">
						<table class="type9">
							<colgroup>
								<col width="200px" />
								<col width="" />
							</colgroup>
							<tbody>
								
								<tr>
									<!--<th><span class="bullet1">이메일 아이디</span></th>-->
									<td><input type="text" name="m_id" id="id" onkeyup="warring(this);" onchange="warring(this);" value="<?php echo $_COOKIE['m_id']; ?>" size="38" placeholder="이메일 아이디 (로그인시 아이디로 사용됩니다)"  maxlength="40" required/>									
									</td>
								</tr>
								<script>
								/*아이디 공백입력 못하게*/
								function warring(cnj_str) { 
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
								//이름 한글입력만 받기
								function warring2(cnj_str) { 

									if((event.keyCode < 12592) || (event.keyCode > 12687))
									event.returnValue = false
								}
								</script>								
								<tr>
									<!--<th><span class="bullet1">비밀번호</span></th>-->
									<td><input type="password" name="m_password" id="" size="38" placeholder="비밀번호(영문자 조합 8~20 자 이내)"  maxlength="20" required/></td>
								</tr>
								
								<tr>
									<!--<th><span class="bullet1">비밀번호 확인</span></th>-->
									<td><input type="password" name="m_password_re" id="pw_re" size="38" onblur="pwCheck(this);" placeholder="비밀번호를 한번 더 입력해 주세요" /></td>
								</tr>
								<tr>
									<td><input type="text"  name="m_companynum"  value="<?php echo $_COOKIE['m_companynum']; ?>"placeholder="사업자등록번호(법인/개인 사업자등록번호를 입력하세요.)"  size="38"required maxlength="40" <?php echo $config['c_req_nick']=='Y'?'required':'';?>/></td>
								</tr>
								<!--<tr>
								<?php if($config['c_companynum_use']=="Y"){?>
									<!--<th><span <?php echo $config['c_companynum_use']=='Y'?'class="bullet1"':'';?>>사업자등록번호</span></th>
									<td><input type="text" name="m_nick" id="id" onKeyup="idChk(this.value);" value="<?php echo $_COOKIE['m_companynum']; ?>" size="38" placeholder="사업자등록번호(법인/개인 사업자등록번호를 입력하세요.)"  maxlength="40" <?php echo $config['c_req_nick']=='Y'?'required':'';?>/>
								<?php }?>
								</tr>-->
								<tr>
									<td><input type="text"  name="m_company_name" value="<?php echo $_COOKIE['m_company_name'];?>" placeholder="기업명을 입력하세요"  size="38" required/></td>
								</tr>
								<tr>
									<td><input type="text"  name="m_name" value="<?php echo $_COOKIE['m_name'];?>" onKeyPress="warring2()" placeholder="담당자명(한글입력만 가능합니다.)"  size="38"required maxlength="10"/></td>
								</tr>

								<tr>
									<!--<th><span class="bullet1">생년월일</span></th>-->
									<td>
										<span class="sub_name">생일</span>
										<!--<select name="birth1" id="" required>
											<option>선택</option>
										<?php 											
											for($i=substr($date,0,4); $i >= 1930; $i--){?>\
											<option value="<?php echo $i;?>" <?php echo $_COOKIE['birth1']== $i ?'selected':'';?>><?php echo $i;?></option>
										<?php }?>
										</select>-->
										<input type="text" name="birth1" id="birth_h"  title="년" required onKeyPress="warring4" placeholder="년(4자)"  class="form-control  " />
										<!--<label for="">년</label>-->

										<select name="birth2" id="bir_point">
											<option id="">월</option>
										<?php for($i=1; $i<=12; $i++){?>
											<option value="<?php echo $i;?>" <?php echo $_COOKIE['birth2']== $i ?'selected':'';?>><?php echo $i; ?></option>
										<?php }?>
										</select>
										<!--<label for="">월</label>-->

										<!--<select name="birth3" id="">
											<option>선택</option>
										<?php for($i=1; $i<=31; $i++){?>
											<option value="<?php echo $i;?>" <?php echo $_COOKIE['birth3']== $i ?'selected':'';?>><?php echo $i; ?></option>
										<?php }?>
										</select>
										<label for="">일</label>-->
										<input type="text" name="birth3" id="birth_h"  title="년" required onKeyPress="warring4" placeholder="일"  class="form-control  " />
									</td>
								</tr>								
								
								<tr>
								<?php if($config['c_use_hp']=="Y"){?>
									<!--<th><span <?php echo $config['c_req_hp']=='Y'?'class="bullet1"':'';?>>휴대폰번호</span></th>-->
									<td>
										<span class="sub_name1">휴대폰번호</span>
										<select name="m_newsagency" >
											<option>통신사선택</option>
											<option value="SKT" <?php echo $_COOKIE['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
											<option value="KT" <?php echo $_COOKIE['m_newsagency']=='KT'?'selected':'';?>>KT</option>
											<option value="LGT" <?php echo $_COOKIE['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
											<option value="기타" <?php echo $_COOKIE['m_newsagency']=='기타'?'selected':'';?>>기타</option>
										</select> 
										<select name="hp1" <?php echo $config['c_req_hp']=='Y'?'required':'';?> style="width:100px;">
											<option>선택</option>
											<option value="010" <?php echo $_COOKIE['hp1']=='010'?'selected':'';?>>010</option>
											<option value="011" <?php echo $_COOKIE['hp1']=='011'?'selected':'';?>>011</option>
											<option value="016" <?php echo $_COOKIE['hp1']=='016'?'selected':'';?>>016</option>
											<option value="017" <?php echo $_COOKIE['hp1']=='017'?'selected':'';?>>017</option>
											<option value="019" <?php echo $_COOKIE['hp1']=='019'?'selected':'';?>>019</option>
										</select> -
										<input type="text" name="hp2" value="<?php echo $_COOKIE['hp2'];?>" id="birth_ph"  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/> -
										<input type="text" name="hp3" value="<?php echo $_COOKIE['hp3'];?>" id="birth_ph"  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/>
										<label for="m_sms"><input type="checkbox" name="m_sms"  id="m_sms" class="ml15"  value="1" <?php echo $_COOKIE['m_sms']=='1'?'checked':'';?>checked/> SMS수신동의</label>
									</td>
								<?php }?>
								</tr>
								<?php if($config['c_use_addr']=="Y"){?>
								<tr>
									<!--<th><span <?php echo $config['c_req_addr']=='Y'?'class="bullet1"':'';?>>주소</span></th>-->
									<td>
										<input type="text" name="m_zip" placeholder="사업장 주소" value="<?php echo $_COOKIE['m_zip']?>" style="width:76%" id="post1" <?php echo $config['c_req_addr']=='Y'?'required':'';?>>&nbsp&nbsp<a href="javascript:execDaumPostcode()" ><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>
										<span id="guide" style="color:#999"></span>
										<p class="">
											<input type="text" name="m_addr1" id="addr1"   alt='주소'  value='<?=$_COOKIE['m_addr1']?>' size="30" placeholder="나머지 주소를 입력해주세요"  style="border-top:1px solid #dbdada;";required/>
											<!--<input type="text" name="m_addr2" id="addr2"  alt='주소'  value='<?=$_COOKIE['m_addr2']?>' size="30" required/>-->
										</p>
									</td>
								</tr>
								<?php }?>
								<!--<tr>-->
									<!--<th><span <?php echo $config['c_req_homepage']=='Y'?'class="bullet1"':'';?>>회원구분</span></th>-->
									<!--<td>
									<span class="sub_name1">회원구분</span>
										<span class="membder_box">
										<label for="company_invest_m"><input type="radio" name="member" id="company_invest_m" value="company_invest_m" />투자회원</label>&nbsp;&nbsp;
										<label for="company_loan_m"><input type="radio" name="member" id="company_loan_m" value="company_loan_m"/>대출회원</label>&nbsp;&nbsp;
										</span>
									</td>
								</tr>-->
								<?php if($config['c_use_homepage']=="Y"){?>
								<!--<tr>
									<th><span <?php echo $config['c_req_homepage']=='Y'?'class="bullet1"':'';?>>홈페이지주소</span></th>
									<td>
										<input type="text" name="m_homepage" id="" value="<?php echo $_COOKIE['m_homepage']; ?>" size="64"  maxlength="50" <?php echo $config['c_req_homepage']=='Y'?'required':'';?>/>
									</td>
								</tr>-->
								<?php }?>
								<tr>
									<!--<th><span>추천인</span></th>-->
									<td><input type="text" name="m_referee" id="" value="<?php echo $_COOKIE['m_referee']; ?>" size="38"  maxlength="20" placeholder="추천인" required /></td>
								</tr>
							</tbody>
						</table>
						<div id="tab-1" class="tab-content2">
							<div class="part1">	
								<div class="faq1">								
									<p class="question">이용약관[필수] <span>클릭하여 확인하기</span></p>
									<ul class="answer">
										<li class="clr">
											<?php echo $config['c_stipulation'];?>
										</li> 
									</div>
										<div class="chbox"><input type="checkbox" name="terms" id="terms1" value="terms"/> <label>이용약관에 동의합니다.</label></div>
									</ul>
									<div class="faq1">	
									<p class="question">개인 정보 수집 및 이용 안내[필수] <span>클릭하여 확인하기</span></p>
									<ul class="answer">
										<li class="clr">
											<?php echo $config['c_privacy'];?>
										</li>                        	  
									</ul>
									<div class="chbox"><input type="checkbox" name="terms" id="terms2" value="terms"/> <label>이용약관에 동의합니다.</label></div>	
								</div>						
							</div><!--//part1 e -->
						</div><!--tab-3-->
					</div>
					<div class="joun_btn">
						<a href="{MARI_HOME_URL}/?mode=join2"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" style="float:left; "/></a>
						<img src="{MARI_HOMESKIN_URL}/img/btn_next1.png" alt="다음" id="member_form_add" style="cursor:pointer; float:right;"/>
					</div>

						<script>
								$(function(){
									$(".answer").hide();
									$(".question").click(function(){
									$(".answer:visible").slideUp("middle");
									$(this).next('.answer:hidden').slideDown("middle");
									return false;
									})
								});
							</script>	
					 </div><!-- /table_wrap3 -->

	</form>
					

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
//                document.getElementById('addr2').focus();
                
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
//이메일값 가져오기
function getSelectValue(frm){
	//frm.email3.value = frm.email2.options[frm.email2.selectedIndex].text;

	frm.m_id2.value = frm.m_id3.options[frm.m_id3.selectedIndex].value;
}

$(function() {
	var languages = [
	"dd"
	];

	$( "#id" ).autocomplete({
		source: languages
	});
});

/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok(f)
{

	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id1.focus();return false;}

	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test(f.m_id.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.m_id.focus(); return false;
	}
	
	
	if(!f.m_password.value){alert('\n비밀번호를 입력하여 주십시오.');f.m_password.focus();return false;}
	if(!f.m_password_re.value){alert('\n비밀번호확인을 입력하여 주십시오.');f.m_password_re.focus();return false;}


	if(f.m_password.value.indexOf(" ") >= 0 ) {alert('\n패스워드에 공백이 있습니다.\n\n공백을 제거해주세요');f.m_password.focus();return false;}

	if(f.m_password.value.length < 8 || f.m_password.value.length > 20 ){alert('\n패스워드는 [8자~20자]이내 이어야 합니다.');f.m_password.focus();return false;}


			   if(!f.m_password.value.match(/[^(a-zA-Z)]/)) {
				 alert("비밀번호는 [영문자]와 [숫자], 특수문자(!,@,$,^,&,*)중  2종류~3종류 이상의 조합만으로 입력하세요.");
				 return false;
			   }else if(!f.m_password.value.match(/[^(0-9)]/)) {
				 alert("비밀번호는 [영문자]와 [숫자], 특수문자(!,@,$,^,&,*)중  2종류~3종류 이상의 조합만으로 입력하세요.");
				 return false;
			   }else{
			   }
	
	if(f.m_password.value != f.m_password_re.value){alert('\n설정하신 비밀번호와 비밀번호확인이 일치하지않습니다. \n다시 입력하여주십시오.'); f.m_password_re.focus(); return false;}

	if(!f.m_companynum.value){alert('\n사업자등록번호를 입력하여 주십시오.'); f.m_companynum.focus(); return false;}
	
	if(!f.m_company_name.value){alert('\n기업명을 입력하여 주십시오.'); f.m_company_name.focus(); return false;}
			
	if(!f.m_name.value){alert('\n담당자명을 입력하여 주십시오.'); f.m_name.focus(); return false;}
				
	if(!f.birth1.value){alert('\n태어난 해를 입력하여 주십시오.'); return false;}
	if(!f.birth2[0].selected == false){alert('\n태어난 월을 선택하여 주십시오.'); return false;}
	if(!f.birth3.value){alert('\n태어난 일을 입력하여 주십시오.'); return false;}

	if(f.m_newsagency[0].selected == true){alert('\n통신사를 선택하세요');return false;}
	if(f.hp1[0].selected == true){alert('\n휴대폰 첫번째자리를 선택하여 주십시오');return false;}
	if(!f.hp2.value){alert('\n휴대폰 두번째자리를 입력하여 주십시오.');f.hp2.focus();return false;}
	if(!f.hp3.value){alert('\n휴대폰 세번째자리를 입력하여 주십시오.');f.hp3.focus();return false;}

	if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
	if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}

	if(!$('#terms1').is(':checked')){alert('<?php echo $config[c_title];?> 이용약관에 동의하셔야 합니다.'); return false;}
	
	if(!$('#terms2').is(':checked')){alert('개인정보 수집항목 및 수집방법에 동의하셔야 합니다.'); return false;}
	
//	if(f.birth1[0].selected == true){ alert('\n태어난 해를 선택하여주십시오.'); return false;}
//	if(f.birth2[0].selected == true){ alert('\n태어난 월을 선택하여주십시오.'); return false;}
//	if(f.birth3[0].selected == true){ alert('\n태어난 일을 선택하여주십시오.'); return false;}
//
//	if(f.m_sex[0].checked == false && f.m_sex[1].checked == false){ alert('\n성별을 선택하여 주십시오'); return false;}
//
//
//<?php if($config['c_req_hp']=="Y"){?>
//	if(f.hp1[0].selected == true){alert('\n휴대폰 첫번째자리를 선택하여 주십시오');return false;}
//	if(!f.hp2.value){alert('\n휴대폰 두번째자리를 입력하여 주십시오.');f.hp2.focus();return false;}
//	if(!f.hp3.value){alert('\n휴대폰 세번째자리를 입력하여 주십시오.');f.hp3.focus();return false;}
//<?php }?>
//<?php if($config['c_use_addr']=="Y"){?>
//		if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
//		if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}
//<?php }?>
//		if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}
//
//		if(!f.m_addr1.value){alert('\n주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}
//
//	if(f.m_signpurpose[0].checked == false && f.m_signpurpose[1].checked == false && f.m_signpurpose[2].checked == false && f.m_signpurpose[3].checked == false){ alert('\n회원구분을 선택하여 주십시오'); return false;}



	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>
				</div>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->
 {#footer}
<?}?>
<!--하단-->
