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
							<!---->
						</div>

						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_interest">
							<h3><span>관심투자</span></h3>
							<div class="dashboard_interest">
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 관심투자</h3>
								<span>관심상품으로 선택하신 투자 상품들을 확인하실수 있습니다.</span>
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

							
								/*모집마감일 체크*/
								if($iv ['i_invest_eday']<$date){
									$invest_set="Y";
								}else{
									$invest_set="N";
								}
								if($order_pay=="100"){
									$invest_max="Y";
								}
								?>
								<div>
									<div class="invest_interest">
										<div>
											<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv[i_creditratingviews]?>" alt="product" width="150" height="99.55" class="product_thumnail">
										</div>
										<div>
											<table>
												<colgroup>
													<col width=""/>
													<col width=""/>
													<col width=""/>
													<col width=""/>
													<col width=""/>
													<col width=""/>
												</colgroup>
												<tbody>
													<tr>
														<th colspan="6"><?php echo $row['i_subject']?></th>
													</tr>
													<tr>
														<th colspan="6">&lt;자금용도&gt; - <?php echo $row['i_purpose']?></th>
													</tr>
													<tr>
														<th>연수익률</th><td><span><?php echo number_format($row['i_year_plus'],2);?>%</span></td><th>상환기간</th><td><span><?php echo $row['i_loan_day']?>개월</span></td><th>등급</th><td><span><?php echo $iv['i_grade']?></span></td>
													</tr>
													<tr>
														<th colspan="6">
															<div class="pro-bar-container color-green-sea" style="width:650px;">
																<div class="pro-bar color-peter-river animated" style="width:<?php echo $order_pay;?>%" data-pro-bar-percent="<?php echo $order_pay;?>%" data-pro-bar-delay="30">
																	<div class="pro-bar-candy candy-ltr"></div>
																</div>
															</div><!--//invest_percent2_bar e -->
														</th>
													</tr>
													<tr>
														<th><span><?php if(!$iv_money){ echo '0'; }else{ echo $iv_money; } ?>원</span>/<?php echo $loa_money; ?>원</th><td>&nbsp;</td><th>&nbsp;</th><td>&nbsp;</td><th>&nbsp;</th><td><?php echo $order_pay;?>%</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div><!--invest_interest-->
								<?php }}}?>
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