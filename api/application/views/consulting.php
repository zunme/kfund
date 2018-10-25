<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>케이펀딩</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<meta http-equiv="imagetoolbar" content="no">
<meta name="keywords" content="케이펀딩, 피앤피, p2p 대출솔루션, 대출솔루션, p2p투자, p2p펀딩, 일반대출, 담보대출, 대출p2p, 크라우드펀딩, p2p금융솔루션, 대출p2p솔루션, 크라우드펀딩 솔루션, 핀테크 솔루션, 대출 중계솔루션, p2p 대출중개, 소자본창업, 대부업, 금융운영" ><!--HTML 상단 검색 키워드소스 content=""-->
<meta name="description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다." ><!--HTML 상단 검색설명소스 content=""-->

<meta property="og:type" content="https://www.kfunding.co.kr/">
<meta property="og:title" content="케이펀딩">
<meta property="og:description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다.">
<meta property="og:image" content="https://www.kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta property="og:url" content="https://www.kfundingl.co.kr/">
<link rel="canonical" href="https://www.kfunding.co.kr/">

<link rel="SHORTCUT ICON" href="https://www.kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta name="google-site-verification" content="wFlJBNsJ9EcCuDtiz8gnIcdhqess5G-zrN6iGCyLbqs" />
<style>
.save-completed{display:none}
</style>
</head>
<body>
  <section class="save-main-section">
      <div>법인투자 1:1 상담</div>
      <div>아래 정보를 입력후 제출해 주시면 빠른 연락 드리겠습니다.</div>
      <div>
        <form name="consulting_form">
          <table>
            <tr>
              <th>법인명</th>
              <td><input type="text" name="company_name"></td>
            </tr>
            <tr>
              <th>담당자명</th>
              <td><input type="text" name="manager_name"></td>
            </tr>
            <tr>
              <th>담당자 연락처</th>
              <td><input type="text" id="hp" name="manager_tel"></td>
            </tr>
            <tr>
              <th>P2P투자경험</th>
              <td>
                <input type="radio" value="Y" name="inv_exp"> 있음
                <input type="radio" value="N" name="inv_exp"> 없음
              </td>
            </tr>
          </table>
          <div>
            <input type="checkbox" id="agreement" name="agreement" value="Y"> 개인정보 수집 및 이용에 동의 합니다.
          </div>
        </form>

        <div>
          <a href="javascript:;" onClick="test()">상담신청</a>
        </div>
      </div>
  </section>
  <section class="save-completed">
    <div>상담신청을 완료하였습니다</div>
    <div>빠른 연락 드리겠습니다.</div>
  </section>

<script type="text/javascript" src="/pnpinvest/js/jquery-1.11.0.min.js"></script>
<script>
function test() {
  $(".save-main-section").hide();
  $(".save-completed").show();
}
function save(){
  var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
  if($("input[name=manager_name]").val() =='' ){
    $("input[name=manager_name]").focus();
    alert("담당자명을 입력하여주세요");return false;
  }
  if ( !regExp.test( $("#hp").val() ) ) {
    $("input[name=manager_tel]").focus();
    alert("잘못된 전화번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
    return false;
  }
  if( !$("input:checkbox[id='agreement']").is(":checked") ){
    alert("개인정보 수집 및 이용에 동의해주세요");
    return false;
  }
  if( confirm("상담 신청을 하시겠습니까?")){
    $.ajax({
      url:"/api/index.php/consulting/save/",
      type : 'POST',
      data:$("form[name=consulting_form]").serialize(),
      dataType : 'json',
      success : function(result) {
        if(result.code==200){
          $(".save-main-section").hide();
          $(".save-completed").show();
        }else alert(result.msg);
      },
      error: function(request, status, error) {
        alert("잠시 후에 시도해 주세요");
       console.log(request + "/" + status + "/" + error);
      }
    });
  }
}
</script>


</body>
</html>
