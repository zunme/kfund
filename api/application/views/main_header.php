<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="<?php echo $this->config->item('templateurl')?>/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="<?php echo $this->config->item('templateurl')?>/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>엔젤펀딩</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />

	<!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

	<!-- CSS Files -->
    <link href="<?php echo $this->config->item('templateurl')?>/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<?php echo $this->config->item('templateurl')?>/assets/css/main.css" rel="stylesheet" />
    <link href="<?php echo $this->config->item('templateurl')?>/assets/css/material-kit2.css?v=1.2.1" rel="stylesheet"/>
    <style>
    @media only screen and (max-width: 767px) {
      .hidden-excpt-xs {display:inline-block;}
    }
    @media only screen and (min-width: 768px) {
      .hidden-excpt-xs {display:none;}
    }
    @media only screen and (min-width: 992px) {
    	.hidden-excpt-xs {display:none;}
    }
    .product-page .tab-content img {border-radius: 3px;max-width: 100%;}
    .prd-xs-padding{padding : 3px;}
    .footer-first-row h5{font-size: 1.1em;}
    .footer-first-row p{ margin: 0 0 6px 15px;}

    .footer-first-row .social-feed {padding-left:15px;}
    </style>
</head>

<body class="product-page">
	<nav class="navbar navbar-rose navbar-transparent navbar-fixed-top navbar-color-on-scroll" color-on-scroll="100">
    	<div class="container">
        	<!-- Brand and toggle get grouped for better mobile display -->
        	<div class="navbar-header">
        		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example">
            		<span class="sr-only">Toggle navigation</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
        		</button>
        		<a class="navbar-brand" href="./">Angel Funding</a>
        	</div>

        	<div class="collapse navbar-collapse">
        		<ul class="nav navbar-nav navbar-right">
    				<li>
  						<a href="#">
  							<i class="material-icons">apps</i> 투자하기
  						</a>
  					</li>

					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<i class="material-icons">view_day</i> 대출하기
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu dropdown-with-icons">
							<li>
								<a href="../sections.html#headers">
									<i class="material-icons">dns</i> 부동산
								</a>
							</li>
							<li>
								<a href="../sections.html#features">
									<i class="material-icons">build</i> 개인신용
								</a>
							</li>
							<li>
								<a href="../sections.html#blogs">
									<i class="material-icons">list</i> 사업자
								</a>
							</li>
						</ul>
					</li>

          <li>
            <a href="#">
              <i class="material-icons">apps</i> 회사소개
            </a>
          </li>

					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<i class="material-icons">view_carousel</i> 공지사항
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu dropdown-with-icons">
							<li>
								<a href="../examples/about-us.html">
									<i class="material-icons">account_balance</i> 공지사항
								</a>
							</li>
							<li>
								<a href="../examples/blog-post.html">
									<i class="material-icons">art_track</i> 언론보도
								</a>
							</li>
							<li>
								<a href="../examples/blog-posts.html">
									<i class="material-icons">view_quilt</i> 문의하기
								</a>
							</li>
						</ul>
					</li>


          <li>
            <a href="#">
              <i class="material-icons">apps</i> 고객지원
            </a>
          </li>

        		</ul>
        	</div>
    	</div>
    </nav>
