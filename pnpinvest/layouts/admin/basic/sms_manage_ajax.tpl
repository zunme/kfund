<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN sms 저장메세지 ajax
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<script type="text/javascript" src="http://www.intowinsoft.co.kr/play/sms/js/jquery.sms.js"></script>
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/check.js"></script>



	<?
	for ($i=0; $i<$list_total; $i++){

	$msg=$list[$i]["msg"];
	$idx=$list[$i]["sm_idx"];
				
	$list_string = "<li>
					<div class=\"message_box\">
						<textarea name=\"capy_msg\" id=\"$idx\" style=\"cursor:pointer;\" onclick=\"copy_msg(this.value);\" onkeyup=\"updateChar($byte,$idx, 'chkBite');\">$msg</textarea>
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

<div class="ml30 mt15 txt_c" style="padding-bottom:100px;">
 <? if($sm_type == 5){?>
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=lms_manage'.$qstr.'&amp;page='); ?>
 <? }else if($sm_type == 6){?><!--mms-->
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=lms_manage'.$qstr.'&amp;page='); ?>
 <? }else{?>
<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms=sms_manage'.$qstr.'&amp;page='); ?>
 <? }?>
 </div>

