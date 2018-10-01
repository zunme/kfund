<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 덧글
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>
							<div class="comment_wrap">  
								<ul class="comment1">
								<?php
								  for ($i=0; $row=sql_fetch_array($ment); $i++) {
								?>
									<li>
									 	<form name="invest_comment"  method="post" enctype="multipart/form-data">
										<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
										<input type="hidden" name="table" value="<?php echo $table; ?>">
										<input type="hidden" name="co_id" value="<?php echo $row['co_id']?>">
										<p class="comment_info">
											<span class="nickname1">
											<?php 
												if($row['co_level']  >= 10 ){
													echo '관리자';
												}else{
													echo $row[m_id];
												}
											?>
											</span> 
<!--											<span class="c_date1"><?php echo $row['co_regdatetime'];?></span>
										<?php if(!$member_ck){?>
											<a href="javascript:alert('로그인후 신고하실 수 있습니다.')"><img src="{MARI_HOMESKIN_URL}/img/co_icon1.png"alt="신고"/></a>
										<?php }else{?>
											<a href="javascript:mySub2(3);"><img src="{MARI_HOMESKIN_URL}/img/co_icon1.png"alt="신고"/></a>
										<?php }?>
-->
											<!--<a href="javascript:;" title="reply">답글</a>-->
										<?php if(!$member_ck){?>
										<?php }else{?>
											<?if($row['m_id']==$user['m_id'] || $user['m_level'] >= 10){?>
											<a href="{MARI_HOME_URL}/?mode=bbs_view&table=qna&subject=질문과답변&id=<?php echo $row['w_id']?>&type=view&reple=modi&co_id=<?php echo $row[co_id];?>" class="modi">수정</a>
											<a href="{MARI_HOME_URL}/?up=bbs_comment&w_id=<?php echo $row[w_id];?>&co_id=<?php echo $row[co_id];?>&type=d" title="delete" class="del">삭제</a>
											<?php }else{?>
											<?php }?>
										<?php }?>
											<?php echo substr($row['co_datetime'],0,10)?>&nbsp&nbsp&nbsp
										</p>
										
									 
										<p class="comment_txt"><?php echo html_content($row['co_content'],'');?></p>										
										
										
										<div id="content" style="display:none;">
											<textarea name="co_content" value="" style="height:34px; width:1000px;" ></textarea>
											<a href="{MARI_HOME_URL}/?up=view_comment&w_id=<?php echo $row[w_id];?>&co_id=<?php echo $row[co_id];?>&m_id=<?php echo $row[m_id];?>&type=m"><img src="{MARI_HOMESKIN_URL}/img/modify_btn.png" alt="수정" /></a>
										</div>
										
										</form>
									</li>
								<?php
								   }
								   if ($i == 0)
								      echo "<li>TALK <span class=\"fb\">0</span>건</li>";
								?>
								</ul>
								<div class="comment2">
								<form name="comment_form"  method="post" enctype="multipart/form-data">
								<input type="hidden" name="table" value="<?php echo $table; ?>">
								<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
								<input type="hidden" name="m_id" value="<?php echo $user[m_id]; ?>">
								<input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
								<input type="hidden" name="co_id" value="<?php echo $co_id;?>">
								
									<div class="notice_comment2_cont">
										<?php if($reple=="modi"){?>
										<textarea name="co_content" id="co_content"   onkeyup="updateChar_co(<?php if(!$user[m_id]){?>1<?php }else{?>300<?php }?>, 'co_content', 'chkBite_comment');"><?=$ment_modi['co_content']?></textarea>
										<a href="javascript:void(0);" onclick="reple_modi()"><img src="{MARI_MOBILESKIN_URL}/img/modify_btn.png" style="cursor:pointer;" alt="수정"/></a>
										<?php }else{?>
										<textarea name="co_content" id="co_content"   onkeyup="updateChar_co(<?php if(!$user[m_id]){?>1<?php }else{?>300<?php }?>, 'co_content', 'chkBite_comment');"><?=$ser['co_content']?></textarea>																				
										<a href="javascript:;" id="comment_form_add">등록</a>
										<!--<img src="{MARI_MOBILESKIN_URL}/img/btn_register1.png" id="comment_form_add" style="cursor:pointer;" alt="등록"/>-->
										<?php }?>
									</div>
								</form>
									<p><span id="chkBite_comment">0</span> / 300</p>
								</div>
							</div><!-- /comment_wrap -->

<script>
/*comments*/
$(function() {
	$('#comment_form_add').click(function(){
		Comment_form_Ok(document.comment_form);
	});
});


function Comment_form_Ok(f)
{
	if(!f.co_content.value){alert('\n댓글의 내용을 입력하여 주십시오.');f.co_content.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_comment&type=w';
	f.submit();
}

function reple_modi()
{
	var f = document.comment_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_comment&type=m';
	f.submit();
}


/*댓글 수정*/
function sendit(index){
	var f = document.invest_comment;

	if(index==1){
		document.getElementById("content").style.display="block";
	}else if(index==2){
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?up=view_comment&type=m';
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
		f.action = '{MARI_HOME_URL}/?up=comment_singo&si=g';
		f.submit();
		}else{
			alert('취소하였습니다');
			exit;
		}
	
	
	}

 
}


</script>
<?php }else{?>
							<div class="comment_wrap">  
								<ul class="comment1">
								<?php
								  for ($i=0; $row=sql_fetch_array($ment); $i++) {
								?>
									<li>
									 	<form name="invest_comment"  method="post" enctype="multipart/form-data">
										<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
										<input type="hidden" name="table" value="<?php echo $table; ?>">
										<input type="hidden" name="co_id" value="<?php echo $row['co_id']?>">
										<p class="comment_info">
											<span class="nickname1">
											<?php 
												if($row['co_level']  >= 10 ){
													echo '관리자';
												}else{
													echo $row[m_id];
												}
											?>
											</span> 
<!--											<span class="c_date1"><?php echo $row['co_regdatetime'];?></span>
										<?php if(!$member_ck){?>
											<a href="javascript:alert('로그인후 신고하실 수 있습니다.')"><img src="{MARI_HOMESKIN_URL}/img/co_icon1.png"alt="신고"/></a>
										<?php }else{?>
											<a href="javascript:mySub2(3);"><img src="{MARI_HOMESKIN_URL}/img/co_icon1.png"alt="신고"/></a>
										<?php }?>
-->
											<!--<a href="javascript:;" title="reply">답글</a>-->
										<?php if(!$member_ck){?>
										<?php }else{?>
											<?if($row['m_id']==$user['m_id'] || $user['m_level'] >= 10 ){?>
											<a href="{MARI_HOME_URL}/?mode=bbs_view&table=qna&subject=질문과답변&id=<?php echo $row['w_id']?>&type=view&reple=modi&co_id=<?php echo $row[co_id];?>" class="modi">수정</a>
											<a href="{MARI_HOME_URL}/?up=bbs_comment&w_id=<?php echo $row[w_id];?>&co_id=<?php echo $row[co_id];?>&type=d" title="delete" class="del">삭제</a>
											<?php }else{?>
											<?php }?>
										<?php }?>
											<?php echo substr($row['co_datetime'],0,10)?>&nbsp&nbsp&nbsp
										</p>
										
									 
										<p class="comment_txt"><?php echo html_content($row['co_content'],'');?></p>										
										
										<div id="content" style="display:none;">
										<textarea name="co_content" value="" style="height:34px; width:1000px;" ></textarea>
										<a href="{MARI_HOME_URL}/?up=view_comment&w_id=<?php echo $row[w_id];?>&co_id=<?php echo $row[co_id];?>&m_id=<?php echo $row[m_id];?>&type=m"><img src="{MARI_HOMESKIN_URL}/img/modify_btn.png" alt="수정" /></a>
										</div>
										</form>
									</li>
								<?php
								   }
								   if ($i == 0)
								      echo "<li>TALK <span class=\"fb\">0</span>건</li>";
								?>
								</ul>
								<div class="comment2">
								<form name="comment_form"  method="post" enctype="multipart/form-data">
								<input type="hidden" name="table" value="<?php echo $table; ?>">
								<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
								<input type="hidden" name="m_id" value="<?php echo $user[m_id]; ?>">
								<input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
								<input type="hidden" name="co_id" value="<?php echo $co_id;?>">
								
									<div class="notice_comment2_cont">
										
										<?php if($reple=="modi"){?>
											<textarea name="co_content" id="co_content"   onkeyup="updateChar_co(<?php if(!$user[m_id]){?>1<?php }else{?>300<?php }?>, 'co_content', 'chkBite_comment');"><?=$ment_modi['co_content']?></textarea>																				
											<a href="javascript:void(0);" onclick="reple_modi()">등록</a>
										<?php }else{?>
											<textarea name="co_content" id="co_content"   onkeyup="updateChar_co(<?php if(!$user[m_id]){?>1<?php }else{?>300<?php }?>, 'co_content', 'chkBite_comment');"><?=$ser['co_content']?></textarea>						
											<a href="javascript:;" id="comment_form_add">등록</a>
											<!--<img src="{MARI_HOMESKIN_URL}/img/btn_register1.png" id="comment_form_add" style="cursor:pointer;" alt="등록"/>-->
										<?php }?>
									</div>
								</form>
									<p style="display:inline-block; "><span id="chkBite_comment">0</span> / 300</p>
								</div>
							</div><!-- /comment_wrap -->

<script>
/*comments*/
$(function() {
	$('#comment_form_add').click(function(){
		Comment_form_Ok(document.comment_form);
	});
});


function Comment_form_Ok(f)
{
	if(!f.co_content.value){alert('\n댓글의 내용을 입력하여 주십시오.');f.co_content.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_comment&type=w';
	f.submit();
}

function reple_modi()
{
	var f = document.comment_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_comment&type=m';
	f.submit();
}


/*댓글 수정*/
function sendit(index){
	var f = document.invest_comment;

	if(index==1){
		document.getElementById("content").style.display="block";
	}else if(index==2){
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?up=view_comment&type=m';
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
		f.action = '{MARI_HOME_URL}/?up=comment_singo&si=g';
		f.submit();
		}else{
			alert('취소하였습니다');
			exit;
		}
	
	
	}

 
}


</script>
<?php }?>