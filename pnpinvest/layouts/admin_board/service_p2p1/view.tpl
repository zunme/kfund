<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
if ($_COOKIE['ck_id'] != $id)
	{
		$sql = " update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
		sql_query($sql);
		// 하루 동안만
		setcookie('ck_id',$id,time()+600,'/');
	}
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN client_new04.tpl
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
	<div id="client_container">
		<div class="client_containerinner">
		
			<h3>문의요청 확인</h3>
			<div class="ok">
					<div class="receipt_write c_receipt_write" style="border-top: 3px solid #f39c12;">
						<div class="title">
							<h5>접수내용</h5>
						</div>
						<form action="" method="">
						<fieldset>
						<legend>접수내용</legend>
						<table width="100%" summary="접수내용을 위한 창">
						<caption>접수내용</caption>
						<colgroup>
						<col width="170px">
						<col width="">
						</colgroup>
							<tbody>
							
							<tr>
								<th>담당자</th>
								<!--<td><?php echo $w['staff_name'];?></td>-->
								<td><?php echo $user['m_name']?></td>
							</tr>
							<tr>
								<th>연락처</th>
								<td><?php echo $w['w_hp']?></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><?php echo $w['w_email']?></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><?php echo $w['w_subject']?></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><?php echo $w['w_content']?></td>
							</tr>
							<tr>
								<th>URL</th>
								<?php 
								if(substr($w['w_url_path'],0,7)=="http://" || substr($w['w_url_path'],0,8)=="https://"){
									$url_path = $w['w_url_path'];
								}else{
									$url_path = "http://".$w['w_url_path'];
								}?>
								<td ><a style="display:block; width:700px; overflow-x: scroll;" href="<?php echo $url_path?>" target="_blank"><?php echo $w['w_url_path']?></a></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td ><a href="{MARI_DATA_URL}/<?php echo $table?>/<?php echo $w[file_img];?>" download target="_blank"><?php echo $w[file_img];?></a></td>
							</tr>

						</tbody>
						</table>
						</fieldset>
						</form>
					</div><!-- receipt_write -->

						
				{#cs_bbs_comment}	
			
			</div><!-- ok f -->













		</div><!-- client_containerinner -->
	</div><!-- client_container -->
</div><!-- /wrapper -->
<script>


	$(function() {
		$('#w_2').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});
	
	

</script>
{# s_footer}<!--하단-->