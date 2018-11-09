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
		<div class="title02">e-머니 관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 건수 : <?php echo number_format($total_count) ?> (지급 e-머니 합계 : <?php echo number_format($t_emoney) ?>원)
		</div>

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

		<h2 class="h2_frm mt20"><span>e-머니 지급내역</span></h2>
	<form name="emoneylist" id="emoneylist" action="{MARI_HOME_URL}/?update=emoney_list" onsubmit="return emoneylist_submit(this);" method="post">
	<input type="hidden" name="type" value="d">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>e-머니 목록</caption>
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
						<th>회원아이디</th>
						<th>이름</th>
						<th>지급일시</th>
						<th>지급내용</th>
						<th>e-머니</th>
						<th>e-머니합계</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	$sql = "select  * from  mari_member where m_id='$row[m_id]'";
	$em = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="p_id[<?php echo $i ?>]" value="<?php echo $row['p_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['m_id']; ?></td>
						<td><?php echo $em['m_name']; ?></td>
						<td><?php echo substr($row['p_datetime'],0,10); ?></td>
						<td><?php echo $row['p_content']; ?></td>
						<td><?php echo number_format($row[p_emoney]) ?></td>
						<td><?php echo number_format($row[p_top_emoney]) ?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">지급 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&sfl='.$sfl.'&stx='.$stx.'&amp;page='); ?>
		</div><!-- /paging -->
		<div class="btn_list01 btn_list">
		<?php if($user[m_level]>=10){?>
			<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
		<?php }?>
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
	</form>
		<h2 class="h2_frm mt20"><span>e-머니 입력</span></h2>
<form name="emoney_form"  method="post" enctype="multipart/form-data">
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
						<td><input type="text" name="m_id" id="" class="required frm_input"  /></td>
					</tr>
					<tr>
						<th scope="row">지급내용</th>
						<td><input type="text" name="p_content"  class="required frm_input" size="80" /></td>
					</tr>
					<tr>
						<th scope="row">e-머니</th>
						<td><input type="text" name="p_emoney" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="required frm_input" /></td>
					</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" id="emoney_form_add" title="확인"  />
		</div>

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
$(function() {
	$('#emoney_form_add').click(function(){
		Emoney_form_Ok(document.emoney_form);
	});
});


function Emoney_form_Ok(f)
{
	if(!f.m_id.value){alert('\n아이디를 입력하여 주십시오.');f.m_id.focus();return false;}
	if(!f.p_content.value){alert('\n지급내용을 입력하여 주십시오.');f.p_content.focus();return false;}
	if(!f.p_emoney.value){alert('\n지급하실 e-머니를 입력하여 주십시오.');f.p_emoney.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=emoney_list';
	f.submit();
}

function Member_intercept_NO(f)
{
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=member_form&type=cn';
	f.submit();
}

function cnj_comma(cnj_str) {
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = "";
		var cnjValue2 = "";

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		for(i=0; i<cnj_str.value.length; i++)      {
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") {
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2;
		}
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) {
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue;
		} else {
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue;
		}
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}


/*엑셀다운로드*/

function goto_xlsm_time()
{
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>';
}
</script>

{# s_footer}<!--하단-->
