<?
class Location_Control{
// class - Start()

  //---------------------------------------------------------------------
  //  모든 등록 페이지를 정의해준다.
  //---------------------------------------------------------------------
  function Location_Control(){
     


  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function goto($url, $target){
   echo "<script language='javascript'>\n";
   echo "top.location.reload();\n";
   echo "$target.location.href = '$url'\n";
   echo "</script>\n";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function close(){
   echo "<script language='javascript'>\n";
   echo "window.close()\n";
   echo "</script>\n";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function close_top(){
   echo "<script language='javascript'>\n";
   echo "opener.location.reload();\n";
   echo "window.close()\n";
   echo "</script>\n";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function go($url){
   print "<SCRIPT>location.replace('$url');</SCRIPT>";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function msg_go($url,$text){
   print "<SCRIPT>
   window.alert('$text');
   location.replace('$url');
   </SCRIPT>";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function top_go($url){
   print "<SCRIPT>top.location.replace('$url');</SCRIPT>";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function opener_reload(){
   print "<SCRIPT>opener.location.reload();</SCRIPT>";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function top_reload(){
   print "<SCRIPT>top.location.reload();</SCRIPT>";
   return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function msg_close($text){
    echo"<script>
    window.alert('$text');
    window.close();
    </script>";
    return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function msg($text)	{
    echo"<script>
    window.alert('$text');
    </script>";
    return true;
  }

  //---------------------------------------------------------------------
  //  
  //---------------------------------------------------------------------
  function error($text){
    echo"<script>
    window.alert('$text');
    history.go(-1);
    </script>";
    return true;
  }

// class - End()
}

?>