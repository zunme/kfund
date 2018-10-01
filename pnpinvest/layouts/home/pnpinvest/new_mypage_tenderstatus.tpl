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
							<a href="/pnpinvest/?mode=mypage_invest_info" class="btn_mytab active">입찰현황</a>
							<a href="/pnpinvest/?mode=mypage_calculate_schedule" class="btn_mytab">투자 상환 스케줄</a>
						</p>
					</div>
					<div class="my_content">
						<!-- 투자 관리 start -->

						<div class="my_condition">
							<h4>전체입찰현황 <span class="pc">전체 입찰현황을 확인하실 수 있습니다.</span></h4>
							<table class="table_green">
								<caption>전체입찰현황</caption>
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

                  									/*입찰정보*/
                                    $perpage = 5;

                  									$sql = " select count(*) as cnt from mari_invest where m_id='$user[m_id]'";
                  									$laon_count = sql_fetch($sql);
                  									$total_laon= $laon_count['cnt'];

                  									$total_laon_page  = ceil($total_laon / $perpage);  // 전체 페이지 계산
                  									if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
                  									$from_record = ($page - 1) * $perpage; // 시작 열을 구함
                  									$sql = " select * from mari_invest where m_id='$user[m_id]' order by i_regdatetime desc limit $from_record, $perpage ";
                  									$laon = sql_query($sql);
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
                  									<form name="inset_form<?php echo $i; ?>"  id="calcform_<?php echo $i; ?>"  method="post" enctype="multipart/form-data"target="calculation<?php echo $i; ?>">
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
                                          echo '투자진행중';
                                        }else if($iv_pr['i_look']=="C"){
                                          echo '투자마감';
                                        }else if($iv_pr['i_look']=="N"){
                                          echo '투자대기중';
                                        }else if($iv_pr['i_look']=="D"){
                                          echo '상환중';
                                        }else if($iv_pr['i_look']=="F"){
                                          echo '상환완료';
                                        }
                                      ?>
                                      </td>
                  										<td><?php echo $row['i_profit_rate'] ?>%</td>
                  										<td><?php echo $losale[i_loan_day];?>개월</td>
                  										<td><?php echo unit($row['i_pay']) ?>만원</td>
                                      <td class="m_last">
                                        <a href="javascript:void(0);" onclick2="Calculation<?php echo $i; ?>()" onclick="view_calc(<?php echo $i; ?>)">
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
                  									   if ($i == 0)
                  									      echo "<tr><td colspan=\"8\">입찰정보가 없습니다.</td></tr>";
                  									?>

								</tbody>
							</table>
              <p class="right">
							       <a type="button" class="btn more" href="/pnpinvest/?mode=mypage_invest_info">이전</a>
              </p>
							<!-- 페이징 -->
              <!--
							<p class="paging">
								<span class="prev"><a  target="_self">이전</a></span>
								<span class="on">1</span>
								<span><a href="#" target="_self">2</a></span>
								<span><a href="#" target="_self">3</a></span>
								<span><a href="#" target="_self">4</a></span>
								<span><a href="#" target="_self">5</a></span>
								<span class="next"><a href="#" target="_self">다음</a></span>
							</p>
              -->
						</div>
            <!--패이징-->
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
            <?php
            echo get_paging($config['c_write_pages'], $page, $total_laon_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
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
