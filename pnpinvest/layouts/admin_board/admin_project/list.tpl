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
				  <li ><a href="{MARI_HOME_URL}/?cms=customersupport">고객지원</a></li>
				  <li class="on"><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w&table=projectstatus">신규프로젝트</a></li>
				</ul>
				<div class="supportview">
				  <div><a href="">수정요청 전체목록</a></div>
				   <ul>
					<li><p>접수</p><p style="color:#f39c12; ">5</p></li>
					<li><p>진행중</p><p style="color:#00a65a;">5</p></li>
					<li><p>재문의</p><p style="color:#dd4b39;">1</p></li>
				   </ul>
				 </div>
			</div><!-- /containerheader -->
			 <div class="containermain">
				  <ul class="newproinb">
					<li ><a href="{MARI_HOME_URL}/?cms=newproject">메인</a></li>
					<li class="on"><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&table=projectstatus&type=w_project&all=Y">!!프로젝트 현황</a></li>
					<li><a href="{MARI_HOME_URL}/?cms=modified">수정요청</a></li>
				 </ul>
					<div class="sBox01">
					  <h3>전체</h3>
					   <div class="sBoxinner">
						<form name=""  method="" enctype="">
							 <ul class="sBoxul1">
								<li>
									  <p>회사명</p>
									  <p><input type="text" name="" value="인투윈소프트"/></p>
								</li>
								<li>
									   <p>업무분류</p>
									   <p>
										 <select name="" id="h1">
											<option>전체</option>
											<option value="디자인">디자인</option>
											<option value="퍼블리싱">퍼블리싱</option>
											<option value="개발">개발</option>
											<option value="검수">검수</option>
										  </select>
										  </p>
								</li>
								<li>
								   <p>상태</p>
								   <p>
									   <input type="radio" name="staut" id="" value=""><label for="전체">전체</label>
									   <input type="radio" name="staut" id="" value=""> <label for="대기">대기</label>
									   <input type="radio" name="staut" id="" value=""> <label for="진행중">진행중</label>
									   <input type="radio" name="staut" id="" value=""> <label for="완료">완료</label>
								   </p>
								</li>
							 </ul>
							 <ul class="sBoxul2">
								<li>
									<p>담당자</p>
									<p><input type="text" name="" value="인투윈소프트"/></p>
								</li>
								<li>
								   <p>완료예정일</p>
								   <p><input type="text" id="datepicker1"/><span> ~</span><input type="text" id="datepicker2"/></p>

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

						 <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w_project&table=projectstatus">신규프로젝트</a></p>
					</div>
				   <div class="sBox03">
								<table class="sBox03T">
								   <colgroup>
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
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
										   <th>진행단계</th>
										   <th style="color:#dd4b39;">디자인</th>
										   <th style="color:#00a65a;">퍼블리싱</th>
										   <th style="color:#f39c12;">개발</th>
										   <th>완료 예정일</th>
											 <th>완료일</th>
										   <th>상태</th>
									 </tr>
								</thead>
								<tbody>
									<?php 
										if($total_count > 0){
											for($i=0; $row=sql_fetch_array($result); $i++){
												$num = $i+1;
									?>			
											<tr> 
												   <td><!--10--><?php echo $num;?></td>
												   <td><a href="">옐로우펀딩<?php echo $row['w_company_name'];?></a></td>
												   <td><a href="">디자인</a></td>
												   <td><a href=""><span  style="color:#dd4b39;"><?php echo $row['w_design_pct'];?>%</span>:홍길동<?php echo $row['w_design_manager'];?></a></td>
												   <td><a href=""><span  style="color:#00a65a;"><?php echo $row['w_publishing_pct'];?>%</span>:이몽룡<?php echo $row['w_publishing_manager'];?></a></td>
												   <td><a href=""><span style="color:#f39c12;"><?php echo $row['w_develop_pct'];?>%</span>:변학도<?php echo $row['w_develop_manager'];?></a></td>
												   <td><a href="">2017.7.1</a></td>
												   <td><a href="">2017.7.1</a></td>
												   <td><a href=""><p class="colorstatus" style="background:#00a65a;">진행중</p><!--<p  class="colorstatus" style="background:#009abf;">완료</p>
												   <p  class="colorstatus" style="background:#dd4b39;">재문의</p>--></a></td>
											</tr>
											<?}}else{?>
												<tr>없다 없어</tr>
											<?}?>
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
                

				 
			  
		   </div>
      </div><!-- /containerinner -->
    </div><!-- /container001 -->
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

	$(function() {
		$('#datepicker2').datepicker({
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






