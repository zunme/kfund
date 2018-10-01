<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}
<script type="text/javascript">
$(function(){
	$('#container').css('margin-top','0px');
	$('#main_content').css('position','relative');
	$('#main_content').css('margin-top','0px');
});
</script>
<div id="container">
	<div id="sub_content">			
		<div class="mypage">
			<div class="mypage_inner">
				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							
						</div>

						<div class="dashboard_side_mn">
							<ul>
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
							</ul>
						</div>
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">

						<form name="auto_invest_form" method="post" enctype="multipart/form-data">
						<?php if($auto['m_id']){?>						
						<input type="hidden" name="type" value="m">
						<?php }else{?>
						<input type="hidden" name="type" value="w">
						<?php }?>
							<h3><span>자동분산투자 신청</span></h3>
							<div class="dashboard_auto_invest auto_invest_setting">
								<div class="auto_invest_list auto_invest_list2">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">투자조건 설정</h3>
									<table>
										<colgroup>
											<col width="50%">
											<col width="50%">
										</colgroup>
										<thead>
											<tr>
												<th>자동 투자금액</th>
												<th>선호이율</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<input type="text" name="au_pay" value="<?php echo number_format($auto[au_pay])?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="money_in"> 원
												</td>
												<td>
													<select name="au_iyul" style="width:264px">
														<option>선택하세요</option>
														<option value="iyul1" <?php echo $auto['au_iyul']=='iyul1'?'selected':'';?>>10%이상 ~ 13%미만</option>
														<option value="iyul2" <?php echo $auto['au_iyul']=='iyul2'?'selected':'';?>>13%이상 ~ 16%미만</option>
														<option value="iyul3" <?php echo $auto['au_iyul']=='iyul3'?'selected':'';?>>16%이상 ~ 19%미만</option>
														<option value="iyul4" <?php echo $auto['au_iyul']=='iyul4'?'selected':'';?>>19%이상 ~ 21%미만</option>
													</select>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="mt20">
										<colgroup>
											<col width="15%">
											<col width="28%">
											<col width="28%">
											<col width="28%">
										</colgroup>
										<thead>
											<tr>
												<th></th>
												<th>1순위</th>
												<th>2순위</th>
												<th>3순위</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>모집금액</td>
												<td>
													<select name="rec_pay_01">
														<option>선택하세요</option>
														<option value="pay1" <?php echo $rec_pay_01=='pay1'?'selected':'';?>>1000만원 이하</option>
														<option value="pay2" <?php echo $rec_pay_01=='pay2'?'selected':'';?>>1000만원 ~ 5000만원</option>
														<option value="pay3" <?php echo $rec_pay_01=='pay3'?'selected':'';?>>5000만원 ~ 10,000만원</option>
														<option value="pay4" <?php echo $rec_pay_01=='pay4'?'selected':'';?>>10,000만원 ~ 50,000만원</option>
														<option value="pay5" <?php echo $rec_pay_01=='pay5'?'selected':'';?>>50,000만원 이상</option>
													</select>
												</td>
												<td>
													<select name="rec_pay_02">
														<option>선택하세요</option>
														<option value="pay1" <?php echo $rec_pay_02=='pay1'?'selected':'';?>>1000만원 이하</option>
														<option value="pay2" <?php echo $rec_pay_02=='pay2'?'selected':'';?>>1000만원 ~ 5000만원</option>
														<option value="pay3" <?php echo $rec_pay_02=='pay3'?'selected':'';?>>5000만원 ~ 10,000만원</option>
														<option value="pay4" <?php echo $rec_pay_02=='pay4'?'selected':'';?>>10,000만원 ~ 50,000만원</option>
														<option value="pay5" <?php echo $rec_pay_02=='pay5'?'selected':'';?>>50,000만원 이상</option>
													</select>
												</td>
												<td>
													<select name="rec_pay_03">
														<option>선택하세요</option>
														<option value="pay1" <?php echo $rec_pay_03=='pay1'?'selected':'';?>>1000만원 이하</option>
														<option value="pay2" <?php echo $rec_pay_03=='pay2'?'selected':'';?>>1000만원 ~ 5000만원</option>
														<option value="pay3" <?php echo $rec_pay_03=='pay3'?'selected':'';?>>5000만원 ~ 10,000만원</option>
														<option value="pay4" <?php echo $rec_pay_03=='pay4'?'selected':'';?>>10,000만원 ~ 50,000만원</option>
														<option value="pay5" <?php echo $rec_pay_03=='pay5'?'selected':'';?>>50,000만원 이상</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>투자기간</td>
												<td>
													<select name="term_01">
														<option>선택하세요</option>
														<option value="term1" <?php echo $term_01=='term1'?'selected':'';?>>3개월 이하</option>
														<option value="term2" <?php echo $term_01=='term2'?'selected':'';?>>4 ~ 6개월</option>
														<option value="term3" <?php echo $term_01=='term3'?'selected':'';?>>7 ~ 9개월</option>
														<option value="term4" <?php echo $term_01=='term4'?'selected':'';?>>10 ~ 12개월</option>
														<option value="term5" <?php echo $term_01=='term5'?'selected':'';?>>13 ~ 24개월</option>
														<option value="term6" <?php echo $term_01=='term6'?'selected':'';?>>25개월 이상</option>
													</select>
												</td>
												<td>
													<select name="term_02">
														<option>선택하세요</option>
														<option value="term1" <?php echo $term_02=='term1'?'selected':'';?>>3개월 이하</option>
														<option value="term2" <?php echo $term_02=='term2'?'selected':'';?>>4 ~ 6개월</option>
														<option value="term3" <?php echo $term_02=='term3'?'selected':'';?>>7 ~ 9개월</option>
														<option value="term4" <?php echo $term_02=='term4'?'selected':'';?>>10 ~ 12개월</option>
														<option value="term5" <?php echo $term_02=='term5'?'selected':'';?>>13 ~ 24개월</option>
														<option value="term6" <?php echo $term_02=='term6'?'selected':'';?>>25개월 이상</option>
													</select>
												</td>
												<td>
													<select name="term_03">
														<option>선택하세요</option>
														<option value="term1" <?php echo $term_03=='term1'?'selected':'';?>>3개월 이하</option>
														<option value="term2" <?php echo $term_03=='term2'?'selected':'';?>>4 ~ 6개월</option>
														<option value="term3" <?php echo $term_03=='term3'?'selected':'';?>>7 ~ 9개월</option>
														<option value="term4" <?php echo $term_03=='term4'?'selected':'';?>>10 ~ 12개월</option>
														<option value="term5" <?php echo $term_03=='term5'?'selected':'';?>>13 ~ 24개월</option>
														<option value="term6" <?php echo $term_03=='term6'?'selected':'';?>>25개월 이상</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>이자지급방식</td>
												<td>
													<select name="give_way_01">
														<option>선택하세요</option>
														<option value="만기일시상환" <?php echo $give_way_01=='만기일시상환'?'selected':'';?>>만기일시상환</option>
														<option value="원리금균등상환" <?php echo $give_way_01=='원리금균등상환'?'selected':'';?>>원리금균등상환</option>
														<option value="기타" <?php echo $give_way_01=='기타'?'selected':'';?>>기타</option><!--해당플랫폼의 이자지급방식 연동-->
													</select>
												</td>
												<td>
													<select name="give_way_02">
														<option>선택하세요</option>
														<option value="만기일시상환" <?php echo $give_way_02=='만기일시상환'?'selected':'';?>>만기일시상환</option>
														<option value="원리금균등상환" <?php echo $give_way_02=='원리금균등상환'?'selected':'';?>>원리금균등상환</option>
														<option value="기타" <?php echo $give_way_02=='기타'?'selected':'';?>>기타</option><!--해당플랫폼의 이자지급방식 연동-->
													</select>
												</td>
												<td>
													<select name="give_way_03">
														<option>선택하세요</option>
														<option value="만기일시상환" <?php echo $give_way_03=='만기일시상환'?'selected':'';?>>만기일시상환</option>
														<option value="원리금균등상환" <?php echo $give_way_03=='원리금균등상환'?'selected':'';?>>원리금균등상환</option>
														<option value="기타" <?php echo $give_way_03=='기타'?'selected':'';?>>기타</option><!--해당플랫폼의 이자지급방식 연동-->
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!--투자조건 설정-->
								<div class="auto_invest_list auto_invest_list2">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">투자유형 설정</h3>
									<table>
										<colgroup>
											<col width="15%">
											<col width="28%">
											<col width="28%">
											<col width="28%">
										</colgroup>
										<thead>
											<tr>
												<th></th>
												<th>1순위</th>
												<th>2순위</th>
												<th>3순위</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>포트폴리오유형 <a href="{MARI_HOME_URL}/?mode=mypage_portfolio_pop" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false"class="port_pop">?</a></td>
												<td>
													<select name="portfolio_01">
														<option>선택하세요</option>
														<option value="S" <?php echo $portfolio_01=='S'?'selected':'';?>>안정형</option>
														<option value="D" <?php echo $portfolio_01=='D'?'selected':'';?>>위험중립형</option>
														<option value="V" <?php echo $portfolio_01=='V'?'selected':'';?>>적극투자형</option>
														<option value="A" <?php echo $portfolio_01=='A'?'selected':'';?>>공격투자형</option>
													</select>
												</td>
												<td>
													<select name="portfolio_02">
														<option>선택하세요</option>
														<option value="S" <?php echo $portfolio_02=='S'?'selected':'';?>>안정형</option>
														<option value="D" <?php echo $portfolio_02=='D'?'selected':'';?>>위험중립형</option>
														<option value="V" <?php echo $portfolio_02=='V'?'selected':'';?>>적극투자형</option>
														<option value="A" <?php echo $portfolio_02=='A'?'selected':'';?>>공격투자형</option>
													</select>
												</td>
												<td>
													<select name="portfolio_03">
														<option>선택하세요</option>
														<option value="S" <?php echo $portfolio_03=='S'?'selected':'';?>>안정형</option>
														<option value="D" <?php echo $portfolio_03=='D'?'selected':'';?>>위험중립형</option>
														<option value="V" <?php echo $portfolio_03=='V'?'selected':'';?>>적극투자형</option>
														<option value="A" <?php echo $portfolio_03=='A'?'selected':'';?>>공격투자형</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>자체평가등급</td>
												<td>
													<select name="grade_01">
														<option>선택하세요</option>
														<option value="A" <?php echo $grade_01=='A'?'selected':'';?>>A</option>
														<option value="B" <?php echo $grade_01=='B'?'selected':'';?>>B</option>
														<option value="C" <?php echo $grade_01=='C'?'selected':'';?>>C</option>
														<option value="D" <?php echo $grade_01=='D'?'selected':'';?>>D</option>
														<option value="E" <?php echo $grade_01=='E'?'selected':'';?>>E</option>
													</select>
												</td>
												<td>
													<select name="grade_02">
														<option>선택하세요</option>
														<option value="A" <?php echo $grade_02=='A'?'selected':'';?>>A</option>
														<option value="B" <?php echo $grade_02=='B'?'selected':'';?>>B</option>
														<option value="C" <?php echo $grade_02=='C'?'selected':'';?>>C</option>
														<option value="D" <?php echo $grade_02=='D'?'selected':'';?>>D</option>
														<option value="E" <?php echo $grade_02=='E'?'selected':'';?>>E</option>
													</select>
												</td>
												<td>
													<select name="grade_03">
														<option>선택하세요</option>
														<option value="A" <?php echo $grade_03=='A'?'selected':'';?>>A</option>
														<option value="B" <?php echo $grade_03=='B'?'selected':'';?>>B</option>
														<option value="C" <?php echo $grade_03=='C'?'selected':'';?>>C</option>
														<option value="D" <?php echo $grade_03=='D'?'selected':'';?>>D</option>
														<option value="E" <?php echo $grade_03=='E'?'selected':'';?>>E</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>투자상품</td>
												<td>
													<select name="product_01">
														<option>선택하세요</option>
														<option value="real" <?php echo $product_01=='real'?'selected':'';?>>부동산담보</option>
														<option value="credit" <?php echo $product_01=='credit'?'selected':'';?>>신용</option>
														<option value="car" <?php echo $product_01=='car'?'selected':'';?>>자동차</option>
														<option value="pawn" <?php echo $product_01=='pawn'?'selected':'';?>>전당포</option>
														<option value="npl" <?php echo $product_01=='npl'?'selected':'';?>>NPL</option>
														<option value="build" <?php echo $product_01=='build'?'selected':'';?>>자체건축</option>
														<option value="guitar" <?php echo $product_01=='guitar'?'selected':'';?>>기타</option><!-- 플랫폼과 연동 -->
													</select>
												</td>
												<td>
													<select name="product_02">
														<option>선택하세요</option>
														<option value="real" <?php echo $product_02=='real'?'selected':'';?>>부동산담보</option>
														<option value="credit" <?php echo $product_02=='credit'?'selected':'';?>>신용</option>
														<option value="car" <?php echo $product_02=='car'?'selected':'';?>>자동차</option>
														<option value="pawn" <?php echo $product_02=='pawn'?'selected':'';?>>전당포</option>
														<option value="npl" <?php echo $product_02=='npl'?'selected':'';?>>NPL</option>
														<option value="build" <?php echo $product_02=='build'?'selected':'';?>>자체건축</option>
														<option value="guitar" <?php echo $product_02=='guitar'?'selected':'';?>>기타</option><!-- 플랫폼과 연동 -->
													</select>
												</td>
												<td>
													<select name="product_03">
														<option>선택하세요</option>
														<option value="real" <?php echo $product_03=='real'?'selected':'';?>>부동산담보</option>
														<option value="credit" <?php echo $product_03=='credit'?'selected':'';?>>신용</option>
														<option value="car" <?php echo $product_03=='car'?'selected':'';?>>자동차</option>
														<option value="pawn" <?php echo $product_03=='pawn'?'selected':'';?>>전당포</option>
														<option value="npl" <?php echo $product_03=='npl'?'selected':'';?>>NPL</option>
														<option value="build" <?php echo $product_03=='build'?'selected':'';?>>자체건축</option>
														<option value="guitar" <?php echo $product_03=='guitar'?'selected':'';?>>기타</option><!-- 플랫폼과 연동 -->
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!--투자유형 설정-->
								<div class="auto_invest_list">
									<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">자동분산투자 설정 시 위험안내</h3>
									<div class="auto_invest_notice" style="padding-left:0 !important">
										<?php echo $config['c_auto_dangerous']?>
									</div>
									<div class="auto_invest_agree">
										<p class="agree"><input type="checkbox"> 상기 내용에 동의합니다.</p>
										<a href="#" onclick="auto_complete()" class="btn_auto_invest btn_auto_invest3">신청하기</a>
									</div>
								</div><!--위험안내-->					
							</div><!--dashboard_balance-->
							</form>
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div><!--//mapage e -->
	</div><!--//main_content e -->
</div><!--//container e -->

{#footer}
<script>
	function auto_complete(){
		var f = document.auto_invest_form;

		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?up=auto_application';
		f.submit();
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