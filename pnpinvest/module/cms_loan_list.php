<?php
$sql = "select * from mari_authority where m_id = '$user[m_id]'";
$au  = sql_fetch($sql, false);
if ($au[au_loan] == '1' && $au_loan_sub01 == '1') {
    $sql_common = " from mari_loan a ";
    $sql_search = " where (1) ";
    if ($stx) {
        $sql_search .= " and ( ";
        $sql_search .= " ( a.".$sfl." like '$stx%') ";
        $sql_search .= " ) ";
    }
    if (!$sst) {
        $sst = "a.i_id";
        $sod = "desc";
    }
    $sql_order   = " order by $sst $sod ";
    $joinselect =", b.loan_id as parentid,pl.i_subject as parent_subject , d.parents_loan_id as selfparent ";
    $join ="
    left join mari_loan_same_owner b on a.i_id = b.loan_id
    left join mari_loan pl on b.parents_loan_id = pl.i_id
    left join
    ( select parents_loan_id from mari_loan_same_owner c group by c.parents_loan_id) d on a.i_id = d.parents_loan_id
    ";

    $sql         = " select count(*) as cnt $sql_common $sql_search $sql_order ";
    $row         = sql_fetch($sql);
    $total_count = $row['cnt'];
    $rows        = $config['c_page_rows'];
    $total_page  = ceil($total_count / $rows);
    if ($page < 1)
        $page = 1;
    $from_record = ($page - 1) * $rows;
    $sql         = " select a.* $joinselect $sql_common $join $sql_search $sql_order limit $from_record, $rows ";
    $result      = sql_query($sql);
    $sql         = "select  a.* from  mari_category where ca_num='1' order by ca_subject asc";
    $cate1       = sql_query($sql, false);
    $colspan     = 16;
} else {
    alert('접근권한이 없습니다.');
}
?>
