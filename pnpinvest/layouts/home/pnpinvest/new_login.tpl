{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<style>
.login_form {
    max-width: 350px;
	}
</style>
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t3"><span class="motion" data-animation="flash">로그인</span></h2>
	<!-- 로그인 -->
	<div class="login_form userform">
		<div class="container">
			<p class="top_txt">케이펀딩의 다양한 서비스를 이용해보세요.</p>
			<form id="f" name="f" method="post" onSubmit="return sendit()">
				<div>
					<input id="login_id" name="m_id" class="iptxt" title="이메일 입력 폼" type="text" placeholder="이메일을 입력해주세요.">
					<input id="login_pass" name="m_password" class="iptxt" title="비밀번호 입력 폼" type="password" placeholder="비밀번호를 입력해주세요.">
					<span class="checktxt">아이디나 비밀번호를 확인해주세요.</span>
				</div>
				<div>
					<button type="submit" class="btn t1 f2" href="javascript:;" data-onClick="sendit()">로그인</button>
				</div>
				<div class="link">
					<p>아직 회원이 아니세요? <a href="/pnpinvest/?mode=join1">가입하기</a></p>
					<p>비밀번호가 기억나지 않으신가요? <a href="/pnpinvest/?mode=find">비밀번호 찾기</a></p>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
function ValidateEmail(mail)
{
  console.log(mail);
 if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))
  {
    return (true)
  }
    return (false)
}

function sendit(){
  if ( !ValidateEmail($("input[name=m_id]").val()) ){
    alert('이메일을 확인해주세요.');f.m_id.focus();return false;
  }
	else if($("input[name=m_password]").val().trim() == '' ){
		alert('패스워드를 입력해주세요');f.m_password.focus();return false;
	}
  else {
    document.f.action='/pnpinvest/?mode=login_ck';
    return true;
  }
	//
	//document.f.submit();
}
</script>
{# new_footer}
