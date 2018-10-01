<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
		<div class="title02">기본환경설정</div>
			<fieldset>
			<!-- 기본환경설정 -->
			<div id ="server_info">
				<h2 class="bo_title"><span>SERVER 정보</span></h2>
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<caption>결제설정 입력</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo">FTP HOST</th>
						<td><?php echo $sv['ftp_host']; ?> <a href="#">[FTP접속]</a></td>
					</tr>
					<tr>
						<th scope="bo">FTP 아이디</th>
						<td><?php echo $sv['ftp_id']; ?></td>
					</tr>
					<tr>
						<th scope="bo">FTP 비밀번호</th>
						<td><?php echo $sv['ftp_pw']; ?></td>
					</tr>
					<tr>
						<th scope="bo">MYSQL USER</th>
						<td><?php echo $sv['mysql_user']; ?></td>
					</tr>
					<tr>
						<th scope="bo">MYSQL DB</th>
						<td><?php echo $sv['mysql_db']; ?> <a href="#">DB접속</a></td>
					</tr>
					<tr>
						<th scope="bo">서버 IP</th> 
						<td><?php echo $sv['mysql_host']; ?></td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
			<!-- 홈페이지 기본환경 설정 -->
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="w"/>
			<div id ="anc_cf_basic">
				<h2 class="bo_title"><span>홈페이지 기본환경 설정</span></h2>
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<caption>홈페이지 기본환경 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo">관리자</th>
						<td>	
						<p>* 레벨이 10인 사용자만 select됩니다.</p>
							<select name="c_admin">
							<?php
								for ($i=0; $row=sql_fetch_array($su_admin); $i++) {
							?>
								<option value="<?php echo $row['m_id']; ?>" <?php echo $row['m_id']==$conl['c_admin']?'selected':'';?>><?php echo $row['m_id']; ?></option>
							<?php }?>
						</td>
					</tr>
					<tr>
						<th scope="bo">관리자 이메일 주소</th>
						<td>
							<input type="text" name="c_admin_email" value="<?php echo $conl['c_admin_email'];?>" id=""  class="frm_input " size="70" />

						</td>
					</tr>
					<tr>
						<th scope="bo">접근가능 IP</th>
						<td>
						<p>* 입력된 ip의 PC만 접근이 가능합니다. 공란일시 모두 접속허용됩니다. 입력 예)61.22.111.244, 61.23.122.245</p>
						<textarea name="c_possible_ip"><?php echo $conl['c_possible_ip'];?></textarea>
						</td>
					</tr>
					<tr>
						<th scope="bo">접근차단 IP</th>
						<td>
						<p>* 입력된 ip의 PC의 접근이 차단됩니다. 입력 예)61.22.111.244, 61.23.122.245</p>
						<textarea name="c_intercept_ip"><?php echo $conl['c_intercept_ip'];?></textarea>
						</td>
					</tr>
					<tr>
						<th scope="bo">단어 필터링</th>
						<td>
						<p>* 입력된 단어가 포함된 내용을 게시할 수 없습니다. 입력 예) 단어, 단어1</p>
						<textarea name="c_filter"><?php echo $conl['c_filter'];?></textarea>
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
			<!-- 레이아웃및 스킨 설정 -->
			<div id="anc_cf_join">
				<h2 class="bo_title"><span>레이아웃및 스킨 설정</span></h2>
				<div class="bo_text">
					<p>각 HOME / ADMIN 화면의 레이아웃 및 스킨을 설정하실 수 있습니다.</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
						<caption>레이아웃및 스킨 설정</caption>
						<colgroup>
							<col class="grid_4">
							<col>
							<col class="grid_4">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="bo">
									<label for="">HOME 레이아웃<strong class="sound_only">필수</strong></label>
								</th>
								<td colspan="3">
								<?php echo get_skin_select('home', ''.$i, "c_home_skin", $conl['c_home_skin']); ?>

								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">ADMIN 레이아웃<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<?php echo get_skin_select('admin', ''.$i, "c_admin_skin", $conl['c_admin_skin']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원가입 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<?php echo get_skin_select('member', ''.$i, "c_member_skin", $conl['c_member_skin']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">로그인 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<?php echo get_skin_select('login', ''.$i, "c_login_skin", $conl['c_login_skin']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">폼메일 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
								<?php echo get_skin_select('formmail', ''.$i, "c_formmail_skin", $conl['c_formmail_skin']); ?>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">최신글 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
								<?php echo get_skin_select('latest', ''.$i, "c_latest_skin", $conl['c_latest_skin']); ?>
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
			<!-- 게시판 기본설정-->
			<div id="anc_cf_board">
				<h2 class="bo_title"><span>게시판 기본 설정</span></h2>
				<div class="bo_text">
					<p>각 게시판 관리에서 개별적으로 설정 가능합니다.</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>게시판 기본 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">페이지표시수</label></th>
						<td>
							<span class="frm_info">페이지 전체 표시수</span>
							<input type="text" name="c_page_rows" value="<?php echo $conl['c_page_rows'];?>" id="" class="frm_input" size="3"> 페이지
						</td>
						<th scope="bo"><label for="">페이지당 리스트수</label></th>
						<td>
							<span class="frm_info">한페이지당 게시물 리스트수</span>
							<input type="text" name="c_write_pages" value="<?php echo $conl['c_write_pages'];?>" id="" class="frm_input" size="3"> 개
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">이미지 업로드 확장자</label></th>
						<td colspan="3">
							<span class="frm_info">게시판 글작성시 이미지 파일 업로드 가능 확장자. | 로 구분</span>
							<input type="text" name="c_image_upload" value="<?php echo $conl['c_image_upload'];?>" id="" class="frm_input" size="70">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">플래쉬 업로드 확장자</label></th>
						<td colspan="3">
							<span class="frm_info">게시판 글작성시 플래쉬 파일 업로드 가능 확장자. | 로 구분</span>
							<input type="text" name="c_flash_upload" value="<?php echo $conl['c_flash_upload'];?>" id="" class="frm_input" size="70">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">동영상 업로드 확장자</label></th>
						<td colspan="3">
							<span class="frm_info">게시판 글작성시 동영상 파일 업로드 가능 확장자. | 로 구분</span>
							<input type="text" name="c_movie_upload" value="<?php echo $conl['c_movie_upload'];?>" id="" class="frm_input" size="70">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">단어 필터링</label></th>
						<td colspan="3">
							<span class="frm_info">입력된 단어가 포함된 내용은 게시할 수 없습니다. 단어와 단어 사이는 ,로 구분합니다.</span>
							<textarea name="c_bo_filter"><?php echo $conl['c_bo_filter'];?></textarea>
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
								<th scope="bo">사업자등록번호 입력</th>
								<td  colspan="3">
									<input type="checkbox" name="c_companynum_use" value="Y" <?php echo $conl['c_companynum_use']=='Y'?'checked':'';?> > <label for="">보이기</label>
									<input type="checkbox" name="c_companynum_use" value="Y" <?php echo $conl['c_companynum_use']=='Y'?'checked':'';?> > <label for="">필수입력</label>
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
								<td colspan="3"><textarea name="c_stipulation"><?php echo $conl['c_stipulation'];?></textarea></td>
							</tr>
							<tr>
								<th scope="bo"><label for="">개인정보처리방침</label></th>
								<td colspan="3"><textarea name="c_privacy"><?php echo $conl['c_privacy'];?></textarea></td>
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
					<!-- 
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_hp">휴대폰 본인확인</label></th>
						<td class="cf_cert_service">
							<select name="cf_cert_hp" id="cf_cert_hp">
								<option value="" selected="selected">사용안함</option>
								<option value="kcb">코리아크레딧뷰로(KCB) 휴대폰 본인확인</option>
								<option value="kcp">한국사이버결제(KCP) 휴대폰 본인확인</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_kcb_cd">코리아크레딧뷰로<br>KCB 회원사ID</label></th>
						<td class="cf_cert_service">
							<span class="frm_info">KCB 회원사ID를 입력해 주십시오.<br>서비스에 가입되어 있지 않다면, KCB와 계약체결 후 회원사ID를 발급 받으실 수 있습니다.<br>이용하시려는 서비스에 대한 계약을 아이핀, 휴대폰 본인확인 각각 체결해주셔야 합니다.<br>아이핀 본인확인 테스트의 경우에는 KCB 회원사ID가 필요 없으나,<br>휴대폰 본인확인 테스트의 경우 KCB 에서 따로 발급 받으셔야 합니다.</span>                <input type="text" name="cf_cert_kcb_cd" value="" id="cf_cert_kcb_cd" class="frm_input" size="20"> <a href="http://coreweb.kr/main/provider/b_ipin.php" target="_blank" class="btn_frmline">KCB 아이핀 서비스 신청페이지</a>
							<a href="http://coreweb.kr/main/provider/b_cert.php" target="_blank" class="btn_frmline">KCB 휴대폰 본인확인 서비스 신청페이지</a>
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_kcp_cd">한국사이버결제<br>KCP 사이트코드</label></th>
						<td class="cf_cert_service">
							<span class="frm_info">SM으로 시작하는 5자리 사이트 코드중 뒤의 3자리만 입력해 주십시오.<br>서비스에 가입되어 있지 않다면, 본인확인 서비스 신청페이지에서 서비스 신청 후 사이트코드를 발급 받으실 수 있습니다.</span>                <span class="sitecode">SM</span>
							<input type="text" name="cf_cert_kcp_cd" value="" id="cf_cert_kcp_cd" class="frm_input" size="3"> <a href="http://coreweb.kr/main/provider/p_cert.php" target="_blank" class="btn_frmline">KCP 휴대폰 본인확인 서비스 신청페이지</a>
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_limit">본인확인 이용제한</label></th>
						<td class="cf_cert_service">
							<span class="frm_info">하루동안 아이핀과 휴대폰 본인확인 인증 이용회수를 제한할 수 있습니다.<br>회수제한은 실서비스에서 아이핀과 휴대폰 본인확인 인증에 개별 적용됩니다.<br>0 으로 설정하시면 회수제한이 적용되지 않습니다.</span>                <input type="text" name="cf_cert_limit" value="2" id="cf_cert_limit" class="frm_input" size="3"> 회
						</td>
					</tr>
					<tr>
						<th scope="bo" class="cf_cert_service"><label for="cf_cert_req">본인확인 필수</label></th>
						<td class="cf_cert_service">
							<span class="frm_info">회원가입 때 본인확인을 필수로 할지 설정합니다. 필수로 설정하시면 본인확인을 하지 않은 경우 회원가입이 안됩니다.</span>                <input type="checkbox" name="cf_cert_req" value="1" id="cf_cert_req"> 예
						</td>
					</tr> -->
					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>

			<!-- 기본 메일 환경설정 -->
			<div id="anc_cf_mail">
				<h2 class="bo_title"><span>기본 메일 환경 설정</span></h2>
				<div class="bo_text">
					<p>
						전체 메일발송 사용여부를 설정하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>기본 메일 환경 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">메일발송 사용</label></th>
						<td>
							<span class="frm_info">체크하지 않으면 메일발송을 아예 사용하지 않습니다. 메일 테스트도 불가합니다.</span>
							<input type="checkbox" name="c_email_use" value="Y" <?php echo $conl['c_email_use']=='Y'?'checked':'';?>/> 사용
						</td>
					</tr>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>

			<!-- 게시판 글 작성 시 메일 설정 -->
			<div id="anc_cf_article_mail">
				<h2 class="bo_title"><span>게시판 글 작성 시 메일 설정</span></h2>
				<div class="bo_text">
					<p>
						게시판의 글을 작성시 발송할 메일설정을 하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>게시판 글 작성 시 메일 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">최고관리자</label></th>
						<td>
							<span class="frm_info">최고관리자에게 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_wr_administrator_admin" value="Y" <?php echo $conl['c_email_wr_administrator_admin']=='Y'?'checked':'';?>/> 사용
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">그룹관리자</label></th>
						<td>
							<span class="frm_info">그룹관리자에게 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_wr_group_admin" value="Y" <?php echo $conl['c_email_wr_group_admin']=='Y'?'checked':'';?>/> 사용
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">게시판관리자</label></th>
						<td>
							<span class="frm_info">게시판관리자에게 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_wr_board_admin" value="Y" <?php echo $conl['c_email_wr_board_admin']=='Y'?'checked':'';?>/> 사용
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">원글작성자</label></th>
						<td>
							<span class="frm_info">게시자님께 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_wr_write"  value="Y" <?php echo $conl['c_email_wr_write']=='Y'?'checked':'';?> /> 사용
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">댓글작성자</label></th>
						<td>
							<span class="frm_info">원글에 댓글이 올라오는 경우 댓글 쓴 모든 분들께 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_wr_comment_all"  value="Y" <?php echo $conl['c_email_wr_comment_all']=='Y'?'checked':'';?> /> 사용
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

			<!-- 회원가입 시 메일 설정 -->
			<div id="anc_cf_join_mail">
				<h2 class="bo_title"><span>회원가입 시 메일 설정</span></h2>
				<div class="bo_text">
					<p>
						회원가입시 발송할 메일설정을 하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>회원가입 시 메일 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for="">최고관리자 메일발송</label></th>
						<td>
							<span class="frm_info">최고관리자에게 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_mb_administrator_admin"  value="Y" <?php echo $conl['c_email_mb_administrator_admin']=='Y'?'checked':'';?> /> 사용
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for="">회원님께 메일발송</label></th>
						<td>
							<span class="frm_info">회원가입한 회원님께 메일을 발송합니다.</span>
							<input type="checkbox" name="c_email_mb_member"  value="Y" <?php echo $conl['c_email_mb_member']=='Y'?'checked':'';?> /> 사용
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


			<!-- 소셜네트워크 서비스 -->
			<div id="anc_cf_sns">
				<h2 class="bo_title"><span>소셜네트워크 (SNS) 설정</span></h2>
				<div class="bo_text">
					<p>
						페이스북 로그인 기타 SNS 서비스등을 설정하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>SNS 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for=" ">페이스북 앱 ID</label></th>
						<td>
							<input type="text" name="c_facebook_appid" value="<?php echo $conl['c_facebook_appid'];?>" id=" " class="frm_input">
							<a href="https://developers.facebook.com/apps" target="_blank">
								<img src="{MARI_ADMINSKIN_URL}/img/app_btn.png" alt="앱등록하기" />
							</a>
						</td>
						<th scope="bo"><label for=" ">페이스북로그인 사용유무</label></th>
						<td>
							<input type="checkbox" name="c_facebooklogin_use" value="Y" <?php echo $conl['c_facebooklogin_use']=='Y'?'checked':'';?>/> 사용
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
			<!-- SMS 서비스 -->
			<div id="anc_cf_sns">
				<h2 class="bo_title"><span>SMS사용설정</span></h2>
				<div class="bo_text">
					<p>
						발급받으신 아이디와 비밀번호및 키정보를 입력하신후 ADMIN에서 SMS발송관련 서비스를 이용하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>SMS사용설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for=" ">SMS ID</label></th>
						<td>
							<input type="text" name="c_sms_id" value="<?php echo $conl['c_sms_id'];?>" id=" " class="frm_input"> 
						</td>
						<th scope="bo"><label for=" ">SMS PW</label></th>
						<td>
							<input type="text" name="c_sms_pw" value="<?php echo $conl['c_sms_pw'];?>" id=" " class="frm_input" size="35">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for=" ">SMS KEY</label></th>
						<td>
							<input type="text" name="c_sms_key" value="<?php echo $conl['c_sms_key'];?>" id=" " class="frm_input"> 
						</td>
						<th scope="bo"><label for=" "></label></th>
						<td>
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
	var f=document.config_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=config_form';
	f.submit();
}
</script>

{# s_footer}<!--하단-->






