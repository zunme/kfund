
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="/api/statics/pbtouchslicer/css/style.css">
<link rel="stylesheet" type="text/css" href="/api/statics/pbtouchslicer/icons/entypo.css">
<style>
.o-slider-textWrap{bottom:5px;}
.o-sliderContainer{ margin: 15px 0 ;}
.a-container{text-align: center;}
</style>
</head>
<body>

<div class='o-sliderContainer' id="pbSliderWrap0" style="margin-top:0;">
  <div class='o-slider' id='pbSlider0'>

<?php foreach($data as $row){ ?>

    <div class="o-slider--item" data-image="/pnpinvest/data/file/<?php echo $row['loanid']?>/gallery/<?php echo $row['file_name']?>">
      <div class="o-slider-textWrap">
        <!--h1 class="o-slider-title">This is a title</h1>
        <span class="a-divider"></span-->
        <h2 class="o-slider-subTitle"><?php $fileNameWithoutExt = substr($row['client_name'], 0, strrpos($row['client_name'], "."));echo $fileNameWithoutExt;?></h2>
        <span class="a-divider"></span>
        <!--p class="o-slider-paragraph">
        This is a sub paragraph This is a sub paragraph This is a sub paragraph This is a sub paragraph This is a sub paragraph This is a sub paragraph This is a sub paragraph
        </p-->
      </div>
    </div>

<?php } ?>

  </div>
</div>
<footer class="a-footer">
  <div class="a-container"> <?php echo $info['i_subject']?></div>
</footer>
<script src="/api/statics/pbtouchslicer/js/jquery-3.2.0.min.js"></script>
<script src='/api/statics/pbtouchslicer/js/hammer.min.js'></script>
<script src='/api/statics/pbtouchslicer/js/slider.js'></script>
<script>
$('#pbSlider0').pbTouchSlider({
  slider_Wrap: '#pbSliderWrap0',
  slider_Item_Width : 100,
  slider_Threshold: 10,
  slider_Speed:600,
  slider_Ease:'ease-out',
  slider_Drag : true,
  slider_Arrows: {
    enabled : true
  },
  slider_Dots: {
    class :'.o-slider-pagination',
    enabled : true,
    preview : true
  },
  slider_Breakpoints: {
      default: {
          height: 500
      },
      tablet: {
          height: 350,
          media: 1024
      },
      smartphone: {
          height: 250,
          media: 768
      }
  }
});

</script>
</body>
</html>
