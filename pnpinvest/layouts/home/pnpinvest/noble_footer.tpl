<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<div id="footer">
	<div class="partner">
		<div class="partner_inner">
			<img src="{MARI_HOMESKIN_URL}/img2/img_partner.png">
		</div>
	</div><!-- partner-->
	<div class="info">
		<div class="info_top">
			<ul class="sns">
				<li><a href="javascript:;"><img src="{MARI_HOMESKIN_URL}/img2/sns_fb.png" alt="페이스북"/></a></li>
				<li><a href="javascript:;"><img src="{MARI_HOMESKIN_URL}/img2/sns_blog.png" alt="블로그"/></a></li>
				<li><a href="javascript:;"><img src="{MARI_HOMESKIN_URL}/img2/sns_insta.png" alt="인스타그램"/></a></li>
			</ul>
			<ul class="agreement">
				<li><a href="{MARI_HOME_URL}/?mode=common1" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false">이용약관</a></li>
				<li><a href="{MARI_HOME_URL}/?mode=common2" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false">개인정보취급방침</a></li>
				<li><a href="{MARI_HOME_URL}/?mode=common3" onclick="window.open(this.href, '','width=740, height=700, resizable=no, scrollbars=yes, status=no'); return false">이메일무단수집거부</a></li>
			</ul>
			<a href="javascript:;" class="go_top"><img src="{MARI_HOMESKIN_URL}/img2/btn_top.png" alt="맨위로"></a>
		</div><!-- info_top -->
		<div class="info_bottom">
			<div>
				<img src="{MARI_HOMESKIN_URL}/img2/logo_gray.png" alt="logo"/>
				<p>
					<?php echo $config['c_title'];?>은 오랜기간 부동산 사업을<br/>
					운영해 왔습니다. 오프라인 부동산개발 사업의<br/>
					노하우로 안전한 투자상품을 제공하겠습니다.<br/>
					부동산 투자는 큰 자금이 들어간다는 부담으로<br/>
					초기에 포기하는 경우가 많습니다.<br/>
					플레이플랫폼은 소액으로도 투자하여<br/>
					수익을 창출하는 P2P금융 플랫폼입니다.
				</p>
			</div>
			<div>
				<p class="title">Contact Us</p>
				<img class="line" src="{MARI_HOMESKIN_URL}/img2/footer_line.png" alt=""/>
				{_config['c_copyright']}
			</div>
			<div>
				<p class="title">Loan Info</p>
				<img class="line" src="{MARI_HOMESKIN_URL}/img2/footer_line.png" alt=""/>
				{_config['c_information']}
			</div>
		</div>
		<div class="copyright">
			<p>대출금리 연 20%이내 (연체금리 연 25%이내 중개수수료를 요구하거나 받는 행위는 불법입니다.)</br>
			     과도한 빚은 당신에게 큰 불행을 안겨줄 수 있습니다.</p>
			<p>노블펀드는 투자원금과 수익을 보장하지 않으며, 투자손실에 대한 책임은 모두 투자자에게 있습니다.</p>
			<p>Copyright ⓒ <?php echo $config['c_title'];?> All rights reserved.</p>
		</div>	
	</div>	
</div><!-- footer -->
</div><!-- /wrap -->
<script>
	$( '.go_top' ).click( function() {
	$( 'html, body' ).animate( { scrollTop : 0 }, 1000 );
	return false;
	} );
</script>