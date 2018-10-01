<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include (getcwd().'/module/cms_loan_list.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/css/iziModal.min.css" >
<script src="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/js/iziModal.min.js" type="text/javascript"></script>

<style>
i.fa {font-size: 15px;margin-left: 10px;color:#419D46}
i.isparent {color:#0D96CC}
i.islinked {color:#E67229}

</style>

<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02">대출접수 현황</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  대출접수 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="loan_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>


		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=loan_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"></a>
		</div>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=loan_list" onsubmit="return loanlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>대출접수 목록</caption>
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
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>대출상품</th>
						<th>대출방식</th>
						<th>이름</th>
						<th>제목</th>
						<th>대출금액</th>
						<th>대출기간</th>
						<th>연이자율</th>
						<th>입금내역</th>
						<th>접수일자</th>
						<th>연체일수</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($j=0; $row=sql_fetch_array($result); $j++) {
	$sql = "select  * from  mari_order where  user_id='$row[m_id]' and loan_id='$row[i_id]' group by o_count order by o_count asc, o_datetime desc";
	$order = sql_query($sql, false);
	/*연체횟수 회차중복제외구하기(합계)*/
	$sql="select sum(distinct(o_odinterestcount)) from mari_order where loan_id='$row[i_id]' and user_id='$row[m_id]' and o_status='연체' ";
	$odinterestcount=sql_query($sql, false);
	$t_odinterestcount = mysql_result($odinterestcount, 0, 0);
	$sql = " select  * from  mari_category where ca_id='$row[i_payment]'";
	$cate = sql_fetch($sql, false);

    ?>
					<tr>
						<td>
						<input type="hidden" name="i_id[<?php echo $j; ?>]" value="<?php echo $row['i_id']; ?>">
						<input type="checkbox" name="check[]" value="<?php echo $j;?>">
						</td>
						<td><?php echo $row['i_id']; ?></td>
						<td><?php if(!$cate['ca_subject']){?>분류없음.<?php }else{?><?php echo $cate['ca_subject'];?><?php }?></td>
						<td><?php if($row['i_loan_type']=="credit"){echo '신용대출';}else{ echo '부동산대출';} ?></td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo $row['i_subject']; ?>
							<?PHP
							 if ($row['parentid']>0) { ?><i class="fa fa-link islinked triggerModal" href="/api/index.php/cmsloanlist/getsameowner?lid=<?php echo $row['i_id'];?>" aria-hidden="true" title="[<?php echo $row['parent_subject'];?>] 동일차주로 묶인 상품입니다."></i><?php }
							 else if ($row['selfparent']>0) { ?><i class="fa fa-link isparent triggerModal" href="/api/index.php/cmsloanlist/getsameowner?lid=<?php echo $row['i_id'];?>" aria-hidden="true" title="동일차주상품입니다."></i><?php }
							 else { ?> <i class="fa fa-chain-broken triggerModal" href="/api/index.php/cmsloanlist/getsameowner?lid=<?php echo $row['i_id'];?>" aria-hidden="true" title="동일 차주로 묶이지 않았습니다."></i> <?php }
							?>
						</td>
						<td><?php echo number_format($row['i_loan_pay']) ?> 원</td>
						<td><?php echo $row['i_loan_day']; ?>개월</td>
						<td><?php echo $row['i_year_plus']; ?>%</td>
						<td>

							<table class="type2" style="">
								<colgroup>
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>상태</th>
										<th>회차</th>
									</tr>
								</thead>
								<tbody>
								<?php for ($i=0; $count_list=sql_fetch_array($order); $i++) {?>
									<tr>
										<td><?php if($count_list[o_status]=="연체"){?><span style="color:#FF0000;"><?php echo $count_list[o_status];?></span><?php }else{?><?php echo $count_list[o_status];?><?php }?></td>
										<td><?php echo $count_list[o_count];?>회차</td>
									</tr>
								<?php
								   }
								   if ($j == 0)
								      echo "<tr><td colspan=\"3\">내역이 없습니다.</td></tr>";
								?>
								</tbody>
							</table>
						</td>
						<td><?php echo substr($row['i_regdatetime'],0,10); ?></td>
						<td><?php if(!$t_odinterestcount){?>0일<?php }else{?><?php echo $t_odinterestcount; ?>일<?php }?></td>
						<td><a href="{MARI_HOME_URL}/?cms=loan_form&type=m&i_id=<?php echo $row['i_id']; ?>&i_loan_type=<?php echo $row[i_loan_type]?>"><img src="{MARI_ADMINSKIN_URL}/img/view2_btn.png" alt="보기" /></a></td>
					</tr>
    <?php
    }
    if ($j == 0)
        echo "<tr><td colspan=\"".$colspan."\">대출신청 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<!-- <div class="btn_list01 btn_list">
			<input type="submit" name="" value="" class="select_modi_btn" />
			<input type="submit" name="" value="" class="select_delete_btn" />
		</div> -->
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
</form>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
		<div class="local_desc02">
			<p>
				1. 추가+ 버튼을 눌러 직접 대출신청서를 작성하실 수 있습니다.<br />
				2. 목록의 체크박스를 선택하여 삭제하실 수 있습니다.<br />
				3. 보기를 눌러 접수된 신청서를 확인하실 수 있습니다.<br />
				4. 상태/회차를 통해 월불입금상태와 회차를 확인하실 수 있으며 '보기'를 눌러 직접 정산처리가 가능합니다.<br />
			</p>
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->

<div id="modal"></div>


<script>
function loanlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 대출신청 내용을 정말 삭제하시겠습니까? 삭제 후에는 해당 신청내용의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}


$("#modal").iziModal({
    iframe: true,
    iframeHeight: 500,
});
$('.triggerModal').on('click', function (event) {
	$("#modal").iziModal('open',event);
});
function viewOver(lid){
	$.get()
	$.ajax({
	  url: '/api/index.php/cmsloanlist/viewover?loanid='+lid,
	  success: function (data){
			alert(data.msg.replace(/\\n/g,"\n"))
		},
	  dataType: 'json'
	});
}
</script>

{# s_footer}<!--하단-->
