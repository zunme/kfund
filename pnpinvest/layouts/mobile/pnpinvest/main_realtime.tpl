<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 메인페이지 리얼타임
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
				<div class="m_section2_1">
					<div class="m_section2_1_inner">
						<div class="realtime_cont1">
							<!-- <h4>REAL TIME<br /> Money Plus</h4>
							<p>실시간으로 확인하세요!</p> -->
							<img src="{MARI_MOBILESKIN_URL}/img/real_time_title1.png" alt="REAL TIME Status" />
						</div>
						<div class="realtime_cont2">
							<div class="realtime_cont2_inner">
								<div id="dv_rolling">
									<ul class="realtime_lst1">
									<?php if($realtimeitem_display_01=="Y"){?>
										<?php
										    for ($i=0; $row=sql_fetch_array($realinvest); $i++) {
										?>
												<li>
													<img src="{MARI_MOBILESKIN_URL}/img/realtime_sort1.png" alt="투자" />
														<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['i_goods'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),25,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row[m_name]);?>님<?php }?> 입찰 완료</a>
														<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
												</li>
										<?php }?>
									<?php }?>
									<?php if($realtimeitem_display_02=="Y"){?>
										<?php
										    for ($i=0; $row=sql_fetch_array($realloan); $i++) {
										?>
												<li>
													<img src="{MARI_MOBILESKIN_URL}/img/realtime_sort4.png" alt="대출" />
													<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['i_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['i_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['i_subject']),25,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['m_name']);?>님<?php }?> 대출</a>
													<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['i_regdatetime'],0,10); ?></span><?php }?>
												</li>
										<?php }?>
									<?php }?>
									<?php
									    for ($i=0; $row=sql_fetch_array($realorder); $i++) {
									?>
										<?php if($row['o_status']=="입금완료" && $realtimeitem_display_03=="Y"){?>
											<li>
												<img src="{MARI_MOBILESKIN_URL}/img/realtime_sort2.png" alt="입금완료" />
												<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),25,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['user_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 입금 완료</a>
												<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_datetime'],0,10); ?></span><?php }?>
											</li>
										<?php }else if($row['o_salestatus']=="정산완료" && $realtimeitem_display_04=="Y"){?>
											<li>
												<img src="{MARI_MOBILESKIN_URL}/img/realtime_sort3.png" alt="정산완료" />
												<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['loan_id'];?>"><?php if($displayprofile_use_02=="Y"){?>[<?php echo $row['o_payment'];?>]<?php }?> ‘<?=cut_str(strip_tags($row['o_subject']),25,"…")?>’<?php if($displayprofile_use_01=="Y"){?><?php echo Name_conf($row['sale_name']);?>님<?php }?> <?php echo $row['o_count'];?>회차 정산 완료</a>
												<?php if($displayprofile_use_03=="Y"){?><span><?php echo substr($row['o_collectiondate'],0,10); ?></span><?php }?>
											</li>
										<?php }?>
									<?php }?>
									</ul>
								</div>
							</div><!-- /realtime_cont2_inner -->
						</div><!-- /realtime_cont2 -->
					</div><!-- /m_section2_1_inner -->
				</div><!-- /m_section2_1 -->