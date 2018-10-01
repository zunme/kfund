<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# new_header}
<style>
:after, :before {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.row:after, .row:before {
    display: table;
    content: " ";
}
.row:after {
    clear: both;
}
.row {
  margin-right: -15px;
  margin-left: -15px;
}
.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
  position: relative;
  min-height: 1px;
  padding-right: 15px;
  padding-left: 15px;
}
.col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9, .col-xs-10, .col-xs-11, .col-xs-12 {
  float: left;
}
.col-xs-12 {
  width: 100%;
}
.col-xs-11 {
  width: 91.66666667%;
}
.col-xs-10 {
  width: 83.33333333%;
}
.col-xs-9 {
  width: 75%;
}
.col-xs-8 {
  width: 66.66666667%;
}
.col-xs-7 {
  width: 58.33333333%;
}
.col-xs-6 {
  width: 50%;
}
.col-xs-5 {
  width: 41.66666667%;
}
.col-xs-4 {
  width: 33.33333333%;
}
.col-xs-3 {
  width: 25%;
}
.col-xs-2 {
  width: 16.66666667%;
}
.col-xs-1 {
  width: 8.33333333%;
}
.col-xs-pull-12 {
  right: 100%;
}
.col-xs-pull-11 {
  right: 91.66666667%;
}
.col-xs-pull-10 {
  right: 83.33333333%;
}
.col-xs-pull-9 {
  right: 75%;
}
.col-xs-pull-8 {
  right: 66.66666667%;
}
.col-xs-pull-7 {
  right: 58.33333333%;
}
.col-xs-pull-6 {
  right: 50%;
}
.col-xs-pull-5 {
  right: 41.66666667%;
}
.col-xs-pull-4 {
  right: 33.33333333%;
}
.col-xs-pull-3 {
  right: 25%;
}
.col-xs-pull-2 {
  right: 16.66666667%;
}
.col-xs-pull-1 {
  right: 8.33333333%;
}
.col-xs-pull-0 {
  right: auto;
}
.col-xs-push-12 {
  left: 100%;
}
.col-xs-push-11 {
  left: 91.66666667%;
}
.col-xs-push-10 {
  left: 83.33333333%;
}
.col-xs-push-9 {
  left: 75%;
}
.col-xs-push-8 {
  left: 66.66666667%;
}
.col-xs-push-7 {
  left: 58.33333333%;
}
.col-xs-push-6 {
  left: 50%;
}
.col-xs-push-5 {
  left: 41.66666667%;
}
.col-xs-push-4 {
  left: 33.33333333%;
}
.col-xs-push-3 {
  left: 25%;
}
.col-xs-push-2 {
  left: 16.66666667%;
}
.col-xs-push-1 {
  left: 8.33333333%;
}
.col-xs-push-0 {
  left: auto;
}
.col-xs-offset-12 {
  margin-left: 100%;
}
.col-xs-offset-11 {
  margin-left: 91.66666667%;
}
.col-xs-offset-10 {
  margin-left: 83.33333333%;
}
.col-xs-offset-9 {
  margin-left: 75%;
}
.col-xs-offset-8 {
  margin-left: 66.66666667%;
}
.col-xs-offset-7 {
  margin-left: 58.33333333%;
}
.col-xs-offset-6 {
  margin-left: 50%;
}
.col-xs-offset-5 {
  margin-left: 41.66666667%;
}
.col-xs-offset-4 {
  margin-left: 33.33333333%;
}
.col-xs-offset-3 {
  margin-left: 25%;
}
.col-xs-offset-2 {
  margin-left: 16.66666667%;
}
.col-xs-offset-1 {
  margin-left: 8.33333333%;
}
.col-xs-offset-0 {
  margin-left: 0;
}
@media (min-width: 768px) {
  .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12 {
    float: left;
  }
  .col-sm-12 {
    width: 100%;
  }
  .col-sm-11 {
    width: 91.66666667%;
  }
  .col-sm-10 {
    width: 83.33333333%;
  }
  .col-sm-9 {
    width: 75%;
  }
  .col-sm-8 {
    width: 66.66666667%;
  }
  .col-sm-7 {
    width: 58.33333333%;
  }
  .col-sm-6 {
    width: 50%;
  }
  .col-sm-5 {
    width: 41.66666667%;
  }
  .col-sm-4 {
    width: 33.33333333%;
  }
  .col-sm-3 {
    width: 25%;
  }
  .col-sm-2 {
    width: 16.66666667%;
  }
  .col-sm-1 {
    width: 8.33333333%;
  }
  .col-sm-pull-12 {
    right: 100%;
  }
  .col-sm-pull-11 {
    right: 91.66666667%;
  }
  .col-sm-pull-10 {
    right: 83.33333333%;
  }
  .col-sm-pull-9 {
    right: 75%;
  }
  .col-sm-pull-8 {
    right: 66.66666667%;
  }
  .col-sm-pull-7 {
    right: 58.33333333%;
  }
  .col-sm-pull-6 {
    right: 50%;
  }
  .col-sm-pull-5 {
    right: 41.66666667%;
  }
  .col-sm-pull-4 {
    right: 33.33333333%;
  }
  .col-sm-pull-3 {
    right: 25%;
  }
  .col-sm-pull-2 {
    right: 16.66666667%;
  }
  .col-sm-pull-1 {
    right: 8.33333333%;
  }
  .col-sm-pull-0 {
    right: auto;
  }
  .col-sm-push-12 {
    left: 100%;
  }
  .col-sm-push-11 {
    left: 91.66666667%;
  }
  .col-sm-push-10 {
    left: 83.33333333%;
  }
  .col-sm-push-9 {
    left: 75%;
  }
  .col-sm-push-8 {
    left: 66.66666667%;
  }
  .col-sm-push-7 {
    left: 58.33333333%;
  }
  .col-sm-push-6 {
    left: 50%;
  }
  .col-sm-push-5 {
    left: 41.66666667%;
  }
  .col-sm-push-4 {
    left: 33.33333333%;
  }
  .col-sm-push-3 {
    left: 25%;
  }
  .col-sm-push-2 {
    left: 16.66666667%;
  }
  .col-sm-push-1 {
    left: 8.33333333%;
  }
  .col-sm-push-0 {
    left: auto;
  }
  .col-sm-offset-12 {
    margin-left: 100%;
  }
  .col-sm-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-sm-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-sm-offset-9 {
    margin-left: 75%;
  }
  .col-sm-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-sm-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-sm-offset-6 {
    margin-left: 50%;
  }
  .col-sm-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-sm-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-sm-offset-3 {
    margin-left: 25%;
  }
  .col-sm-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-sm-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-sm-offset-0 {
    margin-left: 0;
  }
}
@media (min-width: 992px) {
  .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
    float: left;
  }
  .col-md-12 {
    width: 100%;
  }
  .col-md-11 {
    width: 91.66666667%;
  }
  .col-md-10 {
    width: 83.33333333%;
  }
  .col-md-9 {
    width: 75%;
  }
  .col-md-8 {
    width: 66.66666667%;
  }
  .col-md-7 {
    width: 58.33333333%;
  }
  .col-md-6 {
    width: 50%;
  }
  .col-md-5 {
    width: 41.66666667%;
  }
  .col-md-4 {
    width: 33.33333333%;
  }
  .col-md-3 {
    width: 25%;
  }
  .col-md-2 {
    width: 16.66666667%;
  }
  .col-md-1 {
    width: 8.33333333%;
  }
  .col-md-pull-12 {
    right: 100%;
  }
  .col-md-pull-11 {
    right: 91.66666667%;
  }
  .col-md-pull-10 {
    right: 83.33333333%;
  }
  .col-md-pull-9 {
    right: 75%;
  }
  .col-md-pull-8 {
    right: 66.66666667%;
  }
  .col-md-pull-7 {
    right: 58.33333333%;
  }
  .col-md-pull-6 {
    right: 50%;
  }
  .col-md-pull-5 {
    right: 41.66666667%;
  }
  .col-md-pull-4 {
    right: 33.33333333%;
  }
  .col-md-pull-3 {
    right: 25%;
  }
  .col-md-pull-2 {
    right: 16.66666667%;
  }
  .col-md-pull-1 {
    right: 8.33333333%;
  }
  .col-md-pull-0 {
    right: auto;
  }
  .col-md-push-12 {
    left: 100%;
  }
  .col-md-push-11 {
    left: 91.66666667%;
  }
  .col-md-push-10 {
    left: 83.33333333%;
  }
  .col-md-push-9 {
    left: 75%;
  }
  .col-md-push-8 {
    left: 66.66666667%;
  }
  .col-md-push-7 {
    left: 58.33333333%;
  }
  .col-md-push-6 {
    left: 50%;
  }
  .col-md-push-5 {
    left: 41.66666667%;
  }
  .col-md-push-4 {
    left: 33.33333333%;
  }
  .col-md-push-3 {
    left: 25%;
  }
  .col-md-push-2 {
    left: 16.66666667%;
  }
  .col-md-push-1 {
    left: 8.33333333%;
  }
  .col-md-push-0 {
    left: auto;
  }
  .col-md-offset-12 {
    margin-left: 100%;
  }
  .col-md-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-md-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-md-offset-9 {
    margin-left: 75%;
  }
  .col-md-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-md-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-md-offset-6 {
    margin-left: 50%;
  }
  .col-md-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-md-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-md-offset-3 {
    margin-left: 25%;
  }
  .col-md-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-md-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-md-offset-0 {
    margin-left: 0;
  }
}
@media (min-width: 1200px) {
  .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12 {
    float: left;
  }
  .col-lg-12 {
    width: 100%;
  }
  .col-lg-11 {
    width: 91.66666667%;
  }
  .col-lg-10 {
    width: 83.33333333%;
  }
  .col-lg-9 {
    width: 75%;
  }
  .col-lg-8 {
    width: 66.66666667%;
  }
  .col-lg-7 {
    width: 58.33333333%;
  }
  .col-lg-6 {
    width: 50%;
  }
  .col-lg-5 {
    width: 41.66666667%;
  }
  .col-lg-4 {
    width: 33.33333333%;
  }
  .col-lg-3 {
    width: 25%;
  }
  .col-lg-2 {
    width: 16.66666667%;
  }
  .col-lg-1 {
    width: 8.33333333%;
  }
  .col-lg-pull-12 {
    right: 100%;
  }
  .col-lg-pull-11 {
    right: 91.66666667%;
  }
  .col-lg-pull-10 {
    right: 83.33333333%;
  }
  .col-lg-pull-9 {
    right: 75%;
  }
  .col-lg-pull-8 {
    right: 66.66666667%;
  }
  .col-lg-pull-7 {
    right: 58.33333333%;
  }
  .col-lg-pull-6 {
    right: 50%;
  }
  .col-lg-pull-5 {
    right: 41.66666667%;
  }
  .col-lg-pull-4 {
    right: 33.33333333%;
  }
  .col-lg-pull-3 {
    right: 25%;
  }
  .col-lg-pull-2 {
    right: 16.66666667%;
  }
  .col-lg-pull-1 {
    right: 8.33333333%;
  }
  .col-lg-pull-0 {
    right: auto;
  }
  .col-lg-push-12 {
    left: 100%;
  }
  .col-lg-push-11 {
    left: 91.66666667%;
  }
  .col-lg-push-10 {
    left: 83.33333333%;
  }
  .col-lg-push-9 {
    left: 75%;
  }
  .col-lg-push-8 {
    left: 66.66666667%;
  }
  .col-lg-push-7 {
    left: 58.33333333%;
  }
  .col-lg-push-6 {
    left: 50%;
  }
  .col-lg-push-5 {
    left: 41.66666667%;
  }
  .col-lg-push-4 {
    left: 33.33333333%;
  }
  .col-lg-push-3 {
    left: 25%;
  }
  .col-lg-push-2 {
    left: 16.66666667%;
  }
  .col-lg-push-1 {
    left: 8.33333333%;
  }
  .col-lg-push-0 {
    left: auto;
  }
  .col-lg-offset-12 {
    margin-left: 100%;
  }
  .col-lg-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-lg-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-lg-offset-9 {
    margin-left: 75%;
  }
  .col-lg-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-lg-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-lg-offset-6 {
    margin-left: 50%;
  }
  .col-lg-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-lg-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-lg-offset-3 {
    margin-left: 25%;
  }
  .col-lg-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-lg-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-lg-offset-0 {
    margin-left: 0;
  }
}
.top_line_table{
  border-top: 4px solid #061551;
  text-align: center;
  margin-bottom: 15px;
  border-right:1px solid #aaa;
}
.bg-light-gray{
  background-color: #f8f8f8;
  border-left:1px solid #aaa;
  border-bottom:1px solid #aaa;
  padding:5px;
  line-height: 32px;
}
.bg-white{
  background-color: #FFF;
  border-left:1px solid #aaa;
  border-bottom:1px solid #aaa;
  padding:5px;
  min-height:45px;
  line-height: 32px;
}
.row {
    margin-right: 0px;
    margin-left: 0px;
}
.row2nd
{
  margin-right: -15px;
  margin-left: -15px;
  }
  div.col-xs-6.bg-light-gray{
      min-height:45px;
  }
  .top_line_table .btn_sum2 {
    color: #fff;
    padding: 5px 5px 5px 30px;
    line-height: 20px;
    background: #00656a url('/pnpinvest/img/iw_btn.png') 10px 5px no-repeat;
}
.txt_green {
    font-weight: 600;
    color: #00656a;
}
.invest_write .iw_invest_btn .btn {
    height: auto;
  }
</style>

<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t1"><span class="motion" data-animation="flash">투자하기</span></h2>
	<!-- invest view -->
	<div class="invest_write">
		<div class="container">
			<!-- 요약정보 -->
			<div class="iw_title clearfix">
				<h3 class="fl"><?php echo $iv['i_invest_name'];?></h3>
				<span class="fr iw_term">
          <?php
          if($order_pay=="100" || $iv['i_invest_eday'] < $date){
            echo '모집종료';
          }else{
             echo substr($iv[i_invest_sday],0,4).'.'.substr($iv[i_invest_sday],5,2).'.'.substr($iv[i_invest_sday],8,2).' ~ '.substr($iv[i_invest_eday],0,4).'.'.substr($iv[i_invest_eday],5,2).'.'.substr($iv[i_invest_eday],8,2);
          }
          ?>
        </span>
			</div>
			<form name="inset_form"  method="post" enctype="multipart/form-data">
        <input type="hidden" name="loan_id" value="<?php echo $loan_id; ?>">
        <input type="hidden" name="m_no" value="<?php echo $user[m_no]; ?>">
        <input type="hidden" name="m_id" value="<?php echo $user[m_id]; ?>">
        <input type="hidden" name="m_name" value="<?php echo $user[m_name]; ?>">
        <input type="hidden" name="i_loan_day" value="<?php echo $loa[i_loan_day]; ?>">
        <input type="hidden" name="i_year_plus" value="<?php echo $loa[i_year_plus]; ?>">
        <input type="hidden" name="i_repay" value="<?php echo $loa[i_repay]; ?>">
        <input type="hidden" name="type" value="w"/>
        <input type="hidden" name="stype" value="invest"/>
        <input type="hidden" name="loan" value="<?php echo $loa['i_loan_type']?>">
        <?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>
        <input type="hidden" name="bank_update" value="Y"/>
        <?php }?>
			<fieldset>
				<div class="iw_progress">
					<p class="iw_con"><strong><?php echo number_format($order_pay);?>%</strong> 진행중</p>
					<p class="progress"><span class="p_bar" style="width:<?php echo number_format($order_pay);?>%"></span></p>
					<p class="iw_sum"><?php echo number_format($orders)?> / <?php echo number_format($loa[i_loan_pay])?>원</p>
				</div>
				<div>
					<h4 class="iw_title2">투자상품 요약정보</h4>
<!--
					<table class="iw_table">
						<caption>투자상품 요약정보 표</caption>
						<colgroup>
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:15%">
						</colgroup>
						<thead>
							<tr>
								<th>대출 신청금액</th>
								<th>투자 가능 금액</th>
								<th>수익률</th>
								<th>엔젤펀딩파트너스 등급</th>
								<th>만기</th>
								<th class="last">투자수익확인</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>150,000,000원</td>
								<td>80,000,000원</td>
								<td>연18%</td>
								<td>A3</td>
								<td>3개월</td>
								<td class="last"><button type="button" class="btn btn_sum">투자수익금액</button></td>
							</tr>
						</tbody>
					</table>
-->

<div class="top_line_table">
  <div class="row">

    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">대출 신청금액</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($loa[i_loan_pay]) ?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">투자 가능 금액</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($invest_pay < 0 ? 0 : $invest_pay) ?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">수익률</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo $loa['i_year_plus']; ?>%</div>
      </div>
    </div>

    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">등급</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo $iv['i_grade'];?></div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">만기</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($loa['i_loan_day']) ?>개월</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">투자수익확인</div>
        <div class="col-sm-12 col-xs-6 bg-white"><a href="javascript:;" onClick="calc()" class="btn btn_sum2">투자수익금액</a></div>
      </div>
    </div>
  </div>
</div>

<?php
include (getcwd().'/module/basic.php');
$sameOwnerCheck = sameOwnerCheck ($user['m_id'], $loan_id);
$getMemberlimit = getMemberlimitbyloan($user['m_id'], $loan_id);
$memberInvestmentNowProgress = memberInvestmentNowProgress($user['m_id']);

//$a_total = ( (int)$getMemberlimit['insetpay'] - (int)$memberInvestmentNowProgress['investProgressTotal'] );

$a_total = $getMemberlimit['avail'];
$a_total2 = (int)$sameOwnerCheck['per_maximum'] - (int)$sameOwnerCheck['totalpay'];
if ( $a_total2 < 0 ) $a_total2 = 0;
$available_total = ($a_total > $a_total2) ? $a_total2 : $a_total;

?>

					<h4 class="iw_title2">회원님의 투자한도</h4>
<!--
					<table class="iw_table">
						<caption></caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>총투자한도()</th>
								<th>진행중 투자</th>
								<th>채권당한도</th>
								<th>동일차주 투자금액</th>
								<th class="last">투자가능금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>150,000,000원</td>
								<td>80,000,000원</td>
								<td>5,000,000,000원</td>
								<td>0원</td>
								<td class="last t_green">5,000,000,000원</td>
							</tr>
						</tbody>
					</table>
-->
<div class="top_line_table">
  <div class="row">

    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">총투자한도(<?php echo ($loa['i_payment']=="cate02"||$loa['i_payment']=="cate04") ? "부동산":"동산"?>)</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($getMemberlimit['insetpay']);?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">진행중 투자(부동산)</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($getMemberlimit['progress']['budongsan']);?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">진행중 투자(동산)</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($getMemberlimit['progress']['dongsan']);?>원</div>
      </div>
    </div>

    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">채권당한도</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($sameOwnerCheck['per_maximum']);?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">동일차주 투자금액</div>
        <div class="col-sm-12 col-xs-6 bg-white"><?php echo number_format($sameOwnerCheck['totalpay']);?>원</div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-12">
      <div class="row row2nd">
        <div class="col-sm-12 col-xs-6 bg-light-gray">투자가능금액</div>
        <div class="col-sm-12 col-xs-6 bg-white txt_green"><?php echo number_format($available_total);?>원</div>
      </div>
    </div>
  </div>
</div>


					<p class="right">※최소  <?php echo number_format(unit($iv['i_invest_mini'])); ?>만원 이상부터 투자하실 수 있습니다.</p>
					<div class="right">
						<p class="iw_sum2">
							<span>투자금액</span>
							<input type="text" name="i_pay" required size="35" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onchange="restring(event);" class="invest_add"/> 원
						</p>
					</div>
					<h4 class="iw_title2">투자위험 안내</h4>
					<ul class="list_ltdot">
						<li>온라인을 통한 금융투자상품의 투자는 회사의 권유 없이 고객의 판단에 의해 이루어집니다.</li>
						<li>부동산 건축자금의 특성상, 상환 예정일 이전에 중도상환될 수 있습니다.</li>
						<li>만기시 채무자의 상황에 따라 연체가 발생할 수 있고 채권추심 등을 통해 투자금 회수에 상당기간 소요될 수 있습니다.</li>
						<li>부동산이 담보로 제공되나 채무 불이행시 경,공매등의 환가절차 과정에서 원금의 일부 손실이 발생할 수 있습니다.</li>
						<li>당사는 원금 및 수익률을 보장하지 않으므로 투자시 신중한 결정 바랍니다.</li>
					</ul>
					<div class="iw_agree">
						<p class="checkbox_wrap">
							<input type="checkbox"  name="agreement1" id="agreement1" />
							<label for="agree01">위의 투자위험을 확인하고 인지하였습니다.</label>
						</p>
						<p class="checkbox_wrap">
							<input type="checkbox"  name="agreement2" id="agreement2" />
							<label for="agree02">개인정보 수집 이용 제공 동의서의 내용을 읽었으며, 동의합니다.</label>
							<button type="button" class="btn privacy modal-link" data-title="개인정보 취급 방침" data-url="/pnpinvest/css/con02.htm">개인정보취급방침</button>
						</p>
						<p class="checkbox_wrap">
							<input type="checkbox"  name="agreement3" id="agreement3"  />
							<label for="agree03">투자자 이용약관의 내용을 읽고 동의합니다.</label>
							<button type="button" class="btn investor privacy modal-link" data-title="투자자이용약관" data-url="/pnpinvest/css/con03.htm">투자자이용약관</button>
						</p>
					</div>
					<h4 class="iw_title2">회원님의 예치금 현황</h4>
					<table class="iw_table">
						<caption>예치금 현황 내용</caption>
						<colgroup>
							<col class="w1">
							<col>
						</colgroup>
            <?php if(!$user['m_my_bankcode'] || !$user['m_my_bankacc']){?>
              <tbody>
                <tr>
                  <th>나의 예치금 입금계좌</th>
                  <td class="last left">
                    <?php echo $user['m_name'];?></b>님 께서는 은행/적립금 입금계좌가 설정되지 않았습니다. 정보를 입력하여 주십시오.</p>
										은행
                      <select name="m_my_bankcode" required>
													    <option>선택</option>
            							<?php
            							   foreach($decode as $key=>$value){
            								for($cnt=0; $cnt<count($value); $cnt++){
            								if (!is_array($value)) $value = array();
            							?>
            									<option value="<?php echo $value[$cnt]['cdKey'];?>" <?php echo $user['m_my_bankcode']==$value[$cnt][cdKey]?'selected':'';?>><?php echo $value[$cnt]['cdNm'];?></option>
            							<?php
            								}
            							   }
            							?>
											</select>
										 계좌번호 <input type="text" name="m_my_bankacc" value="<?php echo $user['m_my_bankacc'];?>" onkeypress=""="warring1(this);" onkeyup="warring1(this);" onchange="warring1(this);" required size="50"  class="invest_add"/>
                             <script>
        										/*계좌번호 숫자만 입력이 가능하게*/
        										function warring1(cnj_str) {
        											var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
        											var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
        											var a_num = cnj_str.value;
        											var cnjValue = "";
        											var cnjValue2 = "";

        											if ((t_num < "0" || "9" < t_num)){
        												if(t_num ==""){
        												}else{
        													alert("숫자만 입력하십시오.");
        													cnj_str.value="";
        													cnj_str.focus();
        													return false;
        												}
        											}

        											if(a_num.indexOf(" ") >= 0 ){
        											alert("공백은 입력하실 수 없습니다.");
        											cnj_str.value="";
        											cnj_str.focus();
        											return false;
        											}
        										}
                            /*예금주 공백 입력이 불가능하게*/
        										function warring2(cnj_str) {
        											var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
        											var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
        											var a_num = cnj_str.value;
        											var cnjValue = "";
        											var cnjValue2 = "";


        											if(a_num.indexOf(" ") >= 0 ){
        											alert("공백은 입력하실 수 없습니다.");
        											cnj_str.value="";
        											cnj_str.focus();
        											return false;
        											}
        										}
        									</script>
                  </td>
                  <tr>
                    <th>예금주</th>
                    <td class="last left"><input type="text" name="m_my_bankname" required size="30"  class="invest_add" onkeyup="warring2(this);" onchange="warring2(this);"/></td>
                  </tr>
                </tr>
              </tbody>
            <?php } else {?>
						<tbody>
							<tr>
								<th>나의 예치금 입금계좌</th>
								<td class="last left"><?php echo bank_name($user['m_my_bankcode']);?> <?php echo $user['m_my_bankacc'];?></td>
							</tr>
							<tr>
								<th>예금주</th>
								<td class="last left"><?php echo $user['m_my_bankname'];?></td>
							</tr>
							<tr>
								<th>사용 가능한 예치금</th>
								<td class="last left"><?php echo number_format($user[m_emoney]) ?>원</td>
							</tr>
						</tbody>
          <?php } ?>
					</table>
					<table class="iw_table">
						<caption>비밀번호 확인</caption>
						<colgroup>
							<col class="w1">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>회원가입 비밀번호</th>
								<td class="left"><input type="password" name="m_password" value="" size="30" required/></td>
							</tr>
						</tbody>
					</table>
          <?php if ($user[m_emoney] < 10000 ){ ?>
					<p class="t_red">*예치금을 충전한 후 투자에 참여하실 수 있습니다.</p>
          <?php } ?>
				</div>
				<p class="iw_invest_btn">
					<a href="javascript:;" id="inset_form_add" class="btn" style="line-height: 50px;">투자하기</a>
				</p>

			</fieldset>
			</form>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<?php
include_once (getcwd().'/module/basic.php');
list($isauthed, $authedmsghead,$authedmsgbody) = isauthed($user);
$isregnum = isregnum($user);
if ( !$isauthed || !$isregnum ){
?>
<style>
.izModal-content-inbox{
  padding :20px 0;
}
.member_notice_div{
  padding : 15px 10px 10px;
}
.member_notice_div .notice_head_p{
  padding : 0 10px 5px 10px;
  font-size: 18px;
}
.member_notice_div .notice_body_p{
  padding : 0 10px 15px 35px;
  font-size: 16px;
}
</style>
<div id="modal-default" data-iziModal-fullscreen="false" data-iziModal-title="안내사항" data-iziModal-subtitle="투자를 진행하기 위해서는 아래 사항이 필요합니다.">
  <div class="izModal-content-inbox">
  <?php if(!$isregnum) { ?>
    <div class="member_notice_div">
      <p class="notice_head_p"><i class="far fa-comment-dots"></i> 원천징수정보를 입력하셔야 투자가 가능합니다. </p>
      <p class="notice_body_p"><b>마이페이지 &gt; 회원정보수정</b> 에서 입력해주세요.</p>
    </div>
  <?php  } if(!$isauthed) { ?>
    <div class="member_notice_div">
      <p class="notice_head_p"><i class="far fa-comment-dots"></i> <?php echo $authedmsghead ?></p>
      <p class="notice_body_p"><?php echo $authedmsgbody ?></p>
    </div>
  <?php } ?>
  <div style="text-align:center;margin-top:10px;">
    <a href="/pnpinvest/?mode=mypage_modify" class="btn btn-rose">회원정보수정</a>
  </div>
</div>
</div>
<script>
$("document").ready( function() {
  var modal = $('#modal-default').iziModal(
    {
        transitionIn: 'fadeInDown' // Here transitionIn is the same property.
        , transitionOut: 'fadeOutDown'
        ,overlayClose: false
        ,overlayColor: 'rgba(0, 0, 0, 0.6)'
    }
  );
  $('#modal-default').iziModal('open');

});
</script>
<?php } else {?>
<!-- // -->
<style>
.izModal-content-inbox{
  padding:10px;
}
.agree_notice_div p{
  font-size:16px;
  padding: 5px 12px;
}
.agree_notice_div #agreenotice{
  box-shadow: none;
  border:0;
  border-bottom: 1px solid #e91e63;
  width:70px;
  padding-left:10px;
}
</style>
<div id="modal-default" data-iziModal-fullscreen="false" data-iziModal-title="투자위험 고지" data-iziModal-subtitle="투자를 진행하기 위해서는 아래 입력란에 동의함 을 적어주세요.">
  <div class="izModal-content-inbox">
      <div class="agree_notice_div">
      <p class="notice_head_p">본 투자상품은 원금이 보장되지 않습니다.</p>
      <p class="notice_body_p"> 모든 투자상품은 현행 법률 상 ‘유사수신행위의 규제에 관한 법률’에 의거하여 원금과 수익을 보장할 수 없습니다. 또한 차입자가 원금의 전부 또는 일부를 상환하지 못할 경우 발생하게 되는 투자금 손실 등 투자위험은 투자자가 부담하게 됩니다. </p>
      <p class="notice_foot_p">나 <span><?php echo $user['m_name']?></span> 은 상기 내용을 확인하였으며 그 내용에 <input type="text" id="agreenotice" name="agreenotice" placeholder="동의함" onkeyup="checkagreenotice()">
        <br>(투자를 진행하기 위해서는 입력란에  동의함  을 적어주세요)
    </div>
    <div style="text-align:center;margin-top:10px;">
    <a href="javascript:;" id="agree_notice_btn" class="btn btn-rose" style="display:none" onClick="Inset_form_Ok2(document.inset_form);">확인</a>
    </div>
  </div>
</div>
<?php }?>
<script>
/*투자신청*/
var modal;
$(function() {
	$('#inset_form_add').click(function(){
		Inset_form_Ok(document.inset_form);
    //$('#modal-default').iziModal('open');
	});
  modal = $('#modal-default').iziModal(
  {
      transitionIn: 'fadeInDown' // Here transitionIn is the same property.
      , transitionOut: 'fadeOutDown'
      ,overlayClose: false
      ,overlayColor: 'rgba(0, 0, 0, 0.6)'
    }
  );

});
function checkagreenotice() {
  if( $("#agreenotice").val() =='동의함'){
    $("#agree_notice_btn").show();
  }else $("#agree_notice_btn").hide();
}
function Inset_form_Ok(f)
{
  <?php if ( !$isauthed || !$isregnum ){ ?>
    $('#modal-default').iziModal('open');
    return;
  <?php } ?>
	if(!f.i_pay.value){alert('\n투자하실 금액을 입력하여 주십시오.');f.i_pay.focus();return false;}
	//var lloan_pattern = /[^(0-9)]/;//숫자
	//if(lloan_pattern.test(f.i_pay.value)){alert('\n투자금액은 숫자만 입력하실수 있습니다');f.i_pay.value='';f.i_pay.focus();return false;}
	if(!$('#agreement1').is(':checked')){alert('투자위험을 확인하시고 체크하여 주십시오.'); return false;}
	if(!$('#agreement2').is(':checked')){alert('개인정보 수집 이용 제공 동의서에 체크하여 주십시오.'); return false;}
	if(!$('#agreement3').is(':checked')){alert('투자자 이용약관에 체크하여 주십시오.'); return false;}

<?php if(!$user[m_my_bankcode] || !$user[m_my_bankacc]){?>

	if(f.m_my_bankcode[0].selected == true){alert('\n은행을 선택하여 주십시오.');return false;}
	if(!f.m_my_bankacc.value){alert('\n계좌번호를 입력하여 주십시오.');f.m_my_bankacc.focus();return false;}
	if(!f.m_my_bankname.value){alert('\n예금주를 입력하여 주십시오.');f.m_my_bankname.focus();return false;}

<?php }?>
 var maxlimit = <?php echo $available_total?>;

	/*start 만원단위로만 거르기추가 수치바꿀시 '10000'해당 숫자만변경 2017-08-23 임근호*/
	var i_pay=f.i_pay.value;
	var regpay = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;
	var i_pay = i_pay.replace(regpay, "");
	var payck=Math.ceil(i_pay / 10000) * 10000;

  if (  i_pay * 1 > <?php echo ( (int)$user[m_emoney] ) ?> )  {
    alert('\n현재 회원님의 충전금액은 <?php echo number_format( $user[m_emoney] ) ?>원입니다.');
	  return false;
  }

	if(payck>i_pay){
		alert('\n만원단위로만 입력하실 수 있습니다.');
	return false;}
	/*end 만원단위로만 거르기추가 수치바꿀시 '10000'해당 숫자만변경 2017-08-23 임근호*/
  if( i_pay > maxlimit ) {
		alert('현 상품의 투자가능 한도는 <?php echo number_format($available_total)?>원 입니다.');return false;
	}

	if( i_pay < <?php echo $iv['i_invest_mini']; ?> ) {
		alert('최소 <?php echo number_format(unit($iv['i_invest_mini'])); ?>만원 이상부터 투자하실 수 있습니다.');return false;
	}
	if(!f.m_password.value){alert('\n비밀번호를 입력하여 주십시오'); f.m_password.focus(); return false;}

  $("#agreenotice").val('');
  $("#agree_notice_btn").hide();
  $('#modal-default').iziModal('open');
}
function Inset_form_Ok2(f){
  f.method = 'post';
  f.action = '{MARI_HOME_URL}/?up=invest2';
  f.submit();
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
// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function(){
    if(this==0) return 0;

    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');

    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

    return n;
};

// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";

    return num.format();
};

function onlyNumber(event){
event = event || window.event;
var keyID = (event.which) ? event.which : event.keyCode;
if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
  return;
else
  return false;
}
function removeChar(event) {
event = event || window.event;
var keyID = (event.which) ? event.which : event.keyCode;
if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
event.target.value = event.target.value.replace(/[^0-9]/g, "").format();
  return;
}
else
  event.target.value = event.target.value.replace(/[^0-9]/g, "").format();
}
function restring(event){
event.target.value = event.target.value.replace(/[^0-9]/g, "").format();
}

function calc() {
  //var data =  $("form[name=inset_form]").serialize();
  var num = parseFloat($("input[name=i_pay]").val().replace(/[^0-9]/g, ""));
  if( isNaN(num) || num < <?php echo $iv['i_invest_mini']; ?> ) {
    alert( "최소 <?php echo number_format(unit($iv['i_invest_mini'])); ?>만원 이상부터 투자가 가능합니다.");
    return false;
  }
  var data={'loanid':<?php echo $loan_id; ?>,'won':num, 'type':'json'};

  $.ajax({
  url:"/api/index.php/main/calcabout",
   type : 'GET',
   data:data,
   dataType : 'json',
   success : function(result) {
     var table1 = "<table class='iw_table'><caption>투자수익금액 표 1</caption><colgroup><col><col><col><col><col><col><col><col></colgroup><tbody><tr><th>투자금액</th><td>"+result.info.won.format()+"원</td><th>상환기간</th><td><?php echo $loa[i_loan_day]; ?>개월</td><th>금리</th><td><?php echo $loa[i_year_plus]; ?>%</td><th>상환방식</th><td><?php echo $loa[i_repay]; ?></td></tr></tbody></table>";
     var $table = $("<table>");
     $table.addClass('iw_table');
     $table.append('<thead>').children('thead').append('<tr><th scope="col">회차</th><th scope="col">지급일</th><th scope="col">예상이용일수</th><th scope="col">수익금(세전)</th><th scope="col">이자소득세</th><th scope="col">수익금(세후)</th></tr>');
     $table.append('<tbody>');
     $table.append('<tfoot>').children('tfoot').append('<tr><th scope="row" colspan="3">예상총합계</th><td><span class="calc_totalija">'+result.total.ija+'</span></td><td><span class="calc_total_withholding">'+result.total.withholding+'</span></td><td><span class="calc_total_calc">'+(result.total.ija - result.total.profit -result.total.withholding)+'</span></td></tr>');

     $("#iw_popup_cont").empty();
     $("#iw_popup_cont").html ( table1 );
     $("#iw_popup_cont").append($table);
     $.each( result.calc, function (idx,val){
       var tr = '<tr><th scope="row">'+(idx+1)+'회차</td><td>'+val.end+'</td><td>'+val.diff+'일</td><td>'+val.ija.format()+'원</td><td>'+val.withholding.format()+'원</td><td>'+(val.ija-val.withholding - val.profit).format()+'원</td></tr>';
       $table.children('tbody').append(tr);
     });
     $('.iw_popup').fadeIn('fast');
     $('.iw_popup .iwp_sum').fadeIn('fast');
   },
   error: function(request, status, error) {
     console.log(request + "/" + status + "/" + error);

   }
});


}

</script>
{# new_footer}
