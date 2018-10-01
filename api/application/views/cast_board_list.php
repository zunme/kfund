<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons|Pinyon+Script|Playball|Jua|Nanum+Gothic" />
  <link rel="stylesheet" href="/assets/font-awesome/latest/css/font-awesome.min.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">

  <link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.min.css">
  <link href="/assets/material-kit/assets/css/material-kit2.css?v=1.2.2" rel="stylesheet"/>
  <link href="/assets/material-kit/assets/css/color.css" rel="stylesheet" />

  <link rel="stylesheet" type="text/css" href="/assets/summernote/summernote.css">
  <link href="/assets/zcast.css" rel="stylesheet" />
  <style type="text/css">
  body{
    font-family: 'Nanum Gothic',"Helvetica Neue",Helvetica,Arial,sans-serif;
  }
  .page-header {
    height: 350px;
  }
  .table > thead > tr > th {
    font-size: 1.2em;
    text-align: center;
}
  .c-modal-dialog {
      margin: 30px auto;
      width: 90%;
      max-width: 1000px;
  }

  .float-left {float: left!important;}
  .float-right {float: right!important;}
  .ml-auto, .mx-auto {margin-left: auto!important;float:none;}
  .mr-auto, .mx-auto {margin-right: auto!important;float:none;}
  .btn.btn-fab, .btn.btn-just-icon {font-size: 24px;height: 41px;min-width: 41px;width: 41px;padding: 0;overflow: hidden;position: relative;line-height: 41px;}
  .img-fluid, .img-thumbnail {max-width: 100%;height: auto;}
  .rounded-circle {border-radius: 50%!important;}
  .img-raised {box-shadow: 0 5px 15px -8px rgba(0,0,0,.24), 0 8px 10px -5px rgba(0,0,0,.2);}
  .navbar-dark {color: #fff;background-color: #546e7a;box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(33,33,33,.46);  }
  .bg-dark {color: #fff;background-color: #212121!important;box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(33,33,33,.46);}
  .btn.btn-cyan,
  .navbar .navbar-nav > li > a.btn.btn-cyan {
      box-shadow: 0 2px 2px 0 rgba(0, 172, 193, 0.14), 0 3px 1px -2px rgba(0, 172, 193, 0.2), 0 1px 5px 0 rgba(0, 172, 193, 0.12);
  }
  .btn.btn-cyan, .btn.btn-cyan:hover, .btn.btn-cyan:focus, .btn.btn-cyan:active, .btn.btn-cyan.active, .btn.btn-cyan:active:focus, .btn.btn-cyan:active:hover, .btn.btn-cyan.active:focus, .btn.btn-cyan.active:hover,
  .open > .btn.btn-cyan.dropdown-toggle,
  .open > .btn.btn-cyan.dropdown-toggle:focus,
  .open > .btn.btn-cyan.dropdown-toggle:hover,
  .navbar .navbar-nav > li > a.btn.btn-cyan,
  .navbar .navbar-nav > li > a.btn.btn-cyan:hover,
  .navbar .navbar-nav > li > a.btn.btn-cyan:focus,
  .navbar .navbar-nav > li > a.btn.btn-cyan:active,
  .navbar .navbar-nav > li > a.btn.btn-cyan.active,
  .navbar .navbar-nav > li > a.btn.btn-cyan:active:focus,
  .navbar .navbar-nav > li > a.btn.btn-cyan:active:hover,
  .navbar .navbar-nav > li > a.btn.btn-cyan.active:focus,
  .navbar .navbar-nav > li > a.btn.btn-cyan.active:hover,
  .open >
  .navbar .navbar-nav > li > a.btn.btn-cyan.dropdown-toggle,
  .open >
  .navbar .navbar-nav > li > a.btn.btn-cyan.dropdown-toggle:focus,
  .open >
  .navbar .navbar-nav > li > a.btn.btn-cyan.dropdown-toggle:hover {
      background-color: #00acc1;
      color: #FFFFFF;
  }

  .btn.btn-cyan:focus, .btn.btn-cyan:active, .btn.btn-cyan:hover,
  .navbar .navbar-nav > li > a.btn.btn-cyan:focus,
  .navbar .navbar-nav > li > a.btn.btn-cyan:active,
  .navbar .navbar-nav > li > a.btn.btn-cyan:hover {
      box-shadow: 0 14px 26px -12px rgba(0, 172, 193, 0.42), 0 4px 23px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 172, 193, 0.2);
  }






  img{max-width: 100%;}

  .profile-page .profile { text-align: center;}


  .profile-page .profile img {
    max-width: 160px;
    width: 100%;
    margin: 0 auto;
    transform: translate3d(0,-50%,0);
  }
  .profile-page .follow {
    position: absolute;
    top: 0;
    right: 0;
}
.justiconboard{
  font-size: 24px;
  height: 41px;
  min-width: 41px;
  width: 41px;
  padding: 0;
  overflow: hidden;
  position: relative;
  line-height: 41px;
}
  .view_btn {    font-size: 24px;    padding: 0px 10px;    margin-right: 10px;}
footer {    margin-top: 20px;}
footer ul li a  {
  color: inherit;
  padding: .9375rem;
  font-weight: 500;
  font-size: 12px;
  text-transform: uppercase;
  border-radius: 3px;
  position: relative;
  display: block;
  }

  .avatar{
    position: relative;
  }
  .avatar_title{    position: absolute;
    color:#353535;
    bottom: 90px;
    font-size: 20px;
    font-weight: 600;
    left: 50%;
    transform: translate3d(-50%,-50%,0);
}
.navbar .navbar-nav > li > a.btn.btn-primary.dropdown-toggle:hover {
    background-color: #FFFFFF;
    color: #FFFFFF;
}

.bootstrap-select.btn-group .dropdown-menu li a:focus, .bootstrap-select.btn-group .dropdown-menu li a:hover {
    box-shadow: 0 5px 20px 0px rgba(0, 0, 0, 0.2), 0 13px 24px -11px rgba(91, 177, 179, 0.6);
    background-color: #5BB1B3;
}
.btn.btn-warning, .btn.btn-warning:hover, .btn.btn-warning:focus, .btn.btn-warning:active, .btn.btn-warning.active, .btn.btn-warning:active:focus, .btn.btn-warning:active:hover, .btn.btn-warning.active:focus, .btn.btn-warning.active:hover, .open > .btn.btn-warning.dropdown-toggle, .open > .btn.btn-warning.dropdown-toggle:focus, .open > .btn.btn-warning.dropdown-toggle:hover, .navbar .navbar-nav > li > a.btn.btn-warning, .navbar .navbar-nav > li > a.btn.btn-warning:hover, .navbar .navbar-nav > li > a.btn.btn-warning:focus, .navbar .navbar-nav > li > a.btn.btn-warning:active, .navbar .navbar-nav > li > a.btn.btn-warning.active, .navbar .navbar-nav > li > a.btn.btn-warning:active:focus, .navbar .navbar-nav > li > a.btn.btn-warning:active:hover, .navbar .navbar-nav > li > a.btn.btn-warning.active:focus, .navbar .navbar-nav > li > a.btn.btn-warning.active:hover, .open >
 .navbar .navbar-nav > li > a.btn.btn-warning.dropdown-toggle, .open >
 .navbar .navbar-nav > li > a.btn.btn-warning.dropdown-toggle:focus, .open >
 .navbar .navbar-nav > li > a.btn.btn-warning.dropdown-toggle:hover {
    background-color: #78909c;
    color: #FFFFFF;
        box-shadow: 0 2px 2px 0 rgba(120, 144, 156, 0.14), 0 3px 1px -2px rgba(120, 144, 156, 0.2), 0 1px 5px 0 rgba(120, 144, 156, 0.14);
}

.btn.btn-dribbble, .navbar .navbar-nav > li > a.btn.btn-dribbble {
    background-color: #2c9198;
    color: #fff;
    box-shadow: 0 2px 2px 0 rgba(44, 145, 152, 0.2), 0 3px 1px -2px rgba(44, 145, 152, 0.2), 0 1px 5px 0 rgba(44, 145, 152, 0.2);
}
  </style>

  <script type="text/javascript" src="/assets/js/jquery.min.js"></script>
  <script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>
  <script src="/assets/js/material.min.js"></script>
  <script src="/assets/js/moment.min.js"></script>
  <script src="/assets/js/nouislider.min.js" type="text/javascript"></script>
  <script src="/assets/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
  <script src="/assets/js/bootstrap-selectpicker.js" type="text/javascript"></script>
  <script src="/assets/js/bootstrap-tagsinput.js"></script>
  <script src="/assets/js/jasny-bootstrap.min.js"></script>
  <script src="/assets/js/jquery.flexisel.js"></script>

  <script src="/assets/material-kit/assets/js/material-kit2.js?v=1.2.2" type="text/javascript"></script>
  <script type="text/javascript" src="/assets/summernote/summernote.min.js"></script>
  <script type="text/javascript" src="/assets/summernote/summernote-ext-addclass.js"></script>

  <title>캐스트 리스트</title>
</head>
<body>

  <nav class="navbar navbar-dark navbar-transparent navbar-fixed-top navbar-color-on-scroll" color-on-scroll="100">
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
              <span style="font-family: 'Pinyon Script', cursive;font-size:30px;font-weight:bold;">K</span><span style="margin-left: 20px;">FUNDING</span>
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
                <a class="loan" href="/pnpinvest/?mode=login" >
                  <i class="material-icons">store</i> 대출신청
                </a>
              </li>
              <li>
                <a href="/pnpinvest/?mode=companyintro01">
                  <i class="material-icons">apps</i> 회사소개
                </a>
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
            </ul>
          </div>
      </div>
    </nav>

<div class="page-header header-filter" style="background-image: url('/assets/img/architecture-buildings-city-311012.jpg');">
	<div class="container">

	</div>
</div>
<div class="main main-raised">
  <div class="container">
        <div class="profile-page">
          <div class="row">
            <div class="col-md-6 ml-auto mr-auto">
                    <div class="profile">
                            <div class="avatar">
                                <img src="/assets/img/castlogo.png" alt="Circle Image" class="img-raised rounded-circle img-fluid" style="background-color: #207795;">
                                <span class="avatar_title">캐스트</span>
                            </div>
                            <div class="name">
                                    <h3 class="title">CAST LIST</h3>
                                    <!--h6>CAST LIST</h6-->
                                    <a href="javascript:;" onClick="viewtr('N')" class="btn justiconboard btn-link btn-dribbble" style="background-color:#2C9198"><i class="fas fa-bullhorn"></i></i></a>
                                    <a href="javascript:;" onClick="viewtr('V')"  class="btn justiconboard btn-link btn-twitter"><i class="far fa-eye"></i></a>
                                    <ahref="javascript:;" onClick="viewtr('A')"  class="btn justiconboard btn-link btn-pinterest"><i class="fab fa-adn"></i></a>
                            </div>
                    </div>

                    <div class="follow">
                            <a href="/api/castboard/paper" class="btn btn-fab btn-cyan btn-round" rel="tooltip" title="" data-original-title="신규 캐스트 작성">
                                    <i class="material-icons">add</i>
                            </a>
                    </div>

            </div>
          </div>
          <div>
            <div class="row">
              <div class="col-lg-4 col-md-5 col-sm-6 col-xs-12" style="float:right">
                  <select id="loanselect" class="selectpicker" data-style="select-with-transition" title="관련상품" onchange="viewloan()">
                      <option disabled>Choose ..</option>
                      <option value="0">정보</option>
                      <?php foreach( $select as $row){?>
                      <option value="<?php echo $row['i_id']?>"><?php echo $row['i_subject']?></option>
                      <?php }?>
                  </select>
              </div>
            </div>
          </div>
        </div>
      <!-- / top -->
    <div class="board_list_wrap">
      <table class="table">
        <!--caption>캐스트 리스트</caption-->
        <thead>
          <tr>
            <th class="hidden-xs">#</th>
            <th  class="hidden-xs hidden-sm">상단</th>
            <!--th  class="hidden-xs">보이기</th-->
            <th class="hidden-xs hidden-sm">상품</th>
            <th>제목</th>
            <th class="hidden-xs hidden-sm">일자</th>
          </tr>
        </thead>
        <tbody id="CASTLISTBODY">
          <?php foreach ($list as $row) {?>
            <tr class="<?php echo($row['notice']=='Y')  ? 'notice_Y':'notice_N' ?> <?php echo($row['isview']=='Y')  ? 'view_Y':'view_N' ?>" data-loanid="<?php echo $row['loan_id']?>">
              <td scope="row" class="hidden-xs"><?php echo $row['cast_idx']?></td>
              <td  class="hidden-xs hidden-sm"><?php echo ($row['notice']) ?></td>
              <!--td class="hidden-xs"><?php echo $row['isview']?></td-->
              <td  class="hidden-xs hidden-sm" title="<?php echo $row['i_subject']?>"><?php echo $row['loan_id']?></td>
              <td>
                <a class="btn btn-warning modal-contents view_btn" href="javascript:;" data-idx="<?php echo $row['cast_idx']?>"><i class="fas <?php echo($row['isview']=='Y')  ? 'fa-eye':'fa-eye-slash' ?>"></i></a>
                <a href="/api/castboard/paper?castid=<?php echo $row['cast_idx']?>"><?php echo $row['cast_title']?></a>
              </td>
              <td  class="hidden-xs hidden-sm"><?php echo $row['regdate']?></td>
            </tr>
          <?php } ?>
        </tbody>
      </table>
      <div class="float-right">
        <a href="/api/castboard/paper" class="btn btn-cyan"><i class="far fa-edit"></i> 새로운 글 쓰기</a>
      </div>
    </div>
  </div>
</div>

<footer class="footer footer-default">
  <div>
    <div class="container">
      <ul class="footer-service">
        <li><a href="javasciprt:;" class="modal-link" data-title="서비스 이용 약관" data-url="/pnpinvest/css/con01.htm">서비스이용약관</a></li>
        <li><a href="javasciprt:;" class="modal-link" data-title="개인정보취급방침" data-url="/pnpinvest/css/con02.htm">개인정보취급방침</a></li>
        <li><a href="javasciprt:;" class="modal-link" data-title="투자자이용약관" data-url="/pnpinvest/css/con03.htm">투자자이용약관</a></li>
        <li><a href="javasciprt:;" class="modal-link" data-title="윤리강령" data-url="/pnpinvest/css/con04.htm">윤리강령</a></li>
      </ul>
    </div>
  </div>

  <div class="container">
    <nav class="float-left">
      <ul>
        <li>
          <a href="/pnpinvest/?mode=main">
              K-Funding
          </a>
        </li>
        <li>
          <a href="https://www.facebook.com/thekfunding">
              facebook
          </a>
        </li>
        <li>
          <a href="https://blog.naver.com/kfundings">
              Blog
          </a>
        </li>
        <li>
          <a href="https://pf.kakao.com/_FcJxcC">
              KaKao
          </a>
        </li>
      </ul>
    </nav>
    <div class="copyright float-right">
        © 2018, made with <i class="material-icons">favorite</i> by 태기
    </div>
  </div>
</footer>


  <!-- Modal2 -->
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
function viewloan(select){
  var loanid = $("#loanselect option:selected").val();
  $("#CASTLISTBODY tr").each( function () {
    $(this).data('loanid') == loanid ? $(this).show() : $(this).hide();
  });
}
function viewtr(cl){
  $("#CASTLISTBODY tr").each( function () {
    if (cl=='V'){
      $(this).hasClass('view_Y') ? $(this).show() : $(this).hide();
    }else if (cl =='N') {
      $(this).hasClass('notice_Y') ? $(this).show() : $(this).hide();
      console.log( $(this).hasClass('notice_Y') );
    }else $(this).show();
  });
}
$(document).ready( function () {
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
});
</script>
</body>
</html>
