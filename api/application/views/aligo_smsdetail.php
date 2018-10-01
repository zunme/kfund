	<script src="/pnpinvest/layouts/home/pnpinvest/DataTables/datatables.min.js" type="text/javascript"></script>
<style>
datatable2.table > thead > tr > th {
    font-size: 1em;
  }
  datatable2.table > tbody > tr > td {
      font-size: 1em;
      padding:8px;
    }
    .dataTables_length {position: relative;float: left;margin-left: 20px;}
    .dataTables_filter {position: relative;float: right;margin-right: 20px;}
    .dataTables_filter input {margin-left: 10px;}
    .dataTables_info{margin-bottom: 5px;text-align:right;}
    .dataTables_paginate.paging_simple_numbers{ text-align:center;margin-top: 15px;}
    .dataTables_paginate.paging_simple_numbers a { padding: 0px 5px;}
    .dataTables_paginate.paging_simple_numbers  a.paginate_button {background-color: #9c27b0;
    padding: 5px 10px;
    border-radius: 15px;
    margin-left: 5px;
    margin-right: 5px;
    color: white;
    cursor: pointer;
  }
</style>
 <table id="datatable2" class="table table-striped table-bordered"  class="display nowrap" cellspacing="0" width="100%">
   <thead>
     <tr>
       <th>type</th>
       <th>receiver</th>
       <th>sms_state</th>
     </tr>
   </thead>
   <tbody>
   </tbody>
 </table>
 <script>
 $(document).ready(function() {
   table2 = $('#datatable2').DataTable( {
        "ajax": '/api/index.php/aligo/smsdetailsrc?smsidx=<?php echo($this->input->get('smsidx') )?>'
    });
 });
</script>
