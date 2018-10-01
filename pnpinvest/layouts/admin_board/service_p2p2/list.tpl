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
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
	<div id="container001">
		<div class="containerinner">
		   <div class="containerheader"> 
				<ul class="supportinb">
				  <li class="on"><a href="{MARI_HOME_URL}/?cms=customersupport">고객지원</a></li>
				  <li><a href="{MARI_HOME_URL}/?cms=newproject">신규프로젝트</a></li>
				</ul>
				<div class="supportview">
				  <div><a href="">고객지원 전체목록</a></div>
				   <ul>
					<li><p>접수</p><p style="color:#f39c12; ">5</p></li>
					<li><p>진행중</p><p style="color:#00a65a;">5</p></li>
					<li><p>완료</p><p style="color:#009abf;">3</p></li>
					<li><p>재문의</p><p style="color:#dd4b39;">1</p></li>
				   </ul>
				 </div>
			</div><!-- /containerheader -->
             <div class="containermain">
			   <ul class="customerinb">
					<li class=""><a href="{MARI_HOME_URL}/?cms=newproject">전체</a></li>
				<?php /*그룹*/
				  for ($i=0; $row=sql_fetch_array($group_list); $i++){
				  $sql = "select * from  mari_board where gr_id='$row[gr_id]'";
				  $bolist = sql_query($sql, false);
				?>	

					<?php /*게시판*/
					for ($i=0; $bbs=sql_fetch_array($bolist); $i++){
						/*고객지원:productInquiry 그룹만노출*/
					 ?>
						<li class="<?php echo $table==$bbs[bo_table]?'on':'';?>"><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&table=<?php echo $bbs['bo_table'];?>&group=<?php echo $bbs['gr_id'];?>"><?php echo $bbs['bo_subject'];?></a></li>
					<?php
					}
					?>
				<?php
					}
					if ($i == 0)
				?>
				 </ul>
                <div class="sBox01">
					  <h3>전체</h3>
					   <div class="sBoxinner">
						<form name=""  method="" enctype="">
							 <ul class="sBoxul5">
								<li>
									  <p>회사명</p>
									  <p><input type="text" name="" value="인투윈소프트"/></p>
								</li>
								<li>
									  <p>업무분류</p>
									   <p>
										 <select name="" id="h1">
										    <option  value="전체">전체</option>
											<option  value="디자인">디자인</option>
											<option value="퍼블리싱">퍼블리싱</option>
											<option value="개발">개발</option>
											<option value="기타">기타</option>
                                         </select>
										  </p>
								</li>
								<li>
								   <p>처리담당자</p>
									   <p><input type="text" name="" value="홍길동"/></p>
									   <p> 
										<select name="" id="h1">
											<option  value="접수일">접수일</option>
											<option value="처리예정일">처리예정일</option>
										</select>
										  </p>
                                       <p><input type="text" id="datepicker1"></p>
								</li>
							 </ul>
							 <ul class="sBoxul6">
								<li>
								  <p>상태</p>
								    <p>
									   <input type="radio" name="modifiedstaut" id="" value=""><label for="전체">전체</label>
									   <input type="radio" name="modifiedstaut" id="" value=""> <label for="접수">접수</label>
									   <input type="radio" name="modifiedstaut" id="" value=""> <label for="담당자 배정">담당자 배정</label>
									   <input type="radio" name="modifiedstaut" id="" value=""> <label for="진행중">진행중</label>
									   <input type="radio" name="modifiedstaut" id="" value=""> <label for="완료">완료</label>
									   <input type="radio" name="modifiedstaut" id="" value=""> <label for="재문의">재문의</label>
								   </p>
								</li>
								<li><input type="image" src="{MARI_ADMINSKIN_URL}/img/serc.png"  alt="" /></li>
							 </ul>
						</form>
					   </div>
					
					</div>

					<div class="sBox02">
						  <p>총 1,527건</p>
						  <div> 
						       <form name=""  method="" enctype="">
									 <select name="">
										<option value="15">15</option>
										<option value="30">30</option>
										<option value="60">60</option>
								   </select>
								    <span>개씩 출력</span>
							   </form>
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
										   <th>회사명</th>
										   <th>분류</th>
										   <th>상세분류</th>
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
								?>
									<tr class="recently01">
									   <td><?php echo $list['w_id'];?></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><?php echo $list['w_company_name'];?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><?php echo $group_name['gr_subject'];?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">
									   [<?php echo $list['w_catecode'];?>]
										<?php if(!$bbs_config[bo_subject_len]){?>
											<?php echo $list['w_subject'];?>
										<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?>
										<?php }?>
									   </a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><?php echo substr($list['w_datetime'],0,10); ?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><?php echo substr($list['w_open_date'],0,10); ?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"><?php echo $list['w_name'];?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>">O</a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>"> <p  class="colorstatus1" style="background:#00a65a">진행중</p>
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
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?cms='.$cms.'&group='.$group.'&table='.$table.'&subject='.$subject.''.$qstr.'&amp;page='); ?>
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



           </div>
        </div><!-- /containerinner -->
    </div><!-- /contaner -->
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






