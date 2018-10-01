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
  </style>
 </head>
<style>
  .float-right{
    position: relative;
    min-height: 1px;
    float: right;
    padding-right: 10px;
    padding-left: 10px;
  }
  #datatable3_filter{
    display:none;
    font-size: 14px;
    padding-top: 10px;
    padding-right: 10px;
  }
  .dt-body-right{
    text-align:right
  }
  .tid_desc_span{
    display:inline-block;
    width:50px;
  }
</style>
<body>

  <!-- 태기 로더 부분-->
  <style>
  #ajaxloading{
    display:none;
    position: fixed;
    z-index: 10999;
    height: 2em;
    width: 2em;
    overflow: show;
    margin: auto;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
  }
  #ajaxloading:before {
    content: '';
    display: block;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.3);
  }
  #ajaxloading .spinner {
    margin: 30% auto;
    width: 50px;
    height: 40px;
    text-align: center;
    font-size: 10px;
  }

   #ajaxloading .spinner > div {
    background-color: #333;
    height: 100%;
    width: 6px;
    display: inline-block;

    -webkit-animation: sk-stretchdelay 1.2s infinite ease-in-out;
    animation: sk-stretchdelay 1.2s infinite ease-in-out;
  }

  #ajaxloading .spinner .rect1 {
    background-color: #25edc1;
  }


  #ajaxloading .spinner .rect2 {
    -webkit-animation-delay: -1.1s;
    animation-delay: -1.1s;
    background-color: #3caff5;
  }

  #ajaxloading .spinner .rect3 {
    -webkit-animation-delay: -1.0s;
    animation-delay: -1.0s;
    background-color: #ff994c;
  }

  #ajaxloading .spinner .rect4 {
    -webkit-animation-delay: -0.9s;
    animation-delay: -0.9s;
    background-color: #fb4949;
  }

  #ajaxloading .spinner .rect5 {
    -webkit-animation-delay: -0.8s;
    animation-delay: -0.8s;
    background-color: #e41937;
  }

  @-webkit-keyframes sk-stretchdelay {
    0%, 40%, 100% { -webkit-transform: scaleY(0.4) }
    20% { -webkit-transform: scaleY(1.0) }
  }

  @keyframes sk-stretchdelay {
    0%, 40%, 100% {
      transform: scaleY(0.4);
      -webkit-transform: scaleY(0.4);
    }  20% {
      transform: scaleY(1.0);
      -webkit-transform: scaleY(1.0);
    }
  }
  </style>
  <div id="ajaxloading">
    <div>
      <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
        <div class="rect5"></div>
      </div>
    </div>
  </div>
  <!-- / 태기 로더 끝 -->



<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12">
         <div class="x_panel">
           <div class="x_title">
             <h2>입금 목록<small>충전/입금 리스트</small></h2>

             <ul class="nav navbar-right panel_toolbox">
               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
               </li>
             </ul>
             <div class="clearfix"></div>
           </div>
           <div class="x_content">
             <div class="row">
               <div class="float-right">
                 <span class="btn btn-primary" style="margin-bottom:0" onclick="fnchanged3()">검색</span>
               </div>
               <div class="float-right">
                  <input type="text" name="search3" class="form-control input-sm" placeholder="" aria-controls="datatable3">
              </div>
              <div class="float-right">
                <input type="text" style="width: 120px;display:inline" name="startdate" aria-controls="datatable3" class="form-control singlepicker" value="" />
                ~
                <input type="text" aria-controls="datatable3" style="width: 120px;display:inline" name="enddate" class="form-control singlepicker" value="" />
              </div>
               <div class="float-right">
                   <select id="trnsctnSt" aria-controls="datatable3" name="trnsctnSt" class="input-sm" style="margin-left: 20px;" onChange="fnchanged3()">
                     <option value="" >선택</option>
                     <option value="SFRT_PAYIN_VACCNT_FINISHED" selected>회원충전</option>
                     <option value="SFRT_PAYIN_PVACCNT_FINISHED" >계좌입금</option>
                   </select>
                </div>
             </div>
             <script>
               function fnchanged3(){
                  $('#datatable3').dataTable().fnFilter();
               }
             </script>
             <table id="datatable3" class="table table-striped table-bordered"  class="display nowrap" cellspacing="0" width="100%">
               <thead>
                 <tr>
                   <th>s_id</th>
                   <th>TYPE</th>
                   <th>아이디</th>
                   <th>이름</th>
                   <th>금액</th>
                   <th>남은금액</th>
                   <th>시간</th>
                   <th>tid</th>
                 </tr>
               </thead>
               <tbody>
               </tbody>
             </table>
           </div>
         </div>
       </div>
</div>







    <!-- jQuery -->
  <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/default.js?v=20180105110142"></script>
  <!-- Custom Theme Scripts -->
  <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/build/js/custom.min.js?v=20180105110142"></script>
  <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/raphael/raphael.min.js"></script>
   <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/morris.js/morris.min.js"></script>
   <!-- bootstrap-daterangepicker -->
  <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/moment/min/moment.min.js"></script>
  <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
  <script>
  // refresh 확장
  $.fn.dataTableExt.oApi.fnStandingRedraw = function(oSettings) {
      //redraw to account for filtering and sorting
      // concept here is that (for client side) there is a row got inserted at the end (for an add)
      // or when a record was modified it could be in the middle of the table
      // that is probably not supposed to be there - due to filtering / sorting
      // so we need to re process filtering and sorting
      // BUT - if it is server side - then this should be handled by the server - so skip this step
      if(oSettings.oFeatures.bServerSide === false){
          var before = oSettings._iDisplayStart;
          oSettings.oApi._fnReDraw(oSettings);
          //iDisplayStart has been reset to zero - so lets change it back
          oSettings._iDisplayStart = before;
          oSettings.oApi._fnCalculateEnd(oSettings);
      }

      //draw the 'current' page
      oSettings.oApi._fnDraw(oSettings);
  };
  </script>
<script>
var table2;
function changedata(ln){
  console.log( $(ln).parent().serialize() );
  if ( confirm("정말로 변경하시겠습니까?") ){
    $.ajax({
      type : 'POST',
      url : '/api/index.php/admpop/changedata',
      data : $(ln).parent().serialize(),
      dataType : 'json',
      success : function(result) {
        if(result.code =='200') {
          alert("변경하였습니다.");
        }
        else {
          alert("변경 중 오류가 발생하였습니다.");
        }
        $('#datatable3').dataTable().fnStandingRedraw();
      }
    });
  }
}
function trformat3 ( row,d ) {
    // `d` is the original data object for the row
    ///api/index.php/admpop/tiddesc?tid=T17J72W
    $.ajax({
      type : 'GET',
      url : '/api/index.php/admpop/tiddesc',
      data : {tid:d.s_tid},
      dataType : 'json',
      success : function(result) {
        if(result.code==200){
          var str ="dstMemGuid :" + result.data.dstMemGuid +"<br>" +
          "srcMemGuid :" + result.data.srcMemGuid +"<br>" +
          "payAmt :" + result.data.payAmt +"<br>" +
          "회원 ID :" + result.data.m_id +"<br>" +
          "이름 :" + result.data.m_name2 +"<br>" +
          "계좌명 :" + result.data.m_name +"<br>"
          ;
          str =  '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;width:100%;">'+
          '<tr>'+'<td>TID DESC:</td>'+'<td class="tid_desc">'+str+'</td>'+'</tr>'+
          '<tr><td> </td><td> <hr> </td></tr>'+
          '<tr><td></td><td><form><input type="hidden" name="s_id" value="'+d.s_id+'"><span class="tid_desc_span">ID </span><input type="text" name="new_id" value="'+d.m_id+'"> <br>'+
          '<span class="tid_desc_span">이름 </span> <input type="text" name="new_name" value="'+d.m_name+'"> <br>'+
          '<a href="javascript:;" onClick="changedata(this)" class="btn btn-primary">변경하기</a></form>'
          '</td></tr>'+

          '</table>';
          row.child( str ).show();

        }
      }
    });
}
function tablecomplete(settings) {
  var total = '총 : ' + settings.json.sum.toString().replace( /\B(?=(\d{3})+(?!\d))/g, "," ) + "원";
  $("#datatable3_filter").html(total);
  $("#datatable3_filter").show();
}

$(function () {
  var loading = $("#ajaxloading");
  $(document).ajaxStart(function () {
      loading.show();
  });
  $(document).ajaxStop(function () {
      loading.hide();
  });
});

$(document).ready(function() {
  $('input.singlepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    locale:{format:"YYYY-MM-DD",
    "monthNames": [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"
        ],
    }
  });


  table3 = $('#datatable3').DataTable( {
    "processing": true,
    "serverSide": true,
    "scrollX": true,
    "lengthMenu": [ 1000, 5, 10,20],
    "ajax": {
        "url": "/api/index.php/admpop/ipgumlist",
        "type": "GET",
        "data": function ( d ) {
                 return $.extend( {}, d, {
                   "startdate": $('input[name=startdate]').val()
                   ,"trnsctnSt": $('#trnsctnSt option:selected').val()
                   ,"enddate": $('input[name=enddate]').val()
                   ,"search3": $('input[name=search3]').val()
                 } );
       }
    },
    "drawCallback": tablecomplete,
    "columns": [

        { "data": "s_id","className":      'details-control' ,
          "render": function ( data, type, row, meta )  {
            if(row.trnsctnSt=='SFRT_PAYIN_PVACCNT_FINISHED') return '<img src="/pnpinvest/layouts/home/pnpinvest/DataTables/details_open.png">' + data;
            else return data;
          }
        }
        ,{ "data": "ipgum_type" }
        ,{ "data": "m_id" }
        ,{ "data": "m_name" }
        ,{ "data": "s_amount","className":      'dt-body-right' ,
            "render" : function (data){
              return data.toString().replace( /\B(?=(\d{3})+(?!\d))/g, "," ) + "원";
            }
          }
          ,{ "data": "m_emoney","className":      'dt-body-right' ,
              "render" : function (data){
                if ( data == null) return '';
                return data.toString().replace( /\B(?=(\d{3})+(?!\d))/g, "," ) + "원";
              }
            }
        ,{ "data": "s_date" }
        ,{ "data": "s_tid" }
    ],
    "order": [[0, 'desc']]
    });
    $('#datatable3').dataTable().fnFilterOnReturn();
    $('#datatable3 tbody').on('click', 'td.details-control', function () {
    var tr = $(this).closest('tr');
    var row = table3.row( tr );

    if ( row.child.isShown() ) {
        // This row is already open - close it
        row.child.hide();
        tr.removeClass('shown');
    }
    else {
        $.each( $("tr.shown") , function (){
          table3.row( this ).child.hide();
        });
        // Open this row
        trformat3(row, row.data());
        //row.child( trformat3(row.data()) ).show();
        tr.addClass('shown');
    }
} );
});
</script>
</body>
</html>
