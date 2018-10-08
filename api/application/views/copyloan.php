<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>복사하기</title>
    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js" integrity="sha384-I6F5OKECLVtK/BL+8iSLDEHowSAfUo76ZL9+kGAgTRdiByINKJaqTPH/QVNS1VDb" crossorigin="anonymous"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </head>
  <style>
  .bodysection{padding:15px;}
  .input-group{ margin: 10px;}

  </style>
  <body>
    <section class="bodysection">
      <form id="copyform" name="copyform" action="/api/index.php/copyloan/copy" method="post">
        <input type="hidden" name="i_id" value="<?php echo $data['i_id']?>">
        <div class="input-group">
          <span class="input-group-addon">제목</span>
          <input type="text" class="form-control" aria-label="제목" name= "i_subject" value="<?php echo $data['i_subject']?>">
        </div>
        <div class="input-group">
          <span class="input-group-addon">필요자금</span>
          <input class="form-control" aria-label="0" value="0" name="i_loan_pay">
          <span class="input-group-addon">원</span>
        </div>
      </form>
      <div class="text-center">
        <a class="btn btn-danger" href="javascript:;" onClick="copyloan();" role="button">복사하기</a>
      </div>
    </section>
    <section class="bodysection">
      <div class="row">
        <div class="col-xs-12">
          * 같은 상품(동일차주상품) 복사만을 해주세요<br>
          * 대출승인여부, 대출기간, 대출실행일설정등은 복사후 확인해주세요.<br>
          * 모집시작~모집종료일, 상환예정일 등은 투자진행설정에서 입력해주세요<br>
          * 모든 입력이 끝난후에 투자진행 설정에서 노출여부를 결정해주세요
        </div>
      </div>
    </section>
    <script>
    function copyloan() {
      if( confirm("정말로 복사하기겠습니까?")){
        $("#copyform").submit();
      }
    }
    </script>
  </body>
</html>
