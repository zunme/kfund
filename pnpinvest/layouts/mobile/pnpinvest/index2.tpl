<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header}<!--상단-->

<script>
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

	<section id="container">
		<section id="main_content">
			<div class="m_cont1">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 index_txt">							
							<p>부동산 전문 P2P 금융의<br/>새로운 도약 수익율 넘버원<br/><strong>플레이플랫폼 - 인투윈소프트</strong></p>
							<p>크라우드펀딩 부동산 개발 사업의 노하우로 운영!<br/>건축자금 금융플랫폼</p>
							<a href="javascript:;">펀딩하기</a>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 main_state">
							<div>
								<ul>
									<li>
										<p>평균수익율(연)</p>
										<p><strong><?php if($top_plus){?><?php echo number_format($top_plus,2);?><?php }else{?>0<?php }?>%</strong></p>								
									</li>
									<li>
										<p>누적투자액</p>
										<p><strong><?php if($allpay['i_allpay']!=0){ echo number_format($allpay['i_allpay']); }else{ echo number_format($t_pay); } ?>원</strong></p>
									</li>
									<li>
										<p>누적상환액</p>
										<p><strong><?php echo number_format($Loanrepayments) ?>원</strong></p>
									</li>
									<li>
										<p>
											연체율&nbsp;<span class="detailterm1"> ? </span>
											<span class="detail">
												<div class="detail_pop_up1">
													<ul>
														<li class="pop_title"> 연체율</li>
														<li> &bull; <span class="pop_title2">연체의 정의</span> : 상환일로부터 30일 이상~90일 미만동안 상환이 지연되는 현상</li>
														<li> &bull; <span class="pop_title2">연체율 정의</span> : 현재 미상환된 대출 잔액 중 연체중인 건의 잔여원금의 비중</li>
														<li> &bull; <span class="pop_title2">계산방법</span> : 연체 중인 채권의 잔여원금/대출잔액 (취급총액 중 미상환 금액)</li>
														<li> &bull; <span class="pop_title2">예시</span> : 만기일시의 경우 연체발생 시 전체 원금이 연체중인 잔여원금으로 잡힘</li>
													</ul>
												</div>
											</span>
										</p>
										<p><strong><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</strong></p>								
									</li>
									<li>
										<p>
											부실률&nbsp;<span class="detailterm2"> ? </span>
											<span class="detail">
												<div class="detail_pop_up2">
													<ul>
														<li class="pop_title"> 부실률</li>
														<li> &bull; <span class="pop_title2">부실의 정의</span> : 정상 상환일로부터 90일 이상 장기 연체되는 현상</li>
														<li> &bull; <span class="pop_title2">부실률 정의</span> : 현재 튀금된 총 누적대출취급액 중 90일 이상 연테가 된 건의 잔여원금의 비중</li>
														<li> &bull; <span class="pop_title2">계산방법</span> : 90일 이상 장기 연체 증인 채권의 잔여원금 / 총 누적 대출 취급액</li>
														<li> &bull; <span class="pop_title2">예시</span> : 만기일시의 경우 90일 이상의 장기 연체발생시 전체 원금이 90일 이상의 장기 연체중인 잔여원금으로 잡힘</li>
													</ul>
												</div>
											</span>
										</p>
										<p><strong><?php if($allpay['i_default_rates']){?><?php echo $allpay['i_default_rates']?><?php }else{?>0<?php }?>%</strong></p>								
									</li>
									
								</ul>
							</div>
							<div>
								<div class="main_inroduce"><a href="javascript:alert('준비중입니다.');">투자상품 </br>한 눈에 보기 +</a></div>
								<div class="main_guide"><a href="{MARI_HOME_URL}/?mode=invest_proce">펀딩 및 대출방법 </br> 알아보기 +</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
<div class="container">	
	<h4>투자목록 <a href="{MARI_HOME_URL}/?mode=invest"><img src="{MARI_MOBILESKIN_URL}/img/btn_invest_more.png" alt="투자목록더보기"/></a></h4>
	<div class="invest_lst1 row">
		<?php
	    for ($i=0; $row=sql_fetch_array($result); $i++) {
		$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
		$iv = sql_fetch($sql, false);
		/*투자인원 구하기*/
		/*메인에서는 일단 사용안함
		$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
		$incn = sql_fetch($sql, false);
		$invest_cn = $incn['cnt'];
		*/

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
		$wish = sql_fetch($sql, false);

		
	    ?>
							<div class="invest_lst_box col-xs-12 col-sm-6 col-md-4">
									<div class="invest_lst_cont1">
										<div class="lst_cont1">
											<div class="share">
												<?php if($wish['loan_id']==$row['i_id']){?>
												<a href="{MARI_HOME_URL}/?up=wishlist&type=d&loan_id=<?php echo $row['i_id'];?>" class="btn_share"><img src="{MARI_MOBILESKIN_URL}/img/btn_share.png" alt="공유하기"/></a>
											<?php }else{?>
												<?php if(!$member_ck){?>
												<a href="javascript:alert('로그인후 이용하실 수 있습니다.');" class="btn_share"><img src="{MARI_MOBILESKIN_URL}/img/btn_share.png" alt="공유하기"/></a>
												<?php }else{?>
												<a href="{MARI_HOME_URL}/?up=wishlist&type=w&loan_id=<?php echo $row['i_id'];?>" class="btn_share"><img src="{MARI_MOBILESKIN_URL}/img/btn_share.png" alt="공유하기"/></a>
												<?php }?>
											<?php }?>
											</div>
										<?php if(!$iv[i_creditratingviews]){ ?>
											<img src="{MARI_HOMESKIN_URL}/img/no_image.png" alt="product" width="354" height="200" >
										<?php }else{ ?>
											<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $row[i_id]?>/<?php echo $iv[i_creditratingviews]?>" alt="product" width="354" height="200">
										<?php }?>
											
												<div class="invest_complete">
													<?php 
														/*강제 투자마감 처리하거나 모집일이 만료됬거나 모집금액이 100%인경우 투자불가하도록*/
													if($iv[i_look]=="C" ){?>
														<img src="{MARI_MOBILESKIN_URL}/img/img_product_invest3.png" alt="투자마감" />
													<?php }else if($iv[i_look]=="N"){ ?>
														<img src="{MARI_MOBILESKIN_URL}/img/img_product_invest2.png" alt="투자대기" />
													<?php }else if($iv[i_look]=="D" ){ ?>
														<img src="{MARI_MOBILESKIN_URL}/img/img_product_invest4.png" alt="상환중" />
													<?php }else if($iv[i_look]=="F" ){ ?>
														<img src="{MARI_MOBILESKIN_URL}/img/img_product_invest5.png" alt="상환완료" />
													<?php }else{?>
														<img src="{MARI_MOBILESKIN_URL}/img/img_product_invest.png" alt="투자시작" />
													<?php }?>
												</div>
												

										</div>
										<a href="{MARI_HOME_URL}/?mode=invest_view&loan_id=<?php echo $row['i_id']; ?>">
										<h4 class="lst_title1" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap"><?=cut_str(strip_tags($row['i_subject']),22,"…")?></h4>
										<p class="lst_info1"><?php echo $cate['ca_subject']; ?></p>
										<ul>
											<li><img src="{MARI_MOBILESKIN_URL}/img/img_year_plus.png" alt=""/>수익율(만기)&nbsp;<span><?php echo $row['i_year_plus']; ?>%</span></li>
											<li><img src="{MARI_MOBILESKIN_URL}/img/img_recruitment.png" alt=""/>투자모집기간&nbsp;<span><?php echo substr($iv['i_invest_sday'],0,4); ?>.<?php echo substr($iv['i_invest_sday'],5,2); ?>.<?php echo substr($iv['i_invest_sday'],8,2); ?>~ 
															<?php echo substr($iv['i_invest_eday'],0,4); ?>.<?php echo substr($iv['i_invest_eday'],5,2); ?>.<?php echo substr($iv['i_invest_eday'],8,2); ?></span></li>
											<li><img src="{MARI_MOBILESKIN_URL}/img/img_repayment.png" alt=""/>상환방식&nbsp;<span><?php echo $row['i_repay']; ?></span></li>
											<li><img src="{MARI_MOBILESKIN_URL}/img/img_invest_level.png" alt=""/>신용등급 &nbsp;<span><?php echo $iv['i_grade'];?>등급</span></li>
										</ul>
										<div class="invest_progress">
											투자진행 현황 <span><strong><?php if(!$order){ echo '0'; }else{echo number_format(unit($order));} ?>만원</strong>/<?php echo number_format(unit($row['i_loan_pay']));?>만원</span>
										</div>
										<?php if($order_pay=="100"){?>
										<div class="rate_bar_wrap">
											<div class="progress">
											  <div class="progress-bar2" role="progressbar" aria-valuenow="<?php echo $order_pay;?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $order_pay;?>%;">
											</div>
											</div>
											<?php }else{?>
											<div class="rate_bar_wrap">
											<div class="progress">
											  <div class="progress-bar  progress_color" role="progressbar" aria-valuenow="<?php echo $order_pay; ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $order_pay;?>%;">
											</div>
											</div>
											<?php }?>
										</div><!-- /rate_bar_wrap -->
									</div><!-- /invest_lst_cont1 -->
								</a>
							</div><!-- /invest_lst_box -->
							    <?php
		
	    }
 if ($i == 0){?>
		<tr><td colspan=\"".$colspan."\"><img src='{MARI_MOBILESKIN_URL}/img/no_invest.png' alt=''/ class="col-xs-12"></td></tr>
<?php }?>
						 
						</div><!-- /invest_lst1 -->
			</div>

			<div class="container media_center">
			<h4>인투윈소프트가 전하는 언론</h4>
				<ul class="">
					<?php 
									$sql ="select * from mari_write where w_table = 'media' order by w_datetime desc limit 3";
									$ud = sql_query($sql, false);
						for ($a=0;  $row=sql_fetch_array($ud); $a++){
					?>
							<li>
								<div>
									<a href="<?php echo $row['w_rink'];?>" <?php if($row['w_blank']=="Y"){?> target="_blank"<?php }?>>
										<?php if(!$row['file_img']){?>
											<div class="media_img1"><img src="{MARI_HOMESKIN_URL}/img/no_image.gif" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" /></div>
										<?php }else{?>
											<div class="media_img1"><img src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['file_img']?>" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" alt="<?php echo $list['w_subject'];?>" /></div>
										<?php }?>
										
										<div class="media_align">
												<img class="newsp" src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="124px" height="29px" alt=""/>
											<!--<img src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="124px" height="29px" alt=""/>-->
											<span class="media_date"><?php echo substr($row['w_datetime'],0,10); ?></span>
											<h4 class="mt20"><?php echo $row['w_subject'];?></h4>
											<img src="{MARI_HOMESKIN_URL}/img/img_media_line.png" class="col-xs-12 no_pl no_pr" alt="media_line" />
											<span class="news_content mt15"><?php echo $row['w_content'];?></span>
										</div>
									</a>
								</div>
							</li>
					<?php }?>
				</ul>
			</div>



		</section><!-- /main_content -->
	</section><!-- /container -->
{# footer}<!--하단-->