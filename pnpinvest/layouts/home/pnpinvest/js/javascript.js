// 새 창
function popup_window(url, winname, opt)
{
    window.open(url, winname, opt);
}

/*** window.popup.open ***/
/*** sms 관리 추가 될 함수 ***/
function popup(src,width,height) {
	var scrollbars = "1";
	var resizable = "no";
	if (typeof(arguments[3])!="undefined") scrollbars = arguments[3];
	if (arguments[4]) resizable = "yes";
	window.open(src,'popup','width='+width+',height='+height+',scrollbars='+scrollbars+',toolbar=no,status=no,resizable='+resizable+',menubar=no');
}
/*** sms 관리 추가 될 함수 End ***/
$(window).scroll(function(){
		var scrollTop = $(window).scrollTop();
		if(scrollTop >10){
			


			$('.gnb').stop().animate({top:0+'px'},400);
			$('.gnb').css('position','fixed');
			$('.gnb').css('height','70px');
			$('h1.logo').css('padding-top','12px');
			$('div.gnb_inner> ul > li > a').css('font-size','15px');
			$('div.gnb_inner> ul > li > a').css('margin-top','19px');
			$('div.gnb_inner> ul > li > a').css('margin-bottom','15px');
			$('div.gnb_inner> ul').css('width','670px');/*710px 주석요청 2016-10-06 박유나*/
			$('div.gnb_inner> ul > li:first-child').css('width','130px');
			$('div.gnb_inner> ul > li:nth-child(2)').css('width','80px');
			$('div.gnb_inner> ul > li:nth-child(3)').css('width','80px');
			$('div.gnb_inner> ul > li:nth-child(4)').css('width','80px');
			$('div.gnb_inner> ul > li:nth-child(5)').css('width','107px');
			$('div.gnb_inner> ul > li:nth-child(6)').css('width','80px');
			$('div.gnb_inner> ul > li:nth-child(7)').css('width','60px');
			$('div.gnb_inner> ul > li:first-child>.sub_gnb').css('margin-left','-530px');
			$('div.gnb_inner> ul > li:nth-child(2)>.sub_gnb').css('margin-left','-489px');
			$('div.gnb_inner> ul > li:nth-child(3)>.sub_gnb').css('margin-left','-259px');
			$('div.gnb_inner> ul > li:nth-child(4)>.sub_gnb').css('margin-left','-149px');
			$('div.gnb_inner> ul > li:nth-child(5)>.sub_gnb').css('margin-left','-39px');
			$('div.gnb_inner> ul > li:nth-child(6)>.sub_gnb').css('margin-left','36px');

		}
		else{
			$('.gnb').stop().animate({top:38+'px'},400);
			$('.gnb').css('position','absolute');
			$('.gnb').css('height','96px');
			$('h1.logo').css('padding-top','23px');
			$('div.gnb_inner> ul > li > a').css('font-size','20px');
			$('div.gnb_inner> ul > li > a').css('margin-top','30px');
			$('div.gnb_inner> ul > li > a').css('margin-bottom','30px');
			$('div.gnb_inner> ul').css('width','754px');/*840px 주석요청 2016-10-06 박유나*/
			$('div.gnb_inner> ul > li:first-child').css('width','170px');
			$('div.gnb_inner> ul > li:nth-child(2)').css('width','90px');
			$('div.gnb_inner> ul > li:nth-child(3)').css('width','90px');
			$('div.gnb_inner> ul > li:nth-child(4)').css('width','90px');
			$('div.gnb_inner> ul > li:nth-child(5)').css('width','100px');
			$('div.gnb_inner> ul > li:nth-child(6)').css('width','100px');
			$('div.gnb_inner> ul > li:nth-child(7)').css('width','60px');
			$('div.gnb_inner> ul > li:first-child>.sub_gnb').css('margin-left','-489px');
			$('div.gnb_inner> ul > li:nth-child(2)>.sub_gnb').css('margin-left','-469px');
			$('div.gnb_inner> ul > li:nth-child(3)>.sub_gnb').css('margin-left','-249px');
			$('div.gnb_inner> ul > li:nth-child(4)>.sub_gnb').css('margin-left','-149px');
			$('div.gnb_inner> ul > li:nth-child(5)>.sub_gnb').css('margin-left','-51px');
			$('div.gnb_inner> ul > li:nth-child(6)>.sub_gnb').css('margin-left','36px');

			}
	})
	
/*header-lnb 공지사항 롤링*/				


/**/

			
			$(function(){
				var project=$(".project").bxSlider({
					mode:"horizontal",
					auto:true,
					speed:500,
					pause:8000,
					pager:true,
					moveSlides:1,
					slideWidth:1200,
					minSlides:1,
					maxSlides:1,
					slideMargin:0,
					autoHover:false,
					controls:false
				})
			});
				
			$(function(){
				var cooperator=$(".cooperator").bxSlider({
					mode:"horizontal",
					speed:500,
					pause:8000,
					pager:false,
					moveSlides:1,
					slideWidth:200,
					minSlides:1,
					maxSlides:6,
					slideMargin:0,
					autoHover:false,
					controls:true
				})
			});







/*
	$(function(){
			var obj = $('.gnb ul');

			obj.mouseenter(function(){				
			$('div.sub_gnb').stop().slideDown(100);	
			})
			obj.mouseleave(function(){
				$('div.sub_gnb').stop().slideUp(100);	
			})
		})
*/ 

/* 161017 메인 비주얼 개편으로 기능 사용안함*/
	$(function(){
		$("#slides").slidesjs({
			width: 800, //넓이
			height: 500, //높이
			start: 1, //시작 사진 번호
			navigation: {
				active: false,
				//네비게이션 사용 유무(이전 다음 보기 버튼)
				effect: "slide" //이전 다음 버튼 눌렀을때 효과 슬라이드(slide) 페이드효과(fade)
				//<a href="#" class="slidesjs-previous slidesjs-navigation">이전</a>
			    //<a href="#" class="slidesjs-next slidesjs-navigation">다음</a>
				//false 후 이런식으로 넣으면 커스터마이징 가능함

			},
			pagination: {
			  active: false, //페이징
			  effect: "fade" //숫자 눌렀을때 효과 슬라이드(slide) 페이드효과(fade)
			  //css slidesjs-pagination 이부분 수정으로 커스터마이징 가능함
			},
			play: {
				active: false, //플레이 스탑버튼 사용유무(버튼변경불가)
				effect: "slide",//효과 slide, fade
				interval: 4000,//밀리세컨드 단위 5000 이면 5초
				auto: true, //시작시 자동 재생 사용유무
				swap: true, //플레이스 스탑버튼 둘다보임 false, 하나로 보임 true
				pauseOnHover: true,//마우스 올렸을때 슬라이드 멈춤할껀지 말껀지
				restartDelay: 50//마우스 올렸다가 벗어 났을때 재 작동 시간 밀리세컨드 단위
				//css slidesjs-play, slidesjs-stop 이부분을 이용해서 커스터마이징 가능함
			},

			effect: {
				slide: {
				// 슬라이드 효과
					speed: 3000,
					
					// 0.2초만에 바뀜
				},
				fade: {
				// 페이드 효과
					speed: 3000,
					// 0.3초만에 바뀜
					crossfade: true
					// 다음이미지와 겹쳐서 나타남 유무
				}
			},


			callback: {
				loaded: function(number) {
				//처음 화면 로드될때 번호
				//	alert('loaded : ' + number);
				 $('#slidesjs-slide-number').text(number);
				},
				start: function(number) {
				//변경전 사진번호
				//	alert('start : ' + number);
				},
				complete: function(number) {
				//변경후 사진번호
				// 	alert('complete : ' + number);
				 $('#slidesjs-slide-number').text(number);
				}
			}

		});
	});

	$(function(){	
	$('.all_menu').toggle(
		function(){
	$(".sub_gnb").stop().slideDown(300);
		},function(){
		$(".sub_gnb").stop().slideUp(300);
	});
	})
 
	$( document ).ready( function() {
		//$(".sub_gnb").css('display','none');
	$(".preparing").click(function(){
		alert("현재 서비스 준비중입니다")
		});

	});

	if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});

	//top scroll
	jQuery(document).ready(function() {
	    var offset = 220;
	    var duration = 700;
	    jQuery(window).scroll(function() {
		if (jQuery(this).scrollTop() > offset) {
		    jQuery('.back-to-top').fadeIn(duration);
		} else {
		    jQuery('.back-to-top').fadeOut(duration);
		}
	    });
	    
	    jQuery('.back-to-top').click(function(event) {
		event.preventDefault();
		jQuery('html, body').animate({scrollTop: 0}, duration);
		return false;
	    })
	});

	//top scroll
	jQuery(document).ready(function() {
	    var offset = 220;
	    var duration = 700;
	    jQuery(window).scroll(function() {
		if (jQuery(this).scrollTop() > offset) {
		    jQuery('.back-to-top1').fadeIn(duration);
		} else {
		    jQuery('.back-to-top1').fadeOut(duration);
		}
	    });
	    
	    jQuery('.back-to-top1').click(function(event) {
		event.preventDefault();
		jQuery('html, body').animate({scrollTop: 0}, duration);
		return false;
	    })
	});

	function click_items(id)
	{
		var str = "consult1,consult2";
		var s = str.split(',');
		for (i=0; i<s.length; i++)
		{
			if (id=='*') document.getElementById(s[i]).style.display = 'block';
			else document.getElementById(s[i]).style.display = 'none';
		}
		if (id!='*') document.getElementById(id).style.display = 'block';
	}

	function click_btns(id)
	{
		var str = "realtime1,realtime2";
		var s = str.split(',');
		for (i=0; i<s.length; i++)
		{
			if (id=='*') document.getElementById(s[i]).style.display = 'block';
			else document.getElementById(s[i]).style.display = 'none';
		}
		if (id!='*') document.getElementById(id).style.display = 'block';
	}

/*메인 포트폴리오 이미지 오버시 애니메이팅 되는 스크립트*/


	$(document).ready(function(){
		$("div.project ul li").hover(
			function(){
				$(this).find("div.project_hover").stop().animate({bottom : 0+'px'},300);
			},
			function(){
							
				$(this).find("div.project_hover").stop().animate({bottom : -300+'px'},300);

			}
		)

	});

