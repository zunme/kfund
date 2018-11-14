<style>
  table {
      border-spacing: 0;
      border-collapse: collapse;
      margin-bottom:10px;
  }
  th {background-color:#EEE;text-align: center}
  th, td {    padding: 4px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid #ddd;}
  .right {text-align:right;}
</style>
<table style="width:100%"  class="sunaptable">
  <thead>
    <tr>
      <th>회차</th>
      <th>구분</th>
      <th>수납일</th>
      <th>수납금액</th>
      <th>상환금</th>
      <th>이율</th>
      <th>연체이율</th>
      <th>정상이자</th>
      <th>유예기간내</th>
      <th>유예기간후</th>
      <th>수수료</th>
      <th>총이자</th>
      <th style="width:20px;background: url(/pnpinvest/layouts/home/pnpinvest/DataTables/details_open.png) no-repeat center center;cursor: pointer;" onClick="$(this).closest('table').children('tbody').toggle()"></th>
    </tr>
  </thead>
  <tbody style="display:none">
  <?php if(is_array($history)>0 ) {foreach($history as $hrow) {?>
  <tr>
    <td><?php echo $hrow['회차']?></td>
    <td><?php echo $hrow['상환구분']?></td>
    <td><?php echo $hrow['수납일']?></td>
    <td><?php echo number_format($hrow['수납금액'])?></td>
    <td><?php echo number_format($hrow['상환금']+$hrow['중도상환금'])?></td>
    <td><?php echo $hrow['이율']?>%</td>
    <td><?php echo $hrow['연체이율']?>%</td>
    <td><?php echo number_format($hrow['정상이자'])?>(<?php echo $hrow['이자일수']?>일)</td>
    <td><?php echo number_format($hrow['기간내이자'])?>(<?php echo $hrow['기간내']?>일)</td>
    <td><?php echo number_format($hrow['기간이후이자'])?>(<?php echo $hrow['기간이후']?>일)</td>
    <td><?php echo ($hrow['플랫폼수수료']=='-') ? '-' : number_format($hrow['플랫폼수수료'])?></td>
    <td><?php echo number_format($hrow['총지금이자'])?></td>
    <td></td>
  </tr>
<?php } } else {?>
  <tbody>
    <tr ><td colspan=13 style="padding:5px;text-align:center;">정산 기록이 없습니다.</td></tr>
  </tbody>
  <?php } ?>
</tbody>
</table>
<hr />
<table style="width:100%" class="sunaptable">
  <tr>
    <th>대출상품</th><td colspan='7'><?echo $loaninfo['i_subject']?></td>
  </tr>
  <tr>
    <th>대출금액</th><td><?echo number_format($loaninfo['i_loan_pay'])?>( 실 : <?echo number_format($loaninfo['realpay'])?> )</td>
    <th>대출잔액</th><td><?echo number_format($loaninfo['remaining_amount'])?></td>
    <th>대출일자</th><td><?echo $loaninfo['i_loanexecutiondate2']?></td>
    <th>만기일자</th><td><?echo $loaninfo['i_reimbursement_date2']?></td>
  </tr>
  <tr>
    <th>종납일자</th><td><?=$history[(count($history)-1)]['next_from']?>(수납일 : <?echo $info2['lastdate']?>)</td>
    <th>응당일자</th><td><?echo date('Y-m-d',$cal['next']['holiday'])?></td>
    <td colspan=4></td>
  </tr>
</table>

<hr>
<form name="calc_sunap">
  <input type="hidden" name="loanid" value="<?php echo $this->input->get('loanid')?>">
  <input type="hidden" name="reg" value="">
  <table  style="width:100%" class="sunaptable">
    <tr>
      <th>수수료</th><td><input type="text" name="default_profit" value="<?php echo $loaninfo['default_profit']?>" onkeyup="$('#sunapregbutton').hide();"></td>
      <th>이율</th><td><input type="text" name="i_year_plus" value="<?php echo $loaninfo['i_year_plus']?>" onkeyup="$('#sunapregbutton').hide();">%</td>
      <th>연체이율</th><td><input type="text" name="i_year_over" value="<?php echo $loaninfo['i_year_over']?>" onkeyup="$('#sunapregbutton').hide();">%</td>
    </tr>
  </table>
  <?php if ($loaninfo['i_look']!='D') { ?>
    </form>
    <div style="margin:20px;text-align:center;"> 이자상환중인 상품이 아닙니다.</div>
  <?php  return;}?>
  <?php if ($loaninfo['i_repay']!='일만기일시상환') { ?>
    </form>
    <div style="margin:20px;text-align:center;"> 일만기일기상환으로 되어있는 상품이 아닙니다.(<?php echo $loaninfo['i_repay']?>)</div>
  <?php  return;}?>
<table style="width:100%" class="sunaptable">
  <tr>
    <th width='20%'>수납일자</th>
    <td width='30%'>
      <input type="text" class="form-control has-feedback-left" id="single_cal4" name="sdate" value="<?echo date('Y-m-d',$cal['get']['sunapil'])?>">
    </td>
    <th width='20%'>차기납일일</th>
    <td width='30%'><?echo date('Y-m-d',$cal['nextmonth']['holiday'])?>(
      <?php echo date_diff( date_create(date('Y-m-d',($cal['get']['sunapil'] < $cal['next']['next'] ) ? $cal['get']['sunapil'] : $cal['next']['next'])), date_create(date('Y-m-d',$cal['nextmonth']['next']) ) )->days;?>
      )</td>
  </tr>
  <tr>
    <th>상환구분</th>
    <td>
      <select name="type_row" onChange="sunapmodal_calc(<?php echo $this->input->get('loanid')?>)">
        <option value='이자상환' <? echo ($this->input->get('type_row')=='이자상환') ? "selected='selected'" : ""?> >이자상환</option>
        <option value='일부상환' <? echo ($this->input->get('type_row')=='일부상환') ? "selected='selected'" : ""?>>일부상환</option>
        <option value='만기상환' <? echo ($this->input->get('type_row')=='만기상환') ? "selected='selected'" : ""?>>만기상환</option>
      </select>
    </td>
    <th>상환후대출잔액</th><td><?php echo number_format(  $cal['after_remain'] )?> 원</td>
  </tr>
  <tr>
    <th>상환이자</th>
    <!-- td><input type="text" name='storage_amount' value="<?php echo $cal['storage_amount']?>" <?php echo $cal['readonly']==true ? 'readonly=readonly':'' ?> onkeyup="$('#sunapregbutton').hide();"></td-->
    <td><input type="text" name='storage_amount_ija' value="<?php echo $cal['ija']['total']?>" readonly onkeyup="$('#sunapregbutton').hide();"></td>
    <th>상환원금</th>
    <td>
      <input type="text" name='storage_amount_wongum' value="<?php echo $cal['Reimbursement']?>" <?php echo $cal['readonly']==true ? 'readonly=readonly':'' ?> onkeyup="$('#sunapregbutton').hide();">
      <input type="hidden" id="calcpcrt" value="<?php echo ($cal['Reimbursement']>0) ? ($cal['Reimbursement'] / $loaninfo['realpay']*100) :"0" ?>" style="width:40px"> <!--a href="javascript:;" class="btn btn-warning" onClick="calcpcrt()">%</a-->
    </td>
  </tr>
  <tr>
    <th>정상이자<br>(이자계산총일수)</th>
    <td><?php echo number_format($cal['ija']['정상이자'])?> 원 (<?php echo $cal['ijail']['days']?>)일
      <input type="hidden" name="wdays" value="<?php echo ($this->input->get('wdays')>0) ? (int)$this->input->get('wdays'):''?>" style="width:40px;position: relative;float: right;">
        <br>(실정상이자일수 : <?php echo $cal['ijail']['days']-$cal['ijail']['inner']-$cal['ijail']['over']?>)
    </td>
    <th></th><td></td>
  </tr>
  <tr>
    <th>기간내이자<br>(유예기간내이자)</th>
    <td><?php echo number_format($cal['ija']['유예기간내'])?> 원 (<?php echo $cal['ijail']['inner']?>)일
      <input type="hidden" name="winner" value="<?php echo ($this->input->get('winner')>0) ? (int)$this->input->get('winner'):''?>" style="width:40px;position: relative;float: right;">
      <br>(정상이자<?php echo ($cal['ijail']['days'] - $cal['ijail']['inner'] -  $cal['ijail']['over'])?>일치)</td>
    <th>기간이후이자<br>(유예기간후이자)</th><td>
      <?php echo number_format($cal['ija']['유예기간외'])?>원 (<?php echo $cal['ijail']['over']?>)일
      <input type="hidden" name="wover" value="<?php echo ($this->input->get('wover')>0) ? (int)$this->input->get('wover'):''?>" style="width:40px;position: relative;float: right;">
      <?php if ($cal['ijail']['overdate'] !='') echo "<br>[ ".$cal['ijail']['overdate']."]";?>
    </td>
  </tr>
  <tr>
    <th>수납원금</th><td><?php echo $cal['Reimbursement']?></td>
    <th>총이자</th><td><?php echo number_format($cal['ija']['total'])?>원</td>
  </tr>
</table>
 <span class="btn btn-primary" onclick="sunapmodal_calc(<?php echo $this->input->get('loanid')?>)">계산하기</span>
  <span class="btn btn-primary" id="sunapregbutton" onclick="sunapmodal_calc_reg(<?php echo $this->input->get('loanid')?>)">등록하기</span>
  <span style="position:relative;float:right">*수납일자까지의 모든 이자를 계산합니다.(종납일=수납일)<br>*세금 계산방식 = 십원절삭(0.25*이자) + 십원절삭(0.025*이자) 방식입니다.</span>
  <span style="clear:both"></span>
</form>

<script>
function calcpcrt() {
  var pcrt = $("#calcpcrt").val() ;
  var realpay = <?php echo $loaninfo['realpay'] ?>;
  if( pcrt > 0 ){
    var pay = realpay * pcrt / 100;
    $("input[name=storage_amount_wongum]").val(pay);
    if( pay == <?php echo $loaninfo['remaining_amount'] ?> ) $("select[name=type_row]").val('만기상환');
    else $("select[name=type_row]").val('일부상환');
    sunapmodal_calc(<?php echo $this->input->get('loanid')?>);
  }
}
$("documnet").ready( function() {
  $("#single_cal4").daterangepicker(
    {
      singleDatePicker: true,
      showDropdowns: true,
      locale: {format: 'YYYY-MM-DD'},
    }
    ,function(a,b,c){
      $("#single_cal4").val(a.format('YYYY-MM-DD'));
      sunapmodal_calc(<?php echo $this->input->get('loanid')?>);
    }
  );
});
</script>
