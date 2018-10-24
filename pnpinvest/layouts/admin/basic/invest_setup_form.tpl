<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
function tohtmlstring($str){
	if($str != strip_tags($str)) return stripslashes($str);
	else {
		$tmparr = preg_split('/\r\n|\r|\n/', $str);
		echo("
		================ tohtmlstring ================
		");
		var_dump($tmparr);
		$str ='';
		foreach($tmparr as $row){
			$str .= "<p>".$row."</p>";
		}
		var_dump($str);
		return $str;
	}
}
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script src="{MARI_PLUGIN_URL}/chart/js/amcharts.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/serial.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/pie.js" type="text/javascript"></script>
<script src="{MARI_PLUGIN_URL}/chart/js/light.js" type="text/javascript"></script>
<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02">투자진행 설정</div>
	<form name="invest_setup_form"  method="post" enctype="multipart/form-data" target="">
	<input type="hidden" name="type" value="<?php echo $type;?>"/>
	<input type="hidden" name="loan_id" value="<?php echo $loan_id;?>"/>
	<input type="hidden" name="i_id" value="<?php echo $iv['i_id'];?>"/>
	<input type="hidden" name="i_invest_endtime" value="<?php echo $iv['i_invest_endtime'];?>"/>
	<!--신용송부재조회 파라매타-->
	<input type=hidden name='user_id' value="<?php echo $config['c_nice_id']?>"/><!--나이스아이디-->
	<input type=hidden name='login_id' value="<?php echo $config['c_nice_login']?>"/><!--나이스로그인아이디-->
	<input type=hidden name='report_no' value="<?php echo $sskey[certno]?>"/><!--재조회 고객번호-->
	<input type=hidden name='cust_nm' value='<?php echo $config['c_nice_company']?>'/><!--점포명-->
	<!--//신용송부재조회 파라매타-->

		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>투자진행 설정</caption>
				<colgroup>
					<col width="140px" />
					<col width="" />
					<col width="140px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th>최상단노출</th>
						<td>
							<input type="radio" name="i_top_view" value="1" <?php echo $iv['i_top_view']=='1'?'checked':'';?> /><label for="" class="mr10">사용</label>
							<input type="radio" name="i_top_view" value="2" <?php echo $iv['i_top_view']=='2'?'checked':'';?> /> <label for="">미사용</label>
						</td>
					</tr>
					<tr>
						<th>상품</th>
						<td colspan="3">
							<select name="i_payment" >
								<option>상품선택</option>
						<?php
						  for ($i=0; $row=sql_fetch_array($cate1); $i++) {
						?>
								<option value="<?php echo $row['ca_id'];?>" <?php echo $row['ca_id']==$loan['i_payment']?'selected':'';?>><?php echo $row['ca_subject'];?></option>
						<?php
						    }
						?>
							</select>

						<?php
						if($order_pay=="100" || $iv['i_look']=="C"){
						/*투자진행율이 마감상태이거나 100%인경우에만 노출*/
						?>
						<!--<a href="{MARI_HOME_URL}/?update=withdrawl_ok">[통장출금]</a>-->
						<a href="javascript:void(0);"  onclick="Withdrawl()">[통장출금]</a>
						<?php }?>
						</td>
					</tr>
					<tr>
						<th>모집시작/종료일</th>
						<td colspan="3">
							<label>시작</label> <input type="text" name="i_invest_sday" value="<?php echo $iv['i_invest_sday'];?>" id=""  class="frm_input datetime" size="" class="mr5" /> ~
							<label class="ml5">종료</label> <input type="text" name="i_invest_eday" value="<?php echo $iv['i_invest_eday'];?>" id=""  class="frm_input datetime" size="" />
						</td>
					</tr>
					<tr>

						<th>최소투자금액(원)</th>
						<td colspan="">
							<input type="text" name="i_invest_mini" value="<?php echo number_format($iv[i_invest_mini]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " size="20" /> <label>원</label>
						</td>
						<th>최대투자율(%)</th>
						<td colspan="">
							<input type="text" name="i_invest_max" value="<?php echo $iv[i_invest_max]; ?>" id=""  class="frm_input " size="20" /> <label>%</label>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="i_invest_name" value="<?php echo $loan['i_subject'];?>" id=""  class="frm_input " size="53" onKeyDown="checkNumber();" /></td>
						<th>신용등급</th>
						<td>
						<input type="text" name="i_invest_level" value="<?php echo $iv['i_invest_level']?$iv[i_invest_level]:$loan[i_creditpoint_two];?>" id=""  class="frm_input " size="10" /> <label>등급</label>
						<!--<a href="javascript:void(0);"  onclick="Calculation()"><b>[신용 정보 조회하기]</b></a>-->
						</td>
					</tr>


					<tr>
						<th>신용평점</th>
						<td><input type="text" name="i_level_point" value="<?php echo $iv['i_level_point']?$iv[i_level_point]:$loan[i_creditpoint_one];?>" id=""  class="frm_input " size="15" /> <label>점</label></td>
						<th>현재투자율</th>
						<td><input type="text" name="i_invest_per" value="<?php echo $order_pay;?>" id=""  class="frm_input " size="15" /><label>%</label></td>
					</tr>

					<tr>
						<th>채무불이행</th>
						<td><input type="text" name="i_debts" value="<?php echo number_format($iv['i_debts'])?>" id=""  class="frm_input " size="15" /> <label>원</label></td>
						<th>신용채무</th>
						<td><input type="text" name="i_credit_debt" value="<?php echo number_format($iv['i_credit_debt'])?>" id=""  class="frm_input " size="15" /><label>원</label></td>
					</tr>
					<tr>
						<th>담보채무</th>
						<td><input type="text" name="i_secured_debt" value="<?php echo number_format($iv['i_secured_debt'])?>" id=""  class="frm_input " size="15" /> <label>원</label></td>
						<th>보증채무</th>
						<td><input type="text" name="i_guaranteed_debt" value="<?php echo number_format($iv['i_guaranteed_debt'])?>" id=""  class="frm_input " size="15" /><label>원</label></td>
					</tr>


					<tr>
						<th>현재 참여인원</th>
						<td><input type="text" name="i_people" value="<?php echo $invest_cn;?>" id=""  class="frm_input " size="15" readonly/><label>명</label></td>
						<th>대출금액</th>
						<td><input type="text" name="i_invest_pay" value="<?php echo number_format($loan['i_loan_pay']);?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " size="15" /><label>원</label></td>
					</tr>
					<tr>
						<th>DTI</th>
						<td><input type="text" name="i_level_dti" value="<?php echo $loan['i_level_dti'];?>" id=""  class="frm_input " size="15" /> %</td>
						<th>이자율</th>
						<td><input type="text" name="i_profit_rate" value="<?php echo $loan['i_year_plus'];?>" id=""  class="frm_input " size="15" /> %</td>
					</tr>
					<tr>
						<th>LTV</th>
						<td><input type="text" name="i_ltv_per" value="<?php echo $iv['i_ltv_per'];?>" id=""  class="frm_input " size="15" /> %</td>
						<th>채무불이행 내역</th>
						<td>
							<input type="radio" name="i_debt_fail" value="Y" <?php echo $iv['i_debt_fail']=='Y'?'checked':'';?> /><label for="" class="mr10">있음</label>
							<input type="radio" name="i_debt_fail" value="N" <?php echo $iv['i_debt_fail']=='N'?'checked':'';?> /> <label for="">없음</label>
						</td>
					</tr>
					<!--<tr>
						<td colspan="4">
							<label><b>▶동일차입자 한도설정</b> ※동일차입자 기준 한도를 작성하여 주십시오. 예)동일차입자 개인투자자한도 <b>"5,000,000"</b>원 <b>무제한</b>일경우 <b>"0"</b>으로 설정 바랍니다.</label>
						</td>
					</tr>-->
					<!--NEW★ 가이드라인에 따른 동일차입자 한도설정 2017-10-10 START-->
						<tr>
							<th>법인투자자 가능한도</th>
							<td><input type="text" name="i_maximum_v" value="<?php echo $iv['i_maximum_v']?''.number_format($iv[i_maximum_v]).'':'0';?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
							<th>일반개인투자자 가능한도</th>
							<td><input type="text" name="i_maximum" value="<?php echo $iv['i_maximum']?''.number_format($iv[i_maximum]).'':'5000000';?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
						</tr>
						<tr>
							<th>전문투자자 가능한도</th>
							<td><input type="text" name="i_maximum_pro" value="<?php echo $iv['i_maximum_pro']?''.number_format($iv[i_maximum_pro]).'':'0';?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
							<th>소득적격투자자 가능한도</th>
							<td><input type="text" name="i_maximum_in" value="<?php echo $iv['i_maximum_in']?''.number_format($iv[i_maximum_in]).'':'20000000';?>" id="" class="frm_input " required size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label for="">원</label></td>
						</tr>
					<!--NEW★ 가이드라인에 따른 동일차입자 한도설정 2017-10-10 END-->
					<tr>
					<tr>
						<th>상환예정일</th>
						<td colspan="3">
							<input type="text" name="i_repay_plan" value="<?php echo $iv['i_repay_plan'];?>" id=""  class="frm_input calendar" size="" class="mr5" />
						</td>
					</tr>
					<tr>
						<th>상환방식</th>
						<td colspan="3">
							<input type="text" name="i_repay_way" value="<?php echo $iv[i_repay_way];?>" id="" class="frm_input " size="100" /> <label></label>
						</td>
					</tr>
					<tr>
						<th>상환재원</th>
						<td colspan="3">
							<input type="text" name="i_repay_info" value="<?php echo $iv[i_repay_info];?>" id="" class="frm_input " size="100" /> <label></label>
						</td>
					</tr>
					<tr>
						<th>메인사진</th>
						<td colspan="3">
						<p>※파일형식은 jpg, png, gif만 지원합니다.</p>
						    <input type="file" name="i_creditratingviews" size="10">
					    <?php
							    $bimg_str = "";
							    $bimg_01 = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_creditratingviews']."";
							    if (file_exists($bimg_01) && $iv['i_creditratingviews']) {
								$size = @getimagesize($bimg_01);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_01" value="1" id="bn_bimg_del_01"> <label for="bn_bimg_del_01">삭제하기</label>';
								$bimg_str_01 = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id.'/'.$iv['i_creditratingviews'].'" style="width:1000px;" >';
							    }
						    if ($bimg_str_01) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_01;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<tr>
						<th>상세이미지1</th>
						<td colspan="3">
						<p>※파일형식은 jpg, png, gif만 지원합니다.</p>
						    <input type="file" name="i_img_detail1" size="10">
					    <?php
							    $bimg_str2 = "";
							    $bimg_02 = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_img_detail1']."";
							    if (file_exists($bimg_02) && $iv['i_img_detail1']) {
								$size = @getimagesize($bimg_02);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_02" value="1" id="bn_bimg_del_02"> <label for="bn_bimg_del_02">삭제하기</label>';
								$bimg_str_02 = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id."/".$iv['i_img_detail1'].'" style="width:1000px;" >';
							    }
						    if ($bimg_str_02) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_02;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<tr>
						<th>상세이미지2</th>
						<td colspan="3">
						<p>※파일형식은 jpg, png, gif만 지원합니다.</p>
						    <input type="file" name="i_img_detail2" size="10">
					    <?php
							    $bimg_str3 = "";
							    $bimg_03 = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_img_detail2']."";
							    if (file_exists($bimg_03) && $iv['i_img_detail2']) {
								$size = @getimagesize($bimg_03);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_03" value="1" id="bn_bimg_del_03"> <label for="bn_bimg_del_03">삭제하기</label>';
								$bimg_str_03 = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id.'/'.$iv['i_img_detail2'].'" style="width:1000px;" >';
							    }
						    if ($bimg_str_03) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_03;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<tr>
						<th>상세이미지3</th>
						<td colspan="3">
						<p>※파일형식은 jpg, png, gif만 지원합니다.</p>
						    <input type="file" name="i_img_detail3" size="10">
					    <?php
							    $bimg_str4 = "";
							    $bimg_04 = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_img_detail3']."";
							    if (file_exists($bimg_04) && $iv['i_img_detail3']) {
								$size = @getimagesize($bimg_04);
								if($size[0] && $size[0] > 16)
								    $width = 16;
							else
							    $width = $size[0];

								echo '<input type="checkbox" name="d_img_04" value="1" id="bn_bimg_del_04"> <label for="bn_bimg_del_04">삭제하기</label>';
								$bimg_str_04 = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id.'/'.$iv['i_img_detail3'].'" style="width:1000px;" >';
							    }
						    if ($bimg_str_04) {
							echo '<div class="banner_or_img">';
							echo $bimg_str_04;
							echo '</div>';
						    }
					    ?>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/0.9.1/jquery.tablednd.js" integrity="sha256-d3rtug+Hg1GZPB7Y/yTcRixO/wlI78+2m08tosoRn7A=" crossorigin="anonymous"></script>
							<script src="/assets/alertify/alertify.min.js"></script>
							<link rel="stylesheet" href="/assets/alertify/alertify.css" />
							<style>
							tr.myDragClass td {
							    /*position: fixed;*/
							    color: yellow;
							    text-shadow: 0 0 10px black, 0 0 10px black, 0 0 8px black, 0 0 6px black, 0 0 6px black;
							    background-color: #999;
							    -webkit-box-shadow: 0 12px 14px -12px #111 inset, 0 -2px 2px -1px #333 inset;
							}
							tr.myDragClass td:first-child {
							    -webkit-box-shadow: 0 12px 14px -12px #111 inset, 12px 0 14px -12px #111 inset, 0 -2px 2px -1px #333 inset;
							}
							tr.myDragClass td:last-child {
							    -webkit-box-shadow: 0 12px 14px -12px #111 inset, -12px 0 14px -12px #111 inset, 0 -2px 2px -1px #333 inset;
							}
							.tDnD_whileDrag {
							    /*z-index: 500;*/
							    /*width: 90%;*/
							    /*margin: -10px;*/
							    /*display: table-cell;*/
							    /*color: transparent;*/
							    /*width: 0px*/
							}
							.tDnD_whileDrag td {
							    background-color: #eee;
							    /*-webkit-box-shadow: 11px 5px 12px 2px #333, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;*/
							    -webkit-box-shadow: 6px 3px 5px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;
							    /*-moz-box-shadow: 6px 4px 5px 1px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;*/
							    /*-box-shadow: 6px 4px 5px 1px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;*/
							}
							/*.tDnD_whileDrag td:first-child {*/

							/*-webkit-box-shadow: 5px 4px 5px 1px #111, 0 1px 0 #ccc inset, 1px -1px 0 #ccc inset;*/

							/*-moz-box-shadow: 6px 3px 5px 2px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset, 1px 0 0 #ccc inset;*/

							/*-box-shadow: 6px 3px 5px 2px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset, 1px 0 0 #ccc inset;*/

							/*}*/
							 .tDnD_whileDrag td:last-child {
							    /*-webkit-box-shadow: 8px 7px 12px 0 #333, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;*/
							    -webkit-box-shadow: 1px 8px 6px -4px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset;
							    /*-moz-box-shadow: 0 9px 4px -4px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset, -1px 0 0 #ccc inset;*/
							    /*-box-shadow: 0 9px 4px -4px #555, 0 1px 0 #ccc inset, 0 -1px 0 #ccc inset, -1px 0 0 #ccc inset;*/
							}
							/*-webkit-box-shadow:  0 0 40px white, 10px 10px 15px black;*/

							/*-moz-box-shadow: 0 4px 2px -3px rgba(0, 0, 0, 0.5) inset;*/

							/*-webkit-box-shadow: 0px 0px 40px 1px white, 0px 1px 1px 1px black;*/

							/*box-shadow: 0 4px 2px -3px rgba(0, 0, 0, 0.5) inset;*/

							/*}*/

							/*.tDnD_whileDrag {*/

							/*background-color: black;*/

							/*position: relative;*/

							/*display: block;*/

							/*-moz-box-shadow: 0px 0px 40px 1px white, 0px 1px 1px 1px black;*/

							/*-webkit-box-shadow: 0px 0px 40px 1px white, 0px 1px 1px 1px black;*/

							/*box-shadow:        0px 0px 40px 1px white, 0px 1px 1px 1px black ;*/

							/*-webkit-box-shadow: 0 15px 10px -10px black, 0 1px 4px black, 0 0 10px darkgray inset;*/

							/*-webkit-box-shadow: 0 15px 10px -10px black, 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;*/

							/*-moz-box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;*/

							/*box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;*/

							/*width: 90%;*/

							/*height: 90%;*/

							/*width: 100%;*/

							/*overflow: visible;*/

							/*z-index: 10000;*/

							/*opacity: .4;*/

							/*border-collapse: separate;*/

							/*filter:Alpha(Opacity=50);*/

							/*width: auto;*/

							/*}*/

							/*tr.alt td {*/

							/*width:200px*/

							/*-ms-transform:rotate(1deg;*/

							/*-moz-transform: rotate(0deg);*/

							/*-webkit-transform:rotate(0deg);*/

							/*-o-transform:rotate(0deg);*/

							/*}*/
							</style>
							<table id="filetable" class="type2" style="max-width:500px">
								<colgroup>
									<col width="50px" />
									<col width="" />
									<col width="100px" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>상품</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody id="mytable">
						<?php
							if($total_file){
							?>
							<input type="hidden" name="f_type" value="w">
							<input type="hidden" name="loan_Id" value="<?php echo $loan_id;?>">
							<?php
								  for ($i=0; $row=sql_fetch_array($file_list); $i++) {
									  $num=$i+1;
							?>
								<input type="hidden" name="file_idx" value="<?php echo $row['file_idx']?>">
								<tr id="fi_<?php echo $row['file_idx']?>">
									<td><?php echo $num;?></td>
									<td><a href="{MARI_DATA_URL}/file/<?php echo $loan_id?>/<?php echo $row['file_name'];?>" download target="_blank"><?php echo $row[file_name];?></a></td>
									<td>
									<a href="{MARI_HOME_URL}/?update=invest_file_setup&type=d&loan_id=<?php echo $row[loan_id]?>&file_idx=<?php echo $row['file_idx'];?>&file_name=<?php echo $row[file_name]?>">
									<img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="삭제" />
									</td>
								</tr>

								<?php
								   }
								  ?>
								  <a href="javascript:void(0);" onclick="add_row()"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"></a>
							<?php
							 }else{
							?>
							<input type="hidden" name="f_type" value="w">
								<tr>
									<td></td>
									<td><input type="file" name="file_name[]" value="" class="frm_input" size="30" multiple></td>
									<td>
									<!-- a href="{MARI_HOME_URL}/?update=reward_loan_setup&type=d&loan_id=<?php echo $i_id?>&rw_id=<?php echo $row['rw_id'];?>"><img src="{MARI_ADMINSKIN_URL}/img/delete2_btn.png" alt="삭제" / -->
									</td>
								</tr>
								<a href="javascript:void(0);" onclick="add_row()"><img src="{MARI_ADMINSKIN_URL}/img/more_btn.png" alt="추가"></a>
							<?php
							}
							?>

								</tbody>
							</table>
							<script>
							function resortfile(jsonsort){
								var obj = JSON.parse(jsonsort)
								obj.loanid = <?php echo $loan_id?>;
								$.ajax({
									type : 'POST',
									url : '/api/index.php/fileupload/officesort',
									dataType : 'json',
									data :obj,
									success : function(result) {
										if(result.code=='OK') {
											alertify.success("순서를 변경하였습니다.");
										}
										else alert("저장중 오류가 발생하였습니다.\n".result.msg);
									}
									,error : function () {
										alert("저장중 오류가 발생하였습니다.");
									}
								});

							}
							$(document).ready(function() {
						    $("#filetable").tableDnD({
									onDragClass: "tDnD_whileDrag",
									onDrop: function(table, row) {
										resortfile($.tableDnD.jsonize());
									}
								});
							});
							</script>
<!-- 첨부파일 수정.taq -->
<link rel="stylesheet" href="/api/statics/fileuploader/css/jquery.fileupload.css">
							<script src="/api/statics/fileuploader/js/jquery.iframe-transport.js"></script>
							<script src="/api/statics/fileuploader/js/jquery.fileupload.js"></script>
							<style>
.progress {
height: 20px;
margin-bottom: 20px;
overflow: hidden;
background-color: #bfbaba;
border-radius: 4px;
-webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
margin-top: 5px;
}
.progress-bar {
    float: left;
    width: 0;
    height: 100%;
    font-size: 12px;
    line-height: 20px;
    color: #fff;
    text-align: center;
    background-color: #337ab7;
    -webkit-box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
    box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
    -webkit-transition: width .6s ease;
    -o-transition: width .6s ease;
    transition: width .6s ease;
}
.progress-bar-success {
    background-color: #5cb85c;
}
.fileinput-button input {
    position: absolute;
    top: 0;
    right: 0;
    margin: 0;
    opacity: 0;
    -ms-filter: 'alpha(opacity=0)';
    font-size: 200px !important;
    direction: ltr;
    cursor: pointer;
}
.btn {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
.btn-success {
    color: #fff;
    background-color: #5cb85c;
    border-color: #4cae4c;
}
.fileinput-button {
    position: relative;
    overflow: hidden;
    display: inline-block;
}
							</style>
							<div style="margin-top:10px;margin-bottom:10px;border: 1px solid #AAA;padding: 15px;border-radius: 10px;">
								<span class="btn btn-success fileinput-button">
										<i class="glyphicon glyphicon-plus"></i>
										<span>추가하기(gif,jpg,png,doc,pdf)</span>
										<!-- The file input field used as target for the file upload widget -->
										<input id="fileupload" type="file" name="userfile" multiple>
								</span>
							<div id="progress" class="progress">
							        <div class="progress-bar progress-bar-success"></div>
							    </div>
								<div id="files" class="files"></div>
							</div>
							<script>
							/*jslint unparam: true */
							/*global window, $ */
							$(function () {
							    'use strict';
							    $('#fileupload').fileupload({
							        url: "/api/index.php/fileupload/office",
											//url:"/api/statics/fileuploader/test.html",
							        dataType: 'json',
											formData: {loanid: '<?php echo $loan_id;?>'},
											acceptFileTypes: /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i,
											add: function(e, data) {
							                var uploadErrors = [];
							                var acceptFileTypes = /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i;
							                //if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
															if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
							                    uploadErrors.push('Not an accepted file type');
							                }
							                if(uploadErrors.length > 0) {
							                    alert(uploadErrors.join("\n"));
																	return;
							                } else {
							                    data.submit();
							                }
							        },
							        done: function (e, data) {
							            $.each(data.result.files, function (index, file) {
															if(file.error != ''){
																$('#files').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
															}else  {
																$("#mytable").append("<tr id='fi_"+file.fileid+"'><td>added</td><td>"+file.file_name+"</td><td><a href='/pnpinvest/?update=invest_file_setup&amp;type=d&amp;loan_id=<?php echo $loan_id;?>&amp;file_idx="+file.fileid+"'><img src='/pnpinvest/layouts/admin/basic/img/delete2_btn.png' alt='삭제'></a></td>");
																//$('<p/>').text(file.file_name).appendTo('#files');
																$("#filetable").tableDnD({
																	onDragClass: "tDnD_whileDrag",
																	onDrop: function(table, row) {
																		resortfile($.tableDnD.jsonize());
																	}
																});
															}
							            });
							        },
							        progressall: function (e, data) {
							            var progress = parseInt(data.loaded / data.total * 100, 10);
							            $('#progress .progress-bar').css(
							                'width',
							                progress + '%'
							            );
							        }
							    }).prop('disabled', !$.support.fileInput)
							        .parent().addClass($.support.fileInput ? undefined : 'disabled');
							});
							</script>

<!-- /첨부파일 수정 -->
						</td>
					</tr>
					<tr>
						<th>채권의 진행상황</th>
						<td colspan="3">
							<?php echo editor_html('i_binding', $iv['i_binding']); ?>
						</td>
					</tr>
					<tr>
						<th>투자요약</th>
						<td colspan="3">
							<?php echo editor_html('i_invest_summary', $iv['i_invest_summary']); ?>
						</td>
					</tr>
					<tr>
						<th>투자포인트</th>
						<td colspan="3">
							<?php echo editor_html('i_invest_manage', $iv['i_invest_manage']); ?>
						</td>
					</tr>
					<tr>
						<th>담보정보</th>
						<td colspan="3">
							<?php echo editor_html('i_security', $iv['i_security']); ?>
						</td>
					</tr>
					<tr>
						<th>투자시유의사항</th>
						<td colspan="3">
							<?php echo editor_html('i_summary', $iv['i_summary']); ?>
						</td>
					</tr>
					<tr>
						<th>참여인원 상세</th>
						<td>
							<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
							<table class="type2" style="max-width:420px">
								<colgroup>
									<col width="40px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>회원명</th>
										<th>투자금액</th>
										<th>추천인</th>
										<th>마감여부</th>
										<th>정산여부</th>
									</tr>
								</thead>
								<tbody>
								<?php
								  for ($i=0; $row=sql_fetch_array($play_list); $i++) {
									$sql = "select * from mari_member where m_id = '$row[m_id]'";
									$ref = sql_fetch($sql,false);

									$sql = "select s_release from mari_seyfert_order where m_id = '$row[m_id]' and loan_id='$loan_id' and s_type='1' and s_payuse='Y'  order by s_date desc";
									$refonti = sql_fetch($sql,false);


									$sql = "select sale_id from mari_order where sale_id = '$row[m_id]' and loan_id='$loan_id'  and o_salestatus='정산완료' order by o_collectiondate desc";
									$reforder = sql_fetch($sql,false);


								  $num=$i+1;
								?>
									<tr>
										<td><?php echo $num;?></td>
										<td><?php echo $row['m_name'];?></td>
										<td><?php echo number_format($row['i_pay']) ?> 원</td>
										<td><?php echo $ref['m_referee'];?></td>
										<td><?php echo $refonti['s_release'];?></td>
										<td><?php if($reforder['sale_id']){?>Y<?php }else{?>N<?php }?></td>
									</tr>
								<?php
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"6\">투자인원이 없습니다.</td></tr>";
								?>
								</tbody>
							</table>
						</td>
						<td colspan="2">
      <script>

        var chart1;
        var chart2;

        makeCharts("light", "#FFFFFF");


        function makeCharts(theme, bgColor, bgImage) {

            if (chart1) {
                chart1.clear();
            }
            if (chart2) {
                chart2.clear();
            }

            // background
            if (document.body) {
                document.body.style.backgroundColor = bgColor;
                document.body.style.backgroundImage = "url(" + bgImage + ")";
            }


            // pie chart
            chart2 = AmCharts.makeChart("chartdiv2", {
                type: "pie",
                theme: theme,
                dataProvider: [
		{
                    "country": "투자금액",
                    "litres": <?php echo $order?>
                },
		{
                    "country": "투자가능금액",
                    "litres": <?php echo $invest_pay?>
                }
		],
                titleField: "country",
                valueField: "litres",
                balloonText: "[[title]]<br><b>[[value]]</b> ([[percents]]%)",
                legend: {
                    align: "center",
                    markerType: "circle"
                }
            });

        }


        </script>
        <div id="chartdiv2" style="width: 400px; height: 300px;"></div>

						</td>
					</tr>
					<tr>
						<th>담보비율(LTV)</th>
						<td colspan="3">
							<input type="text" name="i_ltv_point" value="<?php echo $iv['i_ltv_point']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>안정성</th>
						<td colspan="3">
							<input type="text" name="i_stability" value="<?php echo $iv['i_stability']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>신용등급</th>
						<td colspan="3">
							<input type="text" name="i_credit_grade" value="<?php echo $iv['i_credit_grade']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>환급성</th>
						<td colspan="3">
							<input type="text" name="i_refund" value="<?php echo $iv['i_refund']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>소득</th>
						<td colspan="3">
							<input type="text" name="i_income" value="<?php echo $iv['i_income']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>위치</th>
						<td colspan="3">
							<input type="text" name="i_position" value="<?php echo $iv['i_position']?>" class="frm_input" maxlength="4" size="6"> 점
						</td>
					</tr>
					<tr>
						<th>신용등급</th>
						<td colspan="3">
							<select name="i_grade">
								<option>등급을 선택하세요</option>
								<option value="A1" <?php echo $iv['i_grade']=='A1'?'selected':'';?>>A1</option>
								<option value="A2" <?php echo $iv['i_grade']=='A2'?'selected':'';?>>A2</option>
								<option value="A3" <?php echo $iv['i_grade']=='A3'?'selected':'';?>>A3</option>
								<option value="B1" <?php echo $iv['i_grade']=='B1'?'selected':'';?>>B1</option>
								<option value="B2" <?php echo $iv['i_grade']=='B2'?'selected':'';?>>B2</option>
								<option value="B3" <?php echo $iv['i_grade']=='B3'?'selected':'';?>>B3</option>
								<option value="C1" <?php echo $iv['i_grade']=='C1'?'selected':'';?>>C1</option>
								<option value="C2" <?php echo $iv['i_grade']=='C2'?'selected':'';?>>C2</option>
								<option value="C3" <?php echo $iv['i_grade']=='C3'?'selected':'';?>>C3</option>
								<option value="D1" <?php echo $iv['i_grade']=='D1'?'selected':'';?>>D1</option>
								<option value="D2" <?php echo $iv['i_grade']=='D2'?'selected':'';?>>D2</option>
								<option value="D3" <?php echo $iv['i_grade']=='D3'?'selected':'';?>>D3</option>
								<option value="E1" <?php echo $iv['i_grade']=='E1'?'selected':'';?>>E1</option>
								<option value="E2" <?php echo $iv['i_grade']=='E2'?'selected':'';?>>E2</option>
								<option value="E3" <?php echo $iv['i_grade']=='E3'?'selected':'';?>>E3</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>현재상태</th>
						<td colspan="3">
							<input type="radio" id="" name="i_look" value="Y" <?php echo $iv['i_look']=='Y'?'checked':'';?> /><label for="" class="mr10">투자 시작</label>
							<input type="radio" id="" name="i_look" value="N" <?php echo $iv['i_look']=='N'?'checked':'';?> /> <label for="">투자 대기</label>
							<input type="radio" id="" name="i_look" value="C" <?php echo $iv['i_look']=='C'?'checked':'';?> /> <label for="">투자 마감</label>
							<input type="radio" id="" name="i_look" value="D" <?php echo $iv['i_look']=='D'?'checked':'';?> /> <label for="">상환중</label>
							<input type="radio" id="" name="i_look" value="F" <?php echo $iv['i_look']=='F'?'checked':'';?> /> <label for="">상환완료</label>
						</td>
					</tr>
					<tr>
						<th>투자시작시SMS발송</th>
						<td colspan="3">
							<p>
								투자시작시 SMS 알림 자동발송 설정입니다. 내용을 입력하신후 사용을 원할시 사용여부 체크박스에 사용 체크하여 주십시오.</br>
								※ 해당 알림 메세지는 "투자시작"시 최초 1회만 발송 됩니다. (가상계좌를 보유중인 회원에게만 발송 됩니다.)
								<!--80바이트 초과시 LMS장문으로 전환되며 "제목" 을 작성시 SMS발송시 제목도 함께 발송됩니다.-->
							</p>
							<p>
								치환코드 : ｛사이트주소｝
							</p>
							<p>
								예) 제1호펀딩이 00시에 오픈됩니다. 자세한사항은 해당url을 클릭하여 확인하실 수 있습니다.｛사이트주소｝
							</p>
							<ul class="sms_cont1">
								<li><!--업데이트예정
									<p >
										제목 : <input type="text" name="msg_title"  id=" " class="frm_input" size="25" />
									</p>
									-->
									<div class="sms_box1">
										<textarea name="investstart_msg" id="msg" onkeyup="updateChar(1500, 'msg', 'chkBite');" ><?php echo $iv['investstart_msg'];?></textarea>
										<p><span id="chkBite">0</span>/1500 byte</p>
									</div>
									<p class="sms_chk1">
										<input type="checkbox" name="investstart_req" value="Y" <?php echo $iv['investstart_req']=='Y'?'checked':'';?> />
										<label class="">사용여부체크</label>
									</p>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th>심사원</th>
						<td colspan="3">
							<table class="type2">
								<colgroup>
									<col width="120px" />
									<col width="150px" />
									<col width="250px" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>사용여부</th>
										<th>이름</th>
										<th>사진</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
										<input type="radio" id="" name="i_rviewers_use" value="Y" <?php echo $iv['i_rviewers_use']=='Y'?'checked':'';?> /><label for="" class="mr10">사용</label>
										<input type="radio" id="" name="i_rviewers_use" value="N" <?php echo $iv['i_rviewers_use']=='N'?'checked':'';?> /> <label for="">미사용</label>
										</td>
										<td><input type="text" name="i_reviewers_name" value="<?php echo $iv['i_reviewers_name'];?>" id=""  class="frm_input " size="15" /></td>
										<td>
										    <input type="file" name="i_photoreviewers" size="10">
										    <?php
										    $bimg_file_str_file = "";
										    $bimg_file = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_photoreviewers']."";
										    if (file_exists($bimg_file) && $iv['i_photoreviewers']) {
											$size = @getimagesize($bimg_file);
											if($size[0] && $size[0] > 16)
											    $width = 16;
											else
											    $width = $size[0];

											echo '<input type="checkbox" name="d_img" value="1" id="bn_bimg_file_del"> <label for="bn_bimg_file_del">삭제하기</label>';
											$bimg_file_str_file = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id.'/'.$iv['i_photoreviewers'].'" width="116" height="149">';
										    }
										    if ($bimg_file_str_file) {
											echo '<div class="banner_or_img">';
											echo $bimg_file_str_file;
											echo '</div>';
										    }
										    ?>
										</td>
										<td>
										<?php echo editor_html('i_reviewers_contact', $iv['i_reviewers_contact']); ?>

										</td>
									</tr>
								</tbody>
							</table>
						</td>
					<tr>
					<tr>
						<th>심사원2</th>
						<td colspan="3">
							<table class="type2">
								<colgroup>
									<col width="120px" />
									<col width="150px" />
									<col width="250px" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>사용여부</th>
										<th>이름</th>
										<th>사진</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
										<input type="radio" id="" name="i_rviewers_use_01" value="Y" <?php echo $iv['i_rviewers_use_01']=='Y'?'checked':'';?> /><label for="" class="mr10">사용</label>
										<input type="radio" id="" name="i_rviewers_use_01" value="N" <?php echo $iv['i_rviewers_use_01']=='N'?'checked':'';?> /> <label for="">미사용</label>
										</td>
										<td><input type="text" name="i_reviewers_name_01" value="<?php echo $iv['i_reviewers_name_01'];?>" id=""  class="frm_input " size="15" /></td>
										<td>
										    <input type="file" name="i_photoreviewers_01" size="10">
										    <?php
										    $bimg_file_str_file = "";
										    $bimg_file = MARI_DATA_PATH."/photoreviewers/".$loan_id."/".$iv['i_photoreviewers_01']."";
										    if (file_exists($bimg_file) && $iv['i_photoreviewers_01']) {
											$size = @getimagesize($bimg_file);
											if($size[0] && $size[0] > 16)
											    $width = 16;
											else
											    $width = $size[0];

											echo '<input type="checkbox" name="d_img_06" value="1" id="bn_bimg_file_del"> <label for="bn_bimg_file_del">삭제하기</label>';
											$bimg_file_str_file = '<img src="'.MARI_DATA_URL.'/photoreviewers/'.$loan_id.'/'.$iv['i_photoreviewers_01'].'" width="116" height="149">';
										    }
										    if ($bimg_file_str_file) {
											echo '<div class="banner_or_img">';
											echo $bimg_file_str_file;
											echo '</div>';
										    }
										    ?>
										</td>
										<td>
										<?php echo editor_html('i_reviewers_contact_01', $iv['i_reviewers_contact_01']); ?>

										</td>
									</tr>
								</tbody>
							</table>
						</td>
					<tr>
					<tr>
						<th>노출여부</th>
						<td colspan="3">
							<input type="radio" id="" name="i_view" value="Y" <?php echo $iv['i_view']=='Y'?'checked':'';?> /><label for="" class="mr10">노출함</label>
							<input type="radio" id="" name="i_view" value="N" <?php echo $iv['i_view']=='N'?'checked':'';?> /> <label for="">미노출</label>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
		<div class="btn_confirm01 btn_confirm">
			<input type="image" src="{MARI_ADMINSKIN_URL}/img/save2_btn.png" alt="저장" id="invest_form_add" />
			<a href="{MARI_HOME_URL}/?cms=invest_setup_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
		</div>


		<!-- ===================================================== -->
		<?php
			$sql = "select * from mari_loan_ext where fk_mari_loan_id= $loan_id";
			$loan_ext = sql_fetch($sql,false);
		?>
<!-- 문구 -->
		<div style="max-width:1150px;;padding:10px;margin-bottom:-10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:left;margin-left:50px;">
				<table style="width:1035px;">
					<form name="main_text">
					<input type="hidden" name="loanid" value="<?php echo $loan_id;?>">
					<tr>
						<td rowspan=2 style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;"><label style="font-size: 14px;font-weight: bold;">설명문구</label></td>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">설명1</td>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">설명2</td>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">설명3</td>
					</tr>
					<tr>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">
							<p><input type="text" name="i_mainimg_txt1" class="frm_input" value="<?php echo $iv['i_mainimg_txt1'];?>"></p>
							<p><input type="text" name="i_mainimg_txt2" class="frm_input" value="<?php echo $iv['i_mainimg_txt2'];?>"></p>
						</td>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">
							<p><input type="text" name="i_mainimg_txt3" class="frm_input" value="<?php echo $iv['i_mainimg_txt3'];?>"></p>
							<p><input type="text" name="i_mainimg_txt4" class="frm_input" value="<?php echo $iv['i_mainimg_txt4'];?>"></p>
						</td>
						<td style="border:none;border-right:1px solid #999 ;text-align:center;padding:0 20px;">
							<p><input type="text" name="i_mainimg_txt5" class="frm_input" value="<?php echo $iv['i_mainimg_txt5'];?>"></p>
							<p><input type="text" name="i_mainimg_txt6" class="frm_input" value="<?php echo $iv['i_mainimg_txt6'];?>"></p>
						</td>
					</tr>
					</form>
					<tr>
					 <td colspan="4" style="border:none;text-align:center;padding:20px 20px; 0">
					 	<a id="main_text_save" class="btn btn-preview" href="javascript:;" onclick="save_maintxt()" style="display: inline;">저장하기</a>
					 </td>
					</tr>

				</table>
			</div>
		</div>
		<script>
		function save_maintxt() {
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/maintxt',
					dataType : 'json',
					data :$("form[name=main_text]").serialize(),
					success : function(result) {
						if(result.code=='OK') {
							alert("설명문구를 저장하였습니다.");
						}
						else alert("저장중 오류가 발생하였습니다.\n".result.msg);
					}
					,error : function () {
						alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}
		</script>
<!-- / 문구 -->
<style>
.btn-danger {
    color: #fff;
    background-color: #d9534f;
    border-color: #d43f3a;
}
</style>
		<div style="max-width:1150px;;padding:10px;margin-bottom:-10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:left;margin-left:50px;">

					<span class="btn btn-success fileinput-button">
							<i class="glyphicon glyphicon-plus"></i>
							<span>투자요약이미지업로드(gif,jpg,png)</span>
							<!-- The file input field used as target for the file upload widget -->
							<input id="rewardfileupload" type="file" name="userfile" multiple>
					</span>
					<a class="btn btn-danger" href="javascript:;" onClick="delimg('reward')">파일삭제</a>
				<div id="rewardprogress" class="progress">
								<div class="progress-bar progress-bar-success"></div>
						</div>
					<div id="rewardfiles" class="files">
						<?php
						if( isset($loan_ext['reward'] ) && $loan_ext['reward'] !='' ){
							?>
							<a class="btn btn-preview" id="reward-preview" data-fancybox="gallery" href="/pnpinvest/data/file/<?php echo $loan_id;?>/<?php echo $loan_ext['reward']?>">투자요약 파일 보기</a>
							<?php
						}else echo "<a class='btn btn-preview'>업로드된 파일이 없습니다.</a>";
						?>
					</div>

			</div>
		</div>
		<script>
		function delimg(imgtype){
			if( confirm(imgtype + " 이미지를 삭제하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/delimg',
					dataType : 'json',
					data :{loan_id:<?php echo $loan_id;?>, imgtype : imgtype},
					success : function(result) {
						if (result.code == 200 ) $("#"+ imgtype +"files").html('');
						else alert(result.msg);
					}
				});
			}
		}
		/*jslint unparam: true */
		/*global window, $ */
		$(function () {
				'use strict';
				$('#rewardfileupload').fileupload({
						url: "/api/index.php/admext/rewardupload",
						//url:"/api/statics/fileuploader/test.html",
						dataType: 'json',
						formData: {loanid: '<?php echo $loan_id;?>'},
						acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
						add: function(e, data) {
										var uploadErrors = [];
										var acceptFileTypes = /(\.|\/)(gif|jpe?g|png)$/i;
										//if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
										if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
												uploadErrors.push('Not an accepted file type');
										}
										if(uploadErrors.length > 0) {
												alert(uploadErrors.join("\n"));
												return;
										} else {
												data.submit();
										}
						},
						done: function (e, data) {
								$.each(data.result.files, function (index, file) {
										if(file.error != ''){
											$('#rewardfiles').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
										}else  {
											$("#rewardfiles").html("<span>"+file.file_name+"</span><div><a target='_blank' href='/pnpinvest/data/file/<?php echo $loan_id;?>/"+file.file_name+"'>업로드된 파일보기</a></div>");
										}
								});
						},
						progressall: function (e, data) {
								var progress = parseInt(data.loaded / data.total * 100, 10);
								$('#rewardprogress .progress-bar').css(
										'width',
										progress + '%'
								);
						}
				}).prop('disabled', !$.support.fileInput)
						.parent().addClass($.support.fileInput ? undefined : 'disabled');
		});
		</script>

		<!-- / reward -->

		<div style="max-width:1150px;;padding:10px;margin-bottom:-10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:left;margin-left:50px;">

					<span class="btn btn-success fileinput-button">
							<i class="glyphicon glyphicon-plus"></i>
							<span>신용정보이미지업로드(gif,jpg,png)</span>
							<!-- The file input field used as target for the file upload widget -->
							<input id="eventfileupload" type="file" name="userfile" multiple>
					</span>
					<a class="btn btn-danger" href="javascript:;" onClick="delimg('event')">파일삭제</a>
				<div id="eventprogress" class="progress">
								<div class="progress-bar progress-bar-success"></div>
						</div>
					<div id="eventfiles" class="files">
						<?php
						if( isset($loan_ext['eventfile'] ) && $loan_ext['eventfile'] !='' ){
							?>
							<a class="btn btn-preview" data-fancybox="gallery" href="/pnpinvest/data/file/<?php echo $loan_id;?>/<?php echo $loan_ext['eventfile']?>">신용정보 파일 보기</a>
							<?php
						}else echo "<a class='btn btn-preview'>업로드된 파일이 없습니다.</a>";
						?>
					</div>

			</div>
		</div>

		<script>
		/*jslint unparam: true */
		/*global window, $ */
		$(function () {
				'use strict';
				$('#eventfileupload').fileupload({
						url: "/api/index.php/admext/eventfileupload",
						//url:"/api/statics/fileuploader/test.html",
						dataType: 'json',
						formData: {loanid: '<?php echo $loan_id;?>'},
						acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
						add: function(e, data) {
										var uploadErrors = [];
										var acceptFileTypes = /(\.|\/)(gif|jpe?g|png)$/i;
										//if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
										if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
												uploadErrors.push('Not an accepted file type');
										}
										if(uploadErrors.length > 0) {
												alert(uploadErrors.join("\n"));
												return;
										} else {
												data.submit();
										}
						},
						done: function (e, data) {
								$.each(data.result.files, function (index, file) {
										if(file.error != ''){
											$('#eventfiles').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
										}else  {
											$("#eventfiles").html("<span>"+file.file_name+"</span><div><a target='_blank' href='/pnpinvest/data/file/<?php echo $loan_id;?>/"+file.file_name+"'>업로드된 파일보기</a></div>");
										}
								});
						},
						progressall: function (e, data) {
								var progress = parseInt(data.loaded / data.total * 100, 10);
								$('#eventprogress .progress-bar').css(
										'width',
										progress + '%'
								);
						}
				}).prop('disabled', !$.support.fileInput)
						.parent().addClass($.support.fileInput ? undefined : 'disabled');
		});
		</script>
		<div style="max-width:1150px;;padding:10px;margin-bottom:10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:center;margin-left:50px;">
				<table style="width:1035px;">
					<form name="extreward">
					<input type="hidden" name="loanid" value="<?php echo $loan_id;?>">
					<tr>
						<td style="border:none;text-align:center;padding:0 20px;"><label style="font-size: 14px;font-weight: bold;">그외이벤트</label></td>
						<td style="border:none;padding:0 0 20px 30px;"><textarea name="eventetc" style="height:80px;width:800px;" onChange="showbt('eventetc')" onKeyDown="showbt('eventetc')"><?php echo isset($loan_ext['fk_mari_loan_id']) ? stripslashes($loan_ext['eventetc']): ""?></textarea></td>
						<td rowspan="1" style="border:none;text-align:right;width:110px;">
							<a id="eventetc" class="btn btn-preview hidebt" href="javascript:;" onClick="saveeventetc()">저장하기</a>
						</td>
					</tr>
					</form>
				</table>
			</div>
		</div>

		<!-- / 이벤트 -->


		<div style="max-width:1150px;;padding:10px;margin-bottom:10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:center;margin-left:50px;">
				<table style="width:1035px;">
					<form name="extdesc">
					<input type="hidden" name="loanid" value="<?php echo $loan_id;?>">
					<tr>
						<td style="border:none;text-align:center;padding:0 20px;"><label style="font-size: 14px;font-weight: bold;">상단설명</label></td>
						<td style="border:none;padding:0 0 20px 30px;"><textarea name="descript" style="height:80px;width:800px;" onChange="showbt('savedescbt')" onKeyDown="showbt('savedescbt')"><?php echo isset($loan_ext['fk_mari_loan_id']) ? stripslashes($loan_ext['descript']): ""?></textarea></td>
						<td rowspan="1" style="border:none;text-align:right;width:110px;">
							<a id="savedescbt" class="btn btn-preview hidebt" href="javascript:;" onClick="savedesc()">저장하기</a>
						</td>
					</tr>
					</form>
				</table>
			</div>
		</div>
		<script>
			function save_defeditor( descname ) {
				var editor_data = oEditors.getById[descname].getIR();

				oEditors.getById[descname].exec('UPDATE_CONTENTS_FIELD', []);
				if(jQuery.inArray(document.getElementById(descname).value.toLowerCase().replace(/^\s*|\s*$/g, ''), ['&nbsp;','<p>&nbsp;</p>','<p><br></p>','<div><br></div>','<p></p>','<br>','']) != -1){
					document.getElementById(descname).value='';
				}

				if( confirm("저장하시겠습니까?") ){
					$.ajax({
						type : 'POST',
						url : '/api/index.php/admext/extdescsave',
						dataType : 'json',
						data :{loanid:"<?php echo $loan_id?>",desctype:descname,desc:editor_data},
						success : function(result) {
							if(result.code=='OK') alert("저장하였습니다.");
							else alert("저장중 오류가 발생하였습니다.");
						}
					});
				}
			}
		</script>

		<div style="max-width:1150px;;padding:10px;margin-bottom:5px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:center;margin-left:50px;">
			<form name="extformtuja">
				<input type="hidden" name="loanid" value="<?php echo $loan_id;?>">
				<table style="width:1035px;">
					<tr>
						<td style="border:none;text-align:center;padding:30px 20px;vertical-align: top;"><label style="font-size: 14px;font-weight: bold;">투자개요</label></td>
						<td style="border:none;padding:0 0 20px 30px;">
							<!-- textarea name="gaeyo" style="height:120px;width:800px;"  onChange="showbt('tujabt')" onKeyDown="showbt('tujabt')">
							<?php echo isset($loan_ext['fk_mari_loan_id']) ? stripslashes($loan_ext['gaeyo']): ""?>
							</textarea-->
								<?php
								$editor_desctype="gaeyo";
								if( isset($loan_ext['fk_mari_loan_id']) ) {
								 	$text_cont = tohtmlstring($loan_ext[$editor_desctype]);
								}else $text_cont = '';
								?>
								<?php echo editor_html($editor_desctype , $text_cont) ?>
								<div style="margin-top:10px;margin-bottom5px;text-align:center">
									<a class="btn btn-preview" href="javascript:;" onClick="save_defeditor('<?php echo $editor_desctype?>')" style="display: inline;">저장하기</a>
								</div>
						</td>
						<td rowspan="4" style="border:none;text-align:right;width:110px;">
							<a id="tujabt" class="btn btn-preview hidebt" href="javascript:;" style="padding:60px 12px;" onClick="saveext1()">저장하기</a>
						</td>
					</tr>
					<tr>
						<td style="border:none;text-align:center;padding:30px 20px;vertical-align: top;"><label style="font-size: 14px;font-weight: bold;">영업상황</label></td>
						<td style="border:none;padding:0 0 20px 30px;">
							<?php
							$editor_desctype="sanghwang";
							if( isset($loan_ext['fk_mari_loan_id']) ) {
								$text_cont = tohtmlstring($loan_ext[$editor_desctype]);
							}else $text_cont = '';
							?>
							<?php echo editor_html($editor_desctype , $text_cont) ?>
							<div style="margin-top:10px;margin-bottom5px;text-align:center">
								<a class="btn btn-preview" href="javascript:;" onClick="save_defeditor('<?php echo $editor_desctype?>')" style="display: inline;">저장하기</a>
							</div>
						</td>
					</tr>
					<tr>
						<td style="border:none;text-align:center;padding:30px 20px;vertical-align: top;"><label style="font-size: 14px;font-weight: bold;">담보력</label></td>
						<td style="border:none;padding:0 0 20px 30px;">
							<?php
							$editor_desctype="dambo";
							if( isset($loan_ext['fk_mari_loan_id']) ) {
								$text_cont = tohtmlstring($loan_ext[$editor_desctype]);
							}else $text_cont = '';
							?>
							<?php echo editor_html($editor_desctype , $text_cont) ?>
							<div style="margin-top:10px;margin-bottom5px;text-align:center">
								<a class="btn btn-preview" href="javascript:;" onClick="save_defeditor('<?php echo $editor_desctype?>')" style="display: inline;">저장하기</a>
							</div>
						</td>
					</tr>
					<tr>
						<td style="border:none;text-align:center;padding:30px 20px 0 20px;vertical-align: top;"><label style="font-size: 14px;font-weight: bold;">채권<br>회수방안</label></td>
						<td style="border:none;padding:0 0 0 20px ;">
							<?php
							$editor_desctype="boho";
							if( isset($loan_ext['fk_mari_loan_id']) ) {
								$text_cont = tohtmlstring($loan_ext[$editor_desctype]);
							}else $text_cont = '';
							?>
							<?php echo editor_html($editor_desctype , $text_cont) ?>
							<div style="margin-top:10px;margin-bottom5px;text-align:center">
								<a class="btn btn-preview" href="javascript:;" onClick="save_defeditor('<?php echo $editor_desctype?>')" style="display: inline;">저장하기</a>
							</div>
						</td>
					</tr>
				</table>
			</form>
			</div>
		</div>
		<script>
		function showbt(id){
			$("#"+id).show();
		}
		function saveext1() {
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/form1',
					dataType : 'json',
					data :$("form[name=extformtuja]").serialize(),
					success : function(result) {
						if(result.code=='OK') alert("저장하였습니다.");
						else alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}
		function savedesc() {
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/desc',
					dataType : 'json',
					data :$("form[name=extdesc]").serialize(),
					success : function(result) {
						if(result.code=='OK') alert("저장하였습니다.");
						else alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}
		function gallerydescsave() {
			<?php echo get_editor_js('gallerydesc'); ?>
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/gallerydesc',
					dataType : 'json',
					data :{loanid:"<?php echo $loan_id?>",gallerydesc:gallerydesc_editor_data},
					success : function(result) {
						if(result.code=='OK') alert("저장하였습니다.");
						else alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}

		function saveeventetc() {
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/eventetc',
					dataType : 'json',
					data :$("form[name=extreward]").serialize(),
					success : function(result) {
						if(result.code=='OK') alert("저장하였습니다.");
						else alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}
		function savejinhaeng() {
			if( confirm("저장하시겠습니까?") ){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/admext/jinhaeng',
					dataType : 'json',
					data :$("form[name=jinhaeng]").serialize(),
					success : function(result) {
						if(result.code=='OK') alert("저장하였습니다.");
						else alert("저장중 오류가 발생하였습니다.");
					}
				});
			}
		}
		</script>
		<style>
		.hidebt {display:none};
		 table.tbl_frm05 th, table.tbl_frm05 tbody tr td{ text-align:left;font-size:14px;padding:10px;min-height:30px;}
		</style>
		<!-- 갤러리용 -->
		<script src="/api/statics/gridly/jquery.gridly.js" type="text/javascript"></script>
		<link href="/api/statics/gridly/jquery.gridly.css" rel="stylesheet" type="text/css" />
		<script src="/api/statics/fancybox/jquery.fancybox.min.js" type="text/javascript"></script>
		<link href="/api/statics/fancybox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
		<style>
			.brick.small {
				width: 136px;
				height: 84px;
				padding: 5px;
				background-color: #00bcd4;
				border-radius: 8px;
				color:white;
			}
			.gal_del_bt{
				position: absolute;
				z-index: 1000000;
				top: 1px;
				right: 3px;
				background-color: #27244e;
				padding: 3px;
				border-radius: 3px;
				color: white;
			}
			.fancybox-slide--iframe .fancybox-content {
				width  : 800px;
				height : 600px;
				max-width  : 80%;
				max-height : 80%;
				margin: 0;
			}
			.btn-preview {
					color: #fff;
					background-color: #365aa5;
					border-color: #365aa5;
			}
		</style>
		<!-- / -->

		<div style="max-width:1150px;;padding:10px;margin-bottom:5px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:30px 20px;text-align:center;margin-left:50px;">
				<form name="jinhaeng">
				<div style="font-size: 16px;padding: 0 0 10px 10px;font-weight: bold;text-align:left">
					<input type="checkbox" name="view_jinhaeng" value="Y"  onChange="showbt('jinhaengbt')" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['view_jinhaeng']=='Y') ? "checked=checked":'' ?> > 사업진행현황 보이기
				</div>
				<input type="hidden" name="loanid" value="<?php echo $loan_id;?>">
					<table class="tbl_frm05">
					<colgroup>
					<col width="200px" />
					<col />
					<colgroup>
						<tbody>
							<tr>
								<td><input type="checkbox" name="view_slide" value="Y" onChange="showbt('jinhaengbt')" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['view_slide']=='Y') ? "checked=checked":'' ?>> 슬라이드 보이기</td>
								<td>
		<!-- 슬라이드 -->
		<div id='gridlyTs' class="gridly" style="position: relative;width:100%;min-height:50px;"></div>

		<div style="margin-top:10px;margin-bottom:10px;border: 1px solid #AAA;padding: 15px;border-radius: 10px;">
			<span class="btn btn-success fileinput-button">
					<i class="glyphicon glyphicon-plus"></i>
					<span>추가하기(gif,jpg,png)</span>
					<!-- The file input field used as target for the file upload widget -->
					<input id="fileuploadTs" type="file" name="userfile" multiple>
			</span>
			<a data-fancybox data-type="iframe" class="btn btn-preview" data-src="/api/index.php/fileupload/galleryview?loanid=<?php echo $loan_id;?>&gtype=s" href="javascript:;">Pre View</a>
		<div id="progressTs" class="progress">
						<div class="progress-bar progress-bar-success"></div>
				</div>
			<div id="filesTs" class="files"></div>
		</div>
		<script>
		var sortednoTs = '';
		function reorderingTs($el){
			var reorder = [];
			$el.each(function (key, val){
				reorder.push($(val).data('idx'));
			});
			sortednoTs = JSON.stringify(reorder);
		}
		function reorderedTs($el){
			var reorder = [];
			$el.each(function (key, val){
				reorder.push($(val).data('idx'));
			});
			if (sortednoTs == JSON.stringify(reorder)) {console.log("pass");return;}
			$.ajax({
				type : 'POST',
				url : '/api/index.php/fileupload/gallerysort',
				dataType : 'json',
				data :{loanid:'<?php echo $loan_id;?>',idxs:JSON.stringify(reorder),gtype:'s'},
				success : function(result) {
					console.log(result);
				}
			});
		}
		function addimageTs(file){

			var str='<div class="brick small" data-idx="'+file.idx+'"><div style="display:block;width:136px;height:68px;overflow:hidden;"><img src="/pnpinvest/data/file/<?php echo $loan_id;?>/gallery/'+file.file_name+'" style="max-width:none !important;width:100%;height:auto;margin-top:-1px"></div><div class="thumbnail-tite-0" style="width:136px;text-overflow:ellipsis; overflow:hidden; white-space:nowrap">'+file.client_name+'</div><div style="position: absolute;z-index: 1000000;top: 1px;right: 3px;background-color: #27244e;padding: 3px;border-radius: 3px;color: white;" onClick="delgal(this)" data-idx="'+file.idx+'">delete</div></div>';
			$("#gridlyTs").append(str);
		}
		function loadgalleryimgTs() {
			$.ajax({
				type : 'GET',
				url : '/api/index.php/fileupload/gallerylist?loanid=<?php echo $loan_id;?>&gtype=s',
				dataType : 'json',
				success : function(result) {
					$.each(result.data, function (key,val){
						addimageTs(val);
						$('#gridlyTs').gridly({
							base: 80, // px
							gutter: 10, // px
							columns: 12,
							callbacks: { reordering: reorderingTs , reordered: reorderedTs }});
					});
				}
			});
		}
		function delgal(delbt){
			if( confirm($(delbt).closest('div.brick').children("div.thumbnail-tite-0").text() + ' 을 삭제하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/fileupload/gallerydel',
					dataType : 'json',
					data:{fileidx:$(delbt).data("idx")},
					success : function(result) {
						if(result.code == "OK") $(delbt).closest('div.brick').remove();
						else alert (result.msg);
					},
					error : function (req, status, error) {alert('에러가 발생했습니다.');}
				});
			}
		}
		$(function () {
				'use strict';
				loadgalleryimgTs();
				$('#fileuploadTs').fileupload({
						url: "/api/index.php/fileupload/gallery",
						//url:"/api/statics/fileuploader/test.html",
						dataType: 'json',
						formData: {loanid: '<?php echo $loan_id;?>',gtype:'s'},
						acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
						add: function(e, data) {
										var uploadErrors = [];
										var acceptFileTypes = /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i;
										//if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
										if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
												uploadErrors.push('Not an accepted file type');
										}
										if(uploadErrors.length > 0) {
												alert(uploadErrors.join("\n"));
												return;
										} else {
												data.submit();
										}
						},
						done: function (e, data) {
								$.each(data.result.files, function (index, file) {
										if(file.error != ''){
											$('#filesTs').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
										}else  {
											addimageTs(file);
											$('#gridlyTs').gridly();
											//$("#mytable").append("<tr><td>added</td><td>"+file.file_name+"</td><td><a href='/pnpinvest/?update=invest_file_setup&amp;type=d&amp;loan_id=<?php echo $loan_id;?>&amp;file_idx="+file.fileid+"'><img src='/pnpinvest/layouts/admin/basic/img/delete2_btn.png' alt='삭제'></a></td>");
											//$('<p/>').text(file.file_name).appendTo('#files');

										}
								});
						},
						progressall: function (e, data) {
								var progress = parseInt(data.loaded / data.total * 100, 10);
								$('#progressTs .progress-bar').css(
										'width',
										progress + '%'
								);
						}
				}).prop('disabled', !$.support.fileInput)
						.parent().addClass($.support.fileInput ? undefined : 'disabled');
		});
		</script>
		<!-- /슬라이드 -->
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="view_gongjung" value="Y" onChange="showbt('jinhaengbt')" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['view_gongjung']=='Y') ? "checked=checked":'' ?>> 공정률 보이기</td>
								<td>공정률 : <input type="text" name="gongjungryul" onChange="showbt('jinhaengbt')"  onKeyDown="showbt('jinhaengbt')" value="<?php echo (isset($loan_ext['fk_mari_loan_id'])) ? $loan_ext['gongjungryul']:'' ?>" style="margin-left:20px;width:50px;border:1px solid #333">%</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="view_gongjung_slide" value="Y"  onChange="showbt('jinhaengbt')" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['view_gongjung_slide']=='Y') ? "checked=checked":'' ?>> 공정 슬라이드 보이기</td>
								<td>
		<!-- 공정슬라이드 -->
		<div id='gridlyTp' class="gridly" style="position: relative;width:100%;min-height:50px;"></div>

		<div style="margin-top:10px;margin-bottom:10px;border: 1px solid #AAA;padding: 15px;border-radius: 10px;">
			<span class="btn btn-success fileinput-button">
					<i class="glyphicon glyphicon-plus"></i>
					<span>추가하기(gif,jpg,png)</span>
					<!-- The file input field used as target for the file upload widget -->
					<input id="fileuploadTp" type="file" name="userfile" multiple>
			</span>
			<a data-fancybox data-type="iframe" class="btn btn-preview" data-src="/api/index.php/fileupload/galleryview?loanid=<?php echo $loan_id;?>&gtype=p" href="javascript:;">Pre View</a>
		<div id="progressTp" class="progress">
						<div class="progress-bar progress-bar-success"></div>
				</div>
			<div id="filesTp" class="files"></div>
		</div>
		<script>
		var sortednoTp = '';
		function reorderingTp($el){
			var reorder = [];
			$el.each(function (key, val){
				reorder.push($(val).data('idx'));
			});
			sortednoTp = JSON.stringify(reorder);
		}
		function reorderedTp($el){
			var reorder = [];
			$el.each(function (key, val){
				reorder.push($(val).data('idx'));
			});
			if (sortednoTp == JSON.stringify(reorder)) {console.log("pass");return;}
			$.ajax({
				type : 'POST',
				url : '/api/index.php/fileupload/gallerysort',
				dataType : 'json',
				data :{loanid:'<?php echo $loan_id;?>',idxs:JSON.stringify(reorder),gtype:'p'},
				success : function(result) {
					console.log(result);
				}
			});
		}
		function addimageTp(file){

			var str='<div class="brick small" data-idx="'+file.idx+'"><div style="display:block;width:136px;height:68px;overflow:hidden;"><img src="/pnpinvest/data/file/<?php echo $loan_id;?>/gallery/'+file.file_name+'" style="max-width:none !important;width:100%;height:auto;margin-top:-1px"></div><div class="thumbnail-tite-0" style="width:136px;text-overflow:ellipsis; overflow:hidden; white-space:nowrap">'+file.client_name+'</div><div style="position: absolute;z-index: 1000000;top: 1px;right: 3px;background-color: #27244e;padding: 3px;border-radius: 3px;color: white;" onClick="delgal(this)" data-idx="'+file.idx+'">delete</div></div>';
			$("#gridlyTp").append(str);
		}
		function loadgalleryimgTp() {
			$.ajax({
				type : 'GET',
				url : '/api/index.php/fileupload/gallerylist?loanid=<?php echo $loan_id;?>&gtype=p',
				dataType : 'json',
				success : function(result) {
					$.each(result.data, function (key,val){
						addimageTp(val);
						$('#gridlyTp').gridly({
							base: 80, // px
							gutter: 10, // px
							columns: 12,
							callbacks: { reordering: reorderingTp , reordered: reorderedTp }});
					});
				}
			});
		}
		function delgal(delbt){
			if( confirm($(delbt).closest('div.brick').children("div.thumbnail-tite-0").text() + ' 을 삭제하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '/api/index.php/fileupload/gallerydel',
					dataType : 'json',
					data:{fileidx:$(delbt).data("idx")},
					success : function(result) {
						if(result.code == "OK") $(delbt).closest('div.brick').remove();
						else alert (result.msg);
					},
					error : function (req, status, error) {alert('에러가 발생했습니다.');}
				});
			}
		}
		$(function () {
				'use strict';
				loadgalleryimgTp();
				$('#fileuploadTp').fileupload({
						url: "/api/index.php/fileupload/gallery",
						//url:"/api/statics/fileuploader/test.html",
						dataType: 'json',
						formData: {loanid: '<?php echo $loan_id;?>',gtype:'p'},
						acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
						add: function(e, data) {
										var uploadErrors = [];
										var acceptFileTypes = /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i;
										//if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
										if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
												uploadErrors.push('Not an accepted file type');
										}
										if(uploadErrors.length > 0) {
												alert(uploadErrors.join("\n"));
												return;
										} else {
												data.submit();
										}
						},
						done: function (e, data) {
								$.each(data.result.files, function (index, file) {
										if(file.error != ''){
											$('#filesTp').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
										}else  {
											addimageTp(file);
											$('#gridlyTp').gridly();
											//$("#mytable").append("<tr><td>added</td><td>"+file.file_name+"</td><td><a href='/pnpinvest/?update=invest_file_setup&amp;type=d&amp;loan_id=<?php echo $loan_id;?>&amp;file_idx="+file.fileid+"'><img src='/pnpinvest/layouts/admin/basic/img/delete2_btn.png' alt='삭제'></a></td>");
											//$('<p/>').text(file.file_name).appendTo('#files');

										}
								});
						},
						progressall: function (e, data) {
								var progress = parseInt(data.loaded / data.total * 100, 10);
								$('#progressTp .progress-bar').css(
										'width',
										progress + '%'
								);
						}
				}).prop('disabled', !$.support.fileInput)
						.parent().addClass($.support.fileInput ? undefined : 'disabled');
		});
		</script>
		<!-- /공정슬라이드 -->
								</td>
							</tr>
							<tr>
								<td>공정스텝</td>
								<td>
								<select name='nowstep' onChange="showbt('jinhaengbt')">
									<option value="N" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['nowstep']=='N') ? "selected=selected":'' ?>>감추기</option>
									<option value="1" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['nowstep']=='1') ? "selected=selected":'' ?>>01. 공사준비단계</option>
									<option value="2" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['nowstep']=='2') ? "selected=selected":'' ?>>02. 공사골조단계</option>
									<option value="3" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['nowstep']=='3') ? "selected=selected":'' ?>>03. 공사마감단계</option>
									<option value="4" <?php echo (isset($loan_ext['fk_mari_loan_id'])&&$loan_ext['nowstep']=='4') ? "selected=selected":'' ?>>04. 공사준공단계</option>
								</select>
								</td>
							</tr>
							<tr>
								<td>추가설명</td>
								<td>
								<textarea name="nowstepdesc" style="height:60px;width:400px;" onchange="showbt('jinhaengbt')" onkeydown="showbt('jinhaengbt')"><?php echo isset($loan_ext['fk_mari_loan_id']) ? stripslashes($loan_ext['nowstepdesc']): ""?></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div style="margin-top:10px;padding-top:10px">
					<a id="jinhaengbt" class="btn btn-preview hidebt" href="javascript:;" onclick="savejinhaeng()">저장하기</a>
					</div>
				</form>
			</div>
		</div>


			<!-- 갤러리 -->
		<div style="max-width:1150px;;padding:10px;margin-bottom:10px;">
			<div style="border:1px solid #999;border-radius:10px;min-height:50px;padding:10px 20px;text-align:left;margin-left:50px;">
			<div style="font-size: 18px;padding: 0 0 10px 20px;font-weight: bold;">갤러리</div>

			<div id='gridly' class="gridly" style="position: relative;width:100%;min-height:50px;"></div>

			<div style="margin-top:10px;margin-bottom:10px;border: 1px solid #AAA;padding: 15px;border-radius: 10px;">
				<span class="btn btn-success fileinput-button">
						<i class="glyphicon glyphicon-plus"></i>
						<span>추가하기(gif,jpg,png)</span>
						<!-- The file input field used as target for the file upload widget -->
						<input id="fileupload2" type="file" name="userfile" multiple>
				</span>
				<a data-fancybox data-type="iframe" class="btn btn-preview" data-src="/api/index.php/fileupload/galleryview?loanid=<?php echo $loan_id;?>" href="javascript:;">Pre View</a>
			<div id="progress2" class="progress">
							<div class="progress-bar progress-bar-success"></div>
					</div>
				<div id="files2" class="files"></div>
			</div>
			<script>
			var sortedno = '';
			function reordering($el){
				var reorder = [];
				$el.each(function (key, val){
					reorder.push($(val).data('idx'));
				});
				sortedno = JSON.stringify(reorder);
			}
			function reordered($el){
				var reorder = [];
				$el.each(function (key, val){
					reorder.push($(val).data('idx'));
				});
				if (sortedno == JSON.stringify(reorder)) {console.log("pass");return;}
				$.ajax({
					type : 'POST',
					url : '/api/index.php/fileupload/gallerysort',
					dataType : 'json',
					data :{loanid:'<?php echo $loan_id;?>',idxs:JSON.stringify(reorder)},
					success : function(result) {
						console.log(result);
					}
				});
			}
			function addimage(file){

				var str='<div class="brick small" data-idx="'+file.idx+'"><div style="display:block;width:136px;height:68px;overflow:hidden;"><img src="/pnpinvest/data/file/<?php echo $loan_id;?>/gallery/'+file.file_name+'" style="max-width:none !important;width:100%;height:auto;margin-top:-1px"></div><div class="thumbnail-tite-0" style="width:136px;text-overflow:ellipsis; overflow:hidden; white-space:nowrap">'+file.client_name+'</div><div style="position: absolute;z-index: 1000000;top: 1px;right: 3px;background-color: #27244e;padding: 3px;border-radius: 3px;color: white;" onClick="delgal(this)" data-idx="'+file.idx+'">delete</div></div>';
				$("#gridly").append(str);
			}
			function loadgalleryimg() {
				$.ajax({
					type : 'GET',
					url : '/api/index.php/fileupload/gallerylist?loanid=<?php echo $loan_id;?>',
					dataType : 'json',
					success : function(result) {
						$.each(result.data, function (key,val){
							addimage(val);
							$('.gridly').gridly({
								base: 80, // px
								gutter: 10, // px
								columns: 12,
								callbacks: { reordering: reordering , reordered: reordered }});
						});
					}
				});
			}
			function delgal(delbt){
				if( confirm($(delbt).closest('div.brick').children("div.thumbnail-tite-0").text() + ' 을 삭제하시겠습니까?')){
					$.ajax({
						type : 'POST',
						url : '/api/index.php/fileupload/gallerydel',
						dataType : 'json',
						data:{fileidx:$(delbt).data("idx")},
						success : function(result) {
							if(result.code == "OK") $(delbt).closest('div.brick').remove();
							else alert (result.msg);
						},
						error : function (req, status, error) {alert('에러가 발생했습니다.');}
					});
				}
			}
			$(function () {
					'use strict';
					loadgalleryimg();
					$("[data-fancybox]").fancybox({
						iframe : {
							css : {
								width : '600px'
							}
						}
					});
					$('#fileupload2').fileupload({
							url: "/api/index.php/fileupload/gallery",
							//url:"/api/statics/fileuploader/test.html",
							dataType: 'json',
							formData: {loanid: '<?php echo $loan_id;?>'},
							acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
							add: function(e, data) {
											var uploadErrors = [];
											var acceptFileTypes = /(\.|\/)(gif|jpe?g|png|doc|pdf)$/i;
											//if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
											if(!acceptFileTypes.test(data.originalFiles[0]['type'])) {
													uploadErrors.push('Not an accepted file type');
											}
											if(uploadErrors.length > 0) {
													alert(uploadErrors.join("\n"));
													return;
											} else {
													data.submit();
											}
							},
							done: function (e, data) {
									$.each(data.result.files, function (index, file) {
											if(file.error != ''){
												$('#files2').append('<p><span style="color:blue;">'+file.file_name+'</span><br><span style="padding-left:20px;">[ERROR] '+file.error+'</span></p>');
											}else  {
												addimage(file);
												$('.gridly').gridly();
												//$("#mytable").append("<tr><td>added</td><td>"+file.file_name+"</td><td><a href='/pnpinvest/?update=invest_file_setup&amp;type=d&amp;loan_id=<?php echo $loan_id;?>&amp;file_idx="+file.fileid+"'><img src='/pnpinvest/layouts/admin/basic/img/delete2_btn.png' alt='삭제'></a></td>");
												//$('<p/>').text(file.file_name).appendTo('#files');

											}
									});
							},
							progressall: function (e, data) {
									var progress = parseInt(data.loaded / data.total * 100, 10);
									$('#progress2 .progress-bar').css(
											'width',
											progress + '%'
									);
							}
					}).prop('disabled', !$.support.fileInput)
							.parent().addClass($.support.fileInput ? undefined : 'disabled');
			});
			</script>
			<form name="gallerydesc">
				<?php echo editor_html('gallerydesc', ''); ?>
					<div style="margin-top:10px;margin-bottom5px;text-align:center">
						<a id="jinhaengbt" class="btn btn-preview" href="javascript:;" onclick="gallerydescsave()" style="display: inline;">갤러리글저장하기</a>
					</div>
			</form>
			</div>
		</div>
			<!-- /갤러리 -->

		<!-- / =================================================== -->
















	<!--<div class="title02">심사위원 리스트</div>
	<form name="lawyer_list" id="lawyer_list" action="{MARI_HOME_URL}/?update=invest_setup_form" onsubmit="return lawyerlist_submit(this);" method="post">

		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>회원관리 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="150px" />
					<col width="200px" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>심사원</th>
						<th>심사원정보</th>
						<th>심사내용</th>
					</tr>
				</thead>
				<tbody>
    <?php


	for ($i=0; $row=sql_fetch_array($lawyer); $i++) {
	//$sql = "select * from mari_mari_lawyer_appr where loan_id = '$row[loan_id]'";
	//$loan = sql_fetch($sql);

	/*변호사 평가 출력*/
	$sql = "select * from mari_lawyer_appr where loan_id = '$loan_id' and ly_id = '$row[ly_id]'";
	$appr = sql_fetch($sql);

    ?>
					<tr>
						<td>
						<input type="hidden" name="ly_id[<?php echo $i; ?>]" value="<?php echo $row['ly_id'] ?>">
						<input type="hidden" name="ly_name[<?php echo $i; ?>]" value="<?php echo $row['ly_name']?>">
						<input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i; ?>">
						</td>
						<td>
						<?php
							if(!$row['ly_img']){
								echo '사진없음';
							}else{
							$sfoimg_str = '<img src="'.MARI_DATA_URL.'/lawyer/'.$row['ly_img'].'" width="116" height="116">';
							echo $sfoimg_str;
							}
						?>
						<br/>심사원 : <?php echo $row['ly_name']?>
						<td>
							<?php echo substr($row['ly_hp'],0,3); ?> - <?php echo substr($row['ly_hp'],3,4); ?> - <?php echo substr($row['ly_hp'],7,4); ?><br/><br/>
							<?php echo $row['ly_email']; ?>
						</td>
						</td>
						<td>
							<textarea name="ly_appr[<?php echo $i;?>]" cols="50" rows="8"></textarea>
						</td>


					</tr>
    <?php

    }
    if ($i == 0){?>
        <tr><td colspan="7">변호사 리스트가 없습니다.</td></tr>
<?php } ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택추가" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>

	</form>

		<div class="title02">심사위원</div>
		<form name="lawyer_list" id="lawyer_list" action="{MARI_HOME_URL}/?update=invest_setup_form" onsubmit="return lawyerlist_submit(this);" method="post">

		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>회원관리 목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="200px" />
					<col width="150px" />
					<col width="200px" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>사용유무</th>
						<th>사진</th>
						<th>이름</th>
						<th>심사내용</th>
					</tr>
				</thead>
				<tbody>
    <?php


	for ($i=0; $row=sql_fetch_array($ly_appr); $i++) {

	$sql = "select * from mari_lawyer where ly_id = '$row[ly_id]'";
	$lawyer = sql_fetch($sql);

    ?>
					<tr>
						<td>
						<input type="hidden" name="la_id[<?php echo $i; ?>]" value="<?php echo $row['la_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i; ?>">
						</td>
						<td>
						<input type="radio" id="" name="ly_lawyer_use[<?php echo $i;?>]" value="Y" <?php echo $row['ly_lawyer_use']=='Y'?'checked':'';?> /><label for="" class="mr10">사용</label>
						<input type="radio" id="" name="ly_lawyer_use[<?php echo $i;?>]" value="N" <?php echo $row['ly_lawyer_use']=='N'?'checked':'';?> /> <label for="">미사용</label>
						</td>
						<td>
						<?php
							if(!$lawyer['ly_img']){
								echo '사진없음';
							}else{
							$sfoimg_str = '<img src="'.MARI_DATA_URL.'/lawyer/'.$lawyer['ly_img'].'" width="116" height="116">';
							echo $sfoimg_str;
							}
						?>
						<br/><?php echo $row['ly_name']?>
						</td>
						<td>
							<?php echo $lawyer['ly_name']?><br/>
							<?php echo substr($lawyer['ly_hp'],0,3)?><?php echo substr($lawyer['ly_hp'],3,4)?><?php echo substr($lawyer['ly_hp'],-4)?><br/>
							<?php echo $lawyer['ly_email']?>
						</td>
						<td>
							<textarea name="ly_appr[<?php echo $i;?>]" cols="50" rows="8"><?php echo $row['ly_appr']?></textarea>
						</td>


					</tr>
    <?php

    }
    if ($i == 0){?>
        <tr><td colspan="7">변호사 리스트가 없습니다.</td></tr>
<?php } ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt2" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt3" value="선택삭제" class="select_delete_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>

	</form>-->

		<div class="local_desc02">
			<p>
				1. 정보보기를 눌러 최초대출신청 정보를 확인하실 수 있습니다.<br />
				2. 상품추가+ 를 눌러 상품을 추가/변경 하실 수 있습니다.<br />
				3. 노출여부에 따라 해당 투자가 웹사이트에 노출/미노출 됩니다.<br />
				4. 심사원 사용 체크 시 투자 상품 상세페이지에 노출됩니다.
			</p>
		</div>

    </div><!-- /contaner -->
</div><!-- /wrapper -->

<form name="withdrawl_startsetup_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="o_pay" value="<?php echo $loan['i_loan_pay'];?>"/>
<input type="hidden" name="type" value="w"/>
</form>

<link rel="stylesheet" href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-datetimepicker/jquery.simple-dtpicker.css">
<script type="text/javascript" src="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-datetimepicker/jquery.simple-dtpicker.js?__=v2"></script>
<script>
$(function(){
	$('.datetime').appendDtpicker({
		"locale": "ko",
		"futureOnly":true,
		"minTime":"10:00",
		"maxTime":"23:59",
	});
});
</script>


<script>
/*필수체크*/
$(function() {
	$('#invest_form_add').click(function(){
		Invest_form_Ok(document.invest_setup_form);
	});
});


function Invest_form_Ok(f){

	<?php echo get_editor_js('i_binding'); ?>
	<?php echo get_editor_js('i_invest_summary'); ?>
	<?php echo get_editor_js('i_invest_manage'); ?>
	<?php echo get_editor_js('i_security'); ?>
	<?php echo get_editor_js('i_summary'); ?>
	<?php echo get_editor_js('i_reviewers_contact'); ?>
	<?php echo get_editor_js('i_reviewers_contact_01'); ?>

	//제목
	if(!f.i_invest_name.value){alert('\n제목을 입력하여 주십시오.');f.i_invest_name.focus();return false;}

	if(!f.i_invest_sday.value){alert('\n모집시작일을 입력하여 주십시오.');f.i_invest_sday.focus();return false;}

	if(!f.i_invest_eday.value){alert('\n모집종료일을 입력하여 주십시오.');f.i_invest_eday.focus();return false;}
	//신용등급
	var loana_pattern = /[^(0-9)]/;//숫자
	if(loana_pattern.test(f.i_invest_level.value)){alert('\n신용등급은 숫자만 입력하실수 있습니다');f.i_invest_level.value='';f.i_invest_level.focus();return false;}
	//신용평점
	var loanp_pattern = /[^(0-9)]/;//숫자
	if(loanp_pattern.test(f.i_level_point.value)){alert('\n신용평점은 숫자만 입력하실수 있습니다');f.i_level_point.value='';f.i_level_point.focus();return false;}
	//현재투자율
	var per_pattern = /[^(0-9)]/;//숫자
	if(per_pattern.test(f.i_invest_per.value)){alert('\n현재투자율은 숫자만 입력하실수 있습니다');f.i_invest_per.value='';f.i_invest_per.focus();return false;}
	//현재참여인원
	var people_pattern = /[^(0-9)]/;//숫자
	if(people_pattern.test(f.i_people.value)){alert('\n현재참여인원은 숫자만 입력하실수 있습니다');f.i_people.value='';f.i_people.focus();return false;}




	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=invest_setup_form';
	f.submit();
}



/*신용송부재조회*/
function Calculation() {
  var f=document.invest_setup_form;
  var opt = "status=yes,toolbar=no,scrollbars=yes,width=750,height=750,left=0,top=0";
  window.open("about:blank", "calculation", opt);
  f.action="https://www.creditinfo.co.kr/nicecredit/web_link/jsp/auth/authInqra.jsp";
  f.submit();
}

/*엑셀다운로드*/
function goto_xlsm_time()
{
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>&loan_id=<?php echo $loan_id?>';
}



/*통장출금*/
function Withdrawl() {
  var f=document.withdrawl_startsetup_form;
  f.action="{MARI_HOME_URL}/?update=withdrawl_ok";
  f.submit();
}

//따옴표 입력방지
function checkNumber()
{
 var objEv = event.srcElement;
 var num ="\"\'";    //입력을 막을 특수문자 기재.
 event.returnValue = true;

 for (var i=0;i<objEv.value.length;i++)
 {
 if(-1 != num.indexOf(objEv.value.charAt(i)))
 event.returnValue = false;
 }

 if (!event.returnValue)
 {
  alert("\"(쌍따옴표) 또는 \'(작은따옴표)는  입력하실 수 없습니다.");
  objEv.value="";
 }
}

function cnj_comma(cnj_str) {
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = "";
		var cnjValue2 = "";

		if (!num.test(cnj_str.value))   {
		alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
		cnj_str.value="";
		cnj_str.focus();
		return false;
		}

		if ((t_num < "0" || "9" < t_num)){
		alert("숫자만 입력하십시오.");
		cnj_str.value="";
		cnj_str.focus();
		return false;
		}

		for(i=0; i<cnj_str.value.length; i++)      {
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") {
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2;
		}
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) {
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue;
		} else {
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue;
		}
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}

$('.calendar').datepicker({
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
 });


   function updateChar(FieldName, contentName, textlimitName){
	var strCount = 0;
	var tempStr, tempStr2;
	var frm = document.getElementById(contentName);
	var size = frm.value.length;
	for(i = 0;i < size;i++){
		tempStr = frm.value.charAt(i);
		if(escape(tempStr).length > 4) strCount += 2;
		else strCount += 1 ;
	}

	if (strCount > FieldName){
		alert("최대 " + FieldName + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
		strCount = 0;
		tempStr2 = "";
		for(i = 0; i < size; i++){
			tempStr = frm.value.charAt(i);

			if(escape(tempStr).length > 4) strCount += 2;
			else strCount += 1 ;

			if (strCount > FieldName){
				if(escape(tempStr).length > 4) strCount -= 2;
				else strCount -= 1 ;
				break;
			} else tempStr2 += tempStr;
		}
		frm.value = tempStr2;
	}
	document.getElementById(textlimitName).innerHTML = strCount;
}

/*첨부파일리스트 추가*/
function add_row() {
  mytable = document.getElementById('mytable');
  row = mytable.insertRow(mytable.rows.length);
  cell1 = row.insertCell(0);
  cell2 = row.insertCell(1);
  cell3 = row.insertCell(2);
  cell1.innerHTML = "";
  cell2.innerHTML = "<input type=\"file\" name=\"file_name[]\" value=\"\" class=\"frm_input\" size=\"30\">";
  cell3.innerHTML = "";

}
</script>

{# s_footer}<!--하단-->
