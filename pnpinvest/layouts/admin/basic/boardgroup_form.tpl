<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 메인중앙
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">게시판관리</div>
				{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">게시판그룹  수정</div>
		 
		 
		 <form name="boardgroup_form"  method="post" enctype="multipart/form-data">

		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>게시판그룹  수정</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>그룹 ID</th>
						<td>
							<span class="color_bl fb">
						<?php if($type=="m"){?>
						<input type="hidden" name="gr_id" value="<?php echo $gro['gr_id'];?>"/>
						<span class="fb"><?php echo $gro['gr_id'];?></span>
						<?php }else{?>
						<input type="text" name="gr_id" value="<?php echo $gro['gr_id'];?>" id=""  class="frm_input " size="30" />
						<?php }?>
							</span>
							<!-- <td>
							<input type="text" name="" value="" id=""  class="frm_input " size="30" />
							<span class="ml10 fb">영문자, 숫자, _ 만 가능 (공백없이) </span>
						</td> -->
						</td>
					</tr>
					<tr>
						<th>그룹 제목</th>
						<td>
							<input type="text" name="gr_subject" value="<?php echo $gro['gr_subject'];?>" id=""  class="frm_input " size="30" />
							<?php if($type=="m"){?>
							<a href="{MARI_HOME_URL}/?cms=board_form&type=w&gr_subject=<?php echo $gro['gr_subject'];?>">
								<img src="{MARI_ADMINSKIN_URL}/img/board_create_btn.png" alt="게시판생성" />
							</a>
							<?php }?>
							 
						</td>
					</tr>
					<tr>
						<th>그룹 관리자</th>
						<td>
						<input type="text" name="gr_admin" value="<?php echo $gro['gr_admin'];?>" id=""  class="frm_input " size="30" />
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" id="boardgroup_form_add" title="확인"  />
			<a href="{MARI_HOME_URL}/?cms=boardgroup_list">
				<img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
				
		</div>
		</form>
 
    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#boardgroup_form_add').click(function(){
		Boardgroup_form_Ok(document.boardgroup_form);
		
	});
});


function Boardgroup_form_Ok(f)
{	
	if(!f.gr_id.value){alert('\n게시판명을 입력하여 주십시오.');f.gr_id.focus();return false;}
	if(!f.gr_subject.value){alert('\n게시판 제목을 입력하여 주십시오.');f.gr_subject.focus();return false;}	


	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=boardgroup_form&type=<?php echo $type;?>';
	f.submit();
}



</script>

{# s_footer}<!--하단-->

