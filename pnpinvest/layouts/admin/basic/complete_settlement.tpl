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
		<div class="title02">정산완료</div>
		<ul class="tab_btn1 pl20">
			<li class="<?php echo $cms=='withholding_list'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=withholding_list">원천징수내역</a></li>
			<li class="<?php echo $cms=='sales_results'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=sales_results">매출현황</a></li>
			<li class="<?php echo $cms=='loans'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=loans">대출자산</a></li>
			<li class="<?php echo $cms=='receiving_treatment'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=receiving_treatment">수납처리</a></li>
			<li class="<?php echo $cms=='complete_settlement'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=complete_settlement">정산완료</a></li>
			<li class="<?php echo $cms=='investment_payment'?'tab_on1':'';?>"><a href="{MARI_HOME_URL}/?cms=investment_payment">투자결재완료</a></li>
		</ul>
		 <div class="local_ov01 local_ov">
			<a href="{MARI_HOME_URL}/?cms=complete_settlement" class="ov_listall">전체목록</a>  정산 : <?php echo $total_count;?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="complete_settlement">
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
				</colgroup>
				<thead>
					<tr>
						<th>정산완료일시</th>
						<th>아이디</th>
						<th>성명</th>
						<th>이자수익</th>
						<th>원금</th>
						<th>수수료수익</th>
						<th>원천징수납부세액</th>
						<th>정산완료금액</th>
						<th>거래후잔액</th>
					</tr>
				</thead>
				<tbody>
				<?php
					for ($i=0; $orders_list=sql_fetch_array($order_w); $i++) {
					$to_order=$orders_list['o_ln_money_to']+$orders_list['o_interest']+$orders_list['o_saleodinterest'];
					$sql = "select i_year_plus from mari_loan where i_id='$orders_list[loan_id]'";
					$plus = sql_fetch($sql, false);
					/*이자 소수점이하제거*/
					$o_saleodinterest=floor($orders_list['o_saleodinterest']);
					/*투자자 정산후잔액정보*/
					$sql = "select p_top_emoney, p_emoney from  mari_emoney where  m_id='$orders_list[sale_id]' and o_id='$orders_list[o_id]' and loan_id='$orders_list[loan_id]'";
					$salemoney = sql_fetch($sql, false);

					/*수수료,원천징수,연체설정정보*/
					$sql = "select * from  mari_inset";
					$is_ck = sql_fetch($sql, false);
					/*수수료계산*/
									/*투자자 정산후잔액정보*/
									$sql = "select * from  mari_member where m_id='$orders_list[sale_id]'";
									$memlvck = sql_fetch($sql, false);

										/*NEW★ 가이드라인 투자자별 원천징수 설정 2017-10-10 START*/
										if($memlvck[m_level]=="2"){
											if($memlvck[m_signpurpose]=="I"){
												$i_profit=$is_ck['i_profit_in'];//소득적격투자자
												$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
												$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
											}else if($memlvck[m_signpurpose]=="P"){
												$i_profit=$is_ck['i_profit_pro'];//전문투자자
												$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
												$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
											}else{
												$i_profit=$is_ck['i_profit'];//개인투자자
												$i_withholding=$is_ck['i_withholding_personal'];//개인투자자
												$i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
											}
										}else if($memlvck[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
											$i_withholding=$is_ck['i_withholding_burr'];
											$i_withholding_v=$is_ck['i_withholding_burr_v'];
										}else{
											if($memlvck[m_signpurpose]=="I"){
												$i_profit=$is_ck['i_profit_in'];//소득적격투자자
												$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
												$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
											}else if($memlvck[m_signpurpose]=="P"){
												$i_profit=$is_ck['i_profit_pro'];//전문투자자
												$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
												$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
											}else{
												$i_profit=$is_ck['i_profit'];//개인투자자
												$i_withholding=$is_ck['i_withholding_personal'];//개인투자자
												$i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
											}
										}
										/*NEW★ 가이드라인 투자자별 원천징수 설정 2017-10-10 END*/



									/*수수료계산*/
									if($orders_list['o_paytype']=="원리금균등상환"){
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_ln_money_to']+$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else if($orders_list['o_paytype']=="만기일시상환"){

										$o_interest=$orders_list['o_interest']-$orders_list['o_ln_money_to'];

										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}else{
										$수수료=$orders_list['o_ln_money_to']*$i_profit;

										$원천징수수수료=$orders_list['o_interest']*$i_profit;
										$실입금액=$orders_list['o_interest']-$수수료-$orders_list['o_withholding'];
									}


									if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){
										$o_interestsum=$orders_list['o_interest']-$orders_list['o_ln_money_to'];
									}else{
										$o_interestsum=$orders_list['o_interest'];
									}
				?>
					<tr>
						<td><?php echo substr($orders_list[o_collectiondate],0,10); ?></td>
						<td><?php echo $orders_list['sale_id']?></td>
						<td><?php echo $orders_list['sale_name']?></td>
						<?php if($orders_list['o_paytype']=="원리금균등상환"){?>
						<td><?php echo number_format($orders_list['o_ln_money_to']) ?>원</td>
						<?php }else{?>
						<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($orders_list['o_ln_money_to']) ?><?php }else{?>0<?php }?>원</td>
						<?php }?>
						<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($o_interest);?><?php }else{?><?php echo number_format($orders_list['o_interest']) ?><?php }?>원</td>
						<td><?php echo number_format($수수료) ?>원</td>
						<td><?php echo number_format($orders_list['o_withholding']) ?>원</td>
						<td><?php echo number_format($salemoney['p_emoney']) ?>원</td>
						<td><?php echo number_format($salemoney['p_top_emoney']) ?>원</td>
					</tr>
				<?php
					if($orders_list['o_paytype']=="원리금균등상환"){
						$실거래금액합산 += $orders_list['o_ipay'];
					}else{
						$실거래금액합산 += $orders_list['o_interest'];
					}
					$이자합산 += $o_interestsum;
					$수수료합산 += $수수료;
					if($orders_list['o_paytype']=="원리금균등상환"){
						$원금합산 += $orders_list['o_ln_money_to'];
					}else{
						if($orders_list['o_count']==$orders_list['o_maturity']){
						$원금합산 = $orders_list['o_ln_money_to'];
						}else{
						}
					}
					$원천징수합산 += $orders_list['o_withholding'];
					$거래후잔액합산 += $salemoney['p_top_emoney'];
					$실입금액합산 += $실입금액;
				$정산완료금액합계 += $salemoney['p_emoney'];

				   }
				   if ($i == 0)
				      echo "<tr><td colspan=\"9\">정산내역이 없습니다.</td></tr>";
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
						<th>정산완료금액합계</th>
						<th>수수료수익합계</th>
						<th>거래후잔액합계</th>
					</tr>
					<tr>
						<td><?php echo number_format($정산완료금액합계) ?>원</td>
						<td><?php echo number_format($수수료합산) ?>원</td>
						<td><?php echo number_format($t_emoney) ?>원</td>
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