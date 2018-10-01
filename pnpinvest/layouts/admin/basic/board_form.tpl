<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 게시판 수정
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">게시판관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">게시판 추가</div>


<form name="board_form"  method="post" enctype="multipart/form-data">

		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>게시판 수정</caption>
				<colgroup>
					<col width="40px" />
					<col width="160px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td class="chk1"></td>
						<th>TABLE</th>
						<td>
						<?php if($type=="m"){?>
						<input type="hidden" name="bo_table" value="<?php echo $bo['bo_table'];?>"/>
						<span class="fb"><?php echo $bo['bo_table'];?></span><a href="{MARI_HOME_URL}/?cms=user_board_list&table=<?php echo $bo['bo_table'];?>&subject=<?php echo $bo['bo_subject'];?>" class="color_bl ml10 fb">바로가기</a>
						<?php }else{?>
						<input type="text" name="bo_table" value="<?php echo $bo['bo_table'];?>" id=""  class="frm_input " size="30" />
						<?php }?>
						</td>
					</tr>
					<tr>
						<td class="chk1"></td>
						<th>그룹</th>
						<td>
							<select name="gr_id">

								<?php
								    for ($i=0; $row=sql_fetch_array($gr_view); $i++) {
								?>
								<option value="<?php echo $row['gr_subject'];?>" <?php if($row['gr_subject']==$bo['gr_id'] || $gr_subject==$row['gr_subject']){?>selected<?php }?>  ><?php echo $row['gr_subject'];?></option>
								<?php }?>
							</select>
							<a href="#" class="color_bl ml10 fb">동일그룹게시판목록</a>
						</td>
					</tr>
					<tr>
						<td class="chk1"></td>
						<th>게시판 제목</th>
						<td>
						<input type="text" name="bo_subject" value="<?php echo $bo['bo_subject'];?>" id=""  class="frm_input " size="30" />
						</td>
					</tr>
					<tr>
						<td class="chk1"></td>
						<th>카운트 조정</th>
						<td>
							<input type="checkbox" name="bo_count" value="Y" <?php echo $bo['bo_count']=='Y'?'checked':'';?>/> <label for="">사용</label>
							<span class="ml10 fb">(현재 게시글수 : <?php echo $board_count;?>, 현재 댓글수 : 0)</span>
						</td> 
					</tr>
					<tr>
						<td class="chk1"></td>
						<th>사용자 링크주소</th>
						<td>
						<a href="{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $bo['bo_table'];?>&subject=<?php echo $bo['bo_subject'];?>">{MARI_HOME_URL}/?mode=bbs_list&table=<?php echo $bo['bo_table'];?></a>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>게시판 관리자</th>
						<td>
							<input type="text" name="bo_admin" value="<?php echo $bo['bo_admin'];?>" id=""  class="frm_input " size="30" />
							<input type="checkbox" name="" id="" class="ml10" /> <label for="">다른 회원의 글쓰기를 금지합니다. </label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" value=""/>--></td>
						<th>목록보기 권한</th>
						<td>
							<select name="bo_list_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_list_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>글읽기 권한</th>
						<td>
							<select name="bo_read_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_01); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_read_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>글쓰기 권한</th>
						<td>
							<select name="bo_write_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_02); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_write_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>글답변 권한</th>
						<td>
							<select name="bo_reply_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_03); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_reply_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>댓글쓰기 권한</th>
						<td>
							<select name="bo_comment_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_04); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_comment_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>업로드 권한</th>
						<td>
							<select name="bo_upload_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_05); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_upload_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>다운로드 권한</th>
						<td>
							<select name="bo_download_level">
								<?php
								    for ($i=0; $row=sql_fetch_array($lv_06); $i++) {
								?>
								<option value="<?php echo $row['lv_level']; ?>" <?php echo $row['lv_level']==$bo['bo_download_level']?'selected':'';?>><?php echo $row['lv_name'];?></option>
								<?php }?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>원글 수정 불가</th>
						<td>
							<input type="text" name="bo_count_modify" value="<?php echo $bo['bo_count_modify'];?>" id=""  class="frm_input " size="2" />
							<span class="ml10 fb">댓글 %개 이상 달리면 수정불가 ( 0 이면 제한 없음 )</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>원글 삭제 불가</th>
						<td>
							<input type="text" name="bo_count_delete" value="<?php echo $bo['bo_count_delete'];?>" id=""  class="frm_input " size="2" />
							<span class="ml10 fb">댓글 %개 이상 달리면 삭제불가 ( 0 이면 제한 없음 )</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>RSS 사용</th>
						<td>	
							<input type="checkbox" name="bo_use_rss" value="Y" <?php echo $bo['bo_use_rss']=='Y'?'checked':'';?>/> <label for="">사용</label>
							<span class="ml5 fb">(<a href="https://ko.wikipedia.org/wiki/RSS" target="_blank" class="color_bl">RSS란?</a>)</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>SNS 보내기 사용</th>
						<td>
							<input type="checkbox" name="bo_use_sns" value="Y" <?php echo $bo['bo_use_sns']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>댓글 사용</th>
						<td>
						<input type="checkbox" name="bo_use_comment" value="Y" <?php echo $bo['bo_use_comment']=='Y'?'checked':'';?>/> <label for="">사용</label>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>분류설정</th>
						<td>
						<input type="text" name="bo_category_list" value="<?php echo $bo['bo_category_list'];?>" id=""  class="frm_input " size="50" /> <label for="">사용</label><input type="checkbox" name="bo_use_category" value="Y" <?php echo $bo['bo_use_category']=='Y'?'checked':'';?>/> <span class="ml10 fb">","로 구분 예)분류1,분류2</span>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>글쓴이 사이드뷰</th>
						<td>
							<input type="checkbox" name="bo_use_sideview" value="Y" <?php echo $bo['bo_use_sideview']=='Y'?'checked':'';?>/> <label for="">사용</label>
							<span class="ml10 fb">( 글쓴이 클릭시 나오는 레이어 메뉴 ) </span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>비밀글 사용</th>
						<td>
							<select name="bo_use_secret">
								<option value="사용하지 않음" <?= $bo['bo_use_secret'] == "사용하지 않음"?"selected":"" ?>  >사용하지 않음</option>
								<option value="체크박스" <?= $bo['bo_use_secret'] == "체크박스"?"selected":"" ?>  >체크박스</option>
								<option value="무조건" <?= $bo['bo_use_secret'] == "무조건"?"selected":"" ?>  >무조건</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>Editor 사용</th>
						<td>
							<input type="checkbox" name="bo_use_editor" value="Y" <?php echo $bo['bo_use_editor']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>이름(실명) 사용</th>
						<td>
							<input type="checkbox" name="bo_use_name" value="Y" <?php echo $bo['bo_use_name']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>IP 보이기 사용</th>
						<td>
							<input type="checkbox" name="bo_use_ip_view" value="Y" <?php echo $bo['bo_use_ip_view']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>전체목록 보이기 사용</th> 
						<td>
							<input type="checkbox" name="bo_use_list_view" value="Y" <?php echo $bo['bo_use_list_view']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>게시판 메일발송 사용</th> 
						<td>
						<input type="checkbox" name="bo_use_email" value="Y" <?php echo $bo['bo_use_email']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>Code Syntax 사용</th> 
						<td>
							<input type="checkbox" name="bo_use_syntax" value="Y" <?php echo $bo['bo_use_syntax']=='Y'?'checked':'';?>/> <label for="">사용</label>
							<span class="ml5 fb">(<a href="http://alexgorbatchev.com/SyntaxHighlighter/" target="_blank" class="color_bl">SyntaxHighlighter</a>)</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>스킨 디렉토리</th> 
						<td>
							<?php echo get_skin_select('board', 'bo_skin_'.$i, "bo_skin", $bo['bo_skin']); ?>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>페이지당 게시글 수</th> 
						<td>
							<input type="text" name="bo_page_rows" value="<?php echo $bo['bo_page_rows'];?>" id=""  class="frm_input " size="7" />
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>페이지당 댓글 수</th> 
						<td><input type="text" name="bo_page_rows_comt" value="<?php echo $bo['bo_page_rows_comt'];?>" id=""  class="frm_input " size="7" /></td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>제목 길이</th> 
						<td>
							<input type="text" name="bo_subject_len" value="<?php echo $bo['bo_subject_len'];?>" id=""  class="frm_input " size="7" />
							<span class="ml10 fb">목록에서의 제목 글자수</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>new 이미지</th> 
						<td>
							<input type="text" name="bo_new" value="<?php echo $bo['bo_new'];?>" id=""  class="frm_input " size="7" />
							<span class="ml10 fb">글 입력후 new 이미지를 출력하는 시간</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>hot 이미지</th> 
						<td>
							<input type="text" name="bo_hot" value="<?php echo $bo['bo_hot'];?>" id=""  class="frm_input " size="7" />
							<span class="ml10 fb">조회수가 설정값 이상이면 hot 이미지 출력</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>이미지 가로 크기</th> 
						<td>
							<input type="text" name="bo_image_width" value="<?php echo $bo['bo_image_width'];?>" id=""  class="frm_input " size="7" />
							<span class="ml10 fb">픽셀 (게시판에서 출력되는 이미지의 가로 크기)</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>이미지 세로 크기</th> 
						<td>
							<input type="text" name="bo_image_height" value="<?php echo $bo['bo_image_height'];?>" id=""  class="frm_input " size="7" />
							<span class="ml10 fb">픽셀 (게시판에서 출력되는 이미지의 세로 크기)</span>
						</td>
					</tr>

					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>답변달기</th> 
						<td>
							<select name="bo_reply_order">
								<option value="나중에 쓴 답변 아래도 달기(기본)" <?= $bo['bo_reply_order']=="나중에 쓴 답변 아래도 달기(기본)"?"selected":"" ?>  >나중에 쓴 답변 아래도 달기(기본)</option>
								<option value="나중에 쓴 답변 위로 달기" <?= $bo['bo_reply_order']=="나중에 쓴 답변 위로 달기"?"selected":"" ?>  >나중에 쓴 답변 위로 달기</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>리스트 정렬</th> 
						<td>
							<select name="bo_sort_field">
								<option value="w_datetime desc" <?= $bo['bo_sort_field']=="w_datetime desc"?"selected":"" ?>  >날짜 최근것 부터</option>
								<option value="w_datetime asc" <?= $bo['bo_sort_field']=="w_datetime asc"?"selected":"" ?>  >날짜 이전것 부터</option>
								<option value="w_num, w_reply" <?= $bo['bo_sort_field']=="w_num, w_reply"?"selected":"" ?>  >나중에 쓴 답변 아래도 달기(기본)</option>
								<option value="w_hit asc" <?= $bo['bo_sort_field']=="w_hit asc"?"selected":"" ?>  >조회수 낮은것 부터</option>
								<option value="w_hit desc" <?= $bo['bo_sort_field']=="w_hit desc"?"selected":"" ?>  >조회수 높은것 부터</option>
								<option value="w_last asc" <?= $bo['bo_sort_field']=="w_last asc"?"selected":"" ?>  >최근 수정글 이전것 부터</option>
								<option value="w_last desc" <?= $bo['bo_sort_field']=="w_last desc"?"selected":"" ?>  >최근 수정글 최근것 부터</option>
								<option value="w_comment asc" <?= $bo['bo_sort_field']=="w_comment asc"?"selected":"" ?>  >댓글수 낮은것 부터</option>
								<option value="w_comment desc" <?= $bo['bo_sort_field']=="w_comment desc"?"selected":"" ?>  >글수 높은것 부터</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>파일 업로드 확장자</th> 
						<td>
							<input type="text" name="bo_upload_ext" value="<?php echo $bo['bo_upload_ext'];?>" id=""  class="frm_input "  size="50" />
							<span class="ml10 fb">"|"로 구분 (gif, jpg, png 제외)</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>파일 업로그 제한용량</th> 
						<td>
							<input type="text" name="bo_upload_size" value="<?php echo $bo['bo_upload_size'];?>" id=""  class="frm_input " size="20" />
							<span class="ml10 fb">업로드 파일 한개당 %Kbytes 이하( 최대 350M 이하, 1M = 1,024 Kbytes )</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>상단 컨트롤러 경로</th> 
						<td>
							<input type="text" name="bo_head" value="<?php echo $bo['bo_head'];?>" id=""  class="frm_input " size="20" />
							<span class="ml10 fb">컨트롤러 / CSS</span>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>하단 컨트롤러 경로</th> 
						<td><input type="text" name="bo_tail" value="<?php echo $bo['bo_tail'];?>" id=""  class="frm_input " size="20" /></td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>글쓰기 기본 내용</th> 
						<td>
						<textarea name="bo_insert_content" id=""><?php echo $bo['bo_insert_content'];?></textarea></td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>전체 검색 사용</th> 
						<td>
						<input type="checkbox" name="bo_use_search" value="Y" <?php echo $bo['bo_use_search']=='Y'?'checked':'';?>/> <label for="">사용</label>
						</td>
					</tr>
					<tr>
						<td class="chk1"><!--<input type="checkbox" name="" id="" />--></td>
						<th>전체 검색 순서</th> 
						<td>
							<input type="text" name="bo_order_search" value="<?php echo $bo['bo_order_search'];?>" id=""  class="frm_input " size="2" />
							<span class="ml10 fb">숫자가 낮은 게시판 부터 검색</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
				
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm2_btn"  id="board_form_add" title="확인"  />
			<a href="{MARI_HOME_URL}/?cms=board_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록" /></a>
			
		</div>
    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#board_form_add').click(function(){
		Board_form_Ok(document.board_form);
	});
});


function Board_form_Ok(f)
{
	if(!f.bo_table.value){alert('\n게시판명을 입력하여 주십시오.');f.bo_table.focus();return false;}
	if(!f.bo_subject.value){alert('\n게시판 제목을 입력하여 주십시오.');f.bo_subject.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=board_form&type=<?php echo $type;?>';
	f.submit();
}



</script>
{# s_footer}<!--하단-->

