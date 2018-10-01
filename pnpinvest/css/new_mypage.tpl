<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
if( !isset($user['m_id']) ) {
  ?>
  <script>
    location.href="/pnpinvest/?mode=login";
  </script>
  <?php
  exit;
}
include (getcwd().'/module/basic.php');
$sameOwnerCheck = sameOwnerCheck ($user['m_id'], $loan_id);
$getMemberlimit = getMemberlimit($user['m_id']);

$sql ="
select ifnull(sum(a.i_pay),0) as total, ifnull(count(1), 0) as cnt, ifnull( sum(a.i_pay * b.i_year_plus) / sum(a.i_pay), 0) as yearplus
,sum( case when (i_look='F') then 1 else 0 end ) as donecnt
,sum( case when (i_look !='F') then 1 else 0 end ) as continuecnt
from mari_invest a
join mari_loan b on a.loan_id = b.i_id
where a.m_id = '".$user['m_id']."'";

$invest_total = sql_fetch($sql, false);

if( !isset($invest_total['total'])) $invest_total = array('total'=>0,'cnt'=>0,'yearplus'=>0);
$sql = "select sum(wongum) as wongum, sum(inv) as inv from view_jungsan a where a.sale_id = '$user[m_id]'";
$jungsanTotal = sql_fetch($sql);

$sql    = "select ifnull(sum(i_loan_pay),0) as loan_total,  ifnull(count(1),0) as cnt, (sum(i_loan_pay*i_year_plus)/sum(i_loan_pay)) as yearplus
,ifnull(sum(
  case
  	when (i_look='F') then i_loan_pay
  	else 0
  end
  ),0) as repayed
from mari_loan where m_id = '$user[m_id]'";
$loan_total = sql_fetch($sql, false);



$sql                 = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
$seyck               = sql_fetch($sql, false);
$sql        = "select sum(i_pay) from mari_invest where m_id='$user[m_id]'";
$top        = sql_query($sql, false);
$t_pay      = mysql_result($top, 0, 0);
$sql        = "select sum(o_mh_money) from mari_order where user_id = '$user[m_id]'";
$e_top      = sql_query($sql, false);
$e_pay      = mysql_result($e_top, 0, 0);



?>

{# new_header}
<script>
var m_signpurpose = "<?php echo $user['m_signpurpose']?>";
function createvirtual() {
  //가상계좌생성
  var  url = '';
  if(m_signpurpose=='L') {
    url='/pnpinvest/?up=virtualaccountissue_loan';
  }else {
    url='/pnpinvest/?up=virtualaccountissue';
  }
  $.post(url,$("form[name=virtualacnt]").serialize(),  function(data) { $("#ajaxdiv").html(data) });
}

</script>


<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub mypage">
	<!-- Sub title -->
	<h2 class="subtitle t4"><span class="motion" data-animation="flash">마이페이지</span></h2>
	<!-- 펀딩 공지사항 -->
	<div class="join">
		<div class="container clearfix">
			<!-- 컨텐츠 본문 -->
			<aside class="snb">
				<h3>MY PAGE</h3>
				<ul>
					{# new_side}
				</ul>
			</aside>
			<div class="my_content">
				<div class="my_info_01 clearfix">
					<h3 class="blind">개인정보</h3>
					<div class="my_left">
						<a class="btn t5"><?php echo $getMemberlimit['invest_flag']?></a>
						<div class="id"><?php echo $user['m_id'];?>
							<div class="exp">
								투자한도
								<button type="button" class="exp_btn"><img src="img/icon_exp.png" alt="설명보기"></button>
								<p class="exp_con">회원님은 <span><?php echo $getMemberlimit['invest_flag']?></span>이므로,<br>
								<span>부동산 상품:</span>동일 상품(차입자) <?php echo change_pay($getMemberlimit['per_limit'])?>원 이하 연간 <?php echo change_pay($getMemberlimit['insetpay2'])?>원 이하<br>
								<span>동산 상품:</span>동일 상품(차입자) <?php echo change_pay($getMemberlimit['per_limit'])?>원 이하 연간<?php echo change_pay( $getMemberlimit['insetpay'])?>원 이하</p>
							</div>
						</div>
					</div>
					<div class="my_right clearfix">
						<p class="name"><span><?php echo $user['m_name']?></span>님</p>
						<ul class="txt_01">
							<li>투자중인 금액<span><?php echo change_pay($invest_total['total'])?>원</span></li>
							<li>투자가능 금액<span><?php echo change_pay($getMemberlimit['insetpay']-$invest_total['total'])?>원</span></li>
						</ul>
					</div>
				</div>
				<div class="my_info_02 clearfix">
					<div class="title clearfix">
						<h3 class="fl">계좌정보</h3>
						<p class="fr">예치금<span class="sum"><?php echo number_format($user[m_emoney]) ?>원</span></p>
					</div>
					<div class="my_left">
						<ul class="my_bank">
							<li class="account">
								<p class="txt"><span>가상계좌</span>
                <?php if(!isset($seyck['s_accntNo']) || $seyck['s_accntNo']==''){?>
                  아직 가상계좌를 발급받지 않으셨습니다.
                <?php } ?>
                </p>
                <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) {?>
								<a href="/pnpinvest/?mode=mypage_certification" class="btn t5">가상계좌 발급</a>
                <form name="virtualacnt">
                  <input type="hidden" name="type" value="w">
                  <input type="hidden" name="m_id" value="<?php echo $user['m_id']?>">
                  <input type="hidden" name="m_name" value="<?php echo $user['m_name']?>">
                  <input type="hidden" name="s_bnkCd" value="SC_023">
                </form>
                <?php } ?>
							</li>
							<li>
								<strong>은행명</strong>
								<span>
                  <?php if (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') {
                    echo "" ;
                  } else if($seyck[s_bnkCd]=="KEB_005"){?>
                    외환은행
                  <?php }else if($seyck[s_bnkCd]=="KIUP_003"){?>
                    기업은행
                  <?php }else if($seyck[s_bnkCd]=="NONGHYUP_011"){?>
                    농협중앙회
                  <?php }else if($seyck[s_bnkCd]=="SC_023"){?>
                    SC제일은행
                  <?php }else if($seyck[s_bnkCd]=="SHINHAN_088"){?>
                    신한은행
                  <?php }?>
                </span>
							</li>
							<li>
								<strong>예금주</strong>
								<span>
                  <?php if (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') { echo "";
                  } else echo $seyck[m_name] ;
                ?>(가상계좌)</span>
							</li>
							<li>
								<strong>계좌번호</strong>
								<span>
                  <?php if (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') {
                    echo "";
                  }
                  else echo $seyck['s_accntNo']; ?>
                </span>
							</li>
						</ul>
					</div>
					<div class="my_right">
						<ul class="my_bank">
							<li class="account">
								<p class="txt"><span>출금계좌</span>
                  <?php if($user['m_my_bankacc']==''){?>
                  아직 출금계좌를 지정하기 않으셨습니다.
                <?php } ?>
                </p>
                <?php if($user['m_my_bankacc']==''){?>
								          <a href="/pnpinvest/?mode=mypage_certification" class="btn t5">출금계좌 발급</a>
                <?php } ?>
							</li>
							<li>
								<strong>은행명</strong>
								<span><?php echo $user[m_my_bankcode]!='' ? bank_name($user[m_my_bankcode]):''?></span>
							</li>
							<li>
								<strong>예금주</strong>
								<span><?php echo $user['m_my_bankname'];?></span>
							</li>
							<li>
								<strong>계좌번호</strong>
								<span><?php echo $user['m_my_bankacc']?></span>
							</li>
						</ul>
					</div>
				</div>
				<div class="my_info_03">
					<div class="title">
						<h3>투자현황</h3>
					</div>
					<ul class="list clearfix">
						<li class="first"><span class="tt">누적투자</span><span class="txt">진행현황</span></li>
						<li><span class="tt">누적투자 건수</span><span class="txt"><?php echo (isset($invest_total['cnt'])) ? $invest_total['cnt']:"0"?>건</span></li>
						<li><span class="tt">누적평균 수익률(예상)</span><span class="txt"><?php echo number_format($invest_total['yearplus'],2);?>%</span></li>
						<li><span class="tt">누적투자 금액</span><span class="txt"><?php echo number_format($t_pay2); ?>원</span></li>
						<li><span class="tt">누적투자 수익금(예상)</span><span class="txt"><?php echo number_format($jungsanTotal['inv']) ?>원</span></li>
					</ul>
				</div>
				<div class="my_info_04 clearfix" style="display:none;">
					<div class="title">
						<h3>투자 포트폴리오</h3>
					</div>
					<div class="chart_wrap">
						<span class="tt">나의 선호상품</span>
						<div class="chart" style="border:1px solid #ccc;">차트 부분</div><!-- 영역을 보여드리기 위한 인라인 스타일이기 때문에 추후 style 속성은 지우시면 됩니다. -->
						<ul class="list">
							<li class="t1">높은 수익률</li>
							<li class="t2">높은 수익률</li>
							<li class="t3">높은 수익률</li>
							<li class="t4">높은 수익률</li>
						</ul>
						<ul class="list2">
							<li><span class="tt">평균 투자 기간</span><span class="txt">약 3.5개월</span></li>
							<li><span class="tt">평균 수익률</span><span class="txt">약 17.5%</span></li>
						</ul>
					</div>
				</div>
				<div class="my_summary">
					<div class="title">
						<h3>투자 요약</h3>
					</div>
					<div class="con_wrap clearfix">
						<div class="con my_left clearfix">
							<p class="fl">누적 투자금<span><?php echo number_format($t_pay2); ?>원</span></p>
							<ul class="fr">
								<li>누적투자 회수금<span><?php echo number_format($e_pay) ?>원</span></li>
								<li>누적투자 회수원금<span><?php echo number_format( $jungsanTotal['wongum'] ) ?>원</span></li>
								<li>누적수익금<span><?php echo number_format($jungsanTotal['inv']) ?>원</span></li>
								<li>잔여상환금<span><?php echo number_format($t_pay2 - $jungsanTotal['wongum'] ) ?>원</span></li>
							</ul>
						</div>
						<div class="con my_right clearfix">
							<p class="fl">평균수익률(연)<span><?php echo number_format($invest_total['yearplus'],2);?>%</span></p>
							<ul class="fr">
								<li>상환중<span><?php echo $invest_total['continuecnt']?>건</span></li>
								<li>상환완료<span><?php echo $invest_total['donecnt']?>건</span></li>
								<li>연체<span>0건</span></li>
								<li>채권발생<span><?php echo $invest_total['cnt']?>건</span></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="my_summary last" <?php echo ($loan_total['cnt']>0) ? '':"style='display:none'"?> >
					<div class="title">
						<h3>대출 요약</h3>
					</div>
					<div class="con_wrap clearfix">
						<div class="con my_left clearfix">
							<p class="fl">누적 대출금<span><?php echo change_pay($loan_total['loan_total'])?>원</span></p>
							<ul class="fr list3ea">
								<li>누적대출 상환금<span><?php echo number_format($loan_total['repayed'])?>원</span></li>
								<li>누적이자금<span>0원</span></li>
								<li>잔여 상환 원금<span>0원</span></li>
							</ul>
						</div>
						<div class="con my_right clearfix">
							<p class="fl">평균수익률(연)<span><?php echo number_format($loan_total['yearplus'],2)?>%</span></p>
							<ul class="fr">
								<li>상환중<span>0원</span></li>
								<li>상환완료<span>0원</span></li>
								<li>연체<span>0원</span></li>
								<li>채권발생<span><?php echo $loan_total['cnt']?>건</span></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="my_info_05">
					<div class="title">
						<h3>투자자 구분에 따른 자격요건 및 투자한도</h3>
					</div>
					<div class="my_info_05">
						<table class="pc">
							<caption>투자자 구분에 따른 자격요건 및 투자한도</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="width:25%;">
								<col style="width:17%;">
								<col style="width:17%;">
								<col style="width:25%;">
							</colgroup>
							<thead>
								<tr class="bg_title2">
									<th>구분</th>
									<th>자격요건</th>
									<th>동산<br>투자한도</th>
									<th>부동산<br>투자한도</th>
									<th>증빙서류</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th class="bg_title">개인 투자자</th>
									<td rowspan="2">없음</td>
									<td rowspan="2">동일 상품 (차입자)<br>500만원 이하<br>연간 2,000만원 이하</td>
									<td rowspan="2">동일 상품 (차입자)<br>500만원 이하<br>연간 1,000만원 이하</td>
									<td>없음</td>
								</tr>
								<tr>
									<th class="bg_title">외국인 개인<br>투자자</th>
									<td>외국인 등록증 앞/뒷면 사본</td>
								</tr>
								<tr>
									<th rowspan="3" class="bg_title">소득적격 투자자<br>(개인)</th>
									<td class="bg_blue">아래의 요건 중 한가지를<br>만족하는 경우</td>
									<td rowspan="3">동일 상품 (차입자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
									<td rowspan="3">동일 상품 (차입자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
									<td rowspan="3">종합소득 과제표준 확정신고서<br>또는<br>
									종합소득제 신고세 접수증,<br>
									근로소득 원천징수 영수증</td>
								</tr>
								<tr>
									<td class="bg_blue">사업&middot;근로소득 1억원 이상</td>
								</tr>
								<tr>
									<td class="bg_blue">이자&middot;배당소득 2,000만원 이상</td>
								</tr>
								<tr>
									<th rowspan="2" class="bg_title">전문 투자자<br>(개인)</th>
									<td class="bg_pink">아래의 요건을 모두 만족하는 경우</td>
									<td rowspan="2">한도없음</td>
									<td rowspan="2">한도없음</td>
									<td rowspan="2">금융투자협회 전문투자자 확인증</td>
								</tr>
								<tr>
									<td class="bg_pink">금융투자업자 계좌개설 1년 경과<br>
									금융투자상품 잔고 5억원 이상<br>
									소득액 1억원 또는 재산가액 10억원</td>
								</tr>
								<tr>
									<th class="bg_title">법인</th>
									<td>없음</td>
									<td>한도없음</td>
									<td>한도없음</td>
									<td>사업자 등록증, 사업주 신분증,<br>법인통장 사본</td>
								</tr>
							</tbody>
						</table>
						<div class="mobile">
							<table>
								<caption>투자자 구분에 따른 자격요건</caption>
								<colgroup>
									<col style="width:25%">
									<col>
									<col style="width:25%">
								</colgroup>
								<thead>
									<tr>
										<th>구분</th>
										<th>자격요건</th>
										<th>증빙서류</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>개인 투자자</th>
										<td rowspan="2">없음</td>
										<td>없음</td>
									</tr>
									<tr>
										<th>외국인 개인 투자자</th>
										<td>회국인 등록증 앞/뒷면 사본</td>
									</tr>
									<tr>
										<th rowspan="3">소득적격 투자자<br>(개인)</th>
										<td class="bg_blue">아래의 요건 중 한가지를 만족하는 경우</td>
										<td rowspan="3">종합소득 과제표준 확정신고서 또는<br>
										종합소득제 신고세 접수증,<br>
										근로소득 원천징수 영수증</td>
									</tr>
									<tr>
										<td class="bg_blue">사업&middot;근로소득 1억원 이상</td>
									</tr>
									<tr>
										<td class="bg_blue">이자&middot;배당소득 2,000만원 이상</td>
									</tr>
									<tr>
										<th rowspan="2">전문 투자자<br>(개인)</th>
										<td class="bg_pink">아래의 요건을 모두 만족하는 경우</td>
										<td rowspan="2">금융투자협회<br>전문투자자 확인증</td>
									</tr>
									<tr>
										<td class="bg_pink">금융투자업자 계좌개설 1년 경과<br>
										금융투자상품 잔고 5억원 이상<br>
										소득액 1억원 또는 재산가액 10억원</td>
									</tr>
									<tr>
										<th>법인</th>
										<td>없음</td>
										<td>사업자 등록증,<br>사업주 신분증,<br>법인통장 사본</td>
									</tr>
								</tbody>
							</table>
							<table>
								<caption>투자자 구분에 따른 투자한도</caption>
								<colgroup>
									<col style="width:25%;">
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>구분</th>
										<th>비부동산 투자한도</th>
										<th>부동산 투자한도</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>개인 투자자</th>
										<td rowspan="2">동일 상품(차입자)<br>500만원 이하<br>연간 2,000만원 이하</td>
										<td rowspan="2">동일 상품(차입자)<br>500만원 이하<br>연간 1,000만원 이하</td>
									</tr>
									<tr>
										<th>외국인 개인 투자자</th>
									</tr>
									<tr>
										<th>소득적격 투자자<br>(개인)</th>
										<td>동일 상품(차입자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
										<td>동일 상품(차입자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
									</tr>
									<tr>
										<th>전문 투자자<br>(개인)</th>
										<td>한도없음</td>
										<td>한도없음</td>
									</tr>
									<tr>
										<th>법인</th>
										<td>한도없음</td>
										<td>한도없음</td>
									</tr>
								</tbody>
							</table>
						</div>
						<p class="txt">투자한도는 동일 년도의 기준이 아니며, 동시 투자 한도 금액입니다.<br>
						(최대한도 투자 후, 기 투자 금액이 상환된 후에 재투자 가능합니다.)</p>
						<p class="txt">회원가입 후, 증빙서류를 <a href="mailto:help@kfunding.co.kr"><u>help@kfunding.co.kr</u></a>으로 전달해 주시면 투자한도를 변경해 드립니다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="ajaxdiv" style="display:none"></div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
