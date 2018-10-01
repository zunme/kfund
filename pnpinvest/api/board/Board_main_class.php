<?php
// 게시판 부가기능 관련 dir
define(CSSURL,"./css/style.css");
define(JSURL,"./js/board.js");
define(FileBaseDir,ImageBase);

class Board{

// 파일 삭제할때 글로벌로 사용되는놈
var $Tmp_delfiles;
var $Img_widmax = 0;
var $DataBase;
var $Sock;

  //-------------------------
  //   생성자
  //-------------------------
  function Board($Sock,$DataBase,$inst_main){

    // 파일삭제할때 tmp 문자열 초기화
    $this->Tmp_delfiles	=	"";
    $this->Img_widmax = 700;
    $this->DataBase = $DataBase;
    $this->Sock = $Sock;
    $this->inst_main = $inst_main;

    //  게시판 확장 기능
    //  게시판과 상품후기,리뷰 등의 공유 메소드 때문에 이렇게 따로 떼준다. 2009-02-02 : 박준형
    $this->inst_BoardExtends = new BoardExtends(&$inst_main);
    //$this->inst_BoardExtends->LoadBoardOPT();

  }

  //----------------------------------------------------
  //                     메인
  //----------------------------------------------------
  function main(){

    $mysql = $this->Sock;
    ob_start();

    if(!$_POST["section"]){$section = $_GET["section"];}else{$section  =  $_POST["section"];}
    if(!$_GET["Field"]){$Field =	$_POST["Field"];}else{$Field		= $_GET["Field"];}
    if(!$_GET["Key"]){$Key =	$_POST["Key"];}else{$Key		=	&$_GET["Key"];}
    if(!$_POST["baction"]){$baction    =  $_GET["baction"];}else{$baction    =  $_POST["baction"];}
    if(!$_POST["Thread"]){$Thread    =  $_GET["Thread"];}else{$Thread    =  $_POST["Thread"];}
    if(!$_POST["Fid"]){$Fid    =  $_GET["Fid"];}else{$Fid    =  $_POST["Fid"];}
    if(!$_POST["table_name"]){$table_name    =  $_GET["table_name"];}else{$table_name = $_POST["table_name"];}
    if(!$_GET["page"]){$page = 1;}else{$page = $_GET["page"];}
    $U_Level = $_SESSION["ULEVEL"];
    $U_id = $_SESSION["UID"] == "" ? $_SESSION["Com_id"]:$_SESSION["UID"];
    $U_name = $_SESSION["Com_id"] == "" ? $_SESSION["UNAME"]:"관리자";
    $temp= explode("[",$_SESSION["UNAME"]); // 회원 명에 붙어 있는 등급을 빼준다.
    $U_name = $temp[0];

    $inst_FileIO = $this->inst_main->inst_FileIO;
    $inst_CForm = $this->inst_main->inst_CForm;
    $inst_Lupdate = $this->inst_main->inst_Lupdate;
    $inst_SelectDisplay = $this->inst_main->inst_SelectDisplay;
    $inst_query			=	new Board_query($this->DataBase);	// 게시판 쿼리 관련 클래스
    $inst_location		=	new Location_Control();         // location관련 클래스
    $inst_html				=  new Html();                    // Html 관련 클래스
    $inst_StringCon	=	new String_Con();                 // 문자열 컨트롤 클래스 로딩
    $inst_auth				=	new Auth();                     // 게시물 접근 권한 관련
    $inst_otm				=	new Board_output_template();      // output 클래스
    $oFCKeditor = new FCKeditor('Contents') ;           // html 텍스트 에디터 클래스
    $inst_query->CP_CODE = $this->inst_main->CP_CODE;   // 쿼리에서 사용할 CP_CODE

    // 테이블 깨는놈들 필터 및 이미지 테그에 테이블 깨짐방지 스크립트 추가
    $_POST[Title] = $inst_StringCon->Guard_table($_POST[Title],"","");
    $_POST[Contents] = $inst_StringCon->Guard_table($_POST[Contents],"","");
    $_POST[Comment] = $inst_StringCon->Guard_table($_POST[Comment],"","");

    // 검색 할 때 검색 키를 변환해서 검색해준다.
    if($Field!='Writer_name'){$Key = $inst_StringCon->Guard_table($Key,"","");}
    else{$Key = $inst_StringCon->clear_text($Key);}

		//	상품문의, 상품후기 어드민에서 작성가능여부 체크 - admin_class 에도 있음 : 2011-06-22 정수진
		if($_SESSION["SelfHugi"]=='on') { $this->AdminBoardWriteCheck = 'Y'; }
		else { $this->AdminBoardWriteCheck = 'N'; }

    //$this->inst_String = &$inst_StringCon;
	// 상품문의 게시판은 마이페이지 내에서 보이도록 설정 2012-02-14 남형진
	if($_SESSION[U_ID] == "" && $table_name == "Board_goods_qna") {
		$_GET['path'] = "mypage";
		$_POST['path'] = "mypage";	
	}

    switch($baction){

      //  테이블 생성
      case "create" :

        if($_POST[board_state] == "goods_qna" || $_POST[board_state] == "goods_after") {
          $section = "good";
        } elseif($_POST[board_state] == "gongji") {
          $section = "gongji";
        } else {
          $section = "normal";
        }

        // 게시판 목록 테이블이 없으면 생성해준다.
        $inst_query->Create_board_list($mysql);
        // 게시판 테이블 생성 및 게시판 목록에 등록
        $result = $inst_query->Create_table($section,$_POST,$mysql);
        Return $result;
        //$inst_location->top_reload();
      break;

      // 코멘트 삭제
      case "comdele" :

        $table = $_GET[table_name]."_c";

        // 만약 데이터가 많아 져서 부하를 주게 된다면 이부분을 삭제하고 대체 한다.
        $query	=	"SELECT * FROM $this->DataBase.$table WHERE B_no	=	'$_GET[No]' and C_no='$_GET[Cno]' ";
        $data		=	$mysql->fetch_key($query);

        // 자신의 게시물일 경우 삭제
        if($data[c_id][0]==$U_id){
          $query = "delete from $this->DataBase.$table where B_no	=	'$_GET[No]' and C_no='$_GET[Cno]' and C_ID='$_GET[ID]' ";
          $mysql->execute($query);
        }

        // action ==> view
        $inst_location->go($inst_output->self_page."?action=Board&baction=view&table_name=$_GET[table_name]&section=$section&No=$_GET[No]&as=$_GET[as]&path=$_GET[path]&b_title=$_GET[b_title]");
      break;

      //  파일 삭제
      case "filedelete" :

        $B_no =	$_POST["No"];
        $inst_filelist = new File_list(); // 파일 목록 출력 클래스 인스턴스

        // Delete_file_repl 의 배열 형식에 맞추기위해서 배열에 키값으로 지정
        $_POST["filename"][0] = substr($_POST["delstring"],0,strlen($_POST["delstring"])-1);

        // 글로벌 변수인 $this->Tmp_delfiles에 삭제할 파일명 할당.
        $this->Delete_file_repl($_POST);

        // 파일 삭제
        $this->Delete_file($this->Tmp_delfiles,$U_id);

        // 업데이트할 파일문자열
        $update_files = $inst_filelist->Sep_strings($_POST);

        if($table_name=='Board_review') { $field_name = "G_code"; }
        else { $field_name = 'Filename';}

        // 최종적으로 저장될 파일문자열을 업데이트해준다.
        $query = "UPDATE $this->DataBase.$table_name SET $field_name='$update_files' WHERE B_no='$B_no' AND Writer_id='$U_id'";
        $mysql->execute($query);

        // action ==> view
        $inst_location->go($inst_output->self_page."?action=Board&baction=edit&table_name=$table_name&section=$section&No=$B_no&as=$_POST[as]&path=$_POST[path]");
      break;

      // 조회 수
      // 따로 조회수 전용 모드가 작동하지 않을때는 view에서 그냥 카운트
      // 이걸 사용하려면 view 모드에서 조회올리기를 주석처리해야한다.
      case "ref" :

        $B_no			 =	$_GET["No"];
        $query	= "UPDATE $this->DataBase.$table_name SET ref = ref+1 WHERE B_no=$B_no ";
        $mysql->execute($query);

        // action ==> view
        $inst_location->go($inst_output->self_page."?action=Board&baction=view&table_name=$table_name&section=$section&No=$B_no&page=$page");
      break;

      // 수정 저장
      case "edit_save" :

        $inst_query->inst_FileIO = $inst_FileIO;
        $inst_query->inst_SelectDisplay = $inst_SelectDisplay;

        $B_no =	$_POST["No"];
        $FileCount = count($_FILES["AttFile"]["tmp_name"]); // 첨부된 파일의 개수

        // 첨부된 파일의 첫번째 파일명 (파일을 첨부하지 않은 경우에 이름이 null이 된다.)
        $ReceiveFileName	=	$_FILES["AttFile"]["tmp_name"][0];

        // ※ 첨부파일이 있을 경우
        // 파일 개수가 0보다 크고 첫번째 파일명이 null이 아닐경우 파일이 들어온것으로 처리
        if($FileCount > 0 && $ReceiveFileName!=""){
          // 파일을 등록해준다.
          $this->Upload_file($inst_query,$inst_output,$inst_location,$_POST,$_FILES,$FileCount,$mysql,$section,$table_name,$U_id,$baction);
        }
        // ※ 첨부파일이 없을 경우
        else{
          // 첨부파일 추가가 없을 경우에는 원래 파일목록 문자열을 할당.
          $_POST["update_filename"] = $_POST["originalfiles"];

          // 전송 받은 값과 , 쿼리용 인스턴스를 전달.
          $inst_query->Update_record($_POST,$mysql);
        }
        // action ==> view
        $inst_location->go($inst_output->self_page."?action=Board&baction=view&table_name=$table_name&section=$section&No=$B_no&as=$_POST[as]&path=$_POST[path]&b_title=$_POST[b_title]");
      break;

      // 답글 작성
      case "repl" :

        $tpl	= new Template_;
        $B_no	= $_GET["No"];

        // 쿼리
        $data	=	$inst_query->Select_view($mysql,$B_no,$table_name,$section,$inst_output->self_pager,$U_id,"link");

        $data[contents][0] = nl2br(urldecode($data[contents][0]));
        $data[title][0] = urldecode($data[title][0]);
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태

        $tpl->define('repl',$tpl_file);
        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data,'view');

        // 텍스트 에디터
        $oFCKeditor->BasePath	= '/fckeditor/';
        $oFCKeditor->Width  = '100%';
        $oFCKeditor->Height = '320px';
        $oFCKeditor->Value		= "";
        $tpl->assign('oFCKeditor',$oFCKeditor);
        $tpl->assign('inst_otm',$inst_otm);						// 템플릿용 output 클래스 인스턴스
        $tpl->assign('data',$data);	// 데이터 배열
        $tpl->assign('options_array',array($data["touser"][0],$data["charger"][0],$data["collaborator"][0],$data["start_time"][0],$data["end_time"][0]));	// 데이터 배열

        $tpl->assign('essential',
        array('section'=>$section,
        'baction'=>$baction,
        'table_name'=>$table_name,
        'U_id'=>$U_id,
        'U_name'=>$U_name,
        'page'=>$page,
        'path'=>$_GET[path],
        'b_title'=>urlencode($_GET[b_title]),
        'No'=>$B_no,
        'mysql'=>$mysql));  // 필수 변수들
        $tpl->print_('repl');

        flush();
      break;

      //  글 저장
      case "write_save" :


        // 이미지 형식 체크 : 리뷰는 이미지 파일만 받음
        if($table_name == "Board_review") {
          $tmp_o = @explode(".",$_FILES["AttFile"]["name"][0]);
          $tmp = array_pop($tmp_o);
          $tmp = strtolower($tmp);
          if(trim($_FILES["AttFile"]["name"][0])!="" && $tmp != "gif" && $tmp != "jpg") {
            $inst_location->msg_go($inst_output->self_page."?action=Board&baction=write&table_name=$table_name&section=$section&No=$B_no&b_title=$_POST[b_title]","파일 형식이 GIF or JPG인 이미지 파일을 입력해 주시기 바랍니다.");
            exit;
          }
        }

        // 로그인 안하고 쓰려고할때
        if(!$U_id){echo "로그인을 해주세요.";exit;}
        $FileCount	=	count($_FILES["AttFile"]["tmp_name"]); // 첨부된 파일의 개수

        // 첨부된 파일의 첫번째 파일명 (파일을 첨부하지 않은 경우에 이름이 null이 된다.)
        $ReceiveFileName	=	$_FILES["AttFile"]["tmp_name"][0];

        // ※ 첨부파일이 있을 경우
        // 파일 개수가 0보다 크고 첫번째 파일명이 null이 아닐경우 파일이 들어온것으로 처리
        if($FileCount > 0 && $ReceiveFileName!=""){
          // 파일을 등록해준다.
          $success	=	$this->Upload_file($inst_query,$inst_output,$inst_location,$_POST,$_FILES,$FileCount,$mysql,$section,$table_name,$U_id,$baction);
        }
        // ※ 첨부파일이 없을 경우
        else{
          $inst_query->inst_FileIO = $inst_FileIO;
          $inst_query->inst_SelectDisplay = $inst_SelectDisplay;

          // SMS 발송 : 2009-03-05 정수진
          /*
          if($table_name=='Board_one_qna'){
            if($_POST['thread']=='A'){ // 답글
              $List=array();
              $List[0] = 'qa_repl';
              $List[1] = $_POST['writer'];
              $data2 = $this->inst_main->inst_SelectMember->GetMemberSMS($List);
              $this->inst_main->inst_ExecuteMember->SendAutoSms(&$this->inst_main,$data2,6);
            } else {
              $List=array();
              $List[0] = 'qa_write';
              $List[1] = $_POST['writer'];
              $data2 = $this->inst_main->inst_SelectMember->GetMemberSMS($List);
              $this->inst_main->inst_ExecuteMember->SendAutoSms(&$this->inst_main,$data2,5);
            }
          }
          */
		  // 이메일 주소가 있으면 메일로 답변 보내기 2011-02-25 우형기 추가
		  if($_POST[email] != '') {

			 // 업체정보 2011-03-02 우형기
			 //$meminfo = $this->inst_main->inst_SelectMember->GetMemInfo($_SESSION[Com_id], 'ECHost');
			 $shopinfo = $this->inst_main->inst_SelectMember->Getshop_info($_SESSION[CP_CODE], 'EC_test');

			 $answer = urldecode($_POST[Contents]);
			 $answer = str_replace("\r","<p>",$answer);
			 $answer = str_replace("\n","<p>",$answer);
			 $subject  = urldecode($_POST[Title]);
			 $content  = "안녕하세요.<p>".$shopinfo[0][shop_name]." 입니다.<p>&nbsp;<p>";
			 $content .= "[질문]<p>";
			 $content .= $_POST[question]."<p>&nbsp;<p>";
			 $content .= "[답변]<p>";
			 $content .= $answer."<p>&nbsp;<p>\n";
			 $content .= " <a href='http://".$shopinfo[0][shop_url]."/?action=Detail&GoodsCode=".$_POST[GoodsCode]."'><b>[해당 상품 바로가기]</b></a>";
			 //								            보내는이메일,        보내는사람 이름,	받는이메일, 제목,    내용,
			 $this->inst_main->inst_SendMail->PutMail($shopinfo[0][admin_email], '관리자', $_POST[email], $subject, $content);

		  }

          $inst_query->Insert_record($inst_query,$inst_output,$inst_location,$_POST,$mysql,$section,$table_name,"nofile"); // 게시물만 등록
        }
      break;

      // 글 삭제
      case "dele" :

      $B_no			 =	$_GET["No"];
      $com_table = $table_name."_c";
      $admin		 =	$_GET["admin"];

      $query	=	"SELECT * FROM $this->DataBase.$table_name WHERE B_no='$B_no' ";
      $data		=	$mysql->fetch_key($query);

      $Writer		=	$data["writer_id"][0];

      //  리뷰게시판일경우 : 2009-01-13 일단...추가...ㅠㅠ 썅..
      if($table_name=='Board_review') {$Filename	=	$data["g_code"][0];}
      else {$Filename	=	$data["filename"][0];}

      $Thread	=	$data["thread"][0];
      $Fid			=	$data["fid"][0];

      // 파일 게시판일 경우에만
      if($section=="file" || $section=="good"){
        // 현재 레코드에 첨부된 모든 파일을 쿼리해온다 부모글이라면 자식글들의 첨부파일까지 쿼리해온다.
        $Repl_data	=	$inst_query->Query_reply_files($mysql,$Thread,$table_name,$Fid,$B_no);

        // 첨부파일들을 문자열로 만들어준다. 결과물은 글로벌 변수 $this->Tmp_delfiles 에 저장된다.
        $this->Delete_file_repl($Repl_data);
      }

      // 자기 게시물이 맞다면
      // $U_id==$Writer ||  제외처리. 어드민에서만 삭제가능하도록. CP_CODE와 로그인 아이디가 같을때만 삭제가능하도록 추가.: 2011-05-11 정수진 - 베로베 게시판 삭제 아무래도 이게원인으로 보임
      if($admin == "Y" && $_SESSION[U_ID]==$_SESSION[CP_CODE]){
      // if - 1 -start

        // 단계 1
        // 레코드와 댓글들을 삭제한다.
        $query	=	"DELETE FROM $this->DataBase.$table_name WHERE B_no	=	'$B_no' ";
        $Result1	=	$mysql->execute($query);
        // 댓글을 모두 삭제한다.
        $query	=	"DELETE FROM $this->DataBase.$com_table WHERE B_no	=	'$B_no' ";
        $mysql->execute($query);

        //  단계 2
        // 또 , 스레드가 A 라면 해당하는 Fid의 게시물을 모두 지워준다.
        if($Result1!= "" && $Thread=="A"){
          $query		=	"DELETE FROM $this->DataBase.$table_name WHERE Fid	=	'$Fid' ";
          $Result2	=	$mysql->execute($query);
        }

        // 공지사항 파일에 업데이트
        // DB로 전환 : 2011-03-02 정수진
        //if($table_name == "Board_gongji") {
        //  $inst_SelectDisplay->PopUpGongJi(&$inst_FileIO,'');
        //}

        // 단계 3
        // 파일이 등록 되어 있다면
        if($Result1== "Success" && $Filename!=""){

          // 파일을 삭제한다.
          /*
          $this->Tmp_delfiles 이놈은
          위에 $this->Query_reply_files 에서 가공되어서 원글 삭제시 하위 답글들 까지 모든 파일들을 삭제해준다.
          */
          $this->Delete_file($this->Tmp_delfiles,$U_id);
        }

      // if - 1 - end
      }
      else{echo "관리자만 삭제 할 수 있습니다.";exit;}

        # action ==> list
        $inst_location->go($inst_output->self_page."?action=Board&baction=list&table_name=$table_name&section=$section&as=$_GET[as]&path=$_GET[path]");
      break;

      // 내용 열람
      case "view" :
        $B_no			 =	$_GET["No"];
        $tpl = new Template_;

        // 조회수 업데이트
        $query	= "UPDATE $this->DataBase.$table_name SET ref = ref+1 WHERE B_no=$B_no ";
        $mysql->execute($query);

        //  첨부파일의 표시 타입 리턴 : 2009-01-13 박준형
        $file_view_type = $this->GetAddfileType($section,$table_name);

        // 쿼리
        $data	=	$inst_query->Select_view($mysql,$B_no,$table_name,$section,$inst_output->self_pager,$U_id,$file_view_type);
        $data[contents][0] = nl2br(urldecode($data[contents][0]));
        $data[title][0] = urldecode($data[title][0]);

        // 댓글 데이터
        $cdata	=	$inst_query->Select_comm($mysql,$B_no,$table_name);

        // 서브 리스트 데이터
        $data_sub = $inst_query->Select_sublist($mysql,$data[fid][0],$section,$table_name);

        // 템플릿 출력
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태

        $CP_CODE = $this->CP_CODE;
        if($_SESSION[CP_CODE] != "") { $CP_CODE = $_SESSION[CP_CODE]; }

        // 상품 리뷰 게시판용 데이터 처리 : 2009-01-13 박준형 수정
        if($table_name=="Board_review") {
          $img_string = @implode("<br>",$data[filename][filename]); //  출력용 이미지들
          $f_name = explode("|",$data[g_code][0]);
          $data[file_name][0] = $f_name[0];
          $Img_URL = Img_Domain."/".$CP_CODE."/Board";
        }
        else { $Img_URL = Img_Domain."/".$CP_CODE."/Goods"; }

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data,'view');
        $this->inst_BoardExtends->SwitchOPT(&$cdata);
        $this->inst_BoardExtends->SwitchOPT(&$data_sub[0]);

        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->define('view',$tpl_file);
        $tpl->assign('img_string',$img_string);
        $tpl->assign('inst_otm',$inst_otm);	// 템플릿용 output 클래스 인스턴스
        $tpl->assign('data',$data);	// 데이터 배열
        $tpl->assign('cdata',$cdata);	// 댓글 데이터 배열
        $tpl->assign('data_sub',$data_sub[0]);	// 서브리스트 데이터 배열
        $tpl->assign('data_sub_count',$data_sub[1]);	// 서브리스트 데이터 갯수
        $tpl->assign('inst_auth',$inst_auth);						// 권한 관련 클래스 인스턴스
        // 도메인 추가 : 2009-04-17 정수진
        if($_SESSION["udomain"]!='') { $userdomain = 'http://'.$_SESSION["udomain"]; }
        else { $userdomain = 'http://'.$_SESSION["surl"]; }
        $essential = array('section'=>$section,'baction'=>$baction,'table_name'=>$table_name,'U_id'=>$U_id,'U_name'=>$U_name,'page'=>$page,'Thread'=>$Thread,'Fid'=>$Fid,'No'=>$B_no,'mysql'=>$mysql,'b_title'=>urlencode($_GET[b_title]),'Img_URL'=>$Img_URL,'board_no'=>$_GET[board_no],'path'=>$_GET[path],'userdomain'=>$userdomain);

