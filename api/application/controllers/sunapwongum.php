<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Sunapwongum extends Adm {
  var $msg;
  var $today;
  var $loaninfo, $timetableArr, $dateArr, $jigupinfo;

  public function _remap($method) {
    $this->db = $this->load->database('real',true);
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $loan = $this->input->post('loanid') !='' ? $this->input->post('loanid') : $this->input->get('loanid');
    $this->loaninfo = $this->db->query("select a.i_repay as method, a.i_repay_day as lastday ,a.i_loan_day as gigan,a.i_year_plus as iyul, date_format(a.i_loanexecutiondate, '%Y-%m-%d') as sdate,b.i_reimbursement_date as edate, b.default_profit,a.*
        from  mari_loan a
        left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
        where a.i_id = ?", array($loan) )->row_array();
    // start

    $sql = "select * from z_invest_sunap where loan_id = ? order by regdate desc";
    $this->jigupinfo = $this->db->query($sql, array($this->loaninfo['i_id']))->result_array();
    $lastinfo = ( is_array($this->jigupinfo) && isset($this->jigupinfo[0]['loan_id']) ) ? $this->jigupinfo[0] : '';

    if( $this->input->post('calc_date') != '' ) $startdate = $this->input->post('calc_date');
    else if ( $this->input->get('calc_date') != '' ) $startdate = $this->input->get('calc_date');
    else if( isset($lastinfo['calc_date'])) $startdate = $lastinfo['calc_date'];
    else $startdate = $this->loaninfo['sdate'];

    if( $this->input->post('sunapil') != '' ) $sunapil = $this->input->post('sunapil');
    else if ( $this->input->get('sunapil') != '' ) $sunapil = $this->input->get('sunapil');
    else $sunapil = date('Y-m-d');

    $nextdate = $this->nextdate($startdate, $this->loaninfo);
    if( $nextdate > $this->loaninfo['edate'] ){
      $nextdate = $this->loaninfo['edate'];
      $overdate = $nextdate;
      $overholiday = $this->holiday($overdate);
    }else {
      $holiday = $this->holiday($nextdate);
      $overdate = $this->nextdate($nextdate, $this->loaninfo);
      if( $overdate > $this->loaninfo['edate'] ){
        $overdate = $this->loaninfo['edate'];
      }
      $overholiday = $this->holiday($overdate);
    }
    $holiday = $this->holiday($nextdate);

    $dateArr = array(
      "start"=>$startdate
      ,"nextdate" => $nextdate
      ,"holiday" => $holiday
      ,"overdate" => $overdate
      ,"overholiday" => $overholiday
      ,"sunapil"=>$sunapil
      ,"calculsunapil"=>$this->holidayRev($sunapil)
    );
    $dateArr['total'] = $this->diffdate($startdate, $dateArr['calculsunapil']);
    if($dateArr['calculsunapil'] > $dateArr['overdate'] ){
      if( $nextdate == $overdate) {
        $dateArr['over1'] = 0;
      }else {
        $dateArr['over1'] = $this->diffdate($nextdate, $overdate );
      }
      $dateArr['over2'] = $this->diffdate($overdate, $dateArr['calculsunapil']);
    }else if ($dateArr['calculsunapil'] > $dateArr['nextdate'] ){
      $dateArr['over1'] = $this->diffdate($nextdate, $dateArr['calculsunapil'] );
      $dateArr['over2'] = 0;
    }
    $dateArr['normal'] = $dateArr['total'] - $dateArr['over1'] - $dateArr['over2'];

    $this->dateArr = $dateArr;
    $this->timetableArr = $this->timetable($this->loaninfo);
    $sql = "select sum(i_pay) as realtotal from mari_invest where loan_id = ? and i_pay_ment ='Y' ";

    $tmp = $this->db->query($sql, array($this->loaninfo['i_id']) )->row_array();
    $this->realtotal = $tmp['realtotal'];
    $sql = "select ifnull(sum(Reimbursement),0) as repayed from z_invest_sunap b where b.loan_id = ? ";
    $tmp = $this->db->query($sql, array($this->loaninfo['i_id']) )->row_array();
    $this->payed = $tmp['repayed'];
    $this->remain = $this->realtotal - $this->payed;
    //end
    $this->{$method}();
  }
  function index() {
    var_dump($this->realtotal);
    var_dump($this->remain);
    var_dump($this->dateArr);
    //var_dump($this->timetableArr);
    $this->cal_wongum();

  }
  function cal_wongum(){
    $ret['remain'] = $this->remain;
    $ret['monthly'] = round( $this->remain / (count($this->timetableArr)-count($this->jigupinfo)) );
    $ret['jango'] = $ret['remain'] - $ret['monthly'];

    $ret ['normal'] = round($this->remain * $this->dateArr['total'] * $this->loaninfo['iyul']/100/365);

    if( $this->dateArr['over1']> 0 ){
        ;
    }else $ret['over1'] =0;

    if( $this->dateArr['over2']> 0 ){
      ;
    }else $ret['over2'] =0;
    var_dump($ret);

  }
  /* 공통 */
  function timetable(&$loaninfo){

    if($loaninfo['lastday']=='') $lastday = 31;

    $date = $loaninfo['sdate'];

    for ($i =1; $i <= $loaninfo['gigan']+5; $i ++){
      $ndate = $this->nextdate($date,$loaninfo);

      if( $loaninfo['edate']!='' &&  $loaninfo['edate']!='0000:00:00' && $ndate >= $loaninfo['edate'] ){
        $ret[] = array('startdate'=>$date, 'nextdate'=>$loaninfo['edate'], 'holiday'=>$this->holiday($loaninfo['edate']), "diff"=> $this->diffdate($date,$loaninfo['edate']) );
        break;
      }
      $ret[] = array('startdate'=>$date, 'nextdate'=>$ndate, 'holiday'=>$this->holiday($ndate), "diff"=> $this->diffdate($date,$ndate));
      $date = $ndate;
    }
    return $ret;
  }
  function nextdate($date, $loaninfo) {
    $strtime = strtotime($date);
    $t = date('t', $strtime);
    $t = ( $t > $loaninfo['lastday'] ) ? $loaninfo['lastday'] : $t;

    if (  date('d', $strtime )<  $t ){
      return date('Y-m', $strtime )."-".$t;
    }else {
      $t = date('t', mktime(0,0,0,intval(date('m', $strtime))+ 1 ,1, intval(date('Y', $strtime)) ) );
      $t = ($t > $loaninfo['lastday']) ? $loaninfo['lastday']: $t;
      return date('Y-m-d', mktime(0,0,0,intval(date('m', $strtime))+ 1 ,$t, intval(date('Y', $strtime)) ));
    }
  }
  function holiday($date){
    $strtotime = strtotime($date);
    $w = date('w',  $strtotime );
    if(  $w == '0' || $w == '6') {
      return $this->holiday( date('Y-m-d', strtotime("+1 day", $strtotime )) );
    }else return $date;
  }
  function holidayRev($date){
    $strtotime = strtotime($date);
    $w = date('w', strtotime("-1 day", $strtotime ) );
    if(  $w == '0' || $w == '6') {
      return $this->holidayRev( date('Y-m-d', strtotime("-1 day", $strtotime )) );
    }else return $date;
  }

  function diffdate($start, $end){
    return date_diff( date_create($start), date_create($end) )->days;
  }
}
