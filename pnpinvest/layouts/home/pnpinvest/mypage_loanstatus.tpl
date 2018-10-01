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
							<h3><span>대출정보</span></h3>
							<div class="dashboard_loan_info">								
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 전체대출현황</h3>
								<span>전체대출현황을 확인하실 수 있습니다.</span>
								
								<div>
									<table>
										<colgroup>
											<col width="166px">
											<col width="93px">
											<col width="117px">
											<col width="127px">
											<col width="55px">
											<col width="100px">
											<col width="100px">
											<col width="125">
										</colgroup>
										<thead>
											<tr>
												<th>제목</th>
												<th>신청금액</th>
												<th>현재 투자 인원</th>
												<th>현재 투자 금액</th>
												<th>진행율</th>
												<th>접수일</th>
												<th>상태</th>
												<th class="last">납입 금액 확인</th>
											</tr>
										</thead>
										<tbody>
										<?php
											
											/*대출신청현황*/
											$sql = " select count(*) as cnt from mari_loan where m_id='$user[m_id]'";
											$laons_count = sql_fetch($sql);
											$total_laons= $laons_count['cnt'];
											$rows ="10";
											$total_laons_page  = ceil($total_laons / $rows);  // 전체 페이지 계산
											if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
											$from_record = ($page - 1) * $rows; // 시작 열을 구함
											$sql = " select * from mari_loan where m_id='$user[m_id]' order by i_regdatetime desc limit $from_record, $rows ";
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
												<td><?php echo $laons_list['i_subject']; ?></td>
												<td><?php echo unit($laons_list['i_loan_pay']) ?>만원</td>
												<td><?php echo number_format($invest_cn) ?>명</td>
												<td><?php echo unit($orders) ?><?php if($orders){?>만원<?php }else{?>모집중<?php }?></td>
												<td><?php echo $order_pay;?>%</td>
												<td><?php echo substr($laons_list['i_regdatetime'],0,10); ?></td>
												<td>
												<?php if($iv[i_look]=="Y"){ echo '투자진행중';}else if($iv[i_look]=="C"){ echo '투자마감'; }else if($iv[i_look]=="N"){ echo '투자대기';}else if($iv[i_look]=="D"){ echo '상환중'; }else if($iv[i_look]=="F"){ echo '상환완료'; }?>
												</td>
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
									<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_laons_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
								</div>
							</div><!--dashboard_loan_info-->
						</div>
					</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}