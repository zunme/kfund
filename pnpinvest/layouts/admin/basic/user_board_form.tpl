<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01"><?php echo $subject;?></div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	
	<div id="container">
		<div class="title02"><?php echo $subject;?> 게시판 입력</div>

		<div class="local_desc01 local_desc">
			<p>
				<?php echo $subject;?>게시판의 내용을 작성합니다.
			</p>
		</div>
<form name="write_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
<input type="hidden" name="table" value="<?php echo $table; ?>">
<input type="hidden" name="subject" value="<?php echo $subject; ?>">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>공지사항 입력</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="m_id" value="<?php echo $w['m_id'];?>" id=""  class="frm_input " size="20" /></td>
						<th>게시물 비밀번호</th>
						<td><input type="password" name="w_password"  id=""  class="frm_input " size="20" /></td>
					</tr>
					<tr>
						<th>이름(성명)</th>
						<td><input type="text" name="w_name" value="<?php echo $w['w_name'];?>" id=""  class="frm_input " size="20" /></td>
						<th>이메일</th>
						<td><input type="text" name="w_email" value="<?php echo $w['w_email'];?>" id=""  class="frm_input " size="30" /></td>
					</tr>
					<tr>
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
							<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="6" /> _
							<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="6" />
						</td>

						<th>분류설정</th>
						<td>
						<select name="w_catecode">
						<?php echo get_category_option($table, $bbs_config[bo_category_list]); ?>
						</select>
						</td>
					</tr>
					<tr>
						<th>공지여부</th>
						<td colspan="3">
							<p class="fb">공지로 노출시 체크박스 '사용' 체크하여 주십시오.</p>
							<input type="checkbox" name="w_notice" value="Y" <?php echo $w['w_notice']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<th>메인 출력여부</th>
						<td colspan="3">
							<p class="fb"> 체크박스 '사용' 체크하여 주십시오.</p>
							<input type="checkbox" name="w_main_exposure" value="Y" <?php echo $w['w_main_exposure']=='Y'?'checked':'';?> /> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<th>연결링크</th>
						<td colspan="3">
							<p class="fb">별도 링크시 이동될 url주소를 'http://'를 포함한 주소를 입력하여 주십시오. 새창사용시 새창체크</p>
							<input type="text" name="w_rink" value="<?php echo $w['w_rink'];?>" id=""  class="frm_input " size="60" /> 새창 <input type="checkbox" value="Y" name="w_blank"  <?php echo $w['w_blank']=='Y'?'checked':'';?> />
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3"><input type="text" name="w_subject" value="<?php echo $w['w_subject'];?>" id=""  class="frm_input " size="60" /></td>
					</tr>
					<?php if($table == "media"){?>
					<tr>
						<th>로고이미지</th>
						<td colspan="3">
							<input type="file" name="w_logo">
							   <?php
							    $viewimg_str_02 = "";
							    $view_img2 = MARI_DATA_PATH."/$table/".$w[w_logo]."";
							    if (file_exists($view_img2) && $w[w_logo]) {
								$size = @getimagesize($view_img2);
								if($size[0] && $size[0] > 320)
								    $width = 320;
								else
								    $width = $size[0];

								echo '<input type="checkbox" name="d_logo" value="1" id="d_logo"> <label for="d_img">삭제</label>';
								$viewimg_str_02 = '<img src="'.MARI_DATA_URL.'/'.$table.'/'.$w[w_logo].'" width="'.$width.'">';
								//$size = getimagesize($bimg);
								//echo "<img src='$mari[admin_path]/img/icon_viewer.gif' border=0 align=absmiddle onclick=\"imageview('bimg', $size[0], $size[1]);\"><input type=checkbox name=d_img value='1'>삭제";
								//echo "<div id='bimg' style='left:0; top:0; z-index:+1; display:none; position:absolute;'><img src='$bimg' border=1></div>";
							    }
							    if ($viewimg_str_02) {
								echo '<div class="banner_or_img">';
								echo $viewimg_str_02;
								echo '</div>';
							    }
							    ?>
						</td>
					</tr>
					<?php }?>
					<tr>
						<th>내용</th>
						<td colspan="3">	
								
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<?php echo editor_html('w_content', $bbs_config['bo_insert_content']); ?>
								<?php }else{?>
									<?php echo editor_html('w_content', $w['w_content']); ?>
								<?php }?><br/>
								<p class="fb">*(필수)사진첨부 가로 293px 세로163px 설정</p>
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
								//$size = getimagesize($bimg);
								//echo "<img src='$mari[admin_path]/img/icon_viewer.gif' border=0 align=absmiddle onclick=\"imageview('bimg', $size[0], $size[1]);\"><input type=checkbox name=d_img value='1'>삭제";
								//echo "<div id='bimg' style='left:0; top:0; z-index:+1; display:none; position:absolute;'><img src='$bimg' border=1></div>";
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
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" id="write_form_add" title="확인"  />
			<a href="{MARI_HOME_URL}/?cms=user_board_list&table=<?php echo $table; ?>&subject=<?php echo $list[w_subject]; ?>"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
			<img src="{MARI_ADMINSKIN_URL}/img/btn_delete.png" id="write_delete" style="cursor:pointer;" alt="삭제하기" />
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


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
	/*
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.w_name.value){alert('\n이름을 입력하여 주십시오.');f.w_name.focus();return false;}
	if(!f.w_email.value){alert('\n이메일을 설정하여 주십시오.');f.w_email.focus();return false;}
	if(!f.w_password.value){alert('\n비밀번호를 설정하여 주십시오.');f.w_password.focus();return false;}
	if(!f.w_subject.value){alert('\n제목을 입력하여 주십시오.');f.w_subject.focus();return false;}
	*/
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=user_board_form&type=<?php echo $type;?>';
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
	f.action = '{MARI_HOME_URL}/?update=user_board_form&type=d';
	f.submit();
  }
}
</script>

{# s_footer}<!--하단-->