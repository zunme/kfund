<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#sub_header} 
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

<section id="container">
	<section id="sub_content">
		<div class="m_cont2">	
			<div class="container" >
				<p class="m_txt4" style="color:#009aff; ">자주 하는 질문</p>
				<div class="faq_wrap">
					<dl class="faq_cont1">
						<?php for($i=0; $row=sql_fetch_array($qna); $i++){ ?>
							<dt>Q. <?php echo $row['f_question'];?><span>∨</span></dt>
							<dd>A. <?php echo $row['f_answer'];?></dd>
						<?php } if($i==0){ ?>
							<dt>현재 등록된 Q&A리스트가 없습니다.</dt>
						<?php }?>
					</dl><!-- /faq_cont1 -->
				</div><!-- /faq_wrap -->
			</div>
		</div>	
	</section>
</section>

{# footer}<!--하단-->