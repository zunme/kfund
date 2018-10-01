<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 서브페이지 리얼타임
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<?php if($mode=="main" && $config['c_mainrealtime_use']=='Y'){?>
<!--리얼타임 데이타-->
	<div class="realtime_wrap">
		<div class="realtime1" id="realtime1"  style="display:none;">
			<h4 class="realtime_title1">REAL TIME <span>anatrits</span></h4>
			<div class="realtime1_inner">
				<div class="dv_rolling">
					<ul class="realtime_lst2">
					<?php if($realtimeitem_display_01=="Y"){?>
						<?php
						    for ($i=0; $row=sql_fetch_array($realinvest); $i++) {
						?>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img/real_sort3.png" alt="투자" />
									<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo cate_name($row['i_goods'],1);?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['m_name']);?>님<?php }?> 입찰 완료</a>
									<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
								</li>
						<?php }?>
					<?php }?>
					<?php if($realtimeitem_display_02=="Y"){?>
						<?php
						    for ($i=0; $row=sql_fetch_array($realloan); $i++) {
						?>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img/real_sort2.png" alt="대출" />
									<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['i_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo cate_name($row['i_payment'],1);?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['m_name']);?>님<?php }?> 대출</a>
									<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
								</li>
						<?php }?>
					<?php }?>
					<?php
					    for ($i=0; $row=sql_fetch_array($realorder); $i++) {
					?>
						<?php if($row['o_status']=="입금완료" && $realtimeitem_display_03=="Y"){?>
							<li>
								<img src="{MARI_HOMESKIN_URL}/img/real_sort1.png" alt="입금완료" />
								<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['user_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 입금 완료</a>
								<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_datetime'],0,10); ?></span><?php }?>
							</li>
						<?php }else if($row['o_salestatus']=="정산완료" && $realtimeitem_display_04=="Y"){?>
							<li>
								<img src="{MARI_HOMESKIN_URL}/img/real_sort4.png" alt="정산완료" />
								<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['sale_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 정산 완료</a>
								<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_collectiondate'],0,10); ?></span><?php }?>
							</li>
						<?php }?>
					<?php }?>


					</ul>
				</div>
			</div><!-- realtime1_inner -->
			<div class="close_btn2"><a href="javascript:click_btns('realtime2')"><img src="{MARI_HOMESKIN_URL}/img/btn_close2.png" alt="닫기" /></a></div>
		</div><!-- /realtime1 -->
		<div class="realtime2" id="realtime2">
			<div class="open_btn2"><a href="javascript:click_btns('realtime1')"><img src="{MARI_HOMESKIN_URL}/img/btn_open2.png" alt="REAL TIME MONEY PLUS 열기" /></a></div>
		</div>
	</div><!-- /realtime_wrap -->
<?php }else{?>
  <script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery.vticker-min.js"></script>
  <script>
			$(function(){  
				$('.dv_rolling').vTicker({
					// 스크롤 속도(default: 700)  
					speed: {_config['c_realtime_speed']},  
					// 스크롤 사이의 대기시간(default: 4000)  
					pause: {_config['c_realtime_pause']},  
				   // 스크롤 애니메이션  
					animation: 'fade',  
					// 마우스 over 일때 멈출 설정  
					mousePause: true,  
					// 한번에 보일 리스트수(default: 2)  
					showItems: 9,  
					// 스크롤 컨테이너 높이(default: 0)  
					height: 388,  
					// 아이템이 움직이는 방향, up/down (default: up)  
					direction: 'up'  
				});  
			});  
</script>
<!--리얼타임 데이타-->
	<div class="realtime_wrap">
		<div class="realtime1" id="realtime1"  style="display:none;">
			<h4 class="realtime_title1">REAL TIME <span>anatrits</span></h4>
			<div class="realtime1_inner">
				<div class="dv_rolling">
					<ul class="realtime_lst2">
					<?php if($realtimeitem_display_01=="Y"){?>
						<?php
						    for ($i=0; $row=sql_fetch_array($realinvest); $i++) {
						?>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img/real_sort3.png" alt="투자" />
									<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo cate_name($row['i_goods'],1);?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['m_name']);?>님<?php }?> 입찰 완료</a>
									<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
								</li>
						<?php }?>
					<?php }?>
					<?php if($realtimeitem_display_02=="Y"){?>
						<?php
						    for ($i=0; $row=sql_fetch_array($realloan); $i++) {
						?>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img/real_sort2.png" alt="대출" />
									<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['i_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo cate_name($row['i_payment'],1);?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['m_name']);?>님<?php }?> 대출</a>
									<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
								</li>
						<?php }?>
					<?php }?>
					<?php
					    for ($i=0; $row=sql_fetch_array($realorder); $i++) {
					?>
						<?php if($row['o_status']=="입금완료" && $realtimeitem_display_03=="Y"){?>
							<li>
								<img src="{MARI_HOMESKIN_URL}/img/real_sort1.png" alt="입금완료" />
								<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['user_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 입금 완료</a>
								<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_datetime'],0,10); ?></span><?php }?>
							</li>
						<?php }else if($row['o_salestatus']=="정산완료" && $realtimeitem_display_04=="Y"){?>
							<li>
								<img src="{MARI_HOMESKIN_URL}/img/real_sort4.png" alt="정산완료" />
								<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),14,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['sale_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 정산 완료</a>
								<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_collectiondate'],0,10); ?></span><?php }?>
							</li>
						<?php }?>
					<?php }?>


					</ul>
				</div>
			</div><!-- realtime1_inner -->
			<div class="close_btn2"><a href="javascript:click_btns('realtime2')"><img src="{MARI_HOMESKIN_URL}/img/btn_close2.png" alt="닫기" /></a></div>
		</div><!-- /realtime1 -->
		<div class="realtime2" id="realtime2">
			<div class="open_btn2"><a href="javascript:click_btns('realtime1')"><img src="{MARI_HOMESKIN_URL}/img/btn_open2.png" alt="REAL TIME MONEY PLUS 열기" /></a></div>
		</div>
	</div><!-- /realtime_wrap -->
<?php }?>

