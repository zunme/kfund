<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="/api/statics/materialtemplate/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="/api/statics/materialtemplate/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>케이펀딩</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />

	<!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

	<!-- CSS Files -->

    <link href="/api/statics/materialtemplate/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/api/statics/materialtemplate/assets/css/material-kit2.css?v=1.2.1.3" rel="stylesheet"/>
		<link href="/api/statics/js/hover-min.css" rel="stylesheet"/>
		<link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet">
<style>

.bmd-label-floating, .bmd-label-placeholder {
    top: 2.3125rem;
}
.bmd-form-group .form-control, .bmd-form-group label, .bmd-form-group input::-webkit-input-placeholder {
    line-height: 1.1;
}
.bmd-form-group .form-control, .bmd-form-group label, .bmd-form-group input::placeholder {
    line-height: 1.1;
}
.bmd-form-group label {
    color: #aaa;
}
.bmd-form-group .checkbox label, .bmd-form-group .radio label, .bmd-form-group label {
    font-size: .875rem;
}
.bmd-form-group [class^='bmd-label'], .bmd-form-group [class*=' bmd-label'] {
    position: absolute;
    pointer-events: none;
    -webkit-transition: .3s ease all;
    transition: .3s ease all;
}
.bmd-form-group .bmd-label-floating, .bmd-form-group .bmd-label-placeholder {
    top: 2.3125rem;
}
.bmd-form-group [class^='bmd-label'].bmd-label-floating, .bmd-form-group [class*=' bmd-label'].bmd-label-floating {
    will-change: left,top,contents;
    margin: 0;
    line-height: 1.4;
    font-weight: 400;
}
.bmd-form-group .bmd-label-floating{
  top:-2rem;left:0;font-size: .6875rem;    padding-left: 10px;
}
.bmd-form-group.roundbox{
  border: 1px solid #999;
    border-radius: 10px;
    padding: 10px;
}
.bmd-form-group:not(.has-success):not(.has-danger) [class^='bmd-label'].bmd-label-floating, .bmd-form-group:not(.has-success):not(.has-danger) [class*=' bmd-label'].bmd-label-floating {
    color: #aaa;
}
.bmd-form-group{
  margin-bottom: 30px;
}
.whitebox {max-width:350px;background-color: white; padding:30px;border-radius: 30px;}




.card .card-header-primary, .card.bg-primary, .card.card-rotate.bg-primary .front, .card.card-rotate.bg-primary .back {
    background: linear-gradient(60deg,#ab47bc,#7b1fa2);
}
.card .card-header-primary {
    -webkit-box-shadow: 0 5px 20px 0 rgba(0,0,0,0.2), 0 13px 24px -11px rgba(156,39,176,0.6);
    box-shadow: 0 5px 20px 0 rgba(0,0,0,0.2), 0 13px 24px -11px rgba(156,39,176,0.6);
}
.sms_remain_div{
	font-size: 1.2rem;
    text-align: right;
}
.sms_remain_div span{padding: 0 2px;}
</style>
</head>

<body>
  <section class="section section-gray">
    <div class="">

      <div class="row">
        <div class="col-md-5">

          <form name="ajaxform">
            <input type="hidden" name="sendtype" value="">
            <input type="hidden" name="loanid" value="">
        <!-- first box-->
            <div class="container whitebox">
              <div class="sms_remain_div">
								<div>
									<span>남은갯수</span>
									<span id="SMS_CNT">SMS()</span>
									<span id="LMS_CNT">LMS()</span>
									<span id="MMS_CNT">MMS()</span>
								</div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group label-floating bmd-form-group roundbox">
                            <label class="form-control-label bmd-label-floating" for="exampleInputTextarea"> 문자 내용을 적어주세요&nbsp;&nbsp;<span id="msg_chkgt"></span></label>
                            <textarea class="form-control" rows="5" name="msg" id="msg" onkeyup="updateChar(80, 'msg', 'msg_chkgt');"></textarea>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group label-floating bmd-form-group" style="background-color: #737373;color: #FFF;padding:10px;">
                            <label class="form-control-label bmd-label-floating" for="exampleInputTextarea"> 받는전화번호 (번호만입력해주세요)</label>
                            <!--input type="text" name="selecttitle" value="" style="background-color: #737373;border:0;display:none;" readonly -->
                            <textarea class="form-control" rows="5" name="phonenum" id="phonenum" style="color:#FFF" readonly></textarea>
														<div id="displaycont" style="text-align: left;">
														</div>
                        </div>
                    </div>
                </div>
                <div style="text-align:center">
                  <a class="btn btn-primary" href="javascript:;" onClick="checksmsform()">문자보내기</a>
                </div>
              </div>
            </div>
          </form>
        <!-- / first box-->
        </div>
        <div class="col-md-7">
          <div class="container" style="max-width:550px;background-color:white;">
        <!-- second box -->
              <div class="card card-nav-tabs">
                <div style="text-align:right;margin-bottom:10px;">
                  <span > <input type="radio" name="receipt" value="A">모든회원&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="receipt" value="Y" checked="checked">동의회원</span>
                </div>
                  <div class="card-header card-header-primary">
                      <!-- colors: "header-primary", "header-info", "header-success", "header-warning", "header-danger" -->
                      <div class="nav-tabs-navigation">
                          <div class="nav-tabs-wrapper">
                              <ul class="nav nav-tabs" data-tabs="tabs">
                                  <li class="nav-item active">
                                      <a class="nav-link active" href="#profile" data-toggle="tab">
                                          <i class="material-icons">group</i> 그룹목록
                                      </a>
                                  </li>
                                  <li class="nav-item">
                                      <a class="nav-link" href="#messages" data-toggle="tab">
                                          <i class="material-icons">person</i> 유저검색
                                      </a>
                                  </li>
                                  <li class="nav-item">
                                      <a class="nav-link" href="#settings" data-toggle="tab">
                                          <i class="material-icons">move_to_inbox</i> 상품별
                                      </a>
                                  </li>
                              </ul>
                          </div>
                      </div>
                  </div>
                  <div class="card-body ">
                      <div class="tab-content ">
                            <div class="tab-pane active" id="profile">
                                <div style="padding:10px 50px;">
                                    <p><input class="form-check-input" type="radio" name="membertype" value="generalperson" data-title="일반회원"> 일반회원</p>
                                    <p><input class="form-check-input" type="radio" name="membertype" value="tujaperson" data-title="투자회원"> 투자회원</p>
                                    <p><input class="form-check-input" type="radio" name="membertype" value="loanperson" data-title="대출회원"> 대출회원</p>
                                    <p><input class="form-check-input" type="radio" name="membertype" value="person" data-title="개별보내기"> 개별보내기</p>
                                </div>

                            </div>
                            <div class="tab-pane" id="messages">

                              <div class="input-group" style="margin-right: 100px;">
                								<span class="input-group-addon">
                									<i class="material-icons">person</i>
                								</span>
                								<div class="form-group is-empty"><input type="text" name="usersearch" class="form-control" placeholder="With Material Icons"><span class="material-input"></span></div>

                							</div>
                              <a class="btn btn-info btn-sm" style="display: inline-block;top: -53px;float: right;" href="javascript:;" onClick="user()">검색</a>

                              <div id="searcheduser" style="padding:10px">
                                <table width=100%>
																	<thead>
																		<tr><th>이메일</th><th>이름</th><th>전화번호</th><th>동의</th></tr>
																	</tehad>
																	<tbody id="searchuserbody">
																</tbody>

                                </table>
                              </div>
                            </div>


                            <div class="tab-pane" id="settings">
                              <div class="input-group" style="margin-right: 100px;">
                                <span class="input-group-addon">
                                  <i class="material-icons">move_to_inbox</i>
                                </span>
                                <div class="form-group is-empty"><input type="text" name="searchloan" class="form-control" placeholder="상품검색"><span class="material-input"></span></div>

                              </div>
                              <a class="btn btn-info btn-sm" style="display: inline-block;top: -53px;float: right;" href="javascript:;" onClick="loan()">검색</a>
															<style>
															#searchloanbody tr{border-bottom: 1px solid #AAA;}
															#searchloanbody td{
																padding: 3px;
															}
															</style>
                              <div id="searchedprd" style="padding:10px">
                                <table width=100%>
																	<tbody id="searchloanbody">
																	<tbody>
                                </table>
                              </div>

                            </div>
                      </div>
                  </div>
              </div>
        <!-- / second box -->
          </div>
        </div>
      </div>
    </div>
		<div>
			<div class="row" style="padding:10px 30px;">
				<div class="col-md-12" style="border-radius:10px;background-color:white;padding:20px">
					<style>
					#smslisttable tbody tr{    border-bottom: 1px solid #aaa;}
					#smslisttable tbody td{padding:5px;}
					</style>
					<a href="javascript:;" onClick="smslist(1)" style="font-size: 1.6rem;padding: 3px 30px;color: white;background-color: #0069c0;display: inline-block;margin-left: 30px;">최근 전송기록</a>
					<table id="smslisttable" width=100%>
						<thead>
							<tr>
									<th style="width: 100px;">성공건수</th>
									<th style="width: 100px;">실패건수</th>
									<th>메세지</th>
									<th style="width: 180px;">시간</th>
							</tr>
						</thead>
						<tbody id="smslist">
						</tbody>
					</table>
				</div>
			</div>

		</div>

  </section>
	<!--    loader image-->
	<style>
	.ajax-loader {
		display:none;
	  background-color: rgba(255,255,255,0.7);
	  position: absolute;
	  z-index: +100 !important;
	  width: 100%;
	  height:100%;
		top:0;
	}

	.ajax-loader img {
	  position: relative;
	  top:50%;
	  left:50%;
	}
	</style>
	<style>
	.spinner {
		position: relative;
		top:50%;
		left:50%;
	  -webkit-animation: rotator 1.4s linear infinite;
	          animation: rotator 1.4s linear infinite;
	}

	@-webkit-keyframes rotator {
	  0% {
	    -webkit-transform: rotate(0deg);
	            transform: rotate(0deg);
	  }
	  100% {
	    -webkit-transform: rotate(270deg);
	            transform: rotate(270deg);
	  }
	}

	@keyframes rotator {
	  0% {
	    -webkit-transform: rotate(0deg);
	            transform: rotate(0deg);
	  }
	  100% {
	    -webkit-transform: rotate(270deg);
	            transform: rotate(270deg);
	  }
	}
	.path {
	  stroke-dasharray: 187;
	  stroke-dashoffset: 0;
	  -webkit-transform-origin: center;
	          transform-origin: center;
	  -webkit-animation: dash 1.4s ease-in-out infinite, colors 5.6s ease-in-out infinite;
	          animation: dash 1.4s ease-in-out infinite, colors 5.6s ease-in-out infinite;
	}

	@-webkit-keyframes colors {
	  0% {
	    stroke: #4285F4;
	  }
	  25% {
	    stroke: #DE3E35;
	  }
	  50% {
	    stroke: #F7C223;
	  }
	  75% {
	    stroke: #1B9A59;
	  }
	  100% {
	    stroke: #4285F4;
	  }
	}

	@keyframes colors {
	  0% {
	    stroke: #4285F4;
	  }
	  25% {
	    stroke: #DE3E35;
	  }
	  50% {
	    stroke: #F7C223;
	  }
	  75% {
	    stroke: #1B9A59;
	  }
	  100% {
	    stroke: #4285F4;
	  }
	}
	@-webkit-keyframes dash {
	  0% {
	    stroke-dashoffset: 187;
	  }
	  50% {
	    stroke-dashoffset: 46.75;
	    -webkit-transform: rotate(135deg);
	            transform: rotate(135deg);
	  }
	  100% {
	    stroke-dashoffset: 187;
	    -webkit-transform: rotate(450deg);
	            transform: rotate(450deg);
	  }
	}
	@keyframes dash {
	  0% {
	    stroke-dashoffset: 187;
	  }
	  50% {
	    stroke-dashoffset: 46.75;
	    -webkit-transform: rotate(135deg);
	            transform: rotate(135deg);
	  }
	  100% {
	    stroke-dashoffset: 187;
	    -webkit-transform: rotate(450deg);
	            transform: rotate(450deg);
	  }
	}
	</style>
	<div class="ajax-loader">
  	<!--img src="{{ url('guest/images/ajax-loader.gif') }}" class="img-responsive" /-->
		<svg class="spinner" width="65px" height="65px" viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
		   <circle class="path" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="30"></circle>
		</svg>
  </div>
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
	<!--    loader image-->
</body>
<style>
 .simpletddiv1{
	 cursor: pointer;
	 overflow: hidden;
    position: relative;
    z-index: 5;
    padding: 30px 0 23px;
    border-bottom: 1px solid #f1f1f1;
    zoom: 1;
 }
 .simpletddiv1.opened {
    margin: -1px 0 0 0;
    padding-right: 30px;
    padding-left: 30px;
    border: 1px solid #e8e9e9;
    background-color: #fcfdfd;
}
 .simpletddiv2{

 }
 .simpletddiv3{
	 overflow: hidden;
    margin-top: 3px;
    max-height: 110px;
    font-size: 13px;
    line-height: 22px;
    color: #666;
    word-break: break-all;
 }
 .simpletddiv1.opened .simpletddiv3 {
     max-height: none;
 }
 .simpletddiv1.opened .simpletddiv3 {
    padding-right: 0;
    min-height: auto;
 }
</style>
	<!--   Core JS Files   -->
	<script src="/api/statics/materialtemplate/assets/js/jquery.min.js" type="text/javascript"></script>
	<script src="/api/statics/materialtemplate/assets/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/api/statics/materialtemplate/assets/js/material.min.js"></script>

	<!--    Plugin for Date Time Picker and Full Calendar Plugin   -->
	<script src="/api/statics/materialtemplate/assets/js/moment.min.js"></script>

	<!--	Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/   -->
	<script src="/api/statics/materialtemplate/assets/js/nouislider.min.js" type="text/javascript"></script>

	<!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker   -->
	<script src="/api/statics/materialtemplate/assets/js/bootstrap-datetimepicker.js" type="text/javascript"></script>

	<!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select   -->
	<script src="/api/statics/materialtemplate/assets/js/bootstrap-selectpicker.js" type="text/javascript"></script>

	<!--	Plugin for Tags, full documentation here: http://xoxco.com/projects/code/tagsinput/   -->
	<script src="/api/statics/materialtemplate/assets/js/bootstrap-tagsinput.js"></script>

	<!--	Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput   -->
	<script src="/api/statics/materialtemplate/assets/js/jasny-bootstrap.min.js"></script>

	<!--	Plugin for Product Gallery, full documentation here: https://9bitstudios.github.io/flexisel/ -->
	<script src="/api/statics/materialtemplate/assets/js/jquery.flexisel.js"></script>

	<!--    Control Center for Material Kit: activating the ripples, parallax effects, scripts from the example pages etc    -->
	<script src="/api/statics/materialtemplate/assets/js/material-kit2.js?v=1.2.1" type="text/javascript"></script>
	<!--script src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js?v=20180105110142" type="text/javascript"></script-->

  <script>
  var cleared = false;
  function updateChar(FieldName, contentName, textlimitName){
  	var strCount = 0;
  	var tempStr, tempStr2;
  	var frm = document.getElementById(contentName);
  	var size = frm.value.length;
  	for(i = 0;i < size;i++){
  		tempStr = frm.value.charAt(i);
  		if(escape(tempStr).length > 4) strCount += 2;
  		else strCount += 1 ;
  	}
  	document.getElementById(textlimitName).innerHTML = "("+strCount+"byte"+")";
    if( strCount>80){
      $("#"+textlimitName).addClass("text-danger");
    }else {
      $("#"+textlimitName).removeClass("text-danger");
    }

  }
  function clearform() {
    $("input[name=sendtype]").val('');
    $("#phonenum").val('');
    $("#phonenum").attr("readonly", true);
    $("#phonenum").hide();
    $("#displaycont").text('');
    $("#displaycont").hide();
  }
  function changeform(val,title,idx){
    if(val=='person'){
      clearform();
      $("#phonenum").attr("readonly", false);
      $("#phonenum").show();
      cleared = true;
    }else if (val=='generalperson' || val=='tujaperson' || val=='loanperson') {
      clearform();
      $("#displaycont").text(title + "에게 보내기");
      $("#displaycont").show();
      cleared = false;
    }else if(val=='loan'){
      clearform();
      $("input[name=loanid]").val(idx);
      $("#displaycont").text(title);
      $("#displaycont").show();
      cleared = false;
    }else if(val=='adddata'){
      if( !cleared) {
        clearform();
        $("#phonenum").attr("readonly", false);
        $("#phonenum").show();
        $('input:radio[name=membertype]:input[value=person]').attr("checked", true);
      }
			 if( $("#phonenum").val().trim() =='' ){
				$("#phonenum").val( idx );
			 }else {
        $("#phonenum").val( $("#phonenum").val().trim() + "\n" + idx );
			 }
      cleared = true;

    }
    $("input[name=sendtype]").val(val);
  }
  function adddata(target){
    console.log($(target).data('hp'));
    changeform('adddata', '', $(target).data('hp'));
  }
  function addloan(target){
    console.log($(target).data('idx'));
    changeform('loan', $(target).parent().parent().children("td:first").text(), $(target).data('idx'));
  }

  function checksmsform() {
		var data = $('form[name=ajaxform]').serializeArray();
		data.push({'name':'receipt','value':$('input:radio[name=receipt]:checked').val()});
		$.ajax({
           type:"POST",
           url:"/api/index.php/aligo/sendsms",
           dataType:"JSON",
					 data : $.param(data),
					 beforeSend : function() {
						$('.ajax-loader').show();
					 },
           success : function(data) {
						 if(data.result_code == 1){
							 if(confirm(data.message)){
								 realsend();
							 }
						 }else alert( data.message);
           },
					 complete: function(){
						$('.ajax-loader').hide();
					 },
           error : function(xhr, status, error) {
                 alert("에러발생");
           }
     });
  }

	function realsend() {
		var data = $('form[name=ajaxform]').serializeArray();
		data.push({'name':'receipt','value':$('input:radio[name=receipt]:checked').val()});
		data.push({'name':'confirm','value':'Y'});
		$.ajax({
           type:"POST",
           url:"/api/index.php/aligo/sendsms",
           dataType:"JSON",
					 data : $.param(data),
					 beforeSend : function() {
						$('.ajax-loader').show();
					 },
           success : function(data) {
						 alert( data.message);
           },
					 complete: function(){
						$('.ajax-loader').hide();
						remaincheck();
						setTimeout( remaincheck(), 2000);
						setTimeout( smslist(1), 2000);
					 },
           error : function(xhr, status, error) {
                 alert("에러발생");
           }
     });
  }
	function remaincheck() {
		$.ajax({
					 type:"GET",
					 url:"/api/index.php/aligo/remain",
					 dataType:"JSON",
					 success : function(data) {
						 $("#SMS_CNT").text("SMS("+data.SMS_CNT+")");
						 $("#LMS_CNT").text("LMS("+data.LMS_CNT+")");
						 $("#MMS_CNT").text("MMS("+data.MMS_CNT+")");
						 if( data.SMS_CNT < 1000) alert("충전이 필요할 수 있습니다.");
					 },
					 error : function(xhr, status, error) {
						 	;
					 }
		 });
	}
	function opened(target){
		if ( $(target).hasClass('opened') ) $(target).removeClass('opened');
		else $(target).addClass('opened');
		console.log( $(target).hasClass('opened') );
	}
	function smslist(page) {
		$("#smslist").empty();
		$.ajax({
					 type:"GET",
					 url:"/api/index.php/aligo/smslist",
					 dataType:"JSON",
					 data : {page:page},
					 success : function(data) {
						 	$.each(data.list ,function(kev,val){
							//if(val.reserve_state !='취소완료')
								$("#smslist").append( "<tr><td>"+val.sms_count+"</td><td>"+val.fail_count+"</td><td><div class='simpletddiv1' onClick='opened(this)'><div  class='simpletddiv2'><div class='simpletddiv3'>"+val.msg+"</div></div></div></td><td><a class='btn btn-sm' href='javascript:;'  onClick='getdetail("+val.mid+")' >"+val.reg_date+ (val.reserve_state !='' ? "</a><br>"+val.reserve_state:"") +"</td></tr>");
							} );
					 },
					 error : function(xhr, status, error) {
							;
					 }
		 });
	}
	function getdetail(idx){
				dynamicmodal("/api/index.php/aligo/smsdetail?smsidx="+idx,"전송기록");
				return;
		$.ajax({
					 type:"GET",
					 url:"/api/index.php/aligo/smsdetail",
					 dataType:"JSON",
					 data : {smsidx:idx},
					 success : function(data) {
						 	$.each(data.list ,function(kev,val){
							//if(val.reserve_state !='취소완료')
							;
							} );
					 },
					 error : function(xhr, status, error) {
							;
					 }
		 });
	}
	function user() {
		var search = $("input[name=usersearch]").val().trim() ;
		if(search =="" ) return;
		$("#searchuserbody").empty();
		$.ajax({
					 type:"GET",
					 url:"/api/index.php/aligo/user",
					 dataType:"JSON",
					 data : {search:search},
					 success : function(data) {
							$.each(data.list ,function(kev,val){
							//if(val.reserve_state !='취소완료')	$("#smslist").append( "<tr><td>"+val.sms_count+"</td><td>"+val.fail_count+"</td><td>"+val.msg+"</td><td onClick='getdetail("+val.mid+")'>"+val.reg_date+"</td></tr>");
							$("#searchuserbody").append("<tr><td>"+val.m_id+"</td><td>"+val.m_name+"</td><td><a href='javascript:;' onClick='adddata(this)' data-hp='"+val.trimed_hp+"'>"+val.trimed_hp+"</a></td><td>"+ ((val.sb_receipt == 1) ? "동의":"거부") +"</td></tr>");
							;
							} );
					 },
					 error : function(xhr, status, error) {
							;
					 }
		 });
	}
	function loan() {
		var search = $("input[name=searchloan]").val().trim() ;
		if(search =="" ) return;
		$("#searchloanbody").empty();
		$.ajax({
					 type:"GET",
					 url:"/api/index.php/aligo/loan",
					 dataType:"JSON",
					 data : {search:search},
					 success : function(data) {
							$.each(data.list ,function(kev,val){
							$("#searchloanbody").append("<tr><td class='loantitle'>"+val.i_subject+"</td> <td><a href='javascript:;' onClick='addloan(this)' data-idx='"+val.i_id+"' style='width: 60px;'>보내기</a></td></tr>");
							} );
					 },
					 error : function(xhr, status, error) {
							;
					 }
		 });
	}
	function dynamicmodal(url, title){
	  $('#dyModal .modal-title').text(title);
	  $('#dyModal .modal-body').load(url,function(){
	    $('#dyModal').modal({show:true});
	  });
	}
  $(document).ready(function() {
    $("input[name=membertype]").on("change", function () {
      changeform(this.value, $(this).data('title'),0);
    });
		$('#dyModal').on('hidden.bs.modal', function () {
			$('#dyModal div.modal-body').empty();
			$('#dyModal div.modal-body').text('');
		});
		remaincheck();
		smslist(1);
  });

</script>
</html>
