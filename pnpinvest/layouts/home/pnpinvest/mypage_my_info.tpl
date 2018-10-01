<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{#header_sub}<!--상단-->
<div id="container">
			<div id="sub_content">
					<div class="mypage">
			<div class="mypage_inner">
<!--
					<div class="left_menu mt30">
						<ul>
							<li class="first current"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney" ><span></span><p>거래내역</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
							<li><a href="{MARI_HOME_URL}/?mode=mypage_withdrawal"><span></span><p>출금 신청</p></a></li>
						</ul>
					</div><!--//left_menu e -->

				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							
						</div>

						<div class="dashboard_side_mn">
							<ul>
								<li class="first current lnb_mn1"><a href="{MARI_HOME_URL}/?mode=mypage"><span></span><p>대시보드</p></a></li>
								<li class="lnb_mn5"><a href="{MARI_HOME_URL}/?mode=mypage_emoney"><span></span><p>예치금 관리</p></a></li>
								<li class="lnb_mn7"><a href="{MARI_HOME_URL}/?mode=mypage_confirm_center"><span></span><p>인증센터</p></a></li>
								<li class="lnb_mn4"><a href="{MARI_HOME_URL}/?mode=mypage_loan_info"><span></span><p>대출 정보</p></a></li>
								<li class="lnb_mn2"><a href="{MARI_HOME_URL}/?mode=mypage_invest_info" ><span></span><p>투자 정보</p></a></li>
								
								
								<li class="lnb_mn3"><a href="{MARI_HOME_URL}/?mode=mypage_interest_invest"><span></span><p>관심 투자</p></a></li>
								<li class="lnb_mn6"><a href="{MARI_HOME_URL}/?mode=mypage_alert"><span></span><p>알림 메세지</p></a></li>
							</ul>
						</div>
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>정보수정</span>
								<ul>
									<li><a href="javascript:;" class="info_current">기본 정보</a></li>
									<li>|</li>
									<li><a href="javascript:;">인증센터</a></li>
								</ul>
							</h3>
							<div>
								<p>정보 수정을 위해 현재 비밀번호를 입력하여 주시기를 바랍니다.</p>
								<div class=""><span>비밀번호 입력</span><input type="password" /></div>
								<a href="javascript:;" class="my_info_submit">확인</a>
							</div>
						</div>
					</div>
				</div>
<!--
				<div class="dashboard mt30 ml15">
					<div>
						<div class="my_profile">
							<div>
								<img src="{MARI_HOMESKIN_URL}/img/pic_profile.png" alt=""/>
							</div>
							<p class="txt_c"><?php echo $user['m_name'];?></p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<p class="txt_c">현재잔액 : <span class=""><?php echo number_format($user[m_emoney]) ?></span>원</p>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="mt30"><img src="{MARI_HOMESKIN_URL}/img/img_dash.png" alt="기본정보 수정"></a>
						</div>
						<div class="average">
							<div>
								<div>
									<img src="{MARI_HOMESKIN_URL}/img/img_dash01.png" alt=""/>
									<p class="txt_c" >누적 투자금 <span class="color_bl2"><strong><?php echo number_format(unit($t_pay)); ?></strong>만원</span></p>
								</div>
								<ul>
									<li>누적 투자 회수금 <strong><?php echo number_format($e_pay) ?>원</strong></li>
									<li>누적 투자 회수 원금 <strong><?php echo number_format($Recoveryofprincipal) ?>원</strong></li>
									<li>누적 수익금<strong><?php echo number_format($Cumulativeearnings) ?>원</strong></li>
									<li>잔여 상환금<strong><?php echo number_format($Theremainingprincipal) ?>원</strong></li>
								</ul>
							</div>
							<div>
								<div>
									<img src="{MARI_HOMESKIN_URL}/img/img_dash02.png" alt=""/>
									<p class="txt_c">평균 수익률(연)<span class="color_bl2"> <strong><?php echo number_format($top_plus,2);?></strong>%</span></p>
								</div>
								<ul>
									<li>상환중인 투자<strong><?php echo $Ofrepayment_count;?>건</strong></li>
									<li>상환완료 건수<strong><?php echo $Ofrepaymentout_count;?>건</strong></li>
									<li>연체 건수<strong><?php echo $Overdue_count?>건</strong></li>
									<li>채권 발생 건수<strong><?php echo $bond_count?>건</strong></li>
								</ul>
							</div>
						</div><!--average-->
<!--					</div>
					
					<div class="">
					<form name="f" method="post">
						<div class="account_info mt20">
							<div>
								<img src="{MARI_HOMESKIN_URL}/img/img_dash04.png" alt="나의 계좌정보">
							</div>
							<p class="txt_c">나의 계좌 정보</p>
							<p class="txt_c">
													<select name="s_bnkCd" required style="width:130px; height:25px; ">
														<option>은행선택</option>
														<option value="KEB_005"  <?php echo $seyck['s_bnkCd']=="KEB_005"?'selected':'';?>>외환은행</option>
														<option value="KIUP_003"  <?php echo $seyck['s_bnkCd']=="KIUP_003"?'selected':'';?>>기업은행</option>
														<option value="NONGHYUP_011"  <?php echo $seyck['s_bnkCd']=="NONGHYUP_011"?'selected':'';?>>농협중앙회</option>
														<option value="SC_023"  <?php echo $seyck['s_bnkCd']=="SC_023"?'selected':'';?>>SC제일은행</option>
														<option value="SHINHAN_088"  <?php echo $seyck['s_bnkCd']=="SHINHAN_088"?'selected':'';?>>신한은행</option>
													</select>
							</p>
							<p class="txt_c mt10" style="font-size:14px; font-weight:600; "><?php if($seyck['s_accntNo']){?> <?php echo $seyck['s_accntNo'];?> <?php }else{?>보유하신 계좌가 없습니다.<?php }?></p>
							
							<p class="txt_c mt15 account_1"><a href="javascript:void(0);" onclick="sendit()" >가상계좌 생성하기</a><b class="help">?<span>발급받은 가상계좌 번호로 투자금을 이체하시면 충전된 예치금으로 투자가 가능합니다.</span></b></p>
							<p class="txt_c mt10 account_1"><a href="{MARI_HOME_URL}/?mode=mypage_basic" >출금계좌 수정</a><b class="help">?<span>출금을 위해 본인인증과 은행정보 등록이 필요합니다.</span></b></p>
							<p class="txt_c mt10 account_1">
								<?php 
								/*거래내역이 있고 은행,예금주,계좌등록된 경우에만 검증가능*/
								if($user['m_my_bankname'] && $user['m_my_bankcode'] && $user['m_my_bankacc']){
								?>
								<a href="{MARI_HOME_URL}/?up=verifyaccount" >계좌검증</a>
								<?php }else{?>
								<a href="javascript:alert('출금계좌 정보가 없습니다. 마이페이지>기본정보 수정에서 \n\n본인 명의에 계좌 정보를 등록하신 후 검증 가능합니다.');" >계좌검증</a>
								<?php }?>
							</p>
						</div>
					</form>
						<div class="average mt20">
							<div>
								<div>
									<img src="{MARI_HOMESKIN_URL}/img/img_dash05.png" alt=""/>
									<p class="txt_c">누적 대출금 <span class="color_bl2"><strong><?php echo  number_format(unit($Loanamount)); ?></strong>만원</span></p>
								</div>
								<ul>
									<li>누적 대출 상환금 <strong><?php echo number_format($Loanrepayments) ?>원</strong></li>
									<li>누적 이자금 <strong>0원</strong></li>
									<li>잔여 상환금<strong><?php echo number_format($o_totalamount) ?>원</strong></li>
								</ul>
							</div>
							<div>
								<div>
									<img src="{MARI_HOMESKIN_URL}/img/img_dash06.png" alt=""/>
									<p class="txt_c">평균 이자율(연)<span class="color_bl2"> <strong><?php echo number_format($top_plus,2);?></strong>%</span></p>
								</div>
								<ul>
									<li>상환중인 대출<strong><?php echo $Loanrepayment_count;?>건</strong></li>
									<li>상환 완료된 대출<strong><?php echo $repaycomplete_count;?>건</strong></li>
									<li>연체 건수<strong><?php echo $total_over;?>건</strong></li>
									<li>채권 발생 건수<strong><?php echo $total_loan;?>건</strong></li>
								</ul>
							</div>
						</div><!--average-->
<!--					</div>
				</div><!--dashboard-->
			</div><!--mypage_inner-->
		</div><!--mypage-->
<script type="text/javascript">
function sendit(){
	if(document.f.s_bnkCd[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
								
	document.f.action='{MARI_HOME_URL}/?up=virtualaccountissue';
	document.f.submit();
}
</script>
{#footer}<!--하단-->