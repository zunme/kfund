<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/common.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/content.css">
<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/style.css">
<script type="text/javascript" src="{MARI_HOMESKIN_URL}/js/jquery-1.9.1.min.js"></script>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});
</script>
 <div class="loadingWrap">
  <img src="{MARI_HOMESKIN_URL}/img/loader.gif">
</div>
	<div class="terms_wrap">
		<div class="terms_logo"><img src="{MARI_DATA_URL}/favicon/{_config['c_logo']}" alt="{_config['c_title']}"/></div>

		<div id="container">
		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="inquery_pop">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id=""  class="required frm_input">
			<input type="submit" class="search_btn" value="검색">

		</form>
		</div>
		<!-- <h4 class="invest_title5"><?php echo $stype=='loan'?'대출금액':'투자금액';?> : <?php echo number_format($ln_money) ?>원 상환기간 : <?php echo $ln_kigan?>개월 금리 : <?php echo $ln_iyul?>% 상환 방식 : <?php echo $i_repay?></h4> -->
		<form name="inquery_form" method="post" target="pwin"/>
		<table class="type2" style="width:100%;">
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>					
					<th>이름</th>
					<th>아이디</th>
					<th>회원등급</th>
					<th>전화번호</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>

			</thead>
			<tbody>
			<?php 
				for($i=0; $row=sql_fetch_array($imem); $i++){

				$sql = "select  * from  mari_level where lv_level='$row[m_level]'";
				$lv = sql_fetch($sql, false);
			?>
				<tr>
					<td><?php echo $row['m_name']?></td>
					<td><?php echo $row['m_id']?></td>
					<td><?php echo $lv['lv_name']?></td>
					<td><?php echo $row['m_hp']?></td>					
					<td><?php echo $row['m_datetime']?></td>					
					<td>
						<!--<a href="javascript:sendChildValue('<?php echo $row['m_id']?>', '<?php echo $row['m_name']?>', '<?php echo $row['m_hp']?>')"><img src="{MARI_ADMINSKIN_URL}/img/btn_set.png"></a>-->
						<a href="javascript:sendChildValue('<?php echo $row['m_id']?>', '<?php echo $row['m_name']?>', '<?php echo $row['m_hp']?>')"><img src="{MARI_ADMINSKIN_URL}/img/btn_set.png"></a>
					</td>
				</tr>
			<?php }?>
			</tbody>
		</table>
		<div class="paging">
			<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_de_page, '?cms='.$cms.'&my='.$my.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
		</form>
		<script>
		
		function sendChildValue(id,name,hp){
			opener.setChildValue(id, name, hp);
			window.close();
		}
		/*
		var opener = window.dialogArguments;
		function trans_name(){
			var test = document.getElementById('')
		      opener.document.all.m_name.value= document..a.value;
		      window.close();
		   }*/
		</script>

	</div><!-- /terms_wrap -->
