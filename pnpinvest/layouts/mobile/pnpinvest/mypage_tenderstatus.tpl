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
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 전체입찰현황</h3>
								<span>전체입찰현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="110px">
											<col width="">
										</colgroup>
										<tbody>
										<?php
										$sql = " select * from mari_invest where m_id='$user[m_id]' order by i_regdatetime desc";
									$laon = sql_query($sql);
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
												<th>제목</th>
												<td><?php echo $iv_pr[i_invest_name];?></td>
											</tr>
											<tr>
												<th>아이디</th>
												<td><?php echo $row[m_id];?></td>
											</tr>
											<tr>
												<th>신청금액</th>
												<td><?php echo unit2($row['i_loan_pay']) ?>원</td>
											</tr>
											<tr>
												<th>이자율</th>
												<td><?php echo unit($row['i_profit_rate']) ?>%</td>
											</tr>
											<tr>
												<th>상환 기간</th>
												<td><?php echo $losale[i_loan_day];?>개월</td>
											</tr>
											<tr>
												<th>입찰액</th>
												<td><?php echo unit2($row['i_pay']) ?>원</td>
											</tr>
											<tr>
												<th>진행율</th>
												<td><?php echo $order_pay;?>%</td>
											</tr>
											<tr>
												<th>상태</th>
												<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_loan_c.png" alt="투자 수익 확인"  onclick="Calculation<?php echo $i; ?>()"/></a></td>									
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
							</div>														
						</div>	
					</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->