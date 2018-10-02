<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 상단
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<link rel="stylesheet" href="{MARI_ADMINSKIN_URL}/css/admin.css">
<script src="{MARI_ADMINSKIN_URL}/js/jquery-1.8.3.min.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/jquery.menu.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/common.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/wrest.js"></script>
<script src="{MARI_ADMINSKIN_URL}/js/check.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="{MARI_ADMINSKIN_URL}/js/javascript.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script language="JavaScript" type="text/JavaScript">
jQuery(document).ready(function() {
    var offset = 220;
    var duration = 700;
    jQuery(window).scroll(function() {
        if (jQuery(this).scrollTop() > offset) {
            jQuery('.back-to-top').fadeIn(duration);
        } else {
            jQuery('.back-to-top').fadeOut(duration);
        }
    });

    jQuery('.back-to-top').click(function(event) {
        event.preventDefault();
        jQuery('html, body').animate({scrollTop: 0}, duration);
        return false;
    })
});
</script>
<!-- lnb -->
<script type="text/javascript">
	$(document).ready(function(){
		$(".sub_lnb").css("display","none");
		$(".sub_lnb_on").css("display","block");
		$(".lnb_mn").click(function(){
			var viewlist = $(this).next("ul");
				if($(viewlist).css("display")=="none"){
				$(".sub_lnb").slideUp("slow");
				$(viewlist).slideDown("slow");
			} else {
				$(viewlist).slideUp("slow");
			}
		});
	});
</script><!-- /lnb -->

<script>
var tempX = 0;
var tempY = 0;

function imageview(id, w, h)
{

    menu(id);

    var el_id = document.getElementById(id);

    //submenu = eval(name+".style");
    submenu = el_id.style;
    submenu.left = tempX - ( w + 11 );
    submenu.top  = tempY - ( h / 2 );

    selectBoxVisible();

    if (el_id.style.display != 'none')
        selectBoxHidden(id);
}

window.onload = function()
 {

 setDivHeight('left_container','container');
 }

 function setDivHeight(objSet, objTar)
 {
   var objSet   = document.getElementById(objSet);
   var objTarHeight= document.getElementById(objTar).offsetHeight;
   objSet.style.height  = objTarHeight + "px";
 }
 //-->
</script>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});

$(function() {
	$('#ftp_add').click(function(){
		ftp_add_Ok(document.ftp_go);
	});
});


function ftp_add_Ok(f)
{
	f.method = 'post';
	f.action = 'http://mplusmaster.wayhome.kr/admin/ftp_client.php';
	f.submit();
}
</script>

<div class="loadingWrap">
  <img src="{MARI_HOMESKIN_URL}/img/loader.gif">
</div>
<div id="to_content"><a href="#container">본문 바로가기</a></div>
<form name="ftp_go"  method="post" enctype="multipart/form-data">
<input type="hidden" name="ftp_host" value="<?php echo $default['ftp_host']; ?>">
<input type="hidden" name="ftp_user" value="<?php echo $default['ftp_id']; ?>">
<input type="hidden" name="ftp_port" value="21">
</form>
<div id="hd" class="hd_zindex">
    <div id="hd_wrap">
		<div class="tnb_wrap">
			<div class="tnb_wrap_inner">
				<ul id="tnb">
					<li class="top_mn1"><a href="#">관리자정보</a></li>
				<?php if($user[m_id]=="webmaster@admin.com"){?>
					<li class="top_mn5"><a href="{MARI_HOME_URL}/?cms=setting_main">HOME 환경설정</a></li>
				<?php }?>
					<li class="top_mn2"><a href="{MARI_HOME_URL}/?mode=main" target="_blank">MY HOME</a></li>
					<li class="top_mn3"><a href="{MARI_HOME_URL}/?cms=service_config">나의서비스관리</a></li>
					<?php if(!$member_ck){?>
					<li id="tnb_logout" class="top_mn4"><a href="{MARI_HOME_URL}/?cms=admin_login">로그인</a></li>
					<?php }else{?>
					<li id="tnb_logout" class="top_mn4"><a href="{MARI_HOME_URL}/?cms=admin_logout">로그아웃</a></li>
					<?php }?>
				</ul>
			</div>
		</div>
		<div id="gnb_wrap">
			<div class="gnb_wrap_inner">
				<div id="logo"><a href="{MARI_HOME_URL}/?cms=admin"><img src="{MARI_DATA_URL}/favicon/{_config['c_logo']}"  alt="{_config['c_title']}" style="width: 120px;"/></a></div>
				<div id="gnb">
					<h2>관리자 주메뉴</h2>
					<ul id="gnb_1dul">
						<?php
						$sql = "select * from mari_authority where m_id = '$user[m_id]'";
						$au = sql_fetch($sql, false);
							if($au[au_member]=='1'){
						?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=member_main" class="gnb_1da">회원관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=member_list" class="gnb_2da">회원목록</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=illusion_acc_list" class="gnb_2da">가상계좌관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=member_grade" class="gnb_2da">회원등급</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=leave_list" class="gnb_2da">탈퇴회원&복구</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=emoney_list" class="gnb_2da">e-머니관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=site_analytics&stype=time" class="gnb_2da">로그분석</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=member_authority" class="gnb_2da">회원권한관리</a></li>
								<!--<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sendmail_test" class="gnb_2da">메일테스트</a></li>-->
							</ul>
						</li>
						<?php }?>
						<?php if($au[au_board]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=board_main" class="gnb_1da">게시판관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=boardgroup_list" class="gnb_2da fb">게시판그룹관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=board_list" class="gnb_2da fb gnb_grp_style">게시판관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=faq_list" class="gnb_2da gnb_3da">FAQ</a></li>
							<?php
							for ($i=0;  $row=sql_fetch_array($bo_view ); $i++){
							?>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=user_board_list&table=<?php echo $row['bo_table'];?>&subject=<?php echo $row['bo_subject'];?>" class="gnb_2da gnb_3da"><?php echo $row['bo_subject'];?></a></li>

							<?php }?>

							</ul>
						</li>
						<?php }?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=plugin_main" class="gnb_1da">플러그인/위젯</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sns" class="gnb_2da">소셜네트워크 (SNS)</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=analytics" class="gnb_2da">네이버 애널리틱스</a></li>
								<!--
								<li class="gnb_2dli"><a href="#" class="gnb_2da">네이버 신디케이션</a></li>
								<li class="gnb_2dli"><a href="#" class="gnb_2da">네이버 블로그</a></li>>
								-->
							</ul>
						</li>
						<?php if($au[au_popup]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=popup_main" class="gnb_1da">팝업관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=popuplist" class="gnb_2da">팝업관리</a></li>
							</ul>
						</li>
						<?php }?>
						<?php if($au[au_loan]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=loan_main" class="gnb_1da">대출관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli">
									<a href="{MARI_HOME_URL}/?cms=loan_list" class="gnb_2da">대출현황</a>
								</li>
								<li class="gnb_2dli">
									<a href="{MARI_HOME_URL}/?cms=invest_setup_list" class="gnb_2da">투자진행 설정</a>
								</li>
								<li class="gnb_2dli">
									<a href="{MARI_HOME_URL}/?cms=lawyer_list" class="gnb_2da">심사원</a>
								</li>
							</ul>
						</li>
						<?php }?>
						<?php if($au[au_invest]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=invest_main" class="gnb_1da">투자관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=invest_list" class="gnb_2da">투자현황</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=pay_list" class="gnb_2da">결제관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=invest_pay_setup" class="gnb_2da">투자/결제 설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=withdrawal_list" class="gnb_2da">출금신청</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=charge_list" class="gnb_2da">충전내역</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sales_report" class="gnb_2da">매출리포트</a></li>
							</ul>
						</li>
						<?php }?>
						<?php if($au[au_sales]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=payment_deal_list" class="gnb_1da">회계관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=payment_deal_list" class="gnb_2da">전자결제거래내역</a></li>
							</ul>
						</li>
						<?php }?>
						<?php if($au[au_design]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=design_main" class="gnb_1da">디자인관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=seo_config" class="gnb_2da">SEO설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=page_security" class="gnb_2da">페이지보안설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=favicon" class="gnb_2da">로고/파비콘설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=copyright" class="gnb_2da">하단정보설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=category_list" class="gnb_2da">카테고리설정</a></li>
							</ul>
						</li>
						<?php }?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=service_config" class="gnb_1da">나의서비스관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=service_config" class="gnb_2da">서비스 정보</a></li>
								<!--<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=conservatism" class="gnb_2da">유지보수</a></li>-->
							</ul>
						</li>
						<?php if($au[au_sms]=='1'){ ?>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=sms_main" class="gnb_1da">SMS관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sms_manage&type=book" class="gnb_2da">SMS관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=lms_manage&type=book" class="gnb_2da">LMS관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sms_group" class="gnb_2da">SMS그룹관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sms_book" class="gnb_2da">SMS전화번호관리</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=sms_setup" class="gnb_2da">SMS설정</a></li>
								<li class="gnb_2dli"><a href="javascript:popup('http://intowinsoft.co.kr/play/pay/sms_order.php?cid=<?=$config[c_sms_id]?>',500,600)" class="gnb_2da">SMS충전</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=reservation_send" class="gnb_2da">푸시관리</a></li>
							</ul>
						</li>
						<?php }?>
            <li class="gnb_1dli">
							<a href="javascript:;" onClick='repayschedule()' class="gnb_1da">정산스케쥴</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="javascript:;" onClick='repayschedule()' class="gnb_2da">정산스케쥴</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=setting_main" class="gnb_1da">환경설정</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=setting1" class="gnb_2da">기본환경설정</a></li>
							<?php if($user[m_id]=="webmaster@admin.com"){?>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=setting2" class="gnb_2da">레이아웃/게시판설정</a></li>
							<?php }?>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=setting3" class="gnb_2da">회원가입/본인확인설정</a></li>
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=setting4" class="gnb_2da">SNS/메일수신설정</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=project&table=modified&subject=클라이언트메인&skin=client_main" class="gnb_1da">고객지원 센터</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=project&table=modified&subject=클라이언트메인&skin=client_main" class="gnb_2da">고객지원</a></li>
							</ul>
						</li>
					</ul>
				</div><!-- gnb -->
			</div><!-- /gnb_wrap_inner -->
		</div><!-- /gnb_wrap -->
    </div><!-- /hd_wrap -->
</div><!-- /hd -->
