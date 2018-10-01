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
});
</script>


<div id="container">
	<div id="main_content">
		<div class="main_visual">
			<div class="main_wrap">
				<div class="main_txt_wrap">
					<div class="main_txt_left">
						<img src="{MARI_HOMESKIN_URL}/img2/img_main_txt1.png" alt="" />
						<!--<p>플레이플랫폼-인투윈소프트</p>
						<p>부동산 전문 P2P 금융의</p>
						<p>새로운 도약 수익율 넘버원</p>
						<p>크라우드펀딩 부동산 개발 사업의 노하우로 운영!</p>
						<p>건축자금 금융플랫폼</p>-->
						<a href="{MARI_HOME_URL}/?mode=invest" class="btn_funding rollover"><img src="{MARI_HOMESKIN_URL}/img2/btn_funding.png" alt="펀딩하기" /><img src="{MARI_HOMESKIN_URL}/img2/btn_funding_h.png" alt="펀딩하기" class="rollover"/></a>
					</div><!-- main_txt_left -->
					<div class="main_txt_right">
						<ul>
							<li>
								<p>평균수익률(연)</p>
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
								<p>누적 대출금액</p>
								<p><?php echo number_format($t_loan_pay);?>원</p>
							</li>
							<li>
								<p>누적대출잔여금액</p>
								<p><?php echo number_format($t_loan_pay - $Loanrepayments);?>원</p>
							</li>
							<li>
								<p>상환율</p>
								<p><?php echo number_format((($Loanrepayments / $t_loan_pay)*100),2);?>%</p>
							</li>
							<li>
								<p>연체율</p>
								<p><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</p>
							</li>
							<li>
								<p>부도율</p>
								<p><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</p>
							</li>							
						</ul>
					</div><!-- main_txt_right -->
				</div><!-- main_txt_wrap -->
				<div class="main_btn">
					<a href="{MARI_HOME_URL}/?mode=invest"><img src="{MARI_HOMESKIN_URL}/img2/btn_invest_more.png" alt="투자상품 한 눈에 보기" /></a>
					<a href="{MARI_HOME_URL}/?mode=guide_invest"><img src="{MARI_HOMESKIN_URL}/img2/btn_guide.png" alt="펀딩 및 대출 방법 알아보기" /></a>
				</div><!-- main_btn -->
			</div><!-- main_wrap -->
			<div class="section1">
				<div class="section1_inner">
					<div>
						<div>
							<img src="{MARI_HOMESKIN_URL}/img/alert_img.png" alt="투자알림신청"/>
						</div>
						<div>
							<h4>이메일 또는 휴대 전화 번호를 입력해 주시면<br/>플레이플랫폼의 투자 상품 정보를 받아보실 수 있습니다.</h4>
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
			<div class="section2">
				<div class="section2_inner">
					<img src="{MARI_HOMESKIN_URL}/img2/img_sec2_txt.png" alt="" />
					<!--<h4>플랫폼의 <span>체계</span>적인 상품 <span>선별</span> 시스템</h4>
					<p>플레이플랫폼은 부동산 투자자본 전문프로세스를 통한 안정적이고 수익율이 높은 투자 상품을 제공합니다.</p>-->
					<img src="{MARI_HOMESKIN_URL}/img2/img_sec2.png" alt="" />
				</div>
			</div><!-- section2 -->
			<div class="section3">
				<div class="section3_inner">
					<ul>
						<li>
							<p>PLAY 자체 평가기준</p>
							<p>기술과 금융이 결합된 부동산 담보평가</p>
							<p>시스템이 공정/투명하게 평가합니다.</p>
						</li>
						<li>
							<p>신용 등급 영향 없음</p>
							<p>대출 후에도 신용등급의 영향없이 기존</p>
							<p>대출의 금리에 영향을 미치지 않습니다. </p>
						</li>
						<li>
							<p>합리적인 이율</p>
							<p>개인과의 직거래로 대출자에겐 합리적</p>
							<p>이율을, 투자자에겐 고수익을 드립니다.</p>
						</li>
						<li>
							<p>안정성 확보</p>
							<p>부동산 담보를 제공함으로써</p>
							<p>투자자에게 보다 안전합니다.</p>
						</li>
					</ul>
					<a href="{MARI_HOME_URL}/?mode=guide_invest" class="btn_merit" id="jisun">더 알아보기 > </a>
				</div>
			</div><!-- section3 -->
			<div class="section4">
				<div class="section4_inner">
					<h3><span>플랫폼</span> 신규오픈 투자상품</h3>
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
				</div><!-- section1_inner -->
			</div><!-- section4 -->
			<div class="section2">
				<div class="section2_inner">
					<img src="{MARI_HOMESKIN_URL}/img2/img_sec2_txt2.png" alt="" />
					<!--<h4>플레이플랫폼에서 투자 및 대출하기</h4>-->
					<div class="guide">
						<div>
							<p>플랫폼 투자 상품에 바로 <span>투자</span>하려면?</p>
							<p>투자하기 앞서 회원가입후에 마이페이지에서 계좌를 발급받으세요</p>
							<p>신규투자 오픈 안내는 SMS또는 메일로 발송됩니다</p>
							 
							<a href="{MARI_HOME_URL}/?mode=invest" id="jisun02">투자하기</a>
						</div>
						<div>
							<p>플랫폼 쉽고 빠른 <span>대출</span>을 시작하려면?</p>
							<p>대출하기 앞서 회원가입후에 “대출하기”에서 간단한 정보작성</p>
							<p>타금융과 상환금액과 이자금액을 비교해보는것도 좋은방법입니다.</p>
							<a href="{MARI_HOME_URL}/?mode=loan" id="jisun02">대출하기</a>
						</div>
						<img class="mu" src="{MARI_HOMESKIN_URL}/img2/img_mockup.png" alt="" />
					</div>
					
				</div>
			</div><!-- section2 -->
			<div class="section6">
				<div class="section6_inner">
					<img src="{MARI_HOMESKIN_URL}/img2/img_sec1_1.png" alt="" />
					<!--<h4 class="title_news"><span>언론속의</span> 플레이플랫폼</h4>-->
					<div class="media_center">
						<ul class="news">
						<?php 
							$sql ="select * from mari_write where w_table = 'media' and w_main_exposure = 'Y' order by w_datetime desc limit 3";
							$ud = sql_query($sql, false);
							for ($a=0;  $row=sql_fetch_array($ud); $a++){
						?>
							<li>
								<div class="news_thumbnail">
									<img  src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['file_img']?>" width="366" height="154" alt=""/>
									<img  src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="107" height="29" alt=""/>
								</div>
								<p class="news_date"><?php echo substr($row['w_datetime'],0,10); ?></p>
								<span class="title_bar"></span>
								<p class="news_title"><?php echo $row['w_subject'];?><!--대한민국, 부동산 P2P 투자 매력에<br/>빠지다. 저금리 기조속 부동산 펀드 설정액 저금리 기조속--></p>
								<p class="news_content"><?php echo $row['w_content'];?></p>
								<a class="news_more" href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=out">자세히보기 ></a>
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
			</div><!-- section1 -->
			<div class="promotion">
				<div class="promo1">
					<div class="promo1_inner">
						<img src="{MARI_HOMESKIN_URL}/img2/img_promo1.png">
						<div class="promo1_content">
							<p>플레이플랫폼 이벤트11</p>
							<p>1020상품 신규고객 펀딩시 반반 선이자 지급</p>
							<a href="http://www.esmfintech.com/esmevent/?mode=esm_event" target="_blank">이벤트 참여하기</a>
						</div>
					</div>
				</div><!-- promo1 -->
				<div class="promo2">
					<div class="promo2_inner">
						<img src="{MARI_HOMESKIN_URL}/img2/img_promo2.png">
						<div class="promo2_content">
							<p>플레이플랫폼 이벤트02</p>
							<p>나에게 꼭! 맞는 재테크를 지금 시작하세요</p>
							<a href="http://www.esmfintech.com/esmevent/?mode=esm_event" target="_blank">이벤트 참여하기</a>
						</div>
					</div>
				</div><!-- promo2 -->
			</div>
		</div>
	</div><!-- main_content -->
</div><!-- container -->
<?php if($popup[po_skin]){?>
	{# popup}<!--팝업-->
<?php }?>
{#footer}