<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header}<!--상단-->
	
<section id="container">
	<section id="sub_content">
		<div class="guide_wrap">
			<div class="container pt20">
	<div class="terms_wrap">
		<ul class="tab_btn2">
			<li class=" col-xs-5 no_pl no_pr"><a href="{MARI_HOME_URL}/?mode=common2">이용약관</a></li>
			<li class=" col-xs-3 no_pl no_pr"><a href="{MARI_HOME_URL}/?mode=common1">개인정보처리 방침</a></li>
			<li class="tab_on2 col-xs-5 no_pl no_pr"><a href="{MARI_HOME_URL}/?mode=common3">투자약관</a></li>	
		</ul>
	
		<div class="invest_lst_cont1 container pt20 pb20 col-xs-12">
			<?php echo $conf[c_auto_dangerous];?>
		</div>
	</section>
	<!--//sub_content e -->
</section>
<!--//container e -->

{#footer}