<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Main extends CI_Controller {
  var $user;
  var $islogin;
  var $nowdate;

  public function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();

    $this->load->model('mainbase');
    if(isset($_SESSION['ss_m_id'])){
        $user = $this->mainbase->meminfo($_SESSION['ss_m_id']);
        if(isset($user['m_id']) && $user['m_id'] == $_SESSION['ss_m_id']) {$this->user = $user;$this->islogin=TRUE;}
        else $this->islogin=FALSE;
    }else $this->islogin=FALSE;
    session_write_close();
    if( $this->needlogin($method) ) $this->{$method}();
  }
  public function index() {
    $sql = "select * from mari_loan a where a.i_view='Y' and ( a.i_look = 'Y' or a.i_look = 'N') order by a.i_id";
    $data['list'] = $this->db->query($sql)->result_array();

    $this->load->view('main_header');
    $this->load->view('main_index', array($data));
    $this->load->view('main_footer');
  }
  public function login(){
echo 'loginpage';
  }
  public function calcabout2(){
    $inset = $this->mainbase->inset();
    $loanid = $this->input->get('loanid');
    $won = ((int)$this->input->get('won') > 0  ) ? $this->input->get('won') : 0 ;
    $won = str_replace(',' , '', $won);
    if((int)$won < 0){
      if($this->input->get('type') == 'htmlpc') {echo "
        <script>
          alert('계산 최소 금액은 5,000,000 입니다.');
          $('input[name=loan_pay]').val('5,000,000');
        </script>";}
      $won = 5000000;
    }
    $tmp = $this->mainbase->loaninfo_for_calc($loanid);
    $tmp['won'] = $won;
    $inset = $this->mainbase->getMemberlimit($this->user);

    $tmp['profit'] = is_null($tmp['default_profit']) ? $inset['i_profit'] : $tmp['default_profit'];
    $tmp['withholding'] = $inset['i_withholding'] + $inset['i_withholding_v'];
    $tmp['i_withholding'] = $inset['i_withholding']*100;
    $tmp['i_withholding_v'] = $inset['i_withholding_v']*100;
    $tmp['invest_flag'] = $inset['invest_flag'];
    $sql = "
      select
      date_format( i_loanexecutiondate,'%Y-%m-%d') as startd1
      , date_format( date_add(now() , interval 0 day ),'%Y-%m-%d') as startd2
      ,a.*, b.* from mari_loan a
      left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
      where i_id = ?
    ";
    $loan = $this->db->query($sql, array($this->input->get('loanid')))->row_array();
    if(!isset($loan['i_id'])){
      return;
    }
    //i_repay 일만기일시상환.. , i_repay_day 매월상환일, i_loan_day:개월 ,
    //i_loanexecutiondate 실행일, i_reimbursement_date 만기일 , i_year_plus 이율
    //$cfg = array('start'=>'2018-01-31', 'end'=>'2018-03-11','month'=>'1', 'dayofeverymonth'=>'17')
    $cfg['start'] = $loan['startd1'] =='0000-00-00' ? $loan['startd2'] : $loan['startd1'];
     $loan['i_reimbursement_date']='';
    if( $loan['i_reimbursement_date'] != '' ) {
      $cfg['end'] = $loan['i_reimbursement_date'];
      $cfg['dayofeverymonth'] = $loan['i_repay_day'];
    }
    else $cfg['month'] = $loan['i_loan_day'];
    //$cfg['dayofeverymonth'] = $loan['i_repay_day'];
    //var_dump($cfg);
    $this->load->library('calcinterest');
    $this->calcinterest->setDate($cfg);
    $timetable = $this->calcinterest->makeTimetable();
    //var_dump($tmp);
    //var_dump($timetable);
    $data = array();
    $total = array('ija'=>0, 'profit'=>0,'withholding'=>0,'tot'=>0);
    $totalcnt = count($timetable);

    $remain = $won;
    $pay = (int)(floor( $won/$totalcnt));

    $pay_months = explode(',', $loan['pay_months']);
    if( count($pay_months) < $totalcnt-1 || count($pay_months) == 0 ){
      $pay_months = array();
    }
    foreach ($timetable as $row ){
      $row['diff'] = $row['diffdate'];
      $row['end'] = $row['holiday'];

      /*계산 */
      $row['ija'] = round( (int)$remain*(float)$tmp['i_year_plus']/100/365*(int)$row['diffdate'] );
      $row['profit'] = floor( $remain * $tmp['profit']*12/365* (int)$row['diffdate'] );
      //$inset['i_withholding'] + $inset['i_withholding_v'];
      $row['withholding1'] = (int)( $row['ija'] *  $inset['i_withholding'] /10)*10;
      $row['withholding2'] = (int)( $row['ija'] *  $inset['i_withholding_v'] /10)*10;
      $row['withholding'] = $row['withholding1'] + $row['withholding2'];
      /* / */
      $rep = ($row['num'] == $totalcnt) ? $remain : ( isset($pay_months[ ( (int)$row['num']- 1) ] ) ?  (int)(floor($pay_months[((int)$row['num']- 1)]/100*$won)) :  $pay)  ;
      $row['pay'] = $rep;

      $remain -= $rep ;
      $row['remain'] = $remain;

      $row['tot'] = $row['ija'] - $row['profit'] - $row['withholding'];

      $data[] = $row;

      $total['ija'] += $row['ija'];
      $total['profit'] += $row['profit'];
      $total['withholding'] += $row['withholding'];
      $total['tot'] += $row['tot'];
    }

    $result = array( 'code'=>200, 'info'=>$tmp, 'calc'=>$data, 'total'=>$total );
    if($this->input->get("type")=="htmlpc") $this->load->view('calcabout', $result);
    else if( $this->input->get("type")=="json" ) echo json_encode($result);
  }

  public function calcabout(){
    $inset = $this->mainbase->inset();
    $loanid = $this->input->get('loanid');
    $won = ((int)$this->input->get('won') > 0  ) ? $this->input->get('won') : 0 ;
    $won = str_replace(',' , '', $won);
    if((int)$won < 0){
      if($this->input->get('type') == 'htmlpc') {echo "
        <script>
          alert('계산 최소 금액은 5,000,000 입니다.');
          $('input[name=loan_pay]').val('5,000,000');
        </script>";}
      $won = 5000000;
    }
    $tmp = $this->mainbase->loaninfo_for_calc($loanid);
    $tmp['won'] = $won;
    $inset = $this->mainbase->getMemberlimit($this->user);

    $tmp['profit'] = is_null($tmp['default_profit']) ? $inset['i_profit'] : $tmp['default_profit'];
    $tmp['withholding'] = $inset['i_withholding'] + $inset['i_withholding_v'];
    $tmp['i_withholding'] = $inset['i_withholding']*100;
    $tmp['i_withholding_v'] = $inset['i_withholding_v']*100;
    $tmp['invest_flag'] = $inset['invest_flag'];
    if($tmp['i_repay']!="일만기일시상환"){
      $this->calcabout2($tmp, $inset);
      return;
    }
    $data = array();
    $total = array('ija'=>0, 'profit'=>0,'withholding'=>0,'tot'=>0);


    $this->load->library('calcdate');

    $this->calcdate->setstart($tmp['startd']);
    $this->calcdate->setend($tmp['endd']);
    $data = $this->calcdate->getDateList();
    foreach ($data as &$res){
      $res['ija'] = (int)($won*(float)$tmp['i_year_plus']/100/365*(int)$res['diff'] );
      $res['profit'] = (int)($won*$tmp['profit']);
      $res['withholding'] = (int)($res['ija']*$tmp['withholding']/10)*10;
      $res['tot'] = $res['ija'] - $res['profit'] -   $res['withholding'];

      $total['ija'] += $res['ija'];
      $total['profit'] += $res['profit'];
      $total['withholding'] += $res['withholding'];
      $total['tot'] += $res['tot'];
    }
    $result = array( 'code'=>200, 'info'=>$tmp, 'calc'=>$data, 'total'=>$total );
    if($this->input->get("type")=="htmlpc") $this->load->view('calcabout', $result);
    else if( $this->input->get("type")=="json" ) echo json_encode($result);
  }

/* 원금균등상환 */
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
/* 원금균등상환 */
  /* 로그인 필요한 METHOD 체크 */
  private function needlogin($method) {
    $need = array();
    if( $this->islogin === false && in_array($method , $need) ){
      if($this->input->get('datatype')=='json') {
        echo json_encode( array('code'=>501, 'msg'=>'로그인이 필요합니다.'));
      }else {
        $this->login();
      }
      return false;
    }else return true;
  }
  protected function json( $data = '' ){
  		header('Content-Type: application/json');
  		if ($data =='') $data = array ( 'code'=>500, 'msg'=>'Unknown Error Occured');
  		echo json_encode( $data );
  		exit;
  	}

}
