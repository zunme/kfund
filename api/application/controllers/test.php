<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Test extends CI_Controller {
  function oauth() {
    $this->load->driver('cache', array('adapter' => 'file'));

    if ( isset($_GET) && count($_GET) > 0 )
    {
      var_dump(count($_GET) );
         $this->cache->save('foo', array( "code"=>"get", "data"=>$_GET), 300);
    } else if ( isset($_POST) && count($_POST) > 0)
    {
            var_dump(count($_GET) );
         $this->cache->save('foo', array( "code"=>"post", "data"=>$_POST), 300);
    } else var_dump( $this->cache->get('foo') );
  }

  function index(){
  //  $sunapdate = new sunapdate;
  //  $sunapdate->set('2017-12-31','2018-02-02','2018-01-31');
  }
  function nice() {
    session_start();
    $config = $this->db->query("select * from mari_config limit 1")->row_array();

    $actiontype = ($this->input->post("actiontype")=='change' ? "change":"join" );
    $this->load->library('encrypt');
    $param = $this->encrypt->encode( date("sHis").":".$actiontype.":".date("sisYm"),"ankey2039");

    if (!extension_loaded('CPClient')) {
        dl('CPClient.' . PHP_SHLIB_SUFFIX);
    }

    $module     = 'CPClient';
    $sitecode   = 'AD150';
    $sitepasswd = '1oTqvwP9oZZs';
    $authtype   = "";
    $popgubun   = "N";
    $customize  = "";
    $reqseq     = "REQ_0123456789";
    if (extension_loaded($module)) {
        $reqseq = get_cprequest_no($sitecode);
    } else {
        $reqseq = "Module get_request_no is not compiled into PHP";
    }
    $_SESSION["REQ_SEQ"] = $reqseq;
    $req_datetime        = date("YmdHis");

    $returnurl          = "https://fundingangel.co.kr:6003/api/index.php/test/authed";
    $errorurl           = "https://fundingangel.co.kr:6003/api/index.php/test/authederr";
    //$sPlainData          = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "12:REQ_DATETIME" . strlen($req_datetime) . ":" . $req_datetime . "8:SITECODE" . strlen($sitecode) . ":" . $sitecode . "9:AUTH_TYPE" . strlen($sAuthType) . ":" . $sAuthType . "10:AGREE1_MAP" . strlen($agree1_map) . ":" . $agree1_map . "10:AGREE2_MAP" . strlen($agree2_map) . ":" . $agree2_map . "10:AGREE3_MAP" . strlen($agree3_map) . ":" . $agree3_map . "8:USERNAME" . strlen($username) . ":" . $username . "9:BIRTHDATE" . strlen($birthdate) . ":" . $birthdate . "6:GENDER" . strlen($gender) . ":" . $gender . "8:CI_GUBUN" . strlen($cigubun) . ":" . $cigubun . "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun . "7:RTN_URL" . strlen($sReturnUrl) . ":" . $sReturnUrl . "7:ERR_URL" . strlen($sErrorUrl) . ":" . $sErrorUrl;
    $sPlainData           = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "8:SITECODE" . strlen($sitecode) . ":" . $sitecode . "9:AUTH_TYPE" . strlen($authtype) . ":" . $authtype . "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl . "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl . "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun . "9:CUSTOMIZE" . strlen($customize) . ":" . $customize;
    $returnMsg ='';
    if (extension_loaded($module)) {
        $enc_data = get_encode_data($sitecode, $sitepasswd, $sPlainData);
    }
    if (extension_loaded($module)) {
        $enc_data = get_encode_data($sitecode, $sitepasswd, $sPlainData);
    } else {
        $returnMsg=$enc_data = "Module get_request_data is not compiled into PHP";
    }
    if ($enc_data == -1) {
        $returnMsg = "암/복호화 시스템 오류입니다.";
        $enc_data  = "";
    } else if ($enc_data == -2) {
        $returnMsg = "암호화 처리 오류입니다.";
        $enc_data  = "";
    } else if ($enc_data == -3) {
        $returnMsg = "암호화 데이터 오류 입니다.";
        $enc_data  = "";
    } else if ($enc_data == -9) {
        $returnMsg = "입력값 오류 입니다.";
        $enc_data  = "";
    }
    $this->load->view("nicecheckform", array("enc_data"=>$enc_data,"returnMsg"=>$returnMsg,"param"=>$param) );
  }
  function authed(){
    $this->sitecode   = 'AD150';
    $this->sitepasswd = '1oTqvwP9oZZs';
    $retdata = array();

    session_start();
    $EncodeData = $this->input->post('EncodeData');
if($EncodeData=='') $EncodeData = "AgAFQUQxNTBXxqf8nw9UEpfPyLfufm3eEQUIANusBvJ2j3XhcVUuzTQSkiPFjpFp1662Fsey8BBRHn1k2W58RHaB5f4Yh/7DpdLFkn2XKPbe0ZcRQWFIQ6cxdLdszZdvyLxpYSIWlPa3XIgdaaY1MqUfRXCFaBiDP6UpukSUlBe90pTs+PEcwRApih9LVJol44BrYOfc96OCIAF05GvwCr9wFL0RErbqGsQgZ+v342/tdTenS8L4ON/WAj4csWLeQdSJhrC0dc29z6MJIF4z19RcGt7bLIhNCMghtCQoCpN3PTfljFYndjs/kCD7hgqF+P1wZuY028RZm28lwFKFG8vsNBRx3MHQKS4iu4RvN2QCxF+cOrrXL8CENqBhsbBkdBqDfrvTQuvTIcCGzBGxxupPjP8EGGOQdmsIWHIuBMqDdcVJRMVWk6/PgNJy6i2DatnFvBsEOnUXUASNHLDIcnlMU7x5AJnvIQEj41GcG18TnzM0buwh0FvRH7gP5isK5StbY2G1UHax9ylq2HOO9L62qDWPRIsHmn35Pq1iGywvEp/l3WqnW9TUdGbt5H6o0OFiJa12K50=";
    if (!extension_loaded('CPClient')) {
        dl('CPClient.' . PHP_SHLIB_SUFFIX);
    }
    //var_dump($reqseq);
    $plaindata = get_decode_data($this->sitecode, $this->sitepasswd, $EncodeData);
    if ($plaindata == -1){
        $returnMsg  = "암/복호화 시스템 오류";
    }else if ($plaindata == -4){
        $returnMsg  = "복호화 처리 오류";
    }else if ($plaindata == -5){
        $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
    }else if ($plaindata == -6){
        $returnMsg  = "복호화 데이터 오류";
    }else if ($plaindata == -9){
        $returnMsg  = "입력값 오류";
    }else if ($plaindata == -12){
        $returnMsg  = "사이트 비밀번호 오류";
    }else{
      $returnMsg  ="";
      $retdata['requestnumber'] = $this->GetValue($plaindata , "REQ_SEQ");
      $retdata['responsenumber'] = $this->GetValue($plaindata , "RES_SEQ");
      $retdata['authtype'] = $this->GetValue($plaindata , "AUTH_TYPE");
      //$retdata['name'] = $this->GetValue($plaindata , "NAME");
      $retdata['name'] = urldecode($this->GetValue($plaindata , "UTF8_NAME")); //charset utf8 사용시 주석 해제 후 사용
      $retdata['birthdate'] = $this->GetValue($plaindata , "BIRTHDATE");
      $retdata['gender'] = $this->GetValue($plaindata , "GENDER");
      $retdata['nationalinfo'] = $this->GetValue($plaindata , "NATIONALINFO");	//내/외국인정보(사용자 매뉴얼 참조)
      $retdata['dupinfo'] = $this->GetValue($plaindata , "DI");
      //$retdata['conninfo'] = $this->GetValue($plaindata , "CI");
      $retdata['mobileno'] = $this->GetValue($plaindata , "MOBILE_NO");
      //$retdata['mobileco'] = $this->GetValue($plaindata , "MOBILE_CO");

      $this->load->library('encrypt');
      if( isset($_POST['param_r1']) && $_POST['param_r1'] !="" ){
        $param = $this->encrypt->decode( $this->input->post('param_r1'),"ankey2039");
        $tmp = explode(':', $param);
        if( isset($tmp[1]) && $tmp[1]=='change' ) $actiontype = 'change';
        else $actiontype ="join";
      }else {
        $actiontype = "join";
      }
      $retdata['actiontype'] = $actiontype;
      /*
      if ( $_SESSION["REQ_SEQ"] != $retdata['requestnumber']){
        $retdata = array();
        $returnMsg  ="인증비교 오류";
      }
      */
    }
    var_dump($retdata);
    var_dump($returnMsg);
  }
  function authederr(){
    var_dump($_SERVER);
  }
  function getview() {
    $this->sitecode   = 'AD150';
    $this->sitepasswd = '1oTqvwP9oZZs';
    $retdata = array();

    session_start();
    $reqseq = $_SESSION["REQ_SEQ"];

    $EncodeData = $this->input->post('EncodeData');
    $EncodeData = "AgAFQUQxNTBXxqf8nw9UEpfPyLfufm3eEQUIANusBvJ2j3XhcVUuzTQSkiPFjpFp1662Fsey8BBRHn1k2W58RHaB5f4Yh/7DpdLFkn2XKPbe0ZcRQWFIQ6cxdLdszZdvyLxpYSIWlPa3XIgdaaY1MqUfRXCFaBiDP6UpukSUlBe90pTs+PEcwRApih9LVJol44BrYOfc96OCIAF05GvwCr9wFL0RErbqGsQgZ+v342/tdTenS8L4ON/WAj4csWLeQdSJhrC0dc29z6MJIF4z19RcGt7bLIhNCMghtCQoCpN3PTfljFYndjs/kCD7hgqF+P1wZuY028RZm28lwFKFG8vsNBRx3MHQKS4iu4RvN2QCxF+cOrrXL8CENqBhsbBkdBqDfrvTQuvTIcCGzBGxxupPjP8EGGOQdmsIWHIuBMqDdcVJRMVWk6/PgNJy6i2DatnFvBsEOnUXUASNHLDIcnlMU7x5AJnvIQEj41GcG18TnzM0buwh0FvRH7gP5isK5StbY2G1UHax9ylq2HOO9L62qDWPRIsHmn35Pq1iGywvEp/l3WqnW9TUdGbt5H6o0OFiJa12K50=";


    if (!extension_loaded('CPClient')) {
        dl('CPClient.' . PHP_SHLIB_SUFFIX);
    }
    //var_dump($reqseq);
    $plaindata = get_decode_data($this->sitecode, $this->sitepasswd, $EncodeData);

    if ($plaindata == -1){
        $returnMsg  = "암/복호화 시스템 오류";
    }else if ($plaindata == -4){
        $returnMsg  = "복호화 처리 오류";
    }else if ($plaindata == -5){
        $returnMsg  = "HASH값 불일치 - 복호화 데이터는 리턴됨";
    }else if ($plaindata == -6){
        $returnMsg  = "복호화 데이터 오류";
    }else if ($plaindata == -9){
        $returnMsg  = "입력값 오류";
    }else if ($plaindata == -12){
        $returnMsg  = "사이트 비밀번호 오류";
    }else{
      $returnMsg  ="";
      $retdata['reqseq'] = $_SESSION["REQ_SEQ"];
      $retdata['requestnumber'] = $this->GetValue($plaindata , "REQ_SEQ");
      $retdata['responsenumber'] = $this->GetValue($plaindata , "RES_SEQ");
      $retdata['authtype'] = $this->GetValue($plaindata , "AUTH_TYPE");
      $retdata['name'] = $this->GetValue($plaindata , "NAME");
      $retdata['UTF8_name'] = $this->GetValue($plaindata , "UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
      $retdata['birthdate'] = $this->GetValue($plaindata , "BIRTHDATE");
      $retdata['gender'] = $this->GetValue($plaindata , "GENDER");
      $retdata['nationalinfo'] = $this->GetValue($plaindata , "NATIONALINFO");	//내/외국인정보(사용자 매뉴얼 참조)
      $retdata['dupinfo'] = $this->GetValue($plaindata , "DI");
      //$retdata['conninfo'] = $this->GetValue($plaindata , "CI");
      $retdata['mobileno'] = $this->GetValue($plaindata , "MOBILE_NO");
      //$retdata['mobileco'] = $this->GetValue($plaindata , "MOBILE_CO");
    }
    var_dump($retdata);
  }
  function GetValue($str , $name)
{
    $pos1 = 0;  //length의 시작 위치
    $pos2 = 0;  //:의 위치

    while( $pos1 <= strlen($str) )
    {
        $pos2 = strpos( $str , ":" , $pos1);
        $len = substr($str , $pos1 , $pos2 - $pos1);
        if((int)$len>0) {
          $key = substr($str , $pos2 + 1 , $len);
        }else $key = null;

        $pos1 = $pos2 + $len + 1;
        if( $key == $name )
        {
            $pos2 = strpos( $str , ":" , $pos1);
            $len = substr($str , $pos1 , $pos2 - $pos1);
            $value = substr($str , $pos2 + 1 , $len);
            return $value;
        }
        else
        {
            // 다르면 스킵한다.
            $pos2 = strpos( $str , ":" , $pos1);
            $len = substr($str , $pos1 , $pos2 - $pos1);
            $pos1 = $pos2 + $len + 1;
        }
    }
}
}


/*
class sunapdate{
  var $CI;
  var $today;
  var $msg='';
  var $isExpired;
  var $basedata;
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $isExpired = false;
    $this->CI=& get_instance();
  }
  function set($start, $expire,$sunap='', $day='last'){
    $data['start'] = strtotime($start);
    $data['expire'] = strtotime($expire);
    $data['expire_Holiday'] = $this->getHoliday($data['expire']);
    $data['sunap'] = ($sunap=='') ? $this->today : strtotime($sunap);
    $data['day'] = $day;
    $this->bassedata = $data;

    $next = $this->nextdate($data['start']);

  }
  function getHoliday($date){
    if( in_array(date('w', $date ), array(0, 6) ) ) {
      $date = $this->getHoliday(mktime(0,0,0, date('m', $date), date('d', $date)+1, date('Y', $date) ) );
    }
    return $date;
  }
  function  nextdate($start){
    if($this->bassedata['sunap'] > $this->bassedata['expire_Holiday'] ){
      echo "만기후연체";
    }else if ( $this->bassedata['sunap'] == $this->bassedata['expire'] ){
      echo "만기";
    }else {
      $thismonth = $this->lastDate( $start);
      if($start >= $thismonth ) $thismonth = $this->lastDate( mktime(0,0,0, date('m', $thismonth['date'] )+1, 1, date('Y', $thismonth['date']) ) );
      var_dump("1:".date('Y-m-d', $thismonth['date']));

      return;
      $i = 0;
      $nextmonth = $this->lastDate( $start);
      $i = ($nextmonth['date'] > $start) ? 1 : 0;
      while($i < 10){
        $thismonth = $nextmonth;
        $nextmonth = $this->lastDate( mktime(0,0,0, date('m', $thismonth['date'] )+1, 1, date('Y', $thismonth['date']) ) );
        if($thismonth['date']<= $this->bassedata['sunap'] && $nextmonth['date']> $this->bassedata['sunap'] ){
          var_dump("1:".date('Y-m-d', $thismonth['date']));
          var_dump("1:".date('Y-m-d', $nextmonth['date']));
          var_dump($i);
          return;
        }
        var_dump("passed:".$i);
        $i++;
      }

      if($start < $thismonth['date']){
       //이번회차 는 0일
       // 다음회차 는 thismonth
      }else {
        //loop
        //다음달 1일의
      }

    }

  }



  function lastDay($strdate){
    return date('t', $strdate);
  }
  function lastDate($strdate){
    if($this->bassedata['day'] == "last") $date = date('Y-m-t', $strdate);
    else {
      $t = $this->lastDay($strdate);
      if( (int)$this->bassedata['day'] > $t ) $date = date('Y-m-t', $strdate);
      else $date = date('Y-m', $strdate).'-'.sprintf('%2d',$this->bassedata['day']);
    }
    $date = strtotime($date);
    if( $date > $this->bassedata['expire'] ) return array('expired'=>true,'date'=>$this->bassedata['expire'] );
    return array('expired'=>true,'date'=>$date);
  }
}
*/




/*
class Test extends CI_Controller {
  function index(){
    $this->load->library('sunap');
    $this->sunap->base(316);
  }
}
===================== suanp ========================
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
class  Sunap extends Adm {
  var $msg;
  function sunapview() {
    date_default_timezone_set('Asia/Seoul');
    $this->sunapil = $this->today = strtotime(date('Y-m-d',strtotime('now')));
    if ($this->input->get('loanid') =='') { echo "LOAN ID 오류";return; }

    $loaninfo = $this->loaninfo($this->input->get('loanid'));
    if(!$loaninfo) { echo "대출 자료를 찾을 수 없습니다.";return; }

    $history = $this->sunaphistory($this->input->get('loanid'));
    if( $history === false){
      $info2['lastdate'] ='';
      $lastdate = $loaninfo['i_loanexecutiondate2'];
      $o_count = 1;
    }else {
      $info2['lastdate'] =$history[(count($history)-1)]['수납일'];
      $lastdate = $history[(count($history)-1)]['원이자일'];
      $o_count = $history[(count($history)-1)]['회차'];
    }

  //  if($loaninfo['nextdate']!=''){
  //    $info2['nextdate'] = $loaninfo['nextdate'];
  //  }else {
      $nextmonth = $this->nextdate($lastdate, $loaninfo['i_reimbursement_date2'],  $loaninfo['payment_day']);
      $info2['nextdate'] = date('Y-m-d',$nextmonth['sunapil']);
  //  }
    $info2['diffdays'] = $this->getDiffDatebydate($lastdate, date('Y-m-d',$nextmonth['next']) );


    $getdata['sunapil'] = $this->input->get('sunapil') ?  $this->input->get('sunapil') : $info2['nextdate'];
    $nextmonth2 = $this->nextdate($nextmonth['next'], $loaninfo['i_reimbursement_date2'],  $loaninfo['payment_day']);
    $getdata['nextdate'] = date('Y-m-d',$nextmonth2['sunapil']);
    $getdata['diffdays'] = $this->getDiffDate($nextmonth['next'], $nextmonth2['next']);

    $this->load->view('adm_sunap1', array('loaninfo'=>$loaninfo,'info2'=>$info2, 'history'=>$history, 'getdata'=>$getdata));
  }
  function sunnapcalview($loanid='') {
    $loanid = ($loanid != '' ) ? $loanid : $this->$this->input->get('loanid');
  }

  function loaninfo($loanid){
    $sql = "
    select
      a.*
      ,if( c.remaining_amount > 0 , c.remaining_amount, a.i_loan_pay) as remaining_amount
      , if(c.payment_day is null , 'last' , c.payment_day ) as payment_day
      , c.nextdate
      , if( a.i_loanexecutiondate = '0000-00-00 00:00:00', '' ,  date_format( a.i_loanexecutiondate,'%Y-%m-%d' )) as i_loanexecutiondate2
      , b.fk_mari_loan_id
      , if( b.i_reimbursement_date = '0000-00-00', NULL , date_format(b.i_reimbursement_date,'%Y-%m-%d' ) ) as i_reimbursement_date2
      , if( b.default_profit = '' , NULL , default_profit ) as default_profit
    from mari_loan a
    left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
    left join z_invest_base c on a.i_id = c.loan_id
    where a.i_id = ?
    ";
    $tmp = $this->db->query($sql , array($loanid) )->row_array();
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
  $rows = $this->db->query($sql, array($loanid,$loanid)) ->result_array();
  if(count($rows)< 1) {$this->msg='기존 수납 내역이 없습니다.';return false;}
  else return $rows;
  }



  // 다음회차계산
  function nextdate($startdate, $expiredate, $day='last'){

    if( $this->testDate($startdate) ) { $startdate = strtotime($startdate);}
    if( $this->testDate($expiredate) ) { $expiredate = strtotime($expiredate);}

    $t = $this->lastDay($startdate);
    if($day == 'last'){
      if(date('d', $startdate)< $t ) {$nextmonth = $this->lastDate($startdate);}
      else $nextmonth = $this->nextmonth($startdate, $day);
    } else {
      // TODO 기본일 지정도 해야함
      $lastdate = $this->lastDate($startdate);
      $temp = mktime(0,0,0, date('m', $startdate), ($day > $t ) ? $t : $day, date('Y', $date) );
      if( $this->today < $temp) $nextmonth =  $temp;
      else $nextmonth = $this->nextmonth($startdate, $day);
    }

    if( $startdate >= $expiredate || $nextmonth >= $expiredate) {
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
   function getDiffDatebydate($start, $end){
     return date_diff( date_create($start), date_create($end)  )->days;
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
     if($day =='last' || (int)$day > (int)$t ){
        $nextmonth = mktime(0,0,0, date('m', $next), $t, date('Y', $next) );
      }
     else $nextmonth = mktime(0,0,0, date('m', $next), $day, date('Y', $next) );
     return $nextmonth;
   }
}
   */
