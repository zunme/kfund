<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header}<!--상단-->

<script>

$(document).ready(function(){
  $('.bxslider01').bxSlider();
});

$(function(){
     $('#pop').click(function(){
        $('#element_to_pop_up').show();
    });
	   $('#pop1').click(function(){
        $('#element_to_pop_up').show();
    });
	$('.pop_close').click(function(){
	$('#element_to_pop_up').hide();
	});
});

$(function(){
   $(".detail_pop_up1,.detail_pop_up2").hide();
    $(".detailterm1").mouseover(function(){
	   $(".detail_pop_up1").show();
    });
     $(".detailterm2").mouseover(function(){
	   $(".detail_pop_up2").show();
    });
    $(".detailterm1,.detailterm2").mouseleave(function(){
	    $(".detail_pop_up1,.detail_pop_up2").hide();
    });



});

</script>






<style>
.main_vis{height: 458px; background: url('{MARI_HOMESKIN_URL}/kimg/main_bg1.jpg') no-repeat center bottom /cover; text-align: center; padding-top: 149px; letter-spacing: -1px; font-size: 16px; box-sizing: content-box;}
.main_vis h2{background: url('{MARI_HOMESKIN_URL}/kimg/vis_ment.png') no-repeat center bottom; background-size: 240px 23px; text-indent: -99999px; width: 348px; margin: 0 auto 60px; height: 33px; line-height: 33px;}
.main_vis p{color: #111; line-height: 32px; margin-bottom: 5px;}
.main_vis p span{display: block;}
.main_vis p span.c_red{color: #ed1c24; display: inline-block; font-weight: 600;}
.main_vis strong{color: #111;}
</style>

		<section id="container">
			<section id="main_content">
		<div class="main_vis" style="">
			<h2>Real Finance Union</h2>
			<p><span>믿을만한 사업주체, 운영능력, 풍부한 경험이 뒷받침될 때,</span><span>안전하고 안정적인 수익 달성이 가능합니다.</span></p>
			<p><span><span class="c_red">키스톤펀딩</span>은 부동산 개발의 노하우를 기반으로</span><span>당신의 투자를 보다 알차게 만들어 드립니다.</span></p>
			<strong>지금 부동산 투자를 쉽게 만나보세요.</strong>
		</div>
		  </section><!-- /main_content -->



				 <section class="main02">


					  <h3><p>신규 투자 상품</p>
			           <a href="{MARI_HOME_URL}/?mode=invest" >+ 전체상품보기</a>
			           </h3>




					<ul class="new_product">
					<?php
					for ($i=0; $row=sql_fetch_array($result); $i++) {
					$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]' limit 1";
					$iv = sql_fetch($sql, false);


					/*카테고리분류*/
					$sql = " select  * from  mari_category where ca_id='$row[i_payment]'";
					$cate = sql_fetch($sql, false);



					/*성별 생년월일*/
					$sql = " select  * from  mari_member where m_id='$row[m_id]'";
					$sex = sql_fetch($sql, false);


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


					/*투자인원 구하기*/
					$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
					$incn = sql_fetch($sql, false);
					$invest_cn = $incn['cnt'];


					/*위시리스트에 등록내역*/
					$sql = " select  * from  mari_wishlist where m_id='$user[m_id]' and loan_id='$row[i_id]'";
					$wish = sql_fetch($sql, false);

					/*모집마감일 체크*/
					if($iv ['i_invest_eday']<$date){
						$invest_set="Y";
					}else{
						$invest_set="N";
					}
					if($order_pay=="100"){
						$invest_max="Y";
					}

					?>

					    <li>
	 <div class="invest1">

		 <div class="state_gauge">
			 <div class="barcontainer" style="width:100%"  >
				 <p class="bar" data-pro-bar-percent="<?php echo $order_pay?>%" data-pro-bar-delay="30" style="width:<?php echo $order_pay?>%;"> <?php echo $order_pay;?>%</strong>진행</p>
			 </div>
		 </div><!-- state_gauge -->
		<div class="invest1_top">
			 <div class="percent">
				<p ><strong><!--<span>(<?php echo $invest_cn.'명'; ?>)</span>--></p>
				<!--<p ><strong>50%</strong>진행<span>(77명)</span></p>-->
						<!--  <p><?php
								if($iv['i_look']=="Y"){
									echo '투자진행중';
								}else if($iv['i_look']=="N"){
									echo '투자대기';
								}else if($iv['i_look']=="C"){
									echo '투자마감';
								}else if($iv['i_look']=="D"){
									echo '상환중';
								}else if($iv['i_look']=="F"){
									echo '상환완료';
								}else if($iv['i_look']=="G"){
									echo '투자심의중';
								}
							?>
						 </p>-->
			</div>
			<div class="thumnail">
				<!--펀딩완료시 나오는 화면-->
				<div class="invest1_top_more_open">
					<div class="backgroundblack"></div>
						 <p>
							<?php if($iv['i_look']=="G"){?>
								<a href="javascript:alert('투자 심의중 입니다.');">
							<?php }else{?>
								<a href="?mode=invest_view&loan_id=<?php echo $row['i_id']?>">
							<?php }?>
						<?php
							if($iv['i_look']=="Y"){
								echo '투자진행중';
							}else if($iv['i_look']=="N"){
								echo '투자대기';
							}else if($iv['i_look']=="C"){
								echo '투자마감';
							}else if($iv['i_look']=="D"){
								echo '상환중';
							}else if($iv['i_look']=="F"){
								echo '상환완료';
							}else if($iv['i_look']=="G"){
								echo '투자심의중';
							}
						?></a>
						</p>
					</div>
						<!--<img src="{MARI_DATA_URL}/photoreviewers/testimg.jpg">-->
						  <?php if($iv['i_creditratingviews']){?>
					       <img src="{MARI_DATA_URL}/photoreviewers/<?php echo $row['i_id']?>/<?php echo $iv['i_creditratingviews'];?>" alt="product" width="370" height="190" class="product_thumnail">
						 <?php }else{?>
						<img class="product_thumnail" src="{MARI_HOMESKIN_URL}/img/no_image.png" alt="상품이미지" width="370" height="190"/>
						 <?php }?>
				</div>
			</div><!-- thumnai l-->
		</div><!-- invest1_top -->

		<div class="invest1_bottom">
			<div class="invest1_title">
				<h4><?php echo $row['i_subject']?></h4>
				<!--<h5><?php echo $row[i_locaty]?></h5> 중 타이틀-->
			</div>

			<div class="invest1_content01">
				<p><strong>참여금액 <?php echo unit2($order) ?> 원</p>
				<p> <strong>펀딩금액<?php echo unit2($row['i_loan_pay']) ?> 원</p>
			</div>
			<div class="invest1_content02">
				   <p>투자기간 <strong><?php echo $row['i_loan_day']?>개월</strong></p>
				   <!-- <p>투자기간 <strong>12개월</strong></p> -->
				  <p>모집기간<strong><?php echo substr($iv['i_invest_sday'],0,4)?>. <?php echo substr($iv['i_invest_sday'],5,2)?>. <?php echo substr($iv['i_invest_sday'],8,2)?>  ~	<?php echo substr($iv['i_invest_eday'],0,4)?>. <?php echo substr($iv['i_invest_eday'],5,2)?>. <?php echo substr($iv['i_invest_eday'],8,2)?></strong></p>
				  <p>수익률(연)<strong><?php echo $row['i_year_plus']; ?>%</p></strong></p>
				  <p>상환방식<strong><?php echo $row['i_repay']?></strong></p>
				   <!--<p>평가등급<strong>A</strong></p> -->
			</div>


	 </div><!--invest1-->
</li><!--리스트1-->
					<?php } ?>


              </ul>

	    </section><!--main02-->


	   <div class="mainnumber">
					 <div class="mainnumber01">
						  <ul>
							<li>
								<ul>
									<li>누적대출액</li>
									<li>
<!-- 										<?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']-=279000000); }else{ echo number_format($t_pay-=279000000); } ?>원 -->
										<?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?>원
									</li>
								</ul>
							</li>
							<li>
								<ul>
									  <li>누적상환액</li>
									  <li>
<!-- 										<?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?>--><!--<?php echo number_format($Loanrepayments) ?>-->
										<?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?>원
									</li>
								</ul>
							</li>
							<li>
								<ul>
									<li>평균수익률(연)</li>
									 <li>
<!-- 										<?php if($top_plus){?><?php echo number_format($top_plus,1);?><?php }else{?>0<?php }?>% -->
										<?php if($Result_average){?><?php echo round($Result_average,2);?><?php }else{?>0<?php }?>%
									</li>
								</ul>
							</li>
						  </ul>
					</div><!--mainnumber01-->
					<div  class="mainnumber02">
					  <ul>
						<li>
							<ul>
								<li>대출잔액</li>
								<li><?=number_format($t_loan_pay - $acc_Payments )?>원</li>
							</ul>
						</li>
						   <li>
							 <ul>
								  <li>부도율</li>
								  <li><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</li>
							  </ul>
						   </li>

						   <li>
							 <ul>
								  <li>연체율</li>
									<li><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</li>
							  </ul>
						   </li>
					   </ul>
					</div><!--mainnumber02-->
				  </div><!--mainnumber-->



	</section><!-- /container -->



{# footer}<!--하단-->


<div id="element_to_pop_up" >
	<div class="popup">
	<div class="b-close">
		<img src="http://www.worldfunding.co.kr/invest/layouts/home/invest/img/btn_close.png" alt="닫기" class="pop_close" />
	</div>
	<div class="pop_box1">
		<h3>투자 알림 신청</h3>
		<p>신규 투자 소식을 제일 먼저 받아보세요!</p><br/>
		<p style="font-size:12px; ">(비회원 알림해지일 경우엔 입력했던 휴대폰 또는 이메일 주소를 입력한 후에 해지를 해주시기 바랍니다.)</p>
	</div>
		<form name="sms_push" method="post" enctype="multipart/form-data">
		<!-- 회원정보 -->
		<?php if($member_ck){?>
			<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>">
			<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>">
		<?php }?>

		<div class="pop_box2">
			<ul>
				<li>SMS 알림<span><input type="text" class="popbox2" id="" name="m_hp" value="<?php echo $user['m_hp']?>" placeholder="휴대폰 번호를 '-' 없이 입력해 주세요." maxlength="11"></span></li>
				<li>E-MAIL 알림<span><input type="text" class="popbox2" id="" name="m_email" value="<?php echo $user['m_email']?>" placeholder="이메일을 입력해 주세요"></span></li>
			</ul>
		</div>
		<div class="pop_box3">
			<a href="javascript:void(0);" onclick="push(1)">알림신청</a>
			<a href="javascript:void(0);" onclick="push(2)">알림해지</a>
		</div>
		<script>
		function push(index){

			var f = document.sms_push;
			if(index=="1"){
				if(!f.m_hp.value){alert('\n알림받으실 휴대폰번호를 입력하여 주십시오.');f.m_hp.focus();return false;}
				if(!f.m_email.value){alert('\n알림받으실 이메일주소를 입력하여 주십시오.');f.m_email.focus();return false;}
				f.method = 'post';
				f.action = '{MARI_HOME_URL}/?up=push_send&type=push_yes';
				f.submit();
			}else if(index=="2"){
				if(!f.m_hp.value){alert('\n알림해제 하실 휴대폰번호를 입력하여 주십시오.');f.m_hp.focus();return false;}
				if(!f.m_email.value){alert('\n알림해제 하실 이메일주소를 입력하여 주십시오.');f.m_email.focus();return false;}
				f.method = 'post';
				f.action = '{MARI_HOME_URL}/?up=push_send&type=push_no';
				f.submit();
			}

		}


		</script>
		</form>

	</div>
</div>