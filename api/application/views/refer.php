
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

   <script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/echarts/dist/echarts.min.js"></script>
</head>

  <body class="nav-md">
    <div class="main_container">

   <div class="row">


    <div class="col-md-5 col-sm-5 col-xs-5">
      <div class="x_panel">
        <div class="x_title">
          <h2>외부유입</h2>
          <ul class="nav navbar-right panel_toolbox">
            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
            </li>
            <li><a class="close-link"><i class="fa fa-close"></i></a>
            </li>
          </ul>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <form id="searchform" style="display:inline">
              <fieldset>
                <div class="control-group">
                  <div class="controls">
                    <div class="col-md-1"></div>
                    <div class="col-md-3 xdisplay_inputx form-group has-feedback">
                      <input type="text" class="form-control has-feedback-left singlepicker" name="startd" value="<?php echo date("Y-m-d",strtotime("-1 day")); ?>">
                      <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                      <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                    </div>
                    <div class="col-md-1">~</div>
                    <div class="col-md-3 xdisplay_inputx form-group has-feedback">
                      <input type="text" class="form-control has-feedback-left singlepicker"  name="endd"  value="<?php echo date("Y-m-d",strtotime("-1 day")); ?>">
                      <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                      <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                    </div>
                    <div class="col-md-4">
                      <a href="javascript:" onClick="getdatatoday('N')" class="btn btn-large btn-success">어제</a>
                      <a href="javascript:" onClick="getdatatoday('Y')" class="btn btn-large btn-success">오늘</a>
                      <a href="javascript:" onClick="getdata()" class="btn btn-large btn-success">검색</a>
                    </div>
                  </div>
                </div>
              </fieldset>
          </form>
          <div id="echart_horizontal" style="height:800px;"></div>
        </div>
      </div>
    </div>


    <div class="col-md-7 col-sm-7 col-xs-7">
      <div class="x_panel">
        <div class="x_title">
          <h2>리스트</h2>
          <ul class="nav navbar-right panel_toolbox">
            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
            </li>
            <li><a class="close-link"><i class="fa fa-close"></i></a>
            </li>
          </ul>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <table class="table table-bordered" id='datatabler' style="table-layout: fixed;word-wrap: break-word;">
            <thead>
              <tr>
                <th>domain</th>
                <th>ID</th>
                <th>referer</th>
                <th>투자</th>
                <th>date</th>
              </tr>
            </thead>
            <tbody id="listbody">

            </tbody>
          </table>
        </div>
      </div>
    </div>


  </div>
<!--   -->

<div class="row">

</div>

<!-- -->
</div>
</div>

    <script>
    var chart;var table;var list;
    $(document).ready( function () {
      $('input.singlepicker').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        locale:{format:"YYYY-MM-DD",
        "monthNames": ["1","2","3","4","5","6","7","8","9","10","11","12"],
        }
      });
      $("#datatabler").DataTable();
      getdata();
    });
    function getdatatoday( yorn ) {
      var date  = yorn =='Y' ? moment(new Date()).format("YYYY-MM-DD") :  moment().add(-1, 'days').format("YYYY-MM-DD");
      $("input[name=startd]").val(date);
      $("input[name=endd]").val(date);
      $("input[name=startd]").data('daterangepicker').setStartDate(date);
      $("input[name=startd]").data('daterangepicker').setEndDate(date);
      $("input[name=endd]").data('daterangepicker').setStartDate(date);
      $("input[name=endd]").data('daterangepicker').setEndDate(date);
      getdata();
    }
    function getdata() {
      $.ajax({
        type : 'get',
        url : '/api/index.php/refer/getlog',
        dataType : 'json',
        data : $("#searchform").serialize() ,
        success : function(result) {
            makechart(result.label, result.in, result.join,result.total);
            $("#datatabler").DataTable().destroy();
            $("#listbody").empty();
            $.each( result.list , function (idx,row){
              $("#listbody").append("<tr><td>"+row.domain+"</td><td>"+row.mid+"</td><td>"+row.referer+"</td><td>"+row.subjs+"</td><td>"+row.regdate+"</td></tr>");
            });
            table = $("#datatabler").DataTable();
        }
      });

    }
    function makechart2(labeldata, indata, joindata) {
      chart=echarts.init(document.getElementById("mainc"));
      option = {
         title : {
             text: '외부유입',
             subtext: '(기간총가입 : 명)'
         },
         tooltip : {
             trigger: 'axis'
         },
         legend: {
             data:['유입','가입']
         },
         toolbox: {
             show : true,
             feature : {
                 dataView : {show: true, readOnly: false},
                 magicType : {show: true, type: ['line', 'bar']},
                 restore : {show: true},
                 saveAsImage : {show: true}
             }
         },
         calculable : true,
         xAxis : [
             {
                 type : 'category',
                 data : labeldata
             }
         ],
         yAxis : [
             {
                 type : 'value'
             }
         ],
         series : [
             {
                 name:'유입',
                 type:'bar',
                 data:indata,
                 markPoint : {
                     data : [
                         {type : 'max', name: '최고유입'},
                         {type : 'min', name: '최저유입'}
                     ]
                 },
                 markLine : {
                     data : [
                         {type : 'average', name: '평균유입량'}
                     ]
                 }
             },
             {
                 name:'가입',
                 type:'bar',
                 data:joindata,
                 markPoint : {
                     data : [
                       {type : 'max', name: '최고가입'},
                       {type : 'min', name: '최저가입'}
                     ]
                 },
                 markLine : {
                     data : [
                         {type : 'average', name : '평균가입량'}
                     ]
                 }
             }
         ]
     };
     b.setOption(option);
   }//make chart end
</script>
<script>
  function makechart(labeldata, indata, joindata, totaldata) {
     chart=echarts.init(document.getElementById("echart_horizontal"));
    chart.setOption(
      {
        title:{text:"외부유입 Graph",subtext:"(기간총가입 : "+ totaldata +"명)"}
        ,tooltip:{trigger:"axis"}
        ,legend: {
            data:['유입','가입']
        },
        grid: {
           x: 150,
           y: 45,
           x2: 5,
           y2: 54
      },
        toolbox:{
          show : true,
          feature : {
              dataView : {show: true, readOnly: false, title:"data", lang:['View', 'close','refresh'] },
              magicType : {show: true, type: ['line', 'bar'], title:'바꾸기'},
              restore : {show: false},
              saveAsImage : {show: true,title:'저장'}
          }
        }
        ,calculable:!0,xAxis:[{type:"value",boundaryGap:[0,.01]}]
        //,calculable : true
        ,yAxis:
          [
            {
              type:"category"
              ,data:labeldata
            }
          ]
        ,series:
          [
            {
              name:"유입"
              ,type:"bar"
              ,markPoint : {
                  data : [
                      {type : 'max', name: '최고유입'}
                  ]
              }
              ,data:indata
            }
            ,{
              name:"가입"
              ,type:"bar"
              ,markPoint : {
                  data : [
                      {type : 'max', name: '최고가입'},
                  ]
              }
              ,data:joindata
            }
          ]
        });
        chart.on('click', function (params) {
            table.search(params.name).draw();
        });
  }
</script>
