<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>kfunding</title>

    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap/dist/css/bootstrap.min.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/font-awesome/css/font-awesome.min.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/styles.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/iCheck/skins/flat/green.css?v=20180105110142" rel="stylesheet">
    <!-- Datatables -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet"-->
    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">

    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/build/css/custom.min.css" rel="stylesheet">
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/default.js?v=20180105110142"></script>
    <!-- Custom Theme Scripts -->
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/build/js/custom.min.js?v=20180105110142"></script>
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/raphael/raphael.min.js"></script>
     <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/morris.js/morris.min.js"></script>
     <!-- bootstrap-daterangepicker -->
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/moment/min/moment.min.js"></script>
    <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
  </head>
  <body>
    <style>
    body{color:black;background-color: #FFF;}
    * {text-align: center}
    table{width:90%;}
    th{text-align: center}
    </style>
    <h4>대출 신청리스트</h4>
    <table id="datatable" class="display">
      <thead>
        <tr>
          <th>NO</th>
          <th>타입</th>
          <th>ID</th>
          <th>신청자명</th>
          <th>연락처</th>
          <th>이메일</th>
          <th>담보물유형</th>
          <th>주소</th>
          <th>시세</th>
          <th>희망금액</th>
          <th>부채</th>
          <th>소득</th>
          <th>방식</th>
          <th>기간</th>
          <th>금리</th>
          <th>상환일</th>
          <th>신청일</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <?php if (count($list)>0) {
          $loan_type = array("기타","아파트","빌라/다세대/주택","토지/임야/전답","전세보증금","기타");
          foreach ($list as $row) {
          ?>
        <tr>
          <td><?php echo $row['loan_apc_idx']?></td>
          <td><?php echo $row['mem_id']?></td>
          <td><?php echo $row['loan_select']?></td>
          <td><?php echo $row['loan_name']?></td>
          <td><?php echo $row['loan_phone2']?>-<?php echo $row['loan_phone3']?>-<?php echo $row['loan_phone4']?></td>
          <td><?php echo $row['loan_email']?></td>
          <td><?php echo isset($loan_type[$row['loan_type']]) ? $loan_type[$row['loan_type']] : "기타";?></td>
          <td><?php echo $row['loan_address']?></td>
          <td><?php echo $row['loan_price']?>(원)</td>
          <td><?php echo $row['loan_sum']?>원</td>
          <td><?php echo $row['loan_liabilities']?>만원</td>
          <td><?php echo $row['loan_income']?>만원</td>
          <td><?php echo $row['loan_way']==1 ? '만기일시상환' :'원리금균등상환'?></td>
          <td><?php echo $row['loan_term']?>개월</td>
          <td><?php echo $row['loan_interest']?></td>
          <td><?php echo $row['loan_repay']?>일</td>
          <td><?php echo $row['regdate']?></td>
          <td><a href="javaascript:;" data-idx="<?php echo  $row['loan_apc_idx']?>" class="btn del" onClick="del_application(this)">삭제</a></td>
        </tr>
      <?php } } ?>
      </tbody>
    </table>
    <div style="text-align:center;">
      <?php echo $links ?>
    </div>
    <script>
    var table;
    function del_application(ln) {
      if (confirm('삭제하시겠습니까?') );
      {
        var idx = $(ln).data('idx');
        $.ajax({
          type : 'POST',
          url : '/api/admext/loanapplicationdel',
          data:{idx:idx},
          dataType : 'json',
          success : function(result) {
            if(result.code=='200'){
              table.row( $(ln).parents('tr') ).remove().draw();
            }else {
              alert (result.msg);
            }
          }
        });
      }
    }
    $("document").ready ( function() {
      table = $("#datatable").DataTable();
    });
    </script>
  </body>
  </html>
