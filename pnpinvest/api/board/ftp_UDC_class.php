<?
//-----------------------------------------------------------------------
//  게시판 전용으로 만들어진 FTP 클래스
//  2007-10-05 : 박준형 
//  다른 곳에 쓰인 FTP 클래스와 기본적인
//  구조는 같으나 이놈은 게시판에 특화된
//  클래스이기 때문에 혼용 하면 안됨.
//-----------------------------------------------------------------------
class file_UDC{
# class - Start()

	# ftp 접속 관련
	var $host,$port,$id,$pw,$fconn;

	# ftp에 접속해서 첫번째로 이동할 디렉토리명
	var $first_move,$CP_CODE;
	
	# 파일 등록 관련 정보
	var $filepath,$filename,$filesize,$virtual_filename, $extension,$name_non_extension,$max_size;
	
	# 파일 삭제 관련 정보
	var $delete_file_name,$old_file_name,$tmp_upload_files;

	##########
	# 생성자 ###############
	# ftp 접속 정보를 세팅 #
	########################
	function file_UDC($first_move,$CP_CODE){
		// 파일 폴더 디렉토리가 들어오지 않았을때
		if(!$first_move){echo "디렉토리를 지정해야합니다.";exit;}

		# 접속 관련 값
		$this->host			=	"127.0.0.1";
		$this->port			=	"21";
		$this->id				=	"sing0912";
		$this->pw				=	"tjsenxkfghks1";
		$this->first_move	=	ImageBase;
		$this->CP_CODE	=	$CP_CODE; // 사용자 ID마다 폴더를 따로 만들때 쓰이는놈 보통의 경우 파일디렉토리 1개만 지정

		# 파일 업로드 관련 
		$this->tmp_upload_files	= array(); // 업로드 되는 파일들의 변환된 이름을 배열로 가지고있는다.
		$this->max_size				=	10000000;
	}
	
	# 파일 사이즈 체크
	function check_file_size($img_size){
		# true 면 1을 반환 false 면 0을 반환
		if($img_size > $this->max_size){return "0";}else{return "1";}
	}

	# 확장자 제한 (확장자를 추가시켜주면 된다.) 
	function check_file_name($filename){
		
  # 파일명과 확장자를 분리
		$tmp = explode(".",$filename);
		
		# 확장자 
		$this->extension = $tmp[sizeof($tmp)-1];
		
		# 확장자를 뺀 파일명
		$this->name_non_extension	=	$tmp[0];

		# true 면 1을 반환 false 면 0을 반환
		if((strcmp($this->extension,"jpg")=="0" or strcmp($this->extension,"gif")=="0" or strcmp($this->extension,"JPG")=="0" or strcmp($this->extension,"GIF")=="0"  or strcmp($this->extension,"xls")=="0" or strcmp($this->extension,"doc")=="0" or strcmp($this->extension,"ppt")=="0" or strcmp($this->extension,"hwp")=="0" or strcmp($this->extension,"zip")=="0" or strcmp($this->extension,"txt")=="0"  or strcmp($this->extension,"pdf")=="0"  or strcmp($this->extension,"cab")=="0"))
		{return "1";}
		else{return "0";}
	}

	# 저장될 파일명 (실 파일명에 등록 날짜를 붙여준다 예: MGP0671(17061238).jpg )
	function make_file_name(){
		$file_name = str_replace(" ","",str_replace("+","",str_replace("-","",trim($this->name_non_extension))));
		$this->virtual_filename = $file_name."(".date("dhis",mktime()).").".$this->extension;
	} 

	# 저장될 파일명을 밖으로 리턴 
	function return_file_name(){return $this->virtual_filename;}

	# 파일 업로드
	function file_upload($fconn){
		# 파일 사이즈,파일명 제한 (둘다 1일 경우에만 통과)
		if($this->check_file_size($this->filesize)==0 || $this->check_file_name($this->filename)==0)
		{return "0";}
		else{
			# 서버에 업로드될 파일명을 만들어준다
			$this->make_file_name();
			
			# 파일 업로드 (성공시 ok 실패시 error 반환)
			if(!@ftp_put($fconn, $this->virtual_filename, $this->filepath, FTP_BINARY))
			{return "error";}
			else{return "ok";}
		}
	}

	# 파일 삭제 
	function file_delete(){if(@ftp_delete($this->fconn, $this->delete_file_name)) {return "ok";}else {return "error";}}
	
	# 업로드 되고있는 파일들의 정보를 담아둔다.
	function tmp_upload_files($upload_files,$filesize){
		$this->tmp_upload_files["filename"][]	=	$upload_files;
		$this->tmp_upload_files["size"][]		=	$filesize;
	}
	
	# 다중 파일 업로드 실패시 올라가있는 파일들 삭제 
	function file_err_delete(){
		for($i = 0; $i < count($this->tmp_upload_files["filename"]); $i++){
			# 파일을 삭제해 준다
			$ftp_result = $this->main($filepath,$this->tmp_upload_files["filename"][$i],$filesize,"delete");
			if($ftp_result!="ok"){echo "파일 삭제 실패 : ftp접속 권한을 확인하세요."; exit;}
		}
	}

	# 업로드 실행과정에서 에러처리
	function error_process($ftp_result,$real_file_name,$filesize){
		// 업로드 실패시
		if($ftp_result!="ok"){
			$inst_location	=	new Location_Control(); // location관련 클래스
			$msg_X	=	sprintf("파일 업로드 실패 : %s MB를 넘거나 형식에 맞지 않는 데이터는 업로드 할 수 없습니다.",(($this->max_size/1000)/1000));

			# 다중 파일 업로드 실패시 이전에 올라가있는 파일들 삭제 
			$this->file_err_delete();

   $inst_location->error($msg_X);
			exit;
		}
		// 업로드 성공시
		else{
			// 현재 업로드중인 파일의 이름을 배열에 가지고있는다
			$this->tmp_upload_files($real_file_name,$filesize);
		}
	}

	# 파일 업로드에 필요한 정보 세팅
	function upload_info_set($filepath,$filename,$filesize){
		# 파일 관련 정보
		$this->filepath		=	$filepath;
		$this->filename		=	$filename;
		$this->filesize		=	$filesize;
	}

	# 파일 업로드에 필요한 정보 세팅
	function delete_info_set($filename){
		# 파일 관련 정보
		$this->delete_file_name		=	$filename;
	}

	# ftp에 로그인하고 해당 디렉토리로 이동한 후 접속인스턴스를 $this->fconn 에 할당
	function ftp_login($Folder){
		# ftp 접속
		$fconn = @ftp_connect(&$this->host, &$this->port) or die(" this->$host : $this->port - 접속 실패"); 

		# 로그인
		@ftp_login($fconn, &$this->id, &$this->pw) or die("FTP 로그인 실패"); // $this->id - login  

		# 첫번째 디렉토리 변경
		@ftp_chdir($fconn, $this->first_move) or die($fconn);

    # 디렉토리 변경
		# 우선 업체코드 디렉토리로 옮긴다
		$change_result2 = @ftp_chdir($fconn, $this->CP_CODE); 

    if(!$change_result2){
			# 디렉토리를 생성해 준다
			@ftp_mkdir($fconn,$this->CP_CODE) or die("디렉토리 생성 실패");

			# 다시 디렉토리 변경
			@ftp_chdir($fconn, $this->CP_CODE) or die("e"); 
		}

		# 이미지 업로드할 디렉토리로 옮긴다
		$change_result = @ftp_chdir($fconn, $Folder); 

		# 디렉토리 변경에 실패했을 경우 ,디렉토리가 존재 하지 않는경우
		if(!$change_result){
			# 디렉토리를 생성해 준다
			@ftp_mkdir($fconn,$Folder) or die("디렉토리 생성 실패");

			# 다시 디렉토리 변경
			$change_result = @ftp_chdir($fconn, $Folder) or die("e"); 
		}
		$this->fconn	 =	$fconn;
	}

	function ftp_close(){
		ftp_close($this->fconn);
	}

	# 수정시에 OLD 이미지 불러들이는 놈
	function call_old_img($old_file_name){
		$this->old_file_name	=	$old_file_name;
	}


	# 메인 메소드
	function main($filepath,$filename,$filesize,$action,$Folder='Board'){	

    # action에 따라서 upload와 delete를 수행
		switch($action){
			case "upload" : 
				
				# 업로드를 위한 정보 세팅
				$this->upload_info_set($filepath,$filename,$filesize);
				#  확장자 체크 : 확장자는 $this->extension
				$this->check_file_name($this->filename);
				# ftp에 로그인
				$this->ftp_login($Folder);
				# 파일을 업로드한다
				$result = $this->file_upload($this->fconn);
				$this->ftp_close();
				return $result;

			break;

			case "delete" : 
			
				# 삭제 파일 정보 세팅
				$this->delete_info_set($filename);
				# ftp에 로그인
				$this->ftp_login($Folder);
				# 파일 삭제
				$result = $this->file_delete();
				$this->ftp_close();
				return $result;

			break;

			case "modify" : 
				
				# 업로드를 위한 정보 세팅
				$this->upload_info_set($filepath,$filename,$filesize);
				
				#  확장자 체크 : 확장자는 $this->extension
				$this->check_file_name($this->filename);
				
				# ftp에 로그인
				$this->ftp_login($Folder);
				
				# 파일을 업로드한다
				$result = $this->file_upload($this->fconn);
				
				# 업로드에 성공했을경우 기존 파일을 삭제한다
				if($result=="ok"){
					# 삭제 파일 정보 세팅
					$this->delete_info_set($this->old_file_name);

					# ftp에 로그인
					$this->ftp_login($Folder);
					
					# 파일 삭제
					$this->file_delete($this->fconn);
				}
				$this->ftp_close();
				return $result;
			break;
		}
	}

# class - End()
}
?>