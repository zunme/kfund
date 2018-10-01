<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 
<script>
$(document).ready(function() {
    $(".tabs-menu a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content").not(tab).css("display", "none");
        $(tab).fadeIn();
    });
});
</script>


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
				<div class="mp_top">
					<div class="mp_right">
						<img src="{MARI_MOBILESKIN_URL}/img/img_mypage.png" alt="" />
						<p><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?>님 환영합니다!</p>
						<p><?php echo $user['m_id']; ?></p>
						<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="mypage_info_modify">정보수정</a>
						<p>예치금 : <?php echo number_format($user[m_emoney]) ?>원</p>
	<!-- 기능 미개발로 주석처리
						<div class="alert_msg">							
							<p>제 1호 상품 오픈, 펀딩금액 2,500만원.투자기간 5개월/연수익률15%</p>
							<a href="{MARI_HOME_URL}/?mode=mypage_alert" class="btn_alert_msg_more">더보기</a>
						</div>
						-->
						<div class="account_info">
							<ul>
								<?php if($seyck[s_accntNo]){?>
									<li>가상계좌</li>
									<li>&gt;</li>
									<li>
										
									<?php if($seyck[s_bnkCd]=="KEB_005"){?>
										외환은행&nbsp;&nbsp;<?php echo $seyck[s_accntNo]?>
									<?php }else if($seyck[s_bnkCd]=="KIUP_003"){?>
										기업은행&nbsp;&nbsp;<?php echo $seyck[s_accntNo]?>
									<?php }else if($seyck[s_bnkCd]=="NONGHYUP_011"){?>
										농협중앙회&nbsp;&nbsp;<?php echo $seyck[s_accntNo]?>
									<?php }else if($seyck[s_bnkCd]=="SC_023"){?>
										SC제일은행&nbsp;&nbsp;<?php echo $seyck[s_accntNo]?>
									<?php }else if($seyck[s_bnkCd]=="SHINHAN_088"){?>
										신한은행&nbsp;&nbsp;<?php echo $seyck[s_accntNo]?>
									<?php }?>
									</li>
									<li>&gt;</li>
									<li>예금주 <?php echo $seyck[m_name]?></li>
								<?php }else{?>
									<li>가상 계좌 정보</li>
									<li>&gt;</li>
									<li>가상계좌없음</li>
								<?php }?>
							</ul>
							<a href="{MARI_HOME_URL}/?mode=mypage_balance" class="btn_dashboard_balance">예치금 관리</a>
						</div>
						<div class="account_info">
							<ul>
								<?php if($user[m_my_bankacc]){?>
									<li>출금계좌</li>
									<li>&gt;</li>
									<li>
									<?php echo bank_name($user[m_my_bankcode]);?>&nbsp;&nbsp;<?php echo $user[m_my_bankacc]?>
									</li>
									<li>&gt;</li>
									<li>예금주 <?php echo $user[m_my_bankname]?></li>
								<?php }else{?>
									<li>출금계좌 정보</li>
									<li>&gt;</li>
									<li>출금계좌 없음</li>
								<?php }?>
							</ul>
							<a href="{MARI_HOME_URL}/?mode=mypage_confirm_center" class="btn_dashboard_balance">인증센터</a>
						</div>
					</div><!--//mp_right e-->
					<div id="tabs-container" class="lnb_menu tabs-menu">
						<ul>
							<li class="col-xs-6 no_pd lnb_mn1">							
								<a class="col-xs-12 no_pl no_pr tab1_m " href="#tab-1">대출정보</a>
							</li>

							<li class="col-xs-6 no_pd lnb_mn2">
								<a class="col-xs-12 no_pl no_pr " href="#tab-2">투자정보</a>
							</li>
							<li class="col-xs-6 no_pd lnb_mn3">
								<a class="col-xs-12 no_pl no_pr " href="#tab-3">관심투자</a>
							</li>
							<!--<li class="col-xs-6 no_pd lnb_mn4">
								<a class="col-xs-12 no_pl no_pr " href="#tab-4">알림메세지</a>
							</li>-->
							<li class="col-xs-6 no_pd lnb_mn5">
								<a class="col-xs-12 no_pl no_pr " href="#tab-5">입출금내역</a>
							</li>
							<!--<li class="col-xs-6 no_pd lnb_mn6">
								<a class="col-xs-12 no_pl no_pr " href="#tab-6">자동투자 예치금 설정</a>
							</li>-->
							<!--<li class="col-xs-6 no_pd lnb_mn7">
								<a class="col-xs-12 no_pl no_pr " href="#tab-7">자동투자</a>
							</li>-->
						</ul>
					</div>

						{#dash_mypage}

				</div><!--//mp_top e -->
			</div>
		</div><!-- /mypage_wrap -->
	</section><!-- /sub_content -->
</section><!-- /container -->
	<?php }?>

<script type="text/javascript">

/*가상계좌생성 모바일번전 pc버전 스크립트 적용안되서 변경*/
$(function() {
	$('#inset_form_add').click(function(){
		Inset_form_Ok(document.inset_pay);
	});
});


function Inset_form_Ok(f)
{
	if(f.s_bnkCd[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
	f.method = 'post';
	f.action='{MARI_HOME_URL}/?up=virtualaccountissue';
	f.submit();
}

</script>
{# footer}<!--하단-->