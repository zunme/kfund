<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->
<section id="container">
		<section id="sub_content">
			<div class="mypage_wrap">
				<div class="container">
					<h3 class="s_title1">투자 정보</h3>
					<div class="my_inner2">
					<?php if($my=="loanstatus"){/*대출신청정보*/?>
						<?php }else{?>
					<h4 class="my_title2">입찰 현황</h4>
						<table class="type3 mb70">
							<colgroup>
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
									<th>제목</th>
									<th>신청금액</th>
									<th>상환기간</th>
									<th>이자율</th>
									<th>입찰액</th>
									<th>진행률</th>
									<th>상태</th>
									<!--<th>투자수익확인</th>!-->
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
									<td><?php echo unit($row['i_loan_pay']) ?>만원</td>
									<td><?php echo $losale[i_loan_day];?>개월</td>
									<td><?php echo unit($row['i_profit_rate']) ?>%</td>
									<td><?php echo unit($row['i_pay']) ?>만원</td>
									<td><?php if(!$iv_pr[i_invest_per]){?>0<?php }else{?><?php echo $iv_pr[i_invest_per];?><?php }?>%</td>
									<td><?php if($iv_pr['i_look']=="Y"){?>투자 진행중<?php }else if($iv_pr['i_look']=="C"){?>투자 마감<?php }else{?>투자 시작전<?php }?></td>
									<!--<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/invest_c_bt.png" alt="투자수익금액" onclick="Calculation<?php echo $i; ?>()"/></a></td>!-->
								</tr>
							</form>
							<script>
							/*매월 투자수익계산*/
							function Calculation<?php echo $i; ?>() { 
								var f=document.inset_form<?php echo $i; ?>;
								var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
								window.open("about:blank", "calculation<?php echo $i; ?>", opt);
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
						<div class="paging">
						<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_laon_page, '?mode='.$mode.''.$qstr.'&amp;page='); ?>
						</div><!-- /paging -->
				<h4 class="my_title2">정산 현황</h4>
						<table class="type3">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>투자금액</th>
									<th>회차</th>
									<th>총회수금</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
							<?php
										  for ($i=0; $orders_list=sql_fetch_array($order_s); $i++) {
										  $to_order=$orders_list['o_ln_money_to']+$orders_list['o_interest']+$orders_list['o_saleodinterest'];
										$sql = "select i_year_plus from mari_loan where i_id='$orders_list[loan_id]'";
										$plus = sql_fetch($sql, false);
										?>
								<tr>
									<td><?php echo $orders_list['o_subject'];?></td>
									<td><?php echo number_format($orders_list['o_ipay']) ?>원</td>
									<td><?php echo $orders_list['o_count'];?>회차</td>
									<td>
										<ul class="tb_txt1">
											<li><strong>원금</strong><?php echo number_format($orders_list['o_ln_money_to']) ?>원</li>
											<li><strong>이자</strong><?php echo number_format($orders_list['o_interest']) ?>원</li>
											<li><strong>연체이자</strong><?php echo number_format($orders_list['o_saleodinterest']) ?>원</li>
											<li><strong>합계</strong><?php echo number_format($to_order) ?>원</li>
										</ul>
									</td>
									<td><?php echo $orders_list['o_salestatus'];?></td>
								</tr>

								<?php
									}
									if($i == 0)
										echo "<tr><td colspan=\"12\">투자현황이 없습니다.</td></tr>";
								?>
							</tbody>
						</table>
						<div class="paging">
									<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_orders_page, '?mode='.$mode.''.$qstr.'&amp;page='); ?>
									</div><!-- /paging -->
						<?php }?>
						 

					</div><!-- /my_inner2 -->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->



{# footer}<!--하단-->