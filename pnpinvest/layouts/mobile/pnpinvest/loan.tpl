 <?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 대출신청
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{#header} 

<style type="text/css">
 <!--
.loan_frm1.form-control{}
 //-->
 </style>

<section id="container">
	<section id="sub_content">
	<div class="loan_wrap">
		<form name="loan_apply"  method="post" enctype="multipart/form-data" target="calculation">
			<input type="hidden" name="type" value="w"/>
			<input type="hidden" name="stype" value="loan"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="m_name" value="<?php echo $user[m_name]?>">
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<?php if($member_ck){?>
			<input type="hidden" name="m_name" value="<?php echo $user[m_name]?>">
			<?php }?>
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />
				<div class="container">
					<h3 class="s_title1">대출신청</h3>
					<p class="title_add2">※중도상환은 수수료가 없습니다!</p>
					<dl class="loan_box1">
						<dt class="loan_b1">01 <span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c1">
							<ul class="loan_cont1">
								
								<li>
									<h4 class="loan_title1">이름</h4>
									<input type="text" name="m_name" value="<?php echo $user[m_name];?>" class="frm_input form-control col-xs-12" readonly>
								</li>
								<li>
									<h4 class="loan_title1">휴대폰번호</h4> 
									<div class="form-horizontal">
										<div class="form-group mb0" style="padding:0 3px;">
											<div class="col-xs-12 pb10">
											 
												 <select name="i_newsagency" required class="form-control col-xs-12">
													<option value="">통신사</option>
													<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
													<option value="KT" <?php echo $loa['i_newsagency']=='KT'?'selected':'';?>>KT</option>
													<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LGT</option>
												</select> 
											</div>

											<div class="col-sm-3 col-xs-4 col-xs-12 no_pr" style="">
												<select name="hp1" required class="col-xs-12 col-sm-12 col-xs-12">
													<option>선택</option>
													<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
													<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
													<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
													<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
													<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
												</select>
											</div>
											<div class="col-sm-3 col-xs-4 col-xs-12" style="">
												<input type="text" name="hp2" value="<?php echo $hp2;?>" id="" maxlength="4" required  class="frm_input form-control col-xs-12" size="40" />
											</div>
											<div class="col-sm-3 col-xs-4 col-xs-12 no_pl" style="">
												<input type="text" name="hp3" value="<?php echo $hp3;?>" id="" maxlength="4" required  class="frm_input form-control col-xs-12" size="40" />
											</div>

										</div>
									</div>
								</li>
								<li>
									<h4 class="loan_title1">휴대전화 명의</h4>
									<div class="form-horizontal">
										<div class="form-group mb0">
											<div class="col-sm-4 pb3">
												<select name="i_pmyeonguija" required class="form-control col-xs-4">
													<option value="">명의 선택</option>
													<option value="본인" <?php echo $loa['i_pmyeonguija']=='본인'?'selected':'';?>>본인</option>
													<option value="가족" <?php echo $loa['i_pmyeonguija']=='가족'?'selected':'';?>>가족</option>
													<option value="기타" <?php echo $loa['i_pmyeonguija']=='기타'?'selected':'';?>>기타</option>
												</select> 

												<input type="text" name="i_myeonguija" id="" class="form-control col-xs-8" value="<?php echo $loa['i_myeonguija'];?>" placeholder="명의자 이름"  maxlength="20" required/>
 
											</div>
										</div>
									</div>
								</li>
										<!-- 소재지 -->
								<li>
									<h4 class="loan_title1">소재지</h4>
									<div class="loan_frm1">
										<input  type="text" name=i_locaty id="i_locaty_00" itemname="Address"  onKeyDown="if(event.keyCode==13){codeAddress();}" class="form-control col-xs-12"  size="50"> <img src="{MARI_ADMINSKIN_URL}/img/adress3_btn.png" onclick="codeAddress()" style="cursor:pointer;" ><br/><br/>

										<div id="mgmap"></div>
										<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<?php echo $config[c_map_api]?>&libraries=services,clusterer,drawing"></script>
										<script type="text/javascript">
											  function codeAddress(results, status){
											 // var lat = '';
											  //var lng = '';
											var x = '';
											var y = '';

											  var address = document.getElementById('i_locaty_00').value;
											  var mapContainer = document.getElementById('mgmap'), // 지도를 표시할 div 
												  mapOption = {
														center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
														level: 4 // 지도의 확대 레벨
														};  
													// 지도를 생성합니다    
													var map = new daum.maps.Map(mapContainer, mapOption); 
													// 주소-좌표 변환 객체를 생성합니다
													var geocoder = new daum.maps.services.Geocoder();
													// 주소로 좌표를 검색합니다
													//geocoder.addr2coord(''+address+'', function(status, result) {
													geocoder.addressSearch(''+address+'', function(result, status){
														// 정상적으로 검색이 완료됐으면 
														 if (status === daum.maps.services.Status.OK) {
//														var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
//															document.getElementById('i_locaty_01').value =result.addr[0].lat;
//															document.getElementById('i_locaty_02').value =result.addr[0].lng;

														var coords = new daum.maps.LatLng(result[0].y, result[0].x);
															document.getElementById('i_locaty_01').value = result[0].y;
															document.getElementById('i_locaty_02').value = result[0].x;


														// 결과값으로 받은 위치를 마커로 표시합니다
														var marker = new daum.maps.Marker({
															map: map,
															position: coords
														});
														// 인포윈도우로 장소에 대한 설명을 표시합니다
														var infowindow = new daum.maps.InfoWindow({
															content: '<div style="width:150px;text-align:center;padding:6px 0;">검색된 지점</div>'
														});
														infowindow.open(map, marker);
														// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
														map.setCenter(coords);
														} 
													});    
													 }
											</script>
									
									</div>
								</li>
								<li>
									<h4 class="loan_title1">제목</h4>
									<div class="loan_frm1">
										<input type="text" maxlength="50" name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="form-control frm_input col-xs-12" size="90" />
									</div>
								</li>
								<li>
									<h4 class="loan_title1">대출 상품</h4>
									<div class="loan_frm1">
												<select name="i_payment" class="form-control col-xs-12">
													<option>상품을 선택하세요</option>
											<?php
											  for ($i=0; $row=sql_fetch_array($cate1); $i++) {
											?>
													<option value="<?php echo $row['ca_id'];?>"><?php echo $row['ca_subject'];?></option>
											<?php
											    }
											?>
											</select>
									</div>
								</li>
								<li>
									<h4 class="loan_title1">자금 용도</h4>
									<div class="loan_frm1">
										<input type="text" maxlength="50" name="i_purpose" value="<?php echo $loa['i_purpose'];?>" id=""  required class="frm_input form-control col-xs-12" size="90" />
									</div>
								</li>
								<li>
									<h4 class="loan_title1">대출 금액 <span class="unit">단위 : 원</span></h4>
									<div class="loan_frm1">
										<input type="text" class="frm_input form-control col-xs-12 " maxlength="15" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>"onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required size="40" />
									</div>
								</li>
								<li>
									<h4 class="loan_title1">대출 기간</h4>
									<div class="loan_frm1">
										<select name="i_loan_day" class="form-control col-xs-12" required>
											<option>선택</option>
											<option value="36" <?php echo $loa['i_loan_day']=='36'?'selected':'';?>>36</option>
											<option value="24" <?php echo $loa['i_loan_day']=='24'?'selected':'';?>>24</option>
											<option value="12" <?php echo $loa['i_loan_day']=='12'?'selected':'';?>>12</option>
										</select>
									</div>
								</li>
								<li>
									<h4 class="loan_title1">희망 금리 <span class="unit">단위 : %</span></h4>
									<div class="loan_frm1">
										<input type="text" name="i_year_plus" value="<?php echo $loa['i_year_plus'];?>" id="" required class="frm_input form-control col-xs-12" size="40"/>
									</div>
								</li>
								<li>
									<h4 class="loan_title1">상환 방식</h4>
									<div class="loan_frm1">
										<select name="i_repay"  class="form-control col-xs-12" required>
											<option>선택</option>
											<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
											<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
										</select>
									</div>
								</li>
								<li>
									<h4 class="loan_title1">대출 상환일<span>(매월)</span></h4>
									<div class="loan_frm1">
										<select name="i_repay_day" class="form-control col-xs-12" required>
											<option>선택</option>
											<option value="1" <?php echo $loa['i_repay_day']=='1'?'selected':'';?>>1</option>
											<option value="2" <?php echo $loa['i_repay_day']=='2'?'selected':'';?>>2</option>
											<option value="3" <?php echo $loa['i_repay_day']=='3'?'selected':'';?>>3</option>
											<option value="4" <?php echo $loa['i_repay_day']=='4'?'selected':'';?>>4</option>
											<option value="5" <?php echo $loa['i_repay_day']=='5'?'selected':'';?>>5</option>
											<option value="6" <?php echo $loa['i_repay_day']=='6'?'selected':'';?>>6</option>
											<option value="7" <?php echo $loa['i_repay_day']=='7'?'selected':'';?>>7</option>
											<option value="8" <?php echo $loa['i_repay_day']=='8'?'selected':'';?>>8</option>
											<option value="9" <?php echo $loa['i_repay_day']=='9'?'selected':'';?>>9</option>
											<option value="10" <?php echo $loa['i_repay_day']=='10'?'selected':'';?>>10</option>
											<option value="11" <?php echo $loa['i_repay_day']=='11'?'selected':'';?>>11</option>
											<option value="12" <?php echo $loa['i_repay_day']=='12'?'selected':'';?>>12</option>
											<option value="13" <?php echo $loa['i_repay_day']=='13'?'selected':'';?>>13</option>
											<option value="14" <?php echo $loa['i_repay_day']=='14'?'selected':'';?>>14</option>
											<option value="15" <?php echo $loa['i_repay_day']=='15'?'selected':'';?>>15</option>
											<option value="16" <?php echo $loa['i_repay_day']=='16'?'selected':'';?>>16</option>
											<option value="17" <?php echo $loa['i_repay_day']=='17'?'selected':'';?>>17</option>
											<option value="18" <?php echo $loa['i_repay_day']=='18'?'selected':'';?>>18</option>
											<option value="19" <?php echo $loa['i_repay_day']=='19'?'selected':'';?>>19</option>
											<option value="20" <?php echo $loa['i_repay_day']=='20'?'selected':'';?>>20</option>
											<option value="21" <?php echo $loa['i_repay_day']=='21'?'selected':'';?>>21</option>
											<option value="22" <?php echo $loa['i_repay_day']=='22'?'selected':'';?>>22</option>
											<option value="23" <?php echo $loa['i_repay_day']=='23'?'selected':'';?>>23</option>
											<option value="24" <?php echo $loa['i_repay_day']=='24'?'selected':'';?>>24</option>
											<option value="25" <?php echo $loa['i_repay_day']=='25'?'selected':'';?>>25</option>
											<option value="26" <?php echo $loa['i_repay_day']=='26'?'selected':'';?>>26</option>
											<option value="27" <?php echo $loa['i_repay_day']=='27'?'selected':'';?>>27</option>
											<option value="28" <?php echo $loa['i_repay_day']=='28'?'selected':'';?>>28</option>
											<option value="29" <?php echo $loa['i_repay_day']=='29'?'selected':'';?>>29</option>
											<option value="30" <?php echo $loa['i_repay_day']=='30'?'selected':'';?>>30</option>
											<option value="31" <?php echo $loa['i_repay_day']=='31'?'selected':'';?>>31</option>
										</select>
									 
									</div>
								</li>
								<li>
									<h4 class="loan_title1">건축면적</h4>
									<div class="loan_frm1">
										<p>※단위는 m<sup>2</sup>(제곱미터입니다.)</p>
										<input type="text" maxlength="50" name="i_area" value="<?php echo $loa['i_area'];?>" id=""  required class="frm_input form-control col-xs-12" size="90" />
									</div>
								</li>
								<li>
									<h4 class="loan_title1">총 세대수</h4>
									<div class="loan_frm1">
										<input type="text" maxlength="50" name="i_gener" value="<?php echo $loa['i_gener'];?>" id=""  required class="frm_input form-control col-xs-12" size="90" />
									</div>
								</li>
								
							</ul><!-- /loan_cont1 -->
						</dd>
					
						<dt class="loan_b3">02 <span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c3">
							<?php if($config['c_nice_use'] == "Y" && $member_ck){?>
							<div class="loan_btn_wrap1"><a href="javascript:fnPopup();"><img src="{MARI_MOBILESKIN_URL}/img/btn_credit1.png" alt="신용보고서 조회" /></a></div>
							<?php }?>
							<ul class="loan_cont1">
							<?php if($config['c_nice_use'] == "Y" && $member_ck){?>
								<li>
									<h4 class="loan_title1">신용 평점</h4>
									<div class="loan_frm1">
										<input type="text" name="i_creditpoint_one" class="form-control col-xs-12" value="<?php echo $loa['i_creditpoint_one'];?>" required id=""/>
 
									</div>
								</li>
								<li>
									<h4 class="loan_title1">신용 등급</h4>
									<div class="loan_frm1">
										<input type="text" name="i_creditpoint_two" class="form-control col-xs-12" value="<?php echo $loa['i_creditpoint_two'];?>" required id=""/>
								 
									</div>
								</li>
							<?php }?>





					<li class="loan_section2">
						 
					 <h4 class="loan_title1">부채 내역</h4>
		 
			 
					 




						<table class="" style="width:100%;">
						 
								<?php if(!$deb['m_id']){?>
								<input type="hidden" name="uptype" value="insert"/>
								<?php }else{?>
								<input type="hidden" name="num" value="<?php echo $deb['i_no'];?>"/>
								<input type="hidden" name="uptype" value="update"/>
								<?php }?>
								<thead>
									<!--<td>금융기관 분류</td>
									<td>금융기관명</td>
									<td>대출잔액</td>
									<td>대출구분</td>-->

								</thead>
							<tbody id="mytable">
				<?php
				if(!$deb['m_id']=="")
				{
					$i_debt_list = explode("[RECORD]",$deb[i_debt_list]);
					if($deb[i_debt_list]!="")
					{
						for($i=0;$i<count($i_debt_list);$i++)
						{
							$tmp_option = explode("[FIELD]",$i_debt_list[$i]);
							?>
								<tr>
									<td>
										 	 
											<select name="i_debt_company[]" class="form-control col-xs-12 no_pl no_pr">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>


									<td>
							 
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input col-xs-12 no_pl no_pr" alt="금융기관명"/>
									</td>


									<td>
										 
										<input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="form-control frm_input col-xs-12 no_pl no_pr" size="35" alt="대출잔액"/>
									</td>
									<td>
									 
										<select name="i_debt_kinds[]"  class="col-xs-12 no_pl no_pr">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);" class="">
											<span alt="삭제" onclick="delete_row()"/>X</span>
										</a>
									</td>
								</tr>
					<?php
						}
					}
					else
					{
					?>
								<tr>
									<td>
										 	
											<select name="i_debt_company[]" class="form-control col-xs-12">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>


									<td>
										
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input col-xs-12" alt="금융기관명"/>
									</td>


									<td>
								
										<input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="form-control frm_input col-xs-12" size="35" alt="대출잔액"/>
									</td>
									<td>
									
										<select name="i_debt_kinds[]" class="col-xs-12">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);" class="col-xs-12">
											<span alt="삭제" onclick="delete_row()"/>X</span>
										</a>
									</td>
								</tr>
					<?php
						}
					}
					else
					{
					?>
								<tr>
									<td>
										 	<label for="" class="ontrol-label">금융기관분류</label>
											<select name="i_debt_company[]" class="fform-control frm_input col-xs-12 no_pl no_pr">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>


									<td>
										<label for="" class="ontrol-label">금융기관명</label>
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input col-xs-12 no_pl no_pr" alt="금융기관명"/>
									</td>


									<td>
										<label for="" class="ontrol-label">대출잔액</label>
										<input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="form-control frm_input col-xs-12 no_pl no_pr"  alt="대출잔액"/>
									</td>
									<td>
										<label for="" class="ontrol-label">대출구분</label>
										<select name="i_debt_kinds[]" class="form-control frm_input col-xs-12 no_pl no_pr">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
										<label for="" class="ontrol-label">선택삭제</label>
										<a href="javascript:void(0);">
											<span alt="삭제" onclick="delete_row()"/>X</span>
										</a>
									</td>
								</tr>
					<?php }?>
							</tbody>
						</table>
						<div class="debt_btn">
							<a href="javascript:void(0);">
							<span onclick="add_row()"/>
							부채 내역 추가하기
							</span>
							</a>
						</div>

						<div class="loan_btn_wrap2">
							<a href="javascript:;" id="loan_form_add" class="mobile_btn">대출하기</a>
 
						</div>
					</li><!-- /loan_section2 -->
					</ul><!-- /loan_cont1 -->
						</dd>
					</dl><!-- /loan_cont1 -->

					 
				</div><!--div container-->
			</form>
			</div><!-- /loan_wrap-->
		</section><!-- /sub_content -->
	</section><!-- /container -->
 
<!-- 나이스 본인인증 서비스 팝업을 호출하기 위한 form -->
<form name="form_chk" method="post">
<input type="hidden" name="m" value="safekeyService">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
<input type="hidden" name="EncodeData" value="<?= $enc_data ?>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	    	 해당 파라미터는 추가하실 수 없습니다. -->
<input type="hidden" name="param_r1" value="">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>
<script language='javascript'>
window.name ="Parent_window";

function fnPopup(){
window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafekeyModel/checkplus.cb";
document.form_chk.target = "popupChk";
document.form_chk.submit();
}
</script>							 
						 
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.js"></script>

<script>
/*거주지주소찾기*/
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1').value = data.postcode1;
                document.getElementById('post2').value = data.postcode2;
                document.getElementById('addr1').value = data.address;
                document.getElementById('addr2').focus();
            }
        }).open();
    }

/*직장주소찾기*/
    function openDaumPostcode_r() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1r').value = data.postcode1;
                document.getElementById('post2r').value = data.postcode2;
                document.getElementById('addr1r').value = data.address;
                document.getElementById('addr2r').focus();
            }
        }).open();
    }

/*프리랜서*/
    function openDaumPostcode_a() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1a').value = data.postcode1;
                document.getElementById('post2a').value = data.postcode2;
                document.getElementById('addr1a').value = data.address;
                document.getElementById('addr2a').focus();
            }
        }).open();
    }


/*사업자*/
    function openDaumPostcode_b() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1b').value = data.postcode1;
                document.getElementById('post2b').value = data.postcode2;
                document.getElementById('addr1b').value = data.address;
                document.getElementById('addr2b').focus();
            }
        }).open();
    }


/*대학생*/
    function openDaumPostcode_c() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1c').value = data.postcode1;
                document.getElementById('post2c').value = data.postcode2;
                document.getElementById('addr1c').value = data.address;
                document.getElementById('addr2c').focus();
            }
        }).open();
    }

/*무직자*/
    function openDaumPostcode_d() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById('post1d').value = data.postcode1;
                document.getElementById('post2d').value = data.postcode2;
                document.getElementById('addr1d').value = data.address;
                document.getElementById('addr2d').focus();
            }
        }).open();
    }


/*필수체크*/
$(function(){
	$('#loan_form_add').click(function(){
		Loan_form_Ok(document.loan_apply);
	});
});



function Loan_form_Ok(f){	
	
	
 	 
	if(f.i_newsagency[0].selected == true){ alert('\n통신사를 선택하여주십시오.'); return false;}

	if(f.hp1[0].selected == true){ alert('\n휴대폰 첫째자리를 선택하여주십시오.'); return false;}

	if(!f.hp2.value){alert('\n휴대폰 둘째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.hp3.value){alert('\n휴대폰 셋째자리를 입력하여 주십시오.');f.hp3.focus();return false;}
	
	if(f.i_pmyeonguija[0].selected == true){ alert('\n휴대폰 명의자를 선택하여주십시오.'); return false;}
	
	if(!f.i_myeonguija.value){alert('\n명의자 이름을 입력하여 주십시오.');f.i_myeonguija.focus();return false;}

	if(!f.i_locaty.value){ alert('\n소재지를 입력하여주세요..');f.i_locaty.focus(); return false;}
	
	if(!f.i_subject.value){alert('\n 대출제목을 입력하여 주십시오.');f.i_subject.focus();return false;}

	if(f.i_payment[0].selected == true){ alert('\n대출상품을 선택하여주십시오.'); return false;}

	if(!f.i_purpose.value){alert('\n자금용도를 입력하여 주십시오.');f.i_purpose.focus();return false;}

	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하여 주십시오.');f.i_loan_pay.focus();return false;}

	if(f.i_loan_day[0].selected == true){ alert('\n대출기간을 선택하여 주십시오.'); return false;}
	
	if(!f.i_year_plus.value){alert('\n희망금리를 입력하여 주십시오.');f.i_year_plus.focus();return false;}

	if(f.i_repay[0].selected == true){ alert('\n상환방식을 선택하여 주십시오.'); return false;}

	if(f.i_repay_day[0].selected == true){ alert('\n대출상환일을 선택하여 주십시오..'); return false;}

	if(!f.i_area.value){alert('\n건축면적을 입력하여 주십시오.');f.i_area.focus();return false;}

	if(!f.i_gener.value){alert('\n총 세대수를 입력하여 주십시오.');f.i_gener.focus();return false;}

   	if(!f.i_creditpoint_one.value){ alert('\신용평점을 입력하여주세요..');f.i_creditpoint_one.focus(); return false;}

	if(!f.i_creditpoint_two.value){ alert('\n신용등급을 입력하여주세요..');f.i_creditpoint_two.focus(); return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=loan';
	f.submit();
}



/*부채내역주가&삭제*/
function add_row() {
  mytable = document.getElementById('mytable');
  row = mytable.insertRow(mytable.rows.length);
  cell1 = row.insertCell(0);
  cell2 = row.insertCell(1);
  cell3 = row.insertCell(2);
  cell4 = row.insertCell(3);
  cell5 = row.insertCell(4);
  cell1.innerHTML = "<select name=\"i_debt_company[]\" class=\" form-control frm_input col-xs-12 no_pl no_pr \"><option>선택</option><option value=\"은행/보험\" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option><option value=\"카드/신협/새마을금고\" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option><option value=\"캐피탈/증권사\" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option><option value=\"저축은행\" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option><option value=\"현금서비스\" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"대부업\" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>";
  cell2.innerHTML = "<input type=\"text\" name=\"i_debt_name[]\" value=\"<?php echo $tmp_option[1]?>\"     class=\"form-control frm_input col-xs-12 no_pl no_prl\"  alt=\"금융기관명\"/>";
  cell3.innerHTML = "<input type=\"text\" name=\"i_debt_pay[]\" value=\"<?php echo number_format($tmp_option[2]);?>\"   onkeyup=\"cnj_comma(this);\" onchange=\"cnj_comma(this);\"  class=\"form-control frm_input col-xs-12 no_pl no_pr\"  alt=\"대출잔액\" />";
  cell4.innerHTML = "<select name=\"i_debt_kinds[]\" class=\"form-control frm_input col-xs-12 no_pl no_pr\" ><option>선택</option><option value=\"신용대출\" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option><option value=\"담보대출\" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option></select>";
  cell5.innerHTML = "<a href=\"javascript:void(0);\"><span alt=\"삭제\" onclick=\"delete_row()\"/>X</span></a>";
} 
											
										 
function delete_row() {
  mytable = document.getElementById('mytable');
  if(mytable.rows.length < 2) return;
  mytable.deleteRow(mytable.rows.length-1);
}

/*필수체크*/
$(function(){
	$('#calculation_form_add').click(function(){
		Calculation(document.loan_apply);
	});
});

/*매월 대출이자 계산*/
function Calculation() { 
  var f=document.loan_apply;
  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
	//대출금액
	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하여 주십시오.');f.i_loan_pay.focus();return false;}
	
	//대출기간
	if(f.i_loan_day[0].selected == true){alert('\n대출기간을 선택하세요');return false;}
	//연이자율
	if(!f.i_year_plus.value){alert('\n연이자율을 입력하여 주십시오.');f.i_year_plus.focus();return false;}
	var inter_pattern = /[^(0-9)]/;//숫자
	if(inter_pattern.test(f.i_year_plus.value)){alert('\n연이자율은 숫자만 입력하실수 있습니다');f.i_year_plus.value='';f.i_year_plus.focus();return false;}
	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}
  window.open("about:blank", "calculation", opt);
  f.action="{MARI_HOME_URL}/?mode=calculation";
  f.submit();
}


/*직업 view*/
function div_OnOff(selectList){

	var obj1 = document.getElementById("stype01");
	var obj2 = document.getElementById("stype02");
	var obj3 = document.getElementById("stype03");
	var obj4 = document.getElementById("stype04");
	var obj5 = document.getElementById("stype05");


	if( selectList == "1" ) { // 학생 리스트
		obj1.style.display = "block"; 
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "2" ){
		obj1.style.display = "none"; 
		obj2.style.display = "block";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "3" ){
		obj1.style.display = "none"; 
		obj2.style.display = "none";
		obj3.style.display = "block";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "4" ){
		obj1.style.display = "none"; 
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "block";
		obj5.style.display = "none";
	}else if(selectList == "5" ){
		obj1.style.display = "none"; 
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "block";
	} else { //디폴트
		obj1.style.display = "block"; 
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}
}

function cnj_comma(cnj_str) { 
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = ""; 
		var cnjValue2 = "";

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		for(i=0; i<cnj_str.value.length; i++)      {   
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") { 
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2; 
		} 
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue; 
		} else { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue; 
		} 
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}


</script>

	 <script type="text/javascript">
		$( document ).ready( function() {
			$(".loan_box1 dd:not(:first)").css("display", "none");
			$(".loan_b1").click(function(){
				$(".loan_c1").slideToggle();
			});
			$(".loan_b2").click(function(){
				$(".loan_c2").slideToggle();
			});
			$(".loan_b3").click(function(){
				$(".loan_c3").slideToggle();
			});
		});
	  </script>
 
{# footer}<!--하단-->