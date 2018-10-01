<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
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
		<div class="title02">충전내역</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  결제 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="charge_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>충전내역</caption>
				<colgroup>
					<!-- <col width="50px" /> -->
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th><input type="checkbox" id="" name="" value="" /></th> -->
						<th>NO</th>
						<th>충전회원</th>
						<th>충전금액</th>
						<th>충전일</th>
						<th>결제여부</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
    ?>
					<tr>
						<!-- <td><input type="checkbox" id="" name="" value="" /></td> -->
						<td><?php echo $row['c_no']; ?></td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo number_format($row['c_pay']) ?> 원</td>
						<td><?php echo $row['c_regdatetime']; ?></td>
						<td><?php if($row['c_fin']=="Y"){?>처리완료<?php }else{?>결제대기<?php }?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">출금신청 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
    </div><!-- /contaner -->
</div><!-- /wrapper -->


{# s_footer}<!--하단-->