<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 정보입력
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{# header} 
<script type="text/javascript">

// 본인인증
	function cpPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
// I-Pin
	function fnPopup(){
		window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_ipin.target = "popupIPIN2";
		document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
		document.form_ipin.submit();
	}
</script>
<section id="container">
		<section id="sub_content">
			<div class="join_wrap">
				<div class="container">
					<h3 class="s_title2" style="text-align:center; ">회원가입</h3>
					<div class="join_auth1">
						<p>안전한 회원가입을 위해 본인 인증이 필요합니다.</p>
						<p>인증 후 회원가입이 가능합니다.</p>
					</div>
					<div class="join_auth2" style="width:100%; ">
						<img src="{MARI_MOBILESKIN_URL}/img/img_phone_auth.png" alt="" />
						<p>휴대폰<br/>본인 인증</p>
						<div>
							<!-- a href="javascript:cpPopup();">휴대폰 인증 받기</a -->
							<a href="{MARI_HOME_URL}/?mode=join0">휴대폰 인증 받기</a >
						</div>
					</div>
					
				</div><!--container!-->
			</div><!-- /join_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
	<form name="form_ipin" method="post">
	<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
	<input type="hidden" name="enc_data" value="<?= $sEncData ?>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	해당 파라미터는 추가하실 수 없습니다. -->
	<input type="hidden" name="param_r1" value="">
	<input type="hidden" name="param_r2" value="">
	<input type="hidden" name="param_r3" value="">
	<input type="hidden" name="agreement1" id="self_agr1" value="<?=$_POST[agreement1]?>">
	<input type="hidden" name="agreement2" id="self_agr2" value="<?=$_POST[agreement2]?>">
	</form>
	<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<?= $enc_data ?>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	    	 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="">
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
		<input type="hidden" name="agreement1" id="self_agr1" value="<?=$_POST[agreement1]?>">
		<input type="hidden" name="agreement2" id="self_agr2" value="<?=$_POST[agreement2]?>">
	</form>

<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
	 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>
	{# footer}