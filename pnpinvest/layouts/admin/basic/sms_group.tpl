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
			<div class="title01">SMS관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">SMS그룹관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  SMS그룹 : <?php echo number_format($total_count) ?>개
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="sms_group">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "sg_name"); ?>>그룹명</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<!-- <div class="btn_add01 btn_add">
			<a href="#"><img src="img/more_btn.png" alt="추가"></a>
		</div> -->
<form name="group<?php echo $res['sg_no']?>" method="post" action="{MARI_HOME_URL}/?update=sms_group" class="local_sch02 local_sch">
<input type="hidden" name="sg_no" value="<?php echo $res['sg_no']?>">
<div>
그룹추가 
    <input type="text" id="sg_name" name="sg_name" required class="required frm_input">
    <input type="image" src="{MARI_ADMINSKIN_URL}/img/more_btn.png" value="그룹추가" >
</div>
<div class="sch_last">
    <span>건수 : <?php echo $total_count; ?></span>
</div>
</form>
<form name="group_hp_form" id="group_hp_form" method="post" action="{MARI_HOME_URL}/?update=sms_group" onsubmit="return num_group_submit(this);">
<input type="hidden" name="type" value="w">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>SMS그룹목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>그룹명</th>
						<th>전체회원</th>
						<th>이동</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
						</td>
						<td><?php echo $no_group['sg_no']; ?></td>
						<td><?php echo $no_group['sg_name']?>[분류미정 그룹]</td>
						<td><?php echo number_format($g_total_count)?></td>
						<td>
            <select name="sg_no" id="sg_no" onchange="move(<?php echo $no_group['sg_no']?>, '<?php echo $no_group['sg_name']?>', this);" >
                <option value=""></option>
                <?php for ($i=0; $i<count($group); $i++) { ?>
                <option value="<?php echo $group[$i]['sg_no']?>"> <?php echo $group[$i]['sg_name']?> </option>
                <?php } ?>
            </select>
						</td>
						<td><a href="{MARI_HOME_URL}/?cms=sms_book&sg_no=1"><img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="상세보기"></a></td>
					</tr>

	<?php
    for ($i=0; $i<count($group); $i++) {
	
    ?>
    					<tr>
						<td>
            <input type="hidden" name="sg_no[<?php echo $i ?>]" value="<?php echo $group[$i]['sg_no']?>" id="sg_no_<?php echo $i ?>">
            <label for="chk_<?php echo $i ?>" class="sound_only">그룹명</label>
            <input type="checkbox" name="chk[]" value="<?php echo $i ?>" id="chk_<?php echo $i ?>">
						</td>
						<td><?php echo $no_group['sg_no']; ?></td>
						<td>
            <label for="sg_name_<?php echo $i; ?>" class="sound_only">그룹명</label>
            <input type="text" name="sg_name[<?php echo $i; ?>]" value="<?php echo $group[$i]['sg_name']?>" id="sg_name_<?php echo $i; ?>" class="frm_input">
						</td>
						<td><?php echo number_format($group[$i]['sg_count'])?></td>
						<td>
            <label for="select_sg_no_<?php echo $i; ?>" class="sound_only">이동할 그룹</label>
            <select name="select_sg_no[<?php echo $i ?>]" id="select_sg_no_<?php echo $i; ?>" onchange="move(<?php echo $group[$i]['sg_no']?>, '<?php echo $group[$i]['sg_name']?>', this);" >
                <option value=""></option>
                <option value="<?php echo $no_group['sg_no']?>"><?php echo $no_group['sg_name']?></option>
                <?php for ($j=0; $j<count($group); $j++) { ?>
                <?php if ($group[$i]['sg_no']==$group[$j]['sg_no']) continue; ?>
                <option value="<?php echo $group[$j]['sg_no']?>"> <?php echo $group[$j]['sg_name']?> </option>
                <?php } ?>
            </select>
						</td>
						<td><a href="{MARI_HOME_URL}/?cms=sms_book&sg_no=<?php echo $group[$i]['sg_no']?>"><img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="상세보기"></a></td>
					</tr>
    <?php } ?>

	
					<?php
						for($i=0; $row=sql_fetch_array($group_list); $i++){
						$sql = "select count(*) as cnt from mari_smsbook where sg_no = '$row[sg_no]'";
						$sm_cnt = sql_fetch($sql, false);
						$sm_total = $sm_cnt['cnt'];
					?>
					<tr>
					<td>
					<input type="hidden" name="sg_no[<?php echo $i ?>]" value="<?php echo $row[sg_no]?>">
					<label for="chk_<?php echo $i ?>" class="sound_only">그룹명</label>
					<input type="checkbox" name="check[]" value="<?php echo $i ?>" >
					</td>
					<td><?php echo $row[sg_no]?></td>
					<td>
					<!--
					<input type="text" class="frm_input" name="sg_name" value="<?php echo $row[sg_name]?>">
					-->
					<?php echo $row[sg_name]?>
					</td>
					<td><?php echo $sm_total?></td>
					<td>
					  <select name="select_sg_no[<?php echo $i ?>]" id="select_sg_no_<?php echo $i; ?>" onchange="move(<?php echo $group[$i]['sg_no']?>, '<?php echo $group[$i]['sg_name']?>', this);" >
						<option value=""></option>
						<option value="<?php echo $no_group['sg_no']?>"><?php echo $no_group['sg_name']?></option>
						<?php for ($j=0; $j<count($group); $j++) { ?>
						<?php if ($group[$i]['sg_no']==$group[$j]['sg_no']) continue; ?>
						<option value="<?php echo $group[$j]['sg_no']?>"> <?php echo $group[$j]['sg_name']?> </option>
						<?php } ?>
					    </select>
					</td>
					<td><a href="{MARI_HOME_URL}/?cms=sms_book&sg_no=<?php echo $row[sg_no]?>"><img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="상세보기"></a></td>
					</tr>
					<?php
						}
					?>

				</tbody>
			</table>
		</div>
			 
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" class="select_delete_btn" value="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value">
		<!--
			   <input type="submit" name="add_bt" class="select_modi_btn" value="선택수정" style="font-size:0px;" >
			    <input type="submit" name="add_bt" class="select_delete_btn" value="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value">
			    <input type="submit" name="add_bt" class="select_cancle_btn" value="선택비우기" style="font-size:0px;" onclick="document.pressed=this.value">
		-->
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
		</div> 

		<!-- <div class="local_desc02">
			<p>
				1. 목록의 체크박스를 선택하여 진행목록으로 이동하실 수 있습니다.<br />
				2. 추가+ 버튼을 눌러 직접 대출신청서를 작성하실 수 있습니다.<br />
				3. 보기를 눌러 접수된 신청서를 확인하실 수 있습니다.
			</p>
		</div> -->

	</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->




