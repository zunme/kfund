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
<body    >

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
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">


<script src="/assets/js/jquery.pjax.js"></script>
<!-- / 공용 header END -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-125059785-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-125059785-1');
</script>

	<div id="ajaxloading">
    <div>
      <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
        <div class="rect5"></div>
      </div>
    </div>
  </div>

    <div id="pageheader" class="page-header header-filter clear-filter header-small " data-parallax="true" filter-color="cyan" >
			<div class="container">

				<div class="row" style="width:100vw">
			      <div class="col-xs-12 text-center">
			          <h3 class="title"><span>K</span><span> FUNDING CAST</span> </h3>
								<h4>투명한 정보의 공유 <span >K</span> Funding</h4>
			      </div>
			  </div>
			</div>
    </div>

    <div class="main main-raised" id="realmain" >
           <div class="container">
               <div class="section">

                 <div>
                     <div class="text-center">
                       <a class="btnli <?php echo ($this->cate == 'All') ? "on": ""?>" href="/api/cast/All/">ALL</a>
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
                                   <p class="card-description block-with-text">
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
                  <div class="col-md-offset-6 col-md-6 col-sm-offset-2 col-sm-10 col-xs-offset-1 col-xs-11">

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
                       <div class="col-md-4 display_col display_col_info">
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

									<div>
									 <ul class="pagination pagination-info">
										 <?php echo $pages ?>
									 </ul>
								 </div>
</div>
<div id="viewcontent3">
</div>


               </div>
           </div> <!-- / container-->


           <div class="team-5 section-image" style="background-image: url('https://s3.amazonaws.com/creativetim_bucket/products/73/nudr_cover_%281%29.jpg?1518594435');background-position: bottom center; padding: 60px 0;">
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
       		<p><span class="logo_k" style="font-size: 25px;padding-right: 14px;position: relative;z-index: 10;">K</span><span class="logo_k_title" style="font-size: 20px;position: relative;z-index: 10;">펀딩</span>의 회원이</p>
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




<link href="/assets/zcast.css" rel="stylesheet" />
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
//				     ga('set', 'location', window.location.href); // 현재 바뀐 주소를
	//			     ga('send', 'pageview'); // 보고한다
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
