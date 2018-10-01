<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
include_once(MARI_EDITOR_LIB);
?>

		<?php
		  for ($i=0; $row=sql_fetch_array($ment); $i++) {
		  $num=$i+1;
		?>
			<?php 
			/*재문의 체크*/
			if($row['contact_us']=="Y"){
			?>
			
					<div class="receipt_write">
						<div class="title"style="padding-top: 2%;">
							<h5>재문의</h5>
						</div>
					<form action="" method="">	
						<fieldset>
						<legend>문의확인</legend>
						<table width="100%" summary="재문의를 위한 창">
						<caption>재문의내용</caption>
						<colgroup>
						<col width="170px">
						</colgroup>
							<tbody>
							<!--<tr class="write">-->
							<tr>
								<th>내용</th>
								<td>
									<?php echo $row[co_content];?>
								</td>
							</tr>

						</tbody>
						</table>
						</fieldset>
					

				</div><!-- receipt_write f-->
			<?php }else{?>
				<?php if($row['co_view']=="Y"){?>
					<div class="receipt_write" style="border-top: 3px solid #3c8dbc;">
						<div class="title"style="padding-top: 5%; ">
							<h5 style="color:#3c8dbc;">답변내용</h5>
						</div>
						
						<fieldset>
						<legend>문의확인</legend>
						<table width="100%" summary="답변내용을 위한 창">
						<caption>답변내용</caption>
						<colgroup>
						<col width="170px">
						<col width="*">
						</colgroup>
							<tbody>
							<tr>
								<th>처리예정일</th>
								<td><?php echo $row['datepro'];?></td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<p>
									<?php echo $row[co_content];?>
									</p>
								</td>
							</tr>
							<tr>
								<th>진행상태</th>
								<td ><B><?php if($row['clear_use']=="Y"){?>완료<?php }else{?>진행중<?php }?>(<?php echo $row['co_datetime'];?>)</B></td>
							</tr>
					
						</tbody>
						</table>
						</fieldset>
						</form>
				</div><!-- receipt_write f-->
				<?php } ?>
			<?php }?>
		<?php
		   }
		   if ($i == 0)
		      echo "<li>TALK <span class=\"fb\">0</span>건</li>";
		?>
					<p class="btn_hold">
						<a class="btn_holdin01" href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1">목록</a>
						<?php echo $rebt;?><!--다시문의하기버튼-->
					</p>
			<form name="comment_form"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="table" value="<?php echo $table; ?>">
			<input type="hidden" name="w_id" value="<?php echo $id; ?>">
			<input type="hidden" name="m_id" value="<?php echo $mysv[sale_code]?>"><!--아이디는 해당 상점 code로한다-->
			<input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
			<input type="hidden" name="co_id" value="<?php echo $co_id;?>">
			<?php if(!$cotop){?>
			<input type="hidden" name="w_projectstatus" value="W"><!--접수-->
			<?php }else{?>
			<input type="hidden" name="w_projectstatus" value="R"><!--재문의-->
			<?php }?>
			<input type="hidden" name="type" value="w">
					<div class="receipt_memo"style="<?php echo $display;?> border-top: 3px solid #3c8dbc; width: 100%;  margin-top: 30px; padding: 20px 30px; background-color: #fff;  border-radius: 10px; box-sizing: border-box;">
					<table width="100%" summary="다시 문의하기위한 창">
						<colgroup>
						<col width="135px">
						<col width="*">
						</colgroup>
							<tbody>
							<tr class="re_memo">
								<th><label for="w_5">다시 문의 작성</label></th>
								<td>
								<?php 
								 /*에디터 사용시에만 에디터노출*/
								if($bbs_config['bo_use_editor']=="Y"){
								?>
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<?php echo editor_html('co_content', $bbs_config['bo_insert_content']); ?>
								<?php }else{?>
									<?php echo editor_html('co_content', $row['co_content']); ?>
								<?php }?>
								<?php }else{?>
									<textarea name="co_content" id="w_5"><?php echo $row['co_content'];?></textarea>
								<?php }?>
								<!--<textarea name="co_content" id="w_5" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다.">--></textarea>
								</td>
							</tr>
							</tbody>
						</table>
						<a href="javascript:;" class="memo_close">닫기</a>
							<p class="btn_hold">
						<?php if($reple=="modi"){?>																			
								<a href="javascript:void(0);" onclick="reple_modi()">접수</a>
						<?php }else{?>
								<a href="javascript:;" id="comment_form_add">접수</a>
						<?php }?>
							</p>
					</div><!--receipt_memo f-->

				 <script>
					$(function(){
					  var ex_show = $('.btn_holdin');
					  var ex_hide = $('.memo_close');
					  var ex_box = $('.receipt_memo');
					  ex_show.click(function(){
						ex_box.slideDown(1000);
						/*ex_show.hide();*/
					  });
					  ex_hide.click(function(){
						ex_box.slideUp(1000);
						ex_show.show();
					  });
					});
				</script>

				
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
	/*
	if(f.business_cate[0].selected == true){ alert('\n업무분류를 선택하여 주십시오.'); return false;}
	if(!f.staff_name.value){alert('\n처리담당자를 입력하여 주십시오.');f.co_content.focus();return false;}
	if(!f.datepro.value){alert('\n처리예정일을 입력하여 주십시오.');f.co_content.focus();return false;}
	*/
		<?php echo get_editor_js('co_content'); ?>
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
