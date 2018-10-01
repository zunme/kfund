<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<div id="container">
	<div id="sub_content">
		<div class="mypage" >
			<div class="mypage_inner">

				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong>예치금 : <span class=""><?php echo number_format($user[m_emoney]) ?></span>원</strong>
						</div>

						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info mb20">
							<h3><span>대출정보</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info" class="info_current">대출관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info">대출정보</a></li>							
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_schedule">상환 스케줄</a></li>

								</ul>
							</h3>
							<div class="dashboard_loan_info">		
								<h3 class="pt0 pb10"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/><?php echo $user['m_name'];?>님의 대출정보</strong></h3>
									<dl>										
										<dt>대출금액</dt>
										<dd><?php echo number_format($total_loan_pay);?>원</dd>
										<dt>총 대출횟수</dt>
										<dd><?php echo $total_loan_cnt;?>회</dd>
									</dl>
									<dl>										
										<dt class="color_re2">연체금액</dt>
										<dd class="color_re2"><?php echo number_format($total_over_pay);?>원</dd>
									</dl>
									<dl>										
										<dt>잔여금액</dt>
										<dd><?php echo number_format($total_ld_pay);?>원</dd>
										<dt>총 상환금액</dt>
										<dd><?php echo number_format($total_lb_pay);?>원</dd>
									</dl>
									<a href="?mode=mypage_loan_info" class="btn_more mt20 mb20">나의 대출정보 자세히 보기</a>
							</div><!--dashboard_interest-->
						</div>
						<div class="dashboard_my_info">
							<h3><span><?php echo $user[m_name];?>님의 상환스케쥴</span>
							</h3>
							<div class="dashboard_loan_info">		
								<h3 class="pt0 pb10"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 나의 상환 계좌 : <strong class="color_bl"><?php if(!$pg['i_not_bankname'] || !$pg['i_not_bank'] || !$pg['i_not_bankacc']){ echo '상환계좌정보가 없습니다.';}else{echo $pg['i_not_bankname']?> <?php echo bank_name($pg['i_not_bank']);?> <?php echo $pg['i_not_bankacc']; }?></strong></h3>
								<h3 class="pt0 pb10"><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 상환스케쥴</strong></h3>
								<span>10일 내로 상환하셔야 할 상환 스케쥴입니다.</span>
								<div>
									<table>
										<colgroup>
											<col width="10%"/>
											<col width="10%"/>
											<col width="45%"/>
											<col width="15%"/>
											<col width="10%"/>
											<col width="10%"/>
										</colgroup>

										<thead>
											<tr>
												<th>상환일</th>
												<th>상환금액</th>
												<th>채권명</th>
												<th>대출 금액</th>
												<th>상태</th>
												<th>잔액</th>
											</tr>
										</thead>
										<tbody>
		<?php


		/*대출자가 대출신청한 대출건가져오기*/
		$sql = " select * from mari_loan where m_id='$user[m_id]'";
		$myloanlist = sql_query($sql, false);


		  for ($i=0; $myloan=sql_fetch_array($myloanlist); $i++) {



			$sql = " select * from mari_order where loan_id='$myloan[loan_id]' and sale_id='$user[m_id]' order by o_datetime desc";
			$orderview = sql_fetch($sql, false);


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
				?>
												<tr>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php echo $order_date;?></td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php echo $myloan[i_subject]?></td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원<?php if($orderview[o_status]=='입금완료'){?>입금완료<?php }else if($orderview[o_status]=='연체'){?>연체중<?php }else{?>상환예정<?php }?></td>
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
				?>
												<tr>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php if($orderview[o_salestatus]=='정산완료'){?><?php echo substr($orderview[o_datetime],0,10); ?><?php }else{?><?php echo $order_date;?><?php }?></td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php echo $myloan[i_subject]?></td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?php if($orderview[o_status]=='입금완료'){?>입금완료<?php }else if($orderview[o_status]=='연체'){?>연체중<?php }else{?>상환예정<?php }?></td>
													<td class="<?php echo $orderview[o_status]=='연체'?'color_re2':'';?>"><?=$i==$ln_kigan?"0":number_format($ln_money)?></td>												
												</tr>
				<?php
				$이자합산 += $첫달이자;
				$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
				$월불입금합산=$만기이자+$전체이자;
					} 
				?>
		<?php }?>
									<?php
										}
										if ($i == 0)
										echo "<tr><td colspan=\"10\">상환스케쥴 정보가 없습니다.</td></tr>";
									?>
									<!--
											<tr>
												<td>!17-01-09</td>
												<td>!3,000,000원</td>
												<td>!3호신용대출</td>
												<td>!5,000,000원</td>
												<td>!연체중</td>
												<td>!3,000,000원</td>
											</tr>
									-->
										</tbody>
									</table>
									<a href="{MARI_HOME_URL}/?mode=mypage_loan_schedule" class="btn_more mt20 mb20">나의 상환스케쥴 자세히 보기</a>
								</div>
							</div><!--dashboard_interest-->
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}