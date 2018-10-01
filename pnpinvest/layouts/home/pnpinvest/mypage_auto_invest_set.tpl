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
							<h3><span>자동투자 예치금 설정</span></h3>
							<div class="dashboard_auto_invest auto_invest_setting">
								<div class="auto_emoney">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동투자 예치금</h3>
									<table>
										<colgroup>
											<col width="135px"/>
											<col width=""/>
										</colgroup>
										<tbody>
											<tr>
												<td>전환 가능 금액</td>
												<td>
													<input type="text" name="" value="" id="" class="" >원
												</td>
											</tr>
											<tr>
												<td>자동 투자 진행 금액</td>
												<td>
													<input type="text" name="" value="" id="" class="" >원
												</td>
											</tr>
										</tbody>
									</table>
								</div><!--자동투자 예치금-->
								<div>
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동 투자 설정</h3>
									<div>
										<ul>	
											<li>전환 가능 금액의 <input type="text">%</li>
											<li>자동 투자 신청은 <input type="text">개월마다</li>
										</ul>
									</div>
									<p class="red">※ 자동적으로 전환 가능 금액의 퍼센티지에 따라 투자가 됩니다.</p>
									<p class="red">※ 자동 투자를 설정한 기간(단위: 월)에 따라 자동적으로 투자 신청이 됩니다.</p>
								</div><!--자동투자 설정-->
								<div>
									<span></span>
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">서비스 이용 상태</h3>
									<p class="auto_invest_txt1">현재 자동 투자 시스템을 이용하지 않고 있습니다.</p>
									<p class="auto_invest_txt2 red">※ 자동 투자 신청을 원하실 경우 상기 전환 금액의 퍼센티지를 설정한 후<br/>오른쪽의 <img class="mr5 ml5"src="{MARI_HOMESKIN_URL}/img/img_btn_small.png" alt="신청하기" />버튼을 클릭해 주세요.</p>
									<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply" class="btn_auto_invest btn_auto_invest2">신청하기</a>
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