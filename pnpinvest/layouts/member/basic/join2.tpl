<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 본인인증
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#header} 

<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
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

	<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<h3 class="title2_1">{_config['c_title']}회원가입</h3>
						<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>-->
						<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="join_wrap">
					<div class="join_step">
						<ul>
							<li class="current"><p>본인인증</p></li>
							<li><p>정보입력</p></li>
							<li><p>가입완료</p></li>
						</ul>
					</div>
					
					<div class="join_section3">
						<div class="certification_box">
							<div class="certification_box_inner">
								<h4>휴대폰으로 인증하기</h4>
								<div class=""><img src="{MARI_HOMESKIN_URL}/img/certification_bg1.png" alt="" /></div>
								<p>인증기관을 통해 본인 인증을 하실 수 있습니다.</p>

								<div class=""><a href="javascript:cpPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_phone.png" alt="휴대폰으로 인증하기" /></a></div>

							</div><!-- /certification_box_inner -->
						</div><!-- /certification_box -->
						<div class="certification_box">
							<div class="certification_box_inner">
								<h4>아이핀으로 인증하기</h4>
								<div><img src="{MARI_HOMESKIN_URL}/img/certification_bg2.png" alt="" /></div>
								<p>인증기관을 통해 본인 인증을 하실 수 있습니다.</p>
								<div><a href="javascript:fnPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_ipin.png"   alt="아이핀으로 인증하기" /></a></div>
							</div><!-- /certification_box_inner -->
						</div><!-- /certification_box -->
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
					</div><!-- /join_section3 -->

					<div class="join_section4">
						<p>개정 정보통신망법 시행('12.8.18)에 따라 <br/>홈페이지 내에서 주민등록번호 수집이 불가합니다.</p>
					</div>

					<div class="btn_wrap7">
						<a href="{MARI_HOME_URL}/?mode=join02"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" /></a>
						<!--<a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_next1.png" alt="다음" id="member_form_add" style="cursor:pointer; float:right;"/></a>-->
					</div>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->


	    
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
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->



{#footer}<!--하단-->
<? }else{ ?>
{#header_sub} 

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

	<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<!--<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
						<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>
						<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>-->
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="join_wrap">
					<div class="join_step">
						<ul>
							<li class="current"><p>본인인증</p></li>
							<li><p>정보입력</p></li>
							<li><p>가입완료</p></li>
						</ul>
					</div>
					
					<div class="join_section3">
						<div class="certification_box  fl_l">
							<div class="certification_box_inner">
								<h4>휴대폰으로 인증하기</h4>
								<div class=""><img src="{MARI_HOMESKIN_URL}/img/certification_bg1.png" alt="" /></div>
								<p>인증기관을 통해 본인 인증을 하실 수 있습니다.</p>

								<div class=""><a href="javascript:cpPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_phone.png" alt="휴대폰으로 인증하기" /></a></div>

							</div><!-- /certification_box_inner -->
						</div><!-- /certification_box -->
						<div class="certification_box fl_r">
							<div class="certification_box_inner">
								<h4>아이핀으로 인증하기</h4>
								<div><img src="{MARI_HOMESKIN_URL}/img/certification_bg2.png" alt="" /></div>
								<p>인증기관을 통해 본인 인증을 하실 수 있습니다.</p>
								<div><a href="javascript:fnPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_ipin.png"   alt="아이핀으로 인증하기" /></a></div>
							</div><!-- /certification_box_inner -->
						</div><!-- /certification_box -->
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
					</div><!-- /join_section3 -->

					<div class="join_section4">
						<p>개정 정보통신망법 시행<br />
						('12.8.18)에 따라 홈페이지 내에서 주민등록번호 수집이 불가합니다.</p>
					</div>

					<div class="txt_l">
						<a href="{MARI_HOME_URL}/?mode=join1"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" /></a>
						<!--<a href="{MARI_HOME_URL}/?mode=join3&type=join" class="ml5"><img src="{MARI_HOMESKIN_URL}/img/btn_next1.png" alt="다음" /></a>-->
					</div>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->


	    
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
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->

 {#footer}<!--하단-->
 <?php } ?>
 
