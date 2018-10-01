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
