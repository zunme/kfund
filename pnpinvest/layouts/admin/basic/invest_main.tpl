<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 투자관리
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->



<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">투자관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title03"><span>투자관리</span></div>
		 <ul class="info1">
			<li>투자에 관련된 사항에 대해 일괄 관리합니다.</li>
			<li>결제, 출금, 충전, 매출 등을 관리합니다.</li>
		</ul>

		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>투자관리</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">투자현황</th>
						<td>투자현황을 확인하실 수 있으며 상품정보설정이 가능합니다.<a href="{MARI_HOME_URL}/?cms=invest_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">결제관리</th>
						<td> 결재내역을 확인하실 수 있으며 투자건에대한 정산이 가능합니다. <a href="{MARI_HOME_URL}/?cms=pay_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">투자/결제 설정</th>
						<td>투자가능한도, 연체이자, 상점수수료와 PG사결제설정을 하실 수 있습니다. <a href="{MARI_HOME_URL}/?cms=invest_pay_setup"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">출금신청</th>
						<td>출금신청 내역을 확인하실 수 있으며 일괄적으로 출금처리가 가능합니다. <a href="{MARI_HOME_URL}/?cms=withdrawal_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">충전내역</th>
						<td>e-머니 결제, 충전내역을 확인할 수 있습니다. <a href="{MARI_HOME_URL}/?cms=charge_list"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">매출리포트</th>
						<td>월별 일일 입찰,결제에대한 매출 현황을 확인할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=sales_report"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->