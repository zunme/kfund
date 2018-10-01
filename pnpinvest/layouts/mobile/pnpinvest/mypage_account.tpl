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
		<form name="member_form"  method="post" enctype="multipart/form-data">
		<input type="hidden" name="m_no" value="<?php echo $user[m_no]?>"/>
		<input type="hidden" name="mode" value="m_member_modify"/>
			<div class="mypage_wrap">
				<div class="container">
					<h3 class="s_title2">계좌 등록</h3>
					<p class="m_txt9">주민등록번호는 원천징수 납부 시 사용되며, <br/>탈퇴 시 모든 정보는 삭제됩니다.</p>
					<ul class="loan_cont1 mt50">
						<li class="mt20">
							<h4 class="loan_title1">주민등록번호*</h4>
							<div class="loan_frm1 col-sm-6 col-xs-6 col-xs-12" style="padding:0 5px 0 0; ">
								<input type="text" name="m_resident1" value="" maxlength="6" id="" required  class="frm_input form-control" size="40" />
							</div>
							<div class="loan_frm1 col-sm-6 col-xs-6 col-xs-12" style="padding:0 0 0 5px; ">
								<input type="text" name="m_resident2" value="" maxlength="7" id="" required  class="frm_input form-control" size="40" />
							</div>
						</li>
						<li class="mt40">
							<h4 class="loan_title1">은행명*</h4>
							<div class="loan_frm1">
								<input type="text" name="m_my_bankcode" value="" id="" required  class="frm_input form-control" size="40" />
							</div>
						</li>
						<li>
							<h4 class="loan_title1">계좌 번호*</h4>
							<div class="loan_frm1">
								<input type="text" name="m_my_bankacc" value="" id="" required  class="frm_input form-control" size="40" />
							</div>
						</li>
					</ul>
					<div class="container mt60" style="padding:0; ">
						<a href="javascript:void(0);" onclick="sendit()"><img style="width:100%;" src="{MARI_MOBILESKIN_URL}/img/btn_mp_save.png" alt="" /></a>
					</div>
				</div>
			</div><!-- /mypage_wrap -->
			</form>
		</section><!-- /sub_content -->
	</section><!-- /container -->
	<?php }?>
						</div><!-- /my_content -->
					</div><!-- /mapage_wr_inner -->
				</div><!-- /mypage_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->




<script>

function sendit()
{	
	var f = document.member_form;
	if(!f.m_resident1.value){ alert('\n주민번호 첫째자리를 입력하여 주십시오');f.m_resident1.focus();return false}
	if(!f.m_resident2.value){ alert('\n주민번호 둘째자리를 입력하여 주십시오'); f.m_resident2.foucs(); return false;}
	if(!f.m_my_bankcode.value){ alert('\n은행명을 입력하여 주십시오'); f.m_my_bankcode.foucs(); return false;}
	if(!f.m_my_bankacc.value){ alert('\n계좌번호를 입력하여 주십시오'); f.m_my_bankacc.foucs(); return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=join3&mode=m_member_modify';
	f.submit();
}
</script>

 
{# footer}<!--하단-->