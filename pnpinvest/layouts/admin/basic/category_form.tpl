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
			<div class="title01">디자인관리</div>
				{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">카테고리  수정</div>
		 
		 
		<form name="category_form"  method="post" enctype="multipart/form-data">
		<input type="hidden" name="type" value="<?php echo $type;?>"/>
		<input type="hidden" name="ca_num" value="<?php echo $site_num;?>"/>
		<input type="hidden" name="ca_pk" value="<?php echo $ca_pk;?>"/>
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>카테고리  수정</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>카테고리 ID</th>
						<td>
							<span class="color_bl fb">
						<?php if($ca_num=="1"){?>
						<input type="hidden" name="ca_id" value="<?php echo $gro['ca_id'];?>"/>
						<span class="fb"><?php echo $gro['ca_id'];?></span>
						<?php }else if($ca_num=="2"){?>
						<input type="hidden" name="ca_id" value="<?php echo $gro['ca_id'];?>"/>
						<input type="hidden" name="ca_sub_id" value="<?php echo $gro['ca_sub_id'];?>"/>
						<span class="fb"><?php echo $gro['ca_id'];?> > <?php echo $gro['ca_sub_id'];?></span>
						<?php }else if($ca_num=="3"){?>
						<input type="hidden" name="ca_id" value="<?php echo $gro['ca_id'];?>"/>
						<input type="hidden" name="ca_ssub_id" value="<?php echo $gro['ca_ssub_id'];?>"/>
						<span class="fb"><?php echo $gro['ca_id'];?> > <?php echo $gro['ca_sub_id'];?> > <?php echo $gro['ca_ssub_id'];?></span>
						<?php }else{?>
						<input type="text" name="ca_id" value="<?php echo $gro['ca_id'];?>" id=""  class="frm_input " size="30" />
						<?php }?>
							</span>
							<!-- <td>
							<input type="text" name="" value="" id=""  class="frm_input " size="30" />
							<span class="ml10 fb">영문자, 숫자, _ 만 가능 (공백없이) </span>
						</td> -->
						</td>
					</tr>
				<?php if($type=="add"){?>
					<tr>
						<th>서브 카테고리 ID</th>
						<td>
							<span class="color_bl fb">
							<?php if($gro['ca_num']=="2"){?>
								<input type="text" name="ca_ssub_id" value="" id=""  class="frm_input " size="30" />
							<?php }else{?>
								<input type="text" name="ca_sub_id" value="" id=""  class="frm_input " size="30" />
							<?php }?>
							</span>
							<!-- <td>
							<input type="text" name="" value="" id=""  class="frm_input " size="30" />
							<span class="ml10 fb">영문자, 숫자, _ 만 가능 (공백없이) </span>
						</td> -->
						</td>
					</tr>
				<?php }?>
					<tr>
						<th>카테고리 제목</th>
						<td>
							<input type="text" name="ca_subject" value="<?php echo $gro['ca_subject'];?>" id=""  class="frm_input " size="30" />
						</td>
					</tr>
					<tr>
						<th>카테고리 관리자</th>
						<td>
						<input type="text" name="ca_admin" value="<?php echo $gro['ca_admin'];?>" id=""  class="frm_input " size="30" />
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" id="category_form_add" title="확인"  />
			<a href="{MARI_HOME_URL}/?cms=category_list">
				<img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
				
		</div>
		</form>
 
    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#category_form_add').click(function(){
		Ctegory_form_Ok(document.category_form);
		
	});
});


function Ctegory_form_Ok(f)
{	
	if(!f.ca_id.value){alert('\n카테고리명을 입력하여 주십시오.');f.ca_id.focus();return false;}
	if(!f.ca_subject.value){alert('\n카테고리 제목을 입력하여 주십시오.');f.ca_subject.focus();return false;}	


	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=category_form';
	f.submit();
}



</script>

{# s_footer}<!--하단-->

