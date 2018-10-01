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
							<h3><span>자동투자 설정</span></h3>
							<div class="dashboard_auto_invest">
								<div>
									<table class="table_auto_invest">
										<colgroup>
											<col width="120px"/>
											<col width="276px"/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>자동투자 예치금</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td></td>
												<td><span>2,100,000</span>원</td>
											</tr>
										</tbody>
									</table>
									<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_set" class="btn_auto_invest">설정하러 가기</a>
								</div><!--자동투자 예치금-->
								<div>
									<table class="table_auto_invest">
										<colgroup>
											<col width="120px"/>
											<col width="276px"/>
										</colgroup>
										<thead>
											<tr>
												<th colspan="2"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/>자동투자 신청현황</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>2017.01.18</td>
												<td><span>2,100,000</span>원 신청</td>
											</tr>
										</tbody>
									</table>
									<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_list" class="btn_auto_invest">신청내역 보러가기</a>
								</div><!--자동투자 신청현황-->
								<div class="auto_invest_apply">
									<p>안전성 보장, 투자의 간편화</p>
									<p>투자의 위험성 감소, 자동화된 시스템으로 편리함 증대</p>
									<p>1. 선호하는 투자조건을 설정</p>
									<p>2. 조건에 맞는 투자상품을 컨택하여 투자까지 한번에 하는 자동화 서비스</p>
									<span></span>
									<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply"><img src="{MARI_HOMESKIN_URL}/img/img_btn_apply.png" />자동분산투자 신청하기</a>
								</div>
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