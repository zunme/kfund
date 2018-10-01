<?
class Html
{
// class - Start()


  // html 헤드 출력
  function Print_head($jsurl,$cssurl){
	return "
	<HEAD>
	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=euc-kr\">
	<link href=\"$cssurl\" rel=\"stylesheet\" type=\"text/css\">
	<script language=JavaScript src=\"$jsurl\"></script>
	</HEAD>";
  }

// html 헤드 출력
function Print_js($jsurl){
  return "<script language=JavaScript src=\"$jsurl\"></script>";
}



  // html 꼬리 출력
  function Print_tail(){echo "</BODY></HTML>";}

// class - End()
}
?>