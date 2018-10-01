<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
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
							<!---->
						</div>

						
						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>투자정보</span></h3>
							<div class="dashboard_invest_info">								
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 입찰현황<a href="{MARI_HOME_URL}/?mode=mypage_tenderstatus" class="btn_more">더보기</a></h3>
								<span>현재 입찰현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="166px">
											<col width="93px">
											<col width="117px">
											<col width="127px">
											<col width="80px">
											<col width="100px">
											<col width="100px">
											<col width="125px">
											<col width="125px">
										</colgroup>
										<thead>
											<tr>
												<th>제목</th>
												<th>진행현황</th>
												<th>신청금액</th>
												<th>이자율</th>
												<th>상환 기간</th>
												<th>입찰액</th>
												<th>진행율</th>
												<th>상태</th>
												<th>권리증서</th>
											</tr>
										</thead>
										<tbody>
										<?php
										  for ($i=0; $row=sql_fetch_array($laon); $i++) {
										/*입찰정보*/
										$sql = "select  * from  mari_loan where i_id='$row[loan_id]'";
										$losale = sql_fetch($sql, false);
										$sql = "select i_invest_name, i_invest_per, i_look from  mari_invest_progress where loan_id='$row[loan_id]'";
										$iv_pr = sql_fetch($sql, false);

										$sql="select sum(i_pay) from mari_invest where loan_id='$row[loan_id]'";
										$top=sql_query($sql, false);
										$order = mysql_result($top, 0, 0);
										$total=$losale[i_loan_pay];
										/*투자금액이 0보다클경우에만 연산*/
										if($order>0){
											/* 투자금액 / 대출금액 * 100 */
											$order_pay=floor ($order/$total*100);
										}else{
											$order_pay="0";
										}

										?>
										<form name="inset_form<?php echo $i; ?>"  method="post" enctype="multipart/form-data" target="calculation<?php echo $i; ?>">
										<input type="hidden" name="i_loan_day" value="<?php echo $losale[i_loan_day]; ?>">
										<input type="hidden" name="i_year_plus" value="<?php echo $losale[i_year_plus]; ?>">
										<input type="hidden" name="i_repay" value="<?php echo $losale[i_repay]; ?>">
										<input type="hidden" name="i_pay" value="<?php echo $row[i_pay]; ?>">
										<input type="hidden" name="loan_id" value="<?php echo $row[loan_id]; ?>">
										<input type="hidden" name="stype" value="invest"/>
										<input type="hidden" name="mtype" value="mypage"/>
											<tr>
												<td><?php echo $iv_pr[i_invest_name];?></td>
												<td>
												<?php 
													if($iv_pr['i_look']=="Y"){														
														echo '투자진행중';
													}else if($iv_pr['i_look']=="C"){
														echo '투자마감';
													}else if($iv_pr['i_look']=="N"){
														echo '투자대기중';
													}else if($iv_pr['i_look']=="D"){
														echo '상환중';
													}else if($iv_pr['i_look']=="F"){
														echo '상환완료';
													}
												?>
												</td>
												<td><?php echo unit2($row['i_loan_pay']) ?>원</td>
												<td><?php echo unit($row['i_profit_rate']) ?>%</td>
												<td><?php echo $losale[i_loan_day];?>개월</td>
												<td><?php echo unit2($row['i_pay']) ?>원</td>
												<td><?php echo $order_pay;?>%</td>
												<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_loan_c.png" alt="투자 수익 확인"  onclick="Calculation<?php echo $i; ?>()"/></a></td>									
												<td><a href="{MARI_HOME_URL}/?mode=invest_receipt&loan_id=<?php echo $row[loan_id]?>&i_pay=<?php echo $row[i_pay]?>" onclick="window.open(this.href, '','width=1022, height=1300, resizable=no, scrollbars=yes, status=no'); return false">조회하기</a></td>
											</tr>
										</form>
										<script>
										/*매월 투자수익계산*/
										function Calculation<?php echo $i; ?>() { 
										  var f=document.inset_form<?php echo $i; ?>;
										  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
										  window.open("about:blank", "calculation<?php echo $i?>", opt);
										  f.action="{MARI_HOME_URL}/?mode=calculation";
										  f.submit();
										}
										</script>
										<?php
										   }
										   if ($i == 0)
										      echo "<tr><td colspan=\"10\">입찰정보가 없습니다.</td></tr>";
										?>
										</tbody>
									</table>

								<h3 class="mt30"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 정산현황<a href="{MARI_HOME_URL}/?mode=mypage_investment" class="btn_more">더보기</a></h3>
								<span>현재 정산현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="158px">
											<col width="66px">
											<col width="72px">
											<col width="96px">
											<col width="63px">
											<col width="67px">
											<col width="73.5px">
											<col width="73.5px">
											<col width="73.5px">
											<col width="73.5px">
											<col width="73.5px">
										</colgroup>
										<thead>
											<tr>
												<th rowspan="2">제목</th>
												<th rowspan="2">투자금액</th>
												<th rowspan="2">이자율</th>
												<th rowspan="2">상환 기간</th>
												<th rowspan="2">회수일</th>
												<th rowspan="2">회차</th>
												<th colspan="4" class="">총 회수금액</th>
												<th rowspan="2"  class="">상태</th>
											</tr>
											<tr class="part1">
												<th>원금</th>
												<th>이자</th>
												<th>연체이자</th>
												<th class="last">합계</th>
											</tr>
										</thead>
										<tbody>
										<?php
											for ($i=0; $orders_list=sql_fetch_array($order_s); $i++) {
												if($orders_list['o_count']==$orders_list['o_maturity'] && $orders_list['o_paytype']=="만기일시상환"){
													$to_order=$orders_list['o_investamount']+$orders_list['o_saleodinterest'];
												}else{
													$to_order=$orders_list['o_ln_money_to']+$orders_list['o_interest']+$orders_list['o_saleodinterest'];
												}
													$sql = "select i_year_plus from mari_loan where i_id='$orders_list[loan_id]'";
													$plus = sql_fetch($sql, false);
													/*이자 소수점이하제거*/
													$o_saleodinterest=floor($orders_list['o_saleodinterest']);
										?>
											<tr>
												<td><?php echo $orders_list['o_subject'];?></td>
												<td><?php echo number_format($orders_list['o_ipay']) ?>원</td>
												<td><?php echo $plus['i_year_plus'];?>%</td>
												<td><?php echo $orders_list['o_maturity'];?>개월</td>
												<td><?php echo substr($orders_list[o_collectiondate],0,10); ?></td>
												<td><?php echo $orders_list['o_count'];?>회차</td>
												<td><?php if($orders_list['o_count']==$orders_list['o_maturity'] && $orders_list['o_paytype']=="만기일시상환" || $orders_list['o_paytype']=="원리금균등상환" ){?><?php echo number_format($orders_list['o_ln_money_to']) ?><?php }else{?>0<?php }?>원</td>
												<td><?php echo number_format($orders_list['o_interest']) ?>원</td>
												<td><?php echo number_format($o_saleodinterest) ?>원</td>
												<td><?php if($orders_list['o_paytype']=="만기일시상환"){?><?php echo $orders_list['o_interest'];?><?php }else{?><?php echo number_format($to_order) ?><?php }?>원</td>
												<td><?php echo $orders_list['o_salestatus'];?></td>
											</tr>
										<?php
										   }
										   if ($i == 0)
										      echo "<tr><td colspan=\"12\">정산현황이 없습니다.</td></tr>";
										?>
										</tbody>
									</table>
								<h3 class="mt30"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 원천징수내역<a href="{MARI_HOME_URL}/?mode=mypage_withholding_list" class="btn_more">더보기</a></h3>
								<span>원천징수내역을 확인하실 수 있습니다.</span>
								
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
										   }
										   if ($i == 0)
										      echo "<tr><td colspan=\"12\">원천징수내역이 없습니다.</td></tr>";
										?>
										</tbody>
									</table>
								</div>
							</div><!--dashboard_interest-->
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}