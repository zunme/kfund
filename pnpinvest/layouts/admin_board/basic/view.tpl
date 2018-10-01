
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 게시판 읽기
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>
{#header}
<script>


/*삭제처리*/
$(function() {
	$('#write_delete').click(function(){
	next_d(document.write_form);
	});
});


function next_d(f)
{
  if(confirm("정말 삭제처리 하시겠습니까? 삭제 후에는 해당 게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다."))
  {
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_view&type=d';
	f.submit();
  }
}
</script>




<section id="container">
		<section id="sub_content">
			<div class="customer_wrap">
				
				
					<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
					<input type="hidden" name="table" value="<?php echo $table; ?>">
					<input type="hidden" name="subject" value="<?php echo $subject; ?>">
					
					<div class="board_wrap">
					<div class="part1">
						<table class="board_view1">
							<colgroup>
								<col width="80px" />
								<col width="200px" />
								<col width="80px" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th colspan="8" class="bo_title1"><?php echo $w['w_subject'];?></th>
								
								</tr>
								<tr>
									<th colspan="8" class="bo_title1">
									첨부파일 :
									<?php if(!$w[file_img]){?>
										파일없음
									<?php }else{?>
										<a href="http://hanwoolfund.com/hanul/data/qna/<?php echo $w['file_img']?>"  target="_blank" download ><?php echo $w[file_img]?><a>
									<?php }?>
									</th>
								
								</tr>							
								<tr>
									<td colspan="6" class="bo_cont1">
									<?php echo $w['w_content'];?>
									</td>
								</tr>
								<tr>
									<td>
										{#view_comment}
									</td>
								</tr>
							</tbody>
						</table><!-- /board_view1 -->


						
					</div><!--customer_inner2 -->
					<div class="b_btn_wrap2">
							
							
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=guide_content&t_type=qna" class="btn_list1">목록</a>								
							
							
							</span>
							<?php if($user[m_level] >= 10 || $user[m_id] == "webmaster@admin.com" || $user[m_id] == $w[m_id]){?>
							<span class="fl_r">							
								<a href="{MARI_HOME_URL}/?up=bbs_write&type=d&w_id=<?php echo $w['w_id']?>&table=<?php echo $table;?>"  class="btn_list">삭제</a>
							</span>
							<?php }?>

						</div><!--b_btn_wrap2-->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->




<?}else{?>


{#header_sub}



<div id="container">
	<div id="sub_content">
		<div class="media_wrap">
				<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
				<input type="hidden" name="table" value="<?php echo $table; ?>">
				<input type="hidden" name="subject" value="<?php echo $subject; ?>">
				<?php
						if ($_COOKIE['ck_id'] != $id)
							{
								$sql = " update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
								sql_query($sql);
								// 하루 동안만
								set_cookie("ck_id", $id, 60*60*24);
							}
				?>
				<div class="notice_view" >
					<p class="notice_top_left"><?php echo $w['w_subject'];?><span class="notice_top_right"><?php echo substr($w['w_datetime'],0,10); ?></span></p>
					<p class="notice_top_left">첨부파일 : <?php if(!$w[file_img]){?>파일없음<?php }else{?><a href="http://apfund.co.kr/playp2p/data/qna/<?php echo $w['file_img']?>"  target="_blank" download ><?php echo $w[file_img]?><a><?php }?></p>
					<div class="notice_content"><?php echo $w['w_content'];?></div>	
					{#view_comment}
				</div><!--notice_view-->
				<div class="btn_wrap6">
					<a href="{MARI_HOME_URL}/?mode=guide_content&t_type=qna" class="btn_list1">목록</a>	
					
				<?php if($user[m_level] >= 10 || $user[m_id] == "webmaster@admin.com" || $user[m_id] == $w[m_id]){?>
				<span class="fl_r">
					<a href="{MARI_HOME_URL}/?up=bbs_write&type=d&w_id=<?php echo $w['w_id']?>&table=<?php echo $table;?>" class="btn_list">삭제하기</a>
				</span>
				<?php }?>
				
				</div>
				
		</div>
	</div><!-- /sub_content -->
</div><!-- /container -->


<script>


/*삭제처리*/
$(function() {
	$('#write_delete').click(function(){
	next_d(document.write_form);
	});
});


function next_d(f)
{
  if(confirm("정말 삭제처리 하시겠습니까? 삭제 후에는 해당 게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다."))
  {
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_view&type=d';
	f.submit();
  }
}
</script>







<?}?>
{# footer}<!--하단-->
