
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 게시판 읽기
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
});
</script>
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>
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
				<div class="container">
				<div class="top_title3">
					<div class="top_title_inner">
						<h3 class="title5">고객센터</h3>
						<p class="title_add1">Service center</p>
						<!--<p class="title_add2 pt40">관련 정보 및 각종 인터뷰 내용을</p>
						<p class="title_add2">확인하실 수 있습니다.</p>
						<p class="location1">
						<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon_location.png" alt="홈" /> > 고객센터 > <strong>Q&A</strong></p>
						</p>-->
						<!--//title_add1 e -->
					</div>				 
					<form name="write_form"  method="post" enctype="multipart/form-data">
					<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
					<input type="hidden" name="table" value="<?php echo $table; ?>">
					<input type="hidden" name="subject" value="<?php echo $subject; ?>">
					<div class="customer_inner2">
						<table class="board_view1">
							<colgroup>
								<col width="80px" />
								<col width="200px" />
								<col width="80px" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="80px" />
								<col width="100px" />
							</colgroup>
							<tbody>
								<tr>
									<th colspan="8" class="bo_title1"><?php echo $w['w_subject'];?></th>
								</tr>
								<tr>
									<th>작성자 :</th><td><?php echo $w['w_name'];?> <?php if($bbs_config['bo_use_ip_view']=="Y"){?>IP : <?php echo $w['w_ip'];?><?php }?></td><th>휴대전화 :</th><td><?php echo $w['w_hp'];?></td><th>조회수 : <?php echo $w['w_hit'];?></th><td></td><th>등록일 :</th><td><?php echo substr($w['w_datetime'],0,10); ?></td>
								</tr>
								<?php if($w[file_img]){?>
								<tr>
									<th>첨부파일 :</th><td colspan="8"><a href="http://pnpinvest.esmfintech.co.kr/pnpinvest/data/<?php echo $table;?>/<?php echo $w[file_img]?>" download target="_blank">다운로드</a></td>
								</tr>
								<?php }?>
								<tr>
									<td colspan="6" class="bo_cont1"><?php echo $w['w_content'];?></td>
								</tr>
							
							</tbody>
						</table><!-- /board_view1 -->


						<div class="b_btn_wrap2">
							
							
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $table; ?>&subject=<?php echo $subject;?>">
									<img src="{MARI_MOBILESKIN_URL}/img/list_btn.png" alt="목록" />
								</a>
							</span>
						<?php if($user['m_level'] >= 10 || $user['m_id']==$w['m_id']){?>
							<span class="fl_r">
								<!-- <a href="#"><img src="{MARI_HOMESKIN_URL}/img/reply_btn.png" alt="답변" /></a> -->
								<a href="{MARI_HOME_URL}/?mode=bbs_write&type=m&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $id; ?>">
								<img src="{MARI_MOBILESKIN_URL}/img/modify_btn.png" alt="수정" /></a>								
								<img src="{MARI_MOBILESKIN_URL}/img/delete_btn.png" id="write_delete" style="cursor:pointer;" alt="삭제" />							
							</span>
						<?php }?>


						</div><!--b_btn_wrap2-->
					</div><!--customer_inner2 -->
					</form>
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->




<?}else{?>






<div id="container">
			<div id="sub_notice">
			<div class="title_wrap title_bg8">
					<div class="title_wr_inner">
						<h3 class="title5">ANA 캐스트</h3>
						<p class="title_add1">Customer Center</p>
						<p class="title_add2">아나리츠에 대한 언론보도, 인터뷰, 공지사항을</p>
						<p class="title_add2">확인하실 수 있습니다</p>
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->

<form name="write_form"  method="post" enctype="multipart/form-data">
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
					</div>
					<div class="btn_wrap4">
						<!--<a href="{MARI_HOME_URL}/?mode=bbs_write&type=m&table=<?php echo $table; ?>&subject=<?php echo 
$subject;?>&id=<?php echo $id; ?>" class="btn_modify">수정</a>-->
						<a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변" class="btn_list">목록</a>
					</div>
					<!--<div class="board_wrap2">
						<table class="board_view1">	 
							 <colgroup>
								<col width="">
								<col width="">
							 </colgroup>
							 <thead>
								<tr>
									<th>dd</th>
								</tr>
							 </thead>
							 <tbody>
								<tr>
									<td>ggg</td>
								</tr>
							 </tbody>
						</table>
					</div>--><!-- /board_wrap2 -->
					</form>
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
