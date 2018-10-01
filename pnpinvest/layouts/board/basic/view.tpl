
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
						<h3 class="s_title1">자료실</h3>
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
								<?php if($w[file_img]){?>
								<tr>
									<th>첨부파일 :</th><td colspan="8"><a href="http://pnpinvest.esmfintech.co.kr/pnpinvest/data/<?php echo $table;?>/<?php echo $w[file_img]?>" download target="_blank">다운로드</a></td>
								</tr>
								<?php }?>								
								<tr>
									<td colspan="6" class="bo_cont1">
									<?php echo $w['w_content'];?>
								<br/><br/>
									</td>
								</tr>
								<tr>
								<td>
									{#view_comment}
								</td>
							</tr>
							</tbody>
						</table><!-- /board_view1 -->


						<div class="b_btn_wrap2">
							
							
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $table; ?>&subject=<?php echo $subject;?>">
									<img src="{MARI_MOBILESKIN_URL}/img/list_btn.png" alt="목록" />
								</a>
							</span>
						


						</div><!--b_btn_wrap2-->
					</div><!--customer_inner2 -->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->




<?}else{?>



{#header_sub}



<div id="container">
			<div id="sub_notice">

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
						<?php if($w[file_img]){?>
						<p class="notice_top_left">첨부파일 : <a href="http://pnpinvest.esmfintech.co.kr/pnpinvest/data/<?php echo $table?>/<?php echo $w[file_img]?>" download target="_blank">다운로드</a></p>
						<?php }?>
						<div class="notice_content"><?php echo $w['w_content'];?></div>						
						<br/><br/>
						{#view_comment}
					
					</div><!--sub_notice-e-->
						<div class="btn_wrap4">
						
							<a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변" class="btn_list">목록</a>
						</div>
					
				</div><!-- /service_wrap -->
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
