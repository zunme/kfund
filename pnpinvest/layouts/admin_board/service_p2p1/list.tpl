<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
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
	<div id="client_container">
		<div class="client_containerinner">
			<section class="client_s01">

				<div class="ingstep">
					<h3>문의 현황</h3>
					<div class="btn_client ">
						<!--<a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w&table=<?php echo $table;?>&gr_id=<?php echo $gr_id;?>&skin=<?php echo $skin;?>">문의하기</a>-->
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1">전체목록</a>
					</div>
					 <ul>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon01.png"></p><p>접수<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=W"><?php echo number_format($status_W);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon03.png"></p><p>진행중<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=P"><?php echo number_format($status_P);?></a></span></p></li>
					 <li><p><img style="padding-top:5px;" src="{MARI_ADMINSKIN_URL}/img/service_icon04.png"></p><p>완료<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=C"><?php echo number_format($status_C);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon02.png"></p><p>재문의<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=R"><?php echo number_format($status_R);?></a></span></p></li>
					 </ul>
				 </div><!-- ingstep -->
				 
			</section>
			<section class="client_s02">

				<div>
					<h3>문의현황 목록</h3>
					<div class="btn_client ">
						<!--<a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w&table=<?php echo $table;?>&gr_id=<?php echo $gr_id;?>&skin=<?php echo $skin;?>">문의하기</a>-->
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=modified&subject=클라이언트메인&skin=client_main&imwork_use=Y">서비스다시선택하기</a>
					</div>
				   <div class="sBox03">
									<table class="sBox03T1">
								   <colgroup>
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:270px; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									</colgroup>
								
								<thead>
									<tr>
										<th>번호</th>
										<th>분류</th>
										<th>제목</th>
										<th>접수일</th>
										<th>처리예정일</th>
										<th>담당자</th>
										<th>긴급</th>
										<th>상태</th>
									 </tr>
								 
								</thead>
								<tbody>
							<?php 
							for ($i=0;  $list=sql_fetch_array($result); $i++){
								$sql = "select gr_subject from  mari_board_group where gr_id='$bbs_config[gr_id]'";
								$group_name = sql_fetch($sql, false);
								$num=$i+1;

								/*뎃글수*/
								$sql = " select count(*) as cnt from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' and co_view = 'Y'";
								$cocnt = sql_fetch($sql);
								
								$cotop= $cocnt['cnt'];
								/*가장최근 뎃글의 완료여부가져옴*/
								$sql = " select * from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' order by co_datetime desc";
								$useck = sql_fetch($sql);

								if(substr($useck['datepro'],0,10)=='0000-00-00' || $useck['datepro']==""){
									$date_pro = "미정";
								}else{
									$date_pro = substr($useck['datepro'],0,10);
								}
								
								/*리스트 넘버링 시작- 171012 전인성*/
//								if($page==1){
//									$list_num = $total_count-$i;
//								}else{
//									$list_num = $total_count - (10*($page-1));									
//									if($list_num <= 10){
//										$list_num = $list_num-$i;
//									}else{
//										$list_num = ($total_count - (10*($page-1)))-$i;
//									}
//								}
								if($page==1){
									$list_num = $total_count-$i;
								}else{
									if($row_type){
										$list_num = $total_count - ($row_type*($page-1));									
										if($list_num <= $row_type){
											$list_num = $list_num-$i;
										}else{
											$list_num = ($total_count - ($row_type*($page-1)))-$i;
										}
									}else{
										$list_num = $total_count - (10*($page-1));									
										if($list_num <= 10){
											$list_num = $list_num-$i;
										}else{
											$list_num = ($total_count - (10*($page-1)))-$i;
										}
									}
								}
								/*리스트 넘버링 끝*/
								?>

							<!--<tr class="<?php if(!$cotop){?><?php }else{?>recently01<?php }?>">-->
							<tr>
							   <td><!--<?php echo $list['w_id'];?>--><?php echo $list_num;?></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"><!--<?php echo $group_name['gr_subject'];?>--><?php echo $list['w_catecode'];?></a></td>
							<td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>">
										<?php if(!$bbs_config[bo_subject_len]){?>
											<?php echo $list['w_subject'];?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)</b><?php }?>
										<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)<?php }?></b>
										<?php }?>
									   </a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"><?php echo substr($list['w_datetime'],0,10); ?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"><!--<?php echo $useck['datepro']?''.substr($useck[datepro],0,10).'':'미정';?>--><?php echo $date_pro;?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"><?php echo $list['w_name'];?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"><?php echo $list['urgency']=='Y'?'O':''?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $list['w_table']; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&skin=<?php echo $skin;?>"> <?php if($list['w_projectstatus']=="W"){?><p class="colorstatus1" style="background:#f39c12;">접수</p><?php }else if($list['w_projectstatus']=="C"){?><p  class="colorstatus1" style="background:#009abf;">완료</p><?php }else if($list['w_projectstatus']=="P"){?><p  class="colorstatus1" style="background:#00a65a">진행중</p><?php }else if($list['w_projectstatus']=="R"){?><p  class="colorstatus1" style="background:#dd4b39;">재문의</p><?php }else if($list['w_projectstatus']=="A"){?><p  class="colorstatus1" style="background:#143fa1; font-size:12px;">담당자배정</p><?php }?>

							   <!--<p class="colorstatus1" style="background:#f39c12;">접수</p>
							  
								  <p  class="colorstatus1" style="background:#009abf;">완료</p> 
									<p  class="colorstatus1" style="background:#dd4b39;">재문의</p> --></a></td>

							</tr>
						<?php
							}
						if ($i == 0)
							echo "<tr><td colspan=8>접수된 내용이 없습니다.</td></tr>";
						?>	

								
								 </tbody>
						   </table>
                     
						 <div class="company-page3">
			<!--패이징--><?php echo get_paging($config['c_page_rows'], $page, $total_page, '?cms='.$cms.'&gr_id='.$gr_id.'&table='.$table.'&subject='.$subject.'&status='.$status.'&skin='.$skin.''.$qstr.'&amp;page='); ?>
						 <!--
							<ul class="pagination1" >
								<li><a href="?page=1"><span >«</span></a></li>
								<li class="active"><a href="?page=1">1</a></li>
								<li ><a href="?page=2">2</a></li>
								<li><a href="?page=3">3</a></li>
								<li><a href="?page=3"><span >»</span></a></li>
							</ul>
							-->
						   </div><!--company-page-->
				  
				   </div><!-- sBox03 -->

				</div>
			</section>
		</div><!-- client_containerinner -->



	</div><!-- client_container -->

</div><!-- /wrapper -->

<script>


	$(function() {
		$('#datepicker1').datepicker({
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






