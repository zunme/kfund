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
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		
	
		<form name="qnaList"   id="keyList"action="{MARI_HOME_URL}/?update=faq" onsubmit="return kBest(this);" method="post">
			<div class="title02">
				자문단관리<br/>				
			</div>
		
			<div class="btn_add01 btn_add">
				<a href="{MARI_HOME_URL}/?cms=advice_view&type=w"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"></a>
			</div>
			
				<div class="tbl_head01 tbl_wrap">
					<table class="txt_c">
					<caption>목록</caption>
					<colgroup>
						<col width="30px" />						
						<col width="50px" />
						<col width="50px" />
						<col width="400px" />
						<col width="150px" />
						<col width="100px" />

					</colgroup>
					<thead>
					<tr>	
						<th scope="col">
							<input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)">
						</th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">링크주소</th>
						<th scope="col">등록일</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
					<tbody>
<?php 
	for ($i=0;  $row=sql_fetch_array($adv); $i++){
?>
					<tr class="">
						<td>
							<input type="hidden" name="f_id[<?php echo $i ?>]" value="<?php echo $row['f_id'] ?>">
							<input type="checkbox" name="check[]" value="<?php echo $i; ?>">
						</td>
						<td><?php echo $row['ad_id'];?></td>
						<td><?php echo $row['ad_name'];?></td>
						<td><?php echo $row['ad_link'];?></td>
						<td><?php echo $row['ad_regidate']?></td>
						<td>	
							<a href="{MARI_HOME_URL}/?cms=advice_view&type=m&ad_id=<?php echo $row['ad_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="답변" /></a>
							<a href="{MARI_HOME_URL}/?update=advice_view&type=d&ad_id=<?php echo $row['ad_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="삭제" /></a>
						</td>
					</tr>	
   <?php
    }
     if ($i == 0)
        echo "<tr><td colspan=6>게시판 리스트가 없습니다.</td></tr>";
    ?>
				
					</tbody>
					</table>					
				</div>
				<div class="btn_list01 btn_list">
					<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
					<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
					<div class="btn_confirm01 btn_confirm">
						<a href="{MARI_HOME_URL}/?cms=faq_view&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_btn.png" alt="추가" /></a>
					</div>
				</div>
			</div>
		</form>

    </div><!-- /contaner -->
</div><!-- /wrapper -->




<script>
function addForm(){
	 var f = document.qnaAdd;
	 f.method = 'post';
	 f.action = '{MARI_HOME_URL}/?update=faq&type=<?php echo $type?>';
	 f.submit();
}
function kBest(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 게시물을 정말 삭제하시겠습니까? 삭제 후에는 해당 게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

</script>
{# s_footer}<!--하단-->