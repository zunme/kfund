<?php
/****************************************************
MASTER SERVER 수정금지
****************************************************/
$master_host     = MARI_MYSQL_HOST;
$master_user     = MARI_MYSQL_USER;
$master_password = MARI_MYSQL_PASSWORD;
$master_db       = MARI_MYSQL_DB;

$con_master = mysql_connect($master_host, $master_user, $master_password) or die("MASTER MySQL 서버에 연결할 수 없습니다.");

mysql_select_db($master_db, $con_master);
?>