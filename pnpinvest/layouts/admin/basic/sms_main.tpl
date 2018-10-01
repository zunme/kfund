<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN SMS관리
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->



<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">SMS관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title03"><span>SMS 관리</span></div>
		 <ul class="info1">
			<li>SMS에 관한 사항을 일괄 관리합니다.</li>
		</ul>

		<!-- <h4 class="t_tite1"><span></span></h4> -->
		<div class="tbl_wrap2">
			<table class="type1">
				<caption>SMS관리</caption>
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">SMS 관리</th>
						<td>80 byte 단문 문자를 간편하게 전송하고 전송결과를 확인할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=sms_manage&type=book"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">LMS 관리</th>
						<td>1500 byte 장문 문자를 간편하게 전송하고 전송결과를 확인할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=lms_manage&type=book"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">SMS 그룹관리</th>
						<td>전화번호의 그룹을 설정하실 수 있습니다.<a href="{MARI_HOME_URL}/?cms=sms_group"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">SMS 전화번호관리</th>
						<td>전화번호부를 설정하실 수 있으며 회원의 전화번호를 불러와 SMS를 간편하게 발송할 수 있도록 설정이 가능합니다.<a href="{MARI_HOME_URL}/?cms=sms_book"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">SMS 설정</th>
						<td>SMS 계정과 대출,투자자 거래에대한 SMS자동발송 설정이 가능합니다.<a href="{MARI_HOME_URL}/?cms=sms_setup"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">SMS 신청</th>
						<td>SMS 충전서비스를 신청할 수 있습니다.<a href="javascript:popup('http://way21.co.kr/pay/sms_order.php?cid=<?=$config[c_sms_id]?>',500,600)"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
					<tr>
						<th scope="row">SMS/LMS 푸시</th>
						<td>등급별로 회원에게 SMS, LMS 문자를 다량예약 발송할 수 있습니다.<a href="{MARI_HOME_URL}/?cms=reservation_send"><img src="{MARI_ADMINSKIN_URL}/img/shortcut_btn.png" alt="바로가기"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->