        $tpl->assign('essential',$essential);  // 필수 변수들
        $tpl->print_('view');

        flush();
      break;

      case "viewpa" : // 본사 공지사항용도 추가 : 2011-02-18 정수진
        $B_no			 =	$_GET["No"];
        $tpl = new Template_;

        //  본사공지 조회 업데이트
        $this->inst_main->inst_ExecuteDisplay->UpdateGongji($B_no);

        // 쿼리
        $data	=	$this->inst_main->inst_SelectDisplay->PrintGongji(1,$B_no);

        // 템플릿 출력
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태

        $CP_CODE = $_SESSION[CP_CODE] != "" ? $_SESSION[CP_CODE] : $this->CP_CODE;

        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->define('view',$tpl_file);
        $tpl->assign('img_string',$img_string);
        $tpl->assign('inst_otm',$inst_otm);	// 템플릿용 output 클래스 인스턴스
        $tpl->assign('data',$data[0]);	// 데이터 배열
        $tpl->assign('inst_auth',$inst_auth);						// 권한 관련 클래스 인스턴스
        $essential = array('section'=>$section,'baction'=>$baction,'page'=>$page,'Thread'=>$Thread,'Fid'=>$Fid,'No'=>$B_no,'mysql'=>$mysql,'b_title'=>urlencode($_GET[b_title]),'board_no'=>$_GET[board_no],'path'=>$_GET[path]);
        $tpl->assign('essential',$essential);  // 필수 변수들
        $tpl->print_('view');

        flush();
      break;

      // 내용 열람
      case "viewSet" :
        $B_no			 =	$_GET["nb"];
        $G_code    =  $_GET["GoodsCode"];
        $tpl = new Template_;

        // 조회수 업데이트
        $query	= "select * from $this->DataBase.$table_name WHERE Fid in(select Fid from $this->DataBase.$table_name WHERE B_no=$B_no)";
        $data	=	$mysql->fetch($query);

        echo "<script>";

        $tt_view = "";
        $re_view = "";
        foreach($data as $key=>$val) {

          if($val[b_no] == $B_no && $val[thread] == 'A') {
			if($val[secret] == "") {
				$tt_view = "
				  parent.document.getElementById('sView_${B_no}').style.display = 'none';
				  parent.document.getElementById('rcView_${B_no}').style.display = '';
				  ";
				  $re_view = "문의 : ".str_replace("\n","<br>",str_replace("\r","",$val[contents]))."<br>";
			} else {
				if($val[secret] != $_GET["pw"]) {
				  echo "alert('비밀번호가 맞지 않습니다');";
				  break;
				}else{
				  $tt_view = "
				  parent.document.getElementById('sView_${B_no}').style.display = 'none';
				  parent.document.getElementById('rcView_${B_no}').style.display = '';
				  ";
				  $re_view = "문의 : ".str_replace("\n","<br>",str_replace("\r","",$val[contents]))."<br>";

				}
			}

          }elseif($val[thread] == 'AA') {

            if(is_array($data)) {
              $re_view .= "답변 : ".str_replace("\n","<br>",str_replace("\r","",urldecode($val[contents])));
              $tt_view .= "
              parent.document.getElementById('rtData_${B_no}').innerHTML= '".urldecode($val[title])."';
              parent.document.getElementById('rtdData_${B_no}').innerHTML= '".$val[regi_date]."'; // 답변 날짜
              parent.document.getElementById('rtView_${B_no}').style.display = '';
              parent.document.getElementById('rcView_${B_no}').style.display = '';
              ";
            }
          }
        }

		    echo "$('.sview').hide();";
        echo $tt_view;
        echo "parent.document.getElementById('rcData_${B_no}').innerHTML= '$re_view';";
        echo "</script>";

        flush();
      break;

      // 내용 수정
      case "edit" :

        $B_no			 =	$_GET["No"];
        // 쿼리
        $data	=	$inst_query->Select_view($mysql,$B_no,$table_name,$section,$inst_output->self_pager,$U_id,"file");
        $data[contents][0] = nl2br(urldecode($data[contents][0]));
        $data[title][0] = urldecode($data[title][0]);
        $inst_filelist = new File_list(); // 파일 목록 출력 클래스
        $tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('edit',$tpl_file);
        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data,'view');

        //  첨부된 파일 갯수
        $have_file_count = count($data[filename][filename]);

        // 텍스트 에디터
        $oFCKeditor->BasePath	= '/fckeditor/';
        $oFCKeditor->Width  = '100%';
        $oFCKeditor->Height = '420px';
        $oFCKeditor->Value		= $data[contents][0];
        $tpl->assign('oFCKeditor',$oFCKeditor);
        $tpl->assign('have_file_count',$have_file_count);
        $tpl->assign('inst_otm',$inst_otm);  // 템플릿용 output 클래스 인스턴스
        $tpl->assign('inst_filelist',$inst_filelist); // 파일 목록 관련
        $tpl->assign('data',$data);	// 데이터 배열
        $tpl->assign('options_array',array($data["touser"][0],$data["charger"][0],$data["collaborator"][0],$data["start_time"][0],$data["end_time"][0]));	// 데이터 배열
        $tpl->assign('essential',
        array('section'=>$section,
        'baction'=>$baction,
        'table_name'=>$table_name,
        'U_id'=>$U_id,
        'U_name'=>$U_name,
        'U_Level'=>$U_Level,
        'page'=>$page,
        'No'=>$B_no,
        'Thread'=>$Thread,
        'Fid'=>$Fid,
        'path'=>$_GET[path],
        'b_title'=>urlencode($_GET[b_title]),
        'g_sati'=>$data["g_sati"][0],
        'g_code'=>$data["g_code"][0],
        'mysql'=>$mysql));  // 필수 변수들
        $tpl->print_('edit');

        flush();
      break;

      // 글 작성
      case "write" :

        if($_GET[table_name] == "Board_goods_qna") {
          $section = "good";
        }

        $tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('write',$tpl_file);

        // 텍스트 에디터
        $oFCKeditor->BasePath	= '/fckeditor/';
        $oFCKeditor->Width  = '100%';
        $oFCKeditor->Height = '420px';
        $oFCKeditor->Value		= $data[contents][0];

        $action = $_GET[path] == "mypage" ? "MyBoard":"Board";

        $Img_URL = Img_Domain."/".$this->CP_CODE."/Goods";
        $goods_info = $inst_query->GetGoods_img($_GET[GoodsCode],$mysql);

        $tpl->assign('oFCKeditor',$oFCKeditor);
        $tpl->assign('inst_otm',$inst_otm);						// 템플릿용 output 클래스 인스턴스
        $tpl->assign('essential',
        array('section'=>$section,
        'baction'=>$baction,
        'table_name'=>$table_name,
        'U_id'=>$U_id,
        'U_name'=>$U_name,
        'U_Level'=>$U_Level,
        'page'=>$page,
        'Thread'=>$Thread,
        'Fid'=>$Fid,
        'GoodsCode'=>$_GET[GoodsCode],
        'GoodsImg'=>$Img_URL.'/'.$goods_info[file_name][0],
        'GoodsName'=>$goods_info[goods_name][0],
        'path'=>$_GET[path],
        'Action'=>$action,
        'b_title'=>urlencode($_GET[b_title]),
        'mysql'=>$mysql));  // 필수 변수들
        $tpl->print_('write');

        flush();
      break;

			// 리스트 팝업
			case "listPop" :

				if(!$_GET["Goods_Code"]) {
					echo "상품 코드를 찾을 수 없습니다.";
					exit;
				}
				$code = $_GET["Goods_Code"];
				$tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('list',$tpl_file);
        $JSURL = $inst_html->Print_js(JSURL); # html 헤드
        $tpl->assign('JSURL',$JSURL);
        $tpl->assign('inst_CForm',$inst_CForm);
        $tpl->assign('inst_Lupdate',$inst_Lupdate);
        $path = $_GET[path]!="" ? $_GET[path] : $_POST[path];

        $su = "";
        // CommonMenu[Board_list] 파일 DB로 변경 : 2011-03-03 정수진
        $CommonMenu_Board_list = $this->inst_main->inst_SelectDisplay->GetBoardlistInfo();
        if($CommonMenu_Board_list[Board_list][table_name] != "") {
          $k = array_search($_GET[table_name],$CommonMenu_Board_list[Board_list][table_name]);
          //$su = $this->inst_main->CommonMenu[Board_list][Paging][$k];
          $su = 10;
        }

        // MyPage 게시판은 자기가 작성한것만 쿼리
        $UID = $param_add = "";
        $action = "Board";

        if($path == "mypage") {
          $UID = $_SESSION[UID];
          $action = "MyBoard";
          $this->inst_main->Mode = "";
          $param_add = "&path=mypage";
        }
        else { $param_add = "&as=".$this->inst_main->Mode; }

        //------------------------------------------------------Paging----------------------------------------------------//
        $param				=	sprintf("section=%s&action=$action&baction=%s&table_name=%s&Field=%s&Key=%s&paging=%s",$section,$baction,$table_name,$Field,$Key,$su).$param_add;
        $inst_page		=	new BoardPage($su,$su); // 리스트 개수, 리스트 블록 수
        $page_query	=	$inst_query->Get_pagecount2($table_name,$Field,$Key,$UID,$code); // 페이징용 전체 게시물 개수 쿼리문
        $total =	 $inst_page->get_total($page_query,$mysql);					// 페이징용 전체 게시물 개수 쿼리
        $inst_page->get_value($total,$page,$_SERVER["PHP_SELF"]," ",$param);
        $limit					=	$inst_page->get_limt();
        $tpl->assign('inst_page',$inst_page);		// 페이징 클래스 인스턴스
        //------------------------------------------------------Paging----------------------------------------------------//

        // 검색어가 있을경우만 전체보기 버튼 출력
        if(!$Key){$total_view	=	"";}

        // 아이콘이 없어서 일단 주석
       // else{$total_view = $inst_otm->Print_button("Total","onclick = \"total_listview('$this->self_page','$section','$table_name','$baction');\"");}

        // 검색된 레코드가 없을때.
        if($total==0 && $Key!=""){$inst_location->msg_go($inst_otm->self_page."?section=$section&table_name=$table_name&action=$action&path=$path&baction=$baction&as=$_POST[as]","검색된 게시물이 없습니다.");}
        else if($total==0){}

        // Select 쿼리 [0번째 놈은 패치 데이터 , 1번째 놈은 레코드 개수]
        $data_array	=	$inst_query->Select_list($inst_query->Make_list_field($section,$table_name,$limit,$Field,$Key,$UID,$code),$mysql);

				// 게시판 설정 가져오기 2011-05-06 우형기 추가
				$data = $this->inst_main->inst_SelectDisplay->GetBoardList($this->inst_main->CP_CODE,'0,10',"Board_goods_qna");

				// 회사정보 불러오기 2011-05-06 우형기 추가
				$com_info = $this->inst_main->inst_SelectDisplay->GetCompanyInfo($this->inst_main->CP_CODE,"com_information");
				$com_data = unserialize($com_info[t_contents][0]);

				$CP_CODE = $this->CP_CODE;
        if($_SESSION[CP_CODE] != "") {
          $CP_CODE = $_SESSION[CP_CODE];
        }

        // 게시판 no
        $board_no = $inst_page->total - ($inst_page->page-1) * $inst_page->block_set;

        if($table_name=="Board_review") {
          // 상품 리뷰 게시판용 상품이미지 경로
          for($i=0; $i<sizeof($data_array[0]); $i++) {
            $f_name = explode("|",$data_array[0][$i][g_code]);
            $data_array[0][$i][file_name] = $f_name[0];
          // loop - End
          }
          $Img_URL = Img_Domain."/".$CP_CODE."/Board";
        }
        else { $Img_URL = Img_Domain."/".$CP_CODE."/Goods"; }

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data_array[0]);

				// 2011-05-06 우형기 추가 답변시 원하는 문구로 답변.
				if($data[0][title_name][0] != "" || $data_array[1] >1) {
					for($i=0; $i<$data_array[1]; $i++) {
						if($data_array[0][$i][thread] == 'AA' && $data[0][title_name][0] !='' ) {
							$answer_title[$i] = str_replace('{_writer}',$data_array[0][$i-1][writer_name],$data[0][title_name][0]);
							$answer_title[$i] = str_replace('{_shopname}',$com_data[shop_name],$answer_title[$i]);
						}
					// loop - End
					}
				}

				if($data[0][name_img][0] != "") {
					$admin_name = "<img src='".Img_Domain."/".$CP_CODE."/Board/".$data[0][name_img][0]."' /> ";
				} else if($data[0][admin_name][0] != "") {
					$admin_name = $data[0][admin_name][0];
				} else {
					$admin_name = "관리자";
				}

        $tpl->assign('trlist',$data_array[0]);					// tr리스트 -> record set
        $tpl->assign('answer_title',$answer_title);					//  2011-05-06 우형기 추가
        $tpl->assign('admin_name',$admin_name);					//  2011-05-06 우형기 추가
				$tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->assign('inst_otm',$inst_otm);						// 템플릿용 output 클래스 인스턴스
        $tpl->assign('inst_auth',$inst_auth);						// 권한 관련 클래스 인스턴스
        $tpl->assign('viewTotal',$data_array[1]);						// 권한 관련 클래스 인스턴스
        $tpl->assign('essential',array('section'=>$section,'baction'=>$baction,'table_name'=>$table_name,'U_id'=>$U_id,'total_view'=>$total_view,'Img_URL'=>$Img_URL,'path'=>$path,'b_title'=>urlencode($_GET[b_title]),'board_no'=>$board_no));  // 필수 변수들
        $tpl->print_('list');

        flush();

			break;

      // 리스트
      case "list" :

		if( $table_name == "Board_one_qna" ) { return ""; }

        $tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('list',$tpl_file);
        $JSURL = $inst_html->Print_js(JSURL); # html 헤드
        $tpl->assign('JSURL',$JSURL);
        $tpl->assign('inst_CForm',$inst_CForm);
        $tpl->assign('inst_Lupdate',$inst_Lupdate);
        $path = $_GET[path]!="" ? $_GET[path] : $_POST[path];

        $su = "";
        // CommonMenu[Board_list] 파일 DB로 변경 : 2011-03-03 정수진
        $CommonMenu_Board_list = $this->inst_main->inst_SelectDisplay->GetBoardlistInfo();
        if($CommonMenu_Board_list[Board_list][table_name] != "") {
          $k = array_search($_GET[table_name],$CommonMenu_Board_list[Board_list][table_name]);
          //$su = $this->inst_main->CommonMenu[Board_list][Paging][$k];
          $su = 10;
        }

        // MyPage 게시판은 자기가 작성한것만 쿼리
        $UID = $param_add = "";
        $action = "Board";

        if($path == "mypage") {
          $UID = $_SESSION[UID];
          $action = "MyBoard";
          $this->inst_main->Mode = "";
          $param_add = "&path=mypage";
        }
        else { $param_add = "&as=".$this->inst_main->Mode; }

        //------------------------------------------------------Paging----------------------------------------------------//
        $param				=	sprintf("section=%s&action=$action&baction=%s&table_name=%s&Field=%s&Key=%s&paging=%s",$section,$baction,$table_name,$Field,$Key,$su).$param_add;
        $inst_page		=	new BoardPage($su,$su); // 리스트 개수, 리스트 블록 수
        $page_query	=	$inst_query->Get_pagecount($table_name,$Field,$Key,$UID); // 페이징용 전체 게시물 개수 쿼리문
        $total =	 $inst_page->get_total($page_query,$mysql);					// 페이징용 전체 게시물 개수 쿼리
        $inst_page->get_value($total,$page,$_SERVER["PHP_SELF"]," ",$param);
        $limit					=	$inst_page->get_limt();
        $tpl->assign('inst_page',$inst_page);		// 페이징 클래스 인스턴스
        //------------------------------------------------------Paging----------------------------------------------------//

        // 검색어가 있을경우만 전체보기 버튼 출력
        if(!$Key){$total_view	=	"";}

        // 아이콘이 없어서 일단 주석
       // else{$total_view = $inst_otm->Print_button("Total","onclick = \"total_listview('$this->self_page','$section','$table_name','$baction');\"");}

        // 검색된 레코드가 없을때.
        if($total==0 && $Key!=""){$inst_location->msg_go($inst_otm->self_page."?section=$section&table_name=$table_name&action=$action&path=$path&baction=$baction&as=$_POST[as]","검색된 게시물이 없습니다.");}
        else if($total==0){}

        // Select 쿼리 [0번째 놈은 패치 데이터 , 1번째 놈은 레코드 개수]
        $data_array	=	$inst_query->Select_list($inst_query->Make_list_field($section,$table_name,$limit,$Field,$Key,$UID),$mysql);

				// 게시판 설정 가져오기 2011-05-06 우형기 추가
				$data = $this->inst_main->inst_SelectDisplay->GetBoardList($this->inst_main->CP_CODE,'0,10',"Board_goods_qna");

				// 회사정보 불러오기 2011-05-06 우형기 추가
				$com_info = $this->inst_main->inst_SelectDisplay->GetCompanyInfo($this->inst_main->CP_CODE,"com_information");
				$com_data = unserialize($com_info[t_contents][0]);

				$CP_CODE = $this->CP_CODE;
        if($_SESSION[CP_CODE] != "") {
          $CP_CODE = $_SESSION[CP_CODE];
        }

        // 게시판 no
        $board_no = $inst_page->total - ($inst_page->page-1) * $inst_page->block_set;

        if($table_name=="Board_review") {
          // 상품 리뷰 게시판용 상품이미지 경로
          for($i=0; $i<sizeof($data_array[0]); $i++) {
            $f_name = explode("|",$data_array[0][$i][g_code]);
            $data_array[0][$i][file_name] = $f_name[0];
          // loop - End
          }
          $Img_URL = Img_Domain."/".$CP_CODE."/Board";
        }
        else { $Img_URL = Img_Domain."/".$CP_CODE."/Goods"; }

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data_array[0]);

				// 2011-05-06 우형기 추가 답변시 원하는 문구로 답변.
				if($data[0][title_name][0] != "" || $data_array[1] >1) {
					for($i=0; $i<$data_array[1]; $i++) {
						if($data_array[0][$i][thread] == 'AA' && $data[0][title_name][0] !='' ) {
							$answer_title[$i] = str_replace('{_writer}',$data_array[0][$i-1][writer_name],$data[0][title_name][0]);
							$answer_title[$i] = str_replace('{_shopname}',$com_data[shop_name],$answer_title[$i]);
						}
					// loop - End
					}
				}

				if($data[0][name_img][0] != "") {
					$admin_name = "<img src='".Img_Domain."/".$CP_CODE."/Board/".$data[0][name_img][0]."' /> ";
				} else if($data[0][admin_name][0] != "") {
					$admin_name = $data[0][admin_name][0];
				} else {
					$admin_name = "관리자";
				}

        $tpl->assign('trlist',$data_array[0]);					// tr리스트 -> record set
        $tpl->assign('answer_title',$answer_title);					//  2011-05-06 우형기 추가
        $tpl->assign('admin_name',$admin_name);					//  2011-05-06 우형기 추가
				$tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->assign('inst_otm',$inst_otm);						// 템플릿용 output 클래스 인스턴스
        $tpl->assign('inst_auth',$inst_auth);						// 권한 관련 클래스 인스턴스
        $tpl->assign('essential',array('section'=>$section,'baction'=>$baction,'table_name'=>$table_name,'U_id'=>$U_id,'total_view'=>$total_view,'Img_URL'=>$Img_URL,'path'=>$path,'b_title'=>urlencode($_GET[b_title]),'board_no'=>$board_no));  // 필수 변수들
        $tpl->print_('list');

        flush();
      break;

      // 리스트
      case "listpa" :

        $tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('list',$tpl_file);
        $JSURL = $inst_html->Print_js(JSURL); # html 헤드
        $tpl->assign('JSURL',$JSURL);
        $tpl->assign('inst_CForm',$inst_CForm);
        $tpl->assign('inst_Lupdate',$inst_Lupdate);
        $path = $_GET[path]!="" ? $_GET[path] : $_POST[path];

        // MyPage 게시판은 자기가 작성한것만 쿼리
        $UID = $param_add = "";
        $action = "Board";
        $param_add = "&as=".$this->inst_main->Mode;

        //  전체갯수
        $total_temp = $this->inst_main->inst_SelectDisplay->PrintGongji("total",'');

        //------------------------------------------------------Paging----------------------------------------------------//
        $param				=	sprintf("section=%s&action=$action&baction=%s&paging=%s",$section,$baction,10).$param_add;
        $inst_page		=	new BoardPage(10,10); // 리스트 개수, 리스트 블록 수
        $total        =	$total_temp[0][count][0];					// 페이징용 전체 게시물 개수 쿼리
        $inst_page->get_value($total,$page,$_SERVER["PHP_SELF"]," ",$param);
        $limit					=	$inst_page->get_limt();
        $tpl->assign('inst_page',$inst_page);		// 페이징 클래스 인스턴스
        //------------------------------------------------------Paging----------------------------------------------------//

        // Select 쿼리 [0번째 놈은 패치 데이터 , 1번째 놈은 레코드 개수]
        $data_array = $this->inst_main->inst_SelectDisplay->PrintGongji("all","","$inst_page->limit_no , $inst_page->page_set");

        $CP_CODE = $_SESSION[CP_CODE] != "" ? $_SESSION[CP_CODE] : $this->CP_CODE;

        // 게시판 no
        $board_no = $inst_page->total - ($inst_page->page-1) * $inst_page->block_set;
        $tpl->assign('trlist',$data_array[0]);					// tr리스트 -> record set
        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->assign('inst_otm',$inst_otm);						// 템플릿용 output 클래스 인스턴스
        $tpl->assign('inst_auth',$inst_auth);						// 권한 관련 클래스 인스턴스
        $tpl->assign('essential',array('section'=>$section,'baction'=>$baction,'path'=>$path,'b_title'=>urlencode($_GET[b_title]),'board_no'=>$board_no));  // 필수 변수들
        $tpl->print_('list');

        flush();
      break;

      //  댓글 등록
      case "addcom" :

       $B_no =	$_POST["No"];
       $C_ID =   	$_POST["U_id"];
       $C_Name = $_POST["U_name"];
       $Comment = $_POST["Comment"];
       $section = $_POST["section"];
       $table_name = $_POST["table_name"];
       $table = $table_name."_c";

        $query = "INSERT INTO $this->DataBase.$table( `B_no` , `C_ID` , `C_Name` , `Regi_date` , `Comment` ) VALUES ('$B_no', '$C_ID', '$C_Name', NOW( ) , '$Comment');";
        $mysql->execute($query);

        # action ==> view
        $inst_location->go($inst_output->self_page."?action=Board&baction=view&No=$B_no&table_name=$table_name&section=$section&as=$_POST[as]&path=$_POST[path]&b_title=$_POST[b_title]");

      break;

      //  문의 등록
      case "add" :
/*
			 // 지엠스팸프리 검사
			 include './zmSpamFree/zmSpamFree.php';
			 if ( !zsfCheck( $_POST['zsfCode'] ) )
			 {
			   $inst_location->msg_go($inst_output->self_page."?action=Detail&GoodsCode=$_POST[GoodsCode]","스팸차단코드를 정확히 입력해 주십시오.");
				 exit;
			 }

*/
       $UID			= $_SESSION[UID];
	   $Title		= $_POST["title"];
       $Writer_name = $_POST["writer"];
       $Contents	= $_POST["content"];
       $G_code		= $_POST["GoodsCode"];

       $Secret		= $_POST["pw"];
       $Touser		= $_POST["open"];
       $email		= $_POST["email"] != "" ? $_POST["email"] : "";
       $user_ip		= $_SERVER['REMOTE_ADDR'];
       $table		= "Board_goods_qna";

       $query	=	"SELECT `Fid` FROM $this->DataBase.$table order by `Fid` desc limit 1";
       $data	=	$mysql->fetch($query);

       $Fid = $data[0]['fid']+1;

       if($Title != "" || $Contents != "") {
			$query = "INSERT INTO $this->DataBase.$table( `Title` , `Writer_id`, `Writer_name` , `Regi_date` , `Contents` , `G_code` , `Fid` , `Touser` ,  `Secret`, `email`, `user_ip` ) VALUES ('$Title', '$UID', '$Writer_name', NOW( ) , '$Contents' , '$G_code' , '$Fid' , '$Touser', '$Secret', '$email','$user_ip');";
			$mysql->execute($query);
       }

       # action ==> view
       $inst_location->go($inst_output->self_page."?action=Detail&GoodsCode=$G_code");

      break;

			//  후기 등록 2011-07-19 우형기
      case "add_hugi" :

			 // 지엠스팸프리 검사
			 include './zmSpamFree/zmSpamFree.php';
			 if ( !zsfCheck( $_POST['spCode'] ) )
			 {
			   $inst_location->msg_go($inst_output->self_page."?action=Detail&GoodsCode=$_POST[GoodsCode]","스팸차단코드를 정확히 입력해 주십시오.");
				 exit;
			 }

			 $regi_date = date('Y-m-d H:i:s');
       $writer			= $_POST["title"];
       $contents	= $_POST["content"];
       $G_code		= $_POST["GoodsCode"];
			 $goods_name = $_POST["GoodsName"];
       $table		  = "Board_goods_review";
			 $rate      =  $_POST["rate"];

			 if($writer != "" || $contents != "") {
				$query = "INSERT INTO $this->DataBase.$table( regi_date , contents ,  writer , rate , goods_code , goods_name , type,  state ) VALUES ('$regi_date', '$contents', '$writer', $rate , '$G_code' , '$goods_name' , 'ADMIN' , '0');";
				$mysql->execute($query);
			 }

       # action ==> view
       $inst_location->go($inst_output->self_page."?action=Detail&GoodsCode=$G_code");

      break;

	  //  상품후기
      case "hugi" :

        $tpl = new Template_;
        $tpl_file = $inst_otm->Output_changer($baction,$section); // $baction_$section.tpl <== 이런 형태
        $tpl->define('list',$tpl_file);
        $JSURL = $inst_html->Print_js(JSURL); # html 헤드
        $tpl->assign('JSURL',$JSURL);
        $tpl->assign('inst_CForm',$inst_CForm);
        $tpl->assign('inst_Lupdate',$inst_Lupdate);

				//	상품문의, 후기 어드민작성 가능여부 : 2011-06-22 정수진
		    $tpl->assign('AdminBoardWriteCheck',$this->AdminBoardWriteCheck);

		// MyPage 게시판은 자기가 작성한것만 쿼리
        $UID = $param_add = "";
        $action = "Board";
        $param_add = "&as=".$this->inst_main->Mode;

        //  전체갯수
        $total_temp = $this->inst_main->inst_SelectDisplay->GetHugiList();

        //------------------------------------------------------Paging----------------------------------------------------//
        $param		  =	sprintf("section=%s&action=$action&baction=%s&paging=%s",$section,$baction,10).$param_add;
        $inst_page	  = new BoardPage(10,10); // 리스트 개수, 리스트 블록 수
        $total        =	$total_temp[1];					// 페이징용 전체 게시물 개수 쿼리
        $inst_page->get_value($total,$page,$_SERVER["PHP_SELF"]," ",$param);
        $limit		  =	$inst_page->get_limt();
        $tpl->assign('inst_page',$inst_page);		// 페이징 클래스 인스턴스
        //------------------------------------------------------Paging----------------------------------------------------//

        // Select 쿼리 [0번째 놈은 패치 데이터 , 1번째 놈은 레코드 개수]
        $data_array	=	$this->inst_main->inst_SelectDisplay->GetHugiList("$inst_page->limit_no , $inst_page->page_set");

        // 게시판 no
        $board_no = $inst_page->total - ($inst_page->page-1) * $inst_page->block_set;
				$CP_CODE = $_SESSION[CP_CODE] != "" ? $_SESSION[CP_CODE] : $this->CP_CODE;

        // 상품 리뷰 게시판용 상품이미지 경로
        for($i=0; $i<sizeof($data_array[0][number]); $i++) {
						$goods_code = $data_array[0][goods_code][$i];
						$data_array[0][path][$i] = "http://".$_SESSION[udomain]."/?action=Detail&GoodsCode=".$goods_code;
            $data_array[0][file_name][$i] = $this->inst_main->inst_SelectGoods->Get_GoodsImageInfo($goods_code);
          // loop - End
         }

				$Img_URL = Img_Domain."/".$CP_CODE."/Goods";

        //  출력정보 변경 2009-02-02 박준형
        //  관리자 에서 설정한 내용대로 변환해줌
        $this->inst_BoardExtends->SwitchOPT(&$data_array[0]);

        $tpl->assign('trlist',$data_array[0]);	// tr리스트 -> record set
        $tpl->assign('inst_StringCon',$inst_StringCon);	// 문자열 컨트롤 클래스 인스턴스
        $tpl->assign('inst_otm',$inst_otm);				// 템플릿용 output 클래스 인스턴스
        $tpl->assign('inst_auth',$inst_auth);			// 권한 관련 클래스 인스턴스
        $tpl->assign('essential',array('section'=>$section,'baction'=>$baction,'table_name'=>$table_name,'total_view'=>$total_view,'Img_URL'=>$Img_URL,'path'=>$path,'b_title'=>urlencode($_GET[b_title]),'board_no'=>$board_no));  // 필수 변수들
        $tpl->print_('list');

        flush();

      break;

	  // 상품평 지우기
	  case "DelReview" :

			// 삭제할 상품 리스트를 배열로
      $Goods_list = explode("|",$_POST[Str_list]);

      //  배열에서 널값 삭제
      Nulldel(&$Goods_list);

			$Array_in = $inst_Lupdate->ArrayToQuery($Goods_list,0);

			$query = "DELETE FROM $this->DataBase.Board_goods_review WHERE number IN(".$Array_in.");";
      $result = $mysql->execute($query);
			$Msg = "삭제 되었습니다.";
      $inst_location->msg_go($inst_output->self_page."?baction=hugi&section=list&table_name=$table_name&as=BoardMan",$Msg);

	  break;

	  // 상품평 노출 변경
	  case "ReviewState" :

			// 넘어온 상태 변경
			if($_POST[Toggle_value] == 0) {
				$state = 1;
			} else{
				$state = 0;
			}

			$query = "update $this->DataBase.Board_goods_review set state='".$state."' where number = '".$_POST[Code_value]."' ";
      $result = $mysql->execute($query);
      $inst_location->go($inst_output->self_page."?baction=hugi&section=list&table_name=$table_name&as=BoardMan");

	  break;

      //  베스트 후기 수정
      case "best_ok" :

        $B_no =	$_GET["no"];
        $best = $_GET["best_ok"];
        $table_name = $_GET["table_name"];
        $query = "update $this->DataBase.$table_name set best_ok='$best',Tag='1'  where b_no='$B_no';";
        $result = $mysql->execute($query);
         # action ==> view
        $inst_location->go($inst_output->self_page."?baction=list&section=good&table_name=$table_name&as=BoardMan");

      break;

      //  top 수정
      case "top" :

        $B_no =	$_GET["no"];
        $top = $_GET["top"];
        $table_name = $_GET["table_name"];
        $query = "update $this->DataBase.$table_name set top='$top' where b_no='$B_no';";
        $result = $mysql->execute($query);
        if($table_name=='Board_gongji') { $inst_location->go($inst_output->self_page."?baction=list&section=gongji&table_name=$table_name&as=BoardMan"); }
        # action ==> view
        else { $inst_location->go($inst_output->self_page."?baction=list&section=good&table_name=$table_name&as=BoardMan"); }

      break;

      //  파일 다운
      case "download" :

        ob_end_clean();
        $filePath  = $_GET["url"]."/".$_GET["dnfilename"];
        header("Cache-control: private");

        if(!is_file($filePath)){

          $fileSize = $_GET["filesize"];
          header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
          header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
          header("Cache-Control: cache, must-revalidate");
          header("Cache-Control: post-check=0, pre-check=0", false);
          header("Pragma: no-cache");
          header("Content-type: application/force-download");

          //파일의 형식에 맞게 이진파일/아스키로 파일을 열것인지를 체크
          if(strstr($file_type, "plane")) { $openType = "r"; $dnflag = "inline"; }
          else{ $openType = "rb"; $dnflag = "attachment"; }

          if(strstr($_SERVER["HTTP_USER_AGENT"], "MSIE")){
            Header("Content-type: application/octet-stream");
            Header("Content-Length: $fileSize"); // 이부분을 넣어 주어야지 다운로드 진행 상태가 표시 됩니다.
            Header("Content-Disposition: $dnflag; filename=$_GET[dnfilename]");
            Header("Content-Transfer-Encoding: binary");
            Header("Pragma: no-cache");
            Header("Expires: 0");
          }
          else{
            Header("Content-type: file/unknown");
            Header("Content-Length: $fileSize");
            Header("Content-Disposition: $dnflag; filename=$_GET[dnfilename]");
            Header("Content-Description: PHP3 Generated Data");
            Header("Pragma: no-cache");
            Header("Expires: 0");
          }

          $result = $this->Get_file_from_url($filePath);

          echo $result[0];
        }
        else{$inst_location->error("파일을 다운받으실 수 없습니다.");}

        // 반드시 exit를 걸어서 뒷부분의 출력을 막아준다.
        // 뒤에서 출력이 되면 파일 다운시 헤더오류 발생
        exit;

      // 테이블 생성 뷰
      default :

        // 처음에 게시판 생성할때만 잠시 풀어준다.
        /*
        echo $inst_html->Print_head(JSURL,CSSURL);
        echo $inst_otm->Print_create_form();
        */

      break;


      // switch - End()
    }

  // function - End()
  }

  //-----------------------------------------------------------------------------
  //  파일 정보 긁어 오는놈 : 2008-07-01 박준형
  //  객체 정보 예시)
  //  $URL_info =>
  //  [scheme] => http
  //  [host] => img1.playauto.co.kr
  //  [path] => /mtc/Goods/217d88e811X41527.jpg
  //  [port] => 80
  //-----------------------------------------------------------------------------
  function Get_file_from_url($url) {

    $URL_info = @parse_url($url);
    $URL_info[port] = 80;  //  포트 추가

    //  URL 정보중에 하나라도 비었으면 리턴
    if($reason = @array_search("",$URL_info)) { return "$reason : 미입력"; }

    $Heder = "GET ".$URL_info[path]." HTTP/1.0\r\nHost: ".$URL_info[host]."\r\n\r\n";
    $inst_file = @fsockopen($URL_info[host], $URL_info[port], $errno, $errstr, 30);

    //  연결 성공
    if($inst_file) {
      $data = null;
      @socket_set_timeout($inst_file, 30);
      @fwrite($inst_file, $Heder);
      $body = false;
      while(!@feof($inst_file)) {
          $buffer = @fgets($inst_file, 128);
          if($body==true) $data .= $buffer;
          if($buffer=="\r\n") {$body = true;}
      }
      @fclose($inst_file);

      //  파일명을 구해서 할당.
      $temp_ = @explode("/",$URL_info[path]);
      $file_name = $temp_[@count($temp_)-1];
      return array($data,$file_name);
    }
    //  연결 실패
    else { return "openerror : URL 오픈 에러"; }

  // funciton - End
  }


  //--------------------------
  //  파일 등록
  //--------------------------
  function Upload_file($inst_query,$inst_output,$inst_location,$_POST,$_FILES,$FileCount,$mysql,$section,$table_name,$U_id,$baction){

    // 파일 등록
    $inst_ftp =	 new file_UDC(FileBaseDir,$this->inst_main->CP_CODE);

    for($i=0; $i < $FileCount; $i++){
      // upload 모드로 메인 실행
      $ftp_result = $inst_ftp->main($_FILES["AttFile"]["tmp_name"][$i],$_FILES["AttFile"]["name"][$i],$_FILES["AttFile"]["size"][$i],"upload","Board");

      // 저장될 파일명
      $real_file_name = $inst_ftp->return_file_name();

      // 업로드 결과를 가지고 업로드 에러시 뒷처리(예:5개 올리다 3번째에서 에러나면 그전 1,2번째 놈들도 삭제 하기 위해
      $inst_ftp->error_process($ftp_result,$real_file_name,$_FILES["AttFile"]["size"][$i]);

    //  loop -end
    }

    if($baction=="write_save"){
      // 게시물 등록
      $inst_query->Insert_record($inst_query,$inst_output,$inst_location,$_POST,$mysql,$section,$table_name,$inst_ftp->tmp_upload_files);
    }
    else{
      // 첨부파일을 추가로 등록했을때 파일 추가를 위해 문자열로 만들어서 리턴
      $_POST["update_filename"] = $this->Update_file_action($inst_query,$inst_ftp->tmp_upload_files,$_POST);

      // 게시물 수정
      $inst_query->Update_record($_POST,$mysql);
    }
    return "success";

  // function - End
  }

  //----------------------------
  //    파일 삭제
  //----------------------------
  function Delete_file($data,$U_id){

    // 파일 컨트롤
    $inst_ftp =	 new file_UDC(FileBaseDir,$this->inst_main->CP_CODE);

    // 파일을 모두 삭제할때 까지 루프
    for($i=0; $i < count($data);$i++){
       $inst_ftp->main($filepath,$data[$i],$filesize,"delete","Board");
    }

  // function - End
  }

  //-------------------------------------------------------------------------------
  // DB의 Filename 필드에서 | 구분자를 기준으로 파일명을 분리해준다.
  // 분리하면서 바로 global 변수 $this->Tmp_delfiles 에 문자열로 저장된다.
  //-------------------------------------------------------------------------------
  function Delete_file_repl_sub($tmp){
    for($i=0; $i < count($tmp); $i++){
      $tmp2	=	explode("|",$tmp[$i]);
      $this->Tmp_delfiles =	$this->Tmp_delfiles.$tmp2[0]."/";
    }

  // function - End
  }

  //-------------------------------------------------------------------------------
  // 부모 게시물 삭제시 딸린 리플들의 첨부파일도 싹 지워주기 위해서 문자열로.
  //-------------------------------------------------------------------------------
  function Delete_file_repl($data){

    for($i=0; $i < count($data["filename"]); $i++){
      $tmp	 =	explode("/",$data["filename"][$i]);
      $this->Delete_file_repl_sub($tmp);
    }

    // 마지막 / 를 빼주고 배열로 만들어준다..
    $this->Tmp_delfiles	=	substr($this->Tmp_delfiles,0,strlen($this->Tmp_delfiles)-1);

    // 배열로 만들어준다.
    $this->Tmp_delfiles	=	explode("/",$this->Tmp_delfiles);

  // function - End
  }

  //-----------------------------------------------------------------------------
  //  첨부된 파일이 뷰페이지에서 어떤식으로 보여질지 형식을 리턴해준다.
  //  뷰 페이지 전용 : 2009-01-13 박준형
  //-----------------------------------------------------------------------------
  function GetAddfileType($section, $table_name) {

    switch($section) {
      case "good" : if($table_name=='Board_review') { return "img"; } else { return "none"; } break;
      case "normal" : return "none"; break;
      case "file" : return "link"; break;
    }

  // funciton - End
  }

  //----------------------------------------------------------------
  //   첨부파일 추가에 사용되는놈
  //----------------------------------------------------------------
  function Return_add_filename($original_filestring,$new_string){
    return $original_filestring."/".$new_string;
  }

  //--------------------------------------------------------------------------
  // 수정 저장 할때 파일 추가 관련 처리부분
  //--------------------------------------------------------------------------
   function Update_file_action($inst_query,$_FILES,$_POST){
     // 키값을 재정의 해서 넣어준다.
     $new_string	=	$inst_query->Filetostring($_FILES);
     $update_string = $this->Return_add_filename($_POST["originalfiles"],$new_string);
     return $update_string;
  }

  //-----------------------------------------------------------------------------
  //  게시판 출력 옵션 변경해주는놈
  /*
  //  출력정보 변경 2009-02-02 박준형
  //  관리자 에서 설정한 내용대로 변환해줌
  $this->inst_BoardExtends->SwitchOPT(&$data[writer_name][0],'writer');
  $this->inst_BoardExtends->SwitchOPT(&$data[regi_date][0],'dateview');
  */
  //-----------------------------------------------------------------------------
  function SwitchOPT($data,$section='list') {

    // 목록 데이터 필터할 경우
    if(is_array($data) && $section=='list') {

      foreach($data as $key=>$val) {
        foreach($val as $key2=>$val2) {
          //  작성자
          if($key2=='writer_name') { if($this->BoardOPT[writer]=='id') { $data[$key][$key2] = $data[$key]['writer_id']=='_ADMIN_' ? '관리자' : $data[$key]['writer_id']; } }
          elseif($key2=='regi_date') { $data[$key][$key2] = $this->inst_String->ext_date($data[$key][$key2],trim($this->BoardOPT[dateview])); }
        // loop - End
        }
      // loop - End
      }

    }
    //  단일 결과
    else {

      //  데이터 있을 때만
      if(trim($data[writer_name][0])!="") {
        if($this->BoardOPT[writer]=='id') { $data[writer_name][0] = $data[writer_id]['writer_id'][0]=='_ADMIN_' ? '관리자' : $data['writer_id'][0]; }
        $data[regi_date][0] = $this->inst_String->ext_date(&$data[regi_date][0],$this->BoardOPT[dateview]);
      }
    }

  // funciton - End
  }

// class - End()
}
?>