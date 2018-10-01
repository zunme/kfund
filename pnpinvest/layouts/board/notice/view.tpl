<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<?php
	if ($_COOKIE['ck_id'] != $id)
		{
			$sql = "update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
			sql_query($sql);

			set_cookie("ck_id", $id, 60*60*24);
		}
?>
{#new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t2"><span class="motion" data-animation="flash"><?php echo $bbs_config["bo_subject"]?></span></h2>
	<!-- 펀딩 공지사항 -->
	<div class="board">
		<div class="container">
			<!-- 컨텐츠 본문 -->
			<div class="board_view">
				<div class="bv_header">
					<h3><?php echo $w['w_subject'];?></h3>
					<span class="date"><?php echo substr($w['w_datetime'],0,10); ?></span>
				</div>
				<div class="bv_body">
					<?php if($w[file_img]){?>
					<img src="/pnpinvest/data/<?php echo $table;?>/<?php echo $w[file_img]?>" alt="">
					<?php }?>

					<?php echo $w['w_content'];?>
					<?php if( $w['w_rink'] != '' && false){?>
						<p><a href="<?php echo $w['w_rink']?>" target="_blank">자세히 보기 &gt;</a></p>
					<?php }?>
				</div>
			</div>
			<p class="bv_footer"><a href="javascript:;" class="btn" onClick="javascript:history.back(-1);">목록</a></p>
			<script>
			window.onload=function(){
				var img = $(".bv_body img");
				img.each(function() {
					var imgWidth = $(this).width();
					$(this).css('max-width',imgWidth).css('width','100%');
				});
			}
			</script>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}<!--하단-->
