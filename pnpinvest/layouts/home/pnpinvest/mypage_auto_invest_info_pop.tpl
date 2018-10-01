<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
 <head>
  <title>자동분산투자 ｜ 자동투자 정보</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css">
</head>

 <body>
	<div class="auto_invest_pop">
		<div class="auto_invest_pop_inner">
			<h3>자동투자정보 상세보기</h3>
			<div>
				<h4><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">투자조건 설정</h4>
				<p>자동투자금액<span><?php echo number_format($auto['au_pay'])?>원</span></p>
				<span class="line"></span>
				<p>선호이율<span><?php if($auto['au_iyul']=="iyul1"){ echo '10%이상 ~ 13%미만'; }else if($auto['au_iyul']=="iyul2"){ echo '13%이상 ~ 16%미만'; }else if($auto['au_iyul']=="iyul3"){ echo '16%이상 ~ 19%미만'; }else if($auto['au_iyul']=="iyul4"){ echo '19%이상 ~ 21%미만'; }?></span></p>
				<table class="mt10">
					<colgroup>
						<col width="20%">
						<col width="26%">
						<col width="26%">
						<col width="26%">
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
							<td><?php if($rec_pay_01=="pay1"){ echo '1000만원 이하'; }else if($rec_pay_01=="pay2"){ echo '1000만원 ~ 5000만원'; }else if($rec_pay_01=="pay3"){ echo '5000만원 ~ 10,000만원'; }else if($rec_pay_01=="pay4"){ echo '10,000만원 ~ 50,000만원'; }else if($rec_pay_01=="pay5"){ echo '50,000만원 이상'; }?></td>
							<td><?php if($rec_pay_01=="pay1"){ echo '1000만원 이하'; }else if($rec_pay_01=="pay2"){ echo '1000만원 ~ 5000만원'; }else if($rec_pay_01=="pay3"){ echo '5000만원 ~ 10,000만원'; }else if($rec_pay_02=="pay4"){ echo '10,000만원 ~ 50,000만원'; }else if($rec_pay_02=="pay5"){ echo '50,000만원 이상'; }?></td>
							<td><?php if($rec_pay_01=="pay1"){ echo '1000만원 이하'; }else if($rec_pay_01=="pay2"){ echo '1000만원 ~ 5000만원'; }else if($rec_pay_01=="pay3"){ echo '5000만원 ~ 10,000만원'; }else if($rec_pay_03=="pay4"){ echo '10,000만원 ~ 50,000만원'; }else if($rec_pay_03=="pay5"){ echo '50,000만원 이상'; }?></td>
						</tr>
						<tr>
							<td>투자기간</td>
							<td><?php if($term_01=="term1"){ echo '3개월 이하'; }else if($term_01=="term2"){ echo '4 ~ 6개월'; }else if($term_01=="term3"){ echo '7 ~ 9개월'; }else if($term_01=="term4"){ echo '10 ~ 12개월'; }else if($term_01=="term5"){ echo '13 ~ 24개월'; }else if($term_01=="term6"){ echo '25개월 이상'; }?></td>
							<td><?php if($term_02=="term1"){ echo '3개월 이하'; }else if($term_02=="term2"){ echo '4 ~ 6개월'; }else if($term_02=="term3"){ echo '7 ~ 9개월'; }else if($term_02=="term4"){ echo '10 ~ 12개월'; }else if($term_02=="term5"){ echo '13 ~ 24개월'; }else if($term_02=="term6"){ echo '25개월 이상'; }?></td>
							<td><?php if($term_03=="term1"){ echo '3개월 이하'; }else if($term_03=="term2"){ echo '4 ~ 6개월'; }else if($term_03=="term3"){ echo '7 ~ 9개월'; }else if($term_03=="term4"){ echo '10 ~ 12개월'; }else if($term_03=="term5"){ echo '13 ~ 24개월'; }else if($term_03=="term6"){ echo '25개월 이상'; }?></td>
						</tr>
						<tr>
							<td>이자지급방식</td>
							<td><?php if($give_way_01=="만기일시상환"){ echo '만기일시상환'; }else if($give_way_01=="원리금균등상환"){ echo '원리금균등상환'; }else if($give_way_01=="기타"){ echo '기타'; }?></td>
							<td><?php if($give_way_02=="만기일시상환"){ echo '만기일시상환'; }else if($give_way_02=="원리금균등상환"){ echo '원리금균등상환'; }else if($give_way_02=="기타"){ echo '기타'; }?></td>
							<td><?php if($give_way_03=="만기일시상환"){ echo '만기일시상환'; }else if($give_way_03=="원리금균등상환"){ echo '원리금균등상환'; }else if($give_way_03=="기타"){ echo '기타'; }?></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<h4><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10">투자유형 설정</h4>
				<table>
					<colgroup>
						<col width="20%">
						<col width="26%">
						<col width="26%">
						<col width="26%">
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
							<td>포트폴리오유형</td>
							<td><?php if($portfolio_01=="S"){ echo '안정형'; }else if($portfolio_01=="D"){ echo '위험중립형'; }else if($portfolio_01=="V"){ echo '적극투자형'; }else if($portfolio_01=="A"){ echo '공격투자형'; }?></td>
							<td><?php if($portfolio_02=="S"){ echo '안정형'; }else if($portfolio_02=="D"){ echo '위험중립형'; }else if($portfolio_02=="V"){ echo '적극투자형'; }else if($portfolio_02=="A"){ echo '공격투자형'; }?></td>
							<td><?php if($portfolio_03=="S"){ echo '안정형'; }else if($portfolio_03=="D"){ echo '위험중립형'; }else if($portfolio_03=="V"){ echo '적극투자형'; }else if($portfolio_03=="A"){ echo '공격투자형'; }?></td>
						</tr>
						<tr>
							<td>자체평가등급</td>
							<td><?php echo $grade_01;?>등급</td>
							<td><?php echo $grade_02;?>등급</td>
							<td><?php echo $grade_03;?>등급</td>
						</tr>
						<tr>
							<td>투자상품</td>
							<td><?php if($product_01=="real"){ echo '부동산담보'; }else if($product_01=="credit"){ echo '신용'; }else if($product_01=="car"){ echo '자동차'; }else if($product_01=="pawn"){ echo '전당포'; }else if($product_01=="npl"){ echo 'NPL'; }else if($product_01=="build"){ echo '자체건축'; }else if($product_01=="guitar"){ echo '기타'; }?></td>
							<td><?php if($product_02=="real"){ echo '부동산담보'; }else if($product_02=="credit"){ echo '신용'; }else if($product_02=="car"){ echo '자동차'; }else if($product_02=="pawn"){ echo '전당포'; }else if($product_02=="npl"){ echo 'NPL'; }else if($product_02=="build"){ echo '자체건축'; }else if($product_02=="guitar"){ echo '기타'; }?></td>
							<td><?php if($product_03=="real"){ echo '부동산담보'; }else if($product_03=="credit"){ echo '신용'; }else if($product_03=="car"){ echo '자동차'; }else if($product_03=="pawn"){ echo '전당포'; }else if($product_03=="npl"){ echo 'NPL'; }else if($product_03=="build"){ echo '자체건축'; }else if($product_03=="guitar"){ echo '기타'; }?></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
 </body>
</html>
