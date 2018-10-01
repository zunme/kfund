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
			<div class="title01">투자관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">투자 현황</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  투자 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="invest_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<p class="sum1"><strong>입찰 누적금액</strong> : <span><?php echo number_format($t_pay) ?></span> 원</p>

		<!-- <div class="btn_add01 btn_add">
			<a href="#"><img src="img/more_btn.png" alt="추가"></a>
		</div> -->
	<form name="investlist" id="investlist" action="{MARI_HOME_URL}/?update=invest_list" onsubmit="return investlist_submit(this);" method="post">

		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>투자목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="" />
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
						<th>NO</th>
						<th>제목</th>
						<th>이름</th>
						<th>대출금액</th>
						<th>투자회원</th>
						<th>투자금액</th>
						<th>입찰일</th>
						<th>모집종료일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	$sql = "select  * from  mari_loan where i_id='$row[loan_id]'";
	$loview = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="i_id[<?php echo $i ?>]" value="<?php echo $row['i_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['i_id']; ?></td>
						<td><?php echo $loview['i_subject']; ?>(<?php echo cate_name($row['i_goods'],1);?>)</td>
						<td><?php echo $row['user_name']; ?></td>
						<td><?php echo number_format($row['i_loan_pay']) ?> 원</td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo number_format($row['i_pay']) ?> 원</td>
						<td><?php echo substr($row['i_regdatetime'],0,10); ?></td>
						<td><?php echo substr($row['i_invest_eday'],0,10); ?></td>
						<td><a href="{MARI_HOME_URL}/?cms=invest_setup_form&type=w&loan_id=<?php echo $row['loan_id']; ?>"><img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="보기" /></a></td>
						 
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">투자신청 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
			 
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택취소" class="cancle_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
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
function investlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택취소") {
        if(!confirm("선택한 투자신청 내용을 정말 삭제하시겠습니까? 삭제 후에는 해당 신청내용의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->