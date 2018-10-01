<style>
 table.justable thead th {text-align:center}
 table.justable tbody td.right {text-align:right}
 table.justable tbody td{padding:3px;}
</style>
<div class="row" style="margin-top:10px;">
  <div class="col col-xs-8" id="jungsan_remain_num" data-remain ="<?php echo count($list)?>" style="text-align:center;font-size:20px;margin-top:2px;">
    총 <?php echo count($list)?> 개 대기중
  </div>
  <div class="col col-xs-4" id="jungsan_btn_div">
     <span class="btn btn-danger" onclick="jungsan_remain_call()">정산하기</span>
     <span class="btn btn-primary" style="display:none">정산중입니다.</span>
  </div>
</div>
<hr>
<table width="100%" class="justable">
  <thead>
    <tr>
      <th>EMAIL</th>
      <th>이름</th>
      <th>정산금</th>
      <th>원금</th>
      <th>이자</th>
      <th>수수료</th>
      <th>원천징수</th>
      <th>투자금액</th>
      <th>남은금액</th>
      <th>투자건</th>
    </tr>
  </thead>
  <tbody id="jungsan_prc_div">
  </tbody>
</table>
<script>
</script>
