<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
 <head>
  <title> {_config['c_title']} |  이용약관 </title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css">

 </head>

 <body>
	<div class="terms_wrap">
		<div class="terms_logo"><img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_logo'];?>" alt="{_config['c_title']}" /></div>
		<ul class="tab_btn2">
			<li ><a href="{MARI_HOME_URL}/?mode=common3">이용약관</a></li>
			<li><a href="{MARI_HOME_URL}/?mode=common1">개인정보처리 방침</a></li>
			<li class="tab_on2"><a href="{MARI_HOME_URL}/?mode=common2">투자약관</a></li>	
		</ul>

		<div class="tab_cont2 terms_cont1">
			<?php echo $conf['c_stipulation']; ?>			
		</div>
	</div><!-- /terms_wrap -->

 </body>
</html>
