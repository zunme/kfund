<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<div id="container">
	<div id="sub_content">
		<div class="mypage" >
			<div class="mypage_inner">
						<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							
						</div>

						<div class="dashboard_side_mn">
							<ul>
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
							</ul>
						</div>
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>투자정보</span></h3>
							<div class="dashboard_invest_info">								
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 전체원천징수내역</h3>
								<span>원천징수내역을 확인하실 수 있습니다.</span>
								<div class="dashboard_srhform">
									<form  class=""  id="fsearch" name="fsearch"  method="get">
									<input type="hidden" name="mode" value="mypage_withholding_list" style="height:10px;">
									<input type="hidden" name="sh" value="Y">
										<label for="" class="">검색대상</label>
										<label for="" class="">검색어<strong class="sound_only"> 필수</strong></label>
										<span class="pl10 pr10">조회 기간 :</span>
										<input type="text" name="s_date" value="<?php echo $s_date ?>" id="s_date" class="frm_input calendar" size="15" maxlength="10" style="height:25px; ">~
										<input type="text" name="e_date" value="<?php echo $e_date ?>" id="e_date" class="frm_input calendar" size="15" maxlength="10" style="height:25px; margin-right:10px; ">
										<label for="date_today" class="pr10"><input type="radio" name="date_m" id="date_today" value="date_today" <?php echo $date_m=="date_today"?'checked':'';?>/> 당일</label>
										<label for="date_month" class="pr10"><input type="radio" name="date_m" id="date_month"  value="date_month" <?php echo $date_m=="date_month"?'checked':'';?>/> 당월</label>
										<label for="date_lastmonth" class="pr10" ><input type="radio" name="date_m" id="date_lastmonth" value="date_lastmonth" <?php echo $date_m=="date_lastmonth"?'checked':'';?>/> 전월</label>
										<label for="date_noselect" class="pr10"><input type="radio" name="date_m" id="date_noselect"  value="" <?php echo !$date_m?'checked':'';?>/> 선택안함</label>
										<input type="submit" class="search_btn" value="검색" style="width:50px; height:25px; font-weight:600; ">

									</form>
								</div>
								<div>
									<table>
										<colgroup>
											<col width="100px">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
										</colgroup>
										<thead>
											<tr>
												<th rowspan="2">발생기간</th>
												<th rowspan="2">실거래금액</th>
												<th rowspan="2">원금</th>
												<th rowspan="2">이자수익</th>
												<th rowspan="2">수수료</th>
												<th rowspan="2">원천징수납부세액</th>
												<th rowspan="2">거래후잔액</th>
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
												$sql = "select p_top_emoney from  mari_emoney where o_id='$orders_list[o_id]' and loan_id='$orders_list[loan_id]' and m_id='$user[m_id]'";
												$salemoney = sql_fetch($sql, false);

												/*수수료,원천징수,연체설정정보*/
												$sql = "select * from  mari_inset";
												$is_ck = sql_fetch($sql, false);
												/*수수료계산*/
									/*투자자 정산후잔액정보*/
									$sql = "select * from  mari_member where m_id='$orders_list[sale_id]'";
									$memlvck = sql_fetch($sql, false);

										if($memlvck[m_level]=="2"){
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}else if($memlvck[m_level]>=3){
											$i_profit=$is_ck['i_profit_v'];
											$i_withholding=$is_ck['i_withholding_burr'];
										}else{
											$i_profit=$is_ck['i_profit'];
											$i_withholding=$is_ck['i_withholding_personal'];
										}



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
												<td><?php echo number_format($orders_list['o_ipay']) ?>원</td>
												<?php if($orders_list['o_paytype']=="원리금균등상환"){?>
												<td><?php echo number_format($orders_list['o_ln_money_to']) ?>원</td>
												<?php }else{?>
												<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($orders_list['o_ln_money_to']) ?><?php }else{?>0<?php }?>원</td>
												<?php }?>
												<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($o_interest);?><?php }else{?><?php echo number_format($orders_list['o_interest']) ?><?php }?>원</td>
												<td><?php echo number_format($수수료) ?>원</td>
												<td><?php echo number_format($orders_list['o_withholding']) ?>원</td>
												<td><?php echo number_format($salemoney['p_top_emoney']) ?>원</td>
											</tr>
										<?php

										$실거래금액합산 += $orders_list['o_ipay'];
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
										   }
										   if ($i == 0)
										      echo "<tr><td colspan=\"12\">원천징수내역이 없습니다.</td></tr>";
										?>
										</tbody>
									</table>
									<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
									<table class="mt30">
										<colgroup>
											<col width="100px">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
										</colgroup>
										<thead>
											<tr>
												<th rowspan="2" class="">합계</th>
												<th>실거래금액합계</th>
												<th>이자수익합계</th>
												<th>수수료합계</th>
												<th>원천징수납부세액합계</th>
												<th>거래후잔액합계</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>합</td>
												<td><?php echo number_format($실거래금액합산) ?>원</td>
												<td><?php echo number_format($이자합산) ?>원</td>
												<td><?php echo number_format($수수료합산) ?>원</td>
												<td><?php echo number_format($원천징수합산) ?>원</td>
												<td class="fb"><?php echo number_format($t_emoney) ?>원</td>
											</tr>
										</tbody>
									</table>
									
								</div>
							</div><!--dashboard_interest-->
						</div>
					</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div>
<!--//container e -->

<script>


$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });
</script>

{#footer}
