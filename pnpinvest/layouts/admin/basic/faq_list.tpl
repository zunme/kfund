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
			<div class="title01">나의서비스관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		
		<!--
				<fieldset>
	<form name="qnaAdd" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="w"/>
			<div id ="server_info">
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<caption>질문추가</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo">질문내용</th>
						<td>
							<input type="text" name="f_question" value="" id="" class="frm_input" size="190" />
						</td>
					</tr>					
					</tbody>
					</table>
				</div>
			</div>
			<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="addForm()">질문추가</a>
			</div>
		</form>
			</fieldset>
		-->
		<form name="qnaList"   id="keyList"action="{MARI_HOME_URL}/?update=faq" onsubmit="return kBest(this);" method="post">
			<div class="title02">
				FAQ<br/>				
			</div>
			<!--
			 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">노출유무</a>
				<input type="radio" id="" name="c_faq_use" value="Y" <?php echo $config['c_faq_use']=='Y'?'checked':'';?> /><label for="" class="mr10">노출</label>
				<input type="radio" id="" name="c_faq_use" value="N" <?php echo $config['c_faq_use']=='N'?'checked':'';?> /> <label for="">미노출</label>&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/save2_btn.png" alt="저장" /></a>
			</div>
			-->
			<script>
				function sendit(){
					var f = document.qnaList;
					f.method = 'post';
					f.action = '{MARI_HOME_URL}/?update=faq&type=view';
					f.submit();
				}
			</script>
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
						<th scope="col">분류</th>
						<th scope="col">질문</th>
						<th scope="col">날짜</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
					<tbody>
<?php 
	for ($i=0;  $row=sql_fetch_array($faq); $i++){
?>
					<tr class="">
						<td>
							<input type="hidden" name="f_id[<?php echo $i ?>]" value="<?php echo $row['f_id'] ?>">
							<input type="checkbox" name="check[]" value="<?php echo $i; ?>">
						</td>
						<td><?php echo $row['f_id'];?></td>
						<td>
							<select name="f_sort[<?php echo $i; ?>]">
								<option>선택하세요</option>
								<option value="1" <?php echo $row['f_sort']=='1'?'selected':'';?>>투자</option>
								<option value="2" <?php echo $row['f_sort']=='2'?'selected':'';?>>대출</option>
								<option value="3" <?php echo $row['f_sort']=='3'?'selected':'';?>>일반</option>
							</select>
						</td>
						<td><?php echo $row['f_question'];?></td>
						<td><?php echo $row['f_regidate']?></td>
						<td>	
							<a href="{MARI_HOME_URL}/?cms=faq_view&type=m&f_id=<?php echo $row['f_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="답변" /></a>
							<a href="{MARI_HOME_URL}/?update=faq&type=d&f_id=<?php echo $row['f_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="삭제" /></a>
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
					<div class="paging">
			<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_faq_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
					</div><!-- /paging -->
					<br/><br/>
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