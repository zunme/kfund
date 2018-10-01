<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
<div id="container">
	<div id="sub_content">
		<div class="mypage">
			<div class="mypage_inner">


				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							<!---->
						</div>

						<div class="dashboard_side_mn">
							<ul>
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								<!---->
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
							</ul>
						</div>
					</div><!--dash_side--e-->

					<div class="dashboard_content">
					<!--개인회원정보수정-->
					<?php if($user[m_level]=="2"){?>
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
							<?php if(!$mmo[m_fb]){?>
							<!-- 페이스북 가입자가 아닐경우에만 이메일값 히든으로설정-->
							<input type="hidden" name="m_email" value="<?php echo $mmo[m_email]?>">
							<?php }?>
								<div class="dashboard_info_modify">
									<div>
										<table>
											<colgroup>
												<col width=""/>
												<col width=""/>
											</colgroup>
											<thead>
												<tr>
													<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>개인 정보 수정</th>
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
												<?php if($mmo[m_fb]=="facebook"){?>
												<tr>
													<th>이메일</th>
													<td><input type="text" class="birth" name="m_email" value="<?php echo $user[m_email]?>" id=""  placeholder="페이스북가입자는 이메일 입력이 필수입니다." /></td>
												</tr>
												<?php }?>
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
														</select><input type="text" class="" name="hp2" value="<?php echo $hp2;?>" id=""  maxlength="4" />
														<input type="text" class="" name="hp3" value="<?php echo $hp3;?>" id=""  maxlength="4" />
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
													<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>비밀번호 변경</th>
												</tr>
											</thead>
											<tbody>
											<?php if($user['m_fb_pw_change']=="Y" || $user[m_fb] != "facebook"){?>
												<tr>
													<th>기존 비밀번호</th>
													<td><input type="password" class="modify_pw" name="password" value="" id=""  maxlength="" /></td>
												</tr>
											<?php }?>
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
						<?php }?>
						
						<?php if($user[m_level] >= 3){?>
						<!--기업회원전용 수정 폼-->
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
							<?php if(!$mmo[m_fb]){?>
							<!-- 페이스북 가입자가 아닐경우에만 이메일값 히든으로설정-->
							<input type="hidden" name="m_email" value="<?php echo $mmo[m_email]?>">
							<?php }?>
								<div class="dashboard_info_modify">
									<div>
										<table>
											<colgroup>
												<col width=""/>
												<col width=""/>
											</colgroup>
											<thead>
												<tr>
													<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>개인 정보 수정</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th>투자자 구분</th>
													<td><?php echo $invest_flag;?></td>
												</tr>
												<tr>
													<th>담당자명</th>
													<td><?php echo $user['m_name'];?></td>
												</tr>
												<tr>
													<th>아이디</th>
													<td><?php echo $user['m_id'];?></td>
												</tr>
												<tr>
													<th>기업명</th>
													<td><input type="text" class="birth" name="m_company_name" value="<?php echo $user[m_company_name]?>" id=""  placeholder="기업명을 입력하십시오" /></td>
												</tr>
												<tr>
													<th>사업자등록번호</th>
													<td><input type="text" class="birth" name="m_companynum" value="<?php echo $user[m_companynum]?>" id=""  placeholder="사업자등록번호를 입력하십시오" /></td>
												</tr>												
												<?php if($mmo[m_fb]=="facebook"){?>
												<tr>
													<th>이메일</th>
													<td><input type="text" class="birth" name="m_email" value="<?php echo $user[m_email]?>" id=""  placeholder="페이스북가입자는 이메일 입력이 필수입니다." /></td>
												</tr>
												<?php }?>
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
														</select><input type="text" class="" name="hp2" value="<?php echo $hp2;?>" id=""  maxlength="4" />
														<input type="text" class="" name="hp3" value="<?php echo $hp3;?>" id=""  maxlength="4" />
													<!-- 기능 미개발로 일시작인 주석처리 2016-11-03 박유나
														<a href="javascript:;" class="btn_confirm_phonenumber">인증</a>
														<input type="text" class="confirm_number" name="" value="" id=""  maxlength="4" />
														<a href="javascript:;" class="btn_submit_dashboard_info_modify">확인</a>
													-->
													</td>
												</tr>
												<tr>
													<th>사업장전화번호</th>
													<td>
														<select name="tel1" <?php echo $config['c_req_tel']=='Y'?'required':'';?>>
															<option>선택</option>
															<option value="02" <?php echo $tel1=='02'?'selected':'';?>>02</option>
															<option value="051" <?php echo $tel1=='051'?'selected':'';?>>051</option>
															<option value="053" <?php echo $tel1=='053'?'selected':'';?>>053</option>
															<option value="032" <?php echo $tel1=='032'?'selected':'';?>>032</option>
															<option value="062" <?php echo $tel1=='062'?'selected':'';?>>062</option>
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
															<option value="064" <?php echo $tel1=='064'?'selected':'';?>>064</option>
															<option value="070" <?php echo $tel1=='070'?'selected':'';?>>070</option>
														</select>
														<input type="text" name="tel2" value="<?php echo $tel2;?>" id=""  class="frm_input " maxlength="4" <?php echo $config['c_req_tel']=='Y'?'required':'';?>/>
														<input type="text" name="tel3" value="<?php echo $tel3;?>" id=""  class="frm_input " maxlength="4" <?php echo $config['c_req_tel']=='Y'?'required':'';?>/>
														
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
													<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>비밀번호 변경</th>
												</tr>
											</thead>
											<tbody>
											<?php if($user['m_fb_pw_change']=="Y" || $user[m_fb] != "facebook"){?>
												<tr>
													<th>기존 비밀번호</th>
													<td><input type="password" class="modify_pw" name="password" value="" id=""  maxlength="" /></td>
												</tr>
											<?php }?>
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
						<?php }?>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->



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






{#footer}