
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 팝업
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

<script>
<!--
	function goUrl(url){
	opener.top.ifrm.location.href=url;
	self.close();}
	-->
</script>

<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>

<?php for ($i=0;  $row=sql_fetch_array($popuproof); $i++){?>
	<?php if($row[po_openchk]=="1" && $row[po_end_date] >= $date){?>
	<?php if (trim($_COOKIE["it_ck_pop_".$row[po_id]]) != "done") {?>
	  <script type="text/javascript" src="{MARI_POPUPSKIN_URL}/popup_control.js"></script>
			<div class="popup1"  id="pop<?=$row[po_id];?>" style="position: absolute;
    top: 100px;">
				<div class="popup1_inner">
					<div class="pop_cont1" style="width:100%">
					<?php echo $row[po_content];?>
					</div>
					<div class="pop_btm1">
						<input type="checkbox" id="expirehours<?=$row[po_id];?>" name="expirehours<?=$row[po_id];?>" value="<?php echo $row[po_expirehours];?>"> <label for=""><?php if($row[po_expirehours]=="24"){?>하루
				<?php }else if($row[po_expirehours]=="168"){?>일주일<?}else{?><?=$row[po_expirehours];?>시간<? } ?> 동안 이 창을 다시 열지 않음 </label>
						<a href="javascript:layer_close(<?=$row[po_id];?><?php echo $row[po_actc]?",'$row[po_actc]'":"";?>)">CLOSE </a>					
					</div>
				</div>
			</div><!-- /popup1 -->
	<?php }?>
	<?php }?>
<?php }?>

<?php }else{?>

<?php for ($i=0;  $row=sql_fetch_array($popuproof); $i++){?>
	<?php if($row[po_openchk]=="1" && $row[po_end_date] >= $date){?>
	<?php if (trim($_COOKIE["it_ck_pop_".$row[po_id]]) != "done") {?>
	  <script type="text/javascript" src="{MARI_POPUPSKIN_URL}/popup_control.js"></script>
			<div class="popup1"  id="pop<?=$row[po_id];?>" style="position:absolute; <?php if($row[po_top]){?>top:<?php echo $row[po_top];?>px;<?php }?> <?php if($row[po_left]){?>left:<?php echo $row[po_left];?>px;<?php }?> <?php if($row[po_width]){?>width:<?php echo $row[po_width];?>px;<?php }?>">
				<div class="popup1_inner">
					<div class="pop_cont1" style="<?php if($row[po_height]){?>height:<?php echo $row[po_height];?>px;<?php }?>" >
					<?php echo $row[po_content];?>
					</div>
					<div class="pop_btm1">
						<input type="checkbox" id="expirehours<?=$row[po_id];?>" name="expirehours<?=$row[po_id];?>" value="<?php echo $row[po_expirehours];?>"> <label for=""><?php if($row[po_expirehours]=="24"){?>하루
				<?php }else if($row[po_expirehours]=="168"){?>일주일<?}else{?><?=$row[po_expirehours];?>시간<? } ?> 동안 이 창을 다시 열지 않음 </label>
						<a href="javascript:layer_close(<?=$row[po_id];?><?php echo $row[po_actc]?",'$row[po_actc]'":"";?>)">CLOSE </a>					
					</div>
				</div>
			</div><!-- /popup1 -->
	<?php }?>
	<?php }?>
<?php }?>

<?}?>





