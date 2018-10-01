<?php
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
{#header} 
<section id="container">
<input type="hidden" name="stype" value="<?php echo $stype;?>">
		<section id="sub_content">
			<div class="mypage_wrap">
				<div class="container">
					<div class="my_inner2">
                        <table class="type3 mt30 mb70">
                                <colgroup>
                                    <col width="" />
                                    <col width="" />
                                    <col width="" />
                                    <col width="" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th><?php echo $stype=='loan'?'대출금액':'투자금액';?></th>
                                        <th>상환기간</th>
                                        <th>금리</th>
                                        <th>상환방식</th>
                                    </tr>
                                </thead>
                                <tbody>
                                        <tr>
                                                <td><?php echo number_format($ln_money) ?>원</td>
                                                <td><?php echo $ln_kigan?>개월</td>
                                                <td><?php echo $ln_iyul?>% </td>
                                                <td><?php echo $i_repay?></td>
                                        </tr>
                                </tbody>
                            </table>
                        <table class="type3 mb70">
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
		$첫달이자 = substr(round($일년이자/12),0,-1)."0";
	?>
			<?php
			$sumPrice = "0"; 
			$rate = (($ln_iyul/100)/12); 
			$상환금 = round($ln_money*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 
			for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
				$납입원금계 += ($상환금-$첫달이자);
				$잔금 = $ln_money-$납입원금계;
				$납입원금 = $상환금-$첫달이자;
				$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
			?>
				<tr>
					<td><?=$i?></td>
					<td><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
					<td><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
					<td><?=number_format($첫달이자)?>원</td>
					<td><?=$잔금>0?number_format($납입원금계):number_format($ln_money)?>원</td>
					<td><?=$잔금>0?number_format($잔금):"0"?>원</td>
				</tr>
			<?php
					$이자합산 += $첫달이자;

					$일년이자 = $잔금*($ln_iyul/100);
					$첫달이자 = substr(round($일년이자/12),0,-1)."0";
				} 

			   if ($i == 0)
			      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
			?>
	<?php
	}else{
	?> 
			<?php
			$일년이자 = $ln_money*($ln_iyul/100);
			$첫달이자 = substr(round($일년이자/12),0,-1)."0";

			for($i=1; $i<=$ln_kigan; $i++){
			?>
				<tr>
					<td><?=$i?></td>
					<td>
					<?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=number_format($첫달이자)?>원</td>
					<td><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
					<td><?=$i==$ln_kigan?"0":number_format($ln_money)?>원</td>
				</tr>
			<?php
			$이자합산 += $첫달이자;
				} 

			   if ($i == 0)
			      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
			?>
	<?php }?>
	<?php if($i_repay=="원리금균등상환"){?>
				<tr>
					<td>계</td>
					<td><?php echo number_format($sale_totalmoney) ?> 원</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
	<?php }else{?>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
	<?php }?>
			</tbody>
                            </table>
			    </div>
			    </div>
			    </section>
			    </section>
{# footer}<!--하단-->