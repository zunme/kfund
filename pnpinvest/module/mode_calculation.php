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

    $sql = "select
      a.i_repay, a.i_repay_day,date_format(a.i_loanexecutiondate,'%Y-%m-%d') i_loanexecutiondate,
      ifnull(b.i_reimbursement_date,'0000-00-00') i_reimbursement_date,a.i_loan_day, a.i_year_plus
    from mari_loan a
    left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
    where a.i_id = ".$loan_id;
    $st_lon_info = sql_fetch($sql, false);

  if($st_lon_info['i_repay']=="일만기일시상환") {
    $st_cal = new calcbase();
    $st_cal->set( array( 'rate'=>(float)$st_lon_info['i_year_plus'], 'principal'=>(int)$i_pay ) );
    if($st_lon_info['i_loanexecutiondate']=='0000-00-00'){
      $loanexecutiondate = $st_cal->dateToArr($st_cal->today);
      $startstatus = false;
    }else {
      $loanexecutiondate = $st_cal->dateToArr($st_lon_info['i_loanexecutiondate']);
      $startstatus = true;
    }

    //$loanexecutiondate = array('year'=>2017,'month'=>1,'day'=>28);
    //상환일자 구하기
    if($st_lon_info['i_reimbursement_date']!='0000-00-00'){
      $enddate = $st_cal->dateToArr( $st_lon_info['i_reimbursement_date'] );
      $endstatus = true;
    }else {
      $enddate = $st_cal->getDurationDate($loanexecutiondate, 4);
      $endstatus = false;
    }
    $timetable = $st_cal->maketable($loanexecutiondate,$enddate);

    $sql = "select o_count,o_investamount,o_salestatus,o_interest,date_format(o_datetime,'%Y-%m-%d') o_datetime_formated,o_collectiondate,o_paytype  from mari_order a
      where a.loan_id = ".(int)$loan_id."
      and sale_id =  '".$user['m_id']."'
      order by o_count";
    $repayqry = sql_query($sql, false);
    $repayArr = array();
    while ($repaytmp=sql_fetch_array($repayqry)) {
      $repayArr[]=$repaytmp;
    }
  }
?>
