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
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
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
    <div id="pageheader" class="page-header header-filter clear-filter" data-parallax="false" filter-color="grey" style="width:100vw;height:250px;background-image: url('/assets/img/bg0002.jpg');background-position: center center;background-size: cover;">
      <div class="page-title">
        투자하기
      </div>
    </div>
    <div class="card-main">
      <div class="container2">
        <div class="maincard">
<style>
body{background-color:#f8fbfb;}
.flot-left{float:left;}
.float-right{float:right;}
.tooltip-inner {
    padding: 10px 15px;
    min-width: 80px;
}
#pageheader .page-title{
  font-size: 28px;
font-weight: 500;
color: #FFF;
}
.card-main{
      background-color: #FFF;
}
.over-card{
  width:90%;
  min-height:200px;
  max-width:900px;
  margin-top: 80px;
  margin-bottom: 50px;
  margin-left:auto;
  margin-right:auto;
  background-color:white;
  border: 1px solid #e0e0e0;
    #box-shadow: 0px 8px 1px -3px rgba(0, 0, 0, 0.14), 0 6px 9px 0px rgba(0, 0, 0, 0.12), 0px 5px 2px -5px rgba(0, 0, 0, 0.2);
    box-shadow: 10px 10px 33px 0px rgba(0, 0, 0, 0.75);
}


.over-card-left .thumbnail-box{
    position: relative;
    #margin:-30px 15px 10px 15px;
  margin-top:-30px;
  margin-bottom:10px;
  margin-left:15px;
  margin-right:15px;
  #padding:0 15px;
    min-height:50px;
    #width:100%;
    boder:1ps solid #999;
}
.over-card-left .thumbnail-box{
  position: relative;
  z-index: 1;
  transition: transform .3s cubic-bezier(.34,2,.6,1),box-shadow .2s ease;
}
.over-card:not(.card-plain):hover .over-card-left .thumbnail-box {
  box-shadow: 0 12px 19px -7px rgba(0,0,0,.3);
  transform: translateY(40px);
  -webkit-transform: translateY(40px);
  -ms-transform: translateY(40px);
  -moz-transform: translateY(40px);
}

@media (max-width: 991px){
  .over-card-left .thumbnail-box{
    max-width:600px;
    margin-left:auto;
    margin-right:auto;
    width: 90%;
  }
}
.thumbnail-box img{
  width:100%;
  #box-shadow: 10px 10px 60px 0px rgba(0, 0, 0, 0.75);
  box-shadow: 6px 9px 50px 0px rgba(0, 0, 0, 0.75);
}
.thumbnail-box .btn-overwrap{
  position:absolute;
  bottom:0;
  padding:5px; 10px;
  text-align:center;
  width:100%;
  background-color:rgba(4, 4, 4, 0.47);
  color:#c7c2c2;
  font-size:1.6rem;
  z-index:100;
}
.thumbnail-box .btn-overwrap2 {
    position: absolute;
    top: 10px;
    right: 10px;
    padding: 6px 22px;
    #border-radius: 6px;
    text-align: center;
    #background-color: #7C4DFF;
    #font-size: 1.4rem;
/*
    color: white;
    background-color: #4286b9;
    border-color: #1d91e8;
    border:1px solid #1d91e8;
*/
/*
    background-color:#e3e3e3;
    color:#5a5a5a;
    border-color: #aaa;
    border:1px solid #333;
*/
background-color:#69a;
color:#f8f8f8;
/*
background-color:#b0bec5;
color:#4a4a4a;
border:1px solid #808e95;
*/
    letter-spacing: 2px;
    font-size: 1.58rem;
    font-weight: 600;
    z-index: 100;
    #box-shadow: 3px 4px 12px 0px rgba(124, 77, 255, 0.7);
    #box-shadow: 3px 4px 1px 0px rgba(71, 165, 237, 0.2);
    box-shadow: 3px 4px 1px 0px rgba(71, 71, 71, 0.2);
}

.over-card-title-left{
    margin: 20px 20px 52px 20px;
    font-size: 1.8rem;
    font-weight: 600;
    color:#666;
}
.title-small-label{
    padding: 5px 8px;
    font-size: 1.4rem;
    background-color: #69a;
    border-radius: 6px;
    line-height: 1.3rem;
    margin-left: 10px;
}


.left-sub-row{
  padding:30px 15px 10px 15px;;
  position:relative;
}
.left-sub-row:after{
  clear:both;
}
.date-col{
  text-align:center;
  display: inline-block;
  margin-left: 10px;
}

.date-col h3{
   font-size: 7rem;
   color: #C3C3C3;
   #color:#69a;
  margin:0;
}
.date-col h3 span{
  color: #C3C3C3;
   font-size: 3rem;
}
.date-col h5{
  font-size: 2.5rem;
  color: #C3C3C3;
  text-align: right;
  margin:0;
  padding-right: 5px;
}

.date-col-right{
    position: absolute;
    bottom: 22px;
    right: 15px;
}
date-col-right:after{
  #clear:both;
}
.date-col-sub{
  text-align:center;
  border:1px solid #cacaca;
  padding:8px;
  border-radius:8px;
  #box-shadow: 0px 0px 2px 2px rgba(0, 0, 0, 0.15);
  margin-right:10px;
  width:74px;height:74px;
  padding-top:10px;

}
.date-col-sub h3{
   font-size: 3rem;
   #color: #C3C3C3;
  color:#69a;
  margin:0;
}
.date-col-sub h3 span{
   font-size: 1.7rem;
  color: #c3c3c3;
}
.date-col-sub h5{
  font-size: 1.7rem;
  #color: #C3C3C3;
  color:#6f6f6f;
  text-align: center;
  margin:0;
  #padding-right: 5px;
}
.btn-grp{
  position: relative;
  margin:10px 5px;
}
.btn-grp-row{
  padding-bottom:10px;
  padding-left:8px;
  padding-right:8px;
  margin-bottom:10px;
}
.btn-grp .flot-left{
  width:33.3%;
  text-align:center;
  font-size:1.4rem;
  color:white;
  padding-top:6px;
  padding-bottom:6px;
  #border-top:1px solid #FFF;
  #border-bottom:1px solid #FFF;
  #border-right:1px solid #FFF;
}
.btn-grp .flot-left:nth-child(1){
  background-color:#3F51B5;
  border-top-left-radius:4px;
  border-bottom-left-radius:4px;
}
.btn-grp .flot-left:nth-child(2){
  background-color:#2196F3;
}
.btn-grp .flot-left:nth-child(3){
  background-color:#009688;
}
.btn-grp .flot-left:last-child{
  border-top-right-radius:4px;
  border-bottom-right-radius:4px;
}

.over-card-right{
  padding:10px 5px;
}

.over-card-title{
  margin-top:30px;
  #margin-bottom:10px;
  padding-bottom: 10px;
  font-size:1.8rem;
  vertical-align:top;
  postion:relative;
}
.over-card-title:after{
  clear:both;
}
.over-card-title span{
  float:left;
  position:relative;
  font-weight: 600;
  color: #595959;
}
.over-card-title-head{
  line-height: 2.4rem;
}
.over-card-title span.small-label, .over-card-title-left span.small-label{
  padding:5px 10px;
  background-color:#69a;
  color:white;
  font-size:1.3rem;
  line-height:1.3rem;
  margin-left:10px;
  border-radius:6px;
}
.over-card-title-left span.small-label{
  margin-left:0px;
  margin-right:10px;
}

.progress{
  margin-bottom: 0px;
  #height: 18px;
}
@media (max-width: 767px){
  .over-card-right {
      padding:10px 30px;
  }
}
@media(max-width: 991px){
  .over-card-right-wrapper
  {
    padding-left: 40px;
    padding-right: 40px;
  }
}

.panel .panel-heading a:hover, .panel .panel-heading a:active, .panel .panel-heading a[aria-expanded="true"] {
    color: #607D8B;
}
.text-info {
    color: #546E7A;
}
.progress .progress-bar, .progress .progress-bar.progress-bar-default {
    background-color: #00BCD4;
    border-radius: 10px;
}
#acordeon{
  padding-right: 15px;
}
.main-desc table {
    width: 100%;
}
.panel .panel-heading a[aria-expanded="true"] i, .panel .panel-heading a.expanded i {
    filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=2);
    -webkit-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
     transform: rotate(0deg);
    margin-top: -5px;
}
.main-desc table tr {
    border-bottom: 1px solid #EEE;
    margin-top: 5px;
    margin-bottom: 5px;
}
.main-desc table tr td {
    padding: 5px;
    min-width: 80px;
}
.btm-detail{
  padding: 8px 40px 6px;
  font-size: 1.6rem;
  margin-bottom: 10px;
  #border-radius: 30px;
}

.btn-grace {
  background-color: #327ab5;
  color: #FFFFFF;
  box-shadow: 0 2px 2px 0 rgba(102, 153, 170, .14), 0 3px 1px -2px rgba(102, 153, 170, 0.2), 0 1px 5px 0 rgba(102, 153, 170, 0.14);
  -webkit-transition: all 200ms linear;
  -moz-transition: all 200ms linear;
  -o-transition: all 200ms linear;
  -ms-transition: all 200ms linear;
  transition: all 200ms linear;
}
.btn-grace:hover {
  background-color: #327ab5;
  color: #FFFFFF;
  box-shadow: 0 14px 26px -12px rgba(102, 153, 170, 0.42), 0 4px 23px 0px rgba(102, 153, 170, 0.12), 0 8px 10px -5px rgba(102, 153, 170, 0.2);
}

</style>
<style>
.progress .skill {
   height: 35px;
  font: normal 12px "Open Sans Web";
  line-height: 35px;
  padding: 0;
  margin: 0 0 0 20px;
  text-transform: uppercase;
}
.progress .skill .val {
  float: right;
  font-style: normal;
  margin: 0 20px 0 0;
}
.progress-bar {
  text-align: left;
  transition-duration: 2s;
}

</style>

<?php if(isset($design['use_slide'])  && $design['use_slide'] == true ) {?><div class="owl-carousel owl-theme navbarbox owl-loaded owl-drag"> <?php } ?>
<?php for($i=0 ; $i < 2 ; $i++ ) { ?>
  <!-- over-card -->
<div class="over-card">
  <a href="javascript:;">
  <div class="row">
    <div class="col-md-6">
      <div class="over-card-left">
        <div class="thumbnail-box">
          <img class="" src="http://kfunding.co.kr/pnpinvest/data/photoreviewers/5/main3.jpg">
          <div class="btn-overwrap">부동산</div>
          <div class="btn-overwrap2">모집대기</div>
        </div>
      </div>
      <div class="row">
        <div class="col-xs-12 hidden-lg hidden-md hidden-sm">
          <div class="over-card-title-left">

            <span class="small-label flot-left">부동산</span>
            <div class="flot-left">
              1호 케이펀딩 오픈자금 모집 1차
            </div>

          </div>
        </div>
      </div>
      <div class="left-sub-row">
        <div class="date-col float-left">
          <h3>10<span>시</span></h3>
          <h5>8월12일</h5>
        </div>
        <div class="date-col-right">
          <div class="date-col-sub float-right">
            <h3>18<span>%</span></h3>
            <h5>수익률</h5>
          </div>
          <div class="date-col-sub float-right">
            <h3>3<span></span></h3>
            <h5>개월</h5>
          </div>
        </div>
      </div>
      <div class="row btn-grp-row">
        <div class="col-xs-12">
          <div class="btn-grp prd-event-grp">
            <div class="flot-left prd-event-item">리워드최대 6%</div>
            <div class="flot-left prd-event-item">스타벅스쿠폰</div>
            <div class="flot-left prd-event-item">문화상품권</div>
          </div>
        </div>
      </div>
    </div> <!-- /left-col -->
    <div class="col-md-6 over-card-right-wrapper">
      <div class="over-card-right hidden-xs">
        <div class="row over-card-title ">
          <span class="over-card-title-head">1호 케이펀딩 오픈자금 모집 1차 </span>
          <span class="small-label hidden-xs">부동산</span>
        </div>
      </div>
      <div id="acordeon" class="hidden-xs">
        <div class="panel-group" id="accordion">
          <div class="panel panel-border panel-default">
            <div class="panel-heading" role="tab" id="headingOne">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    <h4 class="panel-title">
                    Description
                    <i class="material-icons" style="">done_outline</i>
                    <!--i class="fas fa-info-circle"></i-->
                    </h4>
                </a>
            </div>
            <div id="collapseOne" class="panel-collapse collapse in">
              <div class="panel-body main-desc">
      					<table>
      						<tr><td>상환예정</td><td>2018-03-31</td></tr>
      						<tr><td>상환방식</td><td>매월이자 지급 후 원금은 만기일시 상환</td></tr>
      						<tr><td>상환재원</td><td>신탁사가 시공사에게 지급하는 공사비로 상환재원 확보</td></tr>
      					</table>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="row" style="margin-top:50px;">
      	<div class="col-xs-12" style="padding-left:30px;padding-right:30px;">
      		<div class="row" style="font-weight: 700;">
      			<div class="col-xs-6"><span class="text-info" style="padding-right:15px;">참여금액</span> 3,000만원</div>
      			<div class="col-xs-6" style="text-align:right;"><span class="text-info" style="padding-right:15px;">펀딩금액</span> 10,000만원</div>
      		</div>
      		<div class="progress skill-bar" style="height:15px;border-radius:10rem;margin-top:10px;margin-bottom:10px;">
              <!-- 0 % 일때는 여기 -->
              <!--div style="font-size: 12px;text-align: center;">0%</div-->
      		    <div class="progress-bar bg-info" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="color: white;text-align: right;line-height: 16px;">
              <!-- 0 % 이상 일때는 여기 -->
                <span style="padding-right: 10px;">80%</span>
              </div>
      		</div>
      	</div>
      </div>
  </div>
</div>
<div class="row">
  <div class="col-xs-12" style="text-align:center;margin:15px;">
    <span class="btn btm-detail btn-grace">자세히보기
      <i class="material-icons" style="margin-left: 10px;font-size:2.5rem">info_outline</i>
    </a>
  </div>
</div>
          </a>
        </div>
<!-- / over-card -->
<?php } ?>
<?php if($design['use_slide'] == true ) {?></div> <!-- / slide --> <?php } ?>

      </div>
    </div><!-- firstcontainer2 -->



<style>
.prd-container{
  max-width:1000px;
  width:90%;
  margin: 50px auto;
  min-height:100px;
}
.form-group {
    padding-bottom: 7px;
    margin: 10px 0 0 0;
}
.form-group.has-success label.control-label {
  color : #00B8D4;
}
.search_label{
  color : #00B8D4;
}
.has-success .form-control-feedback {
    color: #00B8D4;
    opacity: 1;
}
.form-group.has-success.is-focused .form-control {
     background-image: linear-gradient(#00ae9d, #006691), linear-gradient(#D2D2D2, #D2D2D2);
}

</style>
<style>
.prd-container-wrapper{
  background-color: #eaeaea;
padding: 30px 0;
}
    .card-mini-wrap{
      position: relative;
      z-index: 1;
      background-color: white;
      padding:5px 0;
      margin: 30px 0;
      transition: transform .3s cubic-bezier(.34,2,.6,1),box-shadow .2s ease;
    }
    .card-mini-wrap:not(.card-plain):hover {
      box-shadow: 0 12px 19px -7px rgba(0,0,0,.3);
      transform: translateY(-10px);
      -webkit-transform: translateY(-10px);
      -ms-transform: translateY(-10px);
      -moz-transform: translateY(-10px);
    }
    .over-card-mini .thumbnail-box {
      position: relative;
      margin: 10px 15px 10px;
    }
    .over-card-mini .thumbnail-box img {
      box-shadow:none;
    }

    .over-card-mini .thumbnail-box .btn-overwrap2 {
      background-color: #999;
      #box-shadow: 3px 4px 12px 0px rgba(130, 130, 130, 0.7);
      box-shadow:none;
    }
    .date-col.card-mini h3 {
      font-size: 5.5rem;
    }
    .date-col.card-mini h3 span {
        font-size: 2.5rem;
    }
    .date-col.card-mini h5 {
      font-size: 2rem;
      padding-right: 0px;
    }
    .date-col-sub.card-mini {
      text-align: center;
      border: 1px solid #cacaca;
      padding: 0px;
      border-radius: 8px;
      margin-right: 10px;
      width: 61px;
      height: 61px;
      padding-top: 6px;
    }
    .date-col-sub.card-mini h3 {
      font-size: 2.8rem;
    }
    .left-sub-row.card-mini .date-col-right{
          bottom: 2px;
    }
    .bottom_line{
      color: #999;
      margin-right: 10px;
      font-size: 15px;
      margin-top: 5px;
    }
    left-sub-row card-mini">
      <div class="date-col
    .date-col-sub.card-mini h3 {
      font-size: 2.5rem;
    }
    .date-col-sub.card-mini h3 span {
      font-size: 1.4rem;
    }
    .date-col-sub.card-mini h5 {
      font-size: 1.35rem;
    }
    .btn-grp.card-mini .flot-left {
      font-size: 1.25rem;
    }
    .btn-grp.card-mini .flot-left:nth-child(1) {
      background-color: #108486;
    }
    .btn-grp.card-mini .flot-left:nth-child(2) {
      background-color: #1ba0a2;
    }
    .btn-grp.card-mini .flot-left:nth-child(3) {
      background-color: #1ccacd;
    }
    .btn-deepblue {
      #background-color: #4c7da5;
      #background-color: #999;
      color: #FFFFFF;
      box-shadow: 0 2px 2px 0 rgba(153, 153, 153, 0.14), 0 3px 1px -2px rgba(153, 153, 153, 0.2), 0 1px 5px 0 rgba(153, 153, 153, 0.14);
      -webkit-transition: all 200ms linear;
      -moz-transition: all 200ms linear;
      -o-transition: all 200ms linear;
      -ms-transition: all 200ms linear;
      transition: all 200ms linear;
    }
    .btn-deepblue:hover {
      background-color: #327ab5;
      color: #FFFFFF;
      box-shadow: 0 14px 26px -12px rgba(50, 122, 181, 0.42), 0 4px 23px 0px rgba(50, 122, 181, 0.12), 0 8px 10px -5px rgba(50, 122, 181, 0.2);
    }
    .card-mini-wrap {
      overflow: hidden;
      position: relative;
    }
    .card-mini-wrap.isover:before{
      content:'상환완료';
      position: absolute;
      font-size: 2rem;
      color:#e9e9e9;
      #width:100%;
      padding:5px 25px;
      background-color: #006691;
      border-radius: 3px;
      #text-align: center;
      z-index: 151;
      top:50%;
      -webkit-transform: translateY(-50%) translateX(-50%);
      transform: translateY(-50%) translateX(-50%);
      left:50%;
    }
    .card-mini-wrap.isover:after{
      content:'';
      position: absolute;
      width:100%;
      height:100%;
      z-index:150;
      top:0px;left:0;
      background-color: rgba(50, 50, 50, 0.62);
    }
</style>

<div class="prd-container-wrapper">
    <div class="prd-container">
      <div class="row">
        <div class="col-xs-12" style="text-align:center;color:#066C84;font-size:2.2rem;font-weight:500;"><i class="fas fa-gift"></i> 지난 상품</div>
      </div>
      <div class="row">
        <div class="col-sm-offset-7 col-sm-5">
              <div>
                <form action ='/api/cast/All' method='get'>
                  <div class="form-group label-floating has-success is-empty">
                    <label class="control-label search_label">상품 검색</label>
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

      <div class="row" id="prdlist">
<?php for ($i =0 ; $i< 4 ;$i++) { ?>
        <!-- product item -->
        <div class="col-md-4 col-sm-6">
          <div class="card-mini-wrap <?php if ($i==3) echo 'isover'?>">
          <a href="javasciprt:;">
            <div class="over-card-mini">
              <div class="thumbnail-box">
                <img class="" src="http://kfunding.co.kr/pnpinvest/data/photoreviewers/5/main3.jpg">
                <div class="btn-overwrap">부동산</div>
                <div class="btn-overwrap2">모집대기</div>
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12">
                <div class="over-card-title-left card-mini">
                  <div class="flot-left">
                    1호 케이펀딩 오픈자금 모집 1차
                  </div>
                  <!--span class="flot-left title-small-label hidden-xs">부동산</span-->
                </div>
              </div>
            </div>
            <div class="left-sub-row card-mini">
              <div class="date-col float-left card-mini">
                <h3>10<span>시</span></h3>
                <h5>8월12일</h5>
              </div>
              <div class="date-col-right">
                <div class="date-col-sub float-right card-mini">
                  <h3>18<span>%</span></h3>
                  <h5>수익률</h5>
                </div>
                <div class="date-col-sub float-right card-mini">
                  <h3>3<span></span></h3>
                  <h5>개월</h5>
                </div>
                <div style="clear:both"></div>
                <div class="bottom_line">모집금액: 1억 4,050만원 </div>
              </div>
            </div>
            <div class="row btn-grp-row">
              <div class="col-xs-12">
                <div class="btn-grp prd-event-grp card-mini">
                  <div class="flot-left prd-event-item">리워드최대 6%</div>
                  <div class="flot-left prd-event-item">피자</div>
                  <div class="flot-left prd-event-item">문화상품권</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12" style="text-align:center;margin-bottom:10px;">
                <span class="btn btn-deepblue">자세히보기</span>
              </div>
            </div>
          </a>
          </div>
        </div>
        <!-- / product item -->
<?php } ?>
      </div> <!-- /row -->


<style>
.ellipsis2{
  font-size:18px;
  overflow:hidden;
  text-overflow:ellipsis;
  display:-webkit-box;
  -webkit-line-clamp:2; /* 라인수 */
  -webkit-box-orient:vertical;
  word-wrap:break-word;
  line-height:20px;
  height:40px; /* height = line-height * 줄수 : 비wekkit 계열 */
  }
  .ellipsis3{
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
  }

.prdlist2-item{
    position: relative;
    overflow-x: hidden;
    color:white;
    box-shadow: 0 15px 35px rgba(50,50,93,.1),0 5px 15px rgba(0,0,0,.07)!important;
}
 .prdlist2-item .prdlist2-item-imgbox{
  width:100%;
  height:230px;
  position: relative;
  background-image: url(http://kfunding.co.kr/pnpinvest/data/photoreviewers/5/main3.jpg);
  background-repeat: no-repeat;
  background-position: center center;
  background-size: cover;
  -webkit-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -moz-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -o-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -ms-transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
  transition: all 0.5s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item:hover .prdlist2-item-imgbox, .prdlist2-item:active .prdlist2-item-imgbox{
   background-size: contain;
   background-position: top center;
}
.prdlist2-item-imgbox:before{
    content: attr(data-prdtype);
      position: absolute;
      top: -45px;
      right: -45px;
      width: 90px;
      height: 90px;
      /* vertical-align: bottom; */
      /* z-index: 10; */
      color: white;
      background-color: #3d3f78;
      font-size: 14px;
      text-align: center;
      line-height: 155px;
      transform: rotate(45deg);
      box-shadow: 0 15px 35px rgba(50,50,93,.1),0 5px 15px rgba(0,0,0,.07);
}

.card-img-top {
    width: 100%;
    border-top-left-radius: calc(.25rem - .0625rem);
    border-top-right-radius: calc(.25rem - .0625rem);
}
.bg-gradient-pupple-org {
    background: linear-gradient(87deg,#32325d 0,#44325d 100%);
}
.bg-gradient-pupple {
  background-color:#32325d;
    background: linear-gradient(87deg,rgba(50, 50, 93, 0.7) 0,rgba(68, 50, 93, 0.8) 100%);
}
.bg-gradient-warning {
    background: linear-gradient(87deg,#fa755a 0,#fab85a 100%)!important;
}

.prd2-fill-default {
    fill: #32325d;
}
.prd2-fill-primary {
    fill: #6772e5;
}
.prdlist2-item .card-blockquote {
      margin: 0;
    position: relative;
    padding: 2rem 15px;
    border:0;
}
.prdlist2-item .card-blockquote .svg-bg {
    overflow: hidden;
    vertical-align: middle;
    position: absolute;
    top: -94px;
    left: 0;
    display: block;
    width: 100%;
    height: 95px;
}
.prdlist2-title{
  /*
  line-height: 1.2em;
  height: 2.4em;
  font-weight: 500;
  padding: 5px 0 10px;
  */
}

.prdlist2-infobox{
  margin-top:30px;
  position: relative;
}
.prdlist2-infobox .date-col {
    text-align: center;
    display: inline-block;
    margin-left: 0px;
}
.prdlist2-infobox .date-col-right {
    position: absolute;
    bottom: 9px;
    right: 0px;
}
.prdlist2-infobox .date-col-right:after{
  clear:both;
}
.prdlist2-item .bottom_line {
  color: #999;
  margin-right: 10px;
  font-size: 15px;
  margin-top: -3px;
}
.prdlist2-gift{
  margin-top:10px;
  margin-right: -20px;
  margin-left: -20px;
}

.prdlist2-item .btn-grp.card-mini .flot-left:nth-child(1) {
    #background-color: #007bff;
    background-color: #337ab7;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item .btn-grp.card-mini .flot-left:nth-child(2) {
    #background-color: #3ecf8e;
    background-color: #2098d1;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item .btn-grp.card-mini .flot-left:nth-child(3) {
    #background-color: #fa755a;
    background-color: #337ab7;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}

.prdlist2-item:hover .bg-gradient-pupple {
    background: transparent;
    background-color: #4198b9;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item:hover .prd2-fill-default {
    fill: #357d98;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item:hover .prd2-fill-primary {
    fill: #000000;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}

.light_grey{
  color:#cac4c4 !important;
}
.light_grey2{
  color:#ff9800 !important;
}
.prdlist2-item:hover .light_grey{
  color:#FFF !important;
  -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item:hover .light_grey2{
  color:#FFF !important;
  -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
}
.prdlist2-item:hover .prdlist2-item-imgbox:before {
    background-color: #2a647a;
    -webkit-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -moz-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -o-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    -ms-transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
    transition: all 0.3s cubic-bezier(0.685, 0.0473, 0.346, 1);
  }
.prdlist2-item:hover .btn-grp.card-mini .flot-left:nth-child(1) {
    background-color: #007bff;
}
.prdlist2-item:hover .btn-grp.card-mini .flot-left:nth-child(2) {
    background-color: #3ecf8e;
}
.prdlist2-item:hover .btn-grp.card-mini .flot-left:nth-child(3) {
    background-color: #fa755a;
}
.btn.btn-viewdetail{
  background-color: #4198b9
}
.prdlist2-item:hover .btn.btn-viewdetail{
  background-color: #e91e63
}


.view_link{
  margin-top :40px;
  text-align: center;
}



.prd-container {
    max-width: 1200px;
  }
</style>
<!-- list2 -->
<div id="prdlist2">
  <div class="row">
    <div class="col-md-4 col-sm-6">
      <div class="prdlist2-item bg-gradient-pupple">
        <div class="prdlist2-item-imgbox card-img-top" data-prdtype="부동산" style="background-image: url(/pnpinvest/data/photoreviewers/5/main3.jpg);background-repeat: no-repeat;background-position: center center;background-size: cover;">
        </div>
        <blockquote class="card-blockquote  bg-gradient-pupple">
          <svg preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 583 95" class="svg-bg">
            <polygon points="0,42 583,95 0,95" class="prd2-fill-default" />
            <polygon points="0,42 583,95 583,0 0,95" opacity=".2" class="prd2-fill-primary" />
          </svg>
          <h4 class="prdlist2-title ellipsis2">
            1호 케이펀딩 오픈자금 모집 1차
          </h4>
          <div class="prdlist2-infobox">
            <div class="date-col float-left card-mini">
              <h3 class="light_grey">10<span class="light_grey">시</span></h3>
              <h5 class="light_grey">8월12일</h5>
            </div>
            <div class="date-col-right">
              <div class="date-col-sub float-right card-mini light_grey">
                <h3 class="light_grey2">18<span>%</span></h3>
                <h5 class="light_grey">수익률</h5>
              </div>
              <div class="date-col-sub float-right card-mini light_grey">
                <h3 class="light_grey2">3<span></span></h3>
                <h5 class="light_grey">개월</h5>
              </div>
            </div>
          </div>
          <div class="bottom_line text-right light_grey">모집금액: 1억 4,050만원 </div>

          <div class="row prdlist2-gift">
            <div class="col-xs-12">
              <div class="btn-grp prd-event-grp card-mini prdgrp2">
                <div class="flot-left prd-event-item" style="width: 33.33%;">리워드최대 6%</div>
                <div class="flot-left prd-event-item" style="width: 33.33%;">피자</div>
                <div class="flot-left prd-event-item" style="width: 33.33%;">문화상품권</div>
              </div>
            </div>
          </div>

          <div class="view_link">
            <a href="javascript:;" class="btn btn-viewdetail">자세히보기</a>
          </div>
        </blockquote>
      </div>
    </div>
  </div>
</div>
<!-- / list2 -->



      <!-- page number -->
      <div style="text-align:center">
        <ul class="pagination pagination-info">
          <li class="active"><a href="javascript:;">1</a></li><li><a href="/api/welcome/">2</a></li><li><a href="/api/cast/All/page/3">3</a></li><li><a href="/api/cast/All/page/2">&gt;</a></li>
        </ul>
      </div>
      <!-- / page number -->
    </div>
</div> <!-- / prd-container-wrapper-->
  </div><!-- /card-main -->



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

<link href="/assets/owl/assets/owl.carousel.min.css" rel="stylesheet"/>
<link href="/assets/owl/assets/owl.theme.default.min.css" rel="stylesheet"/>
<script src="/assets/owl/owl.carousel.min.js"></script>
<style>
.owl-carousel .owl-stage-outer {
    margin-bottom: 14px;
  }
.owl-theme .owl-nav {
    height: 0;
    margin: 0;padding: 0;
    /* margin-top: 10px; */
    /*
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    width: 100%;
    */
  }
  .owl-nav .owl-prev{
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    left:0;
    #float:left;
 }
.owl-nav .owl-next{
  position: absolute;
  top: 50%;
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
  right:0;
    #float:right;
}
.owl-dots{
  position: absolute;
  width: 100%;
  bottom: 7px;
}
.owl-theme .owl-dots .owl-dot span {
  /*
    width: 12px;
    height: 12px;
    margin: 5px 7px;
    border-radius: 30px;
    */
    width: 30px;
    height: 4px;
    margin: 5px 6px;

    background: #aaa;
    display: block;
    -webkit-backface-visibility: visible;
    transition: opacity .2s ease;

}
.owl-theme .owl-dots .owl-dot.active span, .owl-theme .owl-dots .owl-dot:hover span {
    background: #228b90;
}
</style>

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


$("document").ready( function() {
  $('.viewtooltip').tooltip({placement: 'left',trigger: 'manual'}).tooltip('show');
  $.each($(".prd-event-grp"), function(){
    var len= $(this).children(".prd-event-item").length ;
    var pct = '33.3';
    switch(len) {
        case(1) :
          pct = '100';
          break;
        case(2) :
          pct = '49.99';
          break
        case(3) :
          pct = '33.33';
          break
    }
    $.each( $(this).children('.prd-event-item') , function (){
      $(this).css("width", pct +"%");
    });
  });

  $('.progress .progress-bar').css("width",
    function() {
      return $(this).attr("aria-valuenow") + "%";
    }
  );

  $(".owl-carousel").owlCarousel({
    items:1,
    margin:10,
    autoHeight:true,
    loop : true,
    autoplay:true,
    autoplayTimeout:5000,
    autoplayHoverPause:true,
    center:true,
    itemsScaleUp:true,
    nav: true,
    navText: ['<i class="fas fa-arrow-circle-left" style="font-size:3.5rem;color:#93a8af"></i>','<i class="fas fa-arrow-circle-right" style="font-size:3.5rem;color:#93a8af"></i>'],
    onInitialize: callbackOwl,
  });

});

function callbackOwl(event) {
  if (parseInt($(event.target).find('div.over-card').length) <= 1) {
    event.relatedTarget.options.loop = false;
  }
}

</script>
</body>
<html>
