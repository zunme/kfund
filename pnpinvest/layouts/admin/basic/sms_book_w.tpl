<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN SMS전화번호 추가
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">전화번호 추가</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">전화번호 추가</div>
			<fieldset>
			<form name="book_form" id="book_form" method="post" action="{MARI_HOME_URL}/?update=sms_book_w">
			<input type="hidden" name="type" value="<?php echo $type?>">
			<input type="hidden" name="page" value="<?php echo $page?>">
			<input type="hidden" name="ap" value="<?php echo $ap?>">
			<input type="hidden" name="sb_no" value="<?php echo $write['sb_no']?>">
			<input type="hidden" name="m_id" id="m_id" value="<?php echo $write['m_id']?>">
			<input type="hidden" name="get_sg_no" value="<?php echo $sg_no?>">
				<div class="local_desc01 local_desc">
					<p>SMS보내실 전화번호를 추가합니다.</p>
				</div>

				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>전화번호 추가</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>

					<tr>
						<th scope="row"><label for="po_end_date">업데이트날짜<strong class="sound_only"> 필수</strong></label></th>
						<td>
						<?php echo $write['sb_datetime']?>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">그룹<strong class="sound_only"> 필수</strong></label></th>
						<td>
						    <select name="sg_no" id="sg_no" required class="required">
							<option value="1"><?php echo $no_group['sg_name']?> (<?php echo number_format($g_total_count)?> 명) 미분류</option>
							<?php
							$qry = sql_query("select * from mari_smsgroup where sg_no> 1 order by sg_name");
							while($res = sql_fetch_array($qry)) {
							?>
							<option value="<?php echo $res['sg_no']?>" <?php echo $res['sg_no']==$write['sg_no']?'selected':''?>> <?php echo $res['sg_name']?>  (<?php echo number_format($res['sg_count'])?> 명) </option>
							<?php } ?>
						    </select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">이름<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<input type="text" name="sb_name" id="sb_name" maxlength="50" value="<?php echo $write['sb_name']?>"  required class="frm_input required" size="30">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">휴대폰번호<strong class="sound_only"> 필수</strong></label></th>
						<td>
						    <input type="text" name="sb_hp" value="<?php echo $write['sb_hp']?>" required class="frm_input required" size="30">
						    <?php if( count($exist_hplist) ) { // 중복되는 목록이 있다면 ?>
						    <div id="hp_check_el">
							<ul>
							<?php

							foreach( $exist_hplist as $v ) {

							    if( empty($v) ) continue;
							    $href = G5_ADMIN_URL."/member_form.php?w=u&amp;m_id=$v[m_id]";
							?>
							    <li><strong>중복됨 </strong><a href="<?php echo $href; ?>" target="_blank"><?php echo $v['m_id']; ?></a></li>
							<?php
							}
							?>
							</ul>
						    </div>
						    <?php } ?>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_disable_hours">수신여부<strong class="sound_only"> 필수</strong></label></th>
						<td>
							<span class="frm_info">SMS수신여부를 설정합니다.</span>
							    <input type="radio" name="sb_receipt" id="sb_receipt_1" value="1" <?php echo $write['sb_receipt']?'checked':''?>>
							    <label for="sb_receipt_1">수신허용</label>
							    <input type="radio" name="sb_receipt" id="sb_receipt_2" value="0" <?php echo !$write['sb_receipt']?'checked':''?>>
							    <label for="sb_receipt_2">수신거부</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_begin_time">아이디<strong class="sound_only"> 필수</strong></label></th>
						<td>
						 <?php 
							if(!$write['m_id']){
						?>
							<input type="text" name="m_id" value="" required class="frm_input required" size="30">
						<?php
							}else{
							  echo $write['m_id'];
							}
						?>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="nw_content">메모</label></th>
						<td><?php echo editor_html('sb_memo', $write['sb_memo']); ?></td>
					</tr>
					</tbody>
					</table>
				</div>
				<div class="btn_confirm01 btn_confirm">
					<input type="submit" value="" class="confirm2_btn"   title="확인"  />
					<a href="{MARI_HOME_URL}/?cms=sms_book"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록" /></a>
				</div>
		</form>
			</fieldset>


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function book_submit(){
    var f = document.book_form;
    var regExp_hp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

    if(!f.sb_hp.value){
        f.sb_hp.focus();
        alert("휴대폰번호를 입력하세요.");
        return false;
    } else if ( !regExp_hp.test(f.sb_hp.value) )
    {
        f.sb_hp.focus();
        alert("휴대폰번호 입력이 올바르지 않습니다.");
        return false;
    }

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=sms_book_w';
	f.submit();
}
</script>
{# s_footer}<!--하단-->