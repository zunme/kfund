<?php
include_once('./_Common_execute_class.php');
include_once(MARI_PATH.'/header.config.php');
include_once(MARI_PATH.'/'.$sale['sale_code'].'/Template_/Template_.class.php');
/************************************************
View
************************************************/
if(!$mode=="" || !$cms==""){
}else{
	echo"
	<script language=\"javascript\">
		location.href=\"?mode=main\";
	</script>
	";
}
/*선언*/
$tpl = new Template_;
/*모바일 환경 체크*/
$mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일전용사용안함*/
$mobile_agent ='/(mobilonly)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {


/************************************************
USER MOBILE LAYOUTS 설정
************************************************/

//$tpl->define('skin1_index', './layouts/mobile/'.$img[c_mobile_skin].'/skin1_index.tpl');
$tpl->define('skin1_footer', './layouts/mobile/'.$img[c_mobile_skin].'/skin1_footer.tpl');
$tpl->define('index', './layouts/mobile/'.$img[c_mobile_skin].'/index.tpl');
$tpl->define('invest', './layouts/mobile/'.$img[c_mobile_skin].'/invest.tpl');
$tpl->define('loan', './layouts/mobile/'.$img[c_mobile_skin].'/loan.tpl');
$tpl->define('loan_real', './layouts/mobile/'.$img[c_mobile_skin].'/loan_real.tpl');
/*임지선 대출하기 페이지 생성 2017-04-10*/
$tpl->define('loan2', './layouts/mobile/'.$img[c_mobile_skin].'/loan2.tpl');
$tpl->define('loan_credit', './layouts/mobile/'.$img[c_mobile_skin].'/loan_credit.tpl');
$tpl->define('loan_business', './layouts/mobile/'.$img[c_mobile_skin].'/loan_business.tpl');
$tpl->define('guide_loan', './layouts/mobile/'.$img[c_mobile_skin].'/guide_loan.tpl');




/*임지선 투자하기 페이지(개인) 생성 2017-04-10*/
$tpl->define('invest_credit', './layouts/mobile/'.$img[c_mobile_skin].'/invest_credit.tpl');


/*임지선 고객지원 페이지 생성 2017-04-11*/
$tpl->define('guide_invest', './layouts/mobile/'.$img[c_mobile_skin].'/guide_invest.tpl');
/*임지선 회사소개 페이지 생성 2017-04-25*/
$tpl->define('company_intro', './layouts/mobile/'.$img[c_mobile_skin].'/company_intro.tpl');
$tpl->define('companyintro01', './layouts/mobile/'.$img[c_mobile_skin].'/companyintro01.tpl');

$tpl->define('member_modify', './layouts/mobile/'.$img[c_mobile_skin].'/join3.tpl');
$tpl->define('invest_view', './layouts/mobile/'.$img[c_mobile_skin].'/invest_view.tpl');
$tpl->define('personal_info_pw', './layouts/mobile/'.$img[c_mobile_skin].'/personal_info_pw.tpl');
$tpl->define('info_modify', './layouts/mobile/'.$img[c_mobile_skin].'/info_modify.tpl');
$tpl->define('change_pw', './layouts/mobile/'.$img[c_mobile_skin].'/change_pw.tpl');
$tpl->define('leave', './layouts/mobile/'.$img[c_mobile_skin].'/leave.tpl');
$tpl->define('invest2', './layouts/mobile/'.$img[c_mobile_skin].'/invest2.tpl');
$tpl->define('charge', './layouts/mobile/'.$img[c_mobile_skin].'/charge.tpl');
$tpl->define('withdrawl', './layouts/mobile/'.$img[c_mobile_skin].'/withdrawl.tpl');
$tpl->define('mypage', './layouts/mobile/'.$img[c_mobile_skin].'/mypage.tpl');
$tpl->define('password', './layouts/mobile/'.$img[c_mobile_skin].'/password.tpl');
$tpl->define('point_pay', './layouts/mobile/'.$img[c_mobile_skin].'/point_pay.tpl');
$tpl->define('product_details', './layouts/mobile/'.$img[c_mobile_skin].'/product_details.tpl');
$tpl->define('product_list', './layouts/mobile/'.$img[c_mobile_skin].'/product_list.tpl');
$tpl->define('register_set01', './layouts/mobile/'.$img[c_mobile_skin].'/register_set01.tpl');
$tpl->define('register_set02', './layouts/mobile/'.$img[c_mobile_skin].'/register_set02.tpl');
$tpl->define('register_set03', './layouts/mobile/'.$img[c_mobile_skin].'/register_set03.tpl');
$tpl->define('register_set04', './layouts/mobile/'.$img[c_mobile_skin].'/register_set04.tpl');
$tpl->define('secession', './layouts/mobile/'.$img[c_mobile_skin].'/secession.tpl');
$tpl->define('withdrawal_Request', './layouts/mobile/'.$img[c_mobile_skin].'/withdrawal_Request.tpl');
$tpl->define('error', './layouts/mobile/'.$img[c_mobile_skin].'/error.tpl');
$tpl->define('invest_proce', './layouts/mobile/'.$img[c_mobile_skin].'/invest_proce.tpl');
$tpl->define('invest_complete', './layouts/mobile/'.$img[c_mobile_skin].'/invest_complete.tpl');
$tpl->define('common1', './layouts/mobile/'.$img[c_mobile_skin].'/common1.tpl');
$tpl->define('common2', './layouts/mobile/'.$img[c_mobile_skin].'/common2.tpl');
$tpl->define('common3', './layouts/mobile/'.$img[c_mobile_skin].'/common3.tpl');
$tpl->define('calculation', './layouts/mobile/'.$img[c_mobile_skin].'/calculation.tpl');
$tpl->define('my_info', './layouts/mobile/'.$img[c_mobile_skin].'/my_info.tpl');
$tpl->define('my_pg', './layouts/mobile/'.$img[c_mobile_skin].'/my_pg.tpl');
$tpl->define('loan_info', './layouts/mobile/'.$img[c_mobile_skin].'/loan_info.tpl');
$tpl->define('invest_info', './layouts/mobile/'.$img[c_mobile_skin].'/invest_info.tpl');
$tpl->define('invest', './layouts/mobile/'.$img[c_mobile_skin].'/invest.tpl');
$tpl->define('emoney', './layouts/mobile/'.$img[c_mobile_skin].'/emoney.tpl');
$tpl->define('customer', './layouts/mobile/'.$img[c_mobile_skin].'/customer.tpl');
$tpl->define('header', './layouts/mobile/'.$img[c_mobile_skin].'/header.tpl');
$tpl->define('sub_header', './layouts/mobile/'.$img[c_mobile_skin].'/sub_header.tpl');
$tpl->define('invest_view', './layouts/mobile/'.$img[c_mobile_skin].'/invest_view.tpl');
$tpl->define('guide1', './layouts/mobile/'.$img[c_mobile_skin].'/guide1.tpl');
$tpl->define('guide2', './layouts/mobile/'.$img[c_mobile_skin].'/guide2.tpl');
$tpl->define('loan_step1', './layouts/mobile/'.$img[c_mobile_skin].'/loan_step1.tpl');
$tpl->define('loan_step2', './layouts/mobile/'.$img[c_mobile_skin].'/loan_step2.tpl');
$tpl->define('loan_step3', './layouts/mobile/'.$img[c_mobile_skin].'/loan_step3.tpl');
$tpl->define('loan_step4', './layouts/mobile/'.$img[c_mobile_skin].'/loan_step4.tpl');
$tpl->define('faq', './layouts/mobile/'.$img[c_mobile_skin].'/faq.tpl');
$tpl->define('faq_view', './layouts/mobile/'.$img[c_mobile_skin].'/faq_view.tpl');
$tpl->define('customer_center', './layouts/mobile/'.$img[c_mobile_skin].'/customer_center.tpl');
$tpl->define('notice', './layouts/mobile/'.$img[c_mobile_skin].'/notice.tpl');
$tpl->define('media', './layouts/mobile/'.$img[c_mobile_skin].'/media.tpl');
$tpl->define('notice_view', './layouts/mobile/'.$img[c_mobile_skin].'/notice_view.tpl');

$tpl->define('join_step1', './layouts/mobile/'.$img[c_mobile_skin].'/join_step1.tpl');
$tpl->define('join_step2', './layouts/mobile/'.$img[c_mobile_skin].'/join_step2.tpl');
$tpl->define('join_step3', './layouts/mobile/'.$img[c_mobile_skin].'/join_step3.tpl');
$tpl->define('join_step4', './layouts/mobile/'.$img[c_mobile_skin].'/join_step4.tpl');
$tpl->define('mypage_withdrawal', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_withdrawal.tpl');
$tpl->define('mypage_basic', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_basic.tpl');
$tpl->define('mypage_emoney', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_emoney.tpl');
$tpl->define('mypage_charge', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_charge.tpl');
$tpl->define('mypage_account', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_account.tpl');
$tpl->define('pw_find', './layouts/mobile/'.$img[c_mobile_skin].'/pw_find.tpl');
$tpl->define('mypage_loanstatus', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_loanstatus.tpl');
$tpl->define('mypage_depositstatus', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_depositstatus.tpl');
$tpl->define('company_info', './layouts/mobile/'.$img[c_mobile_skin].'/company_info.tpl');
$tpl->define('loan_application', './layouts/mobile/'.$img[c_mobile_skin].'/loan_application.tpl');
$tpl->define('loan_application2', './layouts/mobile/'.$img[c_mobile_skin].'/loan_application2.tpl');
$tpl->define('dash_mypage', './layouts/mobile/'.$img[c_mobile_skin].'/dash_mypage.tpl');
$tpl->define('contract_login', './layouts/mobile/'.$img[c_mobile_skin].'/contract_login.tpl');

$tpl->define('protection_plan', './layouts/mobile/'.$img[c_mobile_skin].'/protection_plan.tpl');
$tpl->define('guide', './layouts/mobile/'.$img[c_mobile_skin].'/guide.tpl');
$tpl->define('mypage_contract', './layouts/home/'.$img[c_home_skin].'/mypage_contract.tpl');
$tpl->define('faq', './layouts/home/'.$img[c_home_skin].'/faq.tpl');
$tpl->define('invest_calculation', './layouts/home/'.$img[c_home_skin].'/invest_calculation.tpl');
$tpl->define('introduce', './layouts/mobile/'.$img[c_mobile_skin].'/introduce.tpl');
$tpl->define('safeon', './layouts/mobile/'.$img[c_mobile_skin].'/safeon.tpl');

/*▽마이페이지 개편을 위한 추가 페이지 생성 2016-10-19 박유나▽*/
$tpl->define('mypage_my_info', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_my_info.tpl');
$tpl->define('mypage_confirm_center', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_confirm_center.tpl');
$tpl->define('mypage_balance', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_balance.tpl');
$tpl->define('mypage_alert', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_alert.tpl');
$tpl->define('mypage_out', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_out.tpl');
$tpl->define('mypage_tenderstatus', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_tenderstatus.tpl');
$tpl->define('mypage_investment', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_investment.tpl');
$tpl->define('mypage_withholding_list', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_withholding_list.tpl');


/*마이페이지 자동투자 관련 페이지 2017-02-09 이지은*/
$tpl->define('mypage_auto_invest_set', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_set.tpl');
$tpl->define('mypage_auto_invest_list', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_list.tpl');
$tpl->define('mypage_auto_invest_apply', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_apply.tpl');
$tpl->define('mypage_auto_invest_apply_all', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_apply_all.tpl');
$tpl->define('mypage_auto_invest_info_pop', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_info_pop.tpl');
$tpl->define('mypage_auto_invest_list_pop', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_list_pop.tpl');
$tpl->define('mypage_auto_invest_adjust', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_adjust.tpl');
$tpl->define('mypage_auto_invest_tender', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_auto_invest_tender.tpl');
$tpl->define('mypage_portfolio_pop', './layouts/mobile/'.$img[c_mobile_skin].'/mypage_portfolio_pop.tpl');

}else{
/************************************************
USER PAGE LAYOUTS 설정
************************************************/
/*이벤트 템플릿 스킨 2016-12-01 시작*/
//$tpl->define('skin1_index', './layouts/home/'.$img[c_home_skin].'/skin1_index.tpl');
//$tpl->define('skin1_invest', './layouts/home/'.$img[c_home_skin].'/skin1_invest.tpl');
//$tpl->define('skin1_invest_view', './layouts/home/'.$img[c_home_skin].'/skin1_invest_view.tpl');
//$tpl->define('skin1_loan', './layouts/home/'.$img[c_home_skin].'/skin1_loan.tpl');
$tpl->define('skin1_header', './layouts/home/'.$img[c_home_skin].'/skin1_header.tpl');
$tpl->define('skin1_header_sub', './layouts/home/'.$img[c_home_skin].'/skin1_header_sub.tpl');
$tpl->define('skin1_footer', './layouts/home/'.$img[c_home_skin].'/skin1_footer.tpl');
$tpl->define('skin1_guide_invest', './layouts/home/'.$img[c_home_skin].'/skin1_guide_invest.tpl');
$tpl->define('skin1_guide_content', './layouts/home/'.$img[c_home_skin].'/skin1_guide_content.tpl');
$tpl->define('skin1_mypage', './layouts/home/'.$img[c_home_skin].'/skin1_mypage.tpl');
$tpl->define('invest_view_new', './layouts/home/'.$img[c_home_skin].'/invest_view_new.tpl');
$tpl->define('company_intro', './layouts/home/'.$img[c_home_skin].'/company_intro.tpl');
$tpl->define('invest_new', './layouts/home/'.$img[c_home_skin].'/invest_new.tpl');
/*이벤트 템플릿 스킨 끝*/
$tpl->define('header_sub', './layouts/home/'.$img[c_home_skin].'/header_sub.tpl');
$tpl->define('test01', './layouts/home/'.$img[c_home_skin].'/test01.tpl');
$tpl->define('index', './layouts/home/'.$img[c_home_skin].'/index.tpl');
$tpl->define('invest', './layouts/home/'.$img[c_home_skin].'/invest.tpl');
$tpl->define('loan', './layouts/home/'.$img[c_home_skin].'/loan.tpl');
$tpl->define('loan_real', './layouts/home/'.$img[c_home_skin].'/loan_real.tpl');
$tpl->define('loan_credit', './layouts/home/'.$img[c_home_skin].'/loan_credit.tpl');
$tpl->define('loan_business', './layouts/home/'.$img[c_home_skin].'/loan_business.tpl');
$tpl->define('member_modify', './layouts/home/'.$img[c_home_skin].'/join3.tpl');
$tpl->define('invest_view', './layouts/home/'.$img[c_home_skin].'/invest_view.tpl');
$tpl->define('personal_info_pw', './layouts/home/'.$img[c_home_skin].'/personal_info_pw.tpl');
$tpl->define('info_modify', './layouts/home/'.$img[c_home_skin].'/info_modify.tpl');
$tpl->define('change_pw', './layouts/home/'.$img[c_home_skin].'/change_pw.tpl');
$tpl->define('leave', './layouts/home/'.$img[c_home_skin].'/leave.tpl');
$tpl->define('invest2', './layouts/home/'.$img[c_home_skin].'/invest2.tpl');
$tpl->define('charge', './layouts/home/'.$img[c_home_skin].'/charge.tpl');
$tpl->define('withdrawl', './layouts/home/'.$img[c_home_skin].'/withdrawl.tpl');
$tpl->define('mypage', './layouts/home/'.$img[c_home_skin].'/mypage.tpl');
$tpl->define('password', './layouts/home/'.$img[c_home_skin].'/password.tpl');
$tpl->define('point_pay', './layouts/home/'.$img[c_home_skin].'/point_pay.tpl');
$tpl->define('product_details', './layouts/home/'.$img[c_home_skin].'/product_details.tpl');
$tpl->define('product_list', './layouts/home/'.$img[c_home_skin].'/product_list.tpl');
$tpl->define('register_set01', './layouts/home/'.$img[c_home_skin].'/register_set01.tpl');
$tpl->define('register_set02', './layouts/home/'.$img[c_home_skin].'/register_set02.tpl');
$tpl->define('register_set03', './layouts/home/'.$img[c_home_skin].'/register_set03.tpl');
$tpl->define('register_set04', './layouts/home/'.$img[c_home_skin].'/register_set04.tpl');
$tpl->define('register_set04', './layouts/home/'.$img[c_home_skin].'/register_set04.tpl');
$tpl->define('secession', './layouts/home/'.$img[c_home_skin].'/secession.tpl');
$tpl->define('withdrawal_Request', './layouts/home/'.$img[c_home_skin].'/withdrawal_Request.tpl');
$tpl->define('error', './layouts/home/'.$img[c_home_skin].'/error.tpl');
$tpl->define('invest_proce', './layouts/home/'.$img[c_home_skin].'/invest_proce.tpl');
$tpl->define('invest_complete', './layouts/home/'.$img[c_home_skin].'/invest_complete.tpl');
$tpl->define('common1', './layouts/home/'.$img[c_home_skin].'/common1.tpl');
$tpl->define('common2', './layouts/home/'.$img[c_home_skin].'/common2.tpl');
$tpl->define('common3', './layouts/home/'.$img[c_home_skin].'/common3.tpl');
$tpl->define('common4', './layouts/home/'.$img[c_home_skin].'/common4.tpl');
$tpl->define('calculation', './layouts/home/'.$img[c_home_skin].'/calculation.tpl');
$tpl->define('company', './layouts/home/'.$img[c_home_skin].'/company.tpl');
$tpl->define('product', './layouts/home/'.$img[c_home_skin].'/product.tpl');
$tpl->define('loan_info', './layouts/home/'.$img[c_home_skin].'/loan_info.tpl');
$tpl->define('invest_notice', './layouts/home/'.$img[c_home_skin].'/invest_notice.tpl');
$tpl->define('faq', './layouts/home/'.$img[c_home_skin].'/faq.tpl');
$tpl->define('contract', './layouts/home/'.$img[c_home_skin].'/contract.tpl');
$tpl->define('contract_login', './layouts/home/'.$img[c_home_skin].'/contract_login.tpl');
$tpl->define('contract_upload', './layouts/home/'.$img[c_home_skin].'/contract_upload.tpl');
$tpl->define('test', './layouts/home/'.$img[c_home_skin].'/test.tpl');
$tpl->define('my_pg', './layouts/home/'.$img[c_home_skin].'/my_pg.tpl');
$tpl->define('company_info', './layouts/home/'.$img[c_home_skin].'/company_info.tpl');
$tpl->define('withholding_list2', './layouts/home/'.$img[c_home_skin].'/withholding_list2.tpl');
$tpl->define('withholding_list_more', './layouts/home/'.$img[c_home_skin].'/withholding_list_more.tpl');
$tpl->define('mypage_loan', './layouts/home/'.$img[c_home_skin].'/mypage_loan.tpl');
$tpl->define('mypage_invest', './layouts/home/'.$img[c_home_skin].'/mypage_invest.tpl');
$tpl->define('pw_find', './layouts/home/'.$img[c_home_skin].'/pw_find.tpl');
$tpl->define('loan2', './layouts/home/'.$img[c_home_skin].'/loan2.tpl');
$tpl->define('company_intro', './layouts/home/'.$img[c_home_skin].'/company_intro.tpl');
$tpl->define('guide', './layouts/home/'.$img[c_home_skin].'/guide.tpl');
$tpl->define('loan_realestate', './layouts/home/'.$img[c_home_skin].'/loan_realestate.tpl');
$tpl->define('loan_credit', './layouts/home/'.$img[c_home_skin].'/loan_credit.tpl');
$tpl->define('mypage_loan_info_realestate', './layouts/home/'.$img[c_home_skin].'/mypage_loan_info_realestate.tpl');
$tpl->define('mypage_invest_info_realestate', './layouts/home/'.$img[c_home_skin].'/mypage_invest_info_realestate.tpl');
$tpl->define('mypage_loan_info_credit', './layouts/home/'.$img[c_home_skin].'/mypage_loan_info_credit.tpl');
$tpl->define('mypage_invest_info_credit', './layouts/home/'.$img[c_home_skin].'/mypage_invest_info_credit.tpl');
$tpl->define('invest_calculation', './layouts/home/'.$img[c_home_skin].'/invest_calculation.tpl');
$tpl->define('qna', './layouts/home/'.$img[c_home_skin].'/qna.tpl');
$tpl->define('protection_plan', './layouts/home/'.$img[c_home_skin].'/protection_plan.tpl');
$tpl->define('interview_list', './layouts/home/'.$img[c_home_skin].'/interview_list.tpl');
$tpl->define('interview_view', './layouts/home/'.$img[c_home_skin].'/interview_view.tpl');

$tpl->define('companyintro01', './layouts/home/'.$img[c_home_skin].'/companyintro01.tpl');

$tpl->define('test', './layouts/home/'.$img[c_home_skin].'/test.tpl');
/*임지선 신용 투자 페이지 생성 2017-04-04*/
$tpl->define('invest_credit', './layouts/home/'.$img[c_home_skin].'/invest_credit.tpl');

/*테스트*/
$tpl->define('pho', './layouts/home/'.$img[c_home_skin].'/pho.tpl');
/*임지선 대출하기 페이지 생성 2017-04-05*/

$tpl->define('loan_real', './layouts/home/'.$img[c_home_skin].'/loan_real.tpl');
$tpl->define('loan_credit', './layouts/home/'.$img[c_home_skin].'/loan_credit.tpl');
$tpl->define('loan_business', './layouts/home/'.$img[c_home_skin].'/loan_business.tpl');
$tpl->define('loan_credit02', './layouts/home/'.$img[c_home_skin].'/loan_credit02.tpl');

/*pay24*/

$tpl->define('sub_header', './layouts/home/'.$img[c_home_skin].'/sub_header.tpl');
$tpl->define('footer', './layouts/home/'.$img[c_home_skin].'/footer.tpl');
$tpl->define('index_pay24', './layouts/home/'.$img[c_home_skin].'/index_pay24.tpl');
$tpl->define('invest_info', './layouts/home/'.$img[c_home_skin].'/invest_info.tpl');
$tpl->define('invest_info_detail', './layouts/home/'.$img[c_home_skin].'/invest_info_detail.tpl');
$tpl->define('investment', './layouts/home/'.$img[c_home_skin].'/investment.tpl');
/*
$tpl->define('loan_step1', './layouts/home/'.$img[c_home_skin].'/loan_step1.tpl');
$tpl->define('loan_step2', './layouts/home/'.$img[c_home_skin].'/loan_step2.tpl');
$tpl->define('loan_step3', './layouts/home/'.$img[c_home_skin].'/loan_step3.tpl');
$tpl->define('loan_step4', './layouts/home/'.$img[c_home_skin].'/loan_step4.tpl');
*/
$tpl->define('mypage_loan_info', './layouts/home/'.$img[c_home_skin].'/mypage_loan_info.tpl');
$tpl->define('mypage_invest_info', './layouts/home/'.$img[c_home_skin].'/mypage_invest_info.tpl');
$tpl->define('join_step1', './layouts/home/'.$img[c_home_skin].'/join_step1.tpl');
$tpl->define('join_step2', './layouts/home/'.$img[c_home_skin].'/join_step2.tpl');
$tpl->define('join_step3', './layouts/home/'.$img[c_home_skin].'/join_step3.tpl');
$tpl->define('join_step4', './layouts/home/'.$img[c_home_skin].'/join_step4.tpl');
$tpl->define('pay24_login', './layouts/home/'.$img[c_home_skin].'/pay24_login.tpl');
$tpl->define('customer_center', './layouts/home/'.$img[c_home_skin].'/customer_center.tpl');
$tpl->define('notice', './layouts/home/'.$img[c_home_skin].'/notice.tpl');
$tpl->define('notice_view', './layouts/home/'.$img[c_home_skin].'/notice_view.tpl');
$tpl->define('faq', './layouts/home/'.$img[c_home_skin].'/faq.tpl');
$tpl->define('pw_find', './layouts/home/'.$img[c_home_skin].'/pw_find.tpl');
$tpl->define('mypage_emoney', './layouts/home/'.$img[c_home_skin].'/mypage_emoney.tpl');
$tpl->define('mypage_charge', './layouts/home/'.$img[c_home_skin].'/mypage_charge.tpl');
$tpl->define('mypage_withdrawal', './layouts/home/'.$img[c_home_skin].'/mypage_withdrawal.tpl');
$tpl->define('policy', './layouts/home/'.$img[c_home_skin].'/policy.tpl');
$tpl->define('service', './layouts/home/'.$img[c_home_skin].'/service.tpl');
$tpl->define('mypage_basic', './layouts/home/'.$img[c_home_skin].'/mypage_basic.tpl');
$tpl->define('mypage_pwchange', './layouts/home/'.$img[c_home_skin].'/mypage_pwchange.tpl');
$tpl->define('mypage_out', './layouts/home/'.$img[c_home_skin].'/mypage_out.tpl');
$tpl->define('mypage_interest_invest', './layouts/home/'.$img[c_home_skin].'/mypage_interest_invest.tpl');
$tpl->define('mypage_loanstatus', './layouts/home/'.$img[c_home_skin].'/mypage_loanstatus.tpl');
$tpl->define('mypage_depositstatus', './layouts/home/'.$img[c_home_skin].'/mypage_depositstatus.tpl');
$tpl->define('mypage_tenderstatus', './layouts/home/'.$img[c_home_skin].'/mypage_tenderstatus.tpl');
$tpl->define('mypage_investment', './layouts/home/'.$img[c_home_skin].'/mypage_investment.tpl');
$tpl->define('payment_check', './layouts/home/'.$img[c_home_skin].'/payment_check.tpl');
$tpl->define('invest_income', './layouts/home/'.$img[c_home_skin].'/invest_income.tpl');
$tpl->define('investment_done', './layouts/home/'.$img[c_home_skin].'/investment_done.tpl');
$tpl->define('common1', './layouts/home/'.$img[c_home_skin].'/common1.tpl');
$tpl->define('common2', './layouts/home/'.$img[c_home_skin].'/common2.tpl');
$tpl->define('common3', './layouts/home/'.$img[c_home_skin].'/common3.tpl');
$tpl->define('required_reading', './layouts/home/'.$img[c_home_skin].'/required_reading.tpl');
$tpl->define('mypage_withholding_list', './layouts/home/'.$img[c_home_skin].'/mypage_withholding_list.tpl');
$tpl->define('capital_protected', './layouts/home/'.$img[c_home_skin].'/capital_protected.tpl');
$tpl->define('mypage_contract', './layouts/home/'.$img[c_home_skin].'/mypage_contract.tpl');
$tpl->define('contract_login', './layouts/home/'.$img[c_home_skin].'/contract_login.tpl');
/**2017-07-14권리증서 추가**/
$tpl->define('invest_receipt', './layouts/home/'.$img[c_home_skin].'/invest_receipt.tpl');

$tpl->define('introduce', './layouts/home/'.$img[c_home_skin].'/introduce.tpl');
$tpl->define('guide_invest', './layouts/home/'.$img[c_home_skin].'/guide_invest.tpl');
$tpl->define('guide_loan', './layouts/home/'.$img[c_home_skin].'/guide_loan.tpl');
$tpl->define('guide_content', './layouts/home/'.$img[c_home_skin].'/guide_content.tpl');
$tpl->define('invest_json', './layouts/home/'.$img[c_home_skin].'/invest_json.tpl');
$tpl->define('safeon', './layouts/home/'.$img[c_home_skin].'/safeon.tpl');


/*2018-02-12 파스타 셋팅전*/
$tpl->define('a_pastafter', './layouts/home/'.$img[c_home_skin].'/a_pastafter.tpl');

/*2018-04-02 UIOEX 페이지*/
$tpl->define('uioex_main', './layouts/home/'.$img[c_home_skin].'/uioex_main.tpl');
$tpl->define('uioex_header', './layouts/home/'.$img[c_home_skin].'/uioex_header.tpl');
$tpl->define('uioex_footer', './layouts/home/'.$img[c_home_skin].'/uioex_footer.tpl');

/*▽마이페이지 개편을 위한 추가 페이지 생성 2016-10-10 박유나 상환스케쥴▽*/
$tpl->define('mypage_my_info', './layouts/home/'.$img[c_home_skin].'/mypage_my_info.tpl');
$tpl->define('mypage_confirm_center', './layouts/home/'.$img[c_home_skin].'/mypage_confirm_center.tpl');
$tpl->define('mypage_balance', './layouts/home/'.$img[c_home_skin].'/mypage_balance.tpl');
$tpl->define('mypage_alert', './layouts/home/'.$img[c_home_skin].'/mypage_alert.tpl');
$tpl->define('mypage_calculate_schedule', './layouts/home/'.$img[c_home_skin].'/mypage_calculate_schedule.tpl');
$tpl->define('mypage_schedule', './layouts/home/'.$img[c_home_skin].'/mypage_schedule.tpl');
$tpl->define('mypage_loan_manage', './layouts/home/'.$img[c_home_skin].'/mypage_loan_manage.tpl');
$tpl->define('mypage_loan_schedule', './layouts/home/'.$img[c_home_skin].'/mypage_loan_schedule.tpl');
$tpl->define('mypage_loan_schedule_more', './layouts/home/'.$img[c_home_skin].'/mypage_loan_schedule_more.tpl');

/*마이페이지 자동투자 관련 페이지 2017-02-02 이지은*/
$tpl->define('mypage_auto_invest', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest.tpl');
$tpl->define('mypage_auto_invest_set', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_set.tpl');
$tpl->define('mypage_auto_invest_list', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_list.tpl');
$tpl->define('mypage_auto_invest_apply', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_apply.tpl');
$tpl->define('mypage_portfolio_pop', './layouts/home/'.$img[c_home_skin].'/mypage_portfolio_pop.tpl');
$tpl->define('mypage_auto_invest_info_pop', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_info_pop.tpl');
$tpl->define('mypage_auto_invest_list_pop', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_list_pop.tpl');
$tpl->define('mypage_auto_invest_apply_all', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_apply_all.tpl');
$tpl->define('mypage_auto_invest_tender', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_tender.tpl');
$tpl->define('mypage_auto_invest_adjust', './layouts/home/'.$img[c_home_skin].'/mypage_auto_invest_adjust.tpl');

/*▽포트폴리오투자 2017-02-13 박유나▽*/
$tpl->define('portfolio_list', './layouts/home/'.$img[c_home_skin].'/portfolio_list.tpl');
$tpl->define('portfolio_view', './layouts/home/'.$img[c_home_skin].'/portfolio_view.tpl');


}

/************************************************
USER LOGIN LAYOUTS 설정
************************************************/
$tpl->define('login', './layouts/login/'.$img[c_login_skin].'/login.tpl');
$tpl->define('login_form', './layouts/login/'.$img[c_login_skin].'/login.tpl');

/************************************************
USER MEMBERFORM LAYOUTS 설정
************************************************/
$tpl->define('join_auth', './layouts/member/'.$img[c_member_skin].'/join_auth.tpl');
$tpl->define('join0', './layouts/member/'.$img[c_member_skin].'/join0.tpl');
$tpl->define('join1', './layouts/member/'.$img[c_member_skin].'/join1.tpl');
$tpl->define('join2', './layouts/member/'.$img[c_member_skin].'/join2.tpl');
$tpl->define('join3', './layouts/member/'.$img[c_member_skin].'/join3.tpl');
$tpl->define('join3_enterprise', './layouts/member/'.$img[c_member_skin].'/join3_enterprise.tpl');
$tpl->define('join4', './layouts/member/'.$img[c_member_skin].'/join4.tpl');

/************************************************
USER 사용 페이지
************************************************/
for ($i=0;  $pview=sql_fetch_array($pageexe); $i++){
	$tpl->define(''.$pview[p_id].'', './layouts/home/'.$img[c_home_skin].'/'.$pview[p_id].'.tpl');
}

/************************************************
USER INCLUDE 페이지
************************************************/
for ($i=0;  $iview=sql_fetch_array($incexe); $i++){
	$tpl->define(''.$iview[p_id].'', './layouts/home/'.$img[c_home_skin].'/'.$iview[p_id].'.tpl');
}

/************************************************
user 게시판 설정(공통)
************************************************/
/*게시판 리스트*/
$tpl->define('bbs_list', './layouts/board/'.$bbs_config[bo_skin].'/list.tpl');
/*게시판 상세*/
$tpl->define('bbs_view', './layouts/board/'.$bbs_config[bo_skin].'/view.tpl');
/*게시판 쓰기*/
$tpl->define('bbs_write', './layouts/board/'.$bbs_config[bo_skin].'/write.tpl');
/*코멘트*/
$tpl->define('bbs_comment', './layouts/board/'.$bbs_config[bo_skin].'/view_comment.tpl');

/*latest스킨*/
$tpl->define('view_list', './layouts/latest/'.$img[c_latest_skin].'/view.list.tpl');



/************************************************
cs bbs 게시판 설정(공통)
************************************************/
/*게시판 리스트*/
$tpl->define('cs_bbs_list', './layouts/admin_board/'.$skin.'/list.tpl');
/*게시판 상세*/
$tpl->define('cs_bbs_view', './layouts/admin_board/'.$skin.'/view.tpl');
/*게시판 쓰기*/
$tpl->define('cs_bbs_write', './layouts/admin_board/'.$skin.'/write.tpl');
/*코멘트*/
$tpl->define('cs_bbs_comment', './layouts/admin_board/'.$skin.'/view_comment.tpl');
/*latest스킨*/
$tpl->define('cs_view_list', './layouts/admin_latest/'.$img[c_latest_skin].'/view.list.tpl');


/************************************************
define ADMIN PAGE 설정
************************************************/
$tpl->define('admin', './layouts/admin/'.$img[c_admin_skin].'/admin.tpl');
$tpl->define('analytics', './layouts/admin/'.$img[c_admin_skin].'/analytics.tpl');
$tpl->define('board_list', './layouts/admin/'.$img[c_admin_skin].'/board_list.tpl');
$tpl->define('board_form', './layouts/admin/'.$img[c_admin_skin].'/board_form.tpl');
$tpl->define('user_board_list', './layouts/admin/'.$img[c_admin_skin].'/user_board_list.tpl');
$tpl->define('user_board_form', './layouts/admin/'.$img[c_admin_skin].'/user_board_form.tpl');
$tpl->define('boardgroup_form', './layouts/admin/'.$img[c_admin_skin].'/boardgroup_form.tpl');
$tpl->define('boardgroup_list', './layouts/admin/'.$img[c_admin_skin].'/boardgroup_list.tpl');
$tpl->define('charge_list', './layouts/admin/'.$img[c_admin_skin].'/charge_list.tpl');
$tpl->define('charge_list', './layouts/admin/'.$img[c_admin_skin].'/charge_list.tpl');
$tpl->define('config_form', './layouts/admin/'.$img[c_admin_skin].'/config_form.tpl');
$tpl->define('favicon', './layouts/admin/'.$img[c_admin_skin].'/favicon.tpl');
$tpl->define('invest_setup_form', './layouts/admin/'.$img[c_admin_skin].'/invest_setup_form.tpl');
$tpl->define('invest_setup_list', './layouts/admin/'.$img[c_admin_skin].'/invest_setup_list.tpl');
$tpl->define('loan_form', './layouts/admin/'.$img[c_admin_skin].'/loan_form.tpl');
$tpl->define('loan_list', './layouts/admin/'.$img[c_admin_skin].'/loan_list.tpl');
$tpl->define('loan_list2', './layouts/admin/'.$img[c_admin_skin].'/loan_list2.tpl');
$tpl->define('loan_main', './layouts/admin/'.$img[c_admin_skin].'/loan_main.tpl');
$tpl->define('newpopup', './layouts/admin/'.$img[c_admin_skin].'/newpopup.tpl');
$tpl->define('member_grade', './layouts/admin/'.$img[c_admin_skin].'/member_grade.tpl');
$tpl->define('member_main', './layouts/admin/'.$img[c_admin_skin].'/member_main.tpl');
$tpl->define('withdrawal_list', './layouts/admin/'.$img[c_admin_skin].'/withdrawal_list.tpl');
$tpl->define('member_form', './layouts/admin/'.$img[c_admin_skin].'/member_form.tpl');
$tpl->define('mail_list', './layouts/admin/'.$img[c_admin_skin].'/mail_list.tpl');
$tpl->define('mail_form', './layouts/admin/'.$img[c_admin_skin].'/mail_form.tpl');
$tpl->define('pay_list', './layouts/admin/'.$img[c_admin_skin].'/pay_list.tpl');
$tpl->define('page_security', './layouts/admin/'.$img[c_admin_skin].'/page_security.tpl');
$tpl->define('popuplist', './layouts/admin/'.$img[c_admin_skin].'/popuplist.tpl');
$tpl->define('emoney_list', './layouts/admin/'.$img[c_admin_skin].'/emoney_list.tpl');
$tpl->define('product_add_pop', './layouts/admin/'.$img[c_admin_skin].'/product_add_pop.tpl');
$tpl->define('sendmail_test', './layouts/admin/'.$img[c_admin_skin].'/sendmail_test.tpl');
$tpl->define('invest_list', './layouts/admin/'.$img[c_admin_skin].'/invest_list.tpl');
$tpl->define('invest_pay_setup', './layouts/admin/'.$img[c_admin_skin].'/invest_pay_setup.tpl');
$tpl->define('member_list', './layouts/admin/'.$img[c_admin_skin].'/member_list.tpl');
$tpl->define('sales_report', './layouts/admin/'.$img[c_admin_skin].'/sales_report.tpl');
$tpl->define('service_config', './layouts/admin/'.$img[c_admin_skin].'/service_config.tpl');
$tpl->define('seo_config', './layouts/admin/'.$img[c_admin_skin].'/seo_config.tpl');
$tpl->define('reservation_send', './layouts/admin/'.$img[c_admin_skin].'/reservation_send.tpl');
$tpl->define('leave_list', './layouts/admin/'.$img[c_admin_skin].'/leave_list.tpl');
$tpl->define('admin_login', './layouts/admin/'.$img[c_admin_skin].'/admin_login.tpl');
$tpl->define('filemanager', './layouts/admin/'.$img[c_admin_skin].'/filemanager.tpl');
$tpl->define('ftp_client', './layouts/admin/'.$img[c_admin_skin].'/ftp_client.tpl');
$tpl->define('member_main', './layouts/admin/'.$img[c_admin_skin].'/member_main.tpl');
$tpl->define('board_main', './layouts/admin/'.$img[c_admin_skin].'/board_main.tpl');
$tpl->define('popup_main', './layouts/admin/'.$img[c_admin_skin].'/popup_main.tpl');
$tpl->define('loan_main', './layouts/admin/'.$img[c_admin_skin].'/loan_main.tpl');
$tpl->define('invest_main', './layouts/admin/'.$img[c_admin_skin].'/invest_main.tpl');
$tpl->define('design_main', './layouts/admin/'.$img[c_admin_skin].'/design_main.tpl');
$tpl->define('sms_main', './layouts/admin/'.$img[c_admin_skin].'/sms_main.tpl');
$tpl->define('setting_main', './layouts/admin/'.$img[c_admin_skin].'/setting_main.tpl');
$tpl->define('sms_setup', './layouts/admin/'.$img[c_admin_skin].'/sms_setup.tpl');
$tpl->define('sms_manage', './layouts/admin/'.$img[c_admin_skin].'/sms_manage.tpl');
$tpl->define('lms_manage', './layouts/admin/'.$img[c_admin_skin].'/lms_manage.tpl');
$tpl->define('sms_charge', './layouts/admin/'.$img[c_admin_skin].'/sms_charge.tpl');
$tpl->define('sms_group', './layouts/admin/'.$img[c_admin_skin].'/sms_group.tpl');
$tpl->define('sms_book', './layouts/admin/'.$img[c_admin_skin].'/sms_book.tpl');
$tpl->define('sms_book_w', './layouts/admin/'.$img[c_admin_skin].'/sms_book_w.tpl');
$tpl->define('sms_book_search', './layouts/admin/'.$img[c_admin_skin].'/sms_book_search.tpl');
$tpl->define('setting1', './layouts/admin/'.$img[c_admin_skin].'/setting1.tpl');
$tpl->define('setting2', './layouts/admin/'.$img[c_admin_skin].'/setting2.tpl');
$tpl->define('setting3', './layouts/admin/'.$img[c_admin_skin].'/setting3.tpl');
$tpl->define('setting4', './layouts/admin/'.$img[c_admin_skin].'/setting4.tpl');
$tpl->define('management_page', './layouts/admin/'.$img[c_admin_skin].'/management_page.tpl');
$tpl->define('page_form', './layouts/admin/'.$img[c_admin_skin].'/page_form.tpl');
$tpl->define('management_inc', './layouts/admin/'.$img[c_admin_skin].'/management_inc.tpl');
$tpl->define('include_form', './layouts/admin/'.$img[c_admin_skin].'/include_form.tpl');
$tpl->define('sms_manage_ajax', './layouts/admin/'.$img[c_admin_skin].'/sms_manage_ajax.tpl');
$tpl->define('sns', './layouts/admin/'.$img[c_admin_skin].'/sns.tpl');
$tpl->define('plugin_main', './layouts/admin/'.$img[c_admin_skin].'/plugin_main.tpl');
$tpl->define('copyright', './layouts/admin/'.$img[c_admin_skin].'/copyright.tpl');
$tpl->define('latest', './layouts/admin/'.$img[c_admin_skin].'/latest.tpl');
$tpl->define('site_analytics', './layouts/admin/'.$img[c_admin_skin].'/site_analytics.tpl');
$tpl->define('category_list', './layouts/admin/'.$img[c_admin_skin].'/category_list.tpl');
$tpl->define('category_form', './layouts/admin/'.$img[c_admin_skin].'/category_form.tpl');
$tpl->define('exposure_settings', './layouts/admin/'.$img[c_admin_skin].'/exposure_settings.tpl');
$tpl->define('contract_view_pop', './layouts/admin/'.$img[c_admin_skin].'/contract_view_pop.tpl');
$tpl->define('aa', './layouts/admin/'.$img[c_admin_skin].'/aa.tpl');
$tpl->define('member_authority', './layouts/admin/'.$img[c_admin_skin].'/member_authority.tpl');
$tpl->define('faq_list', './layouts/admin/'.$img[c_admin_skin].'/faq_list.tpl');
$tpl->define('faq_view', './layouts/admin/'.$img[c_admin_skin].'/faq_view.tpl');
$tpl->define('inquery_pop', './layouts/admin/'.$img[c_admin_skin].'/inquery_pop.tpl');



/*회계관리*/
$tpl->define('withholding_list', './layouts/admin/'.$img[c_admin_skin].'/withholding_list.tpl');
$tpl->define('sales_results', './layouts/admin/'.$img[c_admin_skin].'/sales_results.tpl');
$tpl->define('loans', './layouts/admin/'.$img[c_admin_skin].'/loans.tpl');
$tpl->define('receiving_treatment', './layouts/admin/'.$img[c_admin_skin].'/receiving_treatment.tpl');
$tpl->define('complete_settlement', './layouts/admin/'.$img[c_admin_skin].'/complete_settlement.tpl');
$tpl->define('investment_payment', './layouts/admin/'.$img[c_admin_skin].'/investment_payment.tpl');
/*회계관리 -  전자결제거래내역추가*/
$tpl->define('payment_deal_list', './layouts/admin/'.$img[c_admin_skin].'/payment_deal_list.tpl');

/*관리자연동(유지보수)*/
$tpl->define('conservatism', './layouts/admin/'.$img[c_admin_skin].'/conservatism.tpl');
$tpl->define('conservatism_view', './layouts/admin/'.$img[c_admin_skin].'/conservatism_view.tpl');

/*플랫폼(관리자)게시판 팝업창*/
$tpl->define('board_pop', './layouts/admin/'.$img[c_admin_skin].'/board_pop.tpl');
$tpl->define('board_list_pop', './layouts/admin/'.$img[c_admin_skin].'/board_list_pop.tpl');
$tpl->define('board_pop2', './layouts/admin/'.$img[c_admin_skin].'/board_pop2.tpl');
$tpl->define('board_list_pop2', './layouts/admin/'.$img[c_admin_skin].'/board_list_pop2.tpl');

/*2017-09-19 추가 고객지원센터 */
$tpl->define('client_new', './layouts/admin/'.$img[c_admin_skin].'/client_new.tpl');
$tpl->define('client_inquire', './layouts/admin/'.$img[c_admin_skin].'/client_inquire.tpl');
$tpl->define('client_inquire_write', './layouts/admin/'.$img[c_admin_skin].'/client_inquire_write.tpl');
$tpl->define('client_inquire_view', './layouts/admin/'.$img[c_admin_skin].'/client_inquire_view.tpl');
$tpl->define('client_revise', './layouts/admin/'.$img[c_admin_skin].'/client_revise.tpl');
$tpl->define('client_revise_view', './layouts/admin/'.$img[c_admin_skin].'/client_revise_view.tpl');
$tpl->define('client_revise_write', './layouts/admin/'.$img[c_admin_skin].'/client_revise_write.tpl');


$tpl->define('advice_list', './layouts/admin/'.$img[c_admin_skin].'/advice_list.tpl');
$tpl->define('advice_view', './layouts/admin/'.$img[c_admin_skin].'/advice_view.tpl');

/*변호사관리*/
$tpl->define('lawyer_list', './layouts/admin/'.$img[c_admin_skin].'/lawyer_list.tpl');
$tpl->define('lawyer_write', './layouts/admin/'.$img[c_admin_skin].'/lawyer_write.tpl');

/*가상계좌관리 페이지(161202동욱)*/
$tpl->define('illusion_acc_list', './layouts/admin/'.$img[c_admin_skin].'/illusion_acc_list.tpl');


/*관리자 상환스케쥴 2017-02-09 박유나)*/
$tpl->define('repay_schedule', './layouts/admin/'.$img[c_admin_skin].'/repay_schedule.tpl');

/*관리자 상환스케쥴등록 2017-02-16 임근호)*/
$tpl->define('repay_schedule_form', './layouts/admin/'.$img[c_admin_skin].'/repay_schedule_form.tpl');


 /*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

/************************************************
mobilepage define INC 설정
************************************************/
$tpl->define(array(
    'header' => './layouts/mobile/'.$img[c_mobile_skin].'/header.tpl',
    'footer' => './layouts/mobile/'.$img[c_mobile_skin].'/footer.tpl',
    's_header' => './layouts/admin/'.$img[c_admin_skin].'/header.tpl',
    's_footer' => './layouts/admin/'.$img[c_admin_skin].'/footer.tpl',
    'left_bar' => './layouts/admin/'.$img[c_admin_skin].'/left_bar.tpl',
    'lnb' => './layouts/admin/'.$img[c_admin_skin].'/lnb.tpl',
    'popup' => './layouts/popup/'.$popup[po_skin].'/popup.tpl',
    'quick_menu' => './layouts/mobile/'.$img[c_mobile_skin].'/quick_menu.tpl',
    'left_menu' => './layouts/mobile/'.$img[c_mobile_skin].'/left_menu.tpl',
    'my_lnb' => './layouts/mobile/'.$img[c_mobile_skin].'/my_lnb.tpl',
    'real_time' => './layouts/mobile/'.$img[c_mobile_skin].'/real_time.tpl',
    'sms_counsel' => './layouts/mobile/'.$img[c_mobile_skin].'/sms_counsel.tpl',
    'main_realtime' => './layouts/mobile/'.$img[c_mobile_skin].'/main_realtime.tpl',
    'invest_comment' => './layouts/mobile/'.$img[c_mobile_skin].'/invest_comment.tpl',
	'view_comment' => './layouts/board/'.$bbs_config[bo_skin].'/view_comment.tpl',

	'admin_real' => './layouts/admin/'.$img[c_admin_skin].'/admin_real.tpl',
	'admin_credit' => './layouts/admin/'.$img[c_admin_skin].'/admin_credit.tpl',
));

}else{

/************************************************
define INC 설정
************************************************/
$tpl->define(array(
    'header' => './layouts/home/'.$img[c_home_skin].'/header.tpl',
    'footer' => './layouts/home/'.$img[c_home_skin].'/footer.tpl',
	'u_header' => './layouts/home/'.$img[c_home_skin].'/u_header.tpl',
    'u_footer' => './layouts/home/'.$img[c_home_skin].'/u_footer.tpl',
    's_header' => './layouts/admin/'.$img[c_admin_skin].'/header.tpl',
    's_footer' => './layouts/admin/'.$img[c_admin_skin].'/footer.tpl',
    'left_bar' => './layouts/admin/'.$img[c_admin_skin].'/left_bar.tpl',
    'lnb' => './layouts/admin/'.$img[c_admin_skin].'/lnb.tpl',
    'popup' => './layouts/popup/'.$popup[po_skin].'/popup.tpl',
    'quick_menu' => './layouts/home/'.$img[c_home_skin].'/quick_menu.tpl',
    'left_menu' => './layouts/home/'.$img[c_home_skin].'/left_menu.tpl',
    'my_lnb' => './layouts/home/'.$img[c_home_skin].'/my_lnb.tpl',
    'real_time' => './layouts/home/'.$img[c_home_skin].'/real_time.tpl',
    'sms_counsel' => './layouts/home/'.$img[c_home_skin].'/sms_counsel.tpl',
    'main_realtime' => './layouts/home/'.$img[c_home_skin].'/main_realtime.tpl',
    'invest_comment' => './layouts/home/'.$img[c_home_skin].'/invest_comment.tpl',
	'header2' => './layouts/home/'.$img[c_home_skin].'/header2.tpl',
	'view_comment' => './layouts/board/'.$bbs_config[bo_skin].'/view_comment.tpl',
	'mypage_header' => './layouts/home/'.$img[c_home_skin].'/mypage_header.tpl',


	'admin_real' => './layouts/admin/'.$img[c_admin_skin].'/admin_real.tpl',
	'admin_credit' => './layouts/admin/'.$img[c_admin_skin].'/admin_credit.tpl',
	'loan_real' => './layouts/home/'.$img[c_home_skin].'/loan_real.tpl',
	'loan_credit' => './layouts/home/'.$img[c_home_skin].'/loan_credit.tpl',
));

}
/************************************************
경로 CONFIG정의
************************************************/
$tpl->assign(array(
/*URL경로*/
    'MARI_HOME_URL'  =>''.MARI_HOME_URL.'',
    'MARI_ADMIN_URL'  =>''.MARI_ADMIN_URL.'',
    'MARI_B_URL'  =>''.MARI_B_URL.'',
    'MARI_CSS_URL'  =>''.MARI_CSS_URL.'',
    'MARI_DATA_URL'  =>''.MARI_DATA_URL.'',
    'MARI_IMG_URL'  =>''.MARI_IMG_URL.'',
    'MARI_INC_URL'  =>''.MARI_INC_URL.'',
    'MARI_JS_URL'  =>''.MARI_JS_URL.'',
    'MARI_SKIN_URL'  =>''.MARI_SKIN_URL.'',
    'MARI_PLUGIN_URL'  =>''.MARI_PLUGIN_URL.'',
    'MARI_CAPTCHA_URL'  =>''.MARI_CAPTCHA_URL.'',
    'MARI_EDITOR_URL'  =>''.MARI_EDITOR_URL.'',
    'MARI_OKNAME_URL'  =>''.MARI_OKNAME_URL.'',
    'MARI_LGDACOM_URL'  =>''.MARI_PLUGIN_URL.'',
    'MARI_SNS_URL'  =>''.MARI_SNS_URL.'',
    'MARI_SYNDI_URL'  =>''.MARI_SYNDI_URL.'',
    'MARI_SQL_URL'  =>''.MARI_SQL_URL.'',
    'MARI_VIEW_URL'  =>''.MARI_VIEW_URL.'',
    'MARI_API_URL'  =>''.MARI_API_URL.'',
/*PATH 는 서버상에서의 절대경로*/
    'MARI_ADMIN_PATH'  =>''.MARI_ADMIN_PATH.'',
    'MARI_BBS_PATH'  =>''.MARI_BBS_PATH.'',
    'MARI_DATA_PATH'  =>''.MARI_DATA_PATH.'',
    'MARI_VAR_PATH'  =>''.MARI_VAR_PATH.'',
    'MARI_LIB_PATH'  =>''.MARI_LIB_PATH.'',
    'MARI_INC_PATH'  =>''.MARI_INC_PATH.'',
    'MARI_PLUGIN_PATH'  =>''.MARI_PLUGIN_PATH.'',
    'MARI_SKIN_PATH'  =>''.MARI_SKIN_PATH.'',
    'MARI_MOBILE_PATH'  =>''.MARI_MOBILE_PATH.'',
    'MARI_SESSION_PATH'  =>''.MARI_SESSION_PATH.'',
    'MARI_CAPTCHA_PATH'  =>''.MARI_CAPTCHA_PATH.'',
    'MARI_EDITOR_PATH'  =>''.MARI_EDITOR_PATH.'',
    'MARI_OKNAME_PATH'  =>''.MARI_OKNAME_PATH.'',
    'MARI_LGDACOM_PATH'  =>''.MARI_LGDACOM_PATH.'',
    'MARI_SNS_PATH'  =>''.MARI_SNS_PATH.'',
    'MARI_SYNDI_PATH'  =>''.MARI_SYNDI_PATH.'',
    'MARI_PHPMAILER_PATH'  =>''.MARI_PHPMAILER_PATH.'',
    'MARI_SQL_PATH'  =>''.MARI_SQL_PATH.'',
    'MARI_VIEW_PATH'  =>''.MARI_VIEW_PATH.'',
    'MARI_API_PATH'  =>''.MARI_API_PATH.'',
    'MARI_HOMESKIN_PATH'  =>''.MARI_HOMESKIN_PATH.'',
/*PATH 는 서버상에서USER스킨의 절대경로*/
    'PATH_IMAGE'  =>''.PATH_IMAGE.'',
    'MARI_LAYOUTS_PATH'  =>''.MARI_LAYOUTS_PATH.'',
    'MARI_LAYOUTS_URL'  =>''.MARI_LAYOUTS_URL.'',
    'MARI_ADMINSKIN_URL'  =>''.MARI_ADMINSKIN_URL.'',
    'MARI_HOMESKIN_URL'  =>''.MARI_HOMESKIN_URL.'',
	'MARI_MOBILESKIN_URL'  =>''.MARI_MOBILESKIN_URL.'',
    'MARI_MEMBERSKIN_URL'  =>''.MARI_MEMBERSKIN_URL.'',
    'MARI_LOGINSKIN_URL'  =>''.MARI_LOGINSKIN_URL.'',
    'MARI_MAILSKIN_URL'  =>''.MARI_MAILSKIN_URL.'',
    'MARI_PLUGIN_URL'  =>''.MARI_PLUGIN_URL.'',
    'MARI_POPUPSKIN_URL'  =>''.MARI_POPUPSKIN_URL.'',
    'MARI_LATESTSKIN_URL'  =>''.MARI_LATESTSKIN_URL.'',
    'MARI_PLUGIN_URL'  =>''.MARI_PLUGIN_URL.'',
    'PATH_JS'  =>''.PATH_JS.'',
    'PATH_CSS'  =>''.PATH_CSS.''
));



/*상단index 레이아웃 템플릿*/
?>
