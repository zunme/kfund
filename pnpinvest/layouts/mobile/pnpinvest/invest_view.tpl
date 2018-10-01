<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 투자정보
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{# header}

<section id="container">
		<section id="sub_content">
			<div class="invest_wrap">
				
				
					
                      <div class="investTitle">
						
						<h3 class="s_title2"><?php echo $iv['i_invest_name'];?></h3>
						<p class="txtdate"><?php echo substr($iv['i_invest_sday'],0,4); ?>년<?php echo substr($iv['i_invest_sday'],5,2); ?>월<?php echo substr($iv['i_invest_sday'],8,2); ?>일~
							<?php echo substr($iv['i_invest_eday'],0,4); ?>년<?php echo substr($iv['i_invest_eday'],5,2); ?>월<?php echo substr($iv['i_invest_eday'],8,2); ?>일
						</p>

					</div>
					<div class="invest_img">
								<?php if($iv['i_creditratingviews']){?>
									<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id?>/<?php echo $iv['i_creditratingviews'];?>" alt="product" width="370" height="190" class="product_thumnail">
								<?php }else{?>
									<img class="product_thumnail" src="{MARI_HOMESKIN_URL}/img/no_image.png" alt="상품이미지" width="370" height="190"/>
								<?php }?>
					</div>
					<div class="section2">
					 <div  class="invest_view_box">
						<div class="investbarcontainer">
							<div class="investbar" style="width:100%" >
								<div class="investpecent" style="width:<?php echo $order_pay?>%" ></div>
						     </div>
						<p class="gauge g_left"><span class="mr5"><?php echo $order_pay?>%</span> 진행</p>
						<p class="gauge g_right">목표<span class="ml5"><?php echo change_pay($loa['i_loan_pay'])?>원</span></p>
                         </div>
				     </div>
					
					 <!-- <div class="product_slide" >
							<ul class="bxslider01">						
							  <?php if($iv['i_img_detail1']){?>
								<li><a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail1'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
								<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail1'];?>" alt="product" height="200"></a></li>
							<?php }?>
							<?php if($iv['i_img_detail2']){?>
								<li><a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail2'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
								<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail2'];?>" alt="product" height="200"></a></li>
							 <?php }?>
							 <?php if($iv['i_img_detail3']){?>
								<li><a href="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail3'];?>" onclick="window.open(this.href, '','width=1000, height=1000, resizable=no, scrollbars=yes, status=no'); return false">
								<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id;?>/<?php echo $iv['i_img_detail3'];?>" alt="product" height="200"></a></li>
							 <?php }?>
							</ul>
						</div>

						<script>
						$(document).ready(function(){
						$('.bxslider01').bxSlider();
													   });
                          </script>-->
                       
					   <div class="investinfo" >
						<ul>	
								<li>
									<img src="{MARI_HOMESKIN_URL}/img2/mobicon1.png" alt="수익률" />
									<p><?php echo $loa['i_year_plus']; ?>%</p>
									<p>연 수익률</p>
									
									<!--<p>20%</p>-->
								</li>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img2/mobicon2.png" alt="상환기간" />
									<p><?php echo $cate['ca_subject']?></p>
									<p><?php echo $loa['i_repay']?></p>
								</li>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img2/mobicon3.png" alt="상환방식" />
									<p><?php echo $loa['i_loan_day']?>개월</p>
									<p>상환기간</p>
									
									<!--<p>만기일시 상환</p>-->
								</li>
								<li>
									<img src="{MARI_HOMESKIN_URL}/img2/mobicon4.png" alt="자체등급" />
									<p><?php echo change_pay($loa['i_loan_pay'])?></p>
									<p>모집금액</p>
									
									<!--<p>A</p>-->
								</li>
							</ul>
					   </div>	
					   </div>
					   
				
                	<!--<div class="info001">
							<h4>본 채권의 진행상황</h4>
							<div class="in_box1">
							<?php echo $iv['i_binding']?>							
							</div>
					</div><!-- info001 -->



						<div class="info001">
							<h4>투자요약</h4>
							<div class="in_box1">
							<?php echo $iv['i_invest_summary']?>							
							</div>
						</div><!-- info001 -->
					

				
					<div class="info001 point">
							<h4>상환정보</h4>
							<div class="in_box1">
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
							</div>
						</div><!-- info001 -->
				

						<!--<div class="info2">
							<div class="basic_info2">
								<p><?php echo $iv['i_security']?></p>
							</div>-->
						<div class="info001 imp">
							<h4>담보정보</h4>
							<div class="in_box1">
							<?php echo $iv['i_security']?>
							</div>
						</div><!-- info001 -->

				<?php if($iv['i_img_detail1'] && $iv['i_img_detail2'] && $iv['i_img_detail3']){?>
						<div class="info001">
							<h4>담보물 사진</h4>
							<div class="product_slide01">
							<ul class="thumbnail2">		
						<?php if($iv['i_creditratingviews']){?>
						  <li><img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id?>/<?php echo $iv['i_creditratingviews'];?>"  alt="product" width="100%"  height="250"></li>
						<?php }?>
						<?php if($iv['i_img_detail1']){?>
						  <li><img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id?>/<?php echo $iv['i_img_detail1'];?>"  alt="product" width="100%"  height="250"></li>
						<?php }?>
						<?php if($iv['i_img_detail2']){?>
						  <li><img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id?>/<?php echo $iv['i_img_detail2'];?>" alt="product" width="100%"  height="250"></li>
						<?php }?>
						<?php if($iv['i_img_detail3']){?>
						  <li><img src="{MARI_DATA_URL}/photoreviewers/<?php echo $loan_id?>/<?php echo $iv['i_img_detail3'];?>" alt="product" width="100%" height="250"></li>
						<?php }?>
						
						</ul>
					</div>
					<?php } ?>

					<?php if($iv['i_rviewers_use']=="Y" || $iv['i_rviewers_use_01']=="Y"){?>
					<div class="info2_allbox">
						<h4>심사원평가 및 담당자</h4>
						<?php if($iv['i_rviewers_use']=="Y"){?>
						<div class="pho_box">
							<div class="lt_photo_img">
							<div class="photo_box">
							<!--<img src="{MARI_HOMESKIN_URL}/img2/info1_img5.png" alt=""/>-->
							<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv['loan_id'];?>/<?php echo $iv['i_photoreviewers'];?>" />
							</div>
							<p><strong>심사원<span class="se_name"><?php echo $iv['i_reviewers_name'];?></span></strong></p>
							</div>
							<div class="rt_txtbox">
							<!--펀딩 홍길동 심사원입니다.</br>
							토지등기부등본 상 2017년 3월 31일에 신탁을 원인으로 소유권 이전등기가 완료되었습니다.</br>
							그 외 별도의 부동산 소유관계에 대한 권리가 없음을 확인합니다. -->
								<?php echo $iv['i_reviewers_contact'];?>
							</div>
						</div>
						<?php }?>
						<?php if($iv['i_rviewers_use_01']=="Y"){?>
						<div class="pho_box">
							<div class="lt_photo_img">
							<div class="photo_box">
							<!--<img src="{MARI_HOMESKIN_URL}/img2/info1_img5.png" alt=""/>-->
							<img src="{MARI_DATA_URL}/photoreviewers/<?php echo $iv['loan_id'];?>/<?php echo $iv['i_photoreviewers_01'];?>" />
							</div>
							<p><strong>심사원<span class="se_name"><?php echo $iv['i_reviewers_name_01'];?></span></strong></p>
							</div>
							<div class="rt_txtbox">
							<!--펀딩 홍길동 심사원입니다.</br>
							토지등기부등본 상 2017년 3월 31일에 신탁을 원인으로 소유권 이전등기가 완료되었습니다.</br>
							그 외 별도의 부동산 소유관계에 대한 권리가 없음을 확인합니다. -->
								<?php echo $iv['i_reviewers_contact_01'];?>
							</div>
						</div>
						<?php }?>

						  <div class="simsagbox">
							    <ul>
										 <li>&bull; 본 심사보고서는 본 펀딩 상품에 대한 관련서류 등을 검토하고, 현장조사 등을 진행한 결과로 작성되었으며, 본 심사보고서의 내용이 본 펀딩 상품의 사업성의 보장이나 보증을 위한 목적이 아님을 알려드립니다.</li>

								           <li>&bull;본 심사보고서의 내용은 키스톤펀딩의 소유이므로 다른 제3자에게 배포 또는 인용하여서는 안되며, 심사과정에 신뢰할 수 있는 공정성을 다해 객관적으로 심사를 진행하였으나, 정확성 등의 사항은 투자자가 직접 확인 검토 하셔야 합니다. </li>

									   <li>&bull; 본 보고서상의 정보에 따른 손실에 대해서는 당사는 책임지지 않습니다.</li>

							     </ul>
							  </div>
					</div><!-- info2_allbox -->
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
					<script>
						$(document).ready(function(){
						 $('.thumbnail2').bxSlider();
						   });
					</script>

						
				   <?php if($total_file){?>
					 <div class="info001">
						<h4>투자자 보호방법</h4>
						<div class="in_box1">
						<?php echo $iv['i_invest_manage']?>     						
						</div>
					</div><!-- info001 -->

					<script>
						$(".pape_text").each(function(){
							var length = 7;
						$(this).each(function(){
							if($(this).text().length>=length){
						$(this).text($(this).text().substr(0,length)+'...');
							}
						});
						});
					</script>
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

				   <div class="info001">
					<h4>증빙서류</h4>
						<ul class="papers" id="papers">
							<?php 
								for($i=0;$row=sql_fetch_array($file_list);$i++){
							?>
										<li>
											<a href="{MARI_DATA_URL}/file/<?php echo $loan_id?>/<?php echo $row['file_name']?>" download target="_blank">
													<p class="pape_text">
													<?php if(strlen($row['file_name'])<13){
															echo substr($row['file_name'],0,strrpos($row['file_name'],'.'));
														}else{
															echo substr($row['file_name'],0,13)."...";
														}
													?>
													</p>
											</a>
										</li>
							<?
								}
							?>
						</ul>
					</div>
					<?}?>


						<div class="info001" >
							<h4>대출자 신용등급</h4>
							<div class="in_box2">
								<div class="round">
									<p><?php echo $iv['i_invest_level']?>등급<span>(<?php echo $iv['i_level_point']?>/1000)점</span></p>
									</div>
								<div class="grade">
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
											<!--<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>
											<div></div>-->
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
										<div class="table_gra">
											<table>
												<tr>
													<th>채무불이행</th>
													<td><?php echo number_format($iv['i_debts'])?>원</td>
												</tr>
												<tr>
													<th>신용채무</th>
													<td><?php echo number_format($iv['i_credit_debt'])?>원</td>
												</tr>
												<tr>
													<th>담보채무</th>
													<td><?php echo number_format($iv['i_secured_debt'])?>원</td>
												</tr>
												<tr>
													<th>보증채무</th>
													<td><?php echo number_format($iv['i_guaranteed_debt'])?>원</td>
												</tr>
											</table>
										</div>
								</div>
							</div>
						</div><!-- info001 -->

						<div class="info001">
							<h4>투자시 유의사항</h4>
							<div class="in_box1">
							<?php echo $iv['i_summary']?>							
							</div>
						</div><!-- info001 -->
      
						<div class="invest_btn_wrap">	
							<a href="{MARI_HOME_URL}/?mode=invest_calculation&loan_id=<?php echo $loan_id;?>">투자계산기</a>
							<!--<a href="?mode=invest2">투자하기</a>-->
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


				
													
			</div><!-- /invest_wrap-->
		</section><!-- /sub_content -->
	</section><!-- /container -->

	<form name="invest_form"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
	</form>













<script>

/*필수체크*/
$(function() {
	$('#invest_form_add').click(function(){
		Invest_form_Ok(document.invest_form);
	});
});


function Invest_form_Ok(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?mode=invest2';
	f.submit();
}
</script>


<script type="text/javascript">
$(function(){
	var slideHeight = 59; 
	var defHeight = $('#wrap2').height();
	if(defHeight >= slideHeight){
		$('#wrap2').css('height' , slideHeight + 'px');
		$('#read-more').append('<a href="#">..더 보기</a>');
		$('#read-more a').click(function(){
			var curHeight = $('#wrap2').height();
			if(curHeight == slideHeight){
				$('#wrap2').animate({
				  height: defHeight
				}, "normal");
				$('#read-more a').html('닫기');
				$('#gradient').fadeOut();
			}else{
				$('#wrap2').animate({
				  height: slideHeight
				}, "normal");
				$('#read-more a').html('..더 보기');
				$('#gradient').fadeIn();
			}
			return false;
		});		
	}
});
</script>

{# footer}<!--하단-->
