<style>
.jambo2_table tbody tr th {background-color: rgba(78, 100, 121, 0.94);color: #ECF0F1;}
.table-bordered>tbody>tr>td, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>td, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>thead>tr>th {
      border: 1px solid #888;
}
th.right,td.right{ text-align: right;  padding-right: 15px; }
th, td{text-align:center}
</style>
<table class="table table-striped jambo_table">
  <thead>
    <tr>
      <th>일시</th>
      <th>내용</th>
      <th>금액</th>
      <th>잔액</th>
    </tr>
  </thead>
  <tbody>
<? foreach ($log as $row){ ?>
    <tr>
      <td><?php echo $row['p_datetime']?></td>
      <td><?php echo $row['p_content']?></td>
      <td><?php echo $row['p_emoney']?></td>
      <td><?php echo $row['p_top_emoney']?></td>
    </tr>
<?php } ?>
  </tbody>
</table>
