<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#header} 
<script>
$(function(){
	var guide=$("ul.guide_view").bxSlider({
		mode:"fade",
		speed:1200,
		pager:false,
		moveSlides:1,
		minSlides:1,
		maxSlides:12,
		slideMargin:0,
		autoHover:true,
		controls:true
	})
});
</script>
<section id="container">
	<section id="sub_content">
		<div class="m_cont2">	
			<div class="container">
				<div style="padding:25px 0 0 0; ">
					<h3 class="s_title2 txt_c">{_config['c_title']}!<br/>손쉽고<br/>간단한 투자가이드!</h3>
					<p class="m_txt7">지금 바로 따라해보세요</p>
				</div>
			</div>			
			<div class="container guide4 txt_c">
						<ul class="guide_view">
							<li><a href="{MARI_HOME_URL}/?mode=join3"><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page.png" style="margin:0 auto; display:block;" alt=""/></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage"><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page02.png" style="margin:0 auto; display:block;" alt=""/></a></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page03.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page04.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page05.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page06.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page07.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page08.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page09.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page10.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page11.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page12.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page13.png" style="margin:0 auto; display:block;" alt=""/></li>
							<li><img src="{MARI_MOBILESKIN_URL}/img/mobile_invest_guide_page14.png" style="margin:0 auto; display:block;" alt=""/></li>
						</ul>	
			</div>

			<div class="container guide5 txt_c">
				<h4>대출하기</h4>
				<div style="padding:25px 0 0 0; ">
					<h3 class="s_title2 txt_c">{_config['c_title']}!<br/>안전하고 간편한 <br/> 대출 시스템</h3>
					<p class="m_txt7">합리적인 금리로 더욱 많은 분들께<br/>도움을 드립니다. </p>
				</div>
				<h5>STEP 1</h5>
				<h5>대출 심사 단계</h5>
					<ul>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step2.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step3.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step4.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step5.png" alt="대출 진행"></li>

					</ul>
				
				<h5>STEP 2</h5>
				<h5>투자진행 단계</h5>
					<ul>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step6.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step7.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step8.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step9.png" alt="대출 진행"></li>
					</ul>
				<h5>STEP 3</h5>
				<h5>투자관리 단계</h5>
					<ul>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step10.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step11.png" alt="대출 진행"></li>

					</ul>
				<h5>STEP 4</h5>
				<h5>투자상환 단계</h5>
					<ul>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step12.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step13.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step15.png" alt="대출 진행"></li>
						<li><img src="{MARI_MOBILESKIN_URL}/img/img_loan_step14.png" alt="대출 진행"></li>
					</ul>
			</div>
		</div>	
	</section>
</section>
{# footer}<!--하단-->