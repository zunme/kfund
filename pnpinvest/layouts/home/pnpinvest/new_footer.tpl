<?php
	//include(MARI_VIEW_PATH.'/Common_select_class.php');
	//$sql= "select * from mari_config limit 1";
	//$cfg = sql_fetch($sql);
?>

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

<!-- /////////////////////////////// 하단 시작 /////////////////////////////// -->
<link href="/api/statics/js/hover-min.css" rel="stylesheet"/>
<style>
.footer_line_ul{
	text-align:left;
	max-width: 1220px;
	padding: 15px 10px;
}
.footer_line_ul li{
	padding: 0 3px;
  color: white;
  font-size: 14px;
  font-weight: 200;
}
</style>
<footer id="ft">
	<div style="background-color:#020d2b;border-bottom:1px solid #292929;padding-left:14px;">
		<ul class="footer_line_ul" style="margin: 0 auto;">
			<li class="modal-link" data-title="서비스 이용 약관" data-url="/pnpinvest/css/con01.htm" >서비스이용약관</li>
			<li>|</li>
			<li class="modal-link" data-title="개인정보 취급 방침" data-url="/pnpinvest/css/con02.htm">개인정보취급방침</li>
			<li>|</li>
			<li class="modal-link" data-title="투자자 이용 약관" data-url="/pnpinvest/css/con03.htm">투자자이용약관</li>
			<li>|</li>
			<li class="modal-link" data-title="윤리 강령" data-url="/pnpinvest/css/con04.html">윤리강령</li>
		</ul>
	</div>


	<style>
#ft .container {padding:15px 30px 25px;overflow:hidden;}

	.newfooter{padding-top :15px;padding-bottom :15px;}

	.newfooter .row{
		margin-top:15px;
		margin-bottom:30px;
		padding-bottom: 22px;

	}
	.row.bottomline{
		border-bottom: 1px solid #585858;
	}
	.newfooter .row:last-child{
		margin-top: 50px;
		margin-bottom:5px;
		padding-bottom: 0px;
	}
	.newcol{
		float:left;margin-right:50px;
		color:white;
		margin-top:10px;
		margin-bottom:10px;
		display:inline-block;
		padding-left:10px;
		text-align:left;
	}
	.newcol * {
		color:#b5b3b3;
		font-size: 14px;
		font-weight: normal;
	}
	.newcol.second{
		width:320px;
	}
	.roundbar{
		margin-bottom:20px;
	}

	.roundbar p.round{
		padding: 8px 13px;
    border: 1px solid #fff;
    border-radius: 30px;
    margin-bottom: 5px;
    font-size: 15px;
    font-weight: 400;
    color: white;
	}
	.footer_time{padding-left:30px;}
	.splitdiv:after{}
	.splitdiv div{display:inline-block}
	.splitdiv .splitline{padding-left:10px;padding-right:10px;}
	.newcol .imgdiv{
		    text-align: left;
		margin-bottom:10px;
	}
.newcol .imgdiv img{
	padding-right:10px;
}
@media (max-width: 1120px){
	.newcol.desc{
		margin-left:203px;
	}
}
@media (max-width: 992px){
	.newcol.desc2{
		margin-left: 202px;
	}
}
@media (max-width: 780px){
	.p2plogo{
		margin-top: 40px;
	}
}
	@media (max-width: 611px){
		.footer_time{padding-left:10px;font-size: 16px;}
		.newfooter .row{
			#width: 450px;
			#margin-left: auto;
			#margin-right: auto;
		}
		.newcol{
			margin-left:auto;margin-right:auto;width:100%;
		}
		.newcol .roundbar{
			margin-left:0;
		}
		.roundbar {
			margin-bottom: 10px;
    margin-left: 30px;
		}
		.roundbar p{
			display:inline-block;
		}
		.newcol.desc{
			margin-left:0;
		}
		.newcol.desc2{
			margin-left:0;
		}
	}
	.newfooter .row:last-child {margin-top:-30px;}
.row.lastdesc p{
	font-size: 14px;
	font-weight: normal;
	color : #b5b3b3;
	padding-left:12px;
}

	</style>
	<div class="newfooter container">
		<div class="row bottomline">
			<div class="newcol first">
				<div class="roundbar">
					<p class="round">케이펀딩 고객센터</p>
					<p class="footer_time">
						09:30~18:00
					</p>
				</div>
			</div>
			<div class="newcol second">
				<div class="imgdiv">
					<a href="http://pf.kakao.com/_FcJxcC" target="_blank" title="카카오톡"><img class="hvr-buzz-out" src="/pnpinvest/img/new_kakao.png"></a>
					<a href="https://www.facebook.com/kfundingofficial/?modal=admin_todo_tour" target="_blank" title="페이스북"><img class="hvr-buzz-out" src="/pnpinvest/img/new_face.png"></a>
					<a href="https://blog.naver.com/kfundings" target="_blank" title="블로그"><img class="hvr-buzz-out" src="/pnpinvest/img/new_blog.png"></a>
				</div>
				<div class="splitdiv last">
					<div>Tel.02-552-1772</div>
					<div class="splitline">|</div>
					<div>Fax.02-552-1773</div>
				</div>
				<div>E-mail.help@kfunding.co.kr</div>
			</div>
			<div class="newcol desc" style="text-indent:-8px;padding-left:25px;">
				<div>
					<p><i class="far fa-check-circle"></i> 광고 제안은 메일로 보내주시길 바라며, 전화문의는 절대 사절합니다.</p>
					<p><i class="far fa-check-circle"></i> 주말 및 공휴일은 운영하지 않습니다.</p>
					<p><i class="far fa-check-circle"></i> 운영시간은 사정에 따라 변동 될 수 있습니다.</p>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="newcol first">
				<div class="roundbar">
					<p class="round">케이펀딩 회사정보</p>
				</div>
			</div>
			<div class="newcol second">
				<div>(주) 케이펀딩</div>
				<div>대표이사 김현철</div>
				<div>주소 : 서울 강남구 테헤란로 86길 14 윤천빌딩 5층</div>
				<div class="splitdiv last">
					<div>Tel.02-552-1772</div>
					<div class="splitline">|</div>
					<div>Fax.02-552-1773</div>
				</div>
				<div>사업자 등록번호 318-81-09046</div>
			</div>
			<div class="newcol desc2">
				<div>(주) 케이크라우드대부</div>
				<div>대표이사 김현철</div>
				<div>주소 : 서울 강남구 테헤란로 86길 14 윤천빌딩 5층</div>
				<div class="splitdiv last">
					<div>Tel.02-552-1772</div>
					<div class="splitline">|</div>
					<div>FAX.02-552-1773</div>
				</div>
				<div>사업자 등록번호 312-88-01185</div>
				<div>등록번호 2018-금감원-1608(P2P연계대부업)</div>
				<div>등록기관 : 금융감독원 ( 1332 )</div>
			</div>
		</div>

		<div class="row lastdesc" style="text-align: left;text-indent:-8px;">
			<div style="display:inline-block;margin:0 auto;text-align:left;  position: relative;padding-left: 15px;float:left;padding-right:10px;">
				<p><i class="far fa-comment"></i> 대출금리 연 19.9%이내 (연체금리 연 24% 이내) 플랫폼 이용료 외 기타 부대비용은 없습니다.</p>
				<p><i class="far fa-comment"></i> 중개수수료를 요구하거나 받는 행위는 불법입니다. 과도한 빚은 당신에게 큰 불행을 안겨줄 수 있습니다.</p>
				<p><i class="far fa-comment"></i> 대출 시 귀하의 신용등급이 하락할 수 있습니다.</p>
				<p><i class="far fa-comment"></i> 채무의 조기상환수수료율 등 조기상환조건 없습니다. 중개수수료를 요구하거나 받는 행위는 불법 입니다.</p>
				<p class="blue" style="color:white"><i class="far fa-comment"></i> 저희 케이펀딩은 투자원금과 수익을 보장하지 않으며 투자 손실에 대한 책임은 모두 투자자에게 있습니다.</p>
			</div>
			<div class="p2plogo"style="float:right;position:relative;">
				<a href="http://p2plending.or.kr/" target="_blank"><img src="/pnpinvest/img/k_p2p_logo.png" style="width:120px;"></a>
			</div>
			<div style="clear:both"></div>
				<!--a class="kcfa" href="http://crowdfunding.or.kr/" ><img src="/pnpinvest/img/crelogo.png" alt="한국크라우드 펀딩협회"></a-->
				<p class="copyright" style="padding-top:30px;text-align:center;">Copyrightⓒ 2018 K-FUNDING. All Rights Reserved.</p>

		</div>
	</div>

</footer>
<!-- /////////////////////////////// 하단 끝 /////////////////////////////// -->
<div class="alert_wrap">
	<div class="alert login">
		<strong>Angelfunding Partners</strong>
		<p class="txt"><i class="icon"></i>로그인 후 사용가능합니다.</p>
		<a href="/pnpinvest/?mode=login" class="btn t_gray">로그인</a>
		<button class="close">닫기</button>
	</div>
</div>

<!-- 팝업 -->
<div class="iw_popup">
	<div class="iwp_sum">
		<p class="p_logo"><img src="/pnpinvest/img/logo_2.png" alt="Angelfunding Partners"></p>
		<div id="iw_popup_cont">

	  </div>
		<p class="right">
			<button type="button" class="btn close">닫기</button>
		</p>
	</div>
</div>
<script>
function ValidateEmail1(mail)
{
  console.log(mail);
 if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))
  {
    return (true)
  }
    return (false)
}

function ajlogin() {
	console.log($("#fundlogin > #login > input[type=password]").val());
	if ( !ValidateEmail1($("#fundlogin input[name=m_id]").val()) ){
		alert('이메일을 확인해주세요.');return false;
	}
	else if($("#fundlogin input[type=m_password]").val().trim() == '' ){
		alert('패스워드를 입력해주세요');return false;
	}
	else {
		//document.f.action='/pnpinvest/?mode=login_ck';
		//return true;
		$.ajax({
			type : 'POST',
			url : '/pnpinvest/?mode=login_ck',
			data : $("#fundlogin").serialize(),
			dataType : 'json',
			success : function(result) {
				if(result.code==200){
					self.location.reload();
				}else{
					alert(result.msg);
				}
			}
		});
	}

}
function displaylogin() {
	//$("#fundo").fadeIn();
}
function cancellogin() {
	$("#fundo").fadeOut();
}
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

<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "9d1c0cd58e8b30";
wcs_do();
</script>

</body>
</html>
