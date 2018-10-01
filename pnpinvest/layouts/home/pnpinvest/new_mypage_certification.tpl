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

$sql = "select s_date , date_sub( now() , interval 4 minute) limittime from mari_seyfert_order where m_id='".$user['m_id']."' and s_type='3' order by s_date desc limit 1";
$vtimecheckview = sql_fetch($sql, false);

require './vendor/autoload.php';
use phpFastCache\CacheManager;
// Setup File Path on your config files
CacheManager::setup(array(
    "path" => sys_get_temp_dir(), // or in windows "C:/tmp/"
));
CacheManager::CachingMethod("phpfastcache");
$InstanceCache = CacheManager::Files();
/* cache use */
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
    $InstanceCache->set('seyfert_bank_code1', $seyfert_bank_code1, 300);
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
    $InstanceCache->set('seyfert_bank_code2', $seyfert_bank_code2, 300);
  }
?>
{# new_header}

<script>
var m_signpurpose = "<?php echo $user['m_signpurpose']?>";
function createvirtual_normal() {
  //가상계좌생성
  console.log("normal");
  var  url='/pnpinvest/?up=virtualaccountissue';
  $.post(url,$("form[name=virtualacnt]").serialize(),  function(data) { $("#ajaxdiv").html(data) });
}
function createvirtual_loan() {
  //가상계좌생성
  console.log("loan");
  var url='/pnpinvest/?up=virtualaccountissue_loan';
  $.post(url,$("form[name=virtualacnt]").serialize(),  function(data) { $("#ajaxdiv").html(data) });
}
</script>
<style>

.list_con > li > .input_wrap {
    margin-top: 10px;
}
</style>


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
			<div class="my_content">
				<div class="my_certify clearfix">
					<div class="title clearfix">
						<h3 class="fl">인증센터</h3>
					</div>
					<div class="my_left">
						<h4 class="t_gr">예치금 계좌생성</h4>
            <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) {?>
            <form name="virtualacnt">
              <input type="hidden" name="type" value="w">
              <input type="hidden" name="m_id" value="<?php echo $user['m_id']?>">
              <input type="hidden" name="m_name" value="<?php echo $user['m_name']?>">
              <input type="hidden" name="s_bnkCd" value="SC_023">
            </form>
            <?php } ?>
						<fieldset>
						<ul class="list_con">
							<li>
								<ul class="list_dot">
									<li>예치금 가상계좌를 생성해야 정상 이용이 가능합니다.</li>
									<li>계좌이체 후 입금 반영하는 데에는 약 1~5분이 소요됩니다.</li>
									<li>예치금 입금은 가상계좌에 입금한 만큼 1:1로 충전이 이루어집니다.</li>
									<li>은행 전산 점검시간인 23:30~01:00사이에는 이용제한이 있을 수 있습니다.</li>
									<p>&nbsp;</p>
								</ul>
							</li>
							<li>
								<p class="input_wrap">
									<label class="tt" for="my_bank_select1" style="text-align: center;"">은행명</label>
              <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) {?>
									<select class="select t3 w3" id="my_bank_select1" style="padding: 6px;">
										<option value="선택">제일은행</option>
									</select>
              <?php } else { ?>
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
              <?php } ?>
								</p>
							</li>
							<li>
								<p class="input_wrap">
									<span class="tt">계좌번호</span>
									<span class="t_gy">
                    <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) {?>
                    아직 계좌번호를 발급받지 않으셨습니다.
                  <?php } else { echo $seyck['s_accntNo']; } ?>
                  </span>
								</p>
							</li>
							<li class="center non_bd">
                <?php if( (!isset($seyck['s_accntNo']) || $seyck['s_accntNo']=='') ) { ?>
                  <?php if($user['m_signpurpose']=='L') { ?>
                    <button class="btn my_gr" style="margin-bottom:10px;" onclick="createvirtual_loan()">대출자 가상 계좌생성</button>
                  <?php } else {?>
                    <button class="btn my_bl" style="margin-bottom:10px;" onclick="createvirtual_normal()">투자자 가상 계좌생성</button>
                  <?php } ?>
                <?php } ?>
                <div id="90daydiv">
  								<button class="btn" id="preauthbtn" onclick="preauthstatus(true)">90일 선인증</button>
                </div>
							</li>
							<li class="non_bd">
								<p>※ 투자자 분들께서는 <span class="t_rd">투자자 가상계좌생성</span>을 해주셔야 하며, <br>
								투자자께서 오인하여 <span class="t_rd">대출자 가상계좌 생성</span>시에는 3일~5일내로 <br>
								변경처리 해야 하는 어려움이 있으니 유의하여 발급 바랍니다.
                              						</p>
							</li>
						</ul>
						</fieldset>
					</div>
					<div class="my_right">
						<h4 class="t_gr">출금 계좌등록</h4>
						<form class="form_wrap" name="accountform">

						<fieldset>
						<ul class="list_con">
							<li>
								<ul class="list_dot">
									<li>투자의 원리금 수취용 계좌 정보(본인 명의 필수)를 입력해 주세요.</li>
									<li>은행 전산 점검시간인 23:30~01:00 사이에는 이용제한이 있을수 있습니다.</li>
									<li>계좌검증 시 최대 5분 정도 소요될 수 있으며, SMS로 4자리의 숫자를 회신 후</li>
									<li>처리안내 SMS 수신과 동시에 정상적으로 출금 하실 수 있습니다.</li>
									<p>&nbsp;</p>
								</ul>
							</li>
							<li>
								<p class="input_wrap">
									<label for="m_my_bankcode" class="tt">은행명</label>
									<select id="m_my_bankcode" name="m_my_bankcode" data-val="<?php echo $user['m_my_bankcode']?>" class="select t3 w3" onChange="changed()">
										<option value="">선택</option>
                    <option value="">=========일반계좌======</option>
										<?php
                    foreach($seyfert_bank_code1['data'] as $row) { ?>
                      <option value="<?php echo $row['cdKey']?>" <?php echo ( $user['m_my_bankcode'] == $row['cdKey'] ) ? "selected":"" ?> ><?php echo $row['cdNm']?></option>
                    <?php } ?>
                    <option value="">=========증권계좌======</option>
                    <?php
                    foreach($seyfert_bank_code2['data'] as $row) { ?>
                      <option value="<?php echo $row['cdKey']?>" <?php echo ( $user['m_my_bankcode'] == $row['cdKey'] ) ? "selected":"" ?> ><?php echo $row['cdNm']?></option>
                    <?php } ?>
									</select>
								</p>
							</li>
							<li>
								<p class="input_wrap">
									<label for="m_my_bankname" class="tt">계좌주</label>
									<input id="m_my_bankname" name="m_my_bankname" value="<?php echo $user['m_my_bankname']?>" data-val="<?php echo $user['m_my_bankname']?>" type="text" onkeyup="changed()" onkeypress="changed()" placeholder="계좌주를 입력해주세요.">
								</p>
							</li>
							<li>
								<p class="input_wrap">
									<label for="my_bank_text2" class="tt">계좌번호</label>
									<input id="my_bank_text2"  name="m_my_bankacc" value="<?php echo $user['m_my_bankacc']?>" data-val="<?php echo $user['m_my_bankacc']?>" type="text" onkeyup="changed()" onkeypress="changed()" placeholder="계좌번호를 입력해주세요.">
								</p>
							</li>
							<li>
								<p class="input_wrap">
									<span class="tt">계좌상태</span>
									<span class="t_bl"><?php echo ($user['m_verifyaccountuse']=="Y") ? "계좌 검증 완료": "계좌 미검증"?></span>
								</p>
							</li>

              <li class="center non_bd clearfix">
                <?php
                 if( $user['m_verifyaccountuse']=="N" && isset($vtimecheckview['s_date']) && $vtimecheckview['s_date'] >  $vtimecheckview['limittime'] ) {
                 ?>
                 <a href="javascript:alert('현재 검증절차가 진행중입니다.\n\n검증요청후 최대4분이상 소요될 수 있습니다. 검증요청 SMS 회신번호 4자리를 입력하여 주십시오.');" class="btn my_gr">검증 진행중</a>
               <?php } else { ?>
                 <?php if($user['m_my_bankcode']=="" || $user['m_my_bankacc']=="" ||$user['m_my_bankname']==""){ ?>
                   <a class="btn my_bl fl" id="change_account_bt" href="javascript:;" onclick="change_account()" style="margin-bottom: 10px;width: 80%;">계좌등록하기</a>
                 <?php } else if($user['m_verifyaccountuse']=="N"){ ?>
                   <div class="clearfix" style="text-align:center;">
                    <a class="btn my_bl" id="change_account_bt" href="javascript:;" onclick="change_account()" style="margin-bottom: 10px;width: 80%;display:none;">계좌변경하기</a>
                  </div>
                  <div id="confirmdiv">
    								<a class="btn my_bl fl" onClick="verifyaccnt('ARS')">ARS 계좌검증</a>
    								<a class="btn my_gr fr" onClick="verifyaccnt('SMS')">SMS 계좌검증</a>
                  </div>
                  <?php } else { ?>
                    <div class="clearfix" style="width:100%;text-align:center">
                      <a class="btn my_bl fl" id="change_account_bt" href="javascript:;" onclick="change_account()" style="margin-bottom: 10px;width: 80%;display:none;">계좌변경하기</a>
                    </div>
                  <?php } ?>
                <?php } ?>
							</li>
						</ul>
						</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="ajaxdiv" style="display:none"></div>

<script>
var preauthsts;
var preauthmsg='';

function changed() {
  $("#change_account_bt").show();
  $("#confirmdiv").hide();
}
function verifyaccnt(authType) {
  var url = "/pnpinvest/?up=verifyaccount";
  $.get(url,{authType:authType},  function(data) { $("#ajaxdiv").html(data) });
}
function change_account() {
  if($("select[name=m_my_bankcode]").val().trim()==''){
    alert("은행을 선택해주세요");return;
  }
  if($("input[name=m_my_bankacc]").val().trim()==''){
    alert("계좌번호를 입력해주세요");return;
  }
  if($("input[name=m_my_bankname]").val().trim()==''){
    alert("계좌주명을 입력해주세요");return;
  }
  if( $("select[name=m_my_bankcode]").data('val') != $("select[name=m_my_bankcode]").val()  ) console.log("true");
  else if( $("input[name=m_my_bankacc]").data('val') !=$("input[name=m_my_bankacc]").val().trim() ) console.log("true");
  else if( $("input[name=m_my_bankname]").data('val') !=$("input[name=m_my_bankname]").val().trim() ) console.log("true");
  else {
    alert("변경된 내용이 없습니다.");return;
  }

  url='/api/index.php/newhomeapi/changeaccnt';
  $.ajax({
    url:url,
    type : 'POST',
    data:$("form[name=accountform]").serialize(),
    dataType : 'json',
     success : function(result) {
       if(result.code==200){
         alert("계좌등록을 하였습니다.\n 계좌 검증을 진행해주세요");
         location.reload();
       }else {
         alert(result.msg);
       }
     },
     error: function(request, status, error) {
       console.log(request + "/" + status + "/" + error);
       alert("에러가 발생하였습니다.\n 잠시후에 다시시도해주세요");
     }
  });

}
function accconfirm(ctype){
  ;
}


function preauthstatus(checked){
	$.ajax({
		type : 'GET',
		url : '/api/index.php/newhomeapi/preauthcheck',
		dataType : 'json',
		success : function(result) {
			if(result.code==200){
				$("#preauthbtn").text('90일 선인증 등록 해지');
        $("#preauthbtn").removeClass('my_bl').addClass('my_gr');
				preauthsts = 200;
				preauthmsg = "90일 선인증 등록이 완료된 상태입니다.\n등록을 해지하시겠습니까?";
				$("#preauthbtn").closest("div").show();
        if(checked) {
          if(confirm(preauthmsg)){
            preauthcancel();
          }
        }
			}else if(result.code==400) {
				preauthsts = 400;
				$("#preauthbtn").text('90일 선인증 등록');
        $("#preauthbtn").removeClass('my_gr').addClass('my_bl');
				preauthmsg = "90일 선인증 등록을 하시겠습니까?\n선인증등록을 해놓으시면\n투자시 문자를 통한 인증코드 재전송없이\n바로 투자하실 수 있습니다.";
				$("#preauthbtn").closest("div").show();
        if(checked) {
          if(confirm(preauthmsg)){
            preauthreg();
          }
        }
			} else if(result.code > 200 && result.code < 400) {
				$("#preauthbtn").text('선인증 등록 요청 중');
        $("#preauthbtn").removeClass('my_bl').addClass('my_gr');
				preauthsts = result.code;
				preauthmsg = "선인증 등록 요청 중";
				$("#preauthbtn").closest("div").show();
        if(checked) alert("선인증 동록 요청을 하였습니다.\n휴대폰에 수신된 메세지를 확인해주세요")
			}else {
				preauthsts = 500;
        $("#preauthbtn").text('90일 선인증여부 확인하기');
        if(checked){
          alert(result.msg);
        }
			}
		}
	});
}
function preauthreg() {
	$.ajax({
		type : 'GET',
		url : '/api/index.php/seyfert/preauth',
		dataType : 'json',
		success : function(result) {
			if(result.code==201){
				preauthsts=201;
				$("#preauthbtn").text('선인증 등록 요청 중');
			}else alert(result.msg);
		}
	});
}
function preauthcancel() {
	$.ajax({
		type : 'GET',
		url : '/api/index.php/seyfert/preauthcancel',
		dataType : 'json',
		success : function(result) {
			if(result.code==200){
				preauthsts=5;
				$("#preauthbtn").text('해지요청완료');
			}else alert(result.msg);
		}
	});
}
function getpreauth() {
	if(preauthsts==200){
		if(confirm(preauthmsg)){
			preauthcancel();
		}
	}else if (preauthsts==400){
		if(confirm(preauthmsg)){
			preauthreg();
		}
	}else if(preauthsts>200 && preauthsts < 400) {
		alert('90일 선인증 등록 요청을 하였습니다.\n문자메세지를 받으시면 인증코드를 확인 후\n받으신 전화번호로 인증코드를 보내주시고\n잠시 후에 새로 고침 해주세요.');
	} else if (preauthsts == 5){
		alert("해지요청을 하였습니다.\n잠시 후에 새로 고침 해주세요");
	}
	else alert("잠시후에 다시 시도해 주세요");
}



$(function () {
  var loading = $("#ajaxloading");
  $(document).ajaxStart(function () {
      loading.show();
  });
  $(document).ajaxStop(function () {
      loading.hide();
  });

  preauthstatus(false);
});
</script>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
