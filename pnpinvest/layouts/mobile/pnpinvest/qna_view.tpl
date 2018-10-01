
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 질문게시판 읽기
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->


<div id="container">
			<div id="sub_content">
				<div class="title_wrap title_bg6">
					<div class="title_wr_inner">
						<h3 class="title2">고객센터</h3>
						<p class="title_add1">공지사항, 문의, 언론보도 자료 및 각종 인터뷰 내용을<br /> 확인하실 수 있습니다.</p>
						<p class="location1"><img src="{MARI_MOBILESKIN_URL}/img/icon3.png" alt="홈" /> > 고객센터 <strong>Q&A</strong></p>
					</div><!-- /title_wr_inner -->
				</div><!-- /title_wrap -->
				
				<div class="service_wrap">
					<ul class="tab_btn1">
						<li><a href="{MARI_HOME_URL}/?mode=notice">공지사항</a></li>
						<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=qna">Q&A</a></li>
						<li><a href="{MARI_HOME_URL}/?mode=media">언론보도</a></li>
					</ul>

					<div class="board_wrap">
						<table class="board_view1">
							<colgroup>
								<col width="80px" />
								<col width="100px" />
								<col width="80px" />
								<col width="" />
								<col width="80px" />
								<col width="100px" />
							</colgroup>
							<tbody>
								<tr>
									<th colspan="6" class="bo_title1">w_subject</th>
								</tr>
								<tr>
									<th>작성자 :</th><td>w_name</td><th>조회수 :</th><td>w_hit</td><th>등록일 :</th><td>w_datetime</td>
								</tr>
								<!-- <tr>
									<th>첨부파일 :</th><td colspan="5"></td>
								</tr> -->
								<tr>
									<td colspan="6" class="bo_cont1">w_content</td>
								</tr>
							</tbody>
						</table><!-- /board_view1 -->
						<div class="btn_wrap4">
							<span class="fl_l">
								<a href="{MARI_HOME_URL}/?mode=qna"><img src="{MARI_MOBILESKIN_URL}/img/list_btn.png" alt="목록" /></a>
							</span>
							<span class="fl_r">
								<!-- <a href="#"><img src="{MARI_MOBILESKIN_URL}/img/reply_btn.png" alt="답변" /></a> -->
								<a href="#"><img src="{MARI_MOBILESKIN_URL}/img/modify_btn.png" alt="수정" /></a>
								<a href="#"><img src="{MARI_MOBILESKIN_URL}/img/delete_btn.png" alt="삭제" /></a>
							</span>
						</div>
					</div><!-- /board_wrap -->
				</div><!-- /service_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->


		

{# skin1_footer}<!--하단-->
