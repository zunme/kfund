<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 메인중앙
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
		<div class="title02">메일 테스트</div>

		<h2 class="h2_frm"><span>메일전송 테스트</span></h2>
		<div class="local_desc02">
			<p>
				 메일서버가 정상적으로 동작 중인지 확인할 수 있습니다.<br />
				아래 입력칸에 테스트 메일을 발송하실 메일 주소를 입력하시면, [메일검사] 라는 제목으로 테스트 메일을 발송합니다.<br />
			</p>
		</div>
		
		<div style="margin:40px 20px 40px 20px; ">
			<form name="" method="" action="">
				<fieldset>
					<legend>메일전송 테스트</legend>
					<label for="" class="mr10 fb">•받는 메일주소</label>
					<input type="text" name="" value="" id="email" " class="frm_input" size="50" />
					<input type="submit" value="" class="send_btn"  title="발송" />
				</fieldset>
			</form>
		</div>

		<div class="local_desc02">
			<p>
				만약 [메일검사] 라는 내용으로 테스트 메일이 도착하지 않는다면 보내는 메일서버 혹은 받는 메일서버 중 문제가 발생했을 가능성이 있습니다.<br />
				따라서 보다 정확한 테스트를 원하신다면 여러 곳으로 테스트 메일을 발송하시기 바랍니다.<br />
			</p>
		</div>


    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->







