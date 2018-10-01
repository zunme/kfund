<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
		<div class="title02">회원가입/본인확인설정</div>
			<fieldset>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="setting3"/>
			<!-- 회원가입 설정 -->
			<div id="anc_cf_join">
				<h2 class="bo_title"><span>회원가입 설정</span></h2>
				<div class="bo_text">
					<p>회원가입 시 입력 받을 정보를 설정할 수 있습니다.</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
						<caption>회원가입 설정</caption>
						<colgroup>
							<col class="grid_4">
							<col>
							<col class="grid_4">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="bo">홈페이지 입력</th>
								<td>
									<input type="checkbox" name="c_use_homepage" value="Y" <?php echo $conl['c_use_homepage']=='Y'?'checked':'';?> > <label for="">보이기</label>
									<input type="checkbox" name="c_req_homepage" value="Y" <?php echo $conl['c_req_homepage']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
								<th scope="bo">주소 입력</th>
								<td>
									<input type="checkbox" name="c_use_addr"value="Y" <?php echo $conl['c_use_addr']=='Y'?'checked':'';?>> <label for="">보이기</label>
									<input type="checkbox" name="c_req_addr" value="Y" <?php echo $conl['c_req_addr']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
							</tr>
							<tr>
								<th scope="bo">전화번호 입력</th>
								<td>
									<input type="checkbox" name="c_use_tel" value="Y" <?php echo $conl['c_use_tel']=='Y'?'checked':'';?> > <label for="cf_use_tel">보이기</label>
									<input type="checkbox" name="c_req_tel" value="Y" <?php echo $conl['c_req_tel']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
								<th scope="bo">휴대폰번호 입력</th>
								<td>
									<input type="checkbox" name="c_use_hp" value="Y" <?php echo $conl['c_use_hp']=='Y'?'checked':'';?> > <label for="">보이기</label>
									<input type="checkbox" name="c_req_hp" value="Y" <?php echo $conl['c_req_hp']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
							</tr>
							<tr>
								<th scope="bo">이메일 입력</th>
								<td>
									<input type="checkbox" name="c_use_email" value="Y" <?php echo $conl['c_use_email']=='Y'?'checked':'';?> > <label for="">보이기</label>
									<input type="checkbox" name="c_req_email" value="Y" <?php echo $conl['c_req_email']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
								<th scope="bo">닉네임 입력</th>
								<td>
									<input type="checkbox" name="c_use_nick" value="Y" <?php echo $conl['c_use_nick']=='Y'?'checked':'';?> > <label for="">보이기</label>
									<input type="checkbox" name="c_req_nick" value="Y" <?php echo $conl['c_req_nick']=='Y'?'checked':'';?> > <label for="">필수입력</label>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원가입시 권한</label></th>
								<td>
									<select name="c_memregi_level">
										<option value="1" <?= $conl['c_memregi_level'] == "1"?"selected":"" ?>  >1</option>
										<option value="2" <?= $conl['c_memregi_level'] == "2"?"selected":"" ?>  >2</option>
										<option value="3" <?= $conl['c_memregi_level'] == "3"?"selected":"" ?>  >3</option>
										<option value="4" <?= $conl['c_memregi_level'] == "4"?"selected":"" ?>  >4</option>
										<option value="5" <?= $conl['c_memregi_level'] == "5"?"selected":"" ?>  >5</option>
										<option value="6" <?= $conl['c_memregi_level'] == "6"?"selected":"" ?>  >6</option>
										<option value="7" <?= $conl['c_memregi_level'] == "7"?"selected":"" ?>  >7</option>
										<option value="8" <?= $conl['c_memregi_level'] == "8"?"selected":"" ?>  >8</option>
										<option value="9" <?= $conl['c_memregi_level'] == "9"?"selected":"" ?>  >9</option>
										<option value="10" <?= $conl['c_memregi_level'] == "10"?"selected":"" ?>  >10</option>
									</select>
								</td>
								<th scope="bo"><label for="">폼메일 사용여부</label></th>
								<td>
									<select name="c_email_use">
										<option value="Y" <?= $conl['c_email_use'] == "Y"?"selected":"" ?>  >사용함</option>
										<option value="N" <?= $conl['c_email_use'] == "N"?"selected":"" ?>  >사용안함</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원아이콘 사용</label></th>
								<td colspan="3">
									<span class="frm_info">게시물에 게시자 닉네임 대신 아이콘 사용</span>
									<select name="c_use_member_icon">
										<option value="no" <?= $conl['c_use_member_icon'] == "no"?"selected":"" ?>  >미사용</option>
										<option value="icon" <?= $conl['c_use_member_icon'] == "icon"?"selected":"" ?>  >아이콘만표시</option>
										<option value="in" <?= $conl['c_use_member_icon'] == "in"?"selected":"" ?>  >아이콘+이름표시</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원아이콘 용량</label></th>
								<td><input type="text" name="c_member_icon_size" value="<?php echo $conl['c_member_icon_size'];?>" id="" class="frm_input" size="10"> 바이트 이하</td>
								<th scope="bo">회원아이콘 사이즈</th>
								<td>
									<label for="">가로</label>
									<input type="text" name="c_member_icon_width" value="<?php echo $conl['c_member_icon_width'];?>" id="" class="frm_input" size="2">
									<label for="">세로</label>
									<input type="text" name="c_member_icon_height" value="<?php echo $conl['c_member_icon_height'];?>" id="" class="frm_input" size="2">
									픽셀 이하
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">추천인제도 사용</label></th>
								<td  colspan="3"><input type="checkbox" name="c_use_recommend" value="<?php echo $conl['c_use_recommend'];?>" id="" > 사용</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">아이디,닉네임 금지단어</label></th>
								<td>
									<span class="">회원아이디, 닉네임으로 사용할 수 없는 단어를 정합니다. 쉼표 (,) 로 구분</span>
									<textarea name="c_prohibit_id" ><?php echo $conl['c_prohibit_id'];?></textarea>
								</td>
								<th scope="bo"><label for="">입력 금지 메일</label></th>
								<td>
									<span class="">입력 받지 않을 도메인을 지정합니다. 엔터로 구분 ex) hotmail.com</span>                
									<textarea name="c_prohibit_email"><?php echo $conl['c_prohibit_email'];?></textarea>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원가입약관</label></th>
								<td colspan="3">
								<?php echo editor_html('c_stipulation', $conl['c_stipulation']); ?>
								</td>
							</tr>							
							<tr>
								<th scope="bo"><label for="">개인정보처리방침</label></th>
								<td colspan="3">
								<?php echo editor_html('c_privacy', $conl['c_privacy']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">이메일집단수신거부</label></th>
								<td colspan="3">
								<?php echo editor_html('c_email_refusal', $conl['c_email_refusal']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">투자금관리</label></th>
								<td colspan="3">
								<?php echo editor_html('c_invest_manage', $conl['c_invest_manage']); ?>
								</td>
							</tr>
							<!--<tr>
								<th scope="bo"><label for="">자동분산투자 설정시 위험안내</label></th>
								<td colspan="3">
								<?php echo editor_html('c_auto_dangerous', $conl['c_auto_dangerous']); ?>
								</td>
							</tr>-->
							<tr>
								<th scope="bo"><label for="">투자이용약관</label></th>
								<td colspan="3">
								<?php echo editor_html('c_auto_dangerous', $conl['c_auto_dangerous']); ?>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>

			<!-- 본인 확인 설정 -->
			<div id="anc_cf_cert">
				<h2 class="bo_title"><span>본인확인 설정</span></h2>
				<div class="bo_text">
					<p>
						회원가입 시 본인확인 수단을 설정합니다.
					</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>본인인증 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">본인인증</label></th>
						<td>
							<select name="c_cert_use">
								<option value="N">사용안함</option>
								<option value="Y" <?= $conl['c_cert_use'] == "Y"?"selected":"" ?>  >사이렌24</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_ipin">아이핀 본인인증</label></th>
						<td class="cf_cert_service">
							<select name="c_cert_ipin">
								<option value="N">사용안함</option>
								<option value="Y" <?= $conl['c_cert_ipin'] == "Y"?"selected":"" ?>  >아이핀</option>
							</select>
							
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>
			<div id="anc_cf_cert">
				<h2 class="bo_title"><span>나이스 신용정보 코드 설정</span></h2>
				<div class="bo_text">
					<p>
						신용정보조회 코드를 설정합니다.
					</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>본인인증 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">나이스 점포코드</label></th>
						<td>
							<input type="text" name="c_company_code" size="30" class="frm_input" value="<?php echo $conl['c_company_code']?>">
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_ipin">나이스 패스워드 코드</label></th>
						<td class="cf_cert_service">	
							<input type="text" name="c_pw_code" size="30" class="frm_input" value="<?php echo $conl['c_pw_code']?>">
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>

			<div id="anc_cf_cert">
				<h2 class="bo_title"><span>나이스 신용정보 아이디&비밀번호 설정</span></h2>
				<div class="bo_text">
					<p>
						신용정보 재조회코드를 설정합니다.
					</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption></caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">나이스 아이디</label></th>
						<td>
							<input type="text" name="c_nice_id" size="30" class="frm_input" value="<?php echo $conl['c_nice_id']?>">
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_ipin">나이스로그인아이디</label></th>
						<td class="cf_cert_service">
							<input type="text" name="c_nice_login" size="30" class="frm_input" value="<?php echo $conl['c_nice_login']?>">
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_ipin">점포명</label></th>
						<td class="cf_cert_service">
							<input type="text" name="c_nice_company" size="30" class="frm_input" value="<?php echo $conl['c_nice_company']?>">
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_ipin">나이스비밀번호</label></th>
						<td class="cf_cert_service">
							<input type="text" name="c_nice_pw" size="30" class="frm_input" value="<?php echo $conl['c_nice_pw']?>">
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>

			<div id="anc_cf_cert">
				<h2 class="bo_title"><span>지도 API키 설정</span></h2>
				<div class="bo_text">
					<p>
						지도 API키를 설정합니다.
					</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption></caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">지도 API키</label></th>
						<td>
							<input type="text" name="c_map_api" size="50" class="frm_input" value="<?php echo $conl['c_map_api']?>">
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>
		</form>
			</fieldset>


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script type="text/javascript">
function sendit(){

	<?php echo get_editor_js('c_stipulation'); ?>
	<?php echo get_editor_js('c_privacy'); ?>
	<?php echo get_editor_js('c_email_refusal'); ?>
	<?php echo get_editor_js('c_invest_manage'); ?>
	<?php echo get_editor_js('c_auto_dangerous'); ?>

	var f=document.config_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=config_form';
	f.submit();
}
</script>

{# s_footer}<!--하단-->






