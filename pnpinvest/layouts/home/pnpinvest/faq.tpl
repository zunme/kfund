<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# header}

<script>
$(document).ready(function() {
    $(".tabs-menu a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});
</script>
<script>
	$(function(){
	    $(".answer").hide();
	    $(".question").click(function(){
		$(".answer:visible").slideUp("middle");
		$(this).next('.answer:hidden').slideDown("middle");
		return false;
	    })
	});
</script>

<div id="container">
	<div id="sub_content">
<!--	
			<div class="top_title1">
				<div class="top_title_inner">
					<h3 class="title5">자주 묻는 질문</h3>
					<p class="title_add1">&nbsp;</p>
					<p class="title_add2">투자, 대출, 계정에 대한 자주 묻는 질문과 답변을</p>
					<p class="title_add2">확인하실 수 있습니다.</p>

				</div>
			</div>
-->
		<div class="invest_section2_wrap faq">
			<div class="top_title1">
					<div class="top_title_inner">
						<h3 class="top_sub">키스톤펀딩 소식</h3>
						<p class="top_txt">키스톤펀딩의 다양한 소식을 전해드립니다.</p>
						<ul class="tab_btn1">
							<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항">공지사항</a></li>
							<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">언론보도</a></li>
							<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=faq">FAQ</a></li>
						</ul>
					</div>
				</div><!-- top_title1 -->
			<div class="invest_section2_1 ">
				<h3 class="add_subtitle">FAQ</h3>
				<div id="tabs-container">
								<ul class="tabs-menu faq">
									<li class="current col-xs-3"><a class="tab1_m" href="#tab-1">투자관련 FAQ</a></li>
									<li class="col-xs-3"><a class="tab1_m" href="#tab-2">대출관련FAQ</a></li>
									<li class="last col-xs-3"><a class="tab1_m" href="#tab-3">계정관련 FAQ</a></li>
								</ul>
								<div class="tab">
									
										
										<div id="tab-1" class="tab-content">
											<div class="part1">	
												<div class="faq">
													<?php	
														$sql = "select * from mari_faq where f_sort = '1' order by f_regidate desc";
														$f1 = sql_query($sql);
														for($i=0; $row=sql_fetch_array($f1); $i++){
													?>
														<p class="question">Q . <?php echo $row['f_question'];?></p>
														<ul class="answer">
															<li class="clr">
																A. <?php echo $row['f_answer'];?>
															</li>                        	  
														</ul>
													<?php
														}if($i==0)
															echo '질문리스트가 없습니다.';
													?>
												</div>						
											</div><!--//part1 e -->
										</div>
										<div id="tab-2" class="tab-content">
											<div class="part1">
												<div class="faq">
													<?php	
														$sql = "select * from mari_faq where f_sort = '2'";
														$f2 = sql_query($sql);
														for($i=0; $row=sql_fetch_array($f2); $i++){
													?>
												
													<p class="question">Q . <?php echo $row['f_question'];?></p>
													<ul class="answer">
														<li class="clr">
															A. <?php echo $row['f_answer'];?>
														</li>                        	  
													</ul>
												<?php
													}if($i==0)
														echo '질문리스트가 없습니다.';
												?>
												</div>									
											</div><!--//part1 e -->
										</div>
										<div id="tab-3" class="tab-content">
											<div class="part1">
												<div class="faq">
												<?php	
														$sql = "select * from mari_faq where f_sort = '3'";
														$f3 = sql_query($sql);
														for($i=0; $row=sql_fetch_array($f3); $i++){
												?>
													<p class="question">Q. <?php echo $row['f_question'];?></p>
													<ul class="answer">
														<li class="clr">
															A. <?php echo $row['f_answer'];?>
														</li>                        	  
													</ul>
												<?php
													}if($i==0)
														echo '질문리스트가 없습니다.';
												?>
												</div>										
											</div><!--//part1 e -->
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

{#footer}
