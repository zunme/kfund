{# new_header}

<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t2"><span class="motion" data-animation="flash">고객지원</span></h2>
	<!-- invest view -->
	<style>
	body{background-color: #eeeeee;}
	.material-tabs {
display: block;
float: left;
padding: 16px;
padding-top: 0;
width: 100%;

position: relative;
margin: 96px auto;
background: #fff;
#box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0, 0, 0, 0.23) !important;
border-radius: 6px;
}


.visible {
position: relative;
opacity: 1;
width: 100%;
height: auto;
float: left;
transition: opacity .35s ease;
z-index: 3;
}

.hidden {
position: absolute;
opacity: 0;
z-index: 0;
transition: opacity 0s ease;
}
.hidden img {
display: none;
}

[class*="tabbed-section-"] {
float: left;
color: #000;
}
[class*="tabbed-section-"] img {
display: block;
width: 80%;
margin: auto 10%;
}

.tabbed-section__selector {
position: relative;
height: 50px;
top: -31.2px;
left: -16px;
padding: 0;
margin: 0;
width: 100%;
float: left;
}
.tabbed-section__selector [class*="-tab-"] {
float: left;
display: block;
height: 50px;
line-height: 50px;
width: 100px;
text-align: center;
background: #fff;
font-weight: bold;
text-decoration: none;
color: black;
font-size: 14px;
}
.tabbed-section__selector [class*="-tab-"].active {
color: #4F2CCA;
}
.tabbed-section__selector a:first-child {
border-top-left-radius: 2px;
}
.tabbed-section__selector a:last-of-type {
border-top-right-radius: 2px;
}

.tabbed-section__highlighter {
position: absolute;
z-index: 10;
bottom: 0;
height: 2px;
background: #4F2CCA;
max-width: 100px;
width: 100%;
-webkit-transform: translateX(0);
			transform: translateX(0);
display: block;
left: 0;
transition: -webkit-transform 0.23s ease;
transition: transform 0.23s ease;
transition: transform 0.23s ease, -webkit-transform 0.23s ease;
}
.tabbed-section__selector-tab-6.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(500px);
			transform: translateX(500px);
}

.tabbed-section__selector-tab-5.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(400px);
			transform: translateX(400px);
}

.tabbed-section__selector-tab-4.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(300px);
			transform: translateX(300px);
}

.tabbed-section__selector-tab-3.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(200px);
			transform: translateX(200px);
}

.tabbed-section__selector-tab-2.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(100px);
			transform: translateX(100px);
}

.tabbed-section__selector-tab-1.active ~ .tabbed-section__highlighter {
-webkit-transform: translateX(0);
			transform: translateX(0);
}

.divider {
background: rgba(0, 0, 0, 0.1);
position: relative;
display: block;
float: left;
width: 100%;
height: 1px;
margin: 8px 0;
padding: 0;
overflow: hidden;
}


