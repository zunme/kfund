<?php
if($_GET['file_add']=="yes"){

include_once('./_Common_execute_class.php');


include_once (MARI_ADMIN_PATH.'/inc/admin_header.php');
}else{
echo"
<SCRIPT language=JavaScript charset='utf-8'>
window.location.reload('./filemanager.php?file_add=yes');
</SCRIPT>
";
}
?>

<div id="wrapper">
	<div id="left_container">
<?php include(MARI_ADMIN_PATH.'/inc/left_bar.php');?>
		<div class="lnb_wrap">
			<div class="title01">파일매니저</div>
<?php include(MARI_ADMIN_PATH.'/inc/lnb.php');?>

		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
<?php
include_once('class/FileManager.php');
?>
<?php

$FileManager = new FileManager();
print $FileManager->create();

?>
    </div><!-- /contaner -->
</div><!-- /wrapper -->
<?
if($_GET['file_add']=="yes"){
include_once (MARI_ADMIN_PATH.'/inc/admin_footer.php');
}
?>