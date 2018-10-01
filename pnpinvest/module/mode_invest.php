<?php
$sql            = "select * from mari_category order by ca_pk asc";
$depth_list     = sql_query($sql, false);
$sql            = "select * from mari_category where ca_id='$ca_id' order by ca_pk asc";
$depth_sublist  = sql_query($sql, false);
$sql            = "select * from mari_category where ca_id='$ca_id' and ca_sub_id='$ca_sub_id' order by ca_pk asc";
$depth_ssublist = sql_query($sql, false);
$sql            = "select * from mari_invest_progress where loan_id = '$i_id'";
$money          = sql_fetch($sql, false);
$sql_common     = " from mari_loan a";
$sql_search     = " where (1) ";
if ($stx) {
    $sql_search .= " and ( ";
    $sql_search .= " (a.$sfl like '$stx%')";
    $sql_search .= " ) ";
    $list_view = "and (  a.i_view='Y' )";
} else {
    $list_view = " and (  a.i_view='Y' )";
}
if ($ca_id) {
    $cate_sort = "and (a.ca_id='$ca_id' or a.ca_sub_id='$ca_id' or a.ca_ssub_id='$ca_id')";
}
if ($ca_id) {
    if (!$ca_sub_id) {
        $cate_sorting = "&ca_id=$ca_id&ca_pk=$ca_pk";
    } else if (!$ca_ssub_id) {
        $cate_sorting = "&ca_id=$ca_id&ca_sub_id=$ca_sub_id&ca_pk=$ca_pk&page=$page";
    } else {
        $cate_sorting = "&ca_id=$ca_id&ca_sub_id=$ca_sub_id&ca_ssub_id=$ca_ssub_id&ca_pk=$ca_pk&page=$page";
    }
}
if ($i_loan_type) {
    $type_sort = "and a.i_loan_type = '$i_loan_type'";
}
if ($look) {
    $look_sort = "and b.i_look = '" . $look . "'";
}
$jointbl = "
 join mari_invest_progress b on a.i_id = b.loan_id
";
if(isset($search) && trim($search) !='') {
  $search_e_str = mysql_real_escape_string($search);
  $search_str = " and a.i_subject like '%$search_e_str%' ";
}else $search_str ='';
$sst         = "a.i_id";
$sod         = "desc";
$sql_order   = "order by a.i_top_view asc, $sst $sod ";
$sql         = " select count(*) as cnt $sql_common $jointbl $sql_search " . $list_view . " $cate_sort " . $type_sort . " " . $look_sort .' '.$search_str. " $sql_order ";
$row         = sql_fetch($sql, false);
$total_count = $row['cnt'];
if ($investmore == "Y") {
    $rows = "100";
} else {
    $rows = $config['c_display_subcount'];
}
$total_page = ceil($total_count / $rows);
if ($page < 1)
    $page = 1;
$from_record = ($page - 1) * $rows;
$sql         = " select a.* $sql_common $jointbl $sql_search " . $list_view . " $cate_sort " . $type_sort . " " . $look_sort .' '.$search_str. " $sql_order limit $from_record, $rows ";
$result      = sql_query($sql, false);
$sql         = "select count(*) as cnt from mari_loan where i_view = 'Y'";
$pro_cnt     = sql_fetch($sql, false);
$total_pro   = $pro_cnt['cnt'];
$colspan     = 16;
$sql         = "select * from mari_loan where i_id = '$loan_id'";
$stest       = sql_fetch($sql, false);
