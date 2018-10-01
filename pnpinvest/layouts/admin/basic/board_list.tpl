<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 메인중앙
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">게시판관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">게시판 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 게시판수 : <?php echo number_format($total_count) ?>개
		</div>

		<form class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="board_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="bo_table"<?php echo get_selected($_GET['sfl'], "bo_table"); ?>>table</option>
				<option value="bo_subject"<?php echo get_selected($_GET['sfl'], "bo_subject"); ?>>제목</option>
				<option value="gr_id"<?php echo get_selected($_GET['sfl'], "gr_id"); ?>>그룹ID</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text" name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">
		</form>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=board_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/more_board_btn.png" alt="게시판 추가" /></a>
		</div>
	<form name="boardlist" id="boardlist" action="{MARI_HOME_URL}/?update=board_list" onsubmit="return boardlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>게시판 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="80px" />
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
						<th>TABLE</th>
						<th>제목</th>
						<th>그룹</th>
						<th>게시판스킨</th>
						<th>검색사용</th>
						<th>검색순서</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
<?php for ($i=0;  $row=sql_fetch_array($result); $i++){
?>
					<tr>
						<td>
						<input type="hidden" name="bo_table[<?php echo $i ?>]" value="<?php echo $row['bo_table'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><a href="#"><?=$row['bo_table']?></a></td>
						<td><input type="text" name="bo_subject[<?php echo $i; ?>]" id="" value="<?=$row['bo_subject']?>" class="frm_input" size="40" /></td>
						<td>
							<?php echo get_group_select("gr_id[$i]", $row['gr_id']) ?>
						</td>
						<td>

						<input type="hidden" name="bo_skin[<?php echo $i ?>]" value="<?php echo $row['bo_skin'] ?>">
							<?php echo get_skin_select('board', 'bo_skin_'.$i, "bo_skin[$i]", $row['bo_skin']); ?>
						</td>
						<td>
							<input type="checkbox" name="bo_use_search[<?php echo $i; ?>]" value="Y" <?php echo $row['bo_use_search']=='Y'?'checked':'';?>/>
						</td>
						<td>
							<input type="text" name="bo_order_search[<?php echo $i; ?>]" value="<?php echo $row['bo_order_search'];?>" id=""  class="frm_input " size="10" />
						</td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=board_form&type=m&table=<?php echo $row['bo_table'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=board_list&type=d&table=<?php echo $row['bo_table'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">게시판 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" title="선택수정" style="font-size:0px;" onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" title="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value"  />
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
</form>
    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
function boardlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 게시판을 정말 삭제하시겠습니까? 삭제 후에는 해당 게시판의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}
</script>

{# s_footer}<!--하단-->







