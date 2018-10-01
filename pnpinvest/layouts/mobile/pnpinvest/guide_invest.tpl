<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#header} 
<script>
$(function(){
    $('#investintro01').click(function(){
       $('#investintro02').removeClass("on")
        $('#investintro03').removeClass("on")
	   $('#investintro01').addClass("on")
	
	/*tab 클릭시 div 변경*/
	   $('div.investintro02').css("display","none");
	   $('div.investintro03').css("display","none");
	  $('div.investintro01').css("display","block");
	
    });
   
	 $('#investintro02').click(function(){
            $('#investintro01').removeClass("on")
	     $('#investintro03').removeClass("on")
		   $('#investintro02').addClass("on")
          
	  /*tab 클릭시 div 변경*/
	   $('div.investintro01').css("display","none");
	   $('div.investintro03').css("display","none");
	  $('div.investintro02').css("display","block");
    });
    	 $('#investintro03').click(function(){
            $('#investintro01').removeClass("on")
	    $('#investintro02').removeClass("on")
		   $('#investintro03').addClass("on")
          
	  /*tab 클릭시 div 변경*/
	   $('div.investintro01').css("display","none");
	   $('div.investintro02').css("display","none");
	  $('div.investintro03').css("display","block");
    });
   
	
});
</script>
   <div class="part1">
       <div class="investguide">
            <ul class="guide_step1">
			 <li id="investintro01" class="on">투자가이드</li>
			 <li id="investintro02">출금가이드</li>
			 <li id="investintro03">대출가이드</li>
             </ul>
		    <div class="investintro01">  
				<ul>
					<li>
						<p class="textleft">
							<span class="text_blue">01</span>
							</br>로그인 후 대시보드에서 예치금 관리 클릭
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide1.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft">
							<span class="text_blue">02</span>
							<br/>은행 선택 후 가상계좌생성 버튼 클릭
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide2.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft">
							<span class="text_blue">03</span>
							<br/>가상계좌생성 후, 인증센터 클릭
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide3.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft">
							<span class="text_blue">04</span>
							<br/>투자상품 정보 확인 후 투자하기 버튼을 클릭해주세요.
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide4.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft">
							<span class="text_blue">05</span>
							<br/>인증센터에서 출금계좌 정보 및
							<br/>원청징수 정보 등록     
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide5.png" alt=""/></p>
					</li>	
					<li>
						<p class="textleft"> 
							<span class="text_blue">06</span>
							       <br/>투자하기 메뉴의 ‘투자상품보기’에서
								<br/>상품선택
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide6.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft"> 
							<span class="text_blue">07</span>
							       <br/>투자상품 정보 확인 후 투자하기 버튼 클릭,
								<br/>투자진행
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide7.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft"> 
							<span class="text_blue">08</span>
							       <br/>투자하기 버튼 클릭시 발송되는 SMS의 문구 회신 후
								<br/>투자 완료
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide8.png" alt=""/></p>
					</li>
				</ul>	
				<div class="btninvest_g">
					<a href="{MARI_HOME_URL}/?mode=invest"class="invest_btn">투자하러가기</a>
				</div><!--/btninvest_g -->
			</div><!--/investintro01 -->
			 <div class="investintro02">  
				<ul>
					<li>
						<p class="textleft">
							<span class="text_blue">01</span>
							<br/>인증센터에서 출금계좌 정보 및 원천징수 정보를
							<br/>등록한 후 계좌검증을 해주세요.
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_withdrawguide1.png" alt=""/></p>
						<div class="m_withdraw">
							<ul>
								<li>
						<p class="textleft">
							<span class="text_orange">SMS검증</span>
							<br/>SMS계좌검증을 클릭하시면 투자자 본인의 
							<br/>휴대전화로 계좌주 조회 SMS가 전송됩니다.
							<br/> 안내 메시지에 따라 네 자리 숫자를 회신해주세요.
							<br/>(1234형식으로 답장)
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide07.png" alt=""/></p>
					</li>
					<li>
						<p class="textleft">
							<span class="text_orange">ARS검증</span>
							<br/>ARS계좌검증을 클릭하시면 투자자 본인의 
							<br/>휴대전화로 ARS가 걸려옵니다. 안내음성에 따라
							<br/>네 자리 숫자를 입력해주세요.(1234형식으로 입력)
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_investguide08.png" alt=""/></p>
					</li>
							</ul>
						</div>
					</li>
					
					<li>
						<p class="textleft">
							<span class="text_blue">02</span>
							  <br/>계좌 검증 완료된 상태에서 예치금관리 > 출금금액 
							  <br/>입력 후 출금신청을 해주세요.
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_withdrawguide2.png" alt=""/></p>
					</li>	
					<li>
					<p class="textleft"> 
						<span class="text_blue">03</span>
							<br/>신청 시 투자자 본인의 휴대전화로 세이퍼트 출금 요청
							<br/>  SMS가 전송됩니다.        
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_withdrawguide3.png" alt=""/></p>
					</li>
					<li>
					<p class="textleft"> 
						<span class="text_blue">04</span>
							<br/>동의 번호를 확인하신 후 해당번호를 회신해 주세요.
							<br/>(1234형식으로 입력)
							<br/>신청 후 약 20분 이내에 이체가 완료됩니다.
						</p>
						<p><img src="{MARI_MOBILESKIN_URL}/img/m_withdrawguide3.png" alt=""/></p>
					</li>
					<li>
					 <p class="textleft"> 
						<span class="text_blue">05</span>
							<br/>출금이 완료되었습니다. 매월 수취하는 원리금은
							<br/>투자자의 가상계좌에 예치금으로 입금됩니다.                 
						</p>
						
					</li>
				</ul>	
				<div class="btninvest_g">
					<a href="{MARI_HOME_URL}/?mode=mypage"class="invest_btn">마이페이지 가기</a>
				</div><!--/btninvest_g -->
				</div><!--/investintro02 -->
				<div class="investintro03">
						<ul>
							<li>
								<h4 class="loan_guidetitle stepg"><img src="{MARI_HOMESKIN_URL}/img/bes_loan1.png" alt="number"class="m_number"/>&nbsp;&nbsp;대출신청</h4>
								<div class="turn_loantxt">
									<img src="{MARI_HOMESKIN_URL}/img/loan_icon1.png" alt="icon" class="iconloan">
									<p class="turn0">사이트 가입 후 대출 신청 양식에 맞게<br/>신청서를 작성하여 제출</p>
								</div>
							</li>
							<li>
								<h4 class="loan_guidetitle"><img src="{MARI_HOMESKIN_URL}/img/bes_loan2.png" alt="number"class="m_number"/>&nbsp;&nbsp;서류 제출 및 심사</h4>
								<div class="turn_loantxt">
									<img src="{MARI_HOMESKIN_URL}/img/loan_icon2.png" alt="icon"class="iconloan">
									<p class="turn0">관련 서류 제출 후 내부·외부 심사 진행<br/>대출 적격성 확인</p>
								</div>
							</li>
							<li>
								<h4 class="loan_guidetitle stepg"><img src="{MARI_HOMESKIN_URL}/img/bes_loan3.png" alt="number" class="m_number"/>&nbsp;&nbsp;투자 진행</h4>
								<div class="turn_loantxt">
									<img src="{MARI_HOMESKIN_URL}/img/loan_icon3.png" alt="icon"class="iconloan">
									<p class="turn0">등록된 펀딩 상품에 한해 진행이 되며<br/>투자 완료 시 대출금 지급</p>
								</div>
							</li>
							<li>
								<h4 class="loan_guidetitle"><img src="{MARI_HOMESKIN_URL}/img/bes_loan4.png" alt="number" class="m_number"/>&nbsp;&nbsp;대출 실행 및 상환</h4>
								<div class="turn_loantxt">
									<img src="{MARI_HOMESKIN_URL}/img/loan_icon4.png" alt="icon"class="iconloan">
									<p class="turn0">대출금이 대출 신청자 계좌로 이체되며<br/>약정 기간동안 상환</p>
								</div>
							</li>
						</ul>
				<div class="btninvest_g">
					<p><a href="{MARI_HOME_URL}/?mode=loan_real" class="btn_step">대출하기</a></p>
				</div>
			</div><!--//loan_guideste -->

	</div><!--/investguide e-->
  </div><!--//part1 e -->


{# footer}