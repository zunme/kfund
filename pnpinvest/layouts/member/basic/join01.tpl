<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 회원가입
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#header_sub} 

<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
						<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				<form name="frmRegistraion">
				<input type="hidden" name="agreement1" value="yes">
				<input type="hidden" name="agreement2" value="yes">
				<div class="join_wrap">
					<div class="join_step">
						<ul>
							<li class="current"><p>01. 약관 동의</p></li>
							<li><p>02. 개인/기업</p></li>
							<li><p>03. 본인 인증</p></li>
							<li><p>04. 정보 입력</p></li>
							<li><p>05. 가입 완료</p></li>
						</ul>
					</div>
					<div class="join_section1">
						<!--<h4 class="join_title1">회원 이용약관 확인</h4>-->

						<h4 class="join_title1">· 이용 약관</h5>
						<div class="terms_box">
							<textarea>
<?php echo $config['c_stipulation'];?>
							</textarea>
						</div><!-- /terms_box - 이용약관 -->
						<p class="chk1 line1">
							<label for="agreement1"><input type="checkbox"  name="agreement1" id="agreement1" value="yes" title="약관동의"  />
							{_cosnfig['c_title']} 이용약관에 동의합니다.</label>
						</p>

						<h4 class="join_title1">· 개인 정보 수집 및 이용 안내</h5>
						<!-- <div class="terms_box">
								<textarea>
<?php echo $config['c_privacy'];?>
								</textarea>
							</div> -->
						<div class="terms_box_wrap">
							<div id="tab1">
							<!--	<ul class="tab_btn3">
									<li class="tab_on3"><a href="javascript:click_item('tab1')">수집하는 개인정보 항목</a></li>
									<li><a href="javascript:click_item('tab2')">개인정보 수집 이용목적</a></li>
									<li><a href="javascript:click_item('tab3')">개인정보의 보유 및 이용기간</a></li>
								</ul>-->
								<div class="terms_box">
									<textarea>
										<?php echo $config['c_privacy'];?>
<!--정보통신망법 규정에 따라 '뱅크앤론대부'(이하 “회사” 라 한다)에 회원가입 신청하시는 분께 수집하는 개인정보의 항목을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 
ο 본 방침은 2015년 12월 24일부터 시행됩니다.

수집하는 개인정보 항목
“회사”는 회원가입, 원활한 고객 상담, 각종 서비스 등 기본적인 서비스 제공을 위한 필수정보와 고객 맞춤 서비스 제공을 위한 선택정보로 구분하여 아래와 같은 개인정보를 수집하고 있습니다.

- 수집항목 
회원가입 시 : 별칭, ID, 비밀번호, 성별, 생년월일, 메일수신여부, 가입목적, 서비스 이용기록 , 접속 로그 , 쿠키 , 접속 IP 정보

출금신청 시 : 은행명, 거래계좌번호, 예금주명

[투자회원]
투자정보에 관련된 일체사항

[대출회원]
o 신상정보 (주민등록 발급일, 주민등록주소, 실거주지 증빙여부, 실거주지주소, 가족관계증명서, 동거여부, 기혼여부, 가족관계사항, 병역관련사항, 대학정보 등) 
o 신용정보 및 대출정보 (신용등급/신용점수/조회건수/대출정보구분,등록일,변동일,기관명,주택담보여부,예적금담보여부, 보증정보, 등록일, 변동일, 보증기관 명, 보증금액/채무 불이행정보/금융질서 문란정보, 특수기록정보, 공공기록정보의 경우는 공통적으로 발생하는 일자, 해제일자, 기관명, 등록사유, 연체정보, 신용거래의 모든 사항). 
o 소득정보 (직군/직종/직군 상세/재직증명서확인 및 발급일/ 직장명/직장주소/근속기관/소득형태/급여소득)(월별, 년별, 기간별 소득금액, 소득정보와 관계된 주 거래 ,일반거래 통장의 잔고 및 내역등)
o 자산정보 (주택증빙여부, 주택유형, 근저당금액, 임대차계약서-시작, 종료일, 보증금, 월세, 전세 차량소유정보에 관한 사항, 차량유형/차량압류건수,차량저당건수,차량보험가입유무등) 
o 대출정보에 관련된 일체사항
[개인 사업자 또는 법인 대출회원]
o 담당자 또는 대표자의 성명 및 주민등록번호, 아이디, 비밀번호, 닉네임, 휴대 전화번호, 유선 전화번호, 병역기록, 이동통신사, 자택 및 직장 주소, 생년월일, 성별, 법인명, 사업자등록번호, 자본금 및 설립현황, 법인번호, 업종, 이메일 주소, 사업장 소재지, 이메일 주소 서비스 이용기록 , 재무현황, 접속 로그 , 쿠키 , 접속 IP 정보 , 방문 일시 , 서비스 이용기록 , 불량 이용기록, 가입목적 , 가입경로 대출정보, 투자정보 신용카드 정보, 은행계좌 정보, 결제기록 등 
o 신상정보 (주민등록 발급일, 주민등록주소, 실거주지 증빙여부, 실거주지주소, 가족관계증명서, 동거여부, 기혼 여부등) 
o 신용정보 및 대출정보 (법인 신용정보 및 대표자 개인사업자의 신용등급/신용점수/조회건수/대출정보구분,등록일,변동일,기관명,주택담보여부,예적금담보여부, 보증정보 등록일, 변동일, 보증기관명, 보증금액/채무 불이행정보/금융질서문란정보, 특수기록정보, 공공기록정보의 경우는 공통적으로 발생하는 일자, 해제일자, 기관명, 등록사유, 연체정보, 신용거래의 일체의 사항)
o 소득정보 (직군/직종/직군 상세/ 재직 증명서확인 및 발급일/ 직장명/직장주소/근속기관/소득형태/급여소득(월별, 년별, 기간별 소득금액, 사업소득 및 법인소득, 업태, 종목, 과세시작일, 과세종료일, 매출합계, 과세군, 면세군, 납부세액) 소득정보와 관계된 주거래, 일반거래 통장의 잔고 및 내역 등 일체의 사항, 재무현황과 관련된 일체사항) 
o 자산정보 (주택증빙여부, 주택유형, 근저당금액, 임대차계약서-시작,종료일, 보증금, 월세, 전세 차량소유정보에 관한사항, 차량유형/차량압류건수,차량저당건수,차량보험가입유무등 
o 신용능력정보 (금융거래 등 상거래와 관련하여 발생한 개인 또는 기업의 재산, 채무, 소득의 총액, 납세실적, “회사”의 개황, 사업의 내용 등 일반정보, 재무상태, 재무비율 등 재무의 관한 사항, 감사인의 감사의견 및 납세실적등 비 재무에 관한 사항, 신용정보 주체의 신용거래능력을 판단할 수 있는 능력정보일체)-->
								
									</textarea>
								</div>
							</div><!-- /tab1 -->

							<div id="tab2" style="display:none;">
								<ul class="tab_btn3">
									<li><a href="javascript:click_item('tab1')">수집하는 개인정보 항목</a></li>
									<li class="tab_on3"><a href="javascript:click_item('tab2')">개인정보 수집 이용목적</a></li>
									<li><a href="javascript:click_item('tab3')">개인정보의 보유 및 이용기간</a></li>
								</ul>
								<div class="terms_box">
									<textarea>
정보통신망법 규정에 따라 '뱅크앤론대부'(이하 “회사” 라 한다)에 회원가입 신청하시는 분께 개인정보의 수집 및 이용목적을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 
ο 본 방침은 2015년 12월 24일부터 시행됩니다.

개인정보의 수집 및 이용목적
“회사”는 수집한 개인정보를 다음의 목적을 위해 활용합니다.

이용자가 제공한 모든 정보는 하기 목적에 필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 사전 동의를 구할 것입니다.

ο 서비스 제공에 관한 계약 이행 및 관리, 서비스 제공에 따른 요금정산
콘텐츠 제공, 서비스 개발 및 개선, 서비스이용 구매 및 요금 결제, 서비스를 이용하여 체결된 각종의 계약 이행에 있어 필요한 관리 및 연체자에 대한 관리, 채무 불 이행시의 위험관리, 경매 시스템의 관리, 물품배송 또는 청구지 등 발송, 금융거래 본인 인증 및 금융서비스, 대출, 투자 서비스 이용과 관련되어 제공된 정보를 수집 보관 합니다.

ο 회원 관리
회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 불만처리 등 민원처리 , 고지사항 전달

ο 마케팅 및 광고에 활용
신규 서비스 개발과 이벤트 행사에 따른 정보 전달 및 맞춤 서비스 제공, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계								
									</textarea>
								</div>
							</div><!-- /tab2 -->

							<div id="tab3" style="display:none;">
								<ul class="tab_btn3">
									<li><a href="javascript:click_item('tab1')">수집하는 개인정보 항목</a></li>
									<li><a href="javascript:click_item('tab2')">개인정보 수집 이용목적</a></li>
									<li class="tab_on3"><a href="javascript:click_item('tab3')">개인정보의 보유 및 이용기간</a></li>
								</ul>
								<div class="terms_box">
									<textarea>
정보통신망법 규정에 따라 '뱅크앤론대부'(이하 “회사” 라 한다)에 회원가입 신청하시는 분께 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 
ο 본 방침은 2015년 12월 24일부터 시행됩니다.

개인정보의 보유 및 이용기간

“회사”는 회원가입일로부터 서비스를 제공하는 기간 동안에 한하여 이용자의 개인정보를 보유 및 이용하게 됩니다.
회원 탈퇴를 요청하거나 개인정보의 수집 및 이용에 대한 동의를 철회하는 경우, 수집 및 이용목적이 달성되거나 보유 및 이용기간이 종료한 경우 해당 개인정보를 지체 없이 파기합니다.
단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 “회사”는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.
o 보존 항목: 성명, 주민등록번호, 아이디, 비밀번호, 닉네임, 휴대 전화번호, 유선 전화번호, 이동통신사, 자택주소, “회사”주소, 기타주소, 생년월일, 성별, 이메일 주소, 서비스 이용기록 , 접속 로그 , 쿠키 , 접속 IP 정보 , 가입목적 , 가입경로
o 보존 근거: 전자상거래등에서 소비자 보호에 관한 법률
o 보존 기간: 5년 
o 보존 항목: 서비스 이용기록, 접속 로그, 접속 IP 정보
o 표시/광고에 관한 기록: 6개월
o 계약 또는 청약철회 등에 관한 기록: 5년
o 대금결제 및 재화 등의 공급에 관한 기록: 5년
o 소비자의 불만 또는 분쟁처리에 관한 기록: 3년									
									</textarea>
								</div>
							</div><!-- /tab3 -->
						</div><!-- /terms_box_wrap - 개인정보 수집 및 이용 안내 -->
						<p class="chk1">
							<label for="agreement2"><input type="checkbox" name="agreement2" id="agreement2" value="yes"  />
							개인 정보 수집 및 이용에 동의합니다.</label>
						</p>
					</div><!-- /join_section1 -->

					<!--<div class="join_section2">
						<p>※ 입력하신 정보는 본인확인용으로 사용되며, 회원 가입이 완료되면 사용자 확인을 위해 회원정보에 저장 됩니다.</p>
						<p style="text-indent:15px; ">타인의 정보 및 주민등록번호를 부정하게 사용하는 경우 3년 이하의 징역 또는 1천만원 이하의 벌금에 처해지게 됩니다.</p>
					</div>-->
					<div class="btn_wrap7">
						<a href="{MARI_HOME_URL}/?mode=join0" class="btn_list" id="agree_ok" alt="다음">다음</a>
					</div>
				</div><!-- /join_wrap -->
				</form>
				<form name="frmJoin">
				<input type="hidden" name="flag"/>
				<input type="hidden" name="agent"/>
				</form>
			</div><!-- /sub_content -->
		</div><!-- /container -->
<script>
$(function() {
	var f = document.frmRegistraion;
	$('#agree_ok').click(function(){
		if(!$('#agreement1').is(':checked')){alert('<?php echo $config[c_title];?> 이용약관에 동의하셔야 합니다.'); return false;}
		if(!$('#agreement2').is(':checked')){alert('개인정보 수집항목 및 수집방법에 동의하셔야 합니다.'); return false;}
		//if(!$('#agreement2').is(':checked') && !$('#agreement3').is(':checked')){alert('개인정보 수집 및 이용에 동의하셔야 합니다.'); return false;}
		nextStep(f);
	});
	$('#agree_no').click(function(){
		location.href = '{MARI_HOME_URL}/?mode=join1';
	});
});
function nextStep(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?mode=join2';
	f.submit();
}
</script>

<script type="text/javascript">
	/*menu tab*/
	function click_item(id) {
		var str = "tab1,tab2,tab3";
		var s = str.split(',');
		for (i=0; i<s.length; i++)
		{
			if (id=='*') document.getElementById(s[i]).style.display = 'block';
			else document.getElementById(s[i]).style.display = 'none';
		}
		if (id!='*') document.getElementById(id).style.display = 'block';
	}
 </script>

{#footer}<!--하단-->

 

		


		
