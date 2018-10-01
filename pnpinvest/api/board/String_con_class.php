<?php

class String_Con
{
// class - Start

	// 알파벳 구분
	function is_alpha($char){
		$char=ord($char);

		if($char>=0x61 && $char<=0x7a){
			return 1; # 소문자를 의미
		}

		if($char>=0x41 && $char<=0x5a){
			return 2; # 대문자를 의미
		}
	}


	// 한글 구분
	function is_hangul($char){
		# 특정 문자가 한글의 범위내(0xA1A1 - 0xFEFE)에 있는지 검사
		$char=ord($char);

		if($char>=0xa1 && $char<=0xfe){
			return 1;
		}
	}


	// 문자열 자르기
	function cut_string($string, $length){
		if(strlen($string)<=$length&&!eregi("^[a-z]+$", $string)){
			return $string;
		}

		for($i=$length; $i>=1; $i--) {
			# 끝에서부터 한글 byte수를 센다.
			if($this->is_hangul($string[$i-1])){
				$hangul++;
			}else{
				break;
			}
		}

		if($hangul){
			# byte수가 홀수이면, 한글의 첫번째 바이트이다.
			# 한글의 첫번째 바이트일 때 깨지는 것을 막기 위해 지정된 길이를 한
			# 바이트 줄임
			if($hangul%2){
				$length--;
			}
			$string=chop(substr($string,0,$length));
		}else{ # 문자열의 끝이 한글이 아닐 경우
			for($i=1; $i<=$length; $i++){
				# 대문자의 갯수를 기록
				if($this->is_alpha($string[$i-1])==2){
					$alpha++;
				}
				# 마지막 한글이 나타난 위치 기록
				if($this->is_hangul($string[$i-1])){
					$last_han=$i;
				}
			}
				# 지정된 길이로 문자열을 자르고 문자열 끝의 공백 문자를 삭제함
				# 대문자의 길이는 1.3으로 계산한다. 문자열 마지막의 영문 문자열이
				# 빼야할 전체 길이보다 크면 초과된 만큼 뺀다.
			$capitals=intval($alpha*0.5);
			if(($length-$last_han)<=$capitals){
				$capitals=0;
			}
			$string=chop(substr($string,0,$length-$capitals));
		}
		$string=$string."..";
		return $string;
	}


	// HTML Tag 삭제 함수
	function delete_tag($text){
		$src=array("/\n/i","/<html.*<body[^>]*>/i","/<\/body.*<\/html>.*/i",
					"/<\/*(div|span|layer|body|html|head|meta|input|select|option|form)[^>]*>/i",
					"/<(style|script|title).*<\/(style|script|title)>/i",
					"/<\/*(script|style|title|xmp)>/i","/<(\\?|%)/i","/(\\?|%)>/i",
					"/#\^--ENTER--\^#/i");
		$tar=array("#^--ENTER--^#","","","","","","&lt;\\1","\\1&gt;","\n");
		$text=chop(preg_replace($src,$tar,$text));
		return $text;
	}

  // 링크 ,아이프레임, map 등 삭제
  function delete_link($text){
   $text = preg_replace('/<IFRAME(.*?)>(.*?)<\\/IFRAME>/i', '$2', $text);
   $text = preg_replace('/<(.*?)href=(.*?)>/i', '', $text);
   $text = str_replace("</a>",'', $text);
   $text = str_replace("</A>",'', $text);
   return $text;
 }

	// 문자열 정리 함수
	function clear_text($text){
	 $text=eregi_replace("(#|'|\\\\)", "\\\\1", $text);
		$text=eregi_replace("(\r*)\n", "<BR>", $text);
		$text=eregi_replace("\"", "&quot;", $text);
		$text=eregi_replace("\'", "&#039;" , $text);
		$text=eregi_replace(" ", "&nbsp;", $text);
		return $text;
	}


	// html사용을 안할 경우 IE에서 한글 문법에 맞지 않는 글자 표현시 깨지는 것을 수정
	function ugly_han($text,$html=0){
		if(!$html){	$text=preg_replace("/&amp;(#|amp)/i","&\\1",$text);	}
		$text=str_replace("&amp;","&",$text);
		return $text;
	}

 function url_decoder($text){
   $text = urldecode($text);
   return $text;
 }

	// 갈메기 기호 변환
	function change_gal($text){
		$text=str_replace("<table>","&lt;table&gt;",$text);
		$text=str_replace("</table>","&lt;/table&gt;",$text);
		$text=str_replace("<td>","&lt;td&gt;",$text);
		$text=str_replace("</td>","&lt;/td&gt;",$text);
		$text=str_replace("<tr>","&lt;tr&gt;",$text);
		$text=str_replace("</tr>","&lt;/tr&gt;",$text);
		return $text;
	}

	// 날짜 출력 형식
	function ext_date($time,$type){

		$year	=	substr($time,0,4);
		$syear	=	substr($time,2,2);
		$month	=	substr($time,5,2);
		$day		=	substr($time,8,2);
		$hour	=	substr($time,11,2);
		$min		=	substr($time,14,2);
		$sec		=	substr($time,17,2);

		switch($type){
		case "all" :
			$date=$year."-".$month."-".$day." ".$hour.":".$min.":".$sec;
			return $date;
			break;
		case "ymdm" :
			$date=$year."-".$month."-".$day;
			return $date;
			break;
		case "ymds" :
			$date=$year."/".$month."/".$day;
			return $date;
			break;
		case "kymd" :
			$date=$year."년".$month."월".$day."일";
			return $date;
			break;
		case "mds" :
			$date=$month."/".$day;
			return $date;
			break;
		case "mdm" :
			$date=$month."-".$day;
			return $date;
			break;
		case "mdsh" :
			$date=$month."/".$day." ".$hour.":".$min.":".$sec;
			return $date;
			break;
		case "ymdhi" :
			$date=$year."-".$month."-".$day." ".$hour.":".$min;
			return $date;
			break;
  case "ymdms" :
			$date=$syear.".".$month.".".$day;
			return $date;
		break;
		default  :
			return "error! 옵션을 잘 선택해주세요.";
			break;
		}
	}

//-----------------------------------------
//   테이블 깨짐 방지
//-----------------------------------------
function Guard_table($text,$section,$Img_widmax){

  $text = str_replace("<br />","",$text);
  $text = $this->change_gal($text);

  // 이미지 테그 추가 필터
  if($section=="img"){
    return urlencode( preg_replace("/<img /","<img style=\"cursor:hand\" onload=\"resizeImgWidth(this,$Img_widmax);\" onclick=\"poporigin(this);\" " , trim($text) ) );
  }
  // 일반 필터
  else{
    return urlencode($text);
  }

// function - End
}


// class - End
}

?>