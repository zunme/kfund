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

						<div class="dashboard_side_mn">
							<ul>
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
							</ul>
						</div>
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>투자정보</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_basic">투자관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_calculate_schedule" class="info_current">정산 스케줄</a></li>
								</ul>
							</h3>
							<div class="dashboard_invest_info">	
								<h3 class=""><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 정산예정안내</h3>
								<span>현재까지 투자한 내역에 대한 정산스케줄입니다.</span>
								<div>
									<table>
										<colgroup>
											<col width="166px">
											<col width="93px">
											<col width="117px">
											<col width="127px">
											<col width="80px">
											<col width="100px">
										</colgroup>
										<thead>
											<tr>
												<th>정산일자</th>
												<th>투자금액</th>
												<th>상품명</th>
												<th>정산회차</th>
												<th>정산금액</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>
		<?php


		  for ($i=0; $myloan=sql_fetch_array($myloanlist); $i++) {

			/*투자자 투자한 대출건의 대출시작일, 대출기간, 상환일 가져오기*/
			$sql = " select * from mari_loan where i_id='$myloan[loan_id]'";
			$loanmonth = sql_fetch($sql, false);

			$o_count=$orderview[o_count];

			$end_loanexecutiondate = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$loanmonth[i_loan_day]."month"));

			/*대출기간 뽑아오기*/
			/*
			$sql = " select * from mari_loan, i_repay_day where i_id='$myloan[loan_id]' and i_loanexecutiondate between '$loanmonth[i_loanexecutiondate]' and '".$end_loanexecutiondate."'";
			$schedule = sql_fetch($sql, false);
			*/
			/*선택한 달력의 년월과 상환마지막일자와 비교를 위한 시작날짜*/
			$Y_date = date("Y", strtotime( $loanmonth[i_loanexecutiondate] ) );
			$M_date = date("m", strtotime( $loanmonth[i_loanexecutiondate] ) );
			$start_loanexecutiondates = "".$Y_date."".$M_date."";
			/*선택한 달력의 년월과 상환마지막일자와 비교를 위한 종료날짜*/
			$end_loanexecutiondates = date("Ym", strtotime($loanmonth[i_loanexecutiondate]."+".$loanmonth[i_loan_day]."month"));
		?>

		<?php
		//원리금균등분할상환 
		if($loanmonth['i_repay']=="원리금균등상환"){
		?>
		<?php
			/*대출기간*/
			$ln_kigan=$loanmonth['i_loan_day'];
			/*투자금액*/
			$ln_money=$myloan['i_pay'];
			/*연이자율*/
			$ln_iyul=$loanmonth['i_year_plus'];

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
				$order_date = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$i."month"));
				$sql = " select * from mari_order where loan_id='$myloan[loan_id]' and sale_id='$user[m_id]' and o_count='".$i."' order by o_datetime desc";
				$orderview = sql_fetch($sql, false);

				$sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
				$scdview = sql_fetch($sql, false);
				?>
												<tr>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php echo $loanmonth[i_subject]?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i?>회</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }?></td>												
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
				$ln_kigan=$loanmonth['i_loan_day'];
				/*투자금액*/
				$ln_money=$myloan['i_pay'];
				/*연이자율*/
				$ln_iyul=$loanmonth['i_year_plus'];

				$일년이자 = $ln_money*($ln_iyul/100);
				$첫달이자 = substr(($일년이자/12),0,-1)."0";
				$ln_kigan_con=$ln_kigan-1;
				$전체이자=$첫달이자*$ln_kigan_con;
				for($i=1; $i<=$ln_kigan; $i++){
				/*정산일자 구하기*/
				$order_date = date("Y-m-d", strtotime($loanmonth[i_loanexecutiondate]."+".$i."month"));
				$sql = " select * from mari_order where loan_id='$myloan[loan_id]' and sale_id='$user[m_id]' and o_count='".$i."' order by o_datetime desc";
				$orderview = sql_fetch($sql, false);

				$sql = " select * from mari_repay_schedule where loan_id='$myloan[loan_id]' and r_count='".$i."'";
				$scdview = sql_fetch($sql, false);
				?>
												<tr>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_orderdate'];?><?php }else{?>준비중<?php }?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money):"0"?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php echo $loanmonth[i_subject]?></td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i?>회</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?=$i==$ln_kigan?number_format($ln_money+$첫달이자):number_format($첫달이자)?>원</td>
													<td class="<?php echo $scdview[r_salestatus]=='연체중'?'color_re2':'';?>"><?php if($scdview['loan_id'] && $scdview['r_view']=="Y"){?><?php echo $scdview['r_salestatus'];?><?php }else{?>준비중<?php }?></td>												
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
										</tbody>
									</table>							
							</div><!--dashboard_interest-->
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->
{#footer}