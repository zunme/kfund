// 쿠키 입력
function set_cookie(name, value, expirehours, domain)
{
    var today = new Date();
    today.setTime(today.getTime() + (60*60*1000*expirehours));
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
    if (domain) {
        document.cookie += "domain=" + domain + ";";
    }
}

// 쿠키 얻음
function get_cookie(name)
{
    var find_sw = false;
    var start, end;
    var i = 0;

    for (i=0; i<= document.cookie.length; i++)
    {
        start = i;
        end = start + name.length;

        if(document.cookie.substring(start, end) == name)
        {
            find_sw = true
            break
        }
    }

    if (find_sw == true)
    {
        start = end + 1;
        end = document.cookie.indexOf(";", start);

        if(end < start)
            end = document.cookie.length;

        return document.cookie.substring(start, end);
    }
    return "";
}

// 쿠키 지움
function delete_cookie(name)
{
    var today = new Date();

    today.setTime(today.getTime() - 1);
    var value = get_cookie(name);
    if(value != "")
        document.cookie = name + "=" + value + "; path=/; expires=" + today.toGMTString();
}



if (typeof(ts_layer) == 'undefined') { // 한번만 실행
    var ts_layer = true;

    function selectbox_hidden(layer_id) 
    { 
        var ly = eval(layer_id); 

        // 레이어 좌표 
        var ly_left  = ly.offsetLeft; 
        var ly_top    = ly.offsetTop; 
        var ly_right  = ly.offsetLeft + ly.offsetWidth; 
        var ly_bottom = ly.offsetTop + ly.offsetHeight; 

        // 셀렉트박스의 좌표 
        var el; 

        for (i=0; i<document.forms.length; i++) { 

            for (k=0; k<document.forms[i].length; k++) { 
                el = document.forms[i].elements[k];    
                if (el.type == "select-one") { 
                    var el_left = el_top = 0; 
                    var obj = el; 
                    if (obj.offsetParent) { 
                        while (obj.offsetParent) { 
                            el_left += obj.offsetLeft; 
                            el_top  += obj.offsetTop; 
                            obj = obj.offsetParent; 
                        } 
                    } 
                    el_left  += el.clientLeft; 
                    el_top    += el.clientTop; 
                    el_right  = el_left + el.clientWidth; 
                    el_bottom = el_top + el.clientHeight; 

                    // 좌표를 따져 레이어가 셀렉트 박스를 침범했으면 셀렉트 박스를 hidden 시킴 
                    if ( (el_left >= ly_left && el_top >= ly_top && el_left <= ly_right && el_top <= ly_bottom) || 
                        (el_right >= ly_left && el_right <= ly_right && el_top >= ly_top && el_top <= ly_bottom) || 
                        (el_left >= ly_left && el_bottom >= ly_top && el_right <= ly_right && el_bottom <= ly_bottom) || 
                        (el_left >= ly_left && el_left <= ly_right && el_bottom >= ly_top && el_bottom <= ly_bottom) ) 
                        el.style.visibility = 'hidden'; 
                } 
            } 
        } 
    } 

    // 감추어진 셀렉트 박스를 모두 보이게 함 
    function selectbox_visible() 
    { 
        for (i=0; i<document.forms.length; i++) { 
            for (k=0; k<document.forms[i].length; k++) { 
                el = document.forms[i].elements[k];    
                if (el.type == "select-one" && el.style.visibility == 'hidden') 
                    el.style.visibility = 'visible'; 
            } 
        } 
    }

	// 주어진 엘리먼트으 style 프로퍼티를 얻는다.
	function ts_getStyle(elem, name){

		// 배열 style[]에 프로퍼티가 존재하는가

		if(elem.style[name]){
			return elem.style[name];

		// 아니면 IE의 메서드를 사용하려고 시도한다
		}else if(elem.currentStyle){
			return elem.currentStyle[name];

		// IE용 메서드를 사용할 수 없으면, W3C 메서드를 사용
		}else if(document.defaultView && document.defaultView.getComputedStyle){
			// 메서드 textAlign 대신,  text-align 형태의 문법을 사용한다.
			name = name.replace(/([A-Z])/g,"-$1");
			name = name.toLowerCase();

			// style 객체를 얻은후 , 프로퍼티의 값을 얻는다
			var s = document.defaultView.getComputedStyle(elem,"");
			return s && s.getPropertyValue(name);

		// 그 외의 경우
		}else{
			return null;
		}

	}

	// 엘레먼트의 X(수평선 상의 왼쪽) 좌표를 찾는다.
	function ts_pageX(elem){
		var p = 0;

		// 부모의 오프셋을 더해야 한다.
		while(elem.offsetParent){
			// 현재 부모의 오프셋을 더한다.
			p += elem.offsetLeft;

			// 다음 부모 엘레멘트를 얻은 후, 작업을 계속 진행한다.
		elem = elem.offsetParent;
		}

		return p;
	}

	// 엘리먼트의 Y(수직선 상의 위쪽) 좌표를 찾는다.
	function ts_pageY(elem){
		var p = 0;

		// 부모의 오프셋을 더해야 한다.
		while(elem.offsetParent){
			// 현재 부모의 오프셋을 더한다.
			p += elem.offsetTop;

			// 다음 부모 엘리먼트를 얻은 후, 작업을 계속 진행한다.
		elem = elem.offsetParent;
		}

		return p;
	}

	// 엘리먼트의 X(수평) 위치를 설정하는 함수
	function ts_setX(elem, pos){

		// CSS 프로퍼티 중 'left' 의 값을 설정하고, 값의 단위는 픽셀이다.
		elem.style.left = pos + "px";
	}

	// 엘리먼트의 Y(수직) 위치를 설정하는 함수
	function ts_setY(elem, pos){

		// CSS 프로퍼티 중 'top' 의 값을 설정하고, 값의 단위는 픽셀이다.
		elem.style.top = pos + "px";
	}

	// 엘리먼트의 실제 높이(CSS 값)를 얻는다.
	function ts_getHeight(elem){
		// CSS 값을 숫자로 변환하여 얻는다.
		return parseInt(ts_getStyle(elem, 'height'));
	}

	// 엘리먼트의 실제 너비(CSS 값)를 얻는다.
	function ts_getWidth(elem){
		// CSS 값을 숫자로 변환하여 얻는다.
		return parseInt(ts_getStyle(elem, 'width'));
	}

	// 엘리먼트의 불투명도를 설정
	function ts_setOpacity(elem, level){
		// filtersr가 존재하면, IE이기 때문에 Alpha 필터를 사용
		if(elem.filters){
			elem.filters.alpha.opacity = level;

		// 그 외의 경우는 W3C의 opacity 프로퍼티를 사용
		}else{
			elem.style.opacity = level / 100;
		}
	}

	// 엘리먼트의 페이드인 효과 설정 열기
	function ts_fadeIn(elem,delay){

		// 불투명도는 0에서 시작
		ts_setOpacity(elem, 0);

		setTimeout(function(){

			// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
			for (var i =0; i <= 100; i += 1){
				// i 값을 올바르게 얻을 수 있게 크로저를 만든다
				(function(){
					var pos = i;

					// 주어진 시간에 타임아웃을 발생시킨다.
					setTimeout(function(){
						ts_setOpacity(elem,pos);
					}, (pos + 1) * 10);
				})();
			}

		}, delay);

	}

	// 엘리먼트의 페이드인 효과 설정 닫기
	function ts_fadeInBack(elem){

		// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
		for (var i =0; i <= 100; i += 1){
			// i 값을 올바르게 얻을 수 있게 크로저를 만든다
			(function(){
				var pos = i;

				// 주어진 시간에 타임아웃을 발생시킨다.
				setTimeout(function(){
					ts_setOpacity(elem,100 - pos);
					if(pos == 100)
						elem.style.display = "none";
				}, (pos + 1) * 10);
			})();
		}

	}

	// 엘리먼트의 슬라이드 효과 설정 열기
	function ts_slideLeftDown(elem,delay){
		// 엘리먼트의 최대 높이를 구한다.
		var h = ts_getHeight(elem);
		var w = ts_getWidth(elem);

		// 0 픽셀부터 슬라이드 다운을 시작한다.
		elem.style.height = "0px";
		elem.style.width = "0px";

		setTimeout(function(){

			// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
			for (var i =0; i <= 100; i += 1){
				// i 값을 올바르게 얻을 수 있게 크로저를 만든다
				(function(){
					var pos = i;

					// 주어진 시간에 타임아웃을 발생시킨다.
					setTimeout(function(){
						elem.style.height = ((pos / 100) * h) + "px";
					}, (pos + 1) * 20);

					// 주어진 시간에 타임아웃을 발생시킨다.
					setTimeout(function(){
						elem.style.width = ((pos / 100) * w) + "px";
					}, (pos + 1) * 20);

				})();
			}

		}, delay);

	}

	// 엘리먼트의 슬라이드 효과 설정 닫기
	function ts_slideLeftDownBack(elem){
		// 엘리먼트의 최대 높이를 구한다.
		var h = ts_getHeight(elem);
		var w = ts_getWidth(elem);

		// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
		for (var i =0; i <= 100; i += 1){
			// i 값을 올바르게 얻을 수 있게 크로저를 만든다
			(function(){
				var pos = i;

				// 주어진 시간에 타임아웃을 발생시킨다.
				setTimeout(function(){
					elem.style.height = h - ((pos / 100) * h) + "px";
				}, (pos + 1) * 20);

				// 주어진 시간에 타임아웃을 발생시킨다.
				setTimeout(function(){
					elem.style.width = w - ((pos / 100) * w) + "px";
				}, (pos + 1) * 20);

			})();
		}

	}

	// 엘리먼트의 슬라이드 효과 설정 열기
	function ts_slideLeft(elem,delay){
		// 엘리먼트의 최대 높이를 구한다.
		var w = ts_getWidth(elem);

		// 0 픽셀부터 슬라이드 다운을 시작한다.
		elem.style.width = "0px";

		setTimeout(function(){

			// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
			for (var i =0; i <= 100; i += 1){
				// i 값을 올바르게 얻을 수 있게 크로저를 만든다
				(function(){
					var pos = i;

					// 주어진 시간에 타임아웃을 발생시킨다.
					setTimeout(function(){
						elem.style.width = ((pos / 100) * w) + "px";
					}, (pos + 1) * 20);

				})();
			}

		}, delay);

	}

	// 엘리먼트의 슬라이드 효과 설정 닫기
	function ts_slideLeftBack(elem){
		// 엘리먼트의 최대 높이를 구한다.
		var w = ts_getWidth(elem);

		// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
		for (var i =0; i <= 100; i += 1){
			// i 값을 올바르게 얻을 수 있게 크로저를 만든다
			(function(){
				var pos = i;

				// 주어진 시간에 타임아웃을 발생시킨다.
				setTimeout(function(){
					elem.style.width = w - ((pos / 100) * w) + "px";
					if(pos == 100)
						elem.style.display = "none";
				}, (pos + 1) * 20);

			})();
		}

	}


	// 엘리먼트의 슬라이드 효과 설정 열기
	function ts_slideDown(elem,delay){
		// 엘리먼트의 최대 높이를 구한다.
		var h = ts_getHeight(elem);

		// 0 픽셀부터 슬라이드 다운을 시작한다.
		elem.style.height = "0px";
		elem.style.display = "none";

		setTimeout(function(){

			// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
			for (var i =0; i <= 100; i += 1){
				// i 값을 올바르게 얻을 수 있게 크로저를 만든다
				(function(){
					var pos = i;
				// 익스플로러 height 버그 때문에 추가
				if(i == 0)
					elem.style.display = "block";


					// 주어진 시간에 타임아웃을 발생시킨다.
					setTimeout(function(){
						elem.style.height = ((pos / 100) * h) + "px";
					}, (pos + 1) * 20);

				})();
			}

		}, delay);

	}

	// 엘리먼트의 슬라이드 효과 설정 닫기
	function ts_slideDownBack(elem){
		// 엘리먼트의 최대 높이를 구한다.
		var h = ts_getHeight(elem);

		// 매 초마다 화면이 바뀌는 20 프레임짜리 에니메이션
		for (var i =0; i <= 100; i += 1){
			// i 값을 올바르게 얻을 수 있게 크로저를 만든다
			(function(){
				var pos = i;

				// 주어진 시간에 타임아웃을 발생시킨다.
				setTimeout(function(){
					elem.style.height = h - ((pos / 100) * h) + "px";
					if(pos == 100)
						elem.style.display = "none";
				}, (pos + 1) * 20);

			})();
		}

	}

	// 엘리먼트의 깜빡이는 효과 설정
	function ts_flickeringly(elem,delay){

		// 엘레먼트를 감춘다
		elem.style.display = "none";

		// delay 시간마다 실행한다
		act_tmp = setInterval(function(){

			// 마우스가 올라오면 멈춘다
			elem.onmouseover = function(){
				elem.style.display = "";
				clearInterval(act_tmp);
			}

			// 현재 엘레먼트가 감춤인지 숨킴인지 체크후 반전한다
			if(elem.style.display == "none"){
				elem.style.display = "";
			}else{
				elem.style.display = "none";
			}

		}, delay);

	}

	function layer_close(id,hiddenWay) {		
		var obj = document.getElementById("expirehours"+ id);
		var tmpid = document.getElementById("pop" + id);
		if (obj.checked == true) {
			set_cookie("it_ck_pop_"+id, "done", obj.value, window.location.host); 
		}
		if(hiddenWay == "ts_slideDownBack"){
			ts_slideDownBack(tmpid);
		}else if(hiddenWay == "ts_slideLeftBack"){
			ts_slideLeftBack(tmpid);
		}else if(hiddenWay == "ts_slideLeftDownBack"){
			ts_slideLeftDownBack(tmpid);
		}else if(hiddenWay == "ts_fadeInBack"){
			ts_fadeInBack(tmpid);
		}else{
			tmpid.style.display = "none";
		}
		selectbox_visible();
	}

}

