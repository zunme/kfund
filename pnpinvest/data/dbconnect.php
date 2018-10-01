<?php
if (!defined('_MARICMS_')) exit;
define('MARI_MYSQL_HOST', 'localhost');
define('MARI_MYSQL_USER', 'user01');
define('MARI_MYSQL_PASSWORD', 'user015754!@#');
define('MARI_MYSQL_DB', 'user01');
define('MARI_MYSQL_SET_MODE', false);
define('MARI_TABLE_PREFIX', 'mari_');
$mari['write_prefix'] = MARI_TABLE_PREFIX.'write_'; // 게시판 테이블명 접두사
$mari['config_table'] = MARI_TABLE_PREFIX.'config'; // 기본환경 설정 테이블
$mari['group_table'] = MARI_TABLE_PREFIX.'board_group'; // 게시판 그룹 테이블
$mari['board_table'] = MARI_TABLE_PREFIX.'board'; // 게시판 설정 테이블
$mari['board_file_table'] = MARI_TABLE_PREFIX.'board_file'; // 게시판 첨부파일 테이블
$mari['board_write_table'] = MARI_TABLE_PREFIX.'write'; // 게시물 테이블
$mari['mail_table'] = MARI_TABLE_PREFIX.'mail'; // 회원메일 테이블
$mari['member_table'] = MARI_TABLE_PREFIX.'member'; // 회원 테이블
$mari['member_leave_table'] = MARI_TABLE_PREFIX.'member_leave'; // 탈퇴회원 테이블
$mari['emoney_table'] = MARI_TABLE_PREFIX.'emoney'; // 이머니 테이블
$mari['popular_table'] = MARI_TABLE_PREFIX.'popular'; // 인기검색어 테이블
$mari['session_table'] = MARI_TABLE_PREFIX.'session'; // 세션 테이블
$mari['content_table'] = MARI_TABLE_PREFIX.'content'; // 내용(컨텐츠)정보 테이블
$mari['mysevice_config_table'] = MARI_TABLE_PREFIX.'mysevice_config'; // 나의서비스관리 테이블
$mari['analytics_config_table'] = MARI_TABLE_PREFIX.'analytics_config'; // 로그분석-에널리틱스관리 테이블
$mari['debt_table'] = MARI_TABLE_PREFIX.'debt'; // 대출상품 테이블
$mari['inset_table'] = MARI_TABLE_PREFIX.'inset'; // 투자한도연체이자율설정 테이블
$mari['invest_table'] = MARI_TABLE_PREFIX.'invest'; // 투자(결제관리) 테이블
$mari['invest_progress_table'] = MARI_TABLE_PREFIX.'invest_progress'; // 대출(진행중인투자) 테이블
$mari['loan_table'] = MARI_TABLE_PREFIX.'loan'; // 대출(대출신청) 테이블
$mari['pg_table'] = MARI_TABLE_PREFIX.'pg'; // PG사설정 테이블
$mari['contact_item_table'] = MARI_TABLE_PREFIX.'contact_item'; // 상품분류 테이블
$mari['outpay_table'] = MARI_TABLE_PREFIX.'outpay'; // 출금신청 테이블
$mari['char_table'] = MARI_TABLE_PREFIX.'char'; // 충전내역 테이블
$mari['order_table'] = MARI_TABLE_PREFIX.'order'; // 대출,투자자 정산테이블
$mari['log_table'] = MARI_TABLE_PREFIX.'log'; // 로그분선 테이블
$mari['log_sum_table'] = MARI_TABLE_PREFIX.'log_sum'; // 로그누적접속수 테이블
$mari['category'] = MARI_TABLE_PREFIX.'category'; // 카테고리 테이블
$mari['viewcomment'] = MARI_TABLE_PREFIX.'viewcomment'; // invest댓글 테이블
?>