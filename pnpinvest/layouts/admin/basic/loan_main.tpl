<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 대출관리
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->



<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title03"><span>대출관리</span></div>
		 <ul class="info1">
			<li>대출접수 정보 및 내용을 확인할 수 있습니다.</li>
			<li>투자진행 설정, 대출현황에 대해 일괄관리합니다.</li>
		</ul>

		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>대출관리</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">대출현황</th>
						<td>대출접수 정보를 확인하실 수 있으며 상품에대한 거래가 완료시 입금및 정산이 가능합니다.<a href="{MARI_HOME_URL}/?cms=loan_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">투자진행 설정</th>
						<td>사용자화면에서 대출상품의 투자진행시 세부정보를 설정하실 수 있습니다.  <a href="{MARI_HOME_URL}/?cms=invest_setup_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->