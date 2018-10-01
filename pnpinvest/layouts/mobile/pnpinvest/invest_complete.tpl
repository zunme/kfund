	
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 투자신청서 확인
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header}<!--상단-->
<section id="container">
		<section id="sub_content">
			<div class="mypage_wrap">
				<div class="my_inner6">
					<h3 class="s_title1">투자신청</h3>
					 <h4 class="m_title3"><strong>투자가 완료되었습니다.<br/> 감사합니다.</strong></h4>
						<p class="" style="text-align:center;margin-top:10px;">
							<span><?php echo $user['m_name'];?></span>
							<span class="color_re"><?php echo $loan_id;?> : <?php echo $complete['i_invest_name'];?></span>
							<span class="color_re">채권 <?php echo unit($i_pay) ?> 만원</span>
						</p>
						<p class="" style="text-align:center">* 투자내역은 마이페이지에서 확인하실 수 있습니다.</p>
						<div class="info_wrap">
						<div class="my_btn_wrap4 mt50 mb50">
							<a href="{MARI_HOME_URL}/?mode=main"><img src="{MARI_MOBILESKIN_URL}/img/btn_ok.png" alt="투자신청 완료" class="col-xs-12 mb50" /></a>							
						</div>
					</div><!-- /info_wrap -->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->
 





