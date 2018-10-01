
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 비밀번호 변경
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->

 














<section id="container">
		<section id="sub_content">
			<div class="mypage_wrap">
			<form name="member_form"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="m_no" value="{_mmo['m_no']}"/>
			<input type="hidden" name="m_id" value="{_user['m_id']}"/>


				<div class="container">
					<h3 class="s_title1">비밀번호 변경</h3>
					<div class="my_inner3">
						<table class="type2">
							<colgroup>
								<col width="100px" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>이메일</th>
									<td><?php echo $mmo['m_id']; ?></td>
								</tr>
								<tr>
									<th>현재비밀번호</th>
									<td>
										<input type="password" name="m_password" id="" required size="40" class="form-control"/>
									</td>
								</tr>
								<tr>
									<th>변경비밀번호</th>
									<td>
										<input type="password" name="m_password_re" required id=""size="40" class="form-control"/>
									</td>
								</tr>
								<tr>
									<th>비밀번호확인</th>
									<td>
										<input type="password" name="" id="" value="" size="40" class="form-control"/>
									</td>
								</tr>
							</tbody>
						</table>

						<div class="my_btn_wrap3">
							<input type="image" src="{MARI_MOBILESKIN_URL}/img/btn_change2.png" id="member_form_add" alt="변경 완료" />
						</div>
					</div><!-- /my_inner3 -->
				</div><!--container-->
			</form>




			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->

<script>
/*필수체크*/
$(function(){
	$('#member_form_add').click(function(){
		Member_form_Ok(document.member_form);
	});
});

function Member_form_Ok(f){
	if(!f.m_password.value){alert('\n현재 비밀번호를 입력하여 주십시오.');f.m_password.focus();return false;}
	if(!f.m_password_re.value){alert('\n비밀번호확인을 입력하여 주십시오.');f.m_password_re.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=change_pw';
	f.submit();
}
</script>
{# footer}<!--하단-->
