/* 작성자 이지연 */

$(document).ready(function(){
	'use strict';
	// animation
	$('.motion').appear(function(){
		var elem = $(this);
		var animation = elem.data('animation');
		if (!elem.hasClass('visible')){
			var animationDelay = elem.data('animation-delay');
			if (animationDelay){
				setTimeout(function(){
					elem.addClass(animation+" visible");
				},animationDelay);
			} else {
				elem.addClass(animation+" visible");
			}
		} 
	});
	$('.motion2').appear(function() {
		var elem = $(this);
		var animationDelay = elem.data('animation-delay');
		setTimeout(function(){
			elem.addClass('up');
		}, animationDelay);
	});
	// gnb
	$('#gnb .dep1_menu').click(function(){
		$(this).siblings().css('opacity','1').css('height','inherit');
	});
	$('#hd').mouseleave(function(){
		$('#gnb .depth2').css('opacity','0').css('height','0px');
	});
	$('#gnb .depth2 a').focus(function(){
		$('#gnb .depth2').css('opacity','1').css('height','inherit');
	});
	$('#gnb .depth2 a').blur(function(){
		$('#gnb .depth2').css('opacity','0').css('height','0px');
	});
	$('.gnb_toggle').click(function(){
		$(this).toggleClass('close');
		$('#gnb').toggleClass('open');
		$('#hd').toggleClass('open');
	});
	$(document).mousedown(function(e){
		if( $('#gnb').hasClass('open') == true ){
			if(!$('#gnb, #hd').has(e.target).length) { 
				$('.gnb_toggle').removeClass('close');
				$('#gnb').removeClass('open');
				$('#hd').removeClass('open');
			};
		};
	}); 

	//alert
	$('#gnb .loan').click(function(){
		$('.alert_wrap').fadeIn();
		$('.alert_wrap .login').fadeIn();
	});
	$('.pass_sch .email_chk').click(function(){
		$('.alert_wrap').fadeIn();
		$('.alert_wrap .email_no').fadeIn();
	});
	$('.pass_sch .code_chk').click(function(){
		$('.alert_wrap').fadeIn();
		$('.alert_wrap .code_no').fadeIn();
	});
	$('.pass_sch .pass_chk').click(function(){
		$('.alert_wrap').fadeIn();
		$('.alert_wrap .pass_no').fadeIn();
	});
	// alert close
	$('.alert_wrap button').click(function(){
		$('.alert_wrap .alert').fadeOut();
		$('.alert_wrap').fadeOut();
	});
	// header
	$(window).scroll(function(){
		var offset=200;
		if($(this).scrollTop() > offset){
			$('#hd .container').addClass('move');
		}else{
			$('#hd .container').removeClass('move');
		};
	});
	// pass list
	$('.allitem').click(function(){
		$('.invest_all').removeClass('close');
	});
	$('.folditem').click(function(){
		$('.invest_all').addClass('close');
	});
	// list type
	$('.list_type .list').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		$('.product').removeClass('gallery');
	});
	$('.list_type .gallery').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		$('.product').addClass('gallery');
	});
	// tab contents
	$('.tab .title').click(function(){
		$(this).siblings().removeClass('on');
		$(this).addClass('on').next().addClass('on');
	});
	//q&a
	$('.qa_con dt').click(function(){
		if( $(this).hasClass('on') == true ){
			$(this).removeClass('on').siblings().removeClass('on');
		} else {		
			$(this).parent().siblings().children('dt,dd').removeClass('on');
			$(this).addClass('on').siblings().addClass('on');
		}
	});
	//main visual
	var wheight = $(window).height();
	$('.main_visual .container').height(wheight-75);
	//scroll fintech
	$('.scroll').click(function(){
		var scrollPosition = $('.fintech').offset().top-65;
		$("body,html").animate({
			scrollTop: scrollPosition
		}, 500);
	});
	//주석
	$('.number .number_con2 th .tt').click(function(){
		$('.number .number_con2 th .txt').removeClass('open');
		$(this).siblings().addClass('open');
	});
	$('.number .number_con2 th .close').click(function(){
		$(this).parent().removeClass('open');
	});
	//주석 2
	$('.exp_btn').click(function(){
		$('.exp_con').fadeToggle();
	});
	//user popup
	$('.ui_list a').click(function(){
		$('.user_popup').fadeIn('fast');
	});
	$('.uil_01').click(function(){
		$('.pu_tab a').removeClass('on');
		$('.pu_tab .uil_01').addClass('on');
		$('.pu_con').removeClass('on');
		$('.pu_con.con01').addClass('on');
	});
	$('.uil_02').click(function(){
		$('.pu_tab a').removeClass('on');
		$('.pu_tab .uil_02').addClass('on');
		$('.pu_con').removeClass('on');
		$('.pu_con.con02').addClass('on');
	});
	$('.uil_03').click(function(){
		$('.pu_tab a').removeClass('on');
		$('.pu_tab .uil_03').addClass('on');
		$('.pu_con').removeClass('on');
		$('.pu_con.con03').addClass('on');
	});
	$('.user_popup .close').click(function(){
		$('.user_popup').fadeOut('fast');
	});
	//mypage tab
	$('.btn_mytab').click(function(){
		$(this).addClass('active').siblings().removeClass('active');
	});
	//counter
	$('.counter').counterUp({
		delay: 10,
		time: 1000
	});
	// 투자신청 동의 팝업
	$('.iw_agree .privacy').click(function(){
		$('.user_popup').fadeIn('fast');
		$('.pu_tab a').removeClass('on');
		$('.pu_con').removeClass('on');
		$('.pu_tab .uil_02').addClass('on');
		$('.pu_con.con02').addClass('on');
	});
	$('.iw_agree .investor').click(function(){
		$('.user_popup').fadeIn('fast');
		$('.pu_tab a').removeClass('on');
		$('.pu_tab .uil_03').addClass('on');
		$('.pu_con').removeClass('on');
		$('.pu_con.con03').addClass('on');
	});
	//투자수익금액 팝업
	$('.invest_write .btn_sum').click(function(){
		$('.iw_popup').fadeIn('fast');
		$('.iw_popup .iwp_sum').fadeIn('fast');
	});
	$('.iw_popup .iwp_sum .close').click(function(){
		$('.iw_popup').fadeOut('fast');
		$('.iw_popup .iwp_sum').fadeOut('fast');
	});
	//납입금액확인 팝업
	$('.my_condition .btn_check').click(function(){
		$('.iw_popup').fadeIn('fast');
		$('.iw_popup .iwp_sum').fadeIn('fast');
	});
	$('.iw_popup .iwp_sum .close').click(function(){
		$('.iw_popup').fadeOut('fast');
		$('.iw_popup .iwp_sum').fadeOut('fast');
	});
});