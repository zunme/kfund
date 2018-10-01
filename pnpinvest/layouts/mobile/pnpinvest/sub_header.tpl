<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 메인상단
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<!--HOME 로그분석 스크립트설정-->
{_config['c_analytics']}
  <?php //모바일모드
   $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
   if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {
   ?>
       
 
   <?php }else{?>
       
   <?php }?>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{_config['c_title']}</title>

<meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="{MARI_MOBILESKIN_URL}/js2/common.css" />
<link rel="stylesheet" type="text/css" href="{MARI_MOBILESKIN_URL}/js2/mobile.css" />
<link rel="stylesheet" type="text/css" href="{MARI_MOBILESKIN_URL}/css/mobile.css" />
<link rel="stylesheet" type="text/css" href="{MARI_MOBILESKIN_URL}/css/content_mobile2.css" />
<link rel="stylesheet" type="text/css" href="{MARI_MOBILESKIN_URL}/css/jquery.bxslider.css" />
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/jquery-2.2.1.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/jquery.bxslider.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/javascript.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/swipe.js"></script>

<!-- mobile js -->

<script src="{MARI_MOBILESKIN_URL}/js2/jquery-ui.min.js"></script>
<script src="{MARI_MOBILESKIN_URL}/js2/hamburger.js"></script>

<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/velocity.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/index.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/prefixfree.min.js"></script>

<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/jquery-migrate-1.2.1.min.js"></script> 



    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
     <script>alert("IE9 이전 버전에서는 지원되지 않습니다. 브라우저를 업데이트해주세요.");</script>
    <![endif]-->


<script>
	$(function(){
		$('.top').css('stroke','rgb(78,78,79)');
		$('.mid').css('stroke','rgb(78,78,79)');
		$('.bot').css('stroke','rgb(78,78,79)');
		$('#header').css('border-bottom','1px solid rgb(193,194,194)');
		$('#header').css('background','rgb(193,194,194)');

	})
</script>

<div class="wrap">

        <div id="sidebar">
		<div class="nav_my_info">
			<div>
				<img src="{MARI_MOBILESKIN_URL}/img/img_nav_profile_thumnail.png" alt="프로필" />
			</div>
			
			<div>
				
				<?php if(!$member_ck){?>
				
					
					<a href="{MARI_HOME_URL}/?mode=login">로그인</a>
				<?php }else{?>
					<?php echo $user['m_name']; ?> 님 <img src="{MARI_MOBILESKIN_URL}/img/img_nav_bar.png" alt="img_nav_bar" />
					<a href="{MARI_HOME_URL}/?mode=logout">로그아웃 </a>
				<?php }?>
				<br/>
				<?php if(!$member_ck){ echo '로그인이 필요합니다.';}else{ echo $user['m_id'];}?>
			</div>
		</div>
			<ul class="nav_col_3 cl_b">
				<li><a href="{MARI_HOME_URL}/?mode=mypage"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_dash.png" alt="대시보드"/></a></li>
				<li><a href="{MARI_HOME_URL}/?mode=mypage_tenderstatus"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_invest.png" alt="투자내역"/></a></li>
				<li><a href="{MARI_HOME_URL}/?mode=mypage_loanstatus"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_loan.png" alt="대출내역"/></a></li>
				<li><a href="{MARI_HOME_URL}/?mode=mypage_withdrawal"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_charge.png" alt="출금"/></a></li>
				<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_news.png" alt="새소식"/></a></li>
				<li><a href="{MARI_HOME_URL}/?mode=invest_calculation"><img src="{MARI_MOBILESKIN_URL}/img/btn_nav_calculation.png" alt="수익계산"/></a></li>
			</ul>
			<ul class="nav_col_1 cl_b">
				<?php if(!$member_ck){?>
					
					<li><a href="{MARI_HOME_URL}/?mode=loan">대출하기<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=invest">투자하기<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=guide">자주묻는 질문<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">언론 보도<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=my">새소식<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=introduce">회사소개<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
				<?php }else{?>
					<li><a href="{MARI_HOME_URL}/?mode=mypage_basic">회원정보수정<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=loan">대출하기<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=invest">투자하기<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=mypage">마이페이지<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=guide">자주묻는 질문<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=out">언론 보도<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
					<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰&type=my">새소식<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>]
					<li><a href="{MARI_HOME_URL}/?mode=introduce">회사소개<img src="{MARI_MOBILESKIN_URL}/img/img_nav_arrow.png" alt="img_nav_arrow"/></a></li>
				<?php }?>
				
			</ul>

        </div>
	  <div class="content_layer">
	  </div>
        <div class="main-content">

   <header id="header">
      <div class="header_inner container">
         <div class="menu">
		 <a href="#" data-toggle=".wrap" id="sidebar-toggle" class="toggle">
			<svg class="icon">
				<line class="top" x1="0" y1="3" x2="30" y2="3" />
				<line class="mid" x1="0" y1="10" x2="20" y2="10" />
				<line class="bot" x1="0" y1="17" x2="15" y2="17" />
			</svg>
		</a>
		 <h1 class="logo"><a href="{MARI_HOME_URL}/?mode=main"><img src="{MARI_DATA_URL}/favicon/<?php echo $config['c_logo'];?>" alt="<?php echo $config['c_title'];?>"/></a></h1>
		 <a href="{MARI_HOME_URL}/?mode=login"><img src="{MARI_MOBILESKIN_URL}/img/menu_btn5.png" alt="menu"/></a>
	</div>
      </div><!-- /header_inner -->
   </header><!-- /header -->

<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/velocity.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/index.js"></script>
<script type="text/javascript" src="{MARI_MOBILESKIN_URL}/js/prefixfree.min.js"></script>

















               
       
 







