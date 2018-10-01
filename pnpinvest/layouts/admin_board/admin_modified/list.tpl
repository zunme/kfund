<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN client_new02.tpl
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
			<div class="sBox01">
			  <h3>수정 요청 목록</h3>
			<div class="btn_client ">
				<a class="btn_holdin01" href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=<?php echo $gr_id;?>&table=<?php echo $table;?>&subject=수정요청&skin=admin_modified">전체목록</a>
			</div>
			   <div class="sBoxinner">
				<form name="fsearch"  method="get" enctype="">
				<input type="hidden" name="cms" value="cs_bbs_list">
				<input type="hidden" name="sh" value="Y">
				<input type="hidden" name="table" value="<?php echo $table;?>">
				<input type="hidden" name="group" value="<?php echo $group;?>">
				<input type="hidden" name="gr_id" value="<?php echo $gr_id;?>">
				<input type="hidden" name="subject" value="<?php echo $subject;?>">
				<input type="hidden" name="skin" value="<?php echo $skin;?>">
					 <ul class="sBoxul3">

						<li>
							  <p>제목</p>
							  <p><input type="text" name="w_subject" value="<?php echo $w_subject;?>"/></p>
						</li>
						<li>
							   <p></p>
							   <p></p>
							   <p>
								 <select name="search_date" id="h1">
									<option  value="접수일" <?php echo $search_date=='접수일'?'selected':''?>>접수일</option>
									<option value="처리예정일" <?php echo $search_date=='처리예정일'?'selected':''?>>처리예정일</option>
								 </select>
								  </p>
							   <p><input type="text" id="datepicker1" name="datepro" value="<?php echo $datepro;?>"></p>
						</li>
						<!--<li>
						   <p>업무분류</p>
						   <p>
								 <select name="w_catecode" id="h1">
									<option  value="전체" <?php echo $w_catecode=='전체'?'selected':''?>>전체</option>
									<option value="수정요청" <?php echo $w_catecode=='수정요청'?'selected':''?>>수정요청</option>
									<option  value="디자인" <?php echo $w_catecode=='디자인'?'selected':''?>>디자인</option>
									<option value="퍼블리싱" <?php echo $w_catecode=='퍼블리싱'?'selected':''?>>퍼블리싱</option>
									<option value="개발" <?php echo $w_catecode=='개발'?'selected':''?>>개발</option>
									<option value="기타" <?php echo $w_catecode=='기타'?'selected':''?>>기타</option>
								 </select>
						   </p>
						</li>-->
					 </ul>
					 <ul class="sBoxul4">
						<li>
						  <p>상태</p>
							<p>
							   <input type="radio" name="modifiedstaut" id="ra1" value="all" <?php echo $modifiedstaut=='all'?'checked':''?>><label for="ra1">전체</label>
							   <input type="radio" name="modifiedstaut" id="ra2" value="W" <?php echo $modifiedstaut=='W'?'checked':''?>> <label for="ra2">접수</label>
							   <input type="radio" name="modifiedstaut" id="ra3" value="A" <?php echo $modifiedstaut=='A'?'checked':''?>> <label for="ra3">담당자 배정</label>
							   <input type="radio" name="modifiedstaut" id="ra4" value="P" <?php echo $modifiedstaut=='P'?'checked':''?>> <label for="ra4">진행중</label>
							   <input type="radio" name="modifiedstaut" id="ra5" value="C" <?php echo $modifiedstaut=='C'?'checked':''?>> <label for="ra5">완료</label>
							   <input type="radio" name="modifiedstaut" id="ra6" value="R" <?php echo $modifiedstaut=='R'?'checked':''?>> <label for="ra6">재문의</label>
						   </p>
						</li>
						<li><input type="image" src="{MARI_ADMINSKIN_URL}/img/serc.png" src="" alt="" /></li>
					 </ul>
				</form>
			   </div>
			
			</div>

			<div class="sBox02">
				  <p>총 <?php echo number_format($total_count);?>건</p>

				  <div> 
					   <form name="rowsearch" method="get" enctype="">
						<input type="hidden" name="cms" value="cs_bbs_list">
						<input type="hidden" name="sh" value="Y">
						<input type="hidden" name="table" value="<?php echo $table;?>">
						<input type="hidden" name="gr_id" value="<?php echo $gr_id;?>">
						<input type="hidden" name="group" value="<?php echo $group;?>">
						<input type="hidden" name="subject" value="<?php echo $subject;?>">
						<input type="hidden" name="skin" value="<?php echo $skin;?>">
							 <select name="row_type" id="row_type" onchange="submit()">
								<option value="15" <?php echo get_selected($_GET['row_type'], "15");?>>15</option>
								<option value="30" <?php echo get_selected($_GET['row_type'], "30");?>>30</option>
								<option value="60" <?php echo get_selected($_GET['row_type'], "60");?>>60</option>
						   </select>
							<span>개씩 출력</span>
					   </form>
				  </div>
				 <div class="btn_client ">
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w&table=<?php echo $table;?>&gr_id=<?php echo $gr_id;?>&skin=<?php echo $skin;?>">수정요청</a>
				</div>
			</div>
		   <div class="sBox03">
						<table class="sBox03T1">
						   <colgroup>
							   <col style="width:auto; ">
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
								  <!-- <th>회사명</th>-->
								   <th>분류</th>
								   <th>제목</th>
								   <th>접수일</th>
								   <th>처리예정일</th>
								   <th>담당자</th>
									<!--<th>긴급</th>-->
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
								$sql = " select count(*) as cnt from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' and co_view='Y'";
								$cocnt = sql_fetch($sql);
								
								$cotop= $cocnt['cnt'];
								/*가장최근 뎃글의 완료여부가져옴*/
								$sql = " select * from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' order by co_datetime desc";
								$useck = sql_fetch($sql);
								?>
							<!--<tr class="<?php if(!$cotop){?><?php }else{?>recently01<?php }?>">-->
							<tr>
							   <td><?php echo $list['w_id'];?></td>
							   <!--<td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>"><?php echo $list['w_company_name'];?></a></td>-->
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>"><!--<?php echo $group_name['gr_subject'];?>--><?php echo $list['w_catecode'];?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>">
									   <!--[<?php echo $list['w_catecode'];?>]-->
										<?php if(!$bbs_config[bo_subject_len]){?>
											<?php echo $list['w_subject'];?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)</b><?php }?>
										<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)<?php }?></b>
										<?php }?>
									   </a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>"><?php echo substr($list['w_datetime'],0,10); ?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>"><?php echo $useck['datepro']?''.substr($useck[datepro],0,10).'':'미정';?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>"><?php echo $list['w_name'];?></a></td>
							   <!--<td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>">O</a></td>-->
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&gr_id=<?php echo $gr_id;?>&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=<?php echo $skin;?>">
							   <?php if($list['w_projectstatus']=="W"){?>
							   <p class="colorstatus1" style="background:#f39c12;">접수</p>
							   <?php }else if($list['w_projectstatus']=="C"){?>
							   <p  class="colorstatus1" style="background:#009abf;">완료</p>
							   <?php }else if($list['w_projectstatus']=="P"){?>
							   <p  class="colorstatus1" style="background:#00a65a">진행중</p>
							   <?php }else if($list['w_projectstatus']=="R"){?>
							   <p  class="colorstatus1" style="background:#dd4b39;">재문의</p>
							    <?php }else if($list['w_projectstatus']=="A"){?>
							  <p  class="colorstatus1" style="background:#143fa1; font-size:12px;">담당자배정</p>
							   <?php }?>

							   <!--<p class="colorstatus1" style="background:#f39c12;">접수</p>
							  
								  <p  class="colorstatus1" style="background:#009abf;">완료</p> 
									<p  class="colorstatus1" style="background:#dd4b39;">재문의</p> --></a></td>

							</tr>
						<?php
							}
						if ($i == 0)
							echo "<tr><td colspan=9>접수된 내용이 없습니다.</td></tr>";
						?>		
						 </tbody>
				   </table>
			 
				 <div class="company-page3">
			<!--패이징--><!--<?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?cms='.$cms.'&group='.$gr_id.'&table='.$table.'&subject='.$subject.'&all='.$all.'&skin='.$skin.''.$qstr.'&amp;page='); ?>-->
					<?php $paging_search = '&w_subject='.$w_subject.'&search_date='.$search_date.'&datepro='.$datepro.'$modifiedstaut='.$modifiedstaut;?>
					<?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?cms='.$cms.'&sh='.$sh.'&group='.$gr_id.'&table='.$table.'&subject='.$subject.'&all='.$all.$paging_search.'&skin='.$skin.'&row_type='.$_GET['row_type'].''.$qstr.'&amp;page='); ?>
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
		  
		  </div>
		
		</div><!-- client_containerinner -->
	</div><!-- client_container -->
</div><!-- /wrapper -->

<script>

	$(function() {
		$('#datepicker1').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
			dateFormat: "yy-mm-dd",
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});

</script>

{# s_footer}<!--하단-->