
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 게시판리스트
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->

<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>




<section id="container">
		<section id="sub_content">
			<div class="customer_wrap">
				<div class="container">
					<h3 class="s_title1">자주하는질문</h3><!-- 
					<p class="tit_add1">각종 자료 및 인터뷰 내용을 확인하실 수 있습니다. </p> -->
					<div class="customer_inner2">
						<table class="board1">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />

								</colgroup>
								<thead>
									<tr>
										<th>제목</th><th>작성자</th><th>처리상황</th>
									</tr>
								</thead>
								<tbody>
								<?php 
	for ($i=0;  $list=sql_fetch_array($result); $i++){
	?>
									<tr>
										
										<td class="txt_l">	
										<?php if($list['m_id'] == $user['m_id'] || $user['m_level'] >= 10){?>
											<a href="{MARI_HOME_URL}/?mode=bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">											
											<?php if(!$bbs_config[bo_subject_len]){?>
											<?=cut_str(strip_tags($list['w_subject']),10,"…")?>
											<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
											<?php }?>
											</a>
										<?php }else{?>
											<a href="javascript:alert('본인만 접근이 가능합니다.');">
											<?php if(!$bbs_config[bo_subject_len]){?>
												<?=cut_str(strip_tags($list['w_subject']),10,"…")?>
											<?php }else{?>
												<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
											<?php }?>
											</a>
										<?php }?>
										</td>
										<td><?php echo mb_substr($list['w_name'],0,1,'utf-8');?>*<?php echo mb_substr($list['w_name'],2,1,'utf-8');?></td>
										<td>
										<?php if(!$list['w_answer']){
											echo '처리중';
											}else{
											echo '처리완료';
											}
										?>
										</td>
									</tr>
									
									<?php
	}
	if ($i == 0)
		echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
	?>
								</tbody>
							</table><!-- /board1 -->

					<?php /*쓰기권한 체크*/
					if($bbs_config['bo_write_level']>$user['m_level']){
					?>
					<?php }else{?>
							<div class="b_btn_wrap1">
								<a href="{MARI_HOME_URL}/?mode=bbs_write&type=w&table=<?php echo $table; ?>&subject=<?php echo $subject;?>"><img src="{MARI_MOBILESKIN_URL}/img/write_btn.png" alt="글쓰기" /></a>
							</div>
					<?php }?>
					<div class="paging">
					<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
					</div><!-- /paging -->


					</div><!-- /customer_inner2 -->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->




<?php }else{?>
{#header_sub}
		<div id="container">
			<div id="sub_content">
				<div class="title_wrap title_bg8">
					<div class="title_wr_inner">
						<h3 class="title5">ANA 캐스트</h3>
						<p class="title_add1">Customer Center</p>
						<p class="title_add2">아나리츠에 대한 언론보도, 인터뷰, 공지사항을</p>
						<p class="title_add2">확인하실 수 있습니다</p>
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				</div>


				<div class="service_wrap">
					<ul class="tab_btn1">
						<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">언론보도</a></li>
						<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변">인터뷰</a></li>
						<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항">공지사항</a></li>
					</ul>

					<div class="board_wrap">
						<table class="board1">
							<colgroup>
								<col width="80px" />
								<col width="" />
								<col width="120px" />
								<col width="130px" />
								<col width="80px" />
							</colgroup>
							<thead>
								<tr>
									<th>번호</th><th class="tb_bg1">제목</th><th class="tb_bg1">작성자</th><th class="tb_bg1">작성일</th><th class="tb_bg1">상태</th><th class="tb_bg1">조회수</th>
								</tr>
							</thead>
							<tbody>
	<?php 
	for ($i=0;  $list=sql_fetch_array($result); $i++){
	?>
								<tr>
									<td><?php echo $list['w_id'];?></td><td class="txt_l pl30">
									<?php if($list['m_id'] == $user['m_id'] || $user['m_level'] >= 10){?>
									<a href="{MARI_HOME_URL}/?mode=bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">									
									<?php if(!$bbs_config[bo_subject_len]){?>
										<?php echo $list['w_subject'];?>
									<?php }else{?>
										<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
									<?php }?>
									</a>
									<?php }else{?>
										<a href="javascript:alert('본인만 접근이 가능합니다.');">
										<?php if(!$bbs_config[bo_subject_len]){?>
											<?php echo $list['w_subject'];?>
										<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
										<?php }?>
										</a>
									<?php }?>
									</td>
									<td><?php echo $list['w_name'];?></td>
									<td><?php echo substr($list['w_datetime'],0,10); ?></td>
									<td>
										<?php if(!$list['w_answer']){
											echo '처리중';
											}else{
											echo '처리완료';
											}
										?>
									</td>
									<td><?php echo $list['w_hit'];?></td>
								</tr>
	<?php
	}
	if ($i == 0)
		echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
	?>
							</tbody>
						</table><!-- /board1 -->
					<?php /*쓰기권한 체크*/
					if($bbs_config['bo_write_level']>$user['m_level']){
					?>
					<?php }else{?>
						<div class="txt_r mt20">
							<a href="{MARI_HOME_URL}/?mode=bbs_write&type=w&table=<?php echo $table; ?>&subject=<?php echo $subject;?>"><img src="{MARI_HOMESKIN_URL}/img/write_btn.png" alt="글쓰기" /></a>
						</div>
					<?php }?>
					<div class="paging">
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
					</div><!-- /paging -->
					</div><!-- /board_wrap -->
				</div><!-- /service_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->



<?php }?>
		


{# skin1_footer}<!--하단-->


