<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Calcultemp extends CI_Controller {

  var $userid;

  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    if(isset($_SESSION['ss_m_id'])){
      $this->userid = $_SESSION['ss_m_id'];
    }else $this->islogin=FALSE;
    session_write_close();
    $this->{$method}();

  }
  function index() {
    //$this->db = $this->load->database('real',true);
    date_default_timezone_set('Asia/Seoul');

    $loan_id = $this->input->get('loan_id');
    $total =$remain = $this->input->get('i_payment');

    $i_pay = $this->input->get('loan_id');
    $sql = "select a.i_id, a.i_repay as method, a.i_repay_day as lastday ,a.i_loan_day as gigan,a.i_year_plus as iyul, date_format(a.i_loanexecutiondate, '%Y-%m-%d') as sdate,b.i_reimbursement_date as edate, b.default_profit
        from  mari_loan a
        left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
        where a.i_id = ?";

    $loaninfo = $this->db->query($sql, array($loan_id))->row_array();
    if ( in_array($loan_id, array('384','387') ) ) $loaninfo['method'] = '원금균등상환';
    if ( $loaninfo['method'] == '일만기일시') $loaninfo['lastday'] = 31;

    $timetable = $this->timetable($loaninfo);
    switch ($loaninfo['method']) {
      case("원금균등상환") :
        $this->wongumgyundung($timetable,$loaninfo,$total,$remain);
        break;
    }
//var_dump($timetable);
    $this->load->view('mode_calculation', array('timetable'=>$timetable,'loaninfo'=>$loaninfo,'total'=>$total ));
  }
  function wongumgyundung(&$timetable,$loaninfo,&$total,$remain){
    if( $this->userid != ''){
      $jigupinfo = $this->db->query('select *, date_format(o_collectiondate, "%Y-%m-%d") as jungsan_date from view_jungsan where loan_id = ? and sale_id = ? order by o_count', array($loaninfo['i_id'],$this->userid ) )->result_array();
      $temp = $this->db->query('select i_pay from mari_invest a where a.loan_id =? and m_id = ?', array($loaninfo['i_id'],$this->userid ) )->row_array();
      $total = $temp['i_pay'];
      if( count($jigupinfo)> 0 ) {
          $remain = $jigupinfo[ count($jigupinfo) - 1 ]['remaining_amount'];
      }else $remain = $total;
      $monthly = round( $remain / (count($timetable)-count($jigupinfo)) );
    }else {
      $monthly = round( $total / count($timetable) );
    }
    foreach($timetable as $idx=>&$row){
      if( isset($jigupinfo[$idx]) ) {
        $row['wongum'] = $jigupinfo[$idx]['wongum'];
        $row['real_ija'] = $jigupinfo[$idx]['inv'];
        $row['ija'] = $jigupinfo[$idx]['inv'];
        $row['remain'] = $jigupinfo[$idx]['remaining_amount'];
        $row['holiday'] = $jigupinfo[$idx]['jungsan_date'];
        $row['completed'] ='Y';
      }else {
        $row['wongum'] = ( $idx == count($timetable)-1 ) ? $remain : ( ($remain - $monthly < 0) ? $remain : $monthly )  ;
        //$row['wongum'] = ($remain - $monthly < 0) ? $remain : $monthly;
        $row['real_ija'] = ($remain * (float)$loaninfo['iyul']/100 /365 * $row['diff']);
        $row['ija'] = ceil($row['real_ija']);
        $remain  = ($remain - $monthly < 0) ? 0 : $remain - $monthly;
        $row['remain'] = ( $idx == count($timetable)-1 ) ? 0: $remain;
        $row['completed'] ='N';
      }
    }
  }
  function timetable(&$loaninfo){
    $loandinfo['virtual']='N';
    if ($loaninfo['sdate']=='' || $loaninfo['sdate']=='0000-00-00') {
        $loaninfo['sdate'] = date('Y-m-d');
        $loandinfo['virtual']='Y';
    }
    if ($loaninfo['edate']=='' || $loaninfo['edate']=='0000:00:00') {
      $loandinfo['virtual']='Y';
    }
    if($loaninfo['lastday']=='') $lastday = 31;

    $date = $loaninfo['sdate'];
    for ($i =1; $i <= $loaninfo['gigan']; $i ++){
      $ndate = $this->nextdate($date,$loaninfo);

      if( $loaninfo['edate']!='' &&  $loaninfo['edate']!='0000:00:00' && $ndate >= $loaninfo['edate'] ){
        $ret[] = array('startdate'=>$date, 'nextdate'=>$loaninfo['edate'], 'holiday'=>$this->holiday($loaninfo['edate']), "diff"=> $this->diffdate($date,$loaninfo['edate']) );
        break;
      }
      $ret[] = array('startdate'=>$date, 'nextdate'=>$ndate, 'holiday'=>$this->holiday($ndate), "diff"=> $this->diffdate($date,$ndate));
      $date = $ndate;
    }
    return $ret;
    /*
    if ($loaninfo['edate']=='' || $loaninfo['edate']=='0000:00:00') {
      $strtime = strtotime($loaninfo['sdate']);
      $tempdate = date('t', mktime(0,0,0,intval(date('m', $strtime))+ (int)$loaninfo['gigan'] ,1, intval(date('Y', $strtime)) ) );
      $day = ($tempdate > $loaninfo['lastday']) ? $loaninfo['lastday']: $tempdate;
      $loaninfo['edate']= date('Y-m-d', mktime(0,0,0,intval(date('m', $strtime))+ (int)$loaninfo['gigan'] ,$day, intval(date('Y', $strtime)) ));
    }
    */
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
  function diffdate($start, $end){
    return date_diff( date_create($start), date_create($end) )->days;
  }
}
?>
