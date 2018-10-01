<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 덧글
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

		<?php
		  for ($i=0; $row=sql_fetch_array($ment); $i++) {
		  $num=$i+1;
		?>작업중참고 : 프로젝트상태 대기:W진행중:P완료:C재문의:R
			<form name="comment_form_modi_<?php echo $num?>"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
			<input type="hidden" name="table" value="<?php echo $table; ?>">
			<input type="hidden" name="co_id" value="<?php echo $row['co_id']?>">
			<?php if(!$cotop){?>
			<input type="hidden" name="w_projectstatus" value="W"><!--접수-->
			<?php }else{?>
			<input type="hidden" name="w_projectstatus" value="R"><!--재문의-->
			<?php }?>
			<input type="hidden" name="type" value="m">
				<div class="receipt_write">

					<fieldset>
					<legend>문의하기</legend>
					<table width="100%" summary="문의하기위한 창">
					<caption>회원가입을 위한 표</caption>
					<colgroup>
					<col width="170px">
					<col width="*">
					</colgroup>
					<div>
						<tbody>
						<tr>
							<th><label for="w_2">작성일</label></th>
							<td ><?php echo substr($row['co_datetime'],0,10)?></td>
						</tr>
						<tr>
							<th><label for="h1">업무분류</label></th>
							<td>
								<select id="h1" name="business_cate">
								<option>업무분류선택</option>
								<option <?php echo $row['business_cate']=='디자인'?'selected':'';?>>디자인</option>
								<option <?php echo $row['business_cate']=='퍼블리싱'?'selected':'';?>>퍼블리싱</option>
								<option <?php echo $row['business_cate']=='개발'?'selected':'';?>>개발</option>
								<option <?php echo $row['business_cate']=='PM'?'selected':'';?>>PM</option>
								<option <?php echo $row['business_cate']=='영업상담'?'selected':'';?>>영업상담</option>
								<option <?php echo $row['business_cate']=='마케팅'?'selected':'';?>>마케팅</option>
								<option <?php echo $row['business_cate']=='제품문의'?'selected':'';?>>제품문의</option>
								<option <?php echo $row['business_cate']=='운영문의'?'selected':'';?>>운영문의</option>
								<option <?php echo $row['business_cate']=='방문상담'?'selected':'';?>>방문상담</option>
								<option <?php echo $row['business_cate']=='견적문의'?'selected':'';?>>견적문의</option>
								<option <?php echo $row['business_cate']=='질문과답변'?'selected':'';?>>질문과답변</option>
								<option <?php echo $row['business_cate']=='기술지원'?'selected':'';?>>기술지원</option>
								<option <?php echo $row['business_cate']=='커스터마이징'?'selected':'';?>>커스터마이징</option>
								<option <?php echo $row['business_cate']=='기타'?'selected':'';?>>기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="w_1">처리담당자</label></th>
							<td><input type="text" id="w_1" name="staff_name" value="<?php echo $row['staff_name'];?>"></td>
						</tr>
						<tr>
							<th><label for="w_2">처리예정일</label></th>
							<td ><input type="text" id="w_2" class="calendar_<?php echo $num;?>" name="datepro" value="<?php echo $row['datepro'];?>"></td>
						</tr>
						<tr>
							<th><label for="w_3">내용</label></th>
							<td><textarea name="co_content" id="w_3" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다."><?php echo $row[co_content];?></textarea></td>
						</tr>
						<tr>
							<th>완료처리</th>
							<td><input type="checkbox"  name="clear_use" value="Y" id="c_4" ><label for="c_4"  <?php echo $row['clear_use']=='Y'?'checked':'';?>><span></span>완료처리</label>
							<span class="c_4_01">※ 정확한 답변 내용 입력 후, 완료처리 하시기 바랍니다.</span></td>
						</tr>
					</div>
					</tbody>
					</table>
					</fieldset>

				</div><!--receipt_write f-->
				<div class="receipt_memo">
				<table width="100%" summary="문의하기위한 창">
					<colgroup>
					<col width="170px">
					<col width="*">
					</colgroup>
						<tbody>
						<tr>
							<th><label for="w_5">내부메모</label></th>
							<td><textarea name="co_memo" id="w_3" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다."><?php echo $row[co_memo];?></textarea></td>
						</tr>
						</tbody>
					</table>
				</div><!--receipt_memo f-->
				<p class="btn_hold">
					<a href="javascript:void(0);" onclick="reple_modi_<?php echo $num?>()">저장</a>
					<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&table=<?php echo $table;?>&subject=<?php echo $subject;?>&all=<?php echo $all;?>">목록</a>
				</p>
			</form>
			<script>
				$('.calendar_<?php echo $num?>').datepicker({
					 changeMonth: true,
					 changeYear: true,
					 dateFormat: 'yy-mm-dd',
					 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
					 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
				    showOn: "button",
				     buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
				     buttonImageOnly:true
				 });


				function reple_modi_<?php echo $num?>()
				{
					var f = document.comment_form_modi_<?php echo $num?>;


					if(f.business_cate[0].selected == true){ alert('\n업무분류를 선택하여 주십시오.'); return false;}
					if(!f.staff_name.value){alert('\n처리담당자를 입력하여 주십시오.');f.co_content.focus();return false;}
					if(!f.datepro.value){alert('\n처리예정일을 입력하여 주십시오.');f.co_content.focus();return false;}
					if(!f.co_content.value){alert('\n내용을 입력하여 주십시오.');f.co_content.focus();return false;}

					f.method = 'post';
					f.action = '{MARI_HOME_URL}/sql/imwork.php?update=bbs_comment&type=m';
					f.submit();
				}

			 </script>
		<?php
		   }
		   if ($i == 0)
		      echo "<li>TALK <span class=\"fb\">0</span>건</li>";
		?>

			<form name="comment_form"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="table" value="<?php echo $table; ?>">
			<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
			<input type="hidden" name="m_id" value="<?php echo $mysv[sale_code]?>"><!--아이디는 해당 상점 code로한다-->
			<input type="hidden" name="co_name" value="<?php echo $user[m_name]; ?>">
			<input type="hidden" name="co_id" value="<?php echo $co_id;?>">
			<?php if(!$cotop){?>
			<input type="hidden" name="w_projectstatus" value="W"><!--접수-->
			<?php }else{?>
			<input type="hidden" name="w_projectstatus" value="R"><!--재문의-->
			<?php }?>
			<input type="hidden" name="type" value="w">
				<div class="receipt_write">

					<fieldset>
					<legend>문의하기</legend>
					<table width="100%" summary="문의하기위한 창">
					<caption>회원가입을 위한 표</caption>
					<colgroup>
					<col width="170px">
					<col width="*">
					</colgroup>
					<div>
						<tbody>
						<tr>
							<th><label for="h1">업무분류</label></th>
							<td>
								<select id="h1" name="business_cate">
								<option>업무분류선택</option>
								<option <?php echo $row['business_cate']=='디자인'?'selected':'';?>>디자인</option>
								<option <?php echo $row['business_cate']=='퍼블리싱'?'selected':'';?>>퍼블리싱</option>
								<option <?php echo $row['business_cate']=='개발'?'selected':'';?>>개발</option>
								<option <?php echo $row['business_cate']=='PM'?'selected':'';?>>PM</option>
								<option <?php echo $row['business_cate']=='영업상담'?'selected':'';?>>영업상담</option>
								<option <?php echo $row['business_cate']=='마케팅'?'selected':'';?>>마케팅</option>
								<option <?php echo $row['business_cate']=='제품문의'?'selected':'';?>>제품문의</option>
								<option <?php echo $row['business_cate']=='운영문의'?'selected':'';?>>운영문의</option>
								<option <?php echo $row['business_cate']=='방문상담'?'selected':'';?>>방문상담</option>
								<option <?php echo $row['business_cate']=='견적문의'?'selected':'';?>>견적문의</option>
								<option <?php echo $row['business_cate']=='질문과답변'?'selected':'';?>>질문과답변</option>
								<option <?php echo $row['business_cate']=='기술지원'?'selected':'';?>>기술지원</option>
								<option <?php echo $row['business_cate']=='커스터마이징'?'selected':'';?>>커스터마이징</option>
								<option <?php echo $row['business_cate']=='기타'?'selected':'';?>>기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="w_1">처리담당자</label></th>
							<td><input type="text" name="staff_name" id="w_1" ></td>
						</tr>
						<tr>
							<th><label for="w_2">처리예정일</label></th>
							<td ><input type="text"  class="calendar" name="datepro" id="w_2" ></td>
						</tr>
						<tr>
							<th><label for="w_3">내용</label></th>
							<td><textarea name="co_content" id="w_3" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다."></textarea></td>
						</tr>
						<tr>
							<th>완료처리</th>
							<td><input type="checkbox" name="clear_use"  value="Y" id="c_4" ><label for="c_4"><span></span>완료처리</label>
							<span class="c_4_01">※ 정확한 답변 내용 입력 후, 완료처리 하시기 바랍니다.</span></td>
						</tr>
					</div>
					</tbody>
					</table>
					</fieldset>

				</div><!--receipt_write f-->
				<div class="receipt_memo">
				<table width="100%" summary="문의하기위한 창">
					<colgroup>
					<col width="170px">
					<col width="*">
					</colgroup>
						<tbody>
						<tr>
							<th><label for="w_5">내부메모</label></th>
							<td><textarea name="co_memo" id="w_3" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다."></textarea></td>
						</tr>
						</tbody>
					</table>
				</div><!--receipt_memo f-->
				<p class="btn_hold">
				<?php if($reple=="modi"){?>																			
							<a href="javascript:void(0);" onclick="reple_modi()">저장</a>
				<?php }else{?>
							<a href="javascript:;" id="comment_form_add">저장</a>
				<?php }?>
					<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&table=<?php echo $table;?>&subject=<?php echo $subject;?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>">목록</a>
				</p>
			</form>
<script>


/*comments*/
$(function() {
	$('#comment_form_add').click(function(){
		Comment_form_Ok(document.comment_form);
	});
});


function Comment_form_Ok(f)
{
	if(f.business_cate[0].selected == true){ alert('\n업무분류를 선택하여 주십시오.'); return false;}
	if(!f.staff_name.value){alert('\n처리담당자를 입력하여 주십시오.');f.co_content.focus();return false;}
	if(!f.datepro.value){alert('\n처리예정일을 입력하여 주십시오.');f.co_content.focus();return false;}
	if(!f.co_content.value){alert('\n내용을 입력하여 주십시오.');f.co_content.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/sql/imwork.php?update=bbs_comment&type=w';
	f.submit();
}



/*댓글 수정*/
function sendit(index){
	var f = document.invest_comment;
	<?php echo get_editor_js('co_content'); ?>
	<?php echo get_editor_js('co_memo'); ?>
	if(index==1){
		document.getElementById("content").style.display="block";
	}else if(index==2){
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/sql/imwork.php?update=bbs_comment&type=m';
		f.submit();
	}
}
function visit(v){
	
	if(v.value == "1"){
		document.getElementById("mail").style.display="block";
	}else if(v.value=="gmail.com" || v.value=="naver.com" || v.value=="yahoo.co.kr" || v.value=="hanmail.net" || v.value=="nate.com" || v.value=="hotmail.com"){
		document.getElementById("mail").style.display="none";
	}
}
function updateChar_co(FieldName, contentName, textlimitName){
	var strCount = 0;
	var tempStr, tempStr2;
	var frm = document.getElementById(contentName);
	var size = frm.value.length;		
	for(i = 0;i < size;i++){
		tempStr = frm.value.charAt(i);
		if(escape(tempStr).length > 4) strCount += 2;
		else strCount += 1 ;
	}
	
	if (strCount > FieldName){
		<?php if(!$user[m_id]){?>
		alert("회원 로그인후 작성하실 수 있습니다.");
		<?php }else{?>
		alert("최대 " + FieldName + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
		<?php }?>
		strCount = 0;
		tempStr2 = "";
		for(i = 0; i < size; i++){
			tempStr = frm.value.charAt(i);
			
			if(escape(tempStr).length > 4) strCount += 2;
			else strCount += 1 ;
			
			if (strCount > FieldName){
				if(escape(tempStr).length > 4) strCount -= 2;
				else strCount -= 1 ;
				break;
			} else tempStr2 += tempStr;
		}
		frm.value = tempStr2;
	}
	document.getElementById(textlimitName).innerHTML = strCount;
}


function mySub2(index){
	var f = document.invest_comment;

	if(index==3){
		if(confirm("해당 게시물을 신고하시겠습니까?")){
			
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/sql/imwork.php?update=comment_singo&si=g';
		f.submit();
		}else{
			alert('취소하였습니다');
			exit;
		}
	
	
	}

 
}

$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
	 showOn: "button",
	 buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
	 buttonImageOnly:true
 });

    
</script>
