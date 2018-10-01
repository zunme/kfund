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
		<div class="title02">SNS/메일수신설정</div>
			<fieldset>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="setting4"/>
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
						페이스북 로그인 기타 SNS 서비스등을 설정하실 수 있습니다.(var 2.4)
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
							<input type="text" name="c_facebook_appid" value="<?php echo $conl['c_facebook_appid'];?>" id=" " size="40" class="frm_input">
							<a href="https://developers.facebook.com/apps" target="_blank">
								<img src="{MARI_ADMINSKIN_URL}/img/app_btn.png" alt="앱등록하기" />
							</a>
						</td>
						<th scope="bo"><label for=" ">페이스북 앱 SECRET</label></th>
						<td>
							<input type="text" name="c_facebook_secret" value="<?php echo $conl['c_facebook_secret'];?>" id=" " size="40" class="frm_input">
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for=" ">페이스북로그인 사용여부</label></th>
						<td colspan="3">
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






