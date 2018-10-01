<?php
if (!defined('_MARICMS_')) exit;
?>
<?php if(!$config['c_dot_type']){?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<?php }else{?>
<?php echo $config['c_dot_type'];?>
<?php }?>
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title><?php echo $config['c_title'];?></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<?php
    echo '<meta http-equiv="imagetoolbar" content="no">'.PHP_EOL;
	if($config['compatible']=="Y"){
    echo '<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">'.PHP_EOL;
	}
    //echo '<link rel="SHORTCUT ICON" href="'.MARI_DATA_URL.'/favicon/'.$config['bn_id'].'">'.PHP_EOL;
if($config['c_add_meta'])
    echo $config['c_add_meta'].PHP_EOL;
if (defined('MARI_IS_ADMIN')) {
    echo '<link rel="stylesheet" href="'.MARI_ADMIN_URL.'/css/admin.css">'.PHP_EOL;
}
?>
<link rel="SHORTCUT ICON" href="https://www.kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta name="google-site-verification" content="wFlJBNsJ9EcCuDtiz8gnIcdhqess5G-zrN6iGCyLbqs" />
</head>
<body <?php echo isset($mari['body_script']) ? $mari['body_script'] : ''; ?> <?php if($config['right_mouse'] == 'Y'){?> oncontextmenu="return false"<?php } ?> <?php if($config['frame_url'] == 'Y'){?>ondragstart="return false"<?php } ?> <?php if($config['page_notdrag'] == 'Y'){?>onselectstart="return false"<?php } ?>>
