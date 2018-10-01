<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
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
							<h3><span>자동분산투자 신청현황</span></h3>
							<div class="dashboard_auto_invest auto_invest_setting">
								<div class="auto_invest_list">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 신청현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply_all" class="btn_more">더보기</a></h3>
									<p>현재 자동투자 신청정보를 확인할 수 있습니다.</p>
									<table>
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th>신청일자</th>
												<th>신청금액</th>
												<th>선호이율</th>
												<th>자동투자정보</th>
												<th>투자내역</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>17-02-02</td>
												<td>2,100,000원</td>
												<td>18%</td>
												<td><a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_info_pop" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false" class="btn_auto_list">보기</a></td>
												<td><a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_list_pop" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false" class="btn_auto_list">확인하기</a></td>
											</tr>
										</tbody>
									</table>
								</div><!--자동투자 신청현황-->
								<div class="auto_invest_list">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 입찰현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_tender" class="btn_more">더보기</a></h3>
									<p>현재 자동투자 입찰정보를 확인할 수 있습니다.</p>
									<table>
										<colgroup>
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
											<col width="11%">
										</colgroup>
										<thead>
											<tr>
												<th>신청일자</th>
												<th>입찰일자</th>
												<th>신청금액</th>
												<th>투자금액</th>
												<th>상품명</th>
												<th>이자율</th>
												<th>투자기간</th>
												<th>상태</th>
												<th>수익</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>17-02-02</td>
												<td>17-02-02</td>
												<td>2,100,000원</td>
												<td>900,000원</td>
												<td>3호 신용대출</td>
												<td>18%</td>
												<td>12개월</td>
												<td>투자마감</td>
												<td><a href="javascript:;" class="btn_auto_list">정산금액확인</a></td>
											</tr>
										</tbody>
									</table>
								</div><!--자동투자 입찰현황-->
								<div class="auto_invest_list">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 정산현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_adjust" class="btn_more">더보기</a></h3>
									<p>현재 자동투자 정산현황를 확인할 수 있습니다.</p>
									<table>
										<thead>
											<tr>
												<th>정산일자</th>
												<th>정산금액</th>
												<th>상품명</th>
												<th>이자율</th>
												<th>정산회차/투자기간</th>
												<th>투자금액</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>17-02-16</td>
												<td>2,100,000원</td>
												<td>3호 신용대출</td>
												<td>18%</td>
												<td>1회/12개월</td>
												<td>900,000원</td>
												<td>상환중</td>
											</tr>
										</tbody>
									</table>
								</div><!--자동투자 정산현황-->
							</div><!--dashboard_balance-->
						</div>
						</form>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->

{#footer}