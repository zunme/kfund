{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t1"><span class="motion" data-animation="flash">대출신청</span></h2>
	<!-- invest top -->
	<div class="loan">
		<div class="container">
			<form method="post" action="" name="form1" onsubmit="joinloan();">
			<fieldset>
				<div class="form_wrap">
					<div class="loan_select clearfix">
						<p class="txt">대출 유형을 선택해 주셔야 정확한 상담이 가능합니다.</p>
						<input type="radio" name="loan_select" id="loan_select1" value="부동산" checked>
						<label for="loan_select1">부동산</label>
						<input type="radio" name="loan_select" id="loan_select2" value="사업자">
						<label for="loan_select2">사업자</label>
						<input type="radio" name="loan_select" id="loan_select3" value="개인신용">
						<label for="loan_select3">개인신용</label>
					</div>
					<div>
						<label class="title" for="loan_name">신청자명</label>
						<p class="con"><input class="w1" type="text" id="loan_name" name="loan_name" placeholder="이름을 입력해주세요.(실명으로 입력해주세요.)" required></p>
					</div>
					<div>
						<label class="title" for="loan_phone">연락처</label>
						<p class="con tel">
							<select class="select t3 w3" id="loan_phone" name="loan_phone">
								<option value="">통신사선택</option>
								<option value="SKT">SKT</option>
								<option value="KT">KT</option>
								<option value="LG">LG U+</option>
							</select>
							<select class="select t3 w3" id="loan_phone2" name="loan_phone2" title="번호 선택">
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
							</select>
							<input class="input t1 w3" name="loan_phone3" type="text"> <input class="input t1 w3 mr20"  name="loan_phone4" type="text">
						</p>
					</div>
					<div>
						<label class="title" for="loan_emal">이메일</label>
						<p class="con"><input class="w1" type="text" id="loan_emal" name="loan_email" placeholder="케이펀딩 아이디를 입력해주세요."></p>
					</div>
					<div>
						<label class="title" for="loan_address">담보물 주소</label>
						<p class="con"><input class="w1" type="text" id="loan_address" name="loan_address"></p>
					</div>
					<div class="radiobox">
						<span class="title">담보물 유형</span>
						<p class="con">
							<input type="radio" name="loan_type" id="loan_type1" value="1" checked>
							<label for="loan_type1">아파트</label>
							<input type="radio" name="loan_type" id="loan_type2" value="2">
							<label for="loan_type2">빌라/다세대/주택</label>
							<input type="radio" name="loan_type" id="loan_type3" value="3">
							<label for="loan_type3">토지/임야/전답</label>
							<input type="radio" name="loan_type" id="loan_type4" value="4">
							<label for="loan_type4">전세보증금</label>
							<input type="radio" name="loan_type" id="loan_type5" value="5">
							<label for="loan_type5">기타</label>
						</p>
					</div>
					<div>
						<label class="title" for="loan_price">담보시세</label>
						<p class="con"><input class="w2" type="text" id="loan_price" name="loan_price"></p>
					</div>
					<div>
						<label class="title" for="loan_sum">대출희망금액</label>
						<p class="con"><input class="w2" type="text" id="loan_sum" name="loan_sum"> &nbsp;원</p>
					</div>
					<div>
						<label class="title" for="loan_liabilities">부채현황</label>
						<p class="con"><input class="w2" type="text" id="loan_liabilities" name="loan_liabilities"> &nbsp;만원</p>
					</div>
					<div>
						<label class="title" for="loan_income">월소득</label>
						<p class="con"><input class="w2" type="text" id="loan_income" name="loan_income"> &nbsp;만원</p>
					</div>
					<div>
						<label class="title" for="loan_way">상환방식</label>
						<p class="con">
							<select class="select w3" id="loan_way" name="loan_way">
								<option value="1">만기일시상환</option>
								<option value="2">원리금균등상환</option>
							</select>
						</p>
					</div>
					<div>
						<label class="title" for="loan_term">대출기간</label>
						<p class="con"><input class="w3" type="text" id="loan_term" name="loan_term"> &nbsp;개월</p>
					</div>
					<div>
						<label class="title" for="loan_interest">희망금리</label>
						<p class="con"><input class="w3" type="text" id="loan_interest" name="loan_interest"></p>
					</div>
					<div>
						<label class="title" for="loan_repay">대출상환일</label>
						<p class="con">매월 &nbsp;
							<select class="select t2 w3" id="loan_repay" name="loan_repay">
                <option>선택</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
                <option value="23">23</option>
                <option value="24">24</option>
                <option value="25">25</option>
                <option value="26">26</option>
                <option value="27">27</option>
                <option value="28">28</option>
                <option value="29">29</option>
                <option value="30">30</option>
                <option value="31">31</option>
							</select> &nbsp;일
						</p>
					</div>
				</div>
				<div class="btn_wrap"><a class="btn t5 f4 w300" type="submit" href="javascript:;" onclick="joinloan()"   style= "height: auto;"
}>신청하기</a></div>
			</fieldset>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
function checkemail(email){
  var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
  if(regex.test(email) === false) {
      return false;
  } else {
      return true;
  }
}
function joinloan() {
  $.ajax({
    type : 'POST',
    url : '/api/index.php/newhomeapi/joinloanprc',
    dataType : 'json',
    data : $("form[name=form1]").serialize(),
    success : function(result) {
      if(result.code=='200'){
        alert("대출신청이 완료되었습니다.")
        location.href="/pnpinvest"
      }else {
        alert(result.msg);
      }
    }
  });
  return;

  if ( $("#loan_name").val() ==''){ alert ("이름을 입력해주세요");return;  }
  if ( $("select[name=loan_phone]").val() ==''){ alert ("통신사를 선택해주세요");return;  }
  if ( $("select[name=loan_phone2]").val() =='' || $("input[name=loan_phone3]").val() =='' || $("input[name=loan_phone4]").val() ==''){ alert ("전화번호를 입력해주세요");return;  }
  if ( checkemail($("input[name=loan_email]").val() ) == false ){alert ("이메일을 확인해주세요");return;  }
  if ($("input[name=loan_type]:checked").val() < 5 && $("#loan_address").val() =='' ) {alert ("담보물 주소를 확인해주세요");return;  }
  if ( $("#loan_price").val() ==''){ alert ("담보시세를 입력해주세요");return;  }
  if ( $("#loan_sum").val() ==''){ alert ("희망금액을 입력해주세요");return;  }
  if ( $("#loan_liabilities").val() ==''){ alert ("부채현황을 입력해주세요");return;  }
  if ( $("#loan_income").val() ==''){ alert ("월소득을 입력해주세요");return;  }
  if ( $("#loan_term").val() ==''){ alert ("대출기간을 입력해주세요");return;  }



}
</script>
{# new_footer}
