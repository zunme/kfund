<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN sms 전화번호,그룹선택
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/check.js"></script>
	<form name="smsgrouplist" id="smsgrouplist" action="{MARI_HOME_URL}/?update=sms_book_search" onsubmit="return smsgrouplist_submit(this);" method="post">
	<input type="hidden" name="sg_no" value="<?php echo $sg_no?>">
	<input type="hidden" name="type" value="gr" >
				<h3 class="s_title1">SMS 회원추가</h3>

				<div class="tbl_head01">
					<table class="txt_c">
						<caption>SMS 회원추가</caption>
						<colgroup>
							<col width="50px" />
							<col width="50px" />
							<col width="120px" />
							<col width="" />
							<col width="120px" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
								<th>NO</th>
								<th>회원명</th>
								<th>아이디</th>
								<th>휴대폰번호</th>
								<th>SMS수신여부</th>
							</tr>
						</thead>
						<tbody>
<?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	$memh = sql_fetch("select m_hp from mari_member where m_no='$row[m_no]'");
		/*휴대폰번호 분리*/
		$m_hp = $memh['m_hp'];
		$hp1=substr($m_hp,0,3);
		$hp2=substr($m_hp,3,-4);
		$hp3=substr($m_hp,-4);
	$num=$i+1;
?>
    					<tr>
						<td>
            <input type="hidden" name="m_no[<?php echo $i ?>]" value="<?php echo $row['m_no']?>" >
            <input type="hidden" name="m_name[<?php echo $i ?>]" value="<?php echo $row['m_name']?>" >
            <input type="hidden" name="m_id[<?php echo $i ?>]" value="<?php echo $row['m_id']?>" >
            <input type="hidden" name="m_sms[<?php echo $i ?>]" value="<?php echo $row['m_sms']?>" >
            <input type="hidden" name="m_hp[<?php echo $i ?>]" value="<?php echo $hp1?>-<?php echo $hp2?>-<?php echo $hp3?>" >
            <input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $num; ?></td>
						<td>
						 <?php echo $row['m_name']?>
						</td>
						<td> <?php echo $row['m_id']?></td>
						<td><?php echo $hp1?>-<?php echo $hp2?>-<?php echo $hp3?></td>
						<td> <?php if($row['m_sms']=="1"){?>수신허용<?php }else{?>수신안함<?php }?></td>
					</tr>
    <?php } ?>
						</tbody>
					</table>
		<div class="btn_list01 btn_list pt15">
				<input type="submit" name="add_bt" class="add_number_btn" value="선택추가" style="font-size:0px;" onclick="document.pressed=this.value">
		</div>
			<!--패이징--><!--<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>-->
	</form>
<script>
function smsgrouplist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}
</script>


