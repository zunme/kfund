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



<div id="smodal"class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
</button>
<h4 class="modal-title" id="myModalLabel"></h4>
</div>
<div class="modal-body" id="myModalBody">

</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div>


<!-- modal2-->
<div id="smodal2" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">이체</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 이체 body-->
        <form id="form1">
            <div class="bd">

              <div class="row form-group">
                <div class="col">
                    <div class="checkbox right">
                      <label>
                        <input type="checkbox" class="flat" name="ignore" value="Y" checked="checked"> 기록없이 이체 (기존기록이 있을경우에 체크해주세요. 이체만 진행합니다.)
                      </label>
                    </div>
                </div>
              </div>
              <div class="row form-group">
                <div class="col-xs-10">
                  <label class="form-label">대상 대출</label>
                    <select class="form-control" name="loan_id">
                      <option value='0'>관련 대출이 있으면 선택해주세요</option>
                      <?php foreach ($loanlist as $key => $val) { ?>
                        <option value="<?php echo $val['i_id']?>"><?php echo $val['i_subject']?></option>
                      <?php } ?>
                    </select>
                </div>
                <div class="col-xs-2">
                    <label class="form-label">회차</label>
                    <input class="form-control" type="number" value="0" name="count" placeholder="회차">
                </div>
              </div>
              <div class="row form-group">
                <label class="col-3 col-form-label">보내는 사람</label>
                <div class="col-9">
                    엔젤펀딩
                    <input type="hidden" name="from" value="angelfunding">
                </div>
              </div>
              <div class="row form-group">
                <label class="col-3 col-form-label">받는 사람</label>
                <div class="col-9">
                    <input type="email" class="form-control" placeholder="받는 사람 이메일" name="to">
                </div>
              </div>
              <div class="row form-group">
                <div class="col-xs-4">
                    <label class="form-label">액수(원)</label>
                    <input id='interest' class="form-control" type="number" value="0" name="interest" placeholder="이체 액수를 적어주세요(숫자)" onkeyup="calctotal()">
                </div>
                <div class="col-xs-4">
                    <label class="form-label">원천징수(원)</label>
                    <input  id='withholding' class="form-control" type="number" value="0" name="withholding" placeholder="원천징수금액를 적어주세요(숫자)" onkeyup="calctotal()">
                </div>
                <div class="col-xs-4">
                    <label class="form-label">실이체액수(원)</label>
                    <input id='totalmoney' class="form-control" type="number" value="0" name="amount" placeholder="이체 액수를 적어주세요(숫자)">
                </div>
              </div>
              <div class="row form-group">
                <label class="col-3 col-form-label">내용</label>
                <div class="col-9">
                    <input class="form-control" type="text" value="" name="cont" placeholder="기록에 남길 이체내용을 적어주세요">
                </div>
              </div>
            </div>
        </form>

        <!-- /이체 body -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="sendbt">이체하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- / modal2 -->
<!-- Modal -->
<div class="modal fade" id="dyModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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

 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.6/jstz.min.js"></script>
 <script type="text/javascript" src="/api/statics/calendar/js/language/ko-KR.js"></script>
 <script type="text/javascript" src="/api/statics/calendar/js/calendar.js"></script>

<script>
function dynamicmodal(url, title){
  $('#dyModal .modal-title').text(title);
  $('#dyModal .modal-body').load(url,function(){
    $('#dyModal').modal({show:true});
  });
}
function openSsyWindow(userid, stype) {
  var specs = "left=10,top=10,width=980,height=800";
  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
  window.open('/api/index.php/seyfertinfo/tranceview?mid='+userid+'&type='+stype, "SeyferInfoView", specs);
}
function realtrance() {
    $.ajax({
      type : 'POST',
      url : '/api/index.php/seyfertinfo/tranceit?confrim=Y',
      dataType : 'json',
      data : $("#form1").serialize(),
      success : function(result) {
        if(result.code=='200'){
          $("#smodal2").modal('hide');
          alert('이체완료되었습니다('+result.data.data.tid+').');
        }else alert(result.msg);
      }
    });
}
function calctotal(){
  $('#totalmoney').val( $("#interest").val() - $("#withholding").val() );
}
function searchsetuser(user){
  if( typeof $("#datatable2") !== 'undefined') {
    $("#datatable2_filter input[type='search']").val(user);
    $('#datatable2').dataTable().fnFilter(user);
  }
}
function searchsetloan(loan){
  if( typeof $("#datatable1") !== 'undefined') {
    $("#datatable1_filter input[type='search']").val(loan);
    $('#datatable1').dataTable().fnFilter(loan);
  }
}
function makereserv(memid){
   dynamicmodal('/api/index.php/adm/userlog?user='+memid, 'LOG ['+memid+']');
}
function getuserlog() {
   var li = $("#menu2 li:last-child");
   $.ajax({
    type:"GET",
    dataType: 'html',
    url: '/api/index.php/adm/getreservetemplate?lastidx='+$(li).data('idx'),
    success: function(res){
      var temp = res.split("@@val=");
      if(parseInt(temp[2]) > 0){
        $("#menu2").prepend(temp[0]);
        $("#menu2").closest("li").children("a:first-child").children("span.badge").text( parseInt($("#menu2").closest("li").children("a:first-child").children("span.badge").text()) + parseInt(temp[2]));
        $(li).data('idx' ,temp[1] );

        $.notify({
          title: '<strong>예약 로그 내용이 있습니다.</strong>',
          icon: 'glyphicon glyphicon-star',
          message: "New log"
        },{
          type: 'info',
          animate: {
            enter: 'animated fadeInUp',
            exit: 'animated fadeOutRight'
          },
          placement: {
            from: "bottom",
            align: "left"
          },
          offset: 20,
          spacing: 10,
          z_index: 1031,
        });

      }
    }
  });
}
function getbalance() {
  $("#balanceemoney").text('..Loading..');
  $.ajax({
    type : 'POST',
    url : '/api/index.php/seyfertinfo/lnq',
    dataType : 'json',
    data : {mn:'angelfunding'},
    success : function(result) {
      console.log(result);
      if(result.code=='200'){
        $("#balanceemoney").html(result.data.han+"<br>차액( "+result.data.data.amount2 +")");
      };
    }
  });
}
$(document).ready(function() {
  setInterval(getuserlog,1000*60*5);
  setInterval(getbalance,1000*60*5);

  $("#mainpreloader").fadeOut( "slow");
  $('#dyModal').on('hidden.bs.modal', function () {
    $('#dyModal div.modal-body').empty();
    $('#dyModal div.modal-body').text('');
  });
  $('#smodal').on('hidden.bs.modal', function () {
    $('#smodal div.modal-body').empty();
    $('#smodal div.modal-body').text('');
  });

  //이체하기. START
  $('#smodal2').on('hidden.bs.modal', function (e) {
    $("#smodal2 select[name='loan_id']").find("option:eq(0)").prop("selected", true);
    $("#smodal2 input[type='number']").val('0');
    $("#smodal2 input[type='email']").val('');
    $("#smodal2 input[type='text']").val('');
  });
  $("#sendbt").on("click", function(){
    $.ajax({
      type : 'POST',
      url : '/api/index.php/seyfertinfo/tranceit',
      dataType : 'json',
      data : $("#form1").serialize(),
      success : function(result) {
        if(result.code=='200'){
          if(confirm( result.title +'\n\n' + result.msg) ) {
            realtrance();
          }
        }else alert(result.msg);
      }
    });
  });
  // 이체하기. END
  getbalance();
});

//환불취소 작성중
function cancelAfterEnd(bt){
  var td = $(bt).closest('td');
  console.log(td.children('form').serialize());
  $.ajax({
    type : 'POST',
    url : '/api/index.php/adm/getseyfertorder',
    dataType : 'json',
    data : td.children('form').serialize(),
    success : function(result) {
      if(result.code=='200'){
        if(confirm( result.msg) ) {

          $.ajax({
            type : 'POST',
            url : '/api/index.php/adm/getseyfertorder',
            dataType : 'json',
            data : td.children('form').serialize()+'&confirm=Y',
            success : function(result) {
              if(result.code=='200'){

              }else alert(result.msg);
            }
          });

        }
      }else alert(result.msg);
    }
  });
}
</script>


<script src="/api/statics/calendar/zabuto_calendar.js"></script>
<link rel="stylesheet" type="text/css" href="/api/statics/calendar/zabuto_calendar.min.css">
<style>
div.zabuto_calendar div.calendar-month-navigation{padding-top: 0;}
div.schdetaildiv{padding:3px 0 0 5px;}
div.schdetaildiv.selected {background-color: red; color:white;}
</style>
<script>
$(document).ready(function() {
  $('#calendar').zabuto_calendar({
    language: "kr",
    cell_border: true,
    today: true,
    weekstartson: 0,
    ajax: {
      url: "/api/index.php/adm/settledata",
      modal: false
    },
    action: function () {
        return myDateFunction(this.id, false);
      //console.log(this.id);
    },
    action_nav: function () {
        //return myNavFunction(this.id);
        //console.log(this.id);
    },
  });
});
function myDateFunction(id, fromModal) {
    if (fromModal) {
        $("#" + id + "_modal").modal("hide");
    }
    var date = $("#" + id).data("date");
    var hasEvent = $("#" + id).data("hasEvent");
    if (hasEvent && !fromModal) {
      $("#cal_info").empty();
      $.ajax({
        type : 'GET',
        url : '/api/index.php/adm/settledetail',
        dataType : 'json',
        data : {date:date},
        success : function(result) {
          for(key in result) {
            $("#cal_info").append( '<div class="schdetaildiv" data-date="'+date+'" data-idx="'+result[key].loanid+'" onClick="loadloan(this)">['+((result[key].payed =='Y')? '완료':'예정')+']'+result[key].i_subject+'</div>' );
          }
        }
      });
        return false;
    }
    return true;
}

function myNavFunction(id) {
    var nav = $("#" + id).data("navigation");
    var to = $("#" + id).data("to");
    console.log(nav + ','+to.month + '/' + to.year);
}
function loadloan(div){
  $("#loaninfo").empty();
  $("div.schdetaildiv.selected").removeClass('selected');
  $(div).addClass('selected');
  $.get('/api/index.php/adm/settlejungsantable?loanid='+$(div).data('idx'), function(data, status){
        $("#loaninfo").html( data );
  });
}
function view_calcdetail(tr){
  $("#loancalc").empty();
  $("#loancalc_detail").empty();
  $.get('/api/index.php/adm/settlejungsantableDetail?loanid='+$(tr).data('loanid')+'&loancnt='+$(tr).data('loancnt'), function(data, status){
        $("#loancalc").html( data );
  });
}
function view_calcdetail_history(tr){
}
</script>
<?php if (isset($js)) { ?>
<script src="/api/statics/js/<?php echo $js?>4"></script>
<?php } ?>
</body>
</html>
