<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 덧글
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->


 






							<div class="comment_wrap comment2">
								<ul class="comment1">
								<?php
								  for ($i=0; $row=sql_fetch_array($co_list); $i++) {
								?>
									<li>
										<p class="comment_info">
											<span class="nickname1"><?php echo $row['m_id'];?></span> 
											<span class="c_date1"><?php echo $row['co_regdatetime'];?></span>
											<a href="#" title="신고"><img src="{MARI_MOBILESKIN_URL}/img/co_icon1.png"alt="신고"  /></a>
										</p>
										<p class="comment_txt"><?php echo html_content($row['co_content'],'');?></p>
									</li>
								<?php
								   }
								   if ($i == 0)
								      echo "<li>의견 <span class=\"fb\">0</span>건</li>";
								?>
								</ul>
								<div class="paging">
								<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_co_page, '?mode=invest_view&loan_id='.$loan_id.''.$qstr.'&amp;page='); ?>
								</div><!-- /paging -->
								<div class="comment2">
								<form name="comment_form"  method="post" enctype="multipart/form-data">
								<input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
								<input type="hidden" name="m_id" value="<?php echo $user[m_id]; ?>">
								<input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
								<input type="hidden" name="type" value="w">

									<div class="comment2_cont">
										<textarea style="height:114px;" name="co_content"  class="form-control" id="co_content"  onkeyup="updateChar_co(<?php if(!$user[m_id]){?>1<?php }else{?>300<?php }?>, 'co_content', 'chkBite_comment');"></textarea>
										<p><span id="chkBite_comment">0</span> / 300</p>
										<img src="{MARI_MOBILESKIN_URL}/img/btn_register1.png" id="comment_form_add" style="cursor:pointer;width:100px;height:43px;" alt="등록" />
									</div>
								</form>
									
								</div>
							</div><!-- /comment_wrap -->











<script>
/*comments*/
$(function() {
	$('#comment_form_add').click(function(){
		Comment_form_Ok(document.comment_form);
	});
});


function Comment_form_Ok(f)
{
	if(!f.co_content.value){alert('\n댓글의 내용을 입력하여 주십시오.');f.co_content.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=invest_comment';
	f.submit();
}

function updateChar_co(FieldName, contentName, textlimitName){
	var strCount = 0;
	var tempStr, tempStr2;
	var frm = document.getElementById(contentName);
	var size = frm.value.length;		
	for(i = 0;i < size;i++){
		tempStr = frm.value.charAt(i);
		if(escape(tempStr).length > 4) strCount += 2;
		else strCount += 1 ;
	}
	
	if (strCount > FieldName){
		<?php if(!$user[m_id]){?>
		alert("회원 로그인후 작성하실 수 있습니다.");
		<?php }else{?>
		alert("최대 " + FieldName + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
		<?php }?>
		strCount = 0;
		tempStr2 = "";
		for(i = 0; i < size; i++){
			tempStr = frm.value.charAt(i);
			
			if(escape(tempStr).length > 4) strCount += 2;
			else strCount += 1 ;
			
			if (strCount > FieldName){
				if(escape(tempStr).length > 4) strCount -= 2;
				else strCount -= 1 ;
				break;
			} else tempStr2 += tempStr;
		}
		frm.value = tempStr2;
	}
	document.getElementById(textlimitName).innerHTML = strCount;
}

</script>