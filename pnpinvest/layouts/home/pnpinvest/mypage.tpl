<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
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
							<!---->
						</div>
						<!--마이페이지 헤더-->
						{# mypage_header}

					</div><!--dash_side--e-->
					<div class="dashboard_allbox">

					<div class="dashboard_content">
					
					<div class="dashboard_alert_msg">
							<img src="{MARI_HOMESKIN_URL}/img/icon_mypage_alert.png" alt="icon_mypage_alert"/> <p>알림 메세지</p>
					<?php 
						for ($i=0; $row=sql_fetch_array($push_list); $i++) {
					?>
							<span><?php echo $row['pm_msg']?></span>
					<?php
					}
					if ($i == 0)
						echo "<span>내역이 없습니다.</span>";
					?>
							<a href="{MARI_HOME_URL}/?mode=mypage_alert" class="btn_alert">더보기</a>
						</div>

						<div class="dashboard_account_info">
						
							<?php if(!$seyck['s_accntNo']){?>
							<div class="before">
								<h3>가상계좌 정보</h3>
								<p class="mb30">* 투자를 희망하시는 분은 가상계좌를 생성해주십시오.</p>
								<hr/>
								<a href="?mode=mypage_balance" >가상계좌 생성하기</a>
							</div>	
							<?php }?>
							<?php if(!$user['m_my_bankacc']){?>
							<div class="before">
								<h3>출금계좌 정보</h3>
								<p>* 본인 계좌정보를 입력하신 후 계좌검증을 완료하셔야<br/> 출금이 가능합니다.</p>
								<hr/>
								<a href="?mode=mypage_confirm_center">출금계좌 등록하기</a>
							</div>
							<?php }?>
							<?php if($seyck['s_accntNo']){?>
							<div class="after">
								<h3>가상계좌 정보</h3>
								<hr/>
								<table>
									<colgroup>
										<col width="160px"/>
										<col width="160px"/>
									</colgroup>
									<tbody>
										<tr>
											<th>은행</th>
											<td>
												<?php if($seyck[s_bnkCd]=="KEB_005"){?>
													외환은행
												<?php }else if($seyck[s_bnkCd]=="KIUP_003"){?>
													기업은행
												<?php }else if($seyck[s_bnkCd]=="NONGHYUP_011"){?>
													농협중앙회
												<?php }else if($seyck[s_bnkCd]=="SC_023"){?>
													SC제일은행
												<?php }else if($seyck[s_bnkCd]=="SHINHAN_088"){?>
													신한은행
												<?php }?>											
											</td>
										</tr>
										<tr>
											<th>예금주</th>
											<td>
												<?php echo $seyck[m_name]?>(가상계좌)
											</td>
										</tr>
										<tr>
											<th>가상계좌</th>
											<td>
												<?php if($seyck[s_bnkCd]=="KEB_005"){?>
													<?php echo $seyck[s_accntNo]?>
												<?php }else if($seyck[s_bnkCd]=="KIUP_003"){?>
													<?php echo $seyck[s_accntNo]?>
												<?php }else if($seyck[s_bnkCd]=="NONGHYUP_011"){?>
													<?php echo $seyck[s_accntNo]?>
												<?php }else if($seyck[s_bnkCd]=="SC_023"){?>
													<?php echo $seyck[s_accntNo]?>
												<?php }else if($seyck[s_bnkCd]=="SHINHAN_088"){?>
													<?php echo $seyck[s_accntNo]?>
												<?php }?>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<?php }?>

							<?php if($user['m_my_bankcode'] && $user['m_my_bankacc']){?>
							<div class="after">
								<h3>출금계좌 정보</h3>
								<a href="?mode=mypage_balance">예치금관리</a>
								<hr/>
								<table>
									<colgroup>
										<col width="160px"/>
										<col width="160px"/>
									</colgroup>
									<tbody>
										<tr>
											<th>은행</th>
											<td>
												<?php echo bank_name($user[m_my_bankcode])?>									
											</td>
										</tr>
										<tr>
											<th>예금주</th>
											<td>
												<?php echo $user['m_my_bankname'];?>
											</td>
										</tr>
										<tr>
											<th>출금계좌</th>
											<td>
												<?php echo $user['m_my_bankacc']?>
											</td>
										</tr>
										<tr>
											<th>출금가능액</th>
											<td>
												<?php
													/*foreach 파싱 데이터출력*/
													foreach($decode_lnq as $key=>$value){
														$moneyPair=$value['moneyPair'];/*현재잔액*/

														$amount=$moneyPair['amount'];/*현재잔액*/
														if($amount=="S" || $amount=="E"){
														}else{
													?>
														<?php echo $amount;?>

													<?php
														}
													   }
													?>
																원
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<?php }?>
							<div>
								<a href="?mode=mypage_calculate_schedule" class="dash_btn">월별정산스케줄 ></a>
								<!--<a href="?mode=mypage_auto_invest" class="dash_btn">자동투자 설정  ></a>-->
							</div>
						</div>
						<div class="dashboard_invest">
							<h3>투자 요약</h3>
							<div class="summary_invest">
								<div class="accrue_invest">
									<p>누적 투자금</p>
									<strong><?php echo number_format($t_pay2); ?>원</strong>
								</div>
								<!--2018.01.31 누적금액 변경  이경희-->
								<?
									/* 2018-01-31 투자요약부분의 누적 금액들 구하기  이경희 */
											$sql = "SELECT * FROM mari_order WHERE sale_id='$user[m_id]' ";
											$cum_amount = sql_query($sql, false);

									/* 2018-01-31 투자요약부분의 누적 금액들 구하기  이경희 */

									for($i=0; $s_order=sql_fetch_array($cum_amount); $i++){
										if($s_order['o_count']==$s_order['o_maturity'] && $s_order['o_paytype']=="만기일시상환"){
											$s_principal += $s_order['o_ln_money_to']; //원금합산
											$s_interest += $s_order['o_interest']; //이자합산

										}else if($s_order['o_paytype']=="원리금균등상환"){
											$s_principal += $s_order['o_ln_money_to']; //원금합산
											$s_interest += $s_order['o_interest']; //이자합산
										}else{

											$s_principal += 0; //원금합산
											$s_interest += $s_order['o_interest']; //이자합산
										}
									}
								?>
								<div class="list_accrue_invest">
									<ul>
<!-- 										<li><span class="txt_l">누적 투자 회수금</span><p class=""><?php echo number_format($e_pay) ?>원</p></li> -->
<!-- 										<li><span class="txt_l">누적 투자 회수 원금</span><p class=""><?php echo number_format($Recoveryofprincipal) ?>원</p></li> -->
<!-- 										<li><span class="txt_l">누적 수익금</span><p class=""><?php echo number_format($Cumulativeearnings) ?>원</p></li> -->
<!-- 										<li><span class="txt_l">잔여 상환금</span><p class=""><?php echo number_format($Theremainingprincipal) ?>원</p></li> -->
										<li>
											<span class="txt_l">누적 투자 회수금</span>
												<p class="">
													<?php echo number_format($s_principal+$s_interest)?>원
												</p>
										</li>
										<li>
											<span class="txt_l">누적 투자 회수 원금</span>
												<p class="">
													<?php echo number_format($s_principal)?>원
												</p>
										</li>
										<li>
											<span class="txt_l">누적 수익금</span>
												<p class="">
												<?php echo number_format($s_interest)?>원
												</p>
										</li>
										<li>
											<span class="txt_l">잔여 상환금</span>
												<p class="">
													<?php echo number_format($t_pay2-$s_principal)?>원
												</p>
										</li>
									</ul>
								</div>
							</div>
							<div class="summary_profit">
								<div class="average_profit">
									<p>평균 수익률(연)</p>
									<strong><?php echo number_format($top_invest_plus2,2);?>%</strong>
								</div>
								<div class="list_average_profit">
									<ul>
										<li><span class="txt_l">상환 중</span><p class=""><?php echo number_format($Ofrepayment_count);?>건</p></li>
										<li><span class="txt_l">상환 완료</span><p class=""><?php echo number_format($Ofrepaymentout_count);?>건</p></li>
										<li><span class="txt_l">연체</span><p class=""><?php echo $Overdue_count?>건</p></li>
										<li><span class="txt_l">채권 발생</span><p class=""><?php echo $bond_count?>건</p></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="dashboard_loan">
							<h3>대출 요약</h3>
							<div class="summary_loan">
								<div class="accrue_loan">
									<p>누적 대출금</p>
									<strong><?php echo unit2($t_loan_pay2); ?>원</strong>
								</div>
								<div class="list_accrue_loan">
									<ul>
										<li><span class="txt_l">누적 대출 상환금</span><p class=""><?php echo number_format($Loanrepayments) ?>원</p></li>
										<li><span class="txt_l">누적 이자금</span><p class="">0원</p></li>
										<li><span class="txt_l">잔여 상환 원금</span><p class=""><?php echo number_format($o_totalamount) ?>원</p></li>
									</ul>
								</div>
							</div>
							<div class="summary_interest">
								<div class="average_interest">
									<p>평균 이자율(연)</p>
									<strong><?php echo number_format($top_plus2,2);?>%</strong>
								</div>
								<div class="list_average_interest">
									<ul>
										<li><span class="txt_l">상환 중</span><p class=""><?php echo number_format($Loanrepayment_count);?>건</p></li>
										<li><span class="txt_l">상환 완료</span><p class=""><?php echo number_format($repaycomplete_count);?>건</p></li>
										<li><span class="txt_l">연체</span><p class=""><?php echo $total_over;?>건</p></li>
										<li><span class="txt_l">채권 발생</span><p class=""><?php echo $total_loan;?>건</p></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>

				</div><!--dashboard-->
			</div><!--mypage_inner-->
		</div><!--mypage-->
<script type="text/javascript">
function sendit(){
	if(document.f.s_bnkCd[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
								
	document.f.action='{MARI_HOME_URL}/?up=virtualaccountissue';
	document.f.submit();
}
</script>
{#footer}<!--하단-->