<?
// 파일 수정시 첨부된 파일 목록 표시 클래스
class File_list{

function File_list(){
  $this->delete_icon = "/board/img/file_delete.gif";
}

//-------------------------------------
//   파일 수정시 목록
//-------------------------------------
function Print_filelist($filelist,$writer_id){

  echo "<style>.input_filelist {height:16px; padding:4px 0 0 9px; color:#8C8C8C; background-color:#F8F8F8;}</style>";
  echo "<table border='0'><tr><td style='padding-top:10px;'>";
  echo "<select size=\"3\" multiple  name=\"filelist\" id=\"filelist\" style=\"width:540px; height:70px;font-size:12px; border:0;\" class=\"input_filelist\">";
  echo "<option value=\"\">-----------------------------------첨부된 파일들----------------------------------</option>";

  for($i=0; $i < count($filelist["filename"]); $i++){
    if($filelist["filename"][$i]!=""){
      echo sprintf("<option value=\"%s|%s\" >%s (%sk) </option>",$filelist["filename"][$i],$filelist["size"][$i],$filelist["filename"][$i],round($filelist["size"][$i]/1024,1));
    }
  }

  echo "</select>";
  echo "<img src=\"$this->delete_icon\" border=\"0\" align=\"absmiddle\" style=\"cursor:hand; margin-left:5px; margin-top:-8px;\" onclick=\"if(confirm('삭제 하시겠습니까?')){return delete_filelist();}else{return false;}\">";
  echo "</td></tr></table>";

// function - End
}

//------------------------------------------------------------------------------------------------
//  문자열 끝에서 / 완전 제거해주고 널인 공백 배열 제거
//------------------------------------------------------------------------------------------------
function dell_seprator($sep,$string){

  $return_array = array();
  $temp = explode($sep,$string);

    for($i=0; $i < count($temp); $i++){
      // 배열의 값을 가진 요소를 제거
      if($temp[$i]!=""){
        $return_array[] = $temp[$i];
      // if - End
      }
    // loop - End
    }
  return $return_array;

// function - End
}

//----------------------------------------------------------------------------
//  원파일 문자열에서 삭제할 문자열을 제거
//----------------------------------------------------------------------------
function Sep_strings($_POST){

  $return_string = "";
  $delete_files = $this->dell_seprator("/",$_POST["delstring"]);  // 삭제될 파일들
  $original_files = $this->dell_seprator("/",$_POST["originalfiles"]);  // 원래 파일들
  $update_files = array_diff($original_files,$delete_files);  // 다시 업데이트될 파일들
  sort($update_files);  // 배열 인덱스 정렬
  $turn =  count($update_files);

  for($i=0; $i < $turn; $i++){

    if($i < $turn-1){
      $return_string = $return_string.$update_files[$i]."/";
    // if - End
    }
    else{
      $return_string = $return_string.$update_files[$i];
    // else - End
    }
  // loop - End
  }

  return $return_string;

// function - End
}

// class - End()
}
?>