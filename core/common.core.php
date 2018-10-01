<?php
if (!defined('_MARICMS_')) exit;

include_once(MARI_MAIL_PATH.'/class.phpmailer.php');
/*************************************************************************
**
**  일반 함수 모음
**
*************************************************************************/

		function func($number) 
		{ 
		  return $number = floor($number / 10) * 10; 
		} 

		//금액변환
		function change_pay($money,$step = 0) 
		{ 
			$formater    = array("","만","억","조","경","해","자"); 
			$tmp_mon    = (strlen($money)>4) ? change_pay(substr($money,0,strlen($money)-4),$step+1) : ""; 
			$curmoney    = intval(substr($money,-4)); 

			if($curmoney){ 
				$tmp_mon.= sprintf(" %s%s",number_format($curmoney),$formater[$step]); 
			}else if(!$tmp_mon){ 
				$tmp_mon = 0;
			}

			return $tmp_mon; 
		} 

		function mail_ok($fname, $fmail, $to, $subject, $content, $type=0, $file="", $cc="", $bcc="") 
		{ 
			global $config; 
			global $mari; 

			/*메일발송 사용여부*/
			if (!$config['c_email_use']) return; 

			if ($type != 1) 
				$content = nl2br($content); 

			$mail = new PHPMailer(); // defaults to using php "mail()"
			if (defined('MARI_SMTP') && MARI_SMTP) {
				$mail->IsSMTP(); // telling the class to use SMTP
				$mail->Host = MARI_SMTP; // SMTP server
			}
			$mail->From = $fmail;
			$mail->FromName = $fname;
			$mail->Subject = $subject;
			$mail->AltBody = ""; // optional, comment out and test
			$mail->MsgHTML($content);
			$mail->AddAddress($to);
			if ($cc) 
				$mail->AddCC($cc);
			if ($bcc) 
				$mail->AddBCC($bcc);
			//print_r2($file); exit;
			if ($file != "") { 
				foreach ($file as $f) { 
					$mail->AddAttachment($f['path'], $f['name']);
				}
			}
			return $mail->Send();
		}

		// 파일을 첨부함
		function attach_file($filename, $tmp_name)
		{
			// 서버에 업로드 되는 파일은 확장자를 주지 않는다. (보안 취약점)
			$dest_file = MARI_DATA_PATH.'/tmp/'.str_replace('/', '_', $tmp_name);
			move_uploaded_file($tmp_name, $dest_file);
			/*
			$fp = fopen($tmp_name, "r");
			$tmpfile = array(
				"name" => $filename,
				"tmp_name" => $tmp_name,
				"data" => fread($fp, filesize($tmp_name)));
			fclose($fp);
			*/
			$tmpfile = array("name" => $filename, "path" => $dest_file);
			return $tmpfile;
		}



	/* 세이퍼트 은행명 설정*/
	function bank_name($bankcode) {

			if($bankcode=="SHINHAN_088"){ $bankname="신한은행"; 
			}else if($bankcode=="KIUP_003"){ $bankname="기업은행"; 
			}else if($bankcode=="KUKMIN_004"){ $bankname="국민은행"; 
			}else if($bankcode=="WOORI_020"){ $bankname="우리은행"; 
			}else if($bankcode=="KEB_005"){ $bankname="외환은행"; 
			}else if($bankcode=="NONGHYUP_011"){ $bankname="농협중앙회"; 
			}else if($bankcode=="NONGHYUP_010"){ $bankname="농협"; 
			}else if($bankcode=="HANA_081"){ $bankname="하나은행"; 
			}else if($bankcode=="SC_023"){ $bankname="SC제일은행"; 
			}else if($bankcode=="CITY_027"){ $bankname="한국씨티은행"; 
			}else if($bankcode=="SAEMAEULGEUMGO_045"){ $bankname="새마을금고"; 
			}else if($bankcode=="BUSAN_032"){ $bankname="부산은행"; 
			}else if($bankcode=="DAEGU_031"){ $bankname="대구은행"; 
			}else if($bankcode=="SANUP_002"){ $bankname="산업은행"; 
			}else if($bankcode=="POSTOFFICE_071"){ $bankname="우체국"; 
			}else if($bankcode=="SINHYUB_048"){ $bankname="신협"; 
			}else if($bankcode=="KWANGJU_034"){ $bankname="광주은행"; 
			}else if($bankcode=="SB_050"){ $bankname="상호저축은행"; 
			}else if($bankcode=="NONGHYUP_012"){ $bankname="단위농협"; 
			}else if($bankcode=="KYONGNAM_039"){ $bankname="경남은행"; 
			}else if($bankcode=="JEONBUK_037"){ $bankname="전북은행"; 
			}else if($bankcode=="SUHYUP_007"){ $bankname="수협"; 
			}else if($bankcode=="HSBC_054"){ $bankname="HSBC"; 
			}else if($bankcode=="SUCHULIB_008"){ $bankname="수출입"; 
			}else if($bankcode=="CHOHUNG_021"){ $bankname="(구)조흥은행"; 
			}else if($bankcode=="JEJU_035"){ $bankname="제주은행"; }

		return $bankname;
	}



	/* 분류명 카테고리코드&뎁스*/
	function cate_name($i_payment, $cate_num) {

			$sql = " select  ca_subject from mari_category where ca_id ='".$i_payment."' and ca_num='".$cate_num."'";
			$caname = sql_fetch($sql, false);

		return $caname[ca_subject];
	}



	/*나이스 연동관련 function*/
    function GetValue($str , $name)
    {
        $pos1 = 0;  //length의 시작 위치
        $pos2 = 0;  //:의 위치

        while( $pos1 <= strlen($str) )
        {
            $pos2 = strpos( $str , ":" , $pos1);
            $len = substr($str , $pos1 , $pos2 - $pos1);
            $key = substr($str , $pos2 + 1 , $len);
            $pos1 = $pos2 + $len + 1;
            if( $key == $name )
            {
                $pos2 = strpos( $str , ":" , $pos1);
                $len = substr($str , $pos1 , $pos2 - $pos1);
                $value = substr($str , $pos2 + 1 , $len);
                return $value;
            }
            else
            {
                // 다르면 스킵한다.
                $pos2 = strpos( $str , ":" , $pos1);
                $len = substr($str , $pos1 , $pos2 - $pos1);
                $pos1 = $pos2 + $len + 1;
            }            
        }
    }



/*이름 블라인드처리*/
function Name_conf($r_name)
{ 
	/*3글자*/
	if ($r_name <= 6) { 
		$r_name = substr($r_name, 0, 4); 

	/*4글자*/
	}else if($r_name <= 8) { 
		$r_name = substr($r_name, 0, 6); 

	/*2글자*/
	}else if($r_name <= 4) { 
		$r_name= substr($r_name, 0, 2); 
	}

	return $r_name; 
}


/*남일 일자구하기*/
function DayDiff($day) 
{ 
    $t = strtotime($day); 
    $gap = time() - $t; 
    if($gap > 86400) 
    { 
        return '[모집마감] '.floor($gap/86400).'일 지남'; 
    } 
    $your = floor($gap / 86400); 
    //$hour = floor($gap / 3600); 
    //$min = floor(($gap / 60) / 60); 

    return 'D '.$your.'일'; 
} 


/*투자자결제관련*/
function get_status($STR)
{
	switch($STR)
	{
		case "Y":{return "결제완료";exit;}
		case "N":{return "결제대기";exit;}
	}
}

/*만원단위로 변환*/

function unit($units){ 

	$units = ($units >= 10000) ? $units / 10000 : $units; 

	return $units; 
}

 //금액변환
function unit2($money,$step = 0) 
{ 
    $formater    = array("","만","억","조","경","해","자"); 
    $tmp_mon    = (strlen($money)>4) ? unit2(substr($money,0,strlen($money)-4),$step+1) : ""; 
    $curmoney    = intval(substr($money,-4)); 

    if($curmoney){ 
		$tmp_mon.= sprintf(" %s%s",number_format($curmoney),$formater[$step]); 
	}else if(!$tmp_mon){ 
		$tmp_mon = 0;
	}

    return $tmp_mon; 
} 


function unit3($num) 
 { 
  $return_val = ""; 

  
  $arr_number = strrev($num); 

  for($i =strlen($arr_number)-1; $i>=0; $i--) 
  { 
  ///////////////////////////////////////////////// 
  // 현재 자리를 구함 
  $digit = substr($arr_number, $i, 1); 
  /////////////////////////////////////////////////////////// 
  // 각 자리 명칭 
  switch($digit) 
  { 
    case '-' : $return_val .= "(-) "; 
        break; 
    case '0' : $return_val .= ""; 
        break; 
    case '1' : $return_val .= "1"; 
        break;    
    case '2' : $return_val .= "2"; 
        break;    
    case '3' : $return_val .= "3"; 
        break;    
    case '4' : $return_val .= "4"; 
        break;    
    case '5' : $return_val .= "5"; 
        break;    
    case '6' : $return_val .= "6"; 
        break;    
    case '7' : $return_val .= "7"; 
        break;    
    case '8' : $return_val .= "8"; 
        break;    
    case '9' : $return_val .= "9"; 
        break;    
  } 

    if($digit=="-")continue; 

    /////////////////////////////////////////////////////////// 
    // 4자리 표기법 공통부분 
    if($digit != 0) 
    { 
    if($i % 4 == 1)$return_val .= "십"; 
    else if($i % 4 == 2)$return_val .= "백"; 
    else if($i % 4 == 3)$return_val .= "천";
    } 
    
    /////////////////////////////////////////////////////////// 
    // 4자리 한자 표기법 단위 
    if($i % 4 == 0) 
    { 
    if( floor($i/ 4) ==0)$return_val .= ""; 
    else if(floor($i / 4)==1)$return_val .= "만"; 
    else if(floor($i / 4)==2)$return_val .= "억";
    else if(floor($i / 4)==3)$return_val .= "조 "; 
    else if(floor($i / 4)==4)$return_val .= "경 ";    } 
  } 

  return $return_val; 
 } 

/* 배열을 옵션값으로 만듦: 배열, 선택값 */
function setSelectOptions2($arr, $slt)
{
	foreach($arr as $val)
	{
		$selected = ($val == $slt)?'selected':'';
		echo "<option value='".$val."'  ".$selected.">".$val."</option>";
	}
}

/* 구분자 기준으로 해당배열의 값 return (문자, 구분갯수체크,구분자,리턴값의 배열번호) */
function getArraySeparate($preString,$chkCount,$separate,$getarr) {
	$rtnvalue="";
	if($preString){
		if(eregi($separate,$preString)){
			$arr=explode($separate,$preString);
			if(count($arr)==$chkCount){
				for($i=0;$i<$chkCount;$i++){
					if($i==$getarr){
						$rtnvalue=$arr[$i];
					}
				}
			}
		}
	}
	return $rtnvalue;
}


// multi-dimensional array에 사용자지정 함수적용
function array_map_deep($fn, $array)
{
    if(is_array($array)) {
        foreach($array as $key => $value) {
            if(is_array($value)) {
                $array[$key] = array_map_deep($fn, $value);
            } else {
                $array[$key] = call_user_func($fn, $value);
            }
        }
    } else {
        $array = call_user_func($fn, $array);
    }

    return $array;
}

// SQL Injection 대응 문자열 필터링
function sql_escape_string($str)
{
    $pattern = '/(and|or).*(union|select|insert|update|delete|from|where|limit|create|drop).*/i';
    $replace = '';

    $str = preg_replace($pattern, $replace, $str);
    $str = call_user_func(MARI_ESCAPE_FUNCTION, $str);

    return $str;
}

// 마이크로 타임을 얻어 계산 형식으로 만듦
function get_microtime()
{
    list($usec, $sec) = explode(" ",microtime());
    return ((float)$usec + (float)$sec);
}





/*최신글스킨*/
function view_list($skin_dir='', $w_table, $rows=10, $subject_len=40, $cache_time=1, $options='')
{
    global $mari;

    if (!$skin_dir) $skin_dir = 'basic';


        $view_list_skin_path = MARI_LATESTSKIN_PATH;
        $view_list_skin_url  = MARI_LATESTSKIN_URL;

    $cache_fwrite = false;


        $list = array();

        $sql = " select * from mari_write where w_table = '$w_table' ";
        $board = sql_fetch($sql);
        $w_subject = get_text($board['w_subject']);

        $tmp_write_table = $mari['write_prefix'] . $w_table; // 게시판 테이블 전체이름
        $sql = " select * from mari_write where w_table='$w_table' and w_comment = 0 order by w_num limit 0, $rows ";
        $result = sql_query($sql);
        for ($i=0; $row = sql_fetch_array($result); $i++) {
            $list[$i] = get_list($row, $board, $view_list_skin_url, $subject_len);
        }

        if($cache_fwrite) {
            $handle = fopen($cache_file, 'w');
            $cache_content = "<?php\nif (!defined('_MARICMS_')) exit;\n\$w_subject=\"".$w_subject."\";\n\$list=".var_export($list, true)."?>";
            fwrite($handle, $cache_content);
            fclose($handle);
        }



    ob_start();
    include $view_list_skin_path.'/view.list.tpl';
    $content = ob_get_contents();
    ob_end_clean();

    return $content;
}



// 한페이지에 보여줄 행, 현재페이지, 총페이지수, URL




// 한페이지에 보여줄 행, 현재페이지, 총페이지수, URL
function get_paging($write_pages, $cur_page, $total_page, $url, $add="")
{
    //$url = preg_replace('#&amp;page=[0-9]*(&amp;page=)$#', '$1', $url);
    //페이지코딩추가 2016-11-22 이지은
    $str = '';
    if ($cur_page > 1) {
        $str .= '<li><a href="'.$url.'1'.$add.'" > << </a></li>'.PHP_EOL;
    }

    $start_page = ( ( (int)( ($cur_page - 1 ) / $write_pages ) ) * $write_pages ) + 1;
    $end_page = $start_page + $write_pages - 1;

    if ($end_page >= $total_page) $end_page = $total_page;

    if ($start_page > 1) $str .= '<li><a href="'.$url.($start_page-1).$add.'"> < </a></li>'.PHP_EOL;

    if ($total_page > 1) {
        for ($k=$start_page;$k<=$end_page;$k++) {
            if ($cur_page != $k)
                $str .= '<li><a href="'.$url.$k.$add.'">'.$k.'</a></li>'.PHP_EOL;
            else
                $str .= '<li><a href="#" class="p_on1">'.$k.'</a></li>'.PHP_EOL;
        }
    }

    if ($total_page > $end_page) $str .= '<li><a href="'.$url.($end_page+1).$add.'" > > </a></li>'.PHP_EOL;

    if ($cur_page < $total_page) {
        $str .= '<li><a href="'.$url.$total_page.$add.'" > >> </a></li>'.PHP_EOL;
    }

    if ($str)
        return "<div class=\"p_num1\"><ul><li>{$str}</li></ul></div>";
    else
        return "";
}


// 페이징 코드의 <div><span> 태그 다음에 코드를 삽입
function page_insertbefore($paging_html, $insert_html)
{
    if ($paging_html) {
        return preg_replace("/^(<div[^>]+><span[^>]+>)/", '$1'.$insert_html, $paging_html);
    }
}

// 페이징 코드의 </span></div> 태그 이전에 코드를 삽입
function page_insertafter($paging_html, $insert_html)
{
    if ($paging_html) {
        //return preg_replace("/(<\/span><\/div>)$/", $insert_html.'$1', $paging_html);
        return preg_replace("#(</span></div>)$#", $insert_html.'$1', $paging_html);
    }
}

// 변수 또는 배열의 이름과 값을 얻어냄. print_r() 함수의 변형
function print_r2($var)
{
    ob_start();
    print_r($var);
    $str = ob_get_contents();
    ob_end_clean();
    $str = str_replace(" ", "&nbsp;", $str);
    echo nl2br("<span style='font-family:Tahoma, 굴림; font-size:9pt;'>$str</span>");
}


// 메타태그를 이용한 URL 이동
// header("location:URL") 을 대체
function goto_url($url)
{
    $url = str_replace("&amp;", "&", $url);
    //echo "<script> location.replace('$url'); </script>";

    if (!headers_sent())
        header('Location: '.$url);
    else {
        echo '<script>';
        echo 'location.replace("'.$url.'");';
        echo '</script>';
        echo '<noscript>';
        echo '<meta http-equiv="refresh" content="0;url='.$url.'" />';
        echo '</noscript>';
    }
    exit;
}


// 세션변수 생성
function set_session($session_name, $value)
{
    if (PHP_VERSION < '5.3.0')
        session_register($session_name);
    // PHP 버전별 차이를 없애기 위한 방법
    $$session_name = $_SESSION[$session_name] = $value;
}


// 세션변수값 얻음
function get_session($session_name)
{
    return isset($_SESSION[$session_name]) ? $_SESSION[$session_name] : '';
}


// 쿠키변수 생성
function set_cookie($cookie_name, $value, $expire)
{
    global $mari;

    setcookie($cookie_name, $value, MARI_SERVER_TIME + $expire, '/', MARI_COOKIE_DOMAIN);
}


// 쿠키변수값 얻음
function get_cookie($cookie_name)
{
    $cookie = hash('sha256',$cookie_name);
    if (array_key_exists($cookie, $_COOKIE))
        return base64_decode($_COOKIE[hash('sha256',$cookie_name)]);
    else
        return "";
}


// 경고메세지를 경고창으로
function alert($msg='', $url='', $error=true, $post=false)
{
    global $mari, $config, $member;
    global $_admin;

    if (!$msg) $msg = '올바른 방법으로 이용해 주십시오.';

    $header = '';
    if (isset($mari['title'])) {
        $header = $mari['title'];
    }
    include_once(MARI_LIB_PATH.'/alert.php');
    exit;
}

// 경고메세지 출력후 창을 닫음
function alert_close($msg, $error=true)
{
    global $mari;

    $header = '';
    if (isset($mari['title'])) {
        $header = $mari['title'];
    }

echo"
<script>
alert(\"".$msg."\");
window.open(\"about:blank\",\"_self\").close();
</script>

";
    exit;
}

// confirm 창
function confirm($msg, $url1='', $url2='', $url3='')
{
    global $mari;

    if (!$msg) {
        $msg = '올바른 방법으로 이용해 주십시오.';
        alert($msg);
    }

    if(!trim($url1) || !trim($url2)) {
        $msg = '$url1 과 $url2 를 지정해 주세요.';
        alert($msg);
    }

    if (!$url3) $url3 = $_SERVER['HTTP_REFERER'];

    $msg = str_replace("\\n", "<br>", $msg);

    $header = '';
    if (isset($mari['title'])) {
        $header = $mari['title'];
    }
    include_once(MARI_BBS_PATH.'/confirm.php');
    exit;
}



// 방문자로그
function get_brow($agent)
{
    $agent = strtolower($agent);

    //echo $agent; echo "<br/>";

    if (preg_match("/msie ([1-9][0-9]\.[0-9]+)/", $agent, $m)) { $s = 'MSIE '.$m[1]; }
    else if(preg_match("/firefox/", $agent))            { $s = "FireFox"; }
    else if(preg_match("/chrome/", $agent))             { $s = "Chrome"; }
    else if(preg_match("/x11/", $agent))                { $s = "Netscape"; }
    else if(preg_match("/opera/", $agent))              { $s = "Opera"; }
    else if(preg_match("/gec/", $agent))                { $s = "Gecko"; }
    else if(preg_match("/bot|slurp/", $agent))          { $s = "Robot"; }
    else if(preg_match("/internet explorer/", $agent))  { $s = "IE"; }
    else if(preg_match("/mozilla/", $agent))            { $s = "Mozilla"; }
    else { $s = "기타"; }

    return $s;
}

function get_os($agent)
{
    $agent = strtolower($agent);

    //echo $agent; echo "<br/>";

    if (preg_match("/windows 98/", $agent))                 { $s = "98"; }
    else if(preg_match("/windows 95/", $agent))             { $s = "95"; }
    else if(preg_match("/windows nt 4\.[0-9]*/", $agent))   { $s = "NT"; }
    else if(preg_match("/windows nt 5\.0/", $agent))        { $s = "2000"; }
    else if(preg_match("/windows nt 5\.1/", $agent))        { $s = "XP"; }
    else if(preg_match("/windows nt 5\.2/", $agent))        { $s = "2003"; }
    else if(preg_match("/windows nt 6\.0/", $agent))        { $s = "Vista"; }
    else if(preg_match("/windows nt 6\.1/", $agent))        { $s = "Windows7"; }
    else if(preg_match("/windows nt 6\.2/", $agent))        { $s = "Windows8"; }
    else if(preg_match("/windows 9x/", $agent))             { $s = "ME"; }
    else if(preg_match("/windows ce/", $agent))             { $s = "CE"; }
    else if(preg_match("/mac/", $agent))                    { $s = "MAC"; }
    else if(preg_match("/linux/", $agent))                  { $s = "Linux"; }
    else if(preg_match("/sunos/", $agent))                  { $s = "sunOS"; }
    else if(preg_match("/irix/", $agent))                   { $s = "IRIX"; }
    else if(preg_match("/phone/", $agent))                  { $s = "Phone"; }
    else if(preg_match("/bot|slurp/", $agent))              { $s = "Robot"; }
    else if(preg_match("/internet explorer/", $agent))      { $s = "IE"; }
    else if(preg_match("/mozilla/", $agent))                { $s = "Mozilla"; }
    else { $s = "기타"; }

    return $s;
}


function url_auto_link($str)
{
    global $mari;
    global $config;

    $str = str_replace(array("&lt;", "&gt;", "&amp;", "&quot;", "&nbsp;"), array("\t_lt_\t", "\t_gt_\t", "&", "\"", "\t_nbsp_\t"), $str);
    $str = preg_replace("/(^|[\"'\s(])(www\.[^\"'\s()]+)/i", "\\1<A HREF=\"http://\\2\" TARGET='{$config['c_link_target']}'>\\2</A>", $str);
    $str = preg_replace("`(?:(?:(?:href|src)\s*=\s*(?:\"|'|)){0})((http|https|ftp|telnet|news|mms)://[^\"'\s()]+)`", "<A HREF=\"\\1\" TARGET='{$config['c_link_target']}'>\\1</A>", $str);
    $str = preg_replace("/[0-9a-z_-]+@[a-z0-9._-]{4,}/i", "<a href='mailto:\\0'>\\0</a>", $str);
    $str = str_replace(array("\t_nbsp_\t", "\t_lt_\t", "\t_gt_\t"), array("&nbsp;", "&lt;", "&gt;"), $str);

    return $str;
}


// url에 http:// 를 붙인다
function set_http($url)
{
    if (!trim($url)) return;

    if (!preg_match("/^(http|https|ftp|telnet|news|mms)\:\/\//i", $url))
        $url = "http://" . $url;

    return $url;
}


// 파일의 용량을 구한다.
//function get_filesize($file)
function get_filesize($size)
{
    //$size = @filesize(addslashes($file));
    if ($size >= 1048576) {
        $size = number_format($size/1048576, 1) . "M";
    } else if ($size >= 1024) {
        $size = number_format($size/1024, 1) . "K";
    } else {
        $size = number_format($size, 0) . "byte";
    }
    return $size;
}





// 폴더의 용량 ($dir는 / 없이 넘기세요)
function get_dirsize($dir)
{
    $size = 0;
    $d = dir($dir);
    while ($entry = $d->read()) {
        if ($entry != '.' && $entry != '..') {
            $size += filesize($dir.'/'.$entry);
        }
    }
    $d->close();
    return $size;
}


/*************************************************************************
**
**  MARICMS 관련 함수 모음
**
*************************************************************************/

function get_list($write_row, $board, $skin_url, $subject_len=40)
{
    global $mari, $config;
    global $qstr, $page;

    //$t = get_microtime();

    // 배열전체를 복사
    $list = $write_row;
    unset($write_row);

    $list['is_notice'] = preg_match("/[^0-9]{0,1}{$list['wr_id']}[\r]{0,1}/",$board['w_notice']);

    if ($subject_len)
        $list['subject'] = conv_subject($list['w_subject'], $subject_len, '…');
    else
        $list['subject'] = conv_subject($list['w_subject'], $board['bo_subject_len'], '…');



        $list['content'] = html_content($list['w_content'], $html);

    $list['comment_cnt'] = '';
    if ($list['w_comment'])
        $list['comment_cnt'] = "<span class=\"cnt_cmt\">".$list['w_comment']."</span>";

    // 당일인 경우 시간으로 표시함
    $list['datetime'] = substr($list['w_datetime'],0,10);
    $list['datetime2'] = $list['w_datetime'];
    if ($list['datetime'] == MARI_TIME_YMD)
        $list['datetime2'] = substr($list['datetime2'],11,5);
    else
        $list['datetime2'] = substr($list['datetime2'],5,5);
    // 4.1


    $reply = $list['w_reply'];

    $list['reply'] = strlen($reply)*10;



    return $list;

}

// get_list 의 alias
function get_view($write_row, $board, $skin_url)
{
    return get_list($write_row, $board, $skin_url, 255);
}


// set_search_font(), get_search_font() 함수를 search_font() 함수로 대체
function search_font($stx, $str)
{
    global $config;

    // 문자앞에 \ 를 붙입니다.
    $src = array('/', '|');
    $dst = array('\/', '\|');

    if (!trim($stx)) return $str;

    // 검색어 전체를 공란으로 나눈다
    $s = explode(' ', $stx);

    // "/(검색1|검색2)/i" 와 같은 패턴을 만듬
    $pattern = '';
    $bar = '';
    for ($m=0; $m<count($s); $m++) {
        if (trim($s[$m]) == '') continue;
        // 태그는 포함하지 않아야 하는데 잘 안되는군. ㅡㅡa
        //$pattern .= $bar . '([^<])(' . quotemeta($s[$m]) . ')';
        //$pattern .= $bar . quotemeta($s[$m]);
        //$pattern .= $bar . str_replace("/", "\/", quotemeta($s[$m]));
        $tmp_str = quotemeta($s[$m]);
        $tmp_str = str_replace($src, $dst, $tmp_str);
        $pattern .= $bar . $tmp_str . "(?![^<]*>)";
        $bar = "|";
    }

    // 지정된 검색 폰트의 색상, 배경색상으로 대체
    $replace = "<b class=\"sch_word\">\\1</b>";

    return preg_replace("/($pattern)/i", $replace, $str);
}


// 제목을 변환
function conv_subject($subject, $len, $suffix='')
{
    return cut_str(get_text($subject), $len, $suffix);
}

// 내용을 변환
function html_content($content, $html, $filter=true)
{
    global $config, $board;

    if ($html)
    {
        $source = array();
        $target = array();

        $source[] = "//";
        $target[] = "";

        if ($html == 2) { // 자동 줄바꿈
            $source[] = "/\n/";
            $target[] = "<br/>";
        }

        // 테이블 태그의 개수를 세어 테이블이 깨지지 않도록 한다.
        $table_begin_count = substr_count(strtolower($content), "<table");
        $table_end_count = substr_count(strtolower($content), "</table");
        for ($i=$table_end_count; $i<$table_begin_count; $i++)
        {
            $content .= "</table>";
        }

        $content = preg_replace($source, $target, $content);

        if($filter)
            $content = html_purifier($content);
    }
    else // text 이면
    {
        // & 처리 : &amp; &nbsp; 등의 코드를 정상 출력함
        $content = html_symbol($content);

        // 공백 처리
		//$content = preg_replace("/  /", "&nbsp; ", $content);
		$content = str_replace("  ", "&nbsp; ", $content);
		$content = str_replace("\n ", "\n&nbsp;", $content);

        $content = get_text($content, 1);

        $content = url_auto_link($content);
    }

    return $content;
}


// http://htmlpurifier.org/
// Standards-Compliant HTML Filtering
// Safe  : HTML Purifier defeats XSS with an audited whitelist
// Clean : HTML Purifier ensures standards-compliant output
// Open  : HTML Purifier is open-source and highly customizable
function html_purifier($html)
{
    $f = file(MARI_PLUGIN_PATH.'/htmlpurifier/safeiframe.txt');
    $domains = array();
    foreach($f as $domain){
        // 첫행이 # 이면 주석 처리
        if (!preg_match("/^#/", $domain)) {
            $domain = trim($domain);
            if ($domain)
                array_push($domains, $domain);
        }
    }
    // 내 도메인도 추가
    array_push($domains, $_SERVER['HTTP_HOST'].'/');
    $safeiframe = implode('|', $domains);

    include_once(MARI_PLUGIN_PATH.'/htmlpurifier/HTMLPurifier.standalone.php');
    $config = HTMLPurifier_Config::createDefault();
    // data/cache 디렉토리에 CSS, HTML, URI 디렉토리 등을 만든다.
    $config->set('Cache.SerializerPath', MARI_DATA_PATH.'/cache');
    $config->set('HTML.SafeEmbed', true);
    $config->set('HTML.SafeObject', true);
    $config->set('HTML.SafeIframe', true);
    $config->set('URI.SafeIframeRegexp','%^(https?:)?//('.$safeiframe.')%');
    $config->set('Attr.AllowedFrameTargets', array('_blank'));
    $purifier = new HTMLPurifier($config);
    return $purifier->purify($html);
}




// 게시판의 다음글 번호를 얻는다.
function get_next_num($table)
{
    // 가장 작은 번호를 얻어
    $sql = " select min(wr_num) as min_wr_num from $table ";
    $row = sql_fetch($sql);
    // 가장 작은 번호에 1을 빼서 넘겨줌
    return (int)($row['min_wr_num'] - 1);
}


// 그룹 설정 테이블에서 하나의 행을 읽음
function get_group($gr_id)
{
    global $mari;

    return sql_fetch(" select * from {$mari['group_table']} where gr_id = '$gr_id' ");
}


// 회원 정보를 얻는다.
function get_member($m_id, $fields='*')
{
    global $mari;

    return sql_fetch(" select $fields from {$mari['member_table']} where m_id = TRIM('$m_id') ");
}


// 날짜, 조회수의 경우 높은 순서대로 보여져야 하므로 $flag 를 추가
// $flag : asc 낮은 순서 , desc 높은 순서
// 제목별로 컬럼 정렬하는 QUERY STRING
function subject_sort_link($col, $query_string='', $flag='asc')
{
    global $sst, $sod, $sfl, $stx, $page;

    $q1 = "sst=$col";
    if ($flag == 'asc')
    {
        $q2 = 'sod=asc';
        if ($sst == $col)
        {
            if ($sod == 'asc')
            {
                $q2 = 'sod=desc';
            }
        }
    }
    else
    {
        $q2 = 'sod=desc';
        if ($sst == $col)
        {
            if ($sod == 'desc')
            {
                $q2 = 'sod=asc';
            }
        }
    }

    $arr_query = array();
    $arr_query[] = $query_string;
    $arr_query[] = $q1;
    $arr_query[] = $q2;
    $arr_query[] = 'sfl='.$sfl;
    $arr_query[] = 'stx='.$stx;
    $arr_query[] = 'page='.$page;
    $qstr = implode("&amp;", $arr_query);

    return "<a href=\"{$_SERVER['PHP_SELF']}?{$qstr}\">";
}


// 관리자 정보를 얻음
function get_admin($admin='administrator', $fields='*')
{
    global $config, $group, $board;
    global $mari;

    $is = false;
    if ($admin == 'board') {
        $mb = sql_fetch("select {$fields} from {$mari['member_table']} where m_id in ('{$board['bo_admin']}') limit 1 ");
        $is = true;
    }

    if (($is && !$mb['m_id']) || $admin == 'group') {
        $mb = sql_fetch("select {$fields} from {$mari['member_table']} where m_id in ('{$group['gr_admin']}') limit 1 ");
        $is = true;
    }

    if (($is && !$mb['m_id']) || $admin == 'administrator') {
        $mb = sql_fetch("select {$fields} from {$mari['member_table']} where m_id in ('{$config['c_admin']}') limit 1 ");
    }

    return $mb;
}


// 관리자인가?
function _admin($m_id)
{
    global $config, $group, $board;

    if (!$m_id) return;

    if ($config['c_admin'] == $m_id) return 'administrator';
    if (isset($group['gr_admin']) && ($group['gr_admin'] == $m_id)) return 'group';
    if (isset($board['bo_admin']) && ($board['bo_admin'] == $m_id)) return 'board';
    return '';
}


// 분류 옵션을 얻음
// 4.00 에서는 카테고리 테이블을 없애고 보드테이블에 있는 내용으로 대체
function get_category_option($bo_table='', $w_catecode='')
{
    global $mari, $bbs_config, $_admin;

    $categories = explode(",", $bbs_config['bo_category_list']); // 구분자가 , 로 되어 있음
    $str = "";
    for ($i=0; $i<count($categories); $i++) {
        $category = trim($categories[$i]);
        if (!$category) continue;

        $str .= "<option value=\"$categories[$i]\"";
        if ($category == $w_catecode) {
            $str .= ' selected="selected"';
        }
        $str .= ">$categories[$i]</option>\n";
    }

    return $str;
}


// 게시판 그룹을 SELECT 형식으로 얻음
function get_group_select($name, $selected='', $event='')
{
    global $mari, $_admin, $member;

    $sql = " select gr_id, gr_subject from {$mari['group_table']} a ";
    if ($_admin == "group") {
        $sql .= " left join {$mari['member_table']} b on (b.m_id = a.gr_admin)
                  where b.m_id = '{$member['m_id']}' ";
    }
    $sql .= " order by a.gr_id ";

    $result = sql_query($sql);
    $str = "<select id=\"$name\" name=\"$name\" $event>\n";
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($row['gr_subject'], $selected, $row['gr_subject']);
    }
    $str .= "</select>";
    return $str;
}

// 회원직원리스트를 SELECT 형식으로 얻음
function get_memberstef_select($name, $selected='', $event='')
{
    global $mari, $_admin, $member;

    $sql = "select  m_id, m_name from  mari_member  where m_level>=3 order by m_name desc";
    $result = sql_query($sql);
    $str = "<select id=\"$name\" name=\"$name\" $event>\n";
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($row['m_name'], $selected, $row['m_name']);
    }
    $str .= "</select>";
    return $str;
}

// 회원관리직원을 4레벨이상만 SELECT 형식으로 얻음
function get_memberadmin_select($name, $selected='', $event='')
{
    global $mari, $_admin, $member;

    $sql = "select  m_id, m_name from  mari_member  where m_level>=4 order by m_name desc";
    $result = sql_query($sql);
    $str = "<select id=\"$name\" name=\"$name\" $event>\n";
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($row['m_id'], $selected, $row['m_id']); //m_name -> m_id로 수정했습니다 (동욱)
    }
    $str .= "</select>";
    return $str;
}



// 상품분류를 SELECT 형식으로 얻음
function get_product_select($name, $selected='', $event='')
{
    global $mari, $_admin, $member;

    $sql = " select it_id, it_item_name from {$mari['contact_item_table']}";
    $sql .= " order by it_item_name asc";

    $result = sql_query($sql);
    $str = "<select class=form-control id=\"$name\" name=\"$name\" $event>\n";
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($row['it_item_name'], $selected, $row['it_item_name']);
    }
    $str .= "</select>";
    return $str;
}







// 회원레벨등급을 SELECT 형식으로 얻음
function get_level_select($name, $selected='', $event='')
{
    global $mari, $_admin, $member;

    $sql = "select  * from  mari_level order by lv_level desc";
    $result = sql_query($sql);
    $str = "<select id=\"$name\" name=\"$name\" $event>\n";
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($row['lv_level'], $selected, $row['lv_name']);
    }
    $str .= "</select>";
    return $str;
}



//회원레벨등급을 체크팍스형태로 얻음
function get_level_checkbox($name, $checked='', $event='')
{
    global $mari, $_admin, $member;

	$sql = "select  * from  mari_level order by lv_level desc";
	$result = sql_query($sql, false);
    for ($i=0; $row=sql_fetch_array($result); $i++) {
        $str .= option_checked($row['lv_level'], $checked, $row['lv_name']);
    }
    return $str;
}


function option_checked($value, $checked, $text='')
{
    if (!$text) $text = $value;
    if ($value == $checked)
        return "<input type=\"checkbox\" value=\"$value\" name=\"$name\" checked=\"checked\">$text <br/>\n";
    else
        return "<input type=\"checkbox\" value=\"$value\" name=\"$name\">$text<br/>";
}


function option_selected($value, $selected, $text='')
{
    if (!$text) $text = $value;
    if ($value == $selected)
        return "<option value=\"$value\" selected=\"selected\">$text</option>\n";
    else
        return "<option value=\"$value\">$text</option>\n";
}


// '예', '아니오'를 SELECT 형식으로 얻음
function get_yn_select($name, $selected='1', $event='')
{
    $str = "<select name=\"$name\" $event>\n";
    if ($selected) {
        $str .= "<option value=\"1\" selected>예</option>\n";
        $str .= "<option value=\"0\">아니오</option>\n";
    } else {
        $str .= "<option value=\"1\">예</option>\n";
        $str .= "<option value=\"0\" selected>아니오</option>\n";
    }
    $str .= "</select>";
    return $str;
}


// 스킨디렉토리를 SELECT 형식으로 얻음
function get_skin_select($skin_gubun, $id, $name, $selected='', $event='')
{
    $skins = get_skin_dir($skin_gubun);
    $str = "<select id=\"$id\" name=\"$name\" $event>\n";
    for ($i=0; $i<count($skins); $i++) {
        if ($i == 0) $str .= "<option value=\"\">선택</option>";
        $str .= option_selected($skins[$i], $selected);
    }
    $str .= "</select>";
    return $str;
}


// 스킨경로를 얻는다
function get_skin_dir($skin, $skin_path=MARI_BOARDSKIN_PATH)
{
    global $mari;

    $result_array = array();

    $dirname = $skin_path.'/'.$skin.'/';
    $handle = opendir($dirname);
    while ($file = readdir($handle)) {
        if($file == '.'||$file == '..') continue;

        if (is_dir($dirname.$file)) $result_array[] = $file;
    }
    closedir($handle);
    sort($result_array);

    return $result_array;
}







// 파일을 보이게 하는 링크 (이미지, 플래쉬, 동영상)
function view_file_link($file, $width, $height, $content='')
{
    global $config, $board;
    global $mari;
    static $ids;

    if (!$file) return;

    $ids++;

    // 파일의 폭이 게시판설정의 이미지폭 보다 크다면 게시판설정 폭으로 맞추고 비율에 따라 높이를 계산
    if ($width > $board['bo_image_width'] && $board['bo_image_width'])
    {
        $rate = $board['bo_image_width'] / $width;
        $width = $board['bo_image_width'];
        $height = (int)($height * $rate);
    }

    // 폭이 있는 경우 폭과 높이의 속성을 주고, 없으면 자동 계산되도록 코드를 만들지 않는다.
    if ($width)
        $attr = ' width="'.$width.'" height="'.$height.'" ';
    else
        $attr = '';

    if (preg_match("/\.({$config['c_image_extension']})$/i", $file)) {
        $img = '<a href="'.MARI_B_URL.'/view_image.php?bb_table='.$board['bb_table'].'&amp;fn='.urlencode($file).'" target="_blank" class="view_image">';
        $img .= '<img src="'.MARI_DATA_URL.'/file/'.$board['bb_table'].'/'.urlencode($file).'" alt="'.$content.'">';
        $img .= '</a>';

        return $img;
    }
}


// view_file_link() 함수에서 넘겨진 이미지를 보이게 합니다.
// {img:0} ... {img:n} 과 같은 형식
function view_image($view, $number, $attribute)
{
    if ($view['file'][$number]['view'])
        return preg_replace("/>$/", " $attribute>", $view['file'][$number]['view']);
    else
        //return "{".$number."번 이미지 없음}";
        return "";
}


/*
// {link:0} ... {link:n} 과 같은 형식
function view_link($view, $number, $attribute)
{
    global $config;

    if ($view['link'][$number]['link'])
    {
        if (!preg_match("/target/i", $attribute))
            $attribute .= " target='$config['c_link_target']'";
        return "<a href='{$view['link'][$number]['href']}' $attribute>{$view['link'][$number]['link']}</a>";
    }
    else
        return "{".$number."번 링크 없음}";
}
*/


function cut_str($str, $len, $suffix="…")
{
    $arr_str = preg_split("//u", $str, -1, PREG_SPLIT_NO_EMPTY);
    $str_len = count($arr_str);

    if ($str_len >= $len) {
        $slice_str = array_slice($arr_str, 0, $len);
        $str = join("", $slice_str);

        return $str . ($str_len > $len ? $suffix : '');
    } else {
        $str = join("", $arr_str);
        return $str;
    }
}


// TEXT 형식으로 변환
function get_text($str, $html=0)
{
    /* 3.22 막음 (HTML 체크 줄바꿈시 출력 오류때문)
    $source[] = "/  /";
    $target[] = " &nbsp;";
    */

    // 3.31
    // TEXT 출력일 경우 &amp; &nbsp; 등의 코드를 정상으로 출력해 주기 위함
    if ($html == 0) {
        $str = html_symbol($str);
    }

    $source[] = "/</";
    $target[] = "&lt;";
    $source[] = "/>/";
    $target[] = "&gt;";
    //$source[] = "/\"/";
    //$target[] = "&#034;";
    $source[] = "/\'/";
    $target[] = "&#039;";
    //$source[] = "/}/"; $target[] = "&#125;";
    if ($html) {
        $source[] = "/\n/";
        $target[] = "<br/>";
    }

    return preg_replace($source, $target, $str);
}


/*
// HTML 특수문자 변환 htmlspecialchars
function hsc($str)
{
    $trans = array("\"" => "&#034;", "'" => "&#039;", "<"=>"&#060;", ">"=>"&#062;");
    $str = strtr($str, $trans);
    return $str;
}
*/

// 3.31
// HTML SYMBOL 변환
// &nbsp; &amp; &middot; 등을 정상으로 출력
function html_symbol($str)
{
    return preg_replace("/\&([a-z0-9]{1,20}|\#[0-9]{0,3});/i", "&#038;\\1;", $str);
}


/*************************************************************************
**
**  SQL 관련 함수 모음
**
*************************************************************************/

// DB 연결
function sql_connect($host, $user, $pass)
{
    global $mari;

    return @mysql_connect($host, $user, $pass);
}


// DB 선택
function sql_select_db($db, $connect)
{
    global $mari;

    return @mysql_select_db($db, $connect);
}


// mysql_query 와 mysql_error 를 한꺼번에 처리
function sql_query($sql, $error=MARI_DISPLAY_SQL_ERROR)
{
    // Blind SQL Injection 취약점 해결
    $sql = trim($sql);
    // union의 사용을 허락하지 않습니다.
    $sql = preg_replace("#^select.*from.*union.*#i", "select 1", $sql);
    // `information_schema` DB로의 접근을 허락하지 않습니다.
    $sql = preg_replace("#^select.*from.*where.*`?information_schema`?.*#i", "select 1", $sql);
    if ($error)
        $result = @mysql_query($sql) or die("<p>$sql<p>" . mysql_errno() . " : " .  mysql_error() . "<p>error file : $_SERVER[PHP_SELF]");
    else
        $result = @mysql_query($sql);
    return $result;
}


// 쿼리를 실행한 후 결과값에서 한행을 얻는다.
function sql_fetch($sql, $error=MARI_DISPLAY_SQL_ERROR)
{
    $result = sql_query($sql, $error);
    //$row = @sql_fetch_array($result) or die("<p>$sql<p>" . mysql_errno() . " : " .  mysql_error() . "<p>error file : $_SERVER['PHP_SELF']");
    $row = sql_fetch_array($result);
    return $row;
}


// 결과값에서 한행 연관배열(이름으로)로 얻는다.
function sql_fetch_array($result)
{
    $row = @mysql_fetch_assoc($result);
    return $row;
}


// $result에 대한 메모리(memory)에 있는 내용을 모두 제거한다.
// sql_free_result()는 결과로부터 얻은 질의 값이 커서 많은 메모리를 사용할 염려가 있을 때 사용된다.
// 단, 결과 값은 스크립트(script) 실행부가 종료되면서 메모리에서 자동적으로 지워진다.
function sql_free_result($result)
{
    return mysql_free_result($result);
}


function sql_password($value)
{
    // mysql 4.0x 이하 버전에서는 password() 함수의 결과가 16bytes
    // mysql 4.1x 이상 버전에서는 password() 함수의 결과가 41bytes
    $row = sql_fetch(" select password('$value') as pass ");
    return $row['pass'];
}


// PHPMyAdmin 참고
function get_table_define($table, $crlf="\n")
{
    global $mari;

    // For MySQL < 3.23.20
    $schema_create .= 'CREATE TABLE ' . $table . ' (' . $crlf;

    $sql = 'SHOW FIELDS FROM ' . $table;
    $result = sql_query($sql);
    while ($row = sql_fetch_array($result))
    {
        $schema_create .= '    ' . $row['Field'] . ' ' . $row['Type'];
        if (isset($row['Default']) && $row['Default'] != '')
        {
            $schema_create .= ' DEFAULT \'' . $row['Default'] . '\'';
        }
        if ($row['Null'] != 'YES')
        {
            $schema_create .= ' NOT NULL';
        }
        if ($row['Extra'] != '')
        {
            $schema_create .= ' ' . $row['Extra'];
        }
        $schema_create     .= ',' . $crlf;
    } // end while
    sql_free_result($result);

    $schema_create = preg_replace('/,' . $crlf . '$/', '', $schema_create);

    $sql = 'SHOW KEYS FROM ' . $table;
    $result = sql_query($sql);
    while ($row = sql_fetch_array($result))
    {
        $kname    = $row['Key_name'];
        $comment  = (isset($row['Comment'])) ? $row['Comment'] : '';
        $sub_part = (isset($row['Sub_part'])) ? $row['Sub_part'] : '';

        if ($kname != 'PRIMARY' && $row['Non_unique'] == 0) {
            $kname = "UNIQUE|$kname";
        }
        if ($comment == 'FULLTEXT') {
            $kname = 'FULLTEXT|$kname';
        }
        if (!isset($index[$kname])) {
            $index[$kname] = array();
        }
        if ($sub_part > 1) {
            $index[$kname][] = $row['Column_name'] . '(' . $sub_part . ')';
        } else {
            $index[$kname][] = $row['Column_name'];
        }
    } // end while
    sql_free_result($result);

    while (list($x, $columns) = @each($index)) {
        $schema_create     .= ',' . $crlf;
        if ($x == 'PRIMARY') {
            $schema_create .= '    PRIMARY KEY (';
        } else if (substr($x, 0, 6) == 'UNIQUE') {
            $schema_create .= '    UNIQUE ' . substr($x, 7) . ' (';
        } else if (substr($x, 0, 8) == 'FULLTEXT') {
            $schema_create .= '    FULLTEXT ' . substr($x, 9) . ' (';
        } else {
            $schema_create .= '    KEY ' . $x . ' (';
        }
        $schema_create     .= implode($columns, ', ') . ')';
    } // end while

    $schema_create .= $crlf . ') ENGINE=MyISAM DEFAULT CHARSET=utf8';

    return $schema_create;
} // end of the 'PMA_getTableDef()' function


// 리퍼러 체크
function referer_check($url='')
{
    /*
    // 제대로 체크를 하지 못하여 주석 처리함
    global $mari;

    if (!$url)
        $url = MARI_HOME_URL;

    if (!preg_match("/^http['s']?:\/\/".$_SERVER['HTTP_HOST']."/", $_SERVER['HTTP_REFERER']))
        alert("제대로 된 접근이 아닌것 같습니다.", $url);
    */
}


// 한글 요일
function get_yoil($date, $full=0)
{
    $arr_yoil = array ('일', '월', '화', '수', '목', '금', '토');

    $yoil = date("w", strtotime($date));
    $str = $arr_yoil[$yoil];
    if ($full) {
        $str .= '요일';
    }
    return $str;
}


// 날짜를 select 박스 형식으로 얻는다
function date_select($date, $name='')
{
    global $mari;

    $s = '';
    if (substr($date, 0, 4) == "0000") {
        $date = MARI_TIME_YMDHIS;
    }
    preg_match("/([0-9]{4})-([0-9]{2})-([0-9]{2})/", $date, $m);

    // 년
    $s .= "<select name='{$name}_y'>";
    for ($i=$m['0']-3; $i<=$m['0']+3; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['0']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>년 \n";

    // 월
    $s .= "<select name='{$name}_m'>";
    for ($i=1; $i<=12; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['2']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>월 \n";

    // 일
    $s .= "<select name='{$name}_d'>";
    for ($i=1; $i<=31; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['3']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>일 \n";

    return $s;
}


// 시간을 select 박스 형식으로 얻는다
// 1.04.00
// 경매에 시간 설정이 가능하게 되면서 추가함
function time_select($time, $name="")
{
    preg_match("/([0-9]{2}):([0-9]{2}):([0-9]{2})/", $time, $m);

    // 시
    $s .= "<select name='{$name}_h'>";
    for ($i=0; $i<=23; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['0']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>시 \n";

    // 분
    $s .= "<select name='{$name}_i'>";
    for ($i=0; $i<=59; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['2']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>분 \n";

    // 초
    $s .= "<select name='{$name}_s'>";
    for ($i=0; $i<=59; $i++) {
        $s .= "<option value='$i'";
        if ($i == $m['3']) {
            $s .= " selected";
        }
        $s .= ">$i";
    }
    $s .= "</select>초 \n";

    return $s;
}


// DEMO 라는 파일이 있으면 데모 화면으로 인식함
function check_demo()
{
    global $_admin;
    if ($_admin != 'administrator' && file_exists(MARI_PATH.'/DEMO'))
        alert('데모 화면에서는 하실(보실) 수 없는 작업입니다.');
}


// 문자열이 한글, 영문, 숫자, 특수문자로 구성되어 있는지 검사
function check_string($str, $options)
{
    global $mari;

    $s = '';
    for($i=0;$i<strlen($str);$i++) {
        $c = $str[$i];
        $oc = ord($c);

        // 한글
        if ($oc >= 0xA0 && $oc <= 0xFF) {
            if ($options & MARI_HANGUL) {
                $s .= $c . $str[$i+1] . $str[$i+2];
            }
            $i+=2;
        }
        // 숫자
        else if ($oc >= 0x30 && $oc <= 0x39) {
            if ($options & MARI_NUMERIC) {
                $s .= $c;
            }
        }
        // 영대문자
        else if ($oc >= 0x41 && $oc <= 0x5A) {
            if (($options & MARI_ALPHABETIC) || ($options & MARI_ALPHAUPPER)) {
                $s .= $c;
            }
        }
        // 영소문자
        else if ($oc >= 0x61 && $oc <= 0x7A) {
            if (($options & MARI_ALPHABETIC) || ($options & MARI_ALPHALOWER)) {
                $s .= $c;
            }
        }
        // 공백
        else if ($oc == 0x20) {
            if ($options & MARI_SPACE) {
                $s .= $c;
            }
        }
        else {
            if ($options & MARI_SPECIAL) {
                $s .= $c;
            }
        }
    }

    // 넘어온 값과 비교하여 같으면 참, 틀리면 거짓
    return ($str == $s);
}


// 한글(2bytes)에서 마지막 글자가 1byte로 끝나는 경우
// 출력시 깨지는 현상이 발생하므로 마지막 완전하지 않은 글자(1byte)를 하나 없앰
function cut_hangul_last($hangul)
{
    global $mari;

    // 한글이 반쪽나면 ?로 표시되는 현상을 막음
    $cnt = 0;
    for($i=0;$i<strlen($hangul);$i++) {
        // 한글만 센다
        if (ord($hangul[$i]) >= 0xA0) {
            $cnt++;
        }
    }

    return $hangul;
}


// 테이블에서 INDEX(키) 사용여부 검사
function explain($sql)
{
    if (preg_match("/^(select)/i", trim($sql))) {
        $q = "explain $sql";
        echo $q;
        $row = sql_fetch($q);
        if (!$row['key']) $row['key'] = "NULL";
        echo " <font color=blue>(type={$row['type']} , key={$row['key']})</font>";
    }
}

// 악성태그 변환
function bad_tag_convert($code)
{
    global $view;
    global $member, $_admin;

    if ($_admin && $member['m_id'] != $view['m_id']) {
        //$code = preg_replace_callback("#(\<(embed|object)[^\>]*)\>(\<\/(embed|object)\>)?#i",
        // embed 또는 object 태그를 막지 않는 경우 필터링이 되도록 수정
        $code = preg_replace_callback("#(\<(embed|object)[^\>]*)\>?(\<\/(embed|object)\>)?#i",
                    create_function('$matches', 'return "<div class=\"embedx\">보안문제로 인하여 관리자 아이디로는 embed 또는 object 태그를 볼 수 없습니다. 확인하시려면 관리권한이 없는 다른 아이디로 접속하세요.</div>";'),
                    $code);
    }

    return preg_replace("/\<([\/]?)(script|iframe|form)([^\>]*)\>?/i", "&lt;$1$2$3&gt;", $code);
}


// 토큰 생성
function _token()
{
    return hash('sha256',uniqid(rand(), true));
}


// 불법접근을 막도록 토큰을 생성하면서 토큰값을 리턴
function get_token()
{
    $token = hash('sha256',uniqid(rand(), true));
    set_session('ss_token', $token);

    return $token;
}


// POST로 넘어온 토큰과 세션에 저장된 토큰 비교
function check_token()
{
    set_session('ss_token', '');
    return true;
}


// 문자열에 utf8 문자가 들어 있는지 검사하는 함수
// 코드 : http://in2.php.net/manual/en/function.mb-check-encoding.php#95289
function is_utf8($str)
{
    $len = strlen($str);
    for($i = 0; $i < $len; $i++) {
        $c = ord($str[$i]);
        if ($c > 128) {
            if (($c > 247)) return false;
            elseif ($c > 239) $bytes = 4;
            elseif ($c > 223) $bytes = 3;
            elseif ($c > 191) $bytes = 2;
            else return false;
            if (($i + $bytes) > $len) return false;
            while ($bytes > 1) {
                $i++;
                $b = ord($str[$i]);
                if ($b < 128 || $b > 191) return false;
                $bytes--;
            }
        }
    }
    return true;
}


// UTF-8 문자열 자르기
// 출처 : https://www.google.co.kr/search?q=utf8_strcut&aq=f&oq=utf8_strcut&aqs=chrome.0.57j0l3.826j0&sourceid=chrome&ie=UTF-8
function utf8_strcut( $str, $size, $suffix='...' )
{
        $substr = substr( $str, 0, $size * 2 );
        $multi_size = preg_match_all( '/[\x80-\xff]/', $substr, $multi_chars );

        if ( $multi_size > 0 )
            $size = $size + intval( $multi_size / 3 ) - 1;

        if ( strlen( $str ) > $size ) {
            $str = substr( $str, 0, $size );
            $str = preg_replace( '/(([\x80-\xff]{3})*?)([\x80-\xff]{0,2})$/', '$1', $str );
            $str .= $suffix;
        }

        return $str;
}


/*
-----------------------------------------------------------
    Charset 을 변환하는 함수
-----------------------------------------------------------
iconv 함수가 있으면 iconv 로 변환하고
없으면 mb_convert_encoding 함수를 사용한다.
둘다 없으면 사용할 수 없다.
*/
function convert_charset($from_charset, $to_charset, $str)
{

    if( function_exists('iconv') )
        return iconv($from_charset, $to_charset, $str);
    elseif( function_exists('mb_convert_encoding') )
        return mb_convert_encoding($str, $to_charset, $from_charset);
    else
        die("Not found 'iconv' or 'mbstring' library in server.");
}


// mysql_real_escape_string 의 alias 기능을 한다.
function escape_trim($field)
{
    if ($field) {
        $str = call_user_func(MARI_ESCAPE_FUNCTION, $field);

        return $str;
    }
}


// $_POST 형식에서 checkbox 엘리먼트의 checked 속성에서 checked 가 되어 넘어 왔는지를 검사
function is_checked($field)
{
    return !empty($_POST[$field]);
}


function abs_ip2long($ip='')
{
    $ip = $ip ? $ip : $_SERVER['REMOTE_ADDR'];
    return abs(ip2long($ip));
}


function get_selected($field, $value)
{
    return ($field==$value) ? ' selected="selected"' : '';
}


function get_checked($field, $value)
{
    return ($field==$value) ? ' checked="checked"' : '';
}


function s_mobile()
{
    return preg_match('/'.MARI_MOBILE_AGENT.'/i', $_SERVER['HTTP_USER_AGENT']);
}


/*******************************************************************************
    유일한 키를 얻는다.

    결과 :

        년월일시분초00 ~ 년월일시분초99
        년(4) 월(2) 일(2) 시(2) 분(2) 초(2) 100분의1초(2)
        총 16자리이며 년도는 2자리로 끊어서 사용해도 됩니다.
        예) 2008062611570199 또는 08062611570199 (2100년까지만 유일키)

    사용하는 곳 :
    1. 게시판 글쓰기시 미리 유일키를 얻어 파일 업로드 필드에 넣는다.
    2. 주문번호 생성시에 사용한다.
    3. 기타 유일키가 필요한 곳에서 사용한다.
*******************************************************************************/
// 기존의 get_unique_id() 함수를 사용하지 않고 get_uniqid() 를 사용한다.
function get_uniqid()
{
    global $mari;

    sql_query(" LOCK TABLE {$mari['uniqid_table']} WRITE ");
    while (1) {
        // 년월일시분초에 100분의 1초 두자리를 추가함 (1/100 초 앞에 자리가 모자르면 0으로 채움)
        $key = date('YmdHis', time()) . str_pad((int)(microtime()*100), 2, "0", STR_PAD_LEFT);

        $result = sql_query(" insert into {$mari['uniqid_table']} set uq_id = '$key', uq_ip = '{$_SERVER['REMOTE_ADDR']}' ", false);
        if ($result) break; // 쿼리가 정상이면 빠진다.

        // insert 하지 못했으면 일정시간 쉰다음 다시 유일키를 만든다.
        usleep(10000); // 100분의 1초를 쉰다
    }
    sql_query(" UNLOCK TABLES ");

    return $key;
}


// CHARSET 변경 : euc-kr -> utf-8
function iconv_utf8($str)
{
    return iconv('euc-kr', 'utf-8', $str);
}


// CHARSET 변경 : utf-8 -> euc-kr
function iconv_euckr($str)
{
    return iconv('utf-8', 'euc-kr', $str);
}


// PC 또는 모바일 사용인지를 검사
function check_device($device)
{
    global $_admin;

    if ($_admin) return;

    if ($device=='pc' && MARI_S_MOBILE) {
        alert('PC 전용 게시판입니다.', MARI_HOME_URL);
    } else if ($device=='mobile' && !MARI_S_MOBILE) {
        alert('모바일 전용 게시판입니다.', MARI_HOME_URL);
    }
}


// 게시판 최신글 캐시 파일 삭제
function delete_cache_view_list($bb_table)
{
    $files = glob(MARI_DATA_PATH.'/cache/view_list-'.$bb_table.'-*');
    if (is_array($files)) {
        foreach ($files as $filename)
            unlink($filename);
    }
}

// 게시판 첨부파일 썸네일 삭제
function delete_board_thumbnail($table, $file)
{
    if(!$table || !$file)
        return;

    $files = glob(MARI_DATA_PATH.'/'.$table.'/'.$file.'');
    if (is_array($files)) {
        foreach ($files as $file_img)
            unlink($file_img);
    }
}

// 에디터 이미지 얻기
function get_editor_image($contents, $view=true)
{
    if(!$contents)
        return false;

    // $contents 중 img 태그 추출
    if ($view)
        $pattern = "/<img([^>]*)>/iS";
    else
        $pattern = "/<img[^>]*src=[\'\"]?([^>\'\"]+[^>\'\"]+)[\'\"]?[^>]*>/";
    preg_match_all($pattern, $contents, $matchs);

    return $matchs;
}

// 에디터 썸네일 삭제
function delete_editor_thumbnail($contents)
{
    if(!$contents)
        return;

    // $contents 중 img 태그 추출
    $matchs = get_editor_image($contents);

    if(!$matchs)
        return;

    for($i=0; $i<count($matchs[1]); $i++) {
        // 이미지 path 구함
        $imgurl = parse_url($matchs[1][$i]);
        $srcfile = $_SERVER['DOCUMENT_ROOT'].$imgurl['path'];

        $filename = preg_replace("/\.[^\.]+$/i", "", basename($srcfile));
        $filepath = dirname($srcfile);
        $files = glob($filepath.'/thumb-'.$filename.'*');
        if (is_array($files)) {
            foreach($files as $filename)
                unlink($filename);
        }
    }
}

// 1:1문의 첨부파일 썸네일 삭제
function delete_qa_thumbnail($file)
{
    if(!$file)
        return;

    $fn = preg_replace("/\.[^\.]+$/i", "", basename($file));
    $files = glob(MARI_DATA_PATH.'/qa/thumb-'.$fn.'*');
    if (is_array($files)) {
        foreach ($files as $filename)
            unlink($filename);
    }
}

// 스킨 style sheet 파일 얻기
function get_skin_stylesheet($skin_path, $dir='')
{
    if(!$skin_path)
        return "";

    $str = "";
    $files = array();

    if($dir)
        $skin_path .= '/'.$dir;

    $skin_url = MARI_HOME_URL.str_replace("\\", "/", str_replace(MARI_PATH, "", $skin_path));

    if(is_dir($skin_path)) {
        if($dh = opendir($skin_path)) {
            while(($file = readdir($dh)) !== false) {
                if($file == "." || $file == "..")
                    continue;

                if(is_dir($skin_path.'/'.$file))
                    continue;

                if(preg_match("/\.(css)$/i", $file))
                    $files[] = $file;
            }
            closedir($dh);
        }
    }

    if(!empty($files)) {
        sort($files);

        foreach($files as $file) {
            $str .= '<link rel="stylesheet" href="'.$skin_url.'/'.$file.'?='.date("md").'">'."\n";
        }
    }

    return $str;

    /*
    // glob 를 이용한 코드
    if (!$skin_path) return '';
    $skin_path .= $dir ? '/'.$dir : '';

    $str = '';
    $skin_url = MARI_HOME_URL.str_replace('\\', '/', str_replace(MARI_PATH, '', $skin_path));

    foreach (glob($skin_path.'/*.css') as $filepath) {
        $file = str_replace($skin_path, '', $filepath);
        $str .= '<link rel="stylesheet" href="'.$skin_url.'/'.$file.'?='.date('md').'">'."\n";
    }
    return $str;
    */
}

// 스킨 javascript 파일 얻기
function get_skin_javascript($skin_path, $dir='')
{
    if(!$skin_path)
        return "";

    $str = "";
    $files = array();

    if($dir)
        $skin_path .= '/'.$dir;

    $skin_url = MARI_HOME_URL.str_replace("\\", "/", str_replace(MARI_PATH, "", $skin_path));

    if(is_dir($skin_path)) {
        if($dh = opendir($skin_path)) {
            while(($file = readdir($dh)) !== false) {
                if($file == "." || $file == "..")
                    continue;

                if(is_dir($skin_path.'/'.$file))
                    continue;

                if(preg_match("/\.(js)$/i", $file))
                    $files[] = $file;
            }
            closedir($dh);
        }
    }

    if(!empty($files)) {
        sort($files);

        foreach($files as $file) {
            $str .= '<script src="'.$skin_url.'/'.$file.'"></script>'."\n";
        }
    }

    return $str;
}

// file_put_contents 는 PHP5 전용 함수이므로 PHP4 하위버전에서 사용하기 위함
// http://www.phpied.com/file_get_contents-for-php4/
if (!function_exists('file_put_contents')) {
    function file_put_contents($filename, $data) {
        $f = @fopen($filename, 'w');
        if (!$f) {
            return false;
        } else {
            $bytes = fwrite($f, $data);
            fclose($f);
            return $bytes;
        }
    }
}


// HTML 마지막 처리
function html_end()
{
    global $html_process;

    return $html_process->run();
}

function add_stylesheet($stylesheet, $order=0)
{
    global $html_process;

    if(trim($stylesheet))
        $html_process->merge_stylesheet($stylesheet, $order);
}

class html_process {
    protected $css = array();

    function merge_stylesheet($stylesheet, $order)
    {
        $links = $this->css;
        $is_merge = true;

        foreach($links as $link) {
            if($link[1] == $stylesheet) {
                $is_merge = false;
                break;
            }
        }

        if($is_merge)
            $this->css[] = array($order, $stylesheet);
    }

    function run()
    {
        global $config, $mari, $member;

        // 현재접속자 처리
        $tmp_sql = " select count(*) as cnt from {$mari['login_table']} where lo_ip = '{$_SERVER['REMOTE_ADDR']}' ";
        $tmp_row = sql_fetch($tmp_sql);

        if ($tmp_row['cnt']) {
            $tmp_sql = " update {$mari['login_table']} set m_id = '{$member['m_id']}', lo_datetime = '".MARI_TIME_YMDHIS."', lo_location = '{$mari['lo_location']}', lo_url = '{$mari['lo_url']}' where lo_ip = '{$_SERVER['REMOTE_ADDR']}' ";
            sql_query($tmp_sql, FALSE);
        } else {
            $tmp_sql = " insert into {$mari['login_table']} ( lo_ip, m_id, lo_datetime, lo_location, lo_url ) values ( '{$_SERVER['REMOTE_ADDR']}', '{$member['m_id']}', '".MARI_TIME_YMDHIS."', '{$mari['lo_location']}',  '{$mari['lo_url']}' ) ";
            sql_query($tmp_sql, FALSE);

            // 시간이 지난 접속은 삭제한다
            sql_query(" delete from {$mari['login_table']} where lo_datetime < '".date("Y-m-d H:i:s", MARI_SERVER_TIME - (60 * $config['c_login_minutes']))."' ");

            // 부담(overhead)이 있다면 테이블 최적화
            //$row = sql_fetch(" SHOW TABLE STATUS FROM `$mysql_db` LIKE '$mari['login_table']' ");
            //if ($row['Data_free'] > 0) sql_query(" OPTIMIZE TABLE $mari['login_table'] ");
        }

        $buffer = ob_get_contents();
        ob_end_clean();

        $stylesheet = '';
        $links = $this->css;

        if(!empty($links)) {
            foreach ($links as $key => $row) {
                $order[$key] = $row[0];
                $index[$key] = $key;
                $style[$key] = $row[1];
            }

            array_multisort($order, SORT_ASC, $index, SORT_ASC, $links);

            foreach($links as $link) {
                if(!trim($link[1]))
                    continue;

                $stylesheet .= PHP_EOL.$link[1];
            }
        }

        /*
        </title>
        <link rel="stylesheet" href="default.css">
        밑으로 스킨의 스타일시트가 위치하도록 하게 한다.
        */
        return preg_replace('#(</title>[^<]*<link[^>]+>)#', "$1$stylesheet", $buffer);
    }
}

// 휴대폰번호의 숫자만 취한 후 중간에 하이픈(-)을 넣는다.
function hyphen_hp_number($hp)
{
    $hp = preg_replace("/[^0-9]/", "", $hp);
    return preg_replace("/([0-9]{3})([0-9]{3,4})([0-9]{4})$/", "\\1-\\2-\\3", $hp);
}


// 로그인 후 이동할 URL
function login_url($url='')
{
    if (!$url) $url = MARI_HOME_URL;
    /*
    $p = parse_url($url);
    echo urlencode($_SERVER['REQUEST_URI']);
    return $url.urldecode(preg_replace("/^".urlencode($p['path'])."/", "", urlencode($_SERVER['REQUEST_URI'])));
    */
    return $url;
}


// $dir 을 포함하여 https 또는 http 주소를 반환한다.
function https_url($dir, $https=true)
{
    if ($https) {
        if (MARI_HTTPS_DOMAIN) {
            $url = MARI_HTTPS_DOMAIN.'/'.$dir;
        } else {
            $url = MARI_HOME_URL.'/'.$dir;
        }
    } else {
        if (MARI_DOMAIN) {
            $url = MARI_DOMAIN.'/'.$dir;
        } else {
            $url = MARI_HOME_URL.'/'.$dir;
        }
    }

    return $url;
}


// 게시판의 공지사항을 , 로 구분하여 업데이트 한다.
function board_notice($w_notice, $wr_id, $insert=false)
{
    $notice_array = explode(",", trim($w_notice));

    if($insert && in_array($wr_id, $notice_array))
        return $w_notice;

    $notice_array = array_merge(array($wr_id), $notice_array);
    $notice_array = array_unique($notice_array);
    foreach ($notice_array as $key=>$value) {
        if (!trim($value))
            unset($notice_array[$key]);
    }
    if (!$insert) {
        foreach ($notice_array as $key=>$value) {
            if ((int)$value == (int)$wr_id)
                unset($notice_array[$key]);
        }
    }
    return implode(",", $notice_array);
}


// goo.gl 짧은주소 만들기
function googl_short_url($longUrl)
{
    global $config;

    // Get API key from : http://code.google.com/apis/console/
    // URL Shortener API ON
    $apiKey = $config['c_googl_shorturl_apikey'];

    $postData = array('longUrl' => $longUrl, 'key' => $apiKey);
    $jsonData = json_encode($postData);

    $curlObj = curl_init();

    curl_setopt($curlObj, CURLOPT_URL, 'https://www.googleapis.com/urlshortener/v1/url');
    curl_setopt($curlObj, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curlObj, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curlObj, CURLOPT_HEADER, 0);
    curl_setopt($curlObj, CURLOPT_HTTPHEADER, array('Content-type:application/json'));
    curl_setopt($curlObj, CURLOPT_POST, 1);
    curl_setopt($curlObj, CURLOPT_POSTFIELDS, $jsonData);

    $response = curl_exec($curlObj);

    //change the response json string to object
    $json = json_decode($response);

    curl_close($curlObj);

    return $json->id;
}


// 임시 저장된 글 수
function autosave_count($m_id)
{
    global $mari;

    if ($m_id) {
        $row = sql_fetch(" select count(*) as cnt from {$mari['autosave_table']} where m_id = '$m_id' ");
        return (int)$row['cnt'];
    } else {
        return 0;
    }
}

// 본인확인내역 기록
function insert_cert_history($m_id, $company, $method)
{
    global $mari;

    $sql = " insert into {$mari['cert_history_table']}
                set m_id = '$m_id',
                    cr_company = '$company',
                    cr_method = '$method',
                    cr_ip = '{$_SERVER['REMOTE_ADDR']}',
                    cr_date = '".MARI_TIME_YMD."',
                    cr_time = '".MARI_TIME_HIS."' ";
    sql_query($sql);
}

// 인증시도회수 체크
function certify_count_check($m_id, $type)
{
    global $mari, $config;

    if($config['c_cert_use'] != 2)
        return;

    if($config['c_cert_limit'] == 0)
        return;

    $sql = " select count(*) as cnt from {$mari['cert_history_table']} ";

    if($m_id) {
        $sql .= " where m_id = '$m_id' ";
    } else {
        $sql .= " where cr_ip = '{$_SERVER['REMOTE_ADDR']}' ";
    }

    $sql .= " and cr_method = '".$type."' and cr_date = '".MARI_TIME_YMD."' ";

    $row = sql_fetch($sql);

    switch($type) {
        case 'hp':
            $cert = '휴대폰';
            break;
        case 'ipin':
            $cert = '아이핀';
            break;
        default:
            break;
    }

    if((int)$row['cnt'] >= (int)$config['c_cert_limit'])
        alert_close('오늘 '.$cert.' 본인확인을 '.$row['cnt'].'회 이용하셔서 더 이상 이용할 수 없습니다.');
}

// 1:1문의 설정로드
function get_qa_config($fld='*')
{
    global $mari;

    $sql = " select $fld from {$mari['qa_config_table']} ";
    $row = sql_fetch($sql);

    return $row;
}

// get_sock 함수 대체
if (!function_exists("get_sock")) {
    function get_sock($url)
    {
        // host 와 uri 를 분리
        //if (ereg("http://([a-zA-Z0-9_\-\.]+)([^<]*)", $url, $res))
        if (preg_match("/http:\/\/([a-zA-Z0-9_\-\.]+)([^<]*)/", $url, $res))
        {
            $host = $res[1];
            $get  = $res[2];
        }

        // 80번 포트로 소캣접속 시도
        $fp = fsockopen ($host, 80, $errno, $errstr, 30);
        if (!$fp)
        {
            die("$errstr ($errno)\n");
        }
        else
        {
            fputs($fp, "GET $get HTTP/1.0\r\n");
            fputs($fp, "Host: $host\r\n");
            fputs($fp, "\r\n");

            // header 와 content 를 분리한다.
            while (trim($buffer = fgets($fp,1024)) != "")
            {
                $header .= $buffer;
            }
            while (!feof($fp))
            {
                $buffer .= fgets($fp,1024);
            }
        }
        fclose($fp);

        // content 만 return 한다.
        return $buffer;
    }
}

// 인증, 결제 모듈 실행 체크
function module_exec_check($exe, $type)
{
    $error = '';
    $is_linux = false;
    if(strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN')
        $is_linux = true;

    // 모듈 파일 존재하는지 체크
    if(!is_file($exe)) {
        $error = $exe.' 파일이 존재하지 않습니다.';
    } else {
        // 실행권한 체크
        if(!is_executable($exe)) {
            if($is_linux)
                $error = $exe.'\n파일의 실행권한이 없습니다.\n\nchmod 755 '.basename($exe).' 과 같이 실행권한을 부여해 주십시오.';
            else
                $error = $exe.'\n파일의 실행권한이 없습니다.\n\n'.basename($exe).' 파일에 실행권한을 부여해 주십시오.';
        } else {
            // 바이너리 파일인지
            if($is_linux) {
                $search = false;
                $isbinary = true;
                $executable = true;

                switch($type) {
                    case 'ct_cli':
                        exec($exe.' -h 2>&1', $out, $return_var);

                        if($return_var == 139) {
                            $isbinary = false;
                            break;
                        }

                        for($i=0; $i<count($out); $i++) {
                            if(strpos($out[$i], 'KCP ENC') !== false) {
                                $search = true;
                                break;
                            }
                        }
                        break;
                    case 'pp_cli':
                        exec($exe.' -h 2>&1', $out, $return_var);

                        if($return_var == 139) {
                            $isbinary = false;
                            break;
                        }

                        for($i=0; $i<count($out); $i++) {
                            if(strpos($out[$i], 'PayPLUS CLIENT') !== false) {
                                $search = true;
                                break;
                            }
                        }
                        break;
                    case 'okname':
                        exec($exe.' D 2>&1', $out, $return_var);

                        if($return_var == 139) {
                            $isbinary = false;
                            break;
                        }

                        for($i=0; $i<count($out); $i++) {
                            if(strpos(strtolower($out[$i]), 'ret code') !== false) {
                                $search = true;
                                break;
                            }
                        }
                        break;
                }

                if(!$isbinary || !$search) {
                    $error = $exe.'\n파일을 바이너리 타입으로 다시 업로드하여 주십시오.';
                }
            }
        }
    }

    if($error) {
        $error = '<script>alert("'.$error.'");</script>';
    }

    return $error;
}

// 도로명주소 출력
// 주소출력
function print_address($addr1, $addr2, $addr3)
{
    $address = trim($addr1);
    $addr2 = trim($addr2);
    $addr3 = trim($addr3);

    if($addr2)
        $address .= ', '.$addr2;

    if($addr3)
        $address .= ' '.$addr3;

    return $address;
}

// input vars 체크
function check_input_vars()
{
    $max_input_vars = ini_get('max_input_vars');

    if($max_input_vars) {
        $post_vars = count($_POST, COUNT_RECURSIVE);
        $get_vars = count($_GET, COUNT_RECURSIVE);
        $cookie_vars = count($_COOKIE, COUNT_RECURSIVE);

        $input_vars = $post_vars + $get_vars + $cookie_vars;

        if($input_vars > $max_input_vars) {
            alert('폼에서 전송된 변수의 개수가 max_input_vars 값보다 큽니다.\\n전송된 값중 일부는 유실되어 DB에 기록될 수 있습니다.\\n\\n문제를 해결하기 위해서는 서버 php.ini의 max_input_vars 값을 변경하십시오.');
        }
    }
}

// HTML 특수문자 변환 htmlspecialchars
function htmlspecialchars2($str)
{
    $trans = array("\"" => "&#034;", "'" => "&#039;", "<"=>"&#060;", ">"=>"&#062;");
    $str = strtr($str, $trans);
    return $str;
}

// date 형식 변환
function conv_date_format($format, $date, $add='')
{
    if($add)
        $timestamp = strtotime($add, strtotime($date));
    else
        $timestamp = strtotime($date);

    return date($format, $timestamp);
}

// unescape nl 얻기
function conv_unescape_nl($str)
{
    $search = array('\\r', '\r', '\\n', '\n');
    $replace = array('', '', "\n", "\n");

    return str_replace($search, $replace, $str);
}


if ( ! function_exists('get_hp')) {
    function get_hp($hp, $hyphen=1)
    {
        global $mari;

        if (!is_hp($hp)) return '';

        if ($hyphen) $preg = "$1-$2-$3"; else $preg = "$1$2$3";

        $hp = str_replace('-', '', trim($hp));
        $hp = preg_replace("/^(01[016789])([0-9]{3,4})([0-9]{4})$/", $preg, $hp);

        return $hp;
    }
}
if ( ! function_exists('is_hp')) {
    function is_hp($hp)
    {
        $hp = str_replace('-', '', trim($hp));
        if (preg_match("/^(01[016789])([0-9]{3,4})([0-9]{4})$/", $hp))
            return true;
        else
            return false;
    }
}
?>