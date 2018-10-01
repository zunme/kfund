<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 


		<?php
			if($my=="loanstatus"){
			/*대출신청정보*/
		?>
						
		<?php
			}else if($my=="depositstatus"){
			/*입금현황*/
		?>
						
		<?php
			}else if($my=="tenderstatus"){
			/*입찰정보*/
		?>
						
		<?php
			}else if($my=="investment"){
			/*투자 정산정보*/
		?>
						
		<?php
			}else if($my=="investment"){
		?>
		<?php
			}else if($my=="investmentinterest"){
		?>
				 
    <?php
    for ($i=0; $row=sql_fetch_array($wish); $i++) {
	$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
	$iv = sql_fetch($sql, false);
	/*투자인원 구하기*/
	/*메인에서는 일단 사용안함
	$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
	$incn = sql_fetch($sql, false);
	$invest_cn = $incn['cnt'];
	*/
		/*대출총액의 투자금액 백분율구하기*/
		$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
		$top=sql_query($sql, false);
		$order = mysql_result($top, 0, 0);
		$total=$row[i_loan_pay];
		/*투자금액이 0보다클경우에만 연산*/
		if($order>0){
			/* 투자금액 / 대출금액 * 100 */
			$order_pay=floor ($order/$total*100);
		}else{
			$order_pay="0";
		}
	/*카테고리분류*/
	$sql = " select  * from  mari_category where ca_id='$row[ca_id]'";
	$cate = sql_fetch($sql, false);

	/*대출총액의 투자금액 백분율구하기*/
	$sql="select sum(i_pay) from mari_invest where loan_id='$row[i_id]'"; 
	$top=sql_query($sql, false);
	$order = mysql_result($top, 0, 0);

	/*성별 생년월일*/
	$sql = " select  * from  mari_member where m_id='$row[m_id]'";
	$sex = sql_fetch($sql, false);

	/*나이구하기*/

	/*날짜 자르기*/
	$datetime=$sex['m_birth'];
	$datetime = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $datetime); 
	$Y_date = date("Y", strtotime( $datetime ) );
	$M_date = date("m", strtotime( $datetime ) );
	$D_date = date("d", strtotime( $datetime ) );

	$birthday = "".$Y_date."".$M_date."".$D_date."";
	$birthyear = date("Y", strtotime( $birthday )); //생년
	$nowyear = date("Y"); //현재년도
	$age2 = $nowyear-$birthyear+1; //한국나이

	/*위시리스트에 등록내역*/
	$sql = " select  * from  mari_wishlist where m_id='$user[m_id]' and loan_id='$row[i_id]'";
	$wishadd = sql_fetch($sql, false);

	if($iv['i_view']=="N"){
	}else{

	if($wishadd['loan_id']==$row['i_id']){
    ?>
							
    <?php
    }
    }
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">진행중인 투자 리스트가 없습니다.</td></tr>";
    ?>
		<?php
			}else if($my=="emoney_list"){
		?>
						
		<?php
			}else{
		?>
<section id="container">
		<section id="sub_content">
				<div class="container">
					<div class="dashboard_my_info">
							<h3><span>예치금 관리</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_balance" >입/출금 관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney" class="info_current">내역</a></li>
								</ul>
							</h3>
							<div class="dashboard_emoney">
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class=""/> 입/출금 내역</h3>
								<span>예치금의 입/출금 내역을 확인하실 수 있습니다.</span>
								<div>
									<table class="">
										<colgroup>
											<col width="110px">
											<col width="">
										</colgroup>
									<?php
										$login_ck="YES";

										/*입찰정보*/								
										$sql = " select * from mari_emoney where m_id='$user[m_id]'  order by p_id desc";
										$emoney = sql_query($sql);
										for($i=0; $row = sql_fetch_array($emoney); $i++){
									?>
										<tbody>
											<tr>
												<th>일시</th>
												<td><?php echo substr($row[p_datetime],0,10);?></td>
											</tr>
											<tr>
												<th>내용</th>
												<td><?php echo $row[p_content];?></td>
											</tr>
											<tr>
												<th>입금액</th>
												<td><?php echo number_format($row[p_emoney]);?>원</td>
											</tr>
											<tr>
												<th>출금액</th>
												<td><?php echo number_format($row[p_emoney]);?>원</td>
											</tr>
												<th class="last">잔액</th>
												<td><?php echo number_format($row[p_top_emoney]);?>원</td>
											</tr>
										</tbody>
									<?php }if($i==0){ ?>
											<tr>
												<th>일시</th>
												<td rowspan=5>예치금거래내역이 없습니다.</td>
											</tr>
											<tr>
												<th>내용</th>
												
											</tr>
											<tr>
												<th>입금액</th>
												
											</tr>
											<tr>
												<th>출금액</th>
												
											</tr>
												<th class="last">잔액</th>
												
											</tr>
									<?php }?>
									</table>
								</div>
							</div>
						</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
	<?php }?>
{# footer}<!--하단-->