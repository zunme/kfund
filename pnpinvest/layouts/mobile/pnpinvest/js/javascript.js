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


/**/
		$(function(){
			var strength=$(".strength ul").bxSlider({
				mode:"fade",
				speed:500,
				pager:true,
				moveSlides:1,
				minSlides:4,
				maxSlides:4,
				slideMargin:10,
				autoHover:true,
				controls:false
			})
		});

		$(function(){

			var media_center=$(".media_center ul").bxSlider({
				mode:"fade",
				speed:500,
				pager:true,
				moveSlides:1,
				minSlides:4,
				maxSlides:4,
				slideMargin:10,
				autoHover:true,
				controls:false
			})
		});

		if (document.location.search.match(/type=embed/gi)) {
		  window.parent.postMessage('resize', "*");
	}

		$(function () {
		$(window).load(function () {
			$('.loadingWrap').fadeOut();
		});
	});

	jQuery(document).ready(function() {
	    var offset = 220;
	    var duration = 700;	    
	    jQuery('.go-to-bottom').click(function(event) {
		event.preventDefault();
		jQuery('html, body').animate({scrollTop: 785}, duration);
		return false;
	    })
	});


	$(function(){		
		$('.item-has-children').children('a').on('click', function(event){
			event.preventDefault();
					$(this).toggleClass('hover_bg').next('.sub-menu').slideToggle(200).end().parent('.item-has-children').siblings('.item-has-children').children('a').removeClass('hover_bg').next('.sub-menu').slideUp(200);

		});
	})

