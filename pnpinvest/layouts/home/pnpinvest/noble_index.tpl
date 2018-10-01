<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#noble_header}

<script>
	$(function(){
    $('#pop').click(function(){
        $('#element_to_pop_up').show();
    });
	$('.pop_close').click(function(){
	$('#element_to_pop_up').hide();
	});
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

    function autoHours(){
			var time = new Date();
			var days = ["일","월","화","수","목","금","토"]
			var day = time.getDate();
			var hours = time.getHours();
			var mins = time.getMinutes();
			var secs = time.getSeconds();
            var Year =   time.getFullYear();
            var month = time.getMonth()+1;
             month=dasi(month);
			var msg ="";
			msg +=Year+"-"+month+"-"+day;
			document.getElementById("showTime").innerHTML = msg;
		}
       autoHours();
       
	   function dasi(i){if (i<10){i="0"+i}; 
	   return i;
        }

});
</script>

<div id="container">
	<div id="index_content">

		<div class="visual_wrap">
			<div class="visual_inner">
				
				<div class="visual">
					<img src="{MARI_HOMESKIN_URL}/img/noble_index_bg.png" alt="" />
					<p>격이 다른 부동산 담보 P2P, Noble Fund!</p>
				<!--<a href="{MARI_HOME_URL}/?mode=invest" class="btn_funding rollover"><img src="{MARI_HOMESKIN_URL}/img2/btn_funding.png" alt="펀딩하기" /><img src="{MARI_HOMESKIN_URL}/img2/btn_funding_h.png" alt="펀딩하기" class="rollover"/></a>-->
				</div><!-- main_txt_left -->

				

			<!--	<div class="main_btn">
					<a href="{MARI_HOME_URL}/?mode=invest"><img src="{MARI_HOMESKIN_URL}/img2/btn_invest_more.png" alt="투자상품 한 눈에 보기" /></a>
					<a href="{MARI_HOME_URL}/?mode=guide_invest"><img src="{MARI_HOMESKIN_URL}/img2/btn_guide.png" alt="펀딩 및 대출 방법 알아보기" /></a> 
				</div> main_btn -->

			</div><!-- visual_inner-->
		</div> <!--visual_wrap-->

		<div class="content1">
			<p>집계기준일 : <span id="showTime"></p>
			<ul>
				<li>
					<p>평균수익률</p>
					<p><?php if($top_plus){?><?php echo number_format($top_plus,1);?><?php }else{?>0<?php }?>%</p>
				</li>
				<li>
					<p>누적투자액</p>
					<p><?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']); }else{ echo number_format($t_pay); } ?><span class="won">원</span></p>
				</li>
				<li>
					<p>누적상환액</p>
					<p><?php echo number_format($Loanrepayments) ?><span class="won">원</span></p>
				</li>
				<li>
					<p>
						연체율&nbsp;<span class="detailterm1"> ? </span>
						<span class="detail">
							<div class="detail_pop_up1">
								<ul>
									<li class="pop_title"> 연체율</li>
									<li> &bull; <span class="pop_title2">연체의 정의</span> : 상환일로부터 30일 이상~ </br>90일 미만동안 상환이 지연되는 현상</li>
									<li> &bull; <span class="pop_title2">연체율 정의</span> : 현재 미상환된 대출 잔액 중 연체중인 </br> 건의 잔여원금의 비중</li>
									<li> &bull; <span class="pop_title2">계산방법</span> : 연체 중인 채권의 잔여원금/대출잔액 </br> (취급총액 중 미상환 금액)</li>
									<li> &bull; <span class="pop_title2">예시</span> : 만기일시의 경우 연체발생 시  </br>전체 원금이 연체중인 잔여원금으로 잡힘</li>
								</ul>
							</div>
						</span>
					</p>
					<p><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</p>
				</li>
				<li>
					<p>
						부실률&nbsp;<span class="detailterm2"> ? </span>
						<span class="detail">
							<div class="detail_pop_up2">
								<ul>
									<li class="pop_title"> 부실률</li>
									<li> &bull; <span class="pop_title2">부실의 정의</span> : 정상 상환일로부터 90일 이상 </br> 장기 연체되는 현상</li>
									<li> &bull; <span class="pop_title2">부실률 정의</span> : 현재 튀금된 총 누적대출취급액 </br>중 90일 이상 연테가 된 건의 잔여원금의 비중</li>
									<li> &bull; <span class="pop_title2">계산방법</span> : 90일 이상 장기 연체 증인 채권의 잔여원금 /</br> 총 누적 대출 취급액</li>
									<li> &bull; <span class="pop_title2">예시</span> : 만기일시의 경우 90일 이상의 장기 연체발생시</br> 전체 원금이 90일 이상의 장기 연체중인 잔여원금으로 잡힘</li>
								</ul>
							</div>
						</span>
					</p>
					<p><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</p>
				</li>							
			</ul>
		</div><!-- content1 -->
					



			<div class="section1">
				<div class="section1_inner">
					<div>
						<div>
							<a href="javascript:;" id="pop" class="btn_effect">투자 알림 신청</a>
						</div>
					</div>
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
						</div><!-- element_to_pop_up --> 
				</div>
			</div><!-- section1 -->
			
			
			<div class="content2">
				<div class="content2_inner">
					<div class="content2_title">
						<p>노블펀드 투자상품 <span><a href="" alt=""/>투자상품 더보기+</a></span></p>
					</div>
					<ul class="new_product">
					   <?php
					    for ($i=0; $row=sql_fetch_array($result); $i++) {
						$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
						$iv = sql_fetch($sql, false);
						

						/*투자참여인원*/
						$sql = "select count(*) as cnt from mari_invest where loan_id = '$row[i_id]'";
						$iv_cnt = sql_fetch($sql);
						$iv_per_cnt = $iv_cnt['cnt'];

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
						$sql = " select  * from  mari_category where ca_id='$row[i_payment]'";
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
						$wish = sql_fetch($sql, false);

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
							/*모집마감일 체크*/
							if($iv ['i_invest_eday']<$date){
								$invest_set="Y";
							}
							if($order_pay=="100"){
								$invest_max="Y";
							}
					/*
							if($order_pay != 100 && $iv['i_invest_eday'] > $date){
							*/
					?>	
				<li>
					<div class="invest1">
						<div class="invest1_top">
							<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row[i_id]?>">
								<div class="thumnail">
									<div class="invest1_top_more_open">
										<p>자세히보기</p>
									</div>
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $row['i_id']?>/<?php echo $iv['i_creditratingviews'];?>" alt="product" width="367" height="138" class="product_thumnail">
								</div>
								<!--<?php if($order_pay=="100"){?>
								<div class="thumnail">
									<div class="invest1_top_more_open open2">
										<p>펀딩완료</p>
									</div>
									<img src="{MARI_HOMESKIN_URL}/img2/img_product1.png" alt="" class="product_thumnail" />
								</div>
								<?php }else{?>
									<div class="thumnail">
										<div class="invest1_top_more_open">
											<p>자세히보기</p>
										</div>
										<img src="{MARI_HOMESKIN_URL}/img2/img_product1.png" alt="" class="product_thumnail" />
									</div>	
								<?php }?>-->
							</a>
						</div><!-- invest1_top -->
						<div class="invest1_bottom">
							<div class="invest1_title">
								<h4><?php echo $row[i_subject]?></h4>
								<h5><?php echo $row[i_locaty]?></h5>
							</div>
							<div class="invest1_content">
								<p><span>목표 <?php echo unit2($row[i_loan_pay])?>원</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>연 <?php echo $row[i_year_plus]?>%</span> </p>
								<p>모집기간 : 
								<?php echo substr($iv[i_invest_sday],0,4).".".substr($iv[i_invest_sday],5,2).".".substr($iv[i_invest_sday],8,2)?> ~ 
								<?php echo substr($iv[i_invest_eday],0,4).".".substr($iv[i_invest_eday],5,2).".".substr($iv[i_invest_eday],8,2)?>
								</p>
								<p class="purple"><?php echo $row[i_repay]?></p>
							</div>
							<div class="invest1_grade">
								<p>신용등급</p>
								<div class="grade">
									<div>
									<?php if($iv['i_grade']=="A"){?>
									<img src="{MARI_HOMESKIN_URL}/img2/icon_grade_a.png" alt="grade"/>
									<?php }?>
									</div>
									<div class="grade2">
									<?php if($iv['i_grade']=="B"){?>
									<img src="{MARI_HOMESKIN_URL}/img2/icon_grade_b.png" alt="grade"/>
									<?php }?>
									</div>
									<div class="grade3">
									<?php if($iv['i_grade']=="C"){?>
									<img src="{MARI_HOMESKIN_URL}/img2/icon_grade_c.png" alt="grade"/>
									<?php }?>
									</div>
									<div class="grade4">
									<?php if($iv['i_grade']=="D"){?>
									<img src="{MARI_HOMESKIN_URL}/img2/icon_grade_d.png" alt="grade"/>
									<?php }?>
									</div>
									<div class="grade5">
									<?php if($iv['i_grade']=="E"){?>
									<img src="{MARI_HOMESKIN_URL}/img2/icon_grade_e.png" alt="grade"/>
									<?php }?>
									</div>
								</div><!-- grade -->								
									</div><!-- invest1_grade -->
									<div class="state_gauge">
										<p><span><?php echo $order_pay?>%</span> 진행 (<?php echo $iv_per_cnt?>명)</p>
										<?php if($iv[i_look]=="Y"){?>
										<p><span>펀딩</span>진행중</p>
										<?php }else if($iv[i_look]=="C"){?>
										<p><span>펀딩</span>마감</p>
										<?php }else if($iv[i_look]=="N"){?>
										<p><span>펀딩</span>대기중</p>
										<?php }else if($iv[i_look]=="D"){?>
										<p><span class="red">마감</span>상환중</p>
										<?php }else if($iv[i_look]=="F"){?>
										<p><span class="red">마감</span>상환완료</p>
										<?php }?>
										
										
										<div class="pro-bar-container color-green-sea" style="width:100%;  ">
											<div class="pro-bar color-peter-river"	data-pro-bar-percent="<?php echo $order_pay?>%" data-pro-bar-delay="30" style="width:<?php echo $order_pay?>%; ">
												<div class="pro-bar-candy candy-ltr"></div>
											</div>
										</div>
										<!--<?php if($order_pay=="100"){?>
										<p><span>100%</span> 진행 (143명)</p>
										<p><span class="red">마감</span>상환중</p>
										<div class="pro-bar-container color-green-sea" style="width:100%;  ">
											<div class="pro-bar color-full"	data-pro-bar-percent="100%" data-pro-bar-delay="30" style="width:100%;">
												<div class="pro-bar-candy candy-ltr"></div>
											</div>
										</div>
										<?php }else{?>
										<p><span>50%</span> 진행 (143명)</p>
										<p><span>펀딩</span>진행중</p>
										<div class="pro-bar-container color-green-sea" style="width:100%;  ">
											<div class="pro-bar color-peter-river"	data-pro-bar-percent="<?php echo $order_pay?>%" data-pro-bar-delay="30" style="width:50%;">
												<div class="pro-bar-candy candy-ltr"></div>
											</div>
										</div>
										<?php }?>-->
									</div>
								</div>
							</div>
						</li><!--리스트1-->
						<?php
						/*
						    }
						    */
						}
						    if ($i == 0){?>
						      <img src='{MARI_HOMESKIN_URL}/img/no_invest.png' alt='' class="center"/>
						<?php }?>
					</ul>
				</div><!-- content2_inner -->
			</div><!-- content2-->


		<!--	<div class="section2">
				<div class="section2_inner">
					<img src="{MARI_HOMESKIN_URL}/img2/img_sec2_txt2.png" alt="" />
					
					<div class="guide">
						<div>
							<p>플랫폼 투자 상품에 바로 <span>투자</span>하려면?</p>
							<p>투자하기 앞서 회원가입후에 마이페이지에서 계좌를 발급받으세요</p>
							<p>신규투자 오픈 안내는 SMS또는 메일로 발송됩니다</p>
							<a href="{MARI_HOME_URL}/?mode=invest">투자하기</a>
						</div>
						<div>
							<p>플랫폼 쉽고 빠른 <span>대출</span>을 시작하려면?</p>
							<p>대출하기 앞서 회원가입후에 “대출하기”에서 간단한 정보작성</p>
							<p>타금융과 상환금액과 이자금액을 비교해보는것도 좋은방법입니다.</p>
							<a href="{MARI_HOME_URL}/?mode=loan">대출하기</a>
						</div>
						<img class="mu" src="{MARI_HOMESKIN_URL}/img2/img_mockup.png" alt="" />
					</div>
					
				</div>
			</div> -->
			
			<div class="content3">
				<div class="cont3_title">
					<p>왜? 노블펀드일까요?</p>
				</div>
				<div class="cont3_img">
					<ul>
						<li>
							<p>노플펀드 자체 평가 기준</p>
							<p>기술과 금융이 결합된 부동산 담보평가 시스템이</br>공정/투명하게 평가합니다.</p>
						</li>
						<li>
							<p>신용등급 영향 없음</p>
							<p>대출 후에도 신용등급의 영향없이 기존</br>대출 금리에 영향을 미치지 않습니다.</p>
						</li>
						<li>
							<p>합리적인 이율</p>
							<p>개인과의 직거래로 대출자에겐 합리적 이율을,</br>투자자에겐 고수익을 드립니다.</p>
						</li>
						<li>
							<p>안정성 확보</p>
							<p>전문가들이 엄선한 1순위 부동산 담보를</br>제공함으로써 투자자에게 보다 더 안전합니다.</p>
						</li>
					</ul>
				</div>
			</div>

			<div class="content4">
				<div class="content4_inner">
					<div class="content4_title">
						<p>노블펀드 언론보도 <span><a href="" alt=""/>언론보도 더보기 + </a></span></p>
					</div>

					<div class="media_center">
						<ul class="news">
						<?php 
							$sql ="select * from mari_write where w_table = 'media' and w_main_exposure = 'Y' order by w_datetime desc limit 3";
							$ud = sql_query($sql, false);
							for ($a=0;  $row=sql_fetch_array($ud); $a++){
						?>
							<li>
								<!--<div class="news_thumbnail">
									<img  src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['file_img']?>" width="366" height="154" alt=""/>
									<img  src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="107" height="29" alt=""/>
								</div> -->
								<p class="news_title"><!--<?php echo $row['w_subject'];?>--><?php echo substr($row['w_subject'],0,300);?><!--대한민국, 부동산 P2P 투자 매력에<br/>빠지다. 저금리 기조속 부동산 펀드 설정액 저금리 기조속--></p>
								<p class="news_date"><?php echo substr($row['w_datetime'],0,10); ?></p>
								<span class="title_bar"></span>
								
								<p class="news_content"><?php echo substr($row['w_content'],0,1000);?></p>
												
								<a class="news_more" href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=out">자세히보기 </a>
							</li>
						<?php
							}
							  if ($a == 0){?>
						    <!--<img src='{MARI_HOMESKIN_URL}/img/no_invest.png' alt=''/ class="center">-->등록된 소식이 없습니다.
						  <?php }?>
						  <!--
							<li>
								<div class="news_thumbnail">
									<img src="{MARI_HOMESKIN_URL}/img2/news_th2.png" alt="" />
									<img src="{MARI_HOMESKIN_URL}/img2/media_2.png" alt="" />
								</div>
								<p class="news_date"><?php echo substr($row['w_datetime'],0,10); ?></p>
								<span class="title_bar"></span>
								<p class="news_title">대한민국, 부동산 P2P 투자 매력에<br/>빠지다. 저금리 기조속 부동산 펀드 설정액 저금리 기조속</p>
								<p class="news_content">정기예금 금리 1%대의 사상 최저수준의 은행 기준금리가 지속<br/>되면서저축 재테크는 옛말이 됐다. 부동산을 투자 대상으로<br/>하는 부동산 펀드와 리츠(부동산 투자회사), P2P 금융 등정기예금 금리 1%대의 사상 최저수준의 은행 기준금리가 지속되면서 저축 재테크는 옛말이 됐다. </p>
								<a class="news_more" href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=out">자세히보기 ></a>
							</li>
							<li>
								<div class="news_thumbnail">
									<img src="{MARI_HOMESKIN_URL}/img2/news_th3.png" alt="" />
									<img src="{MARI_HOMESKIN_URL}/img2/media_3.png" alt="" />
								</div>
								<p class="news_date"><?php echo substr($row['w_datetime'],0,10); ?></p>
								<span class="title_bar"></span>
								<p class="news_title">대한민국, 부동산 P2P 투자 매력에<br/>빠지다. 저금리 기조속 부동산 펀드 설정액 저금리 기조속</p>
								<p class="news_content">정기예금 금리 1%대의 사상 최저수준의 은행 기준금리가 지속<br/>되면서저축 재테크는 옛말이 됐다. 부동산을 투자 대상으로<br/>하는 부동산 펀드와 리츠(부동산 투자회사), P2P 금융 등정기예금 금리 1%대의 사상 최저수준의 은행 기준금리가 지속되면서 저축 재테크는 옛말이 됐다. </p>
								<a class="news_more" href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=out">자세히보기 ></a>
							</li>
						-->
						</ul>
					</div><!-- media_center -->
				</div>
			</div><!--content4 -->




	</div><!-- main_content -->
</div><!-- container -->
<?php if($popup[po_skin]){?>
	{# popup}<!--팝업-->
<?php }?>



{#noble_footer}