<!-- header -->
<div id="pageheader" class="page-header header-filter clear-filter" data-parallax="false" filter-color="grey" style="width:100vw;height:250px;background-image: url('/assets/material-kit/assets/img/examples/city.jpg');background-position: center center;background-size: cover;">
  <div class="page-title">
  </div>
</div>
<!-- / header -->
<style>
#mainbody{
background-color:  #F7F7F7;
color:#73879C;
}
.container{
  padding-top:20px;
  padding-bottom:20px;
}
.shadowbox{
  box-shadow: 2px 4px 6px 0 rgba(0,0,0,0.2);
  -webkit-box-shadow: 2px 4px 6px 0 rgba(0,0,0,0.2)
}
.fixed_height_200 {
    height: 200px;
}
.fixed_height_320 {
    height: 320px;
}

.profile-col{
  text-align: right;
  padding-right: 15px;
  font-size: 16px;
  margin-top: 15px;
  margin-bottom: 15px;
}
.profile-col span.btn{
  font-size:16px;
}
.tile-stats {
    position: relative;
    display: block;
    margin-bottom: 12px;
    border: 1px solid #d6dae0;
    -webkit-border-radius: 5px;
    overflow: hidden;
    padding-bottom: 5px;
    -webkit-background-clip: padding-box;
    -moz-border-radius: 5px;
    -moz-background-clip: padding;
    border-radius: 5px;
    background: #FFF;
    transition: all .3s ease-in-out;
}
.tile-stats .count, .tile-stats h3, .tile-stats p {
    position: relative;
    margin: 0 0 0 10px;
    z-index: 5;
    padding: 0;
    font-size:20px;
}
.tile-stats h3{
  color: #627ca9;
  padding-left: 6px;
  font-weight: 800;
}
.tile-stats .icon {
  width: 20px;
  height: 20px;
  color: #d0d0d0;
  position: absolute;
  /* right: 229px; */
  top: 28px;
  left: 8px;
}
.tile-stats .icon i {
  margin: 0;
  font-size: 34px;
  line-height: 0;
  vertical-align: bottom;
  padding: 0;
}
.tile-stats .icon span{
  font-size: 42px;
  top: -50px;
  margin: 0;
  font-size: 36px;
  line-height: 0;
  vertical-align: bottom;
  padding: 5px;
  border: 1px solid #bab8b8;
  border-radius: 9px;
  background-color: #bab8b8;
  color: white;
}
.tile-stats p {
    margin-top: 5px;
    font-size: 12px;
}
.tile-stats .count {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.65857;
  text-align: right;
  padding-right: 18px;
}
.tile-stats .text-right{
  padding-right:20px;
}

.profile-col .tooltip span{
  color:blue;
}
.profile-col .tooltip p{
  padding-left: 20px;
}
.profile-col .tooltip-inner {
    max-width: 480px;
    min-width: 240px;
    width: 90%;
    text-align: left;
}
.degrees:after, .x_content, .x_panel {
    position: relative;
}

.overflow_hidden, .sidebar-widget, .site_title, .tile, .weather-days .col-sm-2, .x_title h2, table.tile_info td p {
    overflow: hidden;
}
.x_panel, .x_title {
    margin-bottom: 10px;
}
.degrees:after, .x_content, .x_panel {
    position: relative;
}
.x_panel {
    width: 100%;
    padding: 10px 17px;
    display: inline-block;
    background: #fff;
    border: 1px solid #d6dae0;
    -webkit-column-break-inside: avoid;
    -moz-column-break-inside: avoid;
    column-break-inside: avoid;
    opacity: 1;
    transition: all .2s ease;
}
.x_panel .navbar-right{
  float: right!important;
}
.x_title {
    border-bottom: 2px solid #E6E9ED;
    padding: 1px 5px 6px;
    margin-bottom: 10px;
}
.x_title h2 {
    margin: 5px 0 6px;
    float: left;
    display: block;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    font-size: 20px;
    font-weight: 600;
}
.panel_toolbox>li {
    float: left;
    cursor: pointer;
}
.panel_toolbox>li>a {
    padding: 5px;
    color: #C5C7CB;
    font-size: 14px;
}
.x_content{
  padding: 0 5px 6px;
  float: left;
  clear: both;
  margin-top: 5px;
  width: 100%;
  position: relative;

}
.bank_row {
  font-size:16px;
  padding: 10px 15px;
}
.bank_row .row{
  margin-top: 5px;
  margin-bottom: 8px;
}
.bank_row_title{
  font-weight: 800;
}
.oncenter{
  margin: auto;
  /* height: 100%; */
  position: absolute;
  text-align: center;
  width: 100%;
  top: 50%;
  transform: translateY(-50%);
}
.titlecolor{
  color:#8d9298 !important;
}
</style>
<div id="mainbody">
  <div class="container">
  <!-- start main -->
    <div class="row">
      <!-- left -->
      <div class="col-lg-3 hidden-md hidden-sm hidden-xs">
        <style>
        .left-menu .a{
          display:block;
          padding :10px
        }
        </style>
        <div class="tile-stats left-menu" style="margin-top:90px;">
              <h6 class="dropdown-header">My Page</h6>
              <a href="#pablo" class="dropdown-item2">Action</a>
              <a href="#pablo" class="dropdown-item2">Another action</a>
        </div>
      </div>
      <!-- / left -->
      <div class="col-lg-9">
        <!-- right -->
        <div class="row">
          <div class="col-xs-12">
            <div class="profile-col">
            <span class="btn btn-warning" data-toggle="hide_tooltip" data-placement="bottom" title="<span>부동산 상품:</span><p>동일 상품(차압자)  500만원 이하<br>연간  1,000만원 이하</p><span>동산 상품:</span><p>동일 상품(차압자)  500만원 이하<br>연간 2,000만원 이하</p>" ><i class="fas fa-users"></i> 전문투자자</span>
            <span class="btn btn-info"><i class="fas fa-user-circle"></i> 홍길동 님</span>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="hidden-lg hidden-md col-sm-6 hidden-xs">
            <div class="tile-stats">
              <div class="icon"><i class="fas fa-user-circle"></i></div>
              <div class="count" style="padding-right: 34px;">홍길동님</div>
              <h3 class="text-right">전문투자자 이십니다.</h3>
              <p class="text-right">&nbsp;</p>
            </div>
          </div>

          <div class="col-md-4 col-sm-6">
            <div class="tile-stats">
              <div class="icon"><i class="fas fa-won-sign"></i></div>
              <div class="count">50,000,000</div>
              <h3 class="text-right titlecolor">예치금</h3>
              <p class="text-right">현재 가상계좌에 있는 금액입니다.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="tile-stats">
              <div class="icon"><i class="fas fa-won-sign"></i></div>
              <div class="count">50,000,000</div>
              <h3 class="text-right titlecolor">투자중인 금액</h3>
              <p class="text-right">자세한 내역은 투자정보를 참고하세요.</p>
            </div>
          </div>

          <div class="col-md-4 col-sm-6">
            <div class="tile-stats">
              <div class="icon"><i class="fas fa-won-sign"></i></div>
              <div class="count">50,000,000</div>
              <h3 class="text-right titlecolor">투자가능 금액</h3>
              <p class="text-right">동산기준 투자가능한 금액입니다.</p>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-sm-6">
            <div class="x_panel tile fixed_height_200">
              <div class="x_title">
                  <h2 class="titlecolor">가상계좌</h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <!--li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Settings 1</a>
                        </li>
                        <li><a href="#">Settings 2</a>
                        </li>
                      </ul>
                    </li-->
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="oncenter" style="top:50px;">
                    <a href="" class="btn btn-social btn-fill btn-facebook" style="font-size:16px;">가상계좌발급하기</a>
                  </div>
                </div>
            </div>
          </div>

          <div class="col-sm-6">
            <div class="x_panel tile fixed_height_200">
              <div class="x_title">
                  <h2 class="titlecolor">출금계좌</h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <!--li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Settings 1</a>
                        </li>
                        <li><a href="#">Settings 2</a>
                        </li>
                      </ul>
                    </li-->
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="bank_row">
                    <div class="row">
                      <div class="col-xs-4 bank_row_title">은행명</div>
                      <div class="col-xs-8 bank_row_sub text-right">카카오뱅크</div>
                    </div>
                    <div class="row">
                      <div class="col-xs-4 bank_row_title">예금주</div>
                      <div class="col-xs-8 bank_row_sub text-right">(주)케이펀딩어쩌구</div>
                    </div>
                    <div class="row">
                      <div class="col-xs-4 bank_row_title">계좌번호</div>
                      <div class="col-xs-8 bank_row_sub text-right">000-00-0000-0000</div>
                    </div>
                  </div>
                </div>
            </div>
          </div>
        </div>
<!-- 요약 -->
<style>
.tile_count .tile_stats_count {
    margin-bottom: 10px;
    border-bottom: 0;
    padding-bottom: 10px;
    position: relative;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.tile_count .tile_stats_count:not(:first-child):before {
    content: "";
    position: absolute;
    left: 0;
    height: 65px;
    border-left: 2px solid #ADB2B5;
    margin-top: 10px;
}
.tile_stats_count .count_top {
  font-size:16px;
  font-weight: 600;
}
.tile_stats_count .count {
  font-size:20px;
  text-align: right;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-top: 8px;
      padding-bottom: 4px;
}

.tile_stats_count .count_bottom{
  text-align: right;
}
</style>

<div class="row">
  <div class="col-xs-12">
    <div class="x_panel">
      <div class="x_title">
          <h2 class="titlecolor">투자현황</h2>
          <ul class="nav navbar-right panel_toolbox">
            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
            </li>
            <li><a class="close-link"><i class="fa fa-close"></i></a>
            </li>
          </ul>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <div class="row tile_count">
            <div class="col-sm-3 col-xs-6 tile_stats_count">
              <span class="count_top titlecolor">상환중</span>
              <div class="count">2건</div>
              <div class="count_bottom"> 현 투자건수</div>
            </div>
            <div class="col-sm-3 col-xs-6 tile_stats_count">
              <span class="count_top titlecolor">잔여상환금</span>
              <div class="count">10,000,000 원</div>
              <div class="count_bottom">현재 투자중인 금액</div>
            </div>
            <div class="col-sm-3 col-xs-6 tile_stats_count">
              <span class="count_top titlecolor">연체</span>
              <div class="count">0 건</div>
              <div class="count_bottom">연체중인 건수</div>
            </div>
            <div class="col-sm-3 col-xs-6 tile_stats_count">
              <span class="count_top titlecolor">채권발생</span>
              <div class="count">0 건</div>
              <div class="count_bottom">장기연체중인 건수</div>
            </div>
          </div>
        </div>
    </div>
  </div>
</div>


        <div class="row">
          <div class="col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                  <h2 class="titlecolor">누적투자현황</h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="row tile_count">
                    <div class="col-sm-3 col-xs-6 tile_stats_count">
                      <span class="count_top titlecolor"><i class="fas fa-hand-holding-usd"></i> 투자 건수</span>
                      <div class="count">2건</div>
                      <div class="count_bottom">총 투자건수 입니다.</div>
                    </div>
                    <div class="col-sm-3 col-xs-6 tile_stats_count">
                      <span class="count_top titlecolor"><i class="fas fa-percent"></i> 수익률(예상)</span>
                      <div class="count">18.09%</div>
                      <div class="count_bottom">총 수익률(예상).</div>
                    </div>
                    <div class="col-sm-3 col-xs-6 tile_stats_count">
                      <span class="count_top titlecolor"><i class="fas fa-won-sign"></i> 투자 금액</span>
                      <div class="count">10,000,000원</div>
                      <div class="count_bottom">총 투자금액입니다.</div>
                    </div>
                    <div class="col-sm-3 col-xs-6 tile_stats_count">
                      <span class="count_top titlecolor"><i class="fas fa-level-up-alt"></i> 수익금(예상)</span>
                      <div class="count">1,000,000원</div>
                      <div class="count_bottom">누적투자 수익금 (예상)</div>
                    </div>
                  </div>
                </div>
            </div>
          </div>
        </div>
<!-- /요약 -->
<div class="bottom-desc">
    <div class="row">
      <div class="col-sm-6">
          <p>개인투자자</p>
          <div class="hidden">
            <table>
              <tr>
                <th>자격요건</th>
                <td>없음</td>
              </tr>
              <tr>
                <th>동산 투자한도</th>
                <td>일 상품(차압자) 500만원 이하, 연간 2,000만원 이하</td>
              </tr>
              <tr>
                <th>부동산 투자한도</th>
                <td>동일 상품(차압자) 500만원 이하, 연간 1,000만원 이하</td>
              </tr>
              <tr>
                <th>증빙서류</th>
                <td>내국인 : 없음<br>외국인 : 외국인 등록증 앞/뒷면 사본</td>
              </tr>
              <tr>
                <th></th>
                <td></td>
              </tr>
            </table>
          </div>
      </div>
    </div>
  <p>투자한도는 동일 년도의 기준이 아니며, 동시 투자 한도 금액입니다.<br>(최대한도 투자 후, 기 투자 금액이 상환된 후에 재투자 가능합니다.)</p>
  <p>회원가입 후, 증빙서류를 contact@kfunding.co.kr 으로 전달해 주시면 투자한도를 변경해 드립니다.</p>
</div>
        <!-- /right -->
      </div>
    </div>
  <!-- / end main -->
  </div>
</div>
<script>
$("document").ready( function() {
  $('[data-toggle="hide_tooltip"]').tooltip({trigger:'hover focus',html:true}).tooltip('hide');
  $('.collapse-link').on('click', function() {
    var $BOX_PANEL = $(this).closest('.x_panel'),
        $ICON = $(this).find('i'),
        $BOX_CONTENT = $BOX_PANEL.find('.x_content');

    // fix for some div with hardcoded fix class
    if ($BOX_PANEL.attr('style')) {
        $BOX_CONTENT.slideToggle(200, function(){
            $BOX_PANEL.removeAttr('style');
        });
    } else {
        $BOX_CONTENT.slideToggle(200);
        $BOX_PANEL.css('height', 'auto');
    }

    $ICON.toggleClass('fa-chevron-up fa-chevron-down');
  });

  $('.close-link').click(function () {
      var $BOX_PANEL = $(this).closest('.x_panel');

      $BOX_PANEL.remove();
  });
})


</script>
