<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN sms 설정
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
		<div class="title02">디스플레이 설정</div>
	<form name="display_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="m"/>
		<h2 class="bo_title"><span>REAL TIME 설정</span></h2>
		<div class="bo_text">
			<p>
				REAL TIME의 보여지는 부분들의 상세설정을 하실 수 있습니다.
			</p>
		</div>
				
		<div class="tbl_frm01 tbl_wrap">
			<table>
			<caption>REAL TIME 상세설정</caption>
			<colgroup>
				<col width="200px" />
				<col width="" />
			</colgroup>
			<tbody>
			<tr>
				<th>노출 여부 체크</th>
				<td>
					<div class="skin_wrap" style="width:400px !important;">
						<img src="{MARI_ADMINSKIN_URL}/img/realtime_side1.png"  alt="" />
						<div class="txt_l mt10">
							<input type="checkbox" name="c_realtime_use" value="Y" <?php echo $config['c_realtime_use']=='Y'?'checked':'';?> />
							<label class="">REAL TIME 사이드 노출</label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="bo"><label for="c_sms_id">노출항목</label></th>
				<td>
					<input type="checkbox" name="realtimeitem_display_01" value="Y" <?php echo $realtimeitem_display_01=='Y'?'checked':'';?> /> 투자 
					<input type="checkbox" name="realtimeitem_display_02" value="Y" <?php echo $realtimeitem_display_02=='Y'?'checked':'';?> /> 대출 
					<input type="checkbox" name="realtimeitem_display_03" value="Y" <?php echo $realtimeitem_display_03=='Y'?'checked':'';?> /> 입금 
					<input type="checkbox" name="realtimeitem_display_04" value="Y" <?php echo $realtimeitem_display_04=='Y'?'checked':'';?> /> 정산
				</td>
			</tr>
			<tr>
				<th scope="bo"><label for="c_sms_phone">노출설정</label></th>
				<td>
					<input type="checkbox" name="displayprofile_use_01" value="Y" <?php echo $displayprofile_use_01=='Y'?'checked':'';?> /> 이름 
					<input type="checkbox" name="displayprofile_use_02" value="Y" <?php echo $displayprofile_use_02=='Y'?'checked':'';?> /> 상품(분류) 
					<input type="checkbox" name="displayprofile_use_03" value="Y" <?php echo $displayprofile_use_03=='Y'?'checked':'';?> /> 날짜 
				</td>
			</tr>
			<tr>
				<th scope="bo"><label for="c_sms_phone">속도설정</label></th>
				<td>
					롤링속도 : <input type="text" name="c_realtime_speed" value="<?php echo $config['c_realtime_speed'];?>" id=" " class="frm_input" size="10" /> 
					대기시간 : <input type="text" name="c_realtime_pause" value="<?php echo $config['c_realtime_pause'];?>" id=" " class="frm_input" size="10" /> 
				</td>
			</tr>
			<tr>
				<th scope="bo"><label for="c_sms_phone">메인노출여부</label></th>
				<td>
					<div class="skin_wrap" style="width:600px !important;">
						<img src="{MARI_ADMINSKIN_URL}/img/realtime_main1.png"  alt="" />
						<div class="txt_l mt10">
							<select name="c_mainrealtime_use" required >
								<option>선택</option>
								<option value="Y" <?php echo $config['c_mainrealtime_use']=='Y'?'selected':'';?>>노출함</option>
								<option value="N" <?php echo $config['c_mainrealtime_use']=='N'?'selected':'';?>>노출안함</option>
							</select>
						</div>
					</div>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		
		<h2 class="bo_title mt40"><span>SMS 상담 설정</span></h2>
		<div class="bo_text">
			<p>
				SMS 상담폼 노출여부를 선택하여 주십시오
			</p>
		</div>
		<div class="tbl_frm01 tbl_wrap">
			<table>
			<caption>REAL TIME 상세설정</caption>
			<colgroup>
				<col width="200px" />
				<col width="" />
			</colgroup>
			<tbody>
			<tr>
				<th>노출 여부 체크</th>
				<td>
					<div class="skin_wrap">
						<img src="{MARI_ADMINSKIN_URL}/img/sms_consult1.png"  alt="" />
						<div class="txt_c mt10">
							<input type="checkbox" name="c_smscounseling_use" value="Y" <?php echo $config['c_smscounseling_use']=='Y'?'checked':'';?> />
							<label class="">SMS상담폼 노출</label>
						</div>
					</div>
					<br/><br/>
					&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp수신번호 : &nbsp&nbsp&nbsp&nbsp<input type="text" name="c_sms_number" value="<?php echo $config['c_sms_number']?>" class="frm_input" size="15" maxlength="11">
				</td>
			</tr>
			</tbody>
			</table>
		</div>


		<h2 class="bo_title mt40"><span>상품 노출 설정</span></h2>
		<div class="bo_text">
			<p>
				상품 노출 개수를 설정하실 수 있습니다.
			</p>
		</div>
		<div class="tbl_frm01 tbl_wrap">
			<table>
			<caption>상품 노출 설정</caption>
			<colgroup>
				<col width="200px" />
				<col width="" />
			</colgroup>
			<tbody>
			<tr>
				<th>메인 상품 리스트 개수</th>
				<td>
					<input type="text" name="c_display_maincount" value="<?php echo $config['c_display_maincount'];?>" id=" " class="frm_input" size="7" /> 개
				</td>
			</tr>
			<tr>
				<th>서브 상품 리스트 개수</th>
				<td>
					<input type="text" name="c_display_subcount" value="<?php echo $config['c_display_subcount'];?>" id=" " class="frm_input" size="7" /> 개
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit_display()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
		</div>
	</form>
    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script type="text/javascript">

function sendit_display(){
	var f=document.display_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=exposure_settings';
	f.submit();
}
</script>

{# s_footer}<!--하단-->