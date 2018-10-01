<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 카테고리 관리
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
		<div class="title02">카테고리 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="" class="ov_listall">전체목록</a> 카테고리수 : <?php echo $total_count;?>개
		</div>

		<form class="local_sch01 local_sch"  name="fsearch"  method="get">
		<input type="hidden" name="cms" value="category_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl" id="">
				<option value="ca_subject"<?php echo get_selected($_GET['sfl'], "ca_subject"); ?>>제목</option>
				<option value="ca_id"<?php echo get_selected($_GET['sfl'], "ca_id"); ?>>ID</option>
				<option value="ca_admin"<?php echo get_selected($_GET['sfl'], "ca_admin"); ?>>관리자</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text" name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">
		</form>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=category_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_category_btn.png" alt="카테고리 추가" /></a>
		</div>
	<form name="categorylist" id="categorylist" action="{MARI_HOME_URL}/?update=category_list" onsubmit="return categorylist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			
		
			<table class="txt_c">
				<caption>카테고리 목록</caption>
				<colgroup>
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
						<th>카테고리 아이디</th>
						<th>제목</th>
						<th>카테고리 관리자</th>
						<th>뎁스</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				<?php 
				for ($i=0;  $row=sql_fetch_array($grolist); $i++){
				if(!$row['ca_sub_id']){
					$sql = " select * from mari_category where ca_id='$row[ca_id]' and ca_num>$row[ca_num] order by ca_subject asc";
					$ca_sub= sql_query($sql, false);
				}else{
					$sql = " select * from mari_category where ca_sub_id='$row[ca_sub_id]' and ca_num>$row[ca_num] order by ca_subject asc";
					$ca_sub= sql_query($sql, false);
				}
				?>
					<tr>
						<td>
						<input type="hidden" name="ca_pk[<?php echo $i ?>]" value="<?php echo $row['ca_pk'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td class="txt_l"><input type="hidden" name="ca_id[<?php echo $i; ?>]" value="<?php echo $row['ca_id'];?>"><?php echo $row['ca_id'] ?></td>
						<td class="txt_l"><input type="text" name="ca_subject[<?php echo $i; ?>]" value="<?php echo $row['ca_subject'];?>" id=""  class="frm_input " size="30" /></td>
						<td class="txt_l"><input type="text" name="ca_admin[<?php echo $i; ?>]" value="<?php echo $row['ca_admin'];?>" id=""  class="frm_input " size="30" /></td>
						<td><a href="#"><?php echo $row['ca_num']?></a></td>
						<td class="txt_l">
							<a href="{MARI_HOME_URL}/?cms=category_form&type=add&ca_id=<?php echo $row['ca_id'];?>&ca_pk=<?php echo $row['ca_pk'];?>"><img src="{MARI_ADMINSKIN_URL}/img/add5_btn.png" alt="추가" /></a>
							<a href="{MARI_HOME_URL}/?cms=category_form&type=m&ca_id=<?php echo $row['ca_id'];?>&ca_pk=<?php echo $row['ca_pk'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=category_list&type=d&id=<?php echo $row_s['ca_pk'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
				<?php 
				for ($is=0;  $row_s=sql_fetch_array($ca_sub); $is++){
				?>
					<tr>
						<td>
						</td>
						<td class="txt_l"><?php echo $row_s['ca_id'] ?> <?php echo $row_s['ca_sub_id']?'<b>→</b>':'';?> <?php echo $row_s['ca_sub_id'] ?> <?php echo $row_s['ca_ssub_id']?'<b>→</b>':'';?> <?php echo $row_s['ca_ssub_id'] ?></td>
						<td class="txt_l"><b class="<?php if($row_s['ca_num']=="2"){?>pl10<?php }else if($row_s['ca_num']=="3"){?>pl20<?php }?>"><img src="{MARI_ADMINSKIN_URL}/img/arrow1.png" alt="" /></b> <?php echo $row_s['ca_subject'];?></td>
						<td class="txt_l"><?php echo $row_s['ca_admin'];?></td>
						<td><a href="#"><?php echo $row_s['ca_num']?></a></td>
						<td class="txt_l">
						<?php if($row_s['ca_num']=="3"){?>
						<?php }else{?>
							<a href="{MARI_HOME_URL}/?cms=category_form&type=add&ca_id=<?php echo $row_s['ca_id'];?>&ca_num=<?php echo $row_s['ca_num'];?>&ca_sub_id=<?php echo $row_s['ca_sub_id'] ?>&ca_pk=<?php echo $row_s['ca_pk'];?>"><img src="{MARI_ADMINSKIN_URL}/img/add5_btn.png" alt="추가" /></a>
						<?php }?>
							<a href="{MARI_HOME_URL}/?cms=category_form&type=m&ca_id=<?php echo $row_s['ca_id'];?>&ca_pk=<?php echo $row_s['ca_pk'];?>&ca_num=<?php echo $row_s['ca_num']?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=category_list&type=d&id=<?php echo $row_s['ca_pk'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
				<?php
				}
				if ($is == 0){
				}
				?>
				<?php
				}
				if ($i == 0)
					echo "<tr><td colspan=\"".$colspan."\">카테고리 리스트가 없습니다.</td></tr>";
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
function categorylist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 카테고리을 정말 삭제하시겠습니까? 삭제 후에는 해당 카테고리의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}
</script>
{# s_footer}<!--하단-->