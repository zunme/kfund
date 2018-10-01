<!doctype html>
<html lang="en">

<!-- Mirrored from demos.creative-tim.com/bs3/material-kit-pro/examples/product-page.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 16 Apr 2018 05:38:15 GMT -->
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title></title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="imagetoolbar" content="no">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<link rel="SHORTCUT ICON" href="">
	<meta name="keywords" content="" >
	<meta name="description" content=", " >

	<meta property="og:type" content="">
	<meta property="og:title" content="">
	<meta property="og:description" content=", ">
	<meta property="og:image" content="">
	<meta property="og:url" content="">
	<link rel="canonical" href="">

	<meta name="google-site-verification" content="" />

	<!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons|Pinyon+Script|Playball|Jua|Nanum+Gothic" />
	<link rel="stylesheet" href="/assets/font-awesome/latest/css/font-awesome.min.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
	<!-- CSS Files -->
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/assets/material-kit/assets/css/material-kit2.css?v=1.2.2" rel="stylesheet"/>
		<link href="/assets/owl/assets/owl.carousel.min.css" rel="stylesheet"/>
		<link href="/assets/owl/assets/owl.theme.default.min.css" rel="stylesheet"/>
		<link href="/assets/css/hover.min.css" rel="stylesheet" />
    <style>
.logoani{
  width:100%;
  height:100%;
}
.logostage{
  padding: 0;
  margin: 0;
  position: absolute;
  top : 20px;
  width: 500px;
  height: 250px;
}
.logostage * {
  font-family: 'Anton', sans-serif;
  padding: 0;
  margin: 0;
  position: absolute;
  width: 100%;
  height: 100%;
}
.textk{overflow:hidden}
    </style>
</head>
<body>

  <div class="row">
    <div class="col-xs-12">
      <div style="height:250px;background-color:red">
        <div class="logoani" id="stage2">

        </div>
      </div>
      </div>
    </div>
  </div>
<div class="row">
  <div class="col-xs-6" style="height:250px;background-color:blue">
    <div class="logoani" id="stage">

    </div>
  </div>
</div>

<!--  guide -->
<?php
$box_wrap = 420;
$box_shadow = 390;
$box_content = 310;
$rand = ($box_wrap - $box_shadow)/2;
$rand2 = 1;
?>
<style>
.z_box_wrap{height:600px; width:780px; position: relative;margin: 10px auto;}
.z_box {
	position: absolute;
	width: <?php echo $box_wrap;?>px;
	height: <?php echo $box_wrap;?>px;
	opacity: .92;
	filter: alpha(opacity=92);
}
.z_box.zbox1 {
	top: 100px;
	right : 20px;
}
.z_box.zbox2 {
	top: 260px;
	right : 180px;
}
.z_box.zbox3 {
	top: 420px;
	right : 340px;
}
.z_box_shadow{
		width: <?php echo $box_shadow;?>px;
    height: <?php echo $box_shadow;?>px;
    position: absolute;
		opacity: .20;
		filter: alpha(opacity=20);

}
.z_box.zbox1 .z_box_shadow{
		border:1px solid #13547a;
}
.z_box.zbox2 .z_box_shadow{
		border:1px solid #868f96;
}
.z_box.zbox3 .z_box_shadow{
		border:1px solid #667eea;
}

.z_box.zbox1 .z_box_content{
	background-color:#13547a;
}
.z_box.zbox2 .z_box_content{
	background-color:#868f96;
}
.z_box.zbox3 .z_box_content{
	background-color:#667eea;
}

.z_box_shadow.sa1{
	top: <?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2 ; ?>px ;
	left:<?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2  ; ?>px;
}
.z_box_shadow.sa2{
	top: <?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2 ; ?>px ;
	left:<?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2  ; ?>px;
}
.z_box_shadow.sa3{
	top: <?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2 ; ?>px ;
	left:<?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2  ; ?>px;
}
.z_box_shadow.sa4{
	top: <?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2 ; ?>px ;
	left:<?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2  ; ?>px;
}
.z_box_shadow.sa5{
	top: <?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2 ; ?>px ;
	left:<?php echo ($rand) - rand( ($rand/2 - $rand2)*-1 , ($rand/2 - $rand2) )*2  ; ?>px;
}

.z_box_shadow.sa1{
	top: 23px ;
	left:3px;
}
.z_box_shadow.sa2{
	top: 11px ;
	left:27px;
}
.z_box_shadow.sa3{
	top: 3px ;
	left:11px;
}
.z_box_shadow.sa4{
	top: 25px ;
	left:17px;
}
.z_box_shadow.sa5{
	top: 19px ;
	left:17px;
}

.z_box:hover .z_box_shadow.sa1
{
	opacity: 1;
	-webkit-transition: opacity 0.5s ease-in-out;
	-moz-transition: opacity 0.5s ease-in-out;
	transition: opacity 0.5s ease-in-out;
}
.z_box:hover .z_box_shadow.sa2
{
	opacity: 1;
	-webkit-transition: opacity 0.9s ease-in-out;
	-moz-transition: opacity 0.9s ease-in-out;
	transition: opacity 0.9s ease-in-out;
}
.z_box:hover .z_box_shadow.sa3
{
	opacity: 1;
	-webkit-transition: opacity 1s ease-in-out;
	-moz-transition: opacity 1s ease-in-out;
	transition: opacity 1s ease-in-out;
}
.z_box:hover .z_box_shadow.sa4
{
	opacity: 1;
	-webkit-transition: opacity 0.1s ease-in-out;
	-moz-transition: opacity 0.1s ease-in-out;
	transition: opacity 0.1s ease-in-out;
}
.z_box:hover .z_box_shadow.sa5
{
	opacity: 1;
	-webkit-transition: opacity 1.5s ease-in-out;
	-moz-transition: opacity 1.5s ease-in-out;
	transition: opacity 1.5s ease-in-out;
}

.z_box_content{
		background-color: yellow;
    height: <?php echo $box_content;?>px;
    width: <?php echo $box_content;?>px;
    position: absolute;
		top: <?php echo ($box_wrap - $box_content)/2;?>px;
		left:<?php echo ($box_wrap - $box_content)/2;?>px;
}
.boxlabel{
	display: inline-block;
	position: absolute;
	top: 20px;
	right: -19px;
	width: 130px;
	/* height: 40px; */
	background-color: #a7a722;
	box-shadow: 0 2px 2px 0 rgba(6, 108, 132, 0.14), 0 3px 1px -2px rgba(6, 108, 132, 0.14), 0 1px 5px 0 rgba(6, 108, 132, 0.14);
	text-align: center;
	padding: 8px 0;
	font-size: 18px;
}
.zbox1 .boxlabel{
	background-color: #a7a722;
}

.z_box:hover{
	z-index:100;
	opacity: 1;
	-webkit-transition: opacity 0.9s ease-in-out;
	-moz-transition: opacity 0.9s ease-in-out;
	transition: opacity 0.9s ease-in-out;
}
.z_box:hover .boxlabel
{
	width: 350px;
	transition: width 1s  ease-in-out;
}
</style>
<div>
	<div>
		<div class="z_box_wrap">
			<div class="z_box zbox1">
				<div class="z_box_inner">
					<div class="z_box_shadow sa1"></div>
					<div class="z_box_shadow sa2"></div>
					<div class="z_box_shadow sa3"></div>
					<div class="z_box_shadow sa4"></div>
					<div class="z_box_shadow sa5"></div>

					<div class="z_box_content">
						<div class="boxlabel">대출가이드	</div>
					</div>
				</div>
			</div>

			<div class="z_box zbox2">
				<div class="z_box_inner">
					<div class="z_box_shadow sa1"></div>
					<div class="z_box_shadow sa2"></div>
					<div class="z_box_shadow sa3"></div>
					<div class="z_box_shadow sa4"></div>
					<div class="z_box_shadow sa5"></div>

					<div class="z_box_content">
						<div class="boxlabel">대출가이드	</div>
					</div>
				</div>
			</div>

			<div class="z_box zbox3">
				<div class="z_box_inner">
					<div class="z_box_shadow sa1"></div>
					<div class="z_box_shadow sa2"></div>
					<div class="z_box_shadow sa3"></div>
					<div class="z_box_shadow sa4"></div>
					<div class="z_box_shadow sa5"></div>

					<div class="z_box_content">
						<div class="boxlabel">대출가이드	</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<!-- / guide -->

<section>
  <!--<h2 class="text-center">Scroll down the page a bit</h2><br><br> -->
<div class="container">
  <div class="row">
    <div class="col-md-2 col-lg-2"></div>
     <div class="col-md-8 col-lg-8">

<div class="barWrapper">
 <span class="progressText"><B>HTML5</B></span>
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" >
        <span  class="popOver" data-toggle="tooltip" data-placement="top" title="85%"> </span>
</div>
</div>

<div class="barWrapper">
 <span class="progressText"><B>CSS3</B></span>
<div class="progress ">
  <div class="progress-bar" role="progressbar" aria-valuenow="75" aria-valuemin="10" aria-valuemax="100" style="">
     <span  class="popOver" data-toggle="tooltip" data-placement="top" title="75%"> </span>
  </div>

</div>
</div>

<div class="barWrapper">
 <span class="progressText"><B>BOOTSTRAP</B></span>
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">
     <span  class="popOver" data-toggle="tooltip" data-placement="top" title="65%"> </span>
  </div>
</div>
</div>
<div class="barWrapper">
 <span class="progressText"><B>JQUERY</B></span>
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100">
         <span  class="popOver" data-toggle="tooltip" data-placement="top" title="55%"> </span>
  </div>
</div>
</div>
<div class="barWrapper">
 <span class="progressText"><B>MYSQL</B></span>
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100">
      <span  class="popOver" data-toggle="tooltip" data-placement="top" title="70%"> </span>
  </div>
</div>
</div>
  <div class="barWrapper">
 <span class="progressText"><B>PHP</B></span>
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
      <span  class="popOver" data-toggle="tooltip" data-placement="top" title="75%"> </span>
  </div>
</div>
</div>

</div>
     <div class="col-md-2 col-lg-2"></div>
    </div>
</div>
  </section>
	
    <script src='https://cdnjs.cloudflare.com/ajax/libs/animejs/1.0.0/anime.min.js'></script>
    <script src="/assets/js/jquery.min.js" type="text/javascript"></script>
    <script src="/assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/assets/js/material.min.js"></script>
    <script src="/assets/js/moment.min.js"></script>
    <script src="/assets/js/nouislider.min.js" type="text/javascript"></script>
    <script src="/assets/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="/assets/js/bootstrap-selectpicker.js" type="text/javascript"></script>
    <script src="/assets/js/bootstrap-tagsinput.js"></script>
    <script src="/assets/js/jasny-bootstrap.min.js"></script>
    <script src="/assets/js/jquery.flexisel.js"></script>
    <script  type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAFPQibxeDaLIUHsC6_KqDdFaUdhrbhZ3M"></script>
    <script src="/assets/material-kit/assets/js/material-kit2.js?v=1.2.2" type="text/javascript"></script>
    <script src="/assets/owl/owl.carousel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/noframework.waypoints.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/shortcuts/inview.min.js" type="text/javascript"></script>

<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/53148/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/53148/jquery.velocity.min.new.js" type="text/javascript"></script>
<link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet' type='text/css'>
<script>

var $stage;
var zwidth = 300;
var zfont = 50;
var zfontmargin = 10;
var zheight = 64;
var zheighttrance = 10
var mask_margin_left = -136;
/* Colors, prefix finder for transforms */
var Colors = {
 white: '#fefefe',
 blue: '#40cacc'
}

var prefix = (function () {
 var styles = window.getComputedStyle(document.documentElement, ''),
     pre = (Array.prototype.slice
         .call(styles)
         .join('')
         .match(/-(moz|webkit|ms)-/) || (styles.OLink === '' && ['', 'o'])
         )[1],
     dom = ('WebKit|Moz|MS|O').match(new RegExp('(' + pre + ')', 'i'))[1];
 return {
     dom: dom,
     lowercase: pre,
     css: '-' + pre + '-',
     js: pre[0].toUpperCase() + pre.substr(1)
 };
})();

var transform = prefix.css+'transform';

function createDiv(className) {
 var div = document.createElement('div');
 if(className) div.className = className;
 var $div = $(div);
 return $div;
}

/* Store transform values for CSS manipulation */
$.fn.extend({
 transform: function(props) {
     var _this = this;
     for(var i in props) {
         _this[i] = props[i];
     }
     return transformString();

     function transformString() {
         var string = '';
         if(_this.x) string += 'translateX('+_this.x+'px)';
         if(_this.y) { string += 'translateY('+_this.y+'px)' ; console.log(_this.y) };
         if(_this.skewX) string += 'skewX('+_this.skewX+'deg)';
         if(_this.skewY) string += 'skewY('+_this.skewY+'deg)';
         if(_this.rotation) string += 'rotate('+_this.rotation+'deg)';
         if(_this.scale) string += 'scale('+_this.scale+','+_this.scale+')';
         return string;
     };
 }
});

function VelocityScene() {
  var _this = this;
    var $l1outer, $l1inner, $l2, $text, $skewbox;
       var letters = [], text = 'K-FUNDING';

    (function() {
       initElements();
    })();

    function initElements() {
        $skewbox = createDiv('box');
        $stage.append($skewbox);
        $skewbox.hide();

        $l1outer = createDiv('line1');
        $l1inner = createDiv('line');

        $stage.append($l1outer);
        $l1outer.append($l1inner);

        $l2 = createDiv('line');

        $stage.append($l2);

        $text = createDiv('textk');

        for(var i in text) {
            var $l = createDiv();
            $l.html(text[i]);
            $l.css({position: 'relative', float: 'left', display: 'inline-block', width: 'auto', marginRight: zfontmargin,
                transform: $l.transform({y: -160 })});
            $text.append($l);
            letters.push($l);
        }
        $stage.append($text);

    }

    this.beginAnimation = function() {
        $skewbox.css({width: zwidth, height: 70, background: Colors.blue, left: '50%', marginLeft: ( zwidth / 2 * -1) , top: '50%',
            transform: $skewbox.transform({skewY: -9}), marginTop: -60 });
        $l1outer.css({overflow: 'hidden', width: zwidth, height: 12, left: '50%', marginLeft: ( zwidth / 2 * -1) , top: '50%',
                      marginTop: -5, transform: $l1outer.transform({x: ( zwidth / 2 ) , y: 0}) });
        $l1inner.css({width: zwidth, height: 10, top: 1, transform: $l1inner.transform({x: ( -1 * zwidth ) , y: 0}), background: Colors.white});
        $l2.css({width: zwidth, height: 10, left: '50%', marginLeft: ( zwidth / 2 * -1) , top: '50%', marginTop: -4,
            background: Colors.white, display: 'none', transform: $l2.transform({skewY: -9})});
        $text.css({width: zwidth, height: 10, fontSize: zfont, color: Colors.white, left: '50%', marginLeft: (zwidth / 2 * -1 +14) , top: '50%', marginTop: -75, transform: $text.transform({skewY: -9, y: zheighttrance}), overflow: 'hidden'});
        $l1outer.show();
        $l1inner.show();
        $text.show();

        $l1inner.velocity({translateX: [0, ( -1 * zwidth ) ], translateY: [0,0]}, 300, 'easeInOutCubic');
        $l1outer.velocity({translateX: [0, ( zwidth / 2 )], translateY: [0,0]}, 300, 'easeInOutCubic');
        $l1outer.velocity({skewY: -9}, {duration: 400, easing: 'easeInOutQuart', complete: function() {
            $l2.show();
            $l1outer.velocity({translateY: -70}, 400, 'easeOutQuart');
            $l2.velocity({translateY: zheighttrance, skewY: [-9,-9]}, 400, 'easeOutQuart');
            $text.velocity({height: zheight , skewY: [-9,-9], translateY: [0,zheighttrance]}, 400, 'easeOutQuart');
            for(var i in letters) {
                letters[i].velocity({translateY: [30, ( zheight * -1 ) ]}, ( zwidth / 2 ), 'easeOutCubic', 100 + i * 50);
            }
        }});
    }
    this.close = function(callback) {
        $text.velocity({height: 10, translateY: [69, 0]}, {duration: 300, easing: 'easeOutCubic'});
        for(var i in letters) {
            letters[i].velocity({translateY: [-150, 0]}, 800, 'easeOutCubic');
        }
        $l1outer.velocity({translateY: [0, -70]}, {duration: 300, easing: 'easeOutCubic'});
        $l2.velocity({translateY: [0, 70], skewY: [-9,-9]}, {duration: 300, easing: 'easeOutCubic',
            complete: function() {
                $l1inner.css({height: 110, transform: $l1inner.transform({y: -100, x: 0})});
                $l1outer.css({height: 110});
                $l2.hide();
                $l1outer.velocity({translateY: [-55, 0]}, {duration: 200, easing: 'easeInCubic'});
                $l1inner.velocity({translateY: [0, -100]}, {duration: 200, easing: 'easeInCubic', complete: function() {
                    $skewbox.show();
                    $skewbox.velocity({skewY: [0, -9]}, 200, 'easeInOutSine');
                    $l1outer.velocity({skewY: [0, -9]}, {duration: 200, easing: 'easeInOutSine', delay: 100, complete: function() {
                        $skewbox.hide();
                        $l1outer.velocity({translateX: -80}, {duration: 100, easing: 'easeOutCubic'});
                        $l1inner.velocity({translateX: 160}, {duration: 100, easing: 'easeOutCubic', complete: function() {
                           callback();
                           $l1outer.hide();
                           $text.hide();
                        }});
                    }});

                }});
        }});
    }
}
function VelocityMask() {
        var  $text;
        var letters = [], text = 'K-FUNDING';
        (function() {
            initElements();
        })();

        function initElements() {
            $text = createDiv('text');
            $text.css({width: 500, height: 160, fontSize: 50, color: Colors.blue, left: '50%', marginLeft: -136,
                top: '50%', marginTop: -81, transform: $text.transform({skewY: -9}), overflow: 'hidden'});
            for(var i in text) {
                var $l = createDiv();
                var $linner = createDiv();
                $l.css({position: 'relative', float: 'left', display: 'inline-block', width: 'auto', overflow: 'hidden', transform: $l.transform({y: -140})});
                $linner.css({position: 'relative', float: 'left', display: 'inline-block', width: 'auto', marginRight: 10, transform: $linner.transform({y: 300})});
                $linner.html(text[i]);
                $l.append($linner);
                $text.append($l);
                letters.push($l);
            }
            $stage.append($text);
        }

        this.animateIn = function() {
            $text.show();
            for(var i in letters) {
                letters[i].velocity({translateY: [10, -100]}, {duration: 200+i*25, easing: 'easeOutCubic', delay: i*50});
                letters[i].find('div').velocity({translateY: [10, 140]}, {duration: 200+i*25, easing: 'easeOutCubic', delay: i*50});
            }

            setTimeout(function() {
                for(var j in letters) {
                    letters[j].velocity({translateY: 10}, {duration: 250, easing: 'easeInCubic', delay: j*40});
                    letters[j].find('div').velocity({translateY: -100}, {duration: 250, easing: 'easeInCubic', delay: j*40});
                }
            }, 700);
        }

        this.hide = function() {
            $text.hide();
        }
    }
    function SplitLines() {
      var $container;
      var _lines = [];

      (function() {
          initElements();
      })();

      function initElements() {
          $container = createDiv('container');
          $container.css({width: 340, height: 110, top: '50%', left: '50%', marginLeft: -170,
              marginTop: -60});
          $stage.append($container);
          $container.hide();

          for(var i = 0; i < 68; i++) {
              var l = {
                  outer: createDiv(),
                  inner: createDiv()
              }
              l.outer.css({width: 5, height: 110, left: i*5});
              l.inner.css({background: Colors.white, width: 5, height: 110});
              $container.append(l.outer);
              l.outer.append(l.inner);
              _lines.push(l);
          }
      }

      this.beginAnimation = function(callback) {
          $container.show();

          setTimeout(function() {
              var midway = _lines.length/2;
              for(var i in _lines) {
                  _lines[i].inner.velocity({translateY: -30+(Math.random()*60)}, {duration: 160, easing: 'easeOutQuart'});
                  _lines[i].inner.velocity({translateY: -30+(Math.random()*60)}, {duration: 160, easing: 'easeInOutQuart'});
                  _lines[i].inner.velocity({translateY: (i%2 == 0) ? -200 : 200}, {duration: 400, easing: 'easeInOutQuart'});
                  if(i < midway) {
                      _lines[i].inner.velocity({translateX: '-='+(midway-i)*2*(midway-i)/10+'px'}, {duration: 300, easing: 'easeInOutCubic'});
                  } else {
                      _lines[i].inner.velocity({translateX: '+='+(i-midway)*2*(i-midway)/10+'px'}, {duration: 300, easing: 'easeInOutCubic'});
                  }

                  _lines[i].inner.velocity({translateX: 0}, {duration: 220, easing: 'easeInCubic'});
                  _lines[i].inner.velocity({rotateZ: '360deg', translateY: 0, translateX: -i*5, height: 5}, {duration: 600, easing: 'easeInOutCubic', delay: i*20});
              }

          }, 30);


          $container.velocity({translateX: [160, 0], translateY: [50, 0]}, {duration: 1800, easing: 'easeInOutCubic', delay: 1400, complete: function() {
              callback();
              $container.hide();
          }});
      }

      this.reset = function() {
        $container.css({width: 340, height: 110, top: '50%', left: '50%', marginLeft: -170,
              marginTop: -60, transform: $container.transform({x: 0, y: 0})});
        for(var i = 0; i < 68; i++) {
          _lines[i].outer.remove();
          var l = {
                  outer: createDiv(),
                  inner: createDiv()
              }
              l.outer.css({width: 5, height: 110, left: i*5});
              l.inner.css({background: Colors.white, width: 5, height: 110});
              $container.append(l.outer);
              l.outer.append(l.inner);
              _lines[i] = l;
        }
      }
  }
function zaniinit(){
  $stage = createDiv('logostage');
  $("#stage").append($stage);
  var velocityScene = new VelocityScene();
  var velocityMask = new VelocityMask();
  var splitLines = new SplitLines();

  setTimeout(velocityScene.beginAnimation, 500);

  setTimeout(velocityMask.animateIn, 1500);
  setTimeout(function() {
      velocityScene.close(function() {
          splitLines.beginAnimation(function() {
            velocityScene.beginAnimation();
          });
          velocityMask.hide();
      });
  }, 3500);
}
$("document").ready( function () {
  zaniinit();


});

</script>

</body>
</html>
