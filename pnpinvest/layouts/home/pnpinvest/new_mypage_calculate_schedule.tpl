<?php

include(MARI_VIEW_PATH.'/Common_select_class.php');
include (getcwd().'/module/calculation_base.php');
if( !isset($user['m_id']) ) {
  ?>
  <script>
    location.href="/pnpinvest/?mode=login";
  </script>
  <?php
  exit;
}
$ilmangitable= new ilmangitable();
?>
{# new_header}
<style>
tr.hiddentr {
    display: none;
}
select {
    margin: 0;
}
.form-control {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
div.zabuto_calendar .table tr.calendar-month-header td span.glyphicon  {
    color: transparent;
}

</style>
<script type="text/javascript" src="js/zabuto_calendar.min.js"></script>
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub mypage">
	<!-- Sub title -->
	<h2 class="subtitle t4"><span class="motion" data-animation="flash">마이페이지</span></h2>
	<!-- 케이펀딩 공지사항 -->
	<div class="join">
		<div class="container clearfix">
			<!-- 컨텐츠 본문 -->
			<aside class="snb">
				<h3>MY PAGE</h3>
				<ul>
					{# new_side}
				</ul>
			</aside>

      <style>
      .btn_mytab{
        font-size: 14px;
        font-weight: 400;
        }
      </style>
			<div class="my_content">
				<div class="my_certify clearfix">
					<div class="title clearfix">
						<h3 class="fl">투자정보</h3>
						<p class="btn_mytab_wrap">
							<a href="/pnpinvest/?mode=mypage_invest_info" class="btn_mytab">투자관리</a>
							<a href="javascript:;" class="btn_mytab active">투자 상환 스케줄</a>
						</p>
					</div>
					<!-- 투자 관리 start -->
					<div class="my_schedule">
						<h4>상환스케줄 <span class="pc">현재까지 투자한 내역에 대한 정산스케줄입니다.</span></h4>
						<div id="my-calendar" class="my_calendar"></div>
            <script type="application/javascript">
            var lastto={year: <?php echo date('Y')?>, month: <?php echo date('m')?>};
            var eventData;
            var prepare =[];
            var lengtr=0;
            var loading = $("#ajaxloading");
            $(document).ajaxStart(function () {
                loading.show();
            });
            $(document).ajaxStop(function () {
                loading.hide();
            });
            $(document).ready(function () {
              $.ajax({
                     type : "get",
                     dataType : "json",
                     url : "/api/index.php/jungsantable?prepare=true",
                     success : function(data) {
                       eventData = data.jungsan;
                       lengtr = eventData.length;
                       makecal();
                       $.each(eventData, function (index, row){
                         var hidden = (row.yearmonth != row.todayym ) ? "hiddentr" : "showtr";
                         var tr = "<tr class='listtr "+hidden+"' data-ym= '"+row.yearmonth+"' data-loan='"+row.loan_id+"'><td>"+row.date+"</td><td>"+row.subject+"</td><td>"+row.status+"</td><td>"+row.wongum+"</td><td>"+row.invtotal+"</td><td>"+row.susuryo+"</td><td>"+row.o_withholding+"</td><td>"+row.p_emoney+"</td></tr>";
                         $("#detailcal > tbody").append(tr);
                         if( index == lengtr-1) changecomplete();
                       });
                       $.each(data.loanlist, function (index, row){
                         $("#loanselect").append("<option value='"+row.i_id+"'>"+row.i_subject+"</option>");
                       });
                       if(data.prepare.length > 0 ) $("#prepareloanbody").empty();
                       $.each(data.prepare, function (index, row){
                         $("#prepareloanbody").append("<div>["+row.i_subject+"] 상품은 현재 계약 진행중입니다.</div>");
                         prepare.push(row.i_id*1)
                       });

                     },

                     error : function(e) {
                            alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
                     }
              });


            });
            function changecomplete () {
              /*
              if ($("tr.listtr.hiddentr").length == lengtr){
                console.log("none");
              }
              console.log($("tr.listtr.hiddentr").length);
              console.log(lengtr);
              */
            }
            function makecal(){
              $("#my-calendar").zabuto_calendar({
                today: true,
                language: "kr",
                action_nav: function () {
                    return myNavFunction(this.id);
                },
                action : function () {
                  console.log(this.id);
                },
                //ajax: { url: "https://192.168.0.3:6003/api/index.php/jungsantable", modal: false },
                data: eventData,
                weekstartson: 0,

              });
            }
            function myNavFunction(id) {
              var to = $("#" + id).data("to");
              if( typeof to == 'undefined'){
                to = lastto;
              }else lastto = to;
              var ym = to.year+''+to.month;
              $("preparetr").addClass('hiddentr');
              $.each( $("tr.listtr") , function (idx,row){
                if (ym != $(row).data('ym') ) {
                  $(row).addClass('hiddentr');
                }
                else {
                  $(row).removeClass('hiddentr');
                }
                if( idx == lengtr) changecomplete();
              });
              $("#loanselect option:eq(0)").attr("selected", "selected");
          }
          function changeselect(){
            var iid= $("#loanselect option:selected").val();
            if (iid=="") {
              myNavFunction("my-calendar");
              return;
            }
            else if( $.inArray(iid*1 , prepare) >= 0) {
              $("tr.listtr").addClass('hiddentr');
              $("tr.preparetr").removeClass('hiddentr');
              console.log("prepare");
              return;
            }else $("preparetr").addClass('hiddentr');

            $.each( $("tr.listtr") , function (idx,row){
              if (iid != $(row).data('loan') ) $(row).addClass('hiddentr');
              else $(row).removeClass('hiddentr');
            });
          }
            </script>
<!-- 태기 -->
<div style="margin-top:20px;" class="my_condition">
  <div style="text-align:right;padding-right:20px;">
    <select name="loanid" id="loanselect" class="form-control" style="font-size:14px;" onchange="changeselect()">
      <option value="">상품별</option>
    </select>
  </div>
  <table id='detailcal' class="table_green">
    <colgroup>
      <col width='90px' />
      <col width='250px'/>
      <col width='50px' />
      <col width='90px' />
      <col width='90px' />
      <col width='90px' />
      <col width='90px' />
      <col width='90px' />
    </colgroup>
    <thead>
      <tr><th>일자</th><th>상품명</th><th>상태</th><th>상환원금</th><th>이자</th><th>수수료</th><th>세금</th><th>(예상)입금액</th></tr>
    </thead>
    <tbody>
      <tr class="preparetr hiddentr"><td colspan="8" style="text-align:center;padding:20px;">현재 계약 진행중인 상품입니다.</td></tr>
    </tbody>
  </table>
</div>

</div><!--dashboard_interest-->
<div class="my_condition" style="margin-bottom:30px;">
  <div id="prepareloan">
  <div class="title" style="padding-left:20px">계약 진행중인 상품</div>
  <div id="prepareloanbody"><div style="text-align:center">계약 진행중인 상품이 없습니다.</div></div>
  </div>
</div>
<!-- / 태기 -->


						<ul class="list_dot">
							<li>원금균등상환 및 원리금균등상환의 납입원금 및 이자금액은 정산금액과 상이할 수 있습니다.</li>
							<li>이 점 양해바랍니다.</li>
						</ul>
					</div>
					<!-- // 투자 관리 end -->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->

{# new_footer}
