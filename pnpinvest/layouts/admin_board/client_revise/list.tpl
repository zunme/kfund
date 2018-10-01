<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
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
			  <h3>@@수정 요청 목록</h3>
			   <div class="sBoxinner">
				<form name=""  method="" enctype="">
					 <ul class="sBoxul3">

						<li>
							  <p>회사명</p>
							  <p><input type="text" name="" value="인투윈소프트"/></p>
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
						<li>
						   <p>업무분류</p>
						   <p>
								 <select name="" id="h1">
									<option  value="접수일">접수일</option>
									<option value="처리예정일">처리예정일</option>
								 </select>
						   </p>
						</li>
					 </ul>
					 <ul class="sBoxul4">
						<li>
						  <p>상태</p>
							<p>
							   <input type="radio" name="modifiedstaut" id="ra1" value=""><label for="ra1">전체</label>
							   <input type="radio" name="modifiedstaut" id="ra2" value=""> <label for="ra2">접수</label>
							   <input type="radio" name="modifiedstaut" id="ra3" value=""> <label for="ra3">담당자 배정</label>
							   <input type="radio" name="modifiedstaut" id="ra4" value=""> <label for="ra4">진행중</label>
							   <input type="radio" name="modifiedstaut" id="ra5" value=""> <label for="ra5">완료</label>
							   <input type="radio" name="modifiedstaut" id="ra6" value=""> <label for="ra6">재문의</label>
						   </p>
						</li>
						<li><input type="image" src="{MARI_ADMINSKIN_URL}/img/serc.png" src="" alt="" /></li>
					 </ul>
				</form>
			   </div>
			
			</div>

			<div class="sBox02">
				  <p>총 1,527건</p>

				  <div> 
					   <form name=""  method="" enctype="">
							 <select name="">
								<option  value="15">15</option>
								<option value="30">30</option>
								<option value="60">60</option>
						   </select>
							<span>개씩 출력</span>
					   </form>
				  </div>
				 <div class="btn_client ">
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w&table=client_revise">수정요청</a>
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
								/*뎃글수*/
								$sql = " select count(*) as cnt from mari_comment where w_id='$list[w_id]'";
								$cocnt = sql_fetch($sql);
								$cotop= $cocnt['cnt'];
								/*가장최근 뎃글의 완료여부가져옴*/
								$sql = " select clear_use from mari_comment where w_id='$list[w_id]' order by co_datetime desc";
								$useck = sql_fetch($sql);
								?>
							<tr class="recently01">
							   <td><?php echo $list['w_id'];?></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo $list['w_company_name'];?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo $group_name['gr_subject'];?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo $list['w_subject'];?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo substr($list['w_datetime'],0,10); ?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo substr($list['w_open_date'],0,10); ?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"><?php echo $list['w_name'];?></a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>">O</a></td>
							   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>"> <?php if(!$cotop){?><p  class="colorstatus1" style="background:#00a65a">접수</p><?php }else if($useck['clear_use']=="Y"){?><p  class="colorstatus1" style="background:#009abf;">완료</p><?php }else{?><p  class="colorstatus1" style="background:#00a65a">진행중</p><?php }?>

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
					<ul class="pagination1" >
						<li><a href="?page=1"><span >«</span></a></li>
						<li class="active"><a href="?page=1">1</a></li>
						<li ><a href="?page=2">2</a></li>
						<li><a href="?page=3">3</a></li>
						<li><a href="?page=3"><span >»</span></a></li>
					</ul>
				   </div><!--company-page-->
		  
		  </div>
		
		</div><!-- client_containerinner -->
	</div><!-- client_container -->
</div><!-- /wrapper -->

{# s_footer}<!--하단-->