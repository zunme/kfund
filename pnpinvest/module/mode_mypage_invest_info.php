<?php
$login_ck        = "YES";
$sql             = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
$laon_count      = sql_fetch($sql);
$total_laon      = $laon_count['cnt'];
$rows            = "10";
$total_laon_page = ceil($total_laon / $rows);
if ($page < 1)
    $page = 1;
$from_record       = ($page - 1) * $rows;
$sql               = " select * from mari_invest where m_id='$user[m_id]' order by i_regdatetime desc limit $from_record, $rows ";
$laon              = sql_query($sql);
$sql               = " select count(*) as cnt from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc";
$order_s_count     = sql_fetch($sql);
$total_order_s     = $order_s_count['cnt'];
$rows              = "10";
$total_orders_page = ceil($total_order_s / $rows);
if ($page < 1)
    $page = 1;
$from_record   = ($page - 1) * $rows;
$sql           = " select * from mari_order where  sale_id='$user[m_id]' order by o_count asc, o_collectiondate desc limit $from_record, $rows ";
$order_s       = sql_query($sql);
$sql           = " select * from mari_order where  sale_id='$user[m_id]' order by o_collectiondate desc limit 6";
$order_w       = sql_query($sql);
$sql           = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
$seyck         = sql_fetch($sql, false);
$sql           = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
$invest_count  = sql_fetch($sql);
$total_invest  = $invest_count['cnt'];
$sql           = "select sum(i_pay) from mari_invest where m_id='$user[m_id]'";
$player_top    = sql_query($sql, false);
$playeramount  = mysql_result($player_top, 0, 0);
$sql           = "select sum(i_profit_rate) from mari_invest where m_id = '$user[m_id]'";
$top_invest    = sql_query($sql, false);
$t_invest_plus = mysql_result($top_invest, 0, 0);
if ($invest_plus['cnt']) {
    $top_invest_plus = floor($t_invest_plus / $total_invest);
}
?>
