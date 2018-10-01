<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#header_sub}
<div id="container">
	<div id="sub_content">
		<div class="mypage">
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
							<h3><span>대출정보</span></h3>
							<div class="dashboard_loan_info">								
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 입금현황</h3>
								<span>대출하신 상품에 대한 입금현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="257px">
											<col width="173px">
											<col width="173px">
											<col width="152px">
											<col width="129px">
										</colgroup>
										<thead>
											<tr>
												<th>채권</th>
												<th>상환일</th>
												<th>차수/만기</th>
												<th>입금액</th>
												<th class="last">상태</th>
											</tr>
										</thead>
										<tbody>
										<?php

										/*입금현황*/
										$sql = " select count(*) as cnt from mari_order  where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc";
										$order_count = sql_fetch($sql);
										$total_order = $order_count['cnt'];
										$rows ="10";
										$total_order_page  = ceil($total_order / $rows);  // 전체 페이지 계산
										if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
										$from_record = ($page - 1) * $rows; // 시작 열을 구함
										$sql = " select * from mari_order   where  user_id='$user[m_id]' group by o_count order by o_count asc, o_datetime desc limit $from_record, $rows ";
										$order = sql_query($sql);
										  for ($i=0; $order_list=sql_fetch_array($order); $i++) {
										?>
											<tr>
												<td><?php echo $order_list['o_payment'];?></td>
												<td><?php echo substr($order_list[o_datetime],0,10); ?></td>
												<td><?php echo $order_list['o_count'];?>회차 / <?php echo $order_list['o_maturity'];?>개월</td>
												<td><?php echo number_format($order_list['o_mh_money']) ?>원</td>
												<td><?php echo $order_list['o_status'];?></td>
											</tr>
										<?php
										   }
										   if ($i == 0)
										      echo "<tr><td colspan=\"5\">입금 정보가 없습니다.</td></tr>";
										?>
										</tbody>
									</table>
									<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_order_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
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