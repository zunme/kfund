<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 파일매니저
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">디자인관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
	<div class="title02">파일매니저 </div>
<?php
include(MARI_PLUGIN_PATH.'/filemanager/class/FileManager.php');
?>
<?php

$FileManager = new FileManager();
print $FileManager->create();

?>

    </div><!-- /contaner -->
</div><!-- /wrapper -->
{# s_footer}<!--하단-->