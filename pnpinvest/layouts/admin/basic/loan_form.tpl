<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<script>
function go_url(url)
{
	location.href = url;
}
</script>
<div id="wrapper">
	<div id="left_container">
	{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">대출관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="container">
		<div class="title02">대출신청</div>
		<h2 class="bo_title"><span>대출신청 정보</span></h2>
	<form name="loan_form"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="type" value="<?php echo $type;?>"/>
	<input type="hidden" name="i_id" value="<?php echo $loa['i_id'];?>"/>
	<input type="hidden" name="m_id" value="<?php echo $m_id;?>">
	<input type="hidden" name="m_name" value="<?php echo $m_name;?>">
	<input type="hidden" name="m_hp" value="<?php echo $m_hp;?>">
	<input type="hidden" name="office_type" value="<?php echo $office;?>">
	<!--지도 위도 경도-->
	<input type="hidden" name="i_locaty_01" id="i_locaty_01" value="<?php echo $loa['i_locaty_01'];?>"/>
	<input type="hidden" name="i_locaty_02" id="i_locaty_02" value="<?php echo $loa['i_locaty_02'];?>"/>

		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>대출신청 정보</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
					<th>대출타입 설정</th>
					<td>
						<select  name="ca_id" onchange="javascript:go_url(this.options[this.selectedIndex].value);">
						<?php if($type=="w"){?>
						<option value="{MARI_HOME_URL}/?cms=loan_form&type=w">선택하세요</option>
						<?php }?>
						<option value="{MARI_HOME_URL}/?cms=loan_form&type=<?php echo $type; ?>&i_id=<?php echo $loa[i_id]?>&i_loan_type=real"  <?php echo $i_loan_type=='real'?'selected':'';?>>부동산</option>
						<option value="{MARI_HOME_URL}/?cms=loan_form&type=<?php echo $type; ?>&i_id=<?php echo $loa[i_id]?>&i_loan_type=credit" <?php echo $i_loan_type=='credit'?'selected':'';?>>개인신용</option>
						<option value="{MARI_HOME_URL}/?cms=loan_form&type=<?php echo $type; ?>&i_id=<?php echo $loa[i_id]?>&i_loan_type=business" <?php echo $i_loan_type=='business'?'selected':'';?>>사업자</option>
						</select>
					</td>
				</tr>
				</tbody>
			</table>
		</div>

		<?php if($i_loan_type=="real"){?>
			{# admin_real}
		<?php }?>
		<?php if($i_loan_type=="credit" || $i_loan_type=="business"){?>
			{# admin_credit}
		<?php }?>


		<h2 class="bo_title mt40"><span>부채 내역</span></h2>
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>부채 내역</caption>
				<colgroup>
					<col width="170px;" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
						<th>DTI</th>
						<td>
							<p class="color_re fb">* DTI (월부채상환금액/월소득)*100</p>
							<input type="text" name="i_level_dti" value="<?php echo $loa['i_level_dti'];?>" id="" required   class="frm_input " size="10" />%
						</td>
					</tr>
					<tr>
						<th>신용정보</th>
						<td>
							<p class="color_re fb">* 신용보고서의 내용을 입력해주십시오.(반드시 보이는대로 기입할 것)</p>
							<p><label>신용 평점</label> :  <input type="text" name="i_creditpoint_one" value="<?php echo $loa['i_creditpoint_one'];?>" id="" required   class="frm_input " size="10" /></p>
							<p><label>신용 등급</label> :  <input type="text" name="i_creditpoint_two" value="<?php echo $loa['i_creditpoint_two'];?>" id="" required   class="frm_input " size="10" /></p>
							<p><label>예측부도율</label> :  <input type="text" name="i_expact_fail" value="<?php echo $loa['i_expact_fail'];?>" id="" required   class="frm_input " size="10" /></p>
							<!--<p><label>월 금융상환비용</label> :  <input type="text" name="i_credit_pay" value="<?php echo $loa['i_credit_pay'];?>" id=""  required  class="frm_input " size="" /> 원 / <span class="fb">매월 부채 상환을 위해 지출되는 총 비용을 기재해주십시오.</span></p>-->
						</td>
					</tr>
					<tr>
						<th>부채내역</th>
						<td>
							<p required  class="color_re fb">* 신용보고서 확인 후, 등재된 기록을 포함하여 대부업 및 기타 부채도 입력해주십시오.</p>
							<div required  class="pb5 txt_r">
							<a href="javascript:void(0);"><img src="{MARI_ADMINSKIN_URL}/img/debt_view_btn.png" alt="부채내역 추가"  onclick="add_row()" /></a></div>
							<table class="type2">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>금융기관분류</th>
										<th>금융기관명</th>
										<th>대출잔액</th>
										<th>대출구분</th>
										<th>관리</th>
									</tr>
								</thead>
								<?php if(!$deb['m_id']){?>
								<input type="hidden" name="uptype" value="insert"/>
								<?php }else{?>
								<input type="hidden" name="num" value="<?php echo $deb['i_no'];?>"/>
								<input type="hidden" name="uptype" value="update"/>
								<?php }?>
								<tbody id="mytable">
				<?php
				if(!$deb['m_id']=="")
				{
					$i_debt_list = explode("[RECORD]",$deb[i_debt_list]);
					if($deb[i_debt_list]!="")
					{
						for($i=0;$i<count($i_debt_list);$i++)
						{
							$tmp_option = explode("[FIELD]",$i_debt_list[$i]);
							?>
									<tr>
										<td>
											<select name="i_debt_company[]"  >
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>
										</td>
										<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id=""    class="frm_input " size="" alt="금융기관명"/></td>
										<td><input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="frm_input " size="" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
										<td>
										<a href="javascript:void(0);"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" onclick="delete_row()" style="cursor:pointer;"/></a>
										</td>
									</tr>
					<?php
						}
					}
					else
					{
					?>
									<tr>
										<td>
											<select name="i_debt_company[]"  >
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>
										</td>
										</td>
										<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id=""    class="frm_input " size="" alt="금융기관명"/></td>
										<td><input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="frm_input " size="" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
										<td>
										<a href="javascript:void(0);"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" onclick="delete_row()" style="cursor:pointer;"/></a>
										</td>
									</tr>

					<?php
						}
					}
					else
					{
					?>
									<tr>
										<td>
											<select name="i_debt_company[]"  >
												<option>선택</option>
												<option value="은행/보험" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option>
												<option value="카드/신협/새마을금고" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option>
												<option value="캐피탈/증권사" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option>
												<option value="저축은행" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option>
												<option value="현금서비스" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option>
												<option value="대부업" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>
											</select>
										</td>
										</td>
										<td><input type="text" name="i_debt_name[]" value="<?php echo $tmp_option[1];?>" id=""    class="frm_input " size="" alt="금융기관명"/></td>
										<td><input type="text" name="i_debt_pay[]" value="<?php echo number_format($tmp_option[2]);?>" id=""  onkeyup="cnj_comma(this);" onchange="cnj_comma(this);"  class="frm_input " size="" alt="대출잔액"/></td>
										<td>
											<select name="i_debt_kinds[]" >
												<option>선택</option>
												<option value="신용대출" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option>
												<option value="담보대출" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option>
											</select>
										</td>
										<td>
										<a href="javascript:void(0);"><img src="{MARI_ADMINSKIN_URL}/img/delete4_btn.png" alt="삭제" onclick="delete_row()" style="cursor:pointer;"/></a>
										</td>
									</tr>
					<?php }?>
								</tbody>
							</table>

						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_confirm01 btn_confirm">
			<!--<input type="image" src="{MARI_ADMINSKIN_URL}/img/save2_btn.png" alt="저장" id="loan_form_add" />-->
			<a href="javascript:void(0);" onclick="send()"><img src="{MARI_ADMINSKIN_URL}/img/save2_btn.png" alt="목록"></a>
			<a href="{MARI_HOME_URL}/?cms=loan_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
		</div>
		</form>
<?php if($loa[i_repay]=="원리금균등상환"){?>

 	<h2 class="bo_title mt40"><span>월불입금관리 [<?php echo $loa[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=loan_form" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $i_id;?>">
	<input type="hidden" name="user_id" value="<?php echo $loa[m_id];?>">
	<input type="hidden" name="user_name" value="<?php echo $loa[m_name];?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $loa[i_loan_day];?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $ln_money;?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $loa['i_year_plus'];?>"><!--연이율-->
	<input type="hidden" name="i_repay" value="<?php echo $loa['i_repay'];?>"><!--상환방식-->
	<input type="hidden" name="i_loan_type" value="<?php echo $ln_type?>"><!-- 대출타입 -->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>월불입금</caption>
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<table class="type2">
								<colgroup>
									<col width="60px" />
									<col width="60px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th><!--<input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)">--> 선택</th>
										<th>회차</th>
										<th>월불입금</th>
										<th>납입원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>
										</td>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($mh_total) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									-->
								<?php
								$topPrice = $mh_total;

								$ln_kigan = $ln_kigan - $stop;

								$일년이자 = $ln_money*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$rate = (($ln_iyul/100)/12);
								$상환금 = ($ln_money*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1));

								   for($i =0 ; $i <$ln_kigan; ++$i){
									if(!$order[o_mh_money]){
										$topPrice-=$mh_money;
									}else{
										$topPrice-=$order[o_mh_money];
									}

									$납입원금계 += ($상환금-$첫달이자);
									$잔금 = $ln_money-$납입원금계;
									$납입원금 = $상환금-$첫달이자;
									$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
									$num=$i+1;
								    $sql = "select  * from  mari_order where loan_id='$i_id' and o_count='$num' order by o_datetime desc limit 1";
								    $order = sql_fetch($sql, false);
								?>
									<tr>
										<td>
						<?php if($order['o_status']=="입금완료"){?>
						<?php }else{?>
						<input type="checkbox" name="check[]" value="<?php echo $num ?>" onclick="check_only(this)">
						<?php }?>
						<input type="hidden" name="o_count[<?php echo $num ?>]" value="<?php echo $num;?>"><!--회차-->
						<input type="hidden" name="o_interestrate[<?php echo $num ?>]" value="<?php echo $month_eja;?>"><!--월이율-->
						<input type="hidden" name="o_totalamount[<?php echo $num ?>]" value="<?php echo $mh_total;?>"><!--원금+이자총금액-->
						<input type="hidden" name="o_salestatus[<?php echo $num ?>]" value="정산대기"><!--투자자 정산상태-->
						<input type="hidden" name="o_id[<?php echo $num ?>]" value="<?php echo $order[o_id]; ?>"><!--order번호-->
						<input type="hidden" name="sale_odinterest[<?php echo $num ?>]" value="<?php echo $order['o_odinterest']; ?>"><!--연체금액-->
						<input type="hidden" name="to_ln_money[<?php echo $num ?>]" value="<?=$잔금>0?$납입원금:$납입원금+$잔금?>"><!--월원금-->
						<input type="hidden" name="loan_type[<?php echo $num;?>]" value="<?php echo $ln_type?>"><!-- 대출타입 -->
										</td>
										<td><?php echo $num;?>회차</td>
										<?php if(!$order['o_mh_money']){?>
										<td><input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?=number_format($잔금>0?$상환금:$납입원금+$잔금+$첫달이자)?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($잔금>0?$잔금:"0")?>" class="frm_input" size="20"> 원</td>
										<?php }else{?>
										<td><input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?php echo number_format($order[o_mh_money]); ?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($잔금>0?$잔금:"0");?>" class="frm_input" size="20"> 원</td>
										<?php }?>
										<td>
										<input type="text" name="o_odinterestcount[<?php echo $num ?>]" value="<?php echo number_format($order[o_odinterestcount]); ?>" class="frm_input" size="7"> 일
										</td>
										<td>
										<?php echo number_format($order['o_odinterest']) ?> 원
										</td>
										<td>
							<select name="o_status[<?php echo $num ?>]"  >
								<option value="">선택</option>
								<option value="입금완료" <?php echo $order['o_status']=='입금완료'?'selected':'';?>>입금완료</option>
								<option value="연체" <?php echo $order['o_status']=='연체'?'selected':'';?>>연체중</option>

							</select>
										</td>
									</tr>
								<?php
								$이자합산 += $첫달이자;
								$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
								$월불입금합산=$납입원금합산+$이자합산;
								$일년이자 = $잔금*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td></td>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($납입원금합산) ?> 원</td>
										<td><?php echo number_format($이자합산) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
<?php }else if($loa[i_repay]=="일만기일시상환"){?>
 		<h2 class="bo_title mt40"><span>월불입금관리 [<?php echo $loa[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=loan_form" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $i_id;?>">
	<input type="hidden" name="user_id" value="<?php echo $loa[m_id];?>">
	<input type="hidden" name="user_name" value="<?php echo $loa[m_name];?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $loa[i_loan_day];?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $ln_money;?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $loa['i_year_plus'];?>"><!--연이율-->
	<input type="hidden" name="i_repay" value="<?php echo $loa['i_repay'];?>"><!--상환방식-->
	<input type="hidden" name="i_loan_type" value="<?php echo $ln_type?>"><!-- 대출타입 -->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>월불입금</caption>
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<table class="type2">
								<colgroup>
									<col width="60px" />
									<col width="60px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th><!--<input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)">--> 선택</th>
										<th>회차</th>
										<th>월불입금</th>
										<th>납입원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>
										</td>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($mh_total) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									-->
								<?php
								$topPrice = $mh_total;

								$일년이자 = $ln_money*($ln_iyul/100);
								$전체이자=$첫달이자*$ln_kigan;
								for($i=1; $i<=$loa['i_loan_day']; $i++){
								$첫달이자 = substr(($일년이자/365),0,-1)."0";
								$daynum=$i-1;
								/*해당월 매회차 마지막날짜구하기*/
								$order_month = date("Y-m-d", strtotime($loa[i_loanexecutiondate]."+".$daynum."month"));
								$jinday_count = date('t', strtotime("".$order_month.""));
								$첫달이자=$첫달이자*$jinday_count;
									if($order[o_mh_money]){
										$topPrice-=$order[o_mh_money];
									}
									$num=$i;
								    $sql = "select  * from  mari_order where loan_id='$i_id' and o_count='$num' order by o_datetime desc limit 1";
								    $order = sql_fetch($sql, false);
								?>
									<tr>
										<td>

						<?php if($order['o_status']=="입금완료"){?>
						<?php }else{?>
						<input type="checkbox" name="check[]" value="<?php echo $num ?>" onclick="check_only(this)">
						<?php }?>

						<input type="hidden" name="o_count[<?php echo $num ?>]" value="<?php echo $num;?>"><!--회차-->
						<input type="hidden" name="o_interestrate[<?php echo $num ?>]" value="<?php echo $month_eja;?>"><!--월이율-->
						<input type="hidden" name="o_totalamount[<?php echo $num ?>]" value="<?php echo $mh_total;?>"><!--원금+이자총금액-->
						<input type="hidden" name="o_salestatus[<?php echo $num ?>]" value="정산대기"><!--투자자 정산상태-->
						<input type="hidden" name="o_id[<?php echo $num ?>]" value="<?php echo $order[o_id]; ?>"><!--order번호-->
						<input type="hidden" name="sale_odinterest[<?php echo $num ?>]" value="<?php echo $order['o_odinterest']; ?>"><!--연체금액-->
						<input type="hidden" name="loan_type[<?php echo $num;?>]" value="<?php echo $ln_type?>"><!-- 대출타입 -->
						<input type="hidden" name="to_ln_money[<?php echo $num ?>]" value="<?=$ln_money?>"><!--월원금-->
						<input type="hidden" name="i_reday[<?php echo $num ?>]" value="<?=$daynum?>"><!--월원금-->
										</td>
										<td><?php echo $i;?>회차</td>
										<?php if(!$order['o_mh_money']){?>
										<td>(<?php echo $jinday_count;?>일) <input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?$ln_money+$첫달이자:$첫달이자);?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }else{?>
										<td>(<?php echo $jinday_count;?>일) <input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?php echo number_format($order[o_mh_money]); ?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }?>
										<td>
										<input type="text" name="o_odinterestcount[<?php echo $num ?>]" value="<?php echo number_format($order[o_odinterestcount]);; ?>" class="frm_input" size="7"> 일
										</td>
										<td>
										<?php echo number_format($order['o_odinterest']) ?> 원
										</td>
										<td>
							<select name="o_status[<?php echo $num ?>]"  >
								<option value="">선택</option>
								<option value="입금완료" <?php echo $order['o_status']=='입금완료'?'selected':'';?>>입금완료</option>
								<option value="연체" <?php echo $order['o_status']=='연체'?'selected':'';?>>연체중</option>

							</select>
										</td>
									</tr>
								<?php
									$이자합산 += $첫달이자;
									$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
									$전체이자=$첫달이자*$ln_kigan;
									$월불입금합산=$ln_money+$이자합산;
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td></td>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($ln_money) ?> 원</td>
										<td><?php echo number_format($이자합산) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
<?php }else if($loa[i_repay]=="만기일시상환"){?>
 		<h2 class="bo_title mt40"><span>월불입금관리 [<?php echo $loa[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=loan_form" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $i_id;?>">
	<input type="hidden" name="user_id" value="<?php echo $loa[m_id];?>">
	<input type="hidden" name="user_name" value="<?php echo $loa[m_name];?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $loa[i_loan_day];?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $ln_money;?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $loa['i_year_plus'];?>"><!--연이율-->
	<input type="hidden" name="i_repay" value="<?php echo $loa['i_repay'];?>"><!--상환방식-->
	<input type="hidden" name="i_loan_type" value="<?php echo $ln_type?>"><!-- 대출타입 -->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>월불입금</caption>
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<table class="type2">
								<colgroup>
									<col width="60px" />
									<col width="60px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th><!--<input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)">--> 선택</th>
										<th>회차</th>
										<th>월불입금</th>
										<th>납입원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>
										</td>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($mh_total) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									-->
								<?php
								$topPrice = $mh_total;

								$일년이자 = $ln_money*($ln_iyul/100);
								$첫달이자 = substr(($일년이자/12),0,-1)."0";
								$전체이자=$첫달이자*$ln_kigan;
								for($i=1; $i<=$loa['i_loan_day']; $i++){

									if($order[o_mh_money]){
										$topPrice-=$order[o_mh_money];
									}
									$num=$i;
								    $sql = "select  * from  mari_order where loan_id='$i_id' and o_count='$num' order by o_datetime desc limit 1";
								    $order = sql_fetch($sql, false);
								?>
									<tr>
										<td>

						<?php if($order['o_status']=="입금완료"){?>
						<?php }else{?>
						<input type="checkbox" name="check[]" value="<?php echo $num ?>" onclick="check_only(this)">
						<?php }?>

						<input type="hidden" name="o_count[<?php echo $num ?>]" value="<?php echo $num;?>"><!--회차-->
						<input type="hidden" name="o_interestrate[<?php echo $num ?>]" value="<?php echo $month_eja;?>"><!--월이율-->
						<input type="hidden" name="o_totalamount[<?php echo $num ?>]" value="<?php echo $mh_total;?>"><!--원금+이자총금액-->
						<input type="hidden" name="o_salestatus[<?php echo $num ?>]" value="정산대기"><!--투자자 정산상태-->
						<input type="hidden" name="o_id[<?php echo $num ?>]" value="<?php echo $order[o_id]; ?>"><!--order번호-->
						<input type="hidden" name="sale_odinterest[<?php echo $num ?>]" value="<?php echo $order['o_odinterest']; ?>"><!--연체금액-->
						<input type="hidden" name="loan_type[<?php echo $num;?>]" value="<?php echo $ln_type?>"><!-- 대출타입 -->
						<input type="hidden" name="to_ln_money[<?php echo $num ?>]" value="<?=$ln_money?>"><!--월원금-->
										</td>
										<td><?php echo $i;?>회차</td>
										<?php if(!$order['o_mh_money']){?>
										<td><input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?$ln_money+$첫달이자:$첫달이자);?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }else{?>
										<td><input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?php echo number_format($order[o_mh_money]); ?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }?>
										<td>
										<input type="text" name="o_odinterestcount[<?php echo $num ?>]" value="<?php echo number_format($order[o_odinterestcount]); ?>" class="frm_input" size="7"> 일
										</td>
										<td>
										<?php echo number_format($order['o_odinterest']); ?> 원
										</td>
										<td>
							<select name="o_status[<?php echo $num ?>]"  >
								<option value="">선택</option>
								<option value="입금완료" <?php echo $order['o_status']=='입금완료'?'selected':'';?>>입금완료</option>
								<option value="연체" <?php echo $order['o_status']=='연체'?'selected':'';?>>연체중</option>

							</select>
										</td>
									</tr>
								<?php
									$이자합산 += $첫달이자;
									$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
									$전체이자=$첫달이자*$ln_kigan;
									$월불입금합산=$만기이자+$전체이자-$첫달이자;
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td></td>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($ln_money) ?> 원</td>
										<td><?php echo number_format($이자합산) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
<?php
}else if($loa[i_repay]=="만기일시상환선취"){
$i_loan_day_s=$loa[i_loan_day]+1;
?>
 		<h2 class="bo_title mt40"><span>월불입금관리 [<?php echo $loa[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=loan_form" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $i_id;?>">
	<input type="hidden" name="user_id" value="<?php echo $loa[m_id];?>">
	<input type="hidden" name="user_name" value="<?php echo $loa[m_name];?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $i_loan_day_s;?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $ln_money;?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $loa['i_year_plus'];?>"><!--연이율-->
	<input type="hidden" name="i_repay" value="<?php echo $loa['i_repay'];?>"><!--상환방식-->
	<input type="hidden" name="i_loan_type" value="<?php echo $ln_type?>"><!-- 대출타입 -->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>월불입금</caption>
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<table class="type2">
								<colgroup>
									<col width="60px" />
									<col width="60px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th><!--<input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)">--> 선택</th>
										<th>회차</th>
										<th>월불입금</th>
										<th>납입원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>
										</td>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($mh_total) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									-->
								<?php
								$topPrice = $mh_total;

								$일년이자 = $ln_money*($ln_iyul/100);
								$첫달이자 = substr(round($일년이자/12),0,-1)."0";
								$전체이자=$첫달이자*$ln_kigan;
								for($i=1; $i<=$i_loan_day_s; $i++){

									if($order[o_mh_money]){
										$topPrice-=$order[o_mh_money];
									}
									$num=$i;
								    $sql = "select  * from  mari_order where loan_id='$i_id' and o_count='$num' order by o_datetime desc limit 1";
								    $order = sql_fetch($sql, false);
								?>
									<tr>
										<td>

						<?php if($order['o_status']=="입금완료"){?>
						<?php }else{?>
						<input type="checkbox" name="check[]" value="<?php echo $num ?>" onclick="check_only(this)">
						<?php }?>

						<input type="hidden" name="o_count[<?php echo $num ?>]" value="<?php echo $num;?>"><!--회차-->
						<input type="hidden" name="o_interestrate[<?php echo $num ?>]" value="<?php echo $month_eja;?>"><!--월이율-->
						<input type="hidden" name="o_totalamount[<?php echo $num ?>]" value="<?php echo $mh_total;?>"><!--원금+이자총금액-->
						<input type="hidden" name="o_salestatus[<?php echo $num ?>]" value="정산대기"><!--투자자 정산상태-->
						<input type="hidden" name="o_id[<?php echo $num ?>]" value="<?php echo $order[o_id]; ?>"><!--order번호-->
						<input type="hidden" name="sale_odinterest[<?php echo $num ?>]" value="<?php echo $order['o_odinterest']; ?>"><!--연체금액-->
						<input type="hidden" name="loan_type[<?php echo $num;?>]" value="<?php echo $ln_type?>"><!-- 대출타입 -->
						<input type="hidden" name="to_ln_money[<?php echo $num ?>]" value="<?=$ln_money?>"><!--월원금-->
										</td>
										<td><?php echo $i;?>회차</td>
										<?php if(!$order['o_mh_money']){?>
										<td>
										<?php if($num==$i_loan_day_s){?>
										<input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?php echo number_format($ln_money);?>" class="frm_input" size="20"><!--월불입금--> 원
										<?php }else{?>
										<input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?$ln_money+$첫달이자:$첫달이자);?>" class="frm_input" size="20"><!--월불입금--> 원
										<?php }?>
										</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td>
										<?php if($num==$i_loan_day_s){?>
										<?php }else{?>
										<?=number_format($첫달이자)?> 원
										<?php }?>
										</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }else{?>
										<td><input type="text" name="o_mh_money[<?php echo $num ?>]" value="<?php echo number_format($order[o_mh_money]); ?>" class="frm_input" size="20"><!--월불입금--> 원</td>
										<td><?=$i==$ln_kigan?number_format($ln_money):"0"?> 원</td>
										<td>
										<?php if($num==$i_loan_day_s){?>
										<?php }else{?>
										<?=number_format($첫달이자)?> 원
										<?php }?>
										</td>
										<td><input type="text" name="o_amount[<?php echo $num ?>]" value="<?=number_format($i==$ln_kigan?"0":$ln_money);?>" class="frm_input" size="20"> 원</td>
										<?php }?>
										<td>
										<input type="text" name="o_odinterestcount[<?php echo $num ?>]" value="<?php echo number_format($order[o_odinterestcount]); ?>" class="frm_input" size="7"> 일
										</td>
										<td>
										<?php echo number_format($order['o_odinterest']) ?> 원
										</td>
										<td>
							<select name="o_status[<?php echo $num ?>]"  >
								<option value="">선택</option>
								<option value="입금완료" <?php echo $order['o_status']=='입금완료'?'selected':'';?>>입금완료</option>
								<option value="연체" <?php echo $order['o_status']=='연체'?'selected':'';?>>연체중</option>

							</select>
										</td>
									</tr>
								<?php
									$이자합산 += $첫달이자;
									$만기이자=$i==$ln_kigan?$ln_money+$첫달이자:$첫달이자+$전체이자;
									$전체이자=$첫달이자*$ln_kigan-$첫달이자;
									$월불입금합산=$만기이자+$전체이자-$첫달이자;
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td></td>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($ln_money) ?> 원</td>
										<td><?php echo number_format($전체이자) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
<?php }?>
			<p class="pt10">
				1. '정산완료' 처리시 해당 상품의 투자회원에게 e-머니로 지급되며 '회원관리 > e-머니관리 메뉴에서 정산된 e-머니 지급내역을 확인하실 수 있습니다.<br/>
				2. 회차별 입금처리&연체는 1개의 회차의 체크박스를 선택하신후 '선택수정'을 눌러 입금처리&연체 하실 수 있습니다.<br />
				3. 연체 설정의 경우 연체일수 입력하신후 상태값을 '연체중'으로 선택하신후 저장하셔야만 연체처리가 됩니다.<br />
				4. 연체중인 회차의경우 언제든 연체일수를 변경하실 수 있으며 연체이자금액또한 횟수에따라 자동계산됩니다. 체크박스를 선택후 처리가 가능합니다.<br/>
				5. '입금완료' 처리시 해당 회차의 체크박스가 비활성화 됩니다.<br/>
			</p>

		</div>

		<div class="btn_confirm01 btn_confirm">

			<input type="submit" name="add_bt" value="입금처리" class="select_order_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />

			<a href="{MARI_HOME_URL}/?cms=loan_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
		</div>
	</form>

	<div class="tbl_frm01 tbl_wrap">
<?php
/*지급정보view 회원정보노출*/
$sql = "select * from mari_member where m_id = '$loa[m_id]'";
$mem = sql_fetch($sql, false);

$sql = "select * from mari_seyfert where m_id='$loa[m_id]' and s_memuse='Y'";
$seyck = sql_fetch($sql, false);
?>
	<h2 class="bo_title mt40"><span>대출액 지급정보 [채무자 : <?php echo $mem['m_name'];?>님]</span></h2>
	<form name="loan_order" id="loan_order" action="{MARI_HOME_URL}/?update=loan_order" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $i_id;?>">
	<input type="hidden" name="m_id" value="<?php echo $loa[m_id];?>">
	<input type="hidden" name="m_name" value="<?php echo $loa[m_name];?>">
	<!--input type="hidden" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>"-->
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>대출액 지급정보</caption>
				<colgroup>
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<table class="type2">
								<colgroup>
									<col width="60px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>선택</th>
										<th>대출지급 예정액</th>
										<th>지급은행</th>
										<th>지급가상계좌(상환용)</th>
										<th>출금은행</th>
										<th>출금계좌</th>
										<th>예금주</th>
										<th>대출기간</th>
										<th>지급여부</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox" name="check[]" value="Y" onclick="check_only(this)"></td>
										<td>
												<input type="text" name="i_loan_pay" value="<?php echo $loa['i_loan_pay'];?>"> 원
									  </td>
										<td><?php echo !$seyck['s_bnkCd']?'가상계좌은행미등록(필수)':''.bank_name($seyck[s_bnkCd]).'';?></td>
										<td><?php echo !$seyck['s_accntNo']?'가상계좌미생성(필수)':''.$seyck[s_accntNo].'';?></td>
										<td><?php echo !$mem['m_my_bankname']?'출금은행미등록':''.bank_name($mem[m_my_bankcode]).'';?></td>
										<td><?php echo !$mem['m_my_bankacc']?'출금계좌미등록':''.$mem[m_my_bankacc].'';?></td>
										<td><?php echo !$mem['m_my_bankname']?'예금주미등록':''.$mem[m_my_bankname].'';?></td>
										<td><?php echo $loa['i_loan_day'];?>개월</td>
										<td>
							<select name="i_pendingsf_use"  >
								<option value="">선택</option>
								<option value="Y" <?php echo $loa['i_pendingsf_use']=='Y'?'selected':'';?>>지급완료</option>
								<option value="N" <?php echo $loa['i_pendingsf_use']=='N'?'selected':'';?>>지급대기</option>

							</select>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>


			<p class="pt10">
				1. '대출실행' 처리시 해당 채무자: <b><?php echo $mem['m_name'];?></b>님의 가상계좌로 <b><?php echo number_format($loa['i_loan_pay']);?></b>원의 대출금이 지급됩니다..<br/>
				2. 지급이 완료된후에는 '지급여부'에서 현재상태를 확인하실 수 있습니다.<br />
				3. 대출이 실행중일경우 '대출실행'버튼은 비 활성화되어 중복지급이 불가합니다.<br />
				4. 상환의 완료되었을경우 '가상계좌해지'를 눌러 가상계좌를 해지하여주시기 바랍니다.<br />
			</p>
		</div>
		<div class="btn_confirm01 btn_confirm">
		<?php if($loa['i_pendingsf_use']=="N"){?>
			<?php if(!$seyck['s_accntNo'] && !$seyck['s_bnkCd']){?>
			※ 해당 채무자의 가상계좌를 생성하신후 대출을 실행하실 수 있습니다.
			<?php }else{?>
			    <input type="submit" name="add_bt" value="대출실행" style="width:68px;height:23px;background:#0d97d7;color:#fff;border:1px solid #5a5959;border-radius: 4px;font-size:11px;"  onclick="document.pressed=this.value" />
				<input type="submit" name="add_bt" value="가상계좌해지" style="width:68px;height:23px;background:#0d97d7;color:#fff;border:1px solid #5a5959;border-radius: 4px;font-size:11px;"  onclick="document.pressed=this.value" />
			<?php }?>
		<?php }?>
		</div>
	</form>
    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>

/*필수체크*/
$(function(){
	$('#loan_form_add').click(function(){
		Loan_form_Ok(document.loan_form);
	});
});
function Loan_form_Ok(f){
	<?php echo get_editor_js('i_loan_pose'); ?>
	<?php echo get_editor_js('i_ltext'); ?>
	<?php echo get_editor_js('i_plan'); ?>


	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=loan_form';
	f.submit();
}
function send(){
	var f = document.loan_form;

	<?php if($i_loan_type=="real"){?>
		<?php echo get_editor_js('i_loan_pose'); ?>
		<?php echo get_editor_js('i_ltext'); ?>
		<?php echo get_editor_js('i_plan'); ?>
		<?php echo get_editor_js('i_zone'); ?>
		<?php echo get_editor_js('i_educa'); ?>
		<?php echo get_editor_js('i_traffic'); ?>
	<?php }?>
	if(!f.i_loan_pay.value){alert('\n필요자금을 입력하여 주십시오.');f.i_loan_pay.focus();return false;}

	if(!f.i_year_plus.value){alert('\n연 이자율을 입력하여 주십시오.');f.i_year_plus.focus();return false;}

	if(f.i_repay[0].selected == true){alert('\n상환방식을 선택하세요');return false;}

	if(!f.i_loan_day.value){alert('\n대출기간을 입력하여 주십시오.');f.i_loan_day.focus();return false;}

	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=loan_form';
	f.submit();
}
$(function(){
	$('#loan_debt_add').click(function(){
		Loan_debt_Ok(document.loan_form_debt);
	});
});
/*부채내역추가&삭제*/
function add_row() {
  mytable = document.getElementById('mytable');
  row = mytable.insertRow(mytable.rows.length);
  cell1 = row.insertCell(0);
  cell2 = row.insertCell(1);
  cell3 = row.insertCell(2);
  cell4 = row.insertCell(3);
  cell5 = row.insertCell(4);
  cell1.innerHTML = "<select name=\"i_debt_company[]\"><option>선택</option><option value=\"은행/보험\" <?php echo $tmp_option[0]=='은행/보험'?'selected':'';?>>은행/보험</option><option value=\"카드/신협/새마을금고\" <?php echo $tmp_option[0]=='카드/신협/새마을금고'?'selected':'';?>>카드/신협/새마을금고</option><option value=\"캐피탈/증권사\" <?php echo $tmp_option[0]=='캐피탈/증권사'?'selected':'';?>>캐피탈/증권사</option><option value=\"저축은행\" <?php echo $tmp_option[0]=='저축은행'?'selected':'';?>>저축은행</option><option value=\"현금서비스\" <?php echo $tmp_option[0]=='현금서비스'?'selected':'';?>>현금서비스</option><option value=\"대부업\" <?php echo $tmp_option[0]=='대부업'?'selected':'';?>>대부업</option>";
  cell2.innerHTML = "<input type=\"text\" name=\"i_debt_name[]\" value=\"<?php echo $tmp_option[1]?>\"     class=\"frm_input \"  alt=\"금융기관명\"/>";
  cell3.innerHTML = "<input type=\"text\" name=\"i_debt_pay[]\" value=\"<?php echo number_format($tmp_option[2]);?>\"  onkeyup=\"cnj_comma(this);\" onchange=\"cnj_comma(this);\"   class=\"frm_input \"  alt=\"대출잔액\"/>";
  cell4.innerHTML = "<select name=\"i_debt_kinds[]\" ><option>선택</option><option value=\"신용대출\" <?php echo $tmp_option[3]=='신용대출'?'selected':'';?>>신용대출</option><option value=\"담보대출\" <?php echo $tmp_option[3]=='담보대출'?'selected':'';?>>담보대출</option></select>";
  cell5.innerHTML = "<a href=\"javascript:void(0);\"><img src=\"{MARI_ADMINSKIN_URL}/img/delete4_btn.png\" alt=\"삭제\" onclick=\"delete_row()\" style=\"cursor:pointer;\"/></a>";
}
function delete_row() {
  mytable = document.getElementById('mytable');
  if(mytable.rows.length < 2) return;
  mytable.deleteRow(mytable.rows.length-1);
}



function check_only(chk){
        var obj = document.getElementsByName("check[]");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }
}

/*직업 view*/
function div_OnOff(selectList){

	var obj1 = document.getElementById("stype01");
	var obj2 = document.getElementById("stype02");
	var obj3 = document.getElementById("stype03");
	var obj4 = document.getElementById("stype04");
	var obj5 = document.getElementById("stype05");


	if( selectList == "1") { // 학생 리스트
		obj1.style.display = "block";
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "2"){
		obj1.style.display = "none";
		obj2.style.display = "block";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "3"){
		obj1.style.display = "none";
		obj2.style.display = "none";
		obj3.style.display = "block";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}else if(selectList == "4"){
		obj1.style.display = "none";
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "block";
		obj5.style.display = "none";
	}else if(selectList == "5"){
		obj1.style.display = "none";
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "block";
	} else { //디폴트
		obj1.style.display = "block";
		obj2.style.display = "none";
		obj3.style.display = "none";
		obj4.style.display = "none";
		obj5.style.display = "none";
	}

}
function loanlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "입금처리") {
        if(!confirm("선택한 회차를 정말 입금처리 하시겠습니까? 입금처리 후에는 해당 대출신청 회원에게 입금내용이 전달되므로 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
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

		if (!num.test(cnj_str.value)){

			if(cnj_str.value==""){

			}else{

				alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

		}

		if ((t_num < "0" || "9" < t_num)){

			if(t_num==""){

			}else{
				alert("숫자만 입력하십시오.");
				cnj_str.value="";
				cnj_str.focus();
				return false;
			}

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
</script>

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.js"></script>
<script>


</script>
{# s_footer}<!--하단-->
