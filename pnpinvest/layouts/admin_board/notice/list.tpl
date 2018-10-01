<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 공지사항
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->


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
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#header}
<section id="container">
	<section id="sub_content">
		<div class="customer_wrap">
			<div class="board_wrap">
			<h3 class="s_title1">공지사항</h3>
				<div class="part1 mt10">
						<table class="board1">
							<colgroup>
								<col width="15%" />
								<col width="70%" />
								<col width="15%" />
							</colgroup>
								<thead>
								<tr>
									<th>번호</th>
									<th class="tb_bg1">제목</th>
									<th class="tb_bg1">작성일</th>
								</tr>
								</thead>
								<tbody>
									<?php 
									for ($i=0;  $list=sql_fetch_array($result); $i++){
									?>	
									<tr>
										<td><?php echo $list['w_id'];?></td>
										<td>
											<?php if(!$list['w_rink']){?>
											<a href="{MARI_HOME_URL}/?mode=bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">
											<?php }else{?>
											<a href="<?php echo $list['w_rink'];?>" <?php if($list['w_blank']=="Y"){?> target="_blank"<?php }?>>
												<?php }?>

												<?php if(!$bbs_config[bo_subject_len]){?>
												<?php echo $list['w_subject'];?>
												<?php }else{?>
												<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
												<?php }?>
											</a>
										</td>
										<td><?php echo substr($list['w_datetime'],0,10); ?></td>
									</tr>
									<?php
									}
									if ($i == 0)
									echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
									?>
								</tbody>
						</table><!-- /board1 -->
						<div class="paging">
						<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
						</div><!-- /paging -->
				</div><!-- /part1 -->
			</div><!--board_wrap-->
		</div><!-- /mypage_wrap -->
	</section><!-- /sub_content -->
</section><!-- /container -->


<?php }else{?>


{#header_sub}


		<div id="container">
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
			<div id="sub_content">
				<div class="service_wrap">
					<ul class="tab_btn1">
						<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항">공지사항</a></li>
						<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">언론보도</a></li>
					</ul>

					<div class="board_wrap">
						<table class="board1">
							<colgroup>
								<col width="80px" />
								<col width="300px" />
								<col width="130px" />
								<col width="80px" />
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th class="tb_bg1">제목</th>
									<th class="tb_bg1">작성자</th>
									<th class="tb_bg1">작성일</th>
								</tr>
							</thead>
							<tbody>
	<?php 
	for ($i=0;  $list=sql_fetch_array($result); $i++){
	?>
								<tr>
									<td><?php echo $list['w_id'];?></td><td class="txt_l pl30">
									<?php if(!$list['w_rink']){?>
									<a href="{MARI_HOME_URL}/?mode=bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">
									<?php }else{?>
									<a href="<?php echo $list['w_rink'];?>" <?php if($list['w_blank']=="Y"){?> target="_blank"<?php }?>>
									<?php }?>
									<?php if(!$bbs_config[bo_subject_len]){?>
										<?php echo $list['w_subject'];?>
									<?php }else{?>
										<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
									<?php }?>
									</a>
									</td>
									<td>관리자</td>
									<td><?php echo substr($list['w_datetime'],0,10); ?></td>
								</tr>
	<?php
	}
	if ($i == 0)
		echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
	?>
							</tbody>
						</table><!-- /board1 -->
					<div class="paging">
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
					</div><!-- /paging -->
					</div><!-- /board_wrap -->
				</div><!-- /service_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->




		

<?}?>
{# footer}<!--하단-->


