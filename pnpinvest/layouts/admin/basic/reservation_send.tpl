<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
/*푸시발송내역*/

$sql = " select count(*) as cnt from mari_push_msg ";
$row = sql_fetch($sql);
$total_count = $row['cnt'];

$rows = $config['c_page_rows'];
$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
$from_record = ($page - 1) * $rows; // 시작 열을 구함

$sql = " select * from mari_push_msg  order by pm_redatetime desc limit $from_record, $rows";
$pushmsg_list = sql_query($sql);


/*푸시알림신청내역*/


$sql = " select count(*) as cnt from mari_push ";
$row_b = sql_fetch($sql);
$total_count_b = $row_b['cnt'];

$rows_b = $config['c_page_rows'];
$total_page_b  = ceil($total_count_b / $rows_b);  // 전체 페이지 계산
if ($page_b < 1) $page_b = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
$from_record_b = ($page_b - 1) * $rows_b; // 시작 열을 구함


$sql = " select * from mari_push  order by p_regdatetime desc limit $from_record_b, $rows_b";
$push_list = sql_query($sql);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN LMS 관리
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script type="text/javascript" src="http://www.intowinsoft.co.kr/play/sms/js/jquery.sms.js"></script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">푸시전송관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02 line1">푸시관리</div>
		<ul class="sms_cont2">
			<li class="sms_left1">
 <form name="fm" method="post" action="{MARI_HOME_URL}/?update=pushlist_send" onsubmit="return chkForm(this)">
  <input type="hidden" name="cid" id="cid" value="<?php echo $config[c_sms_id];?>">
				<h3 class="s_title1">장문보내기(-3건)</h3>
				<p>
				제목 : <input id="msg_title" name="msg_title" class="calltitle frm_input" onclick="document.getElementById('msg_title_info').style.display='none'; this.focus()" type="text" value="" title="메세지제목" onkeypress="" size="37" maxlength="20">
				</p>
				<div class="sms_box3">
					<div class="sms_box_cont1">
						<p class="sms_txt1">남은건수 <span id="smscount"><?php echo number_format($smsCount);?></span>건</p>
						<textarea name="msg" id="msg" onkeyup="updateChar(1500, 'msg', 'chkBite');" class="textarea"></textarea>
						<p class="sms_txt2 chkBite"><span id="chkBite">0</span>/1500 byte</p>
						<div class="sms_btn1">
							<img src="{MARI_ADMINSKIN_URL}/img/rewrite_btn.png" onclick="javascript:document.fm.msg.value='';" style="cursor:pointer;" alt="다시쓰기" />
						</div>
					</div><!-- /sms_box_cont1 -->

	
					<div class="sms_btn3">
						<input type="image" src="{MARI_ADMINSKIN_URL}/img/send3_btn.png" alt="메세지 전송" />
					</div>
				</div><!-- /sms_box2  -->

				<div class="charge_btn">
					<a href="javascript:popup('http://intowinsoft.co.kr/play/pay/sms_order.php?cid=<?=$config[c_sms_id]?>',500,600)" class="charge"><img src="{MARI_ADMINSKIN_URL}/img/charge_btn.png" alt="충전하기" /></a>
				</div>
</FORM>
			</li>
			<li class="sms_right1">
<!-- <p>
<a href="{MARI_HOME_URL}/?cms=sms_manage&type=gr"><?php if($type=="gr"){?><b>[그룹선택]</b><?php }else{?>[그룹선택]<?php }?></a> <a href="{MARI_HOME_URL}/?cms=sms_manage&type=book"><?php if($type=="book"){?><b>[전화번호선택]</b><?php }else{?>[전화번호선택]<?php }?></a>
</p> -->

			<li class="sms_right1">
	<div id="tab1" style="display:none;">
		<ul class="tab_btn1">
			<li><a href="javascript:click_item('tab2')">알림신청리스트</a></li>
			<li class="tab_on1"><a href="javascript:click_item('tab1')">푸시발송내역</a></li>
		</ul>
				<h3 class="s_title1">푸시발송내역</h3>

				<div class="tbl_head01">
					<table class="txt_c">
						<caption>푸시발송내역</caption>
						<colgroup>
							<col width="40px" />
							<col width="20%" />
							<col width="40%" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>내용</th>
								<th>발송타입</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($pushmsg_list); $i++) {
    ?>
    					<tr>
						<td><?php echo $row['pm_no'];?></td>
						<td><?php echo $row['pm_msg_title'];?></td>
						<td><?php echo $row['pm_msg'];?></td>
						<td><?php echo $row['pm_push_type'];?></td>
						<td><?php echo $row['pm_redatetime'];?></td>
					</tr>
    <?php } ?>
					<tbody>
					</table>
			<!--패이징--><div class="paging"><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?></div>
				</div>

		<div class="pt15">
		</div>
	</div>
	<div id="tab2">
		<ul class="tab_btn1">
			<li class="tab_on1"><a href="javascript:click_item('tab2')">알림신청리스트</a></li>
			<li><a href="javascript:click_item('tab1')">푸시발송내역</a></li>
		</ul>
				<h3 class="s_title1">알림신청리스트</h3>

				<div class="tbl_head01">
					<table class="txt_c">
						<caption>알림신청리스트</caption>
						<colgroup>
							<col width="40px" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th>아이디</th>
								<th>이름</th>
								<th>휴대폰번호</th>
								<th>수신여부</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
						<!--
					<tr>
						<td></td>
						<td><?php echo $no_group['sg_no']; ?></td>
						<td><?php echo $no_group['sg_name']?></td>
						<td><?php echo number_format($no_group['sg_count'])?></td>
					</tr>
					-->
    <?php
    for ($i=0; $row=sql_fetch_array($push_list); $i++) {
    ?>
    					<tr>
						<td><?php echo $row['p_no'];?></td>
						<td><?php echo $row['m_id'];?></td>
						<td><?php echo $row['m_name'];?></td>
						<td><?php echo $row['p_hp'];?></td>
						<td><?php echo $row['p_push_use'];?></td>
						<td><?php echo $row['p_regdatetime'];?></td>
					</tr>
    <?php } ?>
						</tbody>
					</table>
			<!--패이징--><div class="paging"><?php echo get_paging($config['c_write_pages'], $page_b, $total_page_b, '?cms='.$cms.''.$qstr.'&amp;page='); ?></div>
	</div>
	</div>
			</li>
			<li class="sms_right1">
				<h3 class="s_title1">SMS 전송 결과</h3>

				<div class="tbl_head01">
      <div class="tblType2" id="sms_list">        
      </div>
      <div class="pageArea" id="page_view">
      </div>  
      <div class="searchArea">
        <form>
          <fieldset>
          <legend>검색하기</legend>
          <label style="display:inline-block">기간</label>          
		  <select name="syear" id="syear">
			<option value="<?=$syear-1?>" <?=$selected[syear][$syear-1]?>><?=$syear-1?></option>
			<option value="<?=$syear?>" <?=$selected[syear][$syear]?>><?=$syear?></option>
			<option value="<?=$syear+1?>" <?=$selected[syear][$syear+1]?>><?=$syear+1?></option>
		  </select><label style="display:inline-block">년</label>
		  <select name="smonth" id="smonth">
			<? for ($i=1;$i<=12;$i++){ $i = ($i<10) ? "0".$i : $i; ?>
			<option value="<?=$i?>" <?=$selected[smonth][$i]?>><?=$i?></option>
			<? } ?>
		  </select><label style="display:inline-block">월</label>          
          <input type="image" src="{MARI_ADMINSKIN_URL}/img/search_btn.png" class="button" id="sms_search" value="검색" />   
          </fieldset>
        </form>
      </div>    
    <!--/전송결과-->
  <iframe name="hiddenfrm" style="width:100%;height:200px;display:none"></iframe>
				</div>
			</li>
		</ul><!-- /sms_cont2 -->
		

		<div class="ml30 mt15 txt_c" style="padding-bottom:100px;">
 <? if($sm_type == 5){?>
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=sms_manage_lms'.$qstr.'&amp;page='); ?>
 <? }else if($sm_type == 6){?><!--mms-->
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=sms_manage_lms'.$qstr.'&amp;page='); ?>
 <? }else{?>
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=sms_manage'.$qstr.'&amp;page='); ?>
 <? }?>
 </div>

<script>
function updateChar(FieldName, contentName, textlimitName){
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
		alert("최대 " + FieldName + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
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

function chkForm(fm){

	if (!fm.msg_title.value){
		alert("메세지 제목을 입력해주세요");
		fm.msg_title.focus();
		return false;
	}

	if (!fm.msg.value){
		alert("sms 전송 메세지를 입력해주세요");
		fm.msg.focus();
		return false;
	}




	return true;
}


function sms_count(){

	var cid = $("#cid").attr("value");
	var dataString = "cid=" + cid + "&&mode=smscall";
	var url = "http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?" + dataString;

	$.getJSON(url + "&jsoncallback=?", function(data){
		smsmsg = data.smscall;
		$("#smscount").html(smsmsg);

	});

}


//저장메세지 j-query
$(document).ready(function(){

	//콜수 불러오기
	sms_count();
	
	$("#msg_save").click(function(){

		if(!$("#msg").val()){
			alert("sms 전송 메세지를 입력해주세요");
			document.fm.msg.focus();
			return false;
		}
		
		var msg = $("#msg").val();
		var smode = "save";
		//아약을 써서 따른 페이지에서 			
		$.ajax({
		type:"POST",
		url:"{MARI_HOME_URL}/?cms=sms_manage_ajax",
		data:"sm_type=5&msg="+msg+"&smode="+smode, 
			  
			success:function(html){	
			  $("#save_sms_list").html(html); 		 
			}
		});
	});
});


function modify_msg(idx){

	var msg = $("#"+idx).val();
	var smode = "modify";


	//아약을 써서 따른 페이지에서 			
	$.ajax({
	type:"POST",
	url:"{MARI_HOME_URL}/?cms=sms_manage_ajax",
	data:"sm_type=5&msg="+msg+"&smode="+smode+"&idx="+idx, 
		  
		success:function(html){	
		  $("#save_sms_list").html(html); 		 
		}
	});
}


function del_msg(idx){

	var smode = "del";

	//아약을 써서 따른 페이지에서 			
	$.ajax({
	type:"POST",
	url:"{MARI_HOME_URL}/?cms=sms_manage_ajax",
	data:"sm_type=5&smode="+smode+"&idx="+idx, 
		  
		success:function(html){	
		  $("#save_sms_list").html(html); 		 
		}
	});
}

function copy_msg(val){
	document.fm.msg.value = val;
}



function smsgrouplist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    return true;
}
/*전화번호추가*/
function add_hp(txt) {
 document.all.to.focus();
 var addhp;
 var hp = document.all.to.value;
 //cRange = document.selection.createRange();
 //cRange.text = txt;

  document.all.to.value = txt;
  if(hp == ""){
	  addhp = txt;
	  document.all.to.value= addhp;
  }else{
	  addhp= hp + txt;
	  document.all.to.value= addhp;
  } 
}
</script>

<script type="text/javascript">
	/*menu tab*/
	function click_item(id) {
		var str = "tab1,tab2";
		var s = str.split(',');
		for (i=0; i<s.length; i++)
		{
			if (id=='*') document.getElementById(s[i]).style.display = 'block';
			else document.getElementById(s[i]).style.display = 'none';
		}
		if (id!='*') document.getElementById(id).style.display = 'block';
	}
 </script>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

{# s_footer}<!--하단-->