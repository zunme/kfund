<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>관리자 메뉴얼 </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="css/admin.css">
<!--[if lte IE 8]>
<script src="http://61.82.171.174/mari/home/js/html5.js"></script>
<![endif]-->
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery.menu.js"></script>
<script src="js/common.js"></script>
<script src="js/wrest.js"></script>
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
</head>

<body>
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
<div id="to_content"><a href="#container">본문 바로가기</a></div>

<div id="hd" class="hd_zindex">
    <div id="hd_wrap">
		<div class="tnb_wrap">
			<div class="tnb_wrap_inner">
				<ul id="tnb">
					<li class="top_mn1"><a href="#">관리자정보</a></li>
					<li class="top_mn5"><a href="setting_main.html">HOME 환경설정</a></li>
					<li class="top_mn2"><a href="#">MY HOME</a></li>
					<!-- <li><a href="#">SHOP 환경설정</a></li> -->
					<!-- <li><a href="#/">MY SHOP</a></li>	 -->				
					<li class="top_mn3"><a href="service_config.html">나의서비스관리</a></li>
					<li id="tnb_logout" class="top_mn4"><a href="#">로그아웃</a></li>
					<li class="help"><a href="#"><img src="img/help2_btn.png" alt="도움말"></a></li>
					<li class="ftp"><a href="#"><img src="img/ftp_btn.png" alt="ftp접속"></a></li>
				</ul>
			</div>
		</div>
		<div id="gnb_wrap">
			<div class="gnb_wrap_inner">
				<div id="logo"><a href="loan_list.html"><img src="img/logo.png" alt=" 관리자" title=""></a></div> 
				<div id="gnb">
					<h2>관리자 주메뉴</h2>
					<ul id="gnb_1dul">
						<li class="gnb_1dli">
							<a href="member_main.html" class="gnb_1da">회원관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="member_list.html" class="gnb_2da">회원목록</a></li>
								<li class="gnb_2dli"><a href="member_grade.html" class="gnb_2da">회원등급</a></li>
								<li class="gnb_2dli"><a href="leave_list.html" class="gnb_2da">탈퇴회원</a></li>
								<li class="gnb_2dli"><a href="emoney_list.html" class="gnb_2da">e-머니관리</a></li>
								<li class="gnb_2dli"><a href="mail_list.html" class="gnb_2da">회원메일발송</a></li>
								<li class="gnb_2dli"><a href="site_analytics.html" class="gnb_2da">로그분석</a></li>
								<!-- <li class="gnb_2dli"><a href="sendmail_test.html" class="gnb_2da">메일테스트</a></li> -->
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="board_main.html" class="gnb_1da">게시판관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="board_list.html" class="gnb_2da">게시판관리</a></li>
								<li class="gnb_2dli"><a href="boardgroup_list.html" class="gnb_2da">게시판그룹관리</a></li>
								<!-- <li class="gnb_2dli"><a href="#" class="gnb_2da">테스트게시판</a></li> -->
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="plugin_main.html" class="gnb_1da">플러그인/위젯</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="sns.html" class="gnb_2da">소셜네트워크(SNS)</a></li>
								<li class="gnb_2dli"><a href="analytics.html" class="gnb_2da">네이버 애널리틱스</a></li>
								<li class="gnb_2dli"><a href="latest.html" class="gnb_2da">최신글</a></li>
								
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="popup_main.html" class="gnb_1da">팝업관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="popup_list.html" class="gnb_2da">팝업관리</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="loan_main.html" class="gnb_1da">대출관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="loan_list.html" class="gnb_2da">대출현황</a></li>
								<li class="gnb_2dli"><a href="invest_setup_list.html" class="gnb_2da">투자진행 설정</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="invest_main.html" class="gnb_1da">투자관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="invest_list.html" class="gnb_2da">투자현황</a></li>
								<li class="gnb_2dli"><a href="pay_list.html" class="gnb_2da">결제관리</a></li>
								<li class="gnb_2dli"><a href="invest_pay_setup.html" class="gnb_2da">투자/결제 설정</a></li>
								<li class="gnb_2dli"><a href="withdrawal_list.html" class="gnb_2da">출금신청</a></li>
								<li class="gnb_2dli"><a href="charge_list.html" class="gnb_2da">충전내역</a></li>
								<li class="gnb_2dli"><a href="sales_report.html" class="gnb_2da">매출리포트</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="design_main.html" class="gnb_1da">디자인관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="exposure_settings.html" class="gnb_2da">디스플레이설정</a></li>
								<li class="gnb_2dli"><a href="seo_config.html" class="gnb_2da">SEO설정</a></li>
								<li class="gnb_2dli"><a href="page_security.html" class="gnb_2da">페이지보안설정</a></li>
								<li class="gnb_2dli"><a href="favicon.html" class="gnb_2da">파비콘설정</a></li>
								<li class="gnb_2dli"><a href="copyright.html" class="gnb_2da">하단정보설정</a></li>
								<li class="gnb_2dli"><a href="category_list.html" class="gnb_2da">카테고리설정</a></li>
								<li class="gnb_2dli"><a href="filemanager.html" class="gnb_2da">파일매니저</a></li>
								<li class="gnb_2dli"><a href="management_inc.html" class="gnb_2da">INCLUDE관리</a></li>
								<li class="gnb_2dli"><a href="management_page.html" class="gnb_2da">페이지관리</a></li>
								<!-- <li class="gnb_2dli"><a href="#" class="gnb_2da">FTP접속</a></li> -->
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="service_main.html" class="gnb_1da">나의서비스관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="service_config.html" class="gnb_2da">서비스 정보</a></li>
								<!-- <li class="gnb_2dli"><a href="#" class="gnb_2da">공지사항</a></li> -->
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="sms_main.html" class="gnb_1da">SMS관리</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="sms_manage.html" class="gnb_2da">SMS관리</a></li>
								<li class="gnb_2dli"><a href="sms_group.html" class="gnb_2da">SMS그룹/전화번호관리</a></li>
								<li class="gnb_2dli"><a href="sms_setup.html" class="gnb_2da">SMS설정</a></li>
								<!-- <li class="gnb_2dli"><a href="#" class="gnb_2da">SMS충전</a></li> -->
								<li class="gnb_2dli"><a href="reservation_send.html" class="gnb_2da">SMS/LMS푸시</a></li>
							</ul>
						</li>
						<li class="gnb_1dli">
							<a href="setting_main.html" class="gnb_1da">환경설정</a>
							<ul class="gnb_2dul">
								<li class="gnb_2dli"><a href="setting1.html" class="gnb_2da">기본환경설정</a></li>
								<li class="gnb_2dli"><a href="setting2.html" class="gnb_2da">레이아웃/게시판설정</a></li>
								<li class="gnb_2dli"><a href="setting3.html" class="gnb_2da">회원가입/본인확인설정</a></li>
								<li class="gnb_2dli"><a href="setting4.html" class="gnb_2da">SNS/메일수신설정</a></li>
							</ul>
						</li>
					</ul>
				</div><!-- gnb -->
			</div><!-- /gnb_wrap_inner -->
		</div><!-- /gnb_wrap -->
    </div><!-- /hd_wrap -->
</div><!-- /hd -->