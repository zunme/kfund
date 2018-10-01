<?php
class mainbase extends CI_Model {
  function meminfo($id){
    return $this->db->query('select * from mari_member where m_id = ?', array($id))->row_array();
  }

  function getMemberlimit ($mem){
    if ( is_array($mem) && isset( $mem['m_level'] ) && isset( $mem['m_signpurpose'] ) ) $user = $mem;
    else {
      $sql = "select * from mari_member where m_id = ?";
      $user = $this->db->query($sql , array($mem) )->row_array();
    }
    if(!isset($user['m_id']) ) { $user['m_level'] = '2';$user['m_signpurpose']='N';}
    $is_ck = $this->inset();

    if($user['m_level'] >= "3" ) {
      $maximum = $is_ck['i_maximum_v'];
      $member_level_label ='법인회원투자자';
      $i_profit=$is_ck['i_profit_v'];//소득적격투자자
      $i_withholding=$is_ck['i_withholding_burr'];//소득적격투자자
      $i_withholding_v=$is_ck['i_withholding_burr_v'];//소득적격투자자
    } //else if ($user['m_level'] == "2") {
      else {
         if ($user['m_signpurpose'] == "I") {
           $maximum = $is_ck['i_maximum_in'];
           $member_level_label = '소득적격투자자';
           $i_profit=$is_ck['i_profit_in'];//소득적격투자자
           $i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
           $i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
           //$is_ck['i_maximum_in']
         } else if ($user['m_signpurpose'] == "P") {
           $maximum = $is_ck['i_maximum_pro'];
           $member_level_label = '전문투자자';
           $i_profit=$is_ck['i_profit_pro'];//전문투자자
           $i_withholding=$is_ck['i_withholding_pro'];//전문투자자
           $i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
           //$is_ck['i_maximum_pro']
         } else if ($user['m_signpurpose'] == "L2") {
           $maximum = $is_ck['i_maximum_personalloan'];
           $member_level_label ='개인대부사업자투자자';
           $i_profit=$is_ck['i_profit_personalloan'];//개인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_personalloan'];//개인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_personalloan_v'];//개인대부사업자투자자
           //$is_ck['i_maximum_personalloan']
         } else if ($user['m_signpurpose'] == "C2") {
           $maximum = $is_ck['i_maximum_corporateloan'];
           $member_level_label ='법인대부사업자투자자';
           $i_profit=$is_ck['i_profit_corporateloan'];//법인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_corporateloan'];//법인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_corporateloan_v'];//법인대부사업자투자자
           //$is_ck['i_maximum_corporateloan']
         } else if ($user['m_signpurpose'] == "I2") {
           $maximum = $is_ck['i_maximum_incomeloan'];
           $member_level_label ='소득적격대부업자투자자';
           $i_profit=$is_ck['i_profit_incomeloan'];//소득적격대부투자자
           $i_withholding=$is_ck['i_withholding_incomeloan'];//소득적격대부투자자
           $i_withholding_v=$is_ck['i_withholding_incomeloan_v'];//소득적격대부투자자
           //$is_ck['i_maximum_incomeloan']
         }
         //if ($user['m_signpurpose'] == "N" || $user['m_signpurpose'] == "L") {
         else {
          $maximum = $is_ck['i_maximum'];
          $member_level_label = ($user['m_signpurpose'] == "L")?'대출회원':'일반개인투자자';
          $i_profit=$is_ck['i_profit'];//개인투자자
          $i_withholding=$is_ck['i_withholding_personal'];//개인투자자
          $i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
          //$is_ck['i_maximum']
         }
     }
     //총한도, 라벨링, 수수료율,
     return array('insetpay'=>$maximum, 'invest_flag'=>$member_level_label,'i_profit'=>$i_profit,'i_withholding'=>$i_withholding,'i_withholding_v'=>$i_withholding_v );
  }


  function mariconfig($key=null){
    $config = $this->db->query('select * from mari_config limit 1')->row_array();
    if($key != null ) return $config[$key];
    else return $config;
  }
  function inset($key=null){
    $config = $this->db->query('select * from mari_inset limit 1')->row_array();
    if($key != null ) return $config[$key];
    else return $config;
  }
  function seyfertinfo($id){
    return $this->db->query('select * from mari_seyfert where m_id =?', array($id))->row_array();
  }
  function preauthstatus($id){
    return $this->db->query("select  a.*, unix_timestamp(now()) as ntime,date_format(date_add(updatetime, interval 90 day),'%Y-%m-%d') as expire  from z_seyfert_preauth a where m_id = ? order by updatetime desc limit 1", array($id))->row_array();
  }
  /* 투자계산기용 */
  function loaninfo_for_calc($loanid){
    #예상대출실행일 3 day 에서 0 day 로 수정
    $sql = "
    select  datediff( lastd_startd, startd ) as firstdiff
            		, datediff( endd, date_format(endd, '%Y-%m-01') )+1 as lastdiff
            		, datediff( lastd_endd, date_format(lastd_endd, '%Y-%m-01') )+1 as lastdiff2
                , date_format(startd, '%m') as startmonth
                , date_format(endd, '%m') as endmonth
            		, tmp.*
            from
            (
            select
            	 date_format( i_loanexecutiondate,'%Y-%m-%d') as startd1
            	, date_format( date_add(now() , interval 0 day ),'%Y-%m-%d') as startd2
            	, if( i_loanexecutiondate = 0 , date_format( date_add(now() , interval 0 day ),'%Y-%m-%d') , date_format( i_loanexecutiondate,'%Y-%m-%d') ) as startd
            	, b.i_reimbursement_date as endd1
            	, date_format( date_add(date_add(now() , interval 0 day ) , interval i_loan_day month ),'%Y-%m-%d') as endd2
            	, if ( i_reimbursement_date is null , date_format( date_add(date_add(now() , interval 0 day ) , interval i_loan_day month ),'%Y-%m-%d') , i_reimbursement_date ) as endd
            	, last_day( date_add(now() , interval 0 day ) ) as lastd_startd
            	, last_day( date_add(date_add(now() , interval 0 day ), interval i_loan_day month ) ) as lastd_endd
            	, i_id, i_loan_day, i_year_plus, i_subject, i_repay, b.default_profit
            	from mari_loan	a
            	left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
            	where i_id = ?
            ) tmp
    ";

    return $this->db->query($sql, array($loanid))->row_array();
    echo $this->db->last_query();
  }
}
