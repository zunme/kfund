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
			<div class="mypage_wrap">
				<div class="container">
				<div class="dashboard_my_info">
							<h3><span>정보수정</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_current">기본 정보</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center">인증센터</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_out" class="">회원탈퇴</a></li>
								</ul>
							</h3>
					<form name="member_form"  method="post" enctype="multipart/form-data">
					<input type="hidden" name="m_no" value="{_mmo['m_no']}"/>
					<input type="hidden" name="mode" value="member_modify"/>
					<input type="hidden" name="m_id" value="<?php echo $user[m_id];?>">
							<div class="dashboard_info_modify">
								<div>
									<table>
										<colgroup>
											<col width=""/>
											<col width=""/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>개인 정보 수정</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>투자자 구분</th>
												<td><?php echo $invest_flag;?></td>
											</tr>
											<tr>
												<th>이름</th>
												<td><?php echo $user['m_name'];?></td>
											</tr>
											<tr>
												<th>아이디</th>
												<td><?php echo $user['m_id'];?></td>
											</tr>
											<tr>
												<th>휴대폰 번호</th>
												<td>
												<select class="" name="hp1" <?php echo $config['c_req_hp']=='Y'?'required':'';?>>
													<option>선택</option>
													<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
													<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
													<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
													<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
													<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
													</select><input type="text" class="" name="hp2" value="<?php echo $hp2;?>" id=""  maxlength="8" />
													<input type="text" class="" name="hp3" value="<?php echo $hp3;?>" id=""  maxlength="8" />
													<!-- 기능 미개발로 일시작인 주석처리 2016-11-03 박유나
													<a href="javascript:;" class="btn_confirm_phonenumber">인증</a>
													<input type="text" class="confirm_number" name="" value="" id=""  maxlength="4" />
													<a href="javascript:;" class="btn_submit_dashboard_info_modify">확인</a>
													-->
												</td>
											</tr>
											<tr>
												<th>생년월일</th>
												<td><input type="text" class="birth" name="birth" value="<?php echo substr($user[m_birth],0,4).substr($user[m_birth],5,2).substr($user[m_birth],8,2);?>" id=""  maxlength="8" placeholder="ex)19801224" /></td>
											</tr>
											<tr>
												<th>투자 알림 설정</th>
												<td><label><input type="checkbox" name="m_sms" value="1" <?php echo $user['m_sms']=='1'?'checked':'';?> >SMS 투자 알림 받기</label></td>
											</tr>
										</tbody>
									</table>
								</div>

								<div>
									<table>
										<colgroup>
											<col width="85px"/>
											<col width=""/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/>비밀번호 변경</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>기존 비밀번호</th>
												<td><input type="password" class="modify_pw" name="password" value="" id=""  maxlength="" /></td>
											</tr>
											<tr>
												<th>새 비밀번호</th>
												<td><input type="password" class="modify_pw" name="m_password" value="" id=""  maxlength="" /></td>
											</tr>
											<tr>
												<th>새 비밀번호 확인</th>
												<td><input type="password" class="modify_pw" name="m_password_re" value="" id=""  maxlength="" /></td>
											</tr>
										</tbody>
									</table>
								</div>
									<a href="javascript:void(0);" onclick="Member_form_Ok();" class="modify_submit">확인</a>
							</div>
						</form>
					</div>
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
	
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
</script>
<script>
/*필수체크*/
$(function() {
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});


function Member_form_Ok()
{	
	var f = document.member_form;

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3';
	f.submit();
}
</script>

{# footer}<!--하단-->

 



