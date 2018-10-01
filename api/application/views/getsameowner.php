<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>동일차주확인</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" crossorigin="anonymous">
    <style>
      .alert{margin-bottom:3px;padding: .5rem 1.25rem;font-size: 14px;}
      .bodysection{padding : 10px;}
      .fixed-bottom {    bottom: 0;    left: 0;    position: fixed;    width: 100%;}
      .fixed-bottom .alert {margin-bottom:0;text-align: center;font-size: 16px;}
      form {   bottom: 0;    left: 0;    position: fixed; margin:10px 30px;}
    </style>
  </head>
  <body>
    <section class="bodysection">
      <?php
      $parent = $this->input->get('lid');
      if ( count($samedata)>0){
        foreach ($samedata as $row){
          if ($row['stat']=='parent'){
            ?>
            <div class="alert alert-primary" role="alert"><?php echo $row['i_subject'];echo ($row['loanid'] == $parent )?' <i class="fa fa-check-circle" aria-hidden="true"></i>':''?></div>
            <?php
          }else {
        ?>
          <div class="alert alert-secondary" role="alert"><?php echo $row['i_subject'];echo ($row['loanid'] == $parent )?' <i class="fa fa-check-circle" aria-hidden="true"></i>':'';?></div>
        <? }
        }
        $parent = $row['parentid'];
      }else {
        ?><div class="alert alert-warning" role="alert">동일차주로 등록되어 있지 않습니다.</div><?php
      }
      if( $this->input->get('lid') == $parent && count($samedata) > 1 ) {
        ?>
        <div class="fixed-bottom">
          <div class="alert alert-warning" role="alert">
             동일차주로 등록되어있는 상품들을 해제 후 변경이 가능합니다.
          </div>
        </div>
        <?php
      }
      else {?>
      <form id="form">
        <div class="form-group">
          <input type="hidden" name="lid" value="<?php echo $this->input->get('lid');?>" >
          <label for="inputState">동일차주 적용/변경</label>
          <select id="inputState" class="form-control" name="cid">
          <?php foreach($list as $row){?>
            <option value="<?php echo $row['i_id'];?>" <?php echo($parent == $row['i_id'])?'selected':'';?> ><?php echo $row['i_subject'];?></option>
          <?}?>
          </select>
        </div>
        <a class="btn btn-primary" role="button" style="float:right" onClick="changesameowner()">적용하기</a>
      </form>
      <?php } ?>
    </section>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js" integrity="sha384-I6F5OKECLVtK/BL+8iSLDEHowSAfUo76ZL9+kGAgTRdiByINKJaqTPH/QVNS1VDb" crossorigin="anonymous"></script>
    <!--script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script-->
    <!--
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    -->
    <script>
      function changesameowner() {
        console.log($("#inputState option:selected").val() );
        $.ajax({
          type: 'POST',
          url: "/api/index.php/cmsloanlist/changeowner",
          data: $("#form").serialize(),
          xhrFields: { withCredentials: true },
          success: function (data){
            if(data.code=="OK") {
              alert("적용되었습니다.");
              self.location.reload(true);
            }else {
              alert("오류가 발생하였습니다.");
            }
          },
          dataType: 'json'
        });
      }
    </script>
  </body>
</html>
