<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
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
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">회원메일 입력</div>
		<form name="mail_form"  method="post" enctype="multipart/form-data">
		<input type="hidden" name="type" value="<?php echo $type;?>"/>
		<input type="hidden" name="mr_id" value="<?php echo $mv['mr_id'];?>"/>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>회원메일 입력</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
					<th>메일 제목</th>
					<td><input type="text" name="mr_subject" value="<?php echo $mv['mr_subject'];?>" id=""  class="frm_input" size="97"></td>
				</tr>
				<tr>
					<th>메일 내용</th>
					<td>
						<?php echo editor_html('mr_content', $mv['mr_content']); ?>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		</form>

		<div class="local_desc02">
			<p>
				*{이름} , {닉네임} , {아이디} , {이메일} 내용에 작성하시면 해당 해당코드를 치환하여 발송합니다. 
			</p>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" id="mail_form_add" title="확인"  />
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
/*필수체크*/
$(function() {
	$('#mail_form_add').click(function(){
		Mail_form_Ok(document.mail_form);
		
	});
});


function Mail_form_Ok(f)
{	
	if(!f.mr_subject.value){alert('\n보내실 메일의 제목을 입력하여 주십시오.');f.mr_subject.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=mail_form';
	f.submit();
}



</script>
{# s_footer}<!--하단-->







