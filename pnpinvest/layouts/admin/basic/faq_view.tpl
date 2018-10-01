<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">나의서비스관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">FAQ</div>		
				<fieldset>

	<form name="faq_reple" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<?php echo $type;?>">
	<input type="hidden" name="f_id" value="<?php echo $f_id;?>">
			<div id ="server_info">
				<h2 class="bo_title"><span>답변</span></h2>
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>					
					<tr>
						<th scope="bo">분류</th>
						<td>
							<select name="f_sort">
								<option>선택하세요</option>
								<option value="1" <?php echo $faq['f_sort']=='1'?'selected':'';?>>투자</option>
								<option value="2" <?php echo $faq['f_sort']=='2'?'selected':'';?>>대출</option>
								<option value="3" <?php echo $faq['f_sort']=='3'?'selected':'';?>>일반</option>
							</select>
						</td>
					</tr>					
					<tr>
						<th scope="bo">질문</th>
						<td>
							<input type="text" name="f_question" value="<?php echo $faq[f_question];?>" id=""  class="frm_input " size="130" /> <br/>
						</td>
					</tr>
					<tr>
						<th scope="bo">답변</th>
						<td>
							<textarea name="f_answer"><?php echo $faq[f_answer];?></textarea>
						</td>
					</tr>
															
					</tbody>
					</table>
				</div>
			</div>

			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
			</div>


		</form>
			</fieldset>

    </div><!-- /contaner -->
</div><!-- /wrapper -->




<script type="text/javascript">
function sendit(){
	 var f = document.faq_reple;
	 f.method = 'post';
	 f.action = '{MARI_HOME_URL}/?update=faq&type=<?php echo $type?>';
	 f.submit();
}


</script>
{# s_footer}<!--하단-->