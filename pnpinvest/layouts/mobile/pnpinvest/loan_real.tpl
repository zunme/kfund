 <?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 대출하기
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
			<input type="hidden" name="i_loan_type" value="real"/>
			<input type="hidden" name="stype" value="loan"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>">
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />
				
				<div class="container">
					<h3 class="s_title2">대출하기</h3>
						<p class="s_title2_1">부동산 대출</p>
						<dl class="loan_box1">					
						<dt class="loan_b2">01. 본인 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
							<dd class="loan_c2">
								<ul class="loan_cont1">
									<div class="he20"></div>
									<li><!--이름-->									
										<div class="loan_frm1">
										<input type="text" name="m_name" value="<?php echo $user['m_name'];?>" id="" required  class="frm_input form-control" placeholder="이름" size="40"  />
										</div>
									</li>								
									<li class="cl_b"><!--휴대폰번호 -->									
										<div class="form-horizontal">
										<div class="form-group mb0 mobi_phon">
										<div class=" mobi_mnum">											 
											<select name="i_newsagency" required class="form-control" style="border-bottom:none; border-top:none; border-right:none">
												<option value="">통신사</option>
												<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
												<option value="KT" <?php echo $loa['i_newsagency']=='KT'?'selected':'';?>>KT</option>
												<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LG</option>
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
										</div><!--/form-group -->
										</div>
									</li>
								<li>
									<!--휴대전화 명의-->
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
									<!--이메일-->
									<div class="loan_frm1" style="margin-bottom:15px;">
										<input type="text" id="" class="form-control"  placeholder="이메일"  
										/>
									</div>
										
								</li>																																			 															 								
							</ul><!-- /loan_cont1 -->
						</dd>
							<dt class="loan_b1">02. 대출  정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
						<dd class="loan_c1">
							<ul class="loan_cont1">
							<div class="he20"></div>
								<li>
									<!--담보물 주소-->
										<div class="form-horizontal">
									<div class="">
									<div style="position: relative;">										
										<input  type="text" name="i_locaty"style="padding:12px 0; border:1px solid #e0e0e0" id="i_locaty_00" itemname="Address" value="<?php echo $loa['i_locaty'];?>" onKeyDown="if(event.keyCode==13){codeAddress();}" class="frm_input " size="55">
			
										<button type="button" onclick="codeAddress()" class="add_btn" >주소검색</button>
									</div>
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
									
								</li>	
								<div class="he20"></div>
								 <li  class="mo_bback">
									<h4 class="loan_title1">담보유형</h4>
									<div class="loan_frm1">
										<ul class="loan_chk1">
											 <li>
												<input type="radio" name="cType" id="" value=""/> 아파트
											</li>
											 <li>
												<input type="radio" name="cType" id="" value=""/>빌라/다세대/주택
											</li>
											 <li>
												<input type="radio" name="cType" id="" value=""/> 전세보증금
											</li>
											 <li>
												<input type="radio" name="cType" id="" value=""/> 기타
											</li>
											
										</ul>
									</div>
								</li>
                                 <li>
									<!--담보시세-->
									<div class="loan_frm1">
										<input type="text" id="" class="form-control" style="border-bottom:none" placeholder="담보시세 (단위 : 만원)" />
									</div>
								</li>		
								
								<li>									
									<div class="loan_frm1" style="position: relative;">
										<input type="text" maxlength=""placeholder="대출희망금액 (단위 : 만원)"  name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input form-control" size="40" />		
										<div class="mo_paybtn">
										<a href="javascript:void(0);"><img src="{MARI_HOMESKIN_URL}/img/loan_c_bt.png" alt="매월대출납입금액" onclick="Calculation()"/></a>
										</div>
									</div>
								</li>								
								
                                  <li>
									<!--부채현황-->
									<div class="loan_frm1">
										<input type="text" id="" class="form-control" style="border-bottom:none" placeholder="부채현황 (단위 : 만원)"
										/>
									</div>
								</li>	
								 <li>
									<!--월소득-->
									<div class="loan_frm1">
										<input type="text" id="" class="form-control" style="border-bottom:none" placeholder="월소득 (단위 : 만원)"
										/>
									</div>
								</li>	
								<li>
									<!--상환 방식-->
									<div class="loan_frm1">
										<select name="i_repay" required>
										<option>상환 방식</option>
										<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
										<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
									</select>		
									</div>
								</li>
								<div class="he20"></div>
								<li>
									<!--대출기간-->
									<div class="loan_frm1">
										<input type="text"placeholder="대출기간 (단위 : 개월)" name="i_loan_day" value="<?php echo $loa['i_loan_day'];?>" id="" required class="frm_input form-control "style="border-bottom:none" size="40" />														
									</div>
								</li>
								<li>
									<!--희망금리>-->
									<div class="loan_frm1">
										<input type="text" name="i_year_plus"placeholder="희망금리 (단위 : %)" value="<?php echo $loa['i_year_plus'];?>" id=""style="border-bottom:none" required class="frm_input form-control" size="40" />			
									</div>
								</li>
								<li>
									<!--대출 상환일-->
									<div class="loan_frm1">
									<select name="i_repay_day" required>
										<option>대출 상환일 (매월-일)</option>
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
									<!--대출제목-->
									<div class="loan_frm1">
										<input type="text" maxlength="50"placeholder="대출제목"style="border-bottom:none" name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="frm_input form-control" size="90" />
									</div>
								</li>
								<li>
									<!--대출내용-->
									<div class="loan_frm1">
										 <textarea style="width:100%; height:200px; font-size:15px; padding:15px;" placeholder="대출 내용을 입력해주세요."></textarea>
									</div>
								</li>
								<div class="he20"></div>
							</ul>
						</dd>					
						
						<dt class="loan_b4">03. 부채 정보<span><img src="{MARI_MOBILESKIN_URL}/img/loan_bullet1.png" alt="" /></span></dt>
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
						</dd>
						 <div class="loan_btn_wrap2 col-xs-12">
							<?php if(!$loa[i_id]){?>
							<a href="javascript:void(0);" onclick="Loan_form_Ok()" id="">신청완료</a>								
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
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>	 
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