<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
if( !isset($user['m_id']) ) {
  ?>
  <script>
    location.href="/pnpinvest/?mode=login";
  </script>
  <?php
  exit;
}

$sql = "
select a.*, date_format(a.i_regdatetime, '%Y-%m-%d') as regdate
        , case
          when( b.i_look = 'N') then '투자대기'
          when( b.i_look = 'Y') then '투자시작'
          when( b.i_look = 'C') then '투자마감'
          when( b.i_look = 'D') then '상환중'
          when( b.i_look = 'F') then '상환완료'
          else '' end as lookstatus
         , ifnull(tmp.total,0) total, ifnull(tmp.cnt,0) cnt
         , round(ifnull(tmp.total,0)/a.i_loan_pay *100,0) as perct
        from mari_loan a
        join mari_invest_progress b on a.i_id = b.loan_id
			left join (
			select loan_id, sum(i_pay) as total, count(1) as cnt from mari_invest where loan_id in ( select i_id from mari_loan where m_id = '$user[m_id]' ) group by loan_id
			) tmp on a.i_id = tmp.loan_id
        where a.m_id='$user[m_id]' order by a.i_regdatetime desc limit 5;
";
$loan_qry = sql_query($sql);

$sql = "
select
tmp.*
,if( s.storage_amount > 0 ,s.storage_amount, o_mh_money) as payed
,a.i_loan_day
, case
  when( a.i_look = 'N') then '투자대기'
  when( a.i_look = 'Y') then '투자시작'
  when( a.i_look = 'C') then '투자마감'
  when( a.i_look = 'D') then '상환중'
  when( a.i_look = 'F') then '상환완료'
  else '' end as lookstatus
from
(select * from mari_order   where  user_id='$user[m_id]' group by loan_id, o_count order by  o_datetime desc limit 5) tmp
join mari_loan a on tmp.loan_id = a.i_id
left join z_invest_sunap s on tmp.loan_id = s.loan_id and tmp.o_count = s.o_count
";
$order       = sql_query($sql);
?>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub mypage">
	<!-- Sub title -->
	<h2 class="subtitle t4"><span class="motion" data-animation="flash">마이페이지</span></h2>
	<!-- 엔젤펀딩 공지사항 -->
	<div class="join">
		<div class="container clearfix">
			<!-- 컨텐츠 본문 -->
			<aside class="snb">
				<h3>MY PAGE</h3>
				<ul>
					{# new_side}
				</ul>
			</aside>
			<div class="my_content">
				<div class="my_certify clearfix">

					<div class="mytab">
						<input id="mytab01" type="radio" class="blind" name="mytab" title="입출금 관리 내용 보기" checked>
						<input id="mytab02" type="radio" class="blind" name="mytab" title="입출금 내역 내용 보기">

						<!-- 대출 상환 스케줄 start -->
						<div class="mytab_con my_schedule">
							<div class="clearfix">
								<div class="my_left">
									<h4>상환스케줄 <span class="pc">현재까지 투자한 내역에 대한 상환스케줄입니다.</span></h4>
								</div>
								<div class="my_right">
									<span class="tt">상환계좌</span>
									<p class="bank_acc"><strong><?php if(!$pg['i_not_bankname'] || !$pg['i_not_bank'] || !$pg['i_not_bankacc']){ echo '상환계좌정보가 없습니다.';}else{echo $pg['i_not_bankname']?> <?php echo bank_name($pg['i_not_bank']);?> <?php echo $pg['i_not_bankacc']; }?></strong></p>
								</div>
							</div>
							<div id="invest_calendar" class="my_calendar"></div>
							<script type="application/javascript">
								$(document).ready(function () {
									$("#invest_calendar").zabuto_calendar();
								});
							</script>
							<div class="my_condition">
								<table class="table_green">
									<caption>상환스케줄</caption>
									<thead>
										<thead>
											<tr>
												<th>상환일</th>
												<th>상환금액</th>
												<th>채권명</th>
												<th>대출금액</th>
												<th>상태</th>
												<th>잔액</th>
											</tr>
										</thead>
									</thead>
									<tbody>

<!-- start -->
<?php
// mypage_loan_schedule_more 에서 가져옴

/*대출자가 대출신청한 대출건가져오기*/
$sql = " select * from mari_loan where m_id='$user[m_id]'";
$myloanlist = sql_query($sql, false);
 $cnt = 0;
  for ($i=0; $myloan=sql_fetch_array($myloanlist); $i++) {


?>

<?php
//원리금균등분할상환
if($myloan['i_repay']=="원리금균등상환"){
?>
<?php
  /*대출기간*/
  $ln_kigan=$myloan['i_loan_day'];
  /*투자금액*/
  $ln_money=$myloan['i_loan_pay'];
  /*연이자율*/
  $ln_iyul=$myloan['i_year_plus'];

  $ln_kigan = $ln_kigan - $stop;

  $일년이자 = $ln_money*($ln_iyul/100);
  $첫달이자 = substr(($일년이자/12),0,-1)."0";
?>
    <?php
    $sumPrice = "0";
    $rate = (($ln_iyul/100)/12);
    $상환금 = ($ln_money*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1));
    for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) {
      $납입원금계 += ($상환금-$첫달이자);
      $잔금 = $ln_money-$납입원금계;
      $납입원금 = $상환금-$첫달이자;
      $sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
      /*정산일자 구하기*/
      $order_date = date("Y-m-d", strtotime($myloan[i_loanexecutiondate]."+".$i."month"));
      $sql = " select * from mari_order where loan_id='$myloan[loan_id]' and user_id='$user[m_id]'  and o_count='".$i." order by o_datetime desc";
      $orderview = sql_fetch($sql, false);

      $sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
      $scdview = sql_fetch($sql, false);
    ?>
                    <tr>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><<?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php echo $myloan[i_subject]?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }else{?>준비중<?php }?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($잔금):"0"?></td>
                    </tr>
    <?php
        $이자합산 += $첫달이자;
        $납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
        $월불입금합산=$납입원금합산+$이자합산;
        $일년이자 = $잔금*($ln_iyul/100);
        $첫달이자 = substr(($일년이자/12),0,-1)."0";
    }
    ?>

<?php
}else{
?>
    <?php

    /*대출기간*/
    $ln_kigan=$myloan['i_loan_day'];
    /*투자금액*/
    $ln_money=$myloan['i_loan_pay'];
    /*연이자율*/
    $ln_iyul=$myloan['i_year_plus'];

    $일년이자 = $ln_money*($ln_iyul/100);
    $첫달이자 = substr(($일년이자/12),0,-1)."0";
    $ln_kigan_con=$ln_kigan-1;
    $전체이자=$첫달이자*$ln_kigan_con;
    for($i=1; $i<=$ln_kigan; $i++){
    /*정산일자 구하기*/
    $order_date = date("Y-m-d", strtotime($myloan[i_loanexecutiondate]."+".$i."month"));
      $sql = " select * from mari_order where loan_id='$myloan[loan_id]' and user_id='$user[m_id]'  and o_count='".$i." order by o_datetime desc";
      $orderview = sql_fetch($sql, false);

      $sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
      $scdview = sql_fetch($sql, false);
    ?>
                    <tr>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php echo $myloan[i_subject]?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }else{?>준비중<?php }?></td>
                      <td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?"0":number_format($ln_money)?></td>
                    </tr>
    <?php
    $이자합산 += $첫달이자;
    $만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
    $월불입금합산=$만기이자+$전체이자;
      }
    ?>
<?php }?>
      </tr>
    <?php
      }

       if ($i == 0)
          echo "<tr><td colspan=\"6\">스케줄 정보가 없습니다.</td></tr>";
    ?>
<!-- end -->
									</tbody>
								</table>
							</div>

						</div>
						<!-- // 대출 상환 스케줄 end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
