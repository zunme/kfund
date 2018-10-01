<!doctype html>
<!--[if lte IE 6]><html lang="ko" class="ie_low ie_hate"><![endif]-->
<!--[if IE 7]><html lang="ko" class="ie_low"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie_medium"><![endif]-->
<!--[if gte IE 9]><!--><html lang="ko"><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
      <link href="//t1.daumcdn.net/localimg/localimages/07/postcode/2015/favicon.ico" rel="shortcut icon">
    </head>

    <style>
    body{background-color: #eee;}
    .center{
      text-align:center;
    }
    #insspan {
      padding: 10px 20px;
    border: 1px solid #aaa;
    margin-top: 20px;
    display: inline-block;
    border-radius: 10px;
    }
    </style>
<body>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script type="text/javascript" src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<form id="addrform">
  <input type="hidden" name="cate" value="<?php echo $_GET['cate']?>">
  회사이름 : <input type="text" name="cname" placeholder="회사" value="<?php echo trim($_GET['cname'])?>">
  <br>
  대표자 : <input type="text" name="name" placeholder="대표자" value="<?php echo trim($_GET['name'])?>">
  <br>
  우편번호 : <input type="text" id="sample4_postcode" name="postnum" placeholder="우편번호" value="<?php echo trim($_GET['postnum'])?>" >
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
<br>
주소 : <input type="text" name="addr" size=50 placeholder="주소"  value="<?php echo trim($_GET['addr'])?>">
<?php var_dump($_GET);?>
</form>
<div class="center">
  <span id="insspan">저장하기</span>
</div>
<script>
  $("document").ready( function() {
    $("#insspan").on('click', function() {
     var apiURL = 'https://www.kfunding.co.kr/api/crol/croling';
     $.ajax({
          url:apiURL,
           type : 'POST',
           data:$("form#addrform").serialize(),
           dataType : 'html',
           success : function(result) {
             if( result=='200') {
               $("body").text('저장완료');
             }else {
               $("body").text(result);
             }
           },
           error : function (request, status, error) {
             alert(request + "/" + status + "/" + error);
           }
      });
    });
  });
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
            }
        }).open({q:'<?php echo $_GET['addr']?>'});
    }
</script>
</body>
