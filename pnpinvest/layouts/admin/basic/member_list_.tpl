<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_PLUGIN_PATH.'/pg/seyfert/aes.class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN 메인중앙
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->

<div id="wrapper">
	<div id="left_container">
		{# left_bar}

		<div class="lnb_wrap">
			<div class="title01">회원관리</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->
    
	<div id="container">
		<div class="title02">회원목록</div>
		 <div class="local_ov01 local_ov">
			<a href="#" class="ov_listall">전체목록</a>    총회원수 <?php echo number_format($total_count) ?>명 중,
			<a href="#">차단 <?php echo number_format($intercept_count) ?></a>명,
			<a href="#">탈퇴 <?php echo number_format($leave_count) ?></a>명
		</div>

		<form  class="local_sch01 local_sch"  id="fsearch" name="fsearch"  method="get">
		<input type="hidden" name="cms" value="member_list">
			<label for="" class="sound_only">검색대상</label>
			<select name="sfl">
				<option value="m_name"<?php echo get_selected($_GET['sfl'], "m_name"); ?>>이름</option>
				<option value="m_id"<?php echo get_selected($_GET['sfl'], "m_id"); ?>>회원아이디</option>
			</select>
			<label for="" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
			<input type="text"  name="stx" value="<?php echo $stx ?>" id="" required="" class="required frm_input">
			<input type="submit" class="search_btn" value="">

		</form>

		<div class="local_desc01 local_desc">
			<p>
				회원탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다.
			</p>
		</div>

		<div class="btn_add01 btn_add">
			<a href="{MARI_HOME_URL}/?cms=member_form&type=w"><img src="{MARI_ADMINSKIN_URL}/img/add_member_btn.png" alt="회원추가"></a>
		</div>
	<form name="memberlist" id="memberlist" action="{MARI_HOME_URL}/?update=member_list" onsubmit="return memberlist_submit(this);" method="post">
		<div class="tbl_head01 tbl_wrap">
			<table class="txt_c">
				<caption>회원관리 목록</caption>
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
					<col width="" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkall" value="1" id="chkall" onclick="check_all(this.form)"></th>
						<th>NO</th>
						<th><?php echo subject_sort_link('m_name', $cms) ?>이름</a></th>
						<th><?php echo subject_sort_link('m_id', $cms) ?>아이디</a></th>
						<th>가상계좌</th>
						<th>계좌검증여부</th>
						<th>투자한도</th>
						<th>E 머니 / 출금가능액</th>
						<th>가입일</th>
						<th>최종접속일</th>
						<th>회원등급</th>
						<th>멤버키</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
    <?php
    for ($i=0; $row=sql_fetch_array($result); $i++) {
	
	/*레벨로 회원등급명을 가져옴*/
	$sql = "select  * from  mari_inset";
	$insetck = sql_fetch($sql, false);

	/*투자자구분*/
	if($row['m_level']=="2"){
		if($row['m_signpurpose'] =="N"){
			$invest_flag = '일반 개인투자자';
			$insetpay=$insetck['i_maximum'];
		}else if($row['m_signpurpose'] =="L"){
			$invest_flag = '대출회원';
			$insetpay=$insetck['i_maximum'];
		}else if($row['m_signpurpose'] == "P"){
			$invest_flag = '전문 투자자';
			$insetpay=$insetck['i_maximum_pro'];
		}else if($row['m_signpurpose'] == "I"){
			$invest_flag = '소득적격 개인투자자';
			$insetpay=$insetck['i_maximum_in'];
		}else{
			$invest_flag = '일반 개인투자자';
			$insetpay=$insetck['i_maximum'];
		}
	}else if($row['m_level']>2){
			$invest_flag = '법인투자자';
			$insetpay=$insetck['i_maximum_v'];
	}

	/*가상계좌를 불러옴*/
	$sql = "select * from mari_seyfert where m_id = '$row[m_id]'";
	$seyfert = sql_fetch($sql, false);

	/*레벨로 회원등급명을 가져옴*/
	$sql = "select  * from  mari_level where lv_level='$row[m_level]'";
	$lv = sql_fetch($sql, false);
	if($row['m_id']=="webmaster@admin.com"){
	}else{
	/*회원수*/
	$cnt = $colspan; //$colspan = 출력할 라인 수
	$mem_no = $total_member - ($cnt*($page-1));
	$num = $mem_no - $i;
	/*페이게이트 잔액전용nonce체크시 숫자변경*/
	$nonce_lnq_mem = time().rand(111,99);
	/*페이게이트 주문번호 생성*/
	$g_code_mem = "P".time().rand(111,999);

	$ssdate="2017-05-29 00:00:00";

			/*신규 회원누적투자금액 투자, 투자진행설정 join*/
			$sql="select * from mari_invest 
					where m_id = '$row[m_id]' 
					and  i_regdatetime between '".$ssdate."' and '".$date."' ";
			$accr_pay = sql_query($sql, false);

			if(!empty($accr_pay)) {
			    for ($or=0; $row2=sql_fetch_array($accr_pay); $or++) {

				$sql = "select  * from  mari_invest_progress where loan_id='$row2[loan_id]'";
				$prs = sql_fetch($sql, false);

					if($row2['m_id']==$row['m_id'] && $prs['i_look']=="C" || $prs['i_look']=="D" ){
					$i_pay[$i] +=$row2['i_pay'];
					}
			    }
			}

			$sql = "select sum(i_pay) from mari_invest where m_id='$row[m_id]' ";
			$investamt = sql_query($sql, false);
			$investpay = mysql_result($investamt, 0, 0);
			/*한도*/
			$insetpays=$insetpay-$i_pay[$i];
    ?>
					<tr>
						<td>
						<input type="hidden" name="m_id[<?php echo $i ?>]" value="<?php echo $row['m_id'] ?>">
						<input type="checkbox" name="check[]" value="<?php echo $i ?>">
						</td>
						<td><?php echo $num;?></td>
						<td><?php echo $row['m_name']; ?></td>
						<td><?php echo $row['m_id'] ?></td>
						<td>
							<?php if(!$seyfert['s_bnkCd']){?>
								가상계좌없음
							<?php }else{?>
							<?php echo bank_name($seyfert['s_bnkCd']);?> <?php echo $seyfert['s_accntNo'] ?>
							<?php }?>
						</td>
						<td><?php echo $row['m_verifyaccountuse']=='Y'?'검증완료':'미검증';?></td>
						<td>
							<table class="type2" style="max-width:300px">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th>투자액</th>
										<th>유효투자금</th>
										<th>남은한도</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><?php echo number_format($investpay);?></td>
										<td><?php echo number_format($i_pay[$i]);?></td>
										<td><?php echo number_format($insetpays);?></td>
									</tr>
								</tbody>
							</table>
						</td>
						<td><input type="text" name="m_emoney[<?php echo $i; ?>]"  value="<?php echo $row['m_emoney'];?>" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" class="frm_input " size="15"> / 
						<?php
						/*현재 세이퍼트가상계좌의 잔액표시*/
						/*발급받은 memGuid 조회*/
						$sql = "select  s_memGuid from mari_seyfert where m_id='$row[m_id]' and s_memuse='Y'";
						$bankck = sql_fetch($sql, false);
						$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq_mem."&refId=".$g_code_mem."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";

						$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
						$cipherEncoded_lnq = urlencode($cipher_lnq);
						$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

						/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/

						$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

						$curl_handlebank_lnq = curl_init();

						curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
						/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
						curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
						curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
						curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
						$result_lnq = curl_exec($curl_handlebank_lnq);
						curl_close($curl_handlebank_lnq);

						/*파싱*/
						$decode_lnq = json_decode($result_lnq, true);
						?>
							<?php
							/*foreach 파싱 데이터출력*/
							foreach($decode_lnq as $key=>$value){
								$moneyPair=$value['moneyPair'];/*현재잔액*/

								$amount=$moneyPair['amount'];/*현재잔액*/
								if($amount=="S" || $amount=="E"){
								}else{
							?>
								<?php echo $amount;?>

							<?php
								}
							   }
							?> 원</td>
						<td><?php echo substr($row['m_datetime'],0,10); ?></td>
						<td><?php echo substr($row['m_today_login'],0,10); ?></td>
						<td>
						<?php 
							if($row[m_level]=="2"){
								echo $invest_flag;
							}else{
								echo $lv['lv_name'];
							}
						?>
						</td>
						<td>
						<?php if($seyfert['s_memGuid']){?>
						<?php echo $seyfert['s_memGuid']?>
						<?php }else{?>
						<a href="{MARI_HOME_URL}/?update=member_key&m_id=<?php echo $row[m_id]?>&m_hp=<?php echo $row[m_hp]?>&m_name=<?php echo $row[m_name]?>">멤버키생성</a>
						<?php }?>
						</td>
						<td>
							<a href="{MARI_HOME_URL}/?cms=member_form&m_no=<?php echo $row['m_no']; ?>&type=m">
								<img src="{MARI_ADMINSKIN_URL}/img/modify2_btn.png" alt="수정" />
							</a>
						</td>
					</tr>
    <?php
    }
    }
    if ($i == 0)
        echo "<tr><td colspan=\"".$colspan."\">회원 리스트가 없습니다.</td></tr>";
    ?>
				</tbody>
			</table>
		</div>

		<div class="btn_list01 btn_list">
			<input type="submit" name="add_bt" value="선택수정" class="select_modi_btn" style="font-size:0px;"  onclick="document.pressed=this.value" />
			<input type="submit" name="add_bt" value="선택삭제" class="select_delete_btn" style="font-size:0px;" onclick="document.pressed=this.value" />
		<?php if($user[m_level]>=10){?>
			<a href="javascript:goto_xlsm_time()"><img src="{MARI_ADMINSKIN_URL}/img/xlsmdw_btn.png" alt="엑셀다운"/></a>
		<?php }?>
		</div>

	</form>
		<div class="paging">
<!--패이징--><!--<?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.''.$qstr.'&amp;page='); ?>-->
<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?cms='.$cms.'&sfl='.$sfl.'&stx='.$stx.''.$qstr.'&amp;page='); ?>
		</div><!-- /paging -->


    </div><!-- /contaner -->
</div><!-- /wrapper -->

<script>
function memberlist_submit(f)
{
    if (!is_checked("check[]")) {
        alert(document.pressed+" 하실 리스트를 1개 이상 체크하여 주십시오.");
        return false;
    }

    if(document.pressed == "선택삭제") {
        if(!confirm("선택한 회원을 정말 탈퇴하시겠습니까? 탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다.")) {
            return false;
        }
    }

    return true;
}

/*엑셀다운로드*/

function goto_xlsm_time() 
{ 
document.location.href = '{MARI_PLUGIN_URL}/exceldownload/xls/?dwtype=<?php echo $cms?>'; 
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

 