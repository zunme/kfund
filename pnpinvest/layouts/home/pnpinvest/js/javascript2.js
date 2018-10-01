
/*skin1 언론속의 인투윈소프트 2016-11-10 이지은*/
	$(function(){
		var news=$("ul.news").bxSlider({
			mode:"horizontal",
			speed:500,
			pager:true,
			moveSlides:1,
			slideWidth:327,
			minSlides:3,
			maxSlides:3,
			slideMargin:33,
			autoHover:true,
			controls:true
		})
	});


$(function(){
			var investment=$(".product_img").bxSlider({
				mode:"horizontal",
				speed:500,
				pager:false,
				moveSlides:1,
				slideWidth:644,
				minSlides:1,
				maxSlides:1,			
				slideMargin:32,
				autoHover:true,
				controls:true
			})
		});

/*$(function(){
			var investment=$(".thumbnail").bxSlider({
				mode:"horizontal",
				speed:500,
				pager:false,
				moveSlides:1,
				slideWidth:814,
				minSlides:1,
				maxSlides:1,			
				slideMargin:32,
				autoHover:true,
				controls:true,
				 pagerCustom: '#bx-pager'
			})
		});*/


$(function(){
			var investment=$("#bx-pager").bxSlider({
				mode:"horizontal",
				speed:500,
				pager:false,
				moveSlides:1,
				slideWidth:814,
				minSlides:1,
				maxSlides:1,			
				slideMargin:32,
				autoHover:true,
				controls:true,
			})
		});


