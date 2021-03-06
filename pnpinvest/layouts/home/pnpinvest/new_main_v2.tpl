<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');

function returnhex($hex){
  list($r, $g, $b) = sscanf($hex, "#%02x%02x%02x");
  return "$r, $g, $b";
}

require './vendor/autoload.php';
use phpFastCache\CacheManager;
// Setup File Path on your config files
CacheManager::setup(array(
    "path" => sys_get_temp_dir(), // or in windows "C:/tmp/"
));
CacheManager::CachingMethod("phpfastcache");
$InstanceCache = CacheManager::Files();

$sql = "
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
order by field( b.i_look, 'Y','N','C','D','F') , b.i_invest_sday desc limit 1;
";
//and (a.i_look = 'Y' or a.i_look = 'N' or a.i_look='C')
$result = sql_query($sql, false);
$z_loaninfo = array();
for ($i=0; $row=sql_fetch_array($result); $i++) {
  if( $row != false ) {
    $row['percent'] = ($row['payed'] == 0 ) ? '0' : floor($row['payed'] / $row['i_loan_pay']*100);
    $row['type'] = ($row['i_payment']=="cate02"||$row['i_payment']=="cate04") ? "부동산":"비부동산";
    $z_loaninfo[] = $row;
  }
}
/*
if( count($z_loaninfo)< 1)    {
  $sql = "
  select
  	a.i_id, a.i_subject, b.i_invest_sday, a.i_year_plus, a.i_loan_day
  	, if( a.i_repay = '원리금균등상환' , '원금균등상환',  a.i_repay) as i_repay
  	, a.i_loan_pay
      , a.i_security   , b.i_creditratingviews as mainpost, a.i_look
  	, date_format(b.i_invest_sday,'%Y/%m/%d') as i_mainimg_txt1_date
  	, b.i_mainimg_txt1, b.i_mainimg_txt2, b.i_mainimg_txt3, b.i_mainimg_txt4, b.i_mainimg_txt5, b.i_mainimg_txt6
  	, (select  ifnull( sum( mari_invest.i_pay ), 0) from mari_invest where mari_invest.loan_id = a.i_id ) as payed

  from mari_loan a
  join mari_invest_progress b on a.i_id = b.loan_id
  where a.i_view='Y' and (a.i_look = 'D')
  order by b.i_invest_sday desc
  limit 1
  ";
  $z_loaninfo[] = sql_fetch($sql);
}
*/
/* cache use */
$allpay = $InstanceCache->get('allpay');
if (is_null($allpay)) {

//New
$sql = "
select  floor(sum( a.i_pay)/10)*10 into @totalwithvpay from mari_invest a where a.i_pay > 0
";
sql_query($sql, false);
$sql = "
select
floor(sum(i_pay)/10)*10 into @remainwithvpay
from
(select i_id from mari_loan a where a.i_view ='Y'  and a.i_look !='F' and a.i_look !='Y' and a.i_look !='N') b
join mari_invest i on b.i_id = i.loan_id and i_pay_ment = 'Y';
";
sql_query($sql, false);
$sql = "
select
	floor(sum(wongum)/10)*10	, floor( sum( if( i_look !='F' and i_look !='Y' and i_look !='N', remain,0) )/10)*10 , floor(sum( if( i_look = 'F', wongum,0) )/10)*10 into @total, @ing , @done
from
(
	select
		inv.loan_id, inv.wongum, tmp.Reimbursemented, loan.i_look, ifnull( wongum - ifnull(Reimbursemented,0),0) as remain
	from (
		select loan_id, sum(i_pay) as wongum from mari_invest
		where i_pay > 0 and i_pay_ment ='Y'
		group by loan_id
		) inv
	join mari_loan loan on inv.loan_id = loan.i_id and loan.i_view = 'Y'
	left join
	(select a.loan_id, sum( a.Reimbursement ) as Reimbursemented from z_invest_sunap a group by a.loan_id )  tmp on inv.loan_id = tmp.loan_id

) grp;
";
sql_query($sql, false);
$sql = "
select ifnull(sum(total),0) - ifnull( sum(Reimbursemented) , 0) into @yeonche
from
(
select
  	 loan_id , sum(i_pay) as total
  from mari_invest inva
  join(
  	select mari_loan_overdue.fk_loan_id from mari_loan_overdue where startdate < date_format( DATE_SUB( NOW() , INTERVAL 30 DAY ), '%Y-%m-%d') and startdate >= date_format( DATE_SUB( NOW() , INTERVAL 90 DAY ), '%Y-%m-%d')
  ) ov on inva.loan_id = ov.fk_loan_id
  group by loan_id
) grptmp
left join (
	select a.loan_id, sum( a.Reimbursement ) as Reimbursemented from z_invest_sunap a group by a.loan_id
	)  tmp on grptmp.loan_id = tmp.loan_id
  ";
sql_query($sql, false);
$sql = "
select ifnull(sum(total),0) - ifnull( sum(Reimbursemented) , 0) into @budo
from
(
select
  	 loan_id , sum(i_pay) as total
  from mari_invest inva
  join(
  	select * from mari_loan_overdue where startdate < date_format( DATE_SUB( NOW() , INTERVAL 90 DAY ), '%Y-%m-%d')
  ) ov on inva.loan_id = ov.fk_loan_id
  group by loan_id
) grptmp
left join (
	select a.loan_id, sum( a.Reimbursement ) as Reimbursemented from z_invest_sunap a group by a.loan_id
	)  tmp on grptmp.loan_id = tmp.loan_id
";
sql_query($sql, false);
$sql = "
select @totalwithvpay total2,@remainwithvpay ing2,  @total as total, @ing as ing,@done as done,@yeonche as yeonche, @budo as budo
, round(@yeonche/@ing *100,2 ) as yeonchaeyul,  round(@budo/@ing *100,2 ) as budoyul
, round(@yeonche/@remainwithvpay *100,2 ) as yeonchaeyul2,  round(@budo/@totalwithvpay *100,2 ) as budoyul2
";
$allpay = sql_fetch($sql);
// /New

	//수익률
	$sql = "
	  select
	round(sum(a.i_loan_pay * a.i_year_plus) / sum(a.i_loan_pay) , 2) as top_plus
	from mari_loan a
	where i_view='Y'
	";
	$allpay['percent'] = sql_fetch($sql);
	$InstanceCache->set('allpay', $allpay, 300);
}

?>
{# new_header}
<style>
.page-header.header-small .container {
    padding-top: 10vh;
}
.page-header.header-small {
    height: 70vh;
    min-height: 70vh;
}
.movebgcolordiv .movebgcolor {
  position: absolute;
  z-index: 1;
  width: 100vw;
  height: 70vh;
  min-height: 70vh;
  background-color: #667db6;
  background-image: -webkit-linear-gradient(left top,#5d04a7,#00156b, #042b1d,#2098d1,#f44336);
  background-image: -moz-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
  background-image: -ms-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
  background-image: -o-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
  background-image: linear-gradient(to right, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
  background-size: 300% 300%;
  -webkit-animation: subtitle_bg 10s ease infinite;
  animation: subtitle_bg 10s ease infinite;
  opacity: .40;
  filter: alpha(opacity=40);
}
.title, .card-title, .info-title, .footer-brand, .footer-big h5, .footer-big h4, .media .media-heading {
  font-weight: 700;
  font-family: 'Nanum Gothic', sans-serif;
}

.main-raised{
margin-top: -150px
}

@media (min-width: 768px){

}
@media (min-width: 992px){

}
@media (min-width: 1200px){
}
#container {
    margin-top: 0;
}
.page-header:after{
  #opacity: .80;
  #filter: alpha(opacity=80);
}
</style>
<style>
/* text ani 2 */
svg.intro {
  #background: linear-gradient(135deg, #aa3bb1, #582a7e);
  max-width: 600px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
  #box-shadow: 0 30px 50px -20px #2e0642;
}
svg.intro .text {
  display: none;
}
svg.intro.go .text {
  font-family: Arial, sans-serif;
  font-size: 34px;
  text-transform: uppercase;
  display: block;
}
svg.intro.go .text.strokesmall{
  font-size: 26px;
}
svg.intro.go .text-stroke {
  fill: none;
  stroke: #FFF;
  stroke-width: 5.8px;
  stroke-dashoffset: -900;
  stroke-dasharray: 900;
  stroke-linecap: butt;
  stroke-linejoin: round;
  -webkit-animation: dash 2.5s ease-in-out forwards;
          animation: dash 2.5s ease-in-out forwards;
}
svg.intro.go .text-stroke:nth-child(2) {
  -webkit-animation-delay: .3s;
          animation-delay: .3s;
}
svg.intro.go .text-stroke:nth-child(3) {
  -webkit-animation-delay: .9s;
          animation-delay: .9s;
}
svg.intro.go .text-stroke-2 {
  stroke: #FFF;
  -webkit-animation-delay: 1.2s;
          animation-delay: 1.2s;
}
svg.intro.go .text-stroke:nth-child(5) {
  -webkit-animation-delay: 1.5s;
          animation-delay: 1.5s;
}
svg.intro.go .text-stroke:nth-child(6) {
  -webkit-animation-delay: 1.8s;
          animation-delay: 1.8s;
}

@-webkit-keyframes dash {
  100% {
    stroke-dashoffset: 0;
  }
}

@keyframes dash {
  100% {
    stroke-dashoffset: 0;
  }
}
</style>

<link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">

<div id="pageheader" class="page-header header-filter clear-filter header-small " data-parallax="true" filter-color="center_gradient" style="width:100vw;background-image: url('/pnpinvest/img/main_top_new.jpg');background-position: center center;background-size: cover;">
  <!--div class="movebgcolordiv">
    <div id="movebgcolor" class="movebgcolor"></div>
  </div-->
    <div class="container" style="width:100%">
        <div class="row">
            <div class="col-xs-12 text-center">
              <div>
                <!--div class="logoani" id="stage2"></div-->
              </div>
            </div>
        </div>
    </div>
    <svg id="intro2" class="intro" viewbox="0 0 200 86">
      <text text-anchor="start" x="10" y="30" class="text text-stroke" clip-path="url(#text1)">K-FUNDING</text>
      <text text-anchor="start" x="50" y="50" class="text text-stroke strokesmall" clip-path="url(#text2)">BeginningOf</text>
      <text text-anchor="start" x="10" y="70" class="text text-stroke" clip-path="url(#text3)">Trust.</text>
      <text text-anchor="start" x="10" y="30" class="text text-stroke text-stroke-2" clip-path="url(#text1)">K-FUNDING</text>
      <text text-anchor="start" x="10" y="50" class="text text-stroke text-stroke-2 strokesmall" clip-path="url(#text2)">BeginningOf</text>
      <text text-anchor="start" x="10" y="70" class="text text-stroke text-stroke-2" clip-path="url(#text3)">Trust.</text>
      <defs>
        <clipPath id="text1">
          <text text-anchor="start" x="10" y="30" class="text">K-FUNDING</text>
        </clipPath>
        <clipPath id="text2">
          <text text-anchor="start" x="10" y="50" class="text strokesmall">Beginning of</text>
        </clipPath>
        <clipPath id="text3">
          <text text-anchor="start" x="10" y="70" class="text">Trust.</text>
        </clipPath>
      </defs>
    </svg>
</div>

<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="main">
	<!-- main visual -->
	<!--div class="main_visual">
		<div class="container">
			<div>
				<p class="tp1">
					<span class="typing tp1-1">K funding</span>
					<span class="typing tp1-2">partners.</span>
				</p>
				<p class="typing tp2">
				Discover the K funding difference.
				</p>
			</div>
			<span class="scroll" data-target="#fintech"></span>
		</div>
	</div-->
  <style>
  @-webkit-keyframes subtitle_bg {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
@keyframes subtitle_bg {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
@-webkit-keyframes subtitle_bg {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
@keyframes subtitle_bg {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
  </style>
  <style>
    <?php
      $colorlist["WarmFlame"] = array( "#ff9a9e", "#fad0c4" );
      $colorlist["JuicyPeach"] = array( "#ffecd2", "#fcb69f" );
      $colorlist["LadyLips"] = array( "#ff9a9e", "#fecfef" );
      $colorlist["WinterNeva"] = array( "#a1c4fd", "#c2e9fb" );
      $colorlist["HeavyRain"] = array( "#cfd9df", "#e2ebf0" );
      $colorlist["CloudyKnoxville"] = array( "#fdfbfb", "#ebedee" );
      $colorlist["SaintPetersberg"] = array( "#f5f7fa", "#c3cfe2" );
      $colorlist["PlumPlate"] = array( "#667eea", "#764ba2" );
      $colorlist["EverlastingSky"] = array( "#fdfcfb", "#e2d1c3" );
      $colorlist["HappyFisher"] = array( "#89f7fe", "#66a6ff" );
      $colorlist["FlyHigh"] = array( "#48c6ef", "#6f86d6" );
      $colorlist["FreshMilk"] = array( "#feada6", "#f5efef" );
      $colorlist["GreatWhale"] = array( "#a3bded", "#6991c7" );
      $colorlist["AquaSplash"] = array( "#13547a", "#80d0c7" );
      $colorlist["CleanMirror"] = array( "#93a5cf", "#e4efe9" );
      $colorlist["CochitiLake"] = array( "#93a5cf", "#e4efe9" );
      $colorlist["PassionateBed"] = array( "#ff758c", "#ff7eb3" );
      $colorlist["EternalConstance"] = array( "#09203f", "#537895" );
      $colorlist["Nega"] = array( "#ee9ca7", "#ffdde1" );
      $colorlist["GentleCare"] = array( "#ffc3a0", "#ffafbd" );
      $colorlist["MorningSalad"] = array( "#B7F8DB", "#50A7C2" );


      foreach ($colorlist as $colname => $colors){
        ?>
        .header-filter[filter-color="<?php echo $colname?>"]:after {
          background: <?php echo $colors[0]?> ; /* Old browsers */
          background: -moz-linear-gradient(-45deg, <?php echo $colors[0]?> 0%, <?php echo $colors[1]?> 100%); /* FF3.6-15 */
          background: -webkit-linear-gradient(-45deg, <?php echo $colors[0]?>b 0%,<?php echo $colors[1]?> 100%); /* Chrome10-25,Safari5.1-6 */
          background: linear-gradient(135deg, <?php echo $colors[0]?> 0%,<?php echo $colors[1]?> 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
          filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='<?php echo $colors[0]?>', endColorstr='<?php echo $colors[1]?>',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
        }
        .background_<?php echo $colname?> {
            background: <?php echo $colors[0]?> ; /* Old browsers */
            background: -moz-linear-gradient(-45deg, <?php echo $colors[0]?> 0%, <?php echo $colors[1]?> 95%); /* FF3.6-15 */
            background: -webkit-linear-gradient(-45deg, <?php echo $colors[0]?>b 0%,<?php echo $colors[1]?> 95%); /* Chrome10-25,Safari5.1-6 */
            background: linear-gradient(135deg, <?php echo $colors[0]?> 0%,<?php echo $colors[1]?> 95%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='<?php echo $colors[0]?>', endColorstr='<?php echo $colors[1]?>',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
        }
        <?
      }
    ?>
    .header-filter[filter-color="center_gradient"]:after {
      background: -moz-linear-gradient(left, rgba(69, 219, 255, 0.37) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(69, 219, 255, 0.37) 100%); /* FF3.6-15 */
      background: -webkit-linear-gradient(left, rgba(0,0,0,0.92) 0%,rgba(69, 219, 255, 0.37) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(69, 219, 255, 0.37) 100%); /* Chrome10-25,Safari5.1-6 */
      background: linear-gradient(to right,rgba(69, 219, 255, 0.37) 0%,rgba(255, 255, 255, 0.22) 40%,rgba(255, 255, 255, 0.22) 60%,rgba(69, 219, 255, 0.37) 100%);/* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
      filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#eb000000', endColorstr='#eb000000',GradientType=1 ); /* IE6-9 */
    }
    .header-filter.move:before {
        position: absolute;
        z-index: 1;
        width: 100vw;
        height: 100%;
        min-height: 70vh;
        background-color: #667db6;
        background-image: -webkit-linear-gradient(left top,#5d04a7,#00156b, #042b1d,#2098d1,#f44336);
        background-image: -moz-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
        background-image: -ms-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
        background-image: -o-linear-gradient(left top, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
        background-image: linear-gradient(to right, #5d04a7,#00156b, #042b1d,#2098d1,#f44336);
        background-size: 300% 300%;
        -webkit-animation: subtitle_bg 10s ease infinite;
        animation: subtitle_bg 10s ease infinite;
        opacity: .30;
        filter: alpha(opacity=30);
    }
  </style>

<style>
body{
  width:100vw;
}
.top_header {
  margin-top: 0px;
  height: 30vh;
  margin: 0;
  padding:0;
}
.top_header > div {
  height:100%;
}
/* ani css */
.logoani{
  width:100%;
  height:100%;
}
.logostage{
  padding: 0;
  margin: 0;
  position: absolute;
  z-index:10;
  #top: 120px;
  top: 50px;
      width: 100%;
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
<style>

/*
|--------------------------------------------------------------------------
| CSS Text Mask
|--------------------------------------------------------------------------
*/
.table {
	display: table;
	height: 100%;
	width: 100%;
}

.table-cell {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
}

h1.masking,
#svgPath text {
  font-family: 'Black Ops One', cursive;
	font-size: 300px;
	font-weight: 900;
  line-height: 250px;
}
h1.masking {
	background-image: url(/assets/color.JPG);
	-webkit-background-clip: text;
	background-clip: text;
	color: transparent;
}

.webkit {
	display: block;
}

.ff {
	display: none;
}

@-moz-document url-prefix() {
	.webkit {
		display: none;
	}

	.ff {
		display: block;
	}
}
</style>
<style>
/*top safety*/
.top_safety_wrap{
  color:#006691;
  width:100%;
  height:100%;
  position: relative;
  overflow: hidden;
}
.top_safety_box{
  margin: auto;
  position: absolute;
  width:550px;
  height:90px;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
}
.top_safety_box:after{
  clear:both;
}
.float-left{
  display:inline-block;
  position: relative;
  float:left;
  z-index: 10;
}
.top_safety_icon{
  padding-top: 10px;
    vertical-align: top;
}
.top_satety_title_first
{
  font-size: 38px;
  font-weight: 200;
  margin-top: -2px;
}
.top_satety_title_first span.bold{
  font-size: 46px;
  font-weight: 400;
}
.top_satety_title_second{
  font-size: 14px;
  text-align: right;
  padding-right: 10px;
  margin-top: -8px;
}

.top_safety_btn .btn{
  background-color: transparent;
  color: #006691;
  border: 1px solid #006691;
  padding: 8px 40px;
  letter-spacing: 1px;
  font-size: 18px;
  margin: 22px 0 0 25px;
}
  @media (max-width: 600px){
    .top_safety_box{
      width:364px;
      height:160px;
    }
    .top_safety_btn.float-left{
      clear:both;
      position: static;
      display: block;
      width: 100%;
    }
  }
/* -- / top safety--*/
</style>
  <div class="row top_header" style="min-height:206px;">
    <div class="col-md-8" style="background-color:#fefde5; text-align:center;">
      <div class="top_safety_wrap">
        <div class="top_safety_box float-left">
            <div class="top_safety_icon float-left">
              <img src="/pnpinvest/img/top_safety_icon.png">
            </div>
            <div class="top_satety_title float-left">
              <div class="top_satety_title_first"><span class="bold">S</span>afety <span class="bold">G</span>uide <span class="bold">P</span>lan</div>
              <div class="top_satety_title_second">투자금 안전 플랜</div>
            </div>
            <div class="top_safety_btn float-left">
              <a href="#" class="btn top_safety_button">상세보기</a>
            </div>
        </div>
      </div>
    </div>

<style>
.top_safety_wrap2{
  width: 100%;
  height: 100%;
  margin: -3px;
}
.top_safety_wrap2_col{
  position: relative;
  width: 47%;
  height: 48%;
  float: left;
    background-color: rgba(202, 202, 202, 0.12);
  margin: 3px;
  border-radius: 8px;
  -webkit-transition: background-color 2s, -webkit-transform 2s;
  transition:background-color 2s, transform 2s;
}
.top_safety_wrap2_inner{
  margin: auto;
  position: absolute;
  text-align:center;
  width:58px;
  height:80px;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
}
.top_safety_wrap2_col:hover{
  background-color: rgba(255, 255, 255, 0.5);
  -webkit-transition: background-color 1s, -webkit-transform 2s;
  transition:background-color 1s, transform 2s;
}
.top_safety_wrap2_col:hover .top_safety_wrap2_inner{
  width:62px;
  height:90px;
  -webkit-transition: width 0.5s,height 0.5s, -webkit-transform 2s;
  transition:width 0.5s, height 0.5s, transform 0.5s;
}

@-webkit-keyframes neweffect {
  16.65% {
    -webkit-transform: skewx(10deg) ;
    transform: skewx(10deg) ;
  }
  33.3% {
    -webkit-transform: skewx(-8deg) ;
    transform: skewx(-8deg) ;
  }
  49.95% {
    -webkit-transform: skewx(6deg) ;
    transform: skewx(6deg) ;
  }
  66.6% {
    -webkit-transform: skewx(-5deg) ;
    transform: skewx(-5deg) ;
  }
  83.25% {
    -webkit-transform: skewx(3deg) ;
    transform: skewx(3deg) ;
  }
  100% {
    -webkit-transform: skewx(0deg) ;
    transform: skewx(0deg) ;
  }
}
@keyframes neweffect {
  16.65% {
    -webkit-transform: skewx(10deg) ;
    transform: skewx(10deg) ;
  }
  33.3% {
    -webkit-transform: skewx(-8deg) ;
    transform: skewx(-8deg) ;
  }
  49.95% {
    -webkit-transform: skewx(6deg) ;
    transform: skewx(6deg) ;
  }
  66.6% {
    -webkit-transform: skewx(-5deg) ;
    transform: skewx(-5deg) ;
  }
  83.25% {
    -webkit-transform: skewx(3deg) ;
    transform: skewx(3deg) ;
  }
  100% {
    -webkit-transform: skewx(0deg) ;
    transform: skewx(0deg) ;
  }
}

.top_safety_wrap2_col:hover .top_safety_wrap2_inner .twit{
  -webkit-animation-name: neweffect;
  animation-name: neweffect;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
}

</style>
    <div class="col-md-4 hidden-sm hidden-xs" filter-color="ViciousStance" style="background-color: #e5fef4;padding: 10px;">
      <div class="top_safety_wrap2">
        <div class="top_safety_wrap2_col">
          <a href="" class="top_safety_wrap2_inner"><i class="twit fab fa-connectdevelop" style="font-size:50px;"></i><p style="font-size:14px;padding-top:10px;text-align:center;">공지사항</p></a>
        </div>
        <div class="top_safety_wrap2_col">
          <a href="" class="top_safety_wrap2_inner"><span class="twit mbri-image-gallery" style="font-size:50px;"></span><p style="font-size:14px;padding-top:10px;text-align:center;">갤러리</p></a>
        </div>
        <div class="top_safety_wrap2_col">
          <a href="" class="top_safety_wrap2_inner"><span class="twit mbri-contact-form" style="font-size:50px;"></span></span><p style="font-size:14px;padding-top:10px;text-align:center;">언론보도</p></a>
        </div>
        <div class="top_safety_wrap2_col">
          <a href="" class="top_safety_wrap2_inner"><span class="twit mbri-edit" style="font-size:50px;"></span></span><p style="font-size:14px;padding-top:10px;text-align:center;">문의하기</p></a>
        </div>
      </div>
      <!--div style="width:100%;height:100%;dispaly:inline-block;">
        <div style="width: 50%;height: 50%;position: relative;float:left;   display: inline-block;   text-align: center;   border-right: 1px solid #FFF;   border-bottom: 1px solid #FFF;   margin: auto; ">
          <a href="">
            <img src="/pnpinvest/img/01_main_icon.png" class="hvr-wobble-to-bottom-right" style="margin-top: 10px;">
            <p style="color:white">공지사항</p>
          </a>
        </div>
        <div style="width: 50%;height: 50%;position: relative;float:left;  display: inline-block;   text-align: center;   border-bottom: 1px solid #FFF;   margin: auto;">
          <a href="">
            <img src="/pnpinvest/img/02_main_icon.png" class="hvr-wobble-to-top-right" style="margin-top: 10px;">
            <p style="color:white">캐스트</p>
          </a>
        </div>
        <div class="clear:both"></div>
        <div style="width: 50%;height: 50%;position: relative;float:left;   display: inline-block;   text-align: center;   border-right: 1px solid #FFF;   margin: auto;">
          <a href="">
            <img src="/pnpinvest/img/03_main_icon.png" class="hvr-wobble-to-top-right" style="margin-top: 10px;">
            <p style="color:white">언론보도</p>
          </a>
        </div>
        <div style="width: 50%;height: 50%;position: relative;float:left;  display: inline-block;   text-align: center;   margin: auto;">
          <a href="">
            <img src="/pnpinvest/img/04_main_icon.png" class="hvr-wobble-to-bottom-right" style="margin-top: 10px;">
            <p style="color:white">문의하기</p>
          </a>
        </div>
      </div-->

    </div>
  </div>

	<!-- Fintech -->
	<div id="fintech" class="main_section fintech">
		<div class="container">
      <!--
			<h3 class="motion" data-animation="fadeInUp" data-animation-delay="300">
				<span class="sec_title t1"><img src="img/mt_fintech_w.png" alt="Fintech"></span>
			</h3>
    -->
    <div class="container safeguideplan" id="safeguideplandiv" style="padding-bottom:0">
      <div class="safeguideplan-head" style="text-align:left;">
          FINECH
        </div>
    </div>
			<div class="main_product">
<?php foreach ($z_loaninfo as $row) { ?>
<!-- item -->
				<div class="item">
					<p class="timeout <?php echo (in_array($row['i_look'], array('N'))) ? 'item_time':''; ?>" data-loan_id="<?php echo $row['i_id']?>" data-loan_look="<?php echo $row['i_look']?>" style="display:none" <?php echo (!in_array($row['i_look'], array('N'))) ? 'style="display:none"':''; ?>>
						<i class="clock"></i>
						<span class="txt">이 상품의 투자시작 시간이 <span></span></span>
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
							<p class="img_wrap"><span class="img img_w"><img src="/pnpinvest/data/photoreviewers/<?php echo $row['i_id']?>/<?php echo $row['mainpost']?>" alt></span></p>
							<p class="txt"><span class="date fl"><?php $row['i_mainimg_txt1_date']?><?php echo $row['i_mainimg_txt1']?></span><span class="time fr"> <?php echo $row['i_mainimg_txt2']?></span></p>
						</div>
						<div class="item_info info2 fr">
							<h4>
								<a href="/pnpinvest/?mode=invest_view&loan_id=<?php echo $row['i_id']?>">
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
								<span class="ib center event1" style="background-color: #006691;"><?php echo $row['i_mainimg_txt3']?> <?php echo $row['i_mainimg_txt4']?></span>
								<span class="ib center event2" style="background-color: #00ae9d;"><?php echo $row['i_mainimg_txt5']?><?php echo ($row['i_mainimg_txt6']!='')?'/'.$row['i_mainimg_txt6']:''?></span>
							</p>
						</div>
					</div>
				</div>
	<!-- / item -->
	<?php } ?>

			</div>
      <style>
      .btn.t4 {
            border-color: #006691;
            background-color: #fff;
            color: #006691;
        }
        .btn.t4:hover{
          background-color: #006691;
        }
        .number .date {
          background-color: #006691;
        }
      </style>
			<a class="btn t4 f1 w200 " href="/pnpinvest/?mode=invest" style="border: 1px solid #006691;">투자상품 전체보기</a>
		</div>
	</div>
	<!-- 현재 투자 건수 -->
	<div class="number">
		<div class="container">
			<h3 class="motion" data-animation="fadeInUp" data-animation-delay="300">현재까지 <strong><span class="counter"><?php echo $allpay['nujuk']['cnt']?></span>건</strong>의 투자가 이루어졌습니다.</h3>
			<span class="date"><?php echo date('Y년 m월 d일 H:i')?> 기준</span>
			<table class="number_con">
				<caption>투자 현황</caption>
				<colgroup>
					<col style="width:40%;">
					<col style="width:60%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">누적 투자금</th>
						<td><span class="counter"><?php echo number_format($allpay['total2']) ?></span>원</td>
					</tr>
					<tr>
						<th scope="row">대출 잔액</th>
						<td><span class="counter"><?php echo number_format($allpay['ing2']) ?></span>원</td>
					</tr>
					<tr>
						<th scope="row">평균 수익률</th>
						<td><span class="counter"><?php echo $allpay['percent']['top_plus'] ?></span>%</td>
					</tr>
				</tbody>
			</table>
			<table class="number_con2">
				<caption>연체율과 부도율</caption>
				<colgroup>
					<col style="width:50%;">
					<col style="width:50%;">
				</colgroup>
				<thead>
					<th scope="col" style="text-align: center;">
						<span class="tt">연체율</span>
						<p class="txt">연체율 안내 문구를 넣어주세요.
							<br><span class="btn t5 close">닫기</span>
						</p>
					</th>
					<th scope="col" style="text-align: center;"><span class="tt">부도율</span>
						<p class="txt">부도율 안내 문구를 넣어주세요.
							<br><span class="btn t5 close">닫기</span>
						</p>
					</th>
				</thead>
				<tbody>
					<td><?php echo (isset($allpay['yeonchaeyul'])&& $allpay['yeonchaeyul']!='') ? $allpay['yeonchaeyul'] : 0 ?>%</td>
					<td><?php echo (isset($allpay['budoyul'])&& $allpay['budoyul']!='') ? $allpay['budoyul'] : 0 ?>%</td>
				</tbody>
			</table>
		</div>
	</div>
	<!-- Safety -->
  <link rel="stylesheet" href="css/bootstraptable.css" type="text/css">

  <style>
  .btn-boot{
    display:block;
    border: none;
    border-radius: 6px;
    position: relative;
    padding: 12px 30px;
    margin: 0 1px 10px 1px;
    font-size: 12px;
    font-weight: 400;
    text-transform: uppercase;
    letter-spacing: 0;
    will-change: box-shadow, transform;
    transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .btn-boot.btn-color1 {
      background-color: #00ae9d;
      color: #FFFFFF;
      box-shadow: 0 2px 2px 0 rgba(6, 108, 132, 0.14), 0 3px 1px -2px rgba(6, 108, 132, 0.14), 0 1px 5px 0 rgba(6, 108, 132, 0.14);
  }
  .btn-boot.btn-round{
    border-radius: 6px
  }
  .btn-boot.btn-outline{
        border: 1px solid #066c84
  }

  .safeguideplan{
    padding: 90px 10px;
    max-width: 900px;
  }
  .safeguideplan-head:before{
    content: '';
    height: 35px;
    width: 10px;
    background-color: #066C84;
    display: inline-block;
    border-radius: 4px;
    margin-right:10px;
    position: relative;
    /* margin-top: -3px; */
    top: 6px;
  }
  .safeguideplan .safeguideplan-head{
    #text-align: center;
    font-size: 34px;
    font-weight: 800;
    color: #066C84;
    margin-bottom : 45px;
  }

  .safeguideplan .plan_now{
    font-size: 22px;
        text-align: center;
        letter-spacing: 3px;
        padding: 16px;
        margin-bottom: 10px;
        font-weight: 300;
  }
  .safeguideplan .plan_view{
    font-size: 22px;
    font-weight: 300;
    text-align: center;
    letter-spacing: 2px;
    padding: 14px;
    margin-bottom: 20px;
    border: 1px solid #006691;
    color: #006691;
    background-color: white;
    box-shadow: 0 2px 2px 0 rgba(207, 216, 220, 0.14), 0 3px 1px -2px rgba(207, 216, 220, 0.14), 0 1px 5px 0 rgba(207, 216, 220, 0.14);
  }
.safeguideplan .plan-desc{
    text-align: center;
  }
  </style>

  <style>
  .planwrap{
    height:566px;
  }
  .planbox{
    width:567px;
    height:567px;
    display: inline-block;
    position: absolute;
    background: url(/pnpinvest/img/safety_back.png) no-repeat;;
    background-position: center;
        margin: auto;
        top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
  }
  .planbox-box{
    text-align: center;
  }
  .planbox-box .pboxline1 span{
    padding: 7px 20px;
    border: 1px solid #006691;
    border-radius: 30px;
    font-size: 16px;
    color: #006691;
    background-color:white;
  }
  .planbox-box .pboxline2{
    color: #00ae9d;
    font-size: 18px;
    margin-top: 10px;
  }
  .planbox-box .pboxline3{
    color:black;
    font-size:22px;
  }
  .planbox-box .pboxline4{
    color:black;
    font-size:26px;
  }
  .box01{
    margin-top: 10px;
    background-color: white;
    display: inline-block;
    margin: 10px auto;
    width: 155px;
    position: relative;
    left: 50%;
    transform: translateX(-50%);
  }
.innerbox_bottom {
    position: absolute;
    bottom: 50px;
    width: 100%;
  }
  .box02{
    display: inline-block;
    background-color: white;
  }
  .box03{
    display: inline-block;
    float: right;
    background-color: white;
  }
  @media (max-width: 620px){
    .safeguideplan .safeguideplan-head {
      margin-bottom :10px;
    }
    .planbox{
      background: none;
      width: 100vw;
      height: auto;
    }
    .planbox-box{
      width: 90%;
      border: 1px solid #00ae9d;
      border-radius: 80px;
      padding: 10px;
    }
    .box01{
      display: block;
      position: static;
      left: auto;
      transform: translateX(0);
      margin: 20px 5%;
    }
    .planbox-box .pboxline1 span {
      border:0;
    }
    .innerbox_bottom {
      position: static;
    }
    .box02{
      position: static;
      display: block;
      float: none;
          margin: 20px 5%;
    }
    .box03{
      position: static;
          display: block;
          float: none;
              margin: 20px 5%;
    }
    .planbox-box .pboxline1 span {
      color : #00ae9d;

    }
    .planbox-box .pboxline2 {
      color: black;
    }
    .planbox-box .pboxline3 {
      color: #006691;
    }
    .planbox-box .pboxline4 {
      color: #006691;
    }
  }
  </style>
  <div>
    <div class="container safeguideplan">
      <div class="safeguideplan-head">
        Safety Guide Plan
      </div>
      <div>
        <div class="row">
          <div class="col-xs-12 planwrap">
            <div class="planbox">
              <div class="planbox-box box01">
                <div class="pboxline1"><span>Plan 01</span></div>
                <div class="pboxline2">케이펀딩 출자금</div>
                <div class="pboxline3">최초 적립금</div>
                <div class="pboxline4">50,000,000원</div>
              </div>
              <div class="innerbox_bottom">
                <div class="planbox-box box02">
                  <div class="pboxline1"><span>Plan 02</span></div>
                  <div class="pboxline2">투자자 플랫폼 이용료</div>
                  <div class="pboxline3">플랫폼 수수료</div>
                  <div class="pboxline4">0.1% 적립</div>
                </div>

                <div class="planbox-box box03">
                  <div class="pboxline1"><span>Plan 02</span></div>
                  <div class="pboxline2">투자자 플랫폼 이용료</div>
                  <div class="pboxline3">플랫폼 수수료</div>
                  <div class="pboxline4">0.1% 적립</div>
                </div>
              </div>



            </div>
          </div>
        </div>


<?php
  $sql = "select * from z_main_design where idx=1 limit 1";
  $main_design = sql_fetch($sql);
?>
        <div class="row">
          <div class="col-xs-12 col-sm-8 col-sm-offset-2" style="padding-top: 18px;">
            <a href="javascript:;" class="btn-boot btn-color1 btn-round plan_now modal-link" data-title="Safety Guide Plan" data-url2="/api/safetyguide" data-img="/pnpinvest/data/safetyplan/<?php echo $main_design['img']?>">
              현재 <?php echo number_format($main_design['nowplan']) ?>원 <i class="fab fa-superpowers"></i>
              <span><span>
            </a>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12 col-sm-8 col-sm-offset-2">
            <a href="/pnpinvest/?mode=companyintro01#safety" class="btn-boot btn-round btn-outline plan_view">
              세이프 플랜 상세
              <span><span>
            </a>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <div class="plan-desc">
              <span>적립금은 회사 운영 계좌와 완전히 분리되며, 적립금의 납입과 원금 손신 보전을 위한 용도 외에는 입출금은 일어나지 않습니다.</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
	<!--div class="main_section safety">
		<div class="container clearfix">
			<h3 class="motion" data-animation="fadeInUp" data-animation-delay="300">
				<span class="sec_title t2"><img src="img/mt_safety_w.png" alt="Safety"></span>
			</h3>
			<div class="safety_item">
				<div class="sfi sf_1 motion" data-animation="fadeInLeft" data-animation-delay="300">
					<p class="txt">체계성 - 투자상품 거래 및 운용 프로세스 구축</p>
				</div>
				<div class="sfi sf_2 motion" data-animation="fadeInDown" data-animation-delay="600">
					<p class="txt">혁신성 - 고객이 필요한 니즈 반영</p>
				</div>
				<div class="sfi sf_3 motion" data-animation="fadeInRight" data-animation-delay="900">
					<p class="txt">다양성 - 다양한 투자상품 개발 및 운용</p>
				</div>
				<div class="sfi sf_4 motion" data-animation="fadeInUp" data-animation-delay="1200">
					<p class="txt">전문성 - 전문적인 심사와 사후관리 시스템 진행</p>
				</div>
				<div class="sfi sf_5 motion" data-animation="fadeInLeft" data-animation-delay="1500">
					<p class="txt">안전성 - 투자자의 리스크 최소화</p>
				</div>
			</div>
			<div class="safety_item_m motion" data-animation="fadeInUp" data-animation-delay="600">
				<p class="txt">체계성 - 투자상품 거래 및 운용 프로세스 구축</p>
				<p class="txt">혁신성 - 고객이 필요한 니즈 반영</p>
				<p class="txt">다양성 - 다양한 투자상품 개발 및 운용</p>
				<p class="txt">전문성 - 전문적인 심사와 사후관리 시스템 진행</p>
				<p class="txt">안전성 - 투자자의 리스크 최소화</p>
			</div>
			<a class="btn t4 f1 w200 more" href="/pnpinvest/?mode=companyintro01">케이펀딩 회사소개</a>
		</div>
	</div-->
	<!-- 회원 등록 -->
  <style>
    .main_join {
      padding: 50px 0;
      background-color: #f5f5f5;
      color: #006691;
      text-align: center;
      font-size: 20px;
      font-weight: 200;
  }
  .btn.t2 {
      border-color: #006691;
      background-color: #006691;
      color: #fff;
  }
  </style>
	<div class="main_join">
		<div class="container">
			<p>빠르게 마감되는<br>케이펀딩 파트너스의 투자 상품,<br>놓치지 않으려면?</p>
			<a class="btn t2 w200 f1" href="/pnpinvest/?mode=mypage_modify">SNS 알림받기</a>
			<a class="btn t2 w200 f1" href="http://pf.kakao.com/_FcJxcC"  target="_blank">카카오톡 친구추가</a>
		</div>
	</div>
  <!-- guide -->
  <?php
  $box_wrap = 390;
  $box_shadow = 370;
  $box_content = 290;
  $rand = ($box_wrap - $box_shadow)/2;
  $rand2 = 1;
  ?>
  <style>
  .z_box_wrap{height:600px; width:780px; position: relative;margin: 10px auto;}


  .z_box {
  	position: absolute;
  	width: <?php echo $box_wrap;?>px;
  	height: <?php echo $box_wrap;?>px;
  	opacity: .94;
  	filter: alpha(opacity=94);
  }
  .z_box.zbox1 {
  	top: 50px;
  	right : 20px;
  }
  .z_box.zbox2 {
  	top: 210px;
  	right : 180px;
  }
  .z_box.zbox3 {
  	top: 320px;
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
  		border:2px solid #00ae9d;
  }
  .z_box.zbox2 .z_box_shadow{
  		border:2px solid #666;
  }
  .z_box.zbox3 .z_box_shadow{
  		border:2px solid #006691;
  }

.z_box_content{
  background-size: cover;
background-position: center;
}
  .z_box.zbox1 .z_box_content{
  	background-color:#00ae9d;
    background-image: url(/pnpinvest/img/guide01.png);
  }
  .z_box.zbox2 .z_box_content{
  	background-color:#666;
        background-image: url(/pnpinvest/img/guide02.png);
  }
  .z_box.zbox3 .z_box_content{
  	background-color:#006691;
        background-image: url(/pnpinvest/img/guide03.png);
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
    top: 31px;
        left: 37px;
  }
  .z_box_shadow.sa5{
  	top: 19px ;
  	left:24px;
  }

  .z_box:hover .z_box_shadow.sa1
  {
  	opacity: 1;
  	-webkit-transition: opacity 0.5s ease-in-out, -webkit-transform 0.5s;
  	-moz-transition: opacity 0.5s ease-in-out;
  	transition: opacity 0.5s ease-in-out, transform 0.5s;
    -webkit-transform:rotate(-5deg);
    transform:rotate(-5deg);
  }
  .z_box:hover .z_box_shadow.sa2
  {
  	opacity: 1;
  	-webkit-transition: opacity 0.9s ease-in-out, -webkit-transform 0.5s;
  	-moz-transition: opacity 0.9s ease-in-out;
  	transition: opacity 0.9s ease-in-out, transform 0.5s;
    -webkit-transform:rotate(4deg);
    transform:rotate(4deg);
  }
  .z_box:hover .z_box_shadow.sa3
  {
  	opacity: 1;
  	-webkit-transition: opacity 1.5s ease-in-out, -webkit-transform 0.5s;
  	-moz-transition: opacity 1.5s ease-in-out, -webkit-transform 0.5s;
  	transition: opacity 1.5s ease-in-out, transform 0.5s;
    -webkit-transform:rotate(-2deg);
    transform:rotate(-2deg);
  }
  .z_box:hover .z_box_shadow.sa4
  {
  	opacity: 1;
  	-webkit-transition: opacity 0.1s ease-in-out, -webkit-transform 0.5s;
  	-moz-transition: opacity 0.1s ease-in-out;
  	transition: opacity 0.1s ease-in-out, transform 0.3s;
    -webkit-transform:rotate(8deg);
    transform:rotate(8deg);
  }
  .z_box:hover .z_box_shadow.sa5
  {
  	opacity: 1;
  	-webkit-transition: opacity 1.1s ease-in-out;
  	-moz-transition: opacity 1.1s ease-in-out;
  	transition: opacity 1.1s ease-in-out;
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
  	background-color: #e0e017;
  	box-shadow: 0 2px 2px 0 rgba(6, 108, 132, 0.14), 0 3px 1px -2px rgba(6, 108, 132, 0.14), 0 1px 5px 0 rgba(6, 108, 132, 0.14);
  	text-align: center;
  	padding: 8px 0;
  	font-size: 16px;
    color:white;
  }
  .zbox1 .boxlabel{
  	background-color: #006691;
  }
  .zbox2 .boxlabel{
  	background-color: #a5a5a5;
  }
  .zbox3 .boxlabel{
    background-color: #49c9ff;
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
    right: 20px;
  	width: 270px;
    -webkit-transition: width 0.3s  ease-in-out, right 0.6s ease-in-out;
  	-moz-transition: width 0.3s  ease-in-out, right 0.6s ease-in-out;
  	transition: width 0.3s  ease-in-out, right 0.6s ease-in-out;
  }
  .guidediv{
    overflow: hidden;
  }
  .guide_inner_div{
    height:800px;
  }

  @media (max-width: 780px){
    .guide_inner_div {
        height: 1100px;
    }
    .z_box_shadow{display:none;}
    .z_box_wrap{width:100%;}
    .z_box{position: relative;width:<?php echo $box_content;?>px;height:<?php echo $box_content;?>px;margin:30px auto;}
    .z_box.zbox1 {top:0;right:auto;left:auto;}
    .z_box.zbox2 {top:0;right:auto;left:auto;}
    .z_box.zbox3 {top:0;right:auto;left:auto;}
    .z_box .z_box_content {top:0;right:auto;left:auto;margin: 0 auto;}
    .boxlabel{
      top: auto;
      bottom: -16px;
      opacity: .90;
      filter: alpha(opacity=90);
      right: <?php echo ($box_content-130)/2;?>px;
    }
  }
  </style>
  <div class="guidediv">
    <div class="container safeguideplan" style="padding-bottom:0">
      <div class="safeguideplan-head"  style="margin-bottom:0">
          대출가이드
        </div>
    </div>
  	<div class="guide_inner_div">
  		<div class="z_box_wrap">
  			<div class="z_box zbox1">
  				<div class="z_box_inner">
  					<div class="z_box_shadow sa1"></div>
  					<div class="z_box_shadow sa2"></div>
  					<div class="z_box_shadow sa3"></div>
  					<div class="z_box_shadow sa4"></div>
  					<div class="z_box_shadow sa5"></div>

  					<div class="z_box_content">
  						<div class="boxlabel">F A Q	</div>
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
  						<div class="boxlabel">투자가이드	</div>
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
	<!-- Profits -->
	<!--div class="main_section profits">
		<div class="container">
			<h3 class="motion" data-animation="fadeInUp" data-animation-delay="300">
				<span class="sec_title t3"><img src="img/mt_profits_w.png" alt="Profits"></span>
			</h3>
			<div class="profits_item">
				<div class="pfi pf_1 motion2" data-animation-delay="1600">
					<span class="txt">1위 케이펀딩 케이펀딩 평균수익률 <?php echo $allpay['percent']['top_plus'] ?>%</span>
				</div>
				<div class="pfi pf_2 motion" data-animation="fadeInLeft" data-animation-delay="1100">
					<span class="txt">국내펀드 6%</span>
				</div>
				<div class="pfi pf_3 motion" data-animation="fadeInLeft" data-animation-delay="800">
					<span class="txt">저축은행 적금 2.6%</span>
				</div>
				<div class="pfi pf_4 motion" data-animation="fadeInUp" data-animation-delay="500">
					<span class="txt">제1금융권 은행적금 1.54%</span>
				</div>
				<div class="pfi pf_5 motion" data-animation="fadeInRight" data-animation-delay="200">
					<span class="txt">국내CMA 1.38%</span>
				</div>
				<span class="pfi pf_sd motion" data-animation="fadeInRight" data-animation-delay="1600">
			</div>
			<div class="profits_item_m motion" data-animation="fadeInUp" data-animation-delay="600">
				<p class="txt">1위 케이펀딩 케이펀딩 평균수익률 18%</p>
				<p class="txt">국내펀드 6%</p>
				<p class="txt">저축은행 적금 2.6%</p>
				<p class="txt">제1금융권 은행적금 1.54%</p>
				<p class="txt">국내CMA 1.38%</p>
			</div>
			<a class="btn t4 f1 w200 more" href="/pnpinvest/?mode=invest">투자상품 전체보기</a>
		</div>
	</div-->

<!-- graph -->
<style>
.fade {
    opacity: 0;
    -webkit-transition: opacity .15s linear;
    -o-transition: opacity .15s linear;
    transition: opacity .15s linear;
}
.fade.in {
    opacity: 1;
}
.progress-bar {
  float: left;
  width: 0;
  height: 100%;
  font-size: 12px;
  line-height: 20px;
  color: #fff;
  text-align: center;
  background-color: #337ab7;
  -webkit-box-shadow: inset 0 -1px 0 rgba(0, 0, 0, .15);
          box-shadow: inset 0 -1px 0 rgba(0, 0, 0, .15);
  -webkit-transition: width .6s ease;
       -o-transition: width .6s ease;
          transition: width .6s ease;
}
.progress-striped .progress-bar,
.progress-bar-striped {
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:      -o-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:         linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  -webkit-background-size: 40px 40px;
          background-size: 40px 40px;
}
.progress.active .progress-bar,
.progress-bar.active {
  -webkit-animation: progress-bar-stripes 2s linear infinite;
       -o-animation: progress-bar-stripes 2s linear infinite;
          animation: progress-bar-stripes 2s linear infinite;
}
.progress-bar-success {
  background-color: #5cb85c;
}
.progress-striped .progress-bar-success {
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:      -o-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:         linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
}
.progress-bar-info {
  background-color: #5bc0de;
}
.progress-striped .progress-bar-info {
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:      -o-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:         linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
}
.progress-bar-warning {
  background-color: #f0ad4e;
}
.progress-striped .progress-bar-warning {
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:      -o-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:         linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
}
.progress-bar-danger {
  background-color: #d9534f;
}
.progress-striped .progress-bar-danger {
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:      -o-linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
  background-image:         linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
}
.progress {
  background-color:#dadada;
}
.progress .progress-bar, .progress .progress-bar.progress-bar-default {
    background-color: #a5a5a5;
}
.tooltip {
  position: absolute;
  z-index: 1070;
  display: block;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 12px;
  font-weight: normal;
  line-height: 1.4;
  filter: alpha(opacity=0);
  opacity: 0;
}
.tooltip.in {
  filter: alpha(opacity=90);
  opacity: .9;
}
.tooltip.top {
  padding: 5px 0;
  margin-top: -3px;
}
.tooltip.right {
  padding: 0 5px;
  margin-left: 3px;
}
.tooltip.bottom {
  padding: 5px 0;
  margin-top: 3px;
}
.tooltip.left {
  padding: 0 5px;
  margin-left: -3px;
}
.tooltip-inner {
  min-width: 90px;
  padding: 3px 8px;
  color: #fff;
  text-align: center;
  text-decoration: none;
  background-color: #000;
  border-radius: 4px;
}
.tooltip-arrow {
  position: absolute;
  width: 0;
  height: 0;
  border-color: transparent;
  border-style: solid;
}
.tooltip.top .tooltip-arrow {
  bottom: 0;
  left: 50%;
  margin-left: -5px;
  border-width: 5px 5px 0;
  border-top-color: #000;
}
.tooltip.top-left .tooltip-arrow {
  right: 5px;
  bottom: 0;
  margin-bottom: -5px;
  border-width: 5px 5px 0;
  border-top-color: #000;
}
.tooltip.top-right .tooltip-arrow {
  bottom: 0;
  left: 5px;
  margin-bottom: -5px;
  border-width: 5px 5px 0;
  border-top-color: #000;
}
.tooltip.right .tooltip-arrow {
  top: 50%;
  left: 0;
  margin-top: -5px;
  border-width: 5px 5px 5px 0;
  border-right-color: #000;
}
.tooltip.left .tooltip-arrow {
  top: 50%;
  right: 0;
  margin-top: -5px;
  border-width: 5px 0 5px 5px;
  border-left-color: #000;
}
.tooltip.bottom .tooltip-arrow {
  top: 0;
  left: 50%;
  margin-left: -5px;
  border-width: 0 5px 5px;
  border-bottom-color: #000;
}
.tooltip.bottom-left .tooltip-arrow {
  top: 0;
  right: 5px;
  margin-top: -5px;
  border-width: 0 5px 5px;
  border-bottom-color: #000;
}
.tooltip.bottom-right .tooltip-arrow {
  top: 0;
  left: 5px;
  margin-top: -5px;
  border-width: 0 5px 5px;
  border-bottom-color: #000;
}
.popover {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 1060;
  display: none;
  max-width: 276px;
  padding: 1px;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: left;
  white-space: normal;
  background-color: #fff;
  -webkit-background-clip: padding-box;
          background-clip: padding-box;
  border: 1px solid #ccc;
  border: 1px solid rgba(0, 0, 0, .2);
  border-radius: 6px;
  -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, .2);
          box-shadow: 0 5px 10px rgba(0, 0, 0, .2);
}
.popover.top {
  margin-top: -10px;
}
.popover.right {
  margin-left: 10px;
}
.popover.bottom {
  margin-top: 10px;
}
.popover.left {
  margin-left: -10px;
}
.popover-title {
  padding: 8px 14px;
  margin: 0;
  font-size: 14px;
  background-color: #f7f7f7;
  border-bottom: 1px solid #ebebeb;
  border-radius: 5px 5px 0 0;
}
.popover-content {
  padding: 9px 14px;
}
.popover > .arrow,
.popover > .arrow:after {
  position: absolute;
  display: block;
  width: 0;
  height: 0;
  border-color: transparent;
  border-style: solid;
}
.popover > .arrow {
  border-width: 11px;
}
.popover > .arrow:after {
  content: "";
  border-width: 10px;
}
.popover.top > .arrow {
  bottom: -11px;
  left: 50%;
  margin-left: -11px;
  border-top-color: #999;
  border-top-color: rgba(0, 0, 0, .25);
  border-bottom-width: 0;
}
.popover.top > .arrow:after {
  bottom: 1px;
  margin-left: -10px;
  content: " ";
  border-top-color: #fff;
  border-bottom-width: 0;
}
.popover.right > .arrow {
  top: 50%;
  left: -11px;
  margin-top: -11px;
  border-right-color: #999;
  border-right-color: rgba(0, 0, 0, .25);
  border-left-width: 0;
}
.popover.right > .arrow:after {
  bottom: -10px;
  left: 1px;
  content: " ";
  border-right-color: #fff;
  border-left-width: 0;
}
.popover.bottom > .arrow {
  top: -11px;
  left: 50%;
  margin-left: -11px;
  border-top-width: 0;
  border-bottom-color: #999;
  border-bottom-color: rgba(0, 0, 0, .25);
}
.popover.bottom > .arrow:after {
  top: 1px;
  margin-left: -10px;
  content: " ";
  border-top-width: 0;
  border-bottom-color: #fff;
}
.popover.left > .arrow {
  top: 50%;
  right: -11px;
  margin-top: -11px;
  border-right-width: 0;
  border-left-color: #999;
  border-left-color: rgba(0, 0, 0, .25);
}
.popover.left > .arrow:after {
  right: 1px;
  bottom: -10px;
  content: " ";
  border-right-width: 0;
  border-left-color: #fff;
}


.tooltip{
  position:relative;
  float:right;
}
.tooltip > .tooltip-inner {background-color: #00ae9d; padding:5px 15px; color:white; font-weight:bold; font-size:13px;}
.popOver + .tooltip > .tooltip-arrow {	border-left: 5px solid transparent; border-right: 5px solid transparent; border-top: 5px solid #00ae9d;}

section{
  margin:100px auto;
  height:1000px;
}
.progress{
  border-radius:0;
  overflow:visible;
}
.progress-bar {
    background: #a2a5a7;
  -webkit-transition: width 1.5s ease-in-out;
  transition: width 1.5s ease-in-out;
}
.tooltip.top .tooltip-arrow {
    bottom: 0;
    left: 50%;
    margin-left: -5px;
    border-width: 5px 5px 0;
    border-top-color: #00ae9d;
}
.progressText{
  display: block;
    margin-bottom: 34px;
    font-size: 18px;
    padding-left: 10px;
}
.progress-bar.mainprogress {
          background: #016690 ; /* Old browsers */
          background: -moz-linear-gradient(-45deg, #016690 0%, #429f48 100%); /* FF3.6-15 */
          background: -webkit-linear-gradient(-45deg, #016690 0%,#429f48 100%); /* Chrome10-25,Safari5.1-6 */
          background: linear-gradient(135deg, #016690 0%,#429f48 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
          filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#016690', endColorstr='#429f48',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
        }
.graphsectiontxt1{
  text-align:center;
  font-size : 20px;
  margin-bottom: 20px;
}
.graphsectiontxt2{
  text-align:center;
  font-size : 20px;
}
.barWrapper{
  margin-bottom:40px;
}
.graphsection .progress {height: 10px;width:88%;}
</style>
<style>
.form-control2 {
  display: inline-block;
      height: 40px;
      padding: 3px 10px;
      font-size: 20px;
      line-height: 1.428571429;
      color: #555;
      background-color: #fff;
      background-image: none;
      border: 1px solid #ccc;
      border-radius: 4px;
      -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
      box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
      -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
      transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
select.form-control2 {
  text-transform: none;
}
.graph_section{
  margin-top:30px;
  margin-bottom:70px;
}
.graphheader
{
  padding: 50px 0;
background-color: #f5f5f5;
margin-bottom: 60px;
color: #006691;
font-weight: 200;
    font-size: 20px;
}
.barWrapper .graphtitle{
  padding-right:10px;
}
@-webkit-keyframes hvr-icon-pulse-grow2 {
  to {
    -webkit-transform: scale(1.3) translate(6px, -6px) rotate(-15deg);
    transform: scale(1.3) translate(6px, -6px) rotate(-15deg);
  }
}
@keyframes hvr-icon-pulse-grow2 {
  to {
    -webkit-transform: scale(1.3) translate(6px, -6px) rotate(-15deg);
    transform: scale(1.3) translate(6px, -6px) rotate(-15deg);
  }
}
.barWrapper:first-child .graphtitle{
  -webkit-animation-name: hvr-icon-pulse-grow2;
  animation-name: hvr-icon-pulse-grow2;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-timing-function: linear;
  animation-timing-function: linear;
  -webkit-animation-iteration-count: infinite;
  animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  animation-direction: alternate;
}
</style>
<div class="graph_section">
  <div class="graphheader">
    <div class="graphsectiontxt1">
      예금/적금이 아닌 케이펀딩에 투자를 하면
    </div>
    <div class="graphsectiontxt2">
      <select class="form-control2" name="graphmonth" onChange=graphredraw()>
        <option value="1">1개월</option>
    <option value="3" selected>3개월</option>
    <option value="6">6개월</option>
    <option value="9">9개월</option>
    <option value="12">12개월</option>
      </select>
      동안
      <select class="form-control2" name="graphwon" onChange=graphredraw()>
        <option value="100000">10만원</option>
        <option value="500000">20만원</option>
        <option value="1000000">100만원</option>
        <option value="2000000">200만원</option>
        <option value="5000000" selected>500만원</option>
        <option value="10000000">1,000만원</option>
      </select>
      을 투자할 경우 수익률 비교
    </div>
</div>
  <!--<h2 class="text-center">Scroll down the page a bit</h2><br><br> -->
<div class="container graphsection">
  <div class="row">
    <div class="col-md-2 col-lg-2"></div>
     <div class="col-md-8 col-lg-8">
       <?php
         $graphmax = 90;
         $graphdefault_won = 5000000;
         $graphdefault_month = 3;

         $graph[] = array('title'=>'케이펀딩', "pct"=>18, "icon"=>"fas fa-plane" , "color"=>"#01658f");
         $graph[] = array('title'=>'주식형펀드', "pct"=>5.9, "icon"=>"fas fa-car" ,"color"=>"#c0c0c0");
         $graph[] = array('title'=>'저축은행', "pct"=>2.6, "icon"=>"fas fa-bicycle", "color"=>"#c0c0c0");
         $graph[] = array('title'=>'은행예금', "pct"=>1.2, "icon"=>"fas fa-walking", "color"=>"#c0c0c0");
         $calgraph = $graph[0]["pct"];

         foreach( $graph as $grpidx => $grprow){

           ?>
           <div class="barWrapper">
              <span class="progressText"><i class="graphtitle <?php echo $grprow['icon']?>" style="color:<?php echo $grprow['color']?>"></i> <B><?php echo $grprow['title']?></B> 수익률 <b><?php echo $grprow['pct']?></b>%</span>
             <div class="progress">
               <div class="progress-bar <?php echo ($grpidx == 0 )? "mainprogress":"" ?>" role="progressbar" aria-pct='<?php echo $grprow['pct']?>' aria-valuenow="<?php echo round($graphmax /$calgraph * $grprow['pct']) ?>" aria-valuemin="0" aria-valuemax="100" >
                     <span  class="popOver" data-toggle="tooltip" data-placement="top" title="<?php echo number_format(round($graphdefault_won * $grprow['pct']/100/12 * $graphdefault_month))?>원"> </span>
             </div>
             </div>
           </div>
           <?
         }

       ?>

        </div>
     <div class="col-md-2 col-lg-2" id="graphoffset"></div>
    </div>
</div>
</div>
<!-- / graph -->
<style>
.hvr-bounce-to-top2 {
  display: inline-block;
  vertical-align: middle;
  -webkit-transform: perspective(1px) translateZ(0);
  transform: perspective(1px) translateZ(0);
  box-shadow: 0 0 1px rgba(0, 0, 0, 0);
  position: relative;
  -webkit-transition-property: color;
  transition-property: color;
  -webkit-transition-duration: 0.5s;
  transition-duration: 0.5s;
  color:white;
  border-color: white;
  padding: 10px;
  color: #FFF;
  background-color: #006691;
}
.hvr-bounce-to-top2:before {
  content: "";
  position: absolute;
  z-index: -1;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: #00ae9d;
  -webkit-transform: scaleY(0);
  transform: scaleY(0);
  -webkit-transform-origin: 50% 100%;
  transform-origin: 50% 100%;
  -webkit-transition-property: transform;
  transition-property: transform;
  -webkit-transition-duration: 0.5s;
  transition-duration: 0.5s;
  -webkit-transition-timing-function: ease-out;
  transition-timing-function: ease-out;
}
.hvr-bounce-to-top2:hover, .hvr-bounce-to-top2:focus, .hvr-bounce-to-top2:active {
  color: #FFF;
  border-color:#00ae9d;
}
.hvr-bounce-to-top2:hover:before, .hvr-bounce-to-top2:focus:before, .hvr-bounce-to-top2:active:before {
  -webkit-transform: scaleY(1);
  transform: scaleY(1);
  -webkit-transition-timing-function: cubic-bezier(0.52, 1.64, 0.37, 0.66);
  transition-timing-function: cubic-bezier(0.52, 1.64, 0.37, 0.66);
}


.main_join.t2 {
    background-color: #f5f5f5;
}
</style>
	<!-- 회원 등록2 -->
	<div class="main_join t2">
		<div class="container">
			<p>아직도<br>케이펀딩파트너스의 회원이<br>아니신가요?</p>
			<a class="btn  w200 hvr-bounce-to-top2" href="/pnpinvest/?mode=join01">회원가입 하러가기</a>
		</div>
	</div>
</div>

<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->


<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/53148/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/53148/jquery.velocity.min.new.js" type="text/javascript"></script>
<link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet' type='text/css'>
<script src="https://www.jqueryscript.net/demo/jQuery-Plugin-For-Terminal-Text-Typing-Effect-typed-js/js/typed.js" type="text/javascript"></script>

<script>
Number.prototype.numberformat = function(){
    if(this==0) return 0;
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};
String.prototype.numberformat = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";
    return num.numberformat();
};
</script>
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
         if(_this.y) { string += 'translateY('+_this.y+'px)' ; };
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
        $text.css({width: zwidth, height: 10, fontSize: zfont, color: Colors.white, left: '50%', marginLeft: (zwidth / 2 * -1 +14) , top: '50%', marginTop: -72, transform: $text.transform({skewY: -9, y: zheighttrance}), overflow: 'hidden'});
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
                letters[i].velocity({translateY: [4, ( zheight * -1 ) ]}, ( zwidth / 2 ), 'easeOutCubic', 100 + i * 50);
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
                if (typeof text[i] !='string') continue;
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
                letters[i].velocity({translateY: [-1, -100]}, {duration: 200+i*25, easing: 'easeOutCubic', delay: i*50});
                letters[i].find('div').velocity({translateY: [-1, 140]}, {duration: 200+i*25, easing: 'easeOutCubic', delay: i*50});
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
          $container = createDiv('container2');
          $container.css({width: 340, height: 110, top: '0%', left: '50%', marginLeft: -170,
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
        $container.css({width: 340, height: 110, top: '0%', left: '50%', marginLeft: -170,
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
  $("#stage2").append($stage);
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
//===========================================

$("document").ready( function() {
  $(".planbox").on("click", function () {
    $(this).addClass("hover");
  });
  $(".item_time").each(function (){
    checkstatus(this);
		$(this).fadeIn("slow");
  });
  setTimeout(  intro2 , 500);
    zaniinit();
    //setTimeout(  newTyped , 8500);
    var graphoffset = $("#graphoffset").offset();
      graph();
  $( window ).scroll(function() {
    if($( window ).scrollTop() > (graphoffset.top - 900 ) ){
      graphmove();
    }
  });
});
function intro2() {
  $('#intro2').attr("class", "intro go");
}
function newTyped(){
  Typed.new("#typed", {
      stringsElement: document.getElementById('typed-strings'),
      typeSpeed: 30,
      backDelay: 500,
      loop: false,
      contentType: 'html', // or text
      // defaults to null for infinite loop
      loopCount: null,
      callback: function(){ typeend(); },
      resetCallback: function() { newTyped(); }
  });

  var resetElement = document.querySelector('.reset');
  if(resetElement) {
      resetElement.addEventListener('click', function() {
          document.getElementById('typed')._typed.reset();
      });
  }
}
function typeend() {

}

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
function graph(){
  //$('[data-toggle="tooltip"]').tooltip({trigger: 'manual'}).tooltip('show');
$('[data-toggle="tooltip"]').tooltip({trigger: 'manual'}).tooltip('show');
// $( window ).scroll(function() {
 // if($( window ).scrollTop() > 10){  // scroll down abit and get the action
  //$(".progress-bar").each(function(){
//    $(this).width('1%');
//  });
}
function graphmove() {
  $(".progress-bar").each(function(){
    each_bar_width = $(this).attr('aria-valuenow');
    $(this).width(each_bar_width + '%');
  });
}

function  graphredraw(){
  $(".progress-bar").each(function(){
    $(this).width('1%');
  });
  setTimeout(graphdraw , 1500);
}
function graphdraw() {
  var won = $("select[name=graphwon] option:checked").val() * $("select[name=graphmonth] option:checked").val() ;
  $(".progress-bar").each(function(){
    $(this).children('.tooltip').children('.tooltip-inner').html( '<span class="counterup">'+(Math.round(parseFloat($(this).attr('aria-pct'))*won/100/12)).numberformat() +"</span>원") ;
    each_bar_width = $(this).attr('aria-valuenow');
    $(this).width(each_bar_width + '%');
  });
  $(".counterup").counterUp({
		delay: 10,
		time: 1000
	});
}
</script>
<!--    / script -->
{# new_footer}
