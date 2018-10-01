<?php
header("Pragma: no-cache");
header("Cache-Control: no-cache,must-revalidate");
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
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
?>
{#new_header}
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
				<li>03 본인 인증</li>
				<li class="active">04 정보 입력</li>
				<li>05 가입 완료</li>
			</ul>
			<form method="post" action="" name="joinform">

        <input type="hidden" name="m_level" value="3">
      	<input type="hidden" name="mode" value="ajax">
      	<input type="hidden" name="agreement1" value="Y">
      	<input type="hidden" name="agreement2" value="Y">
      	<input type="hidden" name="m_blindness" value="N"><!--실명인증결과-->
      	<input type="hidden" name="m_ipin" value="N"><!--아이핀인증결과-->

			<fieldset>
				<div class="form_wrap">
					<h3 class="blind">일반 / 개인 회원</h3>
					<div class="join_top clearfix company">
						<div class="type1">사업자 보유 회원</div>
						<div class="type2">
							<strong class="tt">선택 목록</strong>
							<ul class="radio_list">
								<li>
									<input id="join_c_01" name="m_signpurpose" type="radio" value=''>
									<label for="join_c_01">01 법인 투자회원</label>
								</li>
								<li>
									<input id="join_c_02" name="m_signpurpose" type="radio"  value='L'>
									<label for="join_c_02">02 법인 대출 회원</label>
								</li>
							</ul>

						</div>
					</div>
					<h4 class="subject">회원 정보 입력</h4>
					<span class="sub_txt">아래 항목들은 필수 입력 사항으로 정확하게 입력해 주시기 바랍니다.</span>
					<div class="first">
						<label class="title" for="join_name">기업명</label>
						<p class="con"><input class="w1" type="text" id="join_name" name="m_company_name" placeholder="기업명을 입력해주세요" required></p>
					</div>
					<div>
						<label class="title" for="join_email">이메일 아이디</label>
						<p class="con"><input class="w1" type="text" id="join_email" name="m_id" placeholder="로그인시 아이디로 사용됩니다." required></p>
					</div>
					<div>
						<label class="title" for="join_pw">비밀번호</label>
						<p class="con"><input class="w1" type="password" id="join_pw" name="m_password" placeholder=" 영문자 조합 8~20자 이내" required></p>
					</div>
					<div>
						<label class="title" for="join_pw2">비밀번호 확인</label>
						<p class="con"><input class="w1" type="password" id="join_pw2" name="m_password_re" placeholder=" 비밀번호를 한번 더 입력해주세요." required></p>
					</div>
          <div>
            <label class="title" for="join_email">사업자등록번호</label>
            <p class="con"><input class="w1" type="text" name="m_companynum" placeholder="사업자등록번호를 입력해주세요." required></p>
          </div>
          <div>
            <label class="title" for="join_email">담당자명</label>
            <p class="con"><input class="w1" type="text" name="m_name" placeholder="담당자 실명을 입력해주세요." required></p>
          </div>

					<div>
						<label class="title" for="join_phone">휴대폰 번호</label>
						<p class="con tel">
							<!--select class="select t3 w3" id="join_phone">
								<option value="선택">통신사선택</option>
								<option value="">SKT</option>
								<option value="">KT</option>
								<option value="">LG U+</option>
							</select-->
							<select class="select t3 w3" id="join_phone2" name="hp1" title="번호 선택">
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
							</select>
							<input class="input t1 w3" name="hp2" type="text"> <input class="input t1 w3 mr20" name="hp3" type="text">
              <label for="m_sms"><input type="checkbox" name="m_sms" id="m_sms" class="ml15" value="1" checked=""> SMS수신동의</label>
						</p>
					</div>
					<div>
						<span class="title">사업장 주소</span>
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
									<span class="tt">사업자등록증</span>
									<input type="file">
									<ul class="file_b condition radiobox">
										<li>
											<input id="file_b1" name="m_declaration_01" type="radio" checked>
											<!--label for="file_b1">미등록</label>
										</li>
										<li>
											<input id="file_b2" name="file_b" type="radio">
											<label for="file_b2">등록완료</label-->
										</li>
									</ul>
								</li>
								<li>
									<span class="tt">사업주 신분증</span>
									<input type="file">
									<ul class="file_r condition radiobox">
										<li>
											<input id="file_r1" name="m_declaration_02" type="radio" checked>
											<!--label for="file_r2">미등록</label>
										</li>
										<li>
											<input id="file_r2" name="file_r" type="radio">
											<label for="file_r2">등록완료</label-->
										</li>
									</ul>
								</li>
								<li>
									<span class="tt">법인통장 사본</span>
									<input type="file">
									<ul class="file_g condition radiobox">
										<li>
											<input id="file_r1" name="m_bill" type="radio" checked>
											<!--label for="file_r1">미등록</label>
										</li>
										<li>
											<input id="file_r2" name="file_r" type="radio">
											<label for="file_r2">등록완료</label-->
										</li>
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
    $('<form action="/pnpinvest/?mode=join01" method="post"><input type="hidden" name="join_agree_01" value="Y"><input type="hidden" name="join_agree_02" value="Y"></form>').appendTo('body').submit();
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
   alert("올바른 휴대폰번호가 아닙니다.");
   return false;
 }  else return true;
}
function checkjoinform() {
  var confirmmessage='회원가입을 진행하시겠습니까?';

  if( !$("input:radio[name=m_signpurpose]:checked").is(':checked') ){
    alert('회원유형(법인투자/법인대출)을 선택해 주세요');
    return false;
  }

  switch( $("input:radio[name=m_signpurpose]:checked").val() ){
    case ('L') :
      confirmmessage ="대출회원은 투자를 하실 수 없습니다.\n회원가입을 진행하시겠습니까?";
    break;
  }

  if( !validateEmail( $("#join_email").val() ) ){
    alert('[이메일 아이디] 를 확인해주세요.');
    $('#join_email').val(''); $('#join_email').focus(); return false;
  }
  if( $("input[name='m_company_name']").val().trim() =='' ){
    alert('[기업명] 을 확인해주세요.');
    $("input[name='m_company_name']").val(''); $("input[name='m_company_name']").focus(); return false;
  }
  if( $("input[name='m_name']").val().trim() =='' ){
    alert('[담당자명] 을 확인해주세요.');
    $("input[name='m_name']").val(''); $("input[name='m_name']").focus(); return false;
  }
  if( $("input[name='m_companynum']").val().trim() =='' ){
    alert('[사업자등록번호] 를 확인해주세요.');
    $("input[name='m_name']").val(''); $("input[name='m_name']").focus(); return false;
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

{#new_footer}
