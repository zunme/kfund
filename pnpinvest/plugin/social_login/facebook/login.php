<?php
include_once('./_Common_execute_class.php');


require_once(MARI_PLUGIN_PATH.'/social_login/facebook/facebook.php');

$config = array(
	'appId' => FACEBOOK_CONSUMER_KEY,
	'secret' => FACEBOOK_CONSUMER_SECRET
);

$facebook = new Facebook($config);

$user = $facebook->getUser();

if (!$user){
	$params = array(
		'scope' => 'email,publish_actions',
		'redirect_uri' => FACEBOOK_OAUTH_CALLBACK
	);

	$loginUrl = $facebook->getLoginUrl($params);
	header('Location: '.$loginUrl);
	break;


}else{
	goto_url(MARI_HOME_URL.'/?mode=callback&m_id='.$_SESSION[ss_m_id].'');
    break;
}


?>