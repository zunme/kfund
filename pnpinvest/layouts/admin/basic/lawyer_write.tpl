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
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">심사원 등록 <?php if($type == "w"){ echo '등록';}else if($type=="m"){ echo '수정';}?></div>		
				<fieldset>

	<form name="lawyer_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<?php echo $type;?>">
	<input type="hidden" name="ly_id" value="<?php echo $ly_id;?>">
			<div id ="server_info">
				<h2 class="bo_title"><span>심사원 등록정보</span></h2>
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>					
					<tr>
						<th scope="bo">이름</th>
						<td>
							<input type="text" name="ly_name" value="<?php echo $lay[ly_name];?>" id=""  class="frm_input " size="10" /> <br/>
						</td>
					</tr>					
					<tr>
						<th scope="bo">휴대폰번호</th>
						<td>
							<select name="hp1">
								<option>선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="019">019</option>
							</select> -
							<input type="text" name="hp2" value="<?php echo substr($lay['ly_hp'],3,4);?>"  maxlength="4"  class="frm_input " size="7" /> -
							<input type="text" name="hp3" value="<?php echo substr($lay['ly_hp'],-3);?>"  maxlength="4"  class="frm_input " size="7" /> 
						</td>
					</tr>
					<tr>
						<th scope="bo"> 이메일</th>
						<td>							
							<input type="text" name="ly_email" value="<?php echo $lay['ly_email']?>"  class="frm_input " size="40" />
						</td>
					</tr>
					<tr>
						<th>사진</th>
						<td colspan="3">
						    <input type="file" name="ly_img" size="10">
					    <?php
							    $bimg_str = "";
							    $bimg_01 = MARI_DATA_PATH."/lawyer/".$lay['ly_img']."";
							    if (file_exists($bimg_01) && $lay['ly_img']) {
								$size = @getimagesize($bimg_01);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_01" value="1" id="bn_bimg_del_01"> <label for="bn_bimg_del_01">삭제하기</label>';
								$bimg_str_01 = '<img src="'.MARI_DATA_URL.'/lawyer/'.$lay['ly_img'].'" style="width:200px;" >';
							    }
						    if ($bimg_str_01) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_01;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<!--
					<tr>
						<th scope="bo">업체이름</th>
						<td>
							<input type="text" name="ly_company" value="<?php echo $lay[ly_company];?>" id=""  class="frm_input " size="20" /> <br/>
						</td>
					</tr>	

					<tr>
						<th>업체로고</th>
						<td colspan="3">
						    <input type="file" name="ly_company_logo" size="10">
					    <?php
							    $bimg_str2 = "";
							    $bimg_02 = MARI_DATA_PATH."/lawyer/".$lay['ly_company_logo']."";
							    if (file_exists($bimg_02) && $lay['ly_company_logo']) {
								$size = @getimagesize($bimg_02);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_02" value="1" id="bn_bimg_del_02"> <label for="bn_bimg_del_02">삭제하기</label>';
								$bimg_str_02 = '<img src="'.MARI_DATA_URL.'/lawyer/'.$lay['ly_company_logo'].'" style="width:200px;" >';
							    }
						    if ($bimg_str_02) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_02;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					-->

					<tr>
						<th scope="bo">경력</th>
						<td>
							<?php echo editor_html('ly_career', $lay['ly_career']); ?>
						</td>
					</tr>
					
					<tr>
						<th scope="bo">업무분야</th>
						<td>
							<?php echo editor_html('ly_part', $lay['ly_part']); ?>
						</td>
					</tr>									
					</tbody>
					</table>
				</div>
			</div>

			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
			</div>


		</form>
			</fieldset>

    </div><!-- /contaner -->
</div><!-- /wrapper -->




<script type="text/javascript">

function sendit(){

	 var f = document.lawyer_form;

	<?php echo get_editor_js('ly_career'); ?>
	<?php echo get_editor_js('ly_part'); ?>

	 f.method = 'post';
	 f.action = '{MARI_HOME_URL}/?update=lawyer_write&type=<?php echo $type?>';
	 f.submit();
}


</script>
{# s_footer}<!--하단-->