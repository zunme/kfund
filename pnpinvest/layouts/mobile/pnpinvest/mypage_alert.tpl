<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 
<script>

		$(function(){
		    $(".alert_msg_content").hide();
		    $(".alert_msg_title").click(function(){
			$(".alert_msg_content:visible").slideUp("middle");
			$(this).next('.alert_msg_content:hidden').slideDown("middle");
			return false;
		    })

		});
</script>
<section id="container">
		<section id="sub_content">
				<div class="container">
					<div class="dashboard_my_info">
						<h3><span>알림메세지</span></h3>
						<div class="dashboard_alert">
							<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 알림메세지</h3>
							<span>새 소식을 한눈에 알아보세요</span>

									<div class="">
										<p class="alert_msg_title"><span>회원님이 선택하신 관심상품의 상태가 변경 되었습니다!</span><span class="date">06.10.11</span></p>
										<ul class="alert_msg_content">
											<li class="clr"><span class="detail_alert_msg">이것은 자세한 메세지이다 더 많은 내용을 볼 수 있는 공간이지.</span></li>                        	  
										</ul>	
										<p class="alert_msg_title"><span>회원님이 선택하신 관심상품의 상태가 변경 되었습니다! </span><span class="date">06.10.11</span></p>
										<ul class="alert_msg_content">
											<li class="clr"><span class="detail_alert_msg">이것은 자세한 메세지이다 더 많은 내용을 볼 수 있는 공간이지.</span></li>                        	  
										</ul>											
									</div>
						</div><!--dashboard_interest-->
					</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->