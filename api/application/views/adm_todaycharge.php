<style>
.jambo2_table tbody tr th {background-color: rgba(78, 100, 121, 0.94);color: #ECF0F1;}
.table-bordered>tbody>tr>td, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>td, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>thead>tr>th {
      border: 1px solid #888;
}
th.right,td.right{ text-align: right;  padding-right: 15px; }
th, td{text-align:center}
</style>
<div id=total></div>
<table class="table table-striped jambo_table">
  <thead>
    <tr>
      <th>일시</th>
      <th>ID</th>
      <th>충전이름(회원이름)</th>
      <th>금액</th>
      <th>잔고</th>
    </tr>
  </thead>
  <tbody>
<?php
$sum =0;
foreach ($log as $row){
  $sum = $sum +(int)$row['cpayorg'];
?>
    <tr>
      <td><?php echo $row['c_regdatetime']?></td>
      <td><a class="linked_class" onclick="searchuser('<?php echo $row['m_id']?>')"><?php echo $row['m_id']?></a></td>
      <td><?php echo $row['r_name']?><br>(<?php echo $row['m_name']?>)</td>
      <td><?php echo $row['c_pay']?></td>
      <td><?php echo $row['m_emoney']?></td>
    </tr>
<?php } ?>
  </tbody>
</table>
<script>
$("document").ready( function() {
  $("#total").text("오늘 현재 총 <?php echo number_format($sum) ?> 원 충전");
});
</script>
총 <?php echo number_format($sum) ?> 원;
