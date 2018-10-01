<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 가입완료
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';
/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])){?>

{#header} 

		<div id="container">
			<div id="sub_content">
				<div class="title_wrap">
					<div class="title_wr_inner">
						<h3 class="title2_1">{_config['c_title']} 회원가입</h3>
						<!--<p class="sub_title"><?php echo $config['c_title'];?> MEMBERSHIP</p>-->
						<p class="title_add1_1">회원가입을 환영합니다. <br>절차에 따라 정보를 바르게 입력해 주세요.</p>
						<!--<p class="location1"><img src="{MARI_HOMESKIN_URL}/img/icon3.png" alt="홈" /> > <strong>투자리스트</strong></p>-->
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="join_wrap">
					<div class="join_inner">
					<h3>절차에 따라 회원가입을 진행해 주세요.</h3>
					<div class="join_step">
						<ul>
							<li >본인인증</li>
							<li>정보입력</li>
							<li  class="list_on">가입완료</li>
						</ul>
					</div>
					<div class="well_tit">
						<p>회원가입이 완료되었습니다.<br/>로그인을 하시고<br/>다양한 서비스를 이용해보세요!</p>
					</div>
					
					<div class="btnwell">
						<a href="{MARI_HOME_URL}/?mode=main" class="btn_list" id="agree_ok" alt="다음">메인으로</a>
					</div>
					</div>	
					
						
					</div>
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->
<!-- 전환페이지 설정 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv("2","10"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script>
 <script type="text/javascript"> 
 //<![CDATA[ 
 var DaumConversionDctSv="type=M,orderID=,amount="; 
 var DaumConversionAccountID="N9feBYOBPEXmlclTU2M7Kg00"; 
 if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){ 
 	var DaumConversionScriptLoaded=true; 
 	document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E")); 
 } 
 //]]> 
 </script> 

<!-- WIDERPLANET  SCRIPT START 2017.6.1 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
    return {
        wp_hcuid:"",  /*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입.
                     *주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"36025",
        ty:"Join",                        /*트래킹태그 타입*/
        device:"web",                  /*디바이스 종류 (web 또는 mobile)*/
        items:[{
            i:"회원가입",          /*전환 식별 코드 (한글, 영문, 숫자, 공백 허용)*/
            t:"회원가입",          /*전환명 (한글, 영문, 숫자, 공백 허용)*/
            p:"1",                   /*전환가격 (전환 가격이 없을 경우 1로 설정)*/
            q:"1"                   /*전환수량 (전환 수량이 고정적으로 1개 이하일 경우 1로 설정)*/
        }]
    };
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2017.6.1 -->
 

<!-- Google Code for &#54924;&#50896;&#44032;&#51077; Conversion Page
In your html page, add the snippet and call
goog_report_conversion when someone clicks on the
chosen link or button. -->
<script type="text/javascript">
  /* <![CDATA[ */
  goog_snippet_vars = function() {
    var w = window;
    w.google_conversion_id = 851722703;
    w.google_conversion_label = "p6tTCOXmtHEQz4ORlgM";
    w.google_remarketing_only = false;
  }
  // DO NOT CHANGE THE CODE BELOW.
  goog_report_conversion = function(url) {
    goog_snippet_vars();
    window.google_conversion_format = "3";
    var opt = new Object();
    opt.onload_callback = function() {
    if (typeof(url) != 'undefined') {
      window.location = url;
    }
  }
  var conv_handler = window['google_trackConversion'];
  if (typeof(conv_handler) == 'function') {
    conv_handler(opt);
  }
}
/* ]]> */
</script>
 <script type="text/javascript"> 
 //<![CDATA[ 
 var DaumConversionDctSv="type=M,orderID=,amount="; 
 var DaumConversionAccountID="N9feBYOBPEXmlclTU2M7Kg00"; 
 if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){ 
 	var DaumConversionScriptLoaded=true; 
 	document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E")); 
 } 
 //]]> 
 </script> 
 {#footer}<!--하단-->
<? }else{ ?>
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
					<div class="join_inner">
					<h3>절차에 따라 회원가입을 진행해 주세요.</h3>
					<div class="join_step">
						<ul>
							<li >본인인증</li>
							<li>정보입력</li>
							<li  class="list_on">가입완료</li>
						</ul>
					</div>
					<div class="well_tit">
						<p>회원가입이 완료되었습니다.<br/>로그인을 하시고<br/>다양한 서비스를 이용해보세요!</p>
					</div>
					
					<div class="btnwell">
						<a href="{MARI_HOME_URL}/?mode=main" class="btn_list" id="agree_ok" alt="다음">메인으로</a>
					</div>
				</div><!-- /join_inner -->
				</div><!-- /join_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->



 {#footer}<!--하단-->
<?php } ?>