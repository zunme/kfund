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
		<div class="title02">레이아웃/게시판설정</div>
			<fieldset>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="setting2"/>
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
									<p>현재 적용된 스킨은 <strong>{_conl['c_home_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_HOMESKIN_URL}/img/skin_main1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('home', ''.$i, "c_home_skin", $conl['c_home_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo">
									<label for="">MOBILE 레이아웃<strong class="sound_only">필수</strong></label>
								</th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_mobile_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_MOBILESKIN_URL}/img/skin_main1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('mobile', ''.$i, "c_mobile_skin", $conl['c_mobile_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">ADMIN 레이아웃<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_admin_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_ADMINSKIN_URL}/img/skin_admin1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('admin', ''.$i, "c_admin_skin", $conl['c_admin_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">회원가입 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_member_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_MEMBERSKIN_URL}/img/skin_join1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('member', ''.$i, "c_member_skin", $conl['c_member_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">로그인 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_login_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_LOGINSKIN_URL}/img/skin_login1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('login', ''.$i, "c_login_skin", $conl['c_login_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">폼메일 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_formmail_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_MAILSKIN_URL}/img/no_image.gif"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('formmail', ''.$i, "c_formmail_skin", $conl['c_formmail_skin']); ?></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="bo"><label for="">최신글 스킨<strong class="sound_only">필수</strong></label></th>
								<td colspan="3">
									<p>현재 적용된 스킨은 <strong>{_conl['c_latest_skin']}</strong>입니다.</p>
									<div class="skin_wrap">
										<img src="{MARI_LATESTSKIN_URL}/img/skin_latest1.jpg"  alt="" />
										<div class="txt_c mt10"><?php echo get_skin_select('latest', ''.$i, "c_latest_skin", $conl['c_latest_skin']); ?></div>
									</div>
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
						<th scope="bo"><label for="">에디터선택</label></th>
						<td colspan="3">
							<span class="frm_info">게시판, 웹사이트에서 사용할 에디터를 선택하세요.</span>
					                <select name="c_editor" id="c_editor">
							<?php
							$arr = get_skin_dir('', MARI_EDITOR_PATH);
							for ($i=0; $i<count($arr); $i++) {
							    if ($i == 0) echo "<option value=\"\">사용안함</option>";
							    echo "<option value=\"".$arr[$i]."\"".get_selected($config['c_editor'], $arr[$i]).">".$arr[$i]."</option>\n";
							}
							?>
							</select>
						</td>
					</tr>

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






