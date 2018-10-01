<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 회원관리
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
		<div class="title03"><span>회원관리</span></div>
		 <ul class="info1">
			<li>사이트에 가입된 회원 정보를 보실 수 있습니다.</li>
			<li>회원등급, 탈퇴 및 복구, e-머니, 메일발송 등에 대해 관리합니다.</li>
		</ul>

		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>회원관리</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회원목록</th>
						<td> 사이트에 가입한 회원들을 일괄 관리합니다.  <a href="{MARI_HOME_URL}/?cms=member_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">회원등급</th>
						<td>가입한 회원들의 등급을 설정 할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=member_grade"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">탈퇴회원&복구</th>
						<td>회원의 탈퇴및 복구를 관리합니다. <a href="{MARI_HOME_URL}/?cms=leave_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">e-머니관리</th>
						<td>회원의 e-머니를 관리할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=emoney_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">회원메일발송</th>
						<td>수신동의한 회원에게 메일을 발송할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=mail_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">로그분석</th>
						<td>사이트의 상세 접속로그와 매출리포트를 확인하실 수 있습니다. <a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<!--
					<tr>
						<th scope="row">메일테스트</th>
						<td>테스트 메일을 발송할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=sendmail_test"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					-->
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->

{# s_footer}<!--하단-->