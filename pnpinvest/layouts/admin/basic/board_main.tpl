<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 게시판관리
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->



<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">게시판관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title03"><span>게시판관리</span></div>
		 <ul class="info1">
			<li>사이트의 게시판을 생성, 수정, 설정 하실 수 있습니다.</li>
			<li>게시판에 관련된 사항에 대해 일괄 관리합니다.</li>
		</ul>

		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>게시판관리</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">게시판관리</th>
						<td>사이트에 게시판을 생성, 수정, 삭제 할 수 있습니다.  <a href="{MARI_HOME_URL}/?cms=board_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">게시판그룹관리</th>
						<td>사이트의 게시판을 그룹별로 관리할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=boardgroup_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->