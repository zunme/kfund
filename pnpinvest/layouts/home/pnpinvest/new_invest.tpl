<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');

require './vendor/autoload.php';
use phpFastCache\CacheManager;
// Setup File Path on your config files
CacheManager::setup(array(
    "path" => sys_get_temp_dir(), // or in windows "C:/tmp/"
));
CacheManager::CachingMethod("phpfastcache");
$InstanceCache = CacheManager::Files();

$sql="
  select
  	a.i_id, a.i_subject, b.i_invest_sday, a.i_year_plus, a.i_loan_day
  	, if( a.i_repay = '원리금균등상환' , '원금균등상환',  a.i_repay) as i_repay
  	, a.i_loan_pay
    , a.i_security   , b.i_creditratingviews as mainpost, b.i_look,i_payment
  	, date_format(b.i_invest_sday,'%Y/%m/%d') as i_mainimg_txt1_date
  	, b.i_mainimg_txt1, b.i_mainimg_txt2, b.i_mainimg_txt3, b.i_mainimg_txt4, b.i_mainimg_txt5, b.i_mainimg_txt6
  	, (select  ifnull( sum( mari_invest.i_pay ), 0) from mari_invest where mari_invest.loan_id = a.i_id ) as payed

  from mari_loan a
  join mari_invest_progress b on a.i_id = b.loan_id
  where a.i_view='Y'
    and ( a.i_look in ( 'N','Y') or b.i_look in ( 'N','Y'))
  order by  b.i_invest_sday desc
  # limit 3;
";
$result = sql_query($sql, false);
$z_loaninfo_slide = array();
for ($i=0; $row=sql_fetch_array($result); $i++) {
  if( $row != false ) {
    $row['percent'] = ($row['payed'] == 0 ) ? '0' : floor($row['payed'] / $row['i_loan_pay']*100);
    $row['type'] = ($row['i_payment']=="cate02"||$row['i_payment']=="cate04") ? "부동산":"비부동산";
    $z_loaninfo_slide[] = $row;
  }
}

if( count($z_loaninfo_slide) < 1 ){
  $sql = "
  select
    a.i_id, a.i_subject, b.i_invest_sday, a.i_year_plus, a.i_loan_day
    , if( a.i_repay = '원리금균등상환' , '원금균등상환',  a.i_repay) as i_repay
    , a.i_loan_pay
    , a.i_security  , b.i_creditratingviews as mainpost, a.i_look,i_payment
    , date_format(b.i_invest_sday,'%Y/%m/%d') as i_mainimg_txt1_date
    , b.i_mainimg_txt1, b.i_mainimg_txt2, b.i_mainimg_txt3, b.i_mainimg_txt4, b.i_mainimg_txt5, b.i_mainimg_txt6
    , (select  ifnull( sum( mari_invest.i_pay ), 0) from mari_invest where mari_invest.loan_id = a.i_id ) as payed

  from mari_loan a
  join mari_invest_progress b on a.i_id = b.loan_id
  where a.i_view='Y'  and b.i_look not in ( 'N','Y')
  order by  b.i_invest_sday desc
  limit 3;
  ";
  $result = sql_query($sql, false);
  for ($i=count(z_loaninfo_slide); $row=sql_fetch_array($result); $i++) {
    if( $row != false ) {
      $row['percent'] = ($row['payed'] == 0 ) ? '0' : floor($row['payed'] / $row['i_loan_pay']*100);
      $row['type'] = ($row['i_payment']=="cate02"||$row['i_payment']=="cate04") ? "부동산":"비부동산";
      $z_loaninfo_slide[] = $row;
    }
    //if ($i >= 2) break;
  }
}
$perpage = 6;
$searchsql= '';
if(get_magic_quotes_gpc()) {
$search = mysql_real_escape_string(stripslashes($_GET['search']));
}
else $search = mysql_real_escape_string($_GET['search']);

if($search != ''){
  $searchsql = " and a.i_subject like '%".$search."%' ";
}
$nowpage = ($_GET['page'] > 1 ) ? $_GET['page']: 1;
$sql = "select count(1) as total from mari_loan a where a.i_view='Y' and a.i_look not in('N','Y') $searchsql";
$totaltmp =  sql_fetch($sql);

$totalnum = ( isset( $totaltmp['total']) ) ? (int)$totaltmp['total'] : 0;
$totalpage = (int)( $totalnum / $perpage )+ ($totalnum % $perpage > 0 ? 1 : 0) ;

$start = ($_GET['page'] > 1 ) ? ((int)$_GET['page'] -1)* $perpage : 0;

$sql = "
select
  a.i_id, a.i_subject, b.i_invest_sday, a.i_year_plus, a.i_loan_day
  , if( a.i_repay = '원리금균등상환' , '원금균등상환',  a.i_repay) as i_repay
  , a.i_loan_pay
  , a.i_security
  , b.i_creditratingviews as mainpost
  , a.i_look,i_payment
  , date_format(b.i_invest_sday,'%Y/%m/%d') as i_mainimg_txt1_date
  , b.i_mainimg_txt1, b.i_mainimg_txt2, b.i_mainimg_txt3, b.i_mainimg_txt4, b.i_mainimg_txt5, b.i_mainimg_txt6
  , (select  ifnull( sum( mari_invest.i_pay ), 0) from mari_invest where mari_invest.loan_id = a.i_id ) as payed

from mari_loan a
join mari_invest_progress b on a.i_id = b.loan_id
where a.i_view='Y' and a.i_look not in('N','Y')
$searchsql
order by  b.i_invest_sday desc
limit $start , $perpage;
";

$result = sql_query($sql, false);
?>
{# new_header}
<link rel="stylesheet" href="js/owl/assets/owl.carousel.min.css">
<link rel="stylesheet" href="js/owl/assets/owl.theme.default.min.css">
<link rel="stylesheet" href="/pnpinvest/layouts/home/pnpinvest/simplomodal/learn.css" type="text/css" media="screen" title="no title" charset="utf-8">
<script src="js/owl/owl.carousel.min.js"></script>
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<style>
.product.gallery .item .item_con {
    padding: 8px 14px;
    width: auto;
    height: auto;
    line-height: unset;
}
</style>
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t1 invest_list"><span class="motion" data-animation="flash">투자하기</span></h2>
	<!-- 금일 상품 -->
	<div class="invest_top">
		<h3 class="skip">금일 상품</h3>
		<div class="container">
			<!-- slider -->
			<div class="invest_slider owl-carousel owl-theme navbarbox">
<?php foreach ( $z_loaninfo_slide as $idx=>$row ){?>
				<!-- loop start -->
				<div class="item">
					<p class="timeout  <?php echo (in_array($row['i_look'], array('N'))) ? 'item_time':''; ?>" data-loan_id="<?php echo $row['i_id']?>" data-loan_look="<?php echo $row['i_look']?>" style="display:none" <?php echo (!in_array($row['i_look'], array('N'))) ? 'style="display:none"':''; ?>>
						<i class="clock"></i>
						<span class="txt">이 상품의 투자시작 시간이 <span>....</span></span>
					</p>
					<div class="item_wrap">

						<div class="item_info info1 fl">
                <?php
                  //N 대기, Y 진행중, C 마감, D 이자, F 완료
                    switch( $row['i_look']){
                      case ('N') :
                  ?>
                      <span class="item_con end">투자대기</span>
                  <?php
                      break;
                      case ('Y') :
                  ?>
                      <span class="item_con ing">투자모집</span>
                  <?php
                      break;
                      case ('C') :
                  ?>
                      <span class="item_con end">투자마감</span>
                  <?php
                      break;
                      case ('D') :
                  ?>
                      <span class="item_con end">이자상환</span>
                  <?php
                      break;
                      default:
                  ?>
                      <span class="item_con end">상환완료</span>
                  <?php
                      break;
                    }
                  ?>
							<p class="img_wrap" width="428" height="282"><span class="img img_w"><a href="/pnpinvest/?mode=invest_view&loan_id=<?php echo $row['i_id']?>" target="_self"><img src="/pnpinvest/data/photoreviewers/<?php echo $row['i_id']?>/<?php echo $row['mainpost']?>" alt></a></span></p>
							<p class="txt"><span class="date fl"><?php echo $row['i_mainimg_txt1']?></span><span class="time fr"><?php echo $row['i_mainimg_txt2']?></span></p>
						</div>
						<div class="item_info info2 fr">
							<h4>
                <a href="/pnpinvest/?mode=invest_view&loan_id=<?php echo $row['i_id']?>" target="_self">
								<span><?php echo $row['i_subject']?></span>
								</a>
							</h4>
							<ul class="summary fl">
								<li class="sm_1">
									<dl>
										<dt>상품분류</dt>
										<dd><?php echo $row['type']?></dd>
									</dl>
								</li>
								<li class="sm_2">
									<dl>
										<dt>수익률</dt>
										<dd><?php echo $row['i_year_plus']?>%</dd>
									</dl>
								</li>
								<li class="sm_3">
									<dl>
										<dt>투자기간</dt>
										<dd><?php echo $row['i_loan_day']?>개월</dd>
									</dl>
								</li>
								<li class="sm_5">
									<dl>
										<dt>모집금액</dt>
										<dd><?php echo change_pay($row['payed'])?>/<?php echo change_pay($row['i_loan_pay'])?></dd>
									</dl>
								</li>
							</ul>
							<div class="donut fr">
								<p class="donut_progress">
									<span class="ib fill" style="height:<?php echo $row['percent']?>%;"></span>
								</p>
								<p class="donut_txt center">
									<span>모집률</span>
									<strong><?php echo $row['percent']?>%</strong>
								</p>
							</div>
							<p class="event fr">
								<span class="ib center event1"><?php echo $row['i_mainimg_txt3']?> <?php echo $row['i_mainimg_txt4']?></span>
								<span class="ib center event2"><?php echo $row['i_mainimg_txt5']?><?php echo ($row['i_mainimg_txt6']!='')?'/'.$row['i_mainimg_txt6']:''?></span>
							</p>
						</div>
					</div>
				</div>
				<!-- loop end -->
<?php } ?>
			</div>
			<script>
      //$('.invest_slider').bxSlider({
      //	auto: false,
      //	autoControls: true,
      //	stopAutoOnClick: false,
      //	pager: true,
      //	speed: 1000
      //});
			</script>
      <style>
      button:focus {outline:0;}
      .owl-carousel.navbarbox .owl-nav button.owl-next, .owl-carousel.navbarbox .owl-nav button.owl-prev, .owl-carousel.navbarbox  button.owl-dot {
          width: 38px;
      }
      .owl-carousel.navbarbox .owl-nav button:hover{
        box-shadow:none;
      }
      .owl-carousel.navbarbox .owl-prev {
          width: 15px;
          height: 100px;
          position: absolute;
          top: 35%;
          #margin-left: -20px;
          display: block!IMPORTANT;
          border:0px solid black;
      }

      .owl-carousel.navbarbox .owl-next {
          width: 15px;
          height: 100px;
          position: absolute;
          top: 35%;
          right: 0px;
          display: block!IMPORTANT;
          border:0px solid black;
      }
      .owl-carousel.navbarbox .owl-prev i, .owl-carousel.navbarbox .owl-next i {transform : scale(1,6); color: #ccc;}
      .owl-carousel.navbarbox .owl-dots{
        position: absolute;
            bottom: 7px;
            width: 100%;
        }
        .owl-carousel.navbarbox .owl-dots .owl-dot span {background-color:#999 }
        .owl-carousel.navbarbox .owl-dots .owl-dot.active span {background-color:#00656a }
        .detail_con.product_info .viewarea {
            min-height: 220px;
          }
        .owl-carousel .single{ transform: translate3d(0px,0px, 0px) !important; }
      </style>
      <script>
      function callbackOwl(event) {
        if (parseInt($(event.target).find('div.item').length) <= 1) {
          ;
          event.relatedTarget.options.loop = false;
        }
      }

      $(document).ready(function(){
        $(".owl-carousel").owlCarousel({
          items:1,
          margin:10,
          autoHeight:true,
          loop : true,
          autoplay:true,
          autoplayTimeout:7000,
          autoplayHoverPause:true,
          center:true,
          itemsScaleUp:true,
          nav: true,
          navText: ["<img src='js/owl/assets/left2.png' style='width: 38px;'>","<img src='js/owl/assets/right2.png' style='width: 38px;'>"],
          onInitialize: callbackOwl,
        });
      });
      </script>
		</div>
	</div>
	<!-- search -->
	<div class="search">
		<div class="container">
			<span class="allitem">지난상품 전체보기</span>
			<form action="/pnpinvest/" method="get" name="form1">
  <input type="hidden" name="mode" value="invest">
				<h3 class="skip">검색창</h3>
				<div class="sch_wrap">
					<span class="sch_box"><input type="text" name="search" id="" title="검색어 입력" value="<?php echo ($_GET['search']!='')? $_GET['search'] : "투자상품 검색"?>" onfocus="if(this.value=='투자상품 검색')this.value=''" onblur="if(this.value=='')this.value='투자상품 검색'"></span>
					<button type="submit" name="" id="" class="btn_sch"><img src="img/btn_sch.png" alt="검색"></button>
				</div>
			</form>
		</div>
	</div>
	<!-- 지난상품 리스트 -->
	<div class="invest_all <?php echo ($search !='' || $nowpage > 1)?'':'close'?>">
		<div class="container">
			<h3 class="skip">지난상품 리스트</h3>
			<span class="folditem">지난상품 접어두기</span>
			<p class="list_type">
				<span class="list on">리스트형</span>
				<span class="gallery">갤러리형</span>
			</p>
			<ul class="product">
<?php for ($i=0; $row=sql_fetch_array($result); $i++) {

  if( $row != false ) {
    $row['percent'] = ($row['payed'] == 0 ) ? '0' : floor($row['payed'] / $row['i_loan_pay']*100);
    $row['type'] = ($row['i_payment']=="cate02"||$row['i_payment']=="cate04") ? "부동산":"비부동산";
?>
				<!-- Item Start -->
				<li>
					<div class="item">

						<div class="item_info info1 fl">
              <?php
              //N 대기, Y 진행중, C 마감, D 이자, F 완료
                switch( $row['i_look']){
                  case ('N') :
              ?>
                  <span class="item_con end">투자대기</span>
              <?php
                  break;
                  case ('Y') :
              ?>
                  <span class="item_con ing">투자모집</span>
              <?php
                  break;
                  case ('C') :
              ?>
                  <span class="item_con end">투자마감</span>
              <?php
                  break;
                  case ('D') :
              ?>
                  <span class="item_con end">이자상환</span>
              <?php
                  break;
                  default:
              ?>
                  <span class="item_con end">상환완료</span>
              <?php
                  break;
                }
              ?>
							<div class="img_wrap">
								<p class="img">
									<img src="/pnpinvest/data/photoreviewers/<?php echo $row['i_id']?>/<?php echo $row['mainpost']?>" alt>
								</p>
							</div>
							<p class="txt"><span class="date fl"><?php echo $row['i_mainimg_txt1']?></span><span class="time fr"><?php echo $row['i_mainimg_txt2']?></span></p>
						</div>
						<div class="item_info info2 fr">
							<h4>
								<a class="item_name" href="/pnpinvest/?mode=invest_view&loan_id=<?php echo $row['i_id']?>">
									<span class="subject"><?php echo $row['i_subject']?></span>
								</a>
							</h4>
							<ul class="summary">
								<li class="sm_1">
									<dl>
										<dt>상품분류</dt>
										<dd><?php echo $row['type']?></dd>
									</dl>
								</li>
								<li class="sm_2">
									<dl>
										<dt>수익률</dt>
										<dd><?php echo $row['i_year_plus']?>%</dd>
									</dl>
								</li>
								<li class="sm_3">
									<dl>
										<dt>투자기간</dt>
										<dd><?php echo $row['i_loan_day']?>개월</dd>
									</dl>
								</li>
								<li class="sm_5">
									<dl>
										<dt>모집금액</dt>
										<dd><?php echo change_pay($row['payed'])?>/<?php echo change_pay($row['i_loan_pay'])?></dd>
									</dl>
								</li>
							</ul>
							<div class="item_progress">
								<span class="ib left">모집률</span>
								<div><p class="progress"><span class="p_bar" style="width:<?php echo $row['percent']?>%;"></span></p><?php echo $row['percent']?>%</div>
							</div>
							<span class="item_event event1"><?php echo $row['i_mainimg_txt3']?> <?php echo $row['i_mainimg_txt4']?></span>
							<span class="item_event event2"><?php echo $row['i_mainimg_txt5']?><?php echo ($row['i_mainimg_txt6']!='')?'/'.$row['i_mainimg_txt6']:''?></span>
						</div>
					</div>
				</li>

				<!-- Item End -->
<?php } } ?>

			</ul>
			<!-- paging -->
      <?php echo paginate($perpage, $nowpage, $totalnum, $totalpage, '/pnpinvest/?mode=invest&search='.$_GET['search']) ?>

		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<script>
$("document").ready( function() {
  $(".item_time").each(function (){
    checkstatus(this);
		$(this).fadeIn("slow");
  });
});
function CountDown(duration, display,start) {
    if (!isNaN(duration)) {
        var timer = duration, minutes, seconds;

      var interVal=  setInterval(function () {
        var string = "";
        var afterstr="";
        var sec_num = parseInt(timer, 10); // don't forget the second param
        var days = Math.floor(sec_num / 3600/24);

        var hours   = Math.floor((sec_num - days*3600*24)  / 3600);
        var minutes = Math.floor((sec_num - days*3600*24 - (hours * 3600)) / 60);
        var seconds = sec_num - (days*3600*24)- (hours * 3600) - (minutes * 60);

        if (hours   < 10) {hours   = "0"+hours;}
        if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {seconds = "0"+seconds;}
        if( days > 0 ) {string = days +"일 ";}
        if( start ) afterstr = " 남았습니다.";
        else afterstr = " 후 투자마감";
            $(display).children('span').children('span').html(string + hours+':'+minutes+':'+seconds + afterstr);
            if (--timer < 0) {
               if(start) {
                 $(display).html("투자시작");
               }
               else $(display).html("투자마감");
               clearInterval(interVal);
               setTimeout( checkstatus(display) , 1000);
            }
            else if(seconds=="00"){
              clearInterval(interVal);
              checkstatus(display);
              return;
            }
            },1000);
    }
}
function checkstatus(display){
  if($(display).data('loan_id') ){
    $.ajax({
      url:"/api/index.php/timer/now/"+$(display).data('loan_id'),
       type : 'GET',
       data:{'_':new Date().getTime()},
       dataType : 'json',
       success : function(result) {
         if( $(display).data('loan_look') != result.data.look ){
           location.reload();
           return;
         }
         if(result.data.status !='drop' && (result.data.look=='Y'|| result.data.look =='N' ) ) { //||result.data.look =='N' 투자시작용
           if(result.data.status=='end'){
              //CountDown(result.data.e_seconds,display, false);
           }else if (result.data.status=='start'){
              CountDown(result.data.s_seconds,display, true);
           }else if( result.data.status=='ready'){
              $(display).html("<p class='txt'>곧 투자시작가 시작됩니다.</p>");
           }else {
             $(display).remove();
           }
         }else {
           $(display).remove();
         }
       },
       error: function(request, status, error) {
         console.log(request + "/" + status + "/" + error);
       }
    });
  }
}
function reloadnow(display){
  $.ajax({
    url:"/api/index.php/timer/now/"+$(display).data('loan_id'),
     type : 'GET',
     dataType : 'json',
     success : function(result) {
         location.reload();
         return;
     }
   });

}
</script>
{# new_footer}

<?php
function paginate($item_per_page, $current_page, $total_records, $total_pages, $page_url)
{
    $pagination = '';
    if($total_pages > 0 && $total_pages != 1 && $current_page <= $total_pages){ //verify total pages and current page number
        $pagination .= '<p class="paging paging2">';
          $pagination .= "
          ";

        $right_links    = $current_page + 3;
        $previous       = $current_page - 3; //previous link
        $next           = $current_page + 1; //next link
        $first_link     = true; //boolean var to decide our first link

        if($current_page > 1){
            $previous_link = ($previous==0)?1:$previous;
            $pagination .= '<span class="first"><a href="'.$page_url.'&page=1" title="First">&laquo;</a></span>'; //first link
            $pagination .= "
            ";
            $pagination .= '<span><a href="'.$page_url.'&page='.$previous_link.'" title="Previous">&lt;</a></span>'; //previous link
            $pagination .= "
            ";
                for($i = ($current_page-2); $i < $current_page; $i++){ //Create left-hand side links
                    if($i > 0){
                        $pagination .= '<span><a href="'.$page_url.'&page='.$i.'">'.$i.'</a></span>';
                        $pagination .= "
                        ";
                    }
                }
            $first_link = false; //set first link to false
        }

        if($first_link){ //if current active page is first link
            $pagination .= '<span class="first active on">'.$current_page.'</span>';
            $pagination .= "
            ";
        }elseif($current_page == $total_pages){ //if it's the last active link
            $pagination .= '<span class="last active on">'.$current_page.'</span>';
            $pagination .= "
            ";
        }else{ //regular current link
            $pagination .= '<span class="active on">'.$current_page.'</span>';
            $pagination .= "
            ";
        }

        for($i = $current_page+1; $i < $right_links ; $i++){ //create right-hand side links
            if($i<=$total_pages){
                $pagination .= '<span><a href="'.$page_url.'&page='.$i.'">'.$i.'</a></span>';
                $pagination .= "
                ";
            }
        }
        if($current_page < $total_pages){
                $next_link = ($i > $total_pages)? $total_pages : $i;
                $pagination .= '<span><a href="'.$page_url.'&page='.$next_link.'" >&gt;</a></span>'; //next link
                $pagination .= "
                ";
                $pagination .= '<span class="last"><a href="'.$page_url.'&page='.$total_pages.'" title="Last">&raquo;</a></span>'; //last link
                $pagination .= "
                ";
        }

        $pagination .= '</p>';
    }
    return $pagination; //return pagination links
}
?>
