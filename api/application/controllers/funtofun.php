<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Funtofun extends CI_Controller {
  function index(){
    $sql = "
    select
    a.i_id as id
    , a.i_subject as product
    , a.i_loan_day as period
    , if( firstdt.firstday is null , if (date_format(i_loanexecutiondate,'%Y-%m-%d') > '0000-00-00' and ext.i_reimbursement_date is not null, LAST_DAY(i_loanexecutiondate)  , ''), date_format(firstdt.firstday,'%Y-%m-%d') ) as interestdt
    , a.i_year_plus as rate
    , a.i_loan_pay as amount
    , if( ib.remaining_amount is not null , ib.remaining_amount ,
    	ifnull(
    	  case
    		when (a.i_look = 'N' ) then 0
    		when (a.i_look = 'Y' ) then 0
    		when (a.i_look = 'F' ) then 0
    		else inv.total
    	  end, 0) ) as remain

    , case
    		when ( a.i_repay = '만기일시상환') then 1
    		when ( a.i_repay = '원리금균등상환') then 3
    		else 4
    	end as method
    , if(ext.default_profit is null ,0, round(ext.default_profit,3) ) as commission
    , if( inv.total>0 , floor(inv.total/a.i_loan_pay*100) , 0) as progress
    , case
    		when (a.i_payment = 'cate04') then 1
    		when (a.i_payment = 'cate06') then 2
    		when (a.i_payment = 'cate05') then 3
    		when (a.i_payment = 'cate03') then 4
    		when (a.i_payment = 'cate01') then 6
    		else 6
    	end as `type`
    , case
    	 	when ( left(a.i_locaty,2) ='서울' ) then 11
    		when ( left(a.i_locaty,2) ='경기' ) then 12
    		when ( left(a.i_locaty,2) ='부산' ) then 13
    		when ( left(a.i_locaty,2) ='대구' ) then 14
    		when ( left(a.i_locaty,2) ='인천' ) then 15
    		when ( left(a.i_locaty,2) ='대전' ) then 16
    		when ( left(a.i_locaty,2) ='울산' ) then 17
    		when ( left(a.i_locaty,2) ='광주' ) then 18
    		when ( left(a.i_locaty,2) ='경남' ) then 19
    		when ( left(a.i_locaty,2) ='경북' ) then 20
    		when ( left(a.i_locaty,2) ='전남' ) then 21
    		when ( left(a.i_locaty,2) ='전북' ) then 22
    		when ( left(a.i_locaty,2) ='충남' ) then 23
    		when ( left(a.i_locaty,2) ='충북' ) then 24
    		when ( left(a.i_locaty,2) ='강원' ) then 25
    		when ( left(a.i_locaty,2) ='제주' ) then 26
    		else ''
     end  as local
    , a.i_locaty as address
    , case
    	when (a.i_look = 'N' ) then 0
    	when (a.i_look = 'Y' ) then 0
    	when (a.i_look = 'C' ) then 1
    	when (a.i_look = 'D' ) then 1
    	when (a.i_look = 'F' ) then 1
    	end  as complete
    , if( a.i_id<=449, 1,  if (date_format(i_loanexecutiondate,'%Y-%m-%d') > '0000-00-00' and date_format(i_loanexecutiondate,'%Y-%m-%d') <= CURDATE() and ext.i_reimbursement_date is not null, 1 , 0) )
     as send
    , if (a.i_look = 'F' , 1, 0) as repay
    , concat('https://fundingangel.co.kr:6003/pnpinvest/?mode=invest_view&loan_id=',a.i_id) as url
    , b.i_invest_sday as startdt
    , b.i_invest_eday as enddt
    from mari_loan a
    join mari_invest_progress b on a.i_id = b.loan_id
    left join (
     select i.loan_id, sum(i.i_pay) as total from mari_invest i group by i.loan_id
    ) inv on a.i_id = inv.loan_id
    left join (
    select ord.loan_id,ord.o_collectiondate as firstday from mari_order ord where ord.o_count = 1 group by ord.loan_id
    ) firstdt on a.i_id = firstdt.loan_id
    left join mari_loan_ext ext on a.i_id = ext.fk_mari_loan_id
    left join z_invest_base ib on a.i_id = ib.loan_id
    where a.i_view='Y'
    order by a.i_id desc
    ";
    $rows = $this->db->query($sql)->result_array();
    header('Content-Type: application/json');
    echo json_encode($rows);
  }
}
