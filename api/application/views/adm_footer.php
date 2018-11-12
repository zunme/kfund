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
                    케이펀딩
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

<!-- modal2-->
<div id="unclosemodal" class="modal fade bs-example-modal-lg" tabindex="-2" role="dialog" aria-hidden="false">
  <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">정산하기</h4>
          </div>
          <div class="modal-body">
          </div>
          <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
      </div>
  </div>
</div>
<div id="izimodal"></div>
<div id="izimodal80"></div>
<!-- jQuery -->
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

<script>
var count = 0;
var remain = 0;
var jungsanajaxstatus = true;
function jungsan_remain_call(){
  if(jungsanajaxstatus == false ) return;
  $("#jungsan_btn_div").children('span').toggle();
   jungsanajaxstatus = false;
   count = 0;
   remain = parseInt($("#jungsan_remain_num").data('remain'));
   console.log(remain);
   jungsan_remain();
}
function jungsan_remain(){
  jungsanajaxstatus = false;
  $.ajax({
  type : 'GET',
  url : '/api/index.php/sunapprc/prcstep',
  dataType : 'json',
  success : function(result) {
    if(result.code=='200'){
      $("#jungsan_prc_div").prepend("<tr><td>"+result.data.sale_id+"</td>"+"<td>"+result.data.sale_name+"</td>"+"<td class='right'>"+result.data.emoney+"</td>"+"<td class='right'>"+result.data.wongum+"</td>"+"<td class='right'>"+result.data.total_interest+"</td>"
      +"<td class='right'>"+result.data.susuryoPayed+"</td>" +"<td class='right'>"+result.data.withholdingPayed+"</td>"+"<td class='right'>"+result.data.i_pay+"</td>"+"<td class='right'>"+(parseInt(result.data.i_pay) - parseInt(result.data.wongum) ) +"</td>"+"<td>"+result.data.i_subject+"</td>");
      $("#jungsan_remain_num").text("총 "+ (++count) +" 개 처리 후 "+ (--remain) +" 개 대기중");
      jungsan_remain();
    }else {
      $("#jungsan_prc_div").prepend("<tr><td colspan=10 style='padding:10px;background-color:red;color:white;text-align:center'>"+result.msg+"</td></tr>");
      if(result.code=='404') {
        jungsanajaxstatus = true;
        $("#jungsan_btn_div").children('span').toggle();
      }
    }
  }
});

}


function dynamicmodal(url, title){
  $('#dyModal .modal-title').text(title);
  $('#dyModal .modal-body').load(url,function(){
    $('#dyModal').modal({show:true});
  });
}
function sunapmodal(loanid){
  dynamicmodal("/api/index.php/sunap?loanid="+loanid, '수납 - *만기이후연체시 용도로 개발되었습니다.');
}
function sunapmodal_calc(loanid){
  $('#dyModal form[name="calc_sunap"]').children('input[name="reg"]').val('');
  $('#dyModal .modal-body').load("/api/index.php/sunap?"+ $('#dyModal form[name="calc_sunap"]').serialize() );
}
function sunapmodal_calc_reg(loanid){
  $('#dyModal form[name="calc_sunap"]').children('input[name="reg"]').val('reg');
  $.ajax({
    type : 'GET',
    url : '/api/index.php/sunap',
    dataType : 'json',
    data : $('#dyModal form[name="calc_sunap"]').serialize(),
    success : function(result) {
      if(result.code=='200'){
        $('#dyModal').modal('hide');
        alert("등록되었습니다.");
      }else alert(result.msg);
    }
  });
}
function openSsyWindow(userid, stype) {
  var specs = "left=10,top=10,width=980,height=800";
  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
  window.open('/api/index.php/seyfertinfo/tranceview?mid='+userid+'&type='+stype, "SeyferInfoView", specs);
}
function openSsyWindow2(userid) {
  var specs = "left=10,top=10,width=980,height=800";
  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
  window.open('/api/index.php/seyfertinfo/trancebalanceview?mid='+userid, "SeyferInfoView", specs);
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
function intervalfunc() {
  getuserlog();
  getbalance();
  getjungsanerror()
}
$(document).ready(function() {
  setInterval(intervalfunc,1000*60*5);
  $('input.singlepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    locale:{format:"YYYY-MM",
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
  $("#mainpreloader").fadeOut( "slow");
  $('#dyModal').on('hidden.bs.modal', function () {
    $('#dyModal div.modal-body').empty();
    $('#dyModal div.modal-body').text('');
  });
  $('#smodal').on('hidden.bs.modal', function () {
    $('#smodal div.modal-body').empty();
    $('#smodal div.modal-body').text('');
  });
  $('#unclosemodal').on('show.bs.modal', function () {
    if(jungsanajaxstatus == true) $('#unclosemodal .modal-body').load('/api/index.php/sunapprc');
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
  $("#izimodal").iziModal({
    iframe: true,
    iframeHeight: 500,
  });
  $('.triggerModal').on('click', function (event) {
    console.log("modal");
  	$("#izimodal").iziModal('open',event);
  });

  $("#izimodal80").iziModal({
    width:'80%',
    iframe: true,
    iframeHeight: 850,
  });
  $('.triggerModal80').on('click', function (event) {
    $("#izimodal80").iziModal('open',event);
  });

  // 이체하기. END
  intervalfunc();
});
function izimodalopen(event){
  $("#izimodal").iziModal('open',event);
}
function getjungsanerror() {
  $.ajax({
    type : 'get',
    url : '/api/index.php/adm/tujaerror',
    dataType : 'json',
    success : function(result) {
      $("#jungsan_errorlist span.badge").text( result.cnt ) ;
      if(result.cnt > '0'){
          $("#jungsan_errorlist ul.dropdown-menu").empty();
          $.each( result.data, function (key, data) {
            $("#jungsan_errorlist ul.dropdown-menu").append( "<li>시간 : "+data.regdate+"<br>refid:"+data.refId+"<br>tid:"+data.tid+"</li>" ) ;
          });
      }else {
        $("#jungsan_errorlist ul.dropdown-menu").html( "<li>오류 내용이 없습니다.</li>" ) ;
      }
    }
  });
}
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
<?php if (isset($js)) { ?>
<script src="/api/statics/js/<?php echo $js?>1"></script>
<?php } ?>
</body>
</html>
