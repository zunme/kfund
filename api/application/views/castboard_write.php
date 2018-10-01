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
    <link rel="stylesheet" type="text/css" href="/assets/zcast.css">

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
.modal-backdrop.in {
    filter: alpha(opacity=50);
    opacity: 0;
    width: 0;
    height: 0;
}

.container {
    max-width: 800px;
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

  <title>캐스트 작성</title>
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
                                <img src="/assets/img/castlogo.png" alt="Circle Image" class="img-raised rounded-circle img-fluid" style="background-color: #ff9800;">
                                <span class="avatar_title">캐스트</span>
                            </div>
                            <div class="name">
                                    <h3 class="title">CAST write</h3>
                            </div>
                    </div>

                    <div class="follow">
                            <a href="/api/castboard/paper" class="btn btn-fab btn-rose btn-round" rel="tooltip" title="" data-original-title="Follow this user">
                                    <i class="material-icons">add</i>
                            </a>
                    </div>

            </div>
          </div>

        </div>
      <!-- / top -->
    <div class="board_list_wrap">
<!-- start -->


<form name="castboard" id="castboard">
  <input type="hidden" name="castid" value="<?php echo ( isset($data['cast_idx']) ) ? $data['cast_idx'] :"" ?>">
  <div class="form-group">
    <label for="exampleInputEmail1">제목</label>
    <input type="text" class="form-control" id="casttitle" name="casttitle" placeholder="제목을 입력하세요" value="<?php echo (isset($data['cast_title']) ) ? $data['cast_title'] : '' ?>">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">관련상품</label>
    <select class="form-control" name="loan_id" onChange="loanchanged()">
    <option value="">선택해주세요</option>
    <option value="0" <?php echo ( isset($data['loan_id']) && $data['loan_id'] === "0" ) ? "selected" :"" ?> >투자정보</option>
    <?php foreach($list as $row) { ?>
    <option value="<?php echo $row['i_id']?>" <?php echo ( isset($data['loan_id']) && $data['loan_id'] == $row['i_id'] ) ? "selected" :"" ?> ><?php echo $row['i_subject']?></option>
    <?php } ?>
  </select>
  </div>
  <div class="row" style="text-align:right">
    <div class="col-sm-2 col-xs-hidden hidden-xs">
    </div>
    <div class="col-sm-5">
      <label class="radio-inline">
      노출여부 :
      </label>
      <label class="radio-inline">
        <input type="radio" name="isview" value="Y" <?php echo ( isset($data['isview']) && $data['isview'] == 'Y' ) ? "checked" :$data['isview'] ?> > 보이기
      </label>
      <label class="radio-inline">
        <input type="radio" name="isview" value="N" <?php echo ( !isset($data['isview']) || $data['isview'] != 'Y' ) ? "checked" :"" ?> > 숨기기
      </label>
    </div>
    <div class="col-sm-5">
      <label class="radio-inline">
      상단노출
      </label>
      <label class="radio-inline">
        <input type="radio" name="notice" value="Y" <?php echo ( isset($data['notice']) && $data['notice'] == 'Y' ) ? "checked" :"" ?> > 상단노출
      </label>
      <label class="radio-inline">
        <input type="radio" name="notice" value="N"  <?php echo ( !isset($data['notice']) || $data['notice'] != 'Y' ) ? "checked" :"" ?> > 일반글
      </label>
    </div>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">내용</label>
    <textarea id="summernote" name="cast_body"><?php echo (isset($data['cast_body']) ) ? $data['cast_body'] : '' ?></textarea>
  </div>
  <div>
    <a  class="btn btn-primary" href="javascript:;" onClick="save()">저장하기</a>
    <a class="btn btn-success float-right clear-both" href="/api/castboard">목록으로 가기</a>
  </div>
</form>











<!-- / END -->
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
<style>
.btn.btn-sm{font-size: 16px;}
</style>

<script type="text/javascript">
  String.prototype.escapeSpecialChars = function() {
    return this.replace(/\\n/g, "\\n")
               .replace(/\\'/g, "\\'")
               .replace(/\\"/g, '\\"')
               .replace(/\\&/g, "\\&")
               .replace(/\\r/g, "\\r")
               .replace(/\\t/g, "\\t")
               .replace(/\\b/g, "\\b")
               .replace(/\\f/g, "\\f");
};

  var beforesuject ="";
  var summernote;
  function loanchanged(){
    var loanid = $("select[name=loan_id] option:checked").val();
    console.log( $("select[name=loan_id] option:checked").text() );
    if( $("input[name=casttitle]").val() == beforesuject && loanid > 0 ){
      beforesuject = $("select[name=loan_id] option:checked").text();
      $("input[name=casttitle]").val( beforesuject );
    }else {
      console.log( $("select[name=loan_id]").val() );
    }
  }

  function save() {
    if( $("input[name=casttitle]").val()=='') {
      alert("제목을 적어주세요"); return false;
    }
    if( $("select[name=loan_id] option:checked").val() =='') {
      alert("관련상품을 넣어주세요"); return false;
    }
    if( $("#summernote").val()=='') {
      alert("내용을 적어주세요"); return false;
    }
    if ( confirm("저장하시겠습니까?") ){
      $.ajax({
        type : 'POST',
        url : '/api/index.php/castboard/write',
        dataType : 'json',
        data : $("#castboard").serialize(),
        success : function(result) {
          if(result.code=='200'){
            $("input[name=castid]").val( result.castid );
            alert("저장하였습니다.");
          }else {
            alert( result.msg.escapeSpecialChars() );
          }
        },
        error: function (jqXHR, exception) {
            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Not connect.\n Verify Network.';
            } else if (jqXHR.status == 404) {
                msg = 'Requested page not found. [404]';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            alert(msg);
        },
      });

    }
  }
  function sendFile(file, editor, welEditable){
    var data = new FormData();
    data.append ("userfile", file);
    $.ajax({
      url : "/api/index.php/castboard/uploadimg",
      data : data,
      cache :false,
      contentType: false,
      processData : false,
      type : "POST",
      success : function (result){
        summernote.summernote('insertImage', result);
        console.log(result);
      },
      error : function (jqXHR, textStatus, errorThrown) {
        console.log(textStatus + " " + errorThrown);
      }
    });
  }
  $(function(){
    summernote = $('#summernote').summernote({
        addclass: {
            debug: false,
            classTags: [{title:"서브제목","value":"k-cast-sub-head"},{title:"3라인","value":"k-threeline"},{title:"이미지타이틀","value":"k-img-title"},{title:"A-텍스트","value":"k-cast-text"},{title:"텍스트","value":"k-cast-p"}]
        },
        height: 500,
        toolbar: [
             //[groupName, [list of button]],
            ['img', ['picture']],
            ['style', ['addclass']],
            ['fontsize', ['fontsize', 'height','color','bold','clear']],
            ['para', ['paragraph']],
            ['table',['table']],
            ['misc', ['undo', 'redo', 'codeview', 'help']]

        ],
        callbacks: {
          onImageUpload: function (files,editor, $editable){
            //console.log( $summernote );
            sendFile(files[0], $(this), $editable);

          }
        }
    });
  });
  </script>

</body>
</html>
