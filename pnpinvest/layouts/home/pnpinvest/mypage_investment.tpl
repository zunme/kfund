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
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 전체정산현황</h3>
								<span>전체정산현황을 확인하실 수 있습니다.</span>
								
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
												<th rowspan="2"  class="last">상태</th>
											</tr>
											<tr class="part1">
												<th>원금</th>
												<th>이자</th>
												<th>연체이자</th>
												<th class="last ">합계</th>
											</tr>
										</thead>
										<tbody>
										<?php
											/*투자 정산정보*/

											/*투자정산정보*/
											$sql = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
											$order_s_count = sql_fetch($sql);
											$total_order_s = $order_s_count['cnt'];
											$rows ="10";
											$total_orders_page  = ceil($total_order_s / $rows);  // 전체 페이지 계산
											if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
											$from_record = ($page - 1) * $rows; // 시작 열을 구함
											$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
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
									<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_orders_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
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