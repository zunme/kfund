<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 팝업목록
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">팝업등록</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">팝업등록</div>
			<fieldset>
		<form name="popup_form"  method="post" enctype="multipart/form-data">
		<input type="hidden" name="type" value="<?php echo $type;?>"/>
		<input type=hidden name=po_id value='<?php echo $pop[po_id];?>'>
				<div class="local_desc01 local_desc">
					<p>쇼핑몰 초기화면 접속 시 자동으로 뜰 팝업레이어를 설정합니다.</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>팝업등록</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>



					<tr>
						<th scope="row"><label for="nw_disable_hours">사용여부<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<span class="frm_info">체크시 팝업을 사용합니다.</span>
							<input type=checkbox class="checkbox" name=po_openchk value="1" <?php echo ($pop[po_openchk] == "1") ? "checked" : ""; ?>>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">스킨<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<span class="frm_info">팝업 스킨을 설정합니다.</span>
						<?php echo get_skin_select('popup', ''.$i, "po_skin", $pop['po_skin']); ?>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">팝업타입<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<span class="frm_info">체크시 레이어 출력.</span>
							<input type=checkbox class="checkbox" name=po_popstyle value="1" <?php echo ($pop[po_popstyle] == "1") ? "checked" : ""; ?> onclick="if (this.checked == true) document.getElementById('act_layer').style.display = 'block'; else document.getElementById('act_layer').style.display = 'none';">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">시간(OFF시간)<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<span class="frm_info">팝업을 보지않음 체크시 팝업창 OFF 시간설정.</span>
							<input type=text class="frm_input"name='po_expirehours' maxlength=4 minlength=2 required itemname='시간' value='<?php echo $pop[po_expirehours] ?>' size="4">
        <input type=radio name=po_date_chk value="24" onclick="if (this.checked == true) this.form.po_expirehours.value=this.form.po_date_chk[0].value; else this.form.po_expirehours.value = this.form.po_date_chk[0].value;">하루 
        <input type=radio name=po_date_chk value="168" onclick="if (this.checked == true) this.form.po_expirehours.value=this.form.po_date_chk[1].value; else this.form.po_expirehours.value = this.form.po_date_chk[1].value;">일주일 
        <input type=radio name=po_date_chk value="1176" onclick="if (this.checked == true) this.form.po_expirehours.value=this.form.po_date_chk[2].value; else this.form.po_expirehours.value = this.form.po_date_chk[2].value;">한달
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_begin_time">시작일시<strong class="sound_only"> 필수</strong></label></th>
						<td>
						        <input type=text class="frm_input  calendar"name=po_start_date  size=21 maxlength=19 value='<?php echo $pop[po_start_date] ?>' required itemname="시작일시">
							<input type=checkbox class="checkbox" name=po_start_chk  value="<?php echo date("Y-m-d 00:00:00", MARI_SERVER_TIME); ?>" onclick="if (this.checked == true) this.form.po_start_date.value=this.form.po_start_chk.value; else this.form.po_start_date.value = this.form.po_start_date.defaultValue;">
							<label for="nw_begin_chk">시작일시를 오늘로</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="po_end_date">종료일시<strong class="sound_only"> 필수</strong></label></th>
						<td>
			<input type=text class="frm_input calendar" name=po_end_date size=21 maxlength=19  value='<?php echo $pop[po_end_date] ?>' required itemname="종료일시">
			<input type=checkbox class="checkbox" name=po_end_chk value="<?php echo date("Y-m-d 23:59:59", MARI_SERVER_TIME+(60*60*24*7)); ?>" onclick="if (this.checked == true) this.form.po_end_date.value=this.form.po_end_chk.value; else this.form.po_end_date.value = this.form.po_end_date.defaultValue;">
							<label for="nw_end_chk">종료일시를 오늘로부터 7일 후로</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="po_left">팝업레이어 좌측 위치<strong class="sound_only"> 필수</strong></label></th>
						<td>							
						   <input type="text" name="po_left"  id="nw_left" value='<?php echo $pop[po_left] ?>' required class="frm_input required" size="5"> px
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="po_top">팝업레이어 상단 위치<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<input type="text" name="po_top" value='<?php echo $pop[po_top] ?>' id="nw_top" required class="frm_input required"  size="5"> px
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="po_width">팝업레이어 넓이<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<input type="text" name="po_width" value='<?php echo $pop[po_width] ?>' id="nw_width" required class="frm_input required" size="5"> px
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="po_height">팝업레이어 높이<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<input type="text" name="po_height" value='<?php echo $pop[po_height] ?>' id="nw_height" required class="frm_input required" size="5"> px
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_subject">팝업 제목<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<input type="text" name="po_subject" value="<?php echo $pop[po_subject] ?>" id="po_subject" required class="frm_input required" size="80">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_content">내용</label></th>
						<td>
						<?php echo editor_html('po_content', $pop['po_content']); ?>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
		</form>
				<div class="btn_confirm01 btn_confirm">
					<input type="submit" value="" class="confirm2_btn"  id="popup_form_add" title="확인"  />
					<a href="{MARI_HOME_URL}/?cms=popuplist"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록" /></a>
				</div>
			</fieldset>


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
/*필수체크*/
$(function() {
	$('#popup_form_add').click(function(){
		Popup_form_Ok(document.popup_form);
	});
});


function Popup_form_Ok(f)
{
	<?php echo get_editor_js('po_content'); ?>
	if(!f.po_start_date.value){alert('\n팝업 시작일시를 입력하여 주십시오.');f.po_start_date.focus();return false;}
	if(!f.po_end_date.value){alert('\n팝업 종료일시를 입력하여 주십시오.');f.po_end_date.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=newpopup';
	f.submit();
}


$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });
</script>
{# s_footer}<!--하단-->