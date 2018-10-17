<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Calcinterest {
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->start = strtotime('now');
    //$this->defaultday = ( date('d', $this->start) == "1" ) ? 31:(date('d', $this->start) - 1);
    $this->end="";
    $this->dayofeverymonth = 31;//기본은 매월 말일로
    $this->holiday = array("2018-10-03", "2018-10-09", "2018-12-25");
  }
/* 세팅 */
  function setDate( $arr ){
    if( isset ($arr['start']) ) $this->start = strtotime($arr['start']);
    if ( isset ($arr['dayofeverymonth']) && (int)$arr['dayofeverymonth'] > 0 ) $this->dayofeverymonth = (int)$arr['dayofeverymonth'];
    else $this->dayofeverymonth = (int)date('d',$this->start) ;

    if( isset ($arr['end']) ) $this->end = strtotime($arr['end']);
    else if ( isset ($arr['month']) ){
      $lastdate = $this->addMonts($this->start, $arr['month']);
      $lastday = (int)date('t', $lastdate);
      $dayofeverymonth = ( $this->dayofeverymonth > $lastday ) ? $lastday : $this->dayofeverymonth ;
      $this->end = strtotime(date('Y-m-', $lastdate).sprintf('%02d', $dayofeverymonth));
    } else $this->end =$this->start;
  }
  function getSetting(){
    return array("start"=> $this->start ,"end"=> $this->end ,"dayofeverymonth"=> $this->dayofeverymonth ,"holiday"=> $this->holiday);
  }
  function setStart($date){
  $this->start = strtotime($date);
  //$this->defaultday = date('d', $this->start);
  }
  function setEnd($date){
    $this->end = strtotime($date);
  }
/* / 세팅 */
  function makeTimetable(){
    $i = 1;
    $table = array();
    $start = $this->start;
    while(true){
      $next = $this->nextdate($start);
      if($next >= $this->end){
        $table[]= array('num'=>$i,'start'=>$this->timestampTostr($start), 'date'=>$this->timestampTostr($this->end),'holiday'=>$this->timestampTostr($this->checkHoliday($this->end)) ,"diffdate"=> $this->getDiffDate($start, $this->end));
        break;
      }
      $table[]= array('num'=>$i,'start'=>$this->timestampTostr($start), 'date'=>$this->timestampTostr($next),'holiday'=>$this->timestampTostr($this->checkHoliday($next)) ,"diffdate"=> $this->getDiffDate($start, $next));
      $start = $next;
      if($i>100) break;
      else $i++;
    }
    return $table;
  }
//=================================================================================================
  // 휴일
  function checkHoliday( $timestamp ){
    for ( $i = 0;$i < 15 ;$i ++){
      if( $this->isholiday($timestamp) ) {
          return $timestamp;
      }else $timestamp += 86400;
    }
  }
  function isHoliday($timestamp){
    /* 일요일, 공휴일 여부 */
    if( in_array(date('w', $timestamp ), array(0, 6) ) ) {
      return false;
    }
    $date = date('Y-m-d', $timestamp );
    foreach ($this->holiday as $holiday){
      if( $holiday == $date) return false;
    }
    return true;
  }
  //
  function timestampTostr($timestamp){
    return date('Y-m-d', $timestamp);
  }
  //월의 먀지막 날짜
  function lastDay($timestamp){
    return date('t', $timestamp);
  }

  //마지막 일
  function lastDate($timestamp){
    return strtotime(date('Y-m-t', $timestamp));
  }
  //ADD DAYS
  function addDays($strdate, $intval){
    return strtotime('+'.(int)$intval.' day', $strdate);
  }
  //다음일자 구하기
  function nextdate($timestamp){
    $date = date('Y-m-d', $timestamp);
    $lastday = (int)date('t', $timestamp);
    $dayofeverymonth = ( $this->dayofeverymonth < $lastday ) ? $this->dayofeverymonth :  $lastday;
    $thismonth = date('Y-m-', $timestamp).sprintf('%02d', $dayofeverymonth);
    if ( $date < $thismonth ) return strtotime($thismonth);
    return $this->addMonts( strtotime($thismonth), 1);
  }
  //ADD MONTHS
  function addMonts($timestamp,$intval){
    $day = date('d', $timestamp);
    $tmp = strtotime('+'.(int)$intval.' month', strtotime(date('Y-m',$timestamp).'-01') );
    $last = $this->lastDay($tmp);
    $day = ($day > $last) ? $last : $day;
    return strtotime(date('Y-m', $tmp).'-'.$day);
  }
  function getDiffDate($start_timestamp, $end_timestamp){
    return date_diff( date_create(date('Y-m-d',$start_timestamp)), date_create(date('Y-m-d',$end_timestamp) ) )->days;
  }
}
