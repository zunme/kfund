<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 플러그인
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->



<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">플러그인/위젯</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title03"><span>플러그인/위젯</span></div>
		 <ul class="info1">
			<li>소셜네트워크(SNS), 네이버 애널리틱스, 위젯을 관리합니다.</li>
		</ul>


		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>플러그인/위젯</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">소셜네트워크(SNS)</th>
						<td> 페이스북 로그인, 기타 SNS 서비스 등을 설정할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=sns"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">네이버 에널리틱스</th>
						<td>사이트 로그분석 현황을 실시간으로 확인할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=analytics"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">최신글 위젯</th>
						<td>최신글을 노출할 수 있도록 위젯코드를 생성하실 수 있습니다. <a href="{MARI_HOME_URL}/?cms=latest"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->