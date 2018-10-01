<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">플러그인/위젯</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
		<div class="title02">최신글 위젯</div>
			<fieldset>
	<form name="config_form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="w"/>
			<!-- 소셜네트워크 서비스 -->
			<div id="anc_cf_sns">
				<h2 class="bo_title"><span>최신글 위젯</span></h2>
				<div class="bo_text">
					<p>
						설정에서 선택하신후 위젯코드를 생성하실 수 있습니다.
					</p>
				</div>
				<div class="tbl_frm01 tbl_wrap">
					<table>
					<caption>SNS 설정</caption>
					<colgroup>
						<col class="grid_4">
						<col>
						<col class="grid_4">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="bo"><label for=" ">설정</label></th>
						<td>
레이아웃스킨 : <?php echo get_skin_select('latest', ''.$i, "c_latest_skin", $c_latest_skin); ?> 게시판코드 : 
							<select name="code">
							<option value="">선택</option>
							<?php 
							for ($i=0;  $row=sql_fetch_array($view_list ); $i++){
							?>

								<option value="<?php echo $row['w_table']; ?>" <?php echo $row['w_table']==$code?'selected':'';?>><?php echo $row['w_table']; ?></option>

							<?php }?>
							</select>
							 리스트갯수 : <input type="text" name="list_row" id=" "value="<?php echo $list_row;?>" size="5" class="frm_input"> 개 제목길이 : <input type="text" name="subject_row" id=" " value="<?php echo $subject_row;?>" size="5" class="frm_input">
							</label>
						</td>
					</tr>
					<tr>
						<th scope="bo"><label for=" ">소스코드</label></th>
						<td colspan="3">
						<input type="text" name="bo_insert_content" id=" "value="<?php if(!$c_latest_skin){?><?php }else{?> {view_list('<?php echo $c_latest_skin;?>', '<?php echo $code;?>', <?php echo $list_row;?>, <?php echo $subject_row;?>);} <?php }?>" size="50" class="frm_input">
						<button onclick="copy_to_clipboard('{view_list(<?=$c_latest_skin?>, <?=$code?>, <?=$list_row?>, <?=$subject_row?>)}');">복사</button>
						</td>
					</tr>

					</tbody>
					</table>
				</div>
			</div>
			<!-- 버튼 확인/목록 -->
			<div class="btn_confirm01 btn_confirm">
				<a href="javascript:void(0);" onclick="sendit()"><img src="{MARI_ADMINSKIN_URL}/img/run_btn.png" alt="실행" /></a>
				<a href="{MARI_HOME_URL}/?cms=admin" class="main_btn"></a>
			</div>
		</form>
			</fieldset>

    </div><!-- /contaner -->
</div><!-- /wrapper -->
 
<script type="text/javascript">
function sendit(){
	var f=document.config_form;
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?cms=latest';
	f.submit();
}

function is_ie() {
  if(navigator.userAgent.toLowerCase().indexOf("chrome") != -1) return false;
  if(navigator.userAgent.toLowerCase().indexOf("msie") != -1) return true;
  if(navigator.userAgent.toLowerCase().indexOf("windows nt") != -1) return true;
  return false;
}
 
function copy_to_clipboard(str) {
  if( is_ie() ) {
    window.clipboardData.setData("Text", str);
    alert("복사되었습니다.");
    return;
  }
  prompt("Ctrl+C를 눌러 복사하세요.", str);
}
</script>

{# s_footer}<!--하단-->






