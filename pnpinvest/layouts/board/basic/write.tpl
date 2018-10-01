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
			<div class="customer_wrap">
				<div class="container">
				<div class="top_title3">
					<div class="top_title_inner">
						<h3 class="title5">고객센터</h3>
						<p class="title_add1">Service center</p>
						<p class="title_add2">관련 정보 및 각종 인터뷰 내용을</p>
						<p class="title_add2">확인하실 수 있습니다.</p>

						<!--title_add1 e-->
					</div>
					<form name="write_form"  method="post" enctype="multipart/form-data">
					<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
					<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>">
					<input type="hidden" name="table" value="<?php echo $table; ?>">
					<input type="hidden" name="subject" value="<?php echo $subject; ?>">
					<div class="customer_inner2">
						<table class="board_write1">
							<colgroup>
								<col width="75px" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
								<?php /*비회원*/
								if(!$member_ck){
								?>
								<th>아이디</th>
								<td><input type="text" name="m_id" value="<?php echo $w['m_id'];?>" id=""  class="frm_input " size="40" /></td>
								<th>게시물 비밀번호</th>
								<td><input type="password" name="w_password" id=""  class="frm_input " size="40" /></td>
								</tr>
								<tr>
								<th>이름(성명)</th>
								<td><input type="text" name="w_name" value="<?php echo $w['w_name'];?>" id=""  class="frm_input " size="40" /></td>
								<th>이메일</th>
								<td><input type="text" name="w_email" value="<?php echo $w['w_email'];?>" id=""  class="frm_input " size="40" /></td>
								</tr>
								<th>휴대폰번호</th>
								<td>
									<select name="hp1">
										<option>선택</option>
										<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
										<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
										<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
										<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
										<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
									</select> _
									<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="10" /> _
									<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="10" />
								</td>
								<?php  /*회원*/}else{?>
								<th>제목</th>
								<td><input type="text" name="w_subject" value="<?php echo $w['w_subject'];?>" id=""  class="frm_input form-control" size="60" /></td>
								</tr>
								<tr>
								<th>작성자</th>
								<td><input type="text" name="w_name" value="<?php echo $user['m_name'];?>" id=""  class="frm_input frm_input form-control" size="40" /></td>
								 
								</tr>
								
								<?php }?>
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
								<a href="{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $table; ?>&subject=<?php echo $subject;?>"><img src="{MARI_MOBILESKIN_URL}/img/list_btn.png" alt="목록" /></a>
							</span>
							<span class="fl_r">
								<img src="{MARI_MOBILESKIN_URL}/img/complete.png"  id="write_form_add"  style="cursor:pointer;" alt="작성완료" />
							<?php if($type=="m"){?>
								<img src="{MARI_MOBILESKIN_URL}/img/delete_btn.png" id="write_delete" style="cursor:pointer;" alt="삭제" />
							<?php }?>
							</span>
						</div><!-- /btn_wrap2 -->
					</div><!-- /customer_inner2 -->



				</form>
		 
	 

				</div><!--containner-->
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->

		 










 






