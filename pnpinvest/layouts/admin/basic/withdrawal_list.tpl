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
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">출금신청</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  출금신청 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="withdrawal_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

	<form name="withdrawallist" id="withdrawallist" action="{MARI_HOME_URL}/?update=withdrawal_list" onsubmit="return withdrawallist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>출금신청 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>신청자</th>
						<th>신청금액</th>
						<th>예금주</th>
						<th>계좌정보</th>
						<th>접수일자</th>
						<th>처리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	$sql = "select m_no, m_my_bankcode, m_my_bankname, m_my_bankacc from mari_member where m_id='$row[m_id]'";
	$bank = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="o_no[<?php echo $i ?>]" value="<?php echo $row['o_no'] ?>">
						<input type="hidden" name="m_id[<?php echo $i ?>]" value="<?php echo $row['m_id'] ?>">
						<input type="hidden" name="m_name[<?php echo $i ?>]" value="<?php echo $row['m_name'] ?>">
						<input type="hidden" name="o_pay[<?php echo $i ?>]" value="<?php echo $row['o_pay'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['o_no']; ?></td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo number_format($row['o_pay']) ?> 원</td>
						<td><?php echo $bank['m_my_bankname']; ?></td>
						<td>
							<?php if(!$bank['m_my_bankcode']){?>
								<a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $bank['m_no']; ?>&type=m">[계좌정보 작성하기]</a>
							<?php }else{?>
								[<?php echo bank_name($bank['m_my_bankcode']);?>] <?php echo $bank['m_my_bankacc']; ?>
							<?php }?>
						</td>
						<td><?php echo $row['o_regdatetime']; ?></td>
						<td><?php if($row['o_fin']=="Y"){?>처리완료<?php }else{?>출금대기<?php }?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">출금신청 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택출금처리" class="outpay_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
	</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
function withdrawallist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택출금처리") {
        if(!confirm("선택한 회원을 정말 출금처리 하시겠습니까?")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->

