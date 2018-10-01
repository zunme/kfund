<?php
$sql_common = " from mari_write ";
$sql_search = " where (1) ";
if ($stx) {
    $sql_search .= " and ( ";
    $sql_search .= " ($sfl like '$stx%') ";
    $sql_search .= " ) ";
}
if(isset($search) && trim($search)!=''){
  $query = htmlspecialchars($search);
  $query = mysql_real_escape_string($query);

  $sql_search .= " and w_subject like '%$query%' ";
}
if (!$sst) {
    $sst = $bbs_config['bo_sort_field'];
}
$sql_order   = " order by $sst $sod ";
$sql         = " select count(*) as cnt $sql_common $sql_search  and (w_table='$table') $sql_order ";
$row         = sql_fetch($sql);
$total_count = $row['cnt'];
if (!$bbs_config['bo_page_rows']) {
    $rows = $config['c_page_rows'];
} else {
    $rows = $bbs_config['bo_page_rows'];
}
$total_page = ceil($total_count / $rows);
if ($page < 1)
    $page = 1;
$from_record = ($page - 1) * $rows;
$sql         = " select * $sql_common $sql_search and (w_table='$table') $sql_order limit $from_record, $rows ";
$result      = sql_query($sql);
$colspan     = 16;
?>
