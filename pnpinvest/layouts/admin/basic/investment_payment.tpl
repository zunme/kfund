<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script src="{MARI_PLUGIN_URL}/chart/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/serial.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/pie.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/light.js" type="text/javascript"></script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">회계관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->


	<div id="container">
		<div class="title02">투자결재완료</div>
		<ul class="tab_btn1 pl20">
			<li class="<?php echo $cms=='withholding_list'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=withholding_list">원천징수내역</a></li>
			<li class="<?php echo $cms=='sales_results'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=sales_results">매출현황</a></li>
			<li class="<?php echo $cms=='loans'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=loans">대출자산</a></li>
			<li class="<?php echo $cms=='receiving_treatment'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=receiving_treatment">수납처리</a></li>
			<li class="<?php echo $cms=='complete_settlement'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=complete_settlement">정산완료</a></li>
			<li class="<?php echo $cms=='investment_payment'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=investment_payment">투자결재완료</a></li>
		</ul>
		 <div class="local_ov01 local_ov">
			<a href="{MARI_HOME_URL}/?cms=investment_payment" class="ov_listall">전체목록</a>  결재완료 : <?php echo $total_count;?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="investment_payment">
		<input type="hidden" name="sh" value="Y">
			<label for="" class="sound_only">검색대상</label>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<span class="fb" style="display:inline;">투자자 :</span>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id=""  class=" frm_input" required>

			<span class="fb" style="display:inline;">조회 기간 :</span>
			<input type="text" name="s_date" value="<?php echo $s_date ?>" id="s_date" class="frm_input calendar" size="15" maxlength="10">
		~
			<input type="text" name="e_date" value="<?php echo $e_date ?>" id="e_date" class="frm_input calendar" size="15" maxlength="10">
			<input type="radio" name="date_m" value="date_today" <?php echo $date_m=="date_today"?'checked':'';?>/> <label for="">당일</label>
			<input type="radio" name="date_m" value="date_month" <?php echo $date_m=="date_month"?'checked':'';?>/> <label for="">당월</label>
			<input type="radio" name="date_m" value="date_lastmonth" <?php echo $date_m=="date_lastmonth"?'checked':'';?>/> <label for="">전월</label>
			<input type="radio" name="date_m" value="" <?php echo !$date_m?'checked':'';?>/> <label for="">선택안함</label>
			<input type="submit" class="search_btn" value="">

		</form>

		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="100px" />
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
						<th>번호</th>
						<th>투자결재완료일시</th>
						<th>아이디</th>
						<th>성명</th>
						<th>대출금</th>
						<th>약정일</th>
						<th>낙찰여부</th>
						<th>모집종료일</th>
						<th>월상환금</th>
					</tr>
				</thead>
				<tbody>
				<?php
					for ($i=0; $orders_list=sql_fetch_array($order_w); $i++) {
					$to_order=$orders_list['o_ln_money_to']+$orders_list['o_interest']+$orders_list['o_saleodinterest'];
					$sql = "select i_year_plus, i_repay_day from mari_loan where i_id='$orders_list[loan_id]'";
					$plus = sql_fetch($sql, false);
					$sql = "select i_invest_eday from mari_invest_progress where loan_id='$orders_list[loan_id]'";
					$endday = sql_fetch($sql, false);
					/*이자 소수점이하제거*/
					$o_saleodinterest=floor($orders_list['o_saleodinterest']);
					/*투자자 정산후잔액정보*/
					$sql = "select p_top_emoney, p_emoney from  mari_emoney where  m_id='$orders_list[sale_id]' and o_id='$orders_list[o_id]' and loan_id='$orders_list[loan_id]'";
					$salemoney = sql_fetch($sql, false);

					/*수수료,원천징수,연체설정정보*/
					$sql = "select * from  mari_inset";
					$is_ck = sql_fetch($sql, false);
					/*수수료계산*/
					$수수료=$to_order*$is_ck['i_profit'];

					$원천징수수수료=$orders_list['o_interest']*$i_profit;
				?>
					<tr>
						<td><?php echo $orders_list['o_id']; ?></td>
						<td>전자결제에맞는처리</td>
						<td><?php echo $orders_list['sale_id']?></td>
						<td><?php echo $orders_list['sale_name']?></td>
						<td><?php echo number_format($orders_list['o_ln_money']) ?>원</td>
						<td>매월<?php echo number_format($plus['i_repay_day']) ?>일</td>
						<td><?php echo $orders_list['o_salestatus'];?></td>
						<td><?php echo substr($endday[i_invest_eday],0,10); ?></td>
						<td><?php echo number_format($orders_list['o_investamount']) ?>원</td>
					</tr>
				<?php
				/*입금완료건만 연산*/
				if($orders_list['o_salestatus']=="정산완료"){
					$정상자산합계 += $orders_list['o_investamount'];
				}
				$연체자산합계 += $orders_list['o_saleodinterest'];
				$대출잔고 += $orders_list['o_investamount'];
				   }
				   if ($i == 0)
				      echo "<tr><td colspan=\"9\">투자결재내역이 없습니다.</td></tr>";
				?>
				</tbody>
			</table>
			<?php if($user[m_level]>=10){?>
				<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
			<?php }?>
		</div>

		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&stx='.$stx.'&s_date='.$s_date.'&e_date='.$e_date.'&date_m='.$date_m.'&cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->

		<div class="tbl_head01 tbl_wrap mt50">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="100px" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="2">합계</th>
						<th>정상자산합계</th>
						<th>연체자산합계</th>
						<th>대출잔고</th>
					</tr>
					<tr>
						<td><?php echo number_format($정상자산합계) ?>원</td>
						<td><?php echo number_format($연체자산합계) ?>원</td>
						<td><?php echo number_format($대출잔고) ?>원</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="local_desc02">
			<p>
				1. 기본적으로 최근기준 31개의 리스트가 보여집니다.<br />
				2. 상단 검색을통해 투자자명, 조회기간, 당일, 당월, 전월등으로 검색하실 수 있습니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>


$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });

 function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>'; 
}
</script>
{# s_footer}<!--하단-->