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
footer{
    position: relative;
    z-index:10;
}
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
.newcol .imgdiv a img {padding-left:20px;}
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
            <span class="round">케이펀딩 고객센터</span>
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
            <div>사업자 등록번호 312-88-01185</div>
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
