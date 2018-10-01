<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
{# header_sub}
<div id="container">
	<div id="sub_content">
		<div class="title_wrap01">
			<div class="title_war_inner">
				<h3 class="title2">키스톤펀딩 대출</h3>	
				<p class="title_add2">사업자 대출</p>
              </div><!-- /title_wr_inner -->
		   </div><!-- /title_wrap -->
			<form name="loan_apply"  method="post" enctype="multipart/form-data"  target="calculation">
			<input type="hidden" name="type" value="w"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>">
			<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>">
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<input type="hidden" name="i_loan_type" value="business"/>
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />

		<div class="loan_wrap">
			<div class="loan_section1">
			
		   <h4 class="loan_title1">01. 본인 정보</h4>
				<table class="type13">
					<colgroup>
							<col width="15%">
							<col width="35%" >
							<col width="15%">
							<col width="35%" >
					</colgroup>
					<tbody>
						<tr>
							<th><span>이름</span></th>
							<td>
								<input type="text" name="m_name" value="<?php echo $user['m_name'];?>" id="" required  class="frm_input " size="25" readonly />
							</td>
							<th><span>나이</span></th>
							<td>
								<input type="text" name="i_birth" value="<?php echo $age2;?>" id="" required  class="frm_input " size="8" /> <label for="m_birth">세</label>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type='radio' name="i_sex" value="m"  <?php echo $user['m_sex']=='m'?'checked':'';?>> <label class="mr10">남자</label>
								<input type='radio' name="i_sex" value="w" <?php echo $user['m_sex']=='w'?'checked':'';?>> <label class="mr10">여자</label>
							</td>
						</tr>
						<tr>
							<th><span>전화번호</span></th>
							<td colspan=3>
								 <select name="i_newsagency" required style="width:90px;" class="mr10">
									<option value="">통신사 선택</option>
									<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
									<option value="KT" <?php echo $loa['i_newsagency']=='KT'?'selected':'';?>>KT</option>
									<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LGT</option>
									<option value="기타" <?php echo $user['m_newsagency']=='기타'?'selected':'';?>>기타</option>
								</select> 
								<select name="hp1" required style="width:90px;">
									<option>선택</option>
									<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
									<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
									<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
									<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
									<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
								</select> -
								<input type="text" name="hp2" value="<?php echo $hp2;?>" id=""  class="frm_input " size="10" maxlength="4" required/> -
								<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="frm_input " size="10" maxlength="4" required/> 
								<select name="i_pmyeonguija" required style="width:90px; margin-left:15px" class="mr10">
									<option value="">명의 선택</option>
									<option value="본인" <?php echo $loa['i_pmyeonguija']=='본인'?'selected':'';?>>본인</option>
									<option value="가족" <?php echo $loa['i_pmyeonguija']=='가족'?'selected':'';?>>가족</option>
									<option value="기타" <?php echo $loa['i_pmyeonguija']=='기타'?'selected':'';?>>기타</option>
								</select> 
								<input type="text" name="i_myeonguija" id="" value="<?php echo $loa['i_myeonguija'];?>" placeholder="명의자 이름 작성"  maxlength="20" size="15" required/>
							</td>
						</tr>
						
						<!--<tr>
							<th><span>직업</span></th>
							<td colspan="3">
								<p class="pt10">
									<input type='radio' name="i_officeworkers" value="직장인" onclick="div_OnOff('1');" checked> <label class="mr10">직장인</label>
									<input type='radio' name="i_officeworkers" value="프리랜서" onclick="div_OnOff('2');"> <label class="mr10">프리랜서</label>
									<input type='radio' name="i_officeworkers" value="사업자" onclick="div_OnOff('3');"> <label class="mr10">사업자</label>
									<input type='radio' name="i_officeworkers" value="대학생" onclick="div_OnOff('4');"> <label class="mr10">대학생</label>
									<input type='radio' name="i_officeworkers" value="무직자" onclick="div_OnOff('5');"> <label>무직자</label>
								</p>
								<ul class="loan_txt4">
									<li style="display:block;"   id="stype01">
									<!-- <h5>직장인</h5>
										<p>
											<strong>직종</strong> 
											<input type="text" name="i_occu_a" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>직장명</strong>  
											<input type="text" name="i_company_name_a" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " size="40" />
										</p>
										<p>
										<strong>규모</strong>
										<input type="text" name="occu_scale_a" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
										</p>
										<p>
											<strong>직장주소</strong>
											<input type="text" name="zip1r"  size="10" id="zip_a" required  /> 											
											<a onclick="javascript:execDaumPostcode_a()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>	
											<span id="guide" style="color:#999"></span>
										</p>
										<p style="padding-left:88px;">
												<input type="text" name="addr1r" id="addr1_a"   alt='주소'   size="60" class="mb10" required/>
												<input type="text" name="addr2r" id="addr2_a"  alt='주소'   size="60" required/>
										</p>
										<p>
											<strong>직장전화번호</strong>  
											<input type="text" name="i_businesshp_a" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" />
											<span class="color_re2 ml10">※ "-"를 제외한 숫자만 입력하여 주십시오.</span>
										</p>
									</li>
									<li style="display:none;"   id="stype02">
										<!-- <h5>프리랜서</h5>
										<p>
											<strong>직종</strong>
											<input type="text" name="i_occu_b" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " size="40" />
										</p>
										<p>
											<strong>직장명</strong>
											<input type="text" name="i_company_name_b" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " size="40" />
										</p>
										<p>
										<strong>규모</strong>
										<input type="text" name="occu_scale_b" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
										</p>
										<p>
											<strong>직장주소</strong>
											<input type="text" name="zip1a"  size="10" id="zip_b" required  />
											<a href="javascript:execDaumPostcode_b()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>	
											<span id="guide" style="color:#999"></span>
										</p>
										<p style="padding-left:88px;">
											<input type="text" name="addr1a" id="addr1_b"   alt='주소'   size="60" class="mb10" required/>
											<input type="text" name="addr2a" id="addr2_b"  alt='주소'   size="60" required/>
										</p>
										<p>
											<strong>직장전화번호</strong> <input type="text" name="i_businesshp_b" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" /> 
											<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
										</p>

									</li>
									<li style="display:none;"   id="stype03">
									<!-- <h5>사업자</h5>
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
											<input type="text" name="zip1b"  size="10" id="zip_c" required  />
											<a href="javascript:execDaumPostcode_c()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>	
											<span id="guide" style="color:#999"></span>
										</p>
										<p style="padding-left:88px;">
											<input type="text" name="addr1b" id="addr1_c"   alt='주소'   size="60" class="mb10" required/>
											<input type="text" name="addr2b" id="addr2_c"  alt='주소'   size="60" required/>
										</p>
										<p>
										<strong>규모</strong>
										<input type="text" name="occu_scale_c" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
										</p>
										<p>
											<strong>사업장전화번호</strong> 
											<input type="text" name="i_businesshp_c" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" />
											<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
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
														<!-- <h5>대학생</h5> 
														<p>
														<strong>학교명</strong>
														<input type="text" name="i_businessname_b" value="<?php echo $loa['i_businessname'];?>" id="" required  class="frm_input " size="40" />
														</p>
														<p>
														<strong>학교주소</strong> 
														<input type="text" name="zip1c"  size="10" id="zip_d" required  />
														<a href="javascript:execDaumPostcode_d()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>	
														<span id="guide" style="color:#999"></span>
														</p>
														<p style="padding-left:88px;">
															<input type="text" name="addr1c" id="addr1_d"   alt='주소'   size="60" class="mb10" required/>
															<input type="text" name="addr2c" id="addr2_d"  alt='주소'   size="60" required/>
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
														<!-- <h5>무직자</h5>
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
														<input type="text" name="zip1d"  size="10" id="zip_e" required  />
														<a href="javascript:execDaumPostcode_e()"><img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" /></a>	
														<span id="guide" style="color:#999"></span>
														</p>
														<p style="padding-left:88px;">
															<input type="text" name="addr1d" id="addr1_e"   alt='주소' class="mb10"   size="60" required/>
															<input type="text" name="addr2d" id="addr2_e"  alt='주소'   size="60" required/>
														</p>
														<p>
														<strong>직장전화번호</strong>
														<input type="text" name="i_businesshp_e" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" size="40" /> 
														<span class="color_re2 ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
														</p>
													</li>
												</ul>
											</td>
										</tr>
										<tr>
											<th><span>소득정보</span></th>
											<td colspan="3">
												<ul class="loan_txt4">
												<li>
												<p>
												<strong>소득금액</strong>
												<label for="">월</label>
												<input type="text" name="i_plus_pay_mon_d" id="" value="<?php echo $loa['i_plus_pay_mon'];?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" size="25" required/>
												<label for="" class="ml5">연</label>
												<input type="text" name="i_plus_pay_year_d" value="<?php echo $loa['i_plus_pay_year'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="25" />
												</p>
												<p>
												<strong>생활비용</strong>
												<label for="">월</label>
												<input type="text" name="i_living_pay" id="" value="<?php echo $loa['i_living_pay'];?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" size="25" required/>
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
											<th><span>근무 개월</span></th>
											<td>
												<input type="text" name="i_company_day" id="" value="<?php echo $loa['i_company_day'];?>" size="5" required/>
												<label for="">개월</label>
											</td>
										</tr>		
							<tr>
							<th><span>제출가능서류</span></th>
							<td colspan="3">
								<ul class="loan_txt3">
									<li>
										<h5>공통</h5>
										<p>
											<label for="out_paper_01" class="mr5"><input type="checkbox" name="out_paper_01" id="out_paper_01" value="신분증" <?php echo $out_paper_01=='신분증'?'checked':'';?>/> 신분증</label>
											<label for="out_paper_02" class="mr5"><input type="checkbox" name="out_paper_02" id="out_paper_02" value="등본" <?php echo $out_paper_02=='등본'?'checked':'';?>/> 등본</label>
											<label for="out_paper_03" class="mr5"><input type="checkbox" name="out_paper_03" id="out_paper_03" value="원초본" <?php echo $out_paper_03=='원초본'?'checked':'';?>/> 원초본</label>
											<label for="out_paper_04" class="mr5"><input type="checkbox" name="out_paper_04" id="out_paper_04" value="가족관계증명서" <?php echo $out_paper_04=='가족관계증명서'?'checked':'';?>/> 가족관계증명서</label>
											<label for="out_paper_05"><input type="checkbox" name="out_paper_05" id="out_paper_05" value="주거래통장" <?php echo $out_paper_05=='주거래통장'?'checked':'';?>/> 주거래통장</label>
										</p>
									</li>
									<li>
										<h5>소득서류</h5>
										<p>
											<label for="out_paper_06" class="mr5"><input type="checkbox" name="out_paper_06" id="out_paper_06" value="원천징수영수증" <?php echo $out_paper_06=='원천징수영수증'?'checked':'';?>/> 원천징수영수증</label>
											<label for="out_paper_07" class="mr5"><input type="checkbox" name="out_paper_07" id="out_paper_07" value="갑종근로소득원천징수확인서" <?php echo $out_paper_07=='갑종근로소득원천징수확인서'?'checked':'';?>/>갑종근로소득원천징수확인서</label>
											<label for="out_paper_08" class="mr5"><input type="checkbox" name="out_paper_08" id="out_paper_08" value="직장의료보험납부확인서" <?php echo $out_paper_08=='직장의료보험납부확인서'?'checked':'';?>/> 직장의료보험납부확인서</label>
											<label for="out_paper_09">		<input type="checkbox" name="out_paper_09" id="out_paper_09" value="급여통장거래내역서" <?php echo $out_paper_09=='급여통장거래내역서'?'checked':'';?>/> 급여통장거래내역서</label>
										</p>
									</li>
									<li>
										<h5>재직서류</h5>
										<p>
											<label for="out_paper_10" class="mr5"><input type="checkbox" name="out_paper_10" id="out_paper_10" value="재직증명서" <?php echo $out_paper_10=='재직증명서'?'checked':'';?>/> 재직증명서</label>
											<label for="out_paper_11"><input type="checkbox" name="out_paper_11" id="out_paper_11" value="직장의료보험자격득실확인서" <?php echo $out_paper_11=='직장의료보험자격득실확인서'?'checked':'';?>/> 직장의료보험자격득실확인서</label>
										</p>
									</li>
								</ul>
							</td>
						</tr>
	<tr>
											<th><span>결혼 여부</span></th>
											<td colspan="3">
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

											<th><span>차량 소유 여부</span></th>
											<td class="pb7">
												<select name="i_car_ok" required>
													<option>선택</option>
													<option value="유" <?php echo $loa['i_car_ok']=='유'?'selected':'';?>>유</option>
													<option value="무" <?php echo $loa['i_car_ok']=='무'?'selected':'';?>>무</option>
												</select>
											</td>
										</tr>
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
										
										<?php }?>-->
									
										
										<tr>
										 <th>이메일</th>
											 <td colspan="3"><input size="40" type="text" name="m_email" value="<?php echo $user['m_email']?>" readonly /></td>
										 </tr>	
										
										
										
										<tr>
											<th><span>실거주지 주소</span></th>
											<td colspan="3">
												<input type="text" name="zip1"  size="10" id="post1" value="" required  />
												<a href="javascript:execDaumPostcode_f()">
													<img src="{MARI_HOMESKIN_URL}/img/postcode_btn.png" alt="우편번호찾기" />
												</a>				
												<span id="guide" style="color:#999"></span>
												<p class="ml_01 mt10">
													<input type="text" name="addr1" id="addr1"   alt='주소'  value="" size="60" required/>
													<input type="text" name="addr2" id="addr2"  alt='주소'  value="" size="60" required/>
												</p>
											</td>
										</tr>
									 <tr >
										<th>키스톤펀딩을 처음 접한 </th>
										 <td colspan="3">
										 <select name="i_motivation">
											 <option>선택해주세요</option>  
											 <option value="포털검색" <?php echo $loa['i_motivation']=='포털검색'?'selected':'';?>>포털검색</option>  
											 <option value="페이스북" <?php echo $loa['i_motivation']=='페이스북'?'selected':'';?>>페이스북</option>  
											 <option value="지인추천" <?php echo $loa['i_motivation']=='지인추천'?'selected':'';?>>지인추천</option>  
											 <option value="신문기사" <?php echo $loa['i_motivation']=='신문기사'?'selected':'';?>>신문기사</option>  
											 <option value="배너광고" <?php echo $loa['i_motivation']=='배너광고'?'selected':'';?>>배너광고</option>  
											 <option value="신문광고" <?php echo $loa['i_motivation']=='신문광고'?'selected':'';?>>신문광고</option>  
											 <option value="방송" <?php echo $loa['i_motivation']=='방송'?'selected':'';?>>방송</option>  
											 <option value="기타" <?php echo $loa['i_motivation']=='기타'?'selected':'';?>>기타</option>  
										 </select>
									 </td>
							          </tr>	
										
					</tbody>
				</table>
					
					<h4 class="loan_title1">02. 대출정보</h4>
					<table class="type13">
						<colgroup>
							<col width="170px">
							<col width="" >
						</colgroup>
						<tbody>
						<!--	<tr>
							<th>종류</th>
							<td>
								<select name="i_payment" required style="width:200px;">
									<option value="">선택</option>
									<?php
										$sql = "select * from mari_category";
										$cate1 = sql_query($sql);
										  for ($i=0; $row=sql_fetch_array($cate1); $i++) {
									?>
											<option value="<?php echo $row['ca_id'];?>"><?php echo $row['ca_subject'];?></option>
									<?php
										    }
									?>
								</select> 
							</td>
						</tr>-->
						<tr>
								<th>대출목적</th>
								<td>
									<input type="radio" name="i_loan_pose" value="직영/가맹 창업" <?php echo $loa['i_loan_pose']=='직영/가맹 창업'?'checked':'';?>>직영/가맹 창업
									<input type="radio"  name="i_loan_pose" value="운영자금" <?php echo $loa['i_loan_pose']=='운영자금'?'checked':'';?>>운영자금
									<input type="radio"  name="i_loan_pose" value="대환" <?php echo $loa['i_loan_pose']=='대환'?'checked':'';?>>대환
									<input type="radio"  name="i_loan_pose"  value="리모델링/확장" <?php echo $loa['i_loan_pose']=='리모델링/확장'?'checked':'';?>>리모델링/확장
								</td>
							</tr>
							<tr>
								<th>대출금액</th>
								<td>
									<input type="text"  name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="29" />
									<label for="">원 </label>
									<a href="javascript:void(0);" class="ml10"><img src="{MARI_HOMESKIN_URL}/img/loan_c_bt.png" alt="매월대출납입금액" onclick="Calculation()"/></a>
								</td>
							</tr>
							<tr>
								<th>대출기간</th>
								<td>
									<input type="text" name="i_loan_day" value="<?php echo $loa['i_loan_day'];?>" id="" required class="frm_input " size="10" />
									<label for="">개월</label>
								</td>
							</tr>
							<tr>
								<th>희망 금리</th>
								<td>
									<input type="text" name="i_year_plus" value="<?php echo $loa['i_year_plus'];?>" id="" required class="frm_input " size="10" />
									<label for="">%</label>
								</td>
							</tr>
							<tr>
								<th>상환 방식</th>
								<td>
									<select name="i_repay" required style="width:200px;">
										<option>선택</option>
										<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
										<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
									</select>
								</td>
							</tr>
							
							
							
							<tr>
								<th>희망 상환일</th>
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
								<th>제목</th>
								<td>
									<input type="text"  name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="frm_input " size="90" />
								</td>
							</tr>
							<tr>
								<th>대출 사유</th>
								<td>
								<input type="text"  name="i_purpose" value="<?php echo $loa['i_purpose'];?>" id=""  required class="frm_input " size="100" />
								</td>
							</tr>
						</tbody>
					</table>
				<h4 class="loan_title1">03.기업정보</h4>
                    	<table class="type13">
							<colgroup>
								<col width="170px">
								<col width="" >
							</colgroup>
							<tbody>
							  <tr>
							    <th>사업자번호</th>
								<td><input type="text" name="i_business_num" value="<?php echo $loa['i_business_num'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>기업명</th>
								<td><input type="text" name="i_company_name2" value="<?php echo $loa['i_company_name2'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>사업형태</th>
								<td><input type='radio' name="i_business_type" value="법인사업자" <?php echo $loa['i_business_type']=='법인사업자'?'checked':'';?>/>법인사업자
								 <input type='radio' name="i_business_type"value="개인사업자" <?php echo $loa['i_business_type']=='개인사업자'?'checked':'';?>/>개인사업자
								</td>
							  </tr>
							  <tr>
							    <th>위치</th>
								<td><input type="text" name="i_location" value="<?php echo $loa['i_location'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>운영기간</th>
								<td><input type="text" name="i_perating_period" value="<?php echo $loa['i_perating_period'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>업종</th>
								<td><input type="text" name="i_csectors" value="<?php echo $loa['i_csectors'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>서비스품목</th>
								<td><input type="text" name="i_service_item" value="<?php echo $loa['i_service_item'];?>" size="60"/></td>
							  </tr>
							  <tr>
							    <th>직원수</th>
								<td><input type="text" name="i_numberof_ep" value="<?php echo $loa['i_numberof_ep'];?>" size="10"/> 명</td>
							  </tr>
							  <tr>
							    <th>연매출</th>
								<td><input type="text" name="i_annual_sales" value="<?php echo $loa['i_annual_sales'];?>" size="20"/> 원</td>
							  </tr>
							  <tr>
							    <th>월평균매출</th>
								<td><input type="text" name="i_monthly_sales" value="<?php echo $loa['i_monthly_sales'];?>" size="20"/> 원</td>
							  </tr>
							  <tr>
							    <th>월타사대출상환액</th>
								<td><input type="text" name="i_mtp_loan" value="<?php echo $loa['i_mtp_loan'];?>" size="20"/> 원</td>
							  </tr>
							  <tr>
							    <th>월순이익</th>
								<td><input type="text" name="i_monthly_netprofit" value="<?php echo $loa['i_monthly_netprofit'];?>" size="20"/> 원</td>
							  </tr>
							  <tr>
							    <th>기대출금액</th>
								<td><input placeholder="담보" type="text" name="i_eamountof_01" value="<?php echo $loa['i_eamountof_01'];?>" />
								      <input  placeholder="신용" type="text" name="i_eamountof_02" value="<?php echo $loa['i_eamountof_02'];?>" />
									  <input  placeholder="P2P금융" type="text" name="i_eamountof_03" value="<?php echo $loa['i_eamountof_03'];?>" />
									  <input placeholder="기타" type="text" name="i_eamountof_04" value="<?php echo $loa['i_eamountof_04'];?>" />
									  </td>
							  </tr>
							</tbody>
                        </table>
		<!--<h4 class="loan_title1 mt80 pt10 ">04. 부채 정보</h4>
					<?php if($config['c_nice_use'] == "Y"){?>
					<div class="loan_cont1 mt20">						
							<div class="loan_cont1_inner">
								<p class="loan_txt1"><span>신용 정보 </span>- 신용보고서의 내용을 입력해 주십시오 (반드시 보이는 대로 기입할 것)   </p>								
								<div class="txt_c pt30 btn_credit"><a href="javascript:fnPopup();"><img src="{MARI_HOMESKIN_URL}/img/btn_inquiry.png" alt="신용평가 조회" /></a></div>								
								<div class="table_wrap2">
									<table class="type8">
										<colgroup>
											<col width="130px" />
											<col width="" />
										</colgroup>
										<tbody>
											<tr>
												<th><span>신용 평점</span></th>
												<td>
													<input type="text" name="i_creditpoint_one" value="<?php echo $loa['i_creditpoint_one'];?>" required id="" size="40"/>
												</td>
											</tr>
											
											<tr>
												<th><span>신용 등급(종합)</span></th>
												<td>
													<input type="text" name="i_creditpoint_two" value="<?php echo $loa['i_creditpoint_two'];?>" required id="" size="40"/>
												</td>
											</tr>																						
										</tbody>
									</table>
								</div>
																
							</div>
						</div>
					<?php }?>
					<div class="btn_wrap2 mb20" style="padding:0; ">
						<a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_add1.png" alt="내역추가" onclick="add_row()"/></a>
					</div>
					<table class="type6">
							<colgroup>
								<col width="13%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="12%">
							</colgroup>
							<thead>
								<tr>
									<th>금융사</th>
									<th>상호명</th>
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
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="frm_input " size="35" alt="금융기관명"/></td>
									<td><input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="frm_input " size="35" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<!--<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>-->
												<!--<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<!--<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>-->
												<!--<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
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
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="frm_input " size="35" alt="금융기관명"/></td>
									<td><input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="frm_input " size="35" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<!--<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>-->
												<!--<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<!--<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>-->
												<!--<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
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
									<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="frm_input " size="35" alt="금융기관명"/></td>
									<td><input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="frm_input " size="35" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<!--<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>-->
												<!--<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<!--<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>-->
												<!--<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
											</select>
										</td>
									<td><a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/btn_select_delete1.png" alt="삭제" onclick="delete_row()"/></a></td>
								</tr>
					<?php }?>
							</tbody>
						</table>-->
						<div class="txt_c mt80">
							<span class="loan_btn"><a href="javascript:void(0)" onclick="Loan_form_Ok()" id="">신청하기</a></span>						
					</div>
				</div>
				<!--// loan_section1_inner e -->
			</div>
			<!--//loan_section1 e -->
		</div>
		<!--// loan_wrap e --><!--//부동산 대출 양식-->

		</form>

	</div>
	<!--// sub_content e -->
</div>
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


{# footer}
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> 

<script>

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

</script>

<script>


function Loan_form_Ok(){	
	
	var f = document.loan_apply;		

	if(!f.i_birth.value){alert('\n나이를 입력하여 주십시오.');f.i_birth.focus();return false;}

	if(f.i_sex[0].checked == false && f.i_sex[1].checked == false){ alert('\n성별을 선택하여 주십시오'); return false;}
	
	if(f.i_newsagency[0].selected == true){alert('\n통신사를 선택하세요');return false;}

	if(f.hp1[0].selected == true){alert('\n휴대폰번호 첫째자리를 선택하세요');return false;}

	if(!f.hp2.value){alert('\n휴대폰번호 둘째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.hp3.value){alert('\n휴대폰번호 셋째자리를 입력하여 주십시오.');f.hp3.focus();return false;}

	if(f.i_pmyeonguija[0].selected == true){alert('\n명의자를 선택하세요');return false;}

	if(!f.i_myeonguija.value){alert('\n명의자 이름을 입력하세요.');f.i_myeonguija.focus();return false;}
	
	if(!f.zip1.value){alert('\n우편번호를 입력하세요.');f.zip1.focus();return false;}

	if(!f.addr1.value){alert('\n주소를 입력하세요.');f.addr1.focus();return false;}

	if(!f.addr2.value){alert('\n상세주소를 입력하세요.');f.addr2.focus();return false;}

	if(f.i_motivation[0].selected == true){alert('\n처음 접하신 경로를 선택하세요');return false;}

	if(f.i_loan_pose[0].checked == false && f.i_loan_pose[1].checked == false && f.i_loan_pose[2].checked == false && f.i_loan_pose[3].checked == false){ alert('\n대출목적을 선택하여 주십시오'); return false;}

	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하세요.');f.i_loan_pay.focus();return false;}

	if(!f.i_loan_day.value){alert('\n대출기간을 선택하세요.');f.i_loan_day.focus();return false;}

	if(!f.i_year_plus.value){alert('\n희망금리를 입력하세요.');f.i_year_plus.focus();return false;}

	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}

	if(f.i_repay_day[0].selected == true){alert('\n희망상환일을 선택하세요');return false;}

	if(!f.i_subject.value){alert('\n제목을 입력하세요.');f.i_subject.focus();return false;}

	if(!f.i_purpose.value){alert('\n대출사유를 입력하세요.');f.i_purpose.focus();return false;}	

	if(!f.i_business_num.value){alert('\n사업자번호를 입력하세요.');f.i_business_num.focus();return false;}

	if(!f.i_company_name2.value){alert('\n기업명을 입력하세요.');f.i_company_name2.focus();return false;}

	if(f.i_business_type[0].checked == false && f.i_business_type[1].checked == false){ alert('\n사업형태를 선택하여 주십시오'); return false;}

	if(!f.i_location.value){alert('\n위치를 입력하세요.');f.i_location.focus();return false;}

	if(!f.i_perating_period.value){alert('\n운영기간을 입력하세요.');f.i_perating_period.focus();return false;}

	if(!f.i_csectors.value){alert('\n업종을 입력하세요.');f.i_csectors.focus();return false;}

	if(!f.i_service_item.value){alert('\n서비스품목을 입력하세요.');f.i_service_item.focus();return false;}

	if(!f.i_numberof_ep.value){alert('\n직원수를 입력하세요.');f.i_numberof_ep.focus();return false;}

	if(!f.i_annual_sales.value){alert('\n연매출을 입력하세요.');f.i_annual_sales.focus();return false;}

	if(!f.i_monthly_sales.value){alert('\n월평균매출 입력하세요.');f.i_monthly_sales.focus();return false;}

	if(!f.i_mtp_loan.value){alert('\n월타사대출상환액을 입력하세요.');f.i_mtp_loan.focus();return false;}

	if(!f.i_monthly_netprofit.value){alert('\n월순이익 입력하세요.');f.i_monthly_netprofit.focus();return false;}

	if(!f.i_eamountof_01.value){alert('\n기대출금액 담보를 입력하세요.');f.i_eamountof_01.focus();return false;}

	if(!f.i_eamountof_02.value){alert('\n기대출금액 신용을 입력하세요.');f.i_eamountof_02.focus();return false;}

	if(!f.i_eamountof_03.value){alert('\n기대출금액 P2P금융을 입력하세요.');f.i_eamountof_03.focus();return false;}

	if(!f.i_eamountof_04.value){alert('\n기대출금액 기타를 입력하세요.');f.i_eamountof_04.focus();return false;}

//	if(!f.i_creditpoint_one.value){alert('\n신용평점을 입력하세요.');f.i_creditpoint_one.focus();return false;}

//	if(!f.i_creditpoint_two.value){alert('\n신용등급을 입력하세요.');f.i_creditpoint_two.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=loan';
	f.submit();

}



function showDay(index){
	
	var f = document.loan_apply;

	if(f.i_loan_type.value=="1"){
		//document.getElementById("active1").disabled = true;
		document.getElementById("active2").disabled = false; 
		document.getElementById("active3").disabled = false; 
		document.getElementById("active4").disabled = false; 
		document.getElementById("active5").disabled = false; 
		document.getElementById("active6").disabled = false; 
		document.getElementById("active7").disabled = false; 
		document.getElementById("active8").disabled = false;
		document.getElementById("pose1").style.display = 'block';
		document.getElementById("pose2").style.display = 'block';
		document.getElementById("pose3").style.display = 'block';
		document.getElementById("pose4").style.display = 'block';
		
	}else if(f.i_loan_type.value == "2"){
		//document.getElementById("active1").disabled = false;
		document.getElementById("active2").disabled = true; document.getElementById("active2").value = '';
		document.getElementById("active3").disabled = true; document.getElementById("active3").value = '';
		document.getElementById("active4").disabled = true; document.getElementById("active4").value = '';
		document.getElementById("active5").disabled = true; document.getElementById("active5").value = '';
		document.getElementById("active6").disabled = true; document.getElementById("active6").value = '';
		document.getElementById("active7").disabled = true; document.getElementById("active7").value = '';
		document.getElementById("active8").disabled = true; document.getElementById("active8").value = '';
		document.getElementById("pose1").style.display = 'none';
		document.getElementById("pose2").style.display = 'none';
		document.getElementById("pose3").style.display = 'none';
		document.getElementById("pose4").style.display = 'none';
	}	
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
  cell1.innerHTML = "<select name=\"i_debt_company[]\"><option>선택</option><option value=\"은행/보험\" >은행/보험</option><option value=\"카드/신협/새마을금고\" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option><option value=\"캐피탈/증권사\" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option><option value=\"저축은행\" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option><option value=\"현금서비스\" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"대부업\" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>";
  cell2.innerHTML = "<input type=\"text\" name=\"i_debt_name[]\" value=\"\"     class=\"frm_input \"  alt=\"금융기관명\"size=\"35\"/>";
  cell3.innerHTML = "<input type=\"text\" name=\"i_debt_pay[]\" value=\"\"     class=\"frm_input \"  alt=\"대출잔액\" size=\"35\"/>";
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
  var f=document.loan_apply2;
  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
	//대출금액
	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하여 주십시오.');f.i_loan_pay.focus();return false;}
	var loann_pattern = /[^(0-9)]/;//숫자
	//if(loann_pattern.test(f.i_loan_pay.value)){alert('\n대출금액은 숫자만 입력하실수 있습니다');f.i_loan_pay.value='';f.i_loan_pay.focus();return false;}	 
	//if(f.i_loan_pay.value.indexOf(" ") >= 0 ) {alert('\n대출금액에 공백이 있습니다.\n\n공백을 제거해주세요');f.i_loan_pay.focus();return false;}
	//if(f.i_loan_pay.value.length < 5){alert('\n정확한 금액을 단위로 입력하여주세요.');return false;}
	//대출기간
	if(!f.i_loan_day.value){alert('\n대출기간을 선택하세요.');f.i_loan_day.focus();return false;}
	//연이자율
	if(!f.i_year_plus.value){alert('\n연이자율을 입력하여 주십시오.');f.i_year_plus.focus();return false;}
	var inter_pattern = /[^(0-9)]/;//숫자
	if(inter_pattern.test(f.i_year_plus.value)){alert('\n연이자율은 숫자만 입력하실수 있습니다');f.i_year_plus.value='';f.i_year_plus.focus();return false;}
	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}
  window.open("about:blank", "calculation", opt);
  f.action="{MARI_HOME_URL}/?mode=calculation";
  f.submit();
}

function Calculation2() { 
  var f=document.loan_apply3;
  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
	//대출금액
	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하여 주십시오.');f.i_loan_pay.focus();return false;}
	var loann_pattern = /[^(0-9)]/;//숫자
	//if(loann_pattern.test(f.i_loan_pay.value)){alert('\n대출금액은 숫자만 입력하실수 있습니다');f.i_loan_pay.value='';f.i_loan_pay.focus();return false;}	 
	//if(f.i_loan_pay.value.indexOf(" ") >= 0 ) {alert('\n대출금액에 공백이 있습니다.\n\n공백을 제거해주세요');f.i_loan_pay.focus();return false;}
	//if(f.i_loan_pay.value.length < 5){alert('\n정확한 금액을 단위로 입력하여주세요.');return false;}
	//대출기간
	if(!f.i_loan_day.value){alert('\n대출기간을 선택하세요.');f.i_loan_day.focus();return false;}
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

		if (!num.test(cnj_str.value))   {
		alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
		cnj_str.value="";
		cnj_str.focus();
		return false;
		}

		if ((t_num < "0" || "9" < t_num)){
		alert("숫자만 입력하십시오.");
		cnj_str.value="";
		cnj_str.focus();
		return false;
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