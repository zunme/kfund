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
			<div class="title01">대출관리<?php echo $total_member;?></div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">심사원 목록</div>
		

		

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=lawyer_write&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_btn.png" alt="회원추가"></a>
		</div>
	<form name="lawyer_list" id="lawyer_list" action="{MARI_HOME_URL}/?update=lawyer_list" onsubmit="return lawyerlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>회원관리 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="200px" />
					<col width="150px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>이름</th>
						<th>사진</th>
						<th>등록일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($lay); $i++) {
	
    ?>
					<tr>
						<td>
						<input type="hidden" name="ly_id[<?php echo $i ?>]" value="<?php echo $row['ly_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i; ?>">
						</td>
						<td><?php echo $row['ly_id'];?></td>
						<td><?php echo $row['ly_name'] ?></td>
						<td>
						<?php
							if(!$row['ly_img']){
								echo '사진없음';
							}else{
							$sfoimg_str = '<img src="'.MARI_DATA_URL.'/lawyer/'.$row['ly_img'].'" width="116" height="116">';
							echo $sfoimg_str;
							}
						?>
						</td>
						<td><?php echo substr($row['ly_regidate'],0,10); ?></td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=lawyer_write&ly_id=<?php echo $row['ly_id']; ?>&type=m"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=lawyer_write&ly_id=<?php echo $row['ly_id']; ?>&type=d"><img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="수정" /></a>
						</td>
					</tr>
    <?php
    
    }
    if ($i == 0){?>
        <tr><td colspan="6">심사원 리스트가 없습니다.</td></tr>
<?php } ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;" onclick="document.pressed=this.value" />
		<?php if($user[m_level]>=10){?>
			<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
		<?php }?>
		</div>

	</form>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function lawyerlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 회원을 정말 탈퇴하시겠습니까? 탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

/*엑셀다운로드*/

function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>'; 
}
</script>

{# s_footer}<!--하단-->

 