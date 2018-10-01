<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN client_new03.tpl
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
			<h3>수정요청</h3>
				<div class="receipt_write">
					<form name="write_form" action="post" enctype="multipart/form-data">
					<input type="hidden" name="w_id" value="<?php echo $w['w_id']?>">
					<input type="hidden" name="table" value="<?php echo $table?>">
					<input type="hidden" name="type" value="w">

					<fieldset>
					<legend>문의하기</legend>
					<table id="insertTable" width="100%" summary="문의하기위한 창">
					<caption>회원가입을 위한 표</caption>
					<colgroup>
					<col width="170px">
					<col width="*">
					<col width="170px">
					<col width="*">
					</colgroup>

						<tbody>
						<tr>
							<th>회사명</th>
							<td><input type="text" id="w_1" name="w_company_name" value="<?php echo $user['w_company_name']?>"><!--(주)인투윈 소프트--></td>
							<th><label for="w_1">담당자</label></th>
							<td><input type="text" id="w_1" name="w_name" value="<?php echo $user['m_name']?>"></td>
						</tr>
						<tr>
							<th><label for="w_2">연락처</label></th>
							<td ><input type="text" id="w_2" name="w_hp" value="<?php echo $user['m_hp'];?>"></td>
							<th><label for="w_3">이메일</label></th>
							<td ><input style="width:260px;" type="text" id="w_3" name="w_email" value="<?php echo $user['m_email'];?>"></td>
						</tr>
						<tr>
							<th><label for="w_4">제목</label></th>
							<td colspan="3"><input style="width:100%;" type="text" id="w_4" name="w_subject" value="<?php echo $w['w_subject'];?>"></td>
						</tr>
						<tr>
							<th><label for="w_5">내용</label></th>
							<td colspan="3">
								<?php 
								 /*에디터 사용시에만 에디터노출*/
								if($bbs_config['bo_use_editor']=="Y"){
								?>
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<?php echo editor_html('w_content', $bbs_config['bo_insert_content']); ?>
								<?php }else{?>
									<?php echo editor_html('w_content', $w['w_content']); ?>
								<?php }?>
								<?php }else{?>
									<textarea name="w_content" id="w_5"><?php echo $w['w_content'];?></textarea>
								<?php }?>
							<!--<textarea name="w_content" id="w_5" placeholder="" ></textarea>-->
							</td>
						</tr>
						<tr>
							<th><label for="w_6">URL 입력</label></th>
							<td colspan="3"><input style="width:100%;" type="text" id="w_6" name="w_url_path" value="<?php echo $w['w_url_path']?>"></td>
						</tr>
						<tr class="file_input">
							<th>첨부파일</th>
							<td colspan="3">
								<input type="text" readonly="readonly" title="File Route" id="file_route" value="파일없음">
								<label>
									파일선택
									<input type="file" maxLength='100' name="u_img" onchange="javascript:document.getElementById('file_route').value=this.value">
										<?php
										    $viewimg_str_01 = "";
										    $view_img = MARI_DATA_PATH."/$table/".$w[file_img]."";
										    if (file_exists($view_img) && $w[file_img]) {
											$size = @getimagesize($view_img);
											if($size[0] && $size[0] > 320)
											    $width = 320;
											else
											    $width = $size[0];

											echo '<input type="checkbox" name="d_img" value="1" id="d_img"> <label for="d_img">삭제</label>';
											$viewimg_str_01 = '<img src="'.MARI_DATA_URL.'/'.$table.'/'.$w[file_img].'" width="'.$width.'">';
										    }
										    if ($viewimg_str_01) {
											echo '<div class="banner_or_img">';
											echo $viewimg_str_01;
											echo '</div>';
										    }
										 ?>
								</label>
<!-- 으악								<input type="button" value="추가" onClick="addFile(this.form)" border=0 style='cursor:hand'>
								        						<input type="button" value="삭제" onClick='deleteFile(this.form)' border=0 style='cursor:hand'>
								<script type="text/javascript">
								
									//첨부파일 추가
								    var rowIndex = 1;
								               
								    function addFile(form){
								        if(rowIndex > 4) return false;
								
								        rowIndex++;
								        var getTable = document.getElementById("insertTable");
									var oCurrentRow = getTable.insertRow(getTable.rows.length);
								        var oCurrentCell = oCurrentRow.insertCell(0);
								        oCurrentCell.innerHTML = "<INPUT TYPE='FILE' NAME='filename" + rowIndex + "' size=25>";
								    }
								   
									//첨부파일 삭제
								    function deleteFile(form){
								        if(rowIndex<2){
								            return false;
								        }else{
								        	rowIndex--;
											var getTable = document.getElementById("insertTable");
											getTable.deleteRow(rowIndex);
								       }
								    }
								    
								</script> -->


							</td>
						</tr>

					</tbody>
					</table>
					</fieldset>
					</form>

				</div><!--receipt_write f-->
				<p class="btn_hold">
					<a href="#" id="write_form_add">접수</a>
				</p>



		</div><!-- client_containerinner -->
	</div><!-- client_container -->
</div><!-- /wrapper -->

<script>
$(function(){
	$('#write_form_add').click(function(){
		Write_form_Ok(document.write_form);
	});
});

function Write_form_Ok(f){
<?php echo get_editor_js('w_content'); ?>
<?php if(!$member_ck){?>
	if(!f.w_company_name.value){alert('\n회사명을 입력하여 주십시오.');f.w_company_name.focus();return false;}
	if(!f.w_name.value){alert('\n담당자명을 입력하여 주십시오.');f.w_name.focus();return false;}
	if(!f.w_hp.value){alert('\n휴대폰번호를 입력하여 주십시오.');f.w_email.focus();return false;}
	if(!f.w_email.value){alert('\n이메일을 설정하여 주십시오.');f.w_email.focus();return false;}

	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test(f.w_email.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.w_email.focus(); return false;
	}
<?php } ?>
	if(!f.w_subject.value){alert('\n제목을 입력하여 주십시오.');f.w_subject.focus();return false;}
	if(!f.w_content.value){alert('\n내용을 입력하여 주십시오.');f.w_content.focus();return false;}
	if(!f.w_url_path.value){alert('\nURL을 입력하여 주십시오.');f.w_url_path.focus();return false;}

	f.method= 'post';
	f.action='{MARI_HOME_URL}/?update=cs_bbs_write&type=<?php echo $type?>&member_ck=<?php echo $user[m_id]?>';
	f.submit();
}
</script>

{# s_footer}<!--하단-->