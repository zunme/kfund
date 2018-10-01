<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#new_header}
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
				<li>02 개인/기업</li>
				<li>03 본인 인증</li>
				<li>04 정보 입력</li>
				<li class="active">05 가입 완료</li>
			</ul>
			<div class="join_ok">
				<strong class="title01">회원가입 완료</strong><br>
				<span class="txt01">케이펀딩에 가입해주셔서 감사합니다.</span>
				<div>
					<strong class="title02">환영합니다!</strong>
					<p class="txt02"><span class="line"><?php echo($user['m_name'])?></span>님, 가입을 진심으로 환영합니다.<br>
					수입성 높은 투자상품과 정직한 대출 시스템으로<br>
					언제나 최고의 만족을 드리는 케이펀딩이 되겠습니다.<br><br>
					예치금 충전과 투자를 위해서 가상계좌 발급이 필요합니다.<br>
					바로 가상계좌를 발급 받으러 가시겠습니까?</p>
					<a href="/pnpinvest/?mode=mypage_certification" class="btn t1">가상계좌 발급 받으러 가기</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{#new_footer}
