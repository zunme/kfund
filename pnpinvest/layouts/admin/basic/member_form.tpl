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
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">회원수정</div>
<form name="member_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="m_no" value="<?php echo $mem['m_no']; ?>">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>회원수정</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="m_id" value="<?php echo $mem['m_id']; ?>" id=""  class="frm_input " size="38" required/></td>
						<th>비밀번호</th>
						<td><input type="password" name="m_password" id=""  class="frm_input " required /></td>
					</tr>
					<tr>
						<th>이름(성명)</th>
						<td>
							<input type="text" name="m_name" value="<?php echo $mem['m_name']; ?>" id="" class="frm_input " size="" />
							<input type="checkbox" name="m_mailling"  class="ml15"  value="Y" <?php echo $mem['m_mailling']=='Y'?'checked':'';?>/> <label for="">정보메일을 수신함</label>
						</td>
						<?php if($config['c_use_nick']=="Y"){?>
						<th><span>닉네임</span></th>
						<td><input type="text" name="m_nick" id="id" class="frm_input" onKeyup="idChk(this.value);" value="<?php echo $mem['m_nick']; ?>" size="38" placeholder="로그인시 별명으로 사용됩니다"  maxlength="40" <?php echo $config['c_req_nick']=='Y'?'required':'';?>/>
						<?php }?>
					</tr>
					<tr>
						<th>기업명</th>
						<td colspan="3">
							<input type="text" name="m_company_name" value="<?php echo $mem['m_company_name']; ?>" id="" class="frm_input " size="" />
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td colspan="3">
							<input type="text" name="m_companynum" value="<?php echo $mem['m_companynum']; ?>" id="" class="frm_input " size="40" />
							<input type="radio" name="m_business_type" value="1" <?php echo $mem['m_business_type'] =='1'?'checked':'';?>>개인 &nbsp
							<input type="radio" name="m_business_type" value="2" <?php echo $mem['m_business_type'] =='2'?'checked':'';?>>법인
						</td>
					</tr>
								<tr>
								<?php if($config['c_use_tel']=="Y"){?>
									<th><span>전화번호</span></th>
									<td>
										<select name="tel1" <?php echo $config['c_req_tel']=='Y'?'required':'';?>>
											<option>선택</option>
											<option value="02" <?php echo $tel1=='02'?'selected':'';?>>02</option>
											<option value="051" <?php echo $tel1=='051'?'selected':'';?>>051</option>
											<option value="053" <?php echo $tel1=='053'?'selected':'';?>>053</option>
											<option value="017" <?php echo $tel1=='017'?'selected':'';?>>017</option>
											<option value="062" <?php echo $tel1=='062'?'selected':'';?>>062</option>
											<option value="042" <?php echo $tel1=='042'?'selected':'';?>>042</option>
											<option value="052" <?php echo $tel1=='052'?'selected':'';?>>052</option>
											<option value="044" <?php echo $tel1=='044'?'selected':'';?>>044</option>
											<option value="031" <?php echo $tel1=='031'?'selected':'';?>>031</option>
											<option value="033" <?php echo $tel1=='033'?'selected':'';?>>033</option>
											<option value="043" <?php echo $tel1=='043'?'selected':'';?>>043</option>
											<option value="041" <?php echo $tel1=='041'?'selected':'';?>>041</option>
											<option value="063" <?php echo $tel1=='063'?'selected':'';?>>063</option>
											<option value="061" <?php echo $tel1=='061'?'selected':'';?>>061</option>
											<option value="054" <?php echo $tel1=='054'?'selected':'';?>>054</option>
											<option value="055" <?php echo $tel1=='055'?'selected':'';?>>055</option>
											<option value="064" <?php echo $tel1=='019'?'selected':'';?>>064</option>
										</select> -
										<input type="text" name="tel2" value="<?php echo $tel2;?>" id=""  class="frm_input " size="10" maxlength="4" required/> -
										<input type="text" name="tel3" value="<?php echo $tel3;?>" id=""  class="frm_input " size="10" maxlength="4" required/>
									</td>
								<?php }?>
								<?php if($config['c_use_addr']=="Y"){?>
									<th><span>주소</span></th>
									<!--
									<td>
										<input type="text" name="m_zip1" class="frm_input" style="width:40px" id="post1" value='<?php echo $m_zip1;?>' <?php echo $config['c_req_addr']=='Y'?'required':'';?>>-<input type="text"  class="frm_input" name="m_zip2" value='<?php echo $m_zip2;?>' style="width:40px" id="post2"   required/> <a href="javascript:openDaumPostcode()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>										
										<p class="ml_01 mt10">
											<input type="text" class="frm_input" name="m_addr1" id="addr1"   alt='주소'  value='<?=$mem[m_addr1]?>' size="29" required/>
											<input type="text" class="frm_input" name="m_addr2" id="addr2"  alt='주소'  value='<?=$mem[m_addr2]?>' size="29" required/>
										</p>
									</td>
									
									<td>
									<input type="text" class="frm_input" name="m_zip" id="zip" value="<?php echo $mem[m_zip]?>" readonly="readonly" class="frm_input" style="width:100px;"  placeholder="우편번호" <?php echo $config['c_req_addr']=='Y'?'required':'';?>/>&nbsp;
									<img src="{MARI_HOMESKIN_URL}/img/btn_post.png"  align="absmiddle" style="cursor:pointer;" onclick="javascript:execDaumPostcode();" alt="우편번호찾기"><br/><br/>
									
									<p class="ml_01 mt10">
									<input type="text" class="frm_input" name="m_addr1" id="addr1" value="<?=$mem[m_addr1]?>" class="frm_input" placeholder="도로명주소" size="29"/>
									&nbsp;
									<input type="text" class="frm_input" name="m_addr2" id="addr2" value="<?=$mem[m_addr2]?>" class="frm_input" placeholder="지번주소"  size="29"/>
									</p>
									</td>
									-->
									<td>
									<input type="text" class="frm_input" name="m_zip" id="zip" value="<?php echo $mem[m_zip]?>" readonly="readonly" class="frm_input" style="width:100px;"  placeholder="우편번호" <?php echo $config['c_req_addr']=='Y'?'required':'';?>/>&nbsp;
									<img src="{MARI_HOMESKIN_URL}/img/btn_post.png"  align="absmiddle" style="cursor:pointer;" onclick="javascript:execDaumPostcode();" alt="우편번호찾기"><br/><br/>
									<span id="guide" style="color:#999"></span>	
									<input type="text" class="frm_input" name="m_addr1" id="addr1" value="<?php echo $mem[m_addr1]?>" class="frm_input" placeholder="도로명주소" size="29"/>
									&nbsp;
									<input type="text" class="frm_input" name="m_addr2" id="addr2" value="<?php echo $mem[m_addr2]?>" class="frm_input" placeholder="지번주소"  size="29"/>
									</td>
								<?php }?>
								</tr>

					<tr>
						<th>회원등급</th>
						<td>
							<select name="m_level" onChange="getSelectValue(this.form);">
								<option>등급선택</option>

								<?php
								    for ($i=0; $row=sql_fetch_array($lv); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$mem[m_level]?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>&nbsp;&nbsp;&nbsp;
							<input type="radio" name="m_signpurpose" id="pose_chk1" value="N" <?php echo $mem['m_signpurpose']=='N'?'checked':'';?> <?php if($mem['m_level']<>"2"){?>disabled<?php }?> /> <label for="">일반 개인투자자</label>&nbsp;
							<input type="radio" name="m_signpurpose" id="pose_chk2" value="I" <?php echo $mem['m_signpurpose']=='I'?'checked':'';?> <?php if($mem['m_level']<>"2"){?>disabled<?php }?> /> <label for="">소득적격 개인투자자</label>&nbsp;
							<input type="radio" name="m_signpurpose" id="pose_chk3" value="P" <?php echo $mem['m_signpurpose']=='P'?'checked':'';?> <?php if($mem['m_level']<>"2"){?>disabled<?php }?> /> <label for="">전문 투자자</label>&nbsp;
							<input type="radio" name="m_signpurpose" id="pose_chk4" value="L" <?php echo $mem['m_signpurpose']=='L'?'checked':'';?> <?php if($mem['m_level']<>"2"){?>disabled<?php }?> /> <label for="">대출회원</label>
						</td>
						<th>E 머니</th>
						<td><input type="text" name="m_emoney" value="<?php echo number_format($mem['m_emoney']); ?>" id="" class="frm_input " onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> 원</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<?php echo $m_birth1 ?>년<?php echo $m_birth2 ?>월<?php echo $m_birth3 ?>일
						</td>
						<th>성별</th>
						<td>
							<input type="radio" name="m_sex" id="" value="m" <?php echo $mem['m_sex']=='m'?'checked':'';?>/> <label for="">남</label>
							<input type="radio" name="m_sex" id="" value="w" <?php echo $mem['m_sex']=='w'?'checked':'';?>/> <label for="">여</label>
						</td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td>
							<select name="m_newsagency">
								<option>통신사선택</option>
								<option value="SKT" <?php echo $mem['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
								<option value="KT" <?php echo $mem['m_newsagency']=='KT'?'selected':'';?>>KT</option>
								<option value="LGT" <?php echo $mem['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
								<option value="기타" <?php echo $mem['m_newsagency']=='기타'?'selected':'';?>>기타</option>
							</select>
							<select name="hp1">
								<option>선택</option>
								<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
								<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
								<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
								<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
								<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
							</select> _
							<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="6"   maxlength="4"/> _
							<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="6"   maxlength="4"/>
						<input type="checkbox" name="m_sms"  class="ml15"  value="1" <?php echo $mem['m_sms']=='1'?'checked':'';?>/> <label for="">SMS수신동의</label>
						</td>
						<th>추천인</th>
						<td><input type="text" name="m_referee" value="<?php echo $mem['m_referee']; ?>" id=""  class="frm_input " size="" /></td>
					</tr>
					<tr>
						<!-- th>가입목적</th>
						<td>
							<input type="radio" name="m_signpurpose" id="" value="투자하기" <?php echo $mem['m_signpurpose']=='투자하기'?'checked':'';?>/> <label for="">투자하기</label>
							<input type="radio" name="m_signpurpose" id=""  value="대출신청"<?php echo $mem['m_signpurpose']=='대출신청'?'checked':'';?>/> <label for="">대출신청</label>
						</td -->
						<th>가입경로</th>
						<td colspan="3">
							<input type="radio" name="m_joinpath" id="" value="검색포탈" <?php echo $mem['m_joinpath']=='검색포탈'?'checked':'';?>/> <label for="" class="sz1" >검색포탈</label>
							<input type="radio" name="m_joinpath" id="" value="인터넷 기사" <?php echo $mem['m_joinpath']=='인터넷 기사'?'checked':'';?>/> <label for="" class="sz1">인터넷 기사</label>
							<input type="radio" name="m_joinpath" id="" value="인터넷 광고" <?php echo $mem['m_joinpath']=='인터넷 광고'?'checked':'';?>/> <label for="" class="sz1">인터넷 광고</label>
							<input type="radio" name="m_joinpath" id="" value="모바일 광고" <?php echo $mem['m_joinpath']=='모바일 광고'?'checked':'';?>/> <label for="" class="sz1">모바일 광고</label><br />
							<input type="radio" name="m_joinpath" id="" value="지인추천" <?php echo $mem['m_joinpath']=='지인추천'?'checked':'';?>/> <label for="" class="sz1">지인추천</label>
							<input type="radio" name="m_joinpath" id="" value="신문" <?php echo $mem['m_joinpath']=='신문'?'checked':'';?>/> <label for="" class="sz1">신문</label>
							<input type="radio" name="m_joinpath" id="" value="홍보믈" <?php echo $mem['m_joinpath']=='홍보믈'?'checked':'';?>/> <label for="" class="sz1">홍보믈</label>
							<input type="radio" name="m_joinpath" id="" value="기타" <?php echo $mem['m_joinpath']=='기타'?'checked':'';?>/> <label for="" class="sz1">기타</label>
						</td>
					</tr>
					<tr>
						<th>회원가입일</th>
						<td><?php echo substr($mem['m_datetime'],0,10); ?></td>
						<th>최근접속일</th>
						<td><?php echo substr($mem['m_today_login'],0,10); ?></td>
					</tr>
								<?php if($config['c_use_homepage']=="Y"){?>
								<tr>
									<th><span>홈페이지주소</span></th>
									<td colspan="3">
										<input type="text" name="m_homepage" id="" class="frm_input " value="<?php echo $mem['m_homepage']; ?>" size="62"  maxlength="50" <?php echo $config['c_req_homepage']=='Y'?'required':'';?>/>
									</td>
								</tr>
								<?php }?>
					<tr>
						<th>실명인증</th>
						<td>
							<input type="radio" name="m_blindness" value="Y" id="" <?php echo $mem['m_blindness']=='Y'?'checked':'';?>/> <label for="">인증</label>
							<input type="radio" name="m_blindness" value="N" id="" <?php echo $mem['m_blindness']=='N'?'checked':'';?>/> <label for="">미인증</label>
						</td>
						<th>아이핀인증</th>
						<td>
							<input type="radio" name="m_ipin" id="" value="Y" <?php echo $mem['m_ipin']=='Y'?'checked':'';?>/> <label for="">인증</label>
							<input type="radio" name="m_ipin" id="" value="N" <?php echo $mem['m_ipin']=='N'?'checked':'';?>/> <label for="">미인증</label>
						</td>
					</tr>
					<tr>
						<th>탈퇴처리(삭제)</th>
						<td><img src="{MARI_ADMINSKIN_URL}/img/secede_btn.png" id="member_delete" style="cursor:pointer;" alt="탈퇴하기" /></td>
						<th>차단처리</th>
						<td>
						<?php if($mem['m_intercept_date']=="0000-00-00"){?>
						<img src="{MARI_ADMINSKIN_URL}/img/block_btn.png" id="member_intercept" style="cursor:pointer;" alt="차단하기" />
						<?php }else{?>
						<img src="{MARI_ADMINSKIN_URL}/img/unblock_btn.png" id="member_intercept_no" style="cursor:pointer;" alt="차단해제" />
						<?php }?>
						</td>
					</tr>
					<tr>
						<th>누적투자금액</th>
						<td><?php echo number_format($order_pay) ?>원</td>
						<th>누적대출금액</th>
						<td><?php echo number_format($loan_pay) ?>원</td>
					</tr>
					<tr>
						<th>은행/입금계좌</th>
						<td><input type="text" name="m_my_bankcode" value="<?php echo $mem['m_my_bankcode']; ?>" class="frm_input " size="" /> / <input type="text" name="m_my_bankacc" value="<?php echo $mem['m_my_bankacc']; ?>" class="frm_input " size="40" /></td>
						<th>예금주</th>
						<td><input type="text" name="m_my_bankname" value="<?php echo $mem['m_my_bankname']; ?>" class="frm_input " size="" /></td>
					</tr>
					<tr>
						<th>주민등록번호</th>
						<td><input type="text" name="reginum1" value="<?php echo substr($mem['m_reginum'],0,6); ?>" class="frm_input " size="15" maxlength="6"/> - <input type="text" name="reginum2" value="<?php echo substr($mem['m_reginum'],6,7); ?>" class="frm_input " size="15" maxlength="7"/></td>
						<th>원천징수주소</th>
						<td>
						<input type="text" class="frm_input" name="m_with_zip" id="w_zip" value="<?php echo $mem[m_with_zip]?>" readonly="readonly" class="frm_input" style="width:100px;"  placeholder="우편번호" <?php echo $config['c_req_addr']=='Y'?'required':'';?>/>&nbsp;
						<img src="{MARI_HOMESKIN_URL}/img/btn_post.png"  align="absmiddle" style="cursor:pointer;" onclick="javascript:execDaumPostcode_b();" alt="우편번호찾기"><br/><br/>
						<span id="guide" style="color:#999"></span>	
						<input type="text" class="frm_input" name="m_with_addr1" id="w_addr1" value="<?php echo $mem[m_with_addr1]?>" class="frm_input" placeholder="도로명주소" size="29"/>
						&nbsp;
						<input type="text" class="frm_input" name="m_with_addr2" id="w_addr2" value="<?php echo $mem[m_with_addr2]?>" class="frm_input" placeholder="지번주소"  size="29"/>
						</td>
					</tr>
					<tr>
						<th>메모</th>
						<td colspan="3"><textarea name="m_memo_call" id=""><?php echo $mem['m_memo_call']; ?></textarea></td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="local_desc02">
			<p>＊회원정보를 수정하신후 “확인”버튼을 눌러 저장하실 수 있습니다.  </p>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" title="확인" id="member_form_add" />
			<a href="{MARI_HOME_URL}/?cms=member_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->
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

                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
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

   function execDaumPostcode_b() {
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

                document.getElementById('w_zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('w_addr1').value = fullRoadAddr;
                document.getElementById('w_addr2').focus();
                
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
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok(f)
{
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}

	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			
	if(exptext.test(f.m_id.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.m_id.focus(); return false;
	}
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.m_name.value){alert('\n이름을 입력하여 주십시오.');f.m_name.focus();return false;}
	if(f.m_level[0].selected == true){alert('\n회원등급을 선택하여 주십시오.');return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=member_form&type=<?php echo $type;?>';
	f.submit();
}


/*탈퇴처리*/
$(function() {
	$('#member_delete').click(function(){
	next_d(document.member_form);
	});
});


function next_d(f)
{
  if(confirm("정말 탈퇴처리 하시겠습니까? 탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다."))
  {
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=member_form&type=d';
	f.submit();
  }
}


/*차단처리*/
$(function() {
	$('#member_intercept').click(function(){
		Member_intercept_Ok(document.member_form);
	});
});


function Member_intercept_Ok(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=member_form&type=c';
	f.submit();
}

/*차단해제처리*/
$(function() {
	$('#member_intercept_no').click(function(){
		Member_intercept_NO(document.member_form);
	});
});


function Member_intercept_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=member_form&type=cn';
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
<script>
	//회원레벨 2레벨 선택시에만 사용가능
	function getSelectValue(frm){
		if(frm.m_level.options[frm.m_level.selectedIndex].value =="2"){
			document.getElementById("pose_chk1").disabled = false; 
			document.getElementById("pose_chk2").disabled = false; 
			document.getElementById("pose_chk3").disabled = false; 
			document.getElementById("pose_chk4").disabled = false; 
		}if(frm.m_level.options[frm.m_level.selectedIndex].value !="2"){
			document.getElementById("pose_chk1").disabled = true; 
			document.getElementById("pose_chk2").disabled = true; 
			document.getElementById("pose_chk3").disabled = true; 
			document.getElementById("pose_chk4").disabled = true; 
		}
	}
</script>

{# s_footer}<!--하단-->