<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 탈퇴회원리스트
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
		<div class="title02">회원탈퇴 목록</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>    총 탈퇴 회원수 <?php echo number_format($total_count) ?>명
		</div>

		<form id="fsearch" name="fsearch"  method="get" class="local_sch01 local_sch">
		<input type="hidden" name="cms" value="leave_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="s_name"<?php echo get_selected($_GET['sfl'], "s_name"); ?>>이름</option>
				<option value="s_id"<?php echo get_selected($_GET['sfl'], "s_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<div class="local_desc01 local_desc">
			<p>
				회원탈퇴 목록중 복구를 원하는 회원을 선택후 "선택복구"를 눌러 복구처리하실 수 있습니다.
			</p>
		</div>
	<form name="memberlist" id="memberlist" action="{MARI_HOME_URL}/?update=leave_list" onsubmit="return memberlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>회원탈퇴 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>이름</th>
						<th>아이디</th>
						<th>E 머니</th>
						<th>이메일</th>
						<th>가입일</th>
						<th>회원등급</th>
						<th>탈퇴일</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	/*레벨로 회원등급명을 가져옴*/
	$sql = "select  * from  mari_level where lv_level='$row[s_level]'";
	$lv = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="s_id[<?php echo $i ?>]" value="<?php echo $row['s_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['s_no']; ?></td>
						<td><?php echo $row['s_name']; ?></td>
						<td><?php echo $row['s_id'] ?></td>
						<td><?php echo $row['s_emoney'];?></td>
						<td><?php echo $row['s_email'];?></td>
						<td><?php echo substr($row['s_datetime'],0,10); ?></td>
						<td><?php echo $lv['lv_name'] ?></td>
						<td><?php echo substr($row['s_leave_date'],0,10); ?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">탈퇴회원 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택복구" class="select_revive_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;" onclick="document.pressed=this.value" />
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
	</form>


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function memberlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}
</script>

{# s_footer}<!--하단-->
