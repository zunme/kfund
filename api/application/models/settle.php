<?php
class settle extends CI_Model {
  function iljungsanTableforCalendar() {
    $sql = "
      select
      if( tmp.o_collectiondate is null ,sc.repaydate,date_format(tmp.o_collectiondate,'%Y-%m-%d') ) as schdate
      ,sum(if( tmp.o_collectiondate is null ,0,1)) as payed
      ,sum(if( tmp.o_collectiondate is null ,1,0)) as unpayed
      from z_repay_schedule sc
      join mari_loan l on sc.loanid = l.i_id
      left join
      	(
          (
      		select a.loan_id, a.o_count, a.o_status, a.o_collectiondate
      			from mari_order a
      			where a.o_status='입금완료'
      			group by loan_id, o_count , o_status
      			order by loan_id, o_count
      		) union (
      		select b.loan_id , b.o_count, '입급완료' as o_status , b.lastUpdateTime as o_collectiondate
      			from z_settlement_history b
      			where b.`status` = 'Y'
      		)
      	) tmp on sc.loanid = tmp.loan_id and sc.cnt = tmp.o_count
      group by 1
    ";
    return $this->db->query($sql)->result_array();
  }
  function iljungsanTableforCalendarDetail($date) {
    $sql = "
    select * from (
      select
      sc.loanid, sc.cnt, if( tmp.o_collectiondate is null ,'N','Y') as payed , if( tmp.o_collectiondate is null ,sc.repaydate,date_format(tmp.o_collectiondate,'%Y-%m-%d') ) as schdate , sc.repaydate, sc.days
 , l.i_subject , l.i_year_plus
      from z_repay_schedule sc
      join mari_loan l on sc.loanid = l.i_id
      left join
      	(
          (
      		select a.loan_id, a.o_count, a.o_status, a.o_collectiondate
      			from mari_order a
      			where a.o_status='입금완료'
      			group by loan_id, o_count , o_status
      			order by loan_id, o_count
      		) union (
      		select b.loan_id , b.o_count, '입급완료' as o_status , b.lastUpdateTime as o_collectiondate
      			from z_settlement_history b
      			where b.`status` = 'Y'
      		)
      	) tmp on sc.loanid = tmp.loan_id and sc.cnt = tmp.o_count
      ) tmp2 where schdate = ? order by loanid
    ";
    return $this->db->query($sql, array($date) )->result_array();
  }
  function ispayed($loanid, $cnt){
    $sql = "
    select ifnull(count(1),0) as payed from (
      select o.loan_id, o.o_count, o.o_collectiondate, NULL as total_interest, NULL as total_delinquency
      from mari_order o where o.loan_id = ? and o.o_count = ?
       union
      select o1.loan_id, o1.o_count, o1.lastUpdateTime as o_collectiondate, o1.total_interest, o1.total_delinquency
      from z_settlement_history o1 where o1.loan_id = ? and o1.`status`='Y' and o1.o_count = ?
      )tmp";
      $tmp = $this->db->query($sql , array($loanid, $cnt,$loanid, $cnt))->row_array();
      return $tmp['payed'];
  }
  function makesettledata($history_idx, $istest = true){
    $sql = "delete from z_settlement where history_idx = ?";
    $this->db->query($sql, array($history_idx));
    $sql = "
      select sum(i_pay) into @sumpay
      from z_settlement_history a
      join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
      where a.idx = ?
    ";
    $this->db->query($sql, array($history_idx));
    $sql = "
    insert into z_settlement
    (i_id, loan_id, history_idx, `status`, o_count, o_ln_iyul,
    Delinquency_rate, sale_id, `date`, o_ln_money_to,before_remaining, remaining_amount, wongum, inv, Delinquency,susuryo,o_withholding,p_emoney , p_content
    )

    select
    i_id,  loan_id, history_idx, `status`, o_count, o_ln_iyul
    ,Delinquency_rate, sale_id, curdate() as `date`, o_ln_money_to, before_remaining,remaining_amount, wongum, inv, Delinquency
    , floor(before_remaining * susuryo) as susuryo
    , floor((inv + Delinquency) * withholding) as o_withholding
    , (wongum + inv + Delinquency - floor(o_ln_money_to * susuryo) - floor((inv + Delinquency) * withholding) ) as p_emoney
    ,p_content
    from
    (select
    	  b.i_id , a.loan_id
    	 , ? as history_idx, 'R' as status
    	 ,a.o_count ,a.rate as o_ln_iyul
    	 ,a.Delinquency_rate, b.m_id as sale_id

    	 ,b.i_pay as o_ln_money_to
    	 , if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) before_remaining
    	 , if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) - if(a.Reimbursement > 0 , (floor(a.Reimbursement * b.i_pay / @sumpay) ) , 0 ) as remaining_amount
    	 , if(a.Reimbursement > 0 , (floor(a.Reimbursement * b.i_pay / @sumpay) ) , 0 ) as wongum
    	 , floor(a.rate * if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) /100 /365 * a.days ) as inv
    	 , if( a.Delinquency_rate * a.Delinquency_days > 0 , a.Delinquency_rate * a.Delinquency_days/100/365 , 0 ) as Delinquency
    	 , b.i_subject as p_content
    	,case
    		when ( m_level > 2 ) then inset.i_withholding_burr + inset.i_withholding_burr_v
    		when ( m_signpurpose ='I') then inset.i_withholding_in + inset.i_withholding_in_v
    		when ( m_signpurpose ='P') then inset.i_withholding_pro + inset.i_withholding_pro_v
    		when ( m_signpurpose ='L2') then inset.i_withholding_personalloan + inset.i_withholding_personalloan_v
    		when ( m_signpurpose ='C2') then inset.i_withholding_corporateloan + inset.i_withholding_corporateloan_v
    		when ( m_signpurpose ='I2') then inset.i_withholding_incomeloan + inset.i_withholding_incomeloan_v
    		else inset.i_withholding_personal + inset.i_withholding_personal_v
    		end as withholding
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
    from
    z_settlement_history a
    join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
    join mari_member m on b.m_id = m.m_id
    join mari_inset inset
    left join z_mari_invest_remaining irem on b.i_id = irem.invest_i_id
    where a.idx = ?
    ) tmp2
    ";
    $this->db->query($sql, array($history_idx,$history_idx));
    /*
    delete from z_settlement where history_idx = 1;

    select sum(i_pay) into @sumpay
          from z_settlement_history a
          join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
          where a.idx =1;

    insert into z_settlement
    (i_id, loan_id, history_idx, `status`, o_count, o_ln_iyul,
    Delinquency_rate, sale_id, `date`, o_ln_money_to,before_remaining, remaining_amount, wongum, inv, Delinquency,susuryo,o_withholding,p_emoney , p_content
    )

    select
    i_id,  loan_id, history_idx, `status`, o_count, o_ln_iyul
    ,Delinquency_rate, sale_id, curdate() as `date`, o_ln_money_to, before_remaining,remaining_amount, wongum, inv, Delinquency
    , floor(before_remaining * susuryo) as susuryo
    , floor((inv + Delinquency) * withholding) as o_withholding
    , (wongum + inv + Delinquency - floor(o_ln_money_to * susuryo) - floor((inv + Delinquency) * withholding) ) as p_emoney
    ,p_content
    from
    (select
    	  b.i_id , a.loan_id
    	 , 1 as history_idx, 'R' as status
    	 ,a.o_count ,a.rate as o_ln_iyul
    	 ,a.Delinquency_rate, b.m_id as sale_id

    	 ,b.i_pay as o_ln_money_to
    	 , if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) before_remaining
    	 , if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) - if(a.Reimbursement > 0 , (floor(a.Reimbursement * b.i_pay / @sumpay) ) , 0 ) as remaining_amount
    	 , if(a.Reimbursement > 0 , (floor(a.Reimbursement * b.i_pay / @sumpay) ) , 0 ) as wongum
    	 , floor(a.rate * if( irem.remaining_amount > 0 , irem.remaining_amount, b.i_pay) /100 /365 * a.days ) as inv
    	 , if( a.Delinquency_rate * a.Delinquency_days > 0 , a.Delinquency_rate * a.Delinquency_days/100/365 , 0 ) as Delinquency
    	 , b.i_subject as p_content
    	,case
    		when ( m_level > 2 ) then inset.i_withholding_burr + inset.i_withholding_burr_v
    		when ( m_signpurpose ='I') then inset.i_withholding_in + inset.i_withholding_in_v
    		when ( m_signpurpose ='P') then inset.i_withholding_pro + inset.i_withholding_pro_v
    		when ( m_signpurpose ='L2') then inset.i_withholding_personalloan + inset.i_withholding_personalloan_v
    		when ( m_signpurpose ='C2') then inset.i_withholding_corporateloan + inset.i_withholding_corporateloan_v
    		when ( m_signpurpose ='I2') then inset.i_withholding_incomeloan + inset.i_withholding_incomeloan_v
    		else inset.i_withholding_personal + inset.i_withholding_personal_v
    		end as withholding
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
    from
    z_settlement_history a
    join mari_invest b on a.loan_id = b.loan_id and b.i_pay_ment ='Y' and b.m_id is not null and b.m_id != b.user_id and i_pay > 0
    join mari_member m on b.m_id = m.m_id
    join mari_inset inset
    left join z_mari_invest_remaining irem on b.i_id = irem.invest_i_id
    where a.idx = 1
    ) tmp2
    ;
*/
  }
}
