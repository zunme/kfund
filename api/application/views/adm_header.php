<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>태기드민 </title>

    <!-- Bootstrap -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap/dist/css/bootstrap.min.css?v=20180105110142" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/font-awesome/css/font-awesome.min.css?v=20180105110142" rel="stylesheet">
    <!-- merge -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/styles.css?v=20180105110142" rel="stylesheet">
    <!-- NProgress -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/nprogress/nprogress.css" rel="stylesheet"-->
    <!-- iCheck -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/iCheck/skins/flat/green.css?v=20180105110142" rel="stylesheet">

    <!-- bootstrap-progressbar -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet"-->
    <!-- JQVMap Not USE-->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/-->
    <!-- bootstrap-daterangepicker -->
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet"-->

    <!-- Datatables -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.merge.min.css?v=20180105110142" rel="stylesheet">
    <!--link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"-->

    <!-- Custom Theme Style -->
    <link href="/pnpinvest/layouts/home/pnpinvest/gentelella/build/css/custom.min.css" rel="stylesheet">
    <style>
    td.details-control {
        background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_open.png') no-repeat center center;
        cursor: pointer;
    }
    tr.shown td.details-control {
        background: url('/pnpinvest/layouts/home/pnpinvest/DataTables/details_close.png') no-repeat center center;
    }
    .linked_class, span.memauthcancel { color: #008EFC; cursor:pointer;}
    span.memauth { color: #FF0042; cursor:pointer;}
    .loading {
      position: fixed;
      top: 0;
      width: 100%;
      height: 100%;
      background: white;
      z-index: 1032;
      opacity: 1;
      transition: opacity 0.5s cubic-bezier(0.7, 0, 0.3, 1);
    }
    .loading.hide {
      display: none;
    }
    .loading .loading-container {
      z-index: 1033;
      display: block;
      position: relative;
      text-align: center;
      top: 50%;
      left: 50%;
      -webkit-transform: translate(-50%, -50%);
      -moz-transform: translate(-50%, -50%);
      -o-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
      transform: translate(-50%, -50%);
    }
    .loading .loading-container .loader {
      width: 40px;
    }
    .loading .loading-container p {
      font-size: 30px;
      margin-bottom: 30px;
    }
@media only screen and (max-width: 767px) {
  .modal-dialog { width: 400px; }
}
@media only screen and (min-width: 768px) {
  .modal-dialog { width: 660px; }
}
@media only screen and (min-width: 900px) {
  .modal-dialog { width: 800px; }
}
@media only screen and (min-width: 1200px) {
  .modal-dialog { width: 1100px; }
}
@media only screen and (min-width: 1400px) {
  .modal-dialog { width: 1300px; }
}
@media only screen and (min-width: 1600px) {
  .modal-dialog { width: 1500px; }
}
.nullmenu{padding :5px 0 15px 30px;color:white;}
    </style>
  </head>

  <body class="nav-md">
    <div id="mainpreloader" class="loading">
        <div class="loading-container">
            <p>K Funding</p>
            <img class="loader" src="/api/statics/img/rubik.svg"/>
        </div>
    </div>
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="/api/index.php/adm" class="site_title"><i class="fa fa-paw"></i> <span>Admin</span></a>
            </div>

            <div class="clearfix"></div>

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a href="/api/index.php/adm"><i class="fa fa-home"></i> Home</a></li>
                  <!--li><a href="/api/index.php/adm/tranceform"><i class="fa fa-bank"></i> 이체</a></li-->
                </ul>
                <h3>ETC</h3>
                <ul class="nav side-menu">
                  <li><span href="/api/index.php/investcheck" class="triggerModal80 nullmenu">가상투자</span></li>
                  <li><span href="/api/index.php/eventcheck" class="triggerModal80 nullmenu">eventcheck</span></li>
                  <li><span href="/api/index.php/consulting/admviewlist" class="triggerModal80 nullmenu">상담리스트</span></li>
                  <li><span href="/api/index.php/design/main" class="triggerModal80 nullmenu">안심케어</span></li>
                  <li><span href="/api/index.php/consulting/toplist" class="triggerModal80 nullmenu">top list</span></li>
                </ul>
              </div>


            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="홈페이지메인" href="/pnpinvest" target="_blank" >
                <!--span class="glyphicon glyphicon-cog" aria-hidden="true"></span-->
                <span class="fa fa-home" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top">
                <!--span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span-->
                <span class="fa fa-circle-o" aria-hidden="true"></span>
              </a>
              <!--a data-toggle="tooltip" data-toggle="modal" data-target="#smodal2" data-backdrop="false" data-placement="top" title="이체">
                <span data-toggle="modal" data-target="#smodal2" data-backdrop="false" class="fa fa-bank"></span>
              </a-->
              <a data-toggle="tooltip" data-placement="top" title="관리자페이지" data-id="<?php echo $this->login->id?>" id="adminlogin">
                <span class="fa fa-external-link-square" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="세이퍼트" href="https://v5.paygate.net/dashboard/app/index.html" target="_blank">
                <!--span class="glyphicon glyphicon-off" aria-hidden="true"></span-->
                <span class="fa fa-paypal" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>


        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>
              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-flash"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a onclick="openSsyWindow('angel','src')"><i class="fa fa-hand-o-right pull-right"></i>보낸내역</a></li>
                    <li><a data-toggle="modal" data-target="#smodal2" data-backdrop="false"><i class="fa fa-bank pull-right"></i>이체</a></li>
                    <li><a data-toggle="modal" data-target="#unclosemodal" data-backdrop="false"><i class="fa fa-bank pull-right"></i>정산하기</a><li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                    <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                      <!--i class="fa fa-envelope-o"></i-->
                      <i class="fa fa-warning"></i>
                      <span class="badge bg-green"><?php echo count($errmsglist);?></span>
                    </a>
                    <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                      <?php if ( count($errmsglist) > 0 ) {
                              foreach($errmsglist as $erow){  ?>
                      <li>
                        <a>
                          <!--span class="image"><img src="images/img.jpg" alt="Profile Image"></span-->
                          <span>
                            <span style="color: #008EFC;cursor: pointer;" onClick="searchsetuser('<?php echo $erow['m_id']?>')"><?php echo $erow['m_id']?></span>
                            <span class="time"><?php echo $erow['s_date']?></span>
                          </span>
                          <span class="message">
                            <?php if(isset($erow['s_amount'])) { ?><p><?php echo number_format($erow['s_amount'])?>원</p><?php } ?>
                            <span class="linked_class" onClick="searchsetloan('<?php echo $erow['loan_id']?>')"><?php echo $erow['s_subject']?></span>
                          </span>
                        </a>
                      </li>
                    <?php }
                  } else { ?>
                    <li>
                      <a>
                        <!--span class="image"><img src="images/img.jpg" alt="Profile Image"></span-->
                        <span>
                          <span>정산 TID 오류 없음</span>
                          <span class="time"><?php echo strftime("%F %T")?></span>
                        </span>
                        <span class="message">
                          일주일 내 정산 TID 오류 내용이 없습니다.
                        </span>
                      </a>
                    </li>

                  <?php } ?>
                    </ul>
                  </li>
                  <li role="presentation" class="dropdown" id="jungsan_errorlist">
                      <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                        <i class="fa fa-exclamation-circle"></i>
                        <span class="badge bg-green">0</span>
                      </a>
                      <ul class="dropdown-menu list-unstyled msg_list" role="menu">
                        <li>
                          <span><a onClick="getjungsanerror()">내용</a></span>
                        </li>
                      </ul>
                  </li>
                  <li role="presentation" class="dropdown">
                      <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                        <i class="fa fa-envelope-o"></i>
                        <span class="badge bg-green"><?php echo count($reservlist);?></span>
                      </a>
                      <ul id="menu2" class="dropdown-menu list-unstyled msg_list" role="menu">
                        <?php echo $reservtemplate[0];?>
                      <li style="text-align:center" data-idx="<?php echo $reservtemplate[1];?>" data-no="<?php echo $reservtemplate[2];?>">
                        <span style="color: #008EFC;cursor: pointer;" onClick="makereserv('<?php echo $this->login->id?>')">작성하기</span>
                      </li>

                      </ul>
                    </li>
                    <li role="presentation" class="dropdown">
                      <!--a href="javascript:;" onClick="dynamicmodal('/api/index.php/adm/todaycharge', '회원 충전 내역 - TODAY');" aria-expanded="false">
                        <i class="fa fa-inbox"></i>
                      </a-->
                      <a href="javascript:;" onClick='window.open("/api/index.php/admpop/ipgum", "회원 충전 내역", "left=10,top=10,width=1000,height=800,toolbar=no,menubar=no,status=no");' aria-expanded="false">
                        <i class="fa fa-inbox"></i>
                      </a>
                    </li>
                    <li role="presentation" class="dropdown">
                      <a href="javascript:;" onClick='window.open("/api/index.php/aligo/layout", "sms", "left=10,top=10,width=1000,height=800,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no");' aria-expanded="false">
                        <i class="fa fa-comment"></i>
                      </a>
                    </li>
                    <li role="presentation" class="dropdown">
                      <a href="javascript:;" onClick="getbalance();" aria-expanded="false">
                        잔고 <span id='balanceemoney'style="padding-left:10px;padding-right:10px;display: inline-block;line-height: 15px;vertical-align: middle;"> ---- </span> 원
                      </a>
                    </li>
                    <script>
                    function adminlogin(id) {
                       if( confirm(id+'으로 로그인 하시겠습니까?') ) {
                         window.open('/api/index.php/adm/memlogin?adm=Y&mid='+id);
                       }
                     }
                    </script>
                    <li role="presentation" class="dropdown">
                      <a onclick="adminlogin('<?php echo $this->login->id?>');return false;" href="javascript:;">
                        <i class="fa fa-external-link-square"></i>
                      </a>
                    </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
