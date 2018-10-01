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
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">가상계좌 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 건수 : <?php echo $total_count;?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="illusion_acc_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="phoneNo"<?php echo get_selected($_GET['sfl'], "phoneNo"); ?>>휴대폰번호</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<h2 class="h2_frm mt20"><span>가상계좌 관리</span></h2>
	<form name="emoneylist" id="emoneylist" action="{MARI_HOME_URL}/?update=illusion_acc_list" onsubmit="return emoneylist_submit(this);" method="post">	
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>e-머니 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>회원아이디</th>
						<th>이름</th>
						<th>멤버키</th>
						<th>가상계좌</th>
						<th>휴대폰번호</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($acc_list); $i++) {
	$sql = "select  * from  mari_member where m_id='$row[m_id]'";
	$em = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="s_id[<?php echo $i ?>]" value="<?php echo $row['s_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['m_id']; ?></td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo $row['s_memGuid']; ?></td>
						<td>
						<?php 
						if($row['s_bnkCd'] || $row['s_accntNo']){
							echo '['.bank_name($row['s_bnkCd']).']'.$row['s_accntNo'];
						}else{
							echo '가상계좌 미발급';
						}
						?>
						</td>
						<td><?php echo $row['phoneNo'] ?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=6>계좌리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&sfl='.$sfl.'&stx='.$stx.'&amp;page='); ?>
		</div><!-- /paging -->
		<div class="btn_list01 btn_list">
		<?php if($user[m_level]>=10){?>
			<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
		<?php }?>
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
	</form>


    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
function emoneylist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}


/*필수체크*/
$(function() {
	$('#emoney_form_add').click(function(){
		Emoney_form_Ok(document.emoney_form);
	});
});


function Emoney_form_Ok(f)
{
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.p_content.value){alert('\n지급내용을 입력하여 주십시오.');f.p_content.focus();return false;}
	if(!f.p_emoney.value){alert('\n지급하실 e-머니를 입력하여 주십시오.');f.p_emoney.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=emoney_list';
	f.submit();
}

/*엑셀다운로드*/

function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>&sfl=<?php echo $sfl?>&stx=<?php echo $stx?>'; 
}
</script>

{# s_footer}<!--하단-->







