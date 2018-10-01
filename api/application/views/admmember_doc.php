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

    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap/dist/css/bootstrap.min.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/font-awesome/css/font-awesome.min.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/styles.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/iCheck/skins/flat/green.css?v=20180105110142" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet">
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/build/css/custom.min.css" rel="stylesheet"-->
    <style>
    body{overflow: hidden;}
    .row{
        border-bottom: 1px solid #ccc;
    }
    .row:last-child{
        border-bottom: none;
    }
    .row .col-xs-4:nth-child(1){
      padding-top: 10px;
      padding-bottom: 10px;
    }
    .row .col-xs-4{
      padding-top: 10px;
    }
    .row .col-xs-2{
      padding-top: 15px;
    }
    input.fileupload:before {
        content: "등록";
        position:relative;
        cursor:pointer;
        display:inline-block;
        vertical-align:middle;
        overflow:hidden;
        width:100px;
        height:30px;
        background:#777;
        color:#fff;
        text-align:center;
        line-height:30px;
        margin-top: 5px;
    }
    input.fileupload {
        position:absolute;
        width:100px;
        height:35px;
        overflow:hidden;
    }
    #meminfo{
      padding: 10px 30px;
    }
    #meminfo div{
      position: relative;
      float:left;
      background-color: #69a;
      color: white;
      border-radius: 6px;
      padding:3px 6px;
      margin-left: 10px;
      margin-bottom:5px;
    }
    </style>
  </head>
  <body>

<div style="text-align:center;padding:10px;margin-bottom:10px;border-bottom:1px solid #cacaca;"><?php echo $info['m_id']?>(<?php echo $info['m_name']?>)</div>
<div class="row" id="meminfo">

</div>

<div style="padding:10px 20px; border:1px solid #cacaca;border-radius:8px;margin:10px;">
  <div class="row">
    <div class="col-xs-4">종합소득신고서<br>(사업자등록증)</div>
    <div class="col-xs-2">
      <?php if( $info['m_declaration_01'] != '' ){ ?><a id="file1_view" class="btn" href="/pnpinvest/data/file/member/<?php echo $info['m_declaration_01']?>" target="_blank">열기</a>  <?php } else {?>
        <a id="file1_view" class="btn" href="javascript:;" target="_blank"></a>
      <?php } ?>
    </div>
    <div class="col-xs-2">
      <?php if( $info['m_declaration_01'] != '' ){ ?><a class="btn" href="javascript:;"  onClick="del(this)" data-ftype="m_declaration_01">삭제</a>  <?php } ?>
    </div>
    <div class="col-xs-4">
      <div class="filebt">
        <input id="file1" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_01", "mid":"<?php echo $info['m_id']?>"}'>
      </div>

    </div>
  </div>

  <div class="row">
    <div class="col-xs-4">근로소득원천징수연수증<br>(사업자신분증)</div>
    <div class="col-xs-2">
      <?php if( $info['m_declaration_02'] != '' ){ ?><a class="btn" href="/pnpinvest/data/file/member/<?php echo $info['m_declaration_02']?>" target="_blank">열기</a>  <?php } else {?>
        <a id="file2_view" class="btn" href="javascript:;" target="_blank"></a>
      <?php } ?>
    </div>
    <div class="col-xs-2">
      <?php if( $info['m_declaration_02'] != '' ){ ?><a class="btn" href="javascript:;"  onClick="del(this)" data-ftype="m_declaration_02">삭제</a>  <?php } ?>
    </div>
    <div class="col-xs-4">
      <input id="file2" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_02", "mid":"<?php echo $info['m_id']?>"}'>
      <a class="btn" href="javascript:;">등록</a>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-4">전문업자확인증<br>(법인통장)</div>
    <div class="col-xs-2">
      <?php if( $info['m_evidence'] != '' ){ ?><a class="btn" href="/pnpinvest/data/file/member/<?php echo $info['m_evidence']?>" target="_blank">열기</a>  <?php } else { ?>
        <a id="file3_view" class="btn" href="javascript:;" target="_blank"></a>
      <?php } ?>
    </div>
    <div class="col-xs-2">
      <?php if( $info['m_evidence'] != '' ){ ?><a class="btn" href="javascript:;" onClick="del(this)" data-ftype="m_evidence" >삭제</a>  <?php } ?>
    </div>
    <div class="col-xs-4">
      <input id="file3" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_evidence", "mid":"<?php echo $info['m_id']?>"}'>
      <a class="btn" href="javascript:;">등록</a>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-4">대부업자등록증<br>&nbsp;</div>
    <div class="col-xs-2">
      <?php if( $info['m_bill'] != '' ){ ?><a class="btn" href="/pnpinvest/data/file/member/<?php echo $info['m_bill']?>" target="_blank">열기</a>  <?php } else {?>
        <a id="file4_view" class="btn" href="javascript:;" target="_blank"></a>
      <?php } ?>
    </div>
    <div class="col-xs-2">
      <?php if( $info['m_bill'] != '' ){ ?><a class="btn" href="javascript:;" onClick="del(this)" data-ftype="m_bill" >삭제</a>  <?php } ?>
    </div>
    <div class="col-xs-4">
      <input id="file4" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_bill", "mid":"<?php echo $info['m_id']?>"}'>
      <a class="btn" href="javascript:;">등록</a>
    </div>
  </div>
</div>
<script type="text/javascript" src="/pnpinvest/js/jquery-1.11.0.min.js"></script>

<script src="/pnpinvest/js/jQuery-File-Upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="/assets/blueimp/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="/assets/blueimp/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-video.js"></script>
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-validate.js"></script>

<script>
function del( ln ){
  var mid = "<?php echo $info['m_id']?>";
  var ftype = $(ln).data('ftype');

  if( confirm("파일을 삭제하시겠습니까?\n삭제후에는 복구가 불가능 합니다.")){
    $.ajax({
       type : "POST",
       dataType : "json",
       url : "/api/index.php/admmember/trashfile",
       data : {'m_id':mid, 'ftype':ftype},
       success : function(result) {
         if(result.code==200){
          alert ( result.msg );
         }else {
           alert ( result.msg );
         }
       },
       error : function(e) {
              alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
       }
    });
  }
}
$(function () {
'use strict';
var userlist ="/api/index.php/adm/userlist?draw=2&columns%5B0%5D%5Bdata%5D=m_no&columns%5B0%5D%5Bname%5D=&columns%5B0%5D%5Bsearchable%5D=true&columns%5B0%5D%5Borderable%5D=true&columns%5B0%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B0%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B1%5D%5Bdata%5D=m_id&columns%5B1%5D%5Bname%5D=&columns%5B1%5D%5Bsearchable%5D=true&columns%5B1%5D%5Borderable%5D=true&columns%5B1%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B1%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B2%5D%5Bdata%5D=m_name&columns%5B2%5D%5Bname%5D=&columns%5B2%5D%5Bsearchable%5D=true&columns%5B2%5D%5Borderable%5D=true&columns%5B2%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B2%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B3%5D%5Bdata%5D=m_hp&columns%5B3%5D%5Bname%5D=&columns%5B3%5D%5Bsearchable%5D=true&columns%5B3%5D%5Borderable%5D=true&columns%5B3%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B3%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B4%5D%5Bdata%5D=virtualacc&columns%5B4%5D%5Bname%5D=&columns%5B4%5D%5Bsearchable%5D=true&columns%5B4%5D%5Borderable%5D=false&columns%5B4%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B4%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B5%5D%5Bdata%5D=m_verifyaccountuse&columns%5B5%5D%5Bname%5D=&columns%5B5%5D%5Bsearchable%5D=true&columns%5B5%5D%5Borderable%5D=false&columns%5B5%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B5%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B6%5D%5Bdata%5D=m_emoney&columns%5B6%5D%5Bname%5D=&columns%5B6%5D%5Bsearchable%5D=true&columns%5B6%5D%5Borderable%5D=true&columns%5B6%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B6%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B7%5D%5Bdata%5D=payed&columns%5B7%5D%5Bname%5D=&columns%5B7%5D%5Bsearchable%5D=true&columns%5B7%5D%5Borderable%5D=true&columns%5B7%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B7%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B8%5D%5Bdata%5D=memlabel&columns%5B8%5D%5Bname%5D=&columns%5B8%5D%5Bsearchable%5D=true&columns%5B8%5D%5Borderable%5D=false&columns%5B8%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B8%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B9%5D%5Bdata%5D=m_referee&columns%5B9%5D%5Bname%5D=&columns%5B9%5D%5Bsearchable%5D=true&columns%5B9%5D%5Borderable%5D=false&columns%5B9%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B9%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B10%5D%5Bdata%5D=m_sms&columns%5B10%5D%5Bname%5D=&columns%5B10%5D%5Bsearchable%5D=true&columns%5B10%5D%5Borderable%5D=false&columns%5B10%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B10%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B11%5D%5Bdata%5D=authed&columns%5B11%5D%5Bname%5D=&columns%5B11%5D%5Bsearchable%5D=true&columns%5B11%5D%5Borderable%5D=false&columns%5B11%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B11%5D%5Bsearch%5D%5Bregex%5D=false&order%5B0%5D%5Bcolumn%5D=0&order%5B0%5D%5Bdir%5D=desc&start=0&length=5&search%5Bregex%5D=false&search%5Bvalue%5D=<?php echo urlencode($info['m_id'])?>";
$.ajax({
   type : "GET",
   dataType : "json",
   url : userlist,
   success : function(result) {
     var info = result.data[0];
     $("#meminfo").append("<div>등급:"+info.memlabel+"</div>");
     $("#meminfo").append("<div>사용확인:"+info.authed+"</div>");
     $("#meminfo").append("<div>전화번호:"+info.m_hp+"</div>");
     $("#meminfo").append("<div>가상계좌:("+info.virtualacc+") "+info.s_accntNo+" "+info.s_bnkCd+"</div>");
     $("#meminfo").append("<div>계좌:("+info.m_verifyaccountuse+") "+info.m_my_bankacc+" "+info.m_my_bankcode+" "+info.m_my_bankname+"</div>");
   },
   error : function(e) {
          alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
   }
});


var url='/api/admmember/officefile';
$('.fileupload').fileupload({
        url: url,
        dataType: 'json',
        autoUpload: true,
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png|pdf)$/i,
        maxFileSize: 99900000,
        // Enable image resizing, except for Android and Opera,
        // which actually support image resizing, but fail to
        // send Blob objects via XHR requests:
        disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
        previewMaxWidth: 100,
        previewMaxHeight: 100,
        previewCrop: true
    }).on('fileuploadadd', function (e, data) {
        data.context = $('<div/>').appendTo('#files');
    }).on('fileuploadprocessalways', function (e, data) {
        var index = data.index,
         file = data.files[index],
         node = $(data.context.children()[index]);
        if (file.error) {
            alert(file.error);
        }
    }).on('fileuploadprogressall', function (e, data) {
      console.log('fileuploadprogressall..');
    }).on('fileuploaddone', function (e, data) {
        $.each(data.result.files, function (index, file) {
            if (file.error) {
                alert (file.error);
            }else {
              var inputid = data.fileInput.context.getAttribute('id');
              alert("서류를 등록하였습니다.");
              $("#"+inputid+"_view").attr("href", "/pnpinvest/data/file/member/"+file.name);
              $("#"+inputid+"_view").text("보기");
            }
        });
    }).on('fileuploadfail', function (e, data) {
      console.log('fileuploadfail');

    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');

});
</script>


</body>
</html>
