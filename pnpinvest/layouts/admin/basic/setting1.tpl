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
						<td><?php echo $sv['ftp_host']; ?> </td>
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
						<td><?php echo $sv['mysql_db']; ?></td>
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
	<input type="hidden" name="type" value="setting1"/>
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






