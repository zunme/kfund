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
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 정산현황</h3>
								<span>현재 정산현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="110px">
											<col width="">
										</colgroup>
										<thead>
											<tr>

											</tr>
											<tr class="part1">

											</tr>
										</thead>
										<tbody>
										<?php
											
											$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
											$order_s = sql_query($sql);	

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
												<th>제목</th>
												<td><?php echo $orders_list['o_subject'];?></td>
											</tr>
											<tr>
												<th>투자금액</th>
												<td><?php echo number_format($orders_list['o_ipay']) ?>원</td>
											</tr>
											<tr>
												<th>이자율</th>
												<td><?php echo $plus['i_year_plus'];?>%</td>
											</tr>
											<tr>
												<th>상환 기간</th>
												<td><?php echo $orders_list['o_maturity'];?>개월</td>
											</tr>
											<tr>
												<th>회수일</th>
												<td><?php echo substr($orders_list[o_collectiondate],0,10); ?></td>
											</tr>
											<tr>
												<th>회차</th>
												<td><?php echo $orders_list['o_count'];?>회차</td>
											</tr>
											<tr>
												<th>총 회수금액</th>
												<td><?php if($orders_list['o_count']==$orders_list['o_maturity'] && $orders_list['o_paytype']=="만기일시상환" || $orders_list['o_paytype']=="원리금균등상환" ){?><?php echo number_format($orders_list['o_ln_money_to']) ?><?php }else{?>0<?php }?>원</td>
											</tr>
											<tr>
												<th>원금</th>
												<td><?php echo number_format($orders_list['o_interest']) ?>원</td>
											</tr>
											<tr>
												<th>이자</th>
												<td><?php echo number_format($o_saleodinterest) ?>원</td>
											</tr>
											<tr>
												<th>연체이자</th>
												<td><?php if($orders_list['o_paytype']=="만기일시상환"){?><?php echo $orders_list['o_interest'];?><?php }else{?><?php echo number_format($to_order) ?><?php }?>원</td>
											</tr>
											<tr>
												<th>합계</th>
												<td><?php echo $orders_list['o_salestatus'];?></td>
											</tr>
										<?php
										   }
										   if ($i == 0)
										      echo "
											<tr>
												<th>제목</th>
												<td rowspan=\"10\">정산현황이 없습니다.</td>
											</tr>
											<tr>
												<th>투자금액</th>
												
											</tr>
											<tr>
												<th>이자율</th>
												
											</tr>
											<tr>
												<th>상환 기간</th>
												
											</tr>
											<tr>
												<th>회수일</th>
												
											</tr>
											<tr>
												<th>회차</th>
												
											</tr>
											<tr>
												<th>총 회수금액</th>
												
											</tr>
											<tr>
												<th>원금</th>
												
											</tr>
											<tr>
												<th>이자</th>
												
											</tr>
											<tr>
												<th>연체이자</th>
												
											</tr>
											<tr>
												<th>합계</th>
												
											</tr>

											";
										?>
										</tbody>
									</table>
							</div>														
						</div>	
					</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->