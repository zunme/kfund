<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>					
<div class="design tab">
	<div id="tab-1" class="tab-content">
		<div class="dashboard_my_info">
			<h3><span>대출정보</span></h3>
				<div class="dashboard_loan_info">								
					<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 대출정보<a href="{MARI_HOME_URL}/?mode=mypage_loanstatus" class="btn_more">더보기</a></h3>
					<span>현재 대출정보를 확인하실 수 있습니다.</span>		
						<div>
							<table>
								<colgroup>
									<col width="110px">
									<col width="">
								</colgroup>
								<tbody>
									<?php
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
											<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_loan_c.png" alt="납입 금액 확인"  onclick="Calculation2<?php echo $i; ?>()"/></a></td>
										</tr>
									</form>
									<script>
									/*매월 대출금액입금계산*/
									function Calculation2<?php echo $i; ?>() { 
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
							<h3 class="mt30"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 입금현황 <a href="{MARI_HOME_URL}/?mode=mypage_depositstatus" class="btn_more">더보기</a></h3>
							<span>현재 입금현황을 확인하실 수 있습니다.</span>
							<div>
								<table>
									<colgroup>
										<col width="110px">
										<col width="">
									</colgroup>

									<tbody>
									<?php
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
	</div>	
	<div id="tab-2" class="tab-content">
		<div class="dashboard_my_info">
			<h3><span>투자정보</span></h3>
			<div class="dashboard_invest_info">								
				<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 입찰현황<a href="{MARI_HOME_URL}/?mode=mypage_tenderstatus" class="btn_more">더보기</a></h3>
				<span>현재 입찰현황을 확인하실 수 있습니다.</span>					
				<div>
					<table>
						<colgroup>
							<col width="110px">
							<col width="">
						</colgroup>
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
									<td><?php echo $order_pay?>%</td>
								</tr>
								<tr>
									<th>상태</th>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_loan_c1.png" alt="투자 수익 확인"  onclick="Calculation<?php echo $i; ?>()"/></a></td>									
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
				<h3 class="mt30"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 정산현황<a href="{MARI_HOME_URL}/?mode=mypage_investment" class="btn_more">더보기</a></h3>
				<span>현재 정산현황을 확인하실 수 있습니다.</span>
				<div>
					<table>
						<colgroup>
							<col width="110px">
							<col width="">
						</colgroup>
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
				<h3 class="mt30"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 원천징수내역<a href="{MARI_HOME_URL}/?mode=mypage_withholding_list" class="btn_more">더보기</a></h3>
				<span>원천징수내역을 확인하실 수 있습니다.</span>				
				<div>
					<table>
						<colgroup>
							<col width="110px">
							<col width="">
						</colgroup>
						<tbody>
										<?php
											/*원천징수현황*/
											$sql = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
											$order_w = sql_query($sql);
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
			</div><!--dashboard_invest_info-->
		</div>
	</div>
	<div id="tab-3" class="tab-content">
		<div class="dashboard_my_info">
			<h3>관심투자</h3>
			<div class="invest_interest">
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 관심투자</h3>
				<span>관심상품으로 선택하신 투자 상품들을 확인하실수 있습니다.</span>
				<?php
					/*관심투자정보*/
					$sql = " select count(*) as cnt from mari_wishlist where m_id='$user[m_id]'";
					$wish_count = sql_fetch($sql);
					$total_wish= $wish_count['cnt'];
					$rows ="100";
					$total_wish_page  = ceil($total_wish / $rows);  // 전체 페이지 계산
					if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
					$from_record = ($page - 1) * $rows; // 시작 열을 구함

					$sql = "select * from mari_loan order by i_regdatetime desc limit $rows ";
					$wish = sql_query($sql);
					for ($i=0; $row=sql_fetch_array($wish); $i++) {
								$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
								$iv = sql_fetch($sql, false);
								/*투자인원 구하기*/
								/*메인에서는 일단 사용안함
								$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
								$incn = sql_fetch($sql, false);
								$invest_cn = $incn['cnt'];
								*/
								/*대출총액의 투자금액 백분율구하기*/
								$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
								$top=sql_query($sql, false);
								$order = mysql_result($top, 0, 0);
								$total=$row[i_loan_pay];
								/*투자금액이 0보다클경우에만 연산*/
								if($order>0){
								/* 투자금액 / 대출금액 * 100 */
								$order_pay=floor ($order/$total*100);
								}else{
								$order_pay="0";
								}
								/*카테고리분류*/
								$sql = " select  * from  mari_category where ca_id='$row[ca_id]'";
								$cate = sql_fetch($sql, false);

								/*대출총액의 투자금액 백분율구하기*/
								$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
								$top=sql_query($sql, false);
								$order = mysql_result($top, 0, 0);

								/*성별 생년월일*/
								$sql = " select  * from  mari_member where m_id='$row[m_id]'";
								$sex = sql_fetch($sql, false);

								/*나이구하기*/

								/*날짜 자르기*/
								$datetime=$sex['m_birth'];
								$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
								$Y_date = date("Y", strtotime( $datetime ) );
								$M_date = date("m", strtotime( $datetime ) );
								$D_date = date("d", strtotime( $datetime ) );

								$birthday = "".$Y_date."".$M_date."".$D_date."";
								$birthyear = date("Y", strtotime( $birthday )); //생년
								$nowyear = date("Y"); //현재년도
								$age2 = $nowyear-$birthyear+1; //한국나이

								/*위시리스트에 등록내역*/
								$sql = " select  * from  mari_wishlist where m_id='$user[m_id]' and loan_id='$row[i_id]'";
								$wishadd = sql_fetch($sql, false);
								
								/*금액단위변환*/
								if($row['i_loan_pay'] % 100000000 == 0){
									$loa_money = unit2($row[i_loan_pay],8);
								}else{
									$loa_money = unit3($row[i_loan_pay]);
								}

								if($order % 100000000 == 0){
									$iv_money = unit2($order,8);		
								}else{
									$iv_money = unit3($order);
								}

								if($iv['i_view']=="N"){
								}else{

								if($wishadd['loan_id']==$row['i_id']){
				?>
				<div style="margin-bottom:30px; border:1px solid #ddd">
					<div>
						<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv[i_creditratingviews]?>" alt="product" width="100%"  class="product_thumnail">
					</div>
					<div>
						<table>
							<colgroup>
								<col width=""/>
								<col width=""/>
							</colgroup>	
							  <tr>
								<td>연수익률</td>
								<td><span class="color_bl"><?php echo number_format($row[i_year_plus],2);?>%</span></td>
							  </tr>
							  <tr>
								<td>상환기간</td>
								<td><span class="color_bl"><?php echo $row['i_loan_day']?>개월</span></td>
							  </tr>
							  <tr>
								<td>등급</td>
								<td><?php echo $iv['i_grade']?></td>
							  </tr>
							  <tr>
								<td><span class="color_bl"><?php if(!$iv_money){ echo '0'; }else{ echo $iv_money; } ?>원</span>/<?php echo $loa_money; ?>원</td>
								<td><?php echo $order_pay;?>%</td>
							  </tr>
						</table>
					</div><!--invest_interest-->
				</div>
				<?php
					}
					}
					}
					if ($i == 0)
					echo "<tr><td colspan=\"".$colspan."\">등록된 관심투자가 없습니다.</td></tr>";
				?>
			</div>
		</div><!--dashboard_my_info-->
	</div>
	<div id="tab-4" class="tab-content">
		<div class="dashboard_my_info">
			<h3><span>알림메세지</span></h3>
			<div class="dashboard_alert">
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 알림메세지</h3>
				<span>새 소식을 한눈에 알아보세요</span>
				<div class="">
					<p class="alert_msg_title"><span>회원님이 선택하신 관심상품의 상태가 변경 되었습니다!</span><span class="date">06.10.11</span></p>
					<ul class="alert_msg_content">
						<li class="clr"><span class="detail_alert_msg">이것은 자세한 메세지이다 더 많은 내용을 볼 수 있는 공간이지.</span></li>                        	  
					</ul>	
					<p class="alert_msg_title"><span>회원님이 선택하신 관심상품의 상태가 변경 되었습니다! </span><span class="date">06.10.11</span></p>
					<ul class="alert_msg_content">
						<li class="clr"><span class="detail_alert_msg">이것은 자세한 메세지이다 더 많은 내용을 볼 수 있는 공간이지.</span></li>                        	  
					</ul>											
				</div>
				<script>
						$(function(){
						    $(".alert_msg_content").hide();
						    $(".alert_msg_title").click(function(){
							$(".alert_msg_content:visible").slideUp("middle");
							$(this).next('.alert_msg_content:hidden').slideDown("middle");
							return false;
						    })
							});
				</script>
			</div><!--dashboard_interest-->
		</div>
	</div>
	<div id="tab-5" class="tab-content">
		<?php
			if($my=="loanstatus"){
			/*대출신청정보*/
			?>

			<?php
			}else if($my=="depositstatus"){
			/*입금현황*/
			?>

			<?php
			}else if($my=="tenderstatus"){
			/*입찰정보*/
			?>

			<?php
			}else if($my=="investment"){
			/*투자 정산정보*/
			?>

			<?php
			}else if($my=="investment"){
			?>
			<?php
			}else if($my=="investmentinterest"){
			?>

			<?php
			for ($i=0; $row=sql_fetch_array($wish); $i++) {
			$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
			$iv = sql_fetch($sql, false);
			/*투자인원 구하기*/
			/*메인에서는 일단 사용안함
			$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
			$incn = sql_fetch($sql, false);
			$invest_cn = $incn['cnt'];
			*/
			/*대출총액의 투자금액 백분율구하기*/
			$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
			$top=sql_query($sql, false);
			$order = mysql_result($top, 0, 0);
			$total=$row[i_loan_pay];
			/*투자금액이 0보다클경우에만 연산*/
			if($order>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($order/$total*100);
			}else{
			$order_pay="0";
			}
			/*카테고리분류*/
			$sql = " select  * from  mari_category where ca_id='$row[ca_id]'";
			$cate = sql_fetch($sql, false);

			/*대출총액의 투자금액 백분율구하기*/
			$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
			$top=sql_query($sql, false);
			$order = mysql_result($top, 0, 0);

			/*성별 생년월일*/
			$sql = " select  * from  mari_member where m_id='$row[m_id]'";
			$sex = sql_fetch($sql, false);

			/*나이구하기*/

			/*날짜 자르기*/
			$datetime=$sex['m_birth'];
			$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
			$Y_date = date("Y", strtotime( $datetime ) );
			$M_date = date("m", strtotime( $datetime ) );
			$D_date = date("d", strtotime( $datetime ) );

			$birthday = "".$Y_date."".$M_date."".$D_date."";
			$birthyear = date("Y", strtotime( $birthday )); //생년
			$nowyear = date("Y"); //현재년도
			$age2 = $nowyear-$birthyear+1; //한국나이

			/*위시리스트에 등록내역*/
			$sql = " select  * from  mari_wishlist where m_id='$user[m_id]' and loan_id='$row[i_id]'";
			$wishadd = sql_fetch($sql, false);

			if($iv['i_view']=="N"){
			}else{

			if($wishadd['loan_id']==$row['i_id']){
			?>

			<?php
			}
			}
			}
			if ($i == 0)
			echo "<tr><td colspan=\"".$colspan."\">진행중인 투자 리스트가 없습니다.</td></tr>";
			?>
			<?php
			}else if($my=="emoney_list"){
			?>

			<?php
			}else{
		?>
		<div class="dashboard_my_info">
			<h3><span>예치금 관리</span></h3>
			<div class="dashboard_emoney">
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 입/출금 내역</h3>
				<span>예치금의 입/출금 내역을 확인하실 수 있습니다.</span>
				<div>
					<table class="">
						<colgroup>
							<col width="110px">
							<col width="">
						</colgroup>
						<?php
										$login_ck="YES";

										/*입찰정보*/								
										$sql = " select * from mari_emoney where m_id='$user[m_id]'  order by p_id desc";
										$emoney = sql_query($sql);
										for($i=0; $row = sql_fetch_array($emoney); $i++){
						?>
						<tbody>
							<tr>
								<th>일시</th>
								<td><?php echo substr($row[p_datetime],0,10);?></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><?php echo $row[p_content];?></td>
							</tr>
							<tr>
								<th>금액</th>
								<td><?php echo number_format($row[p_emoney]);?>원</td>
							</tr>
							<tr>
								<th class="last">잔액</th>
								<td><?php echo number_format($row[p_top_emoney]);?>원</td>
							</tr>
						</tbody>
						<?php }if($i==0){ ?>
							<tr>
								<th>일시</th>
								<td rowspan=5>예치금거래내역이 없습니다.</td>
							</tr>
							<tr>
								<th>내용</th>
								<td></td>	
							</tr>
							<tr>
								<th>금액</th>
								<td></td>						
							</tr>
							<tr>
								<th class="last">잔액</th>
								<td></td>					
							</tr>
						<?php }?>
					</table>
				</div>
			</div>
			<?php }?>
		</div>
	</div>
	<!--<div id="tab-6" class="tab-content">
		<div class="dashboard_my_info">
			<h3><span>자동투자 예치금 설정</span></h3>
			<div class="dashboard_auto_invest">
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 자동투자예치금</h3>
				<div>
					<table>
						<colgroup>
							<col width="125px"/>
							<col width=""/>
						</colgroup>
						<tbody>
							<tr>
								<td>전환 가능 금액</td>
								<td>
									<input type="text" name="" value="" id="" class="" ><span>원</span>
								</td>
							</tr>
							<tr>
								<td>자동 투자 진행 금액</td>
								<td>
									<input type="text" name="" value="" id="" class="" ><span>원</span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 자동 투자 설정</h3>
				<div class="auto_set">
					<ul>	
						<li>전환 가능 금액의 <input type="text">%</li>
						<li>자동 투자 신청은 <input type="text">개월마다</li>
					</ul>	
				</div>
				<div class="auto_set_txt">
					<p>※ 자동적으로 전환 가능 금액의 퍼센티지에 따라 투자가 됩니다.</p>
					<p>※ 자동 투자를 설정한 기간(단위: 월)에 따라 자동적으로 투자 신청이 됩니다.</p>
				</div>
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 서비스 이용 상태</h3>
				<div class="service_txt">
					<p class="auto_invest_txt1">현재 자동 투자 시스템을 이용하지 않고 있습니다.</p>
					<p class="auto_invest_txt2 red">※ 자동 투자 신청을 원하실 경우 상기 전환 금액의 퍼센티지를 설정한 후 아래의 <img class="mr5 ml5"src="{MARI_HOMESKIN_URL}/img/img_btn_small.png" alt="신청하기" />버튼을 클릭해 주세요.</p>
					<a href="" class="btn_auto_invest btn_auto_invest2">신청하기</a>
				</div>
			</div>
		</div>
	</div>-->
	<div id="tab-7" class="tab-content">
		<div class="dashboard_my_info">
			<h3><span>자동투자 설정</span></h3>
			<div class="dashboard_auto_invest_setting">
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 자동투자예치금</h3>
				<div>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td><span>2,100,000</span>원</td>
							</tr>
						</tbody>
					</table>
					<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_set" class="btn_auto_invest">설정하러 가기</a>
				</div>
				<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 자동투자 신청현황</h3>
				<div>
					<table>
						<colgroup>
							<col width="130px">	
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td>2017.01.18</td>
								<td><span>2,100,000</span>원</td>
							</tr>
						</tbody>
					</table>
					<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_list" class="btn_auto_invest">신청내역 보러가기</a>
				</div>
				<div class="auto_invest_apply">
					<p>안전성 보장, 투자의 간편화</p>
					<p>투자의 위험성 감소, 자동화된 시스템으로 편리함 증대</p>
					<p>1. 선호하는 투자조건을 설정</p>
					<p>2. 조건에 맞는 투자상품을 컨택하여 투자까지 한번에 하는 자동화 서비스</p>
					<span></span>
					<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply"><img src="{MARI_HOMESKIN_URL}/img/img_btn_apply.png" />자동분산투자 신청하기</a>
				</div>
			</div>
		</div>
	</div>	
</div><!--design_tab-->