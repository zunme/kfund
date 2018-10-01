<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Sunapmodule extends Adm {
  var $msg;
  var $today;

  public function _remap($method) {
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->{$method}();
  }
  function index() {
    $iza = new stiza();

    //$대출시작일,$대출만기일,$종납일,$수납일,$개월
    $iza->set("2018-01-21", "2018-05-23", "2018-03-30", "2018-06-30", "3");
    $iza->getizail();
    var_dump( $iza->ijail);
  }
}
class stiza {
  var $today;
  var $ijail;
  var $config;

  function __construct() {
    $this->today = date('Y-m-d');
    $this->ijail = array();
  }

  function set($대출시작일,$대출만기일,$종납일,$수납일,$개월 ) {
    $this->config = array();
    $this->config['start'] = $대출시작일=='' ? $this->today : $대출시작일 ;
    $this->config['months'] = (int)$개월 < 1 ? 1 : (int)$개월 ;
    $this->config['expire'] = $대출만기일=='' ? ( $개월!="" && $개월>0 ? $this->about_last_day() : "9999-12:31"  )  : $대출만기일 ;
    $this->config['last_paydate'] = $종납일=='' ? $대출시작일 :  $종납일 ;
    $this->config['sunapil'] = ($수납일 =='') ? $this->today: $수납일;
    $this->config['ijail'] = "last";
  }

  function getizail() {
    $this->calcizail($this->config['last_paydate']);
    return $this->ijail;
  }

  function calcizail_test($start) {

    $tmp = array("start_date"=>"","end_date"=>"", "holiday"=>"",  'days'=> 0, 'inner'=>0, 'over'=>0);
    $start_timestamp = strtotime( $start );
    //일반 한달 기간
    $default_ijail = $this->get_nest_month_ijail($start);
    $next_ijail = $this->get_nest_month_ijail($default_ijail);
    $third_ijail = $this->get_nest_month_ijail($next_ijail);

    if($default_ijail > $this->config['expire'] ) $default_ijail = $this->config['expire'];
    if($next_ijail > $this->config['expire'] ) $next_ijail = $this->config['expire'];
    if($third_ijail > $this->config['expire'] ) $third_ijail = $this->config['expire'];

    if( $this->config['sunapil'] < $default_ijail ) $data['in'] = array( "start"=>$start, "end"=>$this->config['sunapil']);
    else $data['in'] = array( "start"=>$start, "end"=>$default_ijail);

    if( $this->config['sunapil'] > $data['in']['end']){
      if ( $next_ijail > $this->config['sunapil'] ) $data['over1'] = array( "start"=> $data['in']['end'], "end"=>$this->config['sunapil'] );
      else $data['over1'] = array( "start"=> $data['in']['end'], "end"=>$next_ijail );
    }
    if( isset($data['over1']['end'] ) && $this->config['sunapil'] > $data['over1']['end']){
      $data['over2'] = array( "start"=>$data['over1']['end'], "end"=>$this->config['sunapil'] );
    }

    if( isset($data['in']['start']) ){
    //TODO
    }
  
    // 유예기간
    //유예기간후
    /*
    //시작달 마지막일로
    if( date('d',$start_timestamp )    < date('t',$start_timestamp ) ){
      $next = date('Y-m-t', mktime(0,0,0, date('m', $start_timestamp) , 1, date('Y', $start_timestamp) ) );
    }
    //다음달
    else {
      $next = date('Y-m-t', mktime(0,0,0, date('m', $start_timestamp)+1 , 1, date('Y', $start_timestamp) ) );
    }

    $next_holiday = date('Y-m-d',$this->getHoliday($next));
    //임시
    $tmp = array("start_date"=>$start ,"end_date"=>$next, "holiday"=>$next_holiday,  'days'=> 0, 'inner'=>0, 'over'=>0);

    //
    $this->ijail[] = $tmp;
    if( $this->config['sunapil'] > $next_holiday ){
      $this->calcizail($next);
    }
    */
  }


  function get_month_ijail($date){
    $lastday = date('t',strtotime( $date ) );
    if($this->config['ijail'] =='last') return $lastday;
    else return ( (int)$lastday < (int)$this->config['ijail'] ) ? $lastday: $this->config['ijail'];
  }

  //다음 이자일 계산하기
  function get_nest_month_ijail($date){
    $timestamp = strtotime( $date );
    $thismonth = date('Y-m-d',mktime(0,0,0, date('m', $timestamp) , $this->get_month_ijail($date), date('Y', $timestamp) )) ;
    if( $date < $thismonth) return $thismonth;
    $nextmonth = date('Y-m-d',mktime(0,0,0, date('m', $timestamp) + 1 , 1, date('Y', $timestamp) )) ;
    $day = $this->get_month_ijail(date('Y-m-d',mktime(0,0,0, date('m', $timestamp) + 1 , 1, date('Y', $timestamp) )));
    return date('Y-m-d',mktime(0,0,0, date('m', $timestamp) + 1 , $day , date('Y', $timestamp) )) ;
  }
  /* 계약일이 정해지지 않았을 경우 대략적인 날짜를 산출한다. */
  function about_last_day(){
    $start = strtotime( $this->config['start'] );
    $lastday = date('d', $start); //계약 종료일을 계약 시작을과 동일한 일자로 잡는다.
    $last_lastday = date('t',mktime(0,0,0, date('m', $start) + $this->config['months'] , 1, date('Y', $start) )) ;
    $lastday = $lastday > $last_lastday ? $last_lastday : $lastday;
    return date('Y-m-d', mktime(0,0,0, date('m', $start) + $this->config['months'] , (int)$lastday, date('Y', $start) ) );
  }



  /* 기본 */
  function nextdate($start, $expire, $day='last'){
    $start = strtotime($start);
    $expire = strtotime($expire);
    $expired = false;

    $lastday = date('t', $start);
    $lastdate = strtotime(date('Y-m-t', $start));
    $next_lastday = date('t', mktime(0,0,0, date('m', $start)+1, 1, date('Y', $start) ) );
    $next_lastdate = strtotime(date('Y-m-t', mktime(0,0,0, date('m', $start)+1, 1, date('Y', $start) ) ));

    $thismonth = ( $day=='last') ? $lastdate : (  (int)$lastday > (int)$day  ? strtotime(date('Y-m-d', mktime(0,0,0, date('m', $start) , $day, date('Y', $start) ) )) : $lastdate );

    if($start < $thismonth) $next = $thismonth;
    else $next = (   $day == 'last'  ) ? $next_lastdate : ( ($next_lastday > $day ) ? strtotime(date('Y-m-d', mktime(0,0,0, date('m', $start)+1, 2, date('Y', $start) ) )) : $next_lastdate );

    if ($next >= $expire) {$next = $expire; $expired = true;}
    $holiday = $this->getHoliday($next);
    return array('next'=>$next, 'holiday'=>$holiday, 'expired'=>$expired );
  }

  function getHoliday($date){
    $date = strtotime($date);
    if( in_array(date('w', $date ), array(0, 6) ) ) {
      $date = $this->getHoliday(mktime(0,0,0, date('m', $date), date('d', $date)+1, date('Y', $date) ) );
    }
    return $date;
  }
  function getDiffDate($start, $end){
    return date_diff( date_create(date('Y-m-d',$start)), date_create(date('Y-m-d',$end) ) )->days;
  }
}
