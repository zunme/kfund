<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Schedule extends CI_Controller {
  function index() {
    $sql = "
    select
	l.i_id as loan_id
	, date_format( i_loanexecutiondate , '%Y-%m-%d') as startdate
	, date_format( i_reimbursement_date, '%Y-%m-%d') as enddate
	, if ( i_repay  != '일만기일시상환' , '원금분할상환', i_repay) as form
	, i_repay_day as payday
	, i_loan_day as loanday
	, i_year_plus as rate
	, 24 as overrate
from
  (
    select i_id
    from mari_loan l1
    left join
        (
            select loanid from z_repay_schedule group by loanid
        ) s1 on l1.i_id = s1.loanid
    where i_look='D' and i_view='Y' and i_loanexecutiondate is not null and i_loanexecutiondate !='' and i_loanexecutiondate > '2018-01-01 00:00:00' and s1.loanid is null
  ) l2
join mari_loan l on l2.i_id = l.i_id
inner join mari_loan_ext le on l2.i_id = le.fk_mari_loan_id and i_reimbursement_date is not null and i_reimbursement_date != '' and i_reimbursement_date > '2018-01-01'
    ";
    $rows = $this->db->query($sql)->result_array();

    foreach($rows as $row){

      $cfg['start'] = $row['startdate'];
      $cfg['end'] = $row['enddate'];
      $cfg['dayofeverymonth'] = $row['payday'];
      $this->load->library('calcinterest');
      $this->calcinterest->setDate($cfg);
      $timetable = $this->calcinterest->makeTimetable();
      $schedule = array();
      foreach($timetable as &$tt){
        $tmp = array();
        $tmp['loanid'] = $row['loan_id'];
        $tmp['cnt'] = $tt['num'];
        //$tmp['repaydate'] = $tt['holiday'];
        $tmp['repaydate'] = $tt['date'];
        $tmp['days'] = $tt['diffdate'];
        $tmp['startdate'] = $row['startdate'];
        $tmp['enddate'] = $row['enddate'];
        $tmp['form'] = $row['form'];
        $tmp['payday'] = $row['payday'];
        $tmp['loanday'] = $row['loanday'];
        $tmp['rate'] = $row['rate'];
        $tmp['overrate'] = $row['overrate'];
        $this->db->insert('z_repay_schedule', $tmp);
      }

    }
    echo count($row)."상품 등록";
  }
}
