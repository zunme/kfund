<?php
define('_MARICMS_','OK');
include(getcwd()."/pnpinvest/data/dbconnect.php");

$Us = './pnpinvest'; //이동경로
$Ds = (strpos($Us,'?') !== false) ? '&' : '?';
$Qs = ($_SERVER['QUERY_STRING'] ? $Ds.$_SERVER['QUERY_STRING'] : '');
if ( ! session_id() ) @ session_start();
$memid = isset($_SESSION['ss_m_id']) ? $_SESSION['ss_m_id'] : '';
$referer = (isset($_SERVER['HTTP_REFERER']) ) ? $_SERVER['HTTP_REFERER'] : '';

if( isset($_SERVER['HTTP_REFERER']) && $_SERVER['HTTP_REFERER'] !='' ) {
  $referearr = parse_url($_SERVER['HTTP_REFERER']);
  if( isset($referearr['host']) &&  $referearr['host'] !='kfunding.co.kr' &&  $referearr['host'] !='nice.checkplus.co.kr' && $referearr['host'] !='cert.vno.co.kr' && $referearr['host'] != 'localhost'){
      $_SESSION['org_referer'] = $_SERVER['HTTP_REFERER'];
      $connect_db = @mysql_connect(MARI_MYSQL_HOST, MARI_MYSQL_USER, MARI_MYSQL_PASSWORD) or die('MySQL Connect Error!!!');
      $select_db  = @mysql_select_db(MARI_MYSQL_DB, $connect_db) or die('MySQL DB Error!!!');
      @mysql_query(" set names utf8 ");

      $sql = "select * from z_referer where cookie = '".session_id()."' and regdate > SUBDATE(NOW(), INTERVAL 10 SECOND) limit 1";

      $result = @mysql_query($sql);
      $row = @mysql_fetch_assoc($result);
      if( $row == false ) {
        $sql = "insert into z_referer (cookie, memid, referer) values ('".session_id()."', '".$memid."' , '". $referer ."' )";
        @mysql_query($sql);
      }
  }
}

header('Location: '.$Us.$Qs);
exit;
?>
<!DOCTYPE html>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 머니플러스 Ver 1.1.0
┗━━━━━━━━━━━━━━━━━━━━━━━┛
//-->
<html lang="ko">
<head>
<title>케이펀딩</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="keywords" content="엔젤펀딩, 피앤피, p2p 대출솔루션, 대출솔루션, p2p투자, p2p펀딩, 일반대출, 담보대출, 웹 솔루션, 대출p2p, 크라우드펀딩, 엔젤투자, p2p금융솔루션, 대출p2p솔루션, 크라우드펀딩 솔루션, 핀테크 솔루션, 대출 중계솔루션, p2p 대출중개, 소자본창업, 대부업, 금융운영, 머니플러스, 머니플러스 솔루션" ><!--HTML 상단 검색 키워드소스 content=""-->
<meta name="description" content="부동산전문 P2P대출기업, 중저금리대출, 건축자금및신용대출전문, P2P투자전문" ><!--HTML 상단 검색설명소스 content=""-->

<meta property="og:type" content="http://www.kfunding.co.kr/">
<meta property="og:title" content="엔젤펀딩">
<meta property="og:description" content="부동산전문 P2P대출기업, 중저금리대출, 건축자금및신용대출전문, P2P투자전문">
<meta property="og:image" content="http://www.kfunding.co.kr/pnpinvest/data/favicon/logo(2)_sub.png">
<meta property="og:url" content="http://www.kfunding.co.kr/">
<link rel="canonical" href="http://www.kfunding.co.kr/">
</head>
<body >
<script type="text/javascript">
document.write("<meta http-equiv='refresh' content='0; url=./pnpinvest'>");
</script>

</body >
</html>
