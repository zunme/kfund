<?php
/****************************************************
세팅시 서비스할 상점아이디를 넣어줘야합니다
****************************************************/
$service_name='pnpinvest';
/****************************************************
세팅시 서비스할 상점아이디를 넣어줘야합니다
****************************************************/
$mysql_sale_host     = 'localhost';
$mysql_sale_user     = 'user01';
$mysql_sale_password = 'user015754!@#';
$mysql_sale_db       = 'user01';

$connect = mysql_connect($mysql_sale_host, $mysql_sale_user, $mysql_sale_password) or die('MySQL 서버에 연결할 수 없습니다.');
mysql_select_db($mysql_sale_db, $connect);

$query = 'SELECT * from mari_mysevice_config';
mysql_query('SET NAMES utf8');
$result = mysql_query($query);
$sale = mysql_fetch_array($result);
/****************************************************
라이센스키 체크 주의! 해당 쿼리삭제시 서비스이용불가
****************************************************/
$query = 'SELECT license_key, sale_code from mari_mysevice_config';
mysql_query('SET NAMES utf8');
$result = mysql_query($query);
$license_user = mysql_fetch_array($result);
$lc_key_user=$license_user[license_key];
$lc_sale_user=$license_user[sale_code];
/****************************************************
설정된 스킨및 레이아웃이미지
****************************************************/
$query = 'SELECT * from mari_config';
mysql_query('SET NAMES utf8');
$result = mysql_query($query);
$img = mysql_fetch_array($result);

$query = 'SELECT * from mari_popup';
mysql_query('SET NAMES utf8');
$resultp = mysql_query($query);
$popup = mysql_fetch_array($resultp);
?>