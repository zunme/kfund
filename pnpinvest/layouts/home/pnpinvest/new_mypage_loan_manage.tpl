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
	<!-- 케이펀딩 공지사항 -->
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
					<div class="title clearfix">
						<h3 class="fl">대출정보</h3>
						<p class="btn_mytab_wrap">
							<label for="mytab01" class="btn_mytab active">대출관리</label>
							<label for="mytab02" class="btn_mytab">대출 상환 스케줄</label>
						</p>
					</div>
					<div class="mytab">
						<input id="mytab01" type="radio" class="blind" name="mytab" title="입출금 관리 내용 보기" checked>
						<input id="mytab02" type="radio" class="blind" name="mytab" title="입출금 내역 내용 보기">
						<!-- 대출 관리 start -->
						<div class="mytab_con">
							<div class="clearfix">
								<div class="my_left">
									<h4><?php echo $user['m_name'];?> 님의 현재 대출정보입니다</h4>
									<ul class="list_con">
										<li class="non_bd clearfix">
											<span class="fl">대출 금액</span>
											<span class="fr"><?php echo number_format($total_loan_pay);?>원</span>
										</li>
										<li class="non_bd clearfix">
											<span class="fl">연체 금액</span>
											<span class="fr"><?php echo number_format($total_over_pay);?>만원</span>
										</li>
										<li class="non_bd clearfix">
											<span class="fl">잔여 금액</span>
											<span class="fr"><?php echo number_format($total_ld_pay);?>만원</span>
										</li>
									</ul>
								</div>
								<div class="my_right">
									<h4>상환계좌</h4>
									<p class="bank_acc"><strong><?php if(!$pg['i_not_bankname'] || !$pg['i_not_bank'] || !$pg['i_not_bankacc']){ echo '상환계좌정보가 없습니다.';}else{echo $pg['i_not_bankname']?> <?php echo bank_name($pg['i_not_bank']);?> <?php echo $pg['i_not_bankacc']; }?></strong></p>
									<ul class="list_con">
										<li class="non_bd clearfix">
											<table class="table_green center">
												<caption>대출정보</caption>
												<colgroup>
													<col style="width:30%">
													<col style="width:30%">
													<col>
												</colgroup>
												<thead>
													<tr>
														<th>총 대출금액</th>
														<th>대출건수</th>
														<th>총 상환 금액</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><?php echo number_format($total_loan_pay);?> 원</td>
														<td><?php echo $total_loan_cnt;?> 건</td>
														<td><?php echo number_format($total_lb_pay);?> 원</td>
													</tr>
												</tbody>
											</table>
										</li>
									</ul>
								</div>
							</div>
              <script>
              function view_calc(no) {
                //iw_table , iw_popup_cont
                var data =  $("#calcform_"+no).serialize();
                $.post("/pnpinvest/?mode=calculation", data, function (html){
                  $("#iw_popup_cont").html (html);
                  $('.iw_popup').fadeIn('fast');
                  $('.iw_popup .iwp_sum').fadeIn('fast');
                });
              }
              </script>

							<div class="my_condition">
								<h4>대출현황 <span class="pc">현재 대출 정보를 확인하실 수 있습니다.</span></h4>
								<table class="table_green">
									<caption>대출현황</caption>
									<thead>
										<thead>
											<tr>
												<th>제목</th>
												<th>신청금액</th>
												<th>현재 투자인원</th>
												<th>현재 투자금액</th>
												<th>진행율</th>
												<th>접수일</th>
												<th>상태</th>
												<th class="pc">납입 금액 확인</th>
											</tr>
										</thead>
									</thead>
									<tbody>
										<!-- 내용이 없을 때 -->
                    <?php if ( !$loan_qry) { ?>
										<tr>
											<td colspan="8">대출 신청 정보가 없습니다.</td>
										</tr>
                    <?php } ?>
										<!-- // 내용이 없을 때 -->
                    <?php
                    $i = 0;
                    while ($row =sql_fetch_array($loan_qry)){
                    ?>
                    <form name="calcform_<?php echo $i; ?>" id="calcform_<?php echo $i; ?>">
										<input type="hidden" name="i_loan_day" value="<?php echo $row[i_loan_day]; ?>">
										<input type="hidden" name="i_year_plus" value="<?php echo $row[i_year_plus]; ?>">
										<input type="hidden" name="i_repay" value="<?php echo $row[i_repay]; ?>">
										<input type="hidden" name="i_loan_pay" value="<?php echo $row[i_loan_pay]; ?>">
										<input type="hidden" name="loan_id" value="<?php echo $row[i_id]; ?>">
										<input type="hidden" name="stype" value="loan"/>
										<tr>
											<td><?php echo $row['i_subject']?></td>
											<td><?php echo number_format($row['i_loan_pay'])?>원</td>
											<td><?php echo $row['cnt']?>명</td>
											<td><?php echo number_format($row['total'])?>원</td>
											<td><?php echo $row['perct']?>%</td>
											<td><?php echo $row['regdate']?></td>
											<td><?php echo $row['lookstatus']?></td>
											<td class="pc"><a href="javascript:;" onClick="view_calc(<?php echo $i ?>)">납입금액확인</a></td>
										</tr>
                  </form>
                  <?php
                    $i++;
                    }
                    if ($i == 0) echo '<tr><td colspan="8">대출 내역이 없습니다.</td></tr>';
                  ?>

									</tbody>
								</table>
								<p class="right">
							<!--href="/pnpinvest/?mode=mypage_loanstatus" class="btn more">더보기</a>-->
								<a href="#" class="btn more2">더보기</a>
								</p>

							</div>

							<div class="my_condition">
								<h4>입금현황 <span class="pc">현재 입금현황을 확인하실 수 있습니다.</span></h4>
								<table class="table_green">
									<caption>입금현황</caption>
									<thead>
										<thead>
											<tr>
												<th>채권</th>
												<th>상환일</th>
												<th>차수/만기</th>
												<th>입금액</th>
												<th>상태</th>
											</tr>
										</thead>
									</thead>
									<tbody>
                    <?php
                    $i=0;
                    while ($row = sql_fetch_array($order)){
                    ?>
										<tr>
											<td><?php echo $row['o_subject']?></td>
											<td><?php echo $row['o_collectiondate']?></td>
											<td><?php echo $row['o_count']?>/<?php echo $row['i_loan_day']?></td>
											<td><?php echo number_format($row['payed'])?>원</td>
											<td><?php echo $row['lookstatus']?></td>
										</tr>
                  <?php
                    $i ++;
                  }
                  if ($i == 0 ) { ?>
                  <!-- 내용이 없을 때 -->
                  <tr>
                    <td colspan="5">입금정보가 없습니다.</td>
                  </tr>
                  <!-- // 내용이 없을 때 -->
                  <?php } ?>
									</tbody>
								</table>
								<p class="right">
								<a href="#" class="btn more2" style="margin-bottom:25px;">더보기</a>
								</p>
							</div>

						</div>
						<!-- // 대출 관리 end -->
						<!-- 대출 상환 스케줄 start -->
						<div class="mytab_con my_schedule">
							<div class="clearfix">
								<div class="my_left">
									<h4>상환스케줄 <span class="pc">현재까지 대출한 내역에 대한 상환스케줄입니다.</span></h4>
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
      if($cnt >= 5) break;
      $cnt ++;
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
      if($cnt >= 5) break;
      $cnt ++;
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
    if($cnt >= 5) break;
      }

       if ($i == 0)
          echo "<tr><td colspan=\"6\">스케줄 정보가 없습니다.</td></tr>";
    ?>
<!-- end -->
									</tbody>
								</table>
								<p class="right">
								<a href="#" class="btn more2">더보기</a>
								</p>
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
