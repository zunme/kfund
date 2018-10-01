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
			<div class="title01">고객센터</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">유지보수</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  문의 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="invest_list">
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
	<form name="conservatism" id="conservatism" action="{MARI_HOME_URL}/?update=conservatism" onsubmit="return conservatism_submit(this);" method="post">

		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>투자목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="100" />
					<!--
					<col width="100" />
					-->
					<col width="500" />
					<col width="100" />
					<col width="130" />
					<col width="100" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>신청자</th>
						<!--
						<th>담당자</th>
						-->
						<th>제목</th>
						<th>진행상황</th>
						<th>문의날짜</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($con); $i++) {
	
    ?>
					<tr>
						<td>
						<input type="hidden" name="cv_id[<?php echo $i ?>]" value="<?php echo $row['cv_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['cv_id']; ?></td>
						<td>
							<?php echo $row['m_name']; ?>
						</td>
						<!--
						<td>
							<select name="cv_person[<?php echo $i; ?>]">
								<option value="임근호" <?php echo $row['cv_person']=='임근호'?'selected':'';?>>임근호</option>
								<option value="임근철" <?php echo $row['cv_person']=='임근철'?'selected':'';?>>임근철</option>
								<option value="김영선" <?php echo $row['cv_person']=='김영선'?'selected':'';?>>김영선</option>
								<option value="이지은" <?php echo $row['cv_person']=='이지은'?'selected':'';?>>이지은</option>
								<option value="강동욱" <?php echo $row['cv_person']=='강동욱'?'selected':'';?>>강동욱</option>
								<option value="박유나" <?php echo $row['cv_person']=='박유나'?'selected':'';?>>박유나</option>
							</select>
						</td>
						-->
						<td><a href="{MARI_HOME_URL}/?cms=conservatism_view&cv_id=<?php echo $row['cv_id'];?>"><?php echo $row['cv_subject']; ?></a></td>
						<td>
							<select name="cv_condition[<?php echo $i; ?>]">
								<option value="1"<?php echo $row['cv_condition']=='1'?'selected':'';?>>접수</option>
								<option value="2"<?php echo $row['cv_condition']=='2'?'selected':'';?>>처리중</option>
								<option value="3"<?php echo $row['cv_condition']=='3'?'selected':'';?>>처리완료</option>
							</select>
						</td>
						<td><?php echo $row['cv_datetime']; ?></td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=conservatism_view&type=m&cv_id=<?php echo $row['cv_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=conservatism&type=d&cv_id=<?php echo $row['cv_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="삭제" /></a>
						</td>
						 
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=7>견적신청 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
			 
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" title="선택수정" style="font-size:0px;" onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" title="선택삭제" style="font-size:0px;" onclick="document.pressed=this.value"  />
			<div class="btn_confirm01 btn_confirm">
				<a href="{MARI_HOME_URL}/?cms=conservatism_view&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_btn.png" alt="추가" /></a>
			</div>
		</div>
		<!--페이징
		<div class="paging">
		<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div>/paging -->
		</div> 

		<!-- <div class="local_desc02">
			<p>
				1. 목록의 체크박스를 선택하여 진행목록으로 이동하실 수 있습니다.<br />
				2. 추가+ 버튼을 눌러 직접 대출신청서를 작성하실 수 있습니다.<br />
				3. 보기를 눌러 접수된 신청서를 확인하실 수 있습니다.
			</p>
		</div> -->

	</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->




<script>
function conservatism_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택취소") {
        if(!confirm("선택한 투자신청 내용을 정말 삭제하시겠습니까? 삭제 후에는 해당 신청내용의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->