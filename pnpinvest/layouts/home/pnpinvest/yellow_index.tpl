<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#yellow_header}
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



<div id="container">
	<div id="main_content">
		
		<div class="main_visual">
                	<div class="main_wrap">
                   
				   <div class="main_txt_wrap">
					
						<div class="main_txt_leftwarp">
									<div class="main_txt_left">
										<ul class="bxslider_1">
											<li>
											 <!--<a href="<?php echo $config['c_main_img1_url'];?>"><img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img1'];?>" alt="오픈이벤트배너" /></a>-->
                                                 <a href=""><img src="{MARI_DATA_URL}/favicon/openevent.png" alt=""></a>
											</li>

											<li>
											 <!--<a href="<?php echo $config['c_main_img2_url'];?>"><img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img2'];?>" alt="오픈이벤트배너2" /></a>-->
                                                 <a href=""><img src="{MARI_DATA_URL}/favicon/openevent.png" alt=""></a>
											 </li>
											 <li>
											<!-- <a href="<?php echo $config['c_main_img3_url'];?>"><img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_main_img3'];?>" alt="오픈이벤트배너3" /></a>-->
											<a href=""><img src="{MARI_DATA_URL}/favicon/openevent.png" alt=""></a>
											</li>

										</ul>
									
								   </div><!-- main_txt_left -->
						   </div>

						<div class="main_txt_right">
							<div class="main_txt_rightinner">
							   <p><span>부동산 전문 P2P 금융 플랫폼<br/> 옐로우펀딩</span>은 <br/></p>
								<p>부동산 개발, 분양, 중개, 자산관리 등의<br/>
                                     다양한 부동산 경력을 바탕으로 한 부동산 전문 그룹이<br/>
                                     직접 운영합니다.
								</p>
							 </div>
								<div class="main_txt_rightinner01">
										<a href="{MARI_HOME_URL}/?mode=invest" class="btn_funding">
										<p>투자 바로하기</p>
									   </a>
								</div>	
								
						</div><!-- main_txt_right -->
					
				</div><!-- main_txt_wrap -->
         <script>
			$(document).ready(function(){
			  $('.bxslider_1').bxSlider({
			  auto: true 
			  });  
			});
		</script>
			
			      <div class="main_txt_bottom">
					<ul>
					               
						       <li>
								<p class="text01">누적 투자액</p>
								<p class="text02"><?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']); }else{ echo number_format($t_pay); } ?><span class="won">원</span></p>
							</li>
							<li>
								<p class="text01">누적 상환액</p>
								<p class="text02"><?php echo number_format($Loanrepayments) ?><span class="won">원</span></p>
							</li>
							
							
							<li>
								<p class="text01">수익률(연)</p>
								<p class="text02"><?php if($top_plus){?><?php echo number_format($top_plus,1);?><?php }else{?>0<?php }?>%</p>
							</li>
							<li>
								<p class="text01">부도율
								  <span class="detailterm"><img src="{MARI_HOMESKIN_URL}/img2/help.png" alt="부도율" /></span>
								  <span class="detail">90일 이상 장기연체</span >
								 </p>
								<p class="text02"><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</p>
							</li>		
							
							<li>
								<p class="text01">연체율
								 <span class="detailterm"><img src="{MARI_HOMESKIN_URL}/img2/help.png" alt="연체율" /></span>
								 <span class="detail">30일 이상 ~ 90일 미만 연체</span>
								 </p>
								<p class="text02"><?php if($allpay['i_over_per']){?><?php echo $allpay['i_over_per']?><?php }else{?>0<?php }?>%</p>
							</li>
												
						</ul>
				</div><!--main_txt_bottom  -->
			 </div><!-- main_wrap -->
	       </div><!--main_visual-->	
	        <div class="investalert">
               <div class="investalertInner">
			       <h3>아직 투자 알림 신청 안하셨어요?</h3>
				    <p>이메일 또는 휴대 전화 번호를 입력해 주시면
                          옐로우펀딩의 투자 상품 정보를 받아보실 수 있습니다.</p>
                     <a href="javascript:;" id="pop">
						 <p>투자상품알림받기</p>
					</a> 
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
                        <h3>신규 투자 상품
			  <a href="{MARI_HOME_URL}/?mode=invest" >전체보기</a>
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
						<div class="invest1_top">
						<?php if($row['i_loan_type']=="real"){?>
							<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['i_id']?>">
						<?php }else{?>
							<a href="{MARI_HOME_URL}/?mode=invest_credit&loan_id=<?php echo $row['i_id']?>">
						<?php }?>
								<div class="thumnail">
									<div class="invest1_top_more_open">
                                             <div class="backgroundblack"></div>
									         <img src="{MARI_DATA_URL}/photoreviewers/invest1more.png"alt="더보기"/>
                                       </div>
                              
							   <div class="thumnailTxt">
 	                            <p>
								<?php 
									if($iv['i_look']=="Y"){
										echo '자세히보기';
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




							    <?php if($iv['i_creditratingviews']){?>
							               <img src="{MARI_DATA_URL}/photoreviewers/<?php echo $row['i_id']?>/<?php echo $iv['i_creditratingviews'];?>" alt="product" width="370" height="190" class="product_thumnail">
								 <?php }else{?>
									<img class="product_thumnail" src="{MARI_HOMESKIN_URL}/img/no_image.png" alt="상품이미지" width="370" height="190"/>
								 <?php }?>
                                                              </div><!--thumnail-->
								
							</a>
						</div><!-- invest1_top -->
						<div class="invest1_bottom">
							<div class="invest1_title">
								<h4><?php echo $cate['ca_subject']?></h4>
								<h5><?php echo $row['i_subject']?></h5>
							</div>

							<div class="invest1_content01">
								<p>참여 금액 <strong><span><?php echo change_pay($order)?></span>원</strong></p>
                                                                 <p>펀딩 금액 <strong><span><?php echo change_pay($row['i_loan_pay'])?>원</span></strong></p>
							</div>
							<div class="invest1_content02">
								<p>수익률  <strong><?php echo $row['i_year_plus']?><span>%</span></strong></p>
                                                                 <p>투자기간 <strong> <?php echo $row['i_loan_day']?><span>개월</span></strong></p>
								 <p>평가등급<strong><span><?php echo $iv['i_grade']?></span></strong></p>						

							</div>
                                                     <div class="state_gauge">
								<p>투자 진행률</p>
							         <div class="barcontainer" style="width:100%"  >
								    <p class="bar" style="width:<?php echo $order_pay?>%" ></p>
								 </div>
								 <div class="percent">
								 <p ><strong><?php echo $order_pay;?>%</strong></p>
								
	                              </div>
	                            
						    </div><!--state_gauge-->
						</div><!--invest1_bottom-->
                                             </div><!--invest1-->
					</li><!--리스트1-->         
<?php
    
}
    if ($i == 0){?>
       <img src='{MARI_HOMESKIN_URL}/img/no_invest.png' alt='' class="center"/>
<?php }?>					
                              </ul>

                     </div><!--section01Inner-->	
                </div><!--section01-->	
       
                <div class="section02">
                 <div class="section02Inner">
                  <h3 class="hidden">소개</h3>
		   <ul>
		      <li><img src="{MARI_HOMESKIN_URL}/img2/section02_icon01.png"alt="더보기"/>
		              <p class="section02title">자체 평가 시스템</p>
			      <p  class="section02title_detail">기술과 금융이 결합된 평가 시스템이<br/> 공정하고 투명하게 평가합니다.</p>
			</li>
		      <li><img src="{MARI_HOMESKIN_URL}/img2/section02_icon02.png"alt="더보기"/>
		              <p class="section02title">신용 등급 영향 없음</p>
			      <p  class="section02title_detail">대출 후에도 신용 등급의 영향 없이<br/> 기존 대출의 금리에 영향을 미치지 않습니다.</p>
			</li>
		      <li><img src="{MARI_HOMESKIN_URL}/img2/section02_icon03.png"alt="더보기"/>
		              <p class="section02title">합리적인 이율</p>
			      <p  class="section02title_detail">개인과의 직거래로 대출자에게는 합리적 이율을<br/> 투자자에게는 고수익율을 드립니다.</p>
			</li>
		      <li><img src="{MARI_HOMESKIN_URL}/img2/section02_icon04.png"alt="더보기"/>
		              <p class="section02title">안정성확보</p>
			      <p  class="section02title_detail">부동산 담보를 제공함으로써 <br/>투자자에게 보다 안전 합니다.</p>
			</li>
		   </ul>
		 
		 </div><!--section02Inner-->
               </div><!--section02-->
                
		<div class="section03">
		  <div class="section03Inner">
		    <h3>엔젤 펀딩 파트너스의<span>투자금 보호 시스템</span></h3>
		    <h4>투자자의 원금을 안전하게 관리하고, 채무불이행시 발생하는 위험을 줄이기 위해 투자금 보호 시스템을 운영합니다.</h4>
		      <ul>
		          <li>
			      <img src="{MARI_HOMESKIN_URL}/img2/section03_icon01.png"alt="더보기"/>
		              <p class="section03title">준공 건축물 담보 대환 대출</p>
			      <p  class="section03title_detail">공사가 완료된 후 준공된 건축물을 담보로 <br/> 금융권에서 대환 대출을 통해 상환할 수 있도록 합니다.</p>
			  
			  </li>
		          <li>
			      <img src="{MARI_HOMESKIN_URL}/img2/section03_icon02.png"alt="더보기"/>
		              <p class="section03title">투명하고 공정한 자금관리</p>
			      <p  class="section03title_detail">투자금과 수입금은 별도의 계좌에 이체되고,<br/> 
                                                                            해당하는 사업에 원활히 사용될 수 있게 관리합니다.<br/> 
                                                                            대출자가 자금을 요청할 경우 엔젤펀딩 파트너스는<br/> 
                                                                            공사 진행 현황을 확인 후 자금 조달을 수행합니다.</p>
			  
			  </li>
			  <li>
			      <img src="{MARI_HOMESKIN_URL}/img2/section03_icon03.png"alt="더보기"/>
		              <p class="section03title">담보권 설정</p>
			      <p  class="section03title_detail">기존의 담보부 대출 말소 및 공사비 등을 포함한<br/> 
                                                                             펀딩·대출로 1순위 채권자를 확보합니다.<br/> 
                                                                            대출에 관한 담보권을 설정, 필요 시 담보권 행사로<br/> 
                                                                            투자원금을 보호할 수 있습니다.</p>
			  
			  </li>
			  <li>
			      <img src="{MARI_HOMESKIN_URL}/img2/section03_icon04.png"alt="더보기"/>
		              <p class="section03title">1순위 수익권증서</p>
			      <p  class="section03title_detail">집행 기간 동안에 토지소유권은 신탁사로 이전돼<br/>
                                                                            다른 채무로부터 보호받습니다.<br/>
                                                                            채권자는 신탁사로부터 1순위 수익권증서를 발급받아<br/>
                                                                            채권 회수 권리를 우선적으로 확보합니다.</p>
			  
			  </li>
                       </ul>
		   </div><!--section03Inner-->
              </div><!--section03-->
                 
	      <div class="section04">
	          <div class="section04Inner"> 
		      <h3>엔젤펀딩 파트너스 소식
			 <a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">더보기</a>
		     </h3>
		     <ul>    
	<?php 
		for($i=0; $list=sql_fetch_array($media_list); $i++){
	?>		    
		            <li>
                              <a href="<?php echo $list['w_rink'];?>" <?php if($list['w_blank']=="Y"){?> target="_blank"<?php }?>>
                                        <div class="engelnews">
					        <div class="news_thumbnail">
							<div class="news_thumbnail_hover"></div>
	                                                 <img src="<?php echo MARI_DATA_URL?>/<?php echo $list['w_table']?>/<?php echo $list['file_img']?>" alt="소식이미지" style="width:377px;height:160px;" />
                                                        
						  </div><!--news_thumbnail-->
						<div class="engelnews_bottom">
						      <p class="newslogo"><img src="<?php echo MARI_DATA_URL?>/<?php echo $list['w_table']?>/<?php echo $list['w_logo']?>" style="width:95px;height:20px;" alt="뉴스회사로고" /><p>
	                                              <p class="news_title"><?php echo cut_str($list['w_subject'],26,'..')?><p>
						      <p class="news_content"><?php echo $list['w_content']?><p>
						       <p class="news_date"><?php echo substr($list['w_datetime'],0,10)?><p>
						 </div><!--engelnews_bottom-->

					</div><!--engelnews--> 
				</a>
		           </li><!--리스트1-->
	<?php
		}
	?>
                        </ul>
                  </div><!--section04Inner-->
              </div><!--section04-->

	</div><!-- main_content -->
</div><!-- container -->
<?php if($popup[po_skin]){?>
	{# popup}<!--팝업-->
<?php }?>
{#footer}