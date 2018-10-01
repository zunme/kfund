
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
{# header_sub}
<div id="container">
	<div id="sub_content">
		<div class="title_wrap01">
				<h3 class="title2">키스톤 펀딩 파트너스 대출</h3>	
				<p class="title_add2">부동산 대출</p>
              </div><!-- /title_wr_inner -->
		   </div><!-- /title_wrap -->
			<form name="loan_apply"  method="post" enctype="multipart/form-data"  target="calculation">
			<input type="hidden" name="type" value="w"/>
			<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
			<input type="hidden" name="m_name" value="<?php echo $user['m_name'];?>">
			<input type="hidden" name="m_id" value="<?php echo $user['m_id'];?>">
			<input type="hidden" name="sSafekey" value="<?php echo $keyck['sSafekey']?>"/>
			<input type="hidden" name="i_loan_type" value="real"/>
			<!--지도 위도 경도-->
			<input type="hidden" name="i_locaty_01" id="i_locaty_01"/>
			<input type="hidden" name="i_locaty_02" id="i_locaty_02" />

		<div class="loan_wrap">
			<div class="loan_section1">
            <div class="loan_section1_inner">
					<h4 class="loan_title1 mb30">01. 부동산 대출 신청 정보</h4>
					<table class="type13">
						<colgroup>
							<col style=width:"170px">
							<col style="" >
						</colgroup>
						<tbody>
							<tr>
									<th>이름</th>
										<td>
										<?php echo $user[m_name]?>
										</td>
									</tr>
									<tr>
										<th>연락처</th>
										<td>
											<select name="i_newsagency" required style="width:90px;">
												<option value="">통신사 선택</option>
												<option value="SKT" <?php echo $user['m_newsagency']=='SKT'?'selected':'';?>>SKT</option>
												<option value="KT" <?php echo $user['m_newsagency']=='KT'?'selected':'';?>>KT</option>
												<option value="LGT" <?php echo $user['m_newsagency']=='LGT'?'selected':'';?>>LGT</option>
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
											<select name="i_pmyeonguija" required style="width:90px; margin-left:15px">
												<option value="">명의 선택</option>
												<option value="본인" selected>본인</option>
												<option value="가족" >가족</option>
												<option value="기타" >기타</option>
											</select> 
											<input type="text" name="i_myeonguija" id="" value="<?php echo $user['m_name'];?>" placeholder="명의자 이름 작성"  maxlength="20" size="25" required/>
										</td>
									</tr>
							<tr>
                               <th>이메일</th>
							   <td><!--<input size="40" type="text"  />-->
								<?php echo $user['m_id']?>
							   </td>
							</tr>	
								<tr>
										<th>소재지</th>
										<td>
											<input  type="text" name=i_locaty id="i_locaty_00" itemname="Address" value="<?php echo $loa['i_locaty'];?>" onKeyDown="if(event.keyCode==13){codeAddress();}" class="frm_input " size="50" required class="frm_input "> <img src="{MARI_ADMINSKIN_URL}/img/adress3_btn.png" onclick="codeAddress()" style="cursor:pointer;"  class="add_btn">
											<div id="map_canvas" style="width: 100%; height: 434px;"></div>
											<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<?php echo $config[c_map_api]?>&libraries=services,clusterer,drawing"></script>
											<script type="text/javascript">
											  function codeAddress(results, status){
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
													geocoder.addressSearch(''+address+'', function(result, status) {
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
									   <th>담보유형</th>
									  <td><input type="radio" name="i_security_type" value="아파트" <?php echo $_COOKIE['i_security_type']=='아파트'?'checked':'';?> />아파트
									         <input type="radio" name="i_security_type" value="빌라/다세대/주택" <?php echo $_COOKIE['i_security_type']=='빌라/다세대/주택'?'checked':'';?> />빌라/다세대/주택
									         <input type="radio"name="i_security_type" value="토지/임야/전답" <?php echo $_COOKIE['i_security_type']=='토지/임야/전답'?'checked':'';?> />토지/임야/전답
									         <input type="radio"name="i_security_type" value="전세보증금" <?php echo $_COOKIE['i_security_type']=='전세보증금'?'checked':'';?> />전세보증금
										 <input type="radio"name="i_security_type" value="기타" <?php echo $_COOKIE['i_security_type']=='기타'?'checked':'';?>/>기타
									  </td>
									  </tr>
                                     <tr>
									   <th>담보시세</th>
									  <td><input type="text" name="i_realestate_price" value="<?php echo $loa['i_realestate_price']?>"/><label for="">원 </label></td>
									  </tr>

                                   <tr>
											<th><span>대출희망금액</span></th>
											<td>
												<input type="text" maxlength="20" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="40" />
												<label for="">원 </label>
											<!--	<a href="javascript:void(0);" class="ml10"><img src="{MARI_HOMESKIN_URL}/img/loan_c_bt.png" alt="매월대출납입금액" onclick="Calculation()"/></a>-->
											</td>
										</tr>
                                 <tr>
									   <th>부채현황</th>
									 	  <td><input type="text" name="i_debt_status" value="<?php echo $loa['i_debt_status']?>"/><label for="">원 </label></td>
								  </tr>
                                <tr>
									   <th>월소득</th>
									  	  <td><input type="text" name="i_monthly_income" value="<?php echo $loa['i_monthly_income']?>" /><label for="">원 </label></td>
								  </tr>

                                <tr>
											<th><span>상환방식</span></th>
											<td>
												<select name="i_repay" required>
													<option>선택</option>
													<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금 균등 상환</option>
													<option value="만기일시상환" <?php echo $loa['i_repay']=='만기일시상환'?'selected':'';?>>만기일시상환</option>
				
												</select>
											</td>
									</tr>
	                             <tr>
											<th><span>대출기간</span></th>
											<td>
												<input type="text" name="i_loan_day" value="<?php echo $loa['i_loan_day'];?>" id="" required class="frm_input " size="10" />
												<label for="">개월</label>
											</td>
										</tr>
										<tr>
											<th><span>희망 금리</span></th>
											<td>
												<input type="text" name="i_year_plus" value="<?php echo $loa['i_year_plus'];?>" id="" required class="frm_input " size="10" />
												<label for="">%</label>
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
											<th><span>대출제목</span></th>
											<td>
											<input type="text" maxlength="50" size="50" name="i_subject" value="<?php echo $loa['i_subject'];?>" id=""  required class="frm_input " />
											</td>
										</tr>
										<tr>
											<th><span>대출내용</span></th>
											<td>
											 <textarea style="width:100%; height:200px;" name="i_loan_pose"><?php echo $loa['i_loan_pose'];?></textarea>
											</td>
										</tr>
									

						</tbody>
					
					</table><!--table.type13-->
	          

						<!-- <h4 class="loan_title1 mt80 pt10 ">02. 부채 정보</h4>
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
					<?php }
					
					?>
							</tbody>
						</table>-->
			
			
				<div class="txt_c mt80">
						<?php if($i_loan_type=="credit" || $i_loan_type=="business"){?>
							<span class="loan_btn"><a href="#" onclick="Loan_form_Ok2()" id="">신청하기</a></span>	
						<?php }else{?>
							<span class="loan_btn"><a href="#" onclick="Loan_form_Ok()" id="">신청하기</a></span>						
						<?php }?>
				</div>
			<!--//loan_section1 e -->
				</div>
		<!--// loan_wrap e -->
		</form>
	</div><!--sub_content-->
</div><!--container--!>

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
				</div>
				<!--// loan_section1_inner e -->
			</div>
			<!--//loan_section1 e -->
		
		<!--// loan_wrap e --><!--//부동산 대출 양식-->

		</form>

	</div>
	<!--// sub_content e -->
</div>




<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> 
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

                document.getElementById('zip_a').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_a').value = fullRoadAddr;
                document.getElementById('addr2_a').focus();
                
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

                document.getElementById('zip_b').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_b').value = fullRoadAddr;
                document.getElementById('addr2_b').focus();
                
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

                document.getElementById('zip_c').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_c').value = fullRoadAddr;
                document.getElementById('addr2_c').focus();
                
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

                document.getElementById('zip_d').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_d').value = fullRoadAddr;
                document.getElementById('addr2_d').focus();
                
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

                document.getElementById('zip_e').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_e').value = fullRoadAddr;
                document.getElementById('addr2_e').focus();
                
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

                document.getElementById('zip_f').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1_f').value = fullRoadAddr;
                document.getElementById('addr2_f').focus();
                
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
	
	if(f.i_newsagency[0].selected == true){alert('\n통신사를 선택하세요');return false;}

	if(f.hp1[0].selected == true){alert('\n휴대폰번호 첫째자리를 선택하세요');return false;}

	if(!f.hp2.value){alert('\n휴대폰번호 둘째자리를 입력하여 주십시오.');f.hp2.focus();return false;}

	if(!f.hp3.value){alert('\n휴대폰번호 셋째자리를 입력하여 주십시오.');f.hp3.focus();return false;}

	if(f.i_pmyeonguija[0].selected == true){alert('\n명의자를 선택하세요');return false;}

	if(!f.i_myeonguija.value){alert('\n명의자 이름을 입력하세요.');f.i_myeonguija.focus();return false;}

	if(!f.i_locaty.value){alert('\n담보물 주소를 입력하세요.');f.i_locaty.focus();return false;}

	if(f.i_security_type[0].checked == false && f.i_security_type[1].checked == false && f.i_security_type[2].checked == false && f.i_security_type[3].checked == false && f.i_security_type[4].checked == false){ alert('\n담보유형을 선택하여 주십시오'); return false;}

	if(!f.i_loan_pay.value){alert('\n대출희망금액을 입력하세요.');f.i_loan_pay.focus();return false;}	

	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}
	
	if(!f.i_loan_day.value){alert('\n대출기간을 선택하세요.');f.i_loan_day.focus();return false;}
	
	if(!f.i_year_plus.value){alert('\n희망금리를 입력하세요.');f.i_year_plus.focus();return false;}	
	
	if(f.i_repay_day[0].selected == true){alert('\n대출상환일을 선택하세요');return false;}	

	if(!f.i_subject.value){alert('\n대출제목을 입력하세요.');f.i_subject.focus();return false;}

	if(!f.i_loan_pose.value){alert('\n대출내용을 입력하세요.');f.i_loan_pose.focus();return false;}

//	if(!f.i_creditpoint_one.value){alert('\n신용평점을 입력하세요.');f.i_creditpoint_one.focus();return false;}
//	
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

{# footer}