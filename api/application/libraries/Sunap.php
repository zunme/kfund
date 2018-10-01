<?php
Class sunap{
  var $CI;
  var $today;
  var $msg='';
  var $usingLastdate; //이자일을 말일로 계산, 현재는 말일만 구현
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->sunapil = $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->usingLastdate = true;
    $this->CI=& get_instance();
  }

  public function base($loanid) {
    $this->loaninfo = $this->loaninfo($loanid);
    $history = $this->sunaphistory($loanid);
    if( $history === false){
      $lastdate = $this->loaninfo['i_loanexecutiondate'];
      $o_count = 1;
    }else {
      $lastdate = $history[(count($history)-1)]['원이자일'];
      $o_count = $history[(count($history)-1)]['회차'];
    }
    // 이자계산일, 실수납일, 상환일여부
    $nextmonth = $this->nextdate($lastdate, $this->loaninfo['i_reimbursement_date'],  $this->loaninfo['payment_day']);
    $overdate = $this->nextdate($nextmonth['next'], $this->loaninfo['i_reimbursement_date'],  $this->loaninfo['payment_day']);
    $data = array(
      'info'=>$this->loaninfo, 'history'=>$history,
      'next'=>$nextmonth, 'overdate' =>$overdate
    );
  }

  function loaninfo($loanid){
    $sql = "
    select
      if( c.remaining_amount > 0 , c.remaining_amount, a.i_loan_pay) as remaining_amount
      , if(c.payment_day is null , 'last' , c.payment_day ) as payment_day
      , c.nextdate
      , if( a.i_loanexecutiondate = '0000-00-00 00:00:00', '' ,  date_format( a.i_loanexecutiondate,'%Y-%m-%d' )) as loanex_ecution_date
      , b.fk_mari_loan_id
      , if( b.i_reimbursement_date = '0000-00-00', NULL , b.i_reimbursement_date) as i_reimbursement_date
      , if( b.default_profit = '' , NULL , default_profit ) as default_profit
      , a.*
    from mari_loan a
    left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
    left join z_invest_base c on a.i_id = c.loan_id
    where a.i_id = ?
    ";
    $tmp = $this->CI->db->query($sql , array($loanid) )->row_array();
    if(!isset($tmp['i_id'])) {$this->msg='대출자료를 찾을 수 없습니다.';return false;}
    else return $tmp;
  }
  function sunaphistory($loanid){
    $sql = "
    (   select
           0 as idx, loan_id , o.o_count as 회차
           ,if( o.o_investamount > o.o_ln_money_to , '상환완료','이자지급') as 상환구분
           , sc.repaydate as `원이자일`
           , date_format(o.o_collectiondate,'%Y-%m-%d') as `이자일`
           , date_format(o.o_collectiondate,'%Y-%m-%d') as `수납일`
           ,  o.o_mh_money as 수납금액
           , if( o.o_investamount > o.o_ln_money_to, l1.i_loan_pay , 0 ) as 상환금
           , 0 as 중도상환금
           , 0 as 중도상환수수료율, 0 as 중도상환수수료
           , o_ln_iyul as 이율
         , sc.days as 이자일수
           , if (o.o_mh_money > l1.i_loan_pay, o.o_mh_money - l1.i_loan_pay , o.o_mh_money ) 정상이자
           , NULL as 연체이율, 0 as 한달미만,  0 as 한달이상, 0 as 상환일이후 , 0 as  연체이자
           , 0 as 조정금액, 0 as 가수금, 0 as 미수금

       from mari_order o
       join mari_loan l1 on o.loan_id = l1.i_id
       join z_repay_schedule sc on o.loan_id = sc.loanid and o.o_count = sc.cnt
       where
         o.loan_id = ? and
         o.sale_id != ''
         group by o.loan_id, o.o_count )
    union
    (
    select
    s.idx, s.loan_id, s.o_count as 회차
    ,s.`type_row` as 상환구분

           , s.calc_date as `원이자일`
           , s.inv_date as `이자일`
           , s.acceptance_date as `수납일`
           ,  s.`storage_amount` as 수납금액
           , s.repayment as 상환금
           , s.Reimbursement as 중도상환금
           , s.Reimbursement_rate as 중도상환수수료율, s.Reimbursement_susuryo as 중도상환수수료
           , s.rate as 이율
         , s.days as 이자일수
           , interest 정상이자
           , Delinquency_rate as 연체이율, Delinquency_under as 한달미만,  Delinquency_over as 한달이상, Delinquency_end as 상환일이후 , Delinquency as  연체이자
           , adjustment_amount as 조정금액, gasugum as 가수금, misugum as 미수금

    from z_invest_sunap s
    where s.loan_id = ? and s.`status_row` = 'Y'
    )
    order by 회차
    ";
  $rows = $this->CI->db->query($sql, array($loanid,$loanid)) ->result_array();
  if(count($rows)< 1) {$this->msg='기존 수납 내역이 없습니다.';return false;}
  else return $rows;
  }
  // 다음회차계산
  function nextdate($startdate, $expiredate, $day='last'){
    if( $this->testDate($startdate) ) { $startdate = strtotime($startdate);}
    if( $this->testDate($expiredate) ) { $startdate = strtotime($expiredate);}
      $nextmonth = $this->nextmonth($startdate, $day);
    if( $startdate >= $expiredate) {
      $sunapil = $this->getHoliday($expiredate);
      $is_expire = true;
    }
    else {
      $sunapil = $this->getHoliday($nextmonth);
      $is_expire = false;
    }

    return array('next'=>$nextmonth, 'sunapil'=>$sunapil, 'is_expire'=>$is_expire);
  }
  // 휴일 계산
   function getHoliday($date){
     if( $this->testDate($date) ) {
     $date = strtotime($date);
     }
     return $this->getHolidaybystamp($date);
   }
   function getHolidaybystamp($date){
     if( in_array(date('w', $date ), array(0, 6) ) ) {
       $date = $this->getHoliday(mktime(0,0,0, date('m', $date), date('d', $date)+1, date('Y', $date) ) );
     }
     return $date;
   }
   function testDate( $value ) { return preg_match("/^(\d{4})-(\d{2})-(\d{2})$/", $value); }


   //========= DATE =========
   function getDiffDate($start, $end){
     return date_diff( date_create(date('Y-m-d',$start)), date_create(date('Y-m-d',$end) ) )->days;
   }
   //마지막일
   function lastDay($strdate){
     return date('t', $strdate);
   }
   //마지막 날자
   function lastDate($strdate){
     return strtotime(date('Y-m-t', $strdate));
   }
   function nextmonth($date, $day){
     $next = mktime(0,0,0, date('m', $date)+1, 1, date('Y', $date) ) ;
     $t = $this->lastDay($next);
     if($day =='last' || (int)$day > (int)$t ) $nextmonth = mktime(0,0,0, date('m', $next), $t, date('Y', $next) );
     else $nextmonth = mktime(0,0,0, date('m', $next), $day, date('Y', $next) );
     return $nextmonth;
   }
  /*
  function sunaptable($loanid){
    $history = $this->sunap_history($loanid);
    $loaninfo = $this->loaninfo($loanid);
    //TODO 만기코드 다시 할것
    if($loaninfo['i_look']=='F')     return array($loaninfo, $history, array());

    if($history !== false){
      $last = $history[count($history)-1];
      $startdate = $last['수납기준일자'];
    }else {
      $startdate = $loaninfo['loanex_ecution_date'];
      if($startdate == '') {
        $this->msg = '대출실행일 이 설정되지 않았습니다.';return false;
      }
    }
    if( $loaninfo['i_reimbursement_date']==''){$this->msg = '대출종료일 이 설정되지 않았습니다.';return false;}

    $ret = $this->getOoverdue($startdate,$loaninfo['i_reimbursement_date'], ($this->CI->input->get('basedate') !='' ) ? $this->CI->input->get('basedate') : '' );
    $ret = $this->getOoverdue( '2017-11-25','2017-12-31','' );
    //return array($loaninfo,$history, $ret );
    return $ret ;
  }
  //마지막상환일, 대출종료일, 수납기준일자 로 연체여부와 이자일수 및 연체일수계산

 // 휴일 여부 계산 차후 적용
  function getHoliday($date){
    if( $this->testDate($date) ) {
    $date = strtotime($date);
    }
    return $this->getHolidaybystamp($date);
  }
  function getHolidaybystamp($date){
    if( in_array(date('w', $date ), array(0, 6) ) ) {
      var_dump(date('Y-m-d w', $date ));
      $date = $this->getHoliday(mktime(0,0,0, date('m', $date), date('d', $date)+1, date('Y', $date) ) );
    }
    return $date;
  }
  function testDate( $value ) { return preg_match("/^(\d{4})-(\d{2})-(\d{2})$/", $value); }

  function getOoverdue($start, $reimbursement_date,$base='' ){
    $this->CI->load->library('Calcdate');

    $start = strtotime($start);
    $reimburse = strtotime($reimbursement_date);

    $tmp = $this->CI->calcdate->lastDate($start);
    $next = ( $start == $tmp ) ? $this->CI->calcdate->addMonts($start, 1) : $tmp;
    $basedate = ($base !='' ) ? strtotime($base) : $this->today;

    $over30date = $this->CI->calcdate->addMonts($next, 1);
    if( $this->usingLastdate) $over30date = $this->CI->calcdate->lastDate($over30date);

    $overDue = array('isOver'=>'정상수납', 'days'=>0, 'under30'=>0, 'over30'=>0, 'overLoan'=>0,'total'=>0,'over30date'=> date('Y-m-d',$over30date), 'getbasedate' => date('Y-m-d',$basedate)  );
    if( $start <= $reimburse ) {
      //만기후 연체
      if( $basedate >  $reimburse ){
        $overDue['overLoan']= $this->CI->calcdate->getDiffDate($reimburse,$basedate);
        $tmp_basedate = $reimburse;
        $overDue['isOver'] = "만기후연체";
      }else $tmp_basedate = $basedate;
        //연체중
      if($tmp_basedate > $next){
        if( $tmp_basedate > $over30date ){
          $overDue['over30'] = $this->CI->calcdate->getDiffDate($over30date,$tmp_basedate);
          $overDue['under30'] = $this->CI->calcdate->getDiffDate($next, $over30date);
          $overDue['isOver'] = ($overDue['isOver']=='정상수납') ? "한달이상연체" : $overDue['isOver'];
        }else {
          $overDue['under30'] = $this->CI->calcdate->getDiffDate($next,$tmp_basedate);
          $overDue['isOver'] = ($overDue['isOver']=='정상수납') ? "한달미만연체" : $overDue['isOver'];
        }
      }
      //일반
        $overDue['days']=$this->CI->calcdate->getDiffDate($start,$next);
    }

    // 전체 대출만기후 연체
    else {
      $overDue['overLoan']= $this->CI->calcdate->getDiffDate($start,$basedate);
    }
    $overDue['total'] = $this->CI->calcdate->getDiffDate($start,$basedate);
    return $overDue;

  }
  function loaninfo($loanid){
    $sql = "
      select
      	a.*
        , if( a.i_loanexecutiondate = '0000-00-00 00:00:00', '' ,  date_format( a.i_loanexecutiondate,'%Y-%m-%d' )) as loanex_ecution_date
      	, b.fk_mari_loan_id
      	, if( b.i_reimbursement_date = '0000-00-00', NULL , b.i_reimbursement_date) as i_reimbursement_date
      	, if( b.default_profit = '' , NULL , default_profit ) as default_profit
      from mari_loan a
      left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
      where a.i_id =?
    ";
    $tmp = $this->CI->db->query($sql , array($loanid) )->row_array();
    if(!isset($tmp['i_id'])) {$this->msg='대출자료를 찾을 수 없습니다.';return false;}
    else return $tmp;
  }
  function sunap_history($loanid){
    $sql = "
    select
    *
    from (
    (
    select
    		0 as idx, loan_id , o.o_count as 회차
    		,if( o.o_investamount > o.o_ln_money_to , '상환완료','이자지급') as 상환구분
    		, l1.i_loan_pay 원금
    		,  o.o_mh_money as 수납금액
    		, if( o.o_investamount > o.o_ln_money_to, l1.i_loan_pay , 0 ) as 상환원금
    		, 0 as 상환수수료율, 0 as 상환수수료
    		, o_ln_iyul as 이율
    		,if (o.o_mh_money > l1.i_loan_pay, o.o_mh_money - l1.i_loan_pay , o.o_mh_money ) 정상이자
    		, sc.days as 이자일수, NULL as 연체이율, NULL as 연체이자, NULL as 연체일수
    		, 0 as 조정금액
    		, sc.repaydate as 수납기준일자
    		, date_format(o.o_collectiondate,'%Y-%m-%d') 실일자
    from mari_order o
    join mari_loan l1 on o.loan_id = l1.i_id
    join z_repay_schedule sc on o.loan_id = sc.loanid and o.o_count = sc.cnt
    where
    	o.loan_id = ? and
    	o.sale_id != ''
    	group by o.loan_id, o.o_count
    ) union (
    select
    	zh.idx
    	,zh.loan_id as loan_id
    	,zh.o_count as 회차
    	, zh.`type` as 상환구분
    	, 0 as 원금
    	, zh.`storage` as 수납금액
    	, Reimbursement as 상환원금
    	, Reimbursement_rate as 상환수수료율, Reimbursement_susuryo as 상환수수료
    	, rate as 이율
    	, interest as 정상이자
    	, days as 이자일수, Delinquency_rate as 연체이율, Delinquency as 연체이자, Delinquency_days as 연체일수
    	, adjustment_amount as 조정금액
    	, acceptance_date as 수납기준일자
    	, acceptance_date 실일자
    from z_settlement_history zh where loan_id = ? and `status` = 'Y')
    ) untmp
    order by 수납기준일자, loan_id, 회차
    ";
    $rows = $this->CI->db->query($sql, array($loanid,$loanid)) ->result_array();
    if(count($rows)< 1) {$this->msg='기존 수납 내역이 없습니다.';return false;}
    else return $rows;
  }
*/
}
