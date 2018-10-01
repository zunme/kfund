<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Sunap extends Adm {
  var $msg;
  var $today;

  public function _remap($method) {
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->db = $this->load->database('real',true);
    $this->{$method}();
  }

  function index() {
    $info2 = array();
    if($this->input->get('reg') =='reg') $isCalView = false;
    else $isCalView = true;

    if($this->input->get('sdate')!='') $sunapil = strtotime($this->input->get('sdate'));
    else $sunapil = $this->today;
    if($this->input->get('loanid')) $loanid = $this->input->get('loanid');
    else { echo "LOAN ID ERROR";   return;}
    $loaninfo = $this->loaninfo($loanid);
    $inset = $this->db->query('select i_profit,i_overint as i_overint from mari_inset')->row_array();

    if($this->input->get('default_profit')!='') $loaninfo['default_profit'] = (float)$this->input->get('default_profit');
    else if( $loaninfo['default_profit'] =='' ) $loaninfo['default_profit'] = $inset['i_profit'];

    if($this->input->get('i_year_over')!='') $loaninfo['i_year_over'] = (float)$this->input->get('i_year_over');
    else $loaninfo['i_year_over'] = $inset['i_overint']*100;

    if($this->input->get('i_year_plus')!='') $loaninfo['i_year_plus'] = (float)$this->input->get('i_year_plus');

    //$history = $this->history_before($loanid);
    $history = $this->sunaphistory($loanid);

    if( $history === false){
      $info2['lastdate'] ='';
      $lastdate = $loaninfo['i_loanexecutiondate2'];
      $o_count = 1;
    }else {
      $info2['lastdate'] =$history[(count($history)-1)]['수납일'];
      //$lastdate = $history[(count($history)-1)]['원이자일'];
      $lastdate = $history[(count($history)-1)]['next_from'];
      if($lastdate =='') $lastdate = $history[(count($history)-1)]['수납일'];
      $o_count = $history[(count($history)-1)]['회차']+1;
    }
    $info2['o_count']= $o_count;

if ( $sunapil < strtotime($lastdate)){
  $sunapil = strtotime($lastdate);
}
    $next=$this->nextdate($lastdate, $loaninfo['i_reimbursement_date2'],$loaninfo['payment_day']);
    $cal = $this->cal($lastdate, $loaninfo['i_reimbursement_date2'],$sunapil,$loaninfo['remaining_amount'], $loaninfo['i_year_plus'], $loaninfo['i_year_over'] ,$loaninfo['payment_day']);
    switch($this->input->get('type_row')){
      case ('만기상환') :
        $cal['storage_amount'] = (int)$cal['ija']['total']+$loaninfo['remaining_amount'] ;
        $cal['Reimbursement'] = $loaninfo['remaining_amount'];
        $cal['readonly'] = true;
      break;
      case ('일부상환') :
        $storage_amount = (int)$this->input->get('storage_amount_ija') + (int)$this->input->get('storage_amount_wongum');
        //$cal['storage_amount'] = (int)$this->input->get('storage_amount') > 0 ? (int)$this->input->get('storage_amount') : 0;
        $cal['storage_amount'] = (int) $storage_amount > 0 ? $storage_amount : 0;
        $cal['Reimbursement'] = $cal['storage_amount'] - (int)$cal['ija']['total'];
        $cal['readonly'] = false;
      break;
      default:
        $cal['storage_amount'] = (int)$cal['ija']['total'];
        $cal['Reimbursement'] = 0;
        $cal['readonly'] = true;
    }
    $cal['after_remain'] = $loaninfo['remaining_amount'] - $cal['Reimbursement'];
    //var_dump($cal);

    $sunap_id = $this->log($loaninfo,$history, $info2,$cal,($isCalView) ? 'tmp':'' );
    if($sunap_id===false){
      if ($isCalView==false) {
        echo json_encode (array('code'=>500, 'msg'=>'DB 오류가 발생하였습니다.'));
      }else {
        echo "DB 오류가 발생하였습니다.<br> 다시 계산하여 주세요";
      }
      return;
    }
    $detail = $this->log2($sunap_id, ($isCalView) ? 'tmp':'');

    if($sunap_id===false){
      if ($isCalView==false) {
        echo json_encode (array('code'=>500, 'msg'=>'DB 오류가 발생하였습니다.'));
        $sql = "delete from z_invest_sunap where idx = ?";
        $this->db->query($sql, $sunap_id);
      }else {
        echo "DB 오류가 발생하였습니다.<br> 다시 계산하여 주세요";
      }
      return;
    }
    if ($isCalView==false) {
      $this->calc_remain();
      if( $this->input->get('type_row') == '만기상환'){
        $sql1 = "update mari_loan set i_look = 'F' where i_id = ? ";
        $this->db->query($sql1,$loaninfo['i_id'] );
        $sql2 = "update mari_invest_progress set i_look = 'F' where loan_id = ? ";
        $this->db->query($sql2,$loaninfo['i_id']);
      }
      echo json_encode (array('code'=>200, 'msg'=>'정상등록되었습니다.'));
      return;
    }
    $viewtotal['wongum'] = $viewtotal['total_interest'] = $viewtotal['total_emoney'] = 0;

    foreach ($detail as $row){
      $viewtotal['wongum'] += $row['wongum'];
      $viewtotal['total_interest'] += $row['total_interest'];
      $viewtotal['total_emoney'] += $row['emoney'];
    }


    $this->load->view('adm_sunap1', array('loaninfo'=>$loaninfo,'info2'=>$info2, 'history'=>$history, 'cal'=>$cal) );
     if ($loaninfo['i_look']!='D') return;
    $this->load->view('adm_sunap2', array('detail'=>$detail,'viewtotal'=>$viewtotal) );
  }
  function log($loaninfo,$history,$info2,$cal,$tmp){
    //var_dump($loaninfo,$info2,$cal);
    $data = array(
      'loan_id'=>$loaninfo['i_id'],
      'o_count'=>$info2['o_count'],
      'type_row'=>$this->input->get('type_row')=='' ? '이자상환': $this->input->get('type_row'),
      'status_row'=>'Y',
      'remain_amount'=>$loaninfo['remaining_amount'],
      'remain_after'=>$cal['after_remain'],
      'calc_date'=>date('Y-m-d',$cal['next']['next']),
      'inv_date'=>date('Y-m-d',$cal['next']['holiday']),
      'acceptance_date'=>date('Y-m-d', $cal['get']['sunapil']),
      'storage_amount'=>$cal['storage_amount'],
      'repayment'=>0,
      'Reimbursement'=>$cal['Reimbursement'],
      'Reimbursement_rate'=>0,
      'Reimbursement_susuryo'=>0,
      'rate'=>$loaninfo['i_year_plus'],
      'days'=>$cal['ijail']['days'],
      'interest'=>$cal['ija']['정상이자'],
      'Delinquency_rate'=>$loaninfo['i_year_over'],
      'Delinquency_under_days'=>$cal['ijail']['inner'],
      'Delinquency_under'=>$cal['ija']['유예기간내'],
      'Delinquency_over_days'=>$cal['ijail']['over'],
      'Delinquency_over'=>$cal['ija']['유예기간외'],
      'default_susuryo'=>$loaninfo['default_profit'],
      'total_interest'=>(int)($cal['ija']['정상이자']+$cal['ija']['유예기간내']+$cal['ija']['유예기간외']),
      'adjustment_amount'=>0,
      'gasugum'=>0,
      'misugum'=>0,
      'next_date'=>date('Y-m-d',$cal['nextmonth']['holiday'])
    );

    $basesql = "
    insert into z_invest_base ( loan_id, loan, remaining_amount, nextdate) values ( ?, ? ,?, ? ) on duplicate key update remaining_amount = ?, nextdate= ?;
    ";
    if($tmp =='tmp') $this->db->query('truncate table z_invest_sunap_tmp');
    if($this->db->insert('z_invest_sunap'.($tmp=='tmp'?'_tmp':''), $data) ){
      $iid = $this->db->insert_id();
      if($tmp !='tmp') {
        $this->db->query($basesql,  array($loaninfo['i_id'],$loaninfo['realpay'],$cal['after_remain'],date('Y-m-d',$cal['nextmonth']['holiday']),  $cal['after_remain'],date('Y-m-d',$cal['nextmonth']['holiday']) ) );
      }
      return $iid;
    }else return false;
  }
  function log2($sunap_id, $tmp){
    $tablename = ($tmp =='tmp') ? '_tmp': '';
    $sql = "
    select sum(b.i_pay) into @sumpay
    from z_invest_sunap".$tablename." a
    join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
    where a.idx = ?;
    ";
    $this->db->query($sql , array($sunap_id) );

    $presql="";
    if($tmp !='tmp') {
      $presql="
        insert into z_invest_sunap_detail
        ( i_id, loan_id, history_idx, paystatus, o_count, sale_id, rate, Delinquency_rate
, remain_amount, Reimbursement, total_invest, i_pay , i_pay_remain, wongum
, days, interest, Delinquency_under_days,under,Delinquency_over_days,over
,withholding,withholdingPayed,  susuryo, susuryoPayed, total_interest, emoney)
      ";
    }
    $sql =$presql. "
    (
        select  i_id, loan_id, history_idx , paystatus
         ,o_count, sale_id
         , rate, Delinquency_rate, remain_amount, Reimbursement
         , total_invest , i_pay, i_pay_remain
         , if ( wongum > i_pay_remain, i_pay_remain , wongum) as wongum
         , days
         , interest
         , Delinquency_under_days
         , under
         , Delinquency_over_days
         , over
         ,withholding
         #180605 원천징수 계산방식 따로 계산하는 것으로 수정
         #, floor (withholding * ( round(interest + under+over) ) /10) * 10 as withholdingPayed
         , (floor (withholding1 * ( round(interest + under+over) ) /10) * 10 ) + (floor (withholding2 * ( round(interest + under+over) ) /10) * 10 ) as withholdingPayed
         ,susuryo
         , floor(i_pay_remain * susuryo*12/365*days) susuryoPayed
         , round(interest + under+over) as total_interest
         , if ( wongum > i_pay_remain, i_pay_remain , wongum)
          + round(interest + under+over)
          #180605 원천징수 계산방식 따로 계산하는 것으로 수정
         	- (floor (withholding1 * ( round(interest + under+over) ) /10) * 10 ) - (floor (withholding2 * ( round(interest + under+over) ) /10) * 10 )
          - floor(i_pay_remain * susuryo*12/365*days)
           as  emoney
       from
       (select
       	b.i_id , a.loan_id , a.idx as history_idx, 'R' as paystatus
       	,a.o_count , b.m_id as sale_id
       	,a.rate
       	,a.Delinquency_rate
       	,a.remain_amount
       	,a.Reimbursement
       	,@sumpay as total_invest
       	,b.i_pay
       	,if( irem.remaining_amount >= 0 , irem.remaining_amount, b.i_pay) as i_pay_remain
       	,case
       		when( (a.type_row = '만기상환' or a.type_row='상환완료') ) then
       			if( irem.remaining_amount >= 0 , irem.remaining_amount, b.i_pay)
       		when( a.Reimbursement > 0 ) then
       			floor(a.Reimbursement * b.i_pay / @sumpay)
       		else
       			0
       		end as wongum
       	, a.days as days
       	, round(if( irem.remaining_amount >= 0 , irem.remaining_amount, b.i_pay) * rate * days /100.0 /365) as interest
       	, a.Delinquency_under_days
        #180605 기간내이자는 연체제외한 정상이자일수로 계산
       	, round( ( if( irem.remaining_amount >= 0 , irem.remaining_amount, b.i_pay) * rate * (days - Delinquency_under_days-Delinquency_over_days) /100.0 /365 ) * Delinquency_rate * Delinquency_under_days /100.0 /365 ) as under
       	, a.Delinquency_over_days
       	, round( if( irem.remaining_amount >= 0 , irem.remaining_amount, b.i_pay) * (Delinquency_rate-rate)* Delinquency_over_days /100.0 /365 ) as over
       	, b.i_subject
       	,case
       		when ( m_level > 2 ) then inset.i_withholding_burr + inset.i_withholding_burr_v
       		when ( m_signpurpose ='I') then inset.i_withholding_in + inset.i_withholding_in_v
       		when ( m_signpurpose ='P') then inset.i_withholding_pro + inset.i_withholding_pro_v
       		when ( m_signpurpose ='L2') then inset.i_withholding_personalloan + inset.i_withholding_personalloan_v
       		when ( m_signpurpose ='C2') then inset.i_withholding_corporateloan + inset.i_withholding_corporateloan_v
       		when ( m_signpurpose ='I2') then inset.i_withholding_incomeloan + inset.i_withholding_incomeloan_v
       		else inset.i_withholding_personal + inset.i_withholding_personal_v
       		end as withholding
        ,case
       		when ( m_level > 2 ) then inset.i_withholding_burr
       		when ( m_signpurpose ='I') then inset.i_withholding_in
       		when ( m_signpurpose ='P') then inset.i_withholding_pro
       		when ( m_signpurpose ='L2') then inset.i_withholding_personalloan
       		when ( m_signpurpose ='C2') then inset.i_withholding_corporateloan
       		when ( m_signpurpose ='I2') then inset.i_withholding_incomeloan
       		else inset.i_withholding_personal
       		end as withholding1
        ,case
          when ( m_level > 2 ) then inset.i_withholding_burr_v
          when ( m_signpurpose ='I') then inset.i_withholding_in_v
          when ( m_signpurpose ='P') then inset.i_withholding_pro_v
          when ( m_signpurpose ='L2') then inset.i_withholding_personalloan_v
          when ( m_signpurpose ='C2') then inset.i_withholding_corporateloan_v
          when ( m_signpurpose ='I2') then inset.i_withholding_incomeloan_v
          else inset.i_withholding_personal_v
          end as withholding2
       	, if ( a.default_susuryo <>'' , a.default_susuryo ,
       		case
       			when ( m_level > 2 ) then inset.i_profit_v
       			when ( m_signpurpose ='I') then inset.i_profit_in
       			when ( m_signpurpose ='P') then inset.i_profit_pro
       			when ( m_signpurpose ='L2') then inset.i_profit_personalloan
       			when ( m_signpurpose ='C2') then inset.i_profit_corporateloan
       			when ( m_signpurpose ='I2') then inset.i_profit_incomeloan
       			else inset.i_profit
       		end
       	) as susuryo
       	from z_invest_sunap".($tmp =='tmp' ? '_tmp':'')." a
       	join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
       	join mari_member m on b.m_id = m.m_id
       	join mari_inset inset
       	left join z_mari_invest_remaining irem on b.i_id = irem.invest_i_id
         where a.idx = ?
       ) tmp
       )
    ";
    if($tmp =='tmp') return $this->db->query($sql, array($sunap_id))->result_array();
    else {
      $this->db->query($sql, array($sunap_id));
      return $this->db->query('select * from z_invest_sunap_detail where history_idx = ?', array($sunap_id) )->result_array();
    }

  }
  function calc_remain(){
    $sql = "
    insert into z_mari_invest_remaining (invest_i_id, remaining_amount)
        (
        select * from
        (select t.i_id as invest_i_id, (t.i_pay -  sum(t.wongum)) as remaining_amount from z_invest_sunap_detail t
        group by i_id) tmp
        )
    on duplicate key update `remaining_amount` = tmp.remaining_amount
        ";
        $this->db->query($sql);
  }
  function cal($start, $expire,$sunapil,$remain, $rate, $reimbursement_rate, $day='last'){
    //return;
    /*
    $start = '2018-2-28';
    $expire = '2018-05-25';
    $sunapil = strtotime('2018-05-30');
    $day = 'last';
    */

    //응당일
    $get = array('start'=>$start, 'expire'=>$expire,'sunapil'=>$sunapil, 'day'=>$day);
    $next = $this->nextdate($start, $expire,$day);
    //다음회차 응당일
    if( $next['next'] > $sunapil ) $nextmonth = $this->nextdate(date('Y-m-d',$sunapil) , $expire ,$day) ;
    else $nextmonth = $this->nextdate(date('Y-m-d',$next['next']) , $expire ,$day) ;
    //이자일수
    $ijail = $this->ijail ($start,$next,$nextmonth, $expire,$sunapil,$day);

    //180605 이자일수 따로 받을수 있도록 수정
    if($this->input->get('wdays') > 0 ) $ijail['days'] = (int)$this->input->get('wdays');
    if($this->input->get('winner') > 0 ) $ijail['inner'] = (int)$this->input->get('winner');
    if($this->input->get('wover') > 0 ) $ijail['over'] = (int)$this->input->get('wover');

    //이자계산
    $ija = $this->ija($ijail, $remain,$rate,$reimbursement_rate);
    return array('get'=>$get,'next'=>$next,'nextmonth'=>$nextmonth,'ijail'=>$ijail,'ija'=>$ija);
    //$this->load->view('adm_sunap2');
  }


  function loaninfo($loanid){
    $sql = "
    select
      ifnull( if( c.remaining_amount is null , tb.realpay, c.remaining_amount ), 0) as remaining_amount
      , if(c.payment_day is null , 'last' , c.payment_day ) as payment_day
      , c.nextdate
      , if( a.i_loanexecutiondate = '0000-00-00 00:00:00', '' ,  date_format( a.i_loanexecutiondate,'%Y-%m-%d' )) as i_loanexecutiondate2
      , b.fk_mari_loan_id
      , if( b.i_reimbursement_date = '0000-00-00', NULL , date_format(b.i_reimbursement_date,'%Y-%m-%d' ) ) as i_reimbursement_date2
      , if( b.default_profit < 0  , NULL , default_profit ) as default_profit
      , realpay,     a.*
    from mari_loan a
    #join 에서 변경
    left join (
      select ta.loan_id, sum(i_pay) as realpay from mari_invest ta
      where  ta.loan_id = ? and ta.i_pay_ment ='Y'
      group by ta.loan_id
      ) tb on a.i_id = tb.loan_id
    left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
    left join z_invest_base c on a.i_id = c.loan_id
    where a.i_id = ?
    ";
    $tmp = $this->db->query($sql , array($loanid, $loanid) )->row_array();
    if(!isset($tmp['i_id'])) {$this->msg='대출자료를 찾을 수 없습니다.';return false;}
    else return $tmp;
  }
  function history_before($loanid) {
    $sql = "
    select
           0 as idx, loan_id , o.o_count as 회차
           ,if( o.o_investamount > o.o_ln_money_to , '상환완료','이자지급') as 상환구분
           ,'Y' as status_row
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
           , NULL as 연체이율, 0 as 기간내,0 as 기간내이자,  0 as 기간이후, 0 as 기간이후이자, 0 as  연체이자
           , '-' 플랫폼수수료
			  , if (o.o_mh_money > l1.i_loan_pay, o.o_mh_money - l1.i_loan_pay , o.o_mh_money ) 총지금이자
           , 0 as 조정금액, 0 as 가수금, 0 as 미수금
				, o.o_collectiondate as regdate
       from mari_order o
       join mari_loan l1 on o.loan_id = l1.i_id
       join z_repay_schedule sc on o.loan_id = sc.loanid and o.o_count = sc.cnt
       where
         o.loan_id = ? and
         o.sale_id != '' and i_loan_type ='real'
         group by o.loan_id, o.o_count
    ";
    $rows = $this->db->query($sql, array($loanid,$loanid)) ->result_array();
    if(count($rows)< 1) {$this->msg='기존 수납 내역이 없습니다.';return false;}
    else return $rows;
  }
  function sunaphistory($loanid){
    $sql = "
    (    select
               0 as idx, loan_id , o.o_count as 회차
               ,if( o.o_investamount > o.o_ln_money_to , '상환완료','이자지급') as 상환구분
               ,'Y' as status_row
               , ifnull(sc.repaydate,date_format(o.o_collectiondate,'%Y-%m-%d'))  as `원이자일`
               , date_format(o.o_collectiondate,'%Y-%m-%d') as `이자일`
               , date_format(o.o_collectiondate,'%Y-%m-%d') as `수납일`
               , sc.repaydate as `next_from`
               ,  o.o_mh_money as 수납금액
               , if( o.o_investamount > o.o_ln_money_to, l1.i_loan_pay , 0 ) as 상환금
               , 0 as 중도상환금
               , 0 as 중도상환수수료율, 0 as 중도상환수수료
               , o_ln_iyul as 이율
             	, sc.days as 이자일수

               , if (o.o_mh_money > l1.i_loan_pay, o.o_mh_money - l1.i_loan_pay , o.o_mh_money ) 정상이자
               , NULL as 연체이율, 0 as 기간내,0 as 기간내이자,  0 as 기간이후, 0 as 기간이후이자, 0 as  연체이자
               , '-' 플랫폼수수료
    			  , if (o.o_mh_money > l1.i_loan_pay, o.o_mh_money - l1.i_loan_pay , o.o_mh_money ) 총지금이자
               , 0 as 조정금액, 0 as 가수금, 0 as 미수금
    				, o.o_collectiondate as regdate
           from mari_order o
           join mari_loan l1 on o.loan_id = l1.i_id
           left join z_repay_schedule sc on o.loan_id = sc.loanid and o.o_count = sc.cnt
           where
             o.loan_id = ? and
             o.sale_id != '' and o.i_loan_type ='real'
             group by o.loan_id, o.o_count)
    union (
             select
             s1.idx, s1.loan_id, s1.o_count as 회차, s1.type_row as 상환구분,s1.status_row
             ,s1.calc_date as 원이자일
             ,s1.inv_date as 이자일
             ,s1.acceptance_date as 수납일
             , if( s1.inv_date < s1.acceptance_date , s1.acceptance_date, s1.calc_date)   as `next_from`
             ,s1.storage_amount as 수납금액
             ,s1.repayment  as 상환금
             ,s1.Reimbursement as 중도상환금, s1.Reimbursement_rate as 중도상환수수료율 , s1.Reimbursement_susuryo as 중도상환수수료
             , s1.rate as 이율 , s1.days as 이자일수, s1.interest as 정상이자
             ,s1.Delinquency_rate as 연체이율, s1.Delinquency_under_days as 기간내 , s1.Delinquency_under as 기간내이자
    			, s1.Delinquency_over_days as 기간이후, s1.Delinquency_over as 기간이후이자 , (s1.Delinquency_under + s1.Delinquency_over) as  연체이자
    			, s1.default_susuryo as  플랫폼수수료
    			,(s1.interest+s1.Delinquency_under + s1.Delinquency_over) as 총지급이자
    			, s1.adjustment_amount as 조정금액, s1.gasugum as 가수금, s1.misugum as 미수금
    			, s1.regdate


             from z_invest_sunap s1
             where s1.loan_id = ?
     )
     order by regdate
    ";
    $rows = $this->db->query($sql, array($loanid,$loanid)) ->result_array();
    //echo $this->db->last_query();
    if(count($rows)< 1) {$this->msg='기존 수납 내역이 없습니다.';return false;}
    else return $rows;
  }

  function makebase(){
    $sql = "select a.i_id, a.i_subject,suba.totalinvest,  date_format(a.i_loanexecutiondate,'%Y-%m-%d') as i_loanexecutiondate ,b.i_reimbursement_date from
        mari_loan a
        join (
        select c.loan_id, sum(i_pay) totalinvest  from mari_invest c
        where c.i_pay_ment='Y'
        group by c.loan_id
        ) suba on a.i_id = suba.loan_id
        left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
        left join z_invest_base ib on a.i_id = ib.loan_id
        where a.i_repay ='일만기일시상환' and b.i_reimbursement_date is not null and ib.loan_id is null
      ";
      $rows = $this->db->query($sql)->result_array();
      foreach ($rows as &$row) {
        $history = $this->sunaphistory($row['i_id']);
        $expire = $row['i_reimbursement_date'];
        if( $history === false){
          $lastdate = $row['i_loanexecutiondate'];
        }else {
          $lastdate = $history[(count($history)-1)]['next_from'];
        }
        $next=$this->nextdate($lastdate, $expire,'last');
        var_dump($row['i_id']."::".$lastdate.':'. $expire);
        var_dump(date('Y-m-d',$next['holiday']) );
        //var_dump($next)
        $data = array('loan_id'=>$row['i_id'], 'loan'=>$row['totalinvest'], 'remaining_amount'=>$row['totalinvest'], 'payment_day'=>'last','nextdate'=> date('Y-m-d',$next['holiday']));
        $this->db->insert('z_invest_base', $data);
      }
  }

  function ija($ijail, $remain, $rate, $reimbursement_rate, $선납일=0){
    // TODO 정기상환금있을경우
    $data['정상이자'] = round($remain * $rate * $ijail['days']/100 /365);
    //180605 기간내이자는 연체제외한 정상이자일수로 계산 수정
    $data['유예기간내']  = round(($remain * $rate * ( $ijail['days'] -$ijail['inner'] - $ijail['over'] ) /100.0 /365) * $reimbursement_rate * ($ijail['inner']-$선납일) /100.0 /365);
    $data['유예기간외'] = round($remain * ( $reimbursement_rate - $rate) * $ijail['over'] /100.0 / 365);
    $data['total'] = round($data['정상이자']+ $data['유예기간내'] + $data['유예기간외']);
    return $data;
  }
  function ijail( $start,$next,$nextmonth ,$expire, $sunapil=0,$day= 'last',$predays=0  ) {
    if ($sunapil==0) $sunapil = $this->sunapil;
    $overdate  = '';
    $inner = 0;
    $over = 0;

    //응당일
    if($sunapil <= $next['holiday']) {
      //$calcdate = $next['next'];
      //$calcdate = $next['next'];
      //수납일 기준으로 변경
      $calcdate = ( $sunapil < $next['next']) ? $sunapil : $next['next'] ;
      //var_dump( date('Y-m-d',$calcdate) );
    }
    //else $calcdate = $sunapil;
    //응당일이 만기이고 연체
    /*todo 이전납기일후 응당일 이전까지 연체일경우와 응당일 이후만 연체일 경우( inner =>0) */
    else if ( $next['expired'] ===true && $next['holiday'] < $sunapil ){
        $calcdate = $sunapil;
        if($next['next'] > strtotime($start) ){
        $inner = $this->getDiffDate(strtotime($start),$next['next']);
        }else{
        $inner = 0;
        }
        $inner = 0;
        $overdate = ($next['next'] > strtotime($start) ) ? $next['next']: strtotime($start) ; ;
        $over = $this->getDiffDate($overdate, $sunapil);
    //응당일이 만기일자가 아니고 연체
    }else {
      $calcdate = $sunapil;
      $overdate = $nextmonth['next'];
      if( $overdate <= $sunapil){
        $inner = $this->getDiffDate($next['next'], $overdate);
        $over = $this->getDiffDate($overdate, $sunapil);
      }else {
        $inner = $this->getDiffDate($next['next'], $sunapil);
        $over = 0;
      }
    }
    if($next['next'] > $calcdate )$days = date_diff( date_create($start), date_create(date('Y-m-d',$calcdate) ) )->days;
    else $days = date_diff( date_create($start), date_create(date('Y-m-d',$next['next']) ) )->days;

    $days = date_diff( date_create($start), date_create(date('Y-m-d',$calcdate) ) )->days;

    return array('days'=>$days, 'overdate'=>$overdate=='' ? '' : date('Y-m-d',$overdate), 'inner' => $inner, 'over'=>$over);
  }
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
    if( in_array(date('w', $date ), array(0, 6) ) ) {
      $date = $this->getHoliday(mktime(0,0,0, date('m', $date), date('d', $date)+1, date('Y', $date) ) );
    }
    return $date;
  }
  function getDiffDate($start, $end){
    return date_diff( date_create(date('Y-m-d',$start)), date_create(date('Y-m-d',$end) ) )->days;
  }
}
