<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header} 
<section id="container">
		<section id="sub_content">
				<div class="container">
					<div class="dashboard_my_info">
							<h3><span>정보수정</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_basic">기본 정보</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center">인증센터</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_out" class="info_current">회원탈퇴</a></li>
								</ul>
							</h3>
							<div class="dashboard_info_out">
								<p>아래 사항을 꼼꼼히 읽어보신 후 회원 탈퇴를 진행해 주세요.</p>
								<ul>
									<li>회원 탈퇴 후에는 서비스 이용이 불가합니다.</li>
									<li>대출 또는 투자 진행 시 탈퇴가 불가합니다.</li>
									<li>회원 탈퇴 시 현재 접속 중인 아이디는 즉시 탈퇴 처리 됩니다.</li>
									<li>투자, 대출 이용 기록은 탈퇴 후 3개월 뒤 전부 삭제 됩니다.</li>
									<li>회원 정보 및 서비스 이용 기록은 탈퇴 후 즉시 삭제 되며, 삭제된 정보는 복구되지 않습니다.</li>
								</ul>
								<form name="member_out"  method="post" enctype="multipart/form-data">
								<input type="hidden" name="m_no" value="<?php echo $mmo['m_no']; ?>">
								<input type="hidden" name="m_id" value="<?php echo $user[m_id]?>">
								<input type="hidden" name="type" value="d">
								<label><input type="checkbox" id="agreement" name="agreement"> 위 사항을 모두 확인했으며, 이에 동의합니다.</label>
								</form>
								<a href="#" class="modify_submit" id="member_delete">회원 탈퇴하기</a>
							</div>
						</div>
				</div>
		</section><!-- /sub_content -->
	</section><!-- /container -->
<script>
/*탈퇴처리*/
$(function() {
	$('#member_delete').click(function(){
	next_d(document.member_out);
	});
});


function next_d(f)
{
	if(!$('#agreement').is(':checked')){alert('동의란에 체크를 해주시기 바립니다.'); return false;}

	if(confirm("정말 탈퇴처리 하시겠습니까? 탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다.")){
		f.method = 'post';
		f.action = '{MARI_HOME_URL}/?up=leave';
		f.submit();
	}
}
</script>
{# footer}<!--하단-->