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
						<h3><span>입금현황</span></h3>
						<div class="dashboard_loan_info">								
							<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 입금현황 </h3>
							<span>전체 입금현황을 확인하실 수 있습니다.</span>
							
							<div>
								<table>
									<colgroup>
										<col width="110px">
										<col width="">
									</colgroup>

									<tbody>
									<?php
									/*입금현황*/
										$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
										$order_count = sql_fetch($sql);
										$total_order = $order_count['cnt'];
										$rows ="100";
										$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
										if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
										$from_record = ($page - 1) * $rows; // 시작 열을 구함
										$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
										$order = sql_query($sql);
									  for ($i=0; $order_list=sql_fetch_array($order); $i++) {
									?>
										<tr>
											<th>채권</th>
											<td><?php echo $order_list['o_subject'];?></td>
										</tr>
										<tr>
											<th>상환일</th>
											<td><?php echo substr($order_list[o_datetime],0,10); ?></td>
										</tr>
										<tr>
											<th>차수/만기</th>
											<td><?php echo $order_list['o_count'];?>회차 / <?php echo $order_list['o_maturity'];?>개월</td>
										</tr>
										<tr>
											<th>입금액</th>
											<td><?php echo number_format($order_list['o_mh_money']) ?>원</td>
										</tr>
										<tr>
											<th class="last">상태</th>
											<td><?php echo $order_list['o_status'];?></td>
										</tr>
									<?php
									   }
									   if ($i == 0)
										  echo "
										  
										  <tr>
											<th>채권</th>
											<td rowspan=\"5\">입금 정보가 없습니다.</td>
										</tr>
										<tr>
											<th>상환일</t h>
											
										</tr>
										<tr>
											<th>차수/만기</th>
											
										</tr>
										<tr>
											<th>입금액</th>
											
										</tr>
										<tr>
											<th class=\"last\">상태</th>
											
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