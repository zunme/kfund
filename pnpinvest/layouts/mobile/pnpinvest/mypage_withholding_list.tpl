<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 
<section id="container">
		<section id="sub_content">
				<div class="container">
					<div class="dashboard_my_info">								
						<h3><span>투자정보</span></h3>
							<div class="dashboard_invest_info">								
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 원천징수내역</h3>
								<span>원천징수내역을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="110px">
											<col width="">
										</colgroup>

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
												<th>발생기간</th>
												<td><?php echo substr($orders_list[o_collectiondate],0,10); ?></td>
											</tr>
											<tr>
												<th>실거래금액</th>
												<td><?php echo number_format($orders_list['o_ipay']) ?>원</td>
											</tr>
												<?php if($orders_list['o_paytype']=="원리금균등상환"){?>
											<tr>	
												<th>원금</th>
												<td><?php echo number_format($orders_list['o_ln_money_to']) ?>원</td>
											</tr>
												<?php }else{?>
											<tr>	
												<th>원금</th>
												<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($orders_list['o_ln_money_to']) ?><?php }else{?>0<?php }?>원</td>
											</tr>
												<?php }?>
											<tr>
												<th>이자수익</th>
												<td><?php if($orders_list['o_paytype']=="만기일시상환" && $orders_list['o_count']==$orders_list['o_maturity']){?><?php echo number_format($o_interest);?><?php }else{?><?php echo number_format($orders_list['o_interest']) ?><?php }?>원</td>
											</tr>
											<tr>
												<th>수수료</th>
												<td><?php echo number_format($수수료) ?>원</td>
											</tr>	
											<tr>
												<th>원천징수납부세액</th>
												<td><?php echo number_format($orders_list['o_withholding']) ?>원</td>
											</tr>
											<tr>
												<th>거래후잔액</th>
												<td><?php echo number_format($salemoney['p_top_emoney']) ?>원</td>
											</tr>
										<?php
										   }
										   if ($i == 0)
										      echo "
										     	
											<tr>
												<th>발생기간</th>
												<td rowspan=\"7\">원천징수내역이 없습니다.</td>
											</tr>
											<tr>
												<th>실거래금액</th>
												
											</tr>
											<tr>	
												<th>원금</th>
												
											</tr>
											<tr>
												<th>이자수익</th>
												
											</tr>
											<tr>
												<th>수수료</th>
												
											</tr>	
											<tr>
												<th>원천징수납부세액</th>
												
											</tr>
											<tr>
												<th>거래후잔액</th>
												
											</tr> 
										"?>
										</tbody>
									</table>
							</div>														
						</div>	
					</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->