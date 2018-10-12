<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript" src="//code.jquery.com/jquery-1.8.3.js"></script>
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
 <?php
 function returnhex($hex, $opt='1'){
   list($r, $g, $b) = sscanf($hex, "%02x%02x%02x");
   return "rgba($r, $g, $b, $opt)";
 }
 $sql = "select * from z_color_list";
 $colorlist = $this->db->query($sql)->result_array();
//while ( $colorlist=sql_fetch_array($result) ){
 /*
  $colorlist["gradient"] = array( "#45dbff", "#45dbff" );
   $colorlist["pupple"] = array( "#840d79", "#d02cb4" );
   $colorlist["WarmFlame"] = array( "#ff9a9e", "#fad0c4" );
   $colorlist["JuicyPeach"] = array( "#ffecd2", "#fcb69f" );
   $colorlist["LadyLips"] = array( "#ff9a9e", "#fecfef" );
   $colorlist["WinterNeva"] = array( "#a1c4fd", "#c2e9fb" );
   $colorlist["HeavyRain"] = array( "#cfd9df", "#e2ebf0" );
   $colorlist["CloudyKnoxville"] = array( "#fdfbfb", "#ebedee" );
   $colorlist["SaintPetersberg"] = array( "#f5f7fa", "#c3cfe2" );
   $colorlist["PlumPlate"] = array( "#667eea", "#764ba2" );
   $colorlist["EverlastingSky"] = array( "#fdfcfb", "#e2d1c3" );
   $colorlist["HappyFisher"] = array( "#89f7fe", "#66a6ff" );
   $colorlist["FlyHigh"] = array( "#48c6ef", "#6f86d6" );
   $colorlist["FreshMilk"] = array( "#feada6", "#f5efef" );
   $colorlist["GreatWhale"] = array( "#a3bded", "#6991c7" );
   $colorlist["AquaSplash"] = array( "#13547a", "#80d0c7" );
   $colorlist["CleanMirror"] = array( "#93a5cf", "#e4efe9" );
   $colorlist["CochitiLake"] = array( "#93a5cf", "#e4efe9" );
   $colorlist["PassionateBed"] = array( "#ff758c", "#ff7eb3" );
   $colorlist["EternalConstance"] = array( "#09203f", "#537895" );
   $colorlist["Nega"] = array( "#ee9ca7", "#ffdde1" );
   $colorlist["GentleCare"] = array( "#ffc3a0", "#ffafbd" );
   $colorlist["MorningSalad"] = array( "#B7F8DB", "#50A7C2" );
*/

   foreach ($colorlist as $colname => $colors){
     ?>
     .header-filter[filter-color="<?php echo $colors['name']?>"]:after {
       background: <?php echo $colors[0]?> ; /* Old browsers */
       background: -moz-linear-gradient(-45deg, <?php echo returnhex($colors['start_color'],'1') ?> 0%, <?php echo returnhex($colors['end_color'],'1') ?> 100%); /* FF3.6-15 */
       background: -webkit-linear-gradient(-45deg, <?php echo returnhex($colors['start_color'],'1') ?> 0%,<?php echo returnhex($colors['end_color'],'1') ?> 100%); /* Chrome10-25,Safari5.1-6 */
       background: linear-gradient(135deg, <?php echo returnhex($colors['start_color'],'1') ?> 0%,<?php echo returnhex($colors['end_color'],'1') ?> 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
       filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#<?php echo $colors['start_color']?>', endColorstr='#<?php echo $colors['end_color']?>',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
     }
     .header-filter[filter-color="center_<?php echo $colors['colorno']?>"]:after {
        background: -moz-linear-gradient(left, <?php echo returnhex($colors['start_color'],$colors['start_opt']) ?> 0%, <?php echo returnhex($colors['mid1_color'],$colors['mid1_opt']) ?> <?php echo $colors['mid1_pos']?>%,<?php echo returnhex($colors['mid2_color'],$colors['mid2_opt']) ?> <?php echo $colors['mid2_pos']?>%,<?php echo returnhex($colors['end_color'],$colors['end_opt']) ?> 100%);
        background: -webkit-linear-gradient(left, <?php echo returnhex($colors['start_color'],$colors['start_opt']) ?> 0%,<?php echo returnhex($colors['mid1_color'],$colors['mid1_opt']) ?> <?php echo $colors['mid1_pos']?>%,<?php echo returnhex($colors['mid2_color'],$colors['mid2_opt']) ?> <?php echo $colors['mid2_pos']?>%, <?php echo returnhex($colors['end_color'],$colors['end_opt']) ?> 100%);
        background: linear-gradient(to right,<?php echo returnhex($colors['start_color'],$colors['start_opt']) ?> 0%,<?php echo returnhex($colors['mid1_color'],$colors['mid1_opt']) ?> <?php echo $colors['mid1_pos']?>%,<?php echo returnhex($colors['mid2_color'],$colors['mid2_opt']) ?> <?php echo $colors['mid2_pos']?>%, <?php echo returnhex($colors['end_color'],$colors['end_opt']) ?> 100%);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#<?php echo $colors['start_color']?>', endColorstr='<?php echo $colors['end_color']?>',GradientType=1 );
    }
     <?
   }
 ?>
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
        <input type="text" name="safetyplan_now" value="<?php echo $data['nowplan']?>"><span style="padding-right:10px;">원</span>
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
  </table>
  <!--
<div style="margin: 20px 10px;">
  <div>
    <p>filter:<span id="filterd"></span></p>
    <div id="pageheader"
    class="page-header header-filter clear-filter header-small"
     data-parallax="true"
     filter-color="center_<?php echo $data['main_filter']?>"
     style="width:100vw;height:40vh;background-image:url('<?php echo $data['main_img']?>'); background-position: center center;    background-size: cover;">
    <div id="afterdiv"></div>
    </div>
  </div>
  <div>

    <div>
      <div>
        시작 - 색상<input type='color' name="start_color" value="#ea0437"/>  , pos<input type="text" name="start_pos" value="0" style="width:50px;">%
        <br>
        중간 - 색상<input type='color' name="mid1_color" value="#FFFFF"/>  , pos<input type="text" name="mid1_pos" value="40" style="width:50px;">%
        <br>
        중간 - 색상<input type='color' name="mid2_color" value="#FFFFF"/>  , pos<input type="text" name="mid2_pos" value="60" style="width:50px;">%
        <br>
        종료 - 색상<input type='color' name="end_color" value="#ea0437"/>  , pos<input type="text" name="end_pos" value="100" style="width:50px;">%
      </div>
      <a class="btn btn-primary" href="javascript:;" onClick="applycolor()">테스트</a>
    </div>

  </div>
  <div>
    <?php foreach ($colorlist as $colname => $colors){ ?>
      <div class="colorcode header-filter" filter-color="center_<?php echo $colors['colorno']?>" onClick="preview('center_<?php echo $colors['colorno']?>')">
        <div><?php echo $colors['colorno']?></div>
      </div>
    <?php } ?>
  </div>
</div>
-->
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
	<script src="/api/statics/fileuploader/js/jquery.iframe-transport.js"></script>
	<script src="/api/statics/fileuploader/js/jquery.fileupload.js"></script>
  <script src="https://bgrins.github.io/spectrum/spectrum.js"></script>

  <script>
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
