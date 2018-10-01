<?php
Class Calcdate{
  public $start;
  public $defaultday;
  public $end;

  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->start = strtotime('now');
    $this->defaultday = date('d', $this->start);
  }
  function setStart($date){
    $this->start = strtotime($date);
    $this->defaultday = date('d', $this->start);
  }
  function setEnd($date){
    $this->end = strtotime($date);
  }
  //시작일 날짜 더하기
  function setStartDuration($intval){
    $this->start = strtotime('+'.(int)$intval.' day', $this->start);
    $this->defaultday = date('d', $this->start);
  }
  //종료일 개월 더하기
  function setEndDuration($intval){
    $this->end = $this->addMonts($this->start, $intval);
  }
  //종료일을 월말로 변경
  function setEndtoLastDay(){
    $this->end = $this->lastDate($this->end);
  }


  function getDateList(){
    $start = $this->start;
    $next = $this->lastDate($start);
    $ret = array();
    if($start <= $next){
      for($i =1 ; $i < 36; $i++ ){
        if($next > $this->end){
          $next = $this->end;
        }
        if($start >= $this->end) break;
          $tmp['start'] = date('Y-m-d',$start);
          $tmp['end'] = date('Y-m-d',$next);
          $tmp['diff'] = $this->getDiffDate($start, $next);
          $ret[] = $tmp;
          $start = $next;
          $next = $this->lastDate( $this->addMonts($next,1));
      }
    }
    return $ret;
  }

  //월의 먀지막 날짜
  function lastDay($strdate){
    return date('t', $strdate);
  }
  //마지막 일
  function lastDate($strdate){
    return strtotime(date('Y-m-t', $strdate));
  }
  //ADD DAYS
  function addDays($strdate, $intval){
    return strtotime('+'.(int)$intval.' day', $strdate);
  }
  //ADD MONTHS
  function addMonts($strdate,$intval){
    $day = date('d', $strdate);
    $tmp = strtotime('+'.(int)$intval.' month', strtotime(date('Y-m',$strdate).'-01') );
    $last = $this->lastDay($tmp);
    $day = ($day > $last) ? $last : $day;
    return strtotime(date('Y-m', $tmp).'-'.$day);
  }
  function getDiffDate($start, $end){
    return date_diff( date_create(date('Y-m-d',$start)), date_create(date('Y-m-d',$end) ) )->days;
  }
}
