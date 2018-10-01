<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#header} 
<section id="container">
		<section id="sub_content">
			<div class="loan_wrap">
				<div class="container">
					<div class="loan_box2">
						<div>
							<table>
								<colgroup>
									<col width="20%">
									<col width="">
								</colgroup>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input type="text" name="m_name" placeholder="이름을 입력해주세요"/></td>
									</tr>
									<tr>
										<th>생년<br/>월일</th>
										<td><input type="text" name="m_birth" placeholder="생년월일을 입력해주세요"/></td>
									</tr>
									<tr>
										<th>성별</th>
										<td>
											<select name="m_sex">
												<option value="w">여성</option>
												<option value="m">남성</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>휴대<br/>전화</th>
										<td><input type="text" name="m_hp" placeholder="ex)010xxxxxxxx"/></td>
									</tr>
									<tr>
										<th>&nbsp;</th>
										<td><img src="{MARI_MOBILESKIN_URL}/img/btn_number_comfirm.png" alt="번호인증하기" class="col-xs-12 no_pd"/><br/>반드시 본인명의 휴대폰 번호 입력바랍니다.</td>
									</tr>
	
								</tbody>
							</table>
						</div>
						<div>
						<table>
							<colgroup>
								<col width="20%">
								<col width="">
							</colgroup>

							<tbody>
								<tr>
									<th>은행</th>
									<td><select name="m_my_bankcode">
											<option value="KEB_005"  >외환은행</option>
											<option value="KIUP_003" >기업은행</option>
											<option value="NONGHYUP_011" >농협중앙회</option>
											<option value="SC_023" >SC제일은행</option>
											<option value="SHINHAN_088" >신한은행</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>계좌<br/>번호</th>
									<td><input type="text" name="m_my_bankacc" placeholder="계좌번호를 입력해주세요"/></td>
								</tr>
								<tr>
									<th>&nbsp;</th>
									<td><img src="{MARI_MOBILESKIN_URL}/img/btn_number_comfirm.png" alt="번호인증하기" class="col-xs-12 no_pd"/><br/>23:30~01:00시에는 전산망 점검 시간입니다.</td>
								</tr>
								<tr>
									<th colspan="2">
										<a href="{MARI_HOME_URL}/?mode=loan"><img src="{MARI_MOBILESKIN_URL}/img/btn_loan_confirm2.png" alt="입력완료"/></a>
									</th>
								</tr>
							</tbody>
						</table>
						
						</div>
					</div><!-- /login_box1-->
			</div>
			</div><!-- /login_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
				 

{# footer}<!--하단-->