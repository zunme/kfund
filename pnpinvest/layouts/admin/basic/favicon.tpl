<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">디자인관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">로고/파비콘 설정</div>
<form name="favicon"  method="post" enctype="multipart/form-data">
		 <h2 class="bo_title"><span>파비콘 설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>파비콘 설정</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이콘 파일</th>
						<td colspan="3">
							<span class="frm_info">파일규격 : ico 확장자를 가진 16 x 16 또는 32 x 32 픽셀, 16/256/트루컬러</span> 
							    <input type="file" name="bn_bimg">
							    <?php
							    $bimg_str = "";
							    $bimg = MARI_DATA_PATH."/favicon/".$config['bn_id']."";
							    if (file_exists($bimg) && $config['bn_id']) {
								$size = @getimagesize($bimg);
								if($size[0] && $size[0] > 16)
								    $width = 16;
								else
								    $width = $size[0];

								echo '<input type="checkbox" name="bn_bimg_del" value="1" id="bn_bimg_del"> <label for="bn_bimg_del">삭제하기</label>';
								$bimg_str = '이미지 : <img src="'.MARI_DATA_URL.'/favicon/'.$config['bn_id'].'" >';
							    }
							    if ($bimg_str) {
								echo '<div class="banner_or_img">';
								echo $bimg_str;
								echo '</div>';
							    }
							    ?>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn"  id="favicon_add" title="확인"  />
		</div>


		 <h2 class="bo_title"><span>사이트/관리자 상단 로고 설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>로고 설정</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">로고 파일</th>
						<td colspan="3">
							    <input type="file" name="bn_bimg_01">
							    <?php
							    $bimg_str = "";
							    $bimg = MARI_DATA_PATH."/favicon/".$config['c_logo']."";
							    if (file_exists($bimg) && $config['c_logo']) {
								$size = @getimagesize($bimg);
								if($size[0] && $size[0] > 103)
								    $width = 103;
								else
								    $width = $size[0];

								echo '<input type="checkbox" name="bn_bimg_del_01" value="1" id="bn_bimg_del_01"> <label for="bn_bimg_del_01">삭제하기</label>';
								$bimg_str = '이미지 : <img src="'.MARI_DATA_URL.'/favicon/'.$config['c_logo'].'" >';
							    }
							    if ($bimg_str) {
								echo '<div class="banner_or_img">';
								echo $bimg_str;
								echo '</div>';
							    }
							    ?>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn"  id="logo_add" title="확인"  />
		</div>


		 <h2 class="bo_title"><span>사이트 하단 로고 설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>로고 설정</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">로고 파일</th>
						<td colspan="3">
							    <input type="file" name="bn_bimg_02">
							    <?php
							    $bimg_str = "";
							    $bimg = MARI_DATA_PATH."/favicon/".$config['c_logo_bt']."";
							    if (file_exists($bimg) && $config['c_logo_bt']) {
								$size = @getimagesize($bimg);
								if($size[0] && $size[0] > 103)
								    $width = 103;
								else
								    $width = $size[0];

								echo '<input type="checkbox" name="bn_bimg_del_01" value="1" id="bn_bimg_del_01"> <label for="bn_bimg_del_01">삭제하기</label>';
								$bimg_str = '이미지 : <img src="'.MARI_DATA_URL.'/favicon/'.$config['c_logo_bt'].'" >';
							    }
							    if ($bimg_str) {
								echo '<div class="banner_or_img">';
								echo $bimg_str;
								echo '</div>';
							    }
							    ?>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn"  id="logobt_add" title="확인"  />
		</div>
			
		 <h2 class="bo_title"><span> 메인 슬라이드 설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>로고 설정</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">슬라이드1</th>
						<td colspan="3">
						<input type="file" name="c_main_img1">
						<?php if($config[c_main_img1]){?>
							<input type="checkbox" name="d_main_01" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>							
							<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img1'];?>"  width="773" height="">							
						<?php }?>
						<br/><br/><input type="text" name="c_main_img1_url" value="<?php echo $config['c_main_img1_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
					<tr>
						<th scope="row">슬라이드2</th>
						<td colspan="3">
						<input type="file" name="c_main_img2">
						<?php if($config[c_main_img2]){?>
							<input type="checkbox" name="d_main_02" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>
							<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img2'];?>"  width="773" height="">							
						<?php }?>
						<br/><br/><input type="text" name="c_main_img2_url" value="<?php echo $config['c_main_img2_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
					<tr>
						<th scope="row">슬라이드3</th>
						<td colspan="3">
							<input type="file" name="c_main_img3">
							<?php if($config[c_main_img3]){?>
								<input type="checkbox" name="d_main_03" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>							
								<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img3'];?>"  width="773" height="">
							<?php }?>
						<br/><br/><input type="text" name="c_main_img3_url" value="<?php echo $config['c_main_img3_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
					<tr>
						<th scope="row">모바일 슬라이드1</th>
						<td colspan="3">
						<input type="file" name="c_main_img1_m">
						<?php if($config[c_main_img1_m]){?>
							<input type="checkbox" name="d_main_01_m" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>							
							<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img1_m'];?>"  width="773" height="">							
						<?php }?>
						<br/><br/><input type="text" name="c_main_img1_m_url" value="<?php echo $config['c_main_img1_m_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
					<tr>
						<th scope="row">모바일 슬라이드2</th>
						<td colspan="3">
						<input type="file" name="c_main_img2_m">
						<?php if($config[c_main_img2_m]){?>
							<input type="checkbox" name="d_main_02_m" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>
							<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img2_m'];?>"  width="773" height="">							
						<?php }?>
						<br/><br/><input type="text" name="c_main_img2_m_url" value="<?php echo $config['c_main_img2_m_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
					<tr>
						<th scope="row">모바일 슬라이드3</th>
						<td colspan="3">
							<input type="file" name="c_main_img3_m">
							<?php if($config[c_main_img3_m]){?>
								<input type="checkbox" name="d_main_03_m" value="1" id="bn_bimg_del_01"><label for="bn_bimg_del_01"></label>삭제<br/><br/>							
								<img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img3_m'];?>"  width="773" height="">
							<?php }?>
						<br/><br/><input type="text" name="c_main_img3_m_url" value="<?php echo $config['c_main_img3_m_url'];?>" id=" " class="frm_input" size="40" /> 예) http://.test.com
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn"  id="main_img_add" title="확인"  />
		</div>
</form>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


<script>
/*필수체크*/
$(function() {
	$('#favicon_add').click(function(){
		Favicon_Ok(document.favicon);
	});
});


function Favicon_Ok(f)
{

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=favicon&type=fv';
	f.submit();
}


$(function() {
	$('#logo_add').click(function(){
		Lo_Ok(document.favicon);
	});
});


function Lo_Ok(f)
{

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=favicon&type=lo';
	f.submit();
}

$(function() {
	$('#logobt_add').click(function(){
		Lobt_Ok(document.favicon);
	});
});


function Lobt_Ok(f)
{

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=favicon&type=lobt';
	f.submit();
}


$(function() {
	$('#main_img_add').click(function(){
		main_Ok(document.favicon);
	});
});


function main_Ok(f)
{

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=favicon&type=main';
	f.submit();
}


</script>


{# s_footer}<!--하단-->