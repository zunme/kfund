<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko"><head><title>인증</title><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes"><head><body>
<script>
<?php if( isset($alertmsg) && $alertmsg !='') { ?>
  alert("<?php echo $alertmsg?>");
<?php } ?>
<?php if( isset($reload) && $reload == true) { ?>
  window.opener.location.reload(false);
<?php } ?>
<?php if( isset($url) && $url !='') { ?>
  window.opener.location.replace("<?php echo $url?>");
<?php } ?>

self.close();
</script>
</body></html>