<?php }else{?>






{#header_sub}




		<div id="container">
			<div id="sub_content">
			<div class="toptitle01">
				     <div class="top_title_inner">
						<h3 class="title501">고객센터</h3>
						<p class="titleadd101">&nbsp;</p>
						<p class="titleadd201">{_config['c_title']}에 대한 언론보도, 인터뷰, 공지사항을</p>
						<p class="titleadd201">확인하실 수 있습니다</p>
					</div><!-- /title_wr_inner -->
			  </div>

				<div class="media_wrap">
					<ul class="tab_btn1">
						<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변">고객후기</a></li>
					</ul>

<form name="write_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
<input type="hidden" name="table" value="<?php echo $table; ?>">
<input type="hidden" name="subject" value="<?php echo $subject; ?>">
					<div class="board_wrap">
						<table class="board_write100">
							<colgroup>
								<col style="width:300px;">
								<col style="width:auto;">
								<col style="width:200px;">
								<col style="width:auto;">
							</colgroup>
							<tbody>
								<tr>
								<?php /*비회원*/
								if(!$member_ck){
								?>
								<th>아이디</th>
								<td><input style="width:300px;"type="text" name="m_id" value="<?php echo $w['m_id'];?>" id=""  class="frm_input" size="40" /></td>
								<th>게시물 비밀번호</th>
								<td><input style="width:300px;" type="password" name="w_password" id=""  class="frm_input " size="40" /></td>
								</tr>
								<tr>
								<th>이름(성명)</th>
								<td><input  style="width:300px;" type="text" name="w_name" value="<?php echo $w['w_name'];?>" id=""  class="frm_input " size="40" /></td>
								<th>이메일</th>
								<td><input  style="width:300px;" type="text" name="w_email" value="<?php echo $w['w_email'];?>" id=""  class="frm_input " size="40" /></td>
								</tr>
								<th>휴대폰번호</th>
								<td>
									<select name="hp1">
										<option>선택</option>
										<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
										<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
										<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
										<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
										<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
									</select> _
									<input style="width:100px;" type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="10" /> 
									<input style="width:100px;"  type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="10" />
								</td>
								<?php  /*회원*/
								}else{
								?>
								<th>아이디</th>
								<td><input style="width:300px;"type="text" name="m_id" value="<?php echo $user['m_id'];?>" id=""  class="frm_input" size="40" /></td>
								<th>게시물 비밀번호</th>
								<td><input style="width:300px;"type="password" name="w_password" id=""  class="frm_input " size="40" /></td>
								</tr>
								<tr>
								<th>이름(성명)</th>
								<td><input style="width:300px;"type="text" name="w_name" value="<?php echo $user['m_name'];?>" id=""  class="frm_input " size="40" /></td>
								<th>이메일</th>
								<td><input style="width:300px;" type="text" name="w_email" value="<?php echo $user['m_email'];?>" id=""  class="frm_input " size="40" /></td>
								</tr>
								<!--
								<th>휴대폰번호</th>
								<td>
									<select name="hp1">
										<option>선택</option>
										<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
										<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
										<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
										<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
										<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
									</select> _
									<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="10" /> _
									<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="10" />
								</td>
								<?php }?>
							
							<?php /*분류사용 설정시에만 노출*/
							if($bbs_config['bo_use_category']=="Y"){
							?>
								<th>분류설정</th>
								<td>
								<select name="w_catecode">
								<?php echo get_category_option($table, $bbs_config[bo_category_list]); ?>
								</select>
								</td>
							<?php }?>
						           -->
								</tr>
							<?php if($config[c_admin]==$user[m_id] || $config[c_admin]==$bbs_config[bo_admin]){?>
								<tr>
									<th>공지여부</th>
									<td colspan="3">
										<p class="fb mb5">공지로 노출시 체크박스 '사용' 체크하여 주십시오.</p>
										<input type="checkbox" name="w_notice" value="Y" <?php echo $w['w_notice']=='Y'?'checked':'';?>/> <label for="">사용</label>
									</td>
								</tr>
								<tr>
									<th>메인 출력여부</th>
									<td colspan="3">
										<p class="fb mb5"> 체크박스 '사용' 체크하여 주십시오.</p>
										<input type="checkbox" name="w_main_exposure" value="Y" <?php echo $w['w_main_exposure']=='Y'?'checked':'';?> /> <label for="">사용</label>
									</td>
								</tr>
							<?php }?>
							<!--
								<tr>
									<th>연결링크</th>
									<td colspan="3">
										<p class="fb mb7">별도 링크시 이동될 url주소를 'http://'를 포함한 주소를 입력하여 주십시오. 새창사용시 새창체크</p>
										<input type="text" name="w_rink" value="<?php echo $w['w_rink'];?>" id=""  class="frm_input " size="60" />
										<input type="checkbox" value="Y" name="w_blank"  <?php echo $w['w_blank']=='Y'?'checked':'';?> class="ml10" /> <label for="">새창</label>
									</td>
								</tr>
							-->
								<tr>
									<th>제목</th>
									<td colspan="3"><input style="width:700px;"  type="text" name="w_subject" value="<?php echo $w['w_subject'];?>" id=""  class="frm_input " size="100" /></td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="3">
								<?php 
								 /*에디터 사용시에만 에디터노출*/
								if($bbs_config['bo_use_editor']=="Y"){
								?>
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<?php echo editor_html('w_content', $w['w_content']); ?>
								<?php }else{?>
									<?php echo editor_html('w_content', $w['w_content']); ?>
								<?php }?>
								<?php }else{?>
									<textarea name="w_content"><?php echo $w['w_content'];?></textarea>
								<?php }?>
									</td>
								</tr>
								<?php 
								 /*파일첨부 권한이 있을경우에만 노출*/
								if($user['m_level']>=$bbs_config['bo_write_level'] || $bbs_config['bo_admin']==$user[m_id]){
								?>
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
								
								
								<?php }?>
							</tbody>
						</table><!-- /board_write1 -->
						<div class="btn_wrap4">
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $table; ?>&subject=<?php echo $subject;?>"><img src="{MARI_HOMESKIN_URL}/img/list_btn.png" alt="목록" /></a>
							</span>
							<span class="fl_r">
								<img src="{MARI_HOMESKIN_URL}/img/complete_btn.png"  id="write_form_add"  style="cursor:pointer;" alt="작성완료" />
							<!--
							<?php if($type=="m"){?>
								<img src="{MARI_HOMESKIN_URL}/img/btn_del.png" id="write_delete" style="cursor:pointer;" alt="삭제" />
							<?php }?>
							-->
							</span>
						</div><!-- /btn_wrap4 -->
					</div><!-- /board_wrap -->
</form>
				</div><!-- /service_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->


		
<script>
/*필수체크*/
$(function() {
	$('#write_form_add').click(function(){
		Write_form_Ok(document.write_form);
	});
});


function Write_form_Ok(f)
{	
	<?php echo get_editor_js('w_content'); ?>
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.w_name.value){alert('\n이름을 입력하여 주십시오.');f.w_name.focus();return false;}
	//if(!f.w_email.value){alert('\n이메일을 설정하여 주십시오.');f.w_email.focus();return false;}
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









<?php }?>


{# footer}<!--하단-->
