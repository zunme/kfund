<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
			<div class="title01">SMS관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02 line1">LMS 관리</div>
		<ul class="sms_cont2">
			<li class="sms_left1">
 <form name="fm" method="post" action="http://intowinsoft.co.kr/play/sms/ajax_sms_proc_utf8.php?monyplus=Y" onsubmit="return chkForm(this)">
 <input type="hidden" name="cid" id="cid" value="<?php echo $config[c_sms_id];?>">
 <input type="hidden" name="returnurl" value="{MARI_HOME_URL}/?cms=lms_manage">
 <input type="hidden" name="type" value="book">
				<h3 class="s_title1">장문보내기(-3건)</h3>
				<p>
				제목 : <input id="msg_title" name="msg_title" class="calltitle frm_input" onclick="document.getElementById('msg_title_info').style.display='none'; this.focus()" type="text" value="" title="메세지제목" onkeypress="" size="37" maxlength="20">
				</p>
				<div class="sms_box2">
					<div class="sms_box_cont1">
						<p class="sms_txt1">남은건수 <span id="smscount"><?php echo number_format($smsCount);?></span>건</p>
						<textarea name="msg" id="msg" onkeyup="updateChar(1500, 'msg', 'chkBite');" class="textarea"></textarea>
						<p class="sms_txt2 chkBite"><span id="chkBite">0</span>/1500 byte</p>
						<div class="sms_btn1">
							<img src="{MARI_ADMINSKIN_URL}/img/save3_btn.png" id="msg_save" style="cursor:pointer;" alt="저장" />
							<img src="{MARI_ADMINSKIN_URL}/img/rewrite_btn.png" onclick="javascript:document.fm.msg.value='';" style="cursor:pointer;" alt="다시쓰기" />
						</div>
					</div><!-- /sms_box_cont1 -->

					<div class="sms_box_cont2">
						<h4 class="sms_title1">받는사람</h4>
						<!--
						<div class="sms_btn2">
							<a href="javascript:member_all_chk();"><img src="{MARI_ADMINSKIN_URL}/img/all_btn.png" alt="전체" /></a>
							<a href="javascript:popup('{MARI_HOME_URL}/?cms=sms_book_search',500, 620)"><img src="{MARI_ADMINSKIN_URL}/img/search3_btn.png" alt="검색" /></a>
						</div>
						-->
						<textarea name="to" class="sendList"><?php if($booklist=="Y"){?><?php echo $sehp['sb_hp'];?><?php }else{?><?php for ($i=0; $i<count($group_b); $i++) { echo"".$group_b[$i][sb_hp]."\r\n"; ?><?php }?><?php }?></textarea>
					</div><!-- /sms_box_cont2 -->

					<div class="sms_box_cont3">
						<h4 class="sms_title1">보내는 사람</h4>
						<input type="text" name="from" id="" value="<?php echo $config[c_sms_phone];?>" />
						<p class="sms_chk2">
							<input type="radio"  name="mode" value="sendSms_lms" checked="checked" /> <label for="" class="mr10">즉시발송</label>
							<input name="mode" type="radio" value="rsSms_lms" /> <label for="">예약발송</label>
						</p>
						<p class="send_time">
							<span>
								<select name="rs_y" id="">
									<option>선택</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
								</select>
								<label for="">년</label>

								<select name="rs_m" id="">
									<option>선택</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
								<label for="">월</label>

								<select name="rs_d" id="">
									<option>선택</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
								<label for="">일</label>
							</span>

							<select name="rs_h" id="">
								<option>선택</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
							</select>
							<label for="">시</label>

							<select name="rs_s" id="">
								<option>선택</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								<option value="32">32</option>
								<option value="33">33</option>
								<option value="34">34</option>
								<option value="35">35</option>
								<option value="66">36</option>
								<option value="37">37</option>
								<option value="38">38</option>
								<option value="39">39</option>
								<option value="40">40</option>
								<option value="41">41</option>
								<option value="42">42</option>
								<option value="43">43</option>
								<option value="44">44</option>
								<option value="45">45</option>
								<option value="46">46</option>
								<option value="47">47</option>
								<option value="48">48</option>
								<option value="49">49</option>
								<option value="50">50</option>
								<option value="51">51</option>
								<option value="52">52</option>
								<option value="53">53</option>
								<option value="54">54</option>
								<option value="55">55</option>
								<option value="56">56</option>
								<option value="57">57</option>
								<option value="58">58</option>
								<option value="59">59</option>
								<option value="60">60</option>
							</select>
							<label for="">분</label>
						</p>
					</div><!-- /sms_box_cont3 -->

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
	<div id="tab1" style="display:none;">
		<ul class="tab_btn1">
			<li><a href="javascript:click_item('tab2')">전화번호선택</a></li>
			<li class="tab_on1"><a href="javascript:click_item('tab1')">그룹선택</a></li>
		</ul>
	<form name="smsgrouplist" id="smsgrouplist" action="{MARI_HOME_URL}/?cms=lms_manage&atype=book" onsubmit="return smsgrouplist_submit(this);" method="post">
	<input type="hidden" name="type" value="gr" >
				<h3 class="s_title1">SMS 그룹선택</h3>

				<div class="tbl_head01">
					<table class="txt_c">
						<caption>SMS 그룹선택</caption>
						<colgroup>
							<col width="50px" />
							<col width="120px" />
							<col width="120px" />
							<col width="120px" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
								<th>NO</th>
								<th>그룹명</th>
								<th>전체회원</th>
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
    for ($i=0; $i<count($group); $i++) {

    $gr_no = $group[$i]['sg_no'];
    $sql ="select count(*) as cnt from mari_smsbook where sg_no = '$gr_no'";
    $group_cnt = sql_fetch($sql);
    $total_group = $group_cnt[cnt];

    ?>
    					<tr>
						<td>
            <input type="hidden" name="sg_no[<?php echo $i ?>]" value="<?php echo $group[$i]['sg_no']?>" >
            <label for="chk_<?php echo $i ?>" class="sound_only">그룹명</label>
            <input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $group[$i]['sg_no']; ?></td>
						<td>
            <label for="sg_name_<?php echo $i; ?>" class="sound_only">그룹명</label>
						 <?php echo $group[$i]['sg_name']?>
						</td>
						<td><?php echo $total_group?></td>
					</tr>
    <?php } ?>
						</tbody>
					</table>
		<div class="txt_l pt10">
				<input type="submit" name="add_bt" class="add_number_btn" value="선택추가" style="font-size:0px; cursor:pointer;" onclick="document.pressed=this.value" />
		</div>
			<!--패이징--><div class="txt_c mb30"><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?></div>
	</div>
	</form>

	</div>

	<div id="tab2">
		<ul class="tab_btn1">
			<li class="tab_on1"><a href="javascript:click_item('tab2')">전화번호선택</a></li>
			<li><a href="javascript:click_item('tab1')">그룹선택</a></li>
		</ul>


	<form name="smsgrouplist" id="smsgrouplist" action="{MARI_HOME_URL}/?cms=lms_manage" onsubmit="return smsgrouplist_submit(this);" method="post">
	<input type="hidden" name="type" value="book" >
				<h3 class="s_title1">SMS 전화번호선택</h3>

				<div class="tbl_head01">
					<table class="txt_c">
						<caption>SMS 전화번호선택</caption>
						<colgroup>
							<col width="40px" />
							<col width="100px" />
							<col width="" />
							<col width="100px" />
							<col width="100px" />
							<col width="80px" />
                            <col width="80px" />
							<col width="103px" />
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th><?php echo sms_sort('sg_no', $cms, $type) ?>그룹명</a></th>
								<th><?php echo sms_sort('m_id', $cms, $type) ?>아이디</a></th>
								<th><?php echo sms_sort('sb_name', $cms, $type) ?>이름</a></th>
								<th><?php echo sms_sort('sb_hp', $cms, $type) ?>휴대폰</a></th>
        <th><?php echo sms_sort('sb_hp', $cms, $type) ?>휴대폰</a></th>
								<th>수신여부</th>
								<th>번호추가</th>
							</tr>
						</thead>
					</table>
				</div>

				<div class="tbl_head01 tbl_wrap1">
					<table class="txt_c">
						<caption>SMS 전화번호선택</caption>
						<colgroup>
							<col width="40px" />
							<col width="100px" />
							<col width="" />
							<col width="100px" />
							<col width="100px" />
							<col width="80px" />
                            <col width="80px" />
							<col width="75px" />
						</colgroup>
						<!-- <thead>
							<tr>
								<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
								<th>NO</th>
								<th>그룹명</th>
								<th>아이디</th>
								<th>이름</th>
								<th>휴대폰</th>
								<th>수신여부</th>
							</tr>
						</thead> -->
						<tbody>
    <?php
    for ($i=0; $i<count($book); $i++) {
	$sql = " select  sg_name from  mari_smsgroup where sg_no='".$book[$i][sg_no]."' $sql_order";
	$grname = sql_fetch($sql, false);
    ?>
    					<tr>
						<td><?php echo $book[$i]['sb_no']; ?></td>
						<td><?php echo $grname['sg_name'];?></td>
						<td>
            <label for="sg_name_<?php echo $i; ?>" class="sound_only">그룹명</label>
						 <?php echo $book[$i]['m_id']?>
						</td>
						<td><?php echo $book[$i]['sb_name']?></td>
						<td><?php echo $book[$i]['sb_hp']?></td>
                            <td><?php echo $book[$i]['sb_hp']?></td>
						<td><?php echo $book[$i]['sb_receipt'] ? '<font color=blue>수신</font>' : '<font color=red>거부</font>'?></td>
						<td>



						<input type="button" class="add_number_btn" value="내용추가"   style="font-size:0px;" onClick="add_hp('<?php echo $book[$i][sb_hp]?>\n')">
						</td>
					</tr>
    <?php } ?>
						</tbody>
					</table>
				</div>
		<div class="pt15">
		</div>
	</form>
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
		
		<div class="sms_cont3 saveMsg">
			<h3 class="s_title1">LMS 저장 메세지</h3>
			<ul class="message" id="save_sms_list">
                    <?
					for ($i=0; $i<$list_total; $i++){

						$msg=$list[$i]["msg"];
						$idx=$list[$i]["sm_idx"];
					
						$list_string = "
					<li>
					<div class=\"message_box\">
						<textarea name=\"capy_msg\" id=\"$idx\" style=\"cursor:pointer;\" onclick=\"copy_msg(this.value);\" onkeyup=\"updateChar(80,$idx, 'chkBite');\">$msg</textarea>
					</div>
					<div class=\"txt_c mt10\">
						<img src=\"".MARI_ADMINSKIN_URL."/img/modify4_btn.png\" alt=\"수정\"  style=\"cursor:pointer;\" onclick=\"modify_msg($idx)\" />
						<a href=\"javascript:del_msg($idx);\"><img src=\"".MARI_ADMINSKIN_URL."/img/delete5_btn.png\" alt=\"삭제\" id=\"msg_del\" style=\"cursor:pointer;\" onclick=\"del_msg($idx)\" /></a>
					</div>
					</li>";							


						echo "$list_string";


						$line++;
					}
					?>
			</ul><!-- /message -->
		</div><!-- /sms_cont3 -->
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
	if (!fm.from.value){
		alert("보내는 번호를 입력해주세요");
		fm.from.focus();
		return false;
	}

	if (!fm.to.value){
		alert("받는 번호를 입력해주세요");
		fm.to.focus();
		return false;
	}

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

	if(fm.mode[1].checked){

		if(!fm.rs_y.value){
			alert("년도를 yyyy형식으로 입력해주세요.");
			fm.rs_y.focus();
			return false;
		}

		if(!fm.rs_m.value){
			alert("월을 mm형식으로 입력해주세요.");
			fm.rs_m.focus();
			return false;
		}

		if(!fm.rs_d.value){
			alert("일자를 dd형식으로 입력해주세요.");
			fm.rs_d.focus();
			return false;
		}
	
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