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
			<div class="title01"><?php echo $subject;?></div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
		<div class="title02"><?php echo $subject;?> 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 전체 <?php echo $total_count;?>건
		</div>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=user_board_form&type=w&table=<?php echo $table; ?>&subject=<?php echo $subject;?>"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가" /></a>
		</div>
	<form name="userboardlist" id="userboardlist" action="{MARI_HOME_URL}/?update=user_board_list" onsubmit="return userboardlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>게시판 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="120px" />
					<col width="60px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>제목</th>
						<th>등록일시</th>
						<th>메인노출</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
	<?php 
	for ($i=0;  $list=sql_fetch_array($result); $i++){
	?>
					<tr>
						<td>
						<input type="hidden" name="w_table[<?php echo $i ?>]" value="<?php echo $list['w_table'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td>
						<input type="hidden" name="w_id[<?php echo $i ?>]" value="<?php echo $list['w_id'] ?>">
						<?php echo $list['w_id'];?>
						</td>
						<td><?php echo $list['w_subject'];?></td>
						<td><?php echo substr($list['w_datetime'],0,10); ?></td>
						<td><?php if(!$list['w_main_exposure']){?>N<?php }else{?><?php echo $list['w_main_exposure'];?><?php }?></td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=user_board_form&type=m&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=user_board_list&type=d&table=<?php echo $list['w_table'];?>&id=<?php echo $list[w_id]; ?>&subject=<?php echo $subject;?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">게시물이 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" title="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value"  />
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function userboardlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 게시물을 정말 삭제하시겠습니까? 삭제 후에는 해당 게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}
</script>

{# s_footer}<!--하단-->