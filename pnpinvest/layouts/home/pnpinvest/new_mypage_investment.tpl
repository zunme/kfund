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
?>
<style>
.btn_filter{
  display:none;
}
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
							<a href="#" class="btn_mytab active">전체 정산 내역</a>
							<a href="#" class="btn_mytab">투자 상환 스케줄</a>
						</p>
					</div>
					<div class="my_content">
						<!-- 투자 관리 start -->





						<div class="my_condition">
							<h4>전체 정산 내역 <span class="pc">전체 상세내역을 확인할 수 있습니다.</span></h4>
							<table class="table_green">
								<caption>전체 정산 내역</caption>
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
                  $perpage = 5;

                  $sql = "select  if( count(1) is null, 1 , ceil(count(1)/".$perpage.") ) as pages from view_jungsan where view_jungsan.sale_id='".$user['m_id']."'";
                  $tmp = sql_fetch($sql, false);

                    $total_orders_page = ( $tmp['pages'] < 1 ) ? 1 : $tmp['pages'];

                    if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
                    $from_record = ($page - 1) * $perpage; // 시작 열을 구함

                  	$sql = "
                  	select a.*,b.i_subject, concat(b.i_year_plus,'%') as iyul, concat(b.i_loan_day,'개월') as months from view_jungsan a
                  			join mari_loan b on a.loan_id = b.i_id
                  			where sale_id ='$user[m_id]' order by o_collectiondate desc limit $from_record, $perpage
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
                     <a type="button" class="btn more" href="/pnpinvest/?mode=mypage_invest_info">이전</a>
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
<style>
div.p_num1{
      margin: 40px auto 50px;
      width: 100%;
      max-width: 300px;
      text-align: center;
}
div.p_num1 ul {
    display: inline-block;
}
div.p_num1 ul li {
    display: inline;
}
div.p_num1 ul li a {
    color: black;
    float: left;
    width:25px; height:25px;
    text-align: center;
    text-decoration: none;
    border: 1px solid #333;
    margin: 5px 3px;
}
div.p_num1 ul li a.p_on1 {
  background-color: #333;
  color:white;
}
</style>
<?php echo get_paging($config['c_write_pages'], $page, $total_orders_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>


						</div>

						<!-- // 투자 관리 end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
