<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN client_new04.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="client_container">
		<div class="client_containerinner">
		
			<h3>수정요청 확인</h3>
			<div class="ok">
					<div class="receipt_write c_receipt_write" style="border-top: 3px solid #f39c12;">
						<div class="title">
							<h5>접수내용</h5>
						</div>
						<form action="" method="">
						<fieldset>
						<legend>접수내용</legend>
						<table width="100%" summary="접수내용을 위한 창">
						<caption>접수내용</caption>
						<colgroup>
						<col width="170px">
						<col width="*">
						</colgroup>
							<tbody>
							<tr>
								<th>회사명</th>
								<td><?php echo $user['w_company_name']?>(주) 인투윈소프트</td>
							</tr>
							<tr>
								<th>처리담당자</th>
								<td><?php echo $w['w_name'];?></td>
							</tr>
							<tr class="write">
								<th>내용</th>
								<td>
									<p>
									<?php echo $w['w_content']?>
									</p>
								</td>
							</tr>
							<tr>
								<th>URL</th>
								<td ><?php echo $w['w_url_path']?></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td ><a href="{MARI_DATA_URL}/file/<?php echo $w[w_id]?>/<?php echo $w[file_img];?>" download target="_blank"><?php echo $w[file_img];?></a></td>
							</tr>

						</tbody>
						</table>
						</fieldset>
						</form>
					</div><!-- receipt_write -->
						
										{#cs_bbs_comment}

					<p class="btn_hold">
						<a class="btn_holdin01" href="{MARI_HOME_URL}/?cms=cs_bbs_list&table=client_revise">목록</a>
						<a class="btn_holdin" href="javascript:;">다시 문의하기</a>
					</p>

					<div class="receipt_memo"style="display:none; border-top: 3px solid #3c8dbc;">
					<table width="100%" summary="다시 문의하기위한 창">
						<colgroup>
						<col width="135px">
						<col width="*">
						</colgroup>
							<tbody>
							<tr class="re_memo">
								<th><label for="w_5">다시 문의 작성</label></th>
								<td><textarea name="" id="w_5" placeholder="더욱 정확한 상담을 위하여 최대한 자세히 작성하여 주시기 바랍니다."></textarea></td>
							</tr>
							</tbody>
						</table>
						<a href="javascript:;" class="memo_close">닫기</a>
					</div><!--receipt_memo f-->
				 <script>
					$(function(){
					  var ex_show = $('.btn_holdin');
					  var ex_hide = $('.memo_close');
					  var ex_box = $('.receipt_memo');
					  ex_show.click(function(){
						ex_box.slideDown(1000);
						/*ex_show.hide();*/
					  });
					  ex_hide.click(function(){
						ex_box.slideUp(1000);
						ex_show.show();
					  });
					});
			</script>
					<p class="btn_hold">
						<a href="">접수</a>
					</p>
			</div><!-- ok f -->













		</div><!-- client_containerinner -->
	</div><!-- client_container -->
</div><!-- /wrapper -->
<script>


	$(function() {
		$('#w_2').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});
	
	

</script>
{# s_footer}<!--하단-->