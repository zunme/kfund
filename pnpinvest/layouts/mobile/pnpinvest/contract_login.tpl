<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header}<!--상단-->


<section id="container">
		<section id="sub_content">
			<div class="mypage_wrap">
				<div class="container">
				<form name="chargeForm" method="post" enctype="multipart/form-data">
					<h3 class="s_title1">계약관리</h3>
					<div class="my_inner1">
						<table class="type2">
							<colgroup>
								<col width="86px" />
							</colgroup>
							<tbody>
								<tr>
									<th>계약서 업로드를 위해 공인인증서 로그인이 필요합니다.</th>
								</tr>
								<tr>
									<td>
										<a href="javascript:;" class="certificate_login">공인인증서 로그인</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div><!-- /my_inner1 -->
				</form>
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->

<script language='javascript'>

function sendit(){	

var f = document.chargeForm;

var loann_pattern = /[^(0-9)]/;//숫자
if(loann_pattern.test(f.AMOUNT.value)){alert('\n충전금액은 숫자만 입력하실수 있습니다');f.AMOUNT.value='';f.AMOUNT.focus();return false;}	
if(!f.AMOUNT.value){alert('\n충전하실 금액을 입력하여 주십시오.');f.AMOUNT.focus();return false;}

window.open('', 'popupChk', 'width=749, height=520, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
f.action = "{MARI_HOME_URL}/?mode=virtualaccount_input";
f.target = "popupChk";
f.submit();
}
</script>

{# footer}<!--하단-->
