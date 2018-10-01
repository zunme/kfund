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
      <th>회차</th>
      <th>예상일</th>
      <th>실정산일</th>
      <th>예상일수</th>
      <th class="right">예상이자</th>
    </tr>
  </thead>
  <tbody>
<? foreach ($ilmangi as $row){ ?>
    <tr>
      <td><?php echo $row['cnt']?></td>
      <td><?php echo $row['repaydate']?></td>
      <td><?php echo $row['jigupil']?></td>
      <td><?php echo $row['days']?></td>
      <td class="right"><?php echo $row['ija']?></td>
    </tr>
<?php } ?>
  </tbody>
</table>
<table  class="table table-bordered jambo2_table">
  <tbody>
    <tr>
      <th>시작일</th>
      <td class="right"><?php echo (isset($row['startdate'])) ? $row['startdate']:''?></td>
      <th>예상종료일</th>
      <td class="right"><?php echo (isset($row['enddate'])) ? $row['enddate']:''?></td>
    </tr>
    <tr>
      <th>원금</th>
      <td class="right"><?php echo (isset($row['i_loan_pay'])) ? $row['i_loan_pay']:''?></td>
      <th>이율</th>
      <td class="right"><?php echo (isset($row['rate'])) ? $row['rate']:''?></td>
    </tr>
  </tbody>
</table>
