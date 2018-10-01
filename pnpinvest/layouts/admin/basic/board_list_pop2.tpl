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
		<input type="hidden" name="ftp_id" value="<?php echo $ftp_id;?>">
					<table class="board1">
							<colgroup>
								<col width="5%" />
								<col width="30%" />
								<col width="10%" />
								<col width="20%" />
								<col width="80px" />
							</colgroup>
							<thead>
								<tr>
									<th>번호</th><th class="tb_bg1">제목</th><th class="tb_bg1">담당자</th><th class="tb_bg1">접수일</th><th class="tb_bg1">처리상태</th>
								</tr>
							</thead>
							<tbody>
						<?php
							/*관리자 서버접속*/
							include_once(MARI_SQL_PATH.'/master_connect.php');
							$sql = "select * from mari_conservatism where ftp_id = '$ftp_id'";
							$cv = mysql_query($sql);
							
							for ($i=0;  $row=sql_fetch_array($cv); $i++){
						?>
								<tr>
									<td><?php echo $row['cv_id'];?></td>
									<td><a href="{MARI_HOME_URL}/?cms=board_pop2&ftp_id=<?php echo $ftp_id;?>&cv_id=<?php echo $row['cv_id'];?>"><?php echo $row['cv_subject'];?></a></td>
									<td><?php echo $row['cv_person'];?></td>
									<td><?php echo substr($row['cv_datetime'],0,10);?></td>
									<td>
									<?php 
										if($row['cv_condition']=='1'){ echo '접수';}
										else if($row['cv_condition']=='2'){ echo '처리중';}
										else { echo '처리완료';}
									?>
									</td>
								</tr>
						<?php
						}
						if ($i == 0){
						?>
								 <tr><td colspan="5">게시물이 없습니다.</td></tr>
						<?php }?>
						
							</tbody>
						</table><!-- /board1 -->
						<a href="{MARI_HOME_URL}/?cms=board_pop2&ftp_id=<?php echo $ftp_id;?>&type=w"><img src="{MARI_HOMESKIN_URL}/img/write_btn.png"></a>
		</form>
	</div><!-- /terms_wrap -->
{# s_footer}