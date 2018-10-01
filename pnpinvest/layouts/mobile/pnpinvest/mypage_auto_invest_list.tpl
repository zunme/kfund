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
				<h3><span>자동분산투자 신청현황</span></h3>
				<div class="dashboard_auto_invest auto_invest_setting">
					<div class="auto_invest_list">
						<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 신청현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply_all" class="btn_more">더보기</a></h3>
						<p>현재 자동투자 신청정보를 확인할 수 있습니다.</p>
						<table>
							<colgroup>
								<col width="110px">
								<col width="">
							</colgroup>
							<tbody>
								<tr>
									<th>신청일자</th>
									<td>17-02-02</td>
								</tr>
								<tr>
									<th>신청금액</th>
									<td>2,100,000원</td>
								</tr>
								<tr>
									<th>선호이율</th>
									<td>18%</td>	
								</tr>
								<tr>
									<th>자동투자정보</th>
									<td><a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_info_pop" class="btn_auto_list">보기</a></td>
								</tr>
								<tr>
									<th>투자내역</th>
									<td><a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_list_pop" class="btn_auto_list">확인하기</a></td>
								</tr>
							</tbody>
						</table>
					</div><!--자동투자 신청현황-->
					<div class="auto_invest_list">
						<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 입찰현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_tender" class="btn_more">더보기</a></h3>
						<p>현재 자동투자 입찰정보를 확인할 수 있습니다.</p>
						<table>
							<colgroup>
								<col width="110px">
								<col width="">
							</colgroup>
							<tbody>
								<tr>
									<th>신청일자</th>
									<td>17-02-02</td>
								</tr>
								<tr>
									<th>입찰일자</th>
									<td>17-02-02</td>
								</tr>
								<tr>
									<th>신청금액</th>
									<td>2,100,000원</td>
								</tr>
								<tr>
									<th>투자금액</th>
									<td>900,000원</td>
								</tr>
								<tr>
									<th>상품명</th>
									<td>3호 신용대출</td>
								</tr>
								<tr>
									<th>이자율</th>
									<td>18%</td>
								</tr>
								<tr>
									<th>투자기간</th>
									<td>12개월</td>
								</tr>
								<tr>
									<th>상태</th>
									<td>투자마감</td>
								</tr>
								<tr>
									<th>수익</th>
									<td><a href="javascript:;" class="btn_auto_list">정산금액확인</a></td>
								</tr>
							<tbody>
						</table>
					</div><!--자동투자 입찰현황-->
					<div class="auto_invest_list">
						<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 정산현황<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_adjust" class="btn_more">더보기</a></h3>
						<p>현재 자동투자 정산현황를 확인할 수 있습니다.</p>
						<table>
							<colgroup>
								<col width="110px">
								<col width="">
							</colgroup>
							<tbody>
								<tr>
									<th>정산일자</th>
									<td></td>
								</tr>
								<tr>
									<th>정산금액</th>
									<td></td>
								</tr>
								<tr>
									<th>상품명</th>
									<td></td>
								</tr>
								<tr>
									<th>이자율</th>
									<td></td>
								</tr>
								<tr>
									<th>정산회차/투자기간</th>
									<td></td>	
								</tr>
								<tr>
									<th>투자금액</th>
									<td></td>
								</tr>
								<tr>
									<th>상태</th>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div><!--자동투자 정산현황-->
				</div><!--dashboard_balance-->
			</div>	
		</div>
	</section>
</section>	
{#footer}