<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 메인상단
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<!--css 시작-->
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css" />
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/pro-bars.min.css" />
<!--css 끝-->
<!-- script 시작-->
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery.bxslider.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/slides.min.jquery.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/javascript2.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery.vticker-min.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery-migrate-1.2.1.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(function(){
			var obj = $('ul.noble_gnb li');
			$('.noble_sub_gnb').hide();
			obj.mouseenter(function(){				
	
			$(this).find('.noble_sub_gnb').stop().slideDown(500);
			})
			obj.mouseleave(function(){
				$(this).find('.noble_sub_gnb').stop().slideUp(500);
			})
		})
</script>
<!-- script 끝-->

<div id="wrap">
	<div id="noble_header">
		<div class="noble_top_gnb">
			<p>(주)노블자산관리 2017-000-0000 (주)노블파이낸스대부중개업 2017-000-0000</p>
		</div>
		<div class="noble_gnb_wrap">
			<div class="noble_gnb_inner">
				<div class="noble_center_gnb">

					<h1 class="noble_logo">
						<a href="{MARI_HOME_URL}/?mode=noble_index"><img src="{MARI_HOMESKIN_URL}/img/noble_top_logo.png" alt=""/></a>
					</h1>

					<h2 class="hidden">메뉴 네비게이션</h2>

					<ul class="noble_member_mn"> 
						<?php if(!$member_ck){?>
							<li><a href="{MARI_HOME_URL}/?mode=login">로그인</a></li>
						<?php } else{?>
							<li><a href="{MARI_HOME_URL}/?mode=logout">로그아웃</a></li>
						<?php }?>
						<?php if(!$member_ck){?>
							<li><a href="{MARI_HOME_URL}/?mode=join0">회원가입</a></li>
						<?php } else{?>
							<li><a href="{MARI_HOME_URL}/?mode=mypage">마이페이지</a></li>
						<?php }?>
					</ul>
				</div> <!--noble_center_gnb-->
				
				<div class="noble_bottom_gnb_wrap">
					<div class="noble_bottom_gnb">
						<ul class="noble_gnb">
							<li><a href="{MARI_HOME_URL}/?mode=invest">투자하기</a>
								<div class="noble_sub_gnb">
									<ul>
										<li><a href="{MARI_HOME_URL}/?mode=invest">투자하기</a></li>
										<li><a href="{MARI_HOME_URL}/?mode=portfolio_list">지난상품</a></li>
										<li><a href="{MARI_HOME_URL}/?mode=portfolio_list">기관/법인투자상담</a></li>
									</ul>
								</div>
							
							</li>
							<li><a href="{MARI_HOME_URL}/?mode=loan">대출하기</a></li>
							<li><a href="{MARI_HOME_URL}/?mode=company_intro">이용안내</a>
								<div class="noble_sub_gnb">
										<ul>
											<li><a href="{MARI_HOME_URL}/?mode=guide_invest">투자가이드</a></li>
											<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항">공지사항</a></li>
											<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변">FAQ</a></li>
											<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=질문과답변">메일문의</a></li>
										</ul>
								</div>

							</li>
							<li style="cursor:pointer">노블펀드소개 <img src="{MARI_HOMESKIN_URL}/img/img_gnb.png" alt=""/>
								<div class="noble_sub_gnb">
									<ul>
										<li><a href="{MARI_HOME_URL}/?mode=invest_new">회사소개</a></li>
										<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">노블live</a></li>
									</ul>
								</div>
							</li>
						</ul>
					</div><!--noble_bottom_gnb-->
				</div>
			</div>
		</div><!-- gnb -->
	</div><!-- header -->