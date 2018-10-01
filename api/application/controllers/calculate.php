<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//테스트용
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Calculate extends Adm {
  var $msg;
  var $today;

  public function _remap($method) {
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->{$method}();
  }

  public function index() {

    $info= array();

    if($this->input->get('sdate')!='') $sunapil = strtotime($this->input->get('sdate'));
    else $sunapil = $this->today;
    if($this->input->get('loanid')) $loanid = $this->input->get('loanid');
    else { echo "LOAN ID ERROR";   return;}

    $loaninfo = $this->loaninfo($loanid);
    $inset = $this->db->query('select i_profit,i_overint as i_overint from mari_inset')->row_array();


  }


  //=========================
  //개인별 원금 계산
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

  function loaninfo($loanid){
    $sql = "
    select
      ifnull( if( c.remaining_amount is null , tb.realpay, c.remaining_amount ), 0) as remaining_amount
      #, if(c.payment_day is null , 'last' , c.payment_day ) as payment_day
      , if(a.i_repay_day is null or a.i_repay_day='', 'last' , a.i_repay_day ) as payment_day
      , c.nextdate
      , if( a.i_loanexecutiondate = '0000-00-00 00:00:00', '' ,  date_format( a.i_loanexecutiondate,'%Y-%m-%d' )) as i_loanexecutiondate2
      , b.fk_mari_loan_id
      , if( b.i_reimbursement_date = '0000-00-00', NULL , date_format(b.i_reimbursement_date,'%Y-%m-%d' ) ) as i_reimbursement_date2
      , if( b.default_profit < 0  , 0 , default_profit ) as default_profit
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
  //=========================
}
