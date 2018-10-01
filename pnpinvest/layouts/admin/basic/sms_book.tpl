<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN SMS전화번호관리
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
		<div class="title02">SMS전화번호관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  SMS전화번호 : <?php echo number_format($total_count) ?>개
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="sms_book">
			<label for="" class="sound_only">검색대상</label>
			<select name="st">
			    <option value="all"<?php echo get_selected('all', $st); ?>>이름 + 휴대폰번호</option>
			    <option value="name"<?php echo get_selected('name', $st); ?>>이름</option>
			    <option value="hp" <?php echo get_selected('hp', $st); ?>>휴대폰번호</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="sv" value="<?php echo $sv?>" id="sv" required class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>
		<form name="search_form"  class="local_sch01 local_sch">
		그룹보기 
		<label for="sg_no" class="sound_only">그룹명</label>
		<select name="sg_no" id="sg_no" onchange="location.href='{MARI_HOME_URL}/?cms=sms_book&sg_no='+this.value;">
		    <option value=""<?php echo get_selected('', $sg_no); ?>> 전체 </option>
		    <option value="<?php echo $no_group['sg_no']?>"<?php echo get_selected($sg_no, $no_group['sg_no']); ?>> <?php echo $no_group['sg_name']?> (<?php echo number_format($g_total_count)?> 명) 미분류</option>
		    <?php for($i=0; $i<count($group); $i++) {?>
		    
		    <option value="<?php echo $group[$i]['sg_no']?>"<?php echo get_selected($sg_no, $group[$i]['sg_no']);?>> <?php echo $group[$i]['sg_name']?> (<?php echo number_format($group[$i]['sg_count'])?> 명) </option>
		    <?php } ?>
		</select>
		</form>





		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=sms_book_search" onclick="window.open(this.href, '','width=720, height=720, resizable=no, scrollbars=yes, status=no'); return false"><img src="{MARI_ADMINSKIN_URL}/img/member_s_btn.png" alt="회원검색"></a>
			<a href="{MARI_HOME_URL}/?cms=sms_book_w"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"></a>
		</div>
<form name="hp_manage_list" id="hp_manage_list" method="post" action="{MARI_HOME_URL}/?update=sms_book_list" onsubmit="return hplist_submit(this);" >
<input type="hidden" name="page" value="<?php echo $page; ?>">
<input type="hidden" name="token" value="<?php echo $token; ?>">
<input type="hidden" name="sw" value="">
<input type="hidden" name="type" value="del">
<input type="hidden" name="str_query" value="<?php echo $_SERVER['QUERY_STRING']?>" >
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
						<th>그룹</th>
						<th>아이디</th>
						<th>이름</th>
						<th>휴대폰</th>
						<th>수신여부</th>
						<th>날짜</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				    <?php if (!$total_count) { ?>
				    <tr>
					<td colspan="<?php echo $colspan?>" >전화번호 리스트가 없습니다.</td>
				    </tr>
				    <?php
				    }
				    $line = 0;
				    $qry = sql_query("select * from mari_smsbook where 1 $sql_group $sql_search $sql_korean $sql_no_hp order by sb_no desc limit $page_start, $page_size");
				    while($res = sql_fetch_array($qry))
				    {
				    $line+=1;

					$tmp = sql_fetch("select sg_name from mari_smsgroup where sg_no='{$res['sg_no']}'");
					$group_name = $tmp['sg_name'];
				    ?>
					<tr>
						<td>
						<input type="hidden" name="sb_no[<?php echo $line ?>]" value="<?php echo $res['sb_no'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $line ?>">
						</td>
						<td><?php echo number_format($vnum--)?></td>
						<td><?php echo $group_name?></td>
						<td><?php echo $res['m_id']?></td>
						<td><?php echo $res['sb_name']?></td>
						<td><?php echo $res['sb_hp']?></td>
						<td><?php echo $res['sb_receipt'] ? '<font color=blue>수신</font>' : '<font color=red>거부</font>'?></td>
						<td><?php echo $res['sb_datetime']?></td>
						<td>
            <a href="{MARI_HOME_URL}/?cms=sms_book_w&type=w&amp;sb_no=<?php echo $res['sb_no']?>&amp;page=<?php echo $page?>&amp;sg_no=<?php echo $sg_no?>&amp;st=<?php echo $st?>&amp;sv=<?php echo $sv?>&amp;ap=<?php echo $ap?>"><img src="{MARI_ADMINSKIN_URL}/img/modify3_btn.png" alt="수정"/></a>
            <a href="{MARI_HOME_URL}/?cms=sms_manage&sb_no=<?php echo $res['sb_no']?>&booklist=Y"><img src="{MARI_ADMINSKIN_URL}/img/send_btn.png" alt="발송"/></a>
						</td>
					</tr>
    <?php } ?>
				</tbody>
			</table>
		</div>
			 
		<div class="btn_list01 btn_list">
			    <input type="submit" class="select_delete_btn" name="add_bt" value="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value">
			    <input type="submit" class="select_modi_btn" name="add_bt" value="수신허용"  style="font-size:0px;" onclick="document.pressed=this.value">
			    <input type="submit" class="rejection_btn" name="add_bt" value="수신거부"  style="font-size:0px;" onclick="document.pressed=this.value">
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

function book_all_checked(chk)
{
    if (chk) {
        jQuery('[name="sb_no[]"]').attr('checked', true);
    } else {
        jQuery('[name="sb_no[]"]').attr('checked', false);
    }
}

function no_hp_click(val)
{
    var url = '{MARI_HOME_URL}/?update=sms_book?sg_no=<?php echo $sg_no?>&st=<?php echo $st?>&sv=<?php echo $sv?>';

    if (val == true)
        location.href = url + '&no_hp=yes';
    else
        location.href = url + '&no_hp=no';
}


/*UPDATE*/

function hplist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 자료를 정말 삭제하시겠습니까? 삭제하신후에는 복구하실 수 없습니다.")) {
            return false;
        }
    }

    if(document.pressed == "수신허용") {
        if(!confirm("선택한 자료를 정말 수신허용하시겠습니까?")) {
            return false;
        }
    }

    if(document.pressed == "수신거부") {
        if(!confirm("선택한 자료를 정말 수신거부하시겠습니까?")) {
            return false;
        }
    }

    return true;
}



// 선택한 이모티콘 그룹 이동
function select_copy(sw, f) {
    if( !f ){
        var f = document.emoticonlist;
    }
    if (sw == "copy")
        str = "복사";
    else
        str = "이동";

    var sub_win = window.open("", "move", "left=50, top=50, width=500, height=550, scrollbars=1");

    f.sw.value = type;
    f.target = "move";
    f.action = "{MARI_HOME_URL}/?update=sms_book";
    f.submit();
}

</script>
{# s_footer}<!--하단-->