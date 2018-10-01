<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<style>
.btn2 {
		display: inline-block;
		padding: 1px 12px;
		margin-bottom: 0;
		font-size: 14px;
		font-weight: 400;
		line-height: 1.42857143;
		text-align: center;
		white-space: nowrap;
		vertical-align: middle;
		-ms-touch-action: manipulation;
		touch-action: manipulation;
		cursor: pointer;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
		background-image: none;
		border: 1px solid transparent;
		border-radius: 4px;
}
.btn2-default {
	color: #fff;
	background-color: #d9534f;
	border-color: #d43f3a;
}
</style>
<script>
function save_reimbursement() {
	if(confirm('대출만기일을 저장하시겠습니까?')){
		$.ajax ({
			type: "post",
			url : "/api/index.php/cmsloanlist/postreimbursement",
			data : {loanid:'<?php echo $loa['i_id'];?>', reimbursement:$('#i_reimbursement_date').val() },
			dataType : 'json' ,
			success: function(data) {
				if(data.code === 'OK' ) {
					alert(data.data.date + "로 저장되었습니다.");
				}else {
					alert(data.msg);
				}
			}
		});
	}
}
$("document").ready( function() {
	$.ajax ({
		type: "GET",
		url : "/api/index.php/cmsloanlist/getreimbursement",
		data : {loanid:'<?php echo $loa['i_id'];?>'},
		dataType : 'json' ,
		success: function(data) {
			if(data.code === 'OK' ) {
				$('#i_reimbursement_date').val(data.data.i_reimbursement_date);
			}else {
				alert(data.msg);
			}
		}
	});
});
</script>

		<input type="hidden" name="i_loan_type" value="<?php echo $i_loan_type?>">

		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>대출신청 정보</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="m_id" value="<?php echo $loa['m_id'];?>" id="m_id"  required class="frm_input " size="30" maxlength="40" />
							<a href="javascript:void(0);" onclick="id_inquery_pop()"><img src="{MARI_ADMINSKIN_URL}/img/inquiry3_btn.png"></a>
						</td>
					</tr>
					<tr>
						<th>신청자명</th>
						<td><input type="text" name="m_name" value="<?php echo $loa['m_name'];?>" id="m_name"  required class="frm_input " size="" maxlength="10"/></td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td>
							<select name="i_newsagency">
								<option>통신사선택</option>
								<option value="SKT" <?php echo $loa['i_newsagency']=='SKT'?'selected':'';?>>SKT</option>
								<option value="KT" <?php echo $loa['i_newsagency']=='KT'?'selected':'';?>>KT</option>
								<option value="LGT" <?php echo $loa['i_newsagency']=='LGT'?'selected':'';?>>LGT</option>
								<option value="기타" <?php echo $loa['i_newsagency']=='기타'?'selected':'';?>>기타</option>
							</select>
							<input type="text" name="m_hp" value="<?php echo $loa['m_hp'];?>" id="m_hp"  required class="frm_input " size="" maxlength="11"/>
							<select name="i_pmyeonguija" required style="width:90px; margin-left:15px">
								<option value="">명의 선택</option>
								<option value="본인" <?php echo $loa['i_pmyeonguija']=='본인'?'selected':'';?>>본인</option>
								<option value="가족" <?php echo $loa['i_pmyeonguija']=='가족'?'selected':'';?>>가족</option>
								<option value="기타" <?php echo $loa['i_pmyeonguija']=='기타'?'selected':'';?>>기타</option>
							</select>
							<input type="text" name="i_myeonguija" id="" value="<?php echo $loa['i_myeonguija'];?>" placeholder="명의자 이름 작성"  maxlength="20" size="25" required class="frm_input" />
						</td>
					</tr>
					<script>
					function id_inquery_pop() {
						var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
						winObject = window.open("{MARI_HOME_URL}/?cms=inquery_pop", "openPop", opt);
					}

					function setChildValue(id, name, hp){
					      document.getElementById("m_id").value = id;
					      document.getElementById("m_name").value = name;
					      document.getElementById("m_hp").value = hp;
					}


					</script>
					<tr>
						<th>대출상품</th>
						<td>
							<select name="i_payment" >
								<option>상품을 선택하세요</option>
								<?php
									  for ($i=0; $row=sql_fetch_array($cate1); $i++) {
								?>
								<option value="<?php echo $row['ca_id'];?>"  <?php echo $row['ca_id']==$loa['i_payment']?'selected':'';?>><?php echo $row['ca_subject'];?></option>
								<?php
									    }
								?>
							</select>
						</td>
					</tr>
					<tr>
						<th>대출승인여부</th>
						<td>
						<select name="i_loanapproval">
							<option>승인여부선택</option>
							<option value="N" <?php echo $loa['i_loanapproval']=='N'?'selected':'';?>>미승인</option>
							<option value="Y" <?php echo $loa['i_loanapproval']=='Y'?'selected':'';?>>승인완료</option>
						</select>
						</td>
					</tr>
					<tr>
						<th>대출실행일설정</th>
						<td>
							<input type="text" name="i_loanexecutiondate" value="<?php echo $loa['i_loanexecutiondate'];?>" id=""   required class="frm_input calendar" size="25" />
							<h7 style="padding-left: 30px;">( 대출만기일 : <input type="text" id="i_reimbursement_date" class="frm_input calendar" placeholder="대출만기일 정보를 가져옵니다.">
								<a class="btn2 btn2-default" onclick="save_reimbursement()">저장하기</a> )</h7>
						</td>
					</tr>
					<tr>
						<th>필요자금</th>
						<td><input type="text" name="i_loan_pay" value="<?php echo number_format($loa['i_loan_pay']);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="15" /> <label for="">원</label></td>
					</tr>
					<tr>
						<th>대출기간</th>
						<td><input type="text" name="i_loan_day" value="<?php echo $loa['i_loan_day'];?>" id=""   required class="frm_input " size="10" /> 개월</td>
					</tr>
					<tr>
						<th>연이자율</th>
						<td><input type="text" name="i_year_plus" value="<?php echo $loa['i_year_plus'];?>" id=""   required class="frm_input " size="10" /> %</td>
					</tr>
					<tr>
						<th>상환방식</th>
						<td>
							<select name="i_repay">
								<option>선택하세요</option>
								<option value="일만기일시상환" <?php echo $loa['i_repay']=='일만기일시상환'?'selected':'';?>>일만기일시상환</option>
								<option value="원리금균등상환" <?php echo $loa['i_repay']=='원리금균등상환'?'selected':'';?>>원리금균등상환</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>대출상환일</th>
						<td>
						<select name="i_repay_day">
							<option>선택하세요</option>
							<?php for($i=1; $i <= 31; $i++){?>
							<option value="<?php echo $i;?>" <?php echo $loa['i_repay_day']== $i ?'selected':'';?>><?php echo $i;?>일</option>
							<?php }?>
						</select>
						</td>
					</tr>
					<tr>
						<th>담보사진</th>
						<td>
							<p>※파일형식은 jpg, png, gif만 지원합니다.</p>
							<input type="file" name="i_security" size="10">
								<?php
								$bimg_str = "";
								$bimg = MARI_DATA_PATH."/photoreviewers/".$loa['i_security']."";
								if (file_exists($bimg) && $loa['i_security']) {
								$size = @getimagesize($bimg);
								if($size[0] && $size[0] > 16)
								$width = 16;
								else
								$width = $size[0];
								echo '<input type="checkbox" name="d_img" value="1" id="bn_bimg_del"> <label for="bn_bimg_del">삭제하기</label>';
								$bimg_str = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loa['i_security'].'" width="382" height="220">';
								}
								if ($bimg_str) {
								echo '<div class="banner_or_img">';
								echo $bimg_str;
								echo '</div>';
								}
								?>
						</td>
					</tr>
					<tr>
						<th>감정가</th>
						<td>
						<input type="text" name="i_conni" value="<?php echo number_format($loa['i_conni']);?>" size="15" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input">&nbsp 원
						</td>
					</tr>
					<tr>
						<th>감정가(관리자)</th>
						<td>
						<input type="text" name="i_conni_admin" value="<?php echo number_format($loa['i_conni_admin']);?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" size="15" class="frm_input">&nbsp 원
						</td>
					</tr>

					<tr>
						<th>선순위 금액</th>
						<td>
						<input type="text" name="i_senior_price" value="<?php echo number_format($loa['i_senior_price']);?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" size="15" class="frm_input">&nbsp 원
						</td>
					</tr>
					<tr>
						<th>담보물유형</th>
						<td>
						<input type="text" name="i_security_type" value="<?php echo $loa['i_security_type']?>" class="frm_input" size="50"  >
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
						<input type="text" name="i_subject" value="<?php echo $loa['i_subject']?>" class="frm_input" size="100" >
						</td>
					</tr>

					<tr>
						<th>자금용도</th>
						<td>
						<input type="text" name="i_purpose" value="<?php echo $loa['i_purpose'];?>" class="frm_input" size="100">
						</td>
					</tr>
					<tr>
						<th>대출목적</th>
						<td>
						<?php echo editor_html('i_loan_pose', $loa['i_loan_pose']); ?>
						</td>
					</tr>
					<tr>
						<th>투자요약</th>
						<td>
						<?php echo editor_html('i_ltext', $loa['i_ltext']); ?>
						</td>
					</tr>
					<tr>
						<th>원금상환방법</th>
						<td>
						<?php echo editor_html('i_plan', $loa['i_plan']); ?>
						</td>
					</tr>
					<tr>
						<th>소재지 검색</th>
						<td colspan="3">
							<input  type="text" name=i_locaty id="i_locaty_00" itemname="Address" value="<?php echo $loa['i_locaty'];?>" onKeyDown="if(event.keyCode==13){codeAddress();}" class="frm_input " size="50"> <img src="{MARI_ADMINSKIN_URL}/img/adress3_btn.png" onclick="codeAddress()" style="cursor:pointer;" ><br/><br/>
						<div id="mgmap"></div>

						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<?php echo $config[c_map_api]?>&libraries=services,clusterer,drawing"></script>
						<script type="text/javascript">

						  function codeAddress(results, status){
						  var y = '';
						  var x = '';
							  var address = document.getElementById('i_locaty_00').value;
								var mapContainer = document.getElementById('mgmap'), // 지도를 표시할 div
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
					<tr>
						<th>현재위치</th>
						<td>
						<div id="map_canvas" style="width: 90%; height: 380px;"></div>
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
									    content: '<div style="width:150px;text-align:center;padding:6px 0;">위치</div>'
									});
									infowindow.open(map, marker);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								    }
								});
						</script>
						</td>
					</tr>

					</script>


					<tr>
						<th>지역지구</th>
						<td>
						<?php echo editor_html('i_zone', $loa['i_zone']); ?>
						</td>
					</tr>
					<tr>
						<th>면적</th>
						<td>
						<input type="text" name="i_area" value="<?php echo $loa['i_area'];?>" id=""  required class="frm_input " size="15" /> m<sup>2</sup>
						</td>
					</tr>
					<tr>
						<th>건축세대수</th>
						<td>
						<input type="text" name="i_gener" value="<?php echo $loa['i_gener'];?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input " size="15" /> 가구
						</td>
					</tr>
					<tr>
						<th>교육시설</th>
						<td>
						<?php echo editor_html('i_educa', $loa['i_educa']); ?>
						</td>
					</tr>
					<tr>
						<th>교통</th>
						<td>
						<?php echo editor_html('i_traffic', $loa['i_traffic']); ?>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
