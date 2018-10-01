<?
class BoardPage {

  var $block_set = 0; // 게시물 블록당 개수
  var $page_set = 0; // 한페이지당 개수
  var $total = 0;
  var $file_name = "";
  var $total_page = 0;
  var $total_block	 = 0;
  var $block = 0;
  var $limit_no = 0;
  var $page	 = 0;
  var $first_page = 0;
  var $last_page = 0;
  var $prev_page = 0;
  var $next_page	 = 0;
  var $prev_block = 0;
  var $next_block = 0;
  var $prev_block_page = 0;
  var $next_block_page = 0;
  var $img_next, $img_prev;
  var $style;

  //------------------------
  //     생성자
  //------------------------
  function BoardPage($page_set,$block_set){
    $this->img_next = "./img/board/bt_next.gif";
    $this->img_prev = "./img/board/bt_pre.gif";
    $this->style	=	"list_navi";
    $this->block_set = $block_set;
    $this->page_set = $page_set;
  }

  //-------------------------------------------------------
  //   전체 게시물 수 구하기
  //-------------------------------------------------------
  function get_total($query,$mysql){
    $mysql->reset_rownum();
    $data = $mysql->fetch_key($query);
    $total = $data["total"][0];
    return $total;
  }

  //-------------------------------------------
  //  외부 파라미터 받는놈
  //-------------------------------------------
  function get_value($total,$page,$file_name,$messege,$param){

    if(!$page){$this->page  = 1;}
    else{$this->page   = $page;}

    $this->param    =  $param;
    $this->total    =  $total;
    $this->total_page   =  @ceil ($total / $this->page_set);
    $this->total_block   =  @ceil ($this->total_page / $this->block_set);
    $this->block    =  @ceil ($this->page / $this->block_set);
    $this->limit_no    =  ($this->page - 1) * $this->page_set;
    $this->file_name   =  $file_name;
    $this->messege    =  $messege;
    $this->first_page   =  (($this->block - 1) * $this->block_set) + 1;
    $this->last_page   =  min($this->total_page, $this->block * $this->block_set);
    $this->prev_page   =  $this->page - 1;
    $this->next_page   =  $this->page + 1;
    $this->prev_block   =  $this->block - 1;
    $this->next_block   =  $this->block + 1;
    $this->prev_block_page  =  $this->prev_block * $this->block_set - ($this->block_set - 1);
    $this->next_block_page  =  $this->next_block * $this->block_set - ($this->block_set - 1);

  // function - End
  }


  //---------------------------------------------------------
  // 데이터 쿼리할때 limit 숫자 리턴
  //---------------------------------------------------------
  function get_limt(){return sprintf("%d , %d ",$this->limit_no,$this->page_set);}


  //-----------------------------
  //   페이징 출력
  //-----------------------------
  function print_page(){

    echo "<div class='pagenumber'>";
    if(!$this->param){$param = "";}
    else{$param = sprintf("&%s", $this->param);}
    // 이전 블록 이미지
    if($this->prev_block	 > 0){
			echo "<a href='$this->file_name?page=$this->prev_block_page&$param' class='pre'>";
			echo "<&nbsp;이전";
			echo "</a>";
    }
    //  페이지 숫자 loop
    for($i=$this->first_page; $i<=$this->last_page; $i++){
      // 선택된 페이지가 아닐때
      if($i != $this->page){
        // 페이지 숫자
        echo "<a href='$this->file_name?page=$i$param'>$i</a>";
        if($i < $this->last_page){echo "";}
        else{echo "";}
      // if - End
      }
      // 선택된 페이지 일때 <b>를 먹여준다.
      else{
        echo "<strong>$i</strong>";
        if($i < $this->last_page){echo "";}
        else{echo "";}
      // else - End
      }
    // loop - End
    }
    // 페이지 구분선
    if($this->last_page > 0){}else{echo "$this->messege";}

    // 다음 블록 이미지
    if($this->next_block <= $this->total_block){
     echo "<a href='$this->file_name?page=$this->next_block_page&$param' class='next'>";
     echo "다음&nbsp>";
     echo "</a>";
    }

     echo "</div>";

  // function - End()
  }

  //-------------------------------------------------------
  //   페이징 출력 스타일 3번 ( 스캘리도 디자인 스타일 )
  //-------------------------------------------------------
  function print_page3(){

    echo "<div id='listall2'>";
    if(!$this->param){$param = "";}
    else{$param = sprintf("&%s", $this->param);}
    // 이전 블록 이미지
    if($this->prev_block	 > 0){
      echo "<div class='listnumberimg2'>";
      echo "<a href='$this->file_name?page=$this->prev_block_page&$param'>";
      echo "<img src='/skin10/img2/board/btn_prev_1.gif'>&nbsp;&nbsp;";
      echo "</a>";
      echo "</div>";
    }
    else {
      echo "<div class='listnumberimg2'>";
      echo "<img src='/skin10/img2/board/btn_prev_1.gif'>&nbsp;&nbsp;";
      echo "</div>";
    }
    //  페이지 숫자 loop
    for($i=$this->first_page; $i<=$this->last_page; $i++){
      // 선택된 페이지가 아닐때
      if($i != $this->page){
        // 페이지 숫자
        echo "<div class='listnumber2'>";
        echo "<a href='$this->file_name?page=$i$param'>$i</a>";
        echo "</div>";
        if($i < $this->last_page){echo "";}
        else{echo "";}
      // if - End
      }
      // 선택된 페이지 일때 <b>를 먹여준다.
      else{
        echo "<div class='listnumber2'><span class='lnselection2'>$i</span> </div>";
        if($i < $this->last_page){echo "";}
        else{echo "";}
      // else - End
      }
    // loop - End
    }
    // 페이지 구분선
    if($this->last_page > 0){}else{echo "$this->messege";}

    // 다음 블록 이미지
    if($this->next_block <= $this->total_block){
     echo "<div class='listnumberimg2'>";
     echo "<a href='$this->file_name?page=$this->next_block_page&$param'>";
     echo "&nbsp;&nbsp;<img src='/skin10/img2/board/btn_next_1.gif'>";
     echo "</a>";
     echo "</div>";
    }
    else {
     echo "<div class='listnumberimg2'>";
     echo "&nbsp;&nbsp;<img src='/skin10/img2/board/btn_next_1.gif'>";
     echo "</div>";
    }
     // 페이지 레이어 끝 이 아래에 추가하면 에러생김 2008-06-12 김태섭
     echo "</div>";

  // function - End()
  }

// class - End
}
?>