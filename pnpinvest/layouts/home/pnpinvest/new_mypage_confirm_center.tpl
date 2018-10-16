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
$sql                 = "select  * from mari_seyfert where m_id='$user[m_id]' and s_memuse='Y'";
$seyck               = sql_fetch($sql, false);

require './vendor/autoload.php';
use phpFastCache\CacheManager;
// Setup File Path on your config files
CacheManager::setup(array(
    "path" => sys_get_temp_dir(), // or in windows "C:/tmp/"
));
CacheManager::CachingMethod("phpfastcache");
$InstanceCache = CacheManager::Files();
/* cache use */
$bankcode = $InstanceCache->get('bankcode');
if (is_null($bankcode)) {

  $seyfert_bank_code1 = $InstanceCache->get('seyfert_bank_code1');

  if (is_null($seyfert_bank_code1)) {
      include_once(MARI_PLUGIN_PATH . '/pg/seyfert/aes.class.php');
      $requestPath     = "https://v5.paygate.net/v5/code/listOf/banks?_method=GET";
      $curl_handlebank = curl_init();
      curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
      curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 2);
      curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0);
      curl_setopt($curl_handlebank, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/banks');
      $result = curl_exec($curl_handlebank);
      curl_close($curl_handlebank);
      $seyfert_bank_code1  = json_decode($result, true);
      $InstanceCache->set('seyfert_bank_code1', $seyfert_bank_code1, 1000);
    }
  $seyfert_bank_code2 = $InstanceCache->get('seyfert_bank_code2');
  if (is_null($seyfert_bank_code2)) {
      $requestPath_secu     = "https://v5.paygate.net/v5/code/listOf/securities/ko?_method=GET";
      $curl_handlebank_secu = curl_init();
      curl_setopt($curl_handlebank_secu, CURLOPT_URL, $requestPath_secu);
      curl_setopt($curl_handlebank_secu, CURLOPT_CONNECTTIMEOUT, 2);
      curl_setopt($curl_handlebank_secu, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($curl_handlebank_secu, CURLOPT_SSL_VERIFYPEER, 0);
      curl_setopt($curl_handlebank_secu, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/code/listOf/securities/ko');
      $result_secu = curl_exec($curl_handlebank_secu);
      curl_close($curl_handlebank_secu);
      $seyfert_bank_code2    = json_decode($result_secu, true);
      var_dump($seyfert_bank_code);
      $InstanceCache->set('seyfert_bank_code2', $seyfert_bank_code2, 1000);
    }

  $bank = array_merge($seyfert_bank_code1['data'], $seyfert_bank_code2['data'] );
  foreach($bank as $bankrow){
    $bankcode[$bankrow['cdKey']] = $bankrow['cdNm'];
  }
  $InstanceCache->set('bankcode', $bankcode, 1000);
  unset($bank);
}
?>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<style>
.mypage .my_content h4 span {
    font-size: 18px;
}
span.underline {
    text-decoration: underline;
    padding-bottom: 4px;
    display: block;
}
</style>
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
			<div class="my_content">
				<div class="my_certify clearfix">
					<div class="title2 clearfix">
						<h3 class="fl">입&middot;출금 관리</h3>
						<p class="btn_mytab_wrap">
							<label for="mytab01" class="btn_mytab active">입&middot;출금 관리</label>
							<label for="mytab02" class="btn_mytab">입&middot;출금 내역</label>
						</p>
					</div>
					<div class="mytab">
						<input id="mytab01" type="radio" class="blind" name="mytab" title="입출금 관리 내용 보기" checked>
						<input id="mytab02" type="radio" class="blind" name="mytab" title="입출금 내역 내용 보기">
						<!-- 입출금 관리 start -->
						<div class="mytab_con">
							<div class="my_left">
								<h4>예치금 <span class="t_gr">충전하기</span></h4>
								<ul class="list_con">
                  <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) {?>
									<!-- 가상계좌 발급 전 start -->
									<li class="non_bd">
										<span class="underline">가상계좌 발급후 충전이 가능합니다</span>
										<a class="btn my_gr" href="/pnpinvest/?mode=mypage_certification">가상계좌발급</a>
									</li>
                <?php } ?>
									<!-- 가상계좌 발급 전 end -->
									<li>
										<ul class="list_dot">
										<p>&nbsp;</p>
											<li>가상계좌는 1:1로 할당됩니다.</li>
											<li>할당된 가상계좌로 원화를 충전하면 예치금이 충전됩니다.</li>
											<li>가상계좌 입금시 충전금액 반영까지 최대 5분이 소요되며, 완료 후 충전알림이 발송됩니다.</li>
											<li>5분 경과 후에도 예치금 반영이 되지 않았다면 고객센터<br>(☎02-552-1772)로 문의 주시기 바랍니다.</li>
											<p>&nbsp;</p>
										</ul>
									</li>
									<!-- 가상계좌 발급 후 start -->
									<li>
										<p class="input_wrap_2">
											<span class="tt">은행명</span>
											<span class="t_gr">
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
										</p>
									</li>
									<li>
										<p class="input_wrap_2">
											<span class="tt">예금주</span>
											<span class="t_gr">
                        <?php if (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') { echo "";
                      } else echo $seyck[m_name]." (가상계좌)" ;
                      ?>
                      </span>
										</p>
									</li>
									<li>
										<p class="input_wrap_2">
											<span class="tt">계좌번호</span>
											<span class="t_gr">
                        <?php if (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') { echo "";
                          } else echo $seyck[s_accntNo] ;
                        ?>
                      </span>
										</p>
									</li>
									<!-- 가상계좌 발급 후 end -->
								</ul>
							</div>
							<div class="my_right">
								<h4>예치금 <span class="t_gr">출금하기</span></h4>
								<form action="" class="form_wrap_2">
								<fieldset>
								<ul class="list_con">
									<!-- 가상계좌 발급 전 start -->
									<li>
										<ul class="list_dot">
											<li>출금 수수료 : 무료 / 출금 최소 금액 : 1원 / 출금 최대 금액 : 무제한 (1일 기준)</li>
											<li>출금은 계좌 검증이 완료 된 본인 명의의 계좌로만 가능합니다.</li>
											<li>출금액을 입력 후 출금하기 누르면 휴대폰 SMS로 세이퍼트 인증 숫자가 전송됩니다.</li>
											<li>해당 4자리 숫자를 회신하면 약 5분 이내에 이체가 완료됩니다.</li>
											<p>&nbsp;</p>
										</ul>
									</li>
									<!-- 가상계좌 발급 전 end -->
                  <li>
                    <p class="input_wrap_2 clearfic">
                      <span class="tt">예치금</span>
                      <span class="t_gr fr"><?php echo number_format($user['m_emoney']) ?> 원</span>
                    </p>
                  </li>

									<li>
										<p class="input_wrap_2 clearfic">
											<span class="tt">

                        <?php if( isset($bankcode[ $user['m_my_bankcode'] ]) ) echo $bankcode[ $user['m_my_bankcode'] ] ?>
                      </span>
											<span class="t_gr fr"><?php echo $user['m_my_bankacc']?> <?php if ($user['m_my_bankname']!='' ) echo "(예금주 : ".$user['m_my_bankname']." ) " ?></span>
										</p>
									</li>
                  <script>
                  var m_verifyaccountuse = "<?php echo $user['m_verifyaccountuse']?>";
                  var avail_balance = <?php echo ($user['m_emoney']=='' || $user['m_emoney']<1)? 0 : $user['m_emoney']?>;

                  function setComma(inNum){
                       var outNum;
                       var rgx2 = /(\d+)(\d{3})/;
                       if (typeof inNum == 'number') inNum = String(inNum);
                       outNum = inNum;
                       while (rgx2.test(outNum)) {
                            outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
                        }
                       return outNum;
                  }

                  function addnum(num) {
                    num = num * 10000;

                    $("input[name=o_pay]").val( ( $("input[name=o_pay]").val().replace(/[^0-9]/g,""))*1 + num );
                  }
                  function getall(){
                  //  $("input[name=o_pay]").val(avail_balance);
                  //  return;
                    //실정보를 가져오는 부분 우선은 블럭
                    var url='/api/index.php/newhomeapi/lnq';
                    $.ajax({
                      url:url,
                      type : 'POST',
                      dataType : 'json',
                       success : function(result) {
                         if(result.code==200){
                           $("input[name=o_pay]").val(result.data.amount);
                         }
                       },
                       error: function(request, status, error) {
                         console.log(request + "/" + status + "/" + error);
                         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
                       }
                    });

                  }
                  function dowithdraw(){
                    $.ajax({
                      url:'/api/index.php/newhomeapi/withdraw',
                      type : 'POST',
                      dataType : 'json',
                      data :{ o_pay : $("input[name=o_pay]").val() },
                       success : function(result) {
                         if(result.code==200){
                           alert(result.msg);
                           $("input[name=o_pay]").val('0');
                         }else {
                           alert(result.msg);
                         }
                       },
                       error: function(request, status, error) {
                         console.log(request + "/" + status + "/" + error);
                         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
                       }
                    });
                    return;
                    //실정보를 가져오는 부분 우선은 블럭
                    var url='/api/index.php/newhomeapi/lnq';
                    $.ajax({
                      url:url,
                      type : 'POST',
                      dataType : 'json',
                       success : function(result) {
                         if(result.code==200){
                          if( o_pay > result.data.amount*1 ) {
                            alert( "총 출금 가능한 금액은 "+ result.data.amount + "원 입니다.");return;
                          } else {
                            ;
                          }
                         }
                       },
                       error: function(request, status, error) {
                         console.log(request + "/" + status + "/" + error);
                         alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
                       }
                    });
                  }
                  function withdraw() {
                    var o_pay = ($("input[name=o_pay]").val().replace(/[^0-9]/g,""))*1;
                    if( m_verifyaccountuse !='Y'){
                      alert( "출금계좌등록/ 출금계좌검증 먼저 진행해주세요");
                      location.href="/pnpinvest/?mode=mypage_certification";
                      return;
                    }
                    if (  o_pay < 1){
                      alert( "출금하실 금액을 입력해주세요");
                      $("input[name=o_pay]").focus();
                      return;
                    }
                    if( o_pay > avail_balance){
                      alert( "총 출금 가능한 금액은 "+setComma(avail_balance)+"원 입니다.");
                      $("input[name=o_pay]").focus();
                      return;
                    }
                    if (confirm( setComma(o_pay)+" 원을 출금 신청 하시겠습니까?") ){
                      dowithdraw();
                    }
                  }
                  $(function () {
                    var loading = $("#ajaxloading");
                    $(document).ajaxStart(function () {
                        loading.show();
                    });
                    $(document).ajaxStop(function () {
                        loading.hide();
                    });
                  });
                  </script>
									<li class="non_bd">
										<div class="input_wrap_2 clearfic">
											<span class="tt">출금액</span>
											<ul class="my_sum">
												<li><input type="text" name="o_pay" value="0"></li>
												<li class="clearfix">
													<a type="button" class="btn my_wt btn_sum fl" href="javascript:;" onclick="addnum(50)">+50만</a>
													<a type="button" class="btn my_wt btn_sum fl" href="javascript:;" onclick="addnum(100)">+100만</a>
													<a type="button" class="btn my_wt btn_sum fl" href="javascript:;" onclick="addnum(500)">+500만</a>
													<a type="button" class="btn my_wt btn_sum fl" href="javascript:;" onclick="getall()">전액</a>
												</li>
												<li><a type="button" class="btn my_gr" href="javascript:;" onclick="withdraw()">출금하기</a></li>
											</ul>
										</div>
									</li>
								</ul>
								</fieldset>
								</form>
							</div>
						</div>
						<!-- // 입출금 관리 end -->
						<!-- 입출금 관리 start -->
						<div class="mytab_con my_breakdown">
							<h4>입&middot;출금 내역</h4>
							<form name="listform" class="form_wrap">
							<fieldset>
								<p class="my_bd_btn clearfix">
									<button type="button" class="btn active" onclick="getday(0)">당일</button>
									<button type="button" class="btn" onClick="getday(3)">3일</button>
									<button type="button" class="btn" onClick="getday(7)">1주일</button>
									<button type="button" class="btn" onClick="getmonth(1)">1개월</button>
									<button type="button" class="btn" onClick="getmonth(3)">3개월</button>
									<button type="button" class="btn" onClick="getmonth(6)">6개월</button>
								</p>
								<div class="my_bd_term clearfix">
									<p class="term_input fl"><input type="text" class="calendar" value="<?php echo date('Y-m-d')?>" name="startdate">
                  <!--button type="button" class="btn t_term">날짜선택</button-->
                  </p>
									<span class="dash fl center">-</span>
									<p class="term_input fr"><input type="text" class="calendar" value="<?php echo date('Y-m-d')?>" name="endtdate">
                  <!--button type="button" class="btn t_term">날짜선택</button-->
                  </p>
									<p class="term_sch"><a type="submit" class="btn my_gr2" href="javascript:;" onClick="getlist()">조회하기</button></a>
								</div>
								<div class="my_bd_list">
									<p class="radiobox radiobox2 right">
										<input id="newtop" type="radio" name="list_top" value="DESC" checked>
										<label for="newtop">최근 거래내역이 위로</label>
										<input id="oldtop" type="radio" name="list_top" value="ASC" >
										<label for="oldtop">과거 거래내역이 위로</label>
									</p>
									<table>
										<caption>입출금 내역</caption>
										<colgroup>
											<col style="width:20%;">
											<col>
											<col style="width:20%;">
											<col style="width:20%;">
										</colgroup>
										<thead>
											<tr>
												<th>일시</th>
												<th>내용</th>
												<th>금액</th>
												<th>잔액</th>
											</tr>
										</thead>
										<tbody id="listtable">
										</tbody>
									</table>
								</div>
							</fieldset>
							</form>
						</div>
						<!-- // 입출금 관리 end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.structure.min.css" type="text/css">
<link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.min.css" type="text/css">
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<style>
.ui-datepicker-trigger {
    display: inline-block;
    cursor: pointer;
    vertical-align: middle;
    border-radius: 3px;
    border-style: solid;
    border-width: 1px;
    line-height: 30px;
    padding: 0 10px;
    transition: .2s ease-out;
    text-align: center;
}
.ui-datepicker-trigger
{    position: absolute;
    top: 0;
    right: 0;
    width: 32px;
    height: 32px;
    text-indent: -10px;
    background: url(../img/btn_calendar.gif) center no-repeat;
    border-radius: 0;
    border: none;
  }
</style>
<script>
Date.prototype.yyyymmdd = function() {
  var mm = this.getMonth() + 1; // getMonth() is zero-based
  var dd = this.getDate();

  return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
        ].join('-');
};

function getoday() {
  var tomorrow = new Date();
  $("input[name=startdate]").val(tomorrow.yyyymmdd());
  $("input[name=endtdate]").val(tomorrow.yyyymmdd());
}
function getday(days){
  var tomorrow = new Date();
  $("input[name=endtdate]").val(tomorrow.yyyymmdd());
  tomorrow.setDate(tomorrow.getDate() - days);
  $("input[name=startdate]").val(tomorrow.yyyymmdd());
   getlist();
}
function getmonth(month){
  var tomorrow = new Date();
  $("input[name=endtdate]").val(tomorrow.yyyymmdd());
  tomorrow.setMonth(tomorrow.getMonth() - month);
  $("input[name=startdate]").val(tomorrow.yyyymmdd());
   getlist();
}
function getlist() {
  $.ajax({
    url:"/api/index.php/newhomeapi/translist",
    type : 'GET',
    dataType : 'json',
    data :   $("form[name=listform]").serialize(),
     success : function(result) {
       if(result.cnt<1){
         $("#listtable").html('<tr><td colspan="4" class="empty center">거래내역이 없습니다.</td></tr>');
       }else {
         $("#listtable").empty();
         $.each (result.list , function (ind, row){
           $("#listtable").append("<tr><td>"+row.p_datetime+"</td><td>"+row.p_content+"</td><td>"+row.p_emoney+"원</td><td>"+row.p_top_emoney+"원</td></tr>");
         });
       }
     },
     error: function(request, status, error) {
       console.log(request + "/" + status + "/" + error);
       alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
     }
  });
}
$(document).ready(function ()  {
  $('.calendar').datepicker({
    showOn: "button",
	 changeMonth: true,
	 changeYear: true,
	 dateFormat: 'yy-mm-dd',
	 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
	 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
   buttonImage: "/pnpinvest/img/btn_calendar.gif",
  buttonText: "Calendar"
 });
 getlist();
});
</script>
{# new_footer}
