<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# header_sub} 

<!--tabmenu-->
<script>
$(document).ready(function() {
	//대출하기-대출이용안내 클릭 후 페이지 이동시 대출이용안내 TAB addclass current
	var loan_guide = "<?php echo $loan_guide;?>";
	if(loan_guide){
		$(".invest_guide").removeClass("current");
		$(".loan_guide").addClass("current");
		$("#tab-2").css("display","block");
		$("#tab-1").css("display","none");
		
	}

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
<!--다른방법으로 주석<script>
	$(function(){
	    $(".answer").hide();
	    $(".question").click(function(){
		/*$('.question').css({'background-color':'#fff','color':'#222;'});
		$(this).css({'background-color':'#3662ae','color':'#fff;'});*/
		$(".answer:visible").slideUp("middle");
		$(this).next('.answer:hidden').slideDown("middle");
		return false;
	    })
	});
</script>-->
<!--자주하는 질문 Q&A -->
<script>
	$(function(){
		$(".answer").hide();
		$(".question").click(function(e){
			  e.preventDefault();

			  if($(this).next().css("display") == "none"){
				   $(".answer").slideUp();
				   $(".question").removeClass('current');
				   $(this).next().slideDown();
				    $(this).addClass('current');
			  }else{
				  $(this).next().slideUp();
				  $(this).removeClass('current');
			  }
		 })
	});
</script>
<script>
    $(document).on('click','.tab1_m',function () {
        console.log('on');
        $(".answer").hide();
        $('.question').css({ 'background-color': '#fff', 'color': '#222;' });
    });
</script>


<div id="container">
	<div id="sub_content">
		<div class="top_title1">
			<div class="top_title_inner">
				<!--<img src="{MARI_HOMESKIN_URL}/img2/title_icon.png" alt="" />-->
				<h3 class="top_sub">키스톤펀딩 이용안내</h3>
				<p class="top_txt">키스톤펀딩 이용이 처음이신가요? 초보자 분들도 쉽게 이용하실 수 있습니다.</p>
				<ul class="tabs-menu">
					<li class="invest_guide current "><a class="tab-1_m" href="#tab-1">투자이용안내</a></li>
					<li class="col-xs-3"><a class="tab1_m" href="#tab-4">출금이용안내</a></li>
					<li class="col-xs-3 loan_guide"><a class="tab1_m" href="#tab-2">대출이용안내</a></li>
				</ul>
			</div>
		</div><!-- top_title1 -->
		<div class="invest_section2_wrap">
			<div class="invest_section2_1 guide_invest" >
				<div id="tabs-container ">
					<!--<ul class="tabs-menu">
						<li class="current "><a class="tab-1_m" href="#tab-1">투자가이드</a></li>
						<li class="col-xs-3"><a class="tab1_m" href="#tab-4">출금가이드</a></li>
						<li class="col-xs-3"><a class="tab1_m" href="#tab-2">대출가이드</a></li>
						<li class="col-xs-3"><a class="tab1_m" href="#tab-3">자주하는 질문</a></li>
					</ul>-->
						{#guide_content}	
				</div>
			</div><!--//invest_section2 e -->
		</div><!--//invest_section2_wrap e -->
	</div><!--//sub_content e -->
</div><!--//container e -->

{#footer}