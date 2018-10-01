<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 본인인증
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->


<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>
{#header} 
<section id="container">
	<section id="sub_content">
	<div class="title_wrap">
				<div class="title_wr_inner">
					<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
					<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>-->
					<p class="title_add1_1">회원가입을 환영합니다.<br/> 절차에 따라 정보를 바르게 입력해 주세요.</p>
					<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
				</div><!-- /title_wr_inner -->
			</div><!-- /title_wrap -->
			
			<div class="join_wrap">
				<!--<div class="join_step">
					<ul>
						<li><p>01. 약관 동의</p></li>
						<li class="current"><p>02. 개인/기업</p></li>
						<li><p>03. 본인 인증</p></li>
						<li><p>04. 정보 입력</p></li>
						<li><p>05. 가입 완료</p></li>
					</ul>
				</div>-->
				
				<div class="join_section3">
					<div class="member_system">
							<h3>개인회원가입 / 기업회원가입 중 선택해주세요</h3>
							<div class="join_box">
						<div>	
<!-- 							<a href="?mode=join1"> --> <!--실서버 세팅되고 나이스연동하면 주석풀고사용 이경희 2018-04-20-->
							<a href="?mode=join3">
								<img src="{MARI_HOMESKIN_URL}/img/join_person.png" alt="" />
								<h4>개인으로 가입하기</h4>
								<!--<p>일반/개인 회원</p>-->
							</a>
						</div>
						<div>	
							<a href="?mode=join3_enterprise">
							<img src="{MARI_HOMESKIN_URL}/img/join_company.png" alt="" />
							<h4>기업으로 가입하기</h4>
							<!--<p>사업자등록증을 보유한 기업</p>-->
							</a>
						</div>
					</div>
					</div>
					<!--<div class="txt_l mt20">
						<a href="{MARI_HOME_URL}/?mode=join1"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" /></a>						
					</div>-->
				</div>
			</div><!-- /join_wrap -->		
	</section>
</section>

{#footer}<!--하단-->

<?}else{?>

{#header_sub} 

<div id="container">
		<div id="sub_content">
			<div class="title_wrap">
				<div class="title_wr_inner">
					<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
					<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>-->
					<p class="title_add1_1">회원가입을 환영합니다. 절차에 따라 정보를 바르게 입력해 주세요.</p>
					<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
				</div><!-- /title_wr_inner -->
			</div><!-- /title_wrap -->
			
			<div class="join_wrap">
				<!--<div class="join_step">
					<ul>
						<li><p>01. 약관 동의</p></li>
						<li class="current"><p>02. 개인/기업</p></li>
						<li><p>03. 본인 인증</p></li>
						<li><p>04. 정보 입력</p></li>
						<li><p>05. 가입 완료</p></li>
					</ul>
				</div>-->
				
				<div class="join_section3">
					<div class="member_system">
							<h3>개인회원가입 / 기업회원가입 중 선택해주세요</h3>
							<div class="join_box">
						<div>	
<!-- 							<a href="?mode=join1"> --> <!--실서버 세팅되고 나이스연동하면 주석풀고사용 이경희 2018-04-20-->
							<a href="?mode=join3">
								<img src="{MARI_HOMESKIN_URL}/img/join_person.png" alt="" />
								<h4>개인으로 가입하기</h4>
								<!--<p>일반/개인 회원</p>-->
							</a>
						</div>
						<div>	
							<a href="?mode=join3_enterprise">
							<img src="{MARI_HOMESKIN_URL}/img/join_company.png" alt="" />
							<h4>기업으로 가입하기</h4>
							<!--<p>사업자등록증을 보유한 기업</p>-->
							</a>
						</div>
					</div>
					</div>
					<!--<div class="txt_l mt20">
						<a href="{MARI_HOME_URL}/?mode=join1"><img src="{MARI_HOMESKIN_URL}/img/btn_prev1.png" alt="이전" /></a>						
					</div>-->
				</div>
			</div><!-- /join_wrap -->
		</div><!-- /sub_content -->
	</div><!-- /container -->
 {#footer}<!--하단-->
<?}?>
 
