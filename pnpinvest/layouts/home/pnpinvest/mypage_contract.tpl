
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#sub_header}
<div class="right1">					
						<h5 class="present">계약 관리</h5>
						<table class="application_loan">
							<colgroup>
								<col width="50px">
								<col width="600px">
								<col width="px">
							</colgroup>									
							<tbody>
								<tr>
									<th>NO</th>
									<th>대출신청리스트</th>
									<th>계약서작성</th>
								</tr>
								<form name="laon_form0" method="post" enctype="multipart/form-data" target="lcalculation0"></form>
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="12">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="7500000">
								<input type="hidden" name="loan_id" value="142">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>142</td>
									<td>돈 주세요(테스트)</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="100000">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="100000">
								<input type="hidden" name="loan_id" value="136">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>136</td>
									<td>100000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="100000">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="100000">
								<input type="hidden" name="loan_id" value="135">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>135</td>
									<td>100000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="134">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>134</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="133">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>133</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="132">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>132</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="131">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>131</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="15">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="500000">
								<input type="hidden" name="loan_id" value="130">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>130</td>
									<td>100</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="213213">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="123123">
								<input type="hidden" name="loan_id" value="128">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>128</td>
									<td>12312</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="500000">
								<input type="hidden" name="loan_id" value="126">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>126</td>
									<td>신용정보조회 체크테스트</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="122">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>122</td>
									<td>test_subject3333</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="11">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="11111">
								<input type="hidden" name="loan_id" value="125">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>125</td>
									<td>11</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="124">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>124</td>
									<td>test_subject2</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="123">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>123</td>
									<td>test_subject2</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="12">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="5000000">
								<input type="hidden" name="loan_id" value="115">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>115</td>
									<td>테스트 </td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="13">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="1500000">
								<input type="hidden" name="loan_id" value="102">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>102</td>
									<td>펀딩 신청합니다</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="11">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="65000000">
								<input type="hidden" name="loan_id" value="17">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>17</td>
									<td>사업 운영자금으로 신청합니다.</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--//right1 e -->



<?php }else{?>


{#header}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
<div id="container">
	<div id="sub_content">
				<div class="title_wrap title_bg11">
					<div class="title_wr_inner">
						<h3 class="title2"><!--<?php echo $config['c_title'];?>-->TEN PLUS FUNDING 마이페이지</h3>
						<!--<p class="sub_title">MY PAGE</p>-->
						<p class="title_add1">나의 개인정보 관리 및 대출/투자 현황을 확인하실 수 있습니다.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>MY페이지</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
		<div class="mypage">
			<div class="mypage_inner">
				<div class="left_menu mt30">
						<ul>
							<li class="first"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li> <li><a href="{MARI_HOME_URL}/?mode=mypage_emoney" ><span></span><p>거래내역</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>e머니 내역</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_charge"><span></span><p>충전 신청</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_withdrawal"><span></span><p>출금 신청</p></a></li>
							<li class="current"><a href="{MARI_HOME_URL}/?mode=mypage_contract"><span></span><p>계약 관리</p></a></li>
						</ul>
					</div><!--//left_menu e -->
				<div class="right_content mt30 ml22">
					<div class="right1">					
						<h5 class="present">계약 관리</h5>
						<table class="application_loan">
							<colgroup>
								<col width="50px">
								<col width="600px">
								<col width="px">
							</colgroup>									
							<tbody>
								<tr>
									<th>NO</th>
									<th>대출신청리스트</th>
									<th>계약서작성</th>
								</tr>
								<form name="laon_form0" method="post" enctype="multipart/form-data" target="lcalculation0"></form>
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="12">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="7500000">
								<input type="hidden" name="loan_id" value="142">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>142</td>
									<td>돈 주세요(테스트)</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="100000">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="100000">
								<input type="hidden" name="loan_id" value="136">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>136</td>
									<td>100000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="100000">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="100000">
								<input type="hidden" name="loan_id" value="135">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>135</td>
									<td>100000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="134">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>134</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="133">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>133</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="132">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>132</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="10000">
								<input type="hidden" name="loan_id" value="131">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>131</td>
									<td>10000</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>								
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="15">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="500000">
								<input type="hidden" name="loan_id" value="130">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>130</td>
									<td>100</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="213213">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="123123">
								<input type="hidden" name="loan_id" value="128">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>128</td>
									<td>12312</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="500000">
								<input type="hidden" name="loan_id" value="126">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>126</td>
									<td>신용정보조회 체크테스트</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="12">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="122">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>122</td>
									<td>test_subject3333</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="11">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="11111">
								<input type="hidden" name="loan_id" value="125">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>125</td>
									<td>11</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="124">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>124</td>
									<td>test_subject2</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="10">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="200000">
								<input type="hidden" name="loan_id" value="123">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>123</td>
									<td>test_subject2</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="36">
								<input type="hidden" name="i_year_plus" value="12">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="5000000">
								<input type="hidden" name="loan_id" value="115">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>115</td>
									<td>테스트 </td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>										
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="13">
								<input type="hidden" name="i_repay" value="원리금균등상환">
								<input type="hidden" name="i_loan_pay" value="1500000">
								<input type="hidden" name="loan_id" value="102">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>102</td>
									<td>펀딩 신청합니다</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>									
								<input type="hidden" name="i_loan_day" value="24">
								<input type="hidden" name="i_year_plus" value="11">
								<input type="hidden" name="i_repay" value="만기일시상환">
								<input type="hidden" name="i_loan_pay" value="65000000">
								<input type="hidden" name="loan_id" value="17">
								<input type="hidden" name="stype" value="loan">
								<tr>
									<td>17</td>
									<td>사업 운영자금으로 신청합니다.</td>
									<td><a href="{MARI_HOME_URL}/?mode=contract_login">작성</a></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--//right1 e -->
				</div>
				<!--//right_content e --> 
			</div>
			<!--//mypage_inner e -->
		</div>
		<!--//mypage e -->
	</div>
	<!--//main_content e -->
</div>
<!--//container e -->

<?}?>
{#footer}