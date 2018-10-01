<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>seyfert</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" crossorigin="anonymous">
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    body{padding:10px;}
    .form-control{
      display: inline;
      width: 50%;
      margin-left:100px;
    }
    .bd-callout {
      padding: .8rem;
      /* margin-top: 1.25rem; */
      margin-bottom: .8rem;
      border: 1px solid #eee;
      border-left-width: .25rem;
      border-radius: .25rem;
      padding-bottom: 5px;
    }
    .bd-callout-warning h4 {
        color: #f0ad4e;
        font-size: 1.2rem;
    }
    .bd-callout h4 {
        margin-top: 0;
        margin-bottom: .25rem;
    }
    .bd-callout > table{
      width: 600px;
      margin-left: 1.5rem;
      margin-bottom: 0;
    }
    .bd-callout-warning {
        border-left-color: #f0ad4e;
    }
    .bd-callout-info{
      border-left-color: #d1ecf1;
    }
    .bank-accno > span {
      color:
    }
    .wrap-loading{ /*화면 전체를 어둡게 합니다.*/
      position: fixed;
      left:0;
      right:0;
      top:0;
      bottom:0;
      background: rgba(0,0,0,0.2); /*not in ie */
      filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    }
    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
    }
    .display-none{ /*감추기*/
        display:none;
    }
    </style>
  </head>
  <body>
    <div class="bd-callout bd-callout-warning">
      <h4>등록이름</h4>
      <table class="table">
          <tr "table-info">
            <td>우선순위</td>
            <td>fullname</td>
            <td>firstname</td>
            <td>lastname</td>
          </tr>
        <?php foreach($namesList as $name){ ?>
          <tr>
            <td><?php echo $name['priority']?></td>
            <td><?php echo (isset($name['fullname']) ) ?$name['fullname']:''?></td>
            <td><?php echo (isset($name['firstname']) ) ?$name['firstname']:''?></td>
            <td><?php echo (isset($name['lastname']) ) ?$name['lastname']:''?></td>
          </tr>
        <?php }?>
      </table>
      <div>
        <form id="rename">
          <input class="form-control" type="text" name="mid" value="<?php echo $mid?>" readonly>
          <input type="text" class="form-control" name="sname">
          <a class="btn btn-danger" onClick="rename()">이름변경</a>
        </form>
      </div>
    </div>

    <div class="bd-callout bd-callout-warning">
      <h4>전화번호</h4>
      <table class="table">
          <tr "table-info">
            <td>우선순위</td>
            <td>전화번호</td>
          </tr>
        <?php foreach($phonesList as $phone){ ?>
          <tr>
            <td><?php echo (isset($phone['priority']))?$phone['priority']:''?></td>
            <td><?php echo (isset($phone['phoneNo']))?$phone['phoneNo']:''?></td>
          </tr>
        <?php }?>
      </table>
      <div>
        <form id="rephone">
          <input class="form-control" type="hidden" name="mid" value="<?php echo $mid?>" readonly>
          <input type="text" class="form-control" name="sphone">
          <a class="btn btn-danger" onClick="rename_phone()">전화번호변경</a>
        </form>
      </div>
    </div>

    <div class="bd-callout bd-callout-warning">
      <h4>가상계좌</h4>
      <table class="table">
        <tr>
          <td></td>
          <td>bank code</td>
          <td>account no</td>
          <td>원</td>
          <td>이름</td>
        </tr>
        <tr>
          <td>DB</td>
          <td><?php echo $accnt['s_bnkCd'] ?></td>
          <td><?php echo $accnt['s_accntNo'] ?></td>
          <td>-</td>
          <td>-</td>
        </tr>

          <?php if(isset($virtualAccnt['accntNo'])) {
            $virtualAccntGubuntmp = explode("(가상계좌)", $virtualAccnt['custNm']);
            if( count($virtualAccntGubuntmp) ==2) $virtualAccntGubun ='일반계좌';
            else {
              $virtualAccntGubuntmp = explode("_(주)엔젤크라우드대부", $virtualAccnt['custNm']);
              if( count($virtualAccntGubuntmp) ==2) $virtualAccntGubun ='대출계좌';
              else  $virtualAccntGubun ='계좌구분안됨';
            }
            ?>
              <tr>
                <td>seyfert</td>
                <td><?php echo $virtualAccnt['bnkCd'] ?><br><?php echo $virtualAccntGubun?></td>
                <td>
                  <form id='accnt'>
                    <input type="hidden" name="mid" value="<?php echo $mid?>">
                    <input type="hidden" name="accntNo" value="<?php echo $virtualAccnt['accntNo'] ?>">
                    <input type="hidden" name="bnkCd" value="<?php echo $virtualAccnt['bnkCd'] ?>">
                  </form>
                  <?php echo $virtualAccnt['accntNo'] ?>
                  <?php $virtualAccntScript = ($virtualAccntGubun=='대출계좌') ? 'unassignVirtualPayAccount' : 'unassignVirtualAccount';?>
                  <i id="delbt" class="fa fa-trash" aria-hidden="true" onclick="<?php echo $virtualAccntScript?>()" style="display:none"></i></td>
                <td><span id='won'></span></td>
                <td><?php echo $virtualAccnt['custNm'] ?></td>
              </tr>
          <?php  }else { ?>
            <tr>
              <td colspan=5>가상계좌없음</td>
            </tr>
          <?php  } ?>
      </table>
    </div>

    <div class="bd-callout bd-callout-warning">
      <h4>출금계좌</h4>
      <div class="bd-callout bd-callout-info">
      <?php
      if ( isset($bnkAccnt) && is_array($bnkAccnt) ) {
        foreach ( $bnkAccnt as $bank) { ?>
      <div class='bankdetail'>

            <table class="table">
              <tr><td>계좌번호</td><td><?php echo $bank['accntNo'] ?>(<?php echo $bank['bnkCd'] ?>)</td></tr>
              <tr><td>생성시간</td><td><?php echo date('Y-m-d H:i:s', $bank['createDt']/1000); ?></td></tr>
              <tr>
                <td>1원 확인</td>
                <td>
                  <?php echo ($bank['verify']['verifySt'] =='VERIFIED' ) ?'검증':'검증안됨';?>
                  ( <?php echo date('Y-m-d H:i:s', $bank['verify']['updateDt']/1000); ?> )
                </td>
              </tr>
              <tr>
                <td>계좌주 이름 확인</td>
                <td>
                  <?php echo ($bank['nmVerify']['verifySt'] =='VERIFIED' ) ?'검증':'검증안됨';?>
                  ( <?php echo date('Y-m-d H:i:s', $bank['nmVerify']['updateDt']/1000); ?> )
                </td>
              </tr>
              <tr>
                  <td>요청이름</td>
                  <td>
                    <?php echo ( isset($bank['name']['fullname'])  ) ? $bank['name']['fullname']:''; ?>
                  </td>
                  <td>
                    <?php echo ( isset($bank['name']['firstname'])  ) ? $bank['name']['firstname']:''; ?>
                  </td>
                  <td>
                    <?php echo ( isset($bank['name']['lastname'])  ) ? $bank['name']['lastname']:''; ?>
                  </td>
                </tr>
                <tr>
                  <td>계좌주이름</td>
                  <td>
                    <?php echo ( isset($bank['inquiredName']['fullname'])  ) ? $bank['inquiredName']['fullname']:''; ?>
                  </td>
                  <td>
                    <?php echo ( isset($bank['inquiredName']['firstname'])  ) ? $bank['inquiredName']['firstname']:''; ?>
                  </td>
                  <td>
                    <?php echo ( isset($bank['inquiredName']['lastname'])  ) ? $bank['inquiredName']['lastname']:''; ?>
                  </td>
                </tr>
              </table>
          </div>
      </div>
      <?php
        }
      }else { ?>
        출금계좌 없음
      <?php }?>
      </div>
    </div>

    <div class="wrap-loading display-none">
        <div><img src="./images/loading1.gif" /></div>
    </div>

<!--script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script-->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js" integrity="sha384-I6F5OKECLVtK/BL+8iSLDEHowSAfUo76ZL9+kGAgTRdiByINKJaqTPH/QVNS1VDb" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<script>
  function rename() {
    if( confirm('정말로 변경하시겠습니까?') ) {
      $.ajax({
          url:'/api/index.php/seyfertinfo/rename',
          type:'post',
          dataType:'json',
          data:$('#rename').serialize(),
          success:function(data){
              if(data.code ==200) {
                alert('변경되었습니다.');
                location.reload();
              }
              else { alert (data.msg);return;}
          }
          ,beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
          }
          ,complete:function(){
              $('.wrap-loading').addClass('display-none');
          }
      });
    }
  }
  function rename_phone() {
    if( confirm('정말로 변경하시겠습니까?') ) {
      $.ajax({
          url:'/api/index.php/seyfertinfo/rephone',
          type:'post',
          dataType:'json',
          data:$('#rephone').serialize(),
          success:function(data){
              if(data.code ==200) {
                alert('변경되었습니다.');
                location.reload();
              }
              else { alert (data.msg);return;}
          }
          ,beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
          }
          ,complete:function(){
              $('.wrap-loading').addClass('display-none');
          }
      });
    }
  }
  function unassignVirtualPayAccount() {
    if( confirm('정말로 대출계좌를 해지하시겠습니까? ') ) {
      $.ajax({
          url:'/api/index.php/seyfertinfo/unsignpayaccnt',
          type:'post',
          dataType:'json',
          data:$('#accnt').serialize(),
          success:function(data){
              if(data.code ==200) {
                alert('변경되었습니다.');
                location.reload();
              }
              else { alert (data.msg);return;}
          }
          ,beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
          }
          ,complete:function(){
              $('.wrap-loading').addClass('display-none');
          }
      });
    }
  }
  function unassignVirtualAccount() {
    if( confirm('정말로 가상계좌를 해지하시겠습니까? ') ) {
      $.ajax({
          url:'/api/index.php/seyfertinfo/unsignaccnt',
          type:'post',
          dataType:'json',
          data:$('#accnt').serialize(),
          success:function(data){
              if(data.code ==200) {
                alert('변경되었습니다.');
                location.reload();
              }
              else { alert (data.msg);return;}
          }
          ,beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
          }
          ,complete:function(){
              $('.wrap-loading').addClass('display-none');
          }
      });
    }
  }
$("document").ready( function() {

    $.ajax ({
      type: "POST",
      url : "/api/index.php/seyfertinfo/lnq",
      data : {mn:"<?php echo $mid?>"},
      dataType : 'json' ,
      success: function(data) {
        if(data.code === 200 ) {
          if(data.data.amount  == 0 ) $("#delbt").show();
          $("#won").html(data.data.amount);
        }else {
          $("#won").html("Error("+ data.code+")");
        }
      }
    });

});

</script>
</body>
</html>
