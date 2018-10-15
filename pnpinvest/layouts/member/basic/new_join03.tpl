<?php
header("Pragma: no-cache");
header("Cache-Control: no-cache,must-revalidate");
include(MARI_VIEW_PATH.'/Common_select_class.php');

//임시

$m_ipin_use = $m_blindness_use = 'N';

$baseinfo = array();
if( isset($_SESSION['REQ_SEQ']) && $_SESSION['REQ_SEQ'] !='' ){
  $sql = "select * from z_nice_log where REQ_SEQ = '".$_SESSION['REQ_SEQ']."' and actiontype='join' ";
  $niceinfo = sql_fetch($sql, false);

  if( isset($niceinfo['REQ_SEQ']) ) {
    $baseinfo['authtype'] = 'mobile';
    $baseinfo['req'] = $niceinfo['REQ_SEQ'];
    $baseinfo['name'] = $niceinfo['name'];
    $baseinfo['birthdate'] = $niceinfo['birthdate'];
    $baseinfo['gender'] = $niceinfo['gender'];
    $baseinfo['mobileno'] = $niceinfo['mobileno'];
    $m_blindness_use = 'Y';
    $_SESSION['join_req'] = $niceinfo['REQ_SEQ'];
  }
}
if(!isset($niceinfo['REQ_SEQ']) && isset($_SESSION['CPREQUEST']) && $_SESSION['CPREQUEST'] !=''){
  $sql = "select * from z_ipin_log where CPREQUEST = '".$_SESSION['CPREQUEST']."'";
  $ipininfo = sql_fetch($sql, false);
  if( isset($ipininfo['CPREQUEST']) ){
    $baseinfo['authtype'] = 'ipin';
    $baseinfo['req'] = $ipininfo['CPREQUEST'];
    $baseinfo['name'] = $ipininfo['m2'];
    $baseinfo['birthdate'] = $ipininfo['m6'];
    $baseinfo['gender'] = $ipininfo['m5'];
    $baseinfo['mobileno'] = '';
    $m_ipin_use = 'Y';
    $_SESSION['join_req'] = $ipininfo['CPREQUEST'];
  }
}

$_SESSION['REQSEQ'] = $_SESSION['CPREQUEST']='';
unset($_SESSION['REQSEQ']);
unset($_SESSION['CPREQUEST']);

if(!isset( $baseinfo['name']) || $baseinfo['name']=='' ){
  ?>
  <!doctype html>
  <html lang="en">
    <head>
      <title></title>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <meta http-equiv="Cache-Control" content="no-chache"/>
      <meta http-equiv="Expires" content="0"/>
      <meta http-equiv="Pragma" content="no-cache"/>
    </head>
    <body>
      <script>
      alert("인증정보를 찾을 수 없습니다.");
      location.replace("/pnpinvest/?mode=join01");
      </script>
    </body>
    </html>
  <?php
}
$birth1 = date('Y' , strtotime($baseinfo['birthdate']));
$birth2 = date('m' , strtotime($baseinfo['birthdate']));
$birth3 = date('d' , strtotime($baseinfo['birthdate']));

if( $baseinfo['mobileno'] !='') {
  $hp1 = substr( $baseinfo['mobileno'],0,3);
  $hp2 = substr( $baseinfo['mobileno'],3,-4);
  $hp3 = substr( $baseinfo['mobileno'],-4,4);
}
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 회원가입
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t3"><span class="motion" data-animation="flash">회원가입</span></h2>
	<!-- 엔젤펀딩 공지사항 -->
	<div class="join">
		<div class="container">
			<!-- 컨텐츠 본문 -->
			<p class="join_txt"><span>간편한 절차로 엔젤펀딩의 다양한 서비스를 제공받으세요.</span></p>
			<ul class="join_process clearfix">
				<li>01 약관 동의</li>
				<li>02 개인/기업</li>
				<li>03 본인 인증</li>
				<li class="active">04 정보 입력</li>
				<li>05 가입 완료</li>
			</ul>
			<form method="post" name="joinform" enctype="multipart/form-data" >
<!-- 임시 -->
        <!--input type="hidden" name="authtype" value="<?php echo $baseinfo['authtype'];?>">
        <input type="hidden" name="req" value="<?php echo $baseinfo['req'];?>"-->
<!-- / 임시 -->
        <input type="hidden" name="m_level" value="2">
      	<input type="hidden" name="mode" value="ajax">
      	<input type="hidden" name="agreement1" value="yes">
      	<input type="hidden" name="agreement2" value="yes">
      	<input type="hidden" name="m_blindness" value="<?php echo $m_blindness_use;?>"><!--실명인증결과-->
      	<input type="hidden" name="m_ipin" value="<?php echo $m_ipin_use;?>"><!--아이핀인증결과-->

			<fieldset>
				<div class="form_wrap">
					<h3 class="blind">일반 / 개인 회원</h3>
					<div class="join_top clearfix">
						<div class="type1">일반 / 개인 회원</div>
						<div class="type2">
							<strong class="tt">선택 목록</strong>
							<ul class="radio_list">
								<li>
									<input id="join_p_01" name="m_signpurpose" type="radio" value="N">
									<label for="join_p_01">01 일반 개인투자자</label>
								</li>
								<li>
									<input id="join_p_02" name="m_signpurpose" type="radio" value="I">
									<label for="join_p_02">02 소득적격 개인투자자</label>
								</li>
								<li>
									<input id="join_p_03" name="m_signpurpose" type="radio" value="P">
									<label for="join_p_03">03 전문 투자자</label>
								</li>
								<li>
									<input id="join_p_04" name="m_signpurpose" type="radio" value="L">
									<label for="join_p_04">04 대출회원</label>
								</li>
							</ul>
							<!--button type="button" class="reset">다시 선택</button-->
						</div>
					</div>
					<h4 class="subject">회원 정보 입력</h4>
					<span class="sub_txt">아래 항목들은 필수 입력 사항으로 정확하게 입력해 주시기 바랍니다.</span>
					<div class="first">
						<label class="title" for="join_name">이름</label>
						<p class="con"><input class="w1" type="text" id="join_name" name="m_name" placeholder="이름을 입력해주세요.(실명으로 입력해주세요.)" value="<?php echo $baseinfo['name']?>" readonly ></p>
					</div>
					<div>
						<label class="title" for="join_email">이메일 아이디</label>
						<p class="con"><input class="w1" type="text" id="join_email"  name="m_id" placeholder="로그인시 아이디로 사용됩니다." required></p>
					</div>
					<div>
						<label class="title" for="join_pw">비밀번호</label>
						<p class="con"><input class="w1" type="password" id="join_pw"  name="m_password" placeholder="영문자/숫자/특수문자 조합 8~20자 이내" required></p>
					</div>
					<div>
						<label class="title" for="join_pw2">비밀번호 확인</label>
						<p class="con"><input class="w1" type="password" id="join_pw2"  name="m_password_re" placeholder="비밀번호를 한번 더 입력해주세요." required></p>
					</div>
					<div>
						<label class="title" for="join_birth">생년월일</label>
						<p class="con birth">
							<select class="select t3 w3" id="loan_phone" name="birth1" >
								<option value="<?php echo $birth1?>"><?php echo $birth1?></option>
							</select>년 &nbsp;
							<select class="select t3 w3" id="loan_phone2" name="birth2" >
								<option value="<?php echo $birth2?>"><?php echo $birth2?></option>
							</select>월 &nbsp;
							<select class="select t3 w3" id="loan_phone2" name="birth3" >
								<option value="<?php echo $birth3?>"><?php echo $birth3?></option>
							</select>일
						</p>
					</div>
					<div class="radiobox">
						<span class="title">성별</span>
						<p class="con">
              <?php if ($baseinfo['gender']=='1') { ?>
							<input type="radio" name="m_sex" id="join_male" value="m" checked readonly>
							<label for="join_male">남</label>
            <?php } else { ?>
							<input type="radio" name="m_sex" id="join_female" value="w" checked readonly>
							<label for="join_female">여</label>
            <?php } ?>
						</p>
					</div>
					<div>
						<label class="title" for="join_phone">휴대폰 번호</label>
						<p class="con tel">
							<!--select class="select t3 w3" id="join_phone" name='m_newsagency'>
								<option value="선택">통신사선택</option>
								<option value="">SKT</option>
								<option value="">KT</option>
								<option value="">LG U+</option>
							</select-->
							<select class="select t3 w3" id="join_phone2" name="hp1" title="번호 선택">
                <?php if( $baseinfo['mobileno'] !='' ) { ?>
                  <option value="<?php echo $hp1?>"><?php echo $hp1?></option>
                <? } else { ?>
								<option value="선택">선택</option>
								<option value="">010</option>
								<option value="">011</option>
								<option value="">016</option>
                <?php } ?>
							</select>

              <?php if( $baseinfo['mobileno'] !='' ) { ?>
                <input class="input t1 w3" type="text" name="hp2" value="<?php echo $hp2 ?>" readonly>
              <? } else { ?>
              <input class="input t1 w3" type="text" name="hp2" >
              <?php } ?>
              <?php if( $baseinfo['mobileno'] !='' ) { ?>
                <input class="input t1 w3" type="text" name="hp3" value="<?php echo $hp3 ?>" readonly>
              <? } else { ?>
              <input class="input t1 w3" type="text" name="hp3" >
              <?php } ?>
              <!--label for="m_sms"><input type="checkbox" name="m_sms" id="m_sms" class="ml15" value="1" checked=""> SMS수신동의</label-->
              <input type="hidden" name="m_sms" id="m_sms" value="1">
						</p>

					</div>

					<div>
						<span class="title">주소</span>
						<p class="con address">
							<input type="text" class="input t1 w3" id="sample4_postcode" name="m_zip" onClick="sample4_execDaumPostcode()" readonly>
							<a class="btn w3" href="javascript:;" onClick="sample4_execDaumPostcode()">우편번호 검색</a>
							<br>
							<input class="input t1 w1" type="text" id="sample4_jibunAddress" name="m_addr1" onClick="sample4_execDaumPostcode()" readonly>
              <input id="sample4_detailAddress" name="m_addr2" value="" type="text" class="input t1 w1" title="상세주소" placeholder="상세주소">

						</p>
					</div>

					<div>
						<span class="title">필수서류</span>
						<div class="con">
							<ul class="join_file clearfix">
								<li>
									<p class="tt">종합소득신고서<span>(전년도)</span></p>
									<input type="file" name="m_declaration_01">
									<ul class="file_b condition radiobox">
										<li>
											<input id="file_b1" type="radio" checked>
											<!--label for="file_b1">미등록</label-->
										</li>
										<!--li>
											<input id="file_b2" name="file_b" type="radio">
											<label for="file_b2">등록완료</label>
										</li-->
									</ul>
								</li>
								<li>
									<p class="tt">종합소득<span>확정신고서</span></p>
									<input type="file" name="m_declaration_02">
									<ul class="file_r condition radiobox">
										<li>
											<input id="file_r1"  type="radio" checked>
											<!--label for="file_r2">미등록</label>
										</li>
										<li>
											<input id="file_r2" name="file_r" type="radio">
											<label for="file_r2">등록완료</label-->
										</li>
									</ul>
								</li>
								<li>
									<p class="tt">근로서득<span>원천징수 영수증</span></p>
									<input type="file" name="m_evidence">
									<ul class="file_g condition radiobox">
										<li>
											<input id="file_g1" type="radio" checked>
											<!--label for="file_g1">미등록</label>
										</li>
										<li>
											<input id="file_g2" name="file_g" type="radio">
											<label for="file_g2">등록완료</label-->
										</li>
									</ul>
								</li>
								<li>
									<p class="tt">전문투자자<span>확인증</span></p>
									<input type="file" name="m_bill">
									<ul class="file_y condition radiobox">
										<li>
											<input id="file_y1" type="radio" checked>
											<!--label for="file_y1">미등록</label-->
										</li>
										<!--li>
											<input id="file_y2" name="file_y" type="radio">
											<label for="file_y2">등록완료</label>
										</li-->
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<div>
						<label class="title" for="join_rc">추천인</label>
						<p class="con"><input class="w1" type="text" id="join_rc" name="m_referee"></p>
					</div>
				</div>
				<div class="btn_wrap">
					<a class="btn t1 f4 w300 prev" href="javascript:;" onClick="gotoprev()">이전</a>
					<a href="javascript:;" onClick="checkjoinform()" class="btn t5 f4 w300" id="form_ok" >다음</a>
				</div>
			</fieldset>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script><script charset="UTF-8" type="text/javascript" src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>

<script>
String.prototype.escapeSpecialChars = function() {
    return this.replace(/\\n/g, "\\n")
               .replace(/\\'/g, "\\'")
               .replace(/\\"/g, '\\"')
               .replace(/\\&/g, "\\&")
               .replace(/\\r/g, "\\r")
               .replace(/\\t/g, "\\t")
               .replace(/\\b/g, "\\b")
               .replace(/\\f/g, "\\f");
};
function gotoprev() {
  if( confirm('SMS인증 또는 i-pin인증을 다시 하셔야 합니다.\n이전 페이지로 가시겠습니까?')){
    $('<form action="/pnpinvest/?mode=join02" method="post"><input type="hidden" name="join_agree_01" value="Y"><input type="hidden" name="join_agree_02" value="Y"></form>').appendTo('body').submit();
  }
}
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_jibunAddress').value = fullRoadAddr;
                //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
                document.getElementById('sample4_detailAddress').focus();
            }
        }).open();
    }

function validateEmail(email) {
  var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
  return re.test(email);
}
function chkPwd(str){
   var pw = str;
   var num = pw.search(/[0-9]/g);
   var eng = pw.search(/[a-z]/ig);
   var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
   if(pw.length < 8 || pw.length > 20){
    alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
    return false;
   }
   if(pw.search(/₩s/) != -1){
    alert("비밀번호는 공백업이 입력해주세요.");
    return false;
   }
   if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
    alert("영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.");
    return false;
   }
   return true;
}
function checkmobile() {
  var rgEx = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;
  var strValue = $("select[name=hp1]").val()+'-'+$("input[name=hp2]").val()+'-'+$("input[name=hp3]").val();
  var chkFlg = rgEx.test(strValue);
  if(!chkFlg){
   alert(strValue + "올바른 휴대폰번호가 아닙니다.");
   return false;
 }  else return true;
}
function checkjoinform() {
  var confirmmessage='회원가입을 진행하시겠습니까?';

  if( !$("input:radio[name=m_signpurpose]:checked").is(':checked') ){
    alert('회원유형(일반투자자/소득적격투자자/전문투자자/대출회원)을 선택해 주세요');
    return false;
  }

  switch( $("input:radio[name=m_signpurpose]:checked").val() ){
    case ('L') :
      confirmmessage ="대출회원은 투자를 하실 수 없습니다.\n회원가입을 진행하시겠습니까?";
    break;
    case ('I') :
      confirmmessage ="소득적격 개인투자자 회원은 필요 서류가 확인 된 이후 부터 투자가 가능합니다.\n\n[필요서류]\n[이자, 배당소득 2천만원 초과: 직전과세기간의 종합소득과세표준 확정신고서와 신고서 접수증(신고자 실명 기재된 접수증)]\n또는\n[사업, 근로소득 1억원 초과: 근로소득 원천징수 영수증]\n\n회원가입을 진행하시겠습니까?";
    break;
    case ('L') :
      confirmmessage ="소득적격 개인투자자 회원은 필요 서류가 확인 된 이후 부터 투자가 가능합니다.\n\n[필요서류]\n금융투자협회 홈페이지에서 하기 서류 들을 제출하여 받은 전문투자자 확인증\n\n회원가입을 진행하시겠습니까?";
      전문투자자
    break;
  }

  if( !validateEmail( $("#join_email").val() ) ){
    alert('[이메일 아이디] 를 확인해주세요.');
    $('#join_email').val(''); $('#join_email').focus(); return false;
  }

  if( !checkmobile() )  return false;

  if(!chkPwd( $.trim($('#join_pw').val()))){
     $('#join_pw').val('');
     $('#join_pw2').val('');
     $('#join_pw').focus();
     return false;
  }
  if(  $.trim($('#join_pw').val()) != $.trim($('#join_pw2').val()) ){
    alert('[비밀번호 확인] 이 틀립니다.');
    $('#join_pw2').val('');
    $('#join_pw2').focus();
    return false;
  }
  /*
  if( $("input[name=m_with_zip]").val() =='' ){
    alert('주소를 입력해 주세요.');
    $('input[name=m_with_zip]').focus();
    return false;
  }

  if( $.trim($("input[name=m_with_addr2]").val()) =='' ){
    alert('상세주소를 입력해 주세요.');
    $('input[name=m_with_addr2]').focus();
    return false;
  }
  */
  $.ajax({
    url:"/api/index.php/newhomeapi/checkmemid",
   type : 'POST',
   data:$('form[name=joinform]').serialize(),
   dataType : 'json',
   success : function(result) {
    if(result.code !=200){alert(result.msg.escapeSpecialChars() );}
    else {
      if( confirm(confirmmessage)){
        $("input[name=mode]").val('join3');
        //$('form[name=joinform]').attr('action', '/pnpinvest/?up=join3');
        $('form[name=joinform]').attr('action', '/api/index.php/newhomeapi/checkmemid');
        $('form[name=joinform]').submit();
      }
    }
   },
   error: function(request, status, error) {
     console.log(request + "/" + status + "/" + error);
   }
});

}
</script>

{# new_footer}
