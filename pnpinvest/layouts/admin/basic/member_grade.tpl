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
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">회원등급 관리</div>

		<h2 class="bo_title"><span>등급목록</span></h2>
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>등급목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="150px" />
				</colgroup>
				<thead>
					<tr>
						<th>NO</th>
						<th>등급명</th>
						<th>레벨구분</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
<?php
    for ($i=0; $row=sql_fetch_array($lv); $i++) {
?>
					<tr>
						<td><?php echo $row['lv_id'];?></td>
						<td><?php echo $row['lv_name'];?></td>
						<td>
							<select name="lv_level">
								<option value="1" <?php echo $row['lv_level']=='1'?'selected':'';?>>1</option>
								<option value="2" <?php echo $row['lv_level']=='2'?'selected':'';?>>2</option>
								<option value="3" <?php echo $row['lv_level']=='3'?'selected':'';?>>3</option>
								<option value="4" <?php echo $row['lv_level']=='4'?'selected':'';?>>4</option>
								<option value="5" <?php echo $row['lv_level']=='5'?'selected':'';?>>5</option>
								<option value="6" <?php echo $row['lv_level']=='6'?'selected':'';?>>6</option>
								<option value="7" <?php echo $row['lv_level']=='7'?'selected':'';?>>7</option>
								<option value="8" <?php echo $row['lv_level']=='8'?'selected':'';?>>8</option>
								<option value="9" <?php echo $row['lv_level']=='9'?'selected':'';?>>9</option>
								<option value="10" <?php echo $row['lv_level']=='10'?'selected':'';?>>10</option>
							</select>
						</td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=member_grade&lv_id=<?php echo $row['lv_id']; ?>&type=m"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan='4'>등급 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="btn_confirm01 btn_confirm">
				<a href="{MARI_HOME_URL}/?cms=member_grade"><img src="{MARI_ADMINSKIN_URL}/img/btn_new.png" alt="추가"/></a>
		</div>
<?php if($type=="m"){?>
		<h2 class="bo_title mt40"><span>등급수정</span></h2>
<form name="modify_form"  onsubmit="return frmnewwin_check(this);" method="post">
<input type=hidden name=type>
<input type=hidden name=lv_id>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>등급수정</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
					  <th>등급명</th>
					  <td><input type="text" name="lv_name" value="<?php echo $lv_m['lv_name']; ?>" id="" class="frm_input " size="" /></td>
					  <th>레벨구분</th>
					  <td>
							<select name="lv_level">
								<option value="1" <?php echo $lv_m['lv_level']=='1'?'selected':'';?>>1</option>
								<option value="2" <?php echo $lv_m['lv_level']=='2'?'selected':'';?>>2</option>
								<option value="3" <?php echo $lv_m['lv_level']=='3'?'selected':'';?>>3</option>
								<option value="4" <?php echo $lv_m['lv_level']=='4'?'selected':'';?>>4</option>
								<option value="5" <?php echo $lv_m['lv_level']=='5'?'selected':'';?>>5</option>
								<option value="6" <?php echo $lv_m['lv_level']=='6'?'selected':'';?>>6</option>
								<option value="7" <?php echo $lv_m['lv_level']=='7'?'selected':'';?>>7</option>
								<option value="8" <?php echo $lv_m['lv_level']=='8'?'selected':'';?>>8</option>
								<option value="9" <?php echo $lv_m['lv_level']=='9'?'selected':'';?>>9</option>
								<option value="10" <?php echo $lv_m['lv_level']=='10'?'selected':'';?>>10</option>
							</select>
					  </td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0)" onclick="Modify_form();"><img src="{MARI_ADMINSKIN_URL}/img/btn_end.png" alt="작성완료"/></a>
				<a href="javascript:void(0)"  onclick="Delete_form();"><img src="{MARI_ADMINSKIN_URL}/img/btn_delete.png" alt="삭제"/></a>
		</div>
<?php }else{?>
		<h2 class="bo_title mt40"><span>등급생성</span></h2>
<form name="write_form"  onsubmit="return frmnewwin_check(this);" method="post">
<input type=hidden name=type>
<input type=hidden name=lv_id>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>등급생성</caption>
				<colgroup>
					<col width="150px;" />
					<col width="" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
					  <th>등급명</th>
					  <td><input type="text" name="lv_name" value="<?php echo $lv_m['lv_name']; ?>" id="" class="frm_input " size="" /></td>
					  <th>레벨구분</th>
					  <td>
							<select name="lv_level">
								<option value="1" <?php echo $lv_m['lv_level']=='1'?'selected':'';?>>1</option>
								<option value="2" <?php echo $lv_m['lv_level']=='2'?'selected':'';?>>2</option>
								<option value="3" <?php echo $lv_m['lv_level']=='3'?'selected':'';?>>3</option>
								<option value="4" <?php echo $lv_m['lv_level']=='4'?'selected':'';?>>4</option>
								<option value="5" <?php echo $lv_m['lv_level']=='5'?'selected':'';?>>5</option>
								<option value="6" <?php echo $lv_m['lv_level']=='6'?'selected':'';?>>6</option>
								<option value="7" <?php echo $lv_m['lv_level']=='7'?'selected':'';?>>7</option>
								<option value="8" <?php echo $lv_m['lv_level']=='8'?'selected':'';?>>8</option>
								<option value="9" <?php echo $lv_m['lv_level']=='9'?'selected':'';?>>9</option>
								<option value="10" <?php echo $lv_m['lv_level']=='10'?'selected':'';?>>10</option>
							</select>
					  </td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0)" onclick="Write_form();"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"/></a>
		</div>
<?php }?>
		<div class="local_desc02">
			<p>
				1. 등록된 등급을 수정/삭제 하실 수 있습니다 .<br />
				2. 등급명/레벨구분을 선택하신후 추가+버튼을 눌러 등급을 생성하실 수 있습니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>

/*수정*/
function Modify_form(){
if(!document.modify_form.lv_name.value){alert('\n등급명을 입력하여 주십시오.');document.modify_form.lv_name.focus();return false;}	
  document.modify_form.type.value='m';
  document.modify_form.lv_id.value='<?=$lv_m[lv_id]?>';
  document.modify_form.action = "{MARI_HOME_URL}/?cms=member_grade&update=member_grade";
  document.modify_form.submit();
}

/*신규작성*/
function Write_form(){
if(!document.write_form.lv_name.value){alert('\n등급명을 입력하여 주십시오.');document.write_form.lv_name.focus();return false;}	
  document.write_form.type.value='w';
  document.write_form.action = "{MARI_HOME_URL}/?cms=member_grade&update=member_grade";
  document.write_form.submit();
}

/*삭제*/
function Delete_form(){
  document.modify_form.type.value='d';
  document.modify_form.lv_id.value='<?=$lv_m[lv_id]?>';
  document.modify_form.action = "{MARI_HOME_URL}/?cms=member_grade&update=member_grade";
  document.modify_form.submit();
}
</script>
{# s_footer}<!--하단-->