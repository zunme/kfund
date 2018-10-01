<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
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
		<div class="title02">페이지보안 설정</div>

		 <h2 class="bo_title"><span>페이지보안 설정</span></h2>
<form name="page_security"  method="post" enctype="multipart/form-data">
		<div class="tbl_frm01 tbl_wrap">
			<table>
			<caption>페이지보안 설정</caption>
			<colgroup>
				<col width="200px" />
				<col width="" />
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">오른쪽 마우스 차단</th>
				<td>
					<span class="frm_info">사용시 오른쪽 마우스 버튼을 클릭하지 못하게 합니다.</span>			
			<input type="radio" name="right_mouse" value="Y" id="right_mouse" <?php if($config['right_mouse']=="Y"){?>checked<?php } ?>/> 사용 
			<input type="radio" name="right_mouse" value="N" id="right_mouse" <?php if($config['right_mouse']=="N"){?>checked<?php } ?>/> 사용 안함
				</td>
			</tr>
			<tr>
				<th scope="row">페이지 긁기 방지</th>
				<td>
					<span class="frm_info">사용시 텍스트, 기타 컨텐츠 내용을 긁을 수 없게 합니다.</span>
			<input type="radio" name="page_notdrag" value="Y" id="page_notdrag" <?php if($config['page_notdrag']=="Y"){?>checked<?php } ?>/> 사용 
			<input type="radio" name="page_notdrag" value="N" id="page_notdrag" <?php if($config['page_notdrag']=="N"){?>checked<?php } ?>/> 사용 안함
				</td>
			</tr>
			<tr>
				<th scope="row">페이지선택/드래그 방지</th>
				<td>
					<span class="frm_info">사용시 마우스선택, 드래그를 방지할 수 있습니다.</span>
			<input type="radio" name="frame_url" value="Y" id="frame_url" <?php if($config['frame_url']=="Y"){?>checked<?php } ?>/> 사용 
			<input type="radio" name="frame_url" value="N" id="frame_url" <?php if($config['frame_url']=="N"){?>checked<?php } ?>/> 사용 안함
				</td>
			</tr>
			</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" title="확인" id="page_security_add" />
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->


<script>
/*필수체크*/
$(function() {
	$('#page_security_add').click(function(){
		Page_security_Ok(document.page_security);
	});
});


function Page_security_Ok(f)
{

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=page_security';
	f.submit();
}



</script>

{# s_footer}<!--하단-->