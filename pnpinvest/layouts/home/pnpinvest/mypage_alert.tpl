<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
<div id="container">
	<div id="sub_content">
		<div class="mypage" >
			<div class="mypage_inner">

				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							<!---->
						</div>

						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>알림메세지</span></h3>
							<div class="dashboard_alert">
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 알림메세지</h3>
								<span>새 소식을 한눈에 알아보세요</span>
								
								<div>
									<ul>
									<?php 
										for ($i=0; $row=sql_fetch_array($push_list); $i++) {
									?>
										<li><span class="deteil_alert_msg"><?php echo $row['pm_msg']?></span><span><?php echo $row['pm_msg_title']?></span><span class="date"><?php echo substr($row['pm_redatetime'],0,10)?></span></li>

									<?php
									}
									if ($i == 0)
										echo "<li>내역이 없습니다.</li>";
									?>
									</ul>
								</div>
							</div><!--dashboard_interest-->
						</div>
					</div>
				</div>	
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}