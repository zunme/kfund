<?php
if (!defined('_MARICMS_')) exit; 

/*setting4 config설정에서 페이스북 아이디와 SECRET입력값을 사용함*/
define('FACEBOOK_CONSUMER_KEY', ''.$config[c_facebook_appid].'');
define('FACEBOOK_CONSUMER_SECRET', ''.$config[c_facebook_secret].'');
//define('FACEBOOK_CONSUMER_KEY', '');
//define('FACEBOOK_CONSUMER_SECRET', '');
define('FACEBOOK_LOGIN', MARI_PLUGIN_URL.'/social_login/facebook/login.php');
define('FACEBOOK_OAUTH_CALLBACK', MARI_PLUGIN_URL.'/social_login/facebook/callback.php');


define('SO_PASSWORD', '$z!'); //소셜로그인 패스워드

define('SO_M_LEVEL', ''.$config[c_memregi_level].'');
define('SO_M_MAILLING', '1');
define('SO_M_SMS', '0');
define('SO_M_OPEN', '1');
define('SO_M_ADULT', '0');

/*id중복체크*/
function sl_id_check($sns)
{
	global $mari;
	$id = $sns.mt_rand(100000000000000,1000000000000000);
	$row = sql_fetch(" select count(*) as cnt from mari_member where m_id = '".$id."' ");
    if ($row['cnt']) return sl_id_check($sns);
	else return $id;
}

/*닉네임중복체크*/
function sl_nick_check($nick)
{
	global $mari;
    $row = sql_fetch(" select count(*) as cnt from mari_member where m_nick = '".$nick."' ");
    if ($row['cnt']) return sl_nick_check($nick.mt_rand(10,100));
	else return $nick;
}

function sl_sns($type)
{
	if ($type == 'facebook')
		return '페이스북';
}

function sl_register($m)
{
	global $mari;
	
	if (!$m) return FALSE;
	
	$sql = " insert into mari_member
					set m_id = '".$m['m_id']."',
						m_password = '".md5($m['m_password'])."',
						m_name = '".$m['m_name']."',
						m_nick = '".$m['m_nick']."',
						m_email = '".$m['m_email']."',
						m_homepage = '".$m['m_homepage']."',
						m_profile = '".$m['m_profile']."',
						m_today_login = '".MARI_TIME_YMDHIS."',
						m_datetime = '".MARI_TIME_YMDHIS."',
						m_ip = '".$_SERVER['REMOTE_ADDR']."',
						m_level = '".SO_M_LEVEL."',
						m_login_ip = '".$_SERVER['REMOTE_ADDR']."',
						m_mailling = '".SO_M_MAILLING."',
						m_sms = '".SO_M_SMS."',
						m_open = '".SO_M_OPEN."',
						m_open_date = '".MARI_TIME_YMD."',
						m_key = '".$m['m_key']."',
						m_fb = '".$m['m_fb']."',
						m_email_certify = '".MARI_TIME_YMDHIS."' ";
	sql_query($sql);
	return TRUE;
}

function sl_login($id, $sns)
{
	global $mari;
    global $config;
    
	$row = sql_fetch(" select m_id from mari_member  where m_key = '".$id."' and m_fb = '".$sns."' ");
	$m = get_member($row['m_id']);
	
	set_session('ss_m_id', $m['m_id']); //회원아이디 세션 생성
	set_session('ss_m_key', md5($m['m_datetime'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT'])); //XSS 공격

	goto_url(MARI_HOME_URL.'/?mode=callback&m_id='.$_SESSION[ss_m_id].'');

}


?>