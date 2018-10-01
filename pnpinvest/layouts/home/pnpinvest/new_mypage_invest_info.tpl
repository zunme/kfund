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

$sql = "select ifnull(sum(wongum),0) as wongum, ifnull(sum(inv),0) as inv, ifnull(sum(o_withholding),0) as o_withholding, ifnull(sum(susuryo),0)  as susuryo from view_jungsan a where a.sale_id = '$user[m_id]'";
$jungsanTotal = sql_fetch($sql);

$sql        = "select sum(i_pay) from mari_invest where m_id = '$user[m_id]'";
$e_top      = sql_query($sql, false);
$e_pay      = mysql_result($e_top, 0, 0);

$sql = "
select ifnull(count(1),0) as cnt, ifnull(sum(i_pay),0) as total
from mari_invest a
join mari_loan b on a.loan_id = b.i_id
where
a.m_id='".$user['m_id']."'
and b.i_look = 'F'
";
$sanghwan_total = sql_fetch($sql, false);

?>
<style>
.btn_filter{
  display:none;
}
.terms_wrap .terms_logo img{display:none}
</style>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub mypage">
	<!-- Sub title -->
	<h2 class="subtitle t4"><span class="motion" data-animation="flash">마이페이지</span></h2>
	<!-- 케이펀딩 공지사항 -->
	<div class="join">
		<div class="container clearfix">
			<!-- 컨텐츠 본문 -->
			<aside class="snb">
				<h3>MY PAGE</h3>
				<ul>
					{# new_side}
				</ul>
			</aside>
      <style>
      .btn_mytab{
        font-size: 14px;
        font-weight: 400;
        }
      </style>
			<div class="my_content">
				<div class="my_certify clearfix">
					<div class="title clearfix">
						<h3 class="fl">투자정보</h3>
						<p class="btn_mytab_wrap">
							<a href="/pnpinvest/?mode=mypage_invest_info" class="btn_mytab active">투자관리</a>
							<a href="/pnpinvest/?mode=mypage_calculate_schedule" class="btn_mytab">투자 상환 스케줄</a>
						</p>
					</div>
					<div class="my_content">
						<!-- 투자 관리 start -->
						<div class="clearfix">
							<div class="my_left2">
								<h4><?php echo $user['m_name'];?> 님의 현재 투자정보입니다</h4>
								<ul class="list_con">
									<li class="non_bd pc700">&nbsp;</li>
									<li class="non_bd clearfix">
										<span class="fl">투자중인 금액</span>
										<span class="fr"><?php echo change_pay($invest_total['total'])?>원</span>
									</li>
									<li class="non_bd clearfix">
										<span class="fl">투자가능 금액</span>
										<span class="fr"><?php echo change_pay($getMemberlimit['insetpay']-$invest_total['total'])?>원</span>
									</li>
									<li class="non_bd pc700">&nbsp;</li>
									<li class="non_bd clearfix">
										<table class="table_green center">
											<caption>투자정보</caption>
											<colgroup>
												<col style="width:30%">
												<col style="width:30%">
												<col>
											</colgroup>
											<thead>
												<tr>
													<th>총 투자금액</th>
													<th>투자건수</th>
													<th>투자진행중인 금액</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><?php echo change_pay($e_pay) ?>원</td>
													<td><?php echo (isset($invest_total['cnt'])) ? $invest_total['cnt']:"0"?>건</td>
													<td><?php echo change_pay($invest_total['total'])?>원</td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							</div>
							<div class="my_right2">
								<h4>투자현황 <span>전체투자건에 대한 현황정보입니다.</span></h4>
								<ul class="list_con">
									<li class="non_bd clearfix">
										<span class="fl">상환완료</span>
										<span class="fr"><?php echo $sanghwan_total['cnt']?>건</span>
									</li>
									<li class="non_bd clearfix">
										<span class="fl">상환금액</span>
										<span class="fr"><?php echo change_pay($sanghwan_total['total'])?>원</span>
									</li>
									<li class="non_bd clearfix">
										<span class="fl">이자수익(세전)</span>
										<span class="fr"><?php echo change_pay($jungsanTotal['inv'])?>원</span>
									</li>
									<li class="non_bd clearfix">
										<span class="fl">이자수익(세후)</span>
										<span class="fr"><?php echo change_pay($jungsanTotal['inv'] - $jungsanTotal['o_withholding'] - $jungsanTotal['susuryo'])?>원</span>
									</li>
									<li class="non_bd clearfix">
										<table class="table_green center">
											<caption>투자정보</caption>
											<colgroup>
												<col style="width:50%">
												<col>
											</colgroup>
											<thead>
												<tr>
													<th>투자가능금액</th>
													<th>평균 수익률</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><?php echo change_pay($getMemberlimit['insetpay']-$invest_total['total'])?> 원</td>
													<td><?php echo number_format($invest_total['yearplus'],2);?> %</td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							</div>
						</div>
						<div class="my_condition">
							<h4>입찰현황 <span class="pc">현재 입찰현황을 확인하실 수 있습니다.</span></h4>
							<table class="table_green">
								<caption>입찰현황</caption>
								<thead>
									<thead>
										<tr>
											<th class="filter">일자<button type="button" class="btn_filter">필터링</button></th>
											<th class="filter">제목<button type="button" class="btn_filter">필터링</button></th>
											<th>진행현황</th>
											<th>이자율</th>
											<th>상환기간</th>
											<th class="filter">입찰액<button type="button" class="btn_filter">필터링</button></th>
											<th>상태</th>
											<th class="pc">권리증서</th>
										</tr>
									</thead>
								</thead>
								<tbody>
                  <?php
                  if(!$laon ){
                    ?>
                    <tr>
                      <td colspan="8">입찰정보가 없습니다.</td>
                    </tr>
                    <?php
                  }else {
                      for ($i=0; $row=sql_fetch_array($laon); $i++) {
                    /*입찰정보*/
                    $sql = "select  * from  mari_loan where i_id='$row[loan_id]'";
                    $losale = sql_fetch($sql, false);
                    $sql = "select i_invest_name, i_invest_per, i_look from  mari_invest_progress where loan_id='$row[loan_id]'";
                    $iv_pr = sql_fetch($sql, false);

                    $sql="select sum(i_pay) from mari_invest where loan_id='$row[loan_id]'";
                    $top=sql_query($sql, false);
                    $order = mysql_result($top, 0, 0);
                    $total=$losale[i_loan_pay];
                    /*투자금액이 0보다클경우에만 연산*/
                    if($order>0){
                      /* 투자금액 / 대출금액 * 100 */
                      $order_pay=floor ($order/$total*100);
                    }else{
                      $order_pay="0";
                    }
                  ?>
                  <form name="inset_form<?php echo $i; ?>"  id="calcform_<?php echo $i; ?>" method="post" enctype="multipart/form-data" target="calculation<?php echo $i; ?>">
                  <input type="hidden" name="i_loan_day" value="<?php echo $losale[i_loan_day]; ?>">
                  <input type="hidden" name="i_year_plus" value="<?php echo $losale[i_year_plus]; ?>">
                  <input type="hidden" name="i_repay" value="<?php echo $losale[i_repay]; ?>">
                  <input type="hidden" name="i_pay" value="<?php echo $row[i_pay]; ?>">
                  <input type="hidden" name="loan_id" value="<?php echo $row[loan_id]; ?>">
                  <input type="hidden" name="stype" value="invest"/>
                  <input type="hidden" name="mtype" value="mypage"/>
                  <tr>
                    <td><?php echo date('Y-m-d', strtotime($row['i_regdatetime'])) ?></td>
                    <td><?php echo $iv_pr[i_invest_name];?></td>
                    <td>
                      <?php
                        if($iv_pr['i_look']=="Y"){
                          echo '진행중';
                        }else if($iv_pr['i_look']=="C"){
                          echo '마감';
                        }else if($iv_pr['i_look']=="N"){
                          echo '대기중';
                        }else if($iv_pr['i_look']=="D"){
                          echo '상환중';
                        }else if($iv_pr['i_look']=="F"){
                          echo '상환완료';
                        }
                      ?>
                    </td>
                    <td><?php echo unit($row['i_profit_rate']) ?>%</td>
                    <td><?php echo $losale[i_loan_day];?>개월</td>
                    <td><?php echo unit($row['i_pay']) ?>만원</td>
                    <td class="m_last">
                      <a href="javascript:void(0);"  onclick2="Calculation<?php echo $i; ?>()" onclick="view_calc(<?php echo $i; ?>)">
                        확인
                      </a>
                    </td>
                    <td class="pc">
                      <a href="{MARI_HOME_URL}/?mode=invest_receipt&loan_id=<?php echo $row[loan_id]?>&i_pay=<?php echo $row[i_pay]?>" onclick="window.open(this.href, '','width=1022, height=1300, resizable=no, scrollbars=yes, status=no'); return false">권리증서</a>
                    </td>
                  </tr>
                </form>
                <script>
                /*매월 투자수익계산*/
                function Calculation<?php echo $i; ?>() {
                  var f=document.inset_form<?php echo $i; ?>;
                  var opt = "status=yes,toolbar=no,scrollbars=yes,width=800,height=750,left=0,top=0";
                  window.open("about:blank", "calculation<?php echo $i?>", opt);
                  f.action="{MARI_HOME_URL}/?mode=calculation";
                  f.submit();
                }
                </script>
                  <?php
                    }
                  }
                  if($i <1 ){
                    ?>
                    <tr>
                      <td colspan="8">입찰정보가 없습니다.</td>
                    </tr>

                    <?php
                  }
                  ?>
								</tbody>
							</table>
              <p class="right">
							       <a type="button" class="btn more" href="/pnpinvest/?mode=mypage_tenderstatus">더보기</a>
               </p>
						</div>

						<div class="my_condition">
							<h4>정산내역 <span class="pc">투자상품별 상세내역을 확인할 수 있습니다.</span></h4>
							<table class="table_green">
								<caption>정산내역</caption>
								<thead>
									<thead>
										<tr>
											<th class="filter">일자<button type="button" class="btn_filter">필터링</button></th>
											<th class="filter">제목<button type="button" class="btn_filter">필터링</button></th>
											<th class="filter">회차<button type="button" class="btn_filter">필터링</button></th>
											<th class="filter">투자원금<button type="button" class="btn_filter">필터링</button></th>
											<th>이자</th>
											<th>수수료</th>
											<th>원청징수</th>
											<th class="pc">세후합계</th>
										</tr>
									</thead>
								</thead>
								<tbody>

                  <?php
                  /* 정산현황 신규. 원리금균등상환 부분은 처음부터 오류 현재 데이터로는 맞출수가 없을수있음*/
                  	$sql = "
                  	select a.*,b.i_subject, concat(b.i_year_plus,'%') as iyul, concat(b.i_loan_day,'개월') as months from view_jungsan a
                  			join mari_loan b on a.loan_id = b.i_id
                  			where sale_id ='$user[m_id]' order by o_collectiondate desc limit 5
                  	";
                  	$query = sql_query($sql);
                  ?>
                  <?php for ($i=0; $orders_list=sql_fetch_array($query); $i++) { ?>
									<tr>
										<td><?php echo $orders_list['date'];?></td>
										<td><?php echo htmlspecialchars($orders_list['i_subject']);?></td>
										<td><?php echo $orders_list['o_count'];?>회</td>
										<td><?php echo number_format($orders_list['o_ln_money_to']);?>원</td>
										<td><?php echo number_format($orders_list['inv']);?>원</td>
										<td><?php echo number_format($orders_list['susuryo']);?>원</td>
										<td class="m_last"><?php echo number_format($orders_list['o_withholding']);?>원</td>
										<td class="pc"><?php echo number_format($orders_list['p_emoney']);?>원</td>
									</tr>
	<?php }
    if ($i == 0) echo '<tr><td colspan="8">정산내역이 없습니다.</td></tr>';
  ?>
								</tbody>
							</table>
              <p class="right">
							       <a type="button" class="btn more" style="margin-bottom:25px;" href="/pnpinvest/?mode=mypage_investment">더보기</a>
              </p>
							<!-- 페이징 -->
              <!--
							<p class="paging">
								<span class="prev"><a href="#" target="_self">이전</a></span>
								<span class="on">1</span>
								<span><a href="#" target="_self">2</a></span>
								<span><a href="#" target="_self">3</a></span>
								<span><a href="#" target="_self">4</a></span>
								<span><a href="#" target="_self">5</a></span>
								<span class="next"><a href="#" target="_self">다음</a></span>
							</p>
              -->
						</div>

						<!-- // 투자 관리 end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
function view_calc(no) {
  //iw_table , iw_popup_cont
  var data =  $("#calcform_"+no).serialize();
  $.post("/pnpinvest/?mode=calculation", data, function (html){
    $("#iw_popup_cont").html (html);
    $('.iw_popup').fadeIn('fast');
    $('.iw_popup .iwp_sum').fadeIn('fast');
  });
}
</script>
{# new_footer}
