<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/content.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/common.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/check.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="{MARI_ADMINSKIN_URL}/js/javascript.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});
</script>
 <div class="loadingWrap">
  <img src="{MARI_HOMESKIN_URL}/img/loader.gif">
</div>
	<div class="terms_wrap">		
		<div class="terms_logo"><img src="http://eventtpl01.esmfintech.co.kr/eventtpl01/data/favicon/logo(2).png"  alt=""/></div><br/><br/><br/>
		
		<form name="platForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="w_table" value="<?php echo $w_table?>">
		<input type="hidden" name="w_id" value="<?php echo $w_id?>">
		<table class="board_view1">
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<?php
				if(!$ftp_id){
			?>
			<tbody>
				<tr>
					<th colspan="6" class="bo_title1"><?php echo $plat['w_subject'];?></th>
				</tr>
				<tr>
					<th>작성자 :</th><td><?php echo $plat['w_name'];?></td><th>조회수 :</th><td><?php echo $w['w_hit'];?></td><th>등록일 :</th><td><?php echo substr($plat['w_datetime'],0,10); ?></td>
				</tr>
			<?php 
				/*파일 다운로드 권한이 있을경우에만 노출*/
				if($user['m_level']>=$bbs_config['bo_download_level']){
			?>
				<?php if(!$plat[file_img]==""){?>
				<tr>
					<th>첨부파일 :</th><td colspan="5"><a href="<?php echo $dw_file;?>">다운로드</a></td>
				</tr>
				<?php }?>
			<?php }?>
				<tr>
					<td colspan="6" class="bo_cont1"><?php echo $plat['w_content'];?></td>
				</tr>
			</tbody>
			<?php } else{?>
			<tbody>
				<tr>
					<th colspan="6" class="bo_title1">
					<?php if($type == 'w' || $type=="m"){?>
							제목 &nbsp&nbsp&nbsp&nbsp&nbsp : <input type="text" name="cv_subject" size="100" value="<?php echo $cv['cv_subject']?>">
					<?php }else{
							echo '제목&nbsp&nbsp&nbsp&nbsp&nbsp:'.$cv['cv_subject'];
					 }?>
					</th>
				</tr>
				<tr>
					
					
					<th colspan="6" class="bo_title1">
					웹 주소 : 
					<?php if($type=="w" || $type=="m"){?>
						<input type="text" name="cv_webaddr" size="100" value="<?php echo $cv['cv_webaddr']?>">
					<?php }else{
						echo $cv['cv_webaddr'];
					}?>					
					</th>
				</tr>
				<!--
				<tr>
					<th>
					첨부파일 :
					<?php if($type=="w" || $type=="m"){?>
						<input type="file" name="cv_file1">
						<?php
							$bimg_str = "";
							$bimg = MARI_DATA_PATH."/photoreriewers/".$cv['cv_file1']."";
							if (file_exists($bimg) && $cv['cv_file1']) {
							$size = @getimagesize($bimg);
							if($size[0] && $size[0] > 16)
							$width = 16;
							else
							$width = $size[0];
							echo '<input type="checkbox" name="d_img_01" value="1" id="bn_bimg_del"> <label for="bn_bimg_del">삭제하기</label>';
							$bimg_str = '<img src="'.MARI_DATA_URL.'/photoreriewers/'.$cv['cv_file1'].'" width="700" height="700">';
							}
							if ($bimg_str) {
							echo '<div class="banner_or_img">';
							echo $bimg_str;
							echo '</div>';
							}
						?>
					<?php }else{
						if(!$cv['cv_file1']){
							echo '등록된 파일 없음';
						}else{
							echo $viewimg_str_01 = '<img src="'.MARI_DATA_URL.'/photoreriewers/'.$cv[cv_file1].'" height="300" width="300">'; 
						}
					}?>	
					</th>
				</tr>
				-->
				<tr>
					<td colspan="6" class="bo_cont1">
					<?php if($type=="w" || $type=="m"){?>
						<?php echo editor_html('cv_content', $cv['cv_content']); ?>
					<?php }else{
						echo $cv['cv_content'];
					}?>	
					
					</td>
				</tr>
			</tbody>
			<?php }?>
		</table><!-- /board_view1 -->		
		<a href="{MARI_HOME_URL}/?cms=board_list_pop&w_table=<?php echo $w_table;?>"><img src="{MARI_HOMESKIN_URL}/img/list_btn.png" alt="목록" /></a>
		</form>
	</div><!-- /terms_wrap -->
{# s_footer}