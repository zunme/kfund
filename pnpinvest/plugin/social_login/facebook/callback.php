<?php
include_once('./_Social_common.php');

require_once(MARI_PLUGIN_PATH.'/social_login/facebook/facebook.php');

$config = array(
	'appId' => FACEBOOK_CONSUMER_KEY,
	'secret' => FACEBOOK_CONSUMER_SECRET
);

$facebook = new Facebook($config);

$user = $facebook->getUser();

if ($user){
	try{
        $content = $facebook->api('/me');
		//print_r($content);
		//exit;
		
		$str = "<a href='".$content['link']."' target='_blank'>".$content['first_name']."</a>
				<font style='color:#c5c5c5'>(".($content['gender']=='female'?'♀':'♂').")</font><br>
				<font style='color:#a1a1a1'>".str_replace('@', ' (at) ', $content['email'])."</font>";
		
		
		
		$row = sql_fetch(" select count(*) as cnt from mari_member where m_key = '".$content['id']."' and m_fb = 'facebook' ");
		if ($row['cnt']){

			sl_login($content['id'], 'facebook');

			//소셜로그인
			set_session('sl_id', $content['id']);
			set_session('sl_sns', 'facebook');
			set_session('sl_str', $str);
			set_session('sl_picture', 'https://graph.facebook.com/'.$content['id'].'/picture');
			goto_url(MARI_HOME_URL.'/?mode=callback&m_id='.$_SESSION[ss_m_id].'');
			
			
		}else{
/*
			$row = sql_fetch(" select count(*) as cnt from mari_member where m_email = '".$content['email']."' ");
	    	if ($row['cnt']) alert('이미 사용중인 E-mail 주소입니다.', '/');
*/
			$fb_user = array(
				'm_id' => sl_id_check('facebook'),
				'm_password' => SO_PASSWORD.$content['id'],
				'm_email' => $content['email'],
				'm_name' => str_replace(' ', '', $content['name']),
				'm_nick' => sl_nick_check(str_replace(' ', '', $content['first_name'])),
				'm_homepage' => $content['link'],
				'm_key' => $content['id'], 
				'm_fb' => 'facebook'
			);
			
			$result = sl_register($fb_user); //회원가입
			if ($result){
				
				sl_login($content['id'], 'facebook');
				
				//소셜로그인
				set_session('sl_id', $content['id']);
				set_session('sl_sns', 'facebook');
				set_session('sl_str', $str);
				set_session('sl_picture', 'https://graph.facebook.com/'.$content['id'].'/picture');
			}
		}
		
		


    }catch(FacebookApiException $e) {
        error_log($e);
        $user = NULL;
    }
}else{
	//die('Error');
	goto_url(MARI_HOME_URL.'/?mode=callback&m_id='.$_SESSION[ss_m_id].'');
    break;
}


?>