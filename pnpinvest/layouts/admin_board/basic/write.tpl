<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 게시판 쓰기
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->



<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>

<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script>
/*필수체크*/
$(function() {
	$('#write_form_add').click(function(){
		Write_form_Ok(document.write_form);
	});
});

function Write_form_Ok(f)
{
	 
	if(!f.w_name.value){alert('\n이름을 입력하여 주십시오.');f.w_name.focus();return false;}
	 
	if(!f.w_subject.value){alert('\n제목을 입력하여 주십시오.');f.w_subject.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_write&type=<?php echo $type;?>';
	f.submit();
}


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
	f.action = '{MARI_HOME_URL}/?up=bbs_write&type=d';
	f.submit();
  }
}
</script>


{#header}

	<section id="container">
		<section id="sub_content">
			<div class="container invest_section2_wrap">
				<div class="invest_section2_1">
					<div id="tabs-container">
						<ul class="tabs-menu2">
							<li><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-2"<?php }else{?>href="#tab-1"<?php }?>>투자관련 질문</a></li>
							<li><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-3"<?php }else{?>href="#tab-2"<?php }?>>대출관련 질문</a></li>
							<li><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-4"<?php }else{?>href="#tab-3"<?php }?>>기타일반 질문</a></li>
							<li class="current "><a <?php if($t_type=="qna"){?>href="#tab-1"<?php }else{?>href="#tab-4"<?php }?>>문의하기</a></li>
						</ul>
						<div class="tab">
							<form name="write_form"  method="post" enctype="multipart/form-data">
					<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
					<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>">
					<input type="hidden" name="table" value="<?php echo $table; ?>">
					<input type="hidden" name="subject" value="<?php echo $subject; ?>">
						<table class="board1 board2 mt40">
							<colgroup>
								<col width="20%" />
								<col width="80%" />
							</colgroup>
							<tbody>
								<tr>
								<th>작성자(아이디)</th>
								<td><?php echo $user[m_id]?></td>								 
								</tr>
								<tr>
								<th>작성자(이름)</th>
								<td><input type="text" name="w_name" value="<?php echo $user['m_name'];?>" id=""  class="frm_input frm_input form-control" size="40" /></td>								 
								</tr>								
								<tr>
								<th>휴대폰번호</th>
								<td><input type="text" name="w_hp" value="<?php echo $user['m_hp'];?>" id=""  class="frm_input frm_input form-control" size="40" /></td>								 
								</tr>
								<tr>
								<th>이메일</th>
								<td><input type="text" name="w_email" value="<?php echo $user['m_email'];?>" id=""  class="frm_input frm_input form-control" size="40" /></td>								 
								</tr>
								<tr>
								<th>제목</th>
								<td><input type="text" name="w_subject" value="<?php echo $w['w_subject'];?>" id=""  class="frm_input form-control" size="60" /></td>
								</tr>
								
								<tr>
									<th>파일첨부</th>
									<td colspan="3">
										<input type="file" name="u_img" class="form-control">
										    <?php
										    $viewimg_str_01 = "";
										    $view_img = MARI_DATA_PATH."/$table/".$w[file_img]."";
										    if (file_exists($view_img) && $w[file_img]) {
											$size = @getimagesize($view_img);
											if($size[0] && $size[0] > 320)
											    $width = 320;
											else
											    $width = $size[0];

											echo '<input type="checkbox" name="d_img" value="1" id="d_img"> <label for="d_img">삭제</label>';
											$viewimg_str_01 = '<img src="'.MARI_DATA_URL.'/'.$table.'/'.$w[file_img].'" width="'.$width.'">';
										    }
										    if ($viewimg_str_01) {
											echo '<div class="banner_or_img">';
											echo $viewimg_str_01;
											echo '</div>';
										    }
										    ?>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
								<?php 
								 /*에디터 사용시에만 에디터노출*/
								if($bbs_config['bo_use_editor']=="Y"){
								?>
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<textarea name="w_content" class="form-control" rows="8"></textarea>
									<!--<?php echo editor_html('w_content', $bbs_config['bo_insert_content']); ?>!-->
								<?php }else{?>
									<textarea name="w_content" class="form-control" rows="8"><?php echo $w['w_content'] ?></textarea>
									<!--<?php echo editor_html('w_content', $w['w_content']); ?>!-->
								<?php }?>
								<?php }else{?>
									<textarea name="w_content" class="form-control" rows="8"><?php echo $w['w_content'];?></textarea>
								<?php }?>
									</td>
								</tr>
								<?php
									if($type=="m"){
										if($user[m_level] == '10' || $user[m_id]=="webmaster@admin.com"){
								?>
								<tr>
									<th>관리자 답변</th>
									<td>
										<textarea name="w_answer" class="form-control" rows="4"><?php echo $w['w_answer'];?></textarea>
									</td>
								</tr>
									
								<?php
										}
									}
								?>
								<?php 
								 /*파일첨부 권한이 있을경우에만 노출*/
								if($user['m_level']>=$bbs_config['bo_write_level'] || $bbs_config['bo_admin']==$user[m_id]){
								?>
								<?php }?>
							</tbody>
						</table><!-- /board_write1 -->
						<div class="b_btn_wrap2">
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=guide_content&t_type=qna" class="btn_list1">목록</a>
							</span>
							<span class="fl_r">
								<a href="javascript:;" id="write_form_add" class="btn_list">작성완료</a>
							<?php if($type=="m"){?>
								<a href="javascript:;" id="write_delete" class="btn_list">삭제</a>
							<?php }?>
							</span>
						</div><!-- /btn_wrap2 -->
				</form>
						</div>
					</div>
				</div>
			</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->

		 









 






<?php }else{?>







{#header_sub}



		<div id="container">
			<div id="sub_content">
				<div class="invest_section2_wrap">
					<div class="invest_section2_1 guide_invest" >
						<div id="tabs-container ">
							<ul class="tabs-menu">
								<li ><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-2"<?php }else{?>href="#tab-1"<?php }?>>투자관련 질문</a></li>
								<li ><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-3"<?php }else{?>href="#tab-2"<?php }?>>대출관련 질문</a></li>
								<li ><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-4"<?php }else{?>href="#tab-3"<?php }?>>기타일반 질문</a></li>
								<li class="current "><a class="tab-1_m" <?php if($t_type=="qna"){?>href="#tab-1"<?php }else{?>href="#tab-4"<?php }?>>문의하기</a></li>
							</ul>
							<div class="tab">
								<div class="media_wrap">
									<form name="write_form"  method="post" enctype="multipart/form-data">
										<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
										<input type="hidden" name="table" value="<?php echo $table; ?>">
										<input type="hidden" name="subject" value="<?php echo $subject; ?>">
										<div class="board_wrap">
											<table class="board_write1">
												<colgroup>
													<col width="170px" />
													<col width="300px" />
													<col width="170px" />
													<col width="300px" />
												</colgroup>
												<tbody>
													<th>아이디</th>
													<td><input type="text" name="m_id" value="<?php echo $user['m_id'];?>" id=""  class="frm_input" /></td>
													<th>휴대폰번호</th>
													<td><input type="text" name="w_hp" id=""  value="<?php echo $user[m_hp]?>" class="frm_input " /></td>
													</tr>
													<tr>
													<th>이름(성명)</th>
													<td><input type="text" name="w_name" value="<?php echo $user['m_name'];?>" id=""  class="frm_input "  /></td>
													<th>이메일</th>
													<td><input type="text" name="w_email" value="<?php echo $user['m_email'];?>" id=""  class="frm_input " /></td>
													</tr>
													</tr>
													<tr>
														<th>제목</th>
														<td colspan="3"><input type="text" name="w_subject" value="<?php echo $w['w_subject'];?>" id=""  class="frm_input " size="80" /></td>
													</tr>
													<tr>
														<th>내용</th>
														<td colspan="3">
														<?php echo editor_html('w_content', $w['w_content']); ?>
														</td>
													</tr>
													<tr>
														<th>파일첨부</th>
														<td colspan="3">
															<input type="file" name="u_img">
																<?php
																$viewimg_str_01 = "";
																$view_img = MARI_DATA_PATH."/$table/".$w[file_img]."";
																if (file_exists($view_img) && $w[file_img]) {
																$size = @getimagesize($view_img);
																if($size[0] && $size[0] > 320)
																	$width = 320;
																else
																	$width = $size[0];

																echo '<input type="checkbox" name="d_img" value="1" id="d_img"> <label for="d_img">삭제</label>';
																$viewimg_str_01 = '<img src="'.MARI_DATA_URL.'/'.$table.'/'.$w[file_img].'" width="'.$width.'">';
																}
																if ($viewimg_str_01) {
																echo '<div class="banner_or_img">';
																echo $viewimg_str_01;
																echo '</div>';
																}
																?>
														</td>
													</tr>
													
												</tbody>
											</table><!-- /board_write1 -->
											<div class="btn_wrap4">
												<span class="fl_l">
												<a href="{MARI_HOME_URL}/?mode=guide_content&t_type=qna" class="btn_list1" >목록</a>
											</span>
											<span class="fl_r">
												<a href="#" onclick="Write_form_Ok()" id="" class="btn_list">작성완료</a>
											</div><!-- /btn_wrap4 -->
										</div><!-- /board_wrap -->
									</form>
								</div><!-- /media_wrap -->
							</div>
						</div>
					</div>
				</div>
			</div><!-- /sub_content -->
		</div><!-- /container -->


		
<script>
/*필수체크*/
$(function() {
	$('#write_form_add').click(function(){
		Write_form_Ok(document.write_form);
	});
});


function Write_form_Ok()
{	
	var f = document.write_form;
	<?php echo get_editor_js('w_content'); ?>
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.w_name.value){alert('\n이름을 입력하여 주십시오.');f.w_name.focus();return false;}
	if(!f.w_subject.value){alert('\n제목을 입력하여 주십시오.');f.w_subject.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_write&type=<?php echo $type;?>';
	f.submit();
}


</script>









<?php }?>


{# footer}<!--하단-->
