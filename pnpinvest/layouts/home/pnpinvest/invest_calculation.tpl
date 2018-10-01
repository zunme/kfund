<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#header}
<section id="container">
	<section id="sub_content">
		<div class="">	
			<div class="invest_calculation">
			<form  id="invest_calculation" name="invest_calculation"  method="get">
			<input type="hidden" name="mode" value="invest_calculation">
			<input type="hidden" name="loan_id" value="<?php echo $loan_id;?>">
				<div class="calculation">
					<h5>투자 수익 계산</h5>
					<p>입력란에 투자 금액을 입력하시면<br/>수익에 대한 정보를 확인하실 수 있습니다.</p>

					<input type="text" name="loan_pay" value="<?php echo $loan_pay;?>" placeholder="투자 금액을 입력해 주세요"/>
					<?php if(!$loan_id){?>
					<input type="text" name="loan_day" value="<?php echo $loan_day;?>" placeholder="투자기간을 입력해 주세요(단위 : 개월)"/>
					<input type="text" name="year_plus" value="<?php echo $year_plus;?>" placeholder="수익률을 입력해 주세요(단위 : %)"/>
					<?php }?>
					<input type="submit" class="invest_search_btn" value="">

					<div class="invest_amount">
						<p><strong>\<?php echo number_format($loan_pay);?></strong>원</p>
						
					</div>
				</div>
			</form>
				<div class="calculation_info">
					<h5>상세내역</h5>
					<img src="{MARI_HOMESKIN_URL}/img/bg_invest_line2.png" alt=""/>
					<table class="calculation_table mt15">
						<colgroup>
							<col width="50%">
							<col width="">
						</colgroup>
						<tbody>

					<?php

							/*수수료,원천징수,연체설정정보*/
							$sql = "select * from  mari_inset";
							$is_ck = sql_fetch($sql, false);

							/*개인,법인 수수료&원천징수 수수료설정*/
							if($user[m_level]=="2"){
								if($user['m_signpurpose']=="I"){
									$i_profit=$is_ck['i_profit_in'];//소득적격투자자
									$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
									$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
								}else if($user['m_signpurpose']=="P"){
									$i_profit=$is_ck['i_profit_pro'];//전문투자자
									$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
									$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
								}else{
									$profit=$is_ck['i_profit'];
									$i_profit=$is_ck['i_withholding_personal'];
									$i_profit_v=$is_ck['i_withholding_personal_v'];
								}
							}else if($user[m_level]>=3){
								$profit=$is_ck['i_profit_v'];
								$i_profit=$is_ck['i_withholding_burr'];
								$i_profit_v=$is_ck['i_withholding_burr_v'];
							}else{
								$profit=$is_ck['i_profit'];
								$i_profit=$is_ck['i_withholding_personal'];
								$i_profit_v=$is_ck['i_withholding_personal_v'];
							}


							if(!$loan_pay){
								$loan_pay="10000000";
							}
							$loan_pay_p=$loan_pay;
							if(!$loan_id){
								$ln_kigan="6"; //대출기간 
								$ln_iyul="10"; //대출이율 
							}else{
								$ln_kigan=$loa['i_loan_day']; //대출기간 
								$ln_iyul=$loa['i_year_plus']; //대출이율 
							}
					//원리금균등분할상환 
					if($loa['i_repay']=="원리금균등상환"){

							$ln_kigan = $ln_kigan - $stop;

							$일년이자 = $loan_pay_p*($ln_iyul/100);
							$첫달이자 = substr(($일년이자/12),0,-1)."0";

							$sumPrice = "0"; 
							$rate = (($ln_iyul/100)/12); 
							$상환금_A = ($loan_pay_p*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 

							for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
								$납입원금_A += ($상환금_A-$첫달이자);
								$잔금 = $loan_pay_p-$납입원금_A;
								$sumPrice+=$잔금>0?number_format($상환금_A):number_format($납입원금_A+$잔금+$첫달이자);


								$이자합산 += $첫달이자;
								$납입원금_A합산=$loan_pay_p;
								$월불입금합산=$납입원금_A합산+$이자합산;
								$수수료=$납입원금_A합산*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a+=$첫달이자*$i_profit;
								$withholding_b+=$첫달이자*$i_profit_v;
								$withholding=func($withholding_a)+func($withholding_b);

								$일년이자 = $잔금*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$원천징수수수료+=$withholding;
								$실투자수익=$월불입금합산-$수수료-$원천징수수수료;
							} 
					}else{
							$일년이자 = $loan_pay*($ln_iyul/100);
							$첫달이자 = substr(($일년이자/12),0,-1)."0";
							$ln_kigan_con=$ln_kigan;
							$ln_kigan_con=$ln_kigan_con-1;
							$전체이자=$첫달이자*$ln_kigan_con;
							for($i=1; $i<=$ln_kigan; $i++){

								$이자합산 += $첫달이자;
								$만기이자=$i==$ln_kigan?$loan_pay+$첫달이자:$첫달이자+$전체이자;
								$월불입금합산=$만기이자+$전체이자;

								$수수료=$이자합산*$is_ck['i_profit'];
								$수수료마지막달=$loan_pay*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$withholding=func($withholding_a)+func($withholding_b);

								if($ln_kigan==$i){
									$수수료빼기=$수수료/$ln_kigan;
									$수수료=$수수료+$수수료마지막달-$수수료빼기;
								}else{
									$수수료=$수수료+$수수료마지막달;
								}

								$원천징수수수료+=$withholding;
								$실투자수익=$월불입금합산-$수수료합산-$원천징수수수료;

							}
					}
							?>


							<tr>
								<th>투자원금</th>
								<td><strong><?php echo number_format($loan_pay) ?></strong>원</td>
								<th>투자기간</th>
								<td><strong><?php echo $ln_kigan;?></strong>개월</td>
								<th>이자수익</th>
								<td><strong><?php echo number_format($이자합산) ?></strong>원</td>
							</tr>
						</tbody>
					</table>

					<table class="calculation_table mt15">
						<colgroup>
							<col width="50%">
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th>수수료</th>
								<td><strong><?php echo number_format(($수수료합산)) ?></strong>원</td>
								<th>세금</th><td><strong><?php if(!$member_ck){?>로그인필요<?php }else{?><?php echo number_format(($원천징수수수료)) ?><?php }?></strong>원</td>
								<th>총수익</th><td><strong><?php echo number_format($실투자수익);?></strong>원</td>
							</tr>
						</tbody>
					</table>

					<table class="calculation_table2 mt15">
						<colgroup>
							<col width="">
							<col width="">
						</colgroup>
						<tbody>
				<?php
				//원리금균등분할상환 
				/*수수료,원천징수,연체설정정보*/
				$sql = "select * from  mari_inset";
				$is_ck = sql_fetch($sql, false);
				if($loa['i_repay']=="원리금균등상환"){
				?>
				<?php

					$ln_kigan = $ln_kigan - $stop;

					$일년이자 = $loan_pay*($ln_iyul/100);
					$첫달이자 = substr(($일년이자/12),0,-1)."0";
				?>
					<?php
					$sumPrice = "0"; 
					$rate = (($ln_iyul/100)/12); 
					$상환금 = ($loan_pay*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 
					for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
								$납입원금계 += ($상환금-$첫달이자);
								$잔금 = $loan_pay-$납입원금계;
								$납입원금 = $상환금-$첫달이자;
								$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
								$수수료=$납입원금*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$원천징수수수료=func($withholding_a)+func($withholding_b);
					?>
							<tr>
								<th>회차</th>
								<td><?=$i?>회차</td>
							</tr>
							<tr>
								<th>원금</th>
								<td><strong><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?></strong>원</td>
							</tr>
							<tr>
								<th>이자</th>
								<td><strong><?=number_format($첫달이자)?></strong>원</td>
							</tr>
							<tr>
								<th>수수료</th>
								<td><strong><?=number_format($수수료)?></strong>원</td>
							<tr>
								<th>세금</th>
								<td><strong><?=number_format($원천징수수수료)?></strong>원</td>
							</tr>

			<?php
				$이자합산 += $첫달이자;
				$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
				$월불입금합산=$납입원금합산+$이자합산;
				$전체수수료=$납입원금합산*$is_ck['i_profit'];
				$전체원천징수수수료=$이자합산*$is_ck['i_profit'];
				$전체실투자수익=$월불입금합산-$전체수수료-$전체원천징수수수료;
				$일년이자 = $잔금*($ln_iyul/100);
				$첫달이자 = substr(($일년이자/12),0,-1)."0";
				} 

			   if ($i == 0)
			      echo "정보가 없습니다.";
			?>
		<?php
		}else{
		?> 
							<?php
								$일년이자 = $loan_pay*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$ln_kigan_con=$ln_kigan-1;
								$전체이자=$첫달이자*$ln_kigan_con;
								for($i=1; $i<=$ln_kigan; $i++){
								if($i==$ln_kigan){
								$수수료마지막달=$loan_pay*$is_ck['i_profit'];
								$수수료=$수수료마지막달;
								}else{
									$수수료=$첫달이자*$is_ck['i_profit'];
								}

								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$원천징수수수료=func($withholding_a)+func($withholding_b);


							?>
							<tr>
								<th>회차</th>
								<td><strong><?=$i?>회차</strong></td>
							</tr>
							<tr>
								<th>원금</th>
								<td><strong><?=$i==$ln_kigan?number_format($loan_pay):"0"?></strong>원</td>
							</tr>
							<tr>
								<th>이자</th>
								<td><strong><?=number_format($첫달이자)?></strong>원</td>
							</tr>
							<tr>
								<th>수수료</th>
								<td><strong><?=number_format($수수료)?></strong>원</td>
							<tr>
								<th>세금</th>
								<td><strong><?=number_format($원천징수수수료)?></strong>원</td>
							</tr>
							<tr>
								<th>&nbsp;</th>
								<td>&nbsp;</td>
							</tr>
			<?php
					$이자합산 += $첫달이자;
					$만기이자=$i==$ln_kigan?$loan_pay+$첫달이자:$첫달이자+$전체이자;
					$월불입금합산=$만기이자+$전체이자;
					$전체수수료=$이자합산*$is_ck['i_profit'];
					$전체원천징수수수료=$이자합산*$is_ck['i_profit'];
					$전체실투자수익=$월불입금합산-$전체수수료-$전체원천징수수수료;
				} 

			   if ($i == 0)
			      echo "정보가 없습니다.";
			?>
	<?php }?>
						</tbody>
					</table>
					
					<table class="calculation_table2 mt15">
						<colgroup>
							<col width=85px>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th>실입금액</th><td><strong><?php echo number_format($실투자수익) ?></strong>원</td>
							</tr>
						</tbody>
					</table>
					<p class="mt15">
						<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>총수익 = 원금 + 이자 - 수수료 - 세금<br/>
						<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>이자소득에 대한 세금이 원천 징수되어 차감후 금액이 입금 됩니다.<br/>
						<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>만기일시상환 방식은 매월 이자 금액이 동일하며 만기일에 원금을 상환합니다<br/>
					</p>	
				</div>
			</div>
		</div>	
	</section>
</section>
<script>
function cnj_comma(cnj_str) { 
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = ""; 
		var cnjValue2 = "";

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		for(i=0; i<cnj_str.value.length; i++)      {   
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") { 
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2; 
		} 
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue; 
		} else { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue; 
		} 
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}
</script>


<?php }else{?>
{# header_sub}

<div id="container">
	<div id="main_content">

		<div class="invest_calculation">
			<form  id="invest_calculation" name="invest_calculation"  method="get">
			<input type="hidden" name="mode" value="invest_calculation">
			<input type="hidden" name="loan_id" value="<?php echo $loan_id;?>">
				<div class="calculation">
					<h5>투자 수익 계산</h5>
					<p>입력란에 투자 금액을 입력하시면<br/>수익에 대한 정보를 확인하실 수 있습니다.</p>

					<input type="text" name="loan_pay" value="<?php echo $loan_pay;?>" placeholder="투자 금액을 입력해 주세요"/>
					<input type="submit" class="invest_search_btn" value="계산">

					<div class="invest_amount">
						<p><strong>\<?php echo number_format($loan_pay);?></strong>원</p>						
					</div>
				</div>
			</form>


			<div class="calculation_info">
				<h5>상세내역</h5>
				<img src="{MARI_HOMESKIN_URL}/img/bg_invest_line2.png" alt=""/>
				<table class="calculation_table mt15">
					<colgroup>
						<col width=85px>
						<col width=120px>
						<col width=85px>
						<col width=120px>
						<col width=85px>
						<col width=120px>
					</colgroup>
					<tbody>
					<?php
							/*수수료,원천징수,연체설정정보*/
							$sql = "select * from  mari_inset";
							$is_ck = sql_fetch($sql, false);

							/*개인,법인 수수료&원천징수 수수료설정*/
							if($user[m_level]=="2"){
								if($user['m_signpurpose']=="I"){
									$i_profit=$is_ck['i_profit_in'];//소득적격투자자
									$i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
									$i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
								}else if($user['m_signpurpose']=="P"){
									$i_profit=$is_ck['i_profit_pro'];//전문투자자
									$i_withholding=$is_ck['i_withholding_pro'];//전문투자자
									$i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
								}else{
									$profit=$is_ck['i_profit'];
									$i_profit=$is_ck['i_withholding_personal'];
									$i_profit_v=$is_ck['i_withholding_personal_v'];
								}
							}else if($user[m_level]>=3){
								$profit=$is_ck['i_profit_v'];
								$i_profit=$is_ck['i_withholding_burr'];
								$i_profit_v=$is_ck['i_withholding_burr_v'];
							}else{
								$profit=$is_ck['i_profit'];
								$i_profit=$is_ck['i_withholding_personal'];
								$i_profit_v=$is_ck['i_withholding_personal_v'];
							}



							if(!$loan_pay){
								$loan_pay="10000000";
							}
							$loan_pay_p=$loan_pay;
							if(!$loan_id){
								$ln_kigan="6"; //대출기간 
								$ln_iyul="10"; //대출이율 
							}else{
								$ln_kigan=$loa['i_loan_day']; //대출기간 
								$ln_iyul=$loa['i_year_plus']; //대출이율 
							}
					//원리금균등분할상환 
					if($loa['i_repay']=="원리금균등상환"){

							$ln_kigan = $ln_kigan - $stop;

							$일년이자 = $loan_pay_p*($ln_iyul/100);
							$첫달이자 = substr(($일년이자/12),0,-1)."0";

							$sumPrice = "0"; 
							$rate = (($ln_iyul/100)/12); 
							$상환금_A = ($loan_pay_p*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 

							for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
								$납입원금_A += ($상환금_A-$첫달이자);
								$잔금 = $loan_pay_p-$납입원금_A;
								$sumPrice+=$잔금>0?number_format($상환금_A):number_format($납입원금_A+$잔금+$첫달이자);


								$이자합산 += $첫달이자;
								$납입원금_A합산=$loan_pay_p;
								$월불입금합산=$납입원금_A합산+$이자합산;
								$수수료=$납입원금_A합산*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a+=$첫달이자*$i_profit;
								$withholding_b+=$첫달이자*$i_profit_v;
								$withholding=func($withholding_a)+func($withholding_b);

								$일년이자 = $잔금*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$원천징수수수료+=$withholding;
								$실투자수익=$월불입금합산-$수수료-$원천징수수수료;
							} 
					}else{
							$일년이자 = $loan_pay*($ln_iyul/100);
							$첫달이자 = substr(($일년이자/12),0,-1)."0";
							$ln_kigan_con=$ln_kigan;
							$ln_kigan_con=$ln_kigan_con-1;
							$전체이자=$첫달이자*$ln_kigan_con;
							for($i=1; $i<=$ln_kigan; $i++){

								$이자합산 += $첫달이자;
								$만기이자=$i==$ln_kigan?$loan_pay+$첫달이자:$첫달이자+$전체이자;
								$월불입금합산=$만기이자+$전체이자;

								$수수료=$이자합산*$is_ck['i_profit'];
								$수수료마지막달=$loan_pay*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$withholding=func($withholding_a)+func($withholding_b);

								if($ln_kigan==$i){
									$수수료빼기=$수수료/$ln_kigan;
									$수수료=$수수료+$수수료마지막달-$수수료빼기;
								}else{
									$수수료=$수수료+$수수료마지막달;
								}

								$원천징수수수료+=$withholding;
								$실투자수익=$월불입금합산-$수수료합산-$원천징수수수료;
							}
					}
							?>
							<tr>
								<th>투자원금</th>
								<td><strong><?php echo number_format($loan_pay) ?></strong>원</td>
								<th>투자기간</th>
								<td><strong><?php echo $ln_kigan;?></strong>개월</td>
								<th>이자수익</th>
								<td><strong><?php echo number_format($이자합산) ?></strong>원</td>
							</tr>
					</tbody>
				</table>

				<table class="calculation_table mt15">
					<colgroup>
						<col width=85px>
						<col width=120px>
						<col width=85px>
						<col width=120px>
						<col width=85px>
						<col width=120px>
					</colgroup>
					<tbody>
							<tr>
								<th>수수료</th>
								<td><strong><?php echo number_format(($수수료합산)) ?></strong>원</td>
								<th>세금</th>
								<td><strong><?php if(!$member_ck){?>로그인필요<?php }else{?><?php echo number_format(($원천징수수수료)) ?><?php }?></strong>원</td>
								<th>세후수익</th>
								<td><strong><?php echo number_format($실투자수익);?></strong>원</td>
							</tr>
					</tbody>
				</table>

				<table class="calculation_table2 mt15">
					<colgroup>
						<col width="">
						<col width="">
						<col width="">
						<col width="">
						<col width="">
					</colgroup>
					<thead>
						<tr>
							<th>회차</th>
							<th>원금</th>
							<th>이자</th>
							<th>수수료</th>
							<th>세금</th>
						</tr>
					</thead>
					<tbody>
	<?php
	//원리금균등분할상환 
	/*수수료,원천징수,연체설정정보*/
	$sql = "select * from  mari_inset";
	$is_ck = sql_fetch($sql, false);
					if($loa['i_repay']=="원리금균등상환"){
					?>
					<?php

						$ln_kigan = $ln_kigan - $stop;

						$일년이자 = $loan_pay*($ln_iyul/100);
						$첫달이자 = substr(($일년이자/12),0,-1)."0";
					?>
							<?php
							$sumPrice = "0"; 
							$rate = (($ln_iyul/100)/12); 
							$상환금 = ($loan_pay*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 
							for($i=$stop+1;$i<=$stop+$ln_kigan;$i++) { 
								$납입원금계 += ($상환금-$첫달이자);
								$잔금 = $loan_pay-$납입원금계;
								$납입원금 = $상환금-$첫달이자;
								$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
								$수수료=$납입원금*$is_ck['i_profit'];
								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$원천징수수수료=func($withholding_a)+func($withholding_b);
							?>
										<tr>
											<td><strong><?=$i?>회차</strong></td>
											<td><strong><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?></strong>원</td>
											<td><strong><?=number_format($첫달이자)?></strong>원</td>
											<td><strong><?=number_format($수수료)?></strong>원</td>
											<td><strong><?=number_format($원천징수수수료)?></strong>원</td>
										</tr>
							<?php
									$이자합산 += $첫달이자;
									$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
									$월불입금합산=$납입원금합산+$이자합산;
									$전체수수료=$납입원금합산*$is_ck['i_profit'];
									$전체원천징수수수료=$이자합산*$is_ck['i_profit'];
									$전체실투자수익=$월불입금합산-$전체수수료-$전체원천징수수수료;
									$일년이자 = $잔금*($ln_iyul/100);
									$첫달이자 = substr(($일년이자/12),0,-1)."0";
								} 

							   if ($i == 0)
								  echo "정보가 없습니다.";
							?>
					<?php
					}else{
					?> 
								<?php
								$일년이자 = $loan_pay*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$ln_kigan_con=$ln_kigan-1;
								$전체이자=$첫달이자*$ln_kigan_con;
								for($i=1; $i<=$ln_kigan; $i++){
								if($i==$ln_kigan){
								$수수료마지막달=$loan_pay*$is_ck['i_profit'];
								$수수료=$수수료마지막달;
								}else{
									$수수료=$첫달이자*$is_ck['i_profit'];
								}

								/*이자소득세 a 주민세 b 2017-07-24*/
								$withholding_a=$첫달이자*$i_profit;
								$withholding_b=$첫달이자*$i_profit_v;
								$원천징수수수료=func($withholding_a)+func($withholding_b);
								?>
						<tr>
							<td><strong><?=$i?>회차</strong></td>
							<td><strong><?=$i==$ln_kigan?number_format($loan_pay):"0"?></strong>원</td>
							<td><strong><?=number_format($첫달이자)?></strong>원</td>
							<td><strong><?=number_format($수수료)?></strong>원</td>
							<td><strong><?=number_format($원천징수수수료)?></strong>원</td>
						</tr>
					<?php
					$이자합산 += $첫달이자;
					$만기이자=$i==$ln_kigan?$loan_pay+$첫달이자:$첫달이자+$전체이자;
					$월불입금합산=$만기이자+$전체이자;
					$전체수수료=$이자합산*$is_ck['i_profit'];
					$전체원천징수수수료=$이자합산*$is_ck['i_profit'];
					$전체실투자수익=$월불입금합산-$전체수수료-$전체원천징수수수료;
						} 

					   if ($i == 0)
					      echo "정보가 없습니다.";
					?>
	<?php }?>
					</tbody>
				</table>
				
					<table class="calculation_table2 mt15">
						<colgroup>
							<col width=85px>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th>실입금액</th><td><strong><?php echo number_format($실투자수익) ?></strong>원</td>
							</tr>
						</tbody>
					</table>
				<p class="mt15">
					<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>총수익 = 원금 + 이자 - 수수료 - 세금<br/>
					<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>이자소득에 대한 세금이 원천 징수되어 차감후 금액이 입금 됩니다.<br/>
					<img src="{MARI_HOMESKIN_URL}/img/icon_invest_list.png" alt=""/>만기일시상환 방식은 매월 이자 금액이 동일하며 만기일에 원금을 상환합니다<br/>
				</p>	
			</div>
		</div>
	</div><!--//main_content e -->
</div><!--//container e -->
<script>
function cnj_comma(cnj_str) { 
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = ""; 
		var cnjValue2 = "";

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		for(i=0; i<cnj_str.value.length; i++)      {   
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") { 
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2; 
		} 
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue; 
		} else { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue; 
		} 
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}
</script>
<?}?>
{#footer}