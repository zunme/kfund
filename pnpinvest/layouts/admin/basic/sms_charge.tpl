<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN sms 충전
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">SMS관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">SMS 충전</div>

		<div class="local_desc01 local_desc">
			<p>
				무통장/계좌이체 결제시 부가세는 별도입니다.
			</p>
		</div>

		<div class="tbl_head02 tbl_wrap">
			<table class="txt_c">
				<caption>회원관리 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2">선택</th>
						<th rowspan="2">결제금액</th>
						<th colspan="2">무통장/계좌이체요금</th>
						<th colspan="2">신용카드 결제</th>
					</tr>
					<tr>
						<th>건수</th>
						<th>단가</th>
						<th>건수</th>
						<th>단가</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>5,000원</td>
						<td>208건</td>
						<td>24원</td>
						<td>201건</td>
						<td>24.9원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>10,000원</td>
						<td>500건</td>
						<td>20원</td>
						<td>483건</td>
						<td>20.7원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>30,000원</td>
						<td>1,578건</td>
						<td>19원</td>
						<td>1,523건</td>
						<td>19.7원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>50,000원</td>
						<td>2,777건</td>
						<td>18원</td>
						<td>2,680건</td>
						<td>18.7원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>100,000원</td>
						<td>6,250건</td>
						<td>16원</td>
						<td>6,031건</td>
						<td>16.6원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>200,000원</td>
						<td>12,500건</td>
						<td>16원</td>
						<td>12,063건</td>
						<td>16.6원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>300,000원</td>
						<td>20,000건</td>
						<td>15원</td>
						<td>19,300건</td>
						<td>15.5원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>500,000원</td>
						<td>35,714 건</td>
						<td>14원</td>
						<td>34,464건</td>
						<td>14.5원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>1,000,000원</td>
						<td>74,074건</td>
						<td>13.5원</td>
						<td>71,481 건</td>
						<td>14원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>1,250,000 원</td>
						<td>100,000건</td>
						<td>12.5원</td>
						<td>96,500건</td>
						<td>13원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>3,600,000 원</td>
						<td>300,000건</td>
						<td>12원</td>
						<td>289,500 건</td>
						<td>12.4원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>5,750,000 원</td>
						<td>500,000 건</td>
						<td>11원</td>
						<td>482,500건</td>
						<td>11.5원</td>
					</tr>
					<tr>
						<td><input type="radio" id="" name="" value="" /></td>
						<td>10,000,000원 이상</td>
						<td colspan="2">별도협의</td>
						<td colspan="2">별도협의</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm mt10">
			<input type="image" src="{MARI_ADMINSKIN_URL}/img/charge_btn.png" alt="충전하기" />
			<input type="image" src="{MARI_ADMINSKIN_URL}/img/cancel_btn.png" alt="취소"  class="ml5" />
		</div>
		 
    </div><!-- /contaner -->
</div><!-- /wrapper -->

{# s_footer}<!--하단-->