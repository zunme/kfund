<?php
//include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 회원가입
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#new_header}
<?php
if( $_POST['join_agree_01'] !='Y' || $_POST['join_agree_01'] !='Y'){
  ?>
  <script>
  alert('이용약관 / 개인정보수집 에 동의하셔야 회원가입이 가능합니다.');
  location.replace("/pnpinvest/?mode=join01");
  </script>
  <?
  return;
}

/* ipin*/

$sitecode = "BH481";
$sitepasswd = "eAlGvup5Gp7W";
$authtype = "M`";      		// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 카드
$popgubun 	= "N";			// Y : 취소버튼 있음 / N : 취소버튼 없음
$customize 	= "Mobile";			// 없으면 기본 웹페이지 / Mobile : 모바일페이지
$gender = "";      			// 없으면 기본 선택화면, 0: 여자, 1: 남자
$reqseq = get_cprequest_no($sitecode);
$_SESSION["REQ_SEQ"] = $reqseq;

$rtnhost =(($_SERVER['HTTPS'] != "on") ? "http://" : "https://" ).$_SERVER['HTTP_HOST'];
//$returnurl = DEFAULT_URL."/pnpinvest/?mode=join03";	// 성공시 이동될 URL
//$returnurl = $rtnhost."/api/nice/join";	// 성공시 이동될 URL
$returnurl = $rtnhost."/api/nice/join";	// 성공시 이동될 URL

$errorurl = $rtnhost."/api/nice";		// 실패시 이동될 URL
$plaindata = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq .
     "8:SITECODE" . strlen($sitecode) . ":" . $sitecode .
     "9:AUTH_TYPE" . strlen($authtype) . ":". $authtype .
     "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl .
     "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl .
     "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun .
     "9:CUSTOMIZE" . strlen($customize) . ":" . $customize .
     "6:GENDER" . strlen($gender) . ":" . $gender ;
$enc_data = get_encode_data($sitecode, $sitepasswd, $plaindata);
if( $enc_data == -1 )
    {
        $returnMsg = "암/복호화 시스템 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -2 )
    {
        $returnMsg = "암호화 처리 오류입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -3 )
    {
        $returnMsg = "암호화 데이터 오류 입니다.";
        $enc_data = "";
    }
    else if( $enc_data== -9 )
    {
        $returnMsg = "입력값 오류 입니다.";
        $enc_data = "";
    }
    else $returnMsg='';
?>
<style>

</style>
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t3"><span class="motion" data-animation="flash">회원가입</span></h2>
	<!-- 케이펀딩 공지사항 -->
	<div class="join">
		<div class="container">
			<!-- 컨텐츠 본문 -->
			<p class="join_txt"><span>간편한 절차로 케이펀딩의 다양한 서비스를 제공받으세요.</span></p>
			<ul class="join_process clearfix">
				<li>01 약관 동의</li>
				<li>02 개인/기업</li>
				<li class="active">03 본인 인증</li>
				<li>04 정보 입력</li>
				<li>05 가입 완료</li>
			</ul>
      <style>
      .sms_confirm{
        position:relative;
        max-width:480px;
        width:90%;
        border:1px solid #cacaca;
        margin:0 auto;
        margin-bottom: 60px;
        text-align:center;
        padding: 35px 0;
      }
      .sms_confirm p{margin: 15px 0;}
      .fa-stack {
        position: relative;
        display: inline-block;
        height: 122px;
        width: 80px;
        text-align:center;
      }
      </style>
      <div>
      <div style="position:relative">
        <div class="sms_confirm">
<p style="font-size: 20px;font-weight: 700;">SMS 인증</p>

<span class="fa-stack fa-lg">
  <i class="fas fa-mobile-alt" style="color:#00ae9d;font-size:120px;"></i>
  <i class="far fa-envelope-open" style="color:#00ae9d;font-size:30px;margin-top: -70px;"></i>
  <i class="fas fa-wifi" style="color: #00646a;font-size: 24px;margin-top: -72px;position: absolute;bottom: 74px;left: 25px;" ></i>
</span>

<p><span class="txt" style="font-size: 13px;">회원님의 명의로 된 휴대폰으로 인증</span></p>

<a href="javascript:fnPopup();" class="btn btn-social btn-fill btn-linkedin" style="background-color: #006691;padding: 8px 25px;    margin-bottom: 20px;">휴대폰 인증하기</a>
        </div>
      </div>
    </div>
			<!--form method="post" action="join_04.html"-->



			<!--fieldset>
				<div class="form_wrap">
					<h3 class="blind">본인 인증</h3>
					<div class="join_ctf clearfix">
						<p class="join_phone">
							<strong class="title">SMS 인증</strong>
							<span class="txt">회원님의 명의로 된 휴대폰으로 인증</span>
							<a href="javascript:fnPopup();" title="새 창으로 열림" class="btn">휴대폰 인증하기</a>
						</p>
						<p class="join_ipin">
							<strong class="title">i-pin 인증</strong>
							<span class="txt">회원님의 아이핀 아이디와 이빌번호로 인증</span>
							<a href="" title="새 창으로 열림" class="btn">아이핀 인증하기</a>
						</p>
					</div>
				</div>
				<div class="btn_wrap">
					<a href="javascript:;" onclick="gotoprev()" class="btn t1 f4 w300 prev" type="button" value="이전">이전</a>
					<a href="javascript:;" onClick="next()" class="btn t5 f4 w300" id="form_ok" type="submit" value="다음">다음</a>
				</div>
			</fieldset>
    </form-->
      <form method="post" name="joinform" action="/pnpinvest/?mode=join00">
        <input type="hidden" name="join_agree_01" value="Y">
        <input type="hidden" name="join_agree_02" value="Y">
      </form>
		</div>
	</div>
</div>

<form name="form_chk" method="post">
  <input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
  <input type="hidden" name="EncodeData" value="<?= $enc_data ?>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
</form>

<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
<script language='javascript'>
  window.name ="Parent_window";

  function fnPopup(){
    window.open('', 'popupChk', 'width=500, height=600, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbars=1');
    document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
    document.form_chk.target = "popupChk";
    document.form_chk.submit();
  }
</script>

<script>
function gotoprev(){
    $("form[name=joinform]").submit();
}
function next() {
  alert("휴대폰 인증이나 아이핀 인증을 해주세요");
}
</script>
