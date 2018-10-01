<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 회원가입
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#new_header}
<?php
if( $_POST['join_agree_01'] !='Y' || $_POST['join_agree_01'] !='Y'){
  ?>
  <script>
  alert('이용약관 / 개인정보수집 에 동의하셔야 회원가입이 가능합니다.');
  location.replace("/pnpinvest/?mode=join01");
  </script>
  <?
  return;
}
?>
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
				<li>01 약관 동의</li>
				<li class="active">02 개인/기업</li>
				<li>03 본인 인증</li>
				<li>04 정보 입력</li>
				<li>05 가입 완료</li>
			</ul>
			<form method="post" name="joinform" action="">
        <input type="hidden" name="join_agree_01" value="Y">
        <input type="hidden" name="join_agree_02" value="Y">
			<fieldset>
				<div class="form_wrap">
					<h3 class="blind">개인 / 기업</h3>
					<div class="join_p_c clearfix">
						<p class="radiobox_2">
							<input id="join_p" type="radio" name="join_p_c" value="personal">
							<label for="join_p" class="join_p">일반 / 개인 회원</label>
						</p>
						<p class="radiobox_3">
							<input id="join_c" type="radio" name="join_p_c"  value="company">
							<label for="join_c" class="join_c">사업자 보유 회원</label>
						</p>
					</div>
				</div>
				<div class="btn_wrap"><a class="btn t5 f4 w300" id="form_ok" value="다음" href="javascript:;" onclick="joinnext()">다음</a></div>
			</fieldset>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
  function joinnext() {
    var selected = $("input:radio[name=join_p_c]:checked").val();
    if( selected=='personal'){
      $("form[name=joinform]").attr("action", "/pnpinvest/?mode=join02");
    }else if( selected=='company'){
      $("form[name=joinform]").attr("action", "/pnpinvest/?mode=join03_enterprise");
    }else{
      alert ("가입 회원 유형을 선택해주세요");
      return false;
    }
    $("form[name=joinform]").submit();
  }
</script>
{# new_footer}
