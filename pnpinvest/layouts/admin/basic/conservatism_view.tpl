<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN money_setup.tpl 유료금액설정 및 기타설정
┗━━━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">고객센터</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
		<div class="title02">유지보수</div>
			<fieldset>
	<form name="modiForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<?php echo $type?>"/>
	<input type="hidden" name="cv_id" value=<?php echo $cv_id;?>>
			<div id ="server_info">
				<div class="tbl_frm01 tbl_wrap mb30">
					<table>
					<caption>유지보수 수정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<?php if(!$cv['cv_person']){?>
					<?php }else{?>
					<tr>
						<th scope="bo">담당자</th>
						<td>
						<!--
							<select name="cv_person">
								<option>담당자를 선택하세요</option>
								<option value="임근호"<?php echo $cv['cv_person'] =='임근호'?'selected':'';?>>임근호</option>
								<option value="임근철"<?php echo $cv['cv_person'] =='임근철'?'selected':'';?>>임근철</option>
								<option value="김영선"<?php echo $cv['cv_person'] =='김영선'?'selected':'';?>>김영선</option>
								<option value="이지은"<?php echo $cv['cv_person'] =='이지은'?'selected':'';?>>이지은</option>
								<option value="강동욱"<?php echo $cv['cv_person'] =='강동욱'?'selected':'';?>>강동욱</option>								
								<option value="박유나"<?php echo $cv['cv_person'] =='박유나'?'selected':'';?>>박유나</option>
							</select>
						-->
						<?php echo $cv['cv_person'];?>
						</td>
					</tr>	
					<?php }?>
					<tr>
						<th scope="bo">신청자 이름</th>
						<td>
							<input type="text" name="m_name" value="<?php echo $cv['m_name']; ?>" id=" " size="15" class="frm_input">
						</td>
					</tr>	
					<tr>
						<th scope="bo">신청자아이디</th>
						<td>
							<input type="text" name="m_id" value="<?php echo $cv['m_id']; ?>" id=" " size="25" class="frm_input">
						</td>
					</tr>		
					<tr>
						<th scope="bo">비밀번호</th>
						<td>
							<input type="password" name="m_password" value="<?php echo $cv['m_password']; ?>" id=" " size="25" class="frm_input">
						</td>
					</tr>	
					<tr>
						<th scope="bo">이메일</th>
						<td>
							<input type="text" name="cv_email" value="<?php echo $cv['cv_email']; ?>" id=" " size="30" class="frm_input">
							
						</td>
					</tr>	
					
					<tr>
						<th scope="bo">연락처</th>
						<td>
							<select name="hp1">
								<option value="010"<?php echo substr($cv['cv_hp'],0,3)=='010'?'selected':'';?>>010</option>
								<option value="011"<?php echo substr($cv['cv_hp'],0,3)=='011'?'selected':'';?>>011</option>
								<option value="016"<?php echo substr($cv['cv_hp'],0,3)=='016'?'selected':'';?>>016</option>
								<option value="017"<?php echo substr($cv['cv_hp'],0,3)=='017'?'selected':'';?>>017</option>
								<option value="018"<?php echo substr($cv['cv_hp'],0,3)=='018'?'selected':'';?>>018</option>
								<option value="019"<?php echo substr($cv['cv_hp'],0,3)=='019'?'selected':'';?>>019</option>
							</select>&nbsp-&nbsp
							<input type="text" name="hp2" value="<?php echo substr($cv['cv_hp'],3,-4); ?>"  size="7" class="frm_input">&nbsp-&nbsp
							<input type="text" name="hp3" value="<?php echo substr($cv['cv_hp'],-4); ?>"  size="7" class="frm_input">
						</td>
					</tr>	
					<tr>
						<th scope="bo">문의 제목</th>
						<td>
							<input type="text" name="cv_subject" value="<?php echo $cv['cv_subject']; ?>" id=" " size="50" class="frm_input">
						</td>
					</tr>	
					<tr>
						<th scope="bo">웹주소</th>
						<td>
							<input type="text" name="cv_webaddr" value="<?php echo $cv['cv_webaddr']; ?>" id=" " size="50" class="frm_input">
						</td>
					</tr>	
					<tr>
						<th scope="bo">문의 내용</th>
						<td>
							<textarea name="cv_content"><?php echo $cv['cv_content']; ?></textarea>
						</td>
					</tr>	
					<?php 
						if(!$cv['cv_condition']){ 
						}else{
					?>
					<tr>
						<th scope="bo">진행상황</th>
						<td>
							<!--
							<input type="radio"  id=" "class="frm_input" name="em_condition" value='1' <?php echo $cv['cv_condition']=='1'?'checked':'';?>>접수&nbsp&nbsp&nbsp
							<input type="radio"  id=" "class="frm_input" name="em_condition" value='2' <?php echo $cv['cv_condition']=='2'?'checked':'';?>>처리중&nbsp&nbsp&nbsp
							<input type="radio"  id=" "class="frm_input" name="em_condition" value='3' <?php echo $cv['cv_condition']=='3'?'checked':'';?>>처리완료&nbsp&nbsp&nbsp
							-->
							<?php 
								if($cv['cv_condition']=='1'){ echo '접수'; }
								else if($cv['cv_condition']=='2'){ echo '처리중';}
								else{ echo '처리완료'; }
							?>
						</td>
					</tr>	
					<?php }?>
					</tbody>
					</table>
				</div>
			</div>

			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
			<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/confirm2_btn.png" alt="저장" /></a>
			</div>

</form>
		
			</fieldset>
	</div><!-- /contaner -->
</div><!-- /wrapper -->

<script type="text/javascript">
function sendit(){
	var f=document.modiForm;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=conservatism&type=<?php echo $type; ?>';
	f.submit();
}
</script>



{# s_footer}<!--하단-->