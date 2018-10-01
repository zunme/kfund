<?php
$design['use_slide'] = true;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>케이펀딩</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<meta http-equiv="imagetoolbar" content="no">
<meta name="keywords" content="케이펀딩, 피앤피, p2p 대출솔루션, 대출솔루션, p2p투자, p2p펀딩, 일반대출, 담보대출, 대출p2p, 크라우드펀딩, p2p금융솔루션, 대출p2p솔루션, 크라우드펀딩 솔루션, 핀테크 솔루션, 대출 중계솔루션, p2p 대출중개, 소자본창업, 대부업, 금융운영" ><!--HTML 상단 검색 키워드소스 content=""-->
<meta name="description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다." ><!--HTML 상단 검색설명소스 content=""-->

<meta property="og:type" content="http://www.kfunding.co.kr/">
<meta property="og:title" content="케이펀딩">
<meta property="og:description" content="케이펀딩, P2P금융, P2P투자, P2P대출 등 투자자와 대출자를 합리적으로 연결해주는 플랫폼 서비스를 운영합니다.">
<meta property="og:image" content="http://kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta property="og:url" content="http://kfundingl.co.kr/">
<link rel="canonical" href="http://kfunding.co.kr/">

<link rel="SHORTCUT ICON" href="http://kfunding.co.kr/pnpinvest/data/favicon/web_logo.png">
<meta name="google-site-verification" content="wFlJBNsJ9EcCuDtiz8gnIcdhqess5G-zrN6iGCyLbqs" />


<link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="/assets/material-kit/assets/css/material-kit2.v2.css?v=1" rel="stylesheet"/>
<link href="/api/statics/js/hover-min.css" rel="stylesheet"/>

<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons|Pacifico" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">

<style>
@media all and (max-width: 1140px) {
    #bodyClick {
        height: 100%;
        width: 100%;
        position: fixed;
        opacity: 0;
        top: 0;
        left: auto;
        right: 300px;
        content: "";
        z-index: 1029;
        overflow-x: hidden;
    }
    .navbar-header {
        float: none;
    }
    .navbar-header .navbar-toggle {
        display: block;
        float: right;
    }
    .navbar-collapse {
        position: fixed;
        display: block;
        top: 0px;
        height: 100vh;
        width: 230px;
        right: 0;
        margin-right: 0 !important;
        z-index: 1032;
        visibility: visible;
        background-color: #999;
        overflow-y: visible;
        border-top: none;
        text-align: left;
        padding-right: 0;
        padding-left: 0;
        max-height: none !important;
        -webkit-transform: translate3d(230px, 0, 0);
        -moz-transform: translate3d(230px, 0, 0);
        -o-transform: translate3d(230px, 0, 0);
        -ms-transform: translate3d(230px, 0, 0);
        transform: translate3d(230px, 0, 0);
        -webkit-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -moz-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -o-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -ms-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
    }
    .navbar-collapse.collapse {
        height: 100vh !important;
    }
    .navbar-collapse ul {
        position: relative;
        z-index: 3;
        overflow-y: auto;
        height: 100%;
        float: none !important;
        margin: 0;
    }
    .navbar-collapse .nav > li:after {
        width: calc(100% - 30px);
        content: "";
        display: block;
        height: 1px;
        margin-left: 15px;
        background-color: #e5e5e5;
    }
    .navbar-collapse .nav > li:last-child:after {
        display: none;
    }
    .navbar-collapse::after {
        top: 0;
        left: 0;
        height: 100%;
        width: 100%;
        position: absolute;
        background-color: #FFFFFF;
        display: block;
        content: "";
        z-index: 1;
    }
    .navbar.navbar-transparent .navbar-toggle .icon-bar {
        color: #FFFFFF;
    }
    .navbar.navbar-default .navbar-toggle .icon-bar {
        color: inherit;
    }
    .navbar .navbar-collapse .caret {
        position: absolute;
        right: 16px;
        margin-top: 8px;
    }
    .navbar .navbar-collapse .nav > li {
        padding: 0;
        float: none;
    }
    .navbar .navbar-collapse .navbar-nav {
        margin-top: 0;
    }
    .navbar .navbar-collapse .navbar-nav > li > a {
        color: #3C4858;
        margin: 5px 15px;
    }
    .navbar .navbar-collapse .navbar-nav > li > a:hover, .navbar .navbar-collapse .navbar-nav > li > a:focus {
        color: #3C4858;
    }
    .navbar .navbar-collapse .navbar-nav > li.button-container > a {
        margin: 15px;
    }
    .navbar .navbar-collapse .navbar-nav > li.open > .dropdown-menu {
        padding-bottom: 10px;
        margin-bottom: 5px;
        box-shadow: none;
    }
    .navbar .navbar-collapse .open .dropdown-menu.dropdown-with-icons > li > a {
        padding: 12px 20px 12px 35px;
    }
    .navbar .navbar-collapse .open .dropdown-menu > li > a {
        color: #3C4858;
        margin: 0;
        padding-left: 46px;
    }
    .navbar .navbar-collapse .open .dropdown-menu > li > a:hover, .navbar .navbar-collapse .open .dropdown-menu > li > a:focus {
        color: #FFFFFF;
    }
    .navbar .navbar-collapse .dropdown-menu li {
        margin: 0 15px;
    }
    .navbar .navbar-collapse .dropdown.open .dropdown-menu {
        display: block;
    }
    .navbar .navbar-collapse .dropdown .dropdown-menu {
        display: none;
    }
    nav .container,
    nav .navbar-header {
        -webkit-transition: transform 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -moz-transition: transform 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -o-transition: transform 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        -ms-transition: transform 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
        transition: transform 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
    }
    .nav-open nav .navbar-header {
        left: 0;
        -webkit-transform: translate3d(-245px, 0, 0);
        -moz-transform: translate3d(-245px, 0, 0);
        -o-transform: translate3d(-245px, 0, 0);
        -ms-transform: translate3d(-245px, 0, 0);
        transform: translate3d(-245px, 0, 0);
    }
    .nav-open .navbar-collapse {
        -webkit-transform: translate3d(0px, 0, 0);
        -moz-transform: translate3d(0px, 0, 0);
        -o-transform: translate3d(0px, 0, 0);
        -ms-transform: translate3d(0px, 0, 0);
        transform: translate3d(0px, 0, 0);
    }
    .features-5 .container [class*="col-"] {
        border-right: 0;
        border-left: 0;
    }
    .features-5 .container .row:last-child [class*="col-"]:last-child,
    .features-5 .container .row:last-child [class*="col-"]:nth-last-child(2) {
        border-top: 1px solid rgba(255, 255, 255, 0.35);
    }
}
@media (min-width: 768px){
  .navbar-right {
    margin-right: 0px;
  }
}
li.dropdown a i.fas
{
  margin-right: 13px;
    margin-left: 4px;
    font-size: 17px;
        opacity: .5;
}
li.dropdown a i.far
{
  margin-right: 17px;
    margin-left: 4px;
    font-size: 17px;
        opacity: .5;
}
.page-header{
  min-height:250px;
}
.navbar-aqua{
  color:white;
  box-shadow: 0 4px 20px 0px rgba(0, 0, 0, 0.14), 0 7px 12px -5px rgba(0, 188, 212, 0.46);
  background-color: #00acc1;
}

.header-filter[filter-color="grey"]:after {
		    background: rgba(133, 134, 134, 0.6);
		    /* For browsers that do not support gradients */
		    background: -webkit-linear-gradient(60deg, rgba(133, 134, 134, 0.6), rgba(0, 0, 0, 0.95));
		    /* For Safari 5.1 to 6.0 */
		    background: -o-linear-gradient(60deg, rgba(133, 134, 134, 0.6), rgba(0, 0, 0, 0.95));
		    /* For Opera 11.1 to 12.0 */
		    background: -moz-linear-gradient(60deg, rgba(133, 134, 134, 0.6), rgba(0, 0, 0, 0.95));
		    /* For Firefox 3.6 to 15 */
		    background: linear-gradient(60deg, rgba(133, 134, 134, 0.6), rgba(0, 0, 0, 0.95));
		    /* Standard syntax */
		}

.header-filter[filter-color="aqua_dia"]:after{
  /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#d6f9ff+0,9ee8fa+100&0.55+1,0.55+100 */
  /* IE9 SVG, needs conditional override of 'filter' to 'none' */
  background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIxMDAlIiB5Mj0iMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2Q2ZjlmZiIgc3RvcC1vcGFjaXR5PSIwLjU1Ii8+CiAgICA8c3RvcCBvZmZzZXQ9IjElIiBzdG9wLWNvbG9yPSIjZDVmOWZmIiBzdG9wLW9wYWNpdHk9IjAuNTUiLz4KICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzllZThmYSIgc3RvcC1vcGFjaXR5PSIwLjU1Ii8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
  background: -moz-linear-gradient(left, rgba(91, 140, 148, 0.75) 0%,rgba(42, 132, 154, 0.75) 100%); /* FF3.6-15 */
  background: -webkit-linear-gradient(left, rgba(91, 140, 148, 0.75) 0%,rgba(42, 132, 154, 0.75) 100%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to right, rgba(91, 140, 148, 0.75) 0%,rgba(42, 132, 154, 0.75) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b8c94bf', endColorstr='#2a849abf',GradientType=1 ); /* IE6-8 */

}
#pageheader .page-title{
  text-align: center;
  font-size: 4rem;
  color: #FFF;
  /* margin-top: 150px; */
  padding-top: 120px;
  position: relative;
  z-index:100;
}
.flot-left{float:left;}
.float-right{float:right;}
</style>

<!--   Core JS Files   -->
	<script src="/assets/js/jquery.min.js" type="text/javascript"></script>
	<script src="/assets/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/assets/js/material.min.js"></script>
	<!--    Plugin for Date Time Picker and Full Calendar Plugin   -->
	<script src="/assets/js/moment.min.js"></script>
	<!--	Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/   -->
	<script src="/assets/js/nouislider.min.js" type="text/javascript"></script>
	<!--	Plugin for the Datepicker, fll documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker   -->
	<script src="/assets/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
	<!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select   -->
	<script src="/assets/js/bootstrap-selectpicker.js" type="text/javascript"></script>
	<!--	Plugin for Tags, full documentation here: http://xoxco.com/projects/code/tagsinput/   -->
	<script src="/assets/js/bootstrap-tagsinput.js"></script>
	<!--	Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput   -->
	<script src="/assets/js/jasny-bootstrap.min.js"></script>
	<!--	Plugin for Product Gallery, full documentation here: https://9bitstudios.github.io/flexisel/ -->
	<script src="/assets/js/jquery.flexisel.js"></script>
	<!--    Control Center for Material Kit: activating the ripples, parallax effects, scripts from the example pages etc    -->
	<script src="/assets/material-kit/assets/js/material-kit2.js?v=1.2.2" type="text/javascript"></script>
</head>
<body>

  <nav class="navbar navbar-aqua navbar-transparent navbar-fixed-top navbar-color-on-scroll" color-on-scroll="100">
    <div class="container-head" style="    padding-right: 15px;padding-left: 15px;margin-right: auto;margin-left: auto;">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar top-bar"></span>
                <span class="icon-bar middle-bar"></span>
                <span class="icon-bar bottom-bar"></span>
            </button>
            <a class="navbar-brand" href="/pnpinvest" style="padding-top: 8px;">
              <img src="/pnpinvest/img/logo.png" width="190px">
              <!--span style="font-family: 'Pinyon Script', cursive;font-size:30px;font-weight:bold;">K</span><span style="margin-left: 20px;">FUNDING</span-->
            </a>
          </div>

          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li>
                <a href="/pnpinvest/?mode=invest">
                  <i class="material-icons">trending_up</i> 투자하기
                </a>
              </li>

              <li>
                <a class="" href="/pnpinvest/?mode=joinloan" >
                  <i class="material-icons">store</i> 대출신청
                </a>
              </li>
              <li class="dropdown">
                <a href="javascript:" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="material-icons">apps</i> 회사소개
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu dropdown-with-icons">
                  <li>
                    <a href="/pnpinvest/?mode=companyintro01">
                      <i class="material-icons">apps</i> 회사소개
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=safetyguide">
                      <i class="material-icons">art_track</i> safetyguide
                    </a>
                  </li>
                </ul>
              </li>
              <li>
                <a href="/api/cast">
                  <i class="material-icons">ballot</i> 캐스트
                </a>
              </li>

              <li class="dropdown">
                <a href="javascript:" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="material-icons">view_day</i> 공지사항
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu dropdown-with-icons">
                  <li>
                    <a href="/pnpinvest/?mode=bbs_list&table=notice&subject=공지사항">
                      <i class="material-icons">view_headline</i> 공지사항
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=bbs_list&table=media&subject=언론보도&인터뷰">
                      <i class="material-icons">art_track</i> 언론보도
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=bbs_list&table=qna&subject=질문과답변">
                      <i class="material-icons">view_quilt</i> 문의하기
                    </a>
                  </li>
                </ul>
              </li>
              <li>
                <a href="/pnpinvest/?mode=guide">
                  <i class="material-icons">contacts</i> 고객지원
                </a>
              </li>
              <li class="dropdown">
                <a href="javascript:" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="material-icons">how_to_reg</i> 마이페이지
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu dropdown-with-icons">
                  <li>
                    <a href="/pnpinvest/?mode=mypageinfo">
                      <i class="material-icons">how_to_reg</i> 개인정보
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=mypage_certification">
                      <i class="fas fa-user-shield"></i> 인증센터
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=mypage_confirm_center">
                      <i class="fas fa-file-invoice-dollar" style="margin-left: 6px;margin-right: 18px;"></i> 입출금관리
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=mypage_invest_info">
                      <i class="fas fa-won-sign"></i> 투자정보
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=mypage_calculate_schedule">
                      <i class="far fa-calendar-alt"></i> 투자상환스케줄
                    </a>
                  </li>
                  <li>
                    <a href="/pnpinvest/?mode=mypage_modify">
                      <i class="fas fa-user-cog"></i> 회원정보수정
                    </a>
                  </li>

                </ul>
              </li>
              <li class="nav_split_margin">
                <a href="http://kfunding.co.kr/pnpinvest/?mode=logout">
                  <i class="material-icons">exit_to_app</i> 로그아웃
                </a>
              </li>

            </ul>
          </div>
      </div>
    </nav>
    <style>
    .navbar.navbar-transparent {
      background-color:rgba(144, 144, 144, 0.77);
    }
    #pageheader{
      position: relative;
      #overflow: hidden;
      width:100vw;height:390px;
    }
    #pageheader:before{
      content:"";
      position: absolute;
      width:100%;
      height:100%;
      top:0;
      left:0;
      background-image: url('/assets/img/event_top_01.png');
      background-position: top left;background-size: cover;
    }
    #pageheader:after{
      content:"";
      position: absolute;
      width:100%;
      height:100%;
      top:0;
      left:0;
      background-image: url('/assets/img/event_top_02.png');
      background-position: top right;background-size: cover;
    }

    #pageheader .pageheader-center-img{
      content:"";
      position: absolute;
      bottom:13px;;
      width:100%;
      text-align:center;
    }
    #pageheader .pageheader-center-img img{
          max-width: 356px;
          width:86%;
          box-shadow: 2px 4px 6px 0 rgba(0,0,0,0.2);
    }

    @media (max-width: 1240px){
      #pageheader:before , #pageheader:after{
        opacity: 0.6;
      }
      #pageheader .pageheader-center-img img{
        background-color: #FFF;
        box-shadow: 3px 7px 7px 2px rgba(0, 0, 0, 0.28);
      }
   }
   @media (max-width: 830px){
     #pageheader:before , #pageheader:after{
       opacity: 0.4;
     }
     #pageheader .pageheader-center-img img{
       background-color: #FFF;
       box-shadow: 5px 9px 11px 0 rgba(0, 0, 0, 0.56);
     }
  }

    #pageheader .pageheader-center-img h4{
      margin-top: 55px;

    }
    .event_split{
      color:white;
      min-height: 50px;
      position: relative;
      padding-top: 20px;
      padding-bottom: 10px;
    }

    .event_split{
      overflow: hidden;
    }
    footer{
          position: relative;
    }
    .event_split:before{
      content: 'Join Us';
          font-family: 'Pacifico', cursive;
          color: black;
          opacity: 0.2;
          position: absolute;
          width: 100%;
          text-align: center;
          font-size: 21vw;
          -webkit-transform: rotate(-30deg);
          transform: rotate(-30deg);
          top: 18%;
          left:-20%;
    }
    .event_split:nth-child(2):before{
        content: 'Review';
    }
    .triangle-bottom:not(:last-child):after{
      content:'';
      position: absolute;
      width: 30px;
      height: 30px;
      bottom: -15px;
      left: 50%;
      -webkit-transform: translateX(-50%) rotate(45deg);
      transform: translateX(-50%) rotate(45deg);
      z-index:10;
      background-color: inherit;
    }
    .split_color1.colorp1{
      background-color:#011a68;
    }
    .split_color2.colorp1{
      background-color:#ff55af;
    }
    .split_color3.colorp1{
      background-color:#fbb03b;
    }

    .split_color1.colorp2 {
    background-color: #cc90cc;
    }
    .split_color2.colorp2 {
    background-color: #6ec7e0;
    }
    .split_color3.colorp2 {
    background-color: #e4c4a1;
    }

    .split_color1.colorp3 {
    background-color: #ff55af;
    }
    .split_color2.colorp3 {
    background-color: #20a5f7;
    }
    .split_color3.colorp3 {
    background-color: #fbb03b;
    }

    .event_split_in_wrap{
      position: relative;
      width:95%;
      max-width: 900px;
      margin: 10px auto 0 auto;
      padding: 30px 10px 0px;
    }
    .event_split_content{
      position: relative;
          width: 90%;
          max-width: 500px;
          margin: 10px auto 30px;
          padding: 10px 10px;px;
    }
    .event_split_dotline{
      position: relative;
      width:300px;
      text-align: right;
      display: inline-block;
      border-bottom: 1px solid #FFF;
      margin-bottom: 54px;
    }
    .event_split_dotline :after{
      content: '';
      position: absolute;
      width: 10px;
      height: 10px;
      bottom: -5px;
      left: 0;
      z-index: 11;
      border: 2px solid #FFF;
      border-radius: 50%;
      background-color: #cc90cc;
    }

    .split_color1.colorp1 .event_split_dotline :after {
          background-color:#011a68;
    }
    .split_color2.colorp1 .event_split_dotline :after {
            background-color:#ff55af;
    }
    .split_color3.colorp1 .event_split_dotline :after {
            background-color:#fbb03b;
    }
    .split_color1.colorp2 .event_split_dotline :after {
    background-color: #cc90cc;
    }
    .split_color2.colorp2 .event_split_dotline :after {
    background-color: #6ec7e0;
    }
    .split_color3.colorp2 .event_split_dotline :after {
    background-color: #e4c4a1;
    }
    .split_color1.colorp3 .event_split_dotline :after {
    background-color: #ff55af;
    }
    .split_color2.colorp3 .event_split_dotline :after {
    background-color: #20a5f7;
    }
    .split_color3.colorp3 .event_split_dotline :after {
    background-color: #fbb03b;
    }

    .event_split_setp_no{
      font-size: 16px;
      font-weight: 600;
    }
    .event_split_setp_title{
      font-size: 22px;
      font-weight: 600;
    }
    .event_split_content p{
      font-size: 16px;
      font-weight:500;
      text-align: center;
      margin-bottom: 30px;
    }
    .event_split_content p:nth-child(2){
      margin-bottom:0;
    }
    .event_split_content .sub-title-head{
      font-size: 32px;
      font-weight:600;
      color: black;
    }
    .event_split_content_imgbox{
          text-align: center;
          margin-bottom: 50px;
    }
    .event_split_content img{
      border-radius: 50%;
      width: 277px;
      height: 277px;
      border: 15px solid #FFF;
      background-color: white;
          box-shadow: 6px 9px 50px 0px rgba(0, 0, 0, 0.75);
  }
  .goto_join_box{
    padding:40px 0;
  }
  .btn-join{
    font-size: 16px;
padding: 10px 40px;
  }
    </style>

    <?php
    $pattern = rand ( 1 , 3 );
    $pattern=2;
    ?>
    <div id="pageheader" class="">
      <div class="pageheader-center-img">
        <img src="/assets/img/event_top.png">
        <h4>투자상품은 나~~~~아~~~중에 오픈해요~ 기다리시오!!!</h4>
      </div>
    </div>
    <div class="event-main">
      <div class="event_split triangle-bottom split_color1 colorp<?php echo $pattern?>">
        <div class="event_split_in_wrap">
          <div class="event_split_dotline">
            <span class="event_split_setp">step</span>
            <span class="event_split_setp_no">01</span>
            <span class="event_split_setp_title">신규가입 EVENT</span>
          </div>
          <div class="event_split_content">
            <p>신규가입하고 <span class="sub-title-head">1만원</span> 받자</p>
            <div class="event_split_content_imgbox">
              <img src="/assets/img/shinsegae10000.jpg">
            </div>
            <p>1만원만 받으면 섭섭하시죠? 또 하나의 이벤트 <i class="fas fa-angle-double-down"></i></p>
          </div>
        </div>
      </div>
      <div class="event_split triangle-bottom  split_color2 colorp<?php echo $pattern?>">
        <div class="event_split_in_wrap">
          <div class="event_split_dotline">
            <span class="event_split_setp">step</span>
            <span class="event_split_setp_no">02</span>
            <span class="event_split_setp_title"> SNS 후기 EVENT</span>
          </div>
          <div class="event_split_content">
            <p>신규가입하고 <span class="sub-title-head">오천원</span> 받자</p>
            <div class="event_split_content_imgbox">
              <img src="/assets/img/shinsegae5000.jpg">
            </div>
            <p>푸짐한 선문을 받으시려면 <i class="fas fa-angle-double-down"></i></p>
          </div>
        </div>
      </div>
      <div class="event_split triangle-bottom  split_color3 colorp<?php echo $pattern?>" style="text-align:center">
        <div class="goto_join_box">
          <a href="/pnpinvest/?mode=login" class="btn btn-rose btn-join">가으자~~~!!!! 회원가입하러 <i class="fas fa-user-plus"></i></a>
        <div>
      </div>
    </div>



  <!-- ajax loader -->
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
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
       <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel"></h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true" style="color:black;font-size:22px;">&times;</span>
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

<style>
footer {
    font-size:13px;
  padding-top:5px;
  color:#cacaca;
}
.footer-line{
  padding: 5px;
  border-bottom: 1px solid #999;
  text-align:left;
}
footer .footer-service{
  padding:0 8px 0 5px;
  margin: 0;
  border-right: 1px solid #cacaca;
  cursor: pointer;
}
footer .footer-service:last-child{
  border:none;
}
.footer-line .newcol{
  margin-bottom: 10px;
  margin-top: 10px;
}
.footer-line .row{
  margin-top:5px;
  margin-bottom: 5px;
}
.newcol  div{
  margin-bottom:5px;
}
.newcol.first-col span.round{
  padding: 5px 11px;
  border: 1px solid #cacaca;
  border-radius: 20px;
}
.newcol.first-col {
    font-size: 15px;
    padding-bottom: 10px;
    text-align:center;
}
.newcol p {
    margin: 0 0 5px;
}
.newcol .splitline{padding-left:5px;padding-right:5px;}
.col-nl{
  padding-left:15px;
  display: block;
}
@media (max-width: 991px){
  .col-nl{
    padding-left:10px;
    display: inline;
  }
}
@media (max-width: 767px){
  .newcol {padding-left:20px;padding-right:20px;}
  .newcol.first-col{padding-left: 30px;text-align:left;}
  .newcol.first-col p {
      padding: 0 10px;
      display:inline-block;;
  }
}
.newcol.first-col p{
  margin-top:10px;
}
.footer-desc{
  padding:20px;text-align:left;
}
.footer-desc p{
  margin-bottom: 2px;
}
.footer-copyright {
    color: #757777;
}
</style>
<footer class="footer footer-black">
    <div class="container">
      <div class="footer-line">
        <span class="modal-link footer-service" data-title="서비스 이용 약관" data-url="/pnpinvest/css/con01.htm">서비스이용약관</span>
        <span class="modal-link footer-service" data-title="개인정보 취급 방침" data-url="/pnpinvest/css/con02.htm">개인정보취급방침</span>
        <span class="modal-link footer-service" data-title="투자자 이용 약관" data-url="/pnpinvest/css/con03.htm">투자자이용약관</span>
        <span class="modal-link footer-service" data-title="윤리 강령" data-url="/pnpinvest/css/con04.html">윤리강령</span>
      </div>
      <div class="footer-line">
        <div class="row">
          <div class="col-md-3 col-sm-3">
            <div class="newcol first-col">
              <span class="round">케이펀딩고객센터</span>
              <p class="footer_time">09:30~18:00</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-9">
              <div class="newcol second">
        				<div class="imgdiv">
        					<a href="https://www.facebook.com/thekfunding" target="_blank" title="카카오톡"><img class="hvr-buzz-out" src="/pnpinvest/img/new_kakao.png"></a>
        					<a href="http://pf.kakao.com/_FcJxcC" target="_blank" title="페이스북"><img class="hvr-buzz-out" src="/pnpinvest/img/new_face.png"></a>
        					<a href="https://blog.naver.com/kfundings" target="_blank" title="블로그"><img class="hvr-buzz-out" src="/pnpinvest/img/new_blog.png"></a>
        				</div>
        				<div class="splitdiv last">
        					<span>Tel.02-552-1772</span>
        					<span class="splitline">|</span>
        					<span>Fax.02-552-1773</span>
        				</div>
        				<div>E-mail.help@kfunding.co.kr</div>
        			</div>
          </div>
          <div class="col-md-5 col-sm-9 col-sm-offset-3  col-md-offset-0">
              <div class="newcol desc">
      					<p><i class="far fa-check-circle"></i> 광고 제안은 메일로 보내주시길 바라며<span class="col-nl">전화문의는 절대 사절합니다.<span></p>
      					<p><i class="far fa-check-circle"></i> 주말 및 공휴일은 운영하지 않습니다.</p>
      					<p><i class="far fa-check-circle"></i> 운영시간은 사정에 따라 변돌 될 수 있습니다.</p>
        			</div>
          </div>
        </div>
      </div>
      <div class="footer-line">
        <div class="row">
          <div class="col-md-3 col-sm-3">
            <div class="newcol first-col">
              <span class="round">케이펀딩 회사정보</span>
            </div>
          </div>
          <div class="col-md-4 col-sm-9">
            <div class="newcol second">
              <div>(주) 케이펀딩</div>
              <div>대표이사 임용환</div>
              <div>주소 : 서울 강남구 테헤란로 86길 14 윤천빌딩 5층</div>
              <div class="splitdiv last">
                <span>Tel.02-552-1772</span>
                <span class="splitline">|</span>
                <span>Fax.02-552-1773</span>
              </div>
              <div>사업자 등록번호 318-81-09046</div>
            </div>
          </div>
          <div class="col-md-5 col-sm-9 col-sm-offset-3  col-md-offset-0">
            <div class="newcol desc">
      				<div>(주) 케이크라우드대부</div>
      				<div>대표이사 임용환</div>
      				<div>주소 : 서울 강남구 테헤란로 86길 14 윤천빌딩 5층</div>
      				<div class="splitdiv last">
      					<span>Tel.02-552-1772</span>
      					<span class="splitline">|</span>
      					<span>FAX.02-552-1773</span>
      				</div>
      				<div>사업자 등록번호 000-00-00000</div>
      			</div>
          </div>
        </div>
      </div>

      <div class="footer-desc">
				<p><i class="far fa-comment"></i> 대출금리 연 19.9%이내 (연체금리 연 24% 이내) 플랫폼 이용료 외 기타 부대비용은 없습니다.</p>
				<p><i class="far fa-comment"></i> 중개수수료를 요구하거나 받는 행위는 불법입니다. 과도한 빚은 당신에게 큰 불행을 안겨줄 수 있습니다.</p>
				<p><i class="far fa-comment"></i> 대출 시 귀하의 신용등급이 하락할 수 있습니다.</p>
				<p class="blue"><i class="far fa-comment"></i> 케이펀딩은 고객님의 투자원금과 수익률을 보장하지 않습니다.</p>
			</div>
      <div class="footer-copyright">
        Copyrightⓒ 2018 K-FUNDING. All Rights Reserved.
      </div>
    </div>
</footer>

<script>
$("document").ready( function() {
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
});
</script>
</body>
<html>
