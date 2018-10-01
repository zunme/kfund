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
<form id="userform">
  <input type="hidden" name="cate" value="<?php echo $_GET['cate']?>">
  사용자이름 : <input type="text" name="crol_user" placeholder="입력자 구분용으로 쓰입니다.">
</form>
<div class="center">
  <span id="insspan">시작하기</span>
</div>
<script>
$("document").ready( function(){
  $("#insspan").on('click', function() {
    $.ajax({
         url:"/api/index.php/crol/userreg",
          type : 'POST',
          data:$("form#userform").serialize(),
          dataType : 'json',
          success : function(result) {
            if( result.code=='200') {
              window.location.reload();
            }else {
              alert("오류발생")
            }
          },
          error : function (request, status, error) {
            alert(request + "/" + status + "/" + error);
          }
     });
  });
});
</script>
</body>
