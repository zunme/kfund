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

<section id="container">
		<section id="sub_content">
			<div class="login_wrap">
				<div class="container">
					<div class="join_box1">
						<img src="{MARI_MOBILESKIN_URL}/img/img_login_box1_join.png" alt="img_login_box1" class="img_c wd25"/>
						<h3 class="login_title1">회원가입</h3> 
						<img src="{MARI_MOBILESKIN_URL}/img/img_login_box1_bar.png" alt="img_login_box1_bar"/>
						
						<p><strong>회원가입</strong>을 하시면 플랫폼의 보다 다양한<br/>서비스를 이용하실 수 있습니다.</p>
					<form name="member_form" method="post" enctype="multipart/form-data"/>
					<input type="hidden" name="m_no" value="<?php echo $mmo['m_no']; ?>">
					<input type="hidden" name="m_level" value="3">
					<input type="hidden" name="mode" value="join3">
							<ul class="join_cont1">
								<li>
									<input type="text" name="m_id" id=""  title="아이디" required placeholder="이메일 주소를 입력해주세요(아이디로 이용됩니다.)" class="form-control col-xs-12 mb10" onkeyup="warring(this);" onchange="warring(this);" />
								</li>
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
								<li>
									<input type="password" name="m_password" id=""  title="비밀번호" required placeholder="비밀번호 (영문,숫자조합 8~15자 사용)" class="form-control col-xs-12 mb10" />
								</li>
								<li>
									<input type="password" name="m_password_re" id="pw_re"  title="비밀번호" required placeholder="비밀번호 재확인" class="form-control col-xs-12 mb10" />
								</li>
								<li>
									<input type="text" name="m_companynum" id="" maxlength="10" title="사업자등록번호" required placeholder="법인/개인사업자등록번호를 입력하세요." class="form-control col-xs-12 mb10" />
								</li>
								<li>
									<input type="text" name="m_company_name" id="" maxlength="" title="기업명" required placeholder="기업명을 입력하세요." class="form-control col-xs-12 mb10" />
								</li>
								<li>
									<input type="text" name="m_name" id=""  title="이름" required onKeyPress="warring2()" placeholder="담당자명을 입력하세요(한글입력만 가능합니다.)"  class="form-control col-xs-12 mb10" />
								</li>
								<li>
								<select name="m_newsagency" required class="col-xs-12 form-control">
									<option>통신사선택</option>
									<option value="SKT" >SKT</option>
									<option value="KT" >KT</option>
									<option value="LGT" >LGT</option>
									<option value="기타" >기타</option>
								</select>
								</li>

								<li>
									<input type="text" name="m_hp" id="" maxlength="11" title="휴대폰번호" required placeholder="담당자 휴대폰 번호를 입력해주세요 예) 010xxxxxxxx" class="form-control col-xs-12 mb10" />
									<label for="m_sms"><input type="checkbox" name="m_sms"  id="m_sms" class="ml15"  value="1" <?php echo $mmo['m_sms']=='1'?'checked':'';?>checked/> SMS수신동의</label>
								</li>
								<li>
									<input type="text" name="m_tel" id="" maxlength="" title="" required placeholder="사업장전화번호를 입력해주세요 예) 070xxxxxxxx" class="form-control col-xs-12 mb10" />
								</li>
								<li>
								<?php if($config['c_use_addr']=="Y"){?>																	
										<input type="text" name="m_zip"  style="" id="post1" class="form-control col-xs-8 mb10" <?php echo $config['c_req_addr']=='Y'?'required':'';?>>&nbsp&nbsp<a href="javascript:execDaumPostcode()" class="col-xs-3 no_pl no_pr"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>
										<span id="guide" style="color:#999;display:none;"></span>	
										<p class="ml_01 mt10">
											<input type="text" name="m_addr1" id="addr1"   alt='주소'  value='<?=$mmo[m_addr1]?>' size="30" class="form-control col-xs-12 mb10" required/>
											<input type="text" name="m_addr2" id="addr2"  alt='주소'  value='<?=$mmo[m_addr2]?>' size="30" class="form-control col-xs-12 mb10" required/>
										</p>
								<?php }?>
								</li>
								<li>
									<input type="text" name="m_referee" id="" placeholder="추천인을 입력해주세요" class="form-control col-xs-12 mb10"    value="<?php echo $mmo['m_referee']; ?>" size="38"  maxlength="20" required />
								</li>
							</ul><!-- /login_cont1 -->
							<label><input type="checkbox" name="agreement" id="agreement" /><strong>이용약관에 동의</strong><a href="{MARI_HOME_URL}/?mode=common1">[보기]</a></label>							
						<div class="login_btn1"><input type="image"  style="cursor:pointer"  id="member_form_add" src="{MARI_MOBILESKIN_URL}/img/btn_join_step1.png" alt="로그인" /></div>
							<?php if($config['c_facebooklogin_use']=="Y"){?>
								<div class="login_facebook1"><a href="<?=FACEBOOK_LOGIN?>"><img src="{MARI_MOBILESKIN_URL}/img/btn_facebook_join_step.png" alt="facebook 로그인"/></a></div>
							<?php }?>
							
						</form>		 
					</div><!-- /login_box1-->
			</div>
			</div><!-- /login_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->

