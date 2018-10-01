<?php
if ($au[au_member] == '1' && $au_member_sub01 == '1') {
    $sql_common = " from mari_member a";
    $sql_search = " where (1) ";
    if ($stx) {
        $sql_search .= " and ( ";
        $sql_search .= " ($sfl like '$stx%') ";
        $sql_search .= " ) ";
    }
    if (!$sst) {
        $sst = "m_datetime";
        $sod = "desc";
    }
    $sql_level ='';
    if($searchlevel && trim($searchlevel) !='' ){
      $tmplevel = explode('_', $searchlevel);
      if( count($tmplevel) > 1){
        $sql_level = " and m_".$tmplevel[0];
        if (  $tmplevel[1] =='morethan') $sql_level .= ' > ';
        else if (  $tmplevel[1] =='lessthan') $sql_level .= ' < ';
        else $sql_level .= ' = ';
        $sql_level .= " '".$tmplevel[2]."' ";
      }else {
        $sql_level = " and m_signpurpose = '".trim($searchlevel)."' ";
      }
    } else $sql_level ='';

    $sql_order   = " order by $sst $sod ";

if( $isnotauthed=='Y'){
  $sql_common .= " left join mari_member_auth b on a.m_no = b.fk_mari_member_m_no ";
  $sql_search .= " and b.fk_mari_member_m_no is null ";
}

    $sql         = " select count(*) as cnt $sql_common $sql_search $sql_level $sql_order ";
    $row         = sql_fetch($sql);
    $total_count = $row['cnt'];
    $rows        = $config['c_page_rows'];
    $total_page  = ceil($total_count / $rows);
    if ($page < 1)
        $page = 1;
    $from_record     = ($page - 1) * $rows;
    $sql             = "select count(*) as cnt from mari_member_leave";
    $cnt_leave       = sql_fetch($sql);
    $leave_count     = $cnt_leave['cnt'];
    $sql             = "select count(*) as cnt $sql_common $sql_search $sql_level and m_intercept_date='' ";
    $cnt_cut         = sql_fetch($sql);
    $intercept_count = $cnt_cut['cnt'];
    $sql             = " select * $sql_common $sql_search $sql_level $sql_order limit $from_record, $rows ";
    
    $result          = sql_query($sql);
    $colspan         = 16;
    $sql             = "select count(*) as cnt from mari_member";
    $m_cnt           = sql_fetch($sql);
    $total_member    = $m_cnt['cnt'];
} else {
    alert('접근권한이 없습니다.', '?cms=admin');
}