<script>

function del(sg_no) {
    if (confirm("한번 삭제한 자료는 복구할 방법이 없습니다.\n\n삭제되는 그룹에 속한 자료는 '<?php echo $no_group['sg_name']?>'로 이동됩니다.\n\n그래도 삭제하시겠습니까?"))
        location.href = 'num_group_update.php?mw=d&sg_no=' + sg_no;
}

function move(sg_no, sg_name, sel) {
    var msg = '';
    if (sel.value)
    {
        msg  = "'" + sg_name + "' 그룹에 속한 모든 데이터를\n\n'";
        msg += sel.options[sel.selectedIndex].text + "' 그룹으로 이동하시겠습니까?";

        if (confirm(msg))
            location.href = '{MARI_HOME_URL}/?update=sms_group&type=move&sg_no=' + sg_no + '&move_no=' + sel.value;
        else
            sel.selectedIndex = 0;
    }
}

function empty(sg_no) {
    if (confirm("한번 삭제한 자료는 복구할 방법이 없습니다.\n\n그룹에 속한 데이터를 정말로 비우시겠습니까?"))
        location.href = '{MARI_HOME_URL}/?update=sms_group&type=dt&mw=empty&sg_no=' + sg_no;
}

function num_group_submit(f)
{
   

    if(document.pressed == "선택삭제") {
        if(confirm("한번 삭제한 자료는 복구할 방법이 없습니다.\n\n삭제되는 그룹에 속한 자료는 '<?php echo $no_group['sg_name']?>'로 이동됩니다.\n\n그래도 삭제하시겠습니까?")) {
            f.type.value = "de";
        } else {
            return false;
        }
    }

    if(document.pressed == "선택비우기") {
        if(confirm("한번 삭제한 자료는 복구할 방법이 없습니다.\n\n그룹에 속한 데이터를 정말로 비우시겠습니까?")) {
            f.type.value = "em";
        } else {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->