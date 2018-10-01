 <?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 대출신청
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

{# header} 

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
			<input type="hidden" name="i_loan_type" value="business"/>
			<input type="hidden" name="stype" value="loan"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>">
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />
				<div class="container">
					<h3 class="s_title2">대출하기</h3>
					<p class="s_title2_1">사업자 대출</p>
					<dl class="loan_box1">
						
						<dt class="loan_b2">01. 본인 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c2">
							<ul class="loan_cont1">
								<div class="he20"></div>
								<li>
									<!--<h4 class="loan_title1">이름</h4>-->
									<div class="loan_frm1">
										<input type="text" name="m_name" value="<?php echo $user['m_name'];?>" id="" required  class="frm_input form-control" placeholder="이름" size="40"  />
									</div>
								</li>
								<!--<li>
									<h4 class="loan_title1">나이</h4>
									<div class="loan_frm1">
										<input type="text" name="i_birth" value="<?php echo $age2;?>" id="" required  class="frm_input form-control" size="40" />
									</div>
								</li>-->
								<li class="cl_b">
									<!--<h4 class="loan_title1">휴대폰번호</h4> -->
									<div class="form-horizontal">
										<div class="form-group mb0 mobi_phon">
											<div class=" mobi_mnum">											 
												 <select name="i_newsagency" required class="form-control" style="border-bottom:none; border-top:none; border-right:none">
													<option value="">통신사</option>
													<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
													<option value="KT" <?php echo $loa['i_newsagency']=='KT'?'selected':'';?>>KT</option>
													<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LGT</option>
												</select> 
											</div>

											 <div class="mobi_mnum">
												<select name="hp1" required class="form-control"style="border-bottom:none; border-top:none">
													<option>선택</option>
													<option value="010" <?php echo $hp1=='010'?'selected':'';?>>010</option>
													<option value="011" <?php echo $hp1=='011'?'selected':'';?>>011</option>
													<option value="016" <?php echo $hp1=='016'?'selected':'';?>>016</option>
													<option value="017" <?php echo $hp1=='017'?'selected':'';?>>017</option>
													<option value="019" <?php echo $hp1=='019'?'selected':'';?>>019</option>
												</select>
											</div>

											<div class="mobi_mnum">
												<input type="text" name="hp2" value="<?php echo $hp2;?><?php echo $hp3;?>" id=""  class="form-control frm_input"  maxlength="4"placeholder="핸드폰뒷자리"  required style="border-bottom:none; border-top:none; border-left:none;"/>
											</div>

										<!--	<div class="col-sm-3">
												<input type="text" name="hp3" value="<?php echo $hp3;?>" id=""  class="form-control frm_input"  maxlength="4" required/> 
											</div>-->

										</div><!--/form-group -->
									</div>
								</li>
								<li>
									<!--<h4 class="loan_title1">휴대전화 명의</h4>-->
									<div class="form-horizontal">
										<div class="form-group mb0">
											<div class="">
												<select name="i_pmyeonguija" required class="form-control" style="border-bottom:none">
													<option value="">명의 선택</option>
													<option value="본인" <?php echo $loa['i_pmyeonguija']=='본인'?'selected':'';?>>본인</option>
													<option value="가족" <?php echo $loa['i_pmyeonguija']=='가족'?'selected':'';?>>가족</option>
													<option value="기타" <?php echo $loa['i_pmyeonguija']=='기타'?'selected':'';?>>기타</option>
												</select> 
											</div>
											<div class="">
												<input type="text" name="i_myeonguija" id="" class="form-control" value="<?php echo $loa['i_myeonguija'];?>" placeholder="명의자 이름"  maxlength="20" required style="border-bottom:none"/>
											</div>
										</div>
									</div>
								</li>
								<li>
									<!--<h4 class="loan_title1">이메일</h4>-->
									<div class="loan_frm1" style="margin-bottom:15px;">
										<input type="text" id="" class="form-control"  placeholder="이메일"  
										/>
									</div>
										
								</li>
								<li>
									<!--<h4 class="loan_title1">실거주지 주소</h4>-->
										<div class="form-horizontal">
									<div class="">
									<div style="position: relative;">
										<input type="text"placeholder="실거주지 주소"style="border-bottom:none" name="zip1"  size="10" id="post"  class="frm_input form-control" required  />
										<div class="postc_btn"  align="absmiddle" onclick="javascript:execDaumPostcode_a();" alt="우편번호찾기">우편번호찾기 </div>
									</div>
									
									<!--<div class="">
									
									<img src="{MARI_MOBILESKIN_URL}/img/postcode_btn_mobile.png"  align="absmiddle" style="cursor:pointer;" onclick="javascript:execDaumPostcode_a();" alt="우편번호찾기">							
									<span id="guide" style="color:#999"></span>	
									</div>-->

									</div>
										<input type="text" class="frm_input form-control" name="addr1" id="addr1a"   alt='주소'   size="60" style="border-bottom:none" value='<?=$user[m_addr1]?>' required />
										<input type="text" class="frm_input form-control" name="addr2" id="addr2a"placeholder="나머지 주소"    alt='주소'   size="60"  value='<?=$user[m_addr2]?>' required/>
									</div>
								</li>
								<li>
									<div class="loan_frm1">
										 <select name="i_motivation" style="border-top:none">
											 <option>처음 접한 경로</option>  
											 <option value="포털검색" <?php echo $loa['i_motivation']=='포털검색'?'selected':'';?>>포털검색</option>  
											 <option value="페이스북" <?php echo $loa['i_motivation']=='페이스북'?'selected':'';?>>페이스북</option>  
											 <option value="지인추천" <?php echo $loa['i_motivation']=='지인추천'?'selected':'';?>>지인추천</option>  
											 <option value="신문기사" <?php echo $loa['i_motivation']=='신문기사'?'selected':'';?>>신문기사</option>  
											 <option value="배너광고" <?php echo $loa['i_motivation']=='배너광고'?'selected':'';?>>배너광고</option>  
											 <option value="신문광고" <?php echo $loa['i_motivation']=='신문광고'?'selected':'';?>>신문광고</option>  
											 <option value="방송" <?php echo $loa['i_motivation']=='방송'?'selected':'';?>>방송</option>  
											 <option value="기타" <?php echo $loa['i_motivation']=='기타'?'selected':'';?>>기타</option>  
										 </select>
									</div>
								</li>
								<div class="he20"></div>



																																					 															 								             
							</ul><!-- /loan_cont1 -->
						</dd>
						<dt class="loan_b1">02. 대출 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c1">
							<ul class="loan_cont1">
							<div class="he20"></div>
								<li class="mo_bback" >
									<h4 class="loan_title1">대출목적</h4>
									<div class="loan_frm1">
										<ul class="loan_chk1">
											 <li>
												<input type="radio" name="i_loan_pose" value="직영/가맹 창업" <?php echo $loa['i_loan_pose']=='직영/가맹 창업'?'checked':'';?>>직영/가맹 창업
											</li>
											 <li>
												<input type="radio"  name="i_loan_pose" value="운영자금" <?php echo $loa['i_loan_pose']=='운영자금'?'checked':'';?>>운영자금
											</li>
											 <li>
												<input type="radio"  name="i_loan_pose" value="대환" <?php echo $loa['i_loan_pose']=='대환'?'checked':'';?>>대환
											</li>
											 <li>
												<input type="radio"  name="i_loan_pose"  value="리모델링/확장" <?php echo $loa['i_loan_pose']=='리모델링/확장'?'checked':'';?>>리모델링/확장
											</li>
											
										</ul>
									</div>
								</li>
								<li style="position: relative;">
									<!--<h4 class="loan_title1">대출금액<span style="font-size:12px; margin:0 10px;">(단위 : 원)</span><a href="javascript:void(0);" class="ml10">-->
									<div class="ican3_btn"><img src="{MARI_HOMESKIN_URL}/img/loan_c_bt.png" alt="매월대출납입금액" onclick="Calculation()"/></a></h4></div>
									<div class="loan_frm1">
										<input type="text" maxlength="" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input form-control" size="40" />			
									</div>
								</li>
								<li>
									<!--<h4 class="loan_title1">대출기간<span style="font-size:12px; margin:0 10px;">(단위 : 개월)</span></h4>-->
									<div class="loan_frm1">
										<select name="i_loan_day" required style="border-top:none">
										<option>대출기간(단위 : 개월)</option>
										<option value="36" <?php echo $loa['i_loan_day']=='36'?'selected':'';?>>36</option>
										<option value="24" <?php echo $loa['i_loan_day']=='24'?'selected':'';?>>24</option>
										<option value="12" <?php echo $loa['i_loan_day']=='12'?'selected':'';?>>12</option>
									</select>			
									</div>
								</li>
								<li>
									<!--<h4 class="loan_title1">희망금리<span style="font-size:12px; margin:0 10px;">(단위 : %)</span></h4>-->
									<div class="loan_frm1" >
										<input type="text" name="i_year_plus"placeholder="희망금리 (단위 : %)" value="<?php echo $loa['i_year_plus'];?>" id=""required style="border-top:none" required class="frm_input form-control" size="40" />			
									</div>
								</li>
								<li>
									<!--<h4 class="loan_title1">상환 방식</h4>-->
									<div class="loan_frm1">
										<select name="i_repay" required style="border-bottom:none; border-top:none">
										<option>상환방식</option>
										<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
										<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
									</select>		
									</div>
								</li>
								<li>
								<li>
									<!--<h4 class="loan_title1">희망 상환일<span style="font-size:12px; margin:0 10px;">(단위 : 매월-일)</span></h4>-->
									<div class="loan_frm1">
									<select name="i_repay_day" required>
										<option>희망 상환일 (단위 : 매월-일) </option>
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
								<div class="he20"></div>
								<li>
									<!--<h4 class="loan_title1">제목</h4>-->
									<div class="loan_frm1">
										<input type="text" maxlength="50" placeholder="제목" name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="frm_input form-control" size="90" />
									</div>
								</li>
								<!--
								<li>
									<h4 class="loan_title1">자금 용도</h4>
									<div class="loan_frm1">
										<input type="text" maxlength="50" name="i_purpose" value="<?php echo $loa['i_purpose'];?>" id=""  required class="frm_input form-control" size="90" />
									</div>
								</li>-->
								<li>
									<!--<h4 class="loan_title1">대출 사유</h4>-->
									<div class="loan_frm1">
										<input type="text" maxlength="50" style="border-top:none"placeholder="대출 사유" name="i_purpose" value="<?php echo $loa['i_purpose'];?>" id=""  required class="frm_input form-control" size="90" />
									</div>
								</li>
								<div class="he20"></div>
							</ul>
						</dd>
						<dt class="loan_b3">03. 기업 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c3" style="padding:15px 0px;" >
						 <ul>
						 <div class="he20"></div>
						    <li>
									<!--<h4 class="loan_title1">사업자번호</h4>-->
									<div class="loan_frm1">
										<input type="text" placeholder="사업자번호" name="i_business_num" value="<?php echo $loa['i_business_num'];?>" size="90" class="frm_input form-control"/>
									</div>
								</li>
						   <li>
									<!--<h4 class="loan_title1">기업명</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_company_name2"style="border-top:none"placeholder="기업명" value="<?php echo $loa['i_company_name2'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							<li class="mo_bback" style="border-top:none">
									<h4 class="loan_title1">사업형태</h4>
									<div class="loan_frm1">
										<ul class="loan_chk1">
											 <li>
												<input type='radio' name="i_business_type" value="법인사업자" <?php echo $loa['i_business_type']=='법인사업자'?'checked':'';?>/>법인사업자
											</li>
											 <li>
												<input type='radio' name="i_business_type"value="개인사업자" <?php echo $loa['i_business_type']=='개인사업자'?'checked':'';?>/>개인사업자
											</li>
											
										</ul>
									</div>
							</li>
							  <li>
									<!--<h4 class="loan_title1">위치</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_location"placeholder="위치" value="<?php echo $loa['i_location'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							  <li>
									<!--<h4 class="loan_title1">운영기간</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_perating_period"style="border-top:none"placeholder="운영기간" value="<?php echo $loa['i_perating_period'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							  <li>
									<!--<h4 class="loan_title1">업종</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_csectors" style="border-top:none"placeholder="업종" value="<?php echo $loa['i_csectors'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							  <li>
									<!--<h4 class="loan_title1">서비스품목</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_service_item"style="border-top:none"placeholder="서비스품목" value="<?php echo $loa['i_service_item'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							<div class="he20"></div>
							  <li>
									<!--<h4 class="loan_title1">직원수</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_numberof_ep"placeholder="직원수" value="<?php echo $loa['i_numberof_ep'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							  <li>
									<!--<h4 class="loan_title1">연매출</h4>-->
									<div class="loan_frm1">
										<input type="text"placeholder="연매출"style="border-top:none" name="i_annual_sales" value="<?php echo $loa['i_annual_sales'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
								  <li>
									<!--<h4 class="loan_title1">월평균매출</h4>-->
									<div class="loan_frm1">
										<input type="text" name="i_monthly_sales"style="border-top:none"placeholder="월 평균 매출" value="<?php echo $loa['i_monthly_sales'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
								  <li>
									<!--<h4 class="loan_title1">월타사대출상환액</h4>-->
									<div class="loan_frm1">
										<input type="text"placeholder="월 타사대출 상환액" style="border-top:none"name="i_mtp_loan" value="<?php echo $loa['i_mtp_loan'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
								  <li>
									<!--<h4 class="loan_title1">월순이익</h4>-->
									<div class="loan_frm1">
										<input type="text"placeholder="월 순이익"  style="border-top:none"name="i_monthly_netprofit" value="<?php echo $loa['i_monthly_netprofit'];?>" size="90" class="frm_input form-control"/>
									</div>
							</li>
							<div class="he20"></div>
							  <li class="mo_cback">
									<h4 class="loan_title1">기대출금액</h4>
									<div class="loan_frm1">
										<input placeholder="담보" type="text" class="frm_input form-control" size="90" style="margin-bottom:10px;" />
								      <input  placeholder="신용" type="text"class="frm_input form-control" size="90" style="margin-bottom:10px;" />
									  <input  placeholder="P2P금융" type="text"class="frm_input form-control" size="90" style="margin-bottom:10px;"/>
									  <input placeholder="기타" type="text"class="frm_input form-control" size="90" style="margin-bottom:10px;" />
									</div>
							</li>
							
						 </ul>
						</dd>
						
						
						
						
						
						
						
						
						
						
						
						<dt class="loan_b4">04. 부채 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c4" style="padding:15px 0px;" >


								<ul class="loan_cont1">
								<li class="mo_conlist">
								<?php if($config['c_nice_use']=="Y"){?>
									<h4 class="loan_title1">신용정보</h4>
									<p class="m_txt8" style="">신용 보고서 내용을 입력해 주세요.</p> 
									<div class="wor_btn">
									<a href="javascript:fnPopup();"><img src="{MARI_MOBILESKIN_URL}/img/worker.png" alt="신용평가조회"></a></div>
									<li>
										
										<div class="loan_frm1 ">
											<input type="text"  placeholder="신용 평점" name="i_creditpoint_one" class="form-control" value="<?php echo $loa['i_creditpoint_one'];?>"style="border-bottom:none" required id=""/>
	 
										</div>
									</li>
									<li>
									
										<div class="loan_frm1">
											<input type="text" placeholder="신용 등급" name="i_creditpoint_two" class="form-control" value="<?php echo $loa['i_creditpoint_two'];?>" required id=""/>
									 
										</div>
									</li>	
									<div class="he20"></div>
								<div class="mo_cback">
								<?php }?>
								<h4 class="loan_title1">부채 내역</h4>
								<table class="" style="width:100%;">
						 
								<?php if(!$deb['m_id']){?>
								<input type="hidden" name="uptype" value="insert"/>
								<?php }else{?>
								<input type="hidden" name="num" value="<?php echo $deb['i_no'];?>"/>
								<input type="hidden" name="uptype" value="update"/>
								<?php }?>
								<thead class="cback_talble">
									<td>금융기관 분류</td>
									<td>금융기관명</td>
									<td>대출잔액</td>
									<td>대출구분</td>
									

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
										 	 
											<select name="i_debt_company[]" class="form-control" style="width:80px; ">
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
							 
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" style="width:80px; " alt="금융기관명"/>
									</td>


									<td>
										 
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input " style="width:80px; " alt="대출잔액"/>
									</td>
									<td>
									 
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px; width:80px; ">
											<option>선택</option>
											<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>
												<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);">
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
										 	<label for="" class="ontrol-label"></label>
											<select name="i_debt_company[]" class="form-control">
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
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" alt="금융기관명"/>
									</td>


									<td>
										<label for="" class="ontrol-label">대출잔액</label>
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input " size="35" alt="대출잔액"/>
									</td>
									<td>
										<label for="" class="ontrol-label">대출구분</label>
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px;">
											<option>선택</option>
											<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>
												<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);">
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
										 	
											<select name="i_debt_company[]" class="form-control">
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
										
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" alt="금융기관명"/>
									</td>


									<td>
										
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input "  alt="대출잔액"/>
									</td>
									<td>
										
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px;">
											<option>선택</option>
											<option value="신용대출 (카드론)" <?php echo $tmp_option[3]=='신용대출 (카드론)'?'selected':'';?>>신용대출 (카드론)</option>
												<option value="마이너스 통장" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
												<option value="현금서비스" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="리볼빙" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option>
										</select>
									</td>
									<td>
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
						</div>
							
							</ul><!-- /loan_cont1 -->

						<!--</dd>

					

						<!--<dt class="loan_b3">03 <span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c3">
							<ul class="loan_cont1">
								<li><h4 class="loan_title1">입력가능한 부분만 입력하세요. 신용정보를 모를시 '모름'이라고 입력해주세요</h4></li>
								<li>
									<h4 class="loan_title1">신용 평점</h4>
									<div class="loan_frm1">
										<input type="text" name="i_creditpoint_one" class="form-control" value="<?php echo $loa['i_creditpoint_one'];?>" required id=""/>
 
									</div>
								</li>
								<li>
									<h4 class="loan_title1">신용 등급</h4>
									<div class="loan_frm1">
										<input type="text" name="i_creditpoint_two" class="form-control" value="<?php echo $loa['i_creditpoint_two'];?>" required id=""/>
								 
									</div>
								</li>
								<li>
									<h4 class="loan_title1">월 금융상환비용<span>(매월 부채 상환을 위해 지출되는 비용)</span> <span class="unit">단위 : 원</span></h4>
									<div class="loan_frm1">
										<input type="text" name="i_credit_pay" value="<?php echo $loa['i_credit_pay'];?>" required id=""  class="form-control" size="40"/>
									</div>
								</li>





					<li class="loan_section2">
						 
					 
		 
			 
					 




						<table class="" style="width:100%;">
						 
								<?php if(!$deb['m_id']){?>
								<input type="hidden" name="uptype" value="insert"/>
								<?php }else{?>
								<input type="hidden" name="num" value="<?php echo $deb['i_no'];?>"/>
								<input type="hidden" name="uptype" value="update"/>
								<?php }?>
								<thead>
									<td>금융기관 분류</td>
									<td>금융기관명</td>
									<td>대출잔액</td>
									

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
										 	 
											<select name="i_debt_company[]" class="form-control">
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
							 
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" alt="금융기관명"/>
									</td>


									<td>
										 
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input " size="35" alt="대출잔액"/>
									</td>
									<td>
									 
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px;">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);">
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
										 	<label for="" class="ontrol-label"></label>
											<select name="i_debt_company[]" class="form-control">
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
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" alt="금융기관명"/>
									</td>


									<td>
										<label for="" class="ontrol-label">대출잔액</label>
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input " size="35" alt="대출잔액"/>
									</td>
									<td>
										<label for="" class="ontrol-label">대출구분</label>
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px;">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
										<a href="javascript:void(0);">
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
											<select name="i_debt_company[]" class="form-control">
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
										<input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id="" class="form-control frm_input" alt="금융기관명"/>
									</td>


									<td>
										<label for="" class="ontrol-label">대출잔액</label>
										<input type="text" name="i_debt_pay[]" value="<?php echo $tmp_option[2];?>" id=""  class="form-control frm_input "  alt="대출잔액"/>
									</td>
									<td>
										<label for="" class="ontrol-label">대출구분</label>
										<select name="i_debt_kinds[]" style="border-radius:4px;border:1px solid #ccc;height:34px;">
											<option>선택</option>
											<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
											<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
										</select>
									</td>
									<td>
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
							<input type="image" src="{MARI_MOBILESKIN_URL}/img/btn_complete1.png" alt="신청완료" id="loan_form_add"/>
 
						</div>
					</li>
					</ul>
						</dd>
						 <div class="loan_btn_wrap2 col-xs-12">
							<?php if(!$loa[i_id]){?>
							<a href="javascript:void(0);" onclick="Loan_form_Ok()" id="loan_form_add">신청완료</a>
								<!--<input class="mt50" type="image" src="{MARI_MOBILESKIN_URL}/img/btn_complete1.png" alt="신청완료" id="loan_form_add"/>-->
							<?php }else{?>
							<a href="{MARI_HOME_URL}/?mode=mypage&my=loanstatus"><img src="{MARI_HOMESKIN_URL}/img/btn_list1.png" alt="목록으로" /></a>
							<?php }?>
						</div>
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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>						 
<script>

function fnPopup(){
window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafekeyModel/checkplus.cb";
document.form_chk.target = "popupChk";
document.form_chk.submit();
}
    function execDaumPostcode() {
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

                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
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

                document.getElementById('post').value = data.zonecode; //5자리 새우편번호 사용
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
</script>
<script>

//대출기간 직접입력
function disChked(){
	var f = document.loan_form;
       var a = document.getElementById("disChk");
       var b = document.getElementById("loanChk");
        
	if(a.checked == true){
		document.getElementById("disloan").disabled = false;
	}else{
		document.getElementById("disloan").disabled = true;
	}
}

//대출기간 셀렉트박스 선택시 직접입력 값 초기화
function disableCheck(z) // 셀렉트박스에서 받은 z는 object가 됩니다. 
{ 
	
	 if(z.options[z.selectedIndex].value) {  // 셀렉트 option에 값이 있으면 실행 
		var tmp1,tmp2 
		var f = document.orderForm;
		var a = document.getElementById("disChk");

		tmp1 = z.options[z.selectedIndex].text; //text값을 가져오기 
		tmp2= z.options[z.selectedIndex].value; // value값을 가져오기 
		if(tmp1 == '36' || tmp1 == '24' || tmp1 == '12'){
			document.getElementById("disloan").value = "";
			a.checked = false;
			document.getElementById("disloan").disabled = true;
		}	    
	    } 
} 

//이메일값 가져오기
function getSelectValue(frm){
	//frm.email3.value = frm.email2.options[frm.email2.selectedIndex].text;
	frm.email3.value = frm.email2.options[frm.email2.selectedIndex].value;
}


function Loan_form_Ok(){	
	
	var f = document.loan_apply;		
	
	if(f.i_newsagency[0].selected == true){alert('\n통신사를 선택하세요');return false;}

	if(f.hp1[0].selected == true){alert('\n휴대폰번호 첫째자리를 선택하세요');return false;}

	if(!f.hp2.value){alert('\n휴대폰번호 둘째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.hp3.value){alert('\n휴대폰번호 셋째자리를 입력하여 주십시오.');f.hp3.focus();return false;}

	if(f.i_pmyeonguija[0].selected == true){alert('\n명의자를 선택하세요');return false;}

	if(!f.i_myeonguija.value){alert('\n명의자 이름을 입력하세요.');f.i_myeonguija.focus();return false;}

	if(!f.i_subject.value){alert('\n제목을 입력하세요.');f.i_subject.focus();return false;}


	if(!f.i_purpose.value){alert('\n대출사유를 입력하세요.');f.i_purpose.focus();return false;}	

	if(!f.i_loan_pay.value){alert('\n대출금액을 입력하세요.');f.i_loan_pay.focus();return false;}		

	if(f.i_loan_day[0].selected == true){alert('\n대출기간을 선택하세요');return false;}

	if(!f.i_year_plus.value){alert('\n희망금리를 입력하세요.');f.i_year_plus.focus();return false;}

	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}

	if(f.i_repay_day[0].selected == true){alert('\n대출상환일을 선택하세요');return false;}

	if(f.i_motivation[0].selected == true){alert('\n처음 접하신 경로를 선택하세요');return false;}

	if(!f.i_business_num.value){alert('\n사업자번호를 입력하세요.');f.i_business_num.focus();return false;}

	if(!f.i_company_name2.value){alert('\n기업명을 입력하세요.');f.i_company_name2.focus();return false;}

	if(!f.i_location.value){alert('\n위치를 입력하세요.');f.i_location.focus();return false;}

	if(!f.i_perating_period.value){alert('\n운영기간을 입력하세요.');f.i_perating_period.focus();return false;}

	if(!f.i_csectors.value){alert('\n업종을 입력하세요.');f.i_csectors.focus();return false;}

	if(!f.i_service_item.value){alert('\n서비스품목을 입력하세요.');f.i_service_item.focus();return false;}

	if(!f.i_numberof_ep.value){alert('\n직원수를 입력하세요.');f.i_numberof_ep.focus();return false;}

	if(!f.i_annual_sales.value){alert('\n연매출을 입력하세요.');f.i_annual_sales.focus();return false;}

	if(!f.i_monthly_sales.value){alert('\n월평균매출 입력하세요.');f.i_monthly_sales.focus();return false;}

	if(!f.i_mtp_loan.value){alert('\n월타사대출상환액을 입력하세요.');f.i_mtp_loan.focus();return false;}
	/*
	if(!f.i_creditpoint_one.value){alert('\n신용평점을 입력하세요.');f.i_creditpoint_one.focus();return false;}
	if(!f.i_creditpoint_two.value){alert('\n신용등급을 입력하세요.');f.i_creditpoint_two.focus();return false;}
	*/
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
  cell1.innerHTML = "<select name=\"i_debt_company[]\" class=\"form-control\"><option>선택</option><option value=\"은행/보험\" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option><option value=\"카드/신협/새마을금고\" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option><option value=\"캐피탈/증권사\" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option><option value=\"저축은행\" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option><option value=\"현금서비스\" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"대부업\" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>";
  cell2.innerHTML = "<input type=\"text\" name=\"i_debt_name[]\" value=\"<?php echo $tmp_option[1]?>\"     class=\"frm_input form-control\"  alt=\"금융기관명\"/>";
  cell3.innerHTML = "<input type=\"text\" name=\"i_debt_pay[]\" value=\"<?php echo $tmp_option[2]?>\"     class=\"frm_input form-control\"  alt=\"대출잔액\" />";
  cell4.innerHTML = "<select name=\"i_debt_kinds[]\" style=\"border-radius:4px;border:1px solid #ccc;height:34px;\"><option>선택</option><option value=\"신용대출(카드론)\" <?php echo $tmp_option[3]=='신용대출(카드론)'?'selected':'';?>>신용대출(카드론)</option><option value=\"마이너스 통장\" <?php echo $tmp_option[3]=='마이너스 통장'?'selected':'';?>>마이너스 통장</option><option value=\"담보대출\" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option><option value=\"현금서비스\" <?php echo $tmp_option[3]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"리볼빙\" <?php echo $tmp_option[3]=='리볼빙'?'selected':'';?>>리볼빙</option></select>";
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

			$(".loan_b4").click(function(){
				$(".loan_c4").slideToggle();

			});




		});
	  </script>
 
{# footer}<!--하단-->