<?php
if ($loa['i_look']=='F'){ return;}

?>
<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
$startidx = 0; //신규로 보여줄 IDX시작
/*
error_reporting(E_ALL);
ini_set("display_errors", 1);
*/

$sql = "select  * from mari_loan_ext where fk_mari_loan_id = ".(int)$loan_id;
$extinfo           = sql_fetch($sql, false);
$sql = "select ifnull(sum(i_pay),0) as invested from mari_invest where loan_id = ".(int)$loan_id;
$invested  = sql_fetch($sql, false);

//var_dump($loa);
/* 회원인증 적용*/
include_once (getcwd().'/module/basic.php');
list($isauthed, $authedmsghead,$authedmsgbody) = isauthed($user);
$marker ='<div style="position:relative"><div class="current_grade"><img src="/pnpinvest/layouts/home/pnpinvest/img2/barcenter.png" style="width:21px;height:22px;"></div></div>';
?>
{# new_header}
<link rel="stylesheet" href="js/owl/assets/owl.carousel.min.css">
<link rel="stylesheet" href="js/owl/assets/owl.theme.default.min.css">
<link rel="stylesheet" href="/pnpinvest/layouts/home/pnpinvest/simplomodal/learn.css" type="text/css" media="screen" title="no title" charset="utf-8">
<script src="js/owl/owl.carousel.min.js"></script>
<script type="text/javascript" src="/pnpinvest/layouts/home/pnpinvest/simplomodal/jquery.leanModal.min.js"></script>
<style>
#signup-header {
    background-color: #061551;
    padding:5px;
  }
  #signup .modal_close{
    background: url(/pnpinvest/img/alert_close.gif) center no-repeat;
  }
  .top_info .summary dd span.gradebox1 {
    font-size: 26px;
    width: 54px;
    height: 50px;
    display: inline-block;
    background-color: #061551;
    color: white;
    text-align: center;
    line-height: 44px;
    border-radius: 5px;
  }
  .summary .sm_1 dd{
    line-height: 43px;
  }
  .existing_event{
    text-align:center;
  }
  .form-group {
      margin: 15px 0 0 0;
      font-size:18px;
  }
 /*.detail_con.inverest .sum .sum1{
      border:none;
  }*/
  .detail_con.inverest .sum .sum1 input[type=text] {
      font-size: 20px;
          line-height: 25px;
		  margin-left: 10px;
  }
   .form-group.is-focused .form-control{
      background-image: linear-gradient(#061551, #061551), linear-gradient(#D2D2D2, #D2D2D2);
    }
</style>

<?php
if(!$isauthed) { ?>
<div id="signup" style="display:none;">
  <div id="signup-ct">
    <div id="signup-header">
      <img src="/pnpinvest/img/alert_logo.gif">
      <a class="modal_close" href="#"></a>
    </div>
    <form action="">
      <!--div class="txt-fld">
        <label for="">Username</label>
        <input id="" class="good_input" name="" type="text" />
      </div-->
      <div class="txt-fld" id="alert-contents">
        <p style="text-align:left;margin:12px 0; font-size:1.3em"><?php echo ($authedmsghead);?></p>
        <p style="text-align:left;margin-bottom:15px;font-size:1.1em"><?php echo ($authedmsgbody);?></p>
      </div>
      <!--div class="btn-fld">
        <button type="submit">Sign Up &raquo;</button>
      </div-->
    </form>
  </div>
  <a id="openmodal" rel="leanModal" name="signup" href="#signup" style="display:hidden" onClick=""></a>
</div>
<?php } ?>

<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t1"><span class="motion" data-animation="flash">투자상세페이지</span></h2>
	<!-- invest view -->
	<div class="invest_view">
		<div class="container">
			<!-- 요약정보 -->
			<div class="top_info">
				<h3><?php echo $loa['i_subject']?></h3>
				<ul class="summary">
					<li class="sm_1">
						<dl>
							<dt>등급</dt>
							<dd ><!--img src="img/lv_<?php echo strtolower($iv['i_grade']);?>.png" alt="A3"-->
                <span class="gradebox1"><?php echo strtoupper($iv['i_grade'][0]);?><span><?php echo (isset($iv['i_grade'][1])) ? $iv['i_grade'][1]:'';?></span><span>
              </dd>
						</dl>
					</li>
					<li class="sm_2">
						<dl>
							<dt>연수익률(세전)</dt>
							<dd><?php echo $loa['i_year_plus']?>%</dd>
						</dl>
					</li>
					<li class="sm_3">
						<dl>
							<dt>투자기간</dt>
							<dd><?php echo $loa['i_loan_day']?><span>개월</span></dd>
						</dl>
					</li>
					<li class="sm_4">
						<dl>
							<dt>총모집금액</dt>
							<dd><?php echo number_format($loa['i_loan_pay'])?><span>원</span></dd>
						</dl>
					</li>
					<li class="sm_5">
						<dl>
							<dt>모집현황</dt>
							<dd><?php echo number_format($invested['invested'])?>원/<?php echo number_format($loa['i_loan_pay'])?>원 <span>(모집기간:<?php echo date('Y.m.d',strtotime($iv['i_invest_sday']))?>~<?php echo date('Y.m.d',strtotime($iv['i_invest_eday']))?>)</span></dd>
						</dl>
					</li>
				</ul>
				<p class="progress"><span class="p_bar" style="width:<?php echo $order_pay?>%;"><span></p>
				<p class="guide"><?php echo (isset($extinfo['descript']) ? nl2br($extinfo['descript']) :'')?>
			</div>
			<!-- 따라다니는 영역 -->
			<div class="aside">
				<ul class="info">
          <li><strong class="title">상품분류</strong><?php echo ($loa['i_payment']=="cate02"||$loa['i_payment']=="cate04") ? "부동산":"동산"?></li>
					<li><strong class="title">투자기간</strong><?php echo $loa['i_loan_day']?>개월</li>
					<li><strong class="title">모집금액</strong><?php echo change_pay($loa['i_loan_pay'])?>원</li>
					<li><strong class="title">참여금액</strong><?php echo change_pay($invested['invested'])?>원</li>
					<!--li><strong class="title">참여자수</strong><?php echo $invest_cn?>명</li-->
					<li><strong class="title">최소 투자금액</strong><?php echo change_pay($iv['i_invest_mini'])?>원</li>
					<li><strong class="title">펀딩진행률</strong><?php echo $order_pay?>%</li>
				</ul>
				<a class="btn t1 f1" href="javascript:;" onClick="viewCalc()">이자계산기</a>
				<!--a class="btn t5 f1" href="javascript:;" onClick="investment()">투자하기</a-->

        <?php if($iv[i_look]=="C"){?>
          <a class="btn t1 f1" href="javascript:alert('투자가 마감된 상품입니다.');">투자마감</a>
        <?php }else if($iv[i_look]=="N"){?>
          <a class="btn t1 f1" href="javascript:alert('투자대기중인 상품입니다.');">투자대기</a>
        <?php }else if($iv[i_look]=="D"){?>
          <a class="btn t1 f1" href="javascript:alert('상환중인 상품입니다.');">상환중</a>
        <?php }else if($iv[i_look]=="F"){?>
          <a class="btn t1 f1" href="javascript:alert('상환이 완료된 상품입니다.');">상환완료</a>
        <?php }else if($iv[i_look]=="Y"){
            if($order_pay >= "100"){
        ?>
          <a class="btn t1 f1" href="javascript:alert('투자가 100% 이루어진 상품입니다.');">투자마감</a>
        <?php	}else if($iv['i_invest_eday'] < $date){?>
          <a class="btn t1 f1" href="javascript:alert('모집기간이 지난상품입니다.');">투자마감</a>
        <?php	}else{

            /* 회원인증 적용*/
            if($user['m_signpurpose']=='L') {
              ?>
              <a class="btn t5 f1" name="signup" href="javascript:;" onclick="alert('대출회원은 투자가 불가능합니다.')" >투자하기</a>
              <?php
            }else if(!$isauthed) {
              ?>
                <a class="btn t5 f1" rel="leanModal" name="signup" href="#signup" >투자하기</a>
              <?php
            }else {
          ?>
                 <a class="btn t5 f1" href="{MARI_HOME_URL}/?mode=invest2&loan_id=<?php echo $loan_id;?>">투자하기</a>
        <?php	} }
        }
        ?>





			</div>
			<script>
				$(document).ready(function(){
					$(window).scroll(function(){
						var offset=350;
						var overset=$(document).height()-1000;
						if($(this).scrollTop() > offset){
							$('.invest_view .aside').addClass('fixed');
							if($(this).scrollTop() > overset){
								$('.invest_view .aside').fadeOut();
							}else{
								$('.invest_view .aside').fadeIn();
							};
						}else{
							$('.invest_view .aside').removeClass('fixed');
						};
					});
				});
			</script>
			<!-- 모집 알림 -->
      <?php
      switch($iv['i_look']){
        case("Y") :
        $invest_alarm = 'class="invest_alarm" ';
        break;
        case("N") :
        $invest_alarm = "class='invest_alarm alarm_check'  style='display:none'";
        break;
        default :
        $invest_alarm = " class='invest_alarm' style='display:none' ";
      }
      ?>
			<div id="invest_alarm <?php echo (in_array($iv['i_look'], array('N'))) ? 'item_time':''; ?>" data-loan_id="<?php echo $loan_id?>" data-loan_look="<?php echo $iv['i_look']?>" style="display:none" <?php echo (!in_array($iv['i_look'], array('N'))) ? 'style="display:none"':''; ?> >
				<span>투자가 시작되었습니다!</span>
				<a href="javascript:;" onclick="investment()" class="btn">투자하기</a>
			</div>
			<!-- 상세정보 -->
			<div class="detail tab">
				<!-- 투자요약 탭 -->
				<h3 class="title invest first on"><i class="bg"></i><span class="txt">투자요약</span></h3>
				<div class="detail_con invest on">
					

    <?php if ($loan_id >= $startidx ) { ?>
					<!--<h4>이벤트혜택</h4>-->

          <div class="newevent">
            <div class="row">
              <?php
              if(isset($extinfo['reward']) && $extinfo['reward'] !='' && isset($extinfo['eventfile']) && $extinfo['eventfile'] !='' ) {
                $event_class = 'col-sm-6';
              }else {
                $event_class = 'col-sm-offset-2 col-sm-8';
              }
              if( isset($extinfo['reward']) && $extinfo['reward'] !='' ) {?>
              <div class="<?php echo $event_class?>">
                <!--<p><strong>글로벌 리워드</strong></p>-->
                <img src="/pnpinvest/data/file/<?php echo $loan_id?>/<?php echo $extinfo['reward']?>" alt="이벤트"  style="width: 100%;">
              </div>
             <?php }?>
             <?php if( isset($extinfo['eventfile']) && $extinfo['eventfile'] !='' ) { ?>
              <div class="<?php echo $event_class?>">
                <!--<p ><strong>특별 이벤트</strong></p>-->
                <!--<img src="/pnpinvest/data/file/<?php echo $loan_id?>/<?php echo $extinfo['eventfile']?>" alt="이벤트" style="width: 100%;">-->
              </div>
            <?php } ?>
            </div>
          </div>
		  
		  
          <?php if( isset($extinfo['eventetc']) && $extinfo['eventetc'] !='' ) { ?>
          <div style="margin-bottom:45px;">
            <div style="float: left;width: 15%;max-width: 180px;min-width: 100px;">
            <!--<strong>그 외 이벤트</strong>-->
            </div>
            <div style="float: left;">
              <p><?php echo ( isset($extinfo['eventetc'] ) ?  nl2br($extinfo['eventetc']) : '' ) ?></p>
            </div>
            <div style="clear:both"></div>
          </div>

		  
          <?php } ?>
        <?php } else { ?>
          <!-- 기존 데이터로 보여줌 -->
          <style>
          .existing_event_div table{width: 100%;}
          .detail_con .event img {
              width:90%;
              max-width: 800px;
          }
          </style>
		  
		  
          <div class="existing_event_div" style="text-align:center;">
            <p class="existing_event" style="text-align:center;">
                <?php
                echo $iv['i_security'];
                //echo strip_tags($iv['i_security'], '<table><tr><td><th><img>');
                //echo preg_replace("/ style=/"," removed=" , strip_tags($iv['i_security'], '<table><tr><td><th><img>'));
                /*

                preg_match_all("/<img[^>]*src=[\'\"]?([^>\'\"]+)[\'\"]?[^>]*>/", $iv['i_security'], $matchs);
                echo ($matchs[0][0]);
                */
                ?>
            </p>
          </div>
		  
		  
          <!-- / 기존 데이터로 보여줌 -->
        <?php } ?>
        <!--
					<h4>엔젤평가등급</h4>

          <style>
          div.z_time_line{margin-bottom: 40px;}
          div.time_line_box{margin-bottom: 30px;}
          div.time_line_box table tr td{text-align:center}
          div.time_line_box table tr.colorbox{
            height:15px;
            background-image: url('/pnpinvest/img/graditionbg.png') ;
            background-size: 829px 15px;
      			#background-position: center center;
      			#background-repeat:  no-repeat;
      			#background-attachment: fixed;
      			#background-size:  contain;
            #background: #df0956; /* Old browsers */
            #background: -moz-linear-gradient(left, #df0956 0%, #730f53 44%, #061451 100%); /* FF3.6-15 */
            #background: -webkit-linear-gradient(left, #df0956 0%,#730f53 44%,#061451 100%); /* Chrome10-25,Safari5.1-6 */
            #background: linear-gradient(to right, #df0956 0%,#730f53 44%,#061451 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
            #filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#df0956', endColorstr='#061451',GradientType=1 );
          }
          div.time_line_box table tr.titlebox1 td{
            padding-bottom: 15px;
            font-size: 1.2rem;
          }
            div.time_line_box table tr.titlebox2 td span.dot:before {
              content: "";
              width: 8px;
              height: 8px;
              border-radius: 3px;
              display: block;
              margin: 2px auto;
              color: #aaa;
            }
            div.time_line_box table tr.titlebox2 td:nth-child(1) span.dot:before { background-color: #d80a56; }
            div.time_line_box table tr.titlebox2 td:nth-child(2) span.dot:before { background-color: #c40a55; }
            div.time_line_box table tr.titlebox2 td:nth-child(3) span.dot:before { background-color: #b50b55; }
            div.time_line_box table tr.titlebox2 td:nth-child(4) span.dot:before { background-color: #a70d54; }
            div.time_line_box table tr.titlebox2 td:nth-child(5) span.dot:before { background-color: #970e54; }
            div.time_line_box table tr.titlebox2 td:nth-child(6) span.dot:before { background-color: #880e54; }
            div.time_line_box table tr.titlebox2 td:nth-child(7) span.dot:before { background-color: #790f53; }
            div.time_line_box table tr.titlebox2 td:nth-child(8) span.dot:before { background-color: #6c1053; }
            div.time_line_box table tr.titlebox2 td:nth-child(9) span.dot:before { background-color: #5e1152; }
            div.time_line_box table tr.titlebox2 td:nth-child(10) span.dot:before { background-color: #4f1152; }
            div.time_line_box table tr.titlebox2 td:nth-child(11) span.dot:before { background-color: #411252; }
            div.time_line_box table tr.titlebox2 td:nth-child(12) span.dot:before { background-color: #311352; }
            div.time_line_box table tr.titlebox2 td:nth-child(13) span.dot:before { background-color: #211352; }
            div.time_line_box table tr.titlebox2 td:nth-child(14) span.dot:before { background-color: #131351; }
            div.time_line_box table tr.titlebox2 td:nth-child(15) span.dot:before { background-color: #061451; }

            div.time_line_box table tr.titlebox2 td span.dot{
              margin-top: 9px;
              display: inline-block;
              color:#df0956;
              font-size: 0.9rem;
            }
            div.topbox{
              text-align:center
            }
            div.topbox span.gradebox{
              padding: 11px 26px 13px;
              display: inline-block;
              background-color: #131351;
              color: #FFF;
              font-size: 30px;
              font-weight: bold;
              border-radius: 10px;
              margin-bottom: 18px;
            }
            @keyframes loading {
              0%, 100% {
                transform: translateY(-15px);
                animation-timing-function: ease-out;
              }
              50% {
                transform: translateY(-20px);
                animation-timing-function: ease-in;
              }
            }
            .current_grade {
                position:absolute;width: 100%;top: -2px;
                animation: loading 1.5s infinite;
            }
            .topbox span.gradebox1 {
              font-size: 32px;
              width: 68px;
              height: 68px;
              display: inline-block;
              background-color: #131351;
              color: white;
              text-align: center;
              line-height: 63px;
              border-radius: 8px;
              font-weight: bold;
              margin-bottom:15px;
            }
            .topbox span.gradebox1 span.smsize {font-size: 20px;}
          </style>
          <div class="z_time_line">
            <div class="time_line_box">
              <div class="topbox">

                  <span class="gradebox1"><?php echo strtoupper($iv['i_grade'][0]);?><span class="smsize"><?php echo (isset($iv['i_grade'][1])) ? $iv['i_grade'][1]:'';?></span><span>
              </div>
              <table width=100% >
                <tr class="titlebox1"><td colspan=3>A</td><td colspan=3>B</td><td colspan=3>C</td><td colspan=3>D</td><td colspan=3>E</td></tr>
                <tr class="colorbox" id="colorboxtr">
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='A1') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='A2') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='A3') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='B1') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='B2') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='B3') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='C1') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='C2') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='C3') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='D1') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='D2') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='D3') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='E1') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='E2') ? $marker :''?></td>
                  <td><?php echo (isset($iv['i_grade']) && strtoupper($iv['i_grade']) =='E3') ? $marker :''?></td>
                </tr>
                <tr class="titlebox2">
                  <td><span class="dot">A1</span></td>
                  <td><span class="dot">A2</span></td>
                  <td><span class="dot">A3</span></td>
                  <td><span class="dot">B1</span></td>
                  <td><span class="dot">B2</span></td>
                  <td><span class="dot">B3</span></td>
                  <td><span class="dot">C1</span></td>
                  <td><span class="dot">C2</span></td>
                  <td><span class="dot">C3</span></td>
                  <td><span class="dot">D1</span></td>
                  <td><span class="dot">D2</span></td>
                  <td><span class="dot">D3</span></td>
                  <td><span class="dot">E1</span></td>
                  <td><span class="dot">E2</span></td>
                  <td><span class="dot">E3</span></td>
                </tr>
              </table>
            </div>
            <style>
            .text-left {text-align: left;}
            div.time_line_desc{padding: 0 10px;}
            div.time_line_desc table tr th{
              border-top: 1px solid #d8d8d8;
              border-bottom: 1px solid #d8d8d8;
              font-size: 1.1rem;
              padding: 12px 0;
              background-color: #f8f8f8;
            }
            div.time_line_desc table tr th:nth-child(2) , div.time_line_desc table tr td:nth-child(2){
              border-left: 1px solid #d8d8d8;
              border-right: 1px solid #d8d8d8;
              PADDING-LEFT: 15PX;
            }
            div.time_line_desc table tr td{
              border-bottom: 1px solid #d8d8d8;
            }
            div.time_line_desc table tr td:first-child{
              #font-size: 1.1rem;
              padding: 12px 5px;
              text-align: center;
              min-width: 80px;
              max-width:120px;
            }
            div.time_line_desc table tr td:last-child{
              padding: 13px 0 13px 10px;;
              width:110px;
            }
            .startpoint{
              border: 1px solid #333;
              width: 16px;
              height: 16px;
              display: inline-block;
              border-radius: 5px;
            }
            .startpoint .bg-info{
              float: left;
              height: 100%;
              width:100%;
              font-size: 12px;
              line-height: 20px;
            }
            .startpoint .bg-info.half{
              width:55%;
            }
            .startpoint:nth-child(1){border: 1px solid #c40a55}
            .startpoint:nth-child(2){border: 1px solid #970e54}
            .startpoint:nth-child(3){border: 1px solid #6c1053}
            .startpoint:nth-child(4){border: 1px solid #411252}
            .startpoint:nth-child(5){border: 1px solid #131351}
            .startpoint:nth-child(1) .bg-info{background-color:#c40a55}
            .startpoint:nth-child(2) .bg-info{background-color:#970e54}
            .startpoint:nth-child(3) .bg-info{background-color:#6c1053}
            .startpoint:nth-child(4) .bg-info{background-color:#411252}
            .startpoint:nth-child(5) .bg-info{background-color:#131351}
            </style>
<?php if($iv['i_ltv_point'] || $iv['i_stability'] || $iv['i_credit_grade'] || $iv['i_refund'] || $iv['i_income'] || $iv['i_position']){?>
            <div class="time_line_desc">
              <table width=100%>
                <tr>
                  <th>항목</th>
                  <th>설명</th>
                  <th>평점</th>
                </tr>
                <?php if($iv['i_ltv_point']){?>
    							<tr>
    								<td>담보비율 (LTV)</td>
    								<td>담보 비율:총 담보 부채/담보감정가</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_ltv_point']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>
                <?php if($iv['i_stability']){?>
    							<tr>
    								<td>안정성</td>
    								<td>금액,투자기간</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_stability']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>
    						<?php if($iv['i_credit_grade']){?>
    							<tr>
    								<td>신용등급</td>
    								<td>나이스 신용등급</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_credit_grade']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>
    						<?php if($iv['i_refund']){?>
    							<tr>
    								<td>환급성</td>
    								<td>아파트,연립 상가등 가중치가 다릅니다.</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_refund']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>
    						<?php if($iv['i_income']){?>
    							<tr>
    								<td>소득</td>
    								<td>총 부채 대비 소득이 높으면 가중치가 높음</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_income']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>
    						<?php if($iv['i_position']){?>
    							<tr>
    								<td>위치</td>
    								<td>지역,층수,면적등 고려하여 가중치 부여</td>
    								<td>
    								<?php for($i=1;$i<=$iv['i_position']; $i++){?>
    									<div class="startpoint"><div class="bg-info color1"></div></div>
    								<?php }?>
    								</td>
    							</tr>
    						<?php }?>

              </table>
            </div>
<?PHP } ?>
          </div>
        -->
					<!--div class="textbox"><img src="img/angel_level.png" alt="엔젤평가등급 표 이미지"></div-->
          <style>
            .product_table1 table {
              width:100%;
            }
          </style>
          <script>

          </script>
					<!--<h4>투자시 유의사항</h4>-->

<style>
table.product_table tbody tr:first-child{display:none}
table.product_table tbody tr td:first-child{
  color: #00656a;
}
</style>
					<table class="product_table">
						<!--<caption>투자시 유의사항</caption>-->
						<colgroup>
							<col class="prt_th">
							<col>
						</colgroup>
						<tbody>
              <!-- 텍스트만 나오게 -->
             <!-- <?php nl2br(preg_replace("/ style=/"," removed=" , strip_tags($iv['i_summary'], '<tr><td><th>'))); ?>-->
              <!-- /텍스트만 나오게 -->
              <!-- html 내용이 나오게 -->
             <!-- <?php echo $iv['i_summary']?>-->
              <!-- /html 내용이 나오게 -->

						</tbody>
					</table>
				</div>
				
				
				
				
				
				<!-- 상품정보 탭 -->
				<h3 class="title product_info"><i class="bg"></i><span class="txt">상품정보</span></h3>
				
				<div class="detail_con product_info">
<?php if ($loan_id >= $startidx ) { ?>
<div class="container first">
<div class="gp1">
<h4>&#9635;&nbsp;투자정보</h4>
					<table class="check_table">
						<caption>투자정보</caption>
						<colgroup>
							<col class="cht_th1">
								<col class="cht_th2">
								<col>
						</colgroup>
						<tbody>
							<tr>
								<th>&#10625;&nbsp;상품종류</th>
								<td><?php echo ($loa['i_payment']=="cate02"||$loa['i_payment']=="cate04") ? "부동산":"비부동산"; ?><!--<?php echo $cate['ca_subject']?>--></td>
							</tr>
							<tr>
								<th>&#10625;&nbsp;자금용도</th>
								<td><?php echo $loa['i_purpose']?></td>
							</tr>
							<tr>
								<th>
                  <?php if($loa['i_security_type']){?>
										&#10625;&nbsp;담보물 유형
									<?php }?>
									<?php if($loa['i_conni']){?>
										&#10625;&nbsp;담보물 감정가
									<?php }?>
									<?php if($loa['i_conni_admin']){?>
										&#10625;&nbsp;자체 감정가
									<?php }?>

                </th>
								<td>
                  <?php if($loa['i_security_type']){?>
									<?php echo $loa['i_security_type']?>
									<?php }?>
									<?php if($loa['i_conni']){?>
									<?php echo change_pay($loa['i_conni'])?>원
									<?php }?>
									<?php if($loa['i_conni_admin']){?>
									<?php echo change_pay($loa['i_conni_admin'])?>원
									<?php }?>
                </td>
							</tr>
								
						</tbody>
					</table>
							
							
							<table class="check_table">
						<caption>투자정보</caption>
						<colgroup>
							<col class="cht_th1">
								<col class="cht_th2">
								<col>
						</colgroup>
						<tbody>
							<tr>
								<th>&#10625;&nbsp;LTV</th>
								<td>
                  <?php if($iv['i_ltv_per']){
                      echo $iv['i_ltv_per']."%";
                     }else{
                      echo "-";
                     }
                  ?>
                </td>
							</tr>
							<tr>
								<th>&#10625;&nbsp;투자기간</th>
								<td><?php echo $loa['i_loan_day']?>개월</td>
							</tr>
							<tr>
								<th>&#10625;&nbsp;투자수익률</th>
								<td><?php echo $loa['i_year_plus']?>%</td>
							</tr>
						</tbody>
					</table>
					</div>
					
					<h4>&#9635;&nbsp;상환정보</h4>
					<table class="check_table">
						<caption>상환정보</caption>
						<colgroup>
							<col class="cht_th1">
								<col class="cht_th2">
								<col>
						</colgroup>
						<tbody>
              <?php if($iv['i_repay_plan']<>"0000-00-00"){?>
                <tr>
  								<th>&#10625;&nbsp;상환예정</th>
  								<td><?php echo $iv['i_repay_plan'];?></td>
  							</tr>
							<?php }?>
							<?php if($iv['i_repay_way'] !=''){?>
                <tr>
  								<th>&#10625;&nbsp;상환방식</th>
  								<td><?php echo $iv['i_repay_way'];?></td>
  							</tr>
							<?php }?>
							<?php if($iv['i_repay_info'] !=''){?>
                <tr>
  								<th>&#10625;&nbsp;상환재원</th>
  								<td><?php echo $iv['i_repay_info'];?></td>
  							</tr>
							<?php }?>
						</tbody>
					</table>
					
					<style>
:after, :before {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.row:after, .row:before {
    display: table;
    content: " ";
}
.row:after {
    clear: both;
}
.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
  position: relative;
  min-height: 1px;
  padding-right: 15px;
  padding-left: 15px;
}
.col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9, .col-xs-10, .col-xs-11, .col-xs-12 {
  float: left;
}
.col-xs-12 {
  width: 100%;
}
.col-xs-11 {
  width: 91.66666667%;
}
.col-xs-10 {
  width: 83.33333333%;
}
.col-xs-9 {
  width: 75%;
}
.col-xs-8 {
  width: 66.66666667%;
}
.col-xs-7 {
  width: 58.33333333%;
}
.col-xs-6 {
  width: 50%;
}
.col-xs-5 {
  width: 41.66666667%;
}
.col-xs-4 {
  width: 33.33333333%;
}
.col-xs-3 {
  width: 25%;
}
.col-xs-2 {
  width: 16.66666667%;
}
.col-xs-1 {
  width: 8.33333333%;
}
.col-xs-pull-12 {
  right: 100%;
}
.col-xs-pull-11 {
  right: 91.66666667%;
}
.col-xs-pull-10 {
  right: 83.33333333%;
}
.col-xs-pull-9 {
  right: 75%;
}
.col-xs-pull-8 {
  right: 66.66666667%;
}
.col-xs-pull-7 {
  right: 58.33333333%;
}
.col-xs-pull-6 {
  right: 50%;
}
.col-xs-pull-5 {
  right: 41.66666667%;
}
.col-xs-pull-4 {
  right: 33.33333333%;
}
.col-xs-pull-3 {
  right: 25%;
}
.col-xs-pull-2 {
  right: 16.66666667%;
}
.col-xs-pull-1 {
  right: 8.33333333%;
}
.col-xs-pull-0 {
  right: auto;
}
.col-xs-push-12 {
  left: 100%;
}
.col-xs-push-11 {
  left: 91.66666667%;
}
.col-xs-push-10 {
  left: 83.33333333%;
}
.col-xs-push-9 {
  left: 75%;
}
.col-xs-push-8 {
  left: 66.66666667%;
}
.col-xs-push-7 {
  left: 58.33333333%;
}
.col-xs-push-6 {
  left: 50%;
}
.col-xs-push-5 {
  left: 41.66666667%;
}
.col-xs-push-4 {
  left: 33.33333333%;
}
.col-xs-push-3 {
  left: 25%;
}
.col-xs-push-2 {
  left: 16.66666667%;
}
.col-xs-push-1 {
  left: 8.33333333%;
}
.col-xs-push-0 {
  left: auto;
}
.col-xs-offset-12 {
  margin-left: 100%;
}
.col-xs-offset-11 {
  margin-left: 91.66666667%;
}
.col-xs-offset-10 {
  margin-left: 83.33333333%;
}
.col-xs-offset-9 {
  margin-left: 75%;
}
.col-xs-offset-8 {
  margin-left: 66.66666667%;
}
.col-xs-offset-7 {
  margin-left: 58.33333333%;
}
.col-xs-offset-6 {
  margin-left: 50%;
}
.col-xs-offset-5 {
  margin-left: 41.66666667%;
}
.col-xs-offset-4 {
  margin-left: 33.33333333%;
}
.col-xs-offset-3 {
  margin-left: 25%;
}
.col-xs-offset-2 {
  margin-left: 16.66666667%;
}
.col-xs-offset-1 {
  margin-left: 8.33333333%;
}
.col-xs-offset-0 {
  margin-left: 0;
}
@media (min-width: 768px) {
  .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12 {
    float: left;
  }
  .col-sm-12 {
    width: 100%;
  }
  .col-sm-11 {
    width: 91.66666667%;
  }
  .col-sm-10 {
    width: 83.33333333%;
  }
  .col-sm-9 {
    width: 75%;
  }
  .col-sm-8 {
    width: 66.66666667%;
  }
  .col-sm-7 {
    width: 58.33333333%;
  }
  .col-sm-6 {
    width: 100%;
  }
  .col-sm-5 {
    width: 41.66666667%;
  }
  .col-sm-4 {
    width: 33.33333333%;
  }
  .col-sm-3 {
    width: 25%;
  }
  .col-sm-2 {
    width: 16.66666667%;
  }
  .col-sm-1 {
    width: 8.33333333%;
  }
  .col-sm-pull-12 {
    right: 100%;
  }
  .col-sm-pull-11 {
    right: 91.66666667%;
  }
  .col-sm-pull-10 {
    right: 83.33333333%;
  }
  .col-sm-pull-9 {
    right: 75%;
  }
  .col-sm-pull-8 {
    right: 66.66666667%;
  }
  .col-sm-pull-7 {
    right: 58.33333333%;
  }
  .col-sm-pull-6 {
    right: 50%;
  }
  .col-sm-pull-5 {
    right: 41.66666667%;
  }
  .col-sm-pull-4 {
    right: 33.33333333%;
  }
  .col-sm-pull-3 {
    right: 25%;
  }
  .col-sm-pull-2 {
    right: 16.66666667%;
  }
  .col-sm-pull-1 {
    right: 8.33333333%;
  }
  .col-sm-pull-0 {
    right: auto;
  }
  .col-sm-push-12 {
    left: 100%;
  }
  .col-sm-push-11 {
    left: 91.66666667%;
  }
  .col-sm-push-10 {
    left: 83.33333333%;
  }
  .col-sm-push-9 {
    left: 75%;
  }
  .col-sm-push-8 {
    left: 66.66666667%;
  }
  .col-sm-push-7 {
    left: 58.33333333%;
  }
  .col-sm-push-6 {
    left: 50%;
  }
  .col-sm-push-5 {
    left: 41.66666667%;
  }
  .col-sm-push-4 {
    left: 33.33333333%;
  }
  .col-sm-push-3 {
    left: 25%;
  }
  .col-sm-push-2 {
    left: 16.66666667%;
  }
  .col-sm-push-1 {
    left: 8.33333333%;
  }
  .col-sm-push-0 {
    left: auto;
  }
  .col-sm-offset-12 {
    margin-left: 100%;
  }
  .col-sm-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-sm-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-sm-offset-9 {
    margin-left: 75%;
  }
  .col-sm-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-sm-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-sm-offset-6 {
    margin-left: 50%;
  }
  .col-sm-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-sm-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-sm-offset-3 {
    margin-left: 25%;
  }
  .col-sm-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-sm-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-sm-offset-0 {
    margin-left: 0;
  }
}
@media (min-width: 992px) {
  .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
    float: left;
  }
  .col-md-12 {
    width: 100%;
  }
  .col-md-11 {
    width: 91.66666667%;
  }
  .col-md-10 {
    width: 83.33333333%;
  }
  .col-md-9 {
    width: 75%;
  }
  .col-md-8 {
    width: 66.66666667%;
  }
  .col-md-7 {
    width: 58.33333333%;
  }
  .col-md-6 {
    width: 50%;
  }
  .col-md-5 {
    width: 41.66666667%;
  }
  .col-md-4 {
    width: 33.33333333%;
  }
  .col-md-3 {
    width: 25%;
  }
  .col-md-2 {
    width: 16.66666667%;
  }
  .col-md-1 {
    width: 8.33333333%;
  }
  .col-md-pull-12 {
    right: 100%;
  }
  .col-md-pull-11 {
    right: 91.66666667%;
  }
  .col-md-pull-10 {
    right: 83.33333333%;
  }
  .col-md-pull-9 {
    right: 75%;
  }
  .col-md-pull-8 {
    right: 66.66666667%;
  }
  .col-md-pull-7 {
    right: 58.33333333%;
  }
  .col-md-pull-6 {
    right: 50%;
  }
  .col-md-pull-5 {
    right: 41.66666667%;
  }
  .col-md-pull-4 {
    right: 33.33333333%;
  }
  .col-md-pull-3 {
    right: 25%;
  }
  .col-md-pull-2 {
    right: 16.66666667%;
  }
  .col-md-pull-1 {
    right: 8.33333333%;
  }
  .col-md-pull-0 {
    right: auto;
  }
  .col-md-push-12 {
    left: 100%;
  }
  .col-md-push-11 {
    left: 91.66666667%;
  }
  .col-md-push-10 {
    left: 83.33333333%;
  }
  .col-md-push-9 {
    left: 75%;
  }
  .col-md-push-8 {
    left: 66.66666667%;
  }
  .col-md-push-7 {
    left: 58.33333333%;
  }
  .col-md-push-6 {
    left: 50%;
  }
  .col-md-push-5 {
    left: 41.66666667%;
  }
  .col-md-push-4 {
    left: 33.33333333%;
  }
  .col-md-push-3 {
    left: 25%;
  }
  .col-md-push-2 {
    left: 16.66666667%;
  }
  .col-md-push-1 {
    left: 8.33333333%;
  }
  .col-md-push-0 {
    left: auto;
  }
  .col-md-offset-12 {
    margin-left: 100%;
  }
  .col-md-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-md-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-md-offset-9 {
    margin-left: 75%;
  }
  .col-md-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-md-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-md-offset-6 {
    margin-left: 50%;
  }
  .col-md-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-md-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-md-offset-3 {
    margin-left: 25%;
  }
  .col-md-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-md-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-md-offset-0 {
    margin-left: 0;
  }
}
@media (min-width: 1200px) {
  .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12 {
    float: left;
  }
  .col-lg-12 {
    width: 100%;
  }
  .col-lg-11 {
    width: 91.66666667%;
  }
  .col-lg-10 {
    width: 83.33333333%;
  }
  .col-lg-9 {
    width: 75%;
  }
  .col-lg-8 {
    width: 66.66666667%;
  }
  .col-lg-7 {
    width: 58.33333333%;
  }
  .col-lg-6 {
    width: 50%;
  }
  .col-lg-5 {
    width: 41.66666667%;
  }
  .col-lg-4 {
    width: 33.33333333%;
  }
  .col-lg-3 {
    width: 25%;
  }
  .col-lg-2 {
    width: 16.66666667%;
  }
  .col-lg-1 {
    width: 8.33333333%;
  }
  .col-lg-pull-12 {
    right: 100%;
  }
  .col-lg-pull-11 {
    right: 91.66666667%;
  }
  .col-lg-pull-10 {
    right: 83.33333333%;
  }
  .col-lg-pull-9 {
    right: 75%;
  }
  .col-lg-pull-8 {
    right: 66.66666667%;
  }
  .col-lg-pull-7 {
    right: 58.33333333%;
  }
  .col-lg-pull-6 {
    right: 50%;
  }
  .col-lg-pull-5 {
    right: 41.66666667%;
  }
  .col-lg-pull-4 {
    right: 33.33333333%;
  }
  .col-lg-pull-3 {
    right: 25%;
  }
  .col-lg-pull-2 {
    right: 16.66666667%;
  }
  .col-lg-pull-1 {
    right: 8.33333333%;
  }
  .col-lg-pull-0 {
    right: auto;
  }
  .col-lg-push-12 {
    left: 100%;
  }
  .col-lg-push-11 {
    left: 91.66666667%;
  }
  .col-lg-push-10 {
    left: 83.33333333%;
  }
  .col-lg-push-9 {
    left: 75%;
  }
  .col-lg-push-8 {
    left: 66.66666667%;
  }
  .col-lg-push-7 {
    left: 58.33333333%;
  }
  .col-lg-push-6 {
    left: 50%;
  }
  .col-lg-push-5 {
    left: 41.66666667%;
  }
  .col-lg-push-4 {
    left: 33.33333333%;
  }
  .col-lg-push-3 {
    left: 25%;
  }
  .col-lg-push-2 {
    left: 16.66666667%;
  }
  .col-lg-push-1 {
    left: 8.33333333%;
  }
  .col-lg-push-0 {
    left: auto;
  }
  .col-lg-offset-12 {
    margin-left: 100%;
  }
  .col-lg-offset-11 {
    margin-left: 91.66666667%;
  }
  .col-lg-offset-10 {
    margin-left: 83.33333333%;
  }
  .col-lg-offset-9 {
    margin-left: 75%;
  }
  .col-lg-offset-8 {
    margin-left: 66.66666667%;
  }
  .col-lg-offset-7 {
    margin-left: 58.33333333%;
  }
  .col-lg-offset-6 {
    margin-left: 50%;
  }
  .col-lg-offset-5 {
    margin-left: 41.66666667%;
  }
  .col-lg-offset-4 {
    margin-left: 33.33333333%;
  }
  .col-lg-offset-3 {
    margin-left: 25%;
  }
  .col-lg-offset-2 {
    margin-left: 16.66666667%;
  }
  .col-lg-offset-1 {
    margin-left: 8.33333333%;
  }
  .col-lg-offset-0 {
    margin-left: 0;
  }
}
</style>
<style>
.newevent .row p{
  margin-bottom: 10px;
  font-size: 16px;
}
</style>

</div>
<div class="detail_con product_info">
					<div class="container clearfix">
						<h4>&#9635;&nbsp;체크포인트</h4>
						
						<div class="tgp1">
						<table class="check_table">
							<caption>체크포인트</caption>
							<colgroup>
								<col class="cht_th1">
								<col class="cht_th2">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><span class="chk_number">1</span></th>
									<th>투자개요</th>
									<td><?php echo ( isset($extinfo['gaeyo']) && $extinfo['gaeyo']!='' ) ? nl2br($extinfo['gaeyo']): ''?></td>
								</tr>
								</tbody>
								</table>
								</div>
								
								<div class="tgp2">
								<table class="check_table">
							<caption>체크포인트-영업상황</caption>
							<colgroup>
								<col class="cht_th1">
								<col class="cht_th2">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><span class="chk_number">2</span></th>
									<th>영업상황</th>
									<td><?php echo ( isset($extinfo['gaeyo']) && $extinfo['gaeyo']!='' ) ? nl2br($extinfo['sanghwang']): ''?></td>
								</tr>
								</tbody>
								</table>
								</div>
								<div class="tgp2">
									<table class="check_table">
							<caption>체크포인트-담보력</caption>
							<colgroup>
								<col class="cht_th1">
								<col class="cht_th2">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><span class="chk_number">3</span></th>
									<th>담보력</th>
									<td><?php echo ( isset($extinfo['gaeyo']) && $extinfo['gaeyo']!='' ) ? nl2br($extinfo['dambo']): ''?></td>
								</tr>
								</tbody>
								</table>
								</div>
								<div class="tgp3">
									<table class="check_table">
							<caption>체크포인트-보호장치</caption>
							<colgroup>
								<col class="cht_th1">
								<col class="cht_th2">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><span class="chk_number">4</span></th>
									<th>보호장치</th>
									<td><?php echo ( isset($extinfo['gaeyo']) && $extinfo['gaeyo']!='' ) ? nl2br($extinfo['boho']): ''?></td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
					</div>
<?php } ?>
<div class="container clearfix">
<div class="<?php echo $event_class?>">
                <p ><strong>특별 이벤트</strong></p>
                <img src="/pnpinvest/data/file/<?php echo $loan_id?>/<?php echo $extinfo['eventfile']?>" alt="이벤트" style="width: 100%;">
              </div>
</div>








					<div class="container clearfix">
					
						<h4>&#9635;&nbsp;증빙서류 다운로드</h4>

            <?php if($total_file > 0 ){?>
                <ul class="download">
                  <?php
                    for($i=0; $list = sql_fetch_array($file_list); $i++){
                      $ext = explode('.', $list['file_name']);
                      $ext = strtolower($ext[ count($ext)-1]);
                      if($ext=='jpeg') $ext = "jpg";
                  ?>
                  <li>
                    <a href="/pnpinvest/data/file/<?php echo $loan_id?>/<?php echo $list['file_name']?>" target="_blank">
                      <i class="dl_ifon <?php echo $ext ?>"><?php echo $ext ?></i><span class="txt"><?php echo $list['file_name']?><i class="dl_btn">다운로드</span></i>
                    </a>
                  </li>
                  <?php
                    }
                  ?>
                </ul>

            <?php }?>


					</div>
					
        <?php if($loa['i_locaty']){?>
					<div class="container business_info">
						<h4>&#9635;&nbsp;지역정보</h4>
						<table class="business_table">
							<caption>지역정보</caption>
								<colgroup>
									<col style="width:25%;">
									<col>
								</colgroup>
							<tbody>
								<tr>
									<th>&#10625;&nbsp;소재지</th>
									<td><?php echo $loa['i_locaty']?></td>
								</tr>
            <?php if($loa['i_zone']){?>
								<tr>
									<th>&#10625;&nbsp;지역</th>
									<td><?php echo $loa['i_zone']?></td>
								</tr>
            <?php } ?>
            <?php if($loa['i_area']){?>
								<tr>
									<th>&#10625;&nbsp;면적</th>
									<td><?php echo $loa['i_area']?></td>
								</tr>
            <?php } ?>
							</tbody>
						</table>
						<div class="viewarea map" id="map"></div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29a8853bf770935237e38bd0bd60a170&libraries=services"></script>

            <script>
              var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                  mapOption = {
                      center: new daum.maps.LatLng(<?php echo $loa['i_locaty_01']?>, <?php echo $loa['i_locaty_02']?>), // 지도의 중심좌표
                      level: 3, // 지도의 확대 레벨
                      mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
                  };
              // 지도를 생성한다
              var map = new daum.maps.Map(mapContainer, mapOption);

              // 지형도 타일 이미지 추가
              map.addOverlayMapTypeId(daum.maps.MapTypeId.TERRAIN);

              // 지도 타입 변경 컨트롤을 생성한다
              var mapTypeControl = new daum.maps.MapTypeControl();

              // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
              map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

              // 지도에 확대 축소 컨트롤을 생성한다
              var zoomControl = new daum.maps.ZoomControl();

              // 지도의 우측에 확대 축소 컨트롤을 추가한다
              map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

              var geocoder = new daum.maps.services.Geocoder();
              geocoder.addressSearch('서울시 은평구 갈현로 36', function(result, status) {

                  // 정상적으로 검색이 완료됐으면
                   if (status === daum.maps.services.Status.OK) {

                      var coords = new daum.maps.LatLng(result[0].y, result[0].x);

                      // 결과값으로 받은 위치를 마커로 표시합니다
                      var marker = new daum.maps.Marker({
                          map: map,
                          position: coords
                      });

                      // 인포윈도우로 장소에 대한 설명을 표시합니다
                      var infowindow = new daum.maps.InfoWindow({
                          content: '<div style="width:150px;text-align:center;padding:6px 0;">서울시 은평구 갈현로 36</div>'
                      });
                      infowindow.open(map, marker);

                      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                      map.setCenter(coords);
                  }
              });
            </script>

					</div>
<?php } ?>
<?php if( isset($extinfo['view_jinhaeng']) && $extinfo['view_jinhaeng'] =='Y') { ?>
					<div class="container">
						<h4>사업현황</h4>
    <?php if( isset($extinfo['view_slide']) && $extinfo['view_slide'] =='Y') {
      $sql = "select * from z_gallery where loanid= $loan_id and gtype = 's' order by order_no";
      $imgres     = sql_query($sql);
      ?>
						<!-- 동산 -->
						<div class="condition movables">
              <div class="owl-carousel owl-theme navbarbox">
              <?php       while ( $row=sql_fetch_array($imgres) ){ ?>
                <div class="item"><img src="/pnpinvest/data/file/<?php echo $loan_id?>/gallery/<?php echo $row['file_name']?>"></div>
              <?php } ?>
              </div>
						</div>
      <?php } ?>
						<!-- 부동산 -->
						<div class="condition immovables">
      <?php if( isset($extinfo['view_gongjung']) && $extinfo['view_gongjung'] =='Y') { ?>
							<div class="immo_prg">
								<span class="txt">현재공정률</span>
								<p class="progress"><span class="p_bar" style="width:<?php echo $extinfo['gongjungryul'] ?>%; "><?php echo $extinfo['gongjungryul'] ?>%</span></p>
							</div>
      <?php } ?>

      <?php if( isset($extinfo['view_gongjung_slide']) && $extinfo['view_gongjung_slide'] =='Y') {
        $sql = "select * from z_gallery where loanid= $loan_id and gtype = 'p' order by order_no";
        $imgres     = sql_query($sql);
        ?>
              <div class="owl-carousel owl-theme navbarbox">
              <?php       while ( $row=sql_fetch_array($imgres) ){ ?>
                <div class="item"><img src="/pnpinvest/data/file/<?php echo $loan_id?>/gallery/<?php echo $row['file_name']?>"></div>
              <?php } ?>
              </div>
      <?php } ?>

      <?php if( isset($extinfo['nowstep']) && $extinfo['nowstep'] !='N') { ?>
							<ul class="process">
								<li <?php echo ($extinfo['nowstep']==1) ? "class='on'":""?> >01. 공사준비단계</li>
								<li <?php echo ($extinfo['nowstep']==2) ? "class='on'":""?> >02. 공사골조단계</li>
								<li <?php echo ($extinfo['nowstep']==3) ? "class='on'":""?> >03. 공사마감단계</li>
								<li <?php echo ($extinfo['nowstep']==4) ? "class='on'":""?> >04. 공사준공단계</li>
							</ul>
      <?php } ?>
      <?php if( isset($extinfo['nowstepdesc']) && $extinfo['nowstepdesc'] !='') { ?>
              <p class="infotxt"><?php echo nl2br($extinfo['nowstepdesc']) ?></p>
        <?php } ?>

						</div>
		</div>
<?php } ?>

					
					
				</div>
				
				<!-- 이자계산기 탭 -->
				<h3 class="title inverest"><i class="bg"></i><span class="txt">이자계산기</span></h3>
				<div class="detail_con inverest">
					<div class="container">
					<div class="thgp1">
            <form name="calcform">
            <input type="hidden" name="loanid" value="<?php echo $loan_id?>">
            <input type="hidden" name="type" value="json">
  						<h4>투자예정 <span>금액입력</span></h4>
  						<div class="sum">
  							<p class="sum1">
                  <!--input type="text" name="won" value="5,000,000"><span class="txt">원</span-->
                  <input type="text" name="won" value="5,000,000" class="form-control"><span class="txt">원</span>
                </p>
  							<p class="sum2">
  								<a class="btn t4 mr" href="javascript:;" onClick="addnum(5000000)">+500만원</a>
  								<a class="btn t4 mr" href="javascript:;" onClick="addnum(1000000)">+100만원</a>
  								<a class="btn t4" href="javascript:;" onClick="addnum(500000)">+50만원</a>
  							</p>
  							<p class="sum3"><a class="btn t5" href="javascript:;" onclick="calc()">이자 수익 계산기</a></p>
  							<p class="sum4">최소 <?php echo change_pay($iv['i_invest_mini'])?>원부터 투자하실 수 있습니다.</p>
							</div>
  						</div>
            </form>
					</div>
					<div class="container">
						<h4>상환예정표</h4>
						<p class="date1">대출실행일<span class="calc_info_startd"></span>기준</p>
						<table class="plan">
							<caption>상환예정표</caption>
							<colgroup>
								<col class="width:33%;">
								<col class="width:33%;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">만기상환일</th>
									<th scope="col">투자원금</th>
									<th scope="col">플랫폼수수료</th>
								</tr>
								<tr>
									<td><span id="calc_info_endd"></span></td>
									<td><span id="calc_info_won"></span>원</td>
									<td><span id="calc_total_profit"></span>원</td>
								</tr>
								<tr>
									<th>수익금(세전)</th>
									<th>세금(이자소득+주민세)</th>
									<th>수익금(세후)</th>
								</tr>
								<tr>
									<td><span class="calc_totalija"><span>원</td>
									<td><span class="calc_total_withholding"><span>원</td>
									<td><span class="calc_total_calc"><span>원</td>
								</tr>
							</tbody>
						</table>

						<p class="plan_txt">*중도상환 등 기타 사유 발생 시 실제 수익금 및 플랫폼 이용료는 변동될 수 있습니다.</p>
					</div>
					<div class="container">
						<h4>월별 수익금 <span>지급 예정표</span></h4>
						<p class="date2">대출실행일 <span class="calc_info_startd"></span> 기준</span></p>
						<table class="profit">
							<caption>월별 수익금 지급 예정표</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:20%;">
								<col style="width:10%;">
								<col style="width:27%;">
								<col style="width:22%;">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">회차</th>
									<th scope="col">지급일</th>
									<th scope="col">이용일수</th>
									<th scope="col">수익금(세전)</th>
									<th scope="col">이자소득세</th>
									<th scope="col">수익금(세후)</th>
								</tr>
							</thead>
							<tbody id="calc_table_body">
                <tr>
                  <td class="empty" colspan="6">투자금액을 입력해 주세요.</td>
                </tr>
							</tbody>
							<tfoot>
								<tr>
									<th scope="row" colspan="3">총합계</td>
                  <td><span class="calc_totalija"><span>원</td>
									<td><span class="calc_total_withholding"><span>원</td>
									<td><span class="calc_total_calc"><span>원</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="container guide">
						<h4>케이펀딩 투자 <span>수익금 및 원금</span> <span>지급 가이드</span></h4>
						<dl>
							<dt>수익금 지급 :</dt>
							<dd>익금은 대출실행일부터 일 단위로 일할 계산되며, 매달 말일에 세금 원천징수 후 지급됩니다.<br>
							(말일이 공휴일일 경우 다음 영업일에 지급)</dd>
						</dl>
						<dl>
							<dt>원금상환 :</dt>
							<dd>대출자가 대출금 상환 즉시 투자자에게 원금이 상환됩니다.<br>
							※ 투자상품별로 각 사정에 따라 조기상환 될 수 있습니다.</dd>
						</dl>
						<dl>
							<dt>세금 :</dt>
							<dd>이자 소득에 대한 세금 원천징수 후 차감된 금액(세후)이 케이펀딩 가상계좌로 입금됩니다.<br>
							※ 이자소득세율 : 이자소득세 25% + 주민세 2.5% = 27.5%</dd>
						</dl>
						<dl>
							<dt>플랫폼 수수료 :</dt>
							<dd>당 상품은 플랫폼 수수료가 발생하지 않습니다.</dd>
						</dl>
					</div>
					
<div class="container clearfix">
						<h4>투자자 구분에 따른 자격요건 및 투자한도</h4>
            <style>
            .my_info_05 .mobile2 {margin-top:10px;margin-bottom: 10px;}
            .my_info_05 thead th {
              padding:8px 0;
              border-top: 1px solid #AAA;
              border-bottom: 1px solid #AAA;
            }
            .my_info_05 tbody th {
              padding:5px 0;
              border-bottom: 1px solid #AAA;
              border-right: 1px solid #AAA;
            }
            .my_info_05 td {
                padding:5px 0;
                border-bottom: 1px solid #AAA;
                text-align: center;
            }
            .my_info_05 td:not(:last-child) , .my_info_05 th:not(:last-child) {
              border-right: 1px solid #AAA;
            }
            .my_info_05 td.bg_blue{
              background-color:#b2e4e1;
            }
            .my_info_05 td.bg_pink{
              background-color:#facdbe;
            }
            .mobile table{margin-bottom: 10px;width:100%}
            .my_info_05 p.txt {margin-bottom: 10px;}
            </style>
						<div class="my_info_05">
							<table class="pc">
								<caption>투자자 구분에 따른 자격요건 및 투자한도</caption>
								<colgroup>
									<col style="width:14%;">
									<col style="width:30%;">
									<col style="width:13%;">
									<col style="width:13%;">
									<col style="width:30%;">
								</colgroup>
								<thead>
									<tr>
										<th>구분</th>
										<th>자격요건</th>
										<th>동산 투자한도</th>
										<th>부동산 투자한도</th>
										<th>증빙서류</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>개인 투자자</th>
										<td rowspan="2">없음</td>
										<td rowspan="2">동일 상품(차압자)<br>500만원 이하<br>연간 2,000만원 이하</td>
										<td rowspan="2">동일 상품(차압자)<br>500만원 이하<br>연간 1,000만원 이하</td>
										<td>없음</td>
									</tr>
									<tr>
										<th>외국인 개인 투자자</th>
										<td>외국인 등록증 앞/뒷면 사본</td>
									</tr>
									<tr>
										<th rowspan="3">소득적격 투자자<br>(개인)</th>
										<td class="bg_blue">아래의 요건 중 한가지를 만족하는 경우</td>
										<td rowspan="3">동일 상품(차압자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
										<td rowspan="3">동일 상품(차압자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
										<td rowspan="3">종합소득 과제표준 확정신고서 또는<br>
										종합소득제 신고세 접수증,<br>
										근로소득 원천징수 영수증</td>
									</tr>
									<tr>
										<td class="bg_blue">사업&middot;근로소득 1억원 이상</td>
									</tr>
									<tr>
										<td class="bg_blue">이자&middot;배당소득 2,000만원 이상</td>
									</tr>
									<tr>
										<th rowspan="2">전문 투자자<br>(개인)</th>
										<td class="bg_pink">아래의 요건을 모두 만족하는 경우</td>
										<td rowspan="2">한도없음</td>
										<td rowspan="2">한도없음</td>
										<td rowspan="2">금융투자협회 전문투자자 확인증</td>
									</tr>
									<tr>
										<td class="bg_pink">금융투자업자 계좌개설 1년 경과<br>
										금융투자상품 잔고 5억원 이상<br>
										소득액 1억원 또는 재산가액 10억원</td>
									</tr>
									<tr>
										<th>법인</th>
										<td>없음</td>
										<td>한도없음</td>
										<td>한도없음</td>
										<td>사업자 등록증,사업주 신분증,법인통장 사본</td>
									</tr>
								</tbody>
							</table>
							<div class="mobile">
								<table>
									<caption>투자자 구분에 따른 자격요건</caption>
									<colgroup>
										<col style="width:25%">
										<col>
										<col style="width:25%">
									</colgroup>
									<thead>
										<tr>
											<th>구분</th>
											<th>자격요건</th>
											<th>증빙서류</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>개인 투자자</th>
											<td rowspan="2">없음</td>
											<td>없음</td>
										</tr>
										<tr>
											<th>외국인 개인 투자자</th>
											<td>회국인 등록증 앞/뒷면 사본</td>
										</tr>
										<tr>
											<th rowspan="3">소득적격 투자자<br>(개인)</th>
											<td class="bg_blue">아래의 요건 중 한가지를 만족하는 경우</td>
											<td rowspan="3">종합소득 과제표준 확정신고서 또는<br>
											종합소득제 신고세 접수증,<br>
											근로소득 원천징수 영수증</td>
										</tr>
										<tr>
											<td class="bg_blue">사업&middot;근로소득 1억원 이상</td>
										</tr>
										<tr>
											<td class="bg_blue">이자&middot;배당소득 2,000만원 이상</td>
										</tr>
										<tr>
											<th rowspan="2">전문 투자자<br>(개인)</th>
											<td class="bg_pink">아래의 요건을 모두 만족하는 경우</td>
											<td rowspan="2">금융투자협회<br>전문투자자 확인증</td>
										</tr>
										<tr>
											<td class="bg_pink">금융투자업자 계좌개설 1년 경과<br>
											금융투자상품 잔고 5억원 이상<br>
											소득액 1억원 또는 재산가액 10억원</td>
										</tr>
										<tr>
											<th>법인</th>
											<td>없음</td>
											<td>사업자 등록증,<br>사업주 신분증,<br>법인통장 사본</td>
										</tr>
									</tbody>
								</table>
								<table>
									<caption>투자자 구분에 따른 투자한도</caption>
									<colgroup>
										<col style="width:25%;">
										<col>
										<col>
									</colgroup>
									<thead>
										<tr>
											<th>구분</th>
											<th>비부동산 투자한도</th>
											<th>부동산 투자한도</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>개인 투자자</th>
											<td rowspan="2">동일 상품(차압자)<br>500만원 이하<br>연간 2,000만원 이하</td>
											<td rowspan="2">동일 상품(차압자)<br>500만원 이하<br>연간 1,000만원 이하</td>
										</tr>
										<tr>
											<th>외국인 개인 투자자</th>
										</tr>
										<tr>
											<th>소득적격 투자자<br>(개인)</th>
											<td>동일 상품(차압자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
											<td>동일 상품(차압자)<br>2,000만원 이하<br>연간 4,000만원 이하</td>
										</tr>
										<tr>
											<th>전문 투자자<br>(개인)</th>
											<td>한도없음</td>
											<td>한도없음</td>
										</tr>
										<tr>
											<th>법인</th>
											<td>한도없음</td>
											<td>한도없음</td>
										</tr>
									</tbody>
								</table>
							</div>
							<p class="txt">투자한도는 동일 년도의 기준이 아니며, 동시 투자 한도 금액입니다.<br>
							(최대한도 투자 후, 기 투자 금액이 상환된 후에 재투자 가능합니다.)</p>
							<p class="txt">회원가입 후, 증빙서류를 help@kfunding.co.kr 으로 전달해 주시면 투자한도를 변경해 드립니다.</p>
						</div>
					</div>					
					
					
					
				</div>
				
				
				
				
				
				<!-- 갤러리 탭 -->
				<h3 class="title gallery"><i class="bg"></i><span class="txt">CAST</span></h3>
				<div class="detail_con gallery">
        <link href="/assets/zcast.css" rel="stylesheet" />

        <!--
					<ul class="viewarea">
          <?php
          $sql = "select * from z_gallery where loanid= $loan_id and gtype = 'g' order by order_no";
          $imgres     = sql_query($sql);
          while ( $row=sql_fetch_array($imgres) ){
          ?>
            <li><img src="/pnpinvest/data/file/<?php echo $loan_id?>/gallery/<?php echo $row['file_name']?>"></li>
          <?php } ?>

					</ul>
          <?php if(isset($extinfo['gallerydesc']) && $extinfo['gallerydesc'] != '') {?>
          <div class="gallerytxt">
          <?php echo stripslashes($extinfo['gallerydesc'])?>
          </div>
          <?php } ?>
          -->
          <?php
            $sql = "select * from z_cast where loan_id= $loan_id and isview='Y' order by cast_idx desc limit 1";
            $castres = sql_query($sql);
            while ( $row=sql_fetch_array($castres) ){
              ?>
              <div>
                <h3 class="note-editable card-title" style="font-size:20px;"><?php echo $row['cast_title']?></h3>
                <div class="note-editable regdate"><?php echo $row['regdate']?></div>
                <div class="note-editable" style="text-align:left;">
                <?php echo $row['cast_body']?>
                </div>
              </div>
              <?php
            }
          ?>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
<style>
button:focus {outline:0;}
.owl-carousel.navbarbox .owl-nav button.owl-next, .owl-carousel.navbarbox .owl-nav button.owl-prev, .owl-carousel.navbarbox  button.owl-dot {
    width: 38px;
}
.owl-carousel.navbarbox .owl-nav button:hover{
  box-shadow:none;
}
.owl-carousel.navbarbox .owl-stage-outer{border:1px solid #00656a;}
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
  ul.process{margin-top: 15px;}
</style>

<script>
var limit = <?php echo $iv['i_invest_mini']?>;
function investment(){
  <?php if (!$isauthed) { ?>
      $("#openmodal").click();
  <?php  }else if ($user===false){ ?>
    $('.alert_wrap').fadeIn();
		$('.alert_wrap .login').fadeIn();
  <?php  }else{ ?>
      location.href='/pnpinvest/?mode=invest2&loan_id=<?php echo $loan_id?>';
  <?php  } ?>
}
</script>

<script>
function setComma(inNum){
     var outNum;
     var rgx2 = /(\d+)(\d{3})/;
     if (typeof inNum == 'number') inNum = String(inNum);
     outNum = inNum;
     while (rgx2.test(outNum)) {
          outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
      }
     return outNum;
}
function addnum(num){
   $("input[name=won]").val( setComma( (parseInt( $("input[name=won]").val().replace(/[^0-9]/g,"")) + num) +'' ) );
}
function calc(){
  if( $("form[name=calcform] input[name=won]").val() < limit ){
    alert ("최소 투자금액은 "+limit+" 입니다.");
    return;
  }
  $.ajax({
    url:"/api/index.php/main/calcabout",
     type : 'GET',
     data:$("form[name=calcform]").serialize(),
     dataType : 'json',
     success : function(result) {
       $("#calc_info_endd").text( (result.info.endd1==null) ? '' :result.info.endd1 );
       $(".calc_info_startd").text( result.info.startd);
       $("#calc_info_won").text( setComma(result.info.won));
       $("#calc_total_profit").text( setComma(result.total.profit));
       $(".calc_totalija").text( setComma(result.total.ija));
       $(".calc_total_withholding").text( setComma(result.total.withholding));
       $(".calc_total_calc").text( setComma(result.total.ija - result.total.profit -result.total.withholding) );
       $("#calc_table_body").empty();
       $.each( result.calc, function (idx,val){
         var tr = '<tr><th scope="row">'+(idx+1)+'회차</td><td>'+val.end+'</td><td>'+val.diff+'일</td><td>'+setComma(val.ija)+'원</td><td>'+setComma(val.withholding)+'원</td><td>'+setComma(val.ija-val.withholding - val.profit)+'원</td></tr>';
         $("#calc_table_body").append(tr);
       });
     },
     error: function(request, status, error) {
       console.log(request + "/" + status + "/" + error);

     }
  });
}
function resized() {
  $("#colorboxtr").css("background-size" , $("#colorboxtr").width()+'px, 15px');
}
function viewCalc(){
  $("div.tab h3.title.on").removeClass('on');
  $("div.tab h3.title.inverest").addClass('on');
  $("div.tab div.detail_con").removeClass('on');
  $("div.tab div.detail_con.inverest").addClass('on');
}
function callbackOwl(event) {
  if (parseInt($(event.target).find('div.item').length) <= 1) {
    ;
    event.relatedTarget.options.loop = false;
  }
}
$(window).resize( resized );

$(document).ready(function(){
  resized();

  $('a[rel*=leanModal]').leanModal({ top : 150, closeButton: ".modal_close" });
  $("#openmodal").click();

  $(".owl-carousel").owlCarousel({
    items:1,
    margin:10,
    autoHeight:true,
    loop : true,
    autoplay:true,
    autoplayTimeout:2000,
    autoplayHoverPause:true,
    center:true,
    itemsScaleUp:true,
    nav: true,
    navText: ["<img src='js/owl/assets/left2.png' style='width: 38px;'>","<img src='js/owl/assets/right2.png' style='width: 38px;'>"],
    onInitialize: callbackOwl,
  });

  $("input[name=won]").keyup(function(){
       $(this).val(setComma($(this).val().replace(/[^0-9]/g,"")));
  });
  calc();
});
</script>
{# new_footer}
