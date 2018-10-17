<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
  <script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons|Pinyon+Script|Playball" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="https://bgrins.github.io/spectrum/spectrum.css" />

 <title>메인화면 디자인</title>
 <style>
  th, td {padding:10px;}
  tr{
    border-bottom: 1px solid #aaa;
  }
  .page-header
  {
    margin: 0;
  }
 .header-filter:before, .header-filter:after, #afterdiv {
     position: absolute;
     z-index: 1;
     width: 100%;
     height: 100%;
     display: block;
     left: 0;
     top: 0;
     content: "";
 }
 .header-filter{
   position: relative;
   overflow:hidden;
 }

.colorcode{
  display: inline-block;
    width: 100px;
    height: 100px;
    position: relative;
    float: left;
}
 </style>
   <link rel="stylesheet" href="/api/statics/fileuploader/css/jquery.fileupload.css">
</head>
<body>
  <table style="    width: 500px;    margin: 10px auto;">
    <tr>
      <th>SAFETY GUIDE<br>현재금액</th>
      <td>
        <input type="text" name="safetyplan_now" id="safetyplan_now" value="<?php echo $data['nowplan']?>"><span style="padding-right:10px;">원</span>
        <a href="javascript:;" onClick="save_plan_now()" class="btn btn-info">금액저장하기</a>
      </td>
    </tr>

    <tr>
      <th>SAFETY GUIDE<br>이미지</th>
      <td>
        <div style="margin-top:10px;margin-bottom:10px;border: 1px solid #AAA;padding: 15px;border-radius: 10px;">
          <div>
            <img src="/pnpinvest/data/safetyplan/<?php echo $data['img']?>" id="safetyplan_img" width="150px">
          </div>
          <span class="btn btn-success fileinput-button">
            <i class="glyphicon glyphicon-plus"></i>
            <span>변경하기(gif,jpg,png,doc,pdf)</span>
            <!-- The file input field used as target for the file upload widget -->
            <input id="fileupload" type="file" name="userfile" multiple>
          </span>
          <div id="progress" class="progress">
              <div class="progress-bar progress-bar-success"></div>
          </div>
          <div id="files" class="files"></div>
        </div>
      </td>
    </tr>
    <tr>
      <th>로그 합계</th>
      <td id="logtotal"></td>
    </tr>
  </table>
<div class="row">
  <div class="col-xs-1"></div>
  <div class="col-xs-10">
    <table id="example2" class="display" style="width:100%">
      <colgroup>
        <col />
        <col />
        <col />
        <col />
        <col width="110px"/>
        <col />
      </colgroup>
      <thead>
            <tr>
                <th></th>
                <th>일자</th>
                <th>타입</th>
                <th>회차</th>
                <th>금액</th>
                <th>내용</th>
                <th>적용</th>
            </tr>
        </thead>
        <tbody>
            <?php
              $sum = $i= 0;
              foreach ($history as $row) {
                $sum += $row['safety'];
            ?>
          <tr>
            <td><?php echo ++$i?></td>
            <td><?php echo $row['safetydate']?></td>
            <td><?php echo $row['safety_type']?></td>
            <td><?php echo $row['o_count'] > 0 && $row['loan_id'] > 11  ? $row['o_count']."회차":""; ?></td>
            <td class="text-right <?php echo $row['confirm'] == 'N' ? 'editcol':''?>"><?php echo ($row['safety'])?></td>
            <td><?php echo $row['detail']?></td>
            <td>
              <?php
              if ( $row['confirm'] == 'N'){
              ?>
              <a href="javascript:;" class="btn btn-primary" data-historyidx="<?php echo $row['history_idx']?>" onClick="history_confirm(this)">적용하기</a>
              <?php
              }else {
                ?>
                적용완료
                <?php
              }
              ?>
            </td>
          </tr>
            <?php } ?>
        </tbody>
        <tfoot>
            <tr>
                <th colspan="4" style="text-align:right">Total:</th>
                <th style="text-align:right" id="logtotal2"></th>
                <th></th>
            </tr>
        </tfoot>
    </table>
  </div>
</div>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
	<script src="/api/statics/fileuploader/js/jquery.iframe-transport.js"></script>
	<script src="/api/statics/fileuploader/js/jquery.fileupload.js"></script>
  <script src="https://bgrins.github.io/spectrum/spectrum.js"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
  <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

  <script>
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

  function history_confirm (bt) {
    var history_idx = $(bt).data('historyidx');
    var won = $(bt).parent().parent().children('td:nth-child(5)').children("input").val();
    $.ajax({
      type : 'post',
      url : '/api/index.php/design/confirmlog',
      data:{history_idx:history_idx, won :won},
      dataType : 'json',
      success : function(result) {
        if(result.code==200){
          $(bt).parent().parent().children('td:nth-child(5)').html(won);
          $(bt).parent().html("적용완료");
          $("#safetyplan_now").val( result.data);
          $("#logtotal").html( result.total + " 원");
          $("#logtotal2").html( result.total + " 원");

        }else alert(result.msg);
      },
          error: function (jqXHR, exception) {
            ajaxerror( jqXHR, exception )
          }

    });
  }

  $(document).ready(function() {
      $('#example2').DataTable( {
        fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            $('td', nRow).on('click', function() {
                if( $(this).hasClass('editcol') ) {
                  $(this).html('<input type="text" class="safety_added" value="'+ $(this).text()+'">');
                  $(this).removeClass("editcol");
                }
            });
        },
          "footerCallback": function ( row, data, start, end, display ) {
              var api = this.api(), data;

              // Remove the formatting to get integer data for summation
              var intVal = function ( i ) {
                  return typeof i === 'string' ?
                      i.replace(/[\$,]/g, '')*1 :
                      typeof i === 'number' ?
                          i : 0;
              };

              // Total over all pages
              total = api
                  .column( 4 )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );

              // Total over this page
              pageTotal = api
                  .column( 4, { page: 'current'} )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );

              // Update footer
              $( api.column( 4 ).footer() ).html(
                  total+ "원" //+' ( $'+ total +' total)'
              );
              //$( api.column( 5 ).footer() ).html('( 현 페이지 : '+ pageTotal +' 원)');
              $("#logtotal").html(total+ "원")
          }
      } );
  } );

  $(function () {
    'use strict';
    $('#fileupload').fileupload({
        url: "/api/design/safetyimage",
				//url:"/api/statics/fileuploader/test.html",
        dataType: 'json',
				formData: {sort: 'last'},
				acceptFileTypes: /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i,
				add: function(e, data) {
                var uploadErrors = [];
                var acceptFileTypes = /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i;
                //if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
								if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
                    uploadErrors.push('Not an accepted file type');
                }
                if(uploadErrors.length > 0) {
                    alert(uploadErrors.join("\n"));
										return;
                } else {
                    data.submit();
                }
        },
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
								if(file.error != ''){
									$('#files').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
								}else  {
                  $("#safetyplan_img").attr("src","/pnpinvest/data/safetyplan/" + file.file_name );
									//$("#mytable").append("<tr><td>added</td><td>"+file.file_name+"</td><td><a href='/pnpinvest/?update=invest_file_setup&amp;type=d&amp;loan_id=9&amp;file_idx="+file.fileid+"'><img src='/pnpinvest/layouts/admin/basic/img/delete2_btn.png' alt='삭제'></a></td>");
									//$('<p/>').text(file.file_name).appendTo('#files');

								}
            });
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});
function preview(code){
  $("#pageheader").attr("filter-color", code);
  $("#afterdiv").css("background","none");
  $("#filterd").text(code);
}
$("document").ready( function() {
  $("input[type=color]").spectrum({preferredFormat: "rgb",
    showInput: true,showAlpha: true});
});

function applycolor() {
  $("#pageheader").attr("filter-color",'prev');

  $("#afterdiv").css("background", "linear-gradient(to right, "+ $("input[name=start_color]").spectrum('get').toRgbString() + " 0%,"+ $("input[name=mid1_color]").spectrum('get').toRgbString() + " 40%, "+ $("input[name=mid2_color]").spectrum('get').toRgbString() + " 60%, "+ $("input[name=end_color]").spectrum('get').toRgbString() + " 100%)");
  savecolor();
}
function save_plan_now(){

  $.ajax({
         url:"/api/index.php/design/saveplannow/",
         type : 'POST',
         data: { 'safetyplan_now' : $("input[name=safetyplan_now]").val() },
         dataType : 'json',
         success : function(result) {
           if(result.code==200) alert("저장하였습니다.");
           else alert(result.msg);
         },
         error: function(request, status, error) {
            alert(status + " : " + error);
           console.log(request + "/" + status + "/" + error);
         }
      });

}
function savecolor(){
  var start = $("input[name=start_color]").spectrum('get').toHsl();
  var mid1 = $("input[name=mid1_color]").spectrum('get').toHsl();
  var mid2 = $("input[name=mid2_color]").spectrum('get').toHsl();
  var end = $("input[name=end_color]").spectrum('get').toHsl();
  var colordata = {
    start_color : $("input[name=start_color]").spectrum('get').toHex()
    ,start_opt : ( typeof start.a =='undefined') ? 1 : start.a
    ,start_pos : $("input[name=start_pos]").val()
    ,mid1_color : $("input[name=mid1_color]").spectrum('get').toHex()
    ,mid1_opt : ( typeof mid1.a =='undefined') ? 1 : mid1.a
    ,mid1_pos : $("input[name=mid1_pos]").val()
    ,mid2_color : $("input[name=mid2_color]").spectrum('get').toHex()
    ,mid2_opt : ( typeof mid2.a =='undefined') ? 1 : mid2.a
    ,mid2_pos : $("input[name=mid2_pos]").val()
    ,end_color : $("input[name=end_color]").spectrum('get').toHex()
    ,end_opt : ( typeof end.a =='undefined') ? 1 : end.a
    ,end_pos : $("input[name=end_pos]").val()
  }
  $.ajax({
         url:"/api/index.php/design/savecolorlist/",
         type : 'POST',
         data: { 'color' : colordata },
         dataType : 'json',
         success : function(result) {
           if(result.code==200) {alert("저장하였습니다."); window.location.reload();}
           else {alert(result.msg);window.location.reload();}
         },
         error: function(request, status, error) {
            alert(status + " : " + error);
           console.log(request + "/" + status + "/" + error);
         }
      });

}
  </script>
</body>
</html>
