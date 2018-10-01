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
		<div class="title02">회원메일 발송</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a> 폼메일 작성건수 : <?php echo number_format($total_count) ?>통
		</div>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=mail_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/mail_add_btn.png" alt="메일내용 추가" /></a>
		</div>
	<form name="marillist" id="marillist" action="{MARI_HOME_URL}/?update=mail_list" onsubmit="return maillist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>메일발송 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="" />
					<col width="150px" />
					<col width="150px" />
					<col width="100px" />
					<col width="120px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>제목</th>
						<th>작성일</th>
						<th>발송일</th>
						<th>발송</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
    ?>
					<tr>
						<td>
						<input type="hidden" name="mr_id[<?php echo $i ?>]" value="<?php echo $row['mr_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $row['mr_id']; ?></td>
						<td><?php echo $row['mr_subject']; ?></td>
						<td><?php echo substr($row['mr_regtime'],0,10); ?></td>
						<td><?php echo substr($row['mr_sentime'],0,10); ?></td>
						<td><img src="{MARI_ADMINSKIN_URL}/img/send_btn.png" alt="발송"  style="cursor:pointer"></td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=mail_form&type=m&mr_id=<?php echo $row['mr_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" /></a>
							<a href="{MARI_HOME_URL}/?update=mail_list&type=d&id=<?php echo $row['mr_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" /></a>
						</td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">메일 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
	</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->


<script>
function maillist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 메일내용을 정말 삭제하시겠습니까? 삭제 후에는 해당 메일게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->







