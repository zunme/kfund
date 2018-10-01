<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 메인중앙
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">정산스케쥴 관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">정산스케쥴 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 건수 : <?php echo number_format($total_count) ?> 건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="<?php echo $cms;?>">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="r_subject"<?php echo get_selected($_GET['sfl'], "r_subject"); ?>>상품명</option>
				<option value="r_count"<?php echo get_selected($_GET['sfl'], "r_count"); ?>>회차</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<h2 class="h2_frm mt20"><span>정산스케쥴 등록내역</span></h2>
	<form name="schedulelist" id="schedulelist" action="{MARI_HOME_URL}/?update=repay_schedule_form" onsubmit="return schedulelist_submit(this);" method="post">
	<input type="hidden" name="type" value="d">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>정산스케쥴 목록</caption>
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
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>정산일자</th>
						<th>상품명</th>
						<th>회차</th>
						<th>등록아이피주소</th>
						<th>등록일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	$sql = "select  * from  mari_loan where i_id='$row[loan_id]'";
	$loan = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="r_id[<?php echo $i ?>]" value="<?php echo $row['r_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['r_orderdate']; ?></td>
						<td><?php echo $loan['i_subject']; ?>[<?php echo $row['r_view'] == "Y"?"노출":"미노출" ?>]</td>
						<td><?php echo $row['r_count']; ?></td>
						<td><?php echo $row['r_ip']; ?></td>
						<td><?php echo substr($row['r_regdatetime'],0,10); ?></td>
						<td><?php echo $row['r_salestatus']; ?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=7>정산스케쥴 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&sfl='.$sfl.'&stx='.$stx.'&amp;page='); ?>
		</div><!-- /paging -->
		<div class="btn_list01 btn_list">
		<?php if($user[m_level]>=10){?>
			<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
		<?php }?>
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
	</form>
		<h2 class="h2_frm mt20"><span>스케쥴 입력</span></h2>
<form name="schedule_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="w">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">상품선택</th>
						<td>
							<select name="loan_id">
								<option>상품을 선택하세요</option>
								<?php
								    for ($i=0; $row=sql_fetch_array($myloanlist); $i++) {
								?>
								<option value="<?php echo $row['i_id']; ?>"><?php echo $row['i_subject'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">회차선택</th>
						<td>
    							<select name="r_count">
								<option>회차를 선택하세요</option>
								<?php
								    for($i=1;$i<=36;$i++){
								?>
								<option value="<?php echo $i;?>"><?php echo $i;?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">노출여부</th>
						<td>
						<select name="r_view">
								<option>노출여부를 선택하세요</option>
								<option value="Y">노출</option>
								<option value="N">미노출</option>
						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">상태선택</th>
						<td>
						<select name="r_salestatus">
								<option>상태를 선택하세요</option>
								<option value="상환예정">상환예정</option>
								<option value="정산완료">정산완료</option>
								<option value="연체중">연체중</option>
						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">정산일 설정</th>
						<td>
							<input type="text" name="r_orderdate"  id=""  class="frm_input calendar" size="" class="mr5" />
						</td>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" id="schedule_form_add" title="확인"  />
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
function schedulelist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}


/*필수체크*/
$(function() {
	$('#schedule_form_add').click(function(){
		Schedule_form_Ok(document.schedule_form);
	});
});


function Schedule_form_Ok(f)
{

	if(f.loan_id[0].selected == true){alert('\n상품을 선택하여 주십시오.');return false;}
	if(f.r_count[0].selected == true){alert('\n회차를 선택하여 주십시오.');return false;}
	if(f.r_view[0].selected == true){alert('\n노출여부를 선택하여 주십시오.');return false;}
	if(f.r_salestatus[0].selected == true){alert('\n현재상태를 선택하여 주십시오.');return false;}
	if(!f.r_orderdate.value){alert('\n정산일정을 입력하여 주십시오.');f.r_orderdate.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=repay_schedule_form';
	f.submit();
}

/*엑셀다운로드*/

function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>&sfl=<?php echo $sfl?>&stx=<?php echo $stx?>'; 
}


$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });
</script>



{# s_footer}<!--하단-->







