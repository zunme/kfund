<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/common.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/content.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css">
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/javascript.js"></script>
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
		<div class="terms_logo"><img src="{MARI_DATA_URL}/favicon/{_config['c_logo']}" alt="{_config['c_title']}"/></div>
		<table class="type13 mb20">
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
		<table class="type13">
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
			for($i=1; $i<=$ln_kigan; $i++){
			?>
				<tr>
					<td><?=$i?>회차</td>
					<td>
					<?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=$i==$ln_kigan?"0":number_format($ln_money)?>원</td>
				</tr>
			<?php
			$이자합산 += $첫달이자;
			$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
			$월불입금합산=$만기이자+$전체이자;
				} 

			   if ($i == 0)
			      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
			?>
	<?php }?>
	<?php if($i_repay=="원리금균등상환"){?>
				<tr>
					<td>계</td>
					<td><?php echo number_format($월불입금합산) ?> 원</td>
					<td><?php echo number_format($납입원금합산) ?> 원</td>
					<td><?php echo number_format($이자합산) ?> 원</td>
					<td></td>
					<td></td>
				</tr>
	<?php }else{?>
				<tr>
					<td>계</td>
					<td><?php echo number_format($월불입금합산) ?> 원</td>
					<td><?php echo number_format($ln_money) ?> 원</td>
					<td><?php echo number_format($이자합산) ?> 원</td>
					<td></td>
					<td></td>
				</tr>
	<?php }?>
			</tbody>
		</table>

	</div><!-- /terms_wrap -->