@media all and (max-width: 670px) {
.material-tabs {
		max-width: 100%;
		left: 0;
	}
.tabbed-section__selector{height: 100px;position: static;    margin-top: -30px; margin-bottom: 30px;box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0, 0, 0, 0.23) !important;}
.tabbed-section__highlighter{display:none}
.tabsselector {border:1px solid #eee}
.tabsselector.active {border-bottom: 2px solid #4F2CCA;}
	.tabbed-section__selector [class*="-tab-"] {
		width:33.3%
	}
}
</style>
<style>
.qa_con dt {
    transition: .2s ease-out;
    width: 100%;
    padding: 10px;
     background-color: #FFF;
    display: block;
    margin: 0 1px 2px;
    border: 1px solid #ccc;
    color: #006691;
    font-size: 16px;
		    font-weight: 400;
    cursor: pointer;
}

.qa_con dd.on {
    opacity: 1;
    height: auto;
    border: 1px solid #cccccc;
    margin-top: 3px;
    padding: 10px;
}
</style>
	<div class="support">
		<div class="container">
			<div class="material-tabs">
			  <div class="tabbed-section__selector">
			    <a class="tabbed-section__selector-tab-1 tabsselector active" data-tab="tabid01" href="#">투자가이드</a>
			    <a class="tabbed-section__selector-tab-2 tabsselector" data-tab="tabid02" href="#">출금가이드</a>
			    <a class="tabbed-section__selector-tab-3 tabsselector" data-tab="tabid03" href="#">대출가이드</a>
					<a class="tabbed-section__selector-tab-4 tabsselector" data-tab="tabid04" href="#">투자 FAQ</a>
					<a class="tabbed-section__selector-tab-5 tabsselector" data-tab="tabid05" href="#">대출 FAQ</a>
					<a class="tabbed-section__selector-tab-6 tabsselector" data-tab="tabid06" href="#">계정 FAQ</a>


			    <span class="tabbed-section__highlighter"></span>
			  </div>


			  <div class="tabbed-section-1 visible tabssection" id="tabid01">
					<h4 class="title on">투자 가이드</h4>
					<div class="">
<style>
.timeline li{padding:0;}
.timeline {margin :25px;}
.timeline .event{
	    padding: 0px 35px;
}
.timeline > .event.left{
	border-left: 4px solid #006691;
	padding-top:10px;
	padding-bottom:10px;
	position: relative;
}
.timeline .event.left:after {
	position: absolute;
  display: block;
  top: 0;
  /* box-shadow: 0 0 0 6px #006691; */
  left: -16px;
  background: #00ae9d;
  border-radius: 50%;
  height: 30px;
  width: 30px;
  content: attr(data-no);
  top: 35px;
  text-align: center;
  line-height: 30px;
	color:white;
}

.timeline > .event.right{
	border-right: 4px solid #006691;
	padding-top:10px;
	padding-bottom:10px;
	margin-top:-4px;
	position: relative;
}
.timeline .event.center_circle:after{
	font-family: "Font Awesome 5 Free";
	    font-family: FontAwesome;
	    font-style: normal;
	    font-weight: normal;
	    text-decoration: inherit;
	    color: #000;
	    /* padding-right: 0.5em; */
	    font-size: 30px;
	    color: black;
	    content: '\f234';
	    height: 38px;
	    width: 38px;
	    border-radius: 25px;
	    display: inline-block;
	    float: right;
	    /* background-color: #00ae9d; */
	    margin-right: -35px;
	    color: #00ae9d;
	    margin-top: -20px;
}
.timeline .event.right:after {
	position: absolute;
	display: block;
	top: 0;
	/* box-shadow: 0 0 0 6px #006691; */
	right: -16px;
	background: #00ae9d;
	border-radius: 50%;
	height: 30px;
	width: 30px;
	line-height: 30px;
	content: attr(data-no);
	top: 36px;
	text-align: center;
	color:white;
}
.event.line{
	height: 50px;
}
.line_right_bottom{
	    margin-bottom: 10px;
}
.timeline > .event.line_left_top:before{
	content: ' ';
height: 35px;
width: 35px;
border-bottom-left-radius: 25px;
border-left: 4px solid #006691;
border-bottom: 4px solid #006691;
display: inline-block;
margin-left: -35px;
}
.timeline > .event.line_left_bottom:before{
	content: ' ';
	height: 35px;
	width: 35px;
	border-top-left-radius: 25px;
	border-left: 4px solid #006691;
	border-top: 4px solid #006691;
	display: inline-block;
	margin-left: -35px;
	position: absolute;
	margin-top: -4px;
}
.timeline > .event.line_left_bottom {
	padding-top: 25px;
	height: 46px;
}
.timeline > .event.line_right_bottom:after{
	content: ' ';
	height: 35px;
	width: 35px;
	border-top-right-radius: 25px;
	border-right: 4px solid #006691;
	border-top: 4px solid #006691;
	display: inline-block;
	/* margin-right: 25px; */
	/* margin-top: 25px; */
	float: right;
	margin-right: -35px;
	margin-top: -4px;
}
.timeline > .event.line_right_top:after{
	content: ' ';
	height: 35px;
	width: 35px;
	border-bottom-right-radius: 25px;
	border-right: 4px solid #006691;
	border-bottom: 4px solid #006691;
	display: inline-block;
	/* margin-right: 25px; */
	/* margin-top: 25px; */
	float: right;
	margin-right: -35px;
	margin-top: -35px;
}
.bottomline{
	margin-top: -4px;
  border-bottom: 4px solid #006691;
}
.btn-new{
	margin-top: 10px;
	padding-left: 24px;
	padding-right: 24px;
	background-color: #00ae9d;
	border-color: #00ae9d;
}
.btn-new:hover{
	background-color: #00ae9d;
	border-color: #00ae9d;
}

.li h5{ color:}
</style>
<ul class="timeline">
    <li class="event left" data-no="1">
			<h5>01 회원가입 및 개인정보 등록</h5>
		<p>로그인 후 마이페이지&gt;회원정보수정&gt;서류 등록 및 원전징수정보를 입력합니다. </p>
<!-- <a href="javascript:;" class="btn btn-new modal-link" data-img="/pnpinvest/img/chulgum_guide1.jpg" data-title="회원가입 및 개인정보 등록">보기</a> -->
    </li>
		<li class="event line line_left_top line_right_bottom">
			<div class="bottomline"></div>
		</li>

    <li class="event right" data-no="2">
			<h5>02 가상계좌 발급 및 투자 예치금 입금</h5>
      <p>마이페이지&gt;입·출금관리&gt;가상계좌발급 버튼을 눌러 가상계좌를 발급 후, 투자 예치금을 입금 합니다. </p>
      <p>(입금 시 충전 금액 반영까지는 최대 5분이 소요될 수 있습니다.)</p>
    </li>
		<li class="event line line_left_bottom line_right_top">
			<div class="bottomline"></div>
		</li>

    <li class="event left"  data-no="3">
			<h5>03 투자하기</h5>
      <p>투자하기 페이지로 이동하여 진행중인 투자상품을 선택 후 투자하기 버튼을 클릭합니다.</p>
    </li>
		<li class="event line line_left_top line_right_bottom">
			<div class="bottomline"></div>
		</li>

    <li class="event right"  data-no="4">
			<h5>04 약관동의 및 비밀번호 입력</h5>
      <p>투자 약관동의 체크 및 비밀번호 입력 후 투자신청 버튼을 클릭합니다.</p>
    </li>
		<li class="event line line_left_bottom line_right_top">
			<div class="bottomline"></div>
		</li>
		<li class="event left"  data-no="5">
			<h5>05 세이퍼트 거래동의 및 투자 완료</h5>
      <p>회원가입 시 등록되었던 휴대폰번호로 세이퍼트 거래 동의 숫자가 발송되며,<br> 해당 숫자 4자리를 회신하면 투자가 완료됩니다. </p>
		</li>
		<li class="event line line_left_top center_circle" style="width:53%">
			<div class="bottomline"></div>
		</li>
		<li class="event"  data-no="" style="text-align:center;margin-top:20px;">
			<a href="/pnpinvest/?mode=join01" class="btn btn-join btn-rose">회원가입하러가기</a>

		</li>
  </ul>

<!--- / ----------------------->
					</div>
			  </div>
			  <div class="tabbed-section-2 hidden tabssection" id="tabid02">
					<!-- 출금 가이드 -->
			    <h4 class="title on">출금 가이드</h4>
					<ul class="timeline">
    <li class="event left" data-no="1">
			<h5>01 출금계좌 등록</h5>
		<p>로그인 후 마이페이지&gt;인증센터&gt;출금계좌입력 후 계좌등록하기 버튼을 클릭합니다. </p>
		<p>(회원정보상의 이름과 계좌주 명의가 일치해야 합니다.))</p>
<!-- <a href="javascript:;" class="btn btn-new modal-link" data-img="/pnpinvest/data/photoreviewers/1/메인사진.jpg" data-title="어쩌구 저쩌구로 가자구요">여기에 어쩌구 저저구</a>
    </li> -->
		<li class="event line line_left_top line_right_bottom">
			<div class="bottomline"></div>
		</li>

    <li class="event right" data-no="2">
			<h5>02 계좌검증 진행</h5>
      <p>SMS인증 또는 ARS인증 중 선택하여 세이퍼트 숫자 4자리를 회신 후 계좌 검증을 완료합니다.</p>

    </li>
		<li class="event line line_left_bottom line_right_top">
			<div class="bottomline"></div>
		</li>

    <li class="event left" data-no="3">
			<h5>03 출금신청</h5>
      <p>마이페이지&gt;입·출금관리&gt;출금액을 입력 후 출금하기 버튼을 클릭합니다.</p>
    </li>
		<li class="event line line_left_top line_right_bottom">
			<div class="bottomline"></div>
		</li>

    <li class="event right" data-no="4">
			<h5>04 출금동의 진행</h5>
      <p>회원정보상의 휴대폰으로 세이퍼트 출금 요청 SMS가 전송되며, 해당 숫자 4자리를 회신합니다.</p>
    </li>
		<li class="event line line_left_bottom line_right_top">
			<div class="bottomline"></div>
		</li>
		<li class="event left" data-no="5">
			<h5>05 출금완료</h5>
      <p>등록된 출금계좌로 출금이 완료되었습니다. </p>
      <p>(각 은행별 전산 사정에 따라 출금 신청 후 입금까지 1~5분정도 소요될 수 있습니다.) </p>
		</li>
		<li class="event line line_left_top center_circle" style="width:53%">
			<div class="bottomline"></div>
		</li>
		<li class="event" data-no="" style="text-align:center;margin-top:20px;">
			<a href="/pnpinvest/?mode=mypage" class="btn btn-join btn-rose">마이페이지</a>

		</li>
  </ul>
					<!-- / 출금 가이드 -->
			  </div>
			  <div class="tabbed-section-3 hidden tabssection" id="tabid03">
					<h4 class="title on">대출 가이드</h4>

						<!-- new-->
<style>
.timeline__list {
  padding: 0;
  list-style: none;
  position: relative;
	    margin-bottom: -50px;
}

.timeline__list::before,
.timeline__list::after {
  content: " ";
  display: table;
}

.timeline__list::after {
  clear: both;
}

.timeline__item {
  float: left;
  clear:left;
  margin-bottom: 150px;
  position: relative;
  width: 50%;
}

.timeline__item_inverted {
  float: right;
  clear: right;
}

.timeline__body {
  font-size: 19px;
  line-height: 24px;
}

.timeline__body > p:first-child:first-letter {
  color: darkred;
  font-size: 55px;
  font-weight: 700;
  float:left;
  padding-bottom: 5px;
  margin: 14px 5px 0 0;
}

.timeline__body::before {
  height:2px;
  content:"";
  width: calc(100% + 10vw);
  transform: translate(-5vw);
  background-color: darkred;
  display: block;
  margin-bottom: 20px;
}

.timeline__item:last-child,
.timeline__item:nth-last-child(2) {
  /*SHOULD ALSO BE FOR THE ONE BEFORE LAST*/
  margin-bottom: 0;
}

.timeline__item:nth-child(2) {
  margin-top: 60px;
}



.timeline__footer {
  display: none;

}


.timeline__panel {
  margin: 0 5vw 70px 5vw;
}

.timeline__heading {
    font-weight: 700;
    font-size: 36px;
    line-height: 35px;
    margin: 20px 0 20px;
    line-height: 1em;
}

.timeline__badge {
  display: none;
}

div.timeline {
  position: relative;
  padding: 90px 0 40px 0;
  margin: 0 5vw 0 5vw;
}

/*
div.timeline::before {
  color: lightgrey;
  content: "\f0e7";
  font-family: FontAwesome;
  font-size: 18px;
  font-style: normal;
  font-weight: normal;
  left: 50%;
  transform: translate(-50%);
  position: absolute;
  top: 0px;
}
*/
.timeline__list::before {
    background: lightgrey;
    bottom: -40px;
    content:"";
    display:block;
    left: 50%;
    transform: translate(-50%); /* better than: margin-left: -1px; */ /* go back half of the width towards left to center */
    position: absolute;
    top: -60px;
    width: 2px;
}
.timeline__list::before {
    background: #006691;
    bottom: -40px;
    content: "";
    display: block;
    left: 50%;
    transform: translate(-50%);
    position: absolute;
    top: -60px;
    width: 2px;
}
.timeline__body::before {
    height: 2px;
    content: "";
    width: calc(100% + 10vw);
    transform: translate(-5vw);
    background-color: #006691;
    display: block;
    margin-bottom: 20px;
}
.timeline__body {
    font-size: 14px;
    line-height: 24px;
}
.timeline__body::before {
    height: 1px;
    content: "";
    width: calc(100% + 10vw);
    transform: translate(-5vw);
    background-color: #006691;
    display: block;
    margin-bottom: 20px;
}
.timeline__heading {
	font-weight: 700;
	font-size: 1.3em;
	line-height: 35px;
	margin: 20px 0 7px;
	line-height: 1em;
	color: black;
}
.timeline__list::before {
    background: #006691;
    bottom: 124px;
    content: "";
    display: block;
    left: 50%;
    transform: translate(-50%);
    position: absolute;
    top: 0px;
    width: 2px;
}
div.timeline {
    position: relative;
    padding: 65px 0 0px 0px;
    margin: 0px 5vw 0 5vw;
}
/* END of Timeline*/
</style>
<div class="timeline">
<ol class="timeline__list">
<li class="timeline__item">
<div class="timeline__badge">
<a><i class="fa fa-circle" id=""></i></a>
</div>
<div class="timeline__panel">
<h4 class="timeline__heading">Step 01 대출신청</h4>
<div class="timeline__body">
<p></p>
<p>케이펀딩 회원가입 후 대출 신청 양식에 맞게 신청서를 작성하여 제출</p>



