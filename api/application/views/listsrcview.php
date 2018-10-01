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
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th></th>
                <th>tid</th>
                <th>title</th>
                <th>trnsctnDt</th>
                <th>orgAmt</th>
                <th>payAmt</th>
                <th>trnsctnSt</th>
            </tr>
        </thead>
    </table>

<script>
function format ( d ) {
    // `d` is the original data object for the row
    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
    '<tr>'+
        '<td>trnsctnDt:</td>'+
        '<td>'+d.trnsctnDt+'</td>'+
    '</tr>'+
    '<tr>'+
        '<td>updateDt:</td>'+
        '<td>'+d.updateDt+'</td>'+
    '</tr>'+
    '<tr>'+
        '<td>createDt:</td>'+
        '<td>'+d.createDt+'</td>'+
    '</tr>'+
        '<tr>'+
            '<td>trnsctnSt:</td>'+
            '<td>'+d.trnsctnSt+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>trnsctnTp:</td>'+
            '<td>'+d.trnsctnTp+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>refId:</td>'+
            '<td>'+d.refId+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>reqMemGuid:</td>'+
            '<td>'+d.reqMemGuid+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>srcMemGuid:</td>'+
            '<td>'+d.srcMemGuid+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>dstMemGuid:</td>'+
            '<td>'+d.dstMemGuid+'</td>'+
        '</tr>'+
    '</table>';
}
$(document).ready(function() {
    var table = $('#example').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": {
            "url": "/api/index.php/seyfertinfo/trancelist?mid=<?php echo $mid;?>&type=<?php echo $type;?>",
            "type": "GET"
        },
        "columns": [
          {
              "className":      'details-control',
              "orderable":      false,
              "data":           null,
              "defaultContent": ''
          },
            { "data": "tid" },
            { "data": "title" },
            { "data": "trnsctnDt" },
            { "data": "orgAmt" },
            { "data": "payAmt" },
            { "data": "trnsctnSt" }
        ],
        "order": [[3, 'desc']],
        "searching": false,
        "ordering": true,
        "bFilter" : false,
        "bLengthChange": false
    } );
    // Add event listener for opening and closing details
    $('#example tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );

        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( format(row.data()) ).show();
            tr.addClass('shown');
        }
    } );
} );
</script>
