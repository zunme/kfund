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
					<table class="board1">
							<colgroup>
								<col width="80px" />
								<col width="" />
								<col width="120px" />
								<col width="130px" />
								<col width="80px" />
							</colgroup>
							<thead>
								<tr>
									<th>번호</th><th class="tb_bg1">제목</th><th class="tb_bg1">작성자</th><th class="tb_bg1">작성일</th><th class="tb_bg1">조회수</th>
								</tr>
							</thead>
							<tbody>
						<?php
							/*관리자 서버접속*/
							include_once(MARI_SQL_PATH.'/master_connect.php');
							$sql = "select * from mari_write where w_table = '$w_table' order by w_datetime desc";
							$bwl = mysql_query($sql);
							for ($i=0;  $list=sql_fetch_array($bwl); $i++){
						?>
								<tr>
									<td><?php echo $list['w_id'];?></td><td class="txt_l pl30">
									<?php if(!$list['w_rink']){?>
									<a href="{MARI_HOME_URL}/?mode=board_pop&w_table=<?php echo $w_table?>&w_id=<?php echo $list[w_id]; ?>"></a>
									<?php }else{?>
									<a href="<?php echo $list['w_rink'];?>" <?php if($list['w_blank']=="Y"){?> target="_blank"<?php }?>></a>
									<?php }?>									
										<a href="{MARI_HOME_URL}/?cms=board_pop&w_table=<?php echo $w_table?>&w_id=<?php echo $list[w_id]; ?>"><?php echo $list['w_subject'];?></a>								
									</td><td><?php echo $list['w_name'];?></td><td><?php echo substr($list['w_datetime'],0,10); ?></td><td><?php echo $list['w_hit'];?></td>
								</tr>
						<?php
						}
						if ($i == 0)
							echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
						?>
							</tbody>
						</table><!-- /board1 -->
		</form>
	</div><!-- /terms_wrap -->
{# s_footer}