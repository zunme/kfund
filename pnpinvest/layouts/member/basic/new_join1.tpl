<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t3"><span class="motion" data-animation="flash">회원가입</span></h2>
	<!-- 케이펀딩 공지사항 -->
	<div class="join">
		<div class="container">
			<!-- 컨텐츠 본문 -->
			<p class="join_txt"><span>간편한 절차로 케이펀딩의 다양한 서비스를 제공받으세요.</span></p>
			<ul class="join_process clearfix">
				<li class="active">01 약관 동의</li>
				<li>02 개인/기업</li>
				<li>03 본인 인증</li>
				<li>04 정보 입력</li>
				<li>05 가입 완료</li>
			</ul>
			<form method="post" action="" name="join01form">
				<div class="form_wrap">
					<h3 class="subject">이용약관</h3>
					<div class="agree_wrap">
						<div class="tarea">
              <?php $config['c_stipulation']?>
							<?php include "css/con01.htm"?>
            </div>
						<p class="checkbox_wrap">
							<input id="join_agree_01" type="checkbox" name="join_agree_01" value="Y" required>
							<label for="join_agree_01">이용약관에 동의합니다.</label>
						</p>
					</div>
					<h3 class="subject">개인 정보 수집 및 이용 안내</h3>
					<div class="agree_wrap">
						<div class="tarea">
              <?php $config['c_privacy']?>
							<?php include "css/con02.htm"?>
            </div>
						<p class="checkbox_wrap">
							<input id="join_agree_02" type="checkbox" name="join_agree_02" value="Y" required>
							<label for="join_agree_02">개인 정보 수집 및 이용에 동의합니다.</label>
						</p>
					</div>
				</div>
				<div class="btn_wrap"><a class="btn t5 f4 w300" href="javascript:;" onClick="check_agree()">다음</a></div>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
  function check_agree() {
    if( $("input[name=join_agree_01]:checked").val() !='Y') {
      alert('이용약관 동의가 필요합니다.');return;
    };
    if( $("input[name=join_agree_02]:checked").val() !='Y') {
      alert('개인 정보 수집 및 이용 동의가 필요합니다.');return;
    };
    $("form[name=join01form]").attr('action','/pnpinvest/?mode=join00');
    $("form[name=join01form]").submit();
  }
</script>
{# new_footer}
