<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 메인하단
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

<footer id="footer">

    <div class="footer_mn">
            <div class="footer_mn_inner">
					<ul class="">
					<li><a href="{MARI_HOME_URL}/?mode=common2">이용약관</a></li>
						<li>|</li>
					     <li><a href="{MARI_HOME_URL}/?mode=common1">개인정보처리방침</a></li>
						<li>|</li>
						<li><a href="{MARI_HOME_URL}/?mode=common3">투자약관</a></li>
						<li>|</li>

					</ul>
				</div>
				<!--//footner_mn_inner e-->
			</div>
			<!--//footer_mn e -->


		<div class="footer_inner container">
			<div class="info11">
				<div class="c">
				  {_config['c_copyright']}
				   <p >COPYRIGHT ⓒ KEY STONE FUNDINGFUNDING. ALL RIGHTS RESERVED</p>
				</div>
				<a href="javascript:;" class="go_top"><img src="{MARI_HOMESKIN_URL}/img2/toptop.png" alt="맨위로"><p>TOP</p></a>
			</div>
			<div class="info21">
			{_config['c_information']}

		  </div>
           <div class="info3">
		    <!--<ul>
			   <!--<li><a href=""><img src="{MARI_MOBILESKIN_URL}/img/sns1.png" alt="sns1"></a></li>
			   <li><a href="http://pf.kakao.com/_NQYxcxl"><img src="{MARI_MOBILESKIN_URL}/img/sns2.png" alt="카카오톡"></a></li>
			   <!--<li><a href=""><img src="{MARI_MOBILESKIN_URL}/img/sns3.png" alt="sns3"></a></li>
			</ul>-->
		   </div>
         <div class="footer_copy">
			<p>대출금리 : 연 19.9%이내 (연체금리 : 연 24%이내)플랫폼 이용료 외 취급수수료 등 기타 부대비용은 없으며, 중개수수료를 요구하거나 받는 행위는 불법입니다.</p>
			<p>채무의 조기상환수수료율 등 조기상환 조건은 없습니다.</p>
			<p>과도한 빚은 당신에게 큰 불행을 안겨줄 수 있습니다. "대출시 귀하의 신용등급이 하락할 수 있습니다." </p>
			<p>키스톤펀딩은 투자원금과 수익을 보장하지 않으며, 투자손실에 대한 책임은 모두 투자자에게 있습니다.</p>
			</div>
		</div><!-- /footer_inner -->
	</footer><!-- /footer -->
<script>
	$( '.go_top' ).click( function() {
	$( 'html, body' ).animate( { scrollTop : 0 }, 1000 );
	return false;
	} );
</script>