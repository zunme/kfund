<?
define(Default_td_color, "#efefef");	// 기본 TD 색
define(Top_td_color, "#cdcdce");		// 공지일 경우 TD 색
define(_REPLY_IMG, "<img src=\"./board/img/re.gif\" align=\"absmiddle\" >");	// 답변 이미지
define(_SECRET_IMG, "<img src=\"./board/img/secret.gif\" align=\"absmiddle\" >");	// 잠김 이미지
define(_NOSECRET_IMG, "<img src=\"./board/img/nosecret.gif\" align=\"absmiddle\" >");	// 공개 이미지

// 출력용
class Board_output_template{
// class - Start()

	// 게시판 파일
	var $self_page;

	// 글씨 색상
	var $secret_font_color;

	// 테이블 색상
	var $bgcolor_table,$bgcolor_td,$bgcolor_td_title,$bgcolor_turm_td;

	// Tr 높이
	var $list_tr_height,$list_title_height,$page_padding,$view_title_height,$view_td_width,$view_td_height,$file_tr_height,$file_turm_height,$file_turm_width;

// 현재글 표시 화살표 아이콘
var $arrow_now;

// 게시판 사용 버튼들
var $list_button,$list_write,$list_modify, $list_reply, $list_delete, $list_search, $list_comment ,$list_button_dot;

//-----------------------------
//     생성자
//-----------------------------
function Board_output_template(){

  // 링크걸 보드파일명
  $this->self_page			= $_SERVER["PHP_SELF"];

  // 백그라운드 색상
  $this->bgcolor_table	=	"#DCDCDC";
  $this->bgcolor_top =	"#EDECE1";
  $this->bgcolor_td_title	=	"#FDFFF4";
  $this->bgcolor_td =	"#FFFFFF";
  $this->bgcolor_turm_td	 =	"#FDFFF4";
  $this->view_td_title =	"#EDECE1";  // view 파일에서 제목부분
  $this->view_td =	"#FFFFFF";   // view 파일에서 TD부분

  // 글씨 색상
  $this->secret_font_color = "#CDDCDC";

  // list tr 높이
  $this->list_tr_height		=	20;
  $this->list_title_height	=	24;
  $this->page_padding	=	10;	// 리스트와 페이징의 간격

  // view 높이
  $this->view_title_height	=	30;
  $this->view_contents_height	=	200;
  $this->view_td_width		=	340;
  $this->view_td_height	=	40;
  $this->file_tr_height		=	18;
  $this->file_turm_height	=	18;
  $this->file_turm_width	=	160;

  // 현재글 표시 화살표
  $this->arrow_now = "board/img/img_arrow.gif";
  $this->file_addicon = "./board/img/file.gif";

  // 게시판에 사용되는 버튼 이미지들
  $this->list_button = "";
  $this->list_write = "";
  $this->list_modify = "";
  $this->list_reply = "";
  $this->list_delete = "";
  $this->list_search = "";
  $this->list_comment = "";
  $this->list_button_dot = "";

// function - End
}

//--------------------------------------------
//     게시판 생성폼
//--------------------------------------------
function Print_create_form(){

  echo "<body onload=\"document.createform.board_name.focus();\">";
  echo "<table border='1'>";
  echo "<form name=\"createform\" action=\"$this->self_page\" method=\"post\" onsubmit=\"if(!document.createform.board_name.value){return false;}else{document.createform.submit();}\">";
  echo "<INPUT TYPE=\"hidden\" NAME=\"baction\" value=\"create\">";
  echo "<INPUT TYPE=\"hidden\" NAME=\"action\" value=\"Board\">";
  echo "<tr>";
  echo "<td align=\"center\">게시판 용도</td>
  <td align=\"center\"><INPUT TYPE=\"radio\" NAME=\"section\" value='normal' checked>일반</td>
  <td align=\"center\"><INPUT TYPE=\"radio\" NAME=\"section\" value='file'>파일</td>
  <td align=\"center\"><INPUT TYPE=\"radio\" NAME=\"section\" value='level'>임원</td>
  <td align=\"center\"><INPUT TYPE=\"radio\" NAME=\"section\" value='turm'>일정</td>";
  echo "</tr>";
  echo "<tr>";
  echo "<td align=\"center\">게시판 이름</td><td colspan='4' align=\"center\"><INPUT TYPE=\"text\" NAME=\"board_name\" style=\"ime-mode:active\" OnKeyPress=\"korean_only(this);\"></td>";
  echo "</tr>";
  echo "</form>";
  echo "<tr>";
  echo "<td align=\"center\" colspan='5' ><INPUT TYPE=\"button\" value=\"게시판 생성\" onclick=\"if(!document.createform.board_name.value){return false;}else{document.createform.submit();}\"></td>";
  echo "</tr>";
  echo "</table>";
  echo "</body>";

// function - End
}

//----------------------------------------------------------------
//   답변 공백 출력
//----------------------------------------------------------------
function Make_space($Thread){

  $space = "";
  $turn = strlen($Thread);

  // 답글일 경우
  if($turn > 1){
    // 스레드가 2칸 이상이면 공백을 찍어주고 그렇지 않으면 공백을 찍지 않는다.
    if($turn >= 2){
      for($i=0; $i < $turn; $i++){$space = $space."&nbsp;&nbsp;";}
    }
  return $space._REPLY_IMG;
  }
  // 단독 글일 경우
  else{return "";}

// function - End
}

//----------------------------------------------------------------------------
// 서브 리스트에서 현재글 표시 아이콘 출력
//----------------------------------------------------------------------------
function Print_arrow($b_no, $l_no){

 // 현재 글번호와 리스트 글번호가 같으면 화살표 표시
 if($b_no == $l_no){
   echo "<img src='$this->arrow_now' align='absmiddle'>";
 }

// function - End
}


//----------------------------------------------------------------------------
// 리스트에서 비밀글 표시 아이콘 출력 추가 : 2010-03-04 정수진
//----------------------------------------------------------------------------
function Print_secret($secret){
 if($secret == 'y'){ echo "<img src=\"./board/img/ico-lock.gif\" align=\"absmiddle\" >"; }
// function - End
}

//-------------------------------------
//   TD 색깔 출력
//-------------------------------------
function Print_td_color($Top){
  if($Top=="o"){return $this->bgcolor_top;}
  else{return $this->bgcolor_td;}
// function - End
}

//----------------------------------------------------------------
//   섹션에따른 tpl파일 체인지
//----------------------------------------------------------------
function Output_changer($baction,$section){
  return "board/".$baction."_".$section.".tpl";
}

//-----------------------------------------------------
//   옵션 게시판에서 옵션 표시
//-----------------------------------------------------
function Print_optionstatus($section,$data){

  switch($section){
    case "file" :
      // 첨부파일이 있을 때
      if(strlen($data) >= 1)
      {return "<IMG SRC=\"$this->file_addicon\"  BORDER=\"0\" align=\"absmiddle\">";}
      // 첨부 없을때
      else{return "&nbsp;";}
    break;

    case "level" :
      // Touser가 있을때
      if(strlen($data) >= 1){return _SECRET_IMG;} // 잠김 이미지
      // Touser가 없을때
      else{return _NOSECRET_IMG;}
    break;
  // switch - End
  }
// function - End()
}

//------------------------------------------------------------------------------
// 레벨 적용 게시판과 비적용 게시판의 분리
//------------------------------------------------------------------------------
function Sep_level($inst_StringCon,$inst_auth,$table_name,$section,$b_no,$page,$option,$U_id,$Writer_id,$Title,$adminYN,$board_no='',$path='',$secret=''){

  $Title = $inst_StringCon->change_gal($inst_StringCon->ugly_han(urldecode($Title)));

  // 해당게시물의 엑세스권한 판단
  $auth = $inst_auth->Authcheck($section,$option,$U_id,$Writer_id,$secret);

  // 어드민에서 접속 했을경우 as 값넘기기
  $as = $adminYN == "Y" ? "BoardMan":"";

  if($auth=="ok"){
    echo sprintf("<A HREF=\"%s?action=Board&baction=view&table_name=%s&section=%s&No=%s&page=%s&as=%s&board_no=%s&path=%s&b_title=%s&secret=%s\">%s</A>",$this->self_page,$table_name,$section,$b_no,$page,$as,$board_no,$path,urlencode($_GET[b_title]),$secret,$Title);
  }
  else{
    echo sprintf("<font size=\"2\" color=\"$this->secret_font_color\">%s</font>",$Title);
  }
// function - End
}

//----------------------------------------------------------------
// 등록할때 게시판 옵션별 출력
//----------------------------------------------------------------
function Print_write_option($section,$baction,$mysql,$Edit_array){

  switch($section){
    // 레벨 설정
    case "level" :
      //--------------------------------------------------
      //        전체 사용자 목록 쿼리
      //--------------------------------------------------
      $inst_member	= new Member();

      // 0번째는 배열을 , 1번째는 레코드 갯수를
      $data = $inst_member->Query_member($mysql);

      // 수정 시에만 읽기 가능자로 등록된 사람들 문자열을 배열로 분리해준다
      if($baction !="write"){
      // 선택된 목록
      $Touser	=	explode("/",$Edit_array[0]);

      // 전체 목록에서 선택되지 않은 놈들만 뽑아준다.
      $result_array = array_diff($data[0]["u_name"],$Touser);
      sort($result_array); // 배열 인덱스 정렬
      }
      else{$result_array	 =	$data[0]["u_name"];}

      echo "<FORM METHOD=POST ACTION=\"$this->self_page\" NAME=\"multi1\">";
      echo "<INPUT TYPE=\"hidden\" NAME=\"aa\" value=\"aa\">";

      // to 사용 여부
      echo "<tr height=\"150\" valign=\"middle\">";
      echo "	<td align=\"center\" width=\"120\" bgcolor=\"$this->view_td_title\">To</td>";
      echo "	<td bgcolor=\"$this->view_td\">";
      echo " <table>";
      echo " <tr>";

      // 선택할 사람들
      echo "	<td  valign=\"middle\">";
      echo "<select multiple name=\"haveBox\" ONDBLCLICK=\"moveOver2(this.form);\" style=\"width:120px;height:160px;\">";
      $this->Print_Memlist($result_array);
      echo "</select>";
      echo "  </td>";
      echo "<td>
      <table width=\"65\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
      <tr>
      <td align=\"center\" height=\"40\"><input type=\"button\" value=\"추가\" onClick=\"multi_moveOver(this.form);\"></td>
      </tr>
      <tr>
      <td background=\"../img/dot_line.gif\"><img src=\"../img/blank.gif\" width=\"5\" height=\"1\"></td>
      </tr>
      <tr>
      <td align=\"center\" height=\"40\"><input type=\"button\" value=\"빼기\" onclick=\"removeMe(this.form);\"></td>
      </tr>
      </table>
      </td>";

      // 선택한 사람들
      echo "	<td  valign=\"middle\">";
      echo "<select multiple name=\"addBox\" ONDBLCLICK=\"removeMe(this.form);\" style=\"width:120px;height:160px;\">";
      $this->Print_Memlist($Touser);
      echo "</select multiple>";
      echo "  </td>";
      echo " </tr>";
      echo "</table>";
      echo "	</td>";
      echo "</tr>";
      echo "</FORM>";
      break;

    // 일정 설정
    case "turm" :
     // 리플이 아닐경우만
      if($baction!="repl"){
        // if - Start()
        //--------------------------------------------------
        //        전체 사용자 목록 쿼리
        //--------------------------------------------------
        $inst_member	= new Member();

        // 0번째는 배열을 , 1번째는 레코드 갯수를
        $data = $inst_member->Query_member($mysql);

        // 수정 시에만 읽기 가능자로 등록된 사람들 문자열을 배열로 분리해준다
        if($baction !="write"){
          // 담당자 목록
          $Charger = explode("/",$Edit_array[1]);

          // 참여자 목록
          $Collaborator = explode("/",$Edit_array[2]);

          // 전체 목록에서 선택되지 않은 담당자 목록을 뽑아준다.
          $result_Charger = array_diff($data[0]["u_name"],$Charger);
          sort($result_Charger); // 배열 인덱스 정렬

          // 전체 목록에서 선택되지 않은 담당자 목록을 뽑아준다.
          $result_Collaborator = array_diff($data[0]["u_name"],$Collaborator);
          sort($result_Collaborator); // 배열 인덱스 정렬
        }
        else{
          $result_Charger = $data[0]["u_name"];			// 담당자 목록
          $result_Collaborator = $data[0]["u_name"];	// 참여자 목록
        }

        echo "<FORM METHOD=POST ACTION=\"$this->self_page\" NAME=\"multi1\">";
        echo "<INPUT TYPE=\"hidden\" NAME=\"aa\" value=\"aa\">";

        // to 사용 여부
        echo "<tr height=\"150\" valign=\"middle\">";
        echo "	<td align=\"center\" width=\"120\" bgcolor=\"$this->view_td_title\">담당자</td>";
        echo "	<td bgcolor=\"$this->view_td\">";
        echo " <table>";
        echo " <tr>";

        // 선택할 사람들
        echo "	<td  valign=\"middle\">";
        echo "<select multiple name=\"haveBox\" ONDBLCLICK=\"moveOver2(this.form);\" style=\"width:120px;height:160px;\">";
        $this->Print_Memlist($result_Charger);
        echo "</select>";
        echo "  </td>";
        echo "<td>
        <table width=\"65\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
        <tr>
        <td align=\"center\" height=\"40\"><input type=\"button\" value=\"추가\" onClick=\"multi_moveOver(this.form);\"></td>
        </tr>
        <tr>
        <td background=\"../img/dot_line.gif\"><img src=\"../img/blank.gif\" width=\"5\" height=\"1\"></td>
        </tr>
        <tr>
        <td align=\"center\" height=\"40\"><input type=\"button\" value=\"빼기\" onclick=\"removeMe(this.form);\"></td>
        </tr>
        </table>
        </td>";

        // 선택한 사람들
        echo "	<td  valign=\"middle\">";
        echo "<select multiple name=\"addBox\" ONDBLCLICK=\"removeMe(this.form);\" style=\"width:120px;height:160px;\">";
        $this->Print_Memlist($Charger);
        echo "</select multiple>";
        echo "  </td>";
        echo " </tr>";
        echo "</table>";
        echo "	</td>";
        echo "</tr>";

        echo "</FORM>";
        echo "<FORM METHOD=POST ACTION=\"$this->self_page\" NAME=\"multi2\">";
        echo "<INPUT TYPE=\"hidden\" NAME=\"bb\" value=\"bb\">";

        // to 사용 여부
        echo "<tr height=\"150\" valign=\"middle\">";
        echo "	<td align=\"center\" width=\"120\" bgcolor=\"$this->view_td_title\">참여자</td>";
        echo "	<td bgcolor=\"$this->view_td\">";
        echo " <table>";
        echo " <tr>";

        // 선택할 사람들
        echo "	<td  valign=\"middle\">";
        echo "<select multiple name=\"haveBox\" ONDBLCLICK=\"moveOver2(this.form);\" style=\"width:120px;height:160px;\">";
        $this->Print_Memlist($result_Collaborator);
        echo "</select>";
        echo "  </td>";
        echo "<td>
        <table width=\"65\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
        <tr>
        <td align=\"center\" height=\"40\"><input type=\"button\" value=\"추가\" onClick=\"multi_moveOver(this.form);\"></td>
        </tr>
        <tr>
        <td background=\"../img/dot_line.gif\"><img src=\"../img/blank.gif\" width=\"5\" height=\"1\"></td>
        </tr>
        <tr>
        <td align=\"center\" height=\"40\"><input type=\"button\" value=\"빼기\" onclick=\"removeMe(this.form);\"></td>
        </tr>
        </table>
        </td>";
        // 선택한 사람들
        echo "	<td  valign=\"middle\">";
        echo "<select multiple name=\"addBox\" ONDBLCLICK=\"removeMe(this.form);\" style=\"width:120px;height:160px;\">";
        $this->Print_Memlist($Collaborator);
        echo "</select multiple>";
        echo "  </td>";
        echo " </tr>";
        echo "</table>";
        echo "	</td>";
        echo "</tr>";
        echo "</FORM>";
      // if - End();
      }
    break;

  // switch - End
  }

// function - End
}
//------------------------------------------
//   직원 목록 출력
//------------------------------------------
function Print_Memlist($data){
  for($i=0; $i < count($data); $i++){
    $U_name	=	$data[$i];
    echo "<option value='$U_name'>$U_name</option>";
  }
// function - End
}

//----------------------------------------------------
//   기능키들 출력 묶음
//----------------------------------------------------
function Print_viewfunction($mysql,$option,$baction,$table_name,$section,$B_no,$U_id,$Writer,$Top,$Thread,$Fid,$admin='N',$rebuyn='Y'){

  //$inst_query	=	new Board_query();
  // 이전글과 다음글의 번호를 쿼리해서 리턴
 // $Direction	 =	$inst_query->Find_nprecord($mysql,$B_no,$table_name,$Top);
  echo "<div class='viewbtn'>";

  // 각종 버튼 출력할 TD
  //echo $this->Print_button("Space","");

  // 이전글, 다음글 버튼 출력 ( 답변글이 아닐 경우만 표시한다. / 차후에 답변글도 필요하면 답변글 끼리 이전다음 글들을 구해준다.)
  // if(strlen($Thread) <= 1){$this->Print_directionbutton($Direction,$table_name,$section);}
  //echo $this->Print_button("Space","");

  $action = $_GET[path] == "mypage" ? "MyBoard":"Board";

  // 어드민에서 접속 했을경우 as 값넘기기
  $as = $admin=="Y" ? "BoardMan":"";
  $b_title = urlencode($_GET[b_title]);

  // 디자이너 정의 버튼이 있으면 그버튼경로로
  if($this->list_button!="") {  $list_button = sprintf("%s",$this->list_button); }
  else { $list_button = "board/img/btn-03.gif"; }
  echo "<img src='$list_button' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=$action&baction=list&table_name=$table_name&section=$section&page=$_GET[page]&as=$as&path=$_GET[path]&b_title=$b_title');\" style='cursor:pointer'> ";
  //echo $this->Print_button("Space","");

  // 답글 뎁스 조절을 위해 답글은 1뎁스까지만. 일정 게시판은 답글을 달수없게
  // 답글 못달게할 게시판.. 2008-04-01 : 남형진
  $NoRepl = array("Board_goods_after","Board_one_qna","Board_goods_qna","Board_gongji","Board_review");
  if($admin=="Y") $NoRepl = array("Board_goods_after","Board_gongji");

  if(($U_id!="") && $Thread=="A" && $Top!="o" && $section!="turm" && !in_array($table_name,$NoRepl)){
    // 디자이너 정의 버튼이 있으면 그버튼경로로
    if($this->list_reply!="") {  $list_reply = sprintf("%s",$this->list_reply); }
    else { $list_reply = "board/img/btn-04.gif"; }
    if($rebuyn=='Y') {
      echo "<img src='$list_reply' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=Board&baction=repl&table_name=$table_name&section=$section&No=$B_no&page=$_GET[page]&as=$as&path=$_GET[path]&b_title=$b_title&secret=$_GET[secret]');\" style='cursor:pointer'>";
    }

    //echo $this->Print_button("Space","");
  }
  // 수정 , 삭제 버튼 출력
  $this->Print_edbutton($table_name,$section,$U_id,$Writer,$B_no,$Thread,$admin);
  echo "</div>";

  // 첨부파일이 있을경우만 출력할 TR
  if(trim($option["size"][0])!="0" && trim($option["size"][0])!=""){$this->Print_viewfile($option);}

// function - End
}

//---------------------------------------------
//   수정, 삭제 버튼 출력
//---------------------------------------------
function Print_edbutton($table_name,$section,$U_id,$Writer,$B_no,$Thread,$admin='N'){

  // 디자이너 정의 버튼이 있으면 그버튼경로로
  if($this->list_modify!="") {  $list_modify = sprintf("%s",$this->list_modify); }
  else { $list_modify = "board/img/btn-05.gif"; }

  // 디자이너 정의 버튼이 있으면 그버튼경로로
  if($this->list_delete!="") {  $list_delete = sprintf("%s",$this->list_delete); }
  else { $list_delete = "board/img/btn-06.gif"; }

  // 디자이너 정의 버튼이 있으면 그버튼경로로
  if($this->list_button_dot=="none") { $list_button_dot = sprintf(" ");}
  else { $list_button_dot = "<img src='board/img/btn-dot_gray.gif' width='1' height='22' align='absmiddle' style='margin:0 5px;'>";  }

  // 2009-04-20 수정하믄 무조건 mypage로 가게해놔서 수정함 : 박준형
  if($_GET[path]!="") { $path_ = $_GET[path]; }
  else { $path_ = ''; }
  $as = $admin=="Y" ? "BoardMan&path=main":"&path=$path_";

  if( $Writer==$U_id || $admin=="Y" ){
    $b_title = urlencode($_GET[b_title]);
    echo "$list_button_dot<img src='$list_modify' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=Board&baction=edit&table_name=$table_name&section=$section&No=$B_no&Thread=$Thread&page=$_GET[page]&as=$as&b_title=$b_title&secret=$_GET[secret]');\"  style='cursor:pointer'>";
    echo " <img src='$list_delete' align='absmiddle' onclick=\"if(confirm('삭제 하시겠습니까?')){return document.location.replace('$this->self_page?action=Board&baction=dele&table_name=$table_name&section=$section&No=$B_no&page=$_GET[page]&as=$as&admin=$admin');}else{return false;}\" style='cursor:pointer'>";
   // echo $this->Print_button("Space","");
  }
// function - End
}

//----------------------------
//   버튼 출력
//----------------------------
function Print_button($b_action,$param){

  switch($b_action){
    case "Space" :
      return "&nbsp;&nbsp;";
    break;

    case "Write" :
      return "<INPUT TYPE=\"button\" value=\"글쓰기\" $param>";
    break;

    case "Write_submit" :
      return "<INPUT TYPE=\"button\" value=\"등 록\" $param>";
    break;

    case "Edit" :
      return "<INPUT TYPE=\"button\" value=\"수 정\" $param>";
    break;

    case "Del" :
      return "<INPUT TYPE=\"button\" value=\"삭 제\" $param>";
    break;

    case "Next" :
      return "<INPUT TYPE=\"button\" value=\"다 음\" $param>";
    break;

    case "Prev" :
      return "<INPUT TYPE=\"button\" value=\"이 전\" $param>";
    break;

    case "List" :
      return "<INPUT TYPE=\"button\" value=\"목 록\" $param>";
    break;

    case "Repl" :
      return "<INPUT TYPE=\"button\" value=\"답 글\" $param>";
    break;

    case "Search" :
      return "<INPUT TYPE=\"button\" value=\"검 색\" $param>";
    break;

    case "Total" :  // bt_img12.gif
      return "<IMG SRC='/img/page5/bt_img12.gif' $param align='absmiddle' style='cursor:pointer'>";
    break;
  }

// function - End
}

//----------------------------------------------------------------
// 날짜 인터페이스 버튼 출력 메소드
//----------------------------------------------------------------
function button_ud($act,$field){

  return "<table width=\"13\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
  <td><img src=\"./img/bt_up.gif\" width=\"13\" height=\"9\" border=\"0\" style=\"cursor:pointer\" onclick=\"check_value('$act','$field','up','writeform')\"></td>
  </tr>
  <tr><td><img src=\"\" width=\"13\" height=\"1\"></td></tr>
  <tr>
  <td><img src=\"./img/bt_down.gif\" width=\"13\" height=\"9\" border=\"0\" style=\"cursor:pointer\" onclick=\"check_value('$act','$field','down','writeform')\"></td>
  </tr>
  </table>";

// function - End
}

//-----------------------------------------------
//   날짜 인터페이스 메인
//-----------------------------------------------
function Print_date($date1,$date2){

  // 수정시에는 넘겨받은 데이터로 날짜 설정
  if($date1!=""){
    $date1	=	str_replace("-"," ",str_replace(":"," ",$date1));
    $date2	=	str_replace("-"," ",str_replace(":"," ",$date2));
    $temp_date1	=	explode(" ",$date1);
    $temp_date2	=	explode(" ",$date2);
  }
  // 작성시에는 현재 날짜 생성해서 날짜작성
  else{
    $date			=	date("Y m d H i s",mktime());
    $temp_date1	=	explode(" ",$date);
    $temp_date2	=	explode(" ",$date);
  }

  $year	=	intval($temp_date1[0]);
  $month	=	intval($temp_date1[1]);
  $day	 	=	intval($temp_date1[2]);
  $hour	=	intval($temp_date1[3]);
  $min	 	=	intval($temp_date1[4]);
  $sec	 	=	intval($temp_date1[5]);

  $year_e	=	intval($temp_date2[0]);
  $month_e	=	intval($temp_date2[1]);
  $day_e	 	=	intval($temp_date2[2]);
  $hour_e	=	intval($temp_date2[3]);
  $min_e	 	=	intval($temp_date2[4]);
  $sec_e 	=	intval($temp_date2[5]);

  // 시작 일자
  $year_b	=	$this->button_ud("year","year");
  $month_b	=	$this->button_ud("month","month");
  $day_b		=	$this->button_ud("day","day");
  $hour_b	=	$this->button_ud("hour","hour");
  $min_b		=	$this->button_ud("min","min");
  $sec_b		=	$this->button_ud("sec","sec");

  // 종료 일자
  $eyear_b		=	$this->button_ud("year","eyear");
  $emonth_b	=	$this->button_ud("month","emonth");
  $eday_b		=	$this->button_ud("day","eday");
  $ehour_b		=	$this->button_ud("hour","ehour");
  $emin_b		=	$this->button_ud("min","emin");
  $esec_b		=	$this->button_ud("sec","esec");

  echo "
  <tr>
  <td bgcolor=\"$this->view_td_title\" height=\"30\" align=\"center\">일정 시작</td>
  <td bgcolor=\"$this->view_td\">
  <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
  <!--년-->
  <td width=\"35\" align=\"center\"><input name=\"year\" type=\"text\" class=\"input_date1\" value=\"$year\"></td>
  <td width=\"16\" align=\"center\">$year_b</td>
  <!--월-->
  <td width=\"22\" align=\"center\"><input name=\"month\" type=\"text\" class=\"input_date2\" value=\"$month\"></td>
  <td width=\"16\">$month_b</td>
  <!--일-->
  <td width=\"22\" align=\"center\"><input name=\"day\" type=\"text\" class=\"input_date2\" value=\"$day\"></td>
  <td width=\"16\">$day_b</td>
  <td width=\"10\" align=\"center\">&nbsp;</td>
  <!--시-->
  <td width=\"22\" align=\"center\"><input name=\"hour\" type=\"text\" class=\"input_date2\" value=\"$hour\"></td>
  <td width=\"16\" align=\"center\">$hour_b</td>
  <!--분-->
  <td width=\"22\" align=\"center\"><input name=\"min\" type=\"text\" class=\"input_date2\" value=\"$min\"></td>
  <td width=\"16\" align=\"center\">$min_b</td>
  <!--초-->
  <td width=\"22\" align=\"center\"><input name=\"sec\" type=\"text\" class=\"input_date2\" value=\"$sec\"></td>
  <td width=\"16\" align=\"center\">$sec_b</td>
  </tr>
  </table>
  </td>
  </tr>

  <!--종료 날짜-->
  <tr>
  <td bgcolor=\"$this->view_td_title\" height=\"30\" align=\"center\">일정 종료</td>
  <td bgcolor=\"$this->view_td\">
  <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
  <!--년-->
  <td width=\"35\" align=\"center\"><input name=\"eyear\" type=\"text\" class=\"input_date1\" value=\"$year_e\"></td>
  <td width=\"16\" align=\"center\">$eyear_b</td>
  <!--월-->
  <td width=\"22\" align=\"center\"><input name=\"emonth\" type=\"text\" class=\"input_date2\" value=\"$month_e\"></td>
  <td width=\"16\">$emonth_b</td>
  <!--일-->
  <td width=\"22\" align=\"center\"><input name=\"eday\" type=\"text\" class=\"input_date2\" value=\"$day_e\"></td>
  <td width=\"16\">$eday_b</td>
  <td width=\"10\" align=\"center\">&nbsp;</td>
  <!--시-->
  <td width=\"22\" align=\"center\"><input name=\"ehour\" type=\"text\" class=\"input_date2\" value=\"$hour_e\"></td>
  <td width=\"16\" align=\"center\">$ehour_b</td>
  <!--분-->
  <td width=\"22\" align=\"center\"><input name=\"emin\" type=\"text\" class=\"input_date2\" value=\"$min_e\"></td>
  <td width=\"16\" align=\"center\">$emin_b</td>
  <!--초-->
  <td width=\"22\" align=\"center\"><input name=\"esec\" type=\"text\" class=\"input_date2\" value=\"$sec_e\"></td>
  <td width=\"16\" align=\"center\">$esec_b</td>
  </tr>
  </table>
  </td>
  </tr>";

// function - End
}

//-----------------------------------------------
//   이전글,다음글 출력
//-----------------------------------------------
function Print_directionbutton($Direction,$table_name,$section){

  // 다음글이나 이전글이 없을때 버튼 빼줌
  $Next	=	$Direction[1];
  $Prev	=	$Direction[0];

  if($Prev!=""){
     echo $this->Print_button("Prev","onclick=\"document.location.replace('$this->self_page?action=Board&baction=view&table_name=$table_name&section=$section&No=$Prev');\"");
    echo $this->Print_button("Space","");
  }

  if($Next!=""){
    echo $this->Print_button("Next","onclick=\"document.location.replace('$this->self_page?action=Board&baction=view&table_name=$table_name&section=$section&No=$Next');\"");
  }

// function - End
}


//-----------------------------------------
//   첨부파일 목록 표시
//-----------------------------------------
function Print_viewfile($option){

//  echo "<tr><td colspan='5'  style='padding:5px'>";
  echo "<table align=\"center\" border = '0' width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" height='40'>";
  for($i=0; $i<count($option["filename"]);$i++){
    echo "<tr>";
    echo sprintf("<td height=\"$this->file_tr_height\"  style='padding:5px' align='right'><B>%s(%sk)</B></td>",$option["filename"][$i],round($option["size"][$i]/1024,1));
    echo "</tr>";
  }
  echo "</table>";
//  echo "</td></tr>";
//  echo "<tr><td height='1' colspan='5' bgcolor='#EBEBEB'></td></tr>";
// function - End
}


//--------------------------------------------------------------------
// 일정 게시판의 담당자와 참여자 출력
//--------------------------------------------------------------------
function Print_turm_member($Stringvalue){

  $tmp = explode("/",$Stringvalue);
  echo "<TABLE cellpadding='0' cellspacing='0' border=\"0\"  bgcolor=\"$this->bgcolor_table\">";

  for($i=0; $i < count($tmp); $i++){
    echo "<TR>";
    echo "<TD height=\"$this->file_turm_height\" bgcolor=\"$this->bgcolor_td\" align=\"center\" valign=\"middle\">".$tmp[$i]."</TD>";
    echo "</TR>";
  }
  echo "</TABLE>";

// function - End
}

//-----------------------------------------
//   체크박스 옵션 관련
//-----------------------------------------
function Checkbox_check($value){
  if($value!=""){return "checked";}
}

//-------------------------------------------
//  공지사항 체크 tr 출력
//-------------------------------------------
function Print_notice_check($U_Level, $Top,$Thread){

  if($U_Level >=3  && $Thread=="A"){
    $checked = $this->Checkbox_check($Top);
    echo "<TR>
    <TD align=\"center\" width=\"120\" bgcolor=\"$this->view_td_title\">공지사항</TD>
    <TD bgcolor=\"$this->view_td\"><INPUT TYPE=\"checkbox\" NAME=\"Top\" $checked>공지로 등록함</TD>
    </TR>";
  }

// function - End
}


//----------------------------------------------------
//   기능키들 출력 묶음
//----------------------------------------------------
function Print_viewfunction_click($mysql,$option,$baction,$table_name,$section,$B_no,$U_id,$Writer,$Top,$Thread,$Fid,$admin='N'){

  //$inst_query	=	new Board_query();
  // 이전글과 다음글의 번호를 쿼리해서 리턴
 // $Direction	 =	$inst_query->Find_nprecord($mysql,$B_no,$table_name,$Top);
  echo "<div class='viewbtn'>";

  // 각종 버튼 출력할 TD
  //echo $this->Print_button("Space","");

  // 이전글, 다음글 버튼 출력 ( 답변글이 아닐 경우만 표시한다. / 차후에 답변글도 필요하면 답변글 끼리 이전다음 글들을 구해준다.)
  // if(strlen($Thread) <= 1){$this->Print_directionbutton($Direction,$table_name,$section);}
  //echo $this->Print_button("Space","");

  $action = $_GET[path] == "mypage" ? "MyBoard":"Board";

  // 어드민에서 접속 했을경우 as 값넘기기
  $as = $admin=="Y" ? "BoardMan":"";
  $b_title = urlencode($_GET[b_title]);
  echo "<img src='board/img/btn-03.gif' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=$action&baction=list&table_name=$table_name&section=$section&page=$_GET[page]&as=$as&path=$_GET[path]&b_title=$b_title');\" style='cursor:pointer'> ";
  //echo $this->Print_button("Space","");

  // 답글 뎁스 조절을 위해 답글은 1뎁스까지만. 일정 게시판은 답글을 달수없게
  // 답글 못달게할 게시판.. 2008-04-01 : 남형진
  $NoRepl = array("Board_goods_after","Board_one_qna","Board_goods_qna","Board_gongji","Board_review","Board_87222503");
  if($admin=="Y") $NoRepl = array("Board_goods_after","Board_gongji");

  if(($U_id!="") && $Thread=="A" && $Top!="o" && $section!="turm" && !in_array($table_name,$NoRepl)){
    echo "<img src='board/img/btn-04.gif' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=Board&baction=repl&table_name=$table_name&section=$section&No=$B_no&page=$_GET[page]&as=$as');\" style='cursor:pointer'>";
    //echo $this->Print_button("Space","");
  }
  // 수정 , 삭제 버튼 출력
  $this->Print_edbutton($table_name,$section,$U_id,$Writer,$B_no,$Thread,$admin);
  echo "</div>";

  // 첨부파일이 있을경우만 출력할 TR
  if(trim($option["size"][0])!="0" && trim($option["size"][0])!=""){$this->Print_viewfile($option);}

// function - End
}


//---------------------------------------------
//   수정, 삭제 버튼 출력
//---------------------------------------------
function Print_edbutton_click($table_name,$section,$U_id,$Writer,$B_no,$Thread,$admin='N'){

  $as = $admin=="Y" ? "BoardMan&path=main":"&path=mypage";
  if( $Writer==$U_id || $admin=="Y" ){
    $b_title = urlencode($_GET[b_title]);
    echo "<img src='board/img/dot_gray.gif' width='1' height='22' align='absmiddle' style='margin:0 5px;'><img src='board/img/btn-05.gif' align='absmiddle' onclick=\"document.location.replace('$this->self_page?action=Board&baction=edit&table_name=$table_name&section=$section&No=$B_no&Thread=$Thread&page=$_GET[page]&as=$as&b_title=$b_title');\"  style='cursor:pointer'>";
    echo " <img src='board/img/btn-06.gif' align='absmiddle' onclick=\"if(confirm('삭제 하시겠습니까?')){return document.location.replace('$this->self_page?action=Board&baction=dele&table_name=$table_name&section=$section&No=$B_no&page=$_GET[page]&as=$as&admin=$admin');}else{return false;}\" style='cursor:pointer'>";
   // echo $this->Print_button("Space","");
  }
// function - End
}

//-----------------------------------------------------------------------------
//  게시판의 버튼이미지들을 클래스 내부로 유입 시키는놈.
//-----------------------------------------------------------------------------
function PushButtonImage($list, $write, $modify, $reply, $delete ,$search,$comment='none',$dot='none' ) {

  $this->list_button = $list;
  $this->list_write = $write;
  $this->list_modify = $modify;
  $this->list_reply = $reply;
  $this->list_delete = $delete;
  $this->list_search = $search;
  $this->list_comment = $comment;
  $this->list_button_dot = $dot;

// funciton - End
}


// class - End()
}
?>