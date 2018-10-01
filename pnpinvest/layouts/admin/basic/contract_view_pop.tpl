<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
	
<div class="contract_wrap">
	<h4 class="my_title6"><img src="{MARI_ADMINSKIN_URL}/img/contract_top3_img.jpg"></h4>
		<div class="number_wrap">
		<div class="number">
			<table class="ct1">
				<colgroup>
					<col width="100px" />
					<col width="px" />
					<col width="100px" />
				</colgroup>
				<tbody>
					<tr>
						<th>고객번호</th>
						<td></td>
						<th>계약번호</th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		</div>
	<p class="p_txt9 mt35">본인(연대보증인)은 본 대부거래계약을 체결함에 있어 대부거래표준약관(별첨)이 적용됨을 승낙하고 아래와 같이 그 중요 사항을 기입한다.</p>
	<table class="ct1 mb25 mt10">
		<colgroup>
			<col width="15px" />
			<col width="130px" />
			<col width="px" />
			<col width="95px" />
			<col width="140px" />
			<col width="130px" />
			<col width="px" />
		</colgroup>
		<tbody>
			<tr>
				<th rowspan="3">채무자</th>
				<th>성명</th>
				<td colspan="5"><span>홍길동</span> (인/서명) </td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td></td>
				<th>성별</th>
				<td></td>
				<th>전화번호</th>
				<td></td>
			</tr>
			<tr>
				<th>자택주소</th>
				<td colspan="5"></td>
			</tr>
		</tbody>
	</table>
	<table class="ct1">
		<colgroup>
			<col width="173px" />
			<col width="px" />
			<col width="165px" />
			<col width="px" />
		</colgroup>
		<tbody>
			<tr>
				<th>대부금액</th>
				<td colspan="3"><label for="">금 <span class="money"> </span>원 정 (\ <span class="money"></span>) </td>
			</tr>
			<tr>
				<th>이자율</th>
				<td>연 <span></span>%</td>
				<th>연체이자율</th>
				<td>연 <span ></span>%</td>
			</tr>
			<tr>
				<th>계약일자</th>
				<td><span class="date"></span>년 <span class="date"></span>월 <span class="date"></span>일 </td>
				<th>계약만료일</th>
				<td><span class="date"></span>년 <span class="date"></span>월 <span class="date"></span>일</td>
			</tr>
			
		</tbody>
	</table>
	<p class="p_txt6 mb10">※법정 최고이율 연 34.9% (단, 2014년 4월 2일부터 체결되거나 갱신되는 대부계약부터 적용)</p>

	<table class="ct1 mb25">
		<colgroup>
			<col width="15px" />
			<col width="130px" />
			<col width="255px" />
			<col width="100px" />
			<col width="" />
			<col width="130px" />
			<col width="px" />
		</colgroup>
		<tbody>
			
			<tr>
				<th rowspan="6">연대보증인</th>
				<th>성명</th>
				<td colspan="5"><span>홍길동</span>(인/서명)</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td class="birth"></td>
				<th class="gender">성별</th>
				<td></td>
				<th class="tel">전화번호</th>
				<td ></td>
			</tr>
			<tr>
				<th>자택주소</th>
				<td colspan="5"></td>
			</tr>
			<tr>
				<th rowspan="3">피보증<br>채무내용 <br/>(보증기간)</th>
				<th rowspan="2">피보증채무금액</th>
				<td rowspan="2" colspan="2">금 <span class="money"> </span>원 정 <br/><br/>(\ <span class="money"></span>) </td>
				<th>피보증의 <br/>범위</th>
				<td ></td>
				
			</tr>
			<tr>
				<th>특약사항</th>
				<td ></td>
			</tr>
			<tr>
				<th>보증일자</th>
				<td colspan="2"><span class="date"></span>년 <span class="date"></span>월 <span class="date"></span>일</td>
				<th>보증만료일</th>
				<td ><span class="date"></span>년 <span class="date"></span>월 <span class="date"></span>일</td>
			</tr>
		</tbody>
	</table>
	<p class="p_txt8 mt20">※대부기본조건</p>
	<table class="ct1 mb50">
		<colgroup>
			<col width="175px" />
			<col width="155px" />
			<col width="345px" />
			<col width="165px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th>이자계산방법</th>
				<td  class="txt_8" colspan="5">통상 이자 및 연체 이자는 1년을 365일로 보고, 1일 단위로 계산함<br/>
				(대부금잔액 × 이자율 ÷ 365 × 경과일수 (대부 익일부터 변제일까지 계산))</td>
			</tr>
			<tr>
				<th rowspan="3">변제기간 <br/>및<br/> 상환방법</th>
				<th>대부금 상환계좌</th>
				<td colspan="4">우리은행 예금주 : 골든캐피탈 대부 / 채무자의 가상계좌 (<span></span>)
			</tr>
			<tr>
				<th>대부금 상환순서</th>
				<td colspan="4">1. 대부금의 상환 및 이자의 지급은 은행송금(채권자 입금계좌) 등 <br/>&nbsp;&nbsp;&nbsp;&nbsp;당사자가 약정한 방법에 의한다.<br/>
				2. 대부금의 상환 및 이자의 지급은 비용, 이자, 원금순으로 충당한다.</td>
			</tr>
			<tr>
				<th colspan="2"><input type="checkbox" />원리금균등 <span class="date"></span>개월 &nbsp;&nbsp;<input type="checkbox" /> 만기 일시상환 <span class="date"></span>개월 </th>
				<th>약정일</th>
				<td>매월 <span class="date_2"></span>일</td>
			</tr>
			<tr>
				<th>조기상환조건</th>
				<td colspan="5">채무자는 계약기간 중 언제든지 일체의 중도상환수수료 없이 대부금 전액을 상환할 수 있다.</td>
			</tr>
			<tr>
				<th rowspan="4">부대비용</th>
				<td colspan="5">취급 수수료 및 조기상환 수수료 등 채무자가 부담하는 비용 일체 없음.</td>
			</tr>
			<tr>
				<th>채무증명서 <br/>발급비용</th>
				<td class="txt_8">없음</td>
				<th>채무 및 보증채무 <br/>증명서 발급기한</th>
				<td class="txt_8">영업일 7일 이내 <br/>(채무자 요청일 포함)</td>
			</tr>
		</tbody>
	</table>

	<p class="p_txt7">※채무자(연대보증인)는 다음 사항을 읽고 본인의 의사를 사실에 근거하여 자필로 기재하여 주십시오. <br/>(기재예시 : 1. 수령함, 2. 들었음, 3. 들었음)</p>
	<table class="ct2 mb25 mt10">
		<colgroup>
			<col width="700px" />
			<col width="px" />
		</colgroup>
		<tbody>
			
			<tr>
				<th>1. 위 계약서 및 대부거래 표준약관을 확실히 수령하였습니까?</th>
				<td></td>
			</tr>
			<tr>
				<th>2. 위 계약서 및 대부거래 표준약관의 중요한 내용에 대하여 설명을 들었습니까?</th>
				<td></td>
			</tr>
			<tr>
				<th>3. 중개수수료를 채무자로부터 받은 것이 불법이라는 설명을 들었습니까?</th>
				<td> </td>
			</tr>
		</tbody>
	</table>
	<div class="ct_sign">
		<table class="ct3 mb10">
			<colgroup>
				<col width="200px" />
				<col width="200px" />
				<col width="400px" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="2">채무자</th>
					<th>성명</th>
					<td><span></span>(인/서명)</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="contract1">
	<p class="p_txt7">※채권의 양도 및 담보제공에 관한 승낙서</p>
	<table class="ct4 mb25 mt10">
		<colgroup>
			<col width="450px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
		</colgroup>
		<tbody>
			
			<tr>
				<td  class="cont_txt" rowspan="6">본인은 오늘 귀사와 체결한 대부거래약정 (이하"대부거래약정"이라 함)에 따라 신청한 대부금의 차입자로서,
				대부거래 표준약관 제17조에 따라, 귀사가 대부거래약정에 따라 본인에 대하여 가지거나 가지게 될 현재 및
				장래의 일체의 권리("양도대상채권")를 금융기관 또는 기타 제3자("담보권자 또는 채권양수인")에게 귀사의
				자금조달을 위한 양도담보로 제공하거나 기타 목적을 위하여 채권을 양도함에 동의합니다. 귀사는 본인에
				대한 별도의 통지나 승낙 없이 담보권자 또는 채권양수인으로부터 양도대상채권을 반환 받을 수 있으며 그 후
				다시 다른 제3자에게 양도하거나 양도담보로 제공할 수 있음에 동의합니다. 이와 관련하여 귀사가 본인의
				개인정보를 위 담보권자 또는 채권양수인에게 제공하여 귀사의 자금조달기간동안 담보목적으로 활용하거나
				채권양도의 목적으로 활용할 수 있도록 하는데 대하여도 신용정보 이용 및 보호에 관한 법률 제32조 및 정보
				통신망 이용촉진 및 정보보호 등에 관한 법률 제24조의2 등 모든 관련 법령에 따라 동의합니다. 다만 위 양도
				담보제공 또는 채권양도에도 불구하고 담보권자 또는 채권양수인이 본인에 대하여 별도로 통지(인터넷 통지 포함)를
				하기 전까지는 본인은 대부거래약정에 따라 지급하여야 할 모든 금액을 귀사명의의 계좌로 지급하며
				추후 담보권자 또는 채권양수인으로부터 본인에 대한 별도 통지를 받은 후에만 담보권자 또는 채권양수인이
				별도로 지정하는 계좌로 지급하겠습니다.</td>
			
				<th colspan="4">채권양도(담보제공)의 주요내용</th>
			
			<tr>
				<th>대부계약일</th>
				<td></td>
				<th>대부만기일</th>
				<td></td>
			</tr>
			<tr>
				<th>채무자</th>
				<td></td>
				<th>이자율</th>
				<td></td>
			</tr>
			<tr>
				<th>대부한도액</th>
				<td></td>
				<th>연체이자율</th>
				<td></td>
			</tr>
			<tr>
				<th>최초한도금액 <br/>(대부실행금액)</th>
				<td></td>
				<th>채권양도 <br/>(담보제공)금액</th>
				<td></td>
			</tr>
			<tr>
				<th>채권양수인 <br/>(양도담보권자)</th>
				<td></td>
				<th>채권양도<br/>(담보제공)일</th>
				<td></td>
			</tr>
		</tbody>
	</table>
	</div>
	<div class="ct_sign">
		<table class="ct3">
			<colgroup>
				<col width="200px" />
				<col width="200px" />
				<col width="400px" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="2">채무자</th>
					<th>성명</th>
					<td><span></span>(인/서명)</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td></td>
				</tr>
			</tbody>
	</div>
	<p class="p_txt7">※과도한 빚은 고통의 시작입니다.</p>
</div><!-- /contract_wrap -->