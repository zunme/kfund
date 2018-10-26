

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>태기드민 </title>

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

    <!-- bootstrap-progressbar -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet"-->
    <!-- JQVMap Not USE-->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/-->
    <!-- bootstrap-daterangepicker -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet"-->

    <!-- Datatables -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet">
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"-->

    <!-- Custom Theme Style -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/build/css/custom.min.css" rel="stylesheet">
    <style>
    td.details-control {
        background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_open.png') no-repeat center center;
        cursor: pointer;
    }
    tr.shown td.details-control {
        background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_close.png') no-repeat center center;
    }
    .linked_class, span.memauthcancel { color: #008EFC; cursor:pointer;}
    span.memauth { color: #FF0042; cursor:pointer;}
    .loading {
      position: fixed;
      top: 0;
      width: 100%;
      height: 100%;
      background: white;
      z-index: 1032;
      opacity: 1;
      transition: opacity 0.5s cubic-bezier(0.7, 0, 0.3, 1);
    }
    .loading.hide {
      display: none;
    }
    .loading .loading-container {
      z-index: 1033;
      display: block;
      position: relative;
      text-align: center;
      top: 50%;
      left: 50%;
      -webkit-transform: translate(-50%, -50%);
      -moz-transform: translate(-50%, -50%);
      -o-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
      transform: translate(-50%, -50%);
    }
    .loading .loading-container .loader {
      width: 40px;
    }
    .loading .loading-container p {
      font-size: 30px;
      margin-bottom: 30px;
    }
@media only screen and (max-width: 767px) {
  .modal-dialog { width: 400px; }
}
@media only screen and (min-width: 768px) {
  .modal-dialog { width: 660px; }
}
@media only screen and (min-width: 900px) {
  .modal-dialog { width: 800px; }
}
@media only screen and (min-width: 1200px) {
  .modal-dialog { width: 1100px; }
}
@media only screen and (min-width: 1400px) {
  .modal-dialog { width: 1300px; }
}
@media only screen and (min-width: 1600px) {
  .modal-dialog { width: 1500px; }
}
.izimodal2{height: 400px;}
.duptable{margin:10px;width:100%;}
    </style>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">

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
  i.addevent{color: blue;}
  a.collapse-link{padding-left: 10px; padding-right:10px;}
  .nav-md .container.body .right_col {
    margin-left: 0
}
.badge{margin-left: 10px;}
</style>



<div class="row">




    <div class="main">
      <table class="table">
        <thead>
        <tr>
          <th>법인명</th>
          <th>담당자</th>
          <th>전화</th>
          <th>경험유무</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach($list as $row){ ?>
          <tr>
            <td><?php echo $row['company']?></td>
            <td><?php echo $row['name']?></td>
            <td><?php echo $row['tel']?></td>
            <td><?php echo $row['exp']?></td>
          </tr>
        <?php } ?>
      </tbody>
      </table>
    </div>

</div>
<!-- /page content -->

<!-- /footer content -->
</div>
</div>
</div>
<script>
$(document).ready(function() {
  $(".table").dataTable();
});
</script>
