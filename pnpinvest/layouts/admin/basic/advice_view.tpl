<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">자문단 등록</div>		
				<fieldset>

	<form name="faq_reple" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<?php echo $type;?>">
	<input type="hidden" name="ad_id" value="<?php echo $ad_id;?>">
			<div id ="server_info">
				<h2 class="bo_title"><span>자문단 등록</span></h2>
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
							<input type="text" name="ad_name" value="<?php echo $adv[ad_name];?>" id=""  class="frm_input " size="30" /> <br/>
						</td>
					</tr>
					<tr>
						<th>로고이미지</th>
						<td colspan="3">
						    <input type="file" name="ad_logo" size="10">
					    <?php
							    $bimg_str = "";
							    $bimg_01 = MARI_DATA_PATH."/photoreviewers/".$adv['ad_logo']."";
							    if (file_exists($bimg_01) && $adv['ad_logo']) {
								$size = @getimagesize($bimg_01);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_01" value="1" id="bn_bimg_del_01"> <label for="bn_bimg_del_01">삭제하기</label>';
								$bimg_str_01 = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$adv['ad_logo'].'" style="width:300px;" >';
							    }
						    if ($bimg_str_01) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_01;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<tr>
						<th scope="bo">연결링크</th>
						<td>
							<input type="text" name="ad_link" value="<?php echo $adv[ad_link];?>" id=""  class="frm_input " size="130" /> <br/>
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
	 var f = document.faq_reple;
	 f.method = 'post';
	 f.action = '{MARI_HOME_URL}/?update=advice_view&type=<?php echo $type?>';
	 f.submit();
}


</script>
{# s_footer}<!--하단-->