<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# header_sub} 
<div id="container">
	<div id="main_content">
			<form name="loan_apply"  method="post" enctype="multipart/form-data" target="calculation">
			<input type="hidden" name="type" value="w"/>
			<input type="hidden" name="stype" value="loan"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<?php if($member_ck){?>
			<input type="hidden" name="m_name" value="<?php echo $user[m_name]?>">
			<?php }?>
			
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />
				<div class="loan_wrap">
					<div class="loan_section1">
						<div class="loan_section1_inner">
							<h4 class="loan_title1"><em>01.</em> 대출 신청 정보</h4>
							<div class="table_wrap1">
								<table class="type10">
									
									<tbody>									
									<tr>
										<th>이름</th>
										<td>
										<?php echo $user[m_name]?>
										</td>
									</tr>
									<tr>
										<th>핸드폰번호</th>
										<td>
											<select name="i_newsagency" required style="width:18%;">
												<option value="">통신사 선택</option>
												<option value="SKT" <?php echo $user['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
												<option value="KT" <?php echo $user['m_newsagency']=='KT'?'selected':'';?>>KT</option>
												<option value="LGT" <?php echo $user['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
												<option value="기타" <?php echo $user['m_newsagency']=='기타'?'selected':'';?>>기타</option>
											</select> 
											<select name="hp1" required style="width:10%;">
												<option>선택</option>
												<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
												<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
												<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
												<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
												<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
											</select> -
											<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="10" maxlength="4" required/> -
											<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="10" maxlength="4" required/> 
											<select name="i_pmyeonguija" >
												<option value="">명의 선택</option>
												<option value="본인" selected>본인</option>
												<option value="가족" >가족</option>
												<option value="기타" >기타</option>
											</select> 
											<input type="text" name="i_myeonguija" id="" value="<?php echo $user['m_name'];?>" placeholder="명의자 이름 작성"  maxlength="20" size="25" required/>
										</td>
									</tr>
									<tr>
										<th>소재지</th>
										<td>
											<input  type="text" name=i_locaty id="i_locaty_00" itemname="Address" value="<?php echo $loa['i_locaty'];?>" onKeyDown="if(event.keyCode==13){codeAddress();}" class="frm_input " style="width:50%" size=""> <img src="{MARI_ADMINSKIN_URL}/img/adress3_btn.png" onclick="codeAddress()" style="cursor:pointer;" >
											<div id="map_canvas" style="width: 100%; height: 434px;"></div>
											<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<?php echo $config[c_map_api]?>&libraries=services,clusterer,drawing"></script>
											<script type="text/javascript">
											  function codeAddress(results, status){
											 // var lat = '';
											  //var lng = '';
											var x = '';
											var y = '';

											  var address = document.getElementById('i_locaty_00').value;
											  var mapContainer = document.getElementById('map_canvas'), // 지도를 표시할 div 
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
										</td>
									</tr>		
										<tr>
											<th><span>제목</span></th>
											<td>
											<input type="text" maxlength="50" size="50" name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="frm_input " />
											</td>
										</tr>
										<tr>
											<th><span>대출상품</span></th>
											<td required>
											<select name="i_payment" >
													<option>상품을 선택하세요</option>
											<?php
											$sql = "select * from mari_category";
											$cate1 = sql_query($sql, false);
											  for ($i=0; $row=sql_fetch_array($cate1); $i++) {
											?>
													<option value="<?php echo $row['ca_id'];?>"><?php echo $row['ca_subject'];?></option>
											<?php
											    }
											?>
											</select>
											</td>
										</tr>
										<tr>
											<th><span>자금 용도</span></th>
											<td>
											<input type="text" maxlength="50" name="i_purpose" value="<?php echo $loa['i_purpose'];?>" id=""  required class="frm_input "  />
											</td>
										</tr>	
										<tr>
											<th><span>대출금액</span></th>
											<td>
												<input type="text" maxlength="20" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="40" />
												<label for="">원 &nbsp;&nbsp;</label>
												<a href="javascript:void(0);" ><img src="{MARI_HOMESKIN_URL}/img/loan_c_bt.png"  class="ma_10"alt="매월대출납입금액" onclick="Calculation()"/></a>
											</td>
										</tr>
										<tr>
											<th><span>대출기간</span></th>
											<td>
												<select name="i_loan_day" required>
													<option>선택</option>
													<option value="36" <?php echo $loa['i_loan_day']=='36'?'selected':'';?>>36</option>
													<option value="24" <?php echo $loa['i_loan_day']=='24'?'selected':'';?>>24</option>
													<option value="12" <?php echo $loa['i_loan_day']=='12'?'selected':'';?>>12</option>
												</select>
												<label for="">개월</label>
											</td>
										</tr>
										<tr>
											<th><span>희망 금리</span></th>
											<td>
												<input type="text" name="i_year_plus" value="<?php echo $loa['i_year_plus'];?>" id="" required class="frm_input " size="40" />
												<label for="">%</label>
											</td>
										</tr>
										<tr>
											<th><span>상환 방식</span></th>
											<td>
												<select name="i_repay" required>
													<option>선택</option>
													<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
													<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
				
												</select>
											</td>
										</tr>
										<tr>
											<th><span>대출 상환일</span></th>
											<td>매월
												<select name="i_repay_day" required>
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
												<label for="">일</label>
											</td>
										</tr>
										<tr>
										<tr>
											<th><span>건축면적</span></th>
											<td>
											<input type="text" name="i_area" value="<?php echo $loa['i_area'];?>" id=""  required class="frm_input " size="20" />m<sup>2</sup>
											</td>
										</tr>										
										<tr>
											<th><span>총세대수</span></th>
											<td>
											<input type="text" name="i_gener" value="<?php echo $loa['i_gener'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="20" />가구
											</td>
										</tr>
									</tbody>
								</table><!-- /type7 -->
							</div><!-- /table_wrap1 -->
						</div><!-- /loan_section1_inner -->

					<div class="loan_section2">
					<h4 class="loan_title1"><em>02.</em> 본인 정보</h4>
						<div class="loan_cont1">
						<table class="type10">
					<colgroup>
						<col width="170px">
						<col width="" >
					</colgroup>
					<tbody>
						<tr>
							<th><span>나이</span></th>
							<td>
								<input type="text" name="i_birth" value="<?php echo $age2;?>" id="" required  class="frm_input " size="8" /> <label for="m_birth">세</label>
							</td>
						</tr>
						<tr>
							<th><span>직업</span></th>
							<td colspan="2">
								<p class="pt10">
									<input type='radio' name="i_officeworkers" value="직장인" onclick="div_OnOff('1');" checked> <label class="mr10">직장인</label>
									<input type='radio' name="i_officeworkers" value="프리랜서" onclick="div_OnOff('2');"> <label class="mr10">프리랜서</label>
									<input type='radio' name="i_officeworkers" value="사업자" onclick="div_OnOff('3');"> <label class="mr10">사업자</label>
									<input type='radio' name="i_officeworkers" value="대학생" onclick="div_OnOff('4');"> <label class="mr10">대학생</label>
									<input type='radio' name="i_officeworkers" value="무직자" onclick="div_OnOff('5');"> <label>무직자</label>
								</p>
								<ul class="loan_txt4">
									<li style="display:block;"   id="stype01">
									<!-- <h5>직장인</h5> -->
										<p>
											<strong>직종</strong> 
											<input type="text" name="i_occu_a" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>직장명</strong>  
											<input type="text" name="i_company_name_a" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " size="40" />
										</p>
										<p>
											<strong> </strong>
											<input type="text" name="zip1r"  size="10" id="post1r" required  />
											<a href="javascript:execDaumPostcode_a()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>
											<span id="guide" style="color:#999"></span>
										</p>
										<p style="padding-left:88px;">
												<input type="text" name="addr1r" id="addr1r"   alt='주소'   size="" required/>
												<input type="text" name="addr2r" id="addr2r"  alt='주소'   size="" required/>
										</p>
										<p>
											<strong>직장전화번호</strong>  
											<input type="text" name="i_businesshp_a" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" />
											<span class="color_re2 ml10">※ "-"를 제외한 숫자만 입력하여 주십시오.</span>
										</p>
										<!--
										<p>
											<strong>고용형태</strong> 
											<select name="i_employment_a" required >
												<option>선택</option>
												<option value="정규직" <?php echo $loa['i_employment']=='정규직'?'selected':'';?>>정규직</option>
												<option value="비정규직" <?php echo $loa['i_employment']=='비정규직'?'selected':'';?>>비정규직</option>
												<option value="계약직" <?php echo $loa['i_employment']=='계약직'?'selected':'';?>>계약직</option>
											</select>
										</p>
										<p>
											<strong>근무 개월</strong> 
											<select name="i_company_day_a" required>
												<option>선택</option>
												<option value="12" <?php echo $loa['i_company_day']=='12'?'selected':'';?>>12</option>
												<option value="24" <?php echo $loa['i_company_day']=='24'?'selected':'';?>>24</option>
												<option value="36" <?php echo $loa['i_company_day']=='36'?'selected':'';?>>36</option>
											</select>
											<label for="">개월</label>
										</p>
										-->
												<p>
											<strong>소득금액</strong> 
											<label for="">월</label>
											<input type="text" name="i_plus_pay_mon_a" id="" value="<?php echo $loa['i_plus_pay_mon'];?>" size="" required/>
											<label for="" class="ml5">연</label>
											<input type="text" name="i_plus_pay_year_a" value="<?php echo $loa['i_plus_pay_year'];?>" id="" required class="frm_input " size="" />
										</p>
									</li>
									<li style="display:none;"   id="stype02">
										<!-- <h5>프리랜서</h5> -->
										<p>
											<strong>직종</strong>
											<input type="text" name="i_occu_b" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>직장명</strong>
											<input type="text" name="i_company_name_b" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " size="40" />
										</p>
										<p>
											<strong>직장주소</strong>
											<input type="text" name="zip1a"  size="10" id="post1a" required  /> 
											<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" onclick="javascript:execDaumPostcode_b();" alt="우편번호찾기" />
											<span id="guide" style="color:#999"></span>	
										</p>
										<p style="padding-left:88px;">
											<input type="text" name="addr1a" id="addr1a"   alt='주소'   size="60" required/>
											<input type="text" name="addr2a" id="addr2a"  alt='주소'   size="60" required/>
										</p>
										<p>
											<strong>직장전화번호</strong> <input type="text" name="i_businesshp_b" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" /> 
											<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
										</p>
										<!--
										<p>
											<strong>고용형태</strong>
											<select name="i_employment_b" required >
												<option>선택</option>
												<option value="정규직" <?php echo $loa['i_employment']=='정규직'?'selected':'';?>>정규직</option>
												<option value="비정규직" <?php echo $loa['i_employment']=='비정규직'?'selected':'';?>>비정규직</option>
												<option value="계약직" <?php echo $loa['i_employment']=='계약직'?'selected':'';?>>계약직</option>
											</select>
										</p>
										<p>
											<strong>근무 개월</strong> 
											<select name="i_company_day_b" required>
												<option>선택</option>
												<option value="12" <?php echo $loa['i_company_day']=='12'?'selected':'';?>>12</option>
												<option value="24" <?php echo $loa['i_company_day']=='24'?'selected':'';?>>24</option>
												<option value="36" <?php echo $loa['i_company_day']=='36'?'selected':'';?>>36</option>
											</select>
											<label for="">개월</label>
										</p>
										-->
										<p>
											<strong>소득금액 </strong>
											<label for="">월</label>
											<input type="text" name="i_plus_pay_mon_b" id="" value="<?php echo $loa['i_plus_pay_mon'];?>" size="" required/>
											<label for="" class="ml5">연</label>
											<input type="text" name="i_plus_pay_year_b" value="<?php echo $loa['i_plus_pay_year'];?>" id="" required class="frm_input " size="" />
										</p>
									</li>
									<li style="display:none;"   id="stype03">
									<!-- <h5>사업자</h5> -->
										<p>
											<strong>업종</strong>
											<input type="text" name="i_occu_c" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>사업자명</strong> 
											<input type="text" name="i_businessname_a" value="<?php echo $loa['i_businessname'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>사업장주소</strong>
											<input type="text" name="zip1b"  size="10" id="post1b" required  />
											<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" onclick="javascript:execDaumPostcode_c();" alt="우편번호찾기" />
											<span id="guide" style="color:#999"></span>
										</p>
										<p style="padding-left:88px;">
											<input type="text" name="addr1b" id="addr1b"   alt='주소'   size="60" required/>
											<input type="text" name="addr2b" id="addr2b"  alt='주소'   size="60" required/>
										</p>
										<p>
											<strong>사업장전화번호</strong> 
											<input type="text" name="i_businesshp_c" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" />
											<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
										</p>
										<p>
											<strong>사업기간</strong> 
											<select name="i_project_period" required>
												<option>선택</option>
												<option value="1~2년" <?php echo $loa['i_project_period']=='1~2년'?'selected':'';?>>1~2년</option>
												<option value="3~5년" <?php echo $loa['i_project_period']=='3~5년'?'selected':'';?>>3~5년</option>
												<option value="6~9년" <?php echo $loa['i_project_period']=='6~9년'?'selected':'';?>>6~9년</option>
												<option value="10~15년" <?php echo $loa['i_project_period']=='10~15년'?'selected':'';?>>10~15년</option>
												<option value="15년이상" <?php echo $loa['i_project_period']=='15년이상'?'selected':'';?>>15년이상</option>
											</select>
										</p>
										<p>
											<strong>소득금액</strong>
											<label for="">월</label>
											<input type="text" name="i_plus_pay_mon_c" id="" value="<?php echo $loa['i_plus_pay_mon'];?>" size="" required/>
											<label for="" class="ml5">연</label>
											<input type="text" name="i_plus_pay_year_c" value="<?php echo $loa['i_plus_pay_year'];?>" id="" required class="frm_input " size="" />
										</p>
										<p>
											<p class="papers1">
												<strong>소득서류</strong> 
												<input type="checkbox" name="ppdocuments_01" id="" value="부가가치세과세표준증명" <?php echo $ppdocuments_01=='부가가치세과세표준증명'?'checked':'';?>/> <label for="#">부가가치세과세표준증명</label>
												<input type="checkbox" name="ppdocuments_02" id="" value="소득금액증명원" <?php echo $ppdocuments_02=='소득금액증명원'?'checked':'';?>/> <label for="#">소득금액증명원</label>
												<input type="checkbox" name="ppdocuments_03" id="" value="지역의료보험" <?php echo $ppdocuments_03=='지역의료보험'?'checked':'';?>/> <label for="#">지역의료보험</label>
												<input type="checkbox" name="ppdocuments_04" id="" value="카드매출내역" <?php echo $ppdocuments_04=='카드매출내역'?'checked':'';?>/> <label for="#">카드매출내역</label>
											</p>
											<p class="papers1">
														<strong>재직서류</strong> 
														<input type="checkbox" name="ppdocuments_05" id="" value="사업자등록증" <?php echo $ppdocuments_05=='사업자등록증'?'checked':'';?>/> <label for="#">사업자등록증</label>
														<input type="checkbox" name="ppdocuments_06" id="" value="각종허가증" <?php echo $ppdocuments_06=='각종허가증'?'checked':'';?>/> <label for="#">각종허가증</label>
														</p>
													</li>
													<li style="display:none;"   id="stype04">
														<!-- <h5>대학생</h5> -->
														<p>
														<strong>학교명</strong>
														<input type="text" name="i_businessname_b" value="<?php echo $loa['i_businessname'];?>" id="" required  class="frm_input " size="40" />
														</p>
														<p>
														<strong>학교주소</strong> 
														<input type="text" name="zip1c"  size="10" id="post1c" required  />
														<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" onclick="javascript:execDaumPostcode_d();" alt="우편번호찾기" />
														<span id="guide" style="color:#999"></span>
														</p>
														<p style="padding-left:88px;">
															<input type="text" name="addr1c" id="addr1c"   alt='주소'   size="" required/>
															<input type="text" name="addr2c" id="addr2c"  alt='주소'   size="" required/>
														</p>
														<p>
														<strong>학교전화번호</strong> 
														<input type="text" name="i_businesshp_d" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" /> 
														<span class="color_re2 ml10"> ※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
														</p>
														<p>
														<strong>학과</strong>
														<input type="text" name="i_occu_d" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
														</p>
														<p>
														<strong>학년</strong>
														<select name="i_grade" required>
															<option>선택</option>
															<option value="1" <?php echo $loa['i_grade']=='1'?'selected':'';?>>1</option>
															<option value="2" <?php echo $loa['i_grade']=='2'?'selected':'';?>>2</option>
															<option value="3" <?php echo $loa['i_grade']=='3'?'selected':'';?>>3</option>
															<option value="4" <?php echo $loa['i_grade']=='4'?'selected':'';?>>4</option>
															<option value="5" <?php echo $loa['i_grade']=='5'?'selected':'';?>>5</option>
															<option value="6" <?php echo $loa['i_grade']=='6'?'selected':'';?>>6</option>
															<option value="7" <?php echo $loa['i_grade']=='7'?'selected':'';?>>7</option>
														</select>
														<label for="">학년</label>
														<p>
														<strong>학번</strong>
														<input type="text" name="i_once" value="<?php echo $loa['i_once'];?>" id="" required  class="frm_input " size="40" />
														</p>
														<p>
														<strong>재학구분</strong>
														<select name="i_grade" required>
															<option>선택</option>
															<option value="재학" <?php echo $loa['i_attendinguse']=='재학'?'selected':'';?>>재학</option>
															<option value="휴학" <?php echo $loa['i_attendinguse']=='휴학'?'selected':'';?>>휴학</option>
														</select>
														<p>
													</li>
													<li style="display:none;"   id="stype05">
														<!-- <h5>무직자</h5> -->
														<p>
														<strong>최종학력</strong> 
														<select name="i_businessname_c" required>
															<option>선택</option>
															<option value="중졸" <?php echo $loa['i_businessname']=='중졸'?'selected':'';?>>중졸</option>
															<option value="고졸" <?php echo $loa['i_businessname']=='고졸'?'selected':'';?>>고졸</option>
															<option value="대졸" <?php echo $loa['i_businessname']=='대졸'?'selected':'';?>>대졸</option>
														</select>
														</p>
														<p <span class="color_re2 pt10 pb5">※ 아르바이트 중일 경우 입력하세요.</p>
														<p>
														<strong>직종</strong>
														<input type="text" name="i_occu_e" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
														</p>
														<p>
														<strong>직장명</strong>
														<input type="text" name="i_company_name_c" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " size="40" />
														</p>
														<p>
														<strong>직장주소</strong>
														<input type="text" name="zip1d"  size="10" id="post1d" required  /> 
														<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" onclick="javascript:execDaumPostcode_e();" alt="우편번호찾기" />
														<span id="guide" style="color:#999"></span>
														</p>
														<p style="padding-left:88px;">
															<input type="text" name="addr1d" id="addr1d"   alt='주소'   size="60" required/>
															<input type="text" name="addr2d" id="addr2d"  alt='주소'   size="60" required/>
														</p>
														<p>
														<strong>직장전화번호</strong>
														<input type="text" name="i_businesshp_e" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" /> 
														<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
														</p>
														<!--
														<p>
														<strong>고용형태</strong>
														<select name="i_employment_c" required >
															<option>선택</option>
															<option value="정규직" <?php echo $loa['i_employment']=='정규직'?'selected':'';?>>정규직</option>
															<option value="비정규직" <?php echo $loa['i_employment']=='비정규직'?'selected':'';?>>비정규직</option>
															<option value="계약직" <?php echo $loa['i_employment']=='계약직'?'selected':'';?>>계약직</option>
														</select>
														</p>
														<p>
														<strong>근무 개월</strong>
														<select name="i_company_day_c" required>
															<option>선택</option>
															<option value="12" <?php echo $loa['i_company_day']=='12'?'selected':'';?>>12</option>
															<option value="24" <?php echo $loa['i_company_day']=='24'?'selected':'';?>>24</option>
															<option value="36" <?php echo $loa['i_company_day']=='36'?'selected':'';?>>36</option>
														</select>
														<label for="">개월</label>
														</p>
														-->
														<p>
														<strong>소득금액</strong>
														<label for="">월</label>
														<input type="text" name="i_plus_pay_mon_d" id="" value="<?php echo $loa['i_plus_pay_mon'];?>" size="25" required/>
														<label for="" class="ml5">연</label>
														<input type="text" name="i_plus_pay_year_d" value="<?php echo $loa['i_plus_pay_year'];?>" id="" required class="frm_input " size="25" />
														</p>
													</li>
												</ul>
											</td>
										</tr>
										<tr>
											<th><span>고용형태</span></th>
											<td>
											<select name="i_employment_d" required >
												<option>선택</option>
												<option value="정규직" <?php echo $loa['i_employment']=='정규직'?'selected':'';?>>정규직</option>
												<option value="비정규직" <?php echo $loa['i_employment']=='비정규직'?'selected':'';?>>비정규직</option>
												<option value="계약직" <?php echo $loa['i_employment']=='계약직'?'selected':'';?>>계약직</option>
											</select>
											</td>
										</tr>

											<tr>
											<th><span>근무 개월</span></th>
											<td>
												<select name="i_company_day_d" required>
													<option>선택</option>
													<option value="12" <?php echo $loa['i_company_day']=='12'?'selected':'';?>>12</option>
													<option value="24" <?php echo $loa['i_company_day']=='24'?'selected':'';?>>24</option>
													<option value="36" <?php echo $loa['i_company_day']=='36'?'selected':'';?>>36</option>
												</select>
												<label for="">개월</label>
											</td>
										</tr>
										<tr>
											<th><span>제출가능서류</span></th>
											<td colspan="2">
												<ul class="loan_txt3">
													<li>
														<h5>공통</h5>
														<p>
															<input type="checkbox" name="out_paper_01" id="" value="신분증" <?php echo $out_paper_01=='신분증'?'checked':'';?>/> <label for="#" class="mr5">신분증</label>
															<input type="checkbox" name="out_paper_02" id="" value="등본" <?php echo $out_paper_02=='등본'?'checked':'';?>/> <label for="#" class="mr5">등본</label>
															<input type="checkbox" name="out_paper_03" id="" value="원초본" <?php echo $out_paper_03=='원초본'?'checked':'';?>/> <label for="#" class="mr5">원초본</label>
															<input type="checkbox" name="out_paper_04" id="" value="가족관계증명서" <?php echo $out_paper_04=='가족관계증명서'?'checked':'';?>/> <label for="#" class="mr5">가족관계증명서</label>
															<input type="checkbox" name="out_paper_05" id="" value="주거래통장" <?php echo $out_paper_05=='주거래통장'?'checked':'';?>/> <label for="#">주거래통장</label>
														</p>
													</li>
													<li>
														<h5>소득서류</h5>
														<p>
															<input type="checkbox" name="out_paper_06" id="" value="원천징수영수증" <?php echo $out_paper_06=='원천징수영수증'?'checked':'';?>/> <label for="#" class="mr5">원천징수영수증</label>
															<input type="checkbox" name="out_paper_07" id="" value="갑종근로소득세" <?php echo $out_paper_07=='갑종근로소득세'?'checked':'';?>/> <label for="#" class="mr5">갑종근로소득세</label>
															<input type="checkbox" name="out_paper_08" id="" value="직장의료험납부확인서" <?php echo $out_paper_08=='직장의료보험납부확인서'?'checked':'';?>/> <label for="#" class="mr5">직장의료보험납부확인서</label>
															<input type="checkbox" name="out_paper_09" id="" value="급여통장거래내역서" <?php echo $out_paper_09=='급여통장거래내역서'?'checked':'';?>/> <label for="#">급여통장거래내역서</label>
														</p>
													</li>
													<li>
														<h5>재직서류</h5>
														<p>
															<input type="checkbox" name="out_paper_10" id="" value="재직증명서" <?php echo $out_paper_10=='재직증명서'?'checked':'';?>/> <label for="#" class="mr5">재직증명서</label>
															<input type="checkbox" name="out_paper_11" id="" value="직장의료보험자격득실확인서" <?php echo $out_paper_11=='직장의료보험자격득실확인서'?'checked':'';?>/> <label for="#">직장의료보험자격득실확인서</label>
														</p>
													</li>
												</ul>
											</td>
										</tr>
										<tr>
											<th><span>결혼 여부</span></th>
											<td>
												<select name="i_wedding" required>
													<option>선택</option>
													<option value="미혼" <?php echo $loa['i_wedding']=='미혼'?'selected':'';?>>미혼</option>
													<option value="기혼" <?php echo $loa['i_wedding']=='기혼'?'selected':'';?>>기혼</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><span>주거 소유 형태</span></th>
											<td>
												<select name="i_home_ok" required>
													<option>선택</option>
													<option value="아파트" <?php echo $loa['i_home_ok']=='아파트'?'selected':'';?>>아파트</option>
													<option value="빌라" <?php echo $loa['i_home_ok']=='빌라'?'selected':'';?>>빌라</option>
													<option value="연립" <?php echo $loa['i_home_ok']=='연립'?'selected':'';?>>연립</option>
													<option value="단독주택" <?php echo $loa['i_home_ok']=='단독주택'?'selected':'';?>>단독주택</option>
													<option value="다가구" <?php echo $loa['i_home_ok']=='다가구'?'selected':'';?>>다가구</option>
													<option value="기타" <?php echo $loa['i_home_ok']=='기타'?'selected':'';?>>기타</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><span>주거 현황</span></th>
											<td>
												<select name="i_home_me" required>
													<option>선택</option>
													<option value="본인소유" <?php echo $loa['i_home_me']=='본인소유'?'selected':'';?>>본인소유</option>
													<option value="가족소유" <?php echo $loa['i_home_me']=='가족소유'?'selected':'';?>>가족소유</option>
													<option value="전세" <?php echo $loa['i_home_me']=='전세'?'selected':'';?>>전세</option>
													<option value="월세" <?php echo $loa['i_home_me']=='월세'?'selected':'';?>>월세</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><span>세대 구성</span></th>
											<td>
												<select name="i_home_stay" required>
													<option>선택</option>
													<option value="가족동거" <?php echo $loa['i_home_stay']=='가족동거'?'selected':'';?>>가족동거</option>
													<option value="단독세대주" <?php echo $loa['i_home_stay']=='단독세대주'?'selected':'';?>>단독세대주</option>
													<option value="동거인" <?php echo $loa['i_home_stay']=='동거인'?'selected':'';?>>동거인</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><span>차량 소유 여부</span></th>
											<td class="pb7">
												<select name="i_car_ok" required>
													<option>선택</option>
													<option value="유" <?php echo $loa['i_car_ok']=='유'?'selected':'';?>>유</option>
													<option value="무" <?php echo $loa['i_car_ok']=='무'?'selected':'';?>>무</option>
												</select>
											</td>
										</tr>
										<!--
										<tr>
											<th><span>휴대폰명의/통신사</span></th>
											<td class="pb7">
												<select name="i_pmyeonguija" required>
													<option value="선택">선택</option>
													<option value="본인" <?php echo $loa['i_pmyeonguija']=='본인'?'selected':'';?>>본인</option>
													<option value="본인명의아님" <?php echo $loa['i_pmyeonguija']=='본인명의아님'?'selected':'';?>>본인명의아님</option>
												</select> /
												 <select name="i_newsagency" required>
													<option value="선택">선택</option>
													<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
													<option value="KT" <?php echo $loa['i_newsagency']=='본인'?'selected':'';?>>KT</option>
													<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LGT</option>
												</select>
											</td>
										</tr>
										-->
										<?php if($user['m_sex']=="m"){?>
										<tr>
											<th><span>군필 여부</span></th>
											<td>
												<select name="i_veteran" required>
													<option>선택</option>
													<option value="Y" <?php echo $loa['i_veteran']=='Y'?'selected':'';?>>군필</option>
													<option value="N" <?php echo $loa['i_veteran']=='N'?'selected':'';?>>관련없음</option>
												</select>
											</td>
										</tr>
										<?php }?>
										<tr>
											<th><span>실거주지 주소</span></th>
											<td>
												<input type="text" name="zip1"  size="10" id="post1" value="<?php echo $user[m_zip]?>" required  /> 
												<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" onclick="javascript:execDaumPostcode_f();" alt="우편번호찾기" />
														<span id="guide" style="color:#999"></span>									
												<p class="ml_01 mt10">
													<input type="text" name="addr1" id="addr1"   alt='주소'  value='<?=$user[m_addr1]?>' size="" required/>
													<input type="text" name="addr2" id="addr2"  alt='주소'  value='<?=$user[m_addr2]?>' size="" required/>
												</p>
											</td>
										</tr>
					</tbody>
				</table>
						</div>
					</div><!-- /loan_section2 -->
					
					<div class="loan_section2">
						<h4 class="loan_title1"><em>03.</em> 부채 정보</h4>
						<?php if($config['c_nice_use'] == "Y" && $member_ck){?>
						<div class="loan_cont1">
							<div class="loan_cont1_inner">
								<p class="loan_txt1"><span>신용 정보 </span>- 신용보고서의 내용을 입력해 주십시오 (반드시 보이는 대로 기입할 것)   </p>
								<div class="txt_c pt30"><a href="javascript:fnPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_inquiry.png" alt="신용평가 조회" /></a></div>
								<div class="table_wrap2">
									<table class="type8">
										
										<tbody>
											<tr>
												<th><span>신용 평점</span></th>
												<td>
													<input type="text" name="i_creditpoint_one" value="<?php echo $loa['i_creditpoint_one'];?>" required id="" size=""/>
												</td>
											</tr>
											
											<tr>
												<th><span>신용 등급(종합)</span></th>
												<td>
													<input type="text" name="i_creditpoint_two" value="<?php echo $loa['i_creditpoint_two'];?>" required id="" size=""/>
												</td>
											</tr>
											
											
										</tbody>
									</table>
								</div><!-- /table_wrap2 -->
								
								<p class="loan_txt2">부채 내역 - 신용보고서 확인 후 등재된 기록을 포함하여 대부업 및 기타 부채도 입력해 주십시오.</p>
								
									<div class="btn_wrap2">
									<a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_add1.png" alt="내역추가" onclick="add_row()"/></a>
								</div>
							</div><!-- /loan_cont1_inner -->
						</div><!-- /loan_cont2 -->
						<?php }?>
						<table class="type6">
						
							<thead>
								<tr>
									<th>금융기관분류</th>
									<th>금융기관명</th>
									<th>대출 잔액</th>
									<th>대출 구분</th>
									<th>삭제</th>
								</tr>
							</thead>
								<?php if(!$deb['m_id']){?>
								<input type="hidden" name="uptype" value="insert"/>
								<?php }else{?>
								<input type="hidden" name="num" value="<?php echo $deb['i_no'];?>"/>
								<input type="hidden" name="uptype" value="update"/>
								<?php }?>
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
											<select name="i_debt_company[]" style="width:90%">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" style="width:90%" class="frm_input " alt="금융기관명"size=""/></td>
									<td><input type="text" name="i_debt_pay[]"style="width:90%" value="<?php echo number_format($tmp_option[2]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " alt="대출잔액" size=""/></td>
										<td>
											<select name="i_debt_kinds[]" style="width:90%" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_select_delete1.png"  alt="삭제" onclick="delete_row()"/></a></td>
								</tr>
					<?php
						}
					}
					else
					{
					?>
								<tr>
									<td>
											<select name="i_debt_company[]">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id=""class="frm_input " alt="금융기관명" size=""/></td>
									<td><input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " alt="대출잔액" size=""/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_select_delete1.png" alt="삭제" onclick="delete_row()"/></a></td>
								</tr>
					<?php
						}
					}
					else
					{
					?>
								<tr>
									<td>
											<select name="i_debt_company[]">
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>									
									</td>
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="frm_input " alt="금융기관명" size="35"/></td>
									<td><input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="frm_input " alt="대출잔액" size="35"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_select_delete1.png" alt="삭제" onclick="delete_row()"/></a></td>
								</tr>
					<?php }?>
							</tbody>
						</table>

						<div class="loan_btn" style="text-align: center; margin: 70px 0 0;">
							<input type="submit"  value="신청완료" id="loan_form_add"/>
						</div>
					</div><!-- /loan_section2 -->
				</div><!-- /loan_wrap -->
			</form>
			</div><!-- /sub_content -->
		</div><!-- /container -->

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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
    function execDaumPostcode_a() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1r').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1r').value = fullRoadAddr;
                document.getElementById('addr2r').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    function execDaumPostcode_b() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1a').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1a').value = fullRoadAddr;
                document.getElementById('addr2a').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    function execDaumPostcode_c() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1b').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1b').value = fullRoadAddr;
                document.getElementById('addr2b').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    function execDaumPostcode_d() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1c').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1c').value = fullRoadAddr;
                document.getElementById('addr2c').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    function execDaumPostcode_e() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1d').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1d').value = fullRoadAddr;
                document.getElementById('addr2d').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    function execDaumPostcode_f() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('post1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullRoadAddr;
                document.getElementById('addr2').focus();
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
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
  cell1.innerHTML = "<select name=\"i_debt_company[]\"><option>선택</option><option value=\"은행/보험\" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option><option value=\"카드/신협/새마을금고\" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option><option value=\"캐피탈/증권사\" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option><option value=\"저축은행\" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option><option value=\"현금서비스\" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"대부업\" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>";
  cell2.innerHTML = "<input type=\"text\" name=\"i_debt_name[]\" value=\"<?php echo $tmp_option[1]?>\"     class=\"frm_input \"  alt=\"금융기관명\"size=\"35\"/>";
  cell3.innerHTML = "<input type=\"text\" name=\"i_debt_pay[]\" value=\"<?php echo number_format($tmp_option[2])?>\"  onkeyup=\"cnj_comma(this);\" onchange=\"cnj_comma(this);\"   class=\"frm_input \"  alt=\"대출잔액\" size=\"35\"/>";
  cell4.innerHTML = "<select name=\"i_debt_kinds[]\" ><option>선택</option><option value=\"신용대출\" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option><option value=\"담보대출\" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option></select>";
  cell5.innerHTML = "<a href=\"javascript:void(0);\"><img src=\"{MARI_HOMESKIN_URL}/img/btn_select_delete1.png\" alt=\"삭제\" onclick=\"delete_row()\" style=\"cursor:pointer;\"/></a>";
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
	//var loann_pattern = /[^(0-9)]/;//숫자
	//if(loann_pattern.test(f.i_loan_pay.value)){alert('\n대출금액은 숫자만 입력하실수 있습니다');f.i_loan_pay.value='';f.i_loan_pay.focus();return false;}	 
	//if(f.i_loan_pay.value.indexOf(" ") >= 0 ) {alert('\n대출금액에 공백이 있습니다.\n\n공백을 제거해주세요');f.i_loan_pay.focus();return false;}
	//if(f.i_loan_pay.value.length < 5){alert('\n정확한 금액을 단위로 입력하여주세요.');return false;}
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
{# footer}