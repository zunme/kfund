<?php
class calcbase {
  public $today;
  protected $base= array();
  public $res;
  protected $정기상환금=0;
/*
  protected $startDate;//시작일
  protected $targetDate;// 계산일
  protected $turn = 1;// 시작회차
*/
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->today = date('Y-m-d');
  }
  function set( $arr){
    $this->base = $arr;
    $this->이율 = $arr['rate'];
    $this->잔고 = $arr['principal'];
    $this->정기상환금 = 0;
    $this->금번상환금 = 0;
  }
  //array( 'rate'=>(float)$st_lon_info['i_year_plus'], 'principal'=>(int)$i_pay )
  public function 이자($일수=0,$상환금=0){ //후취대출 정상수납
    if($일수 < 1) return false;
    $상환금 = ($상환금 > 0 ) ? $상환금 : ( ($this->정기상환금>0 ) ?$this->정기상환금: $this->금번상환금 );
    $상환이자 = $정상이자 = 0;

    $현잔고 = $this->잔고 - $상환금;
    $정상이자 = $현잔고 * $this->이율/100 * $일수 / 365;

    //상환금이 있으면
    if ($상환금 > 0 ) {
      $상환이자 = $상환금 * $this->이율/100 * $일수 / 365;
    }
    $this->res = array (
      '정상이자'=>$정상이자
      , '상환이자'=>$상환이자
      , '상환금'=>$상환금
      , '현잔고'=>$현잔고
    );
    return  $this->res;
  }

  //n개월후 날짜 구하기 (-1일 해서)
  function getDurationDate($arr, $interval=1){
    $date = new DateTime( (int)$arr['year'].'-'.(int)$arr['month'].'-'.(int)$arr['day'] );
    $date->sub(new DateInterval('P1D'));
    $tmp['year']=(int)$date->format('Y');
    $tmp['month']=(int)$date->format('m');
    $tmp['day']=(int)$date->format('d');
    $date->add(new DateInterval('P1M'));
    $mktime = mktime (0 ,0 ,0 , (int)$tmp['month']+$interval, 1 , (int)$tmp['year'] );
    $ret['year'] = date('Y', $mktime);
    $ret['month'] = (int)date('m', $mktime);

    $lastdate = $this->getEndDay($ret);
    $ret['day'] = ((int)$tmp['day']<$lastdate) ? $tmp['day'] : $lastdate;
    return $ret;
  }
  //1개월후 마지막 일자
  function getDurationLastDate($arr,$interval=1){
    $mktime = mktime (0 ,0 ,0 , (int)$tmp['month']+$interval, 1 , (int)$tmp['year'] );
    $ret['year'] = date('Y', $mktime);
    $ret['month'] = (int)date('m', $mktime);
    $ret['day'] =$this->getEndDay($ret);
  }
      //월의 마지막 일자 구하기
  function getEndDay($arr){
    return date("t", mktime (0 ,0 ,0 , (int)$arr['month'], 1 , (int)$arr['year'] ) );
  }
  function getDiffDate($start, $end){
    return date_diff( date_create($start['year'].'-'.$start['month'].'-'.$start['day']), date_create($end['year'].'-'.$end['month'].'-'.$end['day']) )->days;
  }
  //일반 날짜 형식을 어레이로 변경
  function dateToArr($var){
    if($var == '' || $var=='today'){
      $tmp = getdate ();
      $ret = array("year"=>$tmp['year'],"month"=>$tmp['mon'],"day"=>$tmp['mday'] );
      return $ret;
    } else if(is_string($var) ) {
      $tmp = date_create($var);
      if($tmp != false){
        $ret['year'] = (int)$tmp->format('Y');
        $ret['month'] = (int)$tmp->format('m');
        $ret['day'] = (int)$tmp->format('d');
        return $ret;
      }
    }
    return $var;
  }
  //어레이 형식을 일반 날짜 형식으로 변경
  function format_date($arr){
    return( date_create( $arr['year'].'-'.$arr['month'].'-'.$arr['day'] )->format('Y-m-d') );
  }

  function maketable($start, $end){
    $ret = array();
    $interval = 0;
    $mktime = mktime (0 ,0 ,0 , (int)$start['month']+$interval, 1 , (int)$start['year'] );
    $endmktime = mktime (0 ,0 ,0 , (int)$end['month'], (int)$end['day'] , (int)$end['year'] );

    $lastday = $this->getEndDay($start);
    $tmp = $start;
    if((int)$lastday != (int)$start['day']){
      $tmp['day'] = $lastday;
      $day = $this->getDiffDate($start, $tmp);
      $ret[] = array(
                'start'=>$start
                ,'end'=> $tmp
                ,'days'=>$day
                ,'inv'=> $this->이자($day)
              );
      $interval = 1;
    }
    while ($interval < 10){
      //echo "<br>===== start =======<br>";
      //echo $interval."<br>";
      $mktime = mktime (0 ,0 ,0 , (int)$tmp['month']+1, 1 , (int)$tmp['year'] );
      $tmpe = array('year'=>(int)date('Y', $mktime), 'month'=>(int)date('m', $mktime), 'day'=>1);
      $lastday= $this->getEndDay($tmpe);
      $lastmktime = mktime (0 ,0 ,0 , (int)$tmpe['month'], $lastday , (int)$tmpe['year'] );
      if( $lastmktime >= $endmktime){
        $ret[] = array(
                  'start'=>$tmp
                  ,'end'=> $end
                //  ,'days'=>$this->getDiffDate($tmp, $tmpe)
                ,'days'=>(int)$end['day']
                ,'inv'=> $this->이자((int)$end['day'])
                );
        break;
      }else {
        $tmpe['day'] = (int)$lastday;
        $ret[] = array(
                  'start'=>$tmp
                  ,'end'=> $tmpe
                //  ,'days'=>$this->getDiffDate($tmp, $tmpe)
                ,'days'=>$lastday
                ,'inv'=> $this->이자($lastday)
                );
        //echo "<br>===== end =======<br>";
        $tmp = $tmpe;
        $interval ++;
      }
    }

    return ($ret);
  }
}

class ilmangi extends CI_Model {
  function __construct() {
    $sql = "
    delete z_repay_schedule
    from z_repay_schedule
    join view_ilmangi  on z_repay_schedule.loanid = view_ilmangi.i_id
    where
    	z_repay_schedule.startdate <> view_ilmangi.i_loanexecutiondate
    	or z_repay_schedule.enddate <> view_ilmangi.i_reimbursement_date
    	or z_repay_schedule.form <> view_ilmangi.i_repay
    	or z_repay_schedule.loanday <> view_ilmangi.i_loan_day
    	or z_repay_schedule.payday <> view_ilmangi.i_repay_day
    	or z_repay_schedule.loanday <> view_ilmangi.i_loan_day
    	or z_repay_schedule.rate <> view_ilmangi.i_year_plus";
      $this->db->query($sql);
      $sql = "
      select i_id
      from view_ilmangi il
      left join
      	(select a.loanid
      	from z_repay_schedule a
      	group by a.loanid) tmp on il.i_id = tmp.loanid
      where loanid is null";
      $row = $this->db->query($sql)->result_array();
      if(is_array($row) && count($row) >0) {
        foreach($row as $tmp){
            $this->makePaySchedule($tmp['i_id']);
        }
      }
    }
    function getLoanInvestInfo($loan_id){
      $sql = "
      select a.i_loan_pay as i_pay, il.*
      from mari_loan a
      join view_ilmangi il on a.i_id = il.i_id
      where
      	a.i_id = ".(int)$loan_id."
      	and il.i_loanexecutiondate > '0000-00-00'
      	and il.i_reimbursement_date > '0000-00-00'
      ";
      return $this->db->query($sql)->result_array();
    }
    function makePaySchedule($loan_id){
      $invest_info = $this->getLoanInvestInfo($loan_id);
      $st_cal = new calcbase();
      foreach ($invest_info as $z_tmp){
        $checksql = "select count(1) as cnt from z_repay_schedule where loanid = ".(int)$z_tmp['i_id'];
        $checkrow = $this->db->query($checksql)->row_array();
        if($checkrow['cnt']>0) continue;
        $st_cal->set( array( 'rate'=>(float)$z_tmp['i_year_plus'], 'principal'=>(int)$z_tmp['i_pay'] ) );
        $timetable = $st_cal->maketable($st_cal->dateToArr($z_tmp['i_loanexecutiondate']),$st_cal->dateToArr($z_tmp['i_reimbursement_date']));
        $cnt = 1;
        $check=true;
        foreach($timetable as $timetablerow){
          $sql = "
          INSERT INTO `z_repay_schedule`
          (`loanid`, `cnt`, `repaydate`,`days`
          , `startdate`, `enddate`, `form`
          , `payday`, `loanday`, `rate`, `overrate`)
          VALUES
          ('".$z_tmp['i_id']."', '$cnt', '".$st_cal->format_date($timetablerow['end'])."','".$timetablerow['days']."'
          , '".$z_tmp['i_loanexecutiondate']."', '".$z_tmp['i_reimbursement_date']."', '".$z_tmp['i_repay']."'
          , '".$z_tmp['i_repay_day']."', '".$z_tmp['i_loan_day']."', '".$z_tmp['i_year_plus']."', '".$z_tmp['i_year_plus']."')
          ";
          $cnt++;
          $check = $this->db->query($sql);
          if(!$check) break;
        }
        if(!$check){
          $this->db->query("delete z_repay_schedule where loanid=".(int)$z_tmp['i_id']);
          return false;
        }
      }
    }

    //$grouping = true : return 날짜별 정산예정정보
    //$grouping = false : return 정산예정정보
    function investInfoList($grouping = true) {
      $sql = "
      select
        a.*,
        c.i_subject,c.i_loan_pay,
        floor(c.i_loan_pay*rate/100/365*a.days) as inv,
        date_format( ifnull( o_datetime, a.repaydate) ,'%Y-%m-%d') repaydate_formated,
        if(tmp.o_salestatus = '정산완료', '정산완료', if( a.repaydate <= date_format(now(), '%Y-%m-%d') , '정산대기', '정산예정') ) as status
      from z_repay_schedule a
      join mari_loan c on a.loanid = c.i_id
      left join (select loan_id, o_count, o.o_salestatus,o.o_datetime  from  mari_order o group by loan_id, o_count) tmp on a.loanid = tmp.loan_id and a.cnt = tmp.o_count
      order by 15 asc, c.i_id asc
      ";
      $myinvestInforows = $this->db->qury($sql)->result_array();
      //일반데이터
      if (!$grouping) return $myinvestInforows;
      //날짜별 데이터
      $myinvestInfo = array();
      foreach($myinvestInforows as $z_tmp) {
        $myinvestInfo[ $z_tmp['repaydate_formated'] ][] = $z_tmp;
      }
      return $myinvestInfo;
    }

    function getMyInvestInfo($mid){
        $sql = "
        select b.*
        , a.i_pay
        , floor(a.i_pay*rate/100/365*b.days) as inv
        ,if( b.repaydate = b.enddate, a.i_pay,0 ) reimburse
        ,c.i_subject
        , o.o_investamount
        ,date_format( ifnull( o_datetime, b.repaydate) ,'%Y-%m-%d') repaydate_formated
        ,if(o.o_salestatus = '정산완료', '정산완료', if( b.repaydate <= date_format(now(), '%Y-%m-%d') , '정산대기', '정산예정') ) as status

        from (select loan_id,i_pay,m_id from mari_invest t where t.m_id = '".$mid."') a
        join z_repay_schedule b on a.loan_id = b.loanid
        join mari_loan c on a.loan_id = c.i_id
        left join mari_order o on a.loan_id = o.loan_id and a.m_id = o.sale_id and b.cnt = o.o_count
        order by b.repaydate
        ";
        $myinvestInforows = $this->db->query($sql)->result_array();
        $myinvestInfo = array();
        foreach($myinvestInforows as $z_tmp) {
          $timetmp['repaydate'] = $z_tmp['repaydate_formated'];
          $timetmp['loanid'] = $z_tmp['loanid'];
          $timetmp['cnt'] = $z_tmp['cnt'];
          $timetmp['cntday'] =$timetmp['days'] = $z_tmp['days'];
          $timetmp['i_subject'] = $z_tmp['i_subject'];
          $timetmp['i_pay'] = $z_tmp['i_pay'];
          $timetmp['i_year_plus'] = $z_tmp['rate'];
          $timetmp['i_repay'] = $z_tmp['payday'];
          $timetmp['inv'] = (int)($z_tmp['inv']);
          $timetmp['principal'] = (int)$z_tmp['reimburse'];
          $timetmp['total'] = ((int)$z_tmp['o_investamount'] < 1) ? ($z_tmp['inv']+$z_tmp['reimburse']) : $z_tmp['o_investamount'];
          $timetmp['status'] =$z_tmp['status'];
          $myinvestInfo[ $z_tmp['repaydate_formated'] ][] = $timetmp;
        }
        ksort($myinvestInfo);
        return $myinvestInfo;
      }
      //작업중
      function loantablebyid($loanid){
        //안전하게 group by o_count
        $sql = "
            select
            	date_format(o2.o_collectiondate,'%Y-%m-%d') as jigupil ,o2.loan_id as jigup_loan,
            	b.*,
            	FORMAT(c.i_loan_pay,0) as i_loan_pay, FORMAT(c.i_loan_pay * c.i_year_plus /100.0 /365.0 * b.days,0 )  as ija
            	,c.i_subject,total_interest, total_delinquency
            from z_repay_schedule b
            join mari_loan c on b.loanid = c.i_id
            left join (
              select * from
            	(
                select o.loan_id, o.o_count, o.o_collectiondate, NULL as total_interest, NULL as total_delinquency from mari_order o where o.loan_id = ? and o.o_count > 0
                union
                select o1.loan_id, o1.o_count, o1.lastUpdateTime as o_collectiondate, o1.total_interest, o1.total_delinquency from z_settlement_history o1 where o1.loan_id = ? and o1.`status`='Y' and o1.o_count > 0
            	) otmp group by otmp.o_count
            ) o2 on b.loanid = o2.loan_id and b.cnt = o2.o_count
            where b.loanid = ?
            order by b.repaydate
            ;";
        return $this->db->query($sql, array($loanid,$loanid,$loanid) )->result_array();
      }
}
