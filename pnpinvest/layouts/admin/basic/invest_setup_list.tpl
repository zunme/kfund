<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->


<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">투자진행 현황</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  투자진행 : <?php echo number_format($total_count) ?>건
		</div>

		<form class="local_sch01 local_sch"   id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="invest_setup_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<!-- <div class="btn_add01 btn_add">
			<a href="#"><img src="img/more_btn.png" alt="추가"></a>
		</div> -->
	<form name="loanlist" id="progresslist" action="{MARI_HOME_URL}/?update=invest_setup_list" onsubmit="return progresslist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>투자진행 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
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
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>관리직원</th>
						<th>제목</th>
						<th>이름</th>
						<th>대출금액</th>
						<th>투자금액</th>
						<th>신용등급</th>
						<th>투자인원</th>
						<th>현재상태</th>
						<th>노출여부</th>
						<th>모집시작일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($j=0; $row=sql_fetch_array($result); $j++) {
	$sql = "select  * from  mari_invest_progress where loan_id='$row[i_id]'";
	$iv = sql_fetch($sql, false);
	/*투자인원 구하기*/
	$sql = " select count(*) as cnt from mari_invest where loan_id='$row[i_id]' order by i_pay desc";
	$incn = sql_fetch($sql, false);
	$invest_cn = $incn['cnt'];
	$sql = " select  * from  mari_category where ca_id='$row[i_payment]'";
	$cate = sql_fetch($sql, false);

	$sql = "select sum(i_pay) from mari_invest where loan_id = '$row[i_id]'";
	$inpay = sql_query($sql, false);
	$order = mysql_result($inpay, 0, 0);
	/*투자참여인원 리스트*/
	$sql="select m_id, m_name, i_pay, i_regdatetime from mari_invest  where loan_id='$row[i_id]' order by i_regdatetime desc"; 
	$play_list=sql_query($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="loan_id[<?php echo $j ?>]" value="<?php echo $row['i_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $j ?>">
						</td>
						<td><?php echo $row['i_id']; ?></td>
						<td><?php if($row['i_loan_type']=="credit"){echo '신용대출';}else{ echo '부동산대출';} ?></td>
						<td><?php echo $row['i_subject']; ?>(<?php if(!$cate['ca_subject']){?>분류없음.<?php }else{?><?php echo $cate['ca_subject'];?><?php }?>)</td>
						<td><?php echo $row['m_name']; ?></td>
						<td>
							<input type="hidden" name="i_loan_pay[<?php echo $j?>]" value="<?php echo $row['i_loan_pay']?>">
							<?php echo number_format($row['i_loan_pay']) ?> 원
						</td>						
						<td><?php if(!$order){ echo '0';}else{echo $order;} ?> 원</td>
						<td><?php echo $iv['i_grade']; ?></td>
						<!--투자인원 10명씩 보이며 스크롤 가능하게 스타일 추가 2016-10-11 박유나-->
						<!--투자인원 td에 .investor 클래스 부여, 투자인원 .td 하위에 div 추가해야 클래스 작동합니다.-->
							<style>
								td.investor>div {    height: 297px;    overflow-y: scroll;}
								td.investor {    padding: 0 !important;}
							</style>
						<!--투자인원 10명씩 보이며 스크롤 가능하게 스타일 추가 2016-10-11 박유나-->
						<td class="investor">
						  <div>
							<table class="type2">
								<colgroup>
									<col width="40px" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>아이디</th>
										<th>회원명</th>
										<th>투자금액</th>
									</tr>
								</thead>
								<tbody>
								<?php
								  for ($i=0; $listrow=sql_fetch_array($play_list); $i++) {
								  $num=$i+1;
								?>
									<tr>
										<td><?php echo $num;?></td>
										<td><?php echo $listrow['m_id'];?></td>
										<td><?php echo $listrow['m_name'];?></td>
										<td><?php echo number_format($listrow['i_pay']) ?> 원</td>
									</tr>
								<?php
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"4\">투자인원이 없습니다.</td></tr>";
								?>
									<tr><td colspan="4"><b><?php echo $invest_cn;?></b>명</td></tr>
								</tbody>
							</table>
						   </div>
						</td>
						<td>
							<?php if($iv['i_look']=="Y"){
									echo '투자진행중';
								}else if($iv['i_look']=="C"){
									echo '투자마감';
								}else if($iv['i_look']=="N"){
									echo '투자대기중';
								}else if($iv['i_look']=="D"){
									echo '상환중';
								}else if($iv['i_look']=="F"){
									echo '상환완료';
								}
							?>
						</td>
						<td><?php echo $iv['i_view']; ?></td>
						<td><?php echo substr($iv['i_invest_sday'],0,10); ?></td>
						<td>
						<?php if(!$iv['loan_id']){?>
						<a href="{MARI_HOME_URL}/?cms=invest_setup_form&type=w&loan_id=<?php echo $row['i_id']; ?>&i_level_dti=<?php echo $row['i_level_dti']; ?>">
						<?php }else{?>
						<a href="{MARI_HOME_URL}/?cms=invest_setup_form&type=m&loan_id=<?php echo $row['i_id']; ?>&i_level_dti=<?php echo $row['i_level_dti']; ?>">
						<?php }?>
						<img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="보기" /></a>
						</td>
					</tr>
    <?php
    }
    if ($j == 0)
        echo "<tr><td colspan=\"".$colspan."\">투자진행 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택취소" class="cancle_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
		<!-- <div class="btn_list01 btn_list">
			<input type="submit" name="" value="" class="select_modi_btn" />
			<input type="submit" name="" value="" class="select_delete_btn" />
		</div> -->
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
	</form>



		<div class="local_desc02">
			<p>
				*보기를 눌러 진행설정을 하실 수 있습니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function progresslist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택취소") {
        if(!confirm("선택한 투자설정 내용을 정말 삭제하시겠습니까? 삭제 후에는 해당 대출의 투자설정의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->