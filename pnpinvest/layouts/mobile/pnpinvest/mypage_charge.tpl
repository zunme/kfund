<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
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
			<div class="mypage_wrap">
				<div class="container">
					<h3 class="s_title2 txt_c mt20">출금 신청</h3>
					<p class="m_txt9">출금 신청 시 익일 오후 2시 이전에 계좌로 일괄 입금됩니다.</p>
					<ul class="loan_cont1 mt20">
						<li>
							<h4 class="loan_title1">이름</h4>
							<p class="mp_c_name"><?php echo $user[m_name];?></p>
						</li>
						<li class="">
							<h4 class="loan_title1">출금 금액</h4>
							<div class="loan_frm1 col-xs-12 col-sm-12" style="padding:0; ">
								<input type="text" name="o_pay" value="" id="" required  class="frm_input form-control col-xs-12" size="40" class="col-xs-12" />
							</div>
							<p class="mp_c_txt">입력 금액만큼 출금됩니다.</p>
						</li>
						<li class="mt20">
							<h4 class="loan_title1">잔액</h4>
							<div class="loan_frm1" style="margin-top:-10px; ">
								<p class="mp_c_name"><?php echo number_format($user[m_emoney]) ?></p>
							</div>
						</li>
						<li>
							<h4 class="loan_title1">입금 계좌</h4>
							<div class="loan_frm1" style="margin-top:-10px; ">
								<p class="mp_c_name"><?php echo $user['m_my_bankcode'];?> <?php echo $user['m_my_bankacc'];?></p>
							</div>
						</li>
					</ul>
					<div class="container" style="padding:0; ">
						<a href="javascript:void(0);" onclick="sendit()" class="mobile_btn">출금신청하기</a>
					</div>
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
		<?php }?>
	</section><!-- /container -->
				 

{# footer}<!--하단-->
