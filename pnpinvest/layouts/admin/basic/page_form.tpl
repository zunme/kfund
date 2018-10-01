<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 페이지추가및 수정
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">페이지관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">페이지 추가</div>


<form name="page_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="<?php echo $type;?>">
<?php if($type=="m"){?>
<input type="hidden" name="p_id" value="<?php echo $page['p_id'];?>">
<?php }?>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>페이지 수정</caption>
				<colgroup>
					<col width="40px" />
					<col width="160px;" />
					<col width="" />
				</colgroup>
				<tbody>
				<?php if($type=="m"){?>
					<tr>
						<th>페이지코드</th>
						<td><?php echo $page['p_id'];?></td>
					</tr>
				<?php }?>
					<tr>
						<th>페이지 제목</th>
						<td>
						<input type="text" name="p_subject" value="<?php echo $page['p_subject'];?>" id=""  class="frm_input " size="30" required/>
						</td>
					</tr>
					<tr>
						<th>페이지경로</th> 
						<td>
							<a href="{MARI_HOME_URL}/?mode=content&pg=<?php echo $page['p_id'];?>"><span class="fb">{MARI_HOME_URL}/?mode=content&pg=</span></a><?php if($type=="m"){?><?php echo $page['p_id'];?><?php }else{?><input type="text" name="p_id" value="<?php echo $page['p_id'];?>" id=""  class="frm_input " size="30" /><?php }?>
						</td>
					</tr>

					<tr>
						<th>상단 컨트롤러</th> 
						<td>
							<select name="p_header">
								<option value="">선택</option>
								<?php 
									for ($i=0;  $row=sql_fetch_array($incexe); $i++){
								?>
									<option value="<?php echo $row['p_id']; ?>" <?php echo $row['p_id']==$page['p_header']?'selected':'';?>><?php echo $row['p_id'];?></option>
								<?php }?>
							</select>

							<!--<input type="text" name="p_header" value="<?php echo $page['p_header'];?>" id=""  class="frm_input " size="20"required />-->
							<span class="ml10 fb">페이지 상단 레이아웃 기본값) header</span>
						</td>
					</tr>
					<tr>
						<th>하단 컨트롤러</th> 
						<td>
							<select name="p_footer">
								<option value="">선택</option>
								<?php 
									for ($i=0;  $row=sql_fetch_array($incexe_01 ); $i++){
								?>
									<option value="<?php echo $row['p_id']; ?>" <?php echo $row['p_id']==$page['p_footer']?'selected':'';?>><?php echo $row['p_id'];?></option>
								<?php }?>
							</select>
						<!--<input type="text" name="p_footer" value="<?php echo $page['p_footer'];?>" id=""  class="frm_input " size="20" required/>-->
							<span class="ml10 fb">페이지 하단 레이아웃 기본값) footer</span>
						</td>
					</tr>
					<tr>
						<th>좌측 컨트롤러</th> 
						<td>
							<select name="p_lnb">
								<option value="">선택</option>
								<?php 
									for ($i=0;  $row=sql_fetch_array($incexe_02 ); $i++){
								?>
									<option value="<?php echo $row['p_id']; ?>" <?php echo $row['p_id']==$page['p_lnb']?'selected':'';?>><?php echo $row['p_id'];?></option>
								<?php }?>
							</select>
						<!--<input type="text" name="p_lnb" value="<?php echo $page['p_lnb'];?>" id=""  class="frm_input " size="20" />-->
							<span class="ml10 fb">페이지 좌측 레이아웃 기본값) lnb</span>
						</td>
					</tr>
					<tr>
						<th>사용여부</th> 
						<td>
						<input type=checkbox class="checkbox" name=p_page_use value="Y" <?php echo ($page[p_page_use] == "Y") ? "checked" : ""; ?>> <span class="color_bl ml10 fb">체크시 페이지를 사용합니다.</span>
						</td>
					</tr>
					<tr>
						<th>페이지내용</th>
						<td>
					<?php if($type=="m"){?>
						<span class="ml10 fb">페이지 코딩후 저장시 {MARI_HOMESKIN_PATH}/<?php echo $page['p_id'];?>.tpl 경로에 실제파일이 생성됩니다.</span>
					<?php }else{?>
						<span class="ml10 fb">페이지 코딩후 저장시 {MARI_HOMESKIN_PATH}/<?php echo $page['p_id'];?> 경로에 실제파일이 생성됩니다.</span>
					<?php }?>
						<?php echo editor_html('p_content', $page['p_content']); ?>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
				
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn"  id="board_form_add" title="확인"  />
			<a href="{MARI_HOME_URL}/?cms=management_page"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록" /></a>
			
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#board_form_add').click(function(){
		Page_form_Ok(document.page_form);
	});
});


function Page_form_Ok(f)
{
	if(!f.p_subject.value){alert('\n페이지 제목을 주십시오.');f.p_subject.focus();return false;}
<?php if($type=="w"){?>
	if(!f.p_id.value){alert('\n페이지 코드를 주십시오.');f.p_id.focus();return false;}
<?php }?>
	if(f.p_header[0].selected == true){alert('\n페이지 상단경로를 선택하여 주십시오');return false;}
	if(f.p_footer[0].selected == true){alert('\n페이지 하단경로를 선택하여 주십시오');return false;}
	if(f.p_lnb[0].selected == true){alert('\n페이지 좌측경로를 선택하여 주십시오');return false;}
	/*
	if(!f.p_header.value){alert('\n페이지 상단경로를 주십시오.');f.p_header.focus();return false;}
	if(!f.p_footer.value){alert('\n페이지 하단경로를 주십시오.');f.p_footer.focus();return false;}
	if(!f.p_lnb.value){alert('\n페이지 좌측경로를 주십시오.');f.p_lnb.focus();return false;}
	*/
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=page_form';
	f.submit();
}



</script>
{# s_footer}<!--하단-->