</div>

</div>
<div class="timeline__panel">
<h4 class="timeline__heading">Step03 투자 진행</h4>
<div class="timeline__body">
<p></p>
<p>등록 및 오픈된 투자상품에 한해 진행이 되며 투자 완료 시 대출금 지급</p>



</div>

</div></li>

<li class="timeline__item timeline__item_inverted clearfix">
<div class="timeline__badge">
<a><i class="fa fa-circle" id=""></i></a>
</div>
<div class="timeline__panel">
<h4 class="timeline__heading">Step 02 서류심사</h4>
<div class="timeline__body">
<p></p><p>관련 서류 제출 후 내부·외부 심사 진행 대출 적격성 확인</p>
</div>
<div class="timeline__footer">
<p class="text-right">2</p>
</div>
</div>
</li>







<li class="timeline__item timeline__item_inverted">
<div class="timeline__badge">
<a><i class="fa fa-circle invert" id=""></i></a>
</div>
<div class="timeline__panel">
<h4 class="timeline__heading">Step04 대출 실행 및 상환</h4>
<div class="timeline__body">
<p></p><p>대출금이 대출 신청자 계좌로 이체되며 약정 기간동안 상환</p>
</div>
<div class="timeline__footer">
<p class="text-right">6</p>
</div>

</div>
</li>

</ol>
			<li class="event"  data-no="" style="text-align:center;margin-top:54px;margin-bottom:30px;">
			<a href="/pnpinvest/?mode=join01" class="btn btn-join btn-rose">회원가입하러가기</a>

		</li>
</div>
						<!-- new-->

						</div>
			  </div>
				<div class="tabbed-section-4 tabssection hidden" id="tabid04">
						<h4 class="title on">투자 FAQ</h4>
						<div class="detail_con on">
							<!-- loop start -->
              <?php
  						$sql = "select * from mari_faq where f_sort='1' order by f_id";
  						$ff = sql_query($sql);
  						for($i=0; $row=sql_fetch_array($ff); $i++){
  						?>
							<dl class="qa_con">
                <dt>Q. <?php echo str_replace('•','',$row['f_question']);?></dt>
								<dd>답변. <?php echo nl2br($row['f_answer']);?></dd>
							</dl>
              <?php } ?>
							<!-- loop end -->
						</div>
				</div>
				<div class="tabbed-section-5 tabssection hidden" id="tabid05">
						<h4 class="title">대출 FAQ</h4>
						<div class="detail_con">
              <!-- loop start -->
              <?php
              $sql = "select * from mari_faq where f_sort='2' order by f_id";
              $ff = sql_query($sql);
              for($i=0; $row=sql_fetch_array($ff); $i++){
              ?>
							<dl class="qa_con">
                <dt>Q. <?php echo str_replace('•','',$row['f_question']);?></dt>
								<dd>답변. <?php echo nl2br($row['f_answer']);?></dd>
							</dl>
              <?php } ?>
							<!-- loop end -->
						</div>
				</div>

				<div class="tabbed-section-6 tabssection hidden" id="tabid06">
								<h4 class="title">계정 관련 FAQ</h4>
										<div class="detail_con">
											<!-- loop start -->
				              <?php
											$sql = "select * from mari_faq where f_sort='3' order by f_id";
											$ff = sql_query($sql);
											for($i=0; $row=sql_fetch_array($ff); $i++){
											?>
											<dl class="qa_con">
				                <dt>Q. <?php echo str_replace('•','',$row['f_question']);?></dt>
												<dd>답변. <?php echo nl2br($row['f_answer']);?></dd>
											</dl>
											<!-- loop end -->
				              <?php } ?>

										</div>
				</div>
		</div>




























			<!-- 상세정보 -->

		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<style>
@media (min-width: 768px){
	.modal-dialog {
	    width: 70%;
	    min-width: 600px;
	    max-width: 650px;
	    margin: 80px auto;
	}
}
</style>
<script>
$("document").ready( function() {
	$(".tabsselector").on("click", function () {
		$(".tabsselector.active").removeClass('active');
		$(this).addClass('active');
		var visible = $(".tabssection.visible");
		var tabid = $(this).data('tab');
		$(visible).removeClass('visible');
		$(visible).addClass('hidden');
		$( "#"+tabid).removeClass('hidden');
		$( "#"+tabid).addClass('visible');
		console.log(tabid);
	});
});
</script>
{# new_footer}
