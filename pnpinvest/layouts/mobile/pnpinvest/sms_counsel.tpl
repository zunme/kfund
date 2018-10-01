<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ SMS 상담신청
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<?php if($config['c_sms_use']=="Y"){?>
	<div class="consult_wrap">
<?if($_COOKIE['Cookiadd']=="none"){?>
		<div class="consult1" id="consult1"  style="display:none;">
			<h4 class="consult_title1">SMS 상담 요청</h4>
			<div class="consult1_cont1">
	<form name="fm" method="post" action="http://way21.co.kr/admin/sms/ajax_sms_proc_utf8.php?monyplus=Y" onsubmit="return chkForm(this)">
	<input type="hidden" name="cid" id="cid" value="<?php echo $config[c_sms_id];?>">
	<input type="hidden" name="returnurl" value="{MARI_HOME_URL}/?mode=<?php echo $mode;?>">
	<input type="hidden" name="type" value="book">
	<input type="hidden" name="to" id="" value="<?php echo $config[c_sms_phone];?>" /><!--받는사람-->
				<table class="type11">
					<colgroup>
						<col width="54px" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>상담내용</th>
							<td>
								<textarea name="msg" id="msg" onkeyup="updateChar(80, 'msg', 'chkBite');" class="textarea"></textarea>
								<p class="mt10 txt_r chkBite"><span class="fb" id="chkBite">0</span> / 80 Byte</p>
							</td>
						</tr>
						<tr>
							<th>고객명</th>
							<td><input type="text" name="" id="" value="" /></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="from" id="" /></td>
						</tr>
					</tbody>
				</table>
				<div class="txt_c mt10"><input type="image" src="{MARI_MOBILESKIN_URL}/img/btn_send1.png" alt="전송하기" /></div>
	</form>
			</div>
			<div class="close_btn1"><a href="javascript:click_items('consult2')"  onclick="setCookie('Cookiadd', 'none', 1)"><img src="{MARI_MOBILESKIN_URL}/img/btn_close1.png" alt="close" onClick = "setMyCookie()"/></a></div>
		</div>
		<div class="consult2" id="consult2"  style="display:block;">
			<h4 class="consult_title1">SMS 상담 요청 : <span>궁금한 사항을 물어보세요.</span></h4>
			<div class="open_btn1"><a href="javascript:click_items('consult1')" onclick="setCookie('Cookiadd', '', -1)"><img src="{MARI_MOBILESKIN_URL}/img/btn_open1.png" alt="open" /></a></div>
		</div>
<?php }else{?>
		<div class="consult1" id="consult1"  style="display:block;">
			<h4 class="consult_title1">SMS 상담 요청</h4>
			<div class="consult1_cont1">
	<form name="fm" method="post" action="http://way21.co.kr/admin/sms/ajax_sms_proc_utf8.php?monyplus=Y" onsubmit="return chkForm(this)">
	<input type="hidden" name="cid" id="cid" value="<?php echo $config[c_sms_id];?>">
	<input type="hidden" name="returnurl" value="{MARI_HOME_URL}/?mode=<?php echo $mode;?>">
	<input type="hidden" name="type" value="book">
	<input type="hidden" name="to" id="" value="<?php echo $config[c_sms_phone];?>" /><!--받는사람-->
				<table class="type11">
					<colgroup>
						<col width="54px" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>상담내용</th>
							<td>
								<textarea name="msg" id="msg" onkeyup="updateChar(80, 'msg', 'chkBite');" class="textarea"></textarea>
								<p class="mt10 txt_r chkBite"><span class="fb" id="chkBite">0</span> / 80 Byte</p>
							</td>
						</tr>
						<tr>
							<th>고객명</th>
							<td><input type="text" name="" id="" value="" /></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="from" id="" /></td>
						</tr>
					</tbody>
				</table>
				<div class="txt_c mt10"><input type="image" src="{MARI_MOBILESKIN_URL}/img/btn_send1.png" alt="전송하기" /></div>
	</form>
			</div>
			<div class="close_btn1"><a href="javascript:click_items('consult2')"  onclick="setCookie('Cookiadd', 'none', 1)"><img src="{MARI_MOBILESKIN_URL}/img/btn_close1.png" alt="close" onClick = "setMyCookie()"/></a></div>
		</div>
		<div class="consult2" id="consult2"  style="display:none;">
			<h4 class="consult_title1">SMS 상담 요청 : <span>궁금한 사항을 물어보세요.</span></h4>
			<div class="open_btn1"><a href="javascript:click_items('consult1')" onclick="setCookie('Cookiadd', 'block', 1)"><img src="{MARI_MOBILESKIN_URL}/img/btn_open1.png" alt="open" /></a></div>
		</div>
<?php } ?>
	</div><!-- /consult_wrap -->
<?php }?>