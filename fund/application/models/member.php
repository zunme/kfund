<?php
class member extends CI_Model {
  //level list
  var $msg;
  function __construct()
  {
      parent::__construct();
  }
  function levellist(){
    $data = array(
      'level3'=>array("label"=>'법인회원', "limit"=>array("budongsan"=>5000000000, "dongsan"=>5000000000, "per"=>5000000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),//v
      'N'=>array("label"=>'개인투자자', "limit"=>array("budongsan"=>10000000, "dongsan"=>20000000, "per"=>5000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),
      'L'=>array("label"=>'대출회원', "limit"=>array("budongsan"=>0, "dongsan"=>0, "per"=>0), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),
      'I'=>array("label"=>'소득적격투자자', "limit"=>array("budongsan"=>40000000, "dongsan"=>40000000, "per"=>20000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),//in
      'P'=>array("label"=>'전문투자자', "limit"=>array("budongsan"=>5000000000, "dongsan"=>5000000000, "per"=>5000000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),//pro
      'L2'=>array("label"=>'개인대부사업자투자자', "limit"=>array("budongsan"=>10000000, "dongsan"=>20000000, "per"=>5000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),//loan
      'C2'=>array("label"=>'법인대부사업자투자자', "limit"=>array("budongsan"=>5000000000, "dongsan"=>5000000000, "per"=>5000000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025)),//cor
      'I2'=>array("label"=>'소득적격대부업자투자자', "limit"=>array("budongsan"=>40000000, "dongsan"=>40000000, "per"=>20000000), "withholding"=>array('v1'=>0.25,'v2'=>0.025))//incomeloan
    );
    return $data;
  }
  function getLevel($user=''){
    $level = $this->levellist();
    if(!isset($user['info']['m_id']) ) $leveldata = $level['N'];
    else if( $user['info']['m_level']> 2) $leveldata = $level['level3'];
    else if( isset($level[ $user['info']['m_signpurpose'] ])) $leveldata = $level[ $user['info']['m_signpurpose'] ];
    else $leveldata = $level['N'];
    return $leveldata;
  }
  function user($id){
    $sql = "select * from mari_member where m_id =?";
    $user['info'] = $this->db->query($sql, array($id))->row_array();
    if (!isset($user['info']['m_id']) ){
      $this->msg = "회원(".$id.") 정보를 찾을 수 없습니다.";
      return false;
    }
    $user['level']=$this->getLevel($user);
    return $user;
  }
  function nowpreogress($id){
    $sql = "
    select 'yonghan_shin@naver.com' into @user;
    select loantype , sum(i_pay - payed) as tuja
    from (
     select i.i_pay, if(p.i_payment='cate02' or p.i_payment='cate04', '부동산', '동산') as loantype, ifnull(s.payed,0) as payed
     from mari_invest i
     join mari_loan p on i.loan_id = p.i_id and i_look != 'F'
     left join ( select 	loan_id, sum(wongum) as payed from z_invest_sunap_detail sd  where sd.sale_id = @user and paystatus='Y' group by loan_id ) s on i.loan_id = s.loan_id
     where i.m_id = @user and i.loan_id >= 12
     ) tmp group by loantype;
    ";
  }
  function bankqMemInfo ($id){
    $user = $this->user($id);
    if($user===false) return false;
    $sql = "select ?,?, ? into @user ,@dongsan, @budongsan;";
    $this->db->query($sql, array( $id , $user['level']['limit']['dongsan'], $user['level']['limit']['budongsan']) );
    $sql = "
   	select
   		m.m_id
   		, CASE
   				WHEN m_level > 2 THEN '20'
   				WHEN m.m_signpurpose = 'L' THEN '10' #대출회원->일반으로 표시
   				WHEN m.m_signpurpose = 'I' THEN '11' #소득적격
   				WHEN m.m_signpurpose = 'P' THEN '12' #전문
   				WHEN m.m_signpurpose = 'L2' THEN '10' #개인대부=>일반
   				WHEN m.m_signpurpose = 'C2' THEN '20' #법인대부=>법인
   				WHEN m.m_signpurpose = 'I2' THEN '11' #소득적격대부=>소득적격
   				ELSE '10'
   			END as investorType
   		, m.m_emoney balance
   		, if ( @dongsan - budongsan - dongsan < 0 , 0 , @dongsan - budongsan - dongsan) limitRemain
   		#,if ( @budongsan -budongsan - if(dongsan - @budongsan > 0 , dongsan - @budongsan , 0 )  < 0 , 0 , @budongsan -budongsan - if(dongsan - @budongsan > 0 , dongsan - @budongsan , 0 ) ) limitRealEstateRemain
      ,if ( @budongsan -budongsan - dongsan  < 0 , 0 , @budongsan -budongsan - dongsan ) limitRealEstateRemain
      , dongsan personalEstateProgress, budongsan realEstateProgress
   		, '1' result
   		, '' errorMessage
   	from
   	(
   		 select
   		 	@user as m_id, sum( if(p.i_payment='cate02' or p.i_payment='cate04', i_pay - ifnull(s.payed,0) , 0) ) as budongsan
   		  	, sum( if(p.i_payment != 'cate02' and  p.i_payment != 'cate04', i_pay - ifnull(s.payed,0) , 0) ) as dongsan
   		 from mari_invest i
   		 join mari_loan p on i.loan_id = p.i_id and i_look != 'F'
   		 left join ( select 	loan_id, sum(wongum) as payed from z_invest_sunap_detail sd  where sd.sale_id = @user and paystatus='Y' group by loan_id ) s on i.loan_id = s.loan_id
   		 where i.m_id = @user and i.loan_id >= 12
   	 ) lc
   	join mari_member m on lc.m_id = m.m_id
    ";
    return $this->db->query($sql)->row_array();
  }
  function bankqProductList($id){
    $sql = "
    select
     	case
     		WHEN l.i_payment = 'cate05' THEN  '10' #개인신용
     		WHEN l.i_payment = 'cate02' THEN  '91' #건축자금 법인기타
     		WHEN l.i_payment = 'cate06' THEN  '31' #동산담보 법인
     		WHEN l.i_payment = 'cate04' THEN  '21' #부동산  법인
     		WHEN l.i_payment = 'cate03' THEN  '91' #사업자대출 법인기타
     		ELSE '91'
     	END as producttype
    	, l.i_id as refId
    	, l.i_subject as productName
    	#, date_format(i.i_regdatetime,'%Y%m%d') as startDate
    	, if( l.i_look in('D', 'F') , date_format( l.i_loanexecutiondate,'%Y%m%d') , '00000000') as startDate
    	, if( l.i_look in('D', 'F') , date_format( le.i_reimbursement_date,'%Y%m%d') , '00000000') as endDate
    	, l.i_loan_day as investPeriod
    	, i.i_pay as amount
    	, if( i.i_pay  - ifnull(payed , 0) > 0 , i.i_pay  - ifnull(payed , 0) , 0  ) as amountRemain
    	, i_year_plus as investEarnongRate
    	, case
    			WHEN p.i_look = 'Y' THEN 'A1'
    			WHEN p.i_look = 'C' THEN 'A4'
    			WHEN p.i_look = 'D' THEN 'B1'
    			WHEN p.i_look = 'F' THEN 'B2'
    		END as productState
    	, case
    			WHEN i_repay = '일만기일시상환' THEN '만기일시'
    			WHEN i_repay = '일만기일시상환' THEN '원금분할'
    			ELSE '원금분할'
    		END as repaymentType
    from mari_invest i
    join mari_loan l on i.loan_id = l.i_id
    join mari_invest_progress p on i.loan_id = p.loan_id
    left join mari_loan_ext le on i.loan_id = le.fk_mari_loan_id
    left join (
    	select 	loan_id, sum(wongum) as payed from z_invest_sunap_detail sd  where sd.sale_id = ? and paystatus='Y' group by loan_id
    ) remain on i.loan_id = remain.loan_id
    where i.m_id = ?
    ;
    ";
    return $this->db->query($sql, array($id, $id) )->result_array();
  }
  function bankqSehcdule($id, $loanid=0){
    list($table,$prepare,$loanlist) = $this->totaltable($id,$loanid);
    if( count($table) > 0 ){
      $tmp = array();
      foreach($table as $row){
        if(isset ($row['holiday']) ){
          $tmp[$row['holiday']][] = $row;
        }else $tmp[$row['repay_date']][] = $row;
        //$tmp[$row['holiday']][] = $row;
      }
      //arsort($tmp);
      ksort($tmp);
      $ret = array();
      foreach ( $tmp as $rows){
        foreach ($rows as $row) {

          if( $row['status'] =="완료") $state = 'A2';
          else if( date('Y-m-d') > $row['holiday']) $state ='c1';
          else $state = 'A1';
          $tmp = array(
            'refId'=> $row['loan_id']
            , 'repayOrder' => $row['o_count']
            , 'expectedDate'=> (isset($row['holiday'])) ? date_format(date_create($row['holiday']), 'Ymd') : date_format(date_create($row['repay_date']), 'Ymd')
            , 'repayDate'=> (($state =='A2') ?date_format(date_create($row['repay_date']), 'Ymd'):null)
            //, 'principal'=> $row['o_ln_money_to']
            , 'principal'=> $row['wongum']
            , 'interest'=> $row['inv']
            ,'charge'=> $row['susuryo']
            , 'tax'=> $row['o_withholding']
            , 'overdueInterest'=> $row['Delinquency']
            , 'repayState'=> $state
          );
          $ret[] = $tmp;
        }
      }
      return $ret;
    }else return array();
  }
  function totaltable($id, $loanid=0) {
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
    , case
          when ( mem.m_level > 2 ) then inset.i_withholding_burr
          when ( mem.m_signpurpose ='I') then inset.i_withholding_in
          when ( mem.m_signpurpose ='P') then inset.i_withholding_pro
          when ( mem.m_signpurpose ='L2') then inset.i_withholding_personalloan
          when ( mem.m_signpurpose ='C2') then inset.i_withholding_corporateloan
          when ( mem.m_signpurpose ='I2') then inset.i_withholding_incomeloan
          else inset.i_withholding_personal
          end as tax1
    ,  case
          when ( mem.m_level > 2 ) then  inset.i_withholding_burr_v
          when ( mem.m_signpurpose ='I') then inset.i_withholding_in_v
          when ( mem.m_signpurpose ='P') then inset.i_withholding_pro_v
          when ( mem.m_signpurpose ='L2') then inset.i_withholding_personalloan_v
          when ( mem.m_signpurpose ='C2') then inset.i_withholding_corporateloan_v
          when ( mem.m_signpurpose ='I2') then inset.i_withholding_incomeloan_v
          else inset.i_withholding_personal_v
          end as tax2
  from mari_invest inv
  join mari_loan loa on inv.loan_id = loa.i_id
  join mari_member mem on inv.m_id = mem.m_id
  join mari_inset inset
  left join mari_loan_ext ext on inv.loan_id = fk_mari_loan_id

  where inv.m_id = ? and inv.i_pay_ment ='Y' ".( ($loanid > 0) ? " and inv.loan_id = ".(int)$loanid  : "" ) ." order by loan_id
  ";
  $loanlist = $this->db->query($sql, array($id) )->result_array();
  $jungsantb = new jungsantb;
  foreach ($loanlist as $row) {
    if( $row['i_look'] =='F'){
      //상환완료
      $sql = "select
b.i_subject as subject, loan_id, a.o_count,a.o_paytype, date_format(a.o_collectiondate, '%Y-%m-%d') repay_date , '완료' as `status` , a.o_ln_money_to, a.remaining_amount, a.wongum, a.inv, a.Delinquency, (a.inv + a.Delinquency) as invtotal, a.susuryo, a.o_withholding, a.p_emoney
from view_jungsan a
join mari_loan b on a.loan_id = b.i_id
where a.loan_id =? and a.sale_id = ? order by a.o_count";
      $table = $this->db->query( $sql , array($row['loan_id'], $id))->result_array();
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
        $timetable = array_merge($timetable, $jungsantb->history($loaninfo, $row['i_pay'], $id,$row['withholdingp'], $row['default_susuryo'],$row['tax1'],$row['tax2']) ) ;
      }else {
        //만기일시상환
        $sql = "select
b.i_subject as subject, loan_id, a.o_count,a.o_paytype, date_format(a.o_collectiondate, '%Y-%m-%d') repay_date , '완료' as `status`,'N' as `complete` , a.o_ln_money_to, a.remaining_amount, a.wongum, a.inv, a.Delinquency, (a.inv + a.Delinquency) as invtotal, a.susuryo, a.o_withholding, a.p_emoney
from view_jungsan a
join mari_loan b on a.loan_id = b.i_id
where a.loan_id =? and a.sale_id = ? order by a.o_count";
        $table = $this->db->query( $sql , array($row['loan_id'], $id))->result_array();
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
        $tmp = $this->db->query($sql, array($id, $row['loan_id']) )->result_array();
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
}

class jungsantb {
  var $CI;
  function __construct() {
    date_default_timezone_set('Asia/Seoul');
    $this->CI=& get_instance();
  }
  function history(&$loaninfo,$i_pay ,$userid, $withholdingp=0.275,$susuryo=0,$tax1=0.25, $tax2=0.025 ){
    $timetable = $this->timetable($loaninfo);
    $realtime = $this->CI->db->query ('select *, date_format(o_collectiondate,"%Y-%m-%d" ) as repay_date  from view_jungsan where loan_id =? and sale_id = ? order by o_count', array($loaninfo['i_id'], $userid ) )->result_array();

    if( count($realtime)> 0 ) {
        $remain = $realtime[ count($realtime) - 1 ]['remaining_amount'];
    }else $remain = $i_pay;
    //원금균등
    $monthly =($remain > 0 && count($timetable)-count($realtime) > 0 ) ? round( $remain / (count($timetable)-count($realtime)) ) : 0;

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
        $row ['o_withholding'] = floor($row ['invtotal']*$tax1/10)*10 + floor($row ['invtotal']*$tax2/10)*10;
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
