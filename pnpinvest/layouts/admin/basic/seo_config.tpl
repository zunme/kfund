<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN SEO설정화면
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">디자인관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container">
<form name="seo_config"  method="post" enctype="multipart/form-data">
		<div class="title02">SEO 설정</div>
	
		<h2 class="bo_title"><span>SEO 설정</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>SEO 설정</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
					<th>웹브라우저 타이틀</th>
					<td><input type="text" name="c_title" value="<?php echo $config['c_title'] ?>" id="c_title" required class="required frm_input" size="40"/></td>
				</tr>
				<tr>
					<th>HTML DTD 설정</th>
					<td>
						<span class="frm_info">HTML 문서 타입을 직접 설정하실 수 있습니다.</span>
					<textarea name="c_dot_type" rows="1" id="c_dot_type" style="height:20px;"><?php echo $config['c_dot_type']; ?></textarea>
					</td>
				</tr>
				<tr>
					<th>로그분석 스크립트설정</th>
					<td>
						<span class="frm_info">로그분석 스크립트 코드를 삽입합니다.</span>
						<textarea name="c_analytics" id="c_analytics"><?php echo $config['c_analytics']; ?></textarea>
					</td>
				</tr>
				<tr>
					<th>META 검색 키워드 / META 검색 설명, 기타 META 설정</th>
					<td>
						<span class="frm_info">추가로 사용하실 meta 태그를 입력합니다.</span>
				<?php if(!$config['c_add_meta']){?>
                <textarea name="c_add_meta" id="c_add_meta">
		<meta name="keywords" content="<?php echo $config['c_title'] ?>" ><!--HTML 상단 검색 키워드소스 content=""-->
		<meta name="description" content="<?php echo $config['c_title'] ?>" ><!--HTML 상단 검색설명소스 content=""-->
		</textarea>
				<?php }else{?>
                <textarea name="c_add_meta" id="c_add_meta"><?php echo $config['c_add_meta']; ?></textarea>
				<?php } ?>
					</td>
				</tr>
				<tr>
					<th>호환성보기 차단</th>
					<td>
						<span class="frm_info">인터넷익스플로러의 호환성보기 기능을 사용중인 접속자에게 자동으로 최신버전 기준으로 사이트를 출력하도록 처리합니다.<br>코딩방식에 따라 특정 버전의 브라우저에서 사이트가 깨질수 있으니, 충분한 테스트 후 기능을 설정해 주시기 바랍니다.</span>
				 <input type="checkbox" name="compatible" value="Y"  <?php if($config['compatible']=="Y"){?>checked<?php } ?>> IE 호환성보기 기능을 차단합니다.<b>[현재 : <?php if($config['compatible']=="Y"){?>차단중<?php }else{?>차단하지 않음<?php } ?>]</b>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="submit" value="" class="confirm_btn" title="확인"   id="seo_config_add"/>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->
<script>
/*필수체크*/
$(function() {
	$('#seo_config_add').click(function(){
		Seo_config_Ok(document.seo_config);
	});
});


function Seo_config_Ok(f)
{
	if(!f.c_title.value){alert('\n웹브라우저 타이틀을 입력하여 주십시오.');f.c_title.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=seo_config';
	f.submit();
}



</script>
{# s_footer}<!--하단-->