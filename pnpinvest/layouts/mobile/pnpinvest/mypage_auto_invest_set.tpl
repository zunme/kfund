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
					<a href="{MARI_HOME_URL}/?mode=mypage_auto_invest_apply" class="btn_auto_invest btn_auto_invest2">신청하기</a>
				</div>
			</div>
		</div>
		</div>
	</section>
</section>	
{#footer}