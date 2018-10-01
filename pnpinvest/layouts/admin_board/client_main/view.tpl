<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
if ($_COOKIE['ck_id'] != $id)
	{
		$sql = " update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
		sql_query($sql);
		// 하루 동안만
		setcookie('ck_id',$id,time()+600,'/');
	}
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
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container001">
       <div class="containerinner">
		   <div class="containerheader"> 
				<ul class="supportinb">
				  <li class="on" ><a href="{MARI_HOME_URL}/?cms=customersupport">고객지원</a></li>
				  <li><a href="{MARI_HOME_URL}/?cms=newproject">신규프로젝트</a></li>
				</ul>
			<div class="supportview">
				  <div><a href="">고객지원 전체목록</a></div>
				   <ul>
					<li><p>접수</p><p style="color:#f39c12; "><?php echo number_format($status_W);?></p></li>
					<li><p>진행중</p><p style="color:#00a65a;"><?php echo number_format($status_P);?></p></li>
					<li><p>완료</p><p style="color:#009abf;"><?php echo number_format($status_C);?></p></li>
					<li><p>재문의</p><p style="color:#dd4b39;"><?php echo number_format($status_R);?></p></li>
				   </ul>
				 </div>
			</div><!-- /containerheader -->
			<div class="receipt_content">
				<div class="receipt_view01">
					<div class="view01_1">
						<h3><?php echo $w['w_subject'];?></h3>
						<p>작성자 <span><?php echo $w['w_name'];?></span></p>
						<p><?php echo substr($w['w_datetime'],0,10); ?><!--<span>14:33</span>--></p>
					</div>
					<div class="view01_2">
						<p>
							<?php echo $w['w_content'];?>
							</p>
					</div>
					
				</div><!--receipt_view f-->

				{#cs_bbs_comment}

		 </div><!--receipt_content f-->
	  </div><!-- /containerinner -->
    </div><!-- /container001 -->
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






