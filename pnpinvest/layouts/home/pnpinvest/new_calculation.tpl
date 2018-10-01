<?php
if (in_array($_POST['loan_id'], array('384','387') ) ) { ?>
<script type="text/javascript"> location.href="/api/index.php/calcultemp?loan_id=<?php echo $_POST['loan_id'] ?>&i_payment=<?php echo $_POST['i_pay']?>"; </script>';
<?php
exit;
}

include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});
</script>

	<div class="terms_wrap">

		<table class="iw_table">
			<colgroup>
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><?php echo $stype=='loan'?'대출금액':'투자금액';?></th>
					<td><?php echo number_format($ln_money) ?>원</td>
					<th>상환기간</th>
					<td><?php echo $ln_kigan?>개월</td>
					<th>금리</th>
					<td><?php echo $ln_iyul?>% </td>
					<th>상환방식</th>
					<td><?php echo $i_repay?></td>
				</tr>
			</tbody>
		</table>
		<!-- <h4 class="invest_title5"><?php echo $stype=='loan'?'대출금액':'투자금액';?> : <?php echo number_format($ln_money) ?>원 상환기간 : <?php echo $ln_kigan?>개월 금리 : <?php echo $ln_iyul?>% 상환 방식 : <?php echo $i_repay?></h4> -->
		<table class="iw_table">
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th>회차</th>
					<th><?php echo $stype=='loan'?'상환금':'수익금';?></th>
					<th>납입원금</th>
					<th>이자</th>
					<th>납입원금계</th>
					<th>잔금</th>
				</tr>

			</thead>
			<tbody>
<?php
/* start 일만기일시상환 */
if($i_repay=="일만기일시상환"){
	include (getcwd().'/module/mode_calculation.php');
	$cnt  = count($timetable)-1;
	$invtotal=0;
	if(!$startstatus || !$endstatus ){
		?>
		<tr><td colspan=6 style="text-align:center;font-size:15px;padding:50px 0;">현재 계약 진행중인 상품입니다.</td></tr>
		<?php
	}else {
		$principaltotal = 0;

		if( isset($repayArr) &&  count($repayArr) > count($timetable)) $len = count($repayArr);
		else $len = count($timetable);
		for($idx=0 ; $idx < $len ;$idx++){

		//}
//	foreach($timetable as $idx => $timetablerow){
		if(isset($repayArr[$idx]) ){
			$inv = (int)$repayArr[$idx]["o_investamount"];
			$status = $repayArr[$idx]["o_salestatus"];
			$repaydate = $repayArr[$idx]["o_datetime_formated"];
			$principal = ( $repayArr[$idx]["o_interest"] - $repayArr[$idx]["o_investamount"] );
		}else {
			$timetablerow = $timetable[$idx];
			$inv = (int)($timetablerow['inv']['정상이자']+$timetablerow['inv']['상환이자']);
			$status ="정산예정";
			$repaydate = $st_cal->format_date($timetablerow['end']);
			$principal = ($cnt==$idx) ? $ln_money-$principaltotal:0;
		}
		$principaltotal += $principal;
		$invtotal += $inv;
		 ?>
	<tr>

		<td style="text-align:center"><p class="numbering2"><?=$idx+1?>회차</p><?php echo $repaydate.' ('.$status.')' ?> </td>
		<td><?=number_format((int)($inv+$principal))?>원</td>
		<td><?=number_format((int)($principal))?>원</td>
		<td><?=number_format($inv)?>원</td>
		<td><?=number_format((int)($principal))?>원</td>
		<td><?=number_format((int)($ln_money -$principaltotal ))?>원</td>
	</tr>
<?php
	} ?>
	<tr>
		<td style="text-align:center">계</td>
		<td><?php echo number_format($principaltotal + $invtotal ) ?> 원</td>
		<td><?php echo number_format($principaltotal) ?> 원</td>
		<td><?php echo number_format($invtotal) ?> 원</td>
		<td></td>
		<td><?=number_format((int)($ln_money -$principaltotal ))?>원</td>
	</tr>
<?php } ?>
</tbody>
</table>
<?php if($startstatus && $endstatus) { ?>
<div style="text-align:right;margin-top:10px;padding-right:30px;font-size:15px;">* 대출 실행일은 <?php echo $st_cal->format_date($loanexecutiondate); ?> 입니다.</div>
<?php } ?>
</div>
<?php
	return;
}
/* END 일만기일시상환 */
?>
	<?php
	//원리금균등분할상환
	if($i_repay=="원리금균등상환"){
	?>
	<?php

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
			?>
				<tr>
					<td><?=$i?>회차</td>
					<td><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
					<td><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
					<td><?=number_format($첫달이자)?>원</td>
					<td><?=$잔금>0?number_format($납입원금계):number_format($ln_money)?>원</td>
					<td><?=$잔금>0?number_format($잔금):"0"?>원</td>
				</tr>
			<?php
					$이자합산 += $첫달이자;
					$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
					$월불입금합산=$납입원금합산+$이자합산;
					$일년이자 = $잔금*($ln_iyul/100);
					$첫달이자 = substr(($일년이자/12),0,-1)."0";
				}

			   if ($i == 0)
			      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
			?>
	<?php
	}else{
	?>
			<?php
			$일년이자 = $ln_money*($ln_iyul/100);
			$첫달이자 = substr(($일년이자/12),0,-1)."0";
			$ln_kigan_con=$ln_kigan-1;
			$전체이자=$첫달이자*$ln_kigan_con;

			switch ( $loan_id ){
				//제26호 화성시 서신면 궁평리 전원주택부지 담보대출 1차
				//마지막회차 9일치
				case( '259' ) :
					$ln_kigan++;
					$last = round($ln_money*$ln_iyul/100/365*9);
					break;
				//제27호 화성시 서신면 궁평리 전원주택부지 담보대출 2차
				//마지막회차 4일치
				case( '265' ) :
					$ln_kigan++;
					$last = round($ln_money*$ln_iyul/100/365*4);
					break;
				default :
					$last = $첫달이자;
			}
			for($i=1; $i<=$ln_kigan; $i++){
			?>
				<tr>
					<td><?=$i?>회차</td>
					<td>
					<?=$i==$ln_kigan?number_format($ln_money+$last):number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=($i==$ln_kigan ) ? number_format($last) : number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=$i==$ln_kigan?"0":number_format($ln_money)?>원</td>
				</tr>
			<?php
			$이자합산 += (  round(( $i==$ln_kigan ) ? $last : $첫달이자)  );
			$만기이자= $i==$ln_kigan ? $ln_money+$첫달이자 :$첫달이자+$전체이자;
			$월불입금합산=$만기이자+$전체이자;
				}

			   if ($i == 0)
			      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
			?>
	<?php }?>
	<?php if($i_repay=="원리금균등상환"){?>
				<tr>
					<td>계</td>
					<td><?php echo number_format($ln_money + $이자합산) ?> 원</td>
					<td><?php echo number_format($ln_money) ?> 원</td>
					<td><?php echo number_format($이자합산) ?> 원</td>
					<td></td>
					<td></td>
				</tr>
	<?php }else{?>
				<tr>
					<td>계</td>
					<td><?php echo number_format($ln_money + $이자합산) ?> 원</td>
					<td><?php echo number_format($ln_money) ?> 원</td>
					<td><?php echo number_format($이자합산) ?> 원</td>
					<td></td>
					<td></td>
				</tr>
	<?php }?>
			</tbody>
		</table>
		<?php if ($loan_id == '387' ||$loan_id == '384' ) {?>
			<div style="padding:15px;font-size:13px;">
			<p>* 원금균등상환 및 원리금균등상환의 납입원금 및 이자금액은 정산금액과 상이할 수 있습니다.</p><p style="padding:10px;">이 점 양해바랍니다.</p>
			</div>
		<?php } ?>

	</div><!-- /terms_wrap -->
