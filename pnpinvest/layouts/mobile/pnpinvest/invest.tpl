<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{#header} 

<script language="javascript">
function go_url(url)
{
	location.href=url;
}
</script>
	<section id="container">
		<section id="investmain">
			<div class="investmainInner">	
                <div class="top_title01">
							 <div class="m_subbox">
								<div class="m_text_cont">
									<p class="s_bar"></p>
									<h2>투자의 격이 다릅니다</h2>
									<h2>보다 확실하고 안전한 투자</h2>
								</div>
							 </div>		
									 <fieldset class="status">
										<legend class="hidden">채권상태</legend>
										   <label for="status">채권상태별</label>
											<select name="look" onchange="javascript:go_url(this.options[this.selectedIndex].value);">
												<option value="{MARI_HOME_URL}/?mode=invest&i_loan_type=<?php echo $i_loan_type;?>&ca_id=<?php echo $ca_id; ?>">전체</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=Y" <?php echo $look=='Y'?'selected':'';?>>투자진행중</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=C" <?php echo $look=='C'?'selected':'';?>>상환완료</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=D" <?php echo $look=='D'?'selected':'';?>>상환중</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=F" <?php echo $look=='F'?'selected':'';?>>상환완료</option>

											</select>
										  
									   </fieldset>
									    <fieldset class="status">
										<legend class="hidden">채권상태</legend>
										   <label for="status">카테고리별</label>
											<select name="look" onchange="javascript:go_url(this.options[this.selectedIndex].value);">
												<option value="{MARI_HOME_URL}/?mode=invest&i_loan_type=<?php echo $i_loan_type;?>&ca_id=<?php echo $ca_id; ?>">전체</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=Y" <?php echo $look=='Y'?'selected':'';?>>이벤트</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=C" <?php echo $look=='C'?'selected':'';?>>건축자금</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=D" <?php echo $look=='D'?'selected':'';?>>사업자대출</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=F" <?php echo $look=='F'?'selected':'';?>>부동산</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=F" <?php echo $look=='F'?'selected':'';?>>개인신용</option>
												<option value="{MARI_HOME_URL}/?mode=invest&ca_id=<?php echo $ca_id;?>&look=F" <?php echo $look=='F'?'selected':'';?>>동산담보</option>

											</select>
										  
									   </fieldset>
										
									<fieldset class="search">
										  <legend class="hidden">통합검색</legend>
										<form name="ivsearch" id="ivsearch" method="get">
										   <input type="hidden" name="mode" value="invest" />									
										   <input type="text" name="stx" value="<?php echo $stx?>" placeholder="투자상품명을 입력하세요">
										   <!--<input type="image" src="{MARI_HOMESKIN_URL}/img2/investicon02.png" alt="검색" >-->
										   <input type="submit" class="seachbtn">
										  </form>
									</fieldset>
						

						  </div>
                           <div class="investbottom">
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

													/*투자인원 구하기*/
													$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
													$incn = sql_fetch($sql, false);
													$invest_cn = $incn['cnt'];

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
								<?php }
								if($i == 0){ ?>
								<p class="center">현재 진행중인 투자 리스트가 없습니다.</p>
								<?php }?> 

								  </ul>
                          </div><!-- /invest1_bottom -->
						   <div class="invest-page">
						   <!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
								<!--<ul class="pagination1" >
									<li><a href="?page=1"><span >«</span></a></li>
									<li class="active"><a href="?page=1">1</a></li>
									<li ><a href="?page=2">2</a></li>
									<li><a href="?page=3">3</a></li>
									<li><a href="?page=3"><span >»</span></a></li>
								</ul>-->
                       </div><!--invest-page-->

			   </div><!-- /investmainInner -->
		</section><!-- /investmain -->
	</section><!-- /container -->
{# footer}<!--하단-->