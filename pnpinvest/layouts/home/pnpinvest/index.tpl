<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header}
<script>
	$(function(){
    $('#pop').click(function(){
        $('#element_to_pop_up').show();
    });
	$('.pop_close').click(function(){
	$('#element_to_pop_up').hide();
	});

/*부도율 연체율 설명보기*/


	$( '.detailterm').mouseover( function () {
                $( this ).siblings('.detail').css('display','block');
            } ).mouseout( function () {
                $( this ).siblings('.detail').css('display','none');
            } );




});



</script>

<script>
$(document).ready(function(){
      $('.crapas_bxslider').bxSlider();
    });
$(document).ready(function(){
      $('.crapas_bxslider2').bxSlider({
          pager: false
      });
      $('.crapas_bxslider1').bxSlider({
          pager: false
      });
    });
$(document).ready(function(){
		$('.slider1').bxSlider({
		slideWidth: 170,
		minSlides: 5,
		maxSlides: 5,
		moveSlides: 1,
		slideMargin: 39,
		pager:false
	});
});
</script>

<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/main-keystone.css" />

<div id="container">
	<div id="main_content">
		<div class="main_vis" style="padding-top: 320px !important;">
			<h2>Real Finance Union</h2>
			<p><span>믿을만한 사업주체, 운영능력, 풍부한 경험이 뒷받침될 때,</span><span>안전하고 안정적인 수익 달성이 가능합니다.</span></p>
			<p><span><span class="c_red">키스톤펀딩</span>은 부동산 개발의 노하우를 기반으로</span><span>당신의 투자를 보다 알차게 만들어 드립니다.</span></p>
			<strong>지금 부동산 투자를 쉽게 만나보세요.</strong>
		</div>
		<div class="main_visual">
		</div>


					</div>
			</div><!-- main_wrap -->

		</div><!--main_visual-->

		<!-- 키스톤 펀딩 협력업체 S-->
		<div class="partners">
			<div class="inner">
				<h2>키스톤 펀딩 협력업체<span class="icon"></span></h2>
				<ul class="card_list">
					<li class="partner1">
						<a href="{MARI_HOME_URL}/?mode=company_intro">
							<img src="{MARI_HOMESKIN_URL}/kimg/partner_bg1.jpg" alt="아래에서 바라본 빌딩의 모습" width="310" height="206" />
							<div class="partners_cont">
								<h3>K&amp;H UNITED</h3>
								<p><span>부동산개발사업 및 컨설팅</span><span>사업관리 및 개발대행</span><span>프로젝트 파이낸싱 외</span></p>
								<!--span class="more">DETAIL VIEW</span-->
							</div>
						</a>
					</li>
					<li class="partner2">
						<a href="{MARI_HOME_URL}/?mode=company_intro">
							<img src="{MARI_HOMESKIN_URL}/kimg/partner_bg2.jpg" alt="하늘에서 바라본 도시의 모습" width="310" height="206" />
							<div class="partners_cont">
								<h3>아시아신탁㈜</h3>
								<p><span>기업은행,우리투자증권,신한금융투자,</span><span>금호종합금융이 출자한</span><span>부동산신탁업계 1위의 기업</span></p>
								<!--span class="more">DETAIL VIEW</span-->
							</div>
						</a>
					</li>
					<li class="partner3">
						<a href="{MARI_HOME_URL}/?mode=company_intro">
							<img src="{MARI_HOMESKIN_URL}/kimg/partner_bg3.jpg" alt="하얀 벽을 가진 주택의 모습" width="310" height="206" />
							<div class="partners_cont">
								<h3>일화종합건설㈜</h3>
								<p><span>1996년 설립,</span><span>안전하고 믿음직한 건축물을 시공,</span><span>우량건설기업</span></p>
								<!--span class="more">DETAIL VIEW</span-->
							</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- 키스톤 펀딩 협력업체 E -->

		<!-- 키스톤 투자 현황 S -->
		<div class="investment_wrap">
			<div class="invest_top inner">
				<h2>키스톤펀딩 투자현황<span>(
<?=date("Y")?>.<?=date("m")?>.<?=date("d")?> 기준)</span></h2>
				<strong>
			<?php
				if($allpay['i_allpay']!=0){
					$val = $allpay['i_allpay'];
				}else{
					$val = $t_loan_pay - $acc_Payments;
				}
	//			$val = "300000000000000";
			?>
			<?=number_format( $val )?>
<span>원</span></strong>
				<span>대출 잔액: <?=number_format($t_loan_pay - $acc_Payments )?>원</span>
			</div>
			<div class="invest_bottom inner">
				<ul>
					<li><span>평균수익률</span><?php if($Result_average){?><?php echo round($Result_average,2);?><?php }else{?>0<?php }?>%</li>
					<li><span>누적 상환액</span><?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?>원</li>
					<li><span>연체율</span><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</li>
					<li><span>부실률</span><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</li>
				</ul>
			</div>
		</div>
		<!-- 키스톤 투자 현황 E -->

		<!-- 키스톤펀딩 처음이신가요? S -->
		<div class="guide_wrap">
				<h2><span>6,250명의 선택</span>키스톤펀딩 처음이신가요?</h2>
				<ul>
					<li class="funding hexagon"><a href="{MARI_HOME_URL}/?mode=company_intro"><span class="icon"></span>키스톤펀딩 안내</a></li>
					<li class="p2p hexagon"><a href="{MARI_HOME_URL}/?mode=guide_invest"><span class="icon"></span>이용가이드</a></li>
					<li class="investment hexagon"><a href="{MARI_HOME_URL}/?mode=invest"><span class="icon"></span>투자하기</a></li>
					<li class="loan hexagon"><a href="{MARI_HOME_URL}/?mode=loan_real"><span class="icon"></span>대출하기</a></li>
				</ul>
		</div>
		<!-- 키스톤펀딩 처음이신가요? E -->


  <script>
			$(document).ready(function(){
			  $('.bxslider_1').bxSlider({
			  auto: true ;
			  });
			});

</script>

            <div id="element_to_pop_up">
							<div class="popup">
								<div class="b-close">
									<img src="{MARI_HOMESKIN_URL}/img/btn_close.png" alt="닫기" class="pop_close" />
								</div>
								<div class="pop_box1">
									<h3>투자 알림 신청</h3>
									<p>신규 투자 소식을 제일 먼저 받아보세요!</p><br/>
									<?php if(!$member_ck){?>
									<p style="font-size:12px; ">(비회원 알림해지일 경우엔 입력했던 휴대폰 또는 이메일 주소를 입력한 후에 해지를 해주시기 바랍니다.)</p>
									<?php }?>
								</div>
								<form name="sms_push" method="post" enctype="multipart/form-data">
								<?php
								//회원일 경우
									if($member_ck){
										$sql = "select * from mari_sms_push";
										$find_push = sql_query($sql, false);
										for($i=0; $row = sql_fetch_array($find_push); $i++){
											if($row[m_id] == $user[m_id]){
												//sms정보가 있을경우 카운트
												$mem_cnt+=1;
											}
										}
										if($mem_cnt=="1"){
								?>
								<!-- sms_push 정보가 있을경우 -->
									<input type="hidden" name="push" value="modi">
								<?php
										}else{
								?>
								<!-- sms_push 정보가 없을경우 -->
									<input type="hidden" name="push" value="use">
								<?php
										}
									}else{
								?>
									<input type="hidden" name="push" value="no_member">
								<?php
									}
								?>

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
						</div><!-- element_to_pop_up -->


		 <div class="section00" style="background-color: #CFCFCF; ">
		    <div class="section01Inner">
		    <div class="innerbox">
                        <h3><span class="point_r">키스톤펀딩</span>투자상품
			  <a href="{MARI_HOME_URL}/?mode=invest" >+ 전체상품보기</a></h3>


				    <ul class="new_product">
										<?php
										    for ($i=0; $row=sql_fetch_array($result); $i++) {
											$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]' limit 1";
											$iv = sql_fetch($sql, false);


											/*카테고리분류*/
											$sql = " select  * from  mari_category where ca_id='$row[i_payment]'";
											$cate = sql_fetch($sql, false);

											/*투자인원 구하기*/
											$sql = " select count(*) as cnt from mari_invest where loan_id='$iv[loan_id]' order by i_pay desc";
											$incn = sql_fetch($sql, false);
											$invest_cn = $incn['cnt'];


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
						  <p><?php
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
						 </p>
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
				<?php }?>
				</ul>
			</div>
                     </div><!--section01Inner-->
                </div><!--section01-->

		<!-- 투자상품보기 S -->
		<div class="about">
			<div class="inner">
				<strong>키스톤펀딩 여행 어떠셨나요?</strong>
				<p>이제 투자 상품을 둘러보시고 키스톤 펀딩에 직접 투자해 보세요.<span>P2P금융은 아주 쉽습니다.</span></p>
				<div class="right_btn">
					<a href="{MARI_HOME_URL}/?mode=invest"><span class="icon"></span>투자상품보기</a>
				</div>
			</div>
		</div>
		<!-- 투자상품보기 E -->

              </div>

		<!-- 문의전화 S -->
<style>
.call_center{text-align: center; padding: 50px 0 70px;}
.call_center .inner{max-width: 935px; width: 100%; margin: 0 auto;}
.call_center .inner h2{background: url('{MARI_HOMESKIN_URL}/kimg/main_sp_028815864.png') no-repeat 0 -446px; width: 217px; height: 120px; margin: 0 auto; text-indent: -99999px;}
.call_center .inner p{border-top: 1px solid #e3e3e3; font-size: 17px; color: #525252; line-height: 27px; padding: 6px 0; margin: 10px 0 0 0; letter-spacing: -1px;}
.call_center .inner p span{display: block;}
</style>
		<div class="call_center">
			<div class="inner">
				<h2>문의전화 02-881-5864</h2>
				<p>문의사항이나 사업 자금이 필요한 법인은 고객 센터로 전화주시면 친절히 상담해드리겠습니다.<span>※고객 센터 운영 시간 (오전 10시 ~ 오후 5시 / 주말, 공휴일 휴무)</span></p>
			</div>
		</div>
		<!-- 문의전화 E -->


	</div><!-- main_content -->
</div><!-- container -->
<?php if($popup[po_skin]){?>
	{# popup}<!--팝업-->
<?php }?>
{#footer}


