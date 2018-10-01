$('.toggle').click(function(){
  $(this).toggleClass('open');
  if($(this).hasClass('open')){
    $('.icon').velocity({ 
    	rotateZ: "90deg"
    });

    $('.top')
      .delay(500)
      .velocity({
				x1:0,
				y1:0,
				x2:25,
 				y2: 25
    	});
    $('.mid')
      .delay(500)
      .velocity({
 				x1: 30,
				x2:30

    	});
    $('.bot')
      .delay(500)
      .velocity({
				x1:0,
				y1:25,
				x2:25,
 				y2: 0
    	});
  }
  else {
    $('.icon').delay(500).velocity({ 
    	rotateZ: "0deg"
    });
    $('.top').velocity({
				x1:0,
				y1:3,
				x2:30,
 				y2: 3
    	});
    $('.mid').velocity({
 				x1: 0,
				y1:10,
				x2:20,
				y2:10	
    	});
    $('.bot').velocity({
				x1:0,
				y1:17,
				x2:15,
 				y2: 17
    	});
  }
});

