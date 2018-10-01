/**
 * hamburger.js
 *
 * Mobile Menu Hamburger
 * =====================
 * A hamburger menu for mobile websites
 *
 * Created by Thomas Zinnbauer YMC AG  |  http://www.ymc.ch
 * Date: 21.05.13
 */

	$(function(){	
		$('.toggle').toggle(
	function(){
		$('.nav').css('opacity','1');
		$('.pop_1').css({'opacity':'0.5','width':'100%','height':'100%','background':'#000','z-index':'1','position':'absolute','display':'block',})
		//$('.wrap').stop().animate({marginLeft:240+'px'},300);

		$('#sidebar').stop().animate({marginLeft:80+'%'},300);
		$('#sidebar-toggle').stop().animate({marginLeft:80+'%'},300);
		$("body").addClass("open-sidebar2");
		$("html").addClass("open-sidebar2");
		$('#sidebar').addClass("open-sidebar2");

	},function(){
		$('#sidebar-toggle').stop().animate({marginLeft:0+'px'},300);
		$('#sidebar').stop().animate({marginLeft:0+'px'},300);
		$('.pop_1').css('display','none')
		//$('.wrap').stop().animate({marginLeft:0+'px'},300);
		$('.nav').css('opacity','0');
		$("body").removeClass("open-sidebar2");
		$("html").removeClass("open-sidebar2");
		$('#sidebar').removeClass("open-sidebar2");
	});
	})
