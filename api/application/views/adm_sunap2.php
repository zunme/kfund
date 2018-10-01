<table style="width:100%" class="sunaptable">
  <tr>
    <th>총원금</th><td><?php echo number_format($viewtotal['wongum'])?></td>
    <th>총이자</th><td><?php echo number_format($viewtotal['total_interest'])?></td>
    <th>총금액</th><td><?php echo number_format($viewtotal['wongum']+$viewtotal['total_interest'])?></td>
    <th>총이체금액</th><td><?php echo number_format($viewtotal['total_emoney'])?></td>
  </tr>
</table>
<table style="width:100%">
  <tr>
    <th>EMAIL</th>
    <th>투자액</th>
    <th>남은투자액</th>
    <th>원금</th>
    <th>정상이자</th>
    <th>기간내이자</th>
    <th>기간후이자</th>
    <th>총이자</th>
    <th>수수료</th>
    <th>원천징수</th>
    <th>실금액</th>
  </tr>
  <?php
  foreach ($detail as $row){
  ?>
  <tr>
    <td><?php echo $row['sale_id']?></td>
    <td class="right"><?php echo number_format($row['i_pay'])?> 원</td>
    <td class="right"><?php echo number_format($row['i_pay_remain'])?> 원</td>
    <td class="right"><?php echo number_format($row['wongum'])?> 원</td>
    <td class="right"><?php echo number_format($row['interest'])?> 원</td>
    <td class="right"><?php echo number_format($row['under'])?> 원</td>
    <td class="right"><?php echo number_format($row['over'])?> 원</td>
    <td class="right"><?php echo number_format($row['total_interest'])?> 원</td>
    <td class="right"><?php echo number_format($row['susuryoPayed'])?> 원</td>
    <td class="right"><?php echo number_format($row['withholdingPayed'])?> 원</td>
    <td class="right"><?php echo number_format($row['emoney'])?> 원</td>
  </tr>
<?php }?>
</table>
