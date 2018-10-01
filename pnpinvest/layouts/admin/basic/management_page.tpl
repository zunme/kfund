<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 페이지관리 리스트
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
		<div class="title02">페이지 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 페이지수 : <?php echo number_format($total_count) ?>개
		</div>

		<form class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="management_page">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="p_id"<?php echo get_selected($_GET['sfl'], "p_id"); ?>>페이지코드</option>
				<option value="p_subject"<?php echo get_selected($_GET['sfl'], "p_subject"); ?>>제목</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text" name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">
		</form>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=page_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_btn.png" alt="페이지 추가" /></a>
		</div>
	<form name="pagelist" id="pagelist" action="{MARI_HOME_URL}/?update=management_page" onsubmit="return pagelist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>페이지 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="80px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>페이지코드</th>
						<th>제목</th>
						<th>페이지사용여부</th>
						<th>페이지주소</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
<?php for ($i=0;  $row=sql_fetch_array($result); $i++){
?>
					<tr>
						<td>
						<input type="hidden" name="p_id[<?php echo $i ?>]" value="<?php echo $row['p_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><a href="#"><?=$row['p_id']?></a></td>
						<td><input type="text" name="p_subject[<?php echo $i; ?>]" id="" value="<?=$row['p_subject']?>" class="frm_input" size="40" /></td>
						<td>
						<input type="checkbox" name="p_page_use[<?php echo $i; ?>]" value="Y" <?php echo $row['p_page_use']=='Y'?'checked':'';?>/>
						</td>
						<td>
						<a href="{MARI_HOME_URL}/?mode=content&pg=<?php echo $row['p_id'];?>"><span class="fb">{MARI_HOME_URL}/?mode=content&pg=<?php echo $row['p_id'];?>
						</td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=page_form&type=m&p_id=<?php echo $row['p_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=management_page&type=d&p_id=<?php echo $row['p_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">페이지 리스트가 없습니다.</td></tr>";
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
function pagelist_submit(f)
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







