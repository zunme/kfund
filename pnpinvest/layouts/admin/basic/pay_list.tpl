<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN index
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">투자관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">결제관리</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>  투자 결제완료 : <?php echo number_format($total_count) ?>건
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="pay_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<p class="sum1"><strong>결제 누적금액</strong> : <span><?php echo number_format($order_pay) ?></span> 원</p>

		<!-- <div class="btn_add01 btn_add">
			<a href="#"><img src="img/more_btn.png" alt="추가"></a>
		</div> -->
	<form name="paylist" id="paylist" action="{MARI_HOME_URL}/?update=pay_list" onsubmit="return paylist_submit(this);" method="post">
	<input type=hidden name="ci_id" value='<?=$ci_id?>'>
	<input type=hidden name=loan_id value='<?=$loan_id?>'>
	<input type=hidden name=page value='<?=$page?>'>
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>결제목록</caption>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
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
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th>제목</th>
						<th>이름</th>
						<th>대출금액</th>
						<th>투자회원</th>
						<th>투자금액</th>
						<th>낙찰여부</th>
						<th>모집종료일</th>
						<th>정산내역</th>
						<th>결제여부</th>
					</tr>
				</thead>
				<tbody>

    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	/*정산상태*/
	$sql = "select  o_count, o_salestatus from  mari_order where loan_id='$row[loan_id]' and sale_id='$row[m_id]'  order by o_count asc";
	$count = sql_query($sql, false);
	/*투자정보*/
	$sql = "select i_invest_eday from  mari_invest_progress where loan_id='$row[loan_id]'";
	$ivsale = sql_fetch($sql, false);
	$sql = "select  * from  mari_loan where i_id='$row[loan_id]'";
	$loview = sql_fetch($sql, false);
    ?>
					<tr>
						<td>
						<input type="hidden" name="i_id[<?php echo $i ?>]" value="<?php echo $row['i_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo $row['i_id']; ?></td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo $loview['i_subject']; ?>(<?php echo cate_name($row['i_goods'],1);?>)</td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo $row['user_name']; ?></td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo number_format($row['i_loan_pay']) ?> 원</td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo $row['m_name']; ?></td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo number_format($row['i_pay']) ?> 원</td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php if($row['i_bid_char']=="Y"){?>낙찰완료<?php }else{?>낙찰대기<?php }?></td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php echo substr($ivsale['i_invest_eday'],0,10); ?></td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>">

							<table class="type2" style="">
								<colgroup>
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>상태</th>
										<th>회차</th>
									</tr>
								</thead>
								<tbody>
								<?php for ($i=0; $count_list=sql_fetch_array($count); $i++) {?>
									<tr>
										<td><?php if($count_list[o_salestatus]=="연체중"){?><span style="color:#FF0000;"><?php echo $count_list[o_salestatus];?></span><?php }else{?><?php echo $count_list[o_salestatus];?><?php }?></td>
										<td><?php echo $count_list[o_count];?>회차</td>
									</tr>
								<?php
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"3\">내역이 없습니다.</td></tr>";
								?>
								</tbody>
							</table>

						</td>
						<td onclick="sel('<?php echo $row[i_id]?>','<?php echo $row[loan_id]?>')"  style="cursor:pointer;<?=$row[i_id]==$ci_id?'background-color:#24468A;color:white;':'';?>"><?php if($row['i_pay_ment']=="Y"){?>결제완료<?php }else{?>결제대기<?php }?></td>
					</tr>
    <?php
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">결제 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>
		<!--
		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택취소" class="cancle_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
		</div>
		-->
		<div class="paging">
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->
	</form>
<?php if(!$loan_id){?>
<?php }else{?>
		<div class="detail_view mt50">
	<form name="pay_list" method="post" enctype="multipart/form-data">
	<input type="hidden" name="i_id" value='<?=$ci_id?>'>
	<input type=hidden name="loan_id" value='<?=$loan_id?>'>
	<input type=hidden name="i_regdatetime" value='<?php echo $iv['i_regdatetime']?>'>
			<div class="tbl_frm01 tbl_wrap">
				<table>
					<caption>투자회원정보</caption>
					<colgroup>
						<col width="150px" />
						<col width="" />
						<col width="150px" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>투자회원아이디</th>
							<td>
								<span name="i_member"><?php echo $iv['m_id']?></span>
								<a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $mem['m_no']?>&type=m">
								<img src="{MARI_ADMINSKIN_URL}/img/member_info_btn.png" alt="회원정보" /></a>
							</td>
							<th>투자회원이름</th>
							<td>
								<span name="i_member"><?php echo $iv['m_name']?></span>
							</td>
						</tr>
						<tr>
							<th>투자금액</th>
							<td>
								<input type="text" name="i_pay" value="<?php echo number_format($iv['i_pay'])?>" id="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " size=""  /> <label>원</label> 
							</td>
							<th>대출만기</th>
							<td>
								<?php echo $ln_kigan?>개월
							</td>
						</tr>
						<tr>
							<th>대출상품</th>
							<td>
								<span name="i_goods"><?php echo cate_name($iv['i_goods'],1);?>[<?php echo $iv['user_name']?>]</span>
								<a href="{MARI_HOME_URL}/?cms=loan_form&type=m&i_id=<?php echo $iv['loan_id']?>"><img src="{MARI_ADMINSKIN_URL}/img/view3_btn.png" alt="상세보기" /></a>
							</td>
							<th>낙찰여부</th>
							<td>
								<select name="i_bid_char">
									<option>선택</option>
									<option value="Y" <?php echo $iv['i_bid_char']=='Y'?'selected':'';?>>낙찰완료</option>
									<option value="N" <?php echo $iv['i_bid_char']=='N'?'selected':'';?>>낙찰대기</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>대출금액</th>
							<td><input type="text" name="i_loan_pay" value="<?php echo number_format($iv['i_loan_pay'])?>" id=""  class="frm_input " size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /><label>원</label></td>
							<th>결제여부(가상계좌)</th>
							<td>
								<select name="i_pay_ment">
									<option>선택</option>
									<option value="Y" <?php echo $iv['i_pay_ment']=='Y'?'selected':'';?>>결제완료</option>
									<option value="N" <?php echo $iv['i_pay_ment']=='N'?'selected':'';?>>결제대기</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>현재 연체이자</th>
							<td colspan="3">
							<p>* 투자/결제 설정에서 설정된 연체이자가 반영됩니다.</p>
							<input type="text" name="i_over_pay" value="<?php echo $inv['i_overint']?>" id=""  class="frm_input " size=""  readonly />%
							</td>
						</tr>
						<tr>
							<th>연이율</th>
							<td>연 <input type="text" name="i_profit_rate" value="<?php echo $iv['i_profit_rate']?>" id=""  class="frm_input " size="10" /> %</td>
							<th>수익금액</th>
							<td><input type="text" name="i_profit_pay" value="<?php echo number_format($sale_totalmoney);?>" id=""  class="frm_input " size="" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" /> <label>원</label></td>
						</tr>
						<!--
						<tr>
							<th>연체금액</th>
							<td><input type="text" name="i_over_money" value="<?php echo $iv['i_over_money']?>" id=""  class="frm_input " size="" /> <label>원</label></td>
							<th>총 정산금액</th>
							<td><input type="text" name="i_total_pay" value="<?php echo $iv['i_total_pay']?>" id=""  class="frm_input " size="" /> <label>원</label></td>
						</tr>
						-->
						<tr>
							<th>메모</th>
							<td colspan="3">
								<textarea name="i_memo" id=""><?php echo $iv['i_memo']?></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
	</form>
			<div class="btn_confirm01 btn_confirm">
				<input type="submit" value="" class="save_btn" title="저장" id="pay_list_add" />
				<a href="{MARI_HOME_URL}/?update=pay_list&type=d&i_id=<?php echo $iv[i_id];?>&i_pay=<?php echo $iv[i_pay];?>&loan_id=<?php echo $loan_id;?>">
					<img src="{MARI_ADMINSKIN_URL}/img/cancel_btn.png" alt="결제취소">
				</a>
			</div>

<?php if($loan[i_repay]=="원리금균등상환"){?>
 		<h2 class="bo_title mt40"><span>정산내역[<?php echo $loan[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=pay_list" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $loan_id;?>">
	<input type="hidden" name="sale_id" value="<?php echo $iv['m_id']?>">
	<input type="hidden" name="sale_name" value="<?php echo $iv['m_name']?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $ln_kigan?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $iv['i_pay']?>"><!--원금-->
	<input type="hidden" name="o_ipay" value="<?php echo $iv['i_pay']?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $iv['i_profit_rate']?>"><!--연이율-->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>정산내역</caption>
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
										<th>회차</th>
										<th>월수익금</th>
										<th>투자원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>투자자상태</th>
										<th>채무자상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($sale_totalmoney) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								-->
								<?php
								$sumPrice = $sale_totalmoney; 
								$ln_kigan = $ln_kigan - $stop;

								$일년이자 = $iv[i_pay]*($ln_iyul/100);
								$첫달이자 = substr(floor($일년이자/12),0,-1)."0";

								$rate = (($ln_iyul/100)/12); 
								$상환금 = floor($iv[i_pay]*$rate*pow((1+$rate),$ln_kigan)/(pow((1+$rate),$ln_kigan)-1)); 
								   for($i =0 ; $i <$ln_kigan; ++$i){
									if(!$order[o_investamount]){
										$sumPrice-=$sale_money;
									}else{
										$sumPrice-=$order[o_investamount];
									}

									$납입원금계 += ($상환금-$첫달이자);
									$잔금 = $iv[i_pay]-$납입원금계;
									$납입원금 = $상환금-$첫달이자;
									$sumPrice+=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자);
									$num=$i+1;
								    $sql = "select  * from  mari_order where loan_id='$loan_id' and o_count='$num' and sale_id='$iv[m_id]' order by o_collectiondate desc limit 1";
								    $order = sql_fetch($sql, false);
								    $o_saleodinterest=floor($order[o_saleodinterest]);
								?>
									<tr>
										<td><?php echo $i;?>회차</td>
										<td><?=$잔금>0?number_format($상환금):number_format($납입원금+$잔금+$첫달이자)?> 원</td>
										<td><?=$잔금>0?number_format($납입원금):number_format($납입원금+$잔금)?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><?=$잔금>0?number_format($잔금):"0"?> 원</td>

										<td>
										<?php if(!$order[o_odinterestcount]==""){?><?php echo $order[o_odinterestcount]; ?>일<?php }?>
										</td>
										<td>
										<?php echo number_format($o_saleodinterest); ?> 원
										</td>
										<td>
							<select name="o_salestatus[<?php echo $num ?>]"  >
								<option value="">정산대기</option>
								<option value="정산완료" <?php echo $order['o_salestatus']=='정산완료'?'selected':'';?>>정산완료</option>
								<option value="정산대기" <?php echo $order['o_salestatus']=='정산대기'?'selected':'';?>>정산대기</option>
								<option value="연체" <?php echo $order['o_salestatus']=='연체'?'selected':'';?>>연체중</option>
							
							</select>
										</td>
										<td>
							<?php echo $order[o_status]; ?>
										</td>
									</tr>
								<?php
								$이자합산 += $첫달이자;
								$납입원금합산+=$잔금>0?$납입원금:$납입원금+$잔금;
								$월불입금합산=$납입원금합산+$이자합산;
								$일년이자 = $잔금*($ln_iyul/100);
								$첫달이자 = substr(floor($일년이자/12),0,-1)."0";
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($납입원금합산) ?> 원</td>
										<td><?php echo number_format($이자합산) ?> 원</td>
										<td></td>
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
<?php }else if($loan[i_repay]=="만기일시상환"){?>
 		<h2 class="bo_title mt40"><span>정산내역[<?php echo $loan[i_repay]?>]</span></h2>
	<form name="loanlist" id="loanlist" action="{MARI_HOME_URL}/?update=pay_list" onsubmit="return loanlist_submit(this);" method="post">
	<input type="hidden" name="loan_id" value="<?php echo $loan_id;?>">
	<input type="hidden" name="sale_id" value="<?php echo $iv['m_id']?>">
	<input type="hidden" name="sale_name" value="<?php echo $iv['m_name']?>">
	<input type="hidden" name="o_subject" value="<?php echo $loa[i_subject];?>"><!--제목-->
	<input type="hidden" name="o_maturity" value="<?php echo $ln_kigan?>"><!--대출기간[만기]-->
	<input type="hidden" name="o_payment" value="<?php echo $loa[i_payment];?>"><!--채권-->
	<input type="hidden" name="o_ln_money" value="<?php echo $iv['i_pay']?>"><!--원금-->
	<input type="hidden" name="o_ipay" value="<?php echo $iv['i_pay']?>"><!--원금-->
	<input type="hidden" name="o_ln_iyul" value="<?php echo $iv['i_profit_rate']?>"><!--연이율-->
		<div class="tbl_frm01 tbl_wrap">
			<table>
				<caption>정산내역</caption>
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
										<th>회차</th>
										<th>월수익금</th>
										<th>투자원금</th>
										<th>이자</th>
										<th>잔액</th>
										<th>연체일수</th>
										<th>연체이자금액</th>
										<th>투자자상태</th>
										<th>채무자상태</th>
									</tr>
								</thead>
								<tbody>
								<!--
									<tr>
										<td>0회차</td>
										<td></td>
										<td><?php echo number_format($sale_totalmoney) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								-->
								<?php
								$sumPrice = $sale_totalmoney;
								$일년이자 = $order_pay_add*($ln_iyul/100);
								$첫달이자 = substr(round($일년이자/12),0,-1)."0";
								$전체이자=$첫달이자*$ln_kigan;
								for($i=1; $i<=$ln_kigan; $i++){
									if($order[o_investamount]){
										$sumPrice-=$order[o_investamount];
									}
									$num=$i;
								    $sql = "select  * from  mari_order where loan_id='$loan_id' and o_count='$num' and sale_id='$iv[m_id]' order by o_collectiondate desc limit 1";
								    $order = sql_fetch($sql, false);
								    $o_saleodinterest=floor($order[o_saleodinterest]);
								?>
									<tr>
										<td><?php echo $i;?>회차</td>
										<td><?=$i==$ln_kigan?number_format($order_pay_add+$첫달이자):number_format($첫달이자)?> 원</td>
										<td><?=$i==$ln_kigan?number_format($iv[i_pay]):"0"?> 원</td>
										<td><?=number_format($첫달이자)?> 원</td>
										<td><?=$i==$ln_kigan?"0":number_format($order_pay_add)?> 원</td>

										<td>
										<?php if(!$order[o_odinterestcount]==""){?><?php echo $order[o_odinterestcount]; ?>일<?php }?>
										</td>
										<td>
										<?php echo number_format($o_saleodinterest); ?> 원
										</td>
										<td>
							<select name="o_salestatus[<?php echo $num ?>]"  >
								<option >정산여부</option>
								<option value="정산완료" <?php echo $order['o_salestatus']=='정산완료'?'selected':'';?>>정산완료</option>
								<option value="정산대기" <?php echo $order['o_salestatus']=='정산대기'?'selected':'';?>>정산대기</option>
								<option value="연체" <?php echo $order['o_salestatus']=='연체'?'selected':'';?>>연체중</option>
							
							</select>
										</td>
										<td>
							<?php echo $order[o_status]; ?>
										</td>
									</tr>
								<?php
									$이자합산 += $첫달이자;
									$만기이자=$i==$ln_kigan?$sale_money+$첫달이자:$첫달이자+$전체이자;
									$월불입금합산=$만기이자+$전체이자;
								   }
								   if ($i == 0)
								      echo "<tr><td colspan=\"5\">회차정보가 없습니다.</td></tr>";
								?>
									<tr>
										<td>계</td>
										<td><?php echo number_format($월불입금합산) ?> 원</td>
										<td><?php echo number_format($order_pay_add) ?> 원</td>
										<td><?php echo number_format($이자합산) ?> 원</td>
										<td></td>
										<td></td>
										<td></td>
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
				1. 정산금액은 사이트 수수료설정에 따라 수수료를 제외한 나머지금액이 정산됩니다. <br />
				2. 해당회차의 채무자상태가 '입금완료'인 경우에는 입금처리가 완료된것으로 투자자상태를'정산완료'로 변경되며 정산금이 지급됩니다. <br />
				4. 채무자상태가 '연체'인 경우 다음정산시 월수익금+연체금액이 합산되어 정산됩니다.<br />

			</p>
		</div>
		<div class="btn_confirm01 btn_confirm">
			<a href="{MARI_HOME_URL}/?cms=loan_list"><img src="{MARI_ADMINSKIN_URL}/img/list_btn.png" alt="목록"></a>
		</div>
	</form>
		</div><!-- /detail_view -->
<?php }?>
    </div><!-- /contaner -->
</div><!-- /wrapper -->


<script>
/*리스트선택*/
function sel(no,addr){
	document.paylist.ci_id.value=no;
	document.paylist.loan_id.value=addr;
	document.paylist.action='{MARI_HOME_URL}/?cms=pay_list';
	document.paylist.submit();
}

/*선택취소*/
function paylist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택취소") {
        if(!confirm("선택한 투자의 결제를 정말 취소 하시겠습니까? 삭제 후에는 해당 결제내용의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}



function loanlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "입금처리") {
        if(!confirm("선택한 회차를 정말 입금처리 하시겠습니까? 입금처리 후에는 해당 투자신청 회원에게 e-머니 정산및 입금내용이 전달되므로 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

/*필수체크*/
$(function() {
	$('#pay_list_add').click(function(){
		Pay_list_add(document.pay_list);
	});
});


function Pay_list_add(f)
{
	if(!f.i_loan_pay.value){alert('\n제목을 입력하여 주십시오.');f.i_loan_pay.focus();return false;} 		
	var ipay_pattern = /[^(0-9)]/;//숫자
	if(ipay_pattern.test(f.i_loan_pay.value)){alert('\n대출금액은 숫자만 입력하실수 있습니다');f.i_loan_pay.value='';f.i_loan_pay.focus();return false;}	 
	if(f.i_loan_pay.value.length < 5){alert('\n정확한 금액을 단위로 입력하여주세요.');return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?update=pay_list&type=w';
	f.submit();
 
}

window.onload = function(){

	var strCook = document.cookie;


	if(strCook.indexOf("!~")!=0) {

		var intS = strCook.indexOf("!~");

		var intE = strCook.indexOf("~!");

		var strPos = strCook.substring(intS+2,intE);

		document.getElementById("wrapper").scrollTop = strPos;

		}
}
function SetDivPosition(){

	var intY = document.getElementById("wrapper").scrollTop;

	document.title = intY;

	document.cookie = "yPos=!~" + intY + "~!";

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

</script>
{# s_footer}<!--하단-->