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
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">회원권한관리</div>
		<!--
		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="emoney_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>
		-->
			<h2 class="h2_frm mt20"><span>권한설정</span></h2>

<?php if($type=='m'){ ?>
<form name="modiForm"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="<?php echo $type?>">
<input type="hidden" name="au_id" value="<?php echo $au_id?>">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회원아이디</th>
						<td>
							<?php echo $au1[m_id]?>&nbsp&nbsp&nbsp*4레벨이상 회원만 노출됩니다. 등급설정은 <a href="{MARI_HOME_URL}/?cms=member_grade">[클릭]</a>이동하셔서 하시기바랍니다.
						</td>
					</tr>
					<tr>
						<th scope="row">관리권한</th>
						<td>
							<input type="checkbox" name="au_member" value="1" <?php echo $au1[au_member] == "1" ? "checked" : ""; ?>/>&nbsp회원관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_board" value="1" <?php echo $au1[au_board] == "1" ? "checked" : ""; ?>/>&nbsp게시판관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_popup" value="1" <?php echo $au1[au_popup] == "1" ? "checked" : ""; ?>/>&nbsp팝업관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_loan" value="1" <?php echo $au1[au_loan] == "1" ? "checked" : ""; ?>/>&nbsp대출관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest"  value="1" <?php echo $au1[au_invest] == "1" ? "checked" : ""; ?>/>&nbsp투자관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales"  value="1" <?php echo $au1[au_sales] == "1" ? "checked" : ""; ?>/>&nbsp회계관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design"  value="1" <?php echo $au1[au_design] == "1" ? "checked" : ""; ?>/>&nbsp디자인관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms"  value="1" <?php echo $au1[au_sms] == "1" ? "checked" : ""; ?>/>&nbsp SMS관리
						</td>

					</tr>
					<tr>
						<th scope="row">회원관리</th>
						<td>
							<input type="checkbox" name="au_member01" value="1" <?php echo $au_member_sub01 == "1" ? "checked" : ""; ?> />&nbsp회원목록&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_member02" value="2" <?php echo $au_member_sub02 == "2" ? "checked" : ""; ?> />&nbsp회원등급&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_member03"  value="3" <?php echo $au_member_sub03 == "3" ? "checked" : ""; ?> />&nbsp탈퇴회원&복구&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_member04"  value="4" <?php echo $au_member_sub04 == "4" ? "checked" : ""; ?> />&nbsp e-머니관리
							<input type="checkbox" name="au_member05"  value="5" <?php echo $au_member_sub05 == "5" ? "checked" : ""; ?> />&nbsp 로그분석
							<input type="checkbox" name="au_member06"  value="6" <?php echo $au_member_sub06 == "6" ? "checked" : ""; ?> />&nbsp 회원권한관리
						</td>

					</tr>
					<tr>
						<th scope="row">게시판관리</th>
						<td>
							<input type="checkbox" name="au_board01" value="1" <?php echo $au_board_sub01 == "1" ? "checked" : ""; ?> />&nbsp게시판그룹관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_board02" value="2" <?php echo $au_board_sub02 == "2" ? "checked" : ""; ?> />&nbsp게시판관리&nbsp&nbsp&nbsp																				
						</td>

					</tr>
					<tr>
						<th scope="row">팝업관리</th>
						<td>
							<input type="checkbox" name="au_popup01" value="1" <?php echo $au_popup_sub01 == "1" ? "checked" : ""; ?> />&nbsp팝업관리&nbsp&nbsp&nbsp
						</td>

					</tr>
					<tr>
						<th scope="row">대출관리</th>
						<td>
							<input type="checkbox" name="au_loan01" value="1" <?php echo $au_loan_sub01 == "1" ? "checked" : ""; ?> />&nbsp대출현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_loan02" value="2" <?php echo $au_loan_sub02 == "2" ? "checked" : ""; ?> />&nbsp투자진행설정
						</td>

					</tr>
					<tr>
						<th scope="row">투자관리</th>
						<td>
							<input type="checkbox" name="au_invest01" value="1" <?php echo $au_invest_sub01 == "1" ? "checked" : ""; ?> />&nbsp투자현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest02" value="2" <?php echo $au_invest_sub02 == "2" ? "checked" : ""; ?> />&nbsp결제관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest03" value="3" <?php echo $au_invest_sub03 == "3" ? "checked" : ""; ?> />&nbsp투자/결제 설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest04" value="4" <?php echo $au_invest_sub04 == "4" ? "checked" : ""; ?> />&nbsp출금신청&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest05" value="5" <?php echo $au_invest_sub05 == "5" ? "checked" : ""; ?> />&nbsp충전내역&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest06" value="6" <?php echo $au_invest_sub06 == "6" ? "checked" : ""; ?> />&nbsp매출리포트
						</td>

					</tr>
					<tr>
						<th scope="row">회계관리</th>
						<td>
							<input type="checkbox" name="au_sales01" value="1" <?php echo $au_sales_sub01 == "1" ? "checked" : ""; ?> />&nbsp매출현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales02" value="2" <?php echo $au_sales_sub02 == "2" ? "checked" : ""; ?> />&nbsp대출자산&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales03"  value="3" <?php echo $au_sales_sub03 == "3" ? "checked" : ""; ?> />&nbsp수납처리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales04"  value="4" <?php echo $au_sales_sub04 == "4" ? "checked" : ""; ?> />&nbsp정산완료&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales05"  value="5" <?php echo $au_sales_sub05 == "5" ? "checked" : ""; ?> />&nbsp투자결제완료
						</td>

					</tr>
					<tr>
						<th scope="row">디자인관리</th>
						<td>
							<input type="checkbox" name="au_design01" value="1" <?php echo $au_design_sub01 == "1" ? "checked" : ""; ?> />&nbsp디스플레이설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design02" value="2" <?php echo $au_design_sub02 == "2" ? "checked" : ""; ?> />&nbsp SEO설정&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_design03"  value="3" <?php echo $au_design_sub03 == "3" ? "checked" : ""; ?> />&nbsp페이지보안설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design04"  value="4" <?php echo $au_design_sub04 == "4" ? "checked" : ""; ?> />&nbsp 로고/파비콘설정
							<input type="checkbox" name="au_design05"  value="5" <?php echo $au_design_sub05 == "5" ? "checked" : ""; ?> />&nbsp 하단정보설정
							<input type="checkbox" name="au_design06"  value="6" <?php echo $au_design_sub06 == "6" ? "checked" : ""; ?> />&nbsp 카테고리설정
						</td>

					</tr>
					<tr>
						<th scope="row">SMS관리</th>
						<td>
							<input type="checkbox" name="au_sms01" value="1" <?php echo $au_smssub01 == "1" ? "checked" : ""; ?> />&nbsp SMS관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms02" value="2" <?php echo $au_sms_sub02 == "2" ? "checked" : ""; ?> />&nbsp LMS관리&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_sms03"  value="3" <?php echo $au_sms_sub03 == "3" ? "checked" : ""; ?> />&nbsp SMS그룹관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms04"  value="4" <?php echo $au_sms_sub04 == "4" ? "checked" : ""; ?> />&nbsp 전화번호관리
							<input type="checkbox" name="au_sms05"  value="5" <?php echo $au_sms_sub05 == "5" ? "checked" : ""; ?> />&nbsp SMS설정
							<input type="checkbox" name="au_sms06"  value="6" <?php echo $au_sms_sub06 == "6" ? "checked" : ""; ?> />&nbsp SMS충전
							<input type="checkbox" name="au_sms07"  value="7" <?php echo $au_sms_sub07 == "7" ? "checked" : ""; ?> />&nbsp 푸시관리
						</td>

					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="addForm(2)"><img src="{MARI_ADMINSKIN_URL}/img/modify_btn.png" alt="수정" /></a>
		</div>
</form>
<?php } else{ ?>

<form name="assignForm"  method="post" enctype="multipart/form-data">
<input type="hidden" name="type" value="w">
		 <div class="tbl_frm01 tbl_wrap">
			<table>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회원아이디</th>
						<td>
							<?php echo get_memberadmin_select("m_id") ?>*4레벨이상 회원만 노출됩니다. 등급설정은 <a href="{MARI_HOME_URL}/?cms=member_grade">[클릭]</a>이동하셔서 하시기바랍니다.
						</td>
					</tr>
					<tr>
						<th scope="row">관리권한</th>
						
						<td>
							<input type="checkbox" name="au_member" value="1"  onClick="checkDisable(this.form)"/>&nbsp회원관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_board" value="1"  onClick="checkDisable(this.form)"/>&nbsp게시판관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_popup" value="1"  onClick="checkDisable(this.form)"/>&nbsp팝업관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_loan" value="1" onClick="checkDisable(this.form)"/>&nbsp대출관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest"  value="1" onClick="checkDisable(this.form)"/>&nbsp투자관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales"  value="1" onClick="checkDisable(this.form)"/>&nbsp회계관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design"  value="1" onClick="checkDisable(this.form)"/>&nbsp디자인관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms"  value="1" onClick="checkDisable(this.form)"/>&nbsp SMS관리
						</td>

					</tr>
					<tr>
						<th scope="row">회원관리</th>
						<td>
							
							<input type="checkbox" name="au_member01" value="1" disabled="disabled"/>&nbsp회원목록&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_member02" value="2" disabled="disabled"/>&nbsp회원등급&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_member03"  value="3" disabled="disabled"/>&nbsp탈퇴회원&복구&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_member04"  value="4" disabled="disabled"/>&nbsp e-머니관리
							<input type="checkbox" name="au_member05"  value="5" disabled="disabled"/>&nbsp 로그분석
							<input type="checkbox" name="au_member06"  value="6" disabled="disabled"/>&nbsp 회원권한관리
						</td>

					</tr>
					<tr>
						<th scope="row">게시판관리</th>
						<td>
							
							<input type="checkbox" name="au_board01" value="1" disabled="disabled"/>&nbsp게시판그룹관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_board02" value="2" disabled="disabled"/>&nbsp게시판관리&nbsp&nbsp&nbsp																				
						</td>

					</tr>
					<tr>
						<th scope="row">팝업관리</th>
						<td>
							
							<input type="checkbox" name="au_popup01" value="1" disabled="disabled"/>&nbsp팝업관리&nbsp&nbsp&nbsp
						</td>

					</tr>
					<tr>
						<th scope="row">대출관리</th>
						<td>
							<input type="checkbox" name="au_loan01" value="1" disabled="disabled"/>&nbsp대출현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_loan02" value="2" disabled="disabled"/>&nbsp투자진행설정
						</td>

					</tr>
					<tr>
						<th scope="row">투자관리</th>
						<td>
							<input type="checkbox" name="au_invest01" value="1" disabled="disabled"/>&nbsp투자현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest02" value="2" disabled="disabled"/>&nbsp결제관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest03" value="3" disabled="disabled"/>&nbsp투자/결제 설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest04" value="4" disabled="disabled"/>&nbsp출금신청&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest05" value="5" disabled="disabled"/>&nbsp충전내역&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_invest06" value="6" disabled="disabled"/>&nbsp매출리포트
						</td>

					</tr>
					<tr>
						<th scope="row">회계관리</th>
						<td>
							<input type="checkbox" name="au_sales01" value="1" disabled="disabled"/>&nbsp매출현황&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales02" value="2" disabled="disabled"/>&nbsp대출자산&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales03"  value="3" disabled="disabled"/>&nbsp수납처리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales04"  value="4" disabled="disabled"/>&nbsp정산완료&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sales05"  value="5" disabled="disabled"/>&nbsp투자결제완료
						</td>

					</tr>
					<tr>
						<th scope="row">디자인관리</th>
						<td>
							
							<input type="checkbox" name="au_design01" value="1" disabled="disabled"/>&nbsp 디스플레이설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design02" value="2" disabled="disabled"/>&nbsp SEO설정&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_design03"  value="3" disabled="disabled"/>&nbsp 페이지보안설정&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_design04"  value="4" disabled="disabled"/>&nbsp 로고/파비콘설정
							<input type="checkbox" name="au_design05"  value="5" disabled="disabled"/>&nbsp 하단정보설정
							<input type="checkbox" name="au_design06"  value="6" disabled="disabled"/>&nbsp 카테고리설정
						</td>

					</tr>
					<tr>
						<th scope="row">SMS관리</th>
						<td>
							
							<input type="checkbox" name="au_sms01" value="1" disabled="disabled"/>&nbsp SMS관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms02" value="2" disabled="disabled"/>&nbsp LMS관리&nbsp&nbsp&nbsp																				
							<input type="checkbox" name="au_sms03"  value="3" disabled="disabled"/>&nbsp SMS그룹관리&nbsp&nbsp&nbsp
							<input type="checkbox" name="au_sms04"  value="4" disabled="disabled"/>&nbsp 전화번호관리
							<input type="checkbox" name="au_sms05"  value="5" disabled="disabled"/>&nbsp SMS설정
							<input type="checkbox" name="au_sms06"  value="6" disabled="disabled"/>&nbsp SMS충전
							<input type="checkbox" name="au_sms07"  value="7" disabled="disabled"/>&nbsp 푸시관리
						</td>

					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="addForm(1)"><img src="{MARI_ADMINSKIN_URL}/img/add_btn.png" alt="저장" /></a>
		</div>
</form>	
<?php }?>
		<h2 class="h2_frm mt20"><span>회원 권한 현황</span></h2>
	<form name="list" id="emoneylist" action="{MARI_HOME_URL}/?update=member_authority" onsubmit="return emoneylist_submit(this);" method="post">
	<input type="hidden" name="type" value="d">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>e-머니 목록</caption>
				<colgroup>
					<col width="50" />
					<col width="50" />
					<col width="500" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="50" />
					<col width="200" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>번호</th>
						<th>회원아이디</th>
						<th>회원관리권한</th>
						<th>게시판권한</th>
						<th>팝업권한</th>
						<th>대출관리권한</th>
						<th>투자관리권한</th>
						<th>회계관리권한</th>
						<th>디자인권한</th>
						<th>SMS권한</th>
						<th>권한등록일</th>
					</tr>
				</thead>
			
				<tbody>
				<?php for($i=0 ; $row=sql_fetch_array($au); $i++){ ?>
					<tr>
						<td>
						<input type="hidden" name="au_id[<?php echo $i ?>]" value="<?php echo $row['au_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['au_id'];?></td>
						<td><a href="{MARI_HOME_URL}/?cms=member_authority&type=m&au_id=<?php echo $row['au_id'];?>"><?php echo $row['m_id'];?></a></td>
						<td><?php if(!$row['au_member']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_board']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_popup']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_loan']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_invest']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_sales']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_design']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php if(!$row['au_sms']){ echo 'N'; }else{ echo 'Y'; } ?></td>
						<td><?php echo $row['au_regidate'];?></td>
					</tr>
				<?php }?>
				</tbody>
			</table>
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
	</form>


    </div><!-- /contaner -->
</div><!-- /wrapper -->



<script>
function emoneylist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}


/*필수체크*/

function addForm(index){
	
	if(index==1){
		var f=document.assignForm;
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?update=member_authority&type=w';
		f.submit();
	}
	if(index==2){
		var f=document.modiForm;
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?update=member_authority&type=<?php echo $type?>';
		f.submit();
	}
}

function checkDisable(frm)
{
	if( frm.au_member.checked == true ){
	   frm.au_member01.disabled = false; frm.au_member02.disabled = false; frm.au_member03.disabled = false; frm.au_member04.disabled = false; frm.au_member05.disabled = false; frm.au_member06.disabled = false;
	   
	}else{
	   frm.au_member01.disabled = true; frm.au_member02.disabled = true; frm.au_member03.disabled = true; frm.au_member04.disabled = true; frm.au_member05.disabled = true; frm.au_member06.disabled = true;
	   frm.au_member01.checked = false; frm.au_member02.checked = false; frm.au_member03.checked = false; frm.au_member04.checked = false; frm.au_member05.checked = false; frm.au_member06.checked = false;
	}

	if( frm.au_board.checked == true ){
	   frm.au_board01.disabled = false; frm.au_board02.disabled = false;
	}else{
	   frm.au_board01.disabled = true; frm.au_board02.disabled = true;
	   frm.au_board01.checked = false; frm.au_board02.checked = false;
	}

	if( frm.au_popup.checked == true ){
	   frm.au_popup01.disabled = false;
	}else{
	   frm.au_popup01.disabled = true;
	   frm.au_popup01.checked = false;
	}

	if( frm.au_loan.checked == true ){
	   frm.au_loan01.disabled = false; frm.au_loan02.disabled = false;
	}else{
	   frm.au_loan01.disabled = true; frm.au_loan02.disabled = true;
	   frm.au_loan01.checked = false; frm.au_loan02.checked = false;
	}

	if( frm.au_invest.checked == true ){
	   frm.au_invest01.disabled = false; frm.au_invest02.disabled = false; frm.au_invest03.disabled = false; frm.au_invest04.disabled = false; frm.au_invest05.disabled = false; frm.au_invest06.disabled = false;
	}else{
	   frm.au_invest01.disabled = true; frm.au_invest02.disabled = true; frm.au_invest03.disabled = true; frm.au_invest04.disabled = true; frm.au_invest05.disabled = true; frm.au_invest06.disabled = true;
	   frm.au_invest01.checked = false; frm.au_invest02.checked = false; frm.au_invest03.checked = false; frm.au_invest04.checked = false; frm.au_invest05.checked = false; frm.au_invest06.checked = false;
	}

	if( frm.au_sales.checked == true ){
	   frm.au_sales01.disabled = false; frm.au_sales02.disabled = false; frm.au_sales03.disabled = false; frm.au_sales04.disabled = false; frm.au_sales05.disabled = false; 
	}else{
	   frm.au_sales01.disabled = true; frm.au_sales02.disabled = true; frm.au_sales03.disabled = true; frm.au_sales04.disabled = true; frm.au_sales05.disabled = true; 
	   frm.au_sales01.checked = false; frm.au_sales02.checked = false; frm.au_sales03.checked = false; frm.au_sales04.checked = false; frm.au_sales05.checked = false; 
	}
	if( frm.au_design.checked == true ){
	   frm.au_design01.disabled = false; frm.au_design02.disabled = false; frm.au_design03.disabled = false; frm.au_design04.disabled = false; frm.au_design05.disabled = false; frm.au_design06.disabled = false;
	   
	}else{
	   frm.au_design01.disabled = true; frm.au_design02.disabled = true; frm.au_design03.disabled = true; frm.au_design04.disabled = true; frm.au_design05.disabled = true; frm.au_design06.disabled = true;
	   frm.au_design01.checked = false; frm.au_design02.checked = false; frm.au_design03.checked = false; frm.au_design04.checked = false; frm.au_design05.checked = false; frm.au_design06.checked = false;
	}

	if( frm.au_sms.checked == true ){
	   frm.au_sms01.disabled = false; frm.au_sms02.disabled = false; frm.au_sms03.disabled = false; frm.au_sms04.disabled = false; frm.au_sms05.disabled = false; frm.au_sms06.disabled = false; frm.au_sms07.disabled = false;
	   
	}else{
	   frm.au_sms01.disabled = true; frm.au_sms02.disabled = true; frm.au_sms03.disabled = true; frm.au_sms04.disabled = true; frm.au_sms05.disabled = true; frm.au_sms06.disabled = true; frm.au_sms07.disabled = true;
	   frm.au_sms01.checked = false; frm.au_sms02.checked = false; frm.au_sms03.checked = false; frm.au_sms04.checked = false; frm.au_sms05.checked = false; frm.au_sms06.checked = false; frm.au_sms07.checked = false;
	}
}

</script>

{# s_footer}<!--하단-->







