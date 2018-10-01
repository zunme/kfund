<!doctype html>
<html lang="en">
  <head>
    <title></title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Cache-Control" content="no-chache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
  </head>
  <body>
    <script>
    <?php
    if(isset($msg) && $msg!="" ) {?>
      alert ("<?php echo $msg;?>");
    <?php }
    if(isset($url) && $url!="" ) {?>
      location.replace("<?php echo $url;?>");
    <?php } ?>
    </script>
  </body>
</html>
