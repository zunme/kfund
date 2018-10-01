<form name="settle_calc">
<table class="table table-striped jambo_table">
  <thead>
    <tr>
      <th>type</th>
      <th>상환원금</th>
      <th>예상<br>(일)</th>
      <th>금일기준<br>(일)</th>
      <th>일수</th>
      <th>연체이율</th>
      <th>연체일수</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <input type="hidden" name="loanid" value="<?php echo $info1['loanid']?>">
      <input type="hidden" name="o_count" value="<?php echo $info1['cnt']?>">
      <input type="hidden" name="rate" value="<?php echo $info1['rate']?>">
        <td>
          <select name="type">
            <option value="이자지급" selected="selected">이자지급</option>
            <option value="중도일부상환">중도일부상환</option>
            <option value="중도상환" >중도상환</option>
            <option value="만기상환" >만기상환</option>
          </select>
        </td>
        <td>
          <input type="text" name = "Reimbursement" value="0" style="width: 100px;">
        </td>
        <td><?php echo $info1['days']?>일</td>
        <td><?php echo $info1['nowdiffdays']?>일</td>
        <td><input type="text" name = "days" value="<?php echo $info1['days']?>"  style="width: 60px;">일</td>
        <td><input type="text" name = "Delinquency_rate"  value="<?php echo $info1['rate']?>" style="width: 60px;" >%</td>
        <td><input type="text" name = "Delinquency_days" value='0' style="width: 60px;">일</td>
        <td id="calctd_button"><span class="btn btn-default" onClick="preview_settle_calc()">계산하기</span></td>
    </tr>
  </tbody>
</table>
</form>
<script>
function preview_settle_calc(){

  $.ajax({
    type : 'POST',
    url : '/api/index.php/adm/settleprerun',
    dataType : 'json',
    data : $('form[name="settle_calc"]').serialize() ,
    success : function(result) {
      console.log(result);
    }
  });
}
</script>
