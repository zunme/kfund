<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
						<td><input type="text" name="i_loanexecutiondate" value="<?php echo $loa['i_loanexecutiondate'];?>" id=""   required class="frm_input calendar" size="25" />
							<h7 style="padding-left: 30px;">( 대출만기일 : <input type="text" id="i_reimbursement_date" class="frm_input calendar" placeholder="대출만기일 정보를 가져옵니다.">
								<a class="btn2 btn2-default" onclick="save_reimbursement()">저장하기</a> )</h7>
						</td>
					</tr>
					<tr>
						<th>종류</th>
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
						<th>제목</th>
						<td>
						<input type="text" name="i_subject" value="<?php echo $loa['i_subject']?>" class="frm_input" size="100" >
						</td>
					</tr>
					<tr>
						<th>자금용도</th>
						<td>
						<input type="text" name="i_purpose" value="<?php echo $loa['i_purpose']?>" class="frm_input" size="100" >
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<h2 class="bo_title mt40"><span>본인 정보</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>본인 정보</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th><span>나이</span></th>
						<td>
							<input type="text" name="i_birth" value="<?php echo $loa['i_birth'];?>" id="" required  class="frm_input " size="8" /> <label for="m_birth">세</label>
						</td>
					</tr>
					<tr>
						<th><span>성별</span></th>
						<td>
							<input type="radio" name="i_sex" value="m" <?php echo $loa['i_sex']=='m'?'checked':'';?>>남자&nbsp&nbsp&nbsp
							<input type="radio" name="i_sex" value="w" <?php echo $loa['i_sex']=='w'?'checked':'';?>>여자
						</td>
					</tr>

					<tr>
						<th>직업</th>
						<td colspan="2">
							<p class="pt5">
								<input type='radio' name="i_officeworkers" value="직장인" onclick="div_OnOff('1');"  <?php echo $loa['i_officeworkers']=='직장인'?'checked':'';?>> <label class="mr10">직장인</label>
								<input type='radio' name="i_officeworkers" value="프리랜서" onclick="div_OnOff('2');" <?php echo $loa['i_officeworkers']=='프리랜서'?'checked':'';?>> <label class="mr10">프리랜서</label>
								<input type='radio' name="i_officeworkers" value="사업자" onclick="div_OnOff('3');" <?php echo $loa['i_officeworkers']=='사업자'?'checked':'';?>> <label class="mr10">사업자</label>
								<input type='radio' name="i_officeworkers" value="대학생" onclick="div_OnOff('4');" <?php echo $loa['i_officeworkers']=='대학생'?'checked':'';?>> <label class="mr10">대학생</label>
								<input type='radio' name="i_officeworkers" value="무직자" onclick="div_OnOff('5');" <?php echo $loa['i_officeworkers']=='무직자'?'checked':'';?>> <label>무직자</label>
							</p>
							<ul class="txt_style1">
								<li style="display:<?php if($loa['i_officeworkers']=='직장인' || !$loa['i_officeworkers']){ echo 'block'; }else{ echo 'none'; }?>;"   id="stype01">
									<p>
									<strong>직종</strong>
									<input type="text" name="i_occu_a" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input"  />
									</p>
									<p>
									<strong>직장명</strong>
									<input type="text" name="i_company_name_a" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input"  />
									</p>
									<p>
									<strong>직장주소</strong>
									<input type="text" name="rectal_address_a" value="<?php echo $loa['i_rectal_address'];?>" id="" required   class="frm_input " size="80" />
									</p>
									<p>
									<strong>규모</strong>
									<input type="text" name="occu_scale_a" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
									</p>
									<p>
									<strong>직장전화번호</strong>
									<input type="text" name="i_businesshp_a" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12"  />
									<span class="color_re ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
									</p>
								</li>
								<li style="display:<?php if($loa['i_officeworkers']=='프리랜서'){ echo 'block'; }else{ echo 'none'; }?>;"   id="stype02">
									<p>
									<strong>직종</strong>
									<input type="text" name="i_occu_b" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input"  />
									</p>
									<p>
									<strong>직장명</strong>
									<input type="text" name="i_company_name_b" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input" />
									</p>
									<p>
									<strong>직장주소</strong>
									<input type="text" name="rectal_address_b" value="<?php echo $loa['i_rectal_address'];?>" id="" required   class="frm_input " size="80" />
									</p>
									<p>
									<strong>규모</strong>
									<input type="text" name="occu_scale_b" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
									</p>
									<p>
									<strong>직장전화번호</strong> <input type="text" name="i_businesshp_b" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12" />
									<span class="color_re ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
									</p>
								</li>
								<li style="display:<?php if($loa['i_officeworkers']=='사업자'){ echo 'block'; }else{ echo 'none'; }?>;"   id="stype03">
									<p>
									<strong>업종</strong>
									<input type="text" name="i_occu_c" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input" />
									</p>
									<p>
									<strong>사업자명</strong>
									<input type="text" name="i_businessname_a" value="<?php echo $loa['i_businessname'];?>" id="" required  class="frm_input" />
									</p>
									<p>
									<strong>사업장주소</strong>
									<input type="text" name="rectal_address_c" value="<?php echo $loa['i_rectal_address'];?>" id="" required   class="frm_input " size="80" />
									</p>
									<p>
									<strong>규모</strong>
									<input type="text" name="occu_scale_c" value="<?php echo $loa['i_occu_scale'];?>" id="" required   class="frm_input " size="" />
									</p>
									<p>
									<strong>사업장전화번호</strong>
									<input type="text" name="i_businesshp_c" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12"  />
									<span class="color_re ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
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
								<li style="display:<?php if($loa['i_officeworkers']=='대학생'){ echo 'block'; }else{ echo 'none'; }?>;"   id="stype04">
									<p>
									<strong>학교명</strong>
									<input type="text" name="i_businessname_b" value="<?php echo $loa['i_businessname'];?>" id="" required  class="frm_input "  />
									</p>
									<p>
									<strong>학교주소</strong>
									<input type="text" name="rectal_address_d" value="<?php echo $loa['i_rectal_address'];?>" id="" required   class="frm_input " size="80" />
									</p>
									<p>
									<strong>학교전화번호</strong>
									<input type="text" name="i_businesshp_d" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12"  />
									<span class="color_re ml10"> ※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
									</p>
									<p>
									<strong>학과</strong>
									<input type="text" name="i_occu_d" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input " />
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
									<input type="text" name="i_once" value="<?php echo $loa['i_once'];?>" id="" required  class="frm_input" />
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
								<li style="display:<?php if($loa['i_officeworkers']=='무직자'){ echo 'block'; }else{ echo 'none'; }?>;"   id="stype05">
									<p>
									<strong>최종학력</strong>
									<select name="i_businessname_c" required>
										<option>선택</option>
										<option value="중졸" <?php echo $loa['i_businessname']=='중졸'?'selected':'';?>>중졸</option>
										<option value="고졸" <?php echo $loa['i_businessname']=='고졸'?'selected':'';?>>고졸</option>
										<option value="대졸" <?php echo $loa['i_businessname']=='대졸'?'selected':'';?>>대졸</option>
									</select>
									</p>
									<p <span class="color_re pt5 pb5">※ 아르바이트 중일 경우 입력하세요.</p>
									<p>
									<strong>직종</strong>
									<input type="text" name="i_occu_e" value="<?php echo $loa['i_occu'];?>" id="" required  class="frm_input" />
									</p>
									<p>
									<strong>직장명</strong>
									<input type="text" name="i_company_name_c" value="<?php echo $loa['i_company_name'];?>" id="" required class="frm_input " />
									</p>
									<p>
									<strong>직장주소</strong>
									<input type="text" name="rectal_address_e" value="<?php echo $loa['i_rectal_address'];?>" id="" required   class="frm_input " size="80" />
									</p>
									<p>
									<strong>직장전화번호</strong>
									<input type="text" name="i_businesshp_e" value="<?php echo $loa['i_businesshp'];?>" id="" required  class="frm_input " maxlength="12"  />
									<span class="color_re ml10">※ "-"를 제회한 숫자만 입력하여 주십시오.</span>
									</p>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th>고용정보</th>
						<td>
						<ul class="txt_style1">
							<p>
								<strong>고용형태</strong>
								<select name="i_employment" required >
									<option>선택</option>
									<option value="정규직" <?php echo $loa['i_employment']=='정규직'?'selected':'';?>>정규직</option>
									<option value="비정규직" <?php echo $loa['i_employment']=='비정규직'?'selected':'';?>>비정규직</option>
									<option value="계약직" <?php echo $loa['i_employment']=='계약직'?'selected':'';?>>계약직</option>
								</select>
							</p>
							<p>
								<strong>근무개월 <br/> 사업기간</strong>
								<input type="text" name="i_company_day" value="<?php echo $loa['i_company_day'];?>" id="" required  class="frm_input " size="5"/>
								<label for="">개월</label>
							</p>
						</ul>
						</td>
					</tr>
					<tr>
						<th>소득정보</th>
						<td>
						<ul class="txt_style1">
							<p>
								<strong>소득금액</strong>
								<label for="">월</label>
								<input type="text" name="i_plus_pay_mon" id="" value="<?php echo number_format($loa['i_plus_pay_mon']);?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input" required/>
								<label for="" class="ml5">연</label>
								<input type="text" name="i_plus_pay_year" value="<?php echo number_format($loa['i_plus_pay_year']);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" required class="frm_input"  />
							</p>
							<p>
								<strong>생활비용</strong>
								<label for="">월</label>
								<input type="text" name="i_living_pay" id="" value="<?php echo number_format($loa['i_living_pay']);?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input" required/>
							</p>
						</ul>
						</td>
					</tr>
					<tr>
						<th>제출가능 서류</th>
						<td>
							<p>공통 (
								<input type="checkbox" id="out_paper_01" name="out_paper_01"   value="신분증" <?php echo $out_paper_01=='신분증'?'checked':'';?>/> <label for="">신분증</label>,
								<input type="checkbox" id="out_paper_02" name="out_paper_02"   value="등본"  <?php echo $out_paper_02=='등본'?'checked':'';?>/> <label for="">등본</label>,
								<input type="checkbox" id="out_paper_03" name="out_paper_03"   value="원초본"  <?php echo $out_paper_03=='원초본'?'checked':'';?>/> <label for="">원초본</label> ,
								<input type="checkbox" id="out_paper_04" name="out_paper_04"   value="가족관계증명서"  <?php echo $out_paper_04=='가족관계증명서'?'checked':'';?>/> <label for="">가족관계증명서</label>,
								<input type="checkbox" id="out_paper_05" name="out_paper_05"   value="주거래통장"  <?php echo $out_paper_05=='주거래통장'?'checked':'';?>/> <label for="">주거래통장</label>
								)
							</p>
							<p>소득서류 (
								<input type="checkbox" id="out_paper_06" name="out_paper_06"   value="원천징수영수증"  <?php echo $out_paper_06=='원천징수영수증'?'checked':'';?>/> <label for="">원천징수영수증</label>,
								<input type="checkbox" id="out_paper_07" name="out_paper_07"   value="갑종근로소득세"  <?php echo $out_paper_07=='갑종근로소득세'?'checked':'';?>/> <label for="">갑종근로소득세</label>,
								<input type="checkbox" id="out_paper_08" name="out_paper_08"   value="직장의료보험 납부확인서"  <?php echo $out_paper_08=='직장의료보험 납부확인서'?'checked':'';?>/> <label for="">직장의료보험 납부확인서</label>,
								<input type="checkbox" id="out_paper_09" name="out_paper_09"   value="급여통장 거래내역서"  <?php echo $out_paper_09=='급여통장 거래내역서'?'checked':'';?>/> <label for="">급여통장 거래내역서</label>
								)
							</p>
							<p>재직서류 (
								<input type="checkbox" id="out_paper_10" name="out_paper_10"   value="재직증명서"  <?php echo $out_paper_10=='재직증명서'?'checked':'';?>/> <label for="">재직증명서</label>,
								<input type="checkbox" id="out_paper_11" name="out_paper_11"   value="직장의료보험 자격득실확인서"  <?php echo $i_out_paper_11=='직장의료보험 자격득실확인서'?'checked':'';?>/> <label for="">직장의료보험 자격득실확인서</label> )
							</p>
						</td>
					</tr>
					<tr>
						<th>결혼여부</th>
						<td>
							<select name="i_wedding" required >
								<option value="선택">선택</option>
								<option value="미혼" <?php echo $loa['i_wedding']=='미혼'?'selected':'';?>>미혼</option>
								<option value="기혼" <?php echo $loa['i_wedding']=='기혼'?'selected':'';?>>기혼</option>
							</select>
						</td>
					</tr>
					<!--
					<tr>
						<th>동거인수</th>
						<td><input type="text" name="i_home_many" value="<?php echo $loa['i_home_many'];?>" id=""  required  class="frm_input " size="10" /></td>
					</tr>
					-->
					<tr>
						<th>주거소유형태</th>
						<td>
							<select name="i_home_ok" required >
								<option value="선택">선택</option>
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
						<th>주거현황</th>
						<td>
							<select name="i_home_me" required >
								<option value="선택">선택</option>
								<option value="본인소유" <?php echo $loa['i_home_me']=='본인소유'?'selected':'';?>>본인소유</option>
								<option value="가족소유" <?php echo $loa['i_home_me']=='가족소유'?'selected':'';?>>가족소유</option>
								<option value="전세" <?php echo $loa['i_home_me']=='전세'?'selected':'';?>>전세</option>
								<option value="월세" <?php echo $loa['i_home_me']=='월세'?'selected':'';?>>월세</option>
							</select>

						</td>
					</tr>
					<tr>
						<th>세대구성</th>
						<td>
							<select name="i_home_stay" required >
								<option value="선택">선택</option>
								<option value="가족동거" <?php echo $loa['i_home_stay']=='가족동거'?'selected':'';?>>가족동거</option>
								<option value="단독세대주" <?php echo $loa['i_home_stay']=='단독세대주'?'selected':'';?>>단독세대주</option>
								<option value="동거인" <?php echo $loa['i_home_stay']=='동거인'?'selected':'';?>>동거인</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>차량소유여부</th>
						<td>
							<select name="i_car_ok" required >
								<option value="선택">선택</option>
								<option value="유" <?php echo $loa['i_car_ok']=='유'?'selected':'';?>>유</option>
								<option value="무" <?php echo $loa['i_car_ok']=='무'?'selected':'';?>>무</option>
							</select>
						</td>
					</tr>

					<tr>
					<th><span>군필 여부</span></th>
						<td >
							<select name="i_veteran" required>
								<option value="선택">선택</option>
								<option value="Y" <?php echo $loa['i_veteran']=='Y'?'selected':'';?>>군필</option>
								<option value="N" <?php echo $loa['i_veteran']=='N'?'selected':'';?>>관련없음</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>실거주지 주소</th>
						<td> <input type="text" name="i_home_address" value="<?php echo $loa['i_home_address'];?>" id="" required   class="frm_input " size="80" />	</td>
					</tr>
					<?php if($i_loan_type=="business"){?>
									 <tr >
										<th>펀딩을 처음 접한 </th>
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

							  <tr>
							    <th>사업자번호</th>
								<td><input type="text" name="i_business_num" value="<?php echo $loa['i_business_num'];?>" size="70" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>기업명</th>
								<td><input type="text" name="i_company_name2" value="<?php echo $loa['i_company_name2'];?>" size="60" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>사업형태</th>
								<td><input type='radio' name="i_business_type" value="법인사업자" <?php echo $loa['i_business_type']=='법인사업자'?'checked':'';?>/>법인사업자
								 <input type='radio' name="i_business_type"value="개인사업자" <?php echo $loa['i_business_type']=='개인사업자'?'checked':'';?>/>개인사업자
								</td>
							  </tr>
							  <tr>
							    <th>위치</th>
								<td><input type="text" name="i_location" value="<?php echo $loa['i_location'];?>" size="60" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>운영기간</th>
								<td><input type="text" name="i_perating_period" value="<?php echo $loa['i_perating_period'];?>" size="60" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>업종</th>
								<td><input type="text" name="i_csectors" value="<?php echo $loa['i_csectors'];?>" size="60" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>서비스품목</th>
								<td><input type="text" name="i_service_item" value="<?php echo $loa['i_service_item'];?>" size="60" class="frm_input"/></td>
							  </tr>
							  <tr>
							    <th>직원수</th>
								<td><input type="text" name="i_numberof_ep" value="<?php echo $loa['i_numberof_ep'];?>" size="10" class="frm_input"/> 명</td>
							  </tr>
							  <tr>
							    <th>연매출</th>
								<td><input type="text" name="i_annual_sales" value="<?php echo $loa['i_annual_sales'];?>" size="20" class="frm_input"/>만원</td>
							  </tr>
							  <tr>
							    <th>월평균매출</th>
								<td><input type="text" name="i_monthly_sales" value="<?php echo $loa['i_monthly_sales'];?>" size="20" class="frm_input"/>만원</td>
							  </tr>
							  <tr>
							    <th>월타사대출상환액</th>
								<td><input type="text" name="i_mtp_loan" value="<?php echo $loa['i_mtp_loan'];?>" size="20" class="frm_input"/>만원</td>
							  </tr>
							  <tr>
							    <th>월순이익</th>
								<td><input type="text" name="i_monthly_netprofit" value="<?php echo $loa['i_monthly_netprofit'];?>" size="20" class="frm_input"/>만원</td>
							  </tr>
							  <tr>
							    <th>기대출금액</th>
								<td>담보 <input placeholder="담보" type="text" name="i_eamountof_01" value="<?php echo $loa['i_eamountof_01'];?>"  class="frm_input"/>
								      신용 <input  placeholder="신용" type="text" name="i_eamountof_02" value="<?php echo $loa['i_eamountof_02'];?>"  class="frm_input"/>
									  P2P금융 <input  placeholder="P2P금융" type="text" name="i_eamountof_03" value="<?php echo $loa['i_eamountof_03'];?>"  class="frm_input"/>
									  기타 <input placeholder="기타" type="text" name="i_eamountof_04" value="<?php echo $loa['i_eamountof_04'];?>"  class="frm_input"/>
									  </td>
							  </tr>
							<?php }?>
				</tbody>
			</table>
		</div>
