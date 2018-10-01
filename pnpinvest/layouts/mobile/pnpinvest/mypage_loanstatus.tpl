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
						<h3><span>대출정보</span></h3>
						<div class="dashboard_loan_info">								
							<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 대출정보</h3>
							<span>전체 대출현황을 확인하실 수 있습니다.</span>
							
							<div>
								<table>
									<colgroup>
										<col width="110px">
										<col width="">
									</colgroup>
									<tbody>
									<?php
										/*대출신청현황*/
										
										$sql = " select * from mari_loan where m_id='$user[m_id]' order by i_regdatetime desc";
										$laons = sql_query($sql);

										  for ($i=0; $laons_list=sql_fetch_array($laons); $i++) {
											/*현재상태구하기*/
											$sql = "select  i_look from  mari_invest_progress where loan_id='$laons_list[i_id]'";
											$iv = sql_fetch($sql, false);
											/*입찰합계구하기*/
											$sql="select sum(i_pay) from mari_invest"; 
											$top=sql_query($sql, false);
											$t_pay = mysql_result($top, 0, 0);
											/*투자인원 구하기*/
											$sql = " select count(*) as cnt from mari_invest where loan_id='$laons_list[i_id]' order by i_pay desc";
											$incn = sql_fetch($sql, false);
											$invest_cn = $incn['cnt'];
											/*대출총액의 투자금액 백분율구하기*/
											$sql="select sum(i_pay) from mari_invest where loan_id='$laons_list[i_id]'"; 
											$top=sql_query($sql, false);
											$orders = mysql_result($top, 0, 0);
											$total=$laons_list[i_loan_pay];
											/*투자금액이 0보다클경우에만 연산*/
											if($orders>0){
												/* 투자금액 / 대출금액 * 100 */
												$order_pay=floor ($orders/$total*100);
											}else{
												$order_pay="0";
											}
									?>
									<form name="laon_form<?php echo $i; ?>"  method="post" enctype="multipart/form-data"  target="calculation<?php echo $i; ?>">
									<input type="hidden" name="i_loan_day" value="<?php echo $laons_list[i_loan_day]; ?>">
									<input type="hidden" name="i_year_plus" value="<?php echo $laons_list[i_year_plus]; ?>">
									<input type="hidden" name="i_repay" value="<?php echo $laons_list[i_repay]; ?>">
									<input type="hidden" name="i_loan_pay" value="<?php echo $laons_list[i_loan_pay]; ?>">
									<input type="hidden" name="loan_id" value="<?php echo $laons_list[i_id]; ?>">
									<input type="hidden" name="stype" value="loan"/>
										<tr>	
											<th>제목</th>
											<td><?php echo $laons_list['i_subject']; ?></td>
										</tr>
										<tr>
											<th>신청금액</th>
											<td><?php echo unit($laons_list['i_loan_pay']) ?>만원</td>
										</tr>	
										<tr>
											<th>현재 투자 인원</th>
											<td><?php echo number_format($invest_cn) ?>명</td>
										</tr>	
										<tr>
											<th>현재 투자 금액</th>
											<td><?php echo unit($orders) ?><?php if($orders){?>만원<?php }else{?>모집중<?php }?></td>
										</tr>	
										<tr>
											<th>진행율</th>
											<td><?php echo $order_pay;?>%</td>
										</tr>	
										<tr>
											<th>접수일</th>
											<td><?php echo substr($laons_list['i_regdatetime'],0,10); ?></td>
										</tr>
										<tr>
											<th>상태</th>
											<td>
											<?php if($iv[i_look]=="Y"){ echo '투자진행중';}else if($iv[i_look]=="C"){ echo '투자마감'; }else if($iv[i_look]=="N"){ echo '투자대기';}else if($iv[i_look]=="D"){ echo '상환중'; }else if($iv[i_look]=="F"){ echo '상환완료'; }?>
											</td>
										</tr>
										<tr>
											<th class="last">납입 금액 확인</th>
											<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_loan_c.png" alt="납입 금액 확인"  onclick="Calculation<?php echo $i; ?>()"/></a></td>
										</tr>
									</form>
									<script>
									/*매월 대출금액입금계산*/
									function Calculation<?php echo $i; ?>() { 
									  var f=document.laon_form<?php echo $i; ?>;
									var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
									  window.open("about:blank", "calculation<?php echo $i?>", opt);
									  f.action="{MARI_HOME_URL}/?mode=calculation";
									  f.submit();
									}
									</script>
									<?php
									   }
									   if ($i == 0)
										  echo "<tr><td colspan=\"8\">대출 신청 정보가 없습니다.</td></tr>";
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