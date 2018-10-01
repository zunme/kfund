
<!DOCTYPE html><!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 머니플러스 Ver 1.1.1
┗━━━━━━━━━━━━━━━━━━━━━━━┛
//-->
<html lang="ko">
<head>
<title>엔젤펀딩파트너스</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link rel="SHORTCUT ICON" href="/pnpinvest/data/favicon/pnpinvest_logo.png">
<meta name="keywords" content="엔젤펀딩, 피앤피, p2p 대출솔루션, 대출솔루션, p2p투자, p2p펀딩, 일반대출, 담보대출, 웹 솔루션, 대출p2p, 크라우드펀딩, 엔젤투자, p2p금융솔루션, 대출p2p솔루션, 크라우드펀딩 솔루션, 핀테크 솔루션, 대출 중계솔루션, p2p 대출중개, 소자본창업, 대부업, 금융운영, 머니플러스, 머니플러스 솔루션" ><!--HTML 상단 검색 키워드소스 content=""-->
<meta name="description" content="부동산전문 P2P대출기업, 중저금리대출, 건축자금및신용대출전문, P2P투자전문" ><!--HTML 상단 검색설명소스 content=""-->

<meta property="og:type" content="http://www.fundingangel.co.kr/">
<meta property="og:title" content="엔젤펀딩">
<meta property="og:description" content="부동산전문 P2P대출기업, 중저금리대출, 건축자금및신용대출전문, P2P투자전문">
<meta property="og:image" content="http://pnpinvest.esmfintech.co.kr/pnpinvest/layouts/home/pnpinvest/img/pnpinvest_logo.png">
<meta property="og:url" content="http://fundingangel.co.kr/">
<link rel="canonical" href="http://fundingangel.co.kr/">
<meta name="google-site-verification" content="wFlJBNsJ9EcCuDtiz8gnIcdhqess5G-zrN6iGCyLbqs" />
</head>
<body    >
<link rel="stylesheet" type="text/css" href="/pnpinvest/layouts/home/pnpinvest/css/common.css">
<link rel="stylesheet" type="text/css" href="/pnpinvest/layouts/home/pnpinvest/css/content.css">
<link rel="stylesheet" type="text/css" href="/pnpinvest/layouts/home/pnpinvest/css/style.css">
<script type="text/javascript" src="/pnpinvest/layouts/home/pnpinvest/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/pnpinvest/layouts/home/pnpinvest/js/javascript.js"></script>
<style>
.numbering2{font-size:16px;}
table.type13 td {text-align:right;padding-right: 15px;}
</style>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});
</script>

	<div class="terms_wrap">
		<div class="terms_logo"><img src="/pnpinvest/data/favicon/블루텍스트dd로고.png" alt="엔젤펀딩파트너스"/></div>
		<table class="type13 mb20">
			<colgroup>
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
				<col width="75px" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th>투자금액</th>
					<td><?php echo number_format($total) ?>원</td>
					<th>상환기간</th>
					<td><?php echo $loaninfo['gigan']  ?>개월</td>
					<th>금리</th>
					<td><?php echo $loaninfo['iyul']  ?>% </td>
					<th>상환방식</th>
					<td><?php echo $loaninfo['method']  ?></td>
				</tr>
			</tbody>
		</table>
		<!-- <h4 class="invest_title5">투자금액 : 0원 상환기간 : 개월 금리 : % 상환 방식 : </h4> -->
		<table class="type13">
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th>회차</th>
					<th>수익금</th>
					<th>납입원금</th>
					<th>이자</th>
					<th>납입원금계</th>
					<th>잔금</th>
				</tr>
			</thead>
			<tbody>
        <?php
        $totalija = 0;
        foreach( $timetable as $idx=>$row){
          $totalija += $row['ija'];
          ?>
				<tr>
					<td style="text-align:center"><?php echo $idx+1?>회차<br>( <?php echo $row['holiday']?> <?php echo (( $row['completed']=='Y') ? "정산완료":"정산예정")?>)</td>
					<td><?php echo number_format($row['wongum'] + $row['ija']) ?> 원</td>
					<td><?php echo number_format($row['wongum']) ?> 원</td>
					<td><?php echo number_format($row['ija']) ?> 원</td>
					<td><?php echo number_format($total - $row['remain']) ?> 원</td>
					<td><?php echo number_format($row['remain']) ?> 원</td>
				</tr>
        <?php } ?>
        <tr>
          <td>계</td>
          <td><?php echo number_format($total+$totalija) ?> 원</td>
          <td><?php echo number_format($total) ?> 원</td>
          <td><?php echo number_format($totalija) ?> 원</td>
          <td></td>
          <td></td>
        </tr>
			</tbody>
		</table>
    <div style="padding:15px;font-size:13px;">
			<p>* 원금균등상환 및 원리금균등상환의 납입원금 및 이자금액은 정산금액과 상이할 수 있습니다.</p><p style="padding:10px;">이 점 양해바랍니다.</p>
			</div>

	</div>


</body>
</html>
