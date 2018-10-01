<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 환경설정
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
		<div class="title03"><span>환경설정</span></div>
		 <ul class="info1">
			<li>사이트의 환경을 설정할 수 있습니다.</li>
			<li>게시판, 레이아웃, 회원가입, 소셜네트워크(SNS) 등을 설정합니다.</li>
		</ul>

		<div class="tbl_wrap2">
			<h2>기본환경 설정</h2>
			<table class="type1">
				<caption>환경설정</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">SERVER 정보</th>
						<td>홈페이지 SERVER 정보 확인과 FTP접속 바로가기를 할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting1#server_info"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">홈페이지 기본환경 설정</th>
						<td>관리자, 관리자 메일을 표시하고 접근가능 IP, 접근차단IP, 단어 필터링을 설정할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting1#anc_cf_basic"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<?php if($user[m_id]=="webmaster@admin.com"){?>
					<tr>
						<th scope="row">레이아웃 및 스킨 설정</th>
						<td>사이트의 레이아웃과 스킨을 설정할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting2#anc_cf_join"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">게시판 기본 설정</th>
						<td>페이지표시수, 페이지당 리스트수, 파일 업로드 확장자, 단어필터링을 설정할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting2#anc_cf_board"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<?php }?>
					<tr>
						<th scope="row">회원가입 설정</th>
						<td>회원가입 시 입력받을 정보와 약관을 설정할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=setting3#anc_cf_join"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">본인확인 설정</th>
						<td>회원가입 시 본인확인 수단을 설정합니다.<a href="{MARI_HOME_URL}/?cms=setting4#anc_cf_cert"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">기본 메일 환경 설정</th>
						<td>전체 메일발송 사용여부를 설정할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting4#anc_cf_mail"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">게시판 글 작성시 메일 설정</th>
						<td>게시판 글 작성시 알림 메일 발송 여부를 설정합니다.<a href="{MARI_HOME_URL}/?cms=setting4#anc_cf_article_mail"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">회원가입 시 메일 설정</th>
						<td>회원가입시 발송할 메일 설정을 할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting4#anc_cf_join_mail"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">소셜네트워크(SNS) 설정</th>
						<td>페이스북 로그인 기타 SNS 서비스등을 설정할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=setting4#anc_cf_sns"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->