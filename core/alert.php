<?php
global $lo_location;
global $lo_url;


$msg2 = str_replace("\\n", "<br>", $msg);

if (!$url) $url = $_SERVER['HTTP_REFERER'];

if($error) {
    $header2 = "다음 항목에 오류가 있습니다.";
} else {
    $header2 = "다음 내용을 확인해 주세요.";
}
?>

<script>
alert("<?php echo strip_tags($msg); ?>");
//document.location.href = "<?php echo $url; ?>";
<?php if ($url) { ?>
document.location.replace("<?php echo $url; ?>");
<?php } else { ?>
//alert('history.back();');
history.back();
<?php } ?>
</script>

<noscript>
<div id="validation_check">
    <h1><?php echo $header2 ?></h1>
    <p class="cbg">
        <?php echo $msg2 ?>
    </p>
    <?php if($post) { ?>
    <form method="post" action="<?php echo $url ?>">
    <?php
    foreach($_POST as $key => $value) {
        if(strlen($value) < 1)
            continue;

        if(preg_match("/pass|pwd|capt|url/", $key))
            continue;
    ?>
    <input type="hidden" name="<?php echo $key ?>" value="<?php echo $value ?>">
    <?php
    }
    ?>
    <input type="submit" value="돌아가기">
    </form>
    <?php } else { ?>
    <div class="btn_confirm">
        <a href="<?php echo $url ?>">돌아가기</a>
    </div>
    <?php } ?>
</div>
</noscript>
