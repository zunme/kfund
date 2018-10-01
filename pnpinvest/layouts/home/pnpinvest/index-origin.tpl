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

<div id="container">
	<div id="main_content">
		<div class="main_visual">
			<div class="main_wrap">
					<div class="main_banner">
					<div>
			<ul class="crapas_bxslider">
				<li class="c_bx1">
					<div class="main_text">
						<p class="up_bar"></p>
						<h2>투자의 격이 다릅니다.<br/>보다 확실하고 안전한투자</h2>
						<a href="{MARI_HOME_URL}/?mode=invest"><img src="{MARI_HOMESKIN_URL}/img/go_btn.jpg" alt="펀딩하기" /></a>
					</div>
				</li>

			</ul>
		</div>


						<div class="right_btn">
							<ul>
								<li><a href="{MARI_HOME_URL}/?mode=invest"><img src="{MARI_HOMESKIN_URL}/img/banne_rtbtn01.jpg" alt="펀딩하기" /></a></li>
								<li><a href="javascript:;" id="pop"><img src="{MARI_HOMESKIN_URL}/img/banne_rtbtn02.jpg" alt="투자알림 신청" /></a></li>
								<li><a href="{MARI_HOME_URL}/?mode=guide_invest"><img src="{MARI_HOMESKIN_URL}/img/banne_rtbtn03.jpg" alt="투자가이드" /></a></li>
							</ul>
						</div>
					</div>
			</div><!-- main_wrap -->

		</div><!--main_visual-->



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


		 <div class="section01">
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


            <div class="section02">
             <div class="section02Inner">
	     <h2><span class="point_r">키스톤펀딩</span>은 최적의 투자기회를 선별하여 제공합니다.</h2>
            <h3 class="hidden">소개</h3>
		   <ul>
		      <li>
		          <p class="section02title">쉽고 빠른 투자</p>
			      <p  class="section02title_detail">부동산 전문가들이 추천하는 상품에<br/> 누구나 쉽게 투자하실 수 있습니다</p>
			</li>
		      <li>
		              <p class="section02title">고수익 투자</p>
			      <p  class="section02title_detail">저금리 시대에 연 8%~20대의 <br/> 안전하고 높은 수익을 제공합니다</p>
			</li>
		      <li>
		              <p class="section02title">안전한 투자</p>
			      <p  class="section02title_detail">철저한 심사와 담보권 취득,<br/> 분양까지를 관리하여 안전합니다</p>
			</li>
		      <li>
		              <p class="section02title">소액 간편 투자</p>
			      <p  class="section02title_detail">십만원부터 누구나  <br/>투자가 가능합니다</p>
			</li>
		   </ul>

		 </div><!--section02Inner-->

               </div><!--section02-->
	       <div class="sectionlast">키스톤펀딩 투자현황
		<div class="today_box">
			<div class="today_m">
				<script type="text/javascript">
				 var now = new Date();

				 var nowHour = now.getHours();
				 var nowMt = now.getMinutes();

				 if(nowHour<10){
					nowHour='0'+nowHour;
				 }
				 if(nowMt<10){
					nowMt='0'+nowMt;
				 }

				document.write( nowHour + ' : ' + nowMt + ' '  );

			     </script>
			</div> <!--today_m-->
		</div>

	</div>
	</div><!--  sectionlast  -->
          <div class="main_txt_bottom">
	  <div class="today_c">
			<script>
			var nowMonth = now.getMonth() + 1;
			 var nowDate = now.getDate();

			  document.write( nowMonth + '. ' + nowDate + ' ' );
			</script>
		</div>
		<div class="count_box">

			<h2>누적 대출액</h2>
			<p>
			<?php
				if($allpay['i_allpay']!=0){
					$val = $allpay['i_allpay'];
				}else{
					$val = $t_loan_pay - $acc_Payments;
				}
	//			$val = "300000000000000";
				$val_arr=array();
				for($i=0;$i<strlen($val);$i++){
					$j=-1-$i;
					$result_val = substr($val,$j,1);
					array_push($val_arr, $result_val);
				}

				for($i=count($val_arr); $i>0; $i--){
					if($i%3==0 && $i!=count($val_arr)){
						echo ",";
					}
			?>
					<span class="num_bg"><?php echo $val_arr[$i-1];?></span>
			<?

			}?>
<!-- 				<span class="num_bg"><?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']); }else{ echo number_format($t_loan_pay); } ?></span> -->
<!-- 				<span class="num_bg">5</span> -->
<!-- 				<span class="num_bg">5</span>, -->
<!-- 				<span class="num_bg">0</span> -->
<!-- 				<span class="num_bg">0</span> -->
<!-- 				<span class="num_bg">0</span>, -->
<!-- 				<span class="num_bg">0</span> -->
<!-- 				<span class="num_bg">0</span> -->
<!-- 				<span class="num_bg">0</span> -->
			</p>
		</div>

					<ul>
<!-- 					<li> -->
<!-- 						<p class="text01">누적 투자액</p> -->
<!--  -->
<!-- 						<p class="text02"><?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']-=279000000 ); }else{ echo number_format($t_pay-=279000000 ); } ?><span class="won">원</span></p> -->
<!-- 					</li> -->
					<li>
						<p class="text01">누적 상환액</p>
						<p class="text02">
<!-- 						<?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?> -->
							<?php if($acc_Payments){ echo number_format($acc_Payments); }else{?> 0 <?php }?>
						<span class="won">원</span></p>
					</li>
					<li>
						<p class="text01">대출잔액</p>
						<p class="text02"><?=number_format($t_loan_pay - $acc_Payments )?>원</p>
					</li>
					<li>
						<p class="text01">평균 수익률</p>
						<p class="text02">
<!-- 							<?php if($top_plus){?><?php echo number_format($top_plus,1);?><?php }else{?>0<?php }?> -->
							<?php if($Result_average){?><?php echo round($Result_average,2);?><?php }else{?>0<?php }?>%
						</p>
					</li>

					<li>
						<p class="text01">연체율
							<!-- <span class="detailterm"><img src="{MARI_HOMESKIN_URL}/img2/help.png" alt="연체율" /></span>
							 <span class="detail">30일 이상 ~ 90일 미만 연체</span>-->
						</p>
						<p class="text02"><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</p>
					</li>
					<li>
						<p class="text01">부도율
							<!--<span class="detailterm"><img src="{MARI_HOMESKIN_URL}/img2/help.png" alt="부도율" /></span>
							<span class="detail">90일 이상 장기연체</span >-->
						</p>
						<p class="text02"><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</p>
					</li>

					</ul>
				</div><!--main_txt_bottom  -->


              </div>


	</div><!-- main_content -->
</div><!-- container -->
<?php if($popup[po_skin]){?>
	{# popup}<!--팝업-->
<?php }?>
{#footer}


