<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Web page error</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<?php
    echo '<meta http-equiv="imagetoolbar" content="no">'.PHP_EOL;
	if($config['compatible']=="Y"){
    echo '<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">'.PHP_EOL;
	}
    echo '<link rel="SHORTCUT ICON" href="'.MARI_DATA_URL.'/favicon/'.$config['bn_id'].'">'.PHP_EOL;
?>
<link rel="stylesheet" href="{MARI_MOBILESKIN_URL}/css/style.css" type="text/css"><!--core-->
</head>
<body <?php echo isset($mari['body_script']) ? $mari['body_script'] : ''; ?> <?php if($config['right_mouse'] == 'Y'){?> oncontextmenu="return false"<?php } ?> <?php if($config['frame_url'] == 'Y'){?>ondragstart="return false"<?php } ?> <?php if($config['page_notdrag'] == 'Y'){?>onselectstart="return false"<?php } ?>>
<div id="wrap">
	<div id="container">
		<div class="error">
		<img src="{MARI_MOBILESKIN_URL}/img/Webpage_error.jpg">
		</div>
	</div><!--//container-->
</div>

</body>
</html>
