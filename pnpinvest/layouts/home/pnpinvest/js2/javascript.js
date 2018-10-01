
/*날짜 선택*/
$(function() {
    $( "#testDatepicker1" ).datepicker({
		showOn: "both",
		buttonImage: "http://esmfintech.investsolution.co.kr/mgmgroup/layouts/admin/basic/img2/button.png", 
        buttonImageOnly: true,
        nextText: '다음 달',
        prevText: '이전 달',
		dateFormat: "yy-mm-dd",
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']	
    });
});

$(function() {
    $( "#testDatepicker2" ).datepicker({
		showOn: "both",
		buttonImage: "http://esmfintech.investsolution.co.kr/mgmgroup/layouts/admin/basic/img2/button.png", 
        buttonImageOnly: true,
        nextText: '다음 달',
        prevText: '이전 달',
		dateFormat: "yy-mm-dd",
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']		
    });
});

$(function() {
    $( "#testDatepicker3" ).datepicker({
		showOn: "both",
		buttonImage: "http://esmfintech.investsolution.co.kr/mgmgroup/layouts/admin/basic/img2/button.png", 
        buttonImageOnly: true,
        nextText: '다음 달',
        prevText: '이전 달',
		dateFormat: "yy-mm-dd",
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']		
    });
});

$(function() {
    $( "#testDatepicker4" ).datepicker({
		showOn: "both",
		buttonImage: "http://esmfintech.investsolution.co.kr/mgmgroup/layouts/admin/basic/img2/button.png", 
        buttonImageOnly: true,
        nextText: '다음 달',
        prevText: '이전 달',
		dateFormat: "yy-mm-dd",
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']		
    });
});


$(document).ready(function() {
    $(".loan_graph ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph_wrap2").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});


$(document).ready(function() {
    $(".invest_graph ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph_wrap").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});


$(document).ready(function() {
    $(".tab_wrap1 ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph1").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});

$(document).ready(function() {
    $(".tab_wrap2 ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph2").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});

$(document).ready(function() {
    $(".tab_wrap3 ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph3").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});

$(document).ready(function() {
    $(".tab_wrap4 ul li a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".graph4").not(tab).css("display", "none");

        $(tab).fadeIn();
    });
});

	
	jQuery(document).ready(function() {
	    var offset = 220;
	    var duration = 1000;	    
	    jQuery('.go-top').click(function(event) {
		event.preventDefault();
		jQuery('html, body').animate({scrollTop: 0}, duration);
		return false;
	    })
	});





$(function(){
		var obj = $('.member_info');
		$('.member_info_on').hide();
		obj.mouseenter(function(){				

		$(this).find('.member_info_on').slideDown(400);
		})
		obj.mouseleave(function(){
			$(this).find('.member_info_on').slideUp(400);
		})
	})

	

	$(function(){
			var obj = $('.lnb_mn li');
			$('.lnb_mn_down').hide();
			obj.click(function(){				
	
			$(this).find('.lnb_mn_down').stop().slideToggle(400);
			//$(this).find('.lnb_mn_down').css('display','block')
			})

		})






