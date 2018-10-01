<?php
//동일파일명의 파일이름 변환후 반환 ---------------------------------------------------------------------------------------->
function getSavename($filename,$url)
{		
	$savename = $filename;
	$j = 0;
	$savename = stripslashes($savename);
	$savename=eregi_replace(" ","_",$savename);
	$savename=eregi_replace("	","_",$savename);
	$savename=eregi_replace("'","",$savename);		
	$savename=eregi_replace("\"","",$savename);	
	$savename=eregi_replace(";","",$savename);	
	$savename=eregi_replace("\|","",$savename);

	while (file_exists($url."/".$savename)) {
		$j++;
		$savename = "$j@" . $filename;
	}		
	return $savename;
}

//패스를 현재디렉토리이외 접근금지 ---------------------------------------------------------------------------------------->
	function InnerPath($path){
		$outPath =ereg_replace("\.[\.]+","",$path);
		$outPath =ereg_replace("^[\/]+","",$outPath);

		return $outPath;
	}

//파일확장자 구함 ---------------------------------------------------------------------------------------->
	function getFileExt($filename)
	{
		$tmp = explode(".",$filename);
		$ext = array_pop($tmp);
		return $ext;
	}
// 파일이름을 시간으로 정리(이미지에 주로사용)
function file_rename($filename,$url,$tmp="")
{		
	$savename = $filename;
	$ext = array_pop(explode(".",$savename));
	$j = 0;
	$savename = time().$tmp.".".strtolower($ext);
	while (file_exists($url."/".$savename)) {
		$j++;
		$savename = "$j@" . $savename;
	}
	return $savename;
}


//파일사이즈를 이쁘게 포장합시당.. ---------------------------------------------------------------------------------------->
	function getFilesize($size){
	  if(!$size) return "0 Byte";
	  if($size < 1024){
		   return ($size. "Byte");
	  }elseif($size >= 1024 && $size < 1024 * 1024){
		  return sprintf("%0.1f KB", $size / 1024);
	  }else{
		  return sprintf("%0.2f MB", $size/(1024*1024));
	  }
	}
	   
//설정되어있는 파일사이즈구하기 ---------------------------------------------------------------------------------------->
	function getUploadSize(){
		$size=ini_get("upload_max_filesize");
		return $size;
	}

// 디렉토리 검색옵션(스킨dir , 카드회사선택등에서 사용)
function dirSelect($dirpath , $filename="")
{	
	$dir = opendir($dirpath);
	while($dir_info = readdir($dir))
	{
		if($dir_info <> "." && $dir_info <> ".."){
			if(is_dir($dirpath."/".$dir_info))
			{
				if($dir_info == $filename) echo "<option value='$dir_info' selected>$dir_info</option>";
				else echo "<option value='$dir_info'>$dir_info</option>";
			}
		}
	}
	closedir($dir);
}


// 파일 검색옵션(스킨dir , 카드회사선택등에서 사용)
function fileSelect($dirpath , $filename="")
{	
	$dir = opendir($dirpath);
	while($dir_info = readdir($dir))
	{
		if($dir_info <> "." && $dir_info <> ".."){
			if(is_file($dirpath."/".$dir_info))
			{
				if($dir_info == $filename) echo "<option value='$dir_info' selected>$dir_info</option>";
				else echo "<option value='$dir_info'>$dir_info</option>";
			}
		}
	}
	closedir($dir);
}

function file_check($fp)
{	
	$dirpath = "../classdata";
	$dir = opendir($dirpath);
	$file_name = "";
	while($dir_info = readdir($dir))
	{
		if($dir_info <> "." && $dir_info <> ".."){
			if(is_file($dirpath."/".$dir_info))
			{
				$tmp_info = split("\.",$dir_info);
				if($tmp_info[0]==$fp){
					$file_name=$dir_info;
					break;
				}
			}
		}
	}
	closedir($dir);
	return $file_name;
}

//파일업로드파일 ---------------------------------------------------------------------------------------->
function upload_file_02($tempfile, $realfile, $dir)
{
	if ($tempfile == "") return false;
    // 업로드 한후 , 퍼미션을 변경함
	@move_uploaded_file($tempfile, "$dir/$realfile");
	@chmod("$dir/$realfile", UPFILE_AFTER_PERM);
	return true;
}


// 파일을 업로드 함
function upload_file($srcfile, $destfile, $dir)
{
    if ($destfile == "") return false;
    // 업로드 한후 , 퍼미션을 변경함
    @move_uploaded_file($srcfile, $dir.'/'.$destfile);
    @chmod($dir.'/'.$destfile, MARI_FILE_PERMISSION);
    return true;
}

?>