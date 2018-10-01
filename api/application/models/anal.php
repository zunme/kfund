<?php
class Anal extends CI_Model {
    /* 첫투자 재투자*/
    function first($loanid=null){
        $where ="";
        $limit='';
        if($loanid != null && $loanid !='' ) {
            $limitArr = explode('limit', $loanid);
            if( count($limitArr) == 2) $limit ="limit ".$limitArr[1];
            else $where = " where a.i_id = ".(int)$loanid;
        }
        $sql = "	select loan_id,i_subject
        , SUM(CASE WHEN isfirst = '1' THEN i_pay ELSE 0 END) AS firsttotal
        , SUM(CASE WHEN isfirst = '0' THEN i_pay ELSE 0 END) AS notfirsttotal
        , SUM(CASE WHEN isfirst = '1' THEN 1 ELSE 0 END) AS first_count
        , SUM(CASE WHEN isfirst = '0' THEN 1 ELSE 0 END) AS notfirst_count
        from
        (
        select
                b1.* , if( (select count(1) as cnt from mari_invest c1 where c1.m_id = b1.m_id and c1.i_id < b1.i_id) = 0 , 1 , 0 ) as isfirst
        from mari_loan a
        join mari_invest b1 on a.i_id = b1.loan_id and b1.m_id !='test@test.com' and b1.m_id !='test@admin.com' and b1.m_id <>''
        $where
        ) grp
        group by grp.loan_id
        order by loan_id desc
        $limit
        ";
        return $this->db->query($sql)->result_array();
    }
}
