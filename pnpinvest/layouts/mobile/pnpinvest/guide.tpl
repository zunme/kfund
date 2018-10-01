<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>


<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>

{#header}			

<section id="container">
	<section id="sub_content">

		<div class="customer_wrap">
			<div class="container">
				<div class="guide">
					<div class="guide_inner">
						<div id="tabs-container">
							<div class="tab2">
								<div id="tab-1" class="tab-content2">
									<div class="qna_list">
										<ul>
											<li <?php if(!$sort || $sort=="invest"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=invest">투자 관련 FAQ</a></li>
											<li <?php if($sort=="loan"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=loan">대출 관련 FAQ</a></li>
											<li <?php if($sort=="base"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=base">계정관련 FAQ</a></li>
										</ul>
									<div class="qna">
										<div class="faq_wrap">
											<dl class="faq_cont1">						
												<?php 
												for($i=0; $row=sql_fetch_array($ff); $i++){ 
													?>
														<dt>Q. <?php echo $row['f_question'];?><span>∨</span></dt>
														<dd>A. <?php echo $row['f_answer'];?></dd>
													<?php }
												if($i==0) echo '내용없음';
												?>
											</dl><!-- /faq_cont1 -->
										</div><!-- /faq_wrap -->	
									</div><!-- /qna -->
								</div><!-- /qna_list -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- /mypage_wrap -->
	</section><!-- /sub_content -->
</section><!-- /container -->




<?}else{?>

<script>
$(document).ready(function() {
    $(".tabs-menu2 a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content2").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});
</script>
{#header}	
<div id="container">
	<div id="sub_content">
		<div class="guide">
			<div class="guide_inner">
				<div id="tabs-container">
					<div class="tab2">
						<div id="tab-1" class="tab-content2">
							<div class="qna_list">
								<ul>
									<li <?php if(!$sort || $sort=="invest"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=invest">투자 관련 FAQ</a></li>
									<li <?php if($sort=="loan"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=loan">대출 관련 FAQ</a></li>
									<li <?php if($sort=="base"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=base">계정관련 FAQ</a></li>
                                                             <!-- <li <?php if($sort=="point"){?>class="now"<?php }else{}?>><a href="{MARI_HOME_URL}/?mode=guide&sort=point">포인트관련 FAQ</a></li>-->
								</ul>
								<div class="qna">
									<div class="faq_wrap">
										<dl class="faq_cont1">						
										<?php 
											for($i=0; $row=sql_fetch_array($ff); $i++){ 
										?>
										<dt>Q. <?php echo $row['f_question'];?><span>∨</span></dt>
										<dd><span style="display:inline-block">A.<?php echo $row['f_answer'];?></span> </dd>
										<?php }
											if($i==0) echo '내용없음';
										?>
										</dl><!-- /faq_cont1 -->
									</div><!-- /faq_wrap -->	
								</div><!-- /qna -->
							</div><!-- /qna_list -->
						</div>
					</div>		
			</div>
			<!--//invest_section2 e -->
		</div>
		<!--//invest_section2_wrap e -->
	</div>
	<!--//sub_content e -->
</div>
<!--//container e -->


<?}?>

{# footer}<!--하단-->

<script type="text/javascript">
		$( document ).ready( function() {
			$(".faq_cont1 dd:not(:first)").css("display", "none");
			$(".faq_cont1 dt").click(function(){
				if($("+dd", this).css("display") == "none"){
					$("dd").slideUp();
					$("+dd", this).slideDown();
				}
			});
		});
	  </script>