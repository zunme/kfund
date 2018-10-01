<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# new_header}
<!-- start -->
<style>
body{
  width: 100vw;
}
.header-filter[filter-color="center_gradient"]:after {
  background: -moz-linear-gradient(left, rgba(0, 105, 120, .4) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(52, 192, 205, .4) 100%); /* FF3.6-15 */
  background: -webkit-linear-gradient(left, rgba(0, 105, 120, .4) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(52, 192, 205, .4) 100%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to right,rgba(0, 105, 120, .4) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(52, 192, 205, .4) 100%);/* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#006978', endColorstr='#34c0cd',GradientType=1 ); /* IE6-9 */
}
#pageheader{
  width:100vw;
  #background-image: url('/assets/img/mainbg_0705.jpg');
  background-position: center right;background-size: cover;
  background-color: #083d90;
}
.page-header.header-small {
    height: 240px;
    min-height: 240px;
}
#pageheader .header-title{
  position: absolute;
      margin-top: 96px;
      width: 100%;
      text-align: center;
      font-size: 30px;
      z-index: 30;
      color: #cacaca;
}
.card_wrap{
  max-width:370px;
  width:90%;
  margin: 30px auto;
}
.card{
  margin-top: -120px;
  z-index: 100;
}
.card_head{
  height: 150px;
    background-color: #0095a8;
    border-top-right-radius: 10px;
    border-top-left-radius: 10px;
}
.card {
  border-radius: 10px;
}
.card_body{
      min-height: 300px;
}
.avatar{
  position: relative;
    width: 100%;
    height: 35px;
}
.avatar_circle{
  width: 70px;
height: 70px;
border-radius: 50%;
/* border: 1px solid #028d9a; */
padding-top: 10px;
padding-left: 18px;
background-color: white;
position: absolute;
top: -35px;
left:50%;
transform: translateX(-50%);
color: #78909c;
font-size: 40px;
}
.btn-sm i.material-icons{ font-size:25px;}
#card-title{
  text-align: center;
font-size: 20px;
color: white;
padding-top: 52px;
}
.btn-group2{
  padding:0px 30px;
}
.grpbtn{
  /*
  width:49.9%;
  position: relative;
  float: left;
  padding: 5px 10px;
  background-color: #00bcd4;
  color: #e0e0e0;
  border-top:1px solid #00bcd4;
  border-bottom:1px solid #00bcd4;
  border-left:1px solid #00bcd4;
  */
  width: 49.9%;
    position: relative;
    float: left;
    padding: 5px 10px;
    background-color: #61a6b1;
    color: #dadada;
    border-top: 1px solid #61a6b1;
    border-bottom: 1px solid #61a6b1;
    border-left: 1px solid #61a6b1;
}
.grpbtn:hover{
  background-color:#55acee;
  color: #FFF;
}
.grpbtn:first-child{
  border-top-left-radius: 60px;
  border-bottom-left-radius: 60px;
  border-right:1px solid white;
  text-align:left;
}
.grpbtn:last-child{
  border-right:none;
  border-top-right-radius: 60px;
  border-bottom-right-radius: 60px;
  text-align:right;
}
.grpbtn.on{
  color: #fff;
  background-color: #008ba3 !important;
  border-color: #008ba3;
}

.grpbtn i.fas {
  font-size:14px;
  padding: 8px;
  border-radius: 50%;
  #background-color: #00bcd4;
  background-color:#4498a7;
}
.grpbtn.on i.fas
{
  background-color:#0976b4;
}
.contents{
  padding:15px 20px;
}
.input-wrap{
  padding: 30px 15px;
}
.ncol{
  padding-left: 8px;
  padding-right: 8px;
}

.form-group.is-focused .form-control {
    background-image: linear-gradient(#008ba3, #0095a8), linear-gradient(#D2D2D2, #D2D2D2);
  }


  .find-c-head{
    text-align: center;
    font-size: 18px;
    margin-bottom: 10px;
    margin-top: 20px;
    color: #666;
  }
  .find-c-head-sub{
    font-size: 13px;
color: #888;
  }
</style>

<div id="pageheader" class="page-header header-filter clear-filter header-small " data-parallax="false" filter-color="center_gradient">
  <div class="header-title">아이디 / 비밀번호 찾기</div>
</div>

<div class="container_wrap">

  <div class="container">

    <div class="row">
      <div class="card_wrap">
        <div class="card">
          <div class="card_head">
            <div id="card-title">비밀번호 찾기</div>
          </div>
          <div class="card_body">
            <div class="avatar">
              <div class="avatar_circle">
                <i id="avatarimg" class="fas fa-user"></i>
              </div>
            </div>

            <div class="btn-group2 row">
              <div class="btn grpbtn" data-btntype="find-id">
                  <i class="fas fa-user"></i> <span style="padding-left:10px;">아이디찾기</span>
              </div>
              <div class="btn grpbtn on" data-btntype="find-pwd">
                  <span style="padding-right:10px;">비밀번호찾기</span> <i class="fas fa-key"></i>
              </div>
            </div>

            <div class="contents">
              <div id="find-id"  style="display:none">
                <div class="find-c-head">회원정보에 등록한 휴대전화로 인증</div>
                <div class="find-c-head-sub">회원정보에 등록한 이름, 휴대전화 번호와 입력한 이름과 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다</div>
                <!--div class="row">
                  <div class="col-xs-4 ncol">
                    <div class="form-group label-floating is-empty">
                    	                        <label class="control-label search_label">이름</label>
                    	                        <input type="text" name="search" value="" class="form-control">
                    	                        <span class="material-input"></span>
                    	                      <span class="material-input"></span><span class="material-input"></span></div>
                  </div>
                  <div class="col-xs-4 ncol">
                    <div class="form-group label-floating is-empty">
                    	                        <label class="control-label search_label">휴대전화번호</label>
                    	                        <input type="text" name="search" value="" class="form-control">
                    	                        <span class="material-input"></span>
                    	                      <span class="material-input"></span><span class="material-input"></span></div>
                  </div>
                  <div class="col-xs-4 ncol" style="margin-top: 28px;"><a class="btn" style="padding: 5px 8px;">인증번호받기</a></div>
                </div-->

<form class="input-wrap" name="find-id-form">
                <div class="row">
                  <div class="col-xs-4" style="margin-top:12px">
                    이름
                  </div>
                  <div class="col-xs-8">
                    <div class="form-group label-floating is-empty" style="margin-top:0">
                      <label class="control-label search_label">이름입력</label>
                      <input type="text" name="m-name" value="" class="form-control">
                      <span class="material-input"></span>
                      <span class="material-input"></span><span class="material-input"></span>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-xs-4" style="margin-top:12px">
                    휴대전화
                  </div>
                  <div class="col-xs-8">
                    <div class="form-group label-floating is-empty" style="margin-top:0">
                      <label class="control-label search_label">휴대전화번호 입력</label>
                      <input type="text" name="m-hp" value="" class="form-control">
                      <span class="material-input"></span>
                      <span class="material-input"></span><span class="material-input"></span>
                    </div>
                  </div>
                </div>
                <div class="row" style="margin: 20px 0 0px;">
                  <div class="col-xs-6 col-xs-offset-1">
                    <div class="form-group label-floating is-empty" style="margin-top:0">
                      <label class="control-label search_label">인증번호 입력</label>
                      <input type="text" name="m-confirm" value="" class="form-control">
                      <span class="material-input"></span>
                      <span class="material-input"></span><span class="material-input"></span>
                    </div>
                  </div>
                  <div class="col-xs-4 ncol"><a href="javascript:;" onClick="sendconfirmid()" class="btn" style="padding: 5px 8px;">인증번호받기</a></div>
                </div>
</form>
<div class="center">
  <a class="btn" href="javascript:;" onClick="confirmid()">다음</a>
</div>
              </div>


              <div id="find-pwd">
                  <div class="find-c-head">회원정보에 등록한 휴대전화로 인증</div>
                  <div class="find-c-head-sub">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다</div>

                <form class="input-wrap" name="find-pw-form">
                  <div class="row">
                    <div class="col-xs-4" style="margin-top:12px">
                      E-mail
                    </div>
                    <div class="col-xs-8">
                      <div class="form-group label-floating is-empty" style="margin-top:0">
                        <label class="control-label search_label">이메일 아이디 입력</label>
                        <input type="text" name="m_id" value="" class="form-control">
                        <span class="material-input"></span>
                        <span class="material-input"></span><span class="material-input"></span>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-xs-4" style="margin-top:12px">
                      휴대전화
                    </div>
                    <div class="col-xs-8">
                      <div class="form-group label-floating is-empty" style="margin-top:0">
                        <label class="control-label search_label">휴대전화번호 입력</label>
                        <input type="text" name="m_hp" value="" class="form-control">
                        <span class="material-input"></span>
                        <span class="material-input"></span><span class="material-input"></span>
                      </div>
                    </div>
                  </div>
                  <div class="row" style="margin: 20px 0 0px;">
                    <div class="col-xs-6 col-xs-offset-1">
                      <div class="form-group label-floating is-empty" style="margin-top:0">
                        <label class="control-label search_label">인증번호 입력</label>
                        <input type="text" name="m-confirm" value="" class="form-control">
                        <span class="material-input"></span>
                        <span class="material-input"></span><span class="material-input"></span>
                      </div>
                    </div>
                    <div class="col-xs-4 ncol"><a href="javascript:;" onClick="sendconfirmpw()" class="btn" style="padding: 5px 8px;">인증번호받기</a></div>
                  </div>
                </form>
                <div class="center">
                  <a class="btn" href="javascript:;" onClick="confirmpw()">다음</a>
                </div>


              </div>


              <div id="changepwd" style="display:none">
                <div class="find-c-head">비밀번호 변경하기</div>
                <div class="find-c-head-sub center">변경할 비밀번호를 입력해주세요</div>
                <form class="input-wrap" name="change-pw-form" style="margin-top:10px;">
                  <input type="hidden" name="key" id="changekey">
                  <div class="row">
                    <div class="col-xs-4" style="margin-top:12px">
                      비밀번호
                    </div>
                    <div class="col-xs-8">
                      <div class="form-group label-floating is-empty" style="margin-top:0">
                        <label class="control-label search_label">비밀번호 입력</label>
                        <input type="password" name="pass" value="" class="form-control">
                        <span class="material-input"></span>
                        <span class="material-input"></span><span class="material-input"></span>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-xs-4" style="margin-top:12px">
                      비밀번호확인
                    </div>
                    <div class="col-xs-8">
                      <div class="form-group label-floating is-empty" style="margin-top:0">
                        <label class="control-label search_label">비밀번호 확인</label>
                        <input type="password" name="pass_re" value="" class="form-control">
                        <span class="material-input"></span>
                        <span class="material-input"></span><span class="material-input"></span>
                      </div>
                    </div>
                  </div>
                </form>
                <div class="center">
                  <a class="btn btn-rose" href="javascript:;" onClick="changepw()">변경하기</a>
                </div>

              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<script>
String.prototype.escapeSpecialChars = function() {
    return this.replace(/\\n/g, "\\n")
               .replace(/\\'/g, "\\'")
               .replace(/\\"/g, '\\"')
               .replace(/\\&/g, "\\&")
               .replace(/\\r/g, "\\r")
               .replace(/\\t/g, "\\t")
               .replace(/\\b/g, "\\b")
               .replace(/\\f/g, "\\f");
};
function sendconfirmid() {
  //아이디찾기 인증번호 받기
  if (confirm ('인증번호를 받으시겠습니까?') ){
    $.ajax({
      url:"/api/findaccount/sendconfirm/id",
      type : 'POST',
      data:$("form[name=find-id-form]").serialize(),
      dataType : 'json',
       success : function(result) {
         $("#ajaxloading").hide();
         if(result.code==200){
           alert(result.msg.escapeSpecialChars());
         }else {
           alert(result.msg.escapeSpecialChars());
         }
       },
       error: function(request, status, error) {
         $("#ajaxloading").hide();
         console.log(request + "/" + status + "/" + error);
         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
       }
    });
  }
}

function confirmid() {
  //아이디 찾기 인증번호 확인
  $.ajax({
    url:"/api/findaccount/confirmid",
    type : 'POST',
    data:$("form[name=find-id-form]").serialize(),
    dataType : 'json',
     success : function(result) {
       $("#ajaxloading").hide();
       if(result.code==200){
         $("#find-id").html("<div class='find-c-head'>회원님 아이디는</div><div class='find-c-head' style='color:blue'> "+result.data+ "</div><div class='find-c-head'>입니다.</div>");
       }else {
         alert(result.msg.escapeSpecialChars());
       }
     },
     error: function(request, status, error) {
       $("#ajaxloading").hide();
       console.log(request + "/" + status + "/" + error);
       alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
     }
  });
}

function sendconfirmpw() {
  //비번찾기 인증번호 받기
  if (confirm ('인증번호를 받으시겠습니까?') ){
    $.ajax({
      url:"/api/findaccount/sendconfirm/pwd",
      type : 'POST',
      data:$("form[name=find-pw-form]").serialize(),
      dataType : 'json',
       success : function(result) {
         $("#ajaxloading").hide();
         if(result.code==200){
           alert(result.msg.escapeSpecialChars());
         }else {
           alert(result.msg.escapeSpecialChars());
         }
       },
       error: function(request, status, error) {
         $("#ajaxloading").hide();
         console.log(request + "/" + status + "/" + error);
         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
       }
    });
  }
}
function confirmpw() {
  //비번 찾기 인증번호 확인
  $.ajax({
    url:"/api/findaccount/confirmpwd",
    type : 'POST',
    data:$("form[name=find-pw-form]").serialize(),
    dataType : 'json',
     success : function(result) {
       $("#ajaxloading").hide();
       if(result.code==200){
        $("#changekey").val(result.data);
        $("input[type=text]").each( function () {
          $(this).val('');
        });
        $("input[type=password]").each( function () {
          $(this).val('');
        });
        $("#find-pwd").hide();
        $("#changepwd").show();
       }else {
         alert(result.msg.escapeSpecialChars());
       }
     },
     error: function(request, status, error) {
       $("#ajaxloading").hide();
       console.log(request + "/" + status + "/" + error);
       alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
     }
  });
}
function changepw () {
  if( $("input[name=pass]").val() == '' ){
    $("input[name=pass]").focus();
    alert('변경할 비밀번호를 입력해주세요');
    return;
  }
  if( $("input[name=pass]").val() != $("input[name=pass_re]").val() ){
    $("input[name=pass]").focus();
    alert('비밀번호가 동일하지 않습니다. 비밀번호 확인란에 변경할 비밀번호를 동일하게 한번 더 입력해주세요');
    return;
  }
  if (confirm ('비밀번호를 변경하시겠습니까?') ){
    $.ajax({
      url:"/api/findaccount/changepwd",
      type : 'POST',
      data:$("form[name=change-pw-form]").serialize(),
      dataType : 'json',
       success : function(result) {
         $("#ajaxloading").hide();
         if(result.code==200){
           alert('비밀번호를 변경하였습니다.');
           window.location.href="/pnpinvest/?mode=login";
         }else {
           alert(result.msg.escapeSpecialChars());
         }
       },
       error: function(request, status, error) {
         $("#ajaxloading").hide();
         console.log(request + "/" + status + "/" + error);
         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
       }
    });
  }

}

function changemain(btntype){
 if (btntype=="find-id"){
   $("#card-title").text('아이디 찾기');
   $("#avatarimg").attr("class", "fas fa-user");
   $("#changepwd").hide();
   $("#find-pwd").hide();
   $("#find-id").fadeIn();

 }else {
   $("#card-title").text('비밀번호 찾기');
   $("#avatarimg").attr("class", "fas fa-key");
   $("#changepwd").hide();
   $("#find-id").hide();
   $("#find-pwd").fadeIn();
 }
}
$(document).ready( function() {
  $(window).ajaxStart(function(){
			$("#ajaxloading").show();
		})
		.ajaxStop(function(){
			$("#ajaxloading").hide();
		});

  $(".grpbtn").on( "click", function() {
    if( $(this).hasClass("on")) return;
    $(".grpbtn.on").removeClass("on");
    $(this).addClass("on");
    changemain( $(this).data('btntype'));
  });
});
</script>

<!-- / end -->
{# new_footer}
