<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
정산테이블
  가능 input :
    $this->input->get('yearmonth'); 201803
    $this->input->get('loan_id');271
  output :
    json_encode(array('code'=>500, 'mst'=>"로그인 후 사용해 주세요"));
    json_encode(array('code'=>200, 'data'=>$table, 'total'=>$total));

  * 원리금균등상환 => 원금 균등상환으로 변경
  * 만기일시일 경우 mari_repay_schedule만을 참조함,
  * 수수료율이 따로 등록되지 않았을 경우 inset수수료율로 계산
*/
class main2 extends CI_Controller {
  var $userid;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    if(isset($_SESSION['ss_m_id'])){
      $this->userid = $_SESSION['ss_m_id'];
    }else if( $method !='calcabout'){
    $this->islogin=FALSE;
      $this-> json(array('code'=>500, 'mst'=>"로그인 후 사용해 주세요"));return;
    }
    session_write_close();
    $this->{$method}();
  }
  function calcabout(){
    //예상계산기
    $jungsantb = new jungsantb;
    $sql = "
    select
      case
    		when ( mem.m_level > 2 ) then inset.i_withholding_burr + inset.i_withholding_burr_v
    		when ( mem.m_signpurpose ='I') then inset.i_withholding_in + inset.i_withholding_in_v
    		when ( mem.m_signpurpose ='P') then inset.i_withholding_pro + inset.i_withholding_pro_v
    		when ( mem.m_signpurpose ='L2') then inset.i_withholding_personalloan + inset.i_withholding_personalloan_v
    		when ( mem.m_signpurpose ='C2') then inset.i_withholding_corporateloan + inset.i_withholding_corporateloan_v
    		when ( mem.m_signpurpose ='I2') then inset.i_withholding_incomeloan + inset.i_withholding_incomeloan_v
    		else inset.i_withholding_personal + inset.i_withholding_personal_v
    		end as withholdingp
    from mari_member mem
      join mari_inset inset
    where mem.m_id = ?
    ";
    $row = $this->db->query($sql, array($this->userid) )->row_array();
    $withholdingp = (isset($row['withholdingp'])) ? $row['withholdingp'] : '0.275';
    $sql = "
      select ifnull( ext.default_profit , inset.i_profit ) default_susuryo, loa.*
      from mari_loan loa
      join mari_inset inset
      left join mari_loan_ext ext on loa.i_id = fk_mari_loan_id
      where loa.i_id =   ?
    ";
    $row = $this->db->query($sql, array($this->input->get('loanid') ) )->row_array();
    $default_susuryo = $row['default_susuryo'] ;

    $sql = "select a.i_id, a.i_subject, a.i_repay as method, a.i_repay_day as lastday ,a.i_loan_day as gigan,a.i_year_plus as iyul, date_format(a.i_loanexecutiondate, '%Y-%m-%d') as sdate,b.i_reimbursement_date as edate, b.default_profit
        from  mari_loan a
        left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
        where a.i_id = ?";
    $loaninfo = $this->db->query($sql, array( $this->input->get('loanid') ))->row_array();
    $timetable =  $jungsantb->history($loaninfo, $this->input->get('won'), $this->userid,$withholdingp, $default_susuryo)  ;
    var_dump($loaninfo);
    var_dump($timetable);
  }
  function index() {
    list($table,$prepare,$loanlist) = $this->totaltable();

    $yearmonth = $this->input->get('yearmonth');
    if($yearmonth==""){
      if($this->input->get('year') != "" && $this->input->get('month') != "") {
        $yearmonth = sprintf("%4d%02d",$this->input->get('year'), $this->input->get('month') );
      }
      else if($this->input->get('tomonth') =='true') $yearmonth ==date('Ym');
    }

    $loanid = $this->input->get('loan_id');
    $total['not_complete'] =$total['not_complete_won'] =$total['complete'] =$total['complete_won'] = $total['count'] =$total['wongum'] = $total['invtotal'] =  $total['susuryo'] = $total['o_withholding'] = $total['p_emoney'] =0;

    $tmp = array();
    $todayym = date('Yn');
    foreach($table as $row){
      $time = date('Ym', strtotime($row['repay_date']));
      if(  $yearmonth!='' && ($time < $yearmonth || $time > $yearmonth) ) continue;
      if ( $loanid > 0 &&  $row['loan_id'] != $loanid ) continue;

      $row['date'] = $row['repay_date'];
      $row['todayym'] = $todayym;
      $row['yearmonth'] = date('Yn', strtotime($row['repay_date']));
      $row['badge'] = true;
      $row['title'] = $row['subject'];
      $row['body'] = "";
      $row['footer'] = "";
      $row['classname'] = "purple-event";

      $tmp[] = $row;
      $total['wongum'] += $row['wongum'];
      $total['invtotal'] += $row['invtotal'];
      $total['susuryo'] += $row['susuryo'];
      $total['o_withholding'] += $row['o_withholding'];
      $total['p_emoney'] += $row['p_emoney'];
      $total['count'] += 1;
      if( $row['complete']=='Y') {
        $total['complete'] += 1;
        $total['complete_won'] += $row['p_emoney'];
      }else {
        $total['not_complete'] += 1;
        $total['not_complete_won'] += $row['p_emoney'];
      }
    }
    $table = $tmp;
    if( $this->input->get('prepare')=='true' ) $this->json(array("jungsan"=>$table, "prepare"=>$prepare,"loanlist"=>$loanlist) );
    else $this-> json($table);
  }
  function totaltable() {
    $prepare = array();
    $timetable = array();

    //leesh@tourcabin.com
    $sql = "
    select inv.* , loa.* , ifnull( ext.default_profit , inset.i_profit ) default_susuryo
    	,case
    		when ( mem.m_level > 2 ) then inset.i_withholding_burr + inset.i_withholding_burr_v
    		when ( mem.m_signpurpose ='I') then inset.i_withholding_in + inset.i_withholding_in_v
    		when ( mem.m_signpurpose ='P') then inset.i_withholding_pro + inset.i_withholding_pro_v
    		when ( mem.m_signpurpose ='L2') then inset.i_withholding_personalloan + inset.i_withholding_personalloan_v
    		when ( mem.m_signpurpose ='C2') then inset.i_withholding_corporateloan + inset.i_withholding_corporateloan_v
    		when ( mem.m_signpurpose ='I2') then inset.i_withholding_incomeloan + inset.i_withholding_incomeloan_v
    		else inset.i_withholding_personal + inset.i_withholding_personal_v
    		end as withholdingp
    from mari_invest inv
    join mari_loan loa on inv.loan_id = loa.i_id
    join mari_member mem on inv.m_id = mem.m_id
    join mari_inset inset
    left join mari_loan_ext ext on inv.loan_id = fk_mari_loan_id

    where inv.m_id = ? and inv.i_pay_ment ='Y' order by loan_id
    ";
    $loanlist = $this->db->query($sql, array($this->userid) )->result_array();

    $jungsantb = new jungsantb;
    foreach ($loanlist as $row) {
      if( $row['i_look'] =='F'){
        //상환완료
        $sql = "select
b.i_subject as subject, loan_id, a.o_count,a.o_paytype, date_format(a.o_collectiondate, '%Y-%m-%d') repay_date , '완료' as `status` , a.o_ln_money_to, a.remaining_amount, a.wongum, a.inv, a.Delinquency, (a.inv + a.Delinquency) as invtotal, a.susuryo, a.o_withholding, a.p_emoney
from view_jungsan a
join mari_loan b on a.loan_id = b.i_id
where a.loan_id =? and a.sale_id = ? order by a.o_count";
        $table = $this->db->query( $sql , array($row['loan_id'], $this->userid))->result_array();
        foreach ($table as $idx=>&$row){
          $row['complete'] = ( $idx == count($table)-1 ) ? 'Y' : 'N';
          $timetable[] = $row;
        }
      //  $timetable = array_merge($timetable, $table);
      }else if ( $row['i_look'] =='D'){
        //상환중
        if( $row['i_repay'] == '일만기일시상환' || $row['i_repay'] == '원리금균등상환' ){
          $sql = "select a.i_id, a.i_subject, a.i_repay as method, a.i_repay_day as lastday ,a.i_loan_day as gigan,a.i_year_plus as iyul, date_format(a.i_loanexecutiondate, '%Y-%m-%d') as sdate,b.i_reimbursement_date as edate, b.default_profit
              from  mari_loan a
              left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
              where a.i_id = ?";
          $loaninfo = $this->db->query($sql, array( $row['loan_id']))->row_array();
          $timetable = array_merge($timetable, $jungsantb->history($loaninfo, $row['i_pay'], $this->userid,$row['withholdingp'], $row['default_susuryo']) ) ;
        }else {
          //만기일시상환
          $sql = "select
b.i_subject as subject, loan_id, a.o_count,a.o_paytype, date_format(a.o_collectiondate, '%Y-%m-%d') repay_date , '완료' as `status`,'N' as `complete` , a.o_ln_money_to, a.remaining_amount, a.wongum, a.inv, a.Delinquency, (a.inv + a.Delinquency) as invtotal, a.susuryo, a.o_withholding, a.p_emoney
from view_jungsan a
join mari_loan b on a.loan_id = b.i_id
where a.loan_id =? and a.sale_id = ? order by a.o_count";
          $table = $this->db->query( $sql , array($row['loan_id'], $this->userid))->result_array();
          $sql = "
          select
          	c.i_subject subject,a.loan_id, 0 as o_count, c.i_repay as o_paytype , a.r_orderdate repay_date, '예정' as `status`, b.i_pay as o_ln_money_to,  b.i_pay as remaining_amount
          	, 0 as wongum , b.i_pay * c.i_year_plus/100/12 as inv , 0 as Delinquency , 0 as invtotal, 0 as susuryo , 0 as o_withholding , 0 as p_emoney
          from mari_repay_schedule a
          join mari_invest b on a.loan_id = b.loan_id and b.m_id = ? and b.i_pay_ment ='Y'
          join mari_loan c on a.loan_id = c.i_id
          where a.loan_id = ? and a.r_view = 'Y' and a.r_salestatus ='상환예정'
          order by r_orderdate
          ";
          $tmp = $this->db->query($sql, array($this->userid, $row['loan_id']) )->result_array();
          $o_count = ( isset($table [ count($table) - 1 ]['o_count']))  ? $table [ count($table)-1]['o_count'] + 1 : 1;
          foreach ($tmp as $idx => $row2){
            $row2['o_count'] = $o_count++;
            $row2['wongum'] = ( $idx == count($tmp)-1 ) ? $row2["o_ln_money_to"] : 0;
            $row2['complete'] = ( $idx == count($tmp)-1 ) ? 'Y' : 'N';
            $row2['inv'] = round($row2['inv']);
            $row2['invtotal'] = $row2['inv'] +$row2['Delinquency'] ;
            $row2['susuryo'] = floor($row2["o_ln_money_to"] * $row['default_susuryo']);
            $row2['o_withholding'] = ($row['withholdingp'] > 0 ) ? floor($row2['invtotal']*$row['withholdingp']/10)*10 :0;
            $row2['p_emoney'] = $row2['wongum'] + $row2['invtotal'] - $row2['susuryo'] - $row2['o_withholding'];
            $table[] = $row2;
          }
          $timetable = array_merge($timetable, $table);
        }
      }else {
        //예정
        $prepare[] = $row;
      }
    }
    return( array($timetable,$prepare,$loanlist) );
  }
  protected function json( $data = '' ){
    header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
    echo json_encode( $data );
    exit;
  }
}



class jungsantb {
  var $CI;
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->CI=& get_instance();
  }
  function history(&$loaninfo,$i_pay ,$userid, $withholdingp=0.275,$susuryo=0 ){
    $timetable = $this->timetable($loaninfo);
    $realtime = $this->CI->db->query ('select *, date_format(o_collectiondate,"%Y-%m-%d" ) as repay_date  from view_jungsan where loan_id =? and sale_id = ? order by o_count', array($loaninfo['i_id'], $userid ) )->result_array();

    if( count($realtime)> 0 ) {
        $remain = $realtime[ count($realtime) - 1 ]['remaining_amount'];
    }else $remain = $i_pay;
    //원금균등
    $monthly = round( $remain / (count($timetable)-count($realtime)) );

    foreach ($timetable as $idx=>&$row){
      $row['subject'] = $loaninfo['i_subject'];
      $row['loan_id'] = $loaninfo['i_id'];
      $row ['o_count'] = $idx+1;
      $row ['o_paytype'] = $loaninfo['method'] =='원리금균등상환' ? '원금균등상환' : $loaninfo['method'];

      $remaining = $i_pay;
      if( isset ($realtime[$idx]) ){
        $row['repay_date'] = $realtime[$idx]['repay_date'];
        $row ['status'] = $realtime[$idx]['status'] =='Y' ?  "완료": "준비";
        $row ['o_ln_money_to'] = $realtime[$idx]['o_ln_money_to'];
      #  $row ['before_remaining'] = $realtime[$idx]['before_remaining'];
        $row ['remaining_amount'] = $realtime[$idx]['remaining_amount'];

        $row ['wongum'] = $realtime[$idx]['wongum'];
        $row ['inv'] = $realtime[$idx]['inv'];
        $row ['Delinquency'] = $realtime[$idx]['Delinquency'];
        $row ['invtotal'] = $row ['inv'] + $row ['Delinquency'];
        $row ['susuryo'] = $realtime[$idx]['susuryo'];
        $row ['o_withholding'] = $realtime[$idx]['o_withholding'];
        $row ['p_emoney'] = $realtime[$idx]['p_emoney'];
      }else {
        $row['repay_date'] = $row ['holiday'];
        $row ['status'] ='예정';
        $row ['o_ln_money_to'] = $i_pay;

         $tmpsusuryo = ($susuryo == 0 ) ? 0 : floor($remain*$susuryo*12/365*$row['diff']);

        if( $loaninfo['method']=='원리금균등상환') {
          $row['wongum'] = ( $idx == count($timetable)-1 ) ? $remain : ( ($remain - $monthly < 0) ? $remain : $monthly )  ;
          $real_ija = ($remain * (float)$loaninfo['iyul']/100 /365 * $row['diff']);
          $remain  = ($remain - $monthly < 0) ? 0 : $remain - $monthly;
        }else {
          $row['wongum'] = ($idx == count($timetable)-1 ) ? $remain : 0;
          $real_ija = ($remain * (float)$loaninfo['iyul']/100 /365 * $row['diff']);
          $remain  = $remain - $row['wongum'];
        }
        //$row['wongum'] = ($remain - $monthly < 0) ? $remain : $monthly;

        $row['inv'] = round($real_ija); // 기존것과 맞추기 위해 반올림
        $row ['Delinquency'] = 0 ;
        $row ['invtotal'] = $row ['inv'] + $row ['Delinquency'];
        $row ['remaining_amount'] = ( $idx == count($timetable)-1 ) ? 0: $remain;
        $row ['susuryo'] = $tmpsusuryo;
        $row ['o_withholding'] = floor($row ['invtotal']*$withholdingp/10)*10;
        $row ['p_emoney'] = $row['wongum'] + $row ['invtotal'] - $row ['susuryo'] - $row ['o_withholding'];
      }
    }
    return $timetable;
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
    for ($i =1; $i <= $loaninfo['gigan']+2; $i ++){
      $ndate = $this->nextdate($date,$loaninfo);

      if( $loaninfo['edate']!='' &&  $loaninfo['edate']!='0000-00-00' && $ndate >= $loaninfo['edate'] ){
        $ret[] = array('startdate'=>$date, 'nextdate'=>$loaninfo['edate'], 'holiday'=>$this->holiday($loaninfo['edate']), "diff"=> $this->diffdate($date,$loaninfo['edate']) ,'complete'=>'Y');
        break;
      }
      $ret[] = array('startdate'=>$date, 'nextdate'=>$ndate, 'holiday'=>$this->holiday($ndate), "diff"=> $this->diffdate($date,$ndate),'complete'=>'N');
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
