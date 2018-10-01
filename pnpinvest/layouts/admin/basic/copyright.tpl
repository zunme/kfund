<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 카피라이트, 기타정보관리
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
		<div class="title02">하단정보 설정</div>
				<h2 class="bo_title"><span>카피라이트 설정</span></h2>
				<div class="bo_text">
					<p>
						사이트 하단에 들어갈 대표,사업자등록번호 기타 주소정보를 입력하여 주십시오.
					</p>
				</div>
		<form name="copy_form"  method="post" enctype="multipart/form-data">
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>카피라이트 입력</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
					<th>정보입력</th>
					<td>
						<?php echo editor_html('c_copyright', $config['c_copyright']); ?>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" id="copy_form_add" title="확인"  />
		</div>
				<h2 class="bo_title"><span>부가정보 설정</span></h2>
				<div class="bo_text">
					<p>
						사이트 하단에 들어갈 부가내용을 입력하여 주십시오.
					</p>
				</div>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>부가정보 입력</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
					<th>정보입력</th>
					<td>
						<?php echo editor_html('c_information', $config['c_information']); ?>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		</form>

		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn" id="info_form_add" title="확인"  />
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
/*필수체크*/
$(function() {
	$('#copy_form_add').click(function(){
		Copy_form_Ok(document.copy_form);
		
	});
});


function Copy_form_Ok(f)
{	
	<?php echo get_editor_js('c_copyright'); ?>

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=copyright&type=copy';
	f.submit();
}


/*필수체크*/
$(function() {
	$('#info_form_add').click(function(){
		Info_form_Ok(document.copy_form);
		
	});
});


function Info_form_Ok(f)
{	
	<?php echo get_editor_js('c_information'); ?>

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=copyright&type=info';
	f.submit();
}


</script>
{# s_footer}<!--하단-->







