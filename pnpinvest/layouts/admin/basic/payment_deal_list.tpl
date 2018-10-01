<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script src="{MARI_PLUGIN_URL}/chart/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/serial.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/pie.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/light.js" type="text/javascript"></script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">회계관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->


	<div id="container">
		<div class="title02">전자결제거래내역</div>
		<div class="local_ov01 local_ov">
			<a href="{MARI_HOME_URL}/?cms=payment_deal_list" class="ov_listall">전체목록</a>
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get" onsubmit="return checksearch()">
		<input type="hidden" name="cms" value="payment_deal_list">
		<input type="hidden" name="sh" value="Y">
			<label for="" class="sound_only">검색대상</label>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<!--<span class="fb" style="display:inline;">투자자 :</span>-->
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>아이디</option>
			</select>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id=""  class=" frm_input">

			<span class="fb" style="display:inline;">대출번호 :</span>
			<input type="text" name="slid" value="<?php echo $slid?>" id="" class="frm_input">

			<span class="fb" style="display:inline;">거래번호 :</span>
			<input type="text" name="stid" value="<?php echo $stid?>" id="" class="frm_input">

			<span class="fb" style="display:inline;">주문번호 :</span>
			<input type="text" name="srefid" value="<?php echo $srefid?>" id="" class="frm_input">

			<span class="fb" style="display:inline;">타입 :</span>
			<select name="stype">
				<option value=""<?php echo get_selected($_GET['stype'], ""); ?>>선택안함</option>
				<option value="1"<?php echo get_selected($_GET['stype'], "1"); ?>>투자출금</option>
				<option value="2"<?php echo get_selected($_GET['stype'], "2"); ?>>잔액출금</option>
				<option value="3"<?php echo get_selected($_GET['stype'], "3"); ?>>계좌주검증</option>
				<option value="4"<?php echo get_selected($_GET['stype'], "4"); ?>>입금</option>
			</select>

			<span class="fb" style="display:inline;">조회 기간 :</span>
			<input type="text" name="s_date" value="<?php echo $s_date ?>" id="s_date" class="frm_input calendar" size="15" maxlength="10">
		~
			<input type="text" name="e_date" value="<?php echo $e_date ?>" id="e_date" class="frm_input calendar" size="15" maxlength="10">
			<input type="radio" name="date_m" value="date_today" <?php echo $date_m=="date_today"?'checked':'';?>/> <label for="">당일</label>
			<input type="radio" name="date_m" value="date_month" <?php echo $date_m=="date_month"?'checked':'';?>/> <label for="">당월</label>
			<input type="radio" name="date_m" value="date_lastmonth" <?php echo $date_m=="date_lastmonth"?'checked':'';?>/> <label for="">전월</label>
			<input type="radio" name="date_m" value="" <?php echo !$date_m?'checked':'';?>/> <label for="">선택안함</label>
			<input type="submit" class="search_btn" value="">

		</form>

		<div class="tbl_head01 tbl_wrap mt20">
			<table class="txt_c">
				<caption></caption>
				<colgroup>
					<col width="70px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>대출번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>입찰금액</th>
						<th>거래메세지</th>
						<th>거래번호</th>
						<th>주문번호</th>
						<th>접수일자</th>
						<th>결제동의</th>
						<th>타입</th>
						<th>펀딩해제</th>
						<th>투자취소여부</th>
						<th>거래종류</th>
						<th>거래상태</th>
					</tr>
				</thead>
				<tbody>
				<?php
					for ($i=0; $orders_list=sql_fetch_array($order_w); $i++) {
						$sql = "select s_accntNo from mari_seyfert where m_id='".$orders_list['m_id']."'";
						$virtual_accnt = sql_fetch($sql);
				?>		
					<tr>
						<td><?php echo $orders_list['s_id']?></td>
						<td><?php echo $orders_list['loan_id']?$orders_list['loan_id']:'없음'?></td>
						<td><?php echo $orders_list['m_id']?></br>
							가상계좌 : <?php echo $virtual_accnt['s_accntNo']?>
						</td>
						<td><?php echo $orders_list['m_name']?></td>
						<td><?php echo number_format($orders_list['s_amount'])?>원</td>
						<td><?php echo $orders_list['s_subject']?></td>
						<td><?php echo $orders_list['s_tid']?$orders_list['s_tid']:'-'?></td>
						<td><?php echo $orders_list['s_refId']?$orders_list['s_refId']:'-'?></td>
						<td><?php echo substr($orders_list['s_date'],0,10)?></td>
						<td><?php if($orders_list['s_payuse']=='N'){?> 
								N
							<?}else if($orders_list['s_payuse']=='Y'){?>
								Y
							<?}else if($orders_list['s_payuse']=='D'){?>
								결제취소
							<?}?>
						</td>
						<td><?php if($orders_list['s_type']=='1'){?>
								투자출금
							<?}else if($orders_list['s_type']=='2'){?>
								잔액출금
							<?}else if($orders_list['s_type']=='3'){?>
								계좌주검증
							<?}else if($orders_list['s_type']=='4'){?>
								입금
							<?}?>
						</td>
						<td><?php if($orders_list['s_release']=='N'){?>
								N
							<?}else if($orders_list['s_release']=='Y'){?>
								Y
							<?}?>
						</td>
						<td><?php if($orders_list['o_funding_cancel']=="N"){?>
								N
							<?}else if($orders_list['o_funding_cancel']=="Y"){?>
								Y
							<?}?>
						</td>
						<td><?php echo $orders_list['trnsctnTp']?></td>
						<td><?php echo $orders_list['trnsctnSt']?></td>
					</tr>
				<?php
				
				   }
				   if ($i == 0)
				      echo "<tr><td colspan=\"18\">전자결재거래내역이 없습니다.</td></tr>";
				?>
				</tbody>
			</table>
			<?php if($user[m_level]>=10){?>
				<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
			<?php }?>
		</div>

		<div class="paging">
<!--페이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&stx='.$stx.'&s_date='.$s_date.'&e_date='.$e_date.'&date_m='.$date_m.'&cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->

		<div class="local_desc02">
			<p>
				1. 기본적으로 최근기준 31개의 리스트가 보여집니다.<br />
				2. 상단 검색을통해 이름, 아이디, 대출번호, 거래번호, 주문번호, 타입, 조회기간, 당일, 당월, 전월등으로 검색하실 수 있습니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>


$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });

 function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>'; 
}

function checksearch(){
	var f = document.fsearch;

//	if(!f.stx.value){
//		if(f.sfl[0].selected==true){
//			alert('\n이름을 입력해주세요.'); f.stx.focus(); return false;
//		}else if(f.sfl[1].selected==true){
//			alert('\n아이디를 입력해주세요.'); f.stx.focus(); return false;
//		}
//	}

}
</script>
{# s_footer}<!--하단-->