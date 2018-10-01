<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# header_sub}

   <script>
	$(function() {
		var invest_detail_inner_height = $(".invest_detail_inner").height(); // invest_detail_inner 세로값
		var footer_height = 500; // 바닥 값
		var quick_mn_scroll = invest_detail_inner_height-footer_height; // invest_detail_inner에서 바닥값을 뺀 값

		 $(".invest_detail_inner").ready(function(){
			$(window).scroll(function() {
				var top = $(window).scrollTop();
					if(top<300){
						$(".invest_quick_menu").animate({"margin-top" : top - 0+"px"}, 10);			
					}
					else if(top>351 && top < quick_mn_scroll ){
						$(".invest_quick_menu").animate({"margin-top" : top - 100+"px"}, 10);			
					}else if (top> quick_mn_scroll ){	
						$(".invest_quick_menu").animate({"margin-bottom" : bottom - 500+"px"}, 10);
					};
			});
		});
	})
</script>

<div id="container">
	<div id="main_content" >
		<div class="invest_view">
			<div class="invest_view_inner">
				<h3><?php echo $loa[i_subject]?></h3>
				<p class="p_date"><?php
						if($order_pay=="100" || $iv['i_invest_eday'] < $date){
							echo '모집종료';
						}else{
							 echo substr($iv[i_invest_sday],0,4).'.'.substr($iv[i_invest_sday],5,2).'.'.substr($iv[i_invest_sday],8,2).' ~ '.substr($iv[i_invest_eday],0,4).'.'.substr($iv[i_invest_eday],5,2).'.'.substr($iv[i_invest_eday],8,2);   
						}
					?></p>
				<div style="width:500px; margin:30px auto; ">
					<div class="pro-bar-container color-turquoise">
						<div class="pro-bar color-nephritis" style="width:<?php echo $order_pay;?>%" data-pro-bar-percent="<?php echo $order_pay;?>" data-pro-bar-delay="30">
							<!--<div class="pro-bar-candy2 candy-ltr"></div>--->
						</div>
					</div><!--//pro-bar-container e -->
					<p class="gauge g_left"><span class="mr5"><?php echo $order_pay;?>%</span> 진행</p>
					<p class="gauge g_right">목표<span class="ml5"><?php echo unit2($loa[i_loan_pay]) ?>원</span></p>
				</div>
			</div><!-- invest_view_inner -->
		</div><!-- invest_view -->
		<div class="invest_detail">
			<div class="invest_detail_inner">
				<div class="info1">
					<ul>	
						<li>
							<img  src="{MARI_HOMESKIN_URL}/img/info1_img1.png" alt="수익률" />
							<p>수익률</p>
							<p><?php echo $loa['i_year_plus']?>%</p>
						</li>
						<li>
							<img src="{MARI_HOMESKIN_URL}/img/info1_img2.png" alt="상환기간" />
							<p>상환기간</p>
							<p><?php echo $loa['i_loan_day']?>개월</p>
						</li>
						<li>
							<img src="{MARI_HOMESKIN_URL}/img/info1_img3.png" alt="상환방식" />
							<p>상환방식</p>
							<p><?php echo $loa['i_repay']?></p>
						</li>
						<li>
							<img src="{MARI_HOMESKIN_URL}/img/info1_img4.png" alt="자체등급" />
							<p>자체등급</p>
							<p><?php echo $iv['i_grade']?></p>
						</li>
					</ul>
				</div><!-- info1 -->
				<div class="info2">
					<h4 id="detail_info"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>투자요약</h4>
					<div class="info2Inner">
							<table class="basic_info">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="30%">
									<col width="30%">
								</colgroup>
								<thead>
									<tr>
										<th>상품종류</th>
										<th>자금용도</th>
										<th>모집금액</th>
										<th>투자수익율</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><?php echo $cate['ca_subject']?></td>
										<td><?php echo $loa['i_purpose']?></td>
										<td><?php echo change_pay($loa['i_loan_pay'])?>원</td>
										<td>연 <?php echo $loa['i_year_plus']?>%</td>
									</tr>
								</tbody>
							</table>
					




				<?php if($loa['i_security_type'] || $loa['i_security_type'] || $loa['i_security_type']){?>
					
							<table class="basic_info">
								<colgroup>
									<col width="">
									<col width="">
									<col width="">
								</colgroup>
								<thead>
									<tr>
									<?php if($loa['i_security_type']){?>
										<th>담보물 유형</th>
									<?php }?>
									<?php if($loa['i_conni']){?>
										<th>담보물 감정가</th>
									<?php }?>
									<?php if($loa['i_conni_admin']){?>
										<th>자체 감정가</th>
									<?php }?>
									<th>LTV</th>
									</tr>
								</thead>
								<tbody>
									<tr>
									<?php if($loa['i_security_type']){?>
									<td><?php echo $loa['i_security_type']?></td>
									<?php }?>
									<?php if($loa['i_conni']){?>
									<td><?php echo change_pay($loa['i_conni'])?>원</td>
									<?php }?>
									<?php if($loa['i_conni_admin']){?>
									<td><?php echo change_pay($loa['i_conni_admin'])?>원</td>
									<?php }?>
									<td>
									<?php if($iv['i_ltv_per']){
											echo $iv['i_ltv_per']."%";
										 }else{
											echo "-";
										 }
									?>
									</td>
									</tr>
								</tbody>
							</table>
					    </div>
					</div>


				<?php }?>

				<?php if($iv['i_repay_plan']<>"0000-00-00" || $iv['i_repay_way'] || $iv['i_repay_info']){?>
					<div class="info2">
						<h4><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>상환정보</h4>
						<div class="basic_info2">
							<ul>
							<?php if($iv['i_repay_plan']<>"0000-00-00"){?>
								<li><span>상환예정</span><?php echo $iv['i_repay_plan'];?></li>
							<?php }?>
							<?php if($iv['i_repay_way']){?>
								<li><span>상환방식</span><?php echo $iv['i_repay_way'];?></li>
							<?php }?>
							<?php if($iv['i_repay_info']){?>
								<li><span>상환재원</span><?php echo $iv['i_repay_info'];?></li>
							<?php }?>
							</ul>
						</div>
					</div><!-- info2 -->
				<?php }?>
				
				<div class="info2">
					<h4 id="detail_info01"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>투자정보</h4>
					<div class="basic_info2">
						<p><?php echo $iv['i_security']?></p>
					</div>
					<div class="product_slide" >
						<ul class="thumbnail">
						<?php if($iv['i_creditratingviews']){?>
							<li>
								<a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_creditratingviews'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_creditratingviews'];?>" alt="product" width="843" height="388">
								</a>
							</li>
						<?php }?>
						<?php if($iv['i_img_detail1']){?>
							<li>
								<a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail1'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail1'];?>" alt="product" width="843" height="388">
								</a>
							</li>
						<?php }?>
						<?php if($iv['i_img_detail2']){?>
							<li>
								<a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail2'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail2'];?>" alt="product" width="843" height="388">
								</a>
							</li>
						 <?php }?>
						 <?php if($iv['i_img_detail3']){?>
							<li>
								<a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail3'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail3'];?>" alt="product" width="843" height="388">
								</a>
							</li>
						 <?php }?>
						</ul>
					</div>
					<script>
						$('.thumbnail').bxSlider({
							  buildPager: function(slideIndex){
							    switch(slideIndex){
							<?php if($iv['i_creditratingviews']){?>
							      case 0:
								return '<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv[i_creditratingviews];?>" alt="product" width="100%" height="100%">';
							<?php }?>
							<?php if($iv['i_img_detail1']){?>
							      case 1:
								return '<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv[i_img_detail1];?>" alt="product" width="100%" height="100%">';
							<?php }?>
							<?php if($iv['i_img_detail2']){?>
							      case 2:
								return '<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv[i_img_detail2];?>" alt="product" width="100%" height="100%">';
							<?php }?>
							<?php if($iv['i_img_detail3']){?>
							      case 3:
								return '<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv[i_img_detail3];?>" alt="product" width="100%" height="100%">';
							<?php }?>
							  
							    }
							  }
							});

					</script>
				</div><!-- info2 -->
				<!--
                    <?php	
					$sql = "select count(*) as cnt from mari_lawyer_appr where loan_id = '$loan_id' and ly_lawyer_use = 'Y'";
					$lawyer = sql_fetch($sql, false);
					$ly_cnt = $lawyer['cnt'];

					if($ly_cnt  > 0){
				?>
					<div class="info2">
						<h4 id="summary"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>심사본부의견</h4>
						<?php 
						$sql = "select * from mari_lawyer_appr where loan_id = '$loan_id' and ly_lawyer_use = 'Y'";
						$ly_appr = sql_query($sql);

						for($i=0; $row = sql_fetch_array($ly_appr); $i++){

							$sql = "select * from mari_lawyer where ly_id = '$row[ly_id]'";
							$lawyer_info = sql_fetch($sql, false);
						?>
						 <div class="basic_info2">
							 <div class="who">
								     <img src="{MARI_DATA_URL}/lawyer/<?php echo $lawyer_info['ly_img'];?>" style="width:120px;" alt=""/>
								     <p>심사원 <?php echo $lawyer_info['ly_name'];?></p>
							   </div>
							    <div class="audit"><?php echo $row['ly_appr'];?></div>							
						  </div>
						  <?php }?>
					</div>
				<?php }?>
				-->
					<?php if($iv['i_rviewers_use']=="Y"){?>
					<div class="info2">
						<h4 ><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>심사본부의견</h4>
						<div class="info2Inner">
							
							<table class="basic_info001">
								<colgroup>
									<col width="20%" />
									<col width="80%" />
								</colgroup>
								<thead>
									<tr>
										<th>심사원</th>
										<th>심사내용</th>
									</tr>
								</thead>
								<tbody>
									<tr >
										<td  class="no_pd"><img style="margin-top:15px; "src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv['loan_id'];?>/<?php echo $iv['i_photoreviewers'];?>" width="116" height="149"  alt="<?php echo $iv['i_reviewers_name'];?>" /><p style="margin-bottom:10px; margin-top:2px;"><?php echo $iv['i_reviewers_name'];?></p></td>
										<td class="no_pd">
											<div class="scroll1"><?php echo $iv['i_reviewers_contact'];?></div>
										</td>
									</tr>
						     	<tr><!--두명-->
										<td class="no_pd"><img src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv['loan_id'];?>/<?php echo $iv['i_photoreviewers_01'];?>" width="116" height="149"  alt="<?php echo $iv['i_reviewers_name_01'];?>" /><p style="margin-bottom:10px;  margin-top:2px;"><?php echo $iv['i_reviewers_name_01'];?></p></td>
										<td class="no_pd">
											<div class="scroll1"><?php echo $iv['i_reviewers_contact_01'];?></div>
										</td>
									</tr>
								</tbody>
							</table><!-- /type6 -->
					     <div class="simsagbox">
							    <ul>
										 <li>&bull; 본 심사보고서는 본 펀딩 상품에 대한 관련서류 등을 검토하고, 현장조사 등을 진행한 결과로 작성되었으며, 본 심사보고서의 내용이 본 펀딩 상품의 사업성의 보장이나 보증을 위한 목적이 아님을 알려드립니다.</li>

								           <li>&bull;본 심사보고서의 내용은 키스톤펀딩의 소유이므로 다른 제3자에게 배포 또는 인용하여서는 안되며, 심사과정에 신뢰할 수 있는 공정성을 다해 객관적으로 심사를 진행하였으나, 정확성 등의 사항은 투자자가 직접 확인 검토 하셔야 합니다. </li>

									   <li>&bull; 본 보고서상의 정보에 따른 손실에 대해서는 당사는 책임지지 않습니다.</li>

							     </ul>
							  </div>

						</div><!-- /invest_v_section2_inner -->
					</div><!-- /invest_v_section2 -->
					<?php }?>


                                <div class="info2">
					<h4 id="locaty_info"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>평가등급</h4>
					<div class="grade_wrap">
						<div class="credit_grade">
							<div class="grade_one"><?php echo $iv['i_grade'];?></div>
							<p>플랫폼 평가등급이란?<strong class="help">?<span>안정성, 수익성, 환금성 세가지의 항목을 합산하여 등급이 (종합점수) 결정됩니다.</span></strong></p>
						</div>
						
						<div class="credit_graph">
							
								<div>								
									<img style="margin-left:<?php echo $per?>%;" src="{MARI_HOMESKIN_URL}/img2/barcenter.png" alt="grade" class="current_grade"/>								
								</div>
							
						</div><!--credit_grade-->
				<?php if($iv['i_ltv_point'] || $iv['i_stability'] || $iv['i_credit_grade'] || $iv['i_refund'] || $iv['i_income'] || $iv['i_position']){?>
					<table class="detail_point">
						<colgroup>
							<col width="20%">
							<col width="40%">
							<!--<col width="15%">-->
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th id="grade01">항목</th>
								<th>설명</th>
								<th colspan="2">평가점수</th>
							</tr>
						</thead>
						<tbody>
						<?php if($iv['i_ltv_point']){?>
							<tr>
								<th>담보비율 (LTV)</th>
								<td>담보 비율:총 담보 부채/담보감정가</td>
								<td>
								<?php for($i=1;$i<=$iv['i_ltv_point']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						<?php if($iv['i_stability']){?>
							<tr>
								<th>안정성</th>
								<td>금액,투자기간</td>
								<td>
								<?php for($i=1;$i<=$iv['i_stability']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						<?php if($iv['i_credit_grade']){?>
							<tr>
								<th>신용등급</th>
								<td>나이스 신용등급</td>
								<td>
								<?php for($i=1;$i<=$iv['i_credit_grade']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						<?php if($iv['i_refund']){?>
							<tr>
								<th>환급성</th>
								<td>아파트,연립 상가등 가중치가 다릅니다.</td>
								<td>
								<?php for($i=1;$i<=$iv['i_refund']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						<?php if($iv['i_income']){?>
							<tr>
								<th>소득</th>
								<td>총 부채 대비 소득이 높으면 가중치가 높음</td>
								<td>
								<?php for($i=1;$i<=$iv['i_income']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						<?php if($iv['i_position']){?>
							<tr>
								<th>위치</th>
								<td>지역,층수,면적등 고려하여 가중치 부여</td>
								<td>
								<?php for($i=1;$i<=$iv['i_position']; $i++){?>
									<img src="{MARI_HOMESKIN_URL}/img/selected.png" alt="0">
								<?php }?>											
								</td>
							</tr>
						<?php }?>
						</tbody>
					</table>
				<?php }?>
                                     </div><!--grade_wrap-->
				</div><!-- info2 -->
				
				 <?php if($iv['i_invest_manage']){?>
			    <div class="info2">
					<h4><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>투자자 보호방법</h4>
					<div class="basic_info2" >
						<?php echo $iv['i_invest_manage']?>                                                
					</div>
				</div><!-- info2 -->
			    <?php }?>
			
				<?php if($loa['i_locaty']){?>
				<div class="info2">
					<h4 id="calculation"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>지역정보</h4>
					<div class="basic_info2" >
						<p><?php echo $loa['i_locaty']?> </p>
					
					<div class="invest_content mt20">
						<input type="hidden" name="i_locaty_01" id="i_locaty_01" value="<?php echo $loa['i_locaty_01'];?>"/>
						<input type="hidden" name="i_locaty_02" id="i_locaty_02" value="<?php echo $loa['i_locaty_02'];?>"/>
						<input type="hidden" name="i_locaty" id="i_locaty_00" value="<?php echo $loa[i_locaty]?>"/>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<?php echo $config[c_map_api]?>&libraries=services,clusterer,drawing"></script>
						
						<div id="map_canvas" ></div>
						<script type="text/javascript">
									  var y = '';
									  var x = '';
										  var address = document.getElementById('i_locaty_00').value;
											var mapContainer = document.getElementById('map_canvas'), // 지도를 표시할 div 
												mapOption = {
												center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
												level: 4 // 지도의 확대 레벨
												};  




											// 지도를 생성합니다    
											var map = new daum.maps.Map(mapContainer, mapOption); 

											// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
											var mapTypeControl = new daum.maps.MapTypeControl();

											// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
											// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
											map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

											// 주소-좌표 변환 객체를 생성합니다
											var geocoder = new daum.maps.services.Geocoder();

											// 주소로 좌표를 검색합니다
											geocoder.addressSearch('<?php echo $loa[i_locaty]?>', function(result, status) {

												// 정상적으로 검색이 완료됐으면 
												 if (status === daum.maps.services.Status.OK) {

												var coords = new daum.maps.LatLng(result[0].y, result[0].x);

													document.getElementById('i_locaty_01').value =result[0].y;
													document.getElementById('i_locaty_02').value =result[0].x;

												// 결과값으로 받은 위치를 마커로 표시합니다
												var marker = new daum.maps.Marker({
													map: map,
													position: coords
												});

												// 인포윈도우로 장소에 대한 설명을 표시합니다
												var infowindow = new daum.maps.InfoWindow({
													content: '<div style="width:150px;text-align:center;padding:6px 0;"><?php echo $loa[i_locaty]?></div>'
												});
												infowindow.open(map, marker);

												// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
												map.setCenter(coords);
												} 
											});    
							</script>

							<!--<div class="invest_info2_part2">
								<p></p>
								<p><a href="http://nland.kbstar.com/quics?page=B025914&cc=b043428:b043506" target="_blank"><img src="{MARI_HOMESKIN_URL}/img/btn_invest_banner.png" alt="부동산"/></a><a href="http://rt.molit.go.kr/" target="_blank"><img src="{MARI_HOMESKIN_URL}/img/btn_invest_banner2.png" alt="국토교통부"/></a></p>	
							</div>-->
					</div><!-- invest_content -->
				   </div><!-- basic_info2 -->
				</div><!-- info2 -->
				<?php }?>

				

			  
			<?php if($total_file > 0 ){?>
			    <div class="info2">
					<h4  id="credit"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>증빙서류</h4>
					<div class="basic_info2">
						<ul class="papers">
						<?php
							for($i=0; $list = sql_fetch_array($file_list); $i++){
						?>
							<li><a href="{MARI_DATA_URL}/file/<?php echo $loan_id?>/<?php echo $list['file_name']?>" download target="_blank" class="hover_change"><p class="pape_text"><?php echo $list['file_name']?> </p></a></li>
						<?php
							}
						?>	
						</ul>
					</div>
				</div><!-- info2 -->
			<?php }?>
           <div class="info7">
						<h4  id="credit"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>대출자 신용정보</h4>
						<div class="info_box2">
							<div class="info_grade">
								<div class="round">
									<p><?php echo $iv['i_invest_level']?>등급&nbsp;<span>(<?php echo $iv['i_level_point']?>/1000)점</span></p>
								</div>
								<div class="grade_t">
									<div class="grade_unit">

											<div>1</div>
											<div>2</div>
											<div>3</div>
											<div>4</div>
											<div>5</div>
											<div>6</div>
											<div>7</div>
											<div>8</div>
											<div>9</div>
											<div>10</div>
									</div>
									<div class="grade-guage">
									<?php for($i=0;$i<10;$i++){
										if($i<$iv['i_invest_level']){
									?>
										<div class="invest_level"></div>
									<?}else{?>
										<div></div>
									<?}	}?>
									
									</div>
									<div class="grade_tb">
											<div class="pull-left">
												<p>상위등급</p>
											</div>
											<div class="pull-right">
												<p>하위등급</p>
											</div>
									</div>
								</div><!--gradet-->
						
							</div>
									<div class="table_gra">
											<table>
												<tr>
													<th>채무불이행</th>
													<td><?php echo number_format($iv['i_debts'])?>원</td>
													<th>신용채무</th>
													<td><?php echo number_format($iv['i_credit_debt'])?>원</td>
												</tr>
												<tr>
													<th>담보채무</th>
													<td><?php echo number_format($iv['i_secured_debt'])?>원</td>
													<th>보증채무</th>
													<td><?php echo number_format($iv['i_guaranteed_debt'])?>원</td>
												</tr>
												
											</table>
										</div>
						</div>

					</div><!--info7-->



			<?php if($iv['i_summary']){?>
				<div class="info2" id="papers">
					<h4 class="red"><img src="{MARI_HOMESKIN_URL}/img2/check.png" alt=""/>투자시 유의사항</h4>
					<div class="basic_info2">
						<?php echo $iv['i_summary']?>  
					</div>
				</div><!-- info2 -->
			<?php }?>
							
			
                <!--<div class="invest_quick_menuleft">
						<ul class="invest_quick_menuleftul">
							<li class="detail_info">
							  <a href="#detail_info">
							    <div class="quickTxt">투자 요약</div> <div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon001.png"></div>
							  </a>
							</li>

                            <li class="detail_info01">
							  <a href="#detail_info01">
							    <div class="quickTxt">투자 정보</div> <div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon010.png"></div>
							 </a>
							</li>
                             <li class="summary">
							 <a href="#summary">
							    <div class="quickTxt">심사본부의견</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon004.png"></div>
							  </a>
							 </li>

							<li class="locaty_info">
							<a href="#locaty_info">
							  <div class="quickTxt"> 평가등급</div><div class="dong"><img  src="{MARI_HOMESKIN_URL}/img/investicon002.png"></div>
							</a>
							</li>
							<li class="grade01">
							   <a href="#grade01">
                                   <div class="quickTxt">투자자 보호방법</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon003.png"></div>
							   </a>
							   </li>
							<li class="calculation">
							<a href="#calculation">
                               <div class="quickTxt">지역정보</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon011.png"></div>
							</a>
							</li>

							<li class="credit">
								<a href="#credit">
							    	<div class="quickTxt">증빙서류</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon005.png"></div>
								</a>
							</li>
							<li class="credit01">
								<a href="#credit01">
								   <div class="quickTxt">대출자 신용정보</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon006.png"></div>
								</a>
							</li>
							<li class="papers">
								<a href="#papers">
								   <div class="quickTxt">투자시 유의사항</div><div class="dong"><img src="{MARI_HOMESKIN_URL}/img/investicon007.png"></div>
								</a>
							
							</li>	
						</ul>
				</div><!--invest_quick_menuleft-->
					<!--quickmenu-->
						<div class="invest_quick_menu">
						<ul>
							<li>펀딩기간</li>
							<li class="info_value"><?php echo $loa['i_loan_day']?> 개월</li>
					     </ul>
                                              <ul>
							<li>펀딩금액</li>
							<li class="info_value"><?php echo change_pay($loa['i_loan_pay'])?>원</li>
					    </ul>
					      <ul>
							<li>참여금액</li>
							<li class="info_value"><?php echo change_pay($order)?>원</li>
					     </ul>
                                              <ul>
							<li>참여자 수</li>
							<li class="info_value">
<!-- 								<?php if($loan_id=="7"){?>128<?php }else if($loan_id=="40"){?><?php echo number_format($invest_cn+=115)?><?php }else{?><?php echo number_format($invest_cn)?><?php }?> -->
								<?php echo $invest_cn?>명</li>
					      </ul>
                                            <!-- <ul>
                                               <li>1인당 투자한도</li>
						<li class="info_value"><?php echo change_pay($iv['i_invest_max'] * $loa[i_loan_pay] / 100)?>원</li>
					       </ul>-->
                                                <ul>
							<li>최소 투자금액</li>
							<li class="info_value"><?php echo change_pay($iv['i_invest_mini'])?>원</li>
						</ul>
                                                <ul>
							<li>펀딩 진행율</li>
							<li class="info_value"><?php echo $order_pay?>%</li>	
						</ul>
							
						<div class="quick_btn_wrap">
						<a href="{MARI_HOME_URL}/?mode=guide_invest" class="">투자가이드</a>
						<a href="{MARI_HOME_URL}/?mode=invest_calculation&loan_id=<?php echo $loan_id;?>" class="">투자계산기</a>
						<?php if($iv[i_look]=="C"){?>
							<a href="javascript:alert('투자가 마감된 상품입니다.');">투자마감</a>
						<?php }else if($iv[i_look]=="N"){?>
							<a href="javascript:alert('투자대기중인 상품입니다.');">투자대기</a>
						<?php }else if($iv[i_look]=="D"){?>
							<a href="javascript:alert('상환중인 상품입니다.');">상환중</a>
						<?php }else if($iv[i_look]=="F"){?>
							<a href="javascript:alert('상환이 완료된 상품입니다.');">상환완료</a>
						<?php }else if($iv[i_look]=="Y"){
								if($order_pay >= "100"){
						?>
							<a href="javascript:alert('투자가 100% 이루어진 상품입니다.');">투자마감</a>
						<?php	}else if($iv['i_invest_eday'] < $date){?>
							<a href="javascript:alert('모집기간이 지난상품입니다.');">투자마감</a>
						<?php	}else{?>
							<a href="{MARI_HOME_URL}/?mode=invest2&loan_id=<?php echo $loan_id;?>">투자하기</a>
						<?php	}
						}
						?>	
				
					</div>
						</div><!--quick_menu e-->
			</div><!-- invest_detail_inner -->
   <script>

      
    

	$(window).scroll(function( e ){
			var scrTop = $(window).scrollTop();
			 var docuH = $("#papers").offset().top;
				if(scrTop>=docuH){
				 
					  $(".invest_quick_menuleftul").css("display","none")
				}else{
				
					 $(".invest_quick_menuleftul").css("display","block")
				}
		
	       	});
		
   </script>
      

		</div><!-- invest_detail -->
		
	</div>
</div>
{#footer}