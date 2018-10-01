<?php
/************************************************
Constant declaration
************************************************/
define('MARI_VERSION', 'MARICMS');

define('_MARICMS_', true);

/************************************************
PHP VERSION / ASIA,SEOUL
************************************************/

if (PHP_VERSION >= '5.1.0') {
    date_default_timezone_set("Asia/Seoul");
}


/********************
    상점코드config - 세팅시 DB정보를 넣어줘야함
********************/
include_once('data/ini_config.php');



define('MARI_DOMAIN', '');
define('MARI_HTTPS_DOMAIN', '');
define('MARI_COOKIE_DOMAIN',  '');
/************************************************
Directory declaration
************************************************/
/*dbconnect*/
define('MARI_DBCONFIG_FILE',  'dbconnect.php');
/*ADMIN*/
define('MARI_ADMIN_DIR',      'admin');
/*BBS*/
define('MARI_BBS_DIR',        'bbs');
/*INDSERT , UPDATE*/
	define('MARI_SQL_DIR',    'sql');
/*SELECT*/
	define('MARI_VIEW_DIR',    'view');
define('MARI_LIB_DIR',        'core');
/*STYLE CSS*/
define('MARI_CSS_DIR',        'css');
/*DATA*/
define('MARI_DATA_DIR',       'data');
	define('MARI_SESSION_DIR',    'session');
/*IMAGE*/
define('MARI_IMG_DIR',        'img');
/*layouts*/
define('MARI_LAYOUTS_DIR',        'layouts');
/*INCLIDE*/
define('MARI_INC_DIR',        'inc');
/*BOARD*/
define('MARI_BOARD_DIR',        'board');
define('MARI_HOMESKIN_DIR',        'home');
define('MARI_MOBILESKIN_DIR',        'mobile');
define('MARI_ADMINSKIN_DIR',        'admin');
define('MARI_MAILSKIN_DIR',        'formmail');
define('MARI_LATESTSKIN_DIR',        'latest');
define('MARI_LOGINSKIN_DIR',        'login');
define('MARI_MEMBERSKIN_DIR',        'member');
define('MARI_POPUPSKIN_DIR',        'popup');
/*JS, Jquery*/
define('MARI_JS_DIR',         'js');
/*PLUGIN*/
define('MARI_PLUGIN_DIR',     'plugin');
	define('MARI_EDITOR_DIR',     'editor');
	define('MARI_LGDACOM_DIR',    'lgdacom');
	define('MARI_MAIL_DIR',  'PHPMailer_v2.0.4');
/*API Setting*/
define('MARI_API_DIR',       'api');
/*skin, template*/
define('MARI_SKIN_DIR',       'skin');
/*Version Declaration*/
define('MARI_VAR_DIR',     'var');

if (MARI_DOMAIN) {
    define('MARI_HOME_URL', MARI_DOMAIN);
} else {
    if (isset($mari_path['url']))
        define('MARI_HOME_URL', $mari_path['url'].'/'.$sale['sale_code']);
    else
        define('MARI_HOME_URL', '');
}
if (isset($mari_path['path'])) {
    define('MARI_PATH', $mari_path['path']);
} else {
    define('MARI_PATH', '');
}
define('MARI_ADMIN_URL',      MARI_HOME_URL.'/'.MARI_ADMIN_DIR);
define('MARI_B_URL',        MARI_HOME_URL.'/'.MARI_BBS_DIR);
define('MARI_CSS_URL',        MARI_HOME_URL.'/'.MARI_CSS_DIR);
define('MARI_DATA_URL',       MARI_HOME_URL.'/'.MARI_DATA_DIR);
define('MARI_IMG_URL',        MARI_HOME_URL.'/'.MARI_IMG_DIR);
define('MARI_INC_URL',        MARI_HOME_URL.'/'.MARI_INC_DIR);
define('MARI_JS_URL',         MARI_HOME_URL.'/'.MARI_JS_DIR);
define('MARI_SKIN_URL',       MARI_HOME_URL.'/'.MARI_SKIN_DIR);
define('MARI_PLUGIN_URL',     MARI_HOME_URL.'/'.MARI_PLUGIN_DIR);
define('MARI_CAPTCHA_URL',    MARI_PLUGIN_URL.'/'.MARI_CAPTCHA_DIR);
define('MARI_EDITOR_URL',     MARI_PLUGIN_URL.'/'.MARI_EDITOR_DIR);
define('MARI_OKNAME_URL',     MARI_PLUGIN_URL.'/'.MARI_OKNAME_DIR);
define('MARI_LGDACOM_URL',    MARI_PLUGIN_URL.'/'.MARI_LGDACOM_DIR);
define('MARI_SNS_URL',        MARI_PLUGIN_URL.'/'.MARI_SNS_DIR);
define('MARI_SYNDI_URL',      MARI_PLUGIN_URL.'/'.MARI_SYNDI_DIR);
define('MARI_SQL_URL',     MARI_HOME_URL.'/'.MARI_SQL_DIR);
define('MARI_LAYOUTS_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR);
define('MARI_PLUGIN_URL',     MARI_HOME_URL.'/'.MARI_PLUGIN_DIR);
define('MARI_ADMINSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_ADMINSKIN_DIR.'/'.$img['c_admin_skin']);
define('MARI_MOBILESKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_MOBILESKIN_DIR.'/'.$img['c_mobile_skin']);
define('MARI_HOMESKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_HOMESKIN_DIR.'/'.$img['c_home_skin']);
define('MARI_MEMBERSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_MEMBERSKIN_DIR.'/'.$img['c_member_skin']);
define('MARI_LOGINSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_LOGINSKIN_DIR.'/'.$img['c_login_skin']);
define('MARI_MAILSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_MAILSKIN_DIR.'/'.$img['c_formmail_skin']);
define('MARI_POPUPSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_POPUPSKIN_DIR.'/'.$popup['po_skin']);
define('MARI_LATESTSKIN_URL',     MARI_HOME_URL.'/'.MARI_LAYOUTS_DIR.'/'.MARI_LATESTSKIN_DIR.'/'.$img['c_latest_skin']);


define('MARI_VIEW_URL',     MARI_HOME_URL.'/'.MARI_VIEW_DIR);
define('MARI_API_URL',     MARI_HOME_URL.'/'.MARI_API_DIR);

// PATH 는 서버상에서의 절대경로
define('MARI_ADMIN_PATH',     MARI_PATH.'/'.MARI_ADMIN_DIR);
define('MARI_BBS_PATH',       MARI_PATH.'/'.MARI_BBS_DIR);
define('MARI_DATA_PATH',      MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_DATA_DIR);

define('MARI_VAR_PATH',    MARI_PATH.'/'.MARI_VAR_DIR);
define('MARI_LIB_PATH',       MARI_PATH.'/'.MARI_LIB_DIR);

define('MARI_INC_PATH',      MARI_PATH.'/'.MARI_ONC_DIR);
define('MARI_PLUGIN_PATH',    MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_PLUGIN_DIR);
define('MARI_SKIN_PATH',      MARI_PATH.'/'.MARI_SKIN_DIR);
define('MARI_MOBILE_PATH',    MARI_PATH.'/'.MARI_MOBILE_DIR);
define('MARI_SESSION_PATH',   MARI_DATA_PATH.'/'.MARI_SESSION_DIR);
define('MARI_CAPTCHA_PATH',   MARI_PLUGIN_PATH.'/'.MARI_CAPTCHA_DIR);
define('MARI_EDITOR_PATH',    MARI_PLUGIN_PATH.'/'.MARI_EDITOR_DIR);
define('MARI_OKNAME_PATH',    MARI_PLUGIN_PATH.'/'.MARI_OKNAME_DIR);
define('MARI_LGDACOM_PATH',   MARI_PLUGIN_PATH.'/'.MARI_LGDACOM_DIR);
define('MARI_MAIL_PATH', MARI_PLUGIN_PATH.'/'.MARI_MAIL_DIR);
define('MARI_SQL_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_SQL_DIR);
define('MARI_LAYOUTS_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR);
define('MARI_VIEW_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_VIEW_DIR);
define('MARI_API_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_API_DIR);
define('MARI_BOARDSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR);
define('MARI_HOMESKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_HOMESKIN_DIR.'/'.$img['c_home_skin']);
define('MARI_ADMINSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_ADMINSKIN_DIR.'/'.$img['c_admin_skin']);
define('MARI_FORMMAILSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_FORMMAILSKIN_DIR.'/'.$img['c_formmail_skin']);
define('MARI_LATESTSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_LATESTSKIN_DIR.'/'.$img['c_latest_skin']);
define('MARI_LOGINSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_LOGINSKIN_DIR.'/'.$img['c_login_skin']);
define('MARI_MEMBERSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_MEMBERSKIN_DIR.'/'.$img['c_member_skin']);
define('MARI_POPUPSKIN_PATH',     MARI_PATH.'/'.$sale['sale_code'].'/'.MARI_LAYOUTS_DIR.'/'.MARI_POPUPSKIN_DIR.'/'.$popup['po_skin']);
//==============================================================================

/************************************************
Time constant
************************************************/
// 서버의 시간과 실제 사용하는 시간이 틀린 경우 수정하세요.
// 하루는 86400 초입니다. 1시간은 3600초
// 6시간이 빠른 경우 time() + (3600 * 6);
// 6시간이 느린 경우 time() - (3600 * 6);
define('MARI_SERVER_TIME',    time());
define('MARI_TIME_YMDHIS',    date('Y-m-d H:i:s', MARI_SERVER_TIME));
define('MARI_TIME_YMD',       substr(MARI_TIME_YMDHIS, 0, 10));
define('MARI_TIME_HIS',       substr(MARI_TIME_YMDHIS, 11, 8));

// 입력값 검사 상수 (숫자를 변경하시면 안됩니다.)
define('MARI_ALPHAUPPER',      1); // 영대문자
define('MARI_ALPHALOWER',      2); // 영소문자
define('MARI_ALPHABETIC',      4); // 영대,소문자
define('MARI_NUMERIC',         8); // 숫자
define('MARI_HANGUL',         16); // 한글
define('MARI_SPACE',          32); // 공백
define('MARI_SPECIAL',        64); // 특수문자

/*Permission*/
define('MARI_DIR_PERMISSION',  0755); // 디렉토리 생성시 퍼미션
define('MARI_FILE_PERMISSION', 0644); // 파일 생성시 퍼미션

// SMTP
// lib/mailer.lib.php 에서 사용
define('MARI_SMTP', '127.0.0.1');


/************************************************
Other constants
************************************************/

// SQL 에러를 표시할 것인지 지정
// 에러를 표시하지 않으려면 FALSE 로 변경
define('MARI_DISPLAY_SQL_ERROR', TRUE);

// escape string 처리 함수 지정
// POST 등에서 한글이 깨질 경우 addslashes 로 변경
define('MARI_ESCAPE_FUNCTION', 'mysql_real_escape_string');

// 썸네일 jpg Quality 설정
define('MARI_THUMB_JPG_QUALITY', 90);

// ip 숨김방법 설정
/* 123.456.789.012 ip의 숨김 방법을 변경하는 방법은
\\1 은 123, \\2는 456, \\3은 789, \\4는 012에 각각 대응되므로
표시되는 부분은 \\1 과 같이 사용하시면 되고 숨길 부분은 ♡등의
다른 문자를 적어주시면 됩니다.
*/
define('MARI_IP_DISPLAY', '\\1.♡.\\3.\\4');
?>