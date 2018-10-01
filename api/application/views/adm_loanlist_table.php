<div id="invest_list_total_div" style="text-align:right;padding-right:50px;"></div>
<table id="example" class="table table-striped jambo_table bulk_action" cellspacing="0" width="100%">
  <thead>
      <tr>
          <th>#no</th>
          <th>시간</th>
          <th>email</th>
          <th>이름</th>
          <th>전화번호</th>
          <th>투자액</th>
          <th>재투자여부</th>
          <th style="text-align:center">누적</th>
          <th></th>
      </tr>
  </thead>
  <tbody>
    <?php
    $sum = 0;
    foreach($data as $idx=>$val) {
      $sum = $sum + (int)$val['i_pay'];
    ?>
    <tr data-id="<?php echo $val['i_id']?>">
      <td><?php echo ($idx+1)?></td>
      <td><?php echo ($val['i_regdatetime'])?></td>
      <td><a class="linked_class" onClick="searchuser('<?php echo $val['m_id']?>')"><?php echo $val['m_id']?></a></td>
      <td><?php echo $val['m_name']?></td>
      <td><?php echo preg_replace("/(0(?:2|[0-9]{2}))([0-9]+)([0-9]{4}$)/", "\\1-\\2-\\3", $val['m_hp'])?></td>
      <td style="text-align:right;padding-right:20px;"><?php echo number_format($val['i_pay'])?></td>
      <td style="text-align:center"><?php echo $val['isfirst']== 1 ? '첫투자' :'재투자'?></td>
      <td style="text-align:right;padding-right:20px;"><?php echo number_format($sum)?> 원</td>
      <td>
        <form>
        <input type="hidden" name="invest_id" value="<?php echo $val['i_id']?>">
        <input type="hidden" name="from" value="angelfunding">
        <input type="hidden" name="to" value="<?php echo $val['m_id']?>">
        <input type="hidden" name="interest" value="<?php echo $val['i_pay']?>">
        <input type="hidden" name="withholding" value="">
        <input type="hidden" name="amount" value="<?php echo $val['i_pay']?>">
        <input type="hidden" name="cont" value="[<?php echo $val['i_subject']?>] 펀딩취소">
       </form>
        <!--
        <button type="button" class="btn btn-danger" onClick="cancelAfterEnd(this)">환불후취소</button>
      -->
      </td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<script>
$("#invest_list_total_div").text("총 투자액 : <?php echo number_format($sum)?> 원");
</script>
