<?php
//if ( $_SERVER['REMOTE_ADDR'] !='128.134.106.210' && $_SERVER['REMOTE_ADDR'] !='66.249.82.116' && $_GET['freepass']!='true' ){	exit;}
include_once('./header.php');
include_once('./_Common_execute_class.php');
define("DEFAULT_URL","http://www.kfunding.co.kr");
/*각 레이아웃 템플릿 print, fetch, include, new, define, setCache  loader*/

/************************************************
USER template
***********
*************************************/
/*
	case "product":
	$loop = array();
	for ($i=0;  $row=sql_fetch_array($product); $i++) {
		$loop[] = array(             // or
			'g_name'=>$row[$i],
			'g_content'=>$row[$i],
		);
	}
		$tpl->assign('row', $loop);
		$tpl->print_('index');
	break;
*/

$tpl->define('new_header', './layouts/home/'.$img[c_home_skin].'/new_header.tpl');
$tpl->define('new_footer', './layouts/home/'.$img[c_home_skin].'/new_footer.tpl');
$tpl->define('new_side', './layouts/home/'.$img[c_home_skin].'/new_side.tpl');


if($mode){
switch ($mode){


	case "mypage_modify":
		$tpl->define('new_mypage_modify', './layouts/home/'.$img[c_home_skin].'/new_mypage_modify.tpl');
		$tpl->print_('new_mypage_modify');
	break;
case "safetyguide":
	$tpl->define('new_safetyguide', './layouts/home/'.$img[c_home_skin].'/new_safetyguide.tpl');
	$tpl->print_('new_safetyguide');
break;
case "safetyguide2":
	$tpl->define('new_safetyguide2', './layouts/home/'.$img[c_home_skin].'/new_safetyguide2.tpl');
	$tpl->print_('new_safetyguide2');
break;
case "find":
	$tpl->define('new_findme', './layouts/home/'.$img[c_home_skin].'/new_findme.tpl');
	$tpl->print_('new_findme');
break;

	/*이벤트 템플릿 스킨 2016-12-01 시작*/


	case "main":
		//$tpl->print_('index');
		$tpl->define('new_home', './layouts/home/'.$img[c_home_skin].'/new_main.tpl');
		$tpl->print_('new_home');
	break;
	case "newheader":
		$tpl->define('newheader', './layouts/home/'.$img[c_home_skin].'/new_header.tpl');
		$tpl->print_('newheader');
	break;
	case "newfoot":
	//	$tpl->define('newheader', './layouts/home/'.$img[c_home_skin].'/new_header.tpl');
		$tpl->print_('./layouts/home/'.$img[c_home_skin].'/new_header.tpl');
	break;
	case "newside":
		//$tpl->define('new_side', './layouts/home/'.$img[c_home_skin].'/new_side.tpl');
		$tpl->print_('./layouts/home/'.$img[c_home_skin].'/new_side.tpl');
	break;
	case "joinloan":
  	$tpl->define('new_joinloan', './layouts/home/'.$img[c_home_skin].'/new_joinloan.tpl');
		$tpl->print_('new_joinloan');
	break;
	case "land1":
	case "land2":
	case "land3":
	case "land4":
	case "land5":
		$tpl->print_('index');
	break;
	case "companyintro01":
		$tpl->define('new_companyintro01', './layouts/home/'.$img[c_home_skin].'/new_companyintro01.tpl');
		$tpl->print_('new_companyintro01');
		 //$tpl->print_('companyintro01');
	 break;
	 case "mypageinfo":
 	$tpl->define('new_mypage', './layouts/home/'.$img[c_home_skin].'/new_mypage.tpl');
 	$tpl->print_('new_mypage');
 		//$tpl->print_('mypage');
 	break;
 	case "mypage_certification":
 	$tpl->define('new_mypage_certification', './layouts/home/'.$img[c_home_skin].'/new_mypage_certification.tpl');
 	$tpl->print_('new_mypage_certification');
 		//$tpl->print_('mypage');
 	break;
	case "login":
		$tpl->define('new_login', './layouts/home/'.$img[c_home_skin].'/new_login.tpl');
		$tpl->print_('new_login');
		//$tpl->print_('login');
	break;
	case "event":
		//투자오픈전 이벤트
		//$tpl->define('new_invest', './layouts/home/'.$img[c_home_skin].'/new_invest.tpl');
		$tpl->define('new_invest', './layouts/home/'.$img[c_home_skin].'/new_invest_event.tpl');
		$tpl->print_('new_invest');
		#$tpl->print_('invest');
	break;
	case "invest":
		//투자오픈전 이벤트
	  $tpl->define('new_invest', './layouts/home/'.$img[c_home_skin].'/new_invest.tpl');
		//$tpl->define('new_invest', './layouts/home/'.$img[c_home_skin].'/new_invest_event.tpl');
		$tpl->print_('new_invest');
		//$tpl->print_('invest');
	break;
	case "join00":
		$tpl->define('new_join0', './layouts/member/basic/new_join0.tpl');
		$tpl->print_('new_join0');
		//$tpl->print_('join0');
	break;

	case "join01":
	$tpl->define('new_join1', './layouts/member/basic/new_join1.tpl');
	$tpl->print_('new_join1');
		//$tpl->print_('join1');
	break;
	case "join02":
	$tpl->define('new_join02', './layouts/member/basic/new_join02.tpl');
	$tpl->print_('new_join02');
		//$tpl->print_('join1');
	break;
	case "join03":
		$tpl->define('new_join03', './layouts/member/basic/new_join03.tpl');
		$tpl->print_('new_join03');
		//$tpl->print_('join3');
	break;
	case "join03_enterprise":
		$tpl->define('new_join03_enterprise', './layouts/member/basic/new_join03_enterprise.tpl');
		$tpl->print_('new_join03_enterprise');
		//$tpl->print_('join3');
	break;
	case "join04":
		$tpl->define('new_join04', './layouts/member/basic/new_join04.tpl');
		$tpl->print_('new_join04');
		//$tpl->print_('join3');
	break;
	case "invest_view":
	  $tpl->define('new_invest_view', './layouts/home/'.$img[c_home_skin].'/new_invest_view.tpl');
		$tpl->print_('new_invest_view');
		//$tpl->print_('invest_view');
	break;
	case "invest2":
$tpl->define('new_invest2', './layouts/home/'.$img[c_home_skin].'/new_invest2.tpl');
$tpl->print_('new_invest2');
	//$tpl->print_('invest2');
break;
case "calculation":
$tpl->define('new_calculation', './layouts/home/'.$img[c_home_skin].'/new_calculation.tpl');
$tpl->print_('new_calculation');
	//$tpl->print_('calculation');
break;
case "guide":
 //$tpl->print_('./layouts/home/'.$img[c_home_skin].'/new_guide.tpl');
 $tpl->define('new_guide', './layouts/home/'.$img[c_home_skin].'/new_guide.tpl');
 $tpl->print_('new_guide');
	//$tpl->print_('guide');
break;
case "mypage_invest_info":
	//$tpl->print_('mypage_invest_info');
	$tpl->define('new_mypage_invest_info', './layouts/home/'.$img[c_home_skin].'/new_mypage_invest_info.tpl');
	$tpl->print_('new_mypage_invest_info');
break;
case "mypage_tenderstatus":
	$tpl->define('new_mypage_tenderstatus', './layouts/home/'.$img[c_home_skin].'/new_mypage_tenderstatus.tpl');
	$tpl->print_('new_mypage_tenderstatus');
	//$tpl->print_('mypage_tenderstatus');
break;

case "mypage_investment":
$tpl->define('new_mypage_investment', './layouts/home/'.$img[c_home_skin].'/new_mypage_investment.tpl');
$tpl->print_('new_mypage_investment');
	//$tpl->print_('mypage_investment');
break;
case "mypage_confirm_center":
	$tpl->define('new_mypage_confirm_center', './layouts/home/'.$img[c_home_skin].'/new_mypage_confirm_center.tpl');
	$tpl->print_('new_mypage_confirm_center');
	//$tpl->print_('mypage_confirm_center');
break;
case "mypage_calculate_schedule":

	$tpl->define('new_mypage_calculate_schedule', './layouts/home/'.$img[c_home_skin].'/new_mypage_calculate_schedule.tpl');
	$tpl->print_('new_mypage_calculate_schedule');
	//$tpl->print_('mypage_calculate_schedule');
break;
case "mypage_loan_manage":
	$tpl->define('new_mypage_loan_manage', './layouts/home/'.$img[c_home_skin].'/new_mypage_loan_manage.tpl');
	$tpl->print_('new_mypage_loan_manage');
	//$tpl->print_('mypage_loan_manage');
break;
case "mypage_loan_schedule_more":
$tpl->define('new_mypage_loan_schedule_more', './layouts/home/'.$img[c_home_skin].'/new_mypage_loan_schedule_more.tpl');
$tpl->print_('new_mypage_loan_schedule_more');
	//$tpl->print_('mypage_loan_schedule_more');
break;



   case "pho":
		$tpl->print_('pho');
	break;

     case "test":
		$tpl->print_('test');
	break;

	case "skin1_header":
		$tpl->print_('skin1_header');
	break;

	case "skin1_header_sub":
		$tpl->print_('skin1_header_sub');
	break;

	case "skin1_footer":
		$tpl->print_('skin1_footer');
	break;

	case "invest_view_new":
		$tpl->print_('invest_view_new');
	break;

	case "company_intro":
		$tpl->print_('company_intro');
	break;

	case "invest_new":
		$tpl->print_('invest_new');
	break;

	/*
	case "skin1_invest_view":
		$tpl->print_('skin1_invest_view');
	break;

	case "skin1_invest":
		$tpl->print_('skin1_invest');
	break;

	case "skin1_loan":
		$tpl->print_('skin1_loan');
	break;
	*/

	/*2018-02-12 파스타 셋팅 전*/
	case "a_pastafter":
		$tpl->print_('a_pastafter');
	break;
	/*2018-04-02 uioex*/
	case "uioex_main":
		$tpl->print_('uioex_main');
	break;
	case "uioex_footer":
		$tpl->print_('uioex_footer');
	break;
	case "uioex_header":
		$tpl->print_('uioex_header');
	break;
	/*uioex_end*/

	case "test01":
		$tpl->print_('test01');
	break;



	case "skin1_guide_invest":
		$tpl->print_('skin1_guide_invest');
	break;

	case "skin1_guide_content":
		$tpl->print_('skin1_guide_content');
	break;

	case "skin1_mypage":
		$tpl->print_('skin1_mypage');
	break;

	/*이벤트 템플릿 스킨 끝*/


	case "login_form":
		$tpl->print_('login');
	break;


	case "password":
		$tpl->print_('password');
	break;

	case "point_pay":
		$tpl->print_('point_pay');
	break;

	case "product_details":
		$tpl->print_('product_details');
	break;

	case "product_list":
		$tpl->print_('product_list');
	break;

	case "register_set01":
		$tpl->print_('register_set01');
	break;

	case "register_set02":
		$tpl->print_('register_set02');
	break;

	case "register_set03":
		$tpl->print_('register_set03');
	break;

	case "register_set04":
		$tpl->print_('register_set04');
	break;

	case "secession":
		$tpl->print_('secession');
	break;

	case "withdrawal_Request":
		$tpl->print_('withdrawal_Request');
	break;


	case "loan":
		$tpl->print_('loan');
	break;

	case "loan_real":
		$tpl->print_('loan_real');
	break;

	case "loan_credit":
		$tpl->print_('loan_credit');
	break;

	case "loan_business":
		$tpl->print_('loan_business');
	break;

	case "join0":
//		$tpl->print_('join0');
//	break;

	case "join1":
	//	$tpl->print_('join1');
	//break;

	case "join2":
		//$tpl->print_('join2');
///	break;

	case "join3":
	//	$tpl->print_('join3');
//	break;

	case "join4":
	//	$tpl->print_('join4');
	//break;
		//case "join3_enterprise":
		//$tpl->print_('join3_enterprise');
	break;

	case "join_auth":
		$tpl->print_('join_auth');
	break;

	case "member_modify":
		$tpl->print_('join3');
	break;

	case "personal_info_pw":
		$tpl->print_('personal_info_pw');
	break;

	case "info_modify":
		$tpl->print_('info_modify');
	break;

	case "change_pw":
		$tpl->print_('change_pw');
	break;

	case "leave":
		$tpl->print_('leave');
	break;

	case "charge":
		$tpl->print_('charge');
	break;

	case "charge":
		$tpl->print_('charge');
	break;

	case "withdrawl":
		$tpl->print_('withdrawl');
	break;

	case "mypage_loan":
		$tpl->print_('mypage_loan');
	break;

	case "mypage_invest":
		$tpl->print_('mypage_invest');
	break;



	case "invest_proce":
		$tpl->print_('invest_proce');
	break;

	case "invest_complete":
		$tpl->print_('invest_complete');
	break;

	case "common1":
		$tpl->print_('common1');
	break;

	case "common2":
		$tpl->print_('common2');
	break;

	case "common3":
		$tpl->print_('common3');
	break;

	case "common4":
		$tpl->print_('common4');
	break;



	case "company":
		$tpl->print_('company');
	break;

	case "product":
		$tpl->print_('product');
	break;

	case "loan_info":
		$tpl->print_('loan_info');
	break;

	case "invest_notice":
		$tpl->print_('invest_notice');
	break;

	case "faq":
		$tpl->print_('faq');
	break;

	case "contract":
		$tpl->print_('contract');
	break;

	case "contract_login":
		$tpl->print_('contract_login');
	break;

	case "contract_upload":
		$tpl->print_('contract_upload');
	break;

	case "customer":
		$tpl->print_('customer');
	break;

	case "my_pg":
		$tpl->print_('my_pg');
	break;

	case "emoney":
		$tpl->print_('emoney');
	break;

	case "company_info":
		$tpl->print_('company_info');
	break;

	case "withholding_list2":
		$tpl->print_('withholding_list2');
	break;

	case "withholding_list_more":
		$tpl->print_('withholding_list_more');
	break;

	case "pw_find":
		$tpl->print_('pw_find');
	break;

	case "loan2":
		$tpl->print_('loan2');
	break;

	case "company_intro":
		$tpl->print_('company_intro');
	break;


	case "loan_realestate":
		$tpl->print_('loan_realestate');
	break;

	case "loan_credit":
		$tpl->print_('loan_credit');
	break;

	case "mypage_loan_info_realestate":
		$tpl->print_('mypage_loan_info_realestate');
	break;
	case "mypage_invest_info_realestate":
		$tpl->print_('mypage_invest_info_realestate');
	break;
	case "mypage_loan_info_credit":
		$tpl->print_('mypage_loan_info_credit');
	break;
	case "mypage_invest_info_credit":
		$tpl->print_('mypage_invest_info_credit');
	break;

	case "header_sub":
		$tpl->print_('header_sub');
	break;

	case "test":
		$tpl->print_('test');
	break;

	case "invest_calculation":
		$tpl->print_('invest_calculation');
	break;

	case "qna":
		$tpl->print_('qna');
	break;

	case "protection_plan":
		$tpl->print_('protection_plan');
	break;

	case "interview_list":
		$tpl->print_('interview_list');
	break;

	case "interview_view":
		$tpl->print_('interview_view');
	break;
   /*임지선 신용 투자 페이지 생성 2017-04-04*/
   	case "invest_credit":
		$tpl->print_('invest_credit');
	break;
 /*임지선 대출하기 페이지 생성 2017-04-05*/
   	case "loan_real":
		$tpl->print_('loan_real');
	break;
	 	case "loan_credit":
		$tpl->print_('loan_credit');
	break;
	 	case "loan_business":
		$tpl->print_('loan_business');
	break;
	 	case "loan_realestate":
		$tpl->print_('loan_realestate');
	break;

	case "loan_credit02":
		$tpl->print_('loan_credit02');
	break;
 /*임지선 대출하기(모바일)페이지 생성 2017-04-10*/
  case "loan_credit":
		$tpl->print_('loan_credit');
	break;

/*임지선 대출하기(모바일)페이지 생성 2017-04-10*/
  case "loan2":
		$tpl->print_('loan2');
	break;



	/*pay24*/
	case "index_header":
		$tpl->print_('index_header');
	break;

	case "sub_header":
		$tpl->print_('sub_header');
	break;

	case "footer":
		$tpl->print_('footer');
	break;

	case "invest_info":
		$tpl->print_('invest_info');
	break;

	case "invest_info_detail":
		$tpl->print_('invest_info_detail');
	break;

	case "investment":
		$tpl->print_('investment');
	break;

/*	case "loan_step1":
		$tpl->print_('loan_step1');
	break;

	case "loan_step2":
		$tpl->print_('loan_step2');
	break;

	case "loan_step3":
		$tpl->print_('loan_step3');
	break;

	case "loan_step4":
		$tpl->print_('loan_step4');
	break;
*/
	case "mypage_loan_info":
		$tpl->print_('mypage_loan_info');
	break;

	case "join_step1":
		$tpl->print_('join_step1');
	break;

	case "join_step2":
		$tpl->print_('join_step2');
	break;

	case "join_step3":
		$tpl->print_('join_step3');
	break;

	case "join_step4":
		$tpl->print_('join_step4');
	break;

	case "pay24_login":
		$tpl->print_('pay24_login');
	break;

	case "customer_center":
		$tpl->print_('customer_center');
	break;

	case "notice":
		$tpl->print_('notice');
	break;

	case "faq":
		$tpl->print_('faq');
	break;

	case "notice_view":
		$tpl->print_('notice_view');
	break;

	case "pw_find":
		$tpl->print_('pw_find');
	break;

	case "mypage_emoney":
		$tpl->print_('mypage_emoney');
	break;

	case "mypage_charge":
		$tpl->print_('mypage_charge');
	break;

	case "mypage_withdrawal":
		$tpl->print_('mypage_withdrawal');
	break;

	case "policy":
		$tpl->print_('policy');
	break;

	case "service":
		$tpl->print_('service');
	break;

	case "mypage_basic":
		$tpl->print_('mypage_basic');
	break;

	case "mypage_pwchange":
		$tpl->print_('mypage_pwchange');
	break;

	case "mypage_out":
		$tpl->print_('mypage_out');
	break;

	case "mypage_interest_invest":
		$tpl->print_('mypage_interest_invest');
	break;

	case "mypage_loanstatus":
		$tpl->print_('mypage_loanstatus');
	break;

	case "mypage_depositstatus":
		$tpl->print_('mypage_depositstatus');
	break;

	case "payment_check":
		$tpl->print_('payment_check');
	break;

	case "invest_income":
		$tpl->print_('invest_income');
	break;

	case "investment_done":
		$tpl->print_('investment_done');
	break;

	case "required_reading":
		$tpl->print_('required_reading');
	break;

	case "mypage_withholding_list":
		$tpl->print_('mypage_withholding_list');
	break;

	case "capital_protected":
		$tpl->print_('capital_protected');
	break;

	case "mypage_contract":
		$tpl->print_('mypage_contract');
	break;

	case "contract_login":
		$tpl->print_('contract_login');
	break;
		case "invest_calculation":
			$tpl->print_('invest_calculation');
		break;

		case "guide1":
			$tpl->print_('guide1');
		break;

		case "loan_application":
			$tpl->print_('loan_application');
		break;

		case "loan_application2":
			$tpl->print_('loan_application2');
		break;

		case "dash_mypage":
			$tpl->print_('dash_mypage');
		break;

		case "introduce":
			$tpl->print_('introduce');
		break;
		/**2017-07-14 권리증서 추가**/
		case "invest_receipt":
			$tpl->print_('invest_receipt');
		break;

		case "guide_content":
			$tpl->print_('guide_content');
		break;
		case "guide_invest":
			$tpl->print_('guide_invest');
		break;

		case "guide_loan":
			$tpl->print_('guide_loan');
		break;

		case "invest_json":
			$tpl->print_('invest_json');
		break;

		case "safeon":
			$tpl->print_('safeon');
		break;

/*▽마이페이지 개편을 위한 추가 페이지 생성 2016-10-10 박유나▽*/
		case "mypage_my_info":
			$tpl->print_('mypage_my_info');
		break;

		case "mypage_balance":
			$tpl->print_('mypage_balance');
		break;
		case "mypage_alert":
			$tpl->print_('mypage_alert');
		break;
		case "mypage_schedule":
			$tpl->print_('mypage_schedule');
		break;

		case "mypage_loan_schedule":
			$tpl->print_('mypage_loan_schedule');
		break;


/*마이페이지 자동투자 관련 페이지 2017-02-02 이지은*/
		case "mypage_auto_invest":
			$tpl->print_('mypage_auto_invest');
		break;

		case "mypage_auto_invest_set":
			$tpl->print_('mypage_auto_invest_set');
		break;

		case "mypage_auto_invest_list":
			$tpl->print_('mypage_auto_invest_list');
		break;

		case "mypage_auto_invest_apply":
			$tpl->print_('mypage_auto_invest_apply');
		break;

		case "mypage_portfolio_pop":
			$tpl->print_('mypage_portfolio_pop');
		break;

		case "mypage_auto_invest_info_pop":
			$tpl->print_('mypage_auto_invest_info_pop');
		break;

		case "mypage_auto_invest_list_pop":
			$tpl->print_('mypage_auto_invest_list_pop');
		break;

		case "mypage_auto_invest_apply_all":
			$tpl->print_('mypage_auto_invest_apply_all');
		break;

		case "mypage_auto_invest_tender":
			$tpl->print_('mypage_auto_invest_tender');
		break;

		case "mypage_auto_invest_adjust":
			$tpl->print_('mypage_auto_invest_adjust');
		break;

		/*▽포트폴리오투자 2017-02-13 박유나▽*/
		case "portfolio_list":
			$tpl->print_('portfolio_list');
		break;

		case "portfolio_view":
			$tpl->print_('portfolio_view');
		break;


		case "callback":
		break;

/************************************************
USER게시판 (공통)
************************************************/

	case "bbs_list":
		$tpl->print_('bbs_list');
	break;
	case "bbs_view":
		$tpl->print_('bbs_view');
	break;
	case "bbs_write":
		$tpl->print_('bbs_write');
	break;
	case "bbs_comment":
		$tpl->print_('bbs_comment');
	break;

	case "view_list":
		$tpl->print_('view_list');
	break;

/************************************************
user 사용 페이지
************************************************/
	case "content":
		for ($i=0;  $pview=sql_fetch_array($pageexe_tpl); $i++){
			if($pg=="$pview[p_id]"){
					$tpl->print_(''.$pview[p_id].'');
			}
		}
	break;
/************************************************
error page
************************************************/

	default:
		$tpl->print_('error');
    break;
}
}

/************************************************
ADMIN template
************************************************/
if($cms){
switch ($cms){

	case "cs_bbs_list":
		$tpl->print_('cs_bbs_list');
	break;

	case "cs_bbs_view":
		$tpl->print_('cs_bbs_view');
	break;

	case "cs_bbs_write":
		$tpl->print_('cs_bbs_write');
	break;

	case "cs_bbs_comment":
		$tpl->print_('cs_bbs_comment');
	break;

	/*2017-09-19 추가 장경진*/
		case "client_new":
			$tpl->print_('client_new');
		break;
		case "client_inquire":
			$tpl->print_('client_inquire');
		break;
		case "client_inquire_write":
			$tpl->print_('client_inquire_write');
		break;
		case "client_inquire_view":
			$tpl->print_('client_inquire_view');
		break;
		case "client_revise":
			$tpl->print_('client_revise');
		break;
		case "client_revise_view":
			$tpl->print_('client_revise_view');
		break;
		case "client_revise_write":
			$tpl->print_('client_revise_write');
		break;



	case "admin":
		$tpl->print_('admin');
	break;

	case "analytics":
		$tpl->print_('analytics');
	break;

	case "board_list":
		$tpl->print_('board_list');
	break;

	case "board_form":
		$tpl->print_('board_form');
	break;

	case "boardgroup_form":
		$tpl->print_('boardgroup_form');
	break;

	case "boardgroup_list":
		$tpl->print_('boardgroup_list');
	break;

	case "charge_list":
		$tpl->print_('charge_list');
	break;

	case "config_form":
		$tpl->print_('config_form');
	break;

	case "favicon":
		$tpl->print_('favicon');
	break;


	case "invest_list":
		$tpl->print_('invest_list');
	break;

	case "invest_pay_setup":
		$tpl->print_('invest_pay_setup');
	break;

	case "invest_setup_form":
		$tpl->print_('invest_setup_form');
	break;

	case "invest_setup_list":
		$tpl->print_('invest_setup_list');
	break;

	case "loan_form":
		$tpl->print_('loan_form');
	break;

	case "loan_list":
		$tpl->print_('loan_list');
	break;

	case "loan_list2":
		$tpl->print_('loan_list2');
	break;

	case "loan_main":
		$tpl->print_('loan_main');
	break;

	case "mail_list":
		$tpl->print_('mail_list');
	break;

	case "member_form":
		$tpl->print_('member_form');
	break;

	case "member_grade":
		$tpl->print_('member_grade');
	break;

	case "member_list":
		$tpl->print_('member_list');
	break;

	case "member_main":
		$tpl->print_('member_main');
	break;

	case "mail_form":
		$tpl->print_('mail_form');
	break;

	case "pay_list":
		$tpl->print_('pay_list');
	break;

	case "page_security":
		$tpl->print_('page_security');
	break;


	case "withdrawal_list":
		$tpl->print_('withdrawal_list');
	break;

	case "sales_report":
		$tpl->print_('sales_report');
	break;

	case "seo_config":
		$tpl->print_('seo_config');
	break;

	case "service_config":
		$tpl->print_('service_config');
	break;

	case "popuplist":
		$tpl->print_('popuplist');
	break;

	case "product_add_pop":
		$tpl->print_('product_add_pop');
	break;

	case "newpopup":
		$tpl->print_('newpopup');
	break;

	case "emoney_list":
		$tpl->print_('emoney_list');
	break;

	case "sendmail_test":
		$tpl->print_('sendmail_test');
	break;

	case "reservation_send":
		$tpl->print_('reservation_send');
	break;

	case "user_board_list":
		$tpl->print_('user_board_list');
	break;

	case "user_board_form":
		$tpl->print_('user_board_form');
	break;

	case "leave_list":
		$tpl->print_('leave_list');
	break;

	case "admin_login":
		$tpl->print_('admin_login');
	break;

	case "filemanager":
		$tpl->print_('filemanager');
	break;

	case "ftp_client":
		$tpl->print_('ftp_client');
	break;

	case "member_main":
		$tpl->print_('member_main');
	break;

	case "board_main":
		$tpl->print_('board_main');
	break;

	case "popup_main":
		$tpl->print_('popup_main');
	break;

	case "loan_main":
		$tpl->print_('loan_main');
	break;

	case "invest_main":
		$tpl->print_('invest_main');
	break;

	case "design_main":
		$tpl->print_('design_main');
	break;

	case "sms_main":
		$tpl->print_('sms_main');
	break;

	case "setting_main":
		$tpl->print_('setting_main');
	break;

	case "sms_setup":
		$tpl->print_('sms_setup');
	break;

	case "sms_manage":
		$tpl->print_('sms_manage');
	break;

	case "lms_manage":
		$tpl->print_('lms_manage');
	break;

	case "sms_charge":
		$tpl->print_('sms_charge');
	break;

	case "sms_group":
		$tpl->print_('sms_group');
	break;

	case "sms_book":
		$tpl->print_('sms_book');
	break;

	case "sms_book_w":
		$tpl->print_('sms_book_w');
	break;

	case "sms_book_search":
		$tpl->print_('sms_book_search');
	break;

	case "setting1":
		$tpl->print_('setting1');
	break;

	case "setting2":
		$tpl->print_('setting2');
	break;

	case "setting3":
		$tpl->print_('setting3');
	break;

	case "setting4":
		$tpl->print_('setting4');
	break;

	case "management_page":
		$tpl->print_('management_page');
	break;

	case "page_form":
		$tpl->print_('page_form');
	break;

	case "management_inc":
		$tpl->print_('management_inc');
	break;

	case "include_form":
		$tpl->print_('include_form');
	break;

	case "sms_manage_ajax":
		$tpl->print_('sms_manage_ajax');
	break;

	case "sns":
		$tpl->print_('sns');
	break;

	case "plugin_main":
		$tpl->print_('plugin_main');
	break;

	case "copyright":
		$tpl->print_('copyright');
	break;

	case "latest":
		$tpl->print_('latest');
	break;

	case "site_analytics":
		$tpl->print_('site_analytics');
	break;

	case "category_list":
		$tpl->print_('category_list');
	break;

	case "category_form":
		$tpl->print_('category_form');
	break;

	case "exposure_settings":
		$tpl->print_('exposure_settings');
	break;

	case "contract_view_pop":
		$tpl->print_('contract_view_pop');
	break;

	case "aa":
		$tpl->print_('aa');
	break;

	case "member_authority":
		$tpl->print_('member_authority');
	break;

	case "faq_list":
		$tpl->print_('faq_list');
	break;

	case "faq_view":
		$tpl->print_('faq_view');
	break;

	case "inquery_pop":
		$tpl->print_('inquery_pop');
	break;

	/*회계관리*/

	case "withholding_list":
		$tpl->print_('withholding_list');
	break;

	case "sales_results":
		$tpl->print_('sales_results');
	break;

	case "loans":
		$tpl->print_('loans');
	break;

	case "receiving_treatment":
		$tpl->print_('receiving_treatment');
	break;

	case "complete_settlement":
		$tpl->print_('complete_settlement');
	break;

	case "investment_payment":
		$tpl->print_('investment_payment');
	break;

	case "payment_deal_list":
		$tpl->print_('payment_deal_list');
	break;

	/*관리자연동(유지보수)*/
	case "conservatism":
		$tpl->print_('conservatism');
	break;

	case "conservatism_view":
		$tpl->print_('conservatism_view');
	break;

	/*관리자게시판 팝업창*/
	case "board_pop":
		$tpl->print_('board_pop');
	break;

	case "board_list_pop":
		$tpl->print_('board_list_pop');
	break;

	case "board_pop2":
		$tpl->print_('board_pop2');
	break;

	case "board_list_pop2":
		$tpl->print_('board_list_pop2');
	break;

	case "advice_list":
		$tpl->print_('advice_list');
	break;

	case "advice_view":
		$tpl->print_('advice_view');
	break;

	case "lawyer_list":
		$tpl->print_('lawyer_list');
	break;

	case "lawyer_write":
		$tpl->print_('lawyer_write');
	break;

	//가상계좌관리페이지 (161202동욱)
	case "illusion_acc_list":
		$tpl->print_('illusion_acc_list');
	break;

	/*관리자 상환스케쥴 2017-02-09 박유나)*/
	case "repay_schedule":
		$tpl->print_('repay_schedule');
	break;

	/*관리자 상환스케쥴등록 2017-02-16 임근호)*/
	case "repay_schedule_form":
		$tpl->print_('repay_schedule_form');
	break;

/************************************************
error page
************************************************/
	default:
		$tpl->print_('error');
    break;
}
}
include_once('./footer.php');
?>
