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
/*
$curl_post['actiontype'] = 'change';
$ch = curl_init(); //curl 사용 전 초기화 필수(curl handle)

curl_setopt($ch, CURLOPT_URL, "https://www.kfunding.co.kr/api/index.php/nice?usecode=true"); //URL 지정하기
curl_setopt($ch, CURLOPT_POST, 1); //0이 default 값이며 POST 통신을 위해 1로 설정해야 함
curl_setopt ($ch, CURLOPT_POSTFIELDS, $curl_post); //POST로 보낼 데이터 지정하기
curl_setopt ($ch, CURLOPT_POSTFIELDSIZE, 0); //이 값을 0으로 해야 알아서 &post_data 크기를 측정하는듯
//curl_setopt($ch, CURLOPT_HTTPHEADER, $header_data); //header 지정하기
curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); ////이 옵션이 0으로 지정되면 curl_exec의 결과값을 브라우저에 바로 보여줌. 이 값을 1로 하면 결과값을 return하게 되어 변수에 저장 가능(테스트 시 기본값은 1인듯?)
$res = curl_exec ($ch);
if( $res===false ) $curlerror = curl_error($ch);
curl_close($ch);
$decodeform = json_decode($res, true);
*/
$sitecode = "BH481";
$sitepasswd = "eAlGvup5Gp7W";
$authtype = "M`";      		// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 카드
$popgubun 	= "N";			// Y : 취소버튼 있음 / N : 취소버튼 없음
$customize 	= "Mobile";			// 없으면 기본 웹페이지 / Mobile : 모바일페이지
$gender = "";      			// 없으면 기본 선택화면, 0: 여자, 1: 남자
$reqseq = get_cprequest_no($sitecode);
$_SESSION["REQ_SEQ"] = $reqseq;

$rtnhost =(($_SERVER['HTTPS'] != "on") ? "http://" : "https://" ).$_SERVER['HTTP_HOST'];
//$returnurl = DEFAULT_URL."/pnpinvest/?mode=join03";	// 성공시 이동될 URL
//$returnurl = $rtnhost."/api/nice/join";	// 성공시 이동될 URL
$returnurl          = "https://www.kfunding.co.kr/api/index.php/nice/authed";
$errorurl           = "https://www.kfunding.co.kr/api/index.php/nice/authederr";

$plaindata = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq .
     "8:SITECODE" . strlen($sitecode) . ":" . $sitecode .
     "9:AUTH_TYPE" . strlen($authtype) . ":". $authtype .
     "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl .
     "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl .
     "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun .
     "9:CUSTOMIZE" . strlen($customize) . ":" . $customize .
     "6:GENDER" . strlen($gender) . ":" . $gender ;
$enc_data = get_encode_data($sitecode, $sitepasswd, $plaindata);


include (getcwd().'/module/basic.php');

$getMemberlimit = getMemberlimit($user['m_id']);
$sql = " select ifnull(authed,'N') authed from mari_member_auth where fk_mari_member_m_no = ".(int)$user['m_no'];
$row = sql_fetch($sql,false);
$memberauthed = ( !isset($row['authed']) && $row['authed'] !='Y') ? 'N' :'Y';

$hp1 = substr($user['m_hp'],0,3);
$hp2 = substr($user['m_hp'],3,-4);
$hp3 = substr($user['m_hp'],-4,4);
$birth = explode('-',$user['m_birth']);
$m_reginum1=$m_reginum2='';
if (ereg('^[[:digit:]]{6}[1-4][[:digit:]]{6}$', $user['m_reginum'])) {
  $m_reginum1 = substr($user['m_reginum'],0,6);
  $m_reginum2 = substr($user['m_reginum'],-7,7);
}
?>
{# new_header}
<script src="/pnpinvest/js/jQuery-File-Upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="/assets/blueimp/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="/assets/blueimp/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-video.js"></script>
<script src="/pnpinvest/js/jQuery-File-Upload/js/jquery.fileupload-validate.js"></script>

<style>
.folder .tt {
    font-size: 18px;
    font-weight: 500;
}
.folder .tt {
    font-size: 100%;
    /* padding-left: 5px; */
}
</style>

<style>
.list_con > li {
    margin-top: 10px;
  }
.list_con > form > li {
    border-bottom: 1px solid #bdbdbd;
}
.list_con > form > li > .input_wrap {
    position: relative;
    line-height: 44px;
    min-height: 44px;
    padding-left: 100px;
	margin:5px 0;
}
.list_con > form > li > .input_wrap .tt {
    position: absolute;
    top: 0;
    left: 0;
    color: #636363;
    padding-left: 5px;
}
.form_wrap .address .btn {
    height: auto;
    line-height: normal;
}
.mypage .my_content .btn.my_gr {
    width: 100%;
}
.folder .tt {
    font-size: 100%;
    padding-left: 5px;
}
.list_con > li > .input_wrap .tt {
    font-size: 14px;
    font-weight: 500;
}
.list_con > li > .input_wrap .tt {
    font-size: 14px;
    font-weight: 500;
}
.my_modify .f18 {
    font-size: 16px;
}
.folder .tt {
    font-size: 14px;
    font-weight: 500;
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
				<div class="my_modify clearfix">
					<div class="title clearfix">
						<h3 class="fl">회원정보수정</h3>
						<p class="btn_mytab_wrap">
							<label for="mytab01" class="btn_mytab active">정보 변경&middot;수정</label>
							<label for="mytab02" class="btn_mytab">회원탈퇴</label>
						</p>
					</div>
					<div class="mytab">
						<input id="mytab01" type="radio" class="blind" name="mytab" title="정보 변경 및 수정 내용 보기" checked>
						<input id="mytab02" type="radio" class="blind" name="mytab" title="회원탈퇴 내용 보기">
						<!-- 입출금 관리 start -->
						<div class="mytab_con">
							<div class="my_left">

								<fieldset>
									<h4>개인 정보 수정</h4>
									<ul class="list_con">
										<li>
											<p class="input_wrap">
												<span class="tt">투자자 구분</span>
												<span class="t_gr f18"><?php echo $getMemberlimit['invest_flag']?></span>
											</p>
										</li>									<li class="folder">
											<p class="tt">서류 등록 </p>


											<!-- 개인회원 -->
<?php if( $user['m_level'] < 3 ) { ?>
											<ul class="fd_list clearfix">
												<li class="fd_bl">
												종합소득<br>신고서
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
													<input id="file1" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_01"}'>
                          <?php if ($user['m_declaration_01']=='') { ?>
                            <label for="file1" class="con_none">미등록</label>
                          <?php } else { ?>
                            <label for="file1" class="con_check">등록완료</label>
                          <?php } ?>
                        <?php } else {?>
                          <label for="file1" class="con_lock">수정불가</label>
                        <?php } ?>
												</li>
												<li class="fd_rd">
													근로소득<br>원천징수 영수증
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file2" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_02"}'>
                            <?php if ($user['m_declaration_02']=='') { ?>
                              <label for="file2" class="con_none">미등록</label>
                            <?php } else { ?>
                              <label for="file2" class="con_check">등록완료</label>
                            <?php } ?>
                          <?php } else {?>
                            <label for="file2" class="con_lock">수정불가</label>
                          <?php } ?>
												</li>
												<li class="fd_gr">
													전문업자<br>확인증
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file3" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_evidence"}'>
                            <?php if ($user['m_evidence']=='') { ?>
                              <label for="file3" class="con_none">미등록</label>
                            <?php } else { ?>
                              <label for="file3" class="con_check">등록완료</label>
                            <?php } ?>
                          <?php } else {?>
                            <label for="file3" class="con_lock">수정불가</label>
                          <?php } ?>
                        </li>
												<li class="fd_yl">
													대부업자<br>등록증
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file4" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_bill"}'>
                            <?php if ($user['m_bill']=='') { ?>
                              <label for="file4" class="con_none">미등록</label>
                            <?php } else { ?>
                              <label for="file4" class="con_check">등록완료</label>
                            <?php } ?>
                          <?php } else {?>
                            <label for="file4" class="con_lock">수정불가</label>
                          <?php } ?>
												</li>
											</ul>
<?php } else { ?>
											<!-- 법인회원 -->
											<ul class="fd_list clearfix">
                        <li class="fd_bl">
                          사업자<br>등록증
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file1" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_01"}'>
                          <?php if ($user['m_declaration_01']=='') { ?>
                            <label for="file1" class="con_none">미등록</label>
                          <?php } else { ?>
                            <label for="file1" class="con_check">등록완료</label>
                          <?php } ?>
                        <?php } else {?>
                          <label for="file1" class="con_lock">수정불가</label>
                        <?php } ?>
                        </li>
                        <li class="fd_rd">
                          사업주<br>신분증
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file2" type="file" class="file fileupload" name="userfile" data-form-data='{"ind": "m_declaration_02"}'>
                            <?php if ($user['m_declaration_02']=='') { ?>
                              <label for="file2" class="con_none">미등록</label>
                            <?php } else { ?>
                              <label for="file2" class="con_check">등록완료</label>
                            <?php } ?>
                          <?php } else {?>
                            <label for="file2" class="con_lock">수정불가</label>
                          <?php } ?>
                        </li>
                        <li class="fd_gr">
													법인통장<br>사본
                          <?php
                            if( $memberauthed == 'N'){
                          ?>
                          <input id="file4" type="file" class="file fileupload" name="userfile"  data-form-data='{"ind": "m_bill"}'>
                            <?php if ($user['m_bill']=='') { ?>
                              <label for="file4" class="con_none">미등록</label>
                            <?php } else { ?>
                              <label for="file4" class="con_check">등록완료</label>
                            <?php } ?>
                          <?php } else {?>
                            <label for="file4" class="con_lock">수정불가</label>
                          <?php } ?>
												</li>
											</ul>
<?php } ?>
											<p class="fd_type right">
												(<span class="fd_none">미등록</span>/<span class="fd_check">등록완료</span>/<span class="fd_lock">수정불가</span>)
											</p>
										</li>

                    <script>
                    /*jslint unparam: true */
                    /*global window, $ */

                    $(function () {
                        'use strict';
                        // Change this to the location of your server-side upload handler:
                        var url = '/api/index.php/newhomeapi/officefile/';
                        var loading = $("#ajaxloading");
                        $(document).ajaxStart(function () {
                            loading.show();
                        });
                        $(document).ajaxStop(function () {
                            loading.hide();
                        });

                            $('.fileupload').fileupload({
                                url: url,
                                dataType: 'json',
                                autoUpload: true,
                                acceptFileTypes: /(\.|\/)(gif|jpe?g|png|pdf)$/i,
                                maxFileSize: 999000,
                                // Enable image resizing, except for Android and Opera,
                                // which actually support image resizing, but fail to
                                // send Blob objects via XHR requests:
                                disableImageResize: /Android(?!.*Chrome)|Opera/
                                    .test(window.navigator.userAgent),
                                previewMaxWidth: 100,
                                previewMaxHeight: 100,
                                previewCrop: true
                            }).on('fileuploadadd', function (e, data) {
                                data.context = $('<div/>').appendTo('#files');
                            }).on('fileuploadprocessalways', function (e, data) {
                                var index = data.index,
                                    file = data.files[index],
                                    node = $(data.context.children()[index]);
                                if (file.error) {
                                    alert(file.error);
                                }

                            }).on('fileuploadprogressall', function (e, data) {
                              console.log('fileuploadprogressall');
                            }).on('fileuploaddone', function (e, data) {
                                $.each(data.result.files, function (index, file) {
                                    if (file.error) {
                                        console.log(file.error);
                                    }else {
                                      var inputid = data.fileInput.context.getAttribute('id');
                                      $("#"+inputid).parent().children("label").addClass('con_check');
                                      $("#"+inputid).parent().children("label").removeClass('con_none');
                                      alert("서류를 등록하였습니다.");
                                    }
                                });
                            }).on('fileuploadfail', function (e, data) {
                              console.log('fileuploadfail');

                            }).prop('disabled', !$.support.fileInput)
                                .parent().addClass($.support.fileInput ? undefined : 'disabled');

                    });
                    </script>

										<li>
											<p class="input_wrap">
												<span class="tt">이름</span>
												<span class="t_gr f18"><?php echo $user['m_name']?></span>
											</p>
										</li>
										<li>
											<p class="input_wrap">
												<span class="tt">이메일(아이디)</span>
												<span class="t_gr"><?php echo $user['m_id']?></span>
											</p>
										</li>
                    <form name="form_chk" method="post">
                      <input type="hidden" name="m" value="checkplusSerivce">
                      <input type="hidden" name="EncodeData" value="<?php echo $enc_data?>">
                      <input type="hidden" name="param_r1" value="<?php echo $decodeform['param'] ?>">
                    </form>
                    <script type="text/javascript">
                    	function nicefnPopup(){
                    		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                    		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
                    		document.form_chk.target = "popupChk";
                    		document.form_chk.submit();
                    	}
                    </script>

                    <form class="form_wrap" name="form_base">
										<li>
											<div class="input_wrap">
												<span class="tt">휴대폰 번호</span>
												<div>
													<p class="tel clearfix">
														<select class="select t3 fl" id="loan_phone2" name="hp1" title="번호 선택" readonly>
                              <option><?php echo $hp1;?></option>
                              <!--
															<option value="선택">선택</option>
															<option value="010" <?php echo ($hp1 == '010') ?"selected":"" ?> >010</option>
															<option value="011" <?php echo ($hp1 == '011') ?"selected":"" ?> >011</option>
															<option value="016" <?php echo ($hp1 == '016') ?"selected":"" ?> >016</option>
                            -->
														</select>
														<input class="input t1 fl" type="text" name="hp2" title="휴대폰 번호 중간 4자리" value="<?php echo $hp2;?>" readonly>
                            <input class="input t1 w3 mr20 fl" name="hp3" type="text" title="휴대폰 번호 마지막 4자리" value="<?php echo $hp3;?>" readonly><br>
														<a href="javascript:;" class="btn my_gr btn-lite-green" style="background-color: #028d9a;border-color: #028d9a;" onClick="nicefnPopup()">휴대폰번호 변경하기</a>
													</p>
													<!--p class="check_number clearfix">
														<input type="text" class="fl"  name="authnum" placeholder="수신된 인증번호를 입력해주세요.">
														<a href="javascript:;" onclick="checkauth()" class="btn my_gr fl">확인</a>
													</p-->


												</div>
											</div>
										</li>
										<li>
											<div class="input_wrap">
												<span class="tt">생년월일</span>
												<p class="birth clearfix">
													<select class="select t3 fl" id="loan_phone2" name="birth1" title="년도 선택">
														<option value="선택">선택</option>
                            <?php for ($i = date('Y'); $i>=1900; $i--){ ?>
														<option value="<?php echo $i?>" <?php echo ( $i == $birth[0] ) ? 'selected="selected"': ''; ?> ><?php echo $i?></option>
                          <?php } ?>
													</select>
													<span class="fl">년&nbsp;</span>
													<input class="input t1 fl" name="birth2" type="text" title="월" value="<?php echo (isset($birth[1])) ? $birth[1]:'';?>">
													<span class="fl">월&nbsp;</span>
													<input class="input t1 fl" name="birth3" type="text" title="일" value="<?php echo (isset($birth[2])) ? $birth[2]:'';?>">
													<span class="fl">일</span>
												</p>
											</div>
										</li>
                    <style>
.radiobox.radiobox3 input[type=checkbox]:checked + label:after {
  top: 6px;
  left: 3px;
}
                    </style>
										<li>
											<div class="input_wrap">
												<span class="tt">투자알림 설정</span>
												<p class="radiobox radiobox3" style="padding-top: 12px">
													<input id="smsalarm" type="checkbox" name="m_sms" value="1" <?php echo ($user['m_sms']=='1') ? 'checked="checked"': '';?>>
													<label for="smsalarm" style="line-height:20px;">SMS 투자 알림 받기</label>
												</p>
											</div>
										</li>

                    								</form>
									</ul>
									<p class="center">
										<a href="javascript:;" onClick="formbase()" class="btn my_gr submit" >확인</a>
									</p>
								</fieldset>

							</div>
              <style>
              input.t1{
                border: 1px solid #ccc;
    color: #333;
    padding: 0 6px;
    height: 34px;
    line-height: 34px;
	width:100%;
              }
			                input.t2{
                border: 1px solid #ccc;
    color: #333;
    padding: 0 6px;
    height: 34px;
    line-height: 34px;
	width:47%;

              </style>
							<div class="my_right">
								<form class="form_wrap" name="form_pw">
								<fieldset>
									<h4>비밀번호 변경</h4>
									<ul class="list_con">
										<li>
											<p class="input_wrap pdl120">
												<label for="pass1" class="tt">기존 비밀번호</label>
												<input id="pass1" type="password" class="input t1" name="old_pw1">
											</p>
										</li>
										<li>
											<p class="input_wrap pdl120">
												<label for="pass2" class="tt">새비밀번호</label>
												<input id="pass2" type="password" class="input t1" name="old_pw2">
											</p>
										</li>
										<li>
											<p class="input_wrap pdl120">
												<label for="pass3" class="tt">새비밀번호 확인</label>
												<input id="pass3" type="password" class="input t1" name="new_pw">
											</p>
										</li>
									</ul>
									<p class="center">
										<a href="javascript:;" onClick="formpw()" class="btn my_gr submit" style="margin-bottom: 18px;">확인</a>
									</p>
								</fieldset>
								</form>
								<form class="form_wrap" name="form_withdraw" style="margin-top:30px;">
								<fieldset>
									<h4>원천징수정보</h4>
									<ul class="list_con">
										<li>
											<ul class="list_dot">
												<li>원천징수정보를 등록하셔야 투자가 가능합니다.<br>
													<div class="exp">
														<button type="button" class="exp_btn"><img src="img/icon_exp.png" alt="설명보기"></button>
														왜 주민등록번호를 입력해야 할까요?
														<p class="exp_con">입력하신 주민등록번호와 주소는 원천징수시 사용됩니다. 원천징수랑, 투자수익이 발생했을 시 투자자가 부담해야 할  세액을 ‘플랫폼사이트’가 국가를 대신해 미리 징수하고 투자자의 소득정보를 신고하는 것을 말합니다. 정보를 입력해야 투자가 가능합니다. </p>
													</div>
												</li>
											</ul>
										</li>
										<li>
											<p class="input_wrap s_num clearfix">
												<span class="tt">주민등록번호</span>
												<input id="s_num1" name="m_reginum1" type="text" class="input t1" style="margin-top:0px;" value="<?php echo $m_reginum1?>" title="주민등록번호 앞자리">
												<span class="dash">-</span>
												<input id="s_num2" name="m_reginum2" type="password" class="input t2" value="<?php echo $m_reginum2?>" title="주민등록번호 뒷자리">
											</p>
										</li>
										<li>
											<div class="input_wrap address" style="margin-bottom: 10px;">
												<span class="tt">주소</span>
												<p class="clearfix">
													<input id="sample4_postcode" name="m_with_zip" value="<?php echo $user['m_with_zip']?>" type="text" class="zip input t1 fl" style="padding-top: 1px;height:38px;padding-bottom: 1px;" title="우편번호" onClick="sample4_execDaumPostcode()()" readonly>
													<a href="javascript:;" onClick="sample4_execDaumPostcode()()" class="btn my_gr zip fr btn-lite-green" style="background-color: #028d9a;border-color: #028d9a;line-height:14px;">우편번호 확인</a>
												  <input id="sample4_jibunAddress" name="m_with_addr1" value="<?php echo $user['m_with_addr1']?>" type="text" class="input t3" title="주소입력"  style="margin-bottom:5px;"onClick="sample4_execDaumPostcode()()" readonly>
                          <input id="sample4_detailAddress" name="m_with_addr2" value="<?php echo $user['m_with_addr2']?>" type="text" class="input t1" title="상세주소" placeholder="상세주소">
												</p>
											</div>
										</li>
									</ul>
									<p class="center">
										<a href="javascript:;" onClick="formwithdraw()" class="btn my_gr submit">확인</a>
									</p>
								</fieldset>
								</form>
							</div>
						</div>
						<!-- // 입출금 관리 end -->
						<!-- 입출금 관리 start -->
						<div class="mytab_con my_breakdown">
							<h4 class="blind">회원탈퇴</h4>

                <form name="member_out" method="post" class="form_wrap" enctype="multipart/form-data">
								<input type="hidden" name="m_no" value="<?php echo $user['m_no']?>">
								<input type="hidden" name="m_id" value="<?php echo $user['m_id']?>">
								<input type="hidden" name="type" value="d">

							<fieldset>
								<div class="withdraw">
									<p class="tt">아래 사항을 꼼꼼히 읽어보신 후 회원 탈퇴를 진행해주세요.</p>
									<ul class="list_dot">
										<li>회원 탈퇴 후에는 서비스 이용이 불가합니다.</li>
										<li>대출 또는 투자 진행 시 탈퇴가 불가합니다.</li>
										<li>회원 탈퇴 시 현재 접속 중인 아이디는 즉시 탈퇴 처리 됩니다.</li>
										<li>투자, 대출 이용 기록은 탈퇴 후 3개월 뒤 전부 삭제 됩니다.</li>
										<li>회원 정보 및 서비스 이용 기록은 탈퇴 후 즉시 삭제 되며, 삭제된 정보는 복구되지 않습니다.</li>
									</ul>
									<p class="radiobox radiobox3">
										<input id="withdraw_agree" type="checkbox" name="agreement" value="OK">

										<label for="withdraw_agree">위 사항을 모두 확인했으며, 이에 동의합니다.</label>

									</p>
									<p class="center last"><a href="javascript:;" onClick="drawmem() " class="btn my_gr">확인</a></p>
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
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script><script charset="UTF-8" type="text/javascript" src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>

<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_jibunAddress').value = fullRoadAddr;
                //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
                document.getElementById('sample4_detailAddress').focus();
            }
        }).open();
    }
</script>

<script>
/*
  $('.my_modify .tel .btn').click(function(){
    $(this).hide();
    $('.my_modify .check_number').show();
  });
*/
function getauth() {
  console.log("a");
}
function checkauth() {
  console.log("a");
}
function drawmem() {
  if(!$('#withdraw_agree').is(':checked')){alert('동의란에 체크를 해주시기 바립니다.'); return false;}

  if(confirm("정말 탈퇴처리 하시겠습니까? 탈퇴 후에는 해당 회원의 모든 정보가 삭제되오니 주의하시기 바랍니다.")){
    var f = document.member_out;
    f.method = 'post';
    f.action = '/pnpinvest/?up=leave';
    f.submit();
  }
}
function formbase() {
  if(confirm('생년월일/투자일림설정을 수정하시겠습니까?'))
    {
      $.ajax({
           type : "POST",
           dataType : "json",
           url : "/api/index.php/newhomeapi/modifybase",
           data : $("form[name=form_base]").serialize(),
           success : function(result) {
             if(result.code==200){
              alert ( result.msg );
             }else {
               alert ( result.msg );
             }
           },
           error : function(e) {
                  alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
           }
    });
  }
}

function formpw() {
  if(confirm('비밀번호를 변경하시겠습니까?'))
    {
      $.ajax({
           type : "POST",
           dataType : "json",
           url : "/api/index.php/newhomeapi/modifypw",
           data : $("form[name=form_pw]").serialize(),
           success : function(result) {
             if(result.code==200){
               $("input[name=old_pw1]").val('');
               $("input[name=old_pw2]").val('');
               $("input[name=new_pw]").val('');
              alert ( result.msg );
            }else {
              $("input[name=old_pw1]").focus();
               alert ( result.msg );
               if(result.code==501){
                 $("input[name=old_pw1]").focus();
               }else if (result.code==502){
                 $("input[name=old_pw2]").focus();
               }else if (result.code==503){
                 $("input[name=new_pw]").focus();
               }else if (result.code==504){
                 $("input[name=old_pw1]").focus();
               }else if (result.code==505){
                 $("input[name=old_pw2]").val('');
                 $("input[name=new_pw]").val('');
                 $("input[name=old_pw2]").focus();
               }
             }
           },
           error : function(e) {
                  alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
           }
    });
  }
}
function formwithdraw() {
  $.ajax({
       type : "POST",
       dataType : "json",
       url : "/api/index.php/newhomeapi/modifywithdraw",
       data : $("form[name=form_withdraw]").serialize(),
       success : function(result) {
         if(result.code==200){
          alert ( result.msg );
         }else {
           alert ( result.msg );
         }
       },
       error : function(e) {
              alert('서버 연결 도중 에러가 났습니다. 다시 시도해 주십시오.');
       }
});
}

</script>
{# new_footer}
