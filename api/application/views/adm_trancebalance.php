<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>잔액변동</title>
    	
<?php
if ($mid=='') {echo "ID가 필요합니다.";return;}
?>
<style>
  *{font-size:12px};
</style>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jq-3.2.1/dt-1.10.16/af-2.2.2/b-1.5.0/b-colvis-1.5.0/cr-1.4.1/fc-3.2.4/fh-3.1.3/r-2.2.1/rg-1.0.2/rr-1.2.3/sc-1.4.3/sl-1.2.4/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jq-3.2.1/dt-1.10.16/af-2.2.2/b-1.5.0/b-colvis-1.5.0/cr-1.4.1/fc-3.2.4/fh-3.1.3/r-2.2.1/rg-1.0.2/rr-1.2.3/sc-1.4.3/sl-1.2.4/datatables.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/plug-ins/1.10.16/dataRender/datetime.js"></script>
<style>
td.details-control {
    background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_close.png') no-repeat center center;
}
</style>
<body>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>시간</th>
                <th>tid</th>
                <th>title</th>
                <th>변동</th>
                <th>잔액</th>
            </tr>
        </thead>
    </table>

<script>

$(document).ready(function() {
    var table = $('#example').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": {
            "url": "/api/index.php/seyfertinfo/trancebalance?mid=<?php echo $mid;?>&type=<?php echo $type;?>",
            "type": "GET"
        },
        "columns": [
            { "data": "createDt" },
            { "data": "tid" },
            { "data": "title" },
            { "data": "actcAmt" },
            { "data": "actcRsltAmt" }
        ],
        "order": [[3, 'desc']],
        "searching": false,
        "ordering": true,
        "bFilter" : false,
        "bLengthChange": false
    } );

} );
</script>
</body>
</html>
