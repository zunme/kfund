<a href="javascript:;" onClick="nicefnPopup()" class="hidden_href nicebutton" data-mid="<?php echo $this->userid ?>">핸드폰인증하기</a>
<form name="form_chk" method="post">
  <input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
  <input type="hidden" name="EncodeData" value="<?= $enc_data ?>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
       해당 파라미터는 추가하실 수 없습니다. -->
  <input type="hidden" name="param_r1" value="<?php echo $param?>">
</form>
<script type="text/javascript">

// 본인인증
<?php if( $returnMsg !='' ){ ?>
  function nicefnPopup(){
    alert('<?php echo $returnMsg?>');
  }
<?php }else { ?>
	function nicefnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
<?php } ?>
</script>
