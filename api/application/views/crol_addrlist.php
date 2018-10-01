<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
</head>
<body>
  <p id="date_filter">
    <form>
      <select name="mylist">
        <option value="on" <?php  if($_GET['mylist']!='off') echo 'selected'?>>내가등록한것만</option>
        <option value="off" <?php if($_GET['mylist']=='off') echo 'selected'?>>전부보기</option>
      </option>
    시작일:<input name="startdate" id="min" type="text" value="<?php echo $_GET['startdate']?>"> 종료일:<input name="enddate" id="max" type="text" value="<?php echo $_GET['enddate']?>">
    <input type="submit" value="검색">
  </form>
  </p>
  <table id="addrlist">
    <thead>
      <tr>
        <th>회사이름</th>
        <th>대표자</th>
        <th>우편번호</th>
        <th>주소</th>
        <th>등록일</th>
      </tr>
    </thead>
    <tbody>
    <?php foreach ($list as $row) {?>
      <tr>
        <td><?php echo $row['cname']?></td>
        <td><?php echo $row['name']?></td>
        <td><?php echo $row['postnum']?></td>
        <td><?php echo $row['addr']?></td>
        <td><?php echo $row['regdate']?></td>
      </tr>
    <?php } ?>
  </tbody>
  </table>
<button class='gen_btn'>Generate File</button>

<!--link href="/assets/tableexport/css/tableexport.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="/assets/tableexport/js/Filesaver.js"></script>
<script src="/assets/tableexport/js/tableexport.js"></script>
<script src="/assets/tableexport/js/Blob.min.js"></script>
<script src="/assets/tableexport/js/xlsx.core.min.js"></script>
<script src="/assets/tableexport/js/excelexportjs.js"></script-->
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">

<script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
  crossorigin="anonymous"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
<script>
var g= [];
var makeJsonFromTable=function(a){var b=$("#"+a),c=$(b).find("thead"),d=$(b).find("tbody"),e=$(b).find("tbody>tr").length,f=[],g=[];
$.each($(c).find("tr>th"),function(a,b){f.push($(b).text())}),$.each($(d).find("tr"),function(a,b){
  for(var c={},d=0;d<f.length;d++)c[f[d]]=$(this).find("td").eq(d).text();g.push(c); });var h={};return h.count=e,h.value=g,h};
function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
    //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';
    //Set Report title in first row or line
    CSV += ReportTitle + '\r\n\n';
    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }
        row = row.slice(0, -1);
        //append Label row with line break
        CSV += row + '\r\n';
    }

    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"=' + arrData[i][index] + '",';
        }
        row.slice(0, row.length - 1);
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {
        alert("Invalid data");
        return;
    }

    //Generate a file name
    var fileName = "MyReport_";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");

    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=UTF-8,\uFEFF' + encodeURI(CSV);

    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension

    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");
    link.href = uri;

    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";

    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

$("document").ready( function() {
  var tablejson = makeJsonFromTable('addrlist');
  console.log(tablejson);
  $('button').click(function(){
    JSONToCSVConvertor(tablejson.value, "주소리스트", true);
});
$("#min").datepicker({ dateFormat: 'yy-mm-dd'});
$("#max").datepicker({ dateFormat: 'yy-mm-dd'});
  $('#addrlist').DataTable( {
      dom: 'Bfrtip',
      "lengthMenu": [[10, -1], [10, "All"]],
      buttons: [
          'copyHtml5',
          'excelHtml5',
          'pdfHtml5'
      ]
  } );
});
</script>
