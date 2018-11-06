<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>케이펀딩</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<meta http-equiv="imagetoolbar" content="no">
<meta name="keywords" content="케이펀딩, 피앤피, p2p 대출솔루션, 대출솔루션, p2p투자, p2p펀딩, 일반대출, 담보대출, 대출p2p, 크라우드펀딩, p2p금융솔루션, 대출p2p솔루션, 크라우드펀딩 솔루션, 핀테크 솔루션, 대출 중계솔루션, p2p 대출중개, 소자본창업, 대부업, 금융운영" ><!--HTML 상단 검색 키워드소스 content=""-->
<meta name="description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다." ><!--HTML 상단 검색설명소스 content=""-->

<meta property="og:type" content="https://www.kfunding.co.kr/">
<meta property="og:title" content="케이펀딩">
<meta property="og:description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다.">
<meta property="og:image" content="https://www.kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta property="og:url" content="https://www.kfundingl.co.kr/">
<link rel="canonical" href="https://www.kfunding.co.kr/">

<link rel="SHORTCUT ICON" href="https://www.kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta name="google-site-verification" content="wFlJBNsJ9EcCuDtiz8gnIcdhqess5G-zrN6iGCyLbqs" />
</head>
<body class="blog-posts">

<?php
error_reporting(0);
$member_ck = $this->member_ck;
require getcwd()."/../pnpinvest/_compile/layouts/home/pnpinvest/new_header.tpl.php";
?>


  <link rel="stylesheet" href="/assets/iziModal/css/iziModal.min.css">
  <script src="/assets/iziModal/js/iziModal.min.js" type="text/javascript"></script>
	<!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons|Pinyon+Script|Playball|Jua|Nanum+Gothic" />
	<link rel="stylesheet" href="/assets/font-awesome/latest/css/font-awesome.min.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous" />


<script src="/assets/js/jquery.pjax.js"></script>
<!-- / 공용 header END -->

<style>
.page-header.header-small {
    height:40vh;
    min-height: 40vh;
}
a.btnli{
	border-radius: 30px;
	#box-shadow: 0 2px 2px 0 rgba(156, 39, 176, 0.14), 0 3px 1px -2px rgba(156, 39, 176, 0.2), 0 1px 5px 0 rgba(156, 39, 176, 0.12);
	border: none;
	position: relative;
	padding: 12px 20px;
	margin: 10px 1px;
	font-size: 12px;
	font-weight: 400;
	text-transform: uppercase;
	letter-spacing: 0;
	will-change: box-shadow, transform;
	transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
	margin-left:5px;
	margin-right:5px;
	color:#555555;
	}
	a.btnli:hover{
		    box-shadow: 0 14px 26px -12px rgba(0, 102, 145, 0.24), 0 4px 23px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 102, 145, 0.2);
	}
	a.btnli.on{
		background-color: #006691;
		color: #FFFFFF;
	}
#pageheader h2 {padding-top:13vh; color:white}
.border-btn {
color: white;
border: 1px solid #FFF;
border-radius: 3px;
box-shadow: 0 2px 2px 0 rgba(153, 153, 153, 0.14), 0 3px 1px -2px rgba(153, 153, 153, 0.2), 0 1px 5px 0 rgba(153, 153, 153, 0.12);
position: relative;
margin: 10px 1px;
font-size: 12px;
font-weight: 400;
text-transform: uppercase;
letter-spacing: 0;
will-change: box-shadow, transform;
transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
display: inline-block;
padding: 10px 16px;
margin-bottom: 0;
font-size: 14px;
font-weight: 400;
line-height: 1.42857143;
text-align: center;
white-space: nowrap;
vertical-align: middle;
-ms-touch-action: manipulation;
touch-action: manipulation;
cursor: pointer;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}
.modal-open {
  overflow: hidden;
}
.modal {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1050;
  display: none;
  overflow: hidden;
  -webkit-overflow-scrolling: touch;
  outline: 0;
}
.modal.fade .modal-dialog {
  -webkit-transition: -webkit-transform .3s ease-out;
       -o-transition:      -o-transform .3s ease-out;
          transition:         transform .3s ease-out;
  -webkit-transform: translate(0, -25%);
      -ms-transform: translate(0, -25%);
       -o-transform: translate(0, -25%);
          transform: translate(0, -25%);
}
.modal.in .modal-dialog {
  -webkit-transform: translate(0, 0);
      -ms-transform: translate(0, 0);
       -o-transform: translate(0, 0);
          transform: translate(0, 0);
}
.modal-open .modal {
  overflow-x: hidden;
  overflow-y: auto;
}
.modal-dialog {
  position: relative;
  width: auto;
  margin: 90px 10px;
}
.modal-content {
  position: relative;
  background-color: #fff;
  -webkit-background-clip: padding-box;
          background-clip: padding-box;
  border: 1px solid #999;
  border: 1px solid rgba(0, 0, 0, .2);
  border-radius: 6px;
  outline: 0;
  -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
          box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
}
.modal-backdrop {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1040;
  background-color: #000;
}
.modal-backdrop.fade {
  filter: alpha(opacity=0);
  opacity: 0;
}
.modal-backdrop.in {
  filter: alpha(opacity=50);
  opacity: .5;
}
.modal-header {
  min-height: 16.42857143px;
  padding: 15px;
  border-bottom: 1px solid #e5e5e5;
}
.modal-header .close {
  margin-top: -2px;
}
.modal-title {
  margin: 0;
  line-height: 1.42857143;
  color: #066c84;
  font-size: 24px;
  padding-left: 15px;
  font-weight: 600;
  min-height:34px;
}
.modal-body {
  position: relative;
  padding: 15px;
}
.modal-footer {
  padding: 15px;
  text-align: right;
  border-top: 1px solid #e5e5e5;
}
.modal-footer .btn{
  display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
  border: none;
    border-radius: 3px;
    position: relative;
    padding: 12px 30px;
    margin: 10px 1px;
    font-size: 12px;
    font-weight: 400;
    text-transform: uppercase;
    letter-spacing: 0;
    will-change: box-shadow, transform;
    transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  background-color: #999999;
  color: #FFFFFF;
  box-shadow: 0 2px 2px 0 rgba(153, 153, 153, 0.14), 0 3px 1px -2px rgba(153, 153, 153, 0.2), 0 1px 5px 0 rgba(153, 153, 153, 0.12);
}
.modal .btn:hover,
.modal .btn:focus,
.modal .btn.focus {
  color: #333;
  text-decoration: none;
}
.modal-footer .btn + .btn {
  margin-bottom: 0;
  margin-left: 5px;
}
.modal-footer .btn-group .btn + .btn {
  margin-left: -1px;
}
.modal-footer .btn-block + .btn-block {
  margin-left: 0;
}
.modal-scrollbar-measure {
  position: absolute;
  top: -9999px;
  width: 50px;
  height: 50px;
  overflow: scroll;
}
.modal-header .close {
    float: right;
    font-size: 21px;
    color:black;
    font-weight: 700;
    line-height: 1;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    filter: alpha(opacity=20);
    opacity: .2;
    font-size: inherit;
    color: #FFFFFF;
    opacity: .9;
    text-shadow: none;
    -webkit-appearance: none;
    padding: 0;
    cursor: pointer;
    background: 0 0;
    border: 0;
}

@media (min-width: 768px) {
  .modal-dialog {
    width: 70%;
    min-width: 600px;
    max-width:900px;
    margin: 80px auto;
  }
  .modal-content {
    -webkit-box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
            box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
  }
  .modal-sm {
    width: 300px;
  }
}
@media (min-width: 992px) {
  .modal-lg {
    width: 900px;
  }
}

.main .container {
  max-width: 1000px;
}
@media (min-width: 768px){
.main .container {
    width: 690px;
}}
@media (min-width: 992px){
.main .container {
    width: 880px;
}
.main{
  width: 970px;
  margin: -150px auto 0px;
}
}
@media (min-width: 1200px){
.main .container {
    width: 939px;
}
.main{
  width: 1000px;
  margin: -150px auto 0px;
}
}

.modal.fade .c-modal-dialog {
-webkit-transition: -webkit-transform .3s ease-out;
-o-transition: -o-transform .3s ease-out;
transition: transform .3s ease-out;
-webkit-transform: translate(0,-25%);
-ms-transform: translate(0,-25%);
-o-transform: translate(0,-25%);
transform: translate(0,-25%);
}
.modal.in .c-modal-dialog {
 -webkit-transform: translate(0,0);
 -ms-transform: translate(0,0);
 -o-transform: translate(0,0);
 transform: translate(0,0);
}
.modal .c-modal-dialog {
  margin-top: 100px;
}
.c-modal-dialog {
  position: relative;
  width: auto;
  margin: 10px;
}
.c-modal-dialog{
margin: 30px auto;
width: 90%;
max-width:800px;
}
.c-modal-dialog .modal-content .modal-body {
  padding-top: 24px;
  padding-right: 16px;
  padding-bottom: 16px;
  padding-left: 16px;
}
.modal .modal-header .close {
    color: #999999;
    font-size: 24px;
}
.title, .card-title, .info-title, .footer-brand, .footer-big h5, .footer-big h4, .media .media-heading {
    font-weight: 700;
    font-family: 'Nanum Gothic', sans-serif;
}
.card .card-body, .card .card-footer {
    padding: .9375rem 1.875rem;
}
.card-background .card-body, .back-background .card-body, .front-background .card-body {
    position: relative;
    z-index: 2;
    min-height: 280px;
    padding-top: 40px;
    padding-bottom: 40px;
    max-width: 800px;
    margin: 0 auto;
}
.card-background .card-title, .back-background .card-title, .front-background .card-title {
    text-align: center;
}
.block-with-text {
    overflow: hidden;
    position: relative;
    line-height: 1.3em;
    max-height: 3.7em;
    text-align: justify;
    margin-right: -1em;
    padding-right: 1em;
}
.card-blog .card-title {
    font-size: 16px;
	}
	.cardsubhead {
		color:#00ae9d;
	}
	.readmore{
		color:#006691;
	}
	.form-group.has-success label.control-label {
		color : #006691;
	}
	.search_label{
		color : #006691;
	}
	.has-success .form-control-feedback {
			color: #006691;
			opacity: 1;
	}
	.form-group.has-success.is-focused .form-control {
			 background-image: linear-gradient(#00ae9d, #006691), linear-gradient(#D2D2D2, #D2D2D2);
	}
	.card-background .card-body, .back-background .card-body, .front-background .card-body {
			max-width: 800px;
		}
		.card-background .card-title, .back-background .card-title, .front-background .card-title {
			text-align:center;
	}
  .card-blog .card-title {
    font-size: 16px;
  }
</style>
<link href="/assets/zcast.css" rel="stylesheet" />
<div id="pageheader" class="page-header header-small" data-parallax="true" style="width:100vw;background-image: url('/assets/img/mainbg_0705.jpg');background-position: bottom center;">
    <div class="center">
      <h2>케이펀딩 캐스트</h2>
    </div>
</div>
    <div class="main main-raised" id="realmain" >
           <div class="container">
               <div class="section" style="padding-bottom: 20px;padding-top:40px;">
                 <div style="margin: 10px 0 60px 0;">
                     <div class="text-center">
                       <a class="btnli <?php echo ($this->cate == 'All'|| (!in_array($this->cate, array('Prd','Info'))) ) ? "on": ""?>" href="/api/cast/All/">ALL</a>
                       <a class="btnli <?php echo ($this->cate == 'Prd') ? "on": ""?>" href="/api/cast/Prd/">상품정보</a>
                       <a class="btnli <?php echo ($this->cate == 'Info') ? "on": ""?>" href="/api/cast/Info/">투자정보</a>
                     </div>
                  </div>
                   <div class="row">
                       <div class="col-md-12">
                           <div class="card card-raised card-background" style="background-image: url('<?php echo ( $top['cast_img'] ) ?>')">
                               <div class="card-body">
                                   <h6 class="card-category text-info"><?php echo ( $top['loan_id'] > 0 ) ? "상품정보":"투자정보"?></h6>
                                   <h3 class="card-title"><?php echo ( $top['cast_title'] ) ?></h3>
                                   <p class="card-description block-with-text" style="margin-bottom:30px;margin-top:10px;font-size: 1.7rem;">
                                       <?php echo ( $top['cast_contents'] ) ?>
                                   </p>
                                   <a href="javascript:;" data-idx="<?php echo ( $top['cast_idx'] ) ?>" class="modal-contents btn btn-warning btn-round">
                                       <i class="material-icons">subject</i> Read More ...
                                   </a>

                               </div>
                           </div>
                       </div>
                   </div>
               </div>
               <div class="section" id="viewcontent">
                <div class="row">
                  <div class="col-md-offset-6 col-md-6 col-sm-offset-6 col-sm-6 col-xs-offset-3 col-xs-9">

                    <div>
											<form action ='/api/cast/All' method='get'>
	                      <div class="form-group label-floating has-success is-empty">
	                        <label class="control-label search_label">제목 검색</label>
	                        <input type="text" name="search" value="" class="form-control">
	                        <span class="form-control-feedback">
	                          <i class="material-icons">search</i>
	                        </span>
	                        <span class="material-input"></span>
	                      <span class="material-input"></span></div>
											</form>
                    </div>

                  </div>
                 </div>
                <div id="viewcontent2">
                                   <div class="row">
                										 <?php foreach ($list as $row) { ?>
                                       <div class="col-md-4 col-sm-10 col-md-offset-0 col-sm-offset-1 display_col display_col_info">
                                           <div class="card card-plain card-blog">
                                               <div class="card-header card-header-image">
                                                   <a href="javascript:;" onClick="modalcontents(<?php echo ( $row['cast_idx'] ) ?>)" data-idx="<?php echo ( $row['cast_idx'] ) ?>">
                                                       <img class="img img-raised" src="<?php echo ( $row['cast_img'] ) ?>">
                                                   </a>
                                               </div>
                                               <div class="card-body">
                                                   <h6 class="card-category cardsubhead card-text-<?php echo ( $row['loan_id'] > 0 ) ? 'danger':'info'?>"><?php echo ( $row['loan_id'] > 0 ) ? "상품정보":"투자정보"?></h6>
                                                   <h4 class="card-title">
                                                       <a href="javascript:;" class="modal-contents" data-idx="<?php echo ( $row['cast_idx'] ) ?>"><?php echo ( $row['cast_title'] ) ?></a>
                                                   </h4>
                                                   <p class="card-description block-with-text smallcard">
                                                       <?php echo ( $row['cast_contents'] ) ?>
                                                   </p>
                                                   <a href="javascript:;" onClick="modalcontents(<?php echo ( $row['cast_idx'] ) ?>)" class="readmore" data-idx="<?php echo ( $row['cast_idx'] ) ?>"> Read More </a>
                                               </div>
                                           </div>
                                       </div>
                										 <?php  } ?>

                                   </div>

                									<div class="center">
                									 <ul class="pagination pagination-info">
                										 <?php echo $pages ?>
                									 </ul>
                								 </div>
                </div>
                <div id="viewcontent3">
                </div>
               </div>
           </div> <!-- / container-->


           <div class="team-5 section-image" style="background-image: url('/assets/img/mainbg_0705.jpg');background-position: bottom center; padding: 60px 0;">
               <div class="container">
                   <div style="    text-align: right;    font-size: 20px;    color: #adacac;">
                     <div>
                       <span style="font-family: 'Pinyon Script', cursive;font-size:30px;font-weight:bold;">K</span>
                       <span style="margin-left: 20px;">FUNDING</span>
                     </div>
                     <p style=" margin-top: 20px;    margin-bottom: -20px;    font-size: 15px;">모든 투자 상품을 투명하게 공개하겠습니다.<p>
                   </div>
               </div>
           </div>
           <div class="subscribe-line">
               <div class="container">
               </div>
           </div>
    </div>


       <div style="padding:40px 0;text-align:center; background-color:#e91e63;color:white;font-size:20px;font-weigh:bold;margin-top:50px;">
       	<div>
       		<p>아직도</p>
       		<p><span class="logo_k_title" style="font-size: 20px;position: relative;z-index: 10;font-weight: 700;">케이펀딩</span>의 회원이</p>
       		<p>아니신가요?</p>
       	</div>
       	<a href="#" class="border-btn hvr-bounce-to-right">회원가입하러가기</a>
       </div>
       <!-- /////////////////////////////// 하단 시작 /////////////////////////////// -->
       <?php
       require getcwd()."/../pnpinvest/_compile/layouts/home/pnpinvest/new_footer.tpl.php";
       ?>
       <!-- /////////////////////////////// 하단 끝 /////////////////////////////// -->





       <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog" role="document">
           <div class="modal-content">
           		<div class="modal-header">
           				<h5 class="modal-title" id="exampleModalLabel"></h5>
           				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
           						<span aria-hidden="true">&times;</span>
           				</button>
           		</div>
           		<div class="modal-body">
           				...
           		</div>
           		<div class="modal-footer">
           				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           				<!--button type="button" class="btn btn-primary">Save changes</button-->
           		</div>
           </div>
         </div>
       </div>
			 <!-- Modal2 -->
			 <div class="modal fade" id="contentsmodal" tabindex="-1" role="dialog" aria-labelledby="contents" aria-hidden="true" data-backdrop="static">
         <div class="c-modal-dialog" role="document">
           <div class="modal-content">
           		<div class="modal-header">
           				<h5 class="modal-title" id="contentsmodaltitle"></h5>
           				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
           						<span aria-hidden="true">&times;</span>
           				</button>
           		</div>
           		<div class="modal-body">

           		</div>
           		<div class="modal-footer">
           				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           				<!--button type="button" class="btn btn-primary">Save changes</button-->
           		</div>
           </div>
         </div>
       </div>

       <script>
			 function view(idx){
				 $.get('/api/cast/view?idx='+idx, function (data){
					 $("#viewcontent3").html(data);
					 $("#viewcontent2").fadeOut();
					 $("#viewcontent3").fadeIn();
				 });

			 }
       function movebgcolor_resize() {
         $("#movebgcolor").css("height", $(document).height() - $("footer").height() - 10 );
       }
       function movebgcolor_full() {
       	$("#movebgcolor").css("height",350);
       	$("#movebgcolor").css("height", $(document).height()-20 );
       }
       $(document).ready( function () {

				 var viewcontentscroll = 1000;
				 $(document).on('click', '.pagination a , a.btnli', function(e){ // pjax라는 클래스를 가진 앵커태그가 클릭되면,
				     $.pjax({
				         url: $(this).attr('href'), // 앵커태그가 이동할 주소 추출
				         fragment: '#viewcontent2', // 위 주소를 받아와서 추출할 DOM
				         container: '#viewcontent2' // 위에서 추출한 DOM 내용을 넣을 대상
				     });
				     return false;
				 });
				 // for google analytics
				 $(document).on('pjax:end', function() {
				     ga('set', 'location', window.location.href); // 현재 바뀐 주소를
				     ga('send', 'pageview'); // 보고한다
						$('html, body').scrollTop($("#viewcontent").offset().top);
				 });

				 $('.modal-link').click(function(e) {
					 if ( typeof $(this).data('img') != 'undefined' ){
						 var dataURL = $(this).data('img');
					 } else {
					 	var dataURL = $(this).data('url');
					}
					$("#exampleModalLabel").text($(this).data('title') );

					if ( typeof $(this).data('img') != 'undefined' ){
						$('#exampleModal .modal-body').html("<img src='"+ dataURL +"' width=100%>");
						$('#exampleModal').modal({show:true});
					}else {
						$('#exampleModal .modal-body').load(dataURL,function(){
								$('#exampleModal').modal({show:true});
						});
					}
					e.preventDefault();
			 	});

				$('.modal-contents').click(function(e) {
						var modal = $('#contentsmodal'), modalBody = $('#contentsmodal .modal-body');
						var idx = $(this).data('idx');
						$('#contentsmodal .modal-body').load('/api/cast/view?idx='+ idx ,function(){
								$('#contentsmodal').modal({show:true});
						});

						e.preventDefault();
				});

        $(".btnli").on( "click", function (){
          $(".btnli.on").removeClass("on");
          $(this).addClass("on");
        });
       });
			 function modalcontents(idx){
				 var modal = $('#contentsmodal'), modalBody = $('#contentsmodal .modal-body');
				 $('#contentsmodal .modal-body').load('/api/cast/view?idx='+ idx ,function(){
						 $('#contentsmodal').modal({show:true});
				 });
			 }
       </script>

			 <!-- ani -->
     </body>
</html>
