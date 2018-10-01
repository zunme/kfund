<?php echo ''?>
<h5><span>예상투자수익</span>(대출일 <?php echo $info['startd']?> 기준)</h5>
<div style="text-align:right; padding-right:30px;margin-top: 20px;">
  이 상품의 수익률은 <span style="color:blue"><?php echo $info['i_year_plus']?>%</span> 입니다.
</div>
<div class="table-responsive">
<table class="table calculation_table mt15">
  <colgroup>
		<col width="85px">
		<col width="120px">
		<col width="85px">
		<col width="120px">
		<col width="85px">
		<col width="120px">
	</colgroup>
  <tbody>
    <tr>
      <th>투자원금</th><td><span style="color:blue"><?php echo number_format($info['won'])?></span> 원</td>
      <th>투자기간</th><td><?php echo $info['i_loan_day']?> 개월</td>
      <th>이자수익</th><td><span style="color:blue"><?php echo number_format($total['ija'])?></span> 원</td>
    </tr>
  </tbody>
</table>
</div>
<div class="table-responsive">
<table class="table calculation_table mt15">
  <colgroup>
		<col width="85px">
		<col width="120px">
		<col width="85px">
		<col width="120px">
		<col width="85px">
		<col width="120px">
	</colgroup>
  <tbody>
    <tr>
      <th>수수료</th><td><?php echo number_format($total['profit'])?> 원</td>
      <th>세금</th><td><?php echo number_format($total['withholding'])?> 원</td>
      <th>총수익</th><td><span style="color:blue"><?php echo number_format($total['tot'])?></span> 원</td>
    </tr>
  </tbody>
</table>
</div>
<div class="table-responsive">
<table class="table calculation_table2 mt15">
	<thead>
		<tr>
			<th>회차</th>
      <th>지급일</th>
			<th>이용일수</th>
			<th>이자(세전)</th>
			<th>수수료</th>
			<th>세금</th>
      <th>수익(세후)</th>
		</tr>
	</thead>
	<tbody>
    <?php
      $i = 0;
      $cnt = count($calc);
      foreach($calc as $row) {?>
		<tr>
			<td><strong><?php echo ++$i?>회차 </strong></td>
      <td><strong><?php echo $row['end'] ?> </strong></td>
			<td style="text-align:right;padding-right:10px"><strong><?php echo $row['diff']?></strong> 일</td>
			<td style="text-align:right;padding-right:10px"><strong><?php echo number_format($row['ija'])?></strong>원</td>
			<td style="text-align:right;padding-right:10px"><strong><?php echo number_format($row['profit'])?></strong>원</td>
			<td style="text-align:right;padding-right:10px"><strong><?php echo number_format($row['withholding'])?></strong>원</td>
      <td style="text-align:right;padding-right:10px"><strong><?php echo number_format($row['ija']-$row['profit']-$row['withholding'])?></strong>원</td>
		</tr>
  <?php } ?>
  <tr style="border-top: 1px solid #777; padding-top: 20px;  margin-top: 20px; background-color: #EEE;">
    <td><strong>총합 </strong></td>
    <td><strong> </strong></td>
    <td style="text-align:right;padding-right:10px"></td>
    <td style="text-align:right;padding-right:10px"><strong><?php echo number_format($total['ija'])?></strong>원</td>
    <td style="text-align:right;padding-right:10px"><strong><?php echo number_format($total['profit'])?></strong>원</td>
    <td style="text-align:right;padding-right:10px"><strong><?php echo number_format($total['withholding'])?></strong>원</td>
    <td style="text-align:right;padding-right:10px"><strong><?php echo number_format($total['tot'])?></strong>원</td>
  </tr>
	</tbody>
</table>
</div>
<p class="mt15">
  세금 : 이자수익 X 27.5%<br>
   * 이자소득세율 (<?php echo $info['invest_flag']?> 기준) : 이자소득세 <?php echo $info['i_withholding']?>% + 주민세 <?php echo $info['i_withholding_v']?>% = <?php echo $info['withholding']*100?>% <br>
  이자수익 : 수익금은 대출실행일부터 월 단위로 일할 계산되며, 매월 말일에 원천징수 후 지급됩니다<br>
  현재화면은 예상금액이며, 실제의 대출일, 중도상환 등 사유발생시 실제수익금 및 플랫폼이용료는 변동될 수 있습니다.
</p>
