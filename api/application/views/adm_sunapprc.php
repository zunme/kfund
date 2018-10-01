<style>
 table.justable thead th {text-align:center}
 table.justable tbody td.right {text-align:right}
 table.justable tbody td{padding:3px;}
</style>
<div class="row" style="margin-top:10px;">
  <div class="col col-xs-8" id="jungsan_remain_num" data-remain ="<?php echo count($list)?>" style="text-align:center;font-size:20px;margin-top:2px;">
    총 <?php echo count($list)?> 개 대기중
  </div>
  <div class="col col-xs-2" id="jungsan_btn_div">
     <span class="btn btn-danger" onclick="jungsan_remain_call()">정산하기</span>
     <span class="btn btn-primary" style="display:none">정산중입니다.</span>
  </div>
  <div class="col col-xs-2" id="sunapsms_btn_div">
     <span class="btn btn-danger" onclick="sunapsms(this)" data-avail="true">
       <div style="display:block" class="span">정산SMS보내기</div>
       <div style="display:none;width:40px;height:40pxs;" class="loadicon">
         <svg class="lds-spinner" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><g transform="rotate(0 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.9166666666666666s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(30 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.8333333333333334s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(60 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.75s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(90 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.6666666666666666s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(120 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.5833333333333334s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(150 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.5s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(180 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.4166666666666667s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(210 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.3333333333333333s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(240 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.25s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(270 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.16666666666666666s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(300 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="-0.08333333333333333s" repeatCount="indefinite"></animate>
  </rect>
</g><g transform="rotate(330 50 50)">
  <rect x="47" y="24" rx="9.4" ry="4.8" width="6" height="12" fill="#4658ac">
    <animate attributeName="opacity" values="1;0" keyTimes="0;1" dur="1s" begin="0s" repeatCount="indefinite"></animate>
  </rect>
</g></svg>
       </div>
     </span>
  </div>
</div>
<hr>
<table width="100%" class="justable">
  <thead>
    <tr>
      <th>EMAIL</th>
      <th>이름</th>
      <th>정산금</th>
      <th>원금</th>
      <th>이자</th>
      <th>수수료</th>
      <th>원천징수</th>
      <th>투자금액</th>
      <th>남은금액</th>
      <th>투자건</th>
    </tr>
  </thead>
  <tbody id="jungsan_prc_div">
  </tbody>
</table>
<script>
function sunapsms(bt){
  if ($(bt).data('avail')==true && confirm("정산완료된 사람에게 SMS를 보내시겠습니까?(1회 최대 100건)")){
    $.ajax({
      type : 'GET',
      url : '/api/index.php/Sunapaligo/getlist',
      dataType : 'json',
      success : function(result) {
        if(result.data > 0 && confirm("총 "+result.data+"건이 대기중입니다. 보내시겠습니까?" )){
          $.ajax({
            type : 'GET',
            url : '/api/index.php/Sunapaligo/sendsms',
            dataType : 'json',
            beforeSend: function(){
              $(bt).children('.span').hide();
              $(bt).children('.loadicon').show();
              $(bt).data('avail', false);
            },
            success : function(result) {
              alert(result.msg);
              $(bt).children('.loadicon').hide();
              $(bt).children('.span').show();
              $(bt).data('avail', true);
            },
            error: function (jqXHR, exception) {
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
          });
        }else if (result.data < 1) {
          alert("더이상 보낼 데이터가 없습니다.");
        }
      }
    });
  }
}
</script>
