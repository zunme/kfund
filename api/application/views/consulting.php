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
<link rel="stylesheet" href="/assets/font-awesome/latest/css/font-awesome.min.css" />
<style>
.save-completed{display:none}
.icon-close {
    background: #e91e63;
    margin-bottom: 10px;
    position: absolute;
    right: 10px;
    top: 10px;
    font-size: 18px;
    font-weight: bold;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    border: 0;
    color: white;
    cursor: pointer;
    box-shadow: 1px 5px 18px 3px rgba(0, 0, 0, 0.14), 0 6px 20px 3px rgba(0, 0, 0, 0.12), -4px 5px 18px 0px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
  <section class="head-section">
    <button data-izimodal-close="" class="icon-close"><i class="fa fa-times"></i></button>
  </section>
  <section class="save-main-section">

      <div class="popuptitle">법인투자 1:1 상담</div>
      <div class="popupcall">아래 정보를 입력후 제출해 주시면 빠른 연락 드리겠습니다.</div>
      <div class="popupin">
        <form name="consulting_form" class="popupform">
          <table class="popuptable">
            <tr class="popuptr" >
              <th class="popupth">법인명</th>
              <td><input type="text" class="popupinput" name="company_name"></td>
            </tr>
            <tr class="popuptr">
              <th class="popupth">담당자명</th>
              <td><input type="text" class="popupinput" name="manager_name"></td>
            </tr>
            <tr class="popuptr">
              <th class="popupth">담당자 연락처</th>
              <td><input type="text" id="hp" class="popupinput" name="manager_tel"></td>
            </tr>
            <tr class="popuptr">
              <th class="popupth">P2P투자경험</th>
              <td class="popuptd2">
                <input type="radio" value="Y" name="inv_exp"> 있음
                <input type="radio" class="popupradio" value="N" name="inv_exp"> 없음
              </td>
            </tr>
          </table>
          <div class="popupcheck">
            <input type="checkbox" id="agreement" name="agreement" value="Y"> 개인정보 수집 및 이용에 동의 합니다.
          </div>
        </form>

        <div>
          <a class="popupbtn" href="javascript:;" onClick="test()">상담신청</a>
        </div>
      </div>
    </div>
  </section>
  <section class="save-completed">
    <div class="popup2">상담신청을 완료하였습니다</div>
    <div class="popup2">빠른 연락 드리겠습니다.</div>
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
$('body').on('click', 'button.icon-close', {}, function() {
    window.parent.$('#izimodal').iziModal('close', {
        transition: 'bounceOutDown' // Options
    });
  });
</script>
<style>

.save-main-section {text-align: center; }

.popuptitle {width:100%; font-size: 40px; text-align: center;background-color:#e0abab;height:120px;line-height:115px;}
.popupcall{font-size: 16px; text-align: center;margin-top:24px;}
.popupform {margin-bottom:40px;}
.popuptable {margin: 25px auto 12px; text-align: left;}
.popuptr {height: 40px;}
.popupth {padding-right: 25px;}
.popuptd2 {text-align: center;}
.popupinput{border: 1px solid #ccc;color: #333;padding: 0 6px;height: 34px;line-height: 34px;width: 100%;}
.popupradio {margin-left:10px;}
.popupcheck {text-align: center;}
.popupbtn {border: 1px solid #006691;font-size: 20px;padding: 10px 30px;margin-top: 20px;margin-bottom: 30px;
text-decoration: none;color: #fff;background: #006691;border-radius: 6px;}

.save-completed {text-align: center; margin-top:201px; line-height:40px;font-size:24px;}

@media all and (max-width:479px) {
.save-main-section .closebtn {position: absolute; top:0;border: 1px solid #868686;font-size: 24px;padding: 3px 16px 6px 16px;
  margin-top: 20px;margin-bottom: 30px;text-decoration: none;color: #fff;background: #868686;border-radius: 4px;margin-top:5px;margin-left:242px;}
.popuptitle {width:100%; font-size: 30px; text-align: center;background-color:#e0abab;height:120px;line-height:115px;}
.popupcall{font-size: 16px; text-align: center;margin-top:24px; padding-left:10px; padding-right:10px;word-break:keep-all;}
.popupform {margin-bottom:28px;}
.popuptable {margin: 20px auto 12px; text-align: left;padding-right:10px;}
.popupth {padding-right: 10px;}
.popupbtn {border: 1px solid #006691;font-size: 20px;padding: 8px 28px;margin-top: 20px;margin-bottom: 30px;
text-decoration: none;color: #fff;background: #006691;border-radius: 6px;}
.save-completed {text-align: center; margin-top:201px; line-height:40px;font-size:18px;}
}
@media all and (max-width:400px) {

.popuptitle {width:100%; font-size: 30px; text-align: center;background-color:#e0abab;height:120px;line-height:115px;}
.popupcall{font-size: 16px; text-align: center;margin-top:20px; padding-left:10px; padding-right:10px;word-break:keep-all;}
.popupform {margin-bottom:28px;}
.popuptable {margin: 16px auto 12px; text-align: left;}
.popupth {padding-right: 10px;font-size:16px;}
.popupbtn {border: 1px solid #006691;font-size: 20px;padding: 8px 28px;margin-top: 20px;margin-bottom: 30px;
text-decoration: none;color: #fff;background: #006691;border-radius: 6px;}
.save-completed {text-align: center; margin-top:201px; line-height:40px;font-size:16px;}
.popupinput{border: 1px solid #ccc;color: #333;padding:0;height: 34px;line-height: 34px;width: 100%;}
}
</style>
</body>
</html>
