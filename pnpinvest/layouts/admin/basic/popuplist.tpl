<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
			<div class="title01">팝업관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">팝업목록</div>
	<form name="poplist" id="poplist" action="{MARI_HOME_URL}/?update=popuplist" onsubmit="return boardlist_submit(this);" method="post">
			<fieldset>
				<div class="local_ov01 local_ov"><a href="#" class="ov_listall">전체목록</a> 팝업등록수 : <?php echo number_format($total_count) ?>개</div>
				<div class="btn_add01 btn_add">
					<a href="{MARI_HOME_URL}/?cms=newpopup&type=w"><img src="{MARI_ADMINSKIN_URL}/img/new_add_btn.png" alt="새창관리추가" /></a>
				</div>

				<div class="tbl_head01 tbl_wrap">
					<table class="txt_c">
					<caption>목록</caption>
					<colgroup>
						<col width="30px" />
						<col width="50px" />
						<col width="" />
						<col width="100px" />
						<col width="100px" />
						<col width="75px" />
						<col width="70px" />
						<col width="70px" />
						<col width="70px" />
						<col width="70px" />
						<col width="100px" />
						<col width="60px" />
						<col width="100px" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">시작일시</th>
						<th scope="col">종료일시</th>
						<th scope="col">시간</th>
						<th scope="col">Left</th>
						<th scope="col">Top</th>
						<th scope="col">Width</th>
						<th scope="col">Height</th>
						<th scope="col">사용스킨</th>
						<th scope="col">사용여부</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
					<tbody>
<?php for ($i=0;  $row=sql_fetch_array($result); $i++){?>
					<tr class="">
						<td>
						<input type="hidden" name="po_id[<?php echo $i ?>]" value="<?php echo $row['po_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">						
						</td>
						<td><?php echo $row['po_id']; ?></td>
						<td><?php echo $row['po_subject']; ?></td>
						<td><?php echo substr($row['po_start_date'],0,10); ?></td>
						<td><?php echo substr($row['po_end_date'],0,10); ?></td>
						<td><?php echo $row['po_expirehours']; ?>시간</td>
						<td><?php echo $row['po_left']; ?>px</td>
						<td><?php echo $row['po_top']; ?>px</td>
						<td><?php echo $row['po_width']; ?>px</td>
						<td><?php echo $row['po_height']; ?>px</td>
						<td><?php echo get_skin_select('popup', ''.$i, "po_skin", $row['po_skin']); ?></td>
						<td>
						<input type="checkbox" name="po_openchk[<?php echo $i; ?>]" value="1" <?php echo $row['po_openchk']=='1'?'checked':'';?>/>
						</td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=newpopup&type=m&po_id=<?php echo $row['po_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=popuplist&type=d&po_id=<?php echo $row['po_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">팝업 리스트가 없습니다.</td></tr>";
    ?>
					</tbody>
					</table>
				</div>
			</fieldset>
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" title="선택수정" style="font-size:0px;" onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" title="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value"  />
		</div>
		</form>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
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