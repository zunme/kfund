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
				  <li class="on"><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&type=w_project&table=projectstatus&subject=프로젝트현황">신규프로젝트</a></li>
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
					 <div class="inputT">
						 <h3>신규프로젝트 입력 </h3>
						 <p><span>*</span>필수 입력 항목입니다.</p>
					</div>
				  <form name="new_project_form"  method="post" action="javascript:New_Project_OK();" enctype="multipart/form-data">  
				  <input type="hidden" name="type" value="<?php echo $type;?>">
				  <input type="hidden" name="table" value="<?php echo $table; ?>">
				<input type="hidden" name="subject" value="<?php echo $subject; ?>">
				<input type="hidden" name="m_id" value="<?php echo $mysv[sale_code]?>"><!--아이디는 해당 상점 code로한다-->
				<input type="hidden" name="w_name" value="<?php echo $user['m_name']; ?>">

					<div class="inputB">

						<table class="newprojectT">
						   <colgroup>
										<col style="width:147px; ">
										<col style="width:auto; ">
										<col style="width:147px; ">
										<col style="width:auto; ">
							</colgroup>
							<tbody>
							  <tr class="newprojectT1">
								<th class="borderN"><span>*</span>회사명</th>
								<td><input type="text "name="w_company_name" value="" id=""  required/></td>
								<th><span>*</span>담당자</th>
								<td><input type="text "name="w_company_manager" value="" id="" required/ ></td>
							  </tr>
							   <tr  class="newprojectT2">
								<th class="borderN"><span>*</span>연락처</th>
								<td> 
										 <select name="hp1" required style="">
											<option>선택</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="019">019</option>
										</select><span> -</span>
										<input type="text" name="hp2" value="" id="" required/><span> -</span>
										<input type="text" name="hp3" value="" id="" required/> 
								</td>
								<th><span>*</span>이메일</th>
								<td><input type="email" name="w_company_email" value="" id=""  required/>
										
							  </tr>
							  <tr  class="newprojectT3">
								<th class="borderN"><span>*</span>프로젝트명</th>
								<td colspan="3">
										<input type="text" name="w_project_name" value="" id=""  required/>
								</td>
							  </tr>
							   <tr class="newprojectT4">
								<th class="borderN">디자인</th>
								<td><input type="number" name="w_design_pct" value="" />
								      <span>%</span>
									  <input type="checkbox" name="w_design_chk" value="완료">완료
								</td>
								<th>일정</th>
								<td><input type="text" id="datepicker1"/><span>~</span><input type="text"  id="datepicker2"/></td>
							  </tr>
								<tr  class="newprojectT4">
								<th class="borderN">퍼블리싱</th>
								<td><input type="number" name="w_publishing_pct" value="" />
								      <span>%</span>
									  <input type="checkbox" name="w_publishing_chk" value="완료">완료
								</td>
								<th>일정</th>
								<td><input type="text" id="datepicker3" /><span>~</span><input type="text" id="datepicker4"/></td>
							  </tr>
								<tr  class="newprojectT4">
								<th class="borderN">개발</th>
								<td><input type="number" name="w_develop_pct" value="" />
								      <span>%</span>
									<input type="checkbox" name="w_develop_chk" value="완료">완료
								</td>
								<th>일정</th>
								<td><input type="text"   id="datepicker5"/><span>~</span><input type="text"  id="datepicker6"/></td>
							  </tr>
							   <tr  class="newprojectT5">
								<th class="borderN"><span>*</span>프로젝트상태</th>
								<td>        
								   <input type="radio" name="w_projectstatus" id="" value="대기"><label for="대기">대기</label>
								   <input type="radio" name="w_projectstatus" id="" value="진행중"> <label for="진행중">진행중</label>
								   <input type="radio" name="w_projectstatus" id="" value="완료처리"> <label for="완료처리">완료처리</label>
								 
							   </td>
								<th>프로젝트 완료일</th>
								<td><input type="text" name="w_project_complete" value=""/></td>
							  </tr>
							  
							   <tr class="newprojectT6">
								<th class="borderN">디자인 담당자</th>
								<td class="manager_td">   
									<table id="manager01">
										<?php if($proj_list['w_design_manager']){
//											$w_proj_list = explode("[RECORD]",$proj_list['w_design_manager']);
											$w_proj_list = explode("[FIELD]",$proj_list['w_design_manager']);
											if($proj_list['w_design_manager']!=""){
												for($i=0;$i<count($w_proj_list);$i++){
//													$tmp_option = explode("[FIELD]",$w_proj_list[$i]);
													$tmp_option = $w_proj_list[$i];
										?>
													<tr>
													<td><input type="text" name="w_design_manager[]" value="<?php echo $tmp_option;?>" id=""  /><span><a href="javascript:void(0);" onclick="add_row()">+</a></span></td>
													</tr>
										<?}}}else{?>
													<tr>
													<td><input type="text" name="w_design_manager[]" value="<?php echo $tmp_option;?>" id=""  /><span><a href="javascript:void(0);" onclick="add_row()">+</a></span></td>
													</tr>
										<?}?>
									</table>
								</td>
								<th>퍼블리싱 담당자</th>
								<td class="manager_td">
									<table id="manager02">
										<?php if($proj_list['w_publishing_manager']){
//											$w_proj_list = explode("[RECORD]",$proj_list['w_design_manager']);
											$w_proj_list = explode("[FIELD]",$proj_list['w_publishing_manager']);
											if($proj_list['w_publishing_manager']!=""){
												for($i=0;$i<count($w_proj_list);$i++){
//													$tmp_option = explode("[FIELD]",$w_proj_list[$i]);
													$tmp_option = $w_proj_list[$i];
										?>
											<tr>
											<td><input type="text" name="w_publising_manager[]" value="<?php echo $tmp_option;?>" id=""  /><span><a href="javascript:void(0);" onclick="add_row2()">+</a></span></td>
											</tr>
										<?}
										}}else{?>
											<tr>
											<td><input type="text" name="w_publising_manager[]" value="" id=""  /><span><a href="javascript:void(0);" onclick="add_row2()">+</a></span></td>
											</tr>
										<?}?>
									</table>
								</td>
							  </tr>
							   <tr class="newprojectT6">
								<th class="borderN">개발 담당자</th>
								<td class="manager_td">
									<table id="manager03">
										<?php if($proj_list['w_develop_manager']){
//											$w_proj_list = explode("[RECORD]",$proj_list['w_design_manager']);
											$w_proj_list = explode("[FIELD]",$proj_list['w_develop_manager']);
											if($proj_list['w_develop_manager']!=""){
												for($i=0;$i<count($w_proj_list);$i++){
//													$tmp_option = explode("[FIELD]",$w_proj_list[$i]);
													$tmp_option = $w_proj_list[$i];
										?>
										<tr>
										<td><input type="text" name="w_develop_manager[]" value="<?php echo $tmp_option;?>" id=""  /><span><a href="javascript:void(0);" onclick="add_row3()">+</a></span></td>
										</tr>
										<?}
										}}else{?>
											<tr>
											<td><input type="text" name="w_develop_manager[]" value="" id=""  /><span><a href="javascript:void(0);" onclick="add_row3()">+</a></span></td>
											</tr>
										<?}?>
									</table>
								</td>
								<th>검수 담당자</th>
								<td class="manager_td">
									<table id="manager04">
										<?php if($proj_list['w_inspection_manager']){
//											$w_proj_list = explode("[RECORD]",$proj_list['w_design_manager']);
											$w_proj_list = explode("[FIELD]",$proj_list['w_inspection_manager']);
											if($proj_list['w_inspection_manager']!=""){
												for($i=0;$i<count($w_proj_list);$i++){
//													$tmp_option = explode("[FIELD]",$w_proj_list[$i]);
													$tmp_option = $w_proj_list[$i];
										?>
										<tr>
										<td><input type="text" name="w_inspection_manager[]" value="<?php echo $tmp_option;?>" id=""  /><span><a href="javascript:void(0);" onclick="add_row4()">+</a></span></td>
										</tr>
										<?}
										}}else{?>
											<tr>
											<td><input type="text" name="w_inspection_manager[]" value="" id=""  /><span><a href="javascript:void(0);" onclick="add_row4()">+</a></span></td>
											</tr>
										<?}?>
									</table>
								        <!--플러스 눌렀을때 나오는 부분-->
										<!--<input type="text" name="" value="" id=""  /><span>+</span><span> -</span>-->
								</td>
							  </tr>
							   <tr class="newprojectT7">
								<th class="borderN1">첨부파일</th>
								<td colspan="3" class="borderN1 file_td">
									<table id="project_file">
										<?php if($proj_file['file_img']){
											$w_proj_file = explode("[FIELD]",$proj_file['file_img']);
											if($proj_file['file_img']!=""){
												for($i=0;$i<count($w_proj_file);$i++){
												$tmp_option = $w_proj_file[$i];
										?>
										<tr>
											<td><input type="file" name="file_name[]" class="frm_input" value="<?php echo $tmp_option;?>"><span><a href="javascript:void(0);" onclick="add_row5()">+</a></span></td>
										</tr>
										<?}}}else{?>
											<tr>
												<td><input type="file" name="file_name[]" class="frm_input" value=""><span><a href="javascript:void(0);" onclick="add_row5()">+</a></span></td>
											</tr>
										<?}?>
									</table>
								</td>
							  </tr>

							</tbody>
							   
						</table>

					  </div>
					  <div class="submitE">
						 <input type="submit" value="확인"/>
						 <!--<a href="#" id="new_project_add">확인</a>-->
					 </div>
					 </form>      	   
			  </div>
			
      </div><!-- /containerinner -->
    </div><!-- /container001 -->
</div><!-- /wrapper -->
<script>
//$(function(){
//	$('#new_project_add').click(function(){
//		New_Project_OK(document.new_project_form);
//	});
//});

	function New_Project_OK(){

		f = document.new_project_form;

		if(!f.w_company_name.value){alert("\n회사명을 입력해주세요.");return false;}
		if(!f.w_company_manager.value){alert("\n담당자를 입력해주세요.");return false;}
		if(f.hp1[0].selected == true){alert('\n휴대폰번호 첫째자리를 선택하세요');return false;}
		if(!f.hp2.value){alert('\n휴대폰번호 둘째자리를 입력하세요');return false;}
		if(!f.hp3.value){alert('\n휴대폰번호 셋째자리를 입력하세요');return false;}
		if(!f.w_company_email.value){alert('\n이메일을 입력하세요');return false;}
		if(!f.w_project_name.value){alert('\n프로젝트명을 입력하세요');return false;}

		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if(exptext.test(f.w_company_email.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.company_email.focus(); return false;
		}

		f.method = 'post';
//		f.action = '{MARI_HOME_URL}/?update=bbs_write&type=<?php echo $type;?>&table=<?php echo $table?>&subject=<?php echo $subject?>';
		f.action = '{MARI_HOME_URL}/?update=cs_bbs_write&type=<?php echo $type;?>&table=<?php echo $table?>';
		f.submit();
	}



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


		$(function() {
		$('#datepicker3').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});

		$(function() {
		$('#datepicker4').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});

		$(function() {
		$('#datepicker5').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});

		$(function() {
		$('#datepicker6').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});
	
	
	function add_row() {
	  mytable = document.getElementById('manager01');
	  row = mytable.insertRow(mytable.rows.length);
	  cell1 = row.insertCell(0);
	  cell1.innerHTML = "<input type=\"text\" name=\"w_design_manager[]\" value=\"\" class=\"frm_input\" size=\"30\"><span><a href=\"javascript:void(0);\" onclick=\"delete_row(this)\">-</a></span>";
	}
	function add_row2() {
	  mytable2 = document.getElementById('manager02');
	  row = mytable2.insertRow(mytable2.rows.length);
	  cell1 = row.insertCell(0);
	  cell1.innerHTML = "<input type=\"text\" name=\"w_publising_manager[]\" value=\"\" class=\"frm_input\" size=\"30\"><span><a href=\"javascript:void(0);\" onclick=\"delete_row(this)\">-</a></span>";
	}
	function add_row3() {
	  mytable3 = document.getElementById('manager03');
	  row = mytable3.insertRow(mytable3.rows.length);
	  cell1 = row.insertCell(0);
	  cell1.innerHTML = "<input type=\"text\" name=\"w_develop_manager[]\" value=\"\" class=\"frm_input\" size=\"30\"><span><a href=\"javascript:void(0);\" onclick=\"delete_row(this)\">-</a></span>";
	}
	function add_row4() {
	  mytable4 = document.getElementById('manager04');
	  row = mytable4.insertRow(mytable4.rows.length);
	  cell1 = row.insertCell(0);
	  cell1.innerHTML = "<input type=\"text\" name=\"w_inspection_manager[]\" value=\"\" class=\"frm_input\" size=\"30\"><span><a href=\"javascript:void(0);\" onclick=\"delete_row(this)\">-</a></span>";
	}
	function add_row5() {
	  mytable5 = document.getElementById('project_file');
	  row = mytable5.insertRow(mytable5.rows.length);
	  cell1 = row.insertCell(0);
	  cell1.innerHTML = "<input type=\"file\" name=\"file_name[]\" value=\"\" class=\"frm_input\" size=\"30\"><span><a href=\"javascript:void(0);\" onclick=\"delete_row(this)\">-</a></span>";
	}
	function delete_row(f){
		var trHtml = $(f).parent().parent();
		trHtml.remove();
	}


</script>








<input type="text" name="" value="" id=""  /><span>+</span><span> -</span></td>
{# s_footer}<!--하단-->






