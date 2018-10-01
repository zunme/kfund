<?
class Auth
{
  // class - Start
  // 생성자.
  function Auth()
  {

  }

  // secret 추가 : 2010-03-04 정수진
  // 게시물 엑세스권한 한단
  function Authcheck($section,$Touser,$U_id,$Writer_id,$secret="")
  {
	  // 공개로 되어있거나 
	  if( $secret!='y' && (!$Touser || $section!="level") ) 
	  {
   		return "ok";
	  }
	  // 비공개일때 자신에게 권한이 있으면 return ok
	  else
	  {
     $tmp	 = explode("/",$Touser);
     if($secret=="y") 
     {
       if( ($U_id!="" && in_array($U_id,$tmp)) || $Writer_id == $U_id || ($U_id!="" && ($U_id == $_SESSION[Com_id])) ){
        return "ok";
       }
     }
     else 
     {
       if( in_array($U_id,$tmp) || $Writer_id == $U_id){
        return "ok";
       }
     }
	  }
  }


// class - End
}
?>