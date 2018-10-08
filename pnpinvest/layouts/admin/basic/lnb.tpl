<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<div class="lnb">
				<?php
					$sql = "select * from mari_authority where m_id = '$user[m_id]'";
					$au = sql_fetch($sql, false);
					if($au[au_member]=='1'){
				?>
				<div class="lnb_mn lnb_menu02"><a href="#">회원관리</a></div>
				<?php if($cms=="member_list" || $cms=="illusion_acc_list" || $cms=="member_grade" || $cms=="leave_list" || $cms=="emoney_list" || $cms=="mail_list" || $cms=="sendmail_test" || $cms=="mail_list_form" || $cms=="member_grade_form" || $cms=="member_form" || $cms=="site_analytics" || $cms=="member_authority"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=member_list">회원목록</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=illusion_acc_list">가상계좌관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=member_grade">회원등급</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=leave_list">탈퇴회원&복구</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=emoney_list">e-머니관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time">로그분석</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=member_authority">회원권한관리</a></li>
				</ul>
				<?php }?>
				<?php if($au[au_board]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu03"><a href="#">게시판관리</a></div>
				<?php if($cms=="board_list" || $cms=="boardgroup_list" || $cms=="boardgroup_form" || $cms=="board_form" || !$table==""){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li class="fb"><a href="{MARI_HOME_URL}/?cms=board_list">게시판관리</a></li>
					<li class="fb"><a href="{MARI_HOME_URL}/?cms=boardgroup_list">게시판그룹관리</a></li>
					<li class="fb"><a href="{MARI_HOME_URL}/?cms=faq_list">FAQ</a></li>
				<?php
				for ($i=0;  $row=sql_fetch_array($bo_view ); $i++){
				?>
					<li><a href="{MARI_HOME_URL}/?cms=user_board_list&table=<?php echo $row['bo_table'];?>&subject=<?php echo $row['bo_subject'];?>"><?php echo $row['bo_subject'];?></a></li>

				<?php }?>
				</ul>
				<?php }?>
				<div class="lnb_mn lnb_menu04"><a href="#">플러그인/위젯</a></div>
				<?php if($cms=="analytics" || $cms=="sns" || $cms=="latest"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=sns">소셜네트워크 (SNS)</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=analytics">네이버 애널리틱스</a></li>
					<!--
					<li><a href="#">네이버 신디케이션</a></li>
					<li><a href="#">네이버 블로그</a></li>
					-->
				</ul>
				<?php if($au[au_popup]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu05"><a href="#">팝업관리</a></div>
				<?php if($cms=="popuplist" || $cms=="newpopup"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=popuplist">팝업관리</a></li>
				</ul>
				<?php }?>
				<?php if($au[au_loan]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu06"><a href="#">대출관리</a></div>
				<?php if($cms=="loan_list" || $cms=="invest_setup_list" || $cms=="loan_form" || $cms=="invest_setup_form"|| $cms=="loan_list2" || $cms=="lawyer_list" || $cms=="lawyer_write"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=loan_list">대출현황</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=invest_setup_list">투자진행 설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=lawyer_list">심사원</a></li>
					<li><a href="/api/admext/loanappliction" target='_blank'>신청리스트</a></li>
				</ul>
				<?php } if($au[au_invest]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu06"><a href="#">투자관리</a></div>
				<?php if($cms=="invest_list" || $cms=="invest_form" || $cms=="pay_list" || $cms=="invest_pay_setup" || $cms=="withdrawal_list" || $cms=="charge_list" || $cms=="sales_report" || $cms=="repay_schedule_form" || $cms=="repay_schedule"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=invest_list">투자현황</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=pay_list">결제관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=invest_pay_setup">투자/결제 설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=withdrawal_list">출금신청</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=charge_list">충전내역</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=sales_report">매출리포트</a></li>
					<div class="lnb_mn lnb_menu01"><a href="javascript:;" onClick='investcheck()' >투자체크</a></div>
				</ul>
				<?php } if($au[au_sales]=='1'){ ?>
				<div class="lnb_mn lnb_menu06"><a href="#">회계관리</a></div>
				<?php if($cms=="sales_results" || $cms=="loans" || $cms=="receiving_treatment" || $cms=="complete_settlement" || $cms=="investment_payment" || $cms=="withholding_list"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=payment_deal_list">전자결제거래내역</a></li>
				</ul>
				<?php }?>
				<?php if($au[au_design]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu05"><a href="#">디자인관리</a></div>
				<?php if($cms=="seo_config" || $cms=="page_security" || $cms=="favicon" || $cms=="filemanager" || $cms=="page_form" || $cms=="management_page" || $cms=="management_inc" || $cms=="copyright" || $cms=="category_list" || $cms=="category_form" || $cms=="exposure_settings"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=seo_config">SEO설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=page_security">페이지보안설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=favicon">로고/파비콘설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=copyright">하단정보설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=category_list">카테고리설정</a></li>
				</ul>
				<?php }?>
				<div class="lnb_mn lnb_menu04"><a href="#">나의서비스관리</a></div>
				<?php if($cms=="service_config"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=service_config">서비스 정보</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=conservatism">유지보수</a></li>
				</ul>
				<?php if($au[au_sms]=='1' || $user[m_id] == "webmaster@admin.com"){ ?>
				<div class="lnb_mn lnb_menu09"><a href="#">SMS관리</a></div>
				<?php if($cms=="reservation_send" || $cms=="sms_manage" || $cms=="lms_manage" || $cms=="sms_setup" || $cms=="sms_charge" || $cms=="sms_group" || $cms=="sms_book"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
				<li><a href="javascript:;" onClick='window.open("/api/index.php/aligo/layout", "sms", "left=10,top=10,width=1000,height=800,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no");' aria-expanded="false">ALIGO 문자</a></li>

					<li><a href="{MARI_HOME_URL}/?cms=sms_manage&type=book">SMS관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=lms_manage&type=book">LMS관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=sms_group">SMS그룹관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=sms_book">SMS전화번호관리</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=sms_setup">SMS설정</a></li>
					<li><a href="javascript:popup('http://intowinsoft.co.kr/play/pay/sms_order.php?cid=<?=$config[c_sms_id]?>',500,600)">SMS충전</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=reservation_send">푸시관리</a></li>
				</ul>
				<?php }?>
				<div class="lnb_mn lnb_menu01"><a href="javascript:;" onClick='repayschedule()' >정산스케쥴</a></div>

				<div class="lnb_mn lnb_menu01"><a href="#">환경설정</a></div>
				<?php if($cms=="setting1" || $cms == "advice_list" || $cms=="setting2" || $cms=="setting3" || $cms=="setting4"){?>
				<ul class="sub_lnb  sub_lnb_on">
				<?php }else{?>
				<ul class="sub_lnb" style="display: none;">
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=setting1">기본환경설정</a></li>
				<?php if($user[m_id]=="webmaster@admin.com"){?>
					<li><a href="{MARI_HOME_URL}/?cms=setting2">레이아웃/게시판설정</a></li>
				<?php }?>
					<li><a href="{MARI_HOME_URL}/?cms=setting3">회원가입/본인확인설정</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=setting4">SNS/메일수신설정</a></li>
				</ul>

			</div><!-- /lnb -->
<script>
function repayschedule(){
	$("#container").empty().css('background-color','#dcf5f2').html('<iframe src="/api/index.php/repayschedule" width="100%" height="1014px"/>');
	$("#left_container").height('1014px');
}
function investcheck(){
	$("#container").empty().css('background-color','#dcf5f2').html('<iframe src="/api/index.php/investcheck" width="100%" height="1014px"/>');
	$("#left_container").height('1014px');
}
</script>
