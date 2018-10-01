<?
class Board_query{
// class - Start()

var $DataBase;

//---------------------------------
//            생성자
//---------------------------------
function Board_query($DataBase){
  $this->DataBase = $DataBase;
}

//--------------------------------------------------------------------------------------------
// select 필드에 옵션별로 붙는 필드를 문자열로 리턴
//--------------------------------------------------------------------------------------------
function Make_select_tails($section){

  switch($section){
    case "level" :  return ", a.Touser "; break;
    case "file" : return ", a.Filename "; break;
    case "normal"	: return "";  break;
    case "good"	: return ", a.G_code"; break;
    case "turm" : return ", a.Start_time,  a.End_time,  a.Charger,  a.Collaborator "; break;
    case "gongji" : return ", a.PopYN, a.G_width, a.G_height, a.P_top, a.P_left"; break;
  }

// function - End
}

//------------------------------------------------------------------------------------
//  게시판 형태에 따라서 쿼리 필드를 바꿔준다.
//------------------------------------------------------------------------------------
function Make_list_field($section,$table_name,$limit,$Field,$Key,$UID='',$code=""){

  // 옵션별로 차이나는 필드들을 구할 수 있게 쿼리문을 만들어준다.
  $Fields_last	=	$this->Make_select_tails($section);
  $com_table = $table_name."_c";

  // 상품후기 리스트
  if($table_name=="Board_goods_after") {
    // 검색어가 없을때
    if(!$Key){
      return sprintf("SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.G_sati, b.Goods_name, c.File_name, b.Sale_cost, d.Made_by ,a.G_code ,a.best_ok %s
      FROM
      $this->DataBase.%s as a
      LEFT JOIN $this->DataBase.Goods_Basic as b ON(a.G_code=b.Goods_no)
      LEFT JOIN $this->DataBase.Goods_img as c ON(a.G_code=c.Goods_no)
      LEFT JOIN $this->DataBase.Goods_Extra as d ON(a.G_code=d.Goods_no)
      WHERE c.Size = 2
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc,a.B_no desc  LIMIT $limit",
      $Fields_last,$table_name);
    }
    // 검색어가 있을때
    else{
      return "SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.G_sati, b.Goods_name, c.File_name, b.Sale_cost, d.Made_by , a.G_code ,a.best_ok $Fields_last
      FROM
      $this->DataBase.$table_name as a
      LEFT JOIN $this->DataBase.Goods_Basic as b ON(a.G_code=b.Goods_no)
      LEFT JOIN $this->DataBase.Goods_img as c ON(a.G_code=c.Goods_no)
      LEFT JOIN $this->DataBase.Goods_Extra as d ON(a.G_code=d.Goods_no)
      WHERE c.Size = 2 and $Field like '%$Key%'
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc LIMIT $limit";
    }
  }
  // 상품리뷰 리스트 추가 : 2009-06-10 정수진
  // 퍼밋전 일단 요청업체만 적용함. 추후 전체퍼밋시 업체코드 제거해야함. DB에도 best_ok추가해야함.
  elseif($table_name=="Board_review" && ($this->CP_CODE=='mtc' || $this->CP_CODE=='thecraze')) {
    // 검색어가 없을때
    if(!$Key){
      $UID = $UID == "" ? "":" where ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return sprintf("SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.best_ok %s
      FROM
      $this->DataBase.%s as a
      $UID
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc,a.B_no desc  LIMIT $limit",
      $Fields_last,$table_name);
    }
    // 검색어가 있을때
    else{
      $UID = $UID == "" ? "":" and ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return "SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.best_ok $Fields_last
      FROM
      $this->DataBase.$table_name as a
      WHERE
      $Field like '%$Key%' $UID
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc LIMIT $limit";
    }
  }
  // 상품문의 리스트
  elseif($table_name=="Board_goods_qna") {
    // 검색어가 없을때
		$code = $code == "" ? "" :" and G_code = '".$code."' ";
    if(!$Key){
      $UID = $UID == "" ? "":" and ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return sprintf("SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.G_sati, b.Goods_name, c.File_name, b.Sale_cost, d.Made_by, a.G_code  %s
      FROM
      $this->DataBase.%s as a
      LEFT JOIN $this->DataBase.Goods_Basic as b ON(a.G_code=b.Goods_no)
      LEFT JOIN $this->DataBase.Goods_img as c ON(a.G_code=c.Goods_no)
      LEFT JOIN $this->DataBase.Goods_Extra as d ON(a.G_code=d.Goods_no)
      WHERE c.Size = 2  $UID $code
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc,a.B_no desc  LIMIT $limit",
      $Fields_last,$table_name);
    }
    // 검색어가 있을때
    else{
      $UID = $UID == "" ? "":" and ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return "SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top, a.G_sati, b.Goods_name, c.File_name, b.Sale_cost, d.Made_by, a.G_code $Fields_last
      FROM
      $this->DataBase.$table_name as a
      LEFT JOIN $this->DataBase.Goods_Basic as b ON(a.G_code=b.Goods_no)
      LEFT JOIN $this->DataBase.Goods_img as c ON(a.G_code=c.Goods_no)
      LEFT JOIN $this->DataBase.Goods_Extra as d ON(a.G_code=d.Goods_no)

      WHERE c.Size = 2 and $Field like '%$Key%' $UID $code
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc LIMIT $limit";
    }
  }
  // 상품후기 리스트
  elseif($table_name=="Board_goods_review") {
		return sprintf("
			SELECT * , (select a.File_name from $this->DataBase.Goods_img as a where a.Goods_no=goods_code and a.Size=2 limit 1 ) as file_name
			FROM $this->DataBase.%s ORDER BY `number` desc, `regi_date` desc LIMIT %s
		", $table_name,$limit);
  }
  else {

    // 비밀글 추가 : 2010-03-04 정수진
    if($this->CP_CODE=='dochiqueen' && ereg("Board_[0-9]+",$table_name)) { $Secret_yn = ", a.Secret, a.Touser "; }
    else {$Secret_yn = "";}

    // 검색어가 없을때
    if(!$Key){
      $UID = $UID == "" ? "":" where ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return sprintf("SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top $Secret_yn $gongji_filed %s
      FROM
      $this->DataBase.%s as a
      $UID
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc,a.B_no desc  LIMIT $limit",
      $Fields_last,$table_name);
    }
    // 검색어가 있을때
    else{
      $UID = $UID == "" ? "":" and ( Writer_id = '".$UID."' or Touser = '".$UID."' )";
      return "SELECT
      (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top $Secret_yn $gongji_filed $Fields_last
      FROM
      $this->DataBase.$table_name as a
      WHERE
      $Field like '%$Key%' $UID
      ORDER BY
      a.Top desc ,a.Fid desc ,a.Thread asc LIMIT $limit";
    }
  }

// function - End
}

//------------------------------------------
// 페이징을 위한 쿼리문
//------------------------------------------
function Get_pagecount($table_name,$Field,$Key,$UID){
	if($table_name=='Board_goods_review') {
		$query = "SELECT count(number) as total FROM $this->DataBase.$table_name";
	}
	else {
		$UID1 = $UID == "" ? "":" where (Writer_id = '".$UID."' or Touser = '".$UID."')";
		$UID2 = $UID == "" ? "":" and (Writer_id = '".$UID."' or Touser = '".$UID."')";
		if(!$Key){$query = "SELECT count(B_no) as total FROM $this->DataBase.$table_name".$UID1;}
		else{$query = "SELECT count(B_no) as total FROM $this->DataBase.$table_name WHERE $Field like '%$Key%'".$UID2;}		
	}
  return $query;
}


//------------------------------------------
// 페이징을 위한 쿼리문 2011-06-01 상품코드 추가 우형기
//------------------------------------------
function Get_pagecount2($table_name,$Field,$Key,$UID,$code){
  $UID1 = $UID == "" ? "":" where (Writer_id = '".$UID."' or Touser = '".$UID."')";
  $UID2 = $UID == "" ? "":" and (Writer_id = '".$UID."' or Touser = '".$UID."')";
	if($UID1 != "") {
		$code = $code == "" ? "" : " and G_code = '".$code."' ";
	} else{
		$code = $code == "" ? "" : " WHERE G_code = '".$code."' ";
	}
  if(!$Key){$query = "SELECT count(B_no) as total FROM $this->DataBase.$table_name".$UID1.$code;}
  else{$query = "SELECT count(B_no) as total FROM $this->DataBase.$table_name WHERE $Field like '%$Key%'".$UID2.$code;}

  return $query;
}


//-----------------------------------------------------------------
//                      아래부터 select 쿼리
//-----------------------------------------------------------------

//------------------------
// 리스트 쿼리
//------------------------
function Select_list($query,$mysql){

	$data	= $mysql -> fetch($query);
  $rows	= $mysql -> rownum;
  return array($data,$rows);

// function - End
}

//------------------------------------------
// 파일 다운로드 링크
//------------------------------------------
function Query_filelink($fstring,$Writer_id,$self_page,$baction_file){

  // a링크들이 저장될 배열
  $alink	=	array();
  $fsize	=	array();
  $tmp		=	explode("/",$fstring);
  $Img_Domain = Img_Domain;

  for($i=0; $i < count($tmp); $i++){

    if($tmp[$i] == "") continue;

    $sub_tmp	=	explode("|",$tmp[$i]);

      switch($baction_file) {

        //  링크 형식
        case "link" :
          $url = $Img_Domain."/".$this->CP_CODE."/Board";
          $alink["filename"][]	= "<A HREF=\"board_download.php?as=BoardMan&action=Board&baction=download&filesize=".$sub_tmp[1]."&url=$url&dnfilename=".$sub_tmp[0]."\"><U>".$sub_tmp[0]."</U></A>";
        break;

        //  그냥 이미지객체 배열로 리턴
        case "file" : $alink["filename"][]	= $sub_tmp[0]; break;

        //  그냥 이미지객체 배열로 리턴
        case "none" : $alink["filename"][]	= $sub_tmp[0]; break;

        //  이미지 출력 형태로 리턴
        case "img" :

          $url = $Img_Domain."/".$this->CP_CODE."/Board";
          $filesize = @getimagesize(RootBase.ImageBase."/".$this->CP_CODE."/Board/".$sub_tmp[0]);
          if($filesize[0] > 700) { $img_with = " width='700' "; }
          else { $img_with = "";}
          $alink['filename'][] = sprintf("<img src='%s/%s' %s alt='%s'>",$url,urlencode($sub_tmp[0]),$img_with,$sub_tmp[0]);
        break;

      // switch - End
      }
    $alink["size"][]	=	$sub_tmp[1];

  // loop - End
  }

  // 파일 수정부분일때 원래 파일 문자열을 리턴해준다.
  if($baction_file=="file"){$alink["origin"][0]=$fstring;}
  return $alink;

// function - End
}

//-------------------------------------
// 첨부파일 목록 쿼리
//-------------------------------------
function Query_reply_files($mysql,$Thread,$table_name,$Fid,$B_no){

  //  상품 연동 게시판 일경우
  if($table_name!='Board_review' && $table_name!= 'Board_goods_qna' && $table_name!='Board_goods_after') { $FileField = "Filename"; }
  else { $FileField = "G_code as Filename"; }

  // 원글일 경우 해당 Fid의 모든 첨부파일명을 쿼리
  if($Thread=="A"){
    $query	=	"SELECT $FileField FROM $this->DataBase.$table_name WHERE Fid='$Fid' ";
    $mysql->reset_rownum();
    $data	=	$mysql->fetch_key($query);
  }
  // 답글일 경우 해당 글의 첨부파일만 쿼리
  else{
    $query	=	"SELECT $FileField FROM $this->DataBase.$table_name WHERE B_no='$B_no' ";
    $mysql->reset_rownum();
    $data	=	$mysql->fetch_key($query);
  }
  return $data;

// function - End
}

//-------------------------
//  뷰 쿼리
//------------------------
function Select_view($mysql,$B_no,$table_name,$section,$self_pager,$U_id,$baction_file){

  $inst_auth	=	new Auth();

  // 옵션별로 차이나는 필드들을 구할 수 있게 쿼리문을 만들어준다.
  $Fields_last	=	$this->Make_select_tails($section);

  if($section == "good") {

    // 리뷰 게시판 쿼리
    if($table_name == "Board_review") {
      $query	=	sprintf("SELECT a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Tag, a.Top, a.G_sati, a.Writer_id %s
      FROM $this->DataBase.%s as a WHERE a.B_no='$B_no'",$Fields_last,$table_name);
    }
    // 상품문의, 후기 쿼리
    else {
      $query	=	sprintf("SELECT a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Tag, a.Top, a.G_sati, a.email, b.Goods_name, d.Made_by, b.Sale_cost ,b.Goods_no , c.File_name %s
      FROM $this->DataBase.%s as a
       LEFT JOIN $this->DataBase.Goods_Basic as b ON(a.G_code=b.Goods_no)
       LEFT JOIN $this->DataBase.Goods_img as c ON(a.G_code=c.Goods_no)
       LEFT JOIN $this->DataBase.Goods_Extra as d ON(a.G_code=d.Goods_no)

      WHERE a.B_no='$B_no' and c.Size = 1 ",$Fields_last,$table_name);
    }
  }
  else {
    $query	=	sprintf("SELECT a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Tag, a.Writer_id %s
    FROM $this->DataBase.%s as a WHERE a.B_no='$B_no' ",$Fields_last,$table_name);
  }

  $data	=	$mysql->fetch_key($query);

  //  리뷰 게시판일경우 / 원래 파일 필드를 G_CODE라는놈으로 대체해놓은 나쁜놈때문에
  //  배열을 한번 복사해준다. 2009-01-13 : 박준형
  if($table_name=='Board_review') { $data[filename][0] = $data[g_code][0]; }

  // 해당게시물의 엑세스권한 판단
  $auth = $inst_auth->Authcheck($section,$data["touser"][0],$U_id,$data["writer_id"][0]);
  if($auth!="ok"){echo "게시물 열람 권한이 없습니다.";$mysql->close();exit;}

  // 첨부파일 게시판일 경우 첨부파일명에 링크를 걸어주는놈 ( link 일경우 링크를 배열로 리턴 , file 일경우 파일명을 배열로 리턴)
  $options_array	 =	$this->Query_filelink($data["filename"][0],$data["writer_id"][0],$self_page,$baction_file);

  // 파일명 문자열을 파일 사이즈와 파일명으로 분리된 배열형태로 바꿔서 그대로 넣어준다.
  // 일종의 배열내용 바꿔치기
  // 기존의 $data["Filename"]은 그냥 배열이였지만
  // 다시 덮어 씌워지는놈은 배열의 배열이다.
  $data["filename"]	=	$options_array;
  return $data;

// function - End
}


//----------------------------------
//  서브 리스트 쿼리
//----------------------------------
function Select_sublist($mysql,$fid,$section,$table_name){

  // 옵션별로 차이나는 필드들을 구할 수 있게 쿼리문을 만들어준다.
  $Fields_last	=	$this->Make_select_tails($section);
  $com_table = $table_name."_c";
  $query = sprintf("SELECT
  (select count(C_no) from $this->DataBase.$com_table where B_no=a.B_no) as c_count ,a.B_no, a.Title, a.Writer_id, a.Writer_name, a.Regi_date, a.Ref, a.Contents, a.Fid, a.Thread, a.Top %s FROM $this->DataBase.%s as a WHERE a.Fid='$fid' ORDER BY a.Top desc ,a.Fid desc ,a.Thread asc,a.B_no desc",$Fields_last,$table_name);

  $data	= $mysql -> fetch($query);
  $rows	= $mysql -> rownum;

  return array($data,$rows);
// function - End
}


//-------------------------------------
// 코맨트 데이터 쿼리
//-------------------------------------
function Select_comm($mysql,$B_no,$table_name){

  $query	=	sprintf("SELECT * FROM $this->DataBase.%s WHERE B_no='%s' ORDER BY C_no asc ",$table_name."_c",$B_no);
  $mysql->reset_rownum();

  return $mysql->fetch($query);

}

//--------------------------------------
// 이전글 , 다음글 찾기
//--------------------------------------
function Find_nprecord($mysql,$No,$table_name,$Top){
// mysql 4.1 이상 버전으로 되면 쿼리및 function을 메인에서 같이 바꿔준다.

  // 공지 글이 아닐경우
  if($Top!="o"){$Where_last	 =	" AND Top!='o' ";}
  // 공지글
  else{$Where_last	 =	" AND Top='o' ";}

  // 이전글
  $query		=	"SELECT min(B_no) as No FROM $this->DataBase.$table_name WHERE B_No > $No AND length(Thread) <= 1 $Where_last";
  $data_P	=	$mysql->fetch_key($query);

  // 다음글
  $query		=	"SELECT max(B_no) as No FROM $this->DataBase.$table_name WHERE B_No < $No AND length(Thread) <= 1 $Where_last";
  $data_N	=	$mysql->fetch_key($query);
  return array($data_P["no"][0],$data_N["no"][0]);

// function - End
}


//--------------------------------------------------------------------------------------------
//                              insert , update  쿼리
//--------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------
// 첨부 파일명 문자열로 만들어주는놈
//--------------------------------------------------------------------------------------------
function Filetostring($Filearray){

  // 첨부파일 갯수
  $count	=	count($Filearray["filename"]);
  $file_name	=	"";
  for($i = 0; $i < $count; $i++){
    // 마지막에 / 빼기 위해서
    if($i == $count-1){$file_name	=	$file_name.$Filearray["filename"][$i]."|".$Filearray["size"][$i];}
    else{$file_name	=	$file_name.$Filearray["filename"][$i]."|".$Filearray["size"][$i]."/";}

  // loop - End
  }
  return $file_name;

// function - End
}

//--------------------------------------------------
// 답변 스레드 만들어서 리턴
//--------------------------------------------------
function Make_thread($Fid,$Thread,$mysql,$table_name){

  $query="
  SELECT right(Thread,1) as Thread
  FROM $this->DataBase.$table_name
  WHERE Fid=$Fid and length(Thread) = length('$Thread')+1  and locate('$Thread',Thread)=1
  ORDER BY Thread desc limit 1";

  $data	=	$mysql->fetch_key($query);
  if($mysql->rownum > 0){
    $thread_foot = ++$data["thread"][0];
    $new_thread=$Thread . $thread_foot;
  }
  else{
    $new_thread=$Thread."A";
  }

  return $new_thread;

// function - End
}

//---------------------------------------
//  게시물 등록 switch
//---------------------------------------
function Insert_record($inst_query,$inst_output,$inst_location,$_POST,$mysql,$section,$table_name,$Filearray){

  $Uname_temp = explode("[",$_SESSION[UNAME]);
  $Title = $_POST["Title"];
  $Contents = $_POST["Contents"];
  $Top = $_POST["Top"];
  $Tag = $_POST["Tag"];
  $U_id = $_POST["U_id"];
  $U_name =	$_POST["U_name"] !="" ? $_POST[U_name] : $Uname_temp[0];
  $Touser	=	$_POST["addstring"];
  $Thread	=	$_POST["Thread"];
  $Fid = $_POST["Fid"];
  $as = $_POST["as"];

  $Secret = $_POST["secret"]; // 비밀글 사용시 y로 넘어옴 : 2010-03-04 정수진

  if($_POST["Start_time"]!=""){
  $Start_time = $_POST["Start_time"];}
  else{ $Start_time = "2000-01-01 00:00:00";}

  if($_POST["End_time"]!=""){
  $End_time = $_POST["End_time"];}
  else{ $End_time = "2000-01-01 00:00:00";}

  $dura = intval($_POST["dura"]);
  $Collaborator = $_POST["Collaborator"];
  $Charger = $_POST["charger"];

  $G_code = $_POST[GoodsCode];
  $G_sati = $_POST[sati];

  // 어드민에서 접근한 경우
  if($_POST['as'] != "") {
    $U_name = "관리자";
    $admin = "Y";
    $U_id = "_ADMIN_";
  }

  $PopYN = $_POST["popup"];

  $G_width = $_POST["G_width"];
  $G_height = $_POST["G_height"];

  $P_top = $_POST["P_top"];
  $P_left = $_POST["P_left"];

  $Touser = $_POST['as'] == "" ? $U_id:$_POST[writer];
  $Filename	=	"";

  //-----------------------------------------------------------
  // ※ 파일 첨부가 되었을 때만.
  // 첨부파일들의 배열을 받아서 문자열로 저장
  if($Filearray!="nofile"){$Filename	=	$this->Filetostring($Filearray);}
  //-----------------------------------------------------------

  // 상품리뷰 게시판은 상품코드에 이미지 넣음
  $G_code = $table_name == "Board_review" ? $Filename:$G_code;

  // 스래드가 없거나 패밀리 아이디가 없으면 답글이 아니고 단순 글쓰기 => 스래드는 A가된다.
  if(!$Thread || !$Fid){
    $Thread	=	"A";
  }
  else{
    $Thread	=	$this->Make_thread($Fid,$Thread,$mysql,$table_name);
  }

  // 패밀리 아이디가 없을 경우
  if(!$Fid){
    //--------------------------------------------------------------
    // ※ mysql 4.1 이상 버전으로 바뀌면 서브쿼리로 작성
    $query	=	"SELECT max(`Fid`)+1 as Fid FROM $this->DataBase.$table_name WHERE 1";
    $data	=	$mysql->fetch_key($query);
    $Fid	=	$data["fid"][0];
    if(!$Fid){$Fid="1";} // 첫글일때 Fid가 없으면 1로 설정
    //--------------------------------------------------------------
  }

  switch($section){
    case "file" :
      $query	=	"INSERT INTO
      $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag`,`Filename` )
      VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag','$Filename');";
    break;

    case "normal" :
      // 비밀글 사용 추가 : 2010-03-04 정수진
      if($Secret=='y') {
        $query	=	"INSERT INTO
        $this->DataBase.`$table_name` (`B_no`, `Title`, `Writer_id`, `Writer_name`, `Regi_date`, `Ref`, `Contents`, `Fid`, `Thread`, `Top`, `Tag`, `Touser`, `Secret` )
        VALUES (NULL, '$Title', '$U_id', '$U_name', NOW( ), '0', '$Contents', '$Fid', '$Thread', '$Top', '$Tag', '$Touser', '$Secret');";
      }
      // 일반적인 경우
      else {
        $query	=	"INSERT INTO
        $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag`, `Touser` )
        VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag','$Touser');";
      }
    break;

    case "good" :
      $query	=	"INSERT INTO
      $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag` ,`G_code` ,`G_sati`, `Touser` )
      VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag', '$G_code','$G_sati','$Touser');";
    break;

    case "gongji" :
      $query	=	"INSERT INTO
      $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag`, `Touser`, `PopYN`, `G_width`, `G_height`, `P_top`, `P_left` )
      VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag','$Touser','$PopYN','$G_width','$G_height','$P_top','$P_left');";
    break;

    case "level" :
      $query	=	"INSERT INTO
      $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag` ,`Touser`)
      VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag','$Touser');";
    break;

    case "turm" :
      $query	=	"INSERT INTO
      $this->DataBase.`$table_name` (`B_no` ,`Title` ,`Writer_id` ,`Writer_name` ,`Regi_date` ,`Ref` ,`Contents` ,`Fid` ,`Thread` ,`Top` ,`Tag` ,`Start_time`,`End_time`,`Charger`,`Collaborator`)
      VALUES (NULL , '$Title', '$U_id', '$U_name', NOW( ) , '0', '$Contents', '$Fid', '$Thread', '$Top','$Tag','$Start_time','$End_time','$Charger','$Collaborator');";
    break;

  // switch - End
  }

  $mysql->execute($query);

  // 공지사항 파일에 쓰기
  // DB로 전환 : 2011-03-02 정수진
  //if($_POST[table_name] == "Board_gongji") {
  //  $this->inst_SelectDisplay->PopUpGongJi(&$this->inst_FileIO,'');
  //}

  $action = $_POST[action] == "" ? "Board":$_POST[action];
  // action ==> list

  // 상품문의 등록시에는 마이페이지로
  if($_POST[table_name] == "Board_goods_qna" && $admin != "Y") {
    $inst_location->go($inst_output->self_page."?action=MyBoard&section=good&table_name=Board_goods_qna&baction=list&path=mypage");
  }
  // 일반게시판
  else {
    $inst_location->go($inst_output->self_page."?action=$action&baction=list&table_name=$table_name&section=$section&as=$as&path=".$_POST[path]);
  }


// function - End
}

//------------------------------------
// 게시물 수정 switch
//------------------------------------
function Update_record($POST,$mysql){

  $section = $POST["section"];
  $table_name = $POST["table_name"];
  $B_no	 = $POST["No"];
  $U_id	 = $POST["U_id"];
  $U_level = $POST["U_level"];
  $U_name = $POST["U_name"];
  $Writer_name = $POST["Writer_name"];
  $addstring	 = $POST["addstring"];
  $Charger	 = $POST["charger"];
  $Collaborator	 = $POST["Collaborator"];
  $Start_time	 = $POST["Start_time"];
  $End_time	 = $POST["End_time"];
  $Top	 = $POST["Top"];
  $Tag	 = $POST["Tag"];
  $Title	 = $POST["Title"];
  $Contents	 = $POST["Contents"];
  $Regi_date	 = $POST["Regi_date"]." 00:00:00";
  $End_time	 = $POST["End_time"];
  $update_filename = $POST["update_filename"]; // 업데이트될 파일리스트 문자열
  $PopYN = $_POST["popup"];       // 공지사항의 팝업여부
  $G_width = $POST["G_width"];   // 공지사항의 팝업창 가로 픽셀
  $G_height = $POST["G_height"]; // 공지사항의 팝업창 세로 픽셀
  $P_top = $POST["P_top"];   // 공지사항의 팝업창 위치 top
  $P_left = $POST["P_left"]; // 공지사항의 팝업창 위치 left
  $Sati = $POST["sati"]; // 상품후기 만족도

  $Secret = $_POST["secret"]; // 비밀글 사용시 y로 넘어옴 : 2010-03-04 정수진

  // 어드민에서 접근한 경우
  if($POST['as'] != "") { $U_name = "관리자"; $U_id = "_ADMIN_"; }

  // 관리자면 누가 썼는지 상관없이 수정 2008-08-29 : 남형진
  $admin_name = $U_name == "관리자" ? "":"AND Writer_id='$U_id'";

  // 상품리뷰 이미지 수정
  $g_code = ($table_name == "Board_review" && $update_filename != "") ? ", `G_code`='$update_filename'" : "";

  // 섹션에 따라 수정쿼리 변경
  switch($section){

    // 파일만 따로 수정.
    case "fileonly" :
    break;

    case "level" :
      $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag' ,Touser='$addstring'
      WHERE B_no='$B_no' AND Writer_id='$U_id'";
      $mysql->execute($query);
    break;

    case "turm" :
      $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top',
      `Tag`='$Tag',Charger='$Charger',Collaborator='$Collaborator',Start_time='$Start_time',End_time='$End_time'
      WHERE B_no='$B_no' AND Writer_id='$U_id'";
      $mysql->execute($query);
    break;

    // 파일 게시물의 수정과 일반게시물의 수정은 같이 처리해준다.
    case "normal" :
      // 비밀글 추가 : 2010-03-05 정수진
      if($Secret!='') {
        $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag', `Secret`='$Secret'
        WHERE B_no='$B_no' $admin_name";
      }
      else {
        $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag'
        WHERE B_no='$B_no' $admin_name";
      }
      $mysql->execute($query);
    break;

    case "gongji" :
      $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag', `PopYN`='$PopYN', `G_width`='$G_width', `G_height`='$G_height', `P_top`='$P_top', `P_left`='$P_left'
      WHERE B_no='$B_no' $admin_name";
      $mysql->execute($query);

      // 공지사항 파일에 쓰기
      // DB로 전환 : 2011-03-02 정수진
      //$this->inst_SelectDisplay->PopUpGongJi(&$this->inst_FileIO,'');

    break;

    case "good" :

      //  관리자 수정일 경우
      if($POST['as'] == 'BoardMan') {
      $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag', `G_sati`='$Sati',Regi_date='$Regi_date',Writer_name='$Writer_name' $g_code WHERE B_no='$B_no' $admin_name";
      }
      //  일반 수정
      else {
        $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag', `G_sati`='$Sati' $g_code WHERE B_no='$B_no' $admin_name";
      }

      $mysql->execute($query);
    break;

    case "file" :
      $query = "UPDATE $this->DataBase.$table_name SET `Title`='$Title' , `Contents`='$Contents', `Top`='$Top', `Tag`='$Tag', Filename='$update_filename'
      WHERE B_no='$B_no' $admin_name";
      $mysql->execute($query);
    break;

  // switch - End
  }

// function - End
}

//  테이블 생성  쿼리
function Create_board_list($mysql){

  $query = "
  CREATE TABLE IF NOT EXISTS $this->DataBase.`Board_list` (
  `idx` int(11) NOT NULL auto_increment,
  `table_name` varchar(20) NOT NULL default '',
  `board_name` varchar(128) NOT NULL default '',
  `board_type` varchar(20) NOT NULL default '',
  `regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`idx`),
  UNIQUE KEY `table_name` (`table_name`)
  ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1 ;
  ";
  $mysql->execute($query);

// function - End
}

//-------------------------------------------
// 게시판 DB테이블 생성
//-------------------------------------------
function Create_table($section,$post,$mysql){

  $table_name = $post[table_name];

  // 게시판 테이블명
  if($table_name == "") {
    $table_name = "Board_".rand(1000,9999).rand(1000,9999);
  } else {
    $table_name = "Board_".$table_name;
  }

  $post[table_name] = $table_name;

  // 코멘트 테이블명
  $Comment_name	=	sprintf("%s_c",$table_name);

  // section 따라서
  switch($section){
    // switch - Start()

    // 파일 첨부 형태
      case "file" :
    $query = "
    CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
    `B_no` int(11) NOT NULL auto_increment,
    `Title` varchar(255) NOT NULL default '',
    `Writer_id` varchar(40) NOT NULL default '',
    `Writer_name` varchar(16) NOT NULL default '0',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Ref` int(11) NOT NULL default '0',
    `Contents` text NOT NULL,
    `Fid` int(11) NOT NULL default '1',
    `Thread` varchar(10) NOT NULL default 'A',
    `Top` char(1) NOT NULL default '',
    `Tag` char(1) NOT NULL default '',
    `Filename` text NOT NULL,
    PRIMARY KEY  (`B_no`),
    KEY `Writer_id` (`Writer_id`),
    KEY `Thread` (`Thread`),
    KEY `Fid` (`Fid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

    //  임원 전용 형태
    case "level" :
    $query = "
    CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
    `B_no` int(11) NOT NULL auto_increment,
    `Title` varchar(255) NOT NULL default '',
    `Writer_id` varchar(40) NOT NULL default '',
    `Writer_name` varchar(16) NOT NULL default '0',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Ref` int(11) NOT NULL default '0',
    `Contents` text NOT NULL,
    `Fid` int(11) NOT NULL default '1',
    `Thread` varchar(10) NOT NULL default 'A',
    `Top` char(1) NOT NULL default '',
    `Tag` char(1) NOT NULL default '',
    `Touser` varchar(255) NOT NULL default '',
    `Level` TINYINT NOT NULL default '0',
    PRIMARY KEY  (`B_no`),
    KEY `Writer_id` (`Writer_id`),
    KEY `Thread` (`Thread`),
    KEY `Fid` (`Fid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

    // 일반 적인 형태
    case "normal" :

    //  비밀글 지원 : 2010-03-05 정수진
    if($this->CP_CODE=='dochiqueen') {
      $query = "
      CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
      `B_no` int(11) NOT NULL auto_increment,
      `Title` varchar(255) NOT NULL default '',
      `Writer_id` varchar(40) NOT NULL default '',
      `Writer_name` varchar(16) NOT NULL default '0',
      `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
      `Ref` int(11) NOT NULL default '0',
      `Contents` text NOT NULL,
      `Fid` int(11) NOT NULL default '1',
      `Thread` varchar(10) NOT NULL default 'A',
      `Top` char(1) NOT NULL default '',
      `Tag` char(1) NOT NULL default '',
      `Touser` varchar(255) NOT NULL default '',
      `Secret` char(1) NOT NULL default '',
      PRIMARY KEY  (`B_no`),
      KEY `Writer_id` (`Writer_id`),
      KEY `Thread` (`Thread`),
      KEY `Fid` (`Fid`)
      ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
      ";
      $mysql->execute($query);
    }
    else {
      $query = "
      CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
      `B_no` int(11) NOT NULL auto_increment,
      `Title` varchar(255) NOT NULL default '',
      `Writer_id` varchar(40) NOT NULL default '',
      `Writer_name` varchar(16) NOT NULL default '0',
      `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
      `Ref` int(11) NOT NULL default '0',
      `Contents` text NOT NULL,
      `Fid` int(11) NOT NULL default '1',
      `Thread` varchar(10) NOT NULL default 'A',
      `Top` char(1) NOT NULL default '',
      `Tag` char(1) NOT NULL default '',
      `Touser` varchar(255) NOT NULL default '',
      PRIMARY KEY  (`B_no`),
      KEY `Writer_id` (`Writer_id`),
      KEY `Thread` (`Thread`),
      KEY `Fid` (`Fid`)
      ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
      ";
      $mysql->execute($query);
    }

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

    // 일반 적인 형태
    case "gongji" :

    $query = "
    CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
    `B_no` int(11) NOT NULL auto_increment,
    `Title` varchar(255) NOT NULL default '',
    `Writer_id` varchar(40) NOT NULL default '',
    `Writer_name` varchar(16) NOT NULL default '0',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Ref` int(11) NOT NULL default '0',
    `Contents` text NOT NULL,
    `Fid` int(11) NOT NULL default '1',
    `Thread` varchar(10) NOT NULL default 'A',
    `Top` char(1) NOT NULL default '',
    `Tag` char(1) NOT NULL default '',
    `Touser` varchar(255) NOT NULL default '',
    `PopYN` varchar(1) NOT NULL default '',
    PRIMARY KEY  (`B_no`),
    KEY `Writer_id` (`Writer_id`),
    KEY `Thread` (`Thread`),
    KEY `Fid` (`Fid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

    // 상품후기 형태
    case "good" :

    $query = "
    CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
    `B_no` int(11) NOT NULL auto_increment,
    `Title` varchar(255) NOT NULL default '',
    `Writer_id` varchar(40) NOT NULL default '',
    `Writer_name` varchar(16) NOT NULL default '0',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Ref` int(11) NOT NULL default '0',
    `Contents` text NOT NULL,
    `Fid` int(11) NOT NULL default '1',
    `Thread` varchar(10) NOT NULL default 'A',
    `Top` char(1) NOT NULL default '',
    `Tag` char(1) NOT NULL default '',
    `G_code` varchar(255) NOT NULL default '',
    `G_sati` char(1) NOT NULL default '',
    `Touser` varchar(255) NOT NULL default '',
    `best_ok` TINYINT NOT NULL default '',
    PRIMARY KEY  (`B_no`),
    KEY `Writer_id` (`Writer_id`),
    KEY `Thread` (`Thread`),
    KEY `Fid` (`Fid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

    // 일정 게시판
    case "turm" :
    $query = "
    CREATE TABLE IF NOT EXISTS $this->DataBase.$table_name(
    `B_no` int(11) NOT NULL auto_increment,
    `Title` varchar(255) NOT NULL default '',
    `Writer_id` varchar(40) NOT NULL default '',
    `Writer_name` varchar(16) NOT NULL default '0',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Ref` int(11) NOT NULL default '0',
    `Contents` text NOT NULL,
    `Fid` int(11) NOT NULL default '1',
    `Thread` varchar(10) NOT NULL default 'A',
    `Top` char(1) NOT NULL default '',
    `Tag` char(1) NOT NULL default '',
    `Start_time` datetime NOT NULL default '0000-00-00 00:00:00',
    `End_time` datetime NOT NULL default '0000-00-00 00:00:00',
    `Charger` varchar(255) NOT NULL default'',
    `Collaborator` varchar(255) NOT NULL default'',
    PRIMARY KEY  (`B_no`),
    KEY `Writer_id` (`Writer_id`),
    KEY `Thread` (`Thread`),
    KEY `Fid` (`Fid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);

    $query	=	"
    CREATE TABLE IF NOT EXISTS $this->DataBase.$Comment_name(
    `C_no` int(11) NOT NULL auto_increment,
    `B_no` int(11) NOT NULL default '0',
    `C_ID` varchar(40) NOT NULL default '',
    `C_Name` varchar(40) NOT NULL default '',
    `Regi_date` datetime NOT NULL default '0000-00-00 00:00:00',
    `Comment` text NOT NULL,
    PRIMARY KEY  (`C_no`)
    ) ENGINE=InnoDB DEFAULT CHARSET=euckr AUTO_INCREMENT=1;
    ";
    $mysql->execute($query);
    break;

  // switch - End()
  }
	// 게시판 목록에 등록
	$result = $this->Insert_board_list($section,$post,$mysql);
 Return $result;
// function - End
}

// 게시판 목록 등록 쿼리
function Insert_board_list($board_type,$post,$mysql){
  $file_name = $post[file_name][0]."|".$post[file_name][1];
  $file_name_title = $post[file_name_title];
  $OmpYN = $post[OmpYN];

  $query = "INSERT INTO $this->DataBase.`Board_list` (`idx` ,`table_name` ,`board_name`,`board_type`,`board_state` ,`regi_date` ,`Paging` ,`Img` ,`Title_Img`, `OmpYN` ) VALUES (NULL , '$post[table_name]', '$post[board_name]', '$board_type', '$post[board_state]',NOW( ), '$post[page]', '$file_name', '$file_name_title', '$OmpYN' );";
  $result = $mysql->execute($query);
  Return $result;
}

// 상품코드에 해당하는 이미지 얻기 (상품문의, 후기용)
function GetGoods_img($GoodsCode,$mysql){

    $query	=	"SELECT a.File_name, b.Goods_name FROM $this->DataBase.Goods_img as a
                 LEFT JOIN $this->DataBase.Goods_Basic as b on(a.Goods_no=b.Goods_no)
               WHERE a.Goods_no ='$GoodsCode' and a.Size = '2';";
    $data	=	$mysql->fetch_key($query);

  Return $data;
}

//---------------------------------
// 코멘트
//---------------------------------
function Select_comment(){

}
//----------------------------------------------------------------
// 댓글 등록 : 댓글이 필요하면 추가.
//----------------------------------------------------------------
function Insert_comment(){

}


// class - End()
}
?>