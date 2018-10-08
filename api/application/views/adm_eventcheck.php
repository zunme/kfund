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
</style>
<div class="row">

  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
      <div class="x_title" style="min-height:50px;">
        <div class="form-group">
          <div class="col-md-9 col-sm-9 col-xs-9">
            <select id="eventselect" class="form-control" onchange="eventselectchanged()">
              <?php
              if ( count($list)>0){
              ?>
                  <option value="">선택하여주세요</option>
              <?php
                foreach ($list as $row){?>
                  <option value="<?php echo $row['eventid']?>"><?php echo $row['title']?></option>
              <?php
              }
                }else {
              ?>
                <option value=''>생성된 이벤트가 없습니다.</option>
              <?php } ?>
            </select>
          </div>
          <div class="col-xs-3 text-right" style="height: 50px;line-height: 40px;font-size: 15px;">
            <a class="" href="javascript:;"><i class="fa fa-plus addevent"></i></a>
            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
            <a class=""><i class="fa fa-refresh"></i></a>
          </div>
        </div>

      </div>
      <div class="x_content" id="eventbody">
        <form class="form-horizontal form-label-left" name="eventcfgform" id="eventcfgform">
          <input type="hidden" name="eventid" />
          <div class="form-group">
            <label class="control-label col-xs-1">제목</label>
            <div class="col-xs-11">
              <input type="text" name="title" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-xs-1">시작일</label>
            <div class="col-xs-5">
              <input type="text" class="form-control" name="startdate" data-inputmask="'mask': '9999-99-99'">
            </div>
            <label class="control-label col-xs-1">충전액</label>
            <div class="col-xs-5">
              <div class="input-group demo2 colorpicker-element">
                <input type="text" name="charge" value="" class="form-control">
                <span class="input-group-addon">이상</span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-xs-1">체크</label>
            <div class="col-xs-3"><input type="text" name="condition1" class="form-control"></div>
            <div class="col-xs-3"><input type="text" name="condition2" class="form-control"></div>
            <div class="col-xs-3"><input type="text" name="condition3" class="form-control"></div>
            <div class="col-xs-2"><input type="text" name="condition4" class="form-control"></div>
          </div>
        </form>
        <div class="col-xs-12 text-right">
          <a type="button" class="btn btn-primary">Cancel</a>
          <a type="submit" class="btn btn-success" onClick="saveevent()">저장</a>
        </div>
      </div>
    </div><!-- /xpanel -->
  </div> <!-- /col -->
</div>


<div class="row">

      <table id="eventtable" width="100%">
      </table>

</div>


<script>
var table;
var cell;
var today="";
var inittable = false;
var eventid = 0;

function init_InputMask() {
  if( typeof ($.fn.inputmask) === 'undefined'){ return; }
    console.log('init_InputMask');
    $(":input").inputmask();
};
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
function noti(msg){
  $.notify({
  //title: msg,
  icon: 'glyphicon glyphicon-star',
  message: msg
},{
  type: 'success',
  animate: {
    enter: 'animated fadeInDown',
    exit: 'animated fadeOutUp'
  },
  placement: {
    from: "top",
    align: "left"
  },
  delay: 500,
	timer: 1000,
  offset: 20,
  spacing: 10,
  z_index: 1031,
});

}
function eventselectchanged() {
  $.ajax({
    type : 'get',
    url : '/api/index.php/eventcheck/getlist',
    dataType : 'json',
    data : {eventid : $("#eventselect option:selected").val() },
    success : function(result) {
      if(result.code==200){
        eventid = result.cfg.eventid;
        changeeventcfg(result);
        maketable(result);
      }
    },
    error: function (jqXHR, exception) {
      ajaxerror( jqXHR, exception )
    }
  });
}
function saveevent() {
  $.ajax({
    type : 'POST',
    url : '/api/index.php/eventcheck/savecfg',
    dataType : 'json',
    data : $("#eventcfgform").serialize(),
    success : function(result) {
      if(result.code==200){
        noti("저장되었습니다.");
        changeeventcfg(result);
        changeeventselect(result);
        getlist(result);
      }else alert (result.msg)
    },
    error: function (jqXHR, exception) {
      ajaxerror( jqXHR, exception )
    }
  });
}
function checkthis(check){
    $.confirm({
      title: '저장하시겠습니까?',
      content: '',
      buttons: {
          confirm: function () {
            var m_no = $(check).val();
            var savetype= $(check).data('savetype');
            $.ajax({
              type : 'POST',
              url : '/api/index.php/eventcheck/savetype',
              dataType : 'json',
              data : {eventid:eventid, m_no:$(check).val(), savetype:$(check).data('savetype') },
              success : function(result) {
                if(result.code==200){
                  //$(check).parent().text(result.changedate);
                  cell.data( result.changedate ).draw();
                  if(result.msg !=''){
                    $.alert(result.msg);
                  }
                }else {
                  $(check).prop('checked', false);
                  alert(result.msg);
                }
              },
              error: function (jqXHR, exception) {
                $(check).prop('checked', false);
                ajaxerror( jqXHR, exception )
              }
            });

          },
          cancel: function () {
              $(check).prop('checked', false);
          }
      }
  });
}
function redata( viewtype ){
  if (viewtype =="today") today = moment().format("YYYY-MM-DD");
  else today = viewtype;
  //else today = "";

  filterByDate(); // We call our filter function
  $("#eventtable").DataTable().draw();
}
function iscomplete( data ){
  var istrue = false;
  if( typeof data != "undefined" ){
    if( new Date(data).toString() !="Invalid Date" ) istrue = true;
    else istrue = false;
  }else istrue = true;
  return istrue;
}
var filterByDate = function() {
  // Custom filter syntax requires pushing the new filter to the global filter array
		$.fn.dataTableExt.afnFiltering.push(
		   	function( oSettings, aData, iDataIndex ) {
          if (today == "all" ) return true;
          else if ( today == "complete"){
            if ( iscomplete(aData[6]) && iscomplete(aData[7]) &&  iscomplete(aData[8]) &&iscomplete(aData[9]) &&iscomplete(aData[10]) ) {
              return true;
            }
            else {
              return false;
            }
          }else {
            if(new Date(aData[6]).toString() !="Invalid Date" && moment(aData[6], "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD") == today ) return true;
            else if(aData[7] != "undefined" && new Date(aData[7]).toString() !="Invalid Date" && moment(aData[7], "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD") == today ) return true;
            else if(aData[8] != "undefined" && new Date(aData[8]).toString() !="Invalid Date" && moment(aData[8], "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD") == today ) return true;
            else if(aData[9] != "undefined" && new Date(aData[9]).toString() !="Invalid Date" && moment(aData[9], "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD") == today ) return true;
            else if(aData[10] != "undefined" && new Date(aData[10]).toString() !="Invalid Date" && moment(aData[10], "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD") == today ) return true;
            else return false;
          }
          return false;
        }
		);
	};

function maketable(data){
  //$("#datatitle").text(data.cfg.title);
  if( inittable ){
    $('#eventtable tbody').on( 'click', 'td', function() {});
    $("#eventtable").DataTable().destroy();
  }
  inittable = true;
  $("#eventtable").empty();
  $("#eventtable").append('<thead />');
  $("#eventtable thead").append('<tr/>');
  var thead = $("#eventtable thead tr");
  $(thead).append("<th>ID</th>");
  $(thead).append("<th>NAME</th>");
  $(thead).append("<th>HP</th>");
  $(thead).append("<th  class='hidden'>ADDRESS</th>");
  $(thead).append("<th>가입일</th>");
  $(thead).append("<th>EMONEY</th>");
  $(thead).append("<th>충전일</th>");
  $(thead).append("<th>체크</th>");
  if( data.cfg.condition1 != '' ){$(thead).append("<th>"+data.cfg.condition1+"</th>");}
  if( data.cfg.condition2 != '' ){$(thead).append("<th>"+data.cfg.condition2+"</th>");}
  if( data.cfg.condition3 != '' ){$(thead).append("<th>"+data.cfg.condition3+"</th>");}
  if( data.cfg.condition4 != '' ){$(thead).append("<th>"+data.cfg.condition4+"</th>");}
  $("#eventtable").append('<tbody />');
  $.each(data.data, function (i, item){
    var basecheck, cond1, cond2, cond3, cond4= "";
    if( item.charge_date != null ){
      //basecheck='<input type="checkbox" value="'+item.m_no+'" name="basecheck[]" class="basecheck" checked title="'+item.charge_date+'" disabled >';
      basecheck=item.charge_date;
    }else {
      basecheck='<input type="checkbox" value="'+item.m_no+'" name="chargecheck[]" class="chargecheck" data-savetype="charge" onClick="checkthis(this)">';
    }

    var tr = $('<tr>').append(
      $('<td>').html("<a>"+item.m_id+"</a>")
      ,$('<td>').html("<a>"+item.m_name+"</a>")
      ,$('<td>').html("<a>"+item.m_hp+"</a>")
      ,$('<td class="hidden">').html("<a>("+item.m_zip+")"+item.m_addr1+' '+ item.m_addr2 +"</a>")
      ,$('<td>').html("<a>"+item.m_datetime+"</a>")
      ,$('<td>').html("<a>"+item.m_emoney+"</a>")
      ,$('<td>').html("<a>"+item.basedate+"</a>")
      ,$('<td>').html( basecheck )
    )//.appendTo("#eventtable tbody");
    if(data.cfg.condition1 != ''){
      if( item.condition1_date != null ){
        //cond1='<input type="checkbox" value="'+item.m_no+'" name="condition1[]" class="condition1check" checked title="'+item.condition1_date+'" disabled >';
        cond1 = item.condition1_date;
      }else {
        cond1='<input type="checkbox" value="'+item.m_no+'" name="condition1[]" class="condition1check" data-savetype="condition1" onClick="checkthis(this)">';
      }
      tr.append($('<td>').html( cond1 ));
    }
    if(data.cfg.condition2 != ''){
      if( item.condition2_date != null ){
        //cond2='<input type="checkbox" value="'+item.m_no+'" name="condition2[]" class="condition2check" checked title="'+item.condition2_date+'" disabled >';
        cond2 = item.condition2_date;
      }else {
        cond2='<input type="checkbox" value="'+item.m_no+'" name="condition2[]" class="condition2check" data-savetype="condition2" onClick="checkthis(this)">';
      }
      tr.append($('<td>').html( cond2 ));
    }
    if(data.cfg.condition3 != ''){
      if( item.condition3_date != null ){
        //cond3='<input type="checkbox" value="'+item.m_no+'" name="condition3[]" class="condition3check" checked title="'+item.condition3_date+'" disabled >';
        cond3=item.condition3_date;
      }else {
        cond3='<input type="checkbox" value="'+item.m_no+'" name="condition3[]" class="condition3check" data-savetype="condition3" onClick="checkthis(this)">';
      }
      tr.append($('<td>').html( cond3 ));
    }
    if(data.cfg.condition4 != ''){
      if( item.condition4_date != null ){
        //cond4='<input type="checkbox" value="'+item.m_no+'" name="condition4[]" class="condition4check" checked title="'+item.condition4_date+'" disabled >';
        cond4 = item.condition4_date;
      }else {
        cond4='<input type="checkbox" value="'+item.m_no+'" name="condition4[]" class="condition4check" data-savetype="condition4" onClick="checkthis(this)">';
      }
      tr.append($('<td>').html( cond4 ));
    }
    tr.appendTo("#eventtable tbody");
    if( i+1 == data.data.length) {
      table = $("#eventtable").DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', {
                extend: 'excelHtml5',
                title: 'EVENTLIST'
            }
            , 'pdf', 'print'
            ,{
                text: '전체 보기',
                action: function ( e, dt, node, config ) {
                    redata('all');
                }
            }
            ,{
                text: '오늘체크 보기',
                action: function ( e, dt, node, config ) {
                    redata('today');
                }
            },{
                text: '완료 보기',
                action: function ( e, dt, node, config ) {
                    redata('complete');
                }
            }
        ]
      });
      $('#eventtable tbody').on( 'click', 'td', function () {
          cell = table.cell( this );
          //console.log( table.cell( this ).data() );
      } );
    };
  });
}
function getlist(data){
  $.ajax({
    type : 'get',
    url : '/api/index.php/eventcheck/getlist',
    dataType : 'json',
    data : {eventid:data.eventid},
    success : function(result) {
      if(result.code==200){
        eventid = data.eventid;
        maketable(result);
      }
    },
    error: function (jqXHR, exception) {
      ajaxerror( jqXHR, exception )
    }
  });
}
function changeeventselect(data){
  $("#eventselect").empty();
  $.each(data.cfglist, function(i, item) {
    var str = '<option value="' + item.eventid + '" ' + (   item.eventid == data.eventid ? "selected":"" ) + '>'+item.title+'</option>';
    $("#eventselect").append(str);
  });
}
function changeeventcfg(data){
  $("input[name='eventid']").val(data.eventid);
  $("input[name='title']").attr('disabled','disabled').val(data.cfg.title);
  $("input[name='startdate']").attr('disabled','disabled').val(data.cfg.startdate);
  $("input[name='charge']").attr('disabled','disabled').val(data.cfg.charge);
  $("input[name='condition1']").attr('disabled','disabled').val(data.cfg.condition1);
  $("input[name='condition2']").attr('disabled','disabled').val(data.cfg.condition2);
  $("input[name='condition3']").attr('disabled','disabled').val(data.cfg.condition3);
  $("input[name='condition4']").attr('disabled','disabled').val(data.cfg.condition4);
}
$("document").ready( function() {
  init_InputMask();
  $(".nav_menu").empty();
  $("#izimodal").iziModal({
    iframe: true,
    iframeHeight: 500,
  });
  $('.triggerModal').on('click', function (event) {
    console.log("modal");
    $("#izimodal").iziModal('open',event);
  });

  $("#mainpreloader").fadeOut( "slow");
});
</script>
</div>
<!-- /page content -->

<!-- footer content -->
<footer>
  <div class="pull-right">
    Admin
  </div>
  <div class="clearfix"></div>
</footer>
<!-- /footer content -->
</div>
</div>


<div id="izimodal"></div>

</body>
</html>