<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;
                document.getElementById('addr2').focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%'
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 460; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

<script>



/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});

function Member_form_Ok(f){
		if(!f.m_name.value){alert('\n이름을 입력하여 주십시오.');f.m_name.focus();return false;}
		if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if(exptext.test(f.m_id.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.m_id.focus(); return false;
		}

		if(!f.m_password.value){alert('\n비밀번호를 입력하여 주십시오.');f.m_password.focus();return false;}

		if(!f.m_password_re.value){alert('\n비밀번호확인을 입력하여 주십시오.');f.m_password_re.focus();return false;}

		if(!f.m_name.value){alert('\n담당자명을 입력하여 주십시오.');f.m_name.focus();return false;}

		if(!f.m_hp.value){alert('\n휴대폰번호를 입력하여 주십시오.');f.m_hp.focus();return false;}

		if(!f.m_tel.value){alert('\n사업장전화번호를 입력하여 주십시오.');f.m_tel.focus();return false;}

		if(!f.m_zip.value){alert('\n우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}

		if(!f.m_addr1.value){alert('\n사업장주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}
		
		
		if(!$('#agreement').is(':checked')){alert('개인정보 취급방침에 동의하셔야 합니다.'); return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=m_join3';
	f.submit();
}

</script>				 

{#footer}<!--하단-->
	
<?}else{?>
{#header_sub} 
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
					<div class="join_step">
						<ul>
							<li><p>01. 약관 동의</p></li>
							<li><p>02. 본인 인증</p></li>
							<li class="current"><p>03. 정보 입력</p></li>
							<li><p>04. 가입 완료</p></li>
						</ul>
					</div>
					
					 <p class="join_txt1">필수 입력 사항</p>
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
									<th><span class="bullet1">이메일 아이디</span></th>
									<td><input type="text" name="m_id" id="id" onkeyup="warring(this);" onchange="warring(this);" value="<?php echo $_COOKIE['m_id']; ?>" size="38" placeholder="로그인시 아이디로 사용됩니다"  maxlength="40" required/>
									<!--
									<input type='hidden' name='id_ok' id='id_ok'/>
									<br/><span id='idChk'></span>
									-->
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
									<th><span class="bullet1">비밀번호</span></th>
									<td><input type="password" name="m_password" id="" size="38" placeholder="영문자 조합 8~20 자 이내"  maxlength="20" required/></td>
								</tr>
								
								<tr>
									<th><span class="bullet1">비밀번호 확인</span></th>
									<td><input type="password" name="m_password_re" id="pw_re" size="38" onblur="pwCheck(this);" placeholder="비밀번호를 한번 더 입력해 주세요" /></td>
								</tr>
								<tr>
								
									<th><span>사업자등록번호</span></th>
									<td><input type="text" name="m_companynum"value="<?php echo $_COOKIE['m_companynum'];?>" size="38" placeholder="법인/개인 사업자등록번호를 입력하세요."  maxlength="40" />
								
								</tr>
								<tr>
									<th><span class="bullet1">기업명</span></th>
									<td><input type="text"  name="m_company_name" value="<?php echo $_COOKIE['m_company_name'];?>" placeholder="기업명을 입력하세요"  size="38" required/></td>
								</tr>
								<tr>
									<th><span class="bullet1">담당자명</span></th>
									<td><input type="text"  name="m_name" value="<?php echo $_COOKIE['m_name'];?>" onKeyPress="warring2()" placeholder="이름을 입력하세요(한글입력만 가능합니다.)"  size="38"required maxlength="10"/></td>
								</tr>

								<tr>
									<th><span <?php echo $config['c_req_hp']=='Y'?'class="bullet1"':'';?>>담당자 휴대폰번호</span></th>
									<td>
										<select name="m_newsagency" >
											<option>통신사선택</option>
											<option value="SKT" <?php echo $_COOKIE['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
											<option value="KT" <?php echo $_COOKIE['m_newsagency']=='KT'?'selected':'';?>>KT</option>
											<option value="LGT" <?php echo $_COOKIE['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
											<option value="기타" <?php echo $_COOKIE['m_newsagency']=='기타'?'selected':'';?>>기타</option>
										</select> 
										<select name="hp1" <?php echo $config['c_req_hp']=='Y'?'required':'';?>>
											<option>선택</option>
											<option value="010" <?php echo $_COOKIE['hp1']=='010'?'selected':'';?>>010</option>
											<option value="011" <?php echo $_COOKIE['hp1']=='011'?'selected':'';?>>011</option>
											<option value="016" <?php echo $_COOKIE['hp1']=='016'?'selected':'';?>>016</option>
											<option value="017" <?php echo $_COOKIE['hp1']=='017'?'selected':'';?>>017</option>
											<option value="019" <?php echo $_COOKIE['hp1']=='019'?'selected':'';?>>019</option>
										</select> -
										<input type="text" name="hp2" value="<?php echo $_COOKIE['hp2'];?>" id=""  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/> -
										<input type="text" name="hp3" value="<?php echo $_COOKIE['hp3'];?>" id=""  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_hp']=='Y'?'required':'';?>/>
										<label for="m_sms"><input type="checkbox" name="m_sms"  id="m_sms" class="ml15"  value="1" <?php echo $_COOKIE['m_sms']=='1'?'checked':'';?>checked/> SMS수신동의</label>
									</td>
								</tr>
								<tr>
									<th><span <?php echo $config['c_req_hp']=='Y'?'class="bullet1"':'';?>>사업장 전화번호</span></th>
									<td>
										<select name="tel1" <?php echo $config['c_req_tel']=='Y'?'required':'';?>>
											<option>선택</option>
											<option value="02" <?php echo $_COOKIE['tel1']=='02'?'selected':'';?>>02</option>
											<option value="051" <?php echo $_COOKIE['tel1']=='051'?'selected':'';?>>051</option>
											<option value="053" <?php echo $_COOKIE['tel1']=='053'?'selected':'';?>>053</option>
											<option value="032" <?php echo $_COOKIE['tel1']=='032'?'selected':'';?>>032</option>
											<option value="062" <?php echo $_COOKIE['tel1']=='062'?'selected':'';?>>062</option>
											<option value="052" <?php echo $_COOKIE['tel1']=='052'?'selected':'';?>>052</option>
											<option value="044" <?php echo $_COOKIE['tel1']=='044'?'selected':'';?>>044</option>
											<option value="031" <?php echo $_COOKIE['tel1']=='031'?'selected':'';?>>031</option>
											<option value="033" <?php echo $_COOKIE['tel1']=='033'?'selected':'';?>>033</option>
											<option value="043" <?php echo $_COOKIE['tel1']=='043'?'selected':'';?>>043</option>
											<option value="041" <?php echo $_COOKIE['tel1']=='041'?'selected':'';?>>041</option>
											<option value="063" <?php echo $_COOKIE['tel1']=='063'?'selected':'';?>>063</option>
											<option value="061" <?php echo $_COOKIE['tel1']=='061'?'selected':'';?>>061</option>
											<option value="054" <?php echo $_COOKIE['tel1']=='054'?'selected':'';?>>054</option>
											<option value="055" <?php echo $_COOKIE['tel1']=='055'?'selected':'';?>>055</option>
											<option value="064" <?php echo $_COOKIE['tel1']=='064'?'selected':'';?>>064</option>
											<option value="070" <?php echo $_COOKIE['tel1']=='070'?'selected':'';?>>070</option>
										</select> -
										<input type="text" name="tel2" value="<?php echo $_COOKIE['tel2'];?>" id=""  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_tel']=='Y'?'required':'';?>/> -
										<input type="text" name="tel3" value="<?php echo $_COOKIE['tel3'];?>" id=""  class="frm_input " size="10" maxlength="4" <?php echo $config['c_req_tel']=='Y'?'required':'';?>/>
										
									</td>
								</tr>
								<tr>
									<th><span <?php echo $config['c_req_addr']=='Y'?'class="bullet1"':'';?>>사업장 주소</span></th>
									<td>
										<input type="text" name="m_zip" value="<?php echo $_COOKIE['m_zip']?>" style="width:70px" id="post1" <?php echo $config['c_req_addr']=='Y'?'required':'';?>>&nbsp&nbsp<a href="javascript:execDaumPostcode()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>
										<span id="guide" style="color:#999"></span>
										<p class="ml_01 mt10">
											<input type="text" name="m_addr1" id="addr1"   alt='주소'  value='<?=$_COOKIE['m_addr1']?>' size="30" required/>
											<input type="text" name="m_addr2" id="addr2"  alt='주소'  value='<?=$_COOKIE['m_addr2']?>' size="30" required/>
										</p>
									</td>
								</tr>
								<tr>
									<th><span <?php echo $config['c_req_homepage']=='Y'?'class="bullet1"':'';?>>회원구분</span></th>
									<td>
										<label for="company_invest_m"><input type="radio" name="member" id="company_invest_m" value="company_invest_m" />투자회원</label>
										<label for="company_loan_m"><input type="radio" name="member" id="company_loan_m" value="company_loan_m"/>대출회원</label>
									</td>
								</tr>
								<tr>
									<th><span>추천인</span></th>
									<td><input type="text" name="m_referee" id="" value="<?php echo $_COOKIE['m_referee']; ?>" size="38"  maxlength="20" required /></td>

								</tr>
							</tbody>
						</table>
					 </div><!-- /table_wrap3 -->
	</form>
					<div class="mt30">
						<a href="{MARI_HOME_URL}/?mode=join2"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" style="float:left; "/></a>
						<img src="{MARI_HOMESKIN_URL}/img/btn_next1.png" alt="다음" id="member_form_add" style="cursor:pointer; float:right;"/>
					</div>

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


//이메일값 가져오기
function getSelectValue(frm){
	//frm.email3.value = frm.email2.options[frm.email2.selectedIndex].text;

	frm.m_id2.value = frm.m_id3.options[frm.m_id3.selectedIndex].value;
}

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

	if(!f.m_companynum.value){alert('\n사업자등록번호를 입력하여 주십시오.');f.m_companynum.focus();return false;}

	if(!f.m_company_name.value){alert('\n기업명을 입력하여 주십시오.');f.m_company_name.focus();return false;}

	if(!f.m_name.value){alert('\n담당자명을 입력하여 주십시오.');f.m_name.focus();return false;}

	if(f.m_newsagency[0].selected == true){alert('\n통신사를 선택하여 주십시오');return false;}

	if(f.hp1[0].selected == true){alert('\n휴대폰 첫번째자리를 선택하여 주십시오');return false;}

	if(!f.hp2.value){alert('\n휴대폰 두번째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.hp3.value){alert('\n휴대폰 세번째자리를 입력하여 주십시오.');f.hp3.focus();return false;}

	if(!f.m_zip.value){alert('\n사업장 우편번호를 입력하여 주십시오.');f.m_zip.focus();return false;}

	if(!f.m_addr1.value){alert('\n사업장주소를 입력하여 주십시오.');f.m_addr1.focus();return false;}

	if(!f.m_addr2.value){alert('\n사업장 상세주소를 입력하여 주십시오.');f.m_addr2.focus();return false;}


	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->
 {#footer}
<?}?>
<!--하단-->
