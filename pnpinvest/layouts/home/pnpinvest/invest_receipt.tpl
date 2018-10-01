<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
 <head>
  <title> 쉐어펀드 | 권리증서 </title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/content.css">
<style>
@media print
{

  #test { display:none; }

}
</style>
 </head>
 <body>
   <style>
   img.sign_img {
    width: 75px;
    /* width: 138px; */
    position: absolute;
    right: 10px;
    top: -9px;
}
   </style>
 <input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
 <input type="hidden" name="i_pay" value="<?php echo $i_pay; ?>">
 <input type="hidden" name="i_id" value="<?php echo $i_id;?>">
 <?php
	$sql ="select * from mari_invest_progress where loan_id = '$loan_id'";
	$iv = sql_fetch($sql, false);

	$sql = "select * from mari_loan where i_id = '$loan_id'";
	$loa = sql_fetch($sql, false);
	$sql = "select i_print_no from mari_loan where i_id = '$loan_id'";
	$find_cnt = sql_fetch($sql, false);

 ?>	<form name="invest_print" method="post" enctype="multipart/form-data">
	<div id="print2"><!--프린트영역-->
	<div id="test" style="width:100%; height:85px; background:rgba(0,0,0,0.2); position:absolute; top:0; right:0; ">
	<a href="javascript:void(0);" onclick="window.print();" class="print"><img src="{MARI_HOMESKIN_URL}/img/btn_print.png" alt="출력" /></a>
	</div>
	<div class="receipt" style="background:url('{MARI_HOMESKIN_URL}/img/bg_receipt.png') no-repeat;">
		<p>증서번호 <span style="margin-left:30px; ">제<?php echo substr($date, 0, 4)?> - 담보 - <?php echo $loan_id; ?></span></p>
		<h1 class="receipt_title">원리금 수취권 증서</h1>
		<table class="receipt_1">
			<colgroup>
				<col width="165px">
				<col width="">
			</colgroup>
			<tr>
				<th>우&nbsp;&nbsp;선&nbsp;&nbsp;수&nbsp;&nbsp;익&nbsp;&nbsp;자</th>
				<td><?php echo $user['m_name']?></td>
			</tr>
		</table>
		<table class="receipt_2">
			<colgroup>
				<col width="150px">
				<col width="210px">
				<col width="150px">
				<col width="">
			</colgroup>
			<tr>
				<th>수&nbsp;&nbsp;&nbsp;&nbsp;익&nbsp;&nbsp;&nbsp;&nbsp;금&nbsp;&nbsp;&nbsp;&nbsp;액</th>
				<td colspan="3"><?php echo number_format($i_pay);?>원</td>
			</tr>
			<tr>
				<th>상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;품&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</th>
				<td colspan="3" style="text-align:left; padding:10px 20px;"><p style="white-space:nowrap; text-overflow:ellipsis; overflow:hidden; font-weight:normal; font-size:15px; "><?php echo $loa['i_subject']; ?></p></td>
			</tr>
			<tr>
				<th>채&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;권&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</th>
				<td colspan=3>(주)케이크라우드대부</td>
			</tr>
			<tr>
				<th>투&nbsp;&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;&nbsp;금&nbsp;&nbsp;&nbsp;&nbsp;액</th>
				<td><?php echo number_format($i_pay);?>원</td>
				<th>투&nbsp;&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;&nbsp;금&nbsp;&nbsp;&nbsp;&nbsp;리</th>
				<td><?php echo $loa['i_year_plus']; ?>%</td>
			</tr>
			<tr>
				<th>투&nbsp;&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;&nbsp;레&nbsp;&nbsp;&nbsp;&nbsp;벨</th>
				<td><?php echo $iv['i_grade']; ?></td>
				<th>상&nbsp;&nbsp;&nbsp;&nbsp;환&nbsp;&nbsp;&nbsp;&nbsp;방&nbsp;&nbsp;&nbsp;&nbsp;법</th>
				<td><?php echo $loa['i_repay']; ?></td>
			</tr>
			<tr>
				<th>투&nbsp;&nbsp;자&nbsp;&nbsp;만&nbsp;&nbsp;기&nbsp;&nbsp;일</th>
				<td><?php echo date("Y-m-d", strtotime(substr($iv['i_invest_eday'],0,10)."+".$loa['i_loan_day']."month"))?></td>
				<th>대&nbsp;&nbsp;출&nbsp;&nbsp;실&nbsp;&nbsp;행&nbsp;&nbsp;일</th>
				<td><?php echo substr($loa['i_loanexecutiondate'],0,10);?></td>
			</tr>
			<tr>
				<th>수&nbsp;익&nbsp;권&nbsp;발&nbsp;행&nbsp;자</th>
				<td colspan="3">(주)케이크라우드대부</td>
			</tr>
			<tr>
				<th>수&nbsp;익&nbsp;권&nbsp;판&nbsp;매&nbsp;자</th>
				<td colspan="3">(주)케이펀딩</td>
			</tr>
		</table>
		<div class="receipt_sign">
			<p class="mt100 mb30">원리금 수취권 계약에 의하여 본 증서를 발행합니다.</p>
			<p class="mb10"><?php echo substr($date, 0, 4); ?>년 <?php echo substr($date, 5, 2);?>월 <?php echo substr($date, 8, 2)?>일</p>
			<p class="mb10">주식회사 케이크라우드대부 <img class="sign_img" src="{MARI_HOMESKIN_URL}/img/share2.png" alt="sign" /><!--<img class="sign_img02" src="{MARI_HOMESKIN_URL}/img/sodi.png" alt="sign" />--></p>
		</div>
	</div>
	</div><!--프린트-->
	</form>
 </body>
</html>

<!---<script type="text/javascript">
	function prt() {




		var initBody = document.body.innerHTML;

		window.onbeforeprint = function () {




			document.body.innerHTML = document.getElementById("print2").innerHTML;

		}

		window.onafterprint = function () {




			document.body.innerHTML = initBody;




		}

		window.print();


	}
</script>-->
