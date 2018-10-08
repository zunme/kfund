<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>태기드민-투자체크</title>

    <!-- Bootstrap -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap/dist/css/bootstrap.min.css?v=20180105110142" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/font-awesome/css/font-awesome.min.css?v=20180105110142" rel="stylesheet">
    <!-- merge -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/styles.css?v=20180105110142" rel="stylesheet">
    <!-- NProgress -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/nprogress/nprogress.css" rel="stylesheet"-->
    <!-- iCheck -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/iCheck/skins/flat/green.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/build/css/custom.min.css" rel="stylesheet">

    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/default.js?v=20180105110142"></script>
    <!-- Custom Theme Scripts -->
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/build/js/custom.min.js?v=20180105110142"></script>
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/raphael/raphael.min.js"></script>
     <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/morris.js/morris.min.js"></script>
     <!-- bootstrap-daterangepicker -->
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/moment/min/moment.min.js"></script>
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/css/iziModal.min.css" >
    <script src="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/js/iziModal.min.js" type="text/javascript"></script>
<!-- 알럿 컨펌 등 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>

    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>

    <link href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet">
    <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/locale/ko.js"></script>
    <style>
    .row.alert{
      background-color: #ec3434;
      color: white;
    }
    </style>
  </head>
  <body>
    <section>
      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <div class="x_panel">
            <div class="x_title" style="min-height:50px;">
              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-9">
                  <select id="loanselect" class="form-control" onchange="loanselectchanged()">
                    <option value="0">선택하여주세요</option>
                    <?php foreach($list as $row) {?>
                      <option value="<?php echo $row['loan_id']?>"><?php echo $row['i_invest_name']?></option>
                    <?php }?>
                  </select>
                </div>
                <div class="col-xs-3 text-right" style="height: 50px;line-height: 40px;font-size: 15px;">
                  <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  <a class="" onClick="replay()"><i class="fa fa-refresh"></i></a>
                </div>
              </div>
            </div>
            <div class="x_content">
                <div class="row" id="headerrow">
                  <div class="col-xs-8 text-right" style="font-size: 16px;line-height: 40px;">
                    현재(<span id="nowtime"></span>) 총 <span id="paysum">0</span> 원
                  </div>
                  <div class="col-xs-1"></div>
                  <div class="col-xs-3 form-group has-feedback">
                    <span class="fa fa-bell form-control-feedback left" aria-hidden="true"></span>
                    <input type="text" class="form-control has-feedback-left" id="alertval" placeholder="0" value="0">
                    <span class="form-control-feedback right" aria-hidden="true">원</span>
                  </div>
                </div>
                <div class="row">
                  <div class="col-xs-12">
                    <table class="table">
                      <thead>
                        <tr><th>인덱스</th><th>제목</th><th class="text-center">투자금</th><th class="text-right"><a class="btn btn-warning" onClick="addinvest()">추가하기</a></th></tr>
                      </thead>
                      <tbody id="listtable">
                      </tbody>
                    </table>
                  </div>
                </div>
            </div>
          </div>
        </div>
    </section>
    <script>
Number.prototype.format = function(){
    if(this==0) return 0;
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};
String.prototype.format = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";
    return num.format();
};

    </script>
    <script>
      var loanid = 0;
      var playalert;
      $("document").ready( function (){
        playAlert = setInterval(function() {
           getinfo();
        }, 30000);
      });
      function replay() {
        clearInterval(playAlert);
        getinfo();
        playAlert = setInterval(function() {
           getinfo();
        }, 30000);
      }
      function loanselectchanged(){
        loanid = $("#loanselect option:selected").val();
        replay();
      }
      function getinfo() {
        var alertval = parseInt($("#alertval").val());
        if( loanid < 1){
          return false;
        }
        $("#listtable").empty();
        $.ajax({
          type : 'get',
          url : '/api/index.php/investcheck/info',
          dataType : 'json',
          data : {loanid : loanid },
          success : function(result) {
            if(result.code==200){
              $("#nowtime").html( moment().format("HH:mm:ss") )
              var sum = parseInt( result.data.sum );
              $("#paysum").text(result.data.sum.format());
              if( alertval > 0 && sum > 0 && sum >= alertval ){
                $("#headerrow").addClass("alert");
                alertmsg();
              }else $("#headerrow").removeClass("alert");
              $.each(result.data.list, function (i, item){
                var tr = $("<tr>").append(
                  $("<td>").html(item.i_id)
                  ,$("<td>").html(item.i_subject)
                  , $("<td class='text-right'>").html(item.i_pay.format())
                  , $("<td class='text-right'>").html("<a class='btn btn-danger' href='javasciprt:;' onClick='delinvest(this)' data-loanid='"+item.loan_id+"' data-idx='"+item.i_id+"' data-won='"+item.i_pay+"'>삭제하기</a>")
                ).appendTo("#listtable");

              });
            }else alert(result.msg);
          },
          error: function (jqXHR, exception) {
            ajaxerror( jqXHR, exception )
          }
        });
      }
      function addinvest() {
        if( parseInt($("#loanselect option:selected").val()) < 1 ) {
          alert("대출을 선택해주세요");
          return false;
        }
        $.confirm({
            title: '추가하기',
            content: '' +
            '<form action="" class="formName">' +
            '<div class="form-group">' +
            '<input type="text" placeholder="금액(숫자만)" class="name form-control" required />' +
            '</div>' +
            '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var name = this.$content.find('.name').val();
                        if(!name){
                            $.alert('금액을 적어주세요');
                            return false;
                        }
                        realadd (name);
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
      }
      function realadd(won){
        $.ajax({
          type : 'POST',
          url : '/api/index.php/investcheck/additem',
          dataType : 'json',
          data : {loanid : $("#loanselect option:selected").val(), pay:won },
          success : function(result) {
            if(result.code==200){
              replay();
            }else alert(result.msg);
          },
          error: function (jqXHR, exception) {
            ajaxerror( jqXHR, exception )
          }
        });
      }
      function delinvest(bt){
        if( loanid != $(bt).data("loanid") ){
          alert("선택한 대출과 투자진행 대출이 동일하지 않습니다\n.F5를 누른후 다시 시도해 주세요");
          return false;
        }
        if (confirm("정말로 " + $(bt).data("won").format() + "원을 삭제하시겠습니까? ")){
          $.ajax({
            type : 'POST',
            url : '/api/index.php/investcheck/rmitem',
            dataType : 'json',
            data : {idx : $(bt).data("idx") },
            success : function(result) {
              if(result.code==200){
                replay();
              }else alert(result.msg);
            },
            error: function (jqXHR, exception) {
              ajaxerror( jqXHR, exception )
            }
          });
        }
      }
      function alertmsg() {
        console.log(alert);
      }
      function ajaxerror( jqXHR, exception ){
        var msg = '';
        if (jqXHR.status === 0) {
            msg = 'Not connect.\n Verify Network.';
        } else if (jqXHR.status == 404) {
            msg = 'Requested page not found. [404]';
        } else if (jqXHR.status == 500) {
            msg = 'Internal Server Error [500].';
        } else if (exception === 'parsererror') {
            msg = 'Requested JSON parse failed.';
        } else if (exception === 'timeout') {
            msg = 'Time out error.';
        } else if (exception === 'abort') {
            msg = 'Ajax request aborted.';
        } else {
            msg = 'Uncaught Error.\n' + jqXHR.responseText;
        }
        alert(msg);
      }
    </script>
  </body>
  </html>
