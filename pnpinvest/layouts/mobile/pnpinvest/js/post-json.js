$.postJSON = function(url, data, func) {
	//$.post(url+(url.indexOf("?") == -1 ? "?" : "&")+"callback=?", data, func, "json");
	$.post(url, data, func, "json");
}