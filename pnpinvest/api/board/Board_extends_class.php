<?
class BoardExtends{

	// 파일 삭제할때 글로벌로 사용되는놈
	var $Tmp_delfiles;
	var $Img_widmax = 0;
	var $DataBase;
	var $Sock;
	var $inst_main;

	//-------------------------
	//   생성자
	//-------------------------
	function BoardExtends($inst_main){
	//  게시판 설정 아이디,이름출력 / 날짜 표시 : 2009-02-02 박준형
	//$this->User_Dir = SiteBase."/configs/BoardOPT";
	$this->inst_main = $inst_main;
	$this->inst_String = $inst_main->inst_String;
	$this->LoadBoardOPT();
	}

	//-----------------------------------------------------------------------------
	//  보드옵션 로더 
	//  관리자에서 설정한 옵션 로딩 
	//  DB로 전환 : 2011-03-03 정수진
	//  인스톨시 CP_CODE가 없어 거치면 문제되므로 거치지 않는 처리 추가 : 2011-03-09 정수진
	//-----------------------------------------------------------------------------
	function LoadBoardOPT(){
		if($this->inst_main->DataBase != 'EC_'){
			if($_GET[action] == 'Detail' || $_GET[action] == 'AjaxQna' ){
				$query	= "select dateview from ".$this->inst_main->DataBase.".Board_list where table_name='Board_goods_qna';";
				$data	=	$this->inst_main->select_Sock->fetch($query);
			}else{
				$query	= "select dateview from ".$this->inst_main->DataBase.".Board_list where table_name='Board_gongji';";
				$data	=	$this->inst_main->select_Sock->fetch($query);
			}
		$this->BoardOPT[dateview] = $data[0][dateview] != '' ? $data[0][dateview] : 'ymdm';
		$this->BoardOPT[writer] = 'name';    
		}
	}// funciton - End
	//-----------------------------------------------------------------------------
	//  게시판 출력 옵션 변경해주는놈 
	/*
	//  출력정보 변경 2009-02-02 박준형 
	//  관리자 에서 설정한 내용대로 변환해줌	
	$this->SwitchOPT(&$data[writer_name][0],'writer');
	$this->SwitchOPT(&$data[regi_date][0],'dateview');
	*/
	//-----------------------------------------------------------------------------
	
	function SwitchOPT($data,$section='list') {
	// 목록 데이터 필터할 경우 
		if(is_array($data) && $section=='list') {
			foreach($data as $key=>$val) {
				foreach($val as $key2=>$val2) {
				//  작성자 
				//  댓글 추가 : 2009-11-30 정수진
					if($key2=='writer_name'){
						if($this->BoardOPT[writer]=='id'){ 
							$data[$key][$key2] = $data[$key]['writer_id'] == '_ADMIN_' ? '관리자' : $data[$key]['writer_id']; 
						} 
					}elseif($key2=='regi_date'){ 
					//  어드민일경우 all타입으로 고정 : 2010-12-30 정수진
						if(ereg('ecadmin.playautocorp.com',$_SERVER[HTTP_HOST])){ 
							$data[$key][$key2] = $this->inst_String->ext_date($data[$key][$key2],'all');
						}else{ 
							$data[$key][$key2] = $this->inst_String->ext_date($data[$key][$key2],trim($this->BoardOPT[dateview])); 
						}
					}elseif($key2=='c_name'){ 
						if($this->BoardOPT[writer]=='id'){
							$data[$key][$key2] = $data[$key]['c_id']=='_ADMIN_' ? '관리자' : $data[$key]['c_id'];
						} 
					}
				}// loop - End
			}// loop - End
		}else{//단일결과
		//  데이터 있을 때만 
			if(trim($data[writer_name][0])!=""){
				if($this->BoardOPT[writer]=='id'){
					$data[writer_name][0] = $data[writer_id]['writer_id'][0]=='_ADMIN_' ? '관리자' : $data['writer_id'][0];
				}
				//  어드민일경우 all타입으로 고정 : 2010-12-30 정수진
				if(ereg('ecadmin.playautocorp.com',$_SERVER[HTTP_HOST])){
						$data[regi_date][0] = $this->inst_String->ext_date(&$data[regi_date][0],'all');
				}else{ 
					$data[regi_date][0] = $this->inst_String->ext_date(&$data[regi_date][0],$this->BoardOPT[dateview]);
				}
			}
		}
	}// funciton - End


	//-----------------------------------------------------------------------------
	//  게시판 출력 옵션 변경해주는놈 2
	//  새로 적용한 문의게시판 형태에 맞게 변경 : 2011-03-07 정수진
	//-----------------------------------------------------------------------------
	function SwitchOPT2($data){
		// 목록 데이터 필터할 경우 
		if(is_array($data)){
			foreach($data as $key=>$val){
				$data[$key][regi_date] = $this->inst_String->ext_date($data[$key][regi_date],trim($this->BoardOPT[dateview]));
			}
		}
	}// funciton - End

}// class - End()
?>