<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN sms 설정
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">SMS관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">SMS 설정</div>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="m"/>

		<h2 class="bo_title"><span>SMS사용설정</span></h2>
		<div class="bo_text">
			<p>
				발급받으신 상점코드를 입력하신후 ADMIN에서 SMS발송관련 서비스를 이용하실 수 있습니다.
			</p>
		</div>
		<div class="tbl_frm01 tbl_wrap">
			<table>
			<caption>SMS사용설정</caption>
			<colgroup>
				<col width="200px" />
				<col width="" />
			</colgroup>
			<tbody>
			<tr>
				<th scope="bo"><label for="c_sms_id">SMS ID</label></th>
				<td>
					<input type="text" name="c_sms_id" value="<?php echo $config['c_sms_id'];?>" id=" " class="frm_input" size="40" /> 
				</td>
			</tr>
			<tr>
				<th scope="bo"><label for="c_sms_phone">발신번호</label></th>
				<td>
					<input type="text" name="c_sms_phone" value="<?php echo $config['c_sms_phone'];?>" id=" " class="frm_input" size="40" /> 
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		
		<div class="btn_confirm01 btn_confirm pb50">
			<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
		</div>
	</form>
	<form name="smsload_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="m"/>
		<h2 class="bo_title"><span>회원관련 SMS 발송</span></h2>
		<div class="bo_text">
			<p>
				회원관련 SMS 자동발송 설정입니다. 내용을 입력하신후 사용을 원할시 체크박스에 사용 체크하여 주십시오.
			</p>
			<p>
				치환코드 : ｛이름｝ ｛아이디｝ ｛사이트명｝
			</p>
		</div>
		<ul class="sms_cont1">
			<li>
				<div class="sms_box1">
					<textarea name="member_msg_m" id="msg" onkeyup="updateChar(80, 'msg', 'chkBite');" ><?php echo $load['member_msg'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="member_req" value="Y" <?php echo $load['member_req']=='Y'?'checked':'';?> />
					<label class="">회원가입 시 발송</label>
				</p>
			</li>
		</ul>
		<h2 class="bo_title"><span>채무자 대상 SMS 발송</span></h2>
		<div class="bo_text">
			<p>
				채무자 SMS 자동발송 설정입니다. 내용을 입력하신후 사용을 원할시 체크박스에 사용 체크하여 주십시오.
			</p>
			<p>
				치환코드 : ｛이름｝ ｛신청금액｝
			</p>
		</div>
		<ul class="sms_cont1">
			<li>
				<div class="sms_box1">
					<textarea name="loan_msg_m" id="msg1" onkeyup="updateChar(80, 'msg1', 'chkBite');" ><?php echo $load['loan_msg'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="loan_req" value="Y" <?php echo $load['loan_req']=='Y'?'checked':'';?> />
					<label class="">대출신청 시 발송</label>
				</p>
			</li>
		</ul>

		<h2 class="bo_title"><span>투자자 대상 SMS 발송</span></h2>
		<div class="bo_text">
			<p>
				투자자 SMS 자동발송 설정입니다. 내용을 입력하신후 사용을 원할시 체크박스에 사용 체크하여 주십시오.
			</p>
			<p>
				치환코드 : ｛제목｝ ｛이름｝ ｛투자금액｝ ｛회차｝ ｛정산금액｝ ｛이머니｝ ｛출금금액｝
			</p>
		</div>
		<ul class="sms_cont1">
			<li>
				<div class="sms_box1">
					<textarea name="invest_msg_01_m" id="msg2" onkeyup="updateChar(80, 'msg2', 'chkBite');" ><?php echo $load['invest_msg_01'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="invest_req_01" value="Y" <?php echo $load['invest_req_01']=='Y'?'checked':'';?> />
					<label class="">투자신청 시 발송</label>
				</p>
			</li>
			<li>
				<div class="sms_box1">
					<textarea name="invest_msg_02_m" id="msg3" onkeyup="updateChar(80, 'msg3', 'chkBite');" ><?php echo $load['invest_msg_02'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="invest_req_02" value="Y" <?php echo $load['invest_req_02']=='Y'?'checked':'';?> />
					<label class="">정산 시 발송</label>
				</p>
			</li>
			<li>
				<div class="sms_box1">
					<textarea name="invest_msg_03_m" id="msg4" onkeyup="updateChar(80, 'msg4', 'chkBite');" ><?php echo $load['invest_msg_03'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="invest_req_03" value="Y" <?php echo $load['invest_req_03']=='Y'?'checked':'';?> />
					<label class="">e-머니 충전 시 발송</label>
				</p>
			</li>
			<li>
				<div class="sms_box1">
					<textarea name="invest_msg_04_m" id="msg5" onkeyup="updateChar(80, 'msg5', 'chkBite');" ><?php echo $load['invest_msg_04'];?></textarea>
					<p><span id="chkBite">0</span>/80 byte</p>
				</div>
				<p class="sms_chk1">
					<input type="checkbox" name="invest_req_04" value="Y" <?php echo $load['invest_req_04']=='Y'?'checked':'';?> />
					<label class="">출금완료 시 발송</label>
				</p>
			</li>
		</ul>
		<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit_load()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
		</div>
	</form>
    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script type="text/javascript">
function sendit(){
	var f=document.config_form;
	if(!f.c_sms_id.value){alert('\SMS ID를 입력하여 주십시오.');f.c_sms_id.focus();return false;}
	if(!f.c_sms_phone.value){alert('\대표 발신번호를 입력하여 주십시오.');f.c_sms_phone.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=sms_setup';
	f.submit();
}


function sendit_load(){
	var f=document.smsload_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=smsload_setup';
	f.submit();
}


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
</script>

{# s_footer}<!--하단-->