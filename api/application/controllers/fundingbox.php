<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Fundingbox extends CI_Controller {
  function index(){
    $sql = "
    select
    a.i_id as product_uid, a.i_subject as product_name
    ,date_format(b.i_invest_sday,'%Y-%m-%d') as open_date,date_format(b.i_invest_eday,'%Y-%m-%d') as close_date
    ,cast(a.i_year_plus AS DECIMAL(10,1)) as rate_of_return
    , a.i_loan_pay as amount , ifnull(tmp.total,0) as invest_amount
    , a.i_loan_day as investment_period
    , concat('https://fundingangel.co.kr:6003/pnpinvest/?mode=invest_view&loan_id=', a.i_id) as link_url
    ,
    case
    	when ( a.i_repay ='원리금균등상환' ) then 2
    	when ( a.i_repay ='원균등상환' ) then 3
    	else 1
    	end
    	as repayment_period_code
    ,
    case
    	when ( b.i_look = '') then 1 #준비중
    	when ( b.i_look = 'N') then 1 #준비중
    	when ( b.i_look = 'Y') then 2 #투자모집중
    	else 3 end  as state_code #투자마감
    , concat('https://fundingangel.co.kr:6003/pnpinvest/data/photoreviewers/' , a.i_id, '/', b.i_creditratingviews) as product_image
    , case
    	when(a.i_payment ='cate04' ) then 1#부동산
    	when(a.i_payment ='cate06' ) then 2#동산
    	when(a.i_payment ='cate05' ) then 3#개인신용
    	when(a.i_payment ='cate03' ) then 4#사업자신용
    	when(a.i_payment ='cate02' ) then 7#부동산PF
    	else 6 end as product_category_code

    from mari_loan a
    join mari_invest_progress b on a.i_id = b.loan_id
    left join ( select iv.loan_id, sum(iv.i_pay) as total from mari_invest iv group by loan_id ) tmp on a.i_id = tmp.loan_id
    where a.i_view ='Y' and a.i_look !='F'
    order by a.i_id asc
    ";
    $rows = $this->db->query($sql)->result_array();
    header('Content-Type: application/json');
    echo json_encode(array("products"=>$rows));
  }
}
