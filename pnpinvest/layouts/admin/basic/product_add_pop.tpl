<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
	<div class="pt20">
		<h2 class="bo_title"><span>상품목록</span></h2>
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>상품목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>NO</th>
						<th>상품명</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
<?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
?>
					<tr>
						<td><?php echo $row['it_id']; ?></td>
						<td><?php echo $row['it_item_name']; ?></td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=product_add_pop&it_id=<?php echo $row['it_id']; ?>&type=m"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>

						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"3\" class=\"empty_table\">리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
				<div class="pt10 pb10">
					<a href="{MARI_HOME_URL}/?cms=product_add_pop"><img src="{MARI_ADMINSKIN_URL}/img/btn_new.png" alt="신규등록"/></a>
				</div>
		</div>
<?php if($type=="m"){?>
		<h2 class="bo_title mt40"><span>상품수정</span></h2>
<form name="modify_form"  onsubmit="return frmnewwin_check(this);" method="post">
<input type=hidden name="type">
<input type=hidden name="it_id">
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>상품수정</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
					<th>상품명</th>
					<form name="product_add_pop"  method="post" enctype="multipart/form-data">
						<td><input type="text" name="it_item_name" value="<?php echo $it_view['it_item_name']; ?>" id="" class="frm_input " required size="60" /></td>
					</form>
					</tr>
				</tbody>
			</table>
		</div>
</form>

		<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0)" onclick="Modify_form();"><img src="{MARI_ADMINSKIN_URL}/img/btn_end.png" alt="작성완료"/></a>
				<a href="javascript:void(0)"  onclick="Delete_form();"><img src="{MARI_ADMINSKIN_URL}/img/btn_delete.png" alt="삭제"/></a>
		</div>
	</div><!-- /pop_wrap1 -->
<?php }else{?>
		<h2 class="bo_title mt40"><span>상품생성</span></h2>
<form name="write_form"  onsubmit="return frmnewwin_check(this);" method="post">
<input type=hidden name="type">
<input type=hidden name="it_id">
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>상품생성</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
					<th>상품명</th>
					<form name="product_add_pop"  method="post" enctype="multipart/form-data">
						<td><input type="text" name="it_item_name" value="<?php echo $it_view['it_item_name']; ?>" id="" required class="frm_input " size="60" /></td>
					</form>
					</tr>
				</tbody>
			</table>
		</div>
</form>

		<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0)" onclick="Write_form();"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"/></a>
		</div>
	</div><!-- /pop_wrap1 -->
<?php }?>


<script>

/*전체수정*/
function Modify_form(){
  document.modify_form.type.value='m';
  document.modify_form.it_id.value='<?php echo $it_view[it_id];?>';
  document.modify_form.action = "{MARI_HOME_URL}/?update=product_add_pop";
  document.modify_form.submit();
}

/*신규작성*/
function Write_form(){
  document.write_form.type.value='w';
  document.write_form.action = "{MARI_HOME_URL}/?update=product_add_pop";
  document.write_form.submit();
}

/*삭제*/
function Delete_form(){
  document.modify_form.type.value='d';
  document.modify_form.it_id.value='<?php echo $it_view[it_id];?>';
  document.modify_form.action = "{MARI_HOME_URL}/?update=product_add_pop";
  document.modify_form.submit();
}
</script>