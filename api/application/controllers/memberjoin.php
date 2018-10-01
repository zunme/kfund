<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Memberjoin extends CI_Controller {
  function index() {
    session_start();
    if (!extension_loaded('IPINClient')) {
        dl('IPINClient.' . PHP_SHLIB_SUFFIX);
    }
    $module     = 'IPINClient';
    $sitecode   = "AD150";
    $sitepasswd = "1oTqvwP9oZZs";
    $authtype   = "";
    $popgubun   = "N";
    $customize  = "";
    $reqseq     = "REQ_0123456789";
    if (extension_loaded($module)) {
        $reqseq = get_cprequest_no($sitecode);
    } else {
        $reqseq = "Module get_request_no is not compiled into PHP";
    }
    $returnurl           = "https://fundingangel.co.kr:6003/api/index.php/memberjoin/retrunsuccess";
    $errorurl            = "https://fundingangel.co.kr:6003/api/index.php/memberjoin/retrunfalse";
    $_SESSION["REQ_SEQ"] = $reqseq;
    $plaindata           = "7:REQ_SEQ" . strlen($reqseq) . ":" . $reqseq . "8:SITECODE" . strlen($sitecode) . ":" . $sitecode . "9:AUTH_TYPE" . strlen($authtype) . ":" . $authtype . "7:RTN_URL" . strlen($returnurl) . ":" . $returnurl . "7:ERR_URL" . strlen($errorurl) . ":" . $errorurl . "11:POPUP_GUBUN" . strlen($popgubun) . ":" . $popgubun . "9:CUSTOMIZE" . strlen($customize) . ":" . $customize;
    $enc_data            = get_encode_data($sitecode, $sitepasswd, $plaindata);
    if ($enc_data == -1) {
        $returnMsg = "암/복호화 시스템 오류입니다.";
        $enc_data  = "";
    } else if ($enc_data == -2) {
        $returnMsg = "암호화 처리 오류입니다.";
        $enc_data  = "";
    } else if ($enc_data == -3) {
        $returnMsg = "암호화 데이터 오류 입니다.";
        $enc_data  = "";
    } else if ($enc_data == -9) {
        $returnMsg = "입력값 오류 입니다.";
        $enc_data  = "";
    }else {
      $this->load->view('memberjoin', array('enc_data'=>$enc_data));return;
    }
    return (bool) $this->gotojoin($returnMsg);
  }
  function retrunsuccess() {
    session_start();
    if(!isset($_SESSION["REQ_SEQ"])||$_SESSION["REQ_SEQ"]=='') {
      return (bool) $this->gotojoin();
    }
    if (!extension_loaded('IPINClient')) {
        dl('IPINClient.' . PHP_SHLIB_SUFFIX);
    }
    $sitecode   = "AD150";
    $sitepasswd = "1oTqvwP9oZZs";
    $enc_data   = $_POST["EncodeData"];
    $sReserved1 = $_POST['param_r1'];
    $sReserved2 = $_POST['param_r2'];
    $sReserved3 = $_POST['param_r3'];
    $plaindata = get_decode_data($sitecode, $sitepasswd, $enc_data);
    $ret = array('REQ_SEQ','RES_SEQ','AUTH_TYPE','NAME','BIRTHDATE','GENDER','NATIONALINFO','DI','UTF8_NAME');
    $data = array();
    foreach($ret as $val){
      $data[$val] = $this->GetValue($plaindata, $val);
    }
    $data['TYPE'] = 'CHECKPLUS';
    if($_SESSION["REQ_SEQ"] != $data['REQ_SEQ']){
      $this->gotojoin(); return;
    }
    $_SESSION['realnamecheck'] = $data;
    $url = "/pnpinvest/?mode=join3&agreement1=&agreement2=&m_blindness=Y";
    $this->load->view('alert', array('url'=>$url));
  }
  function retrunfalse() {
    session_start();
    unsset($_SESSION['realnamecheck']);
    return (bool) $this->gotojoin();
  }
  function test(){
    session_start();
    if(!isset($_SESSION["REQ_SEQ"])||$_SESSION["REQ_SEQ"]=='') {
      //임시블럭
      //return (bool) $this->gotojoin();
    }
    if (!extension_loaded('IPINClient')) {
        dl('IPINClient.' . PHP_SHLIB_SUFFIX);
    }
    $sitecode   = "AD150";
    $sitepasswd = "1oTqvwP9oZZs";
    $enc_data ="AgAFQUQxNTAfToCe1SpCfwuo6r/xcHrR3J5KM+4pwuMwaskeieHqUjQSkiPFjpFp1662Fsey8BBRHn1k2W58RHaB5f4Yh/7DzI1jv48aHM280mx7j2vb6cATiVGy0DsmxEjvhrQnjyWQ96iuc6Y2+T96+CK7s5NxxFiALtO3aM/meg7rcA3S7+Fk7eCpOpohsWwxvMzglZABehIFUtasxZJAIPaUoqKmCwpxR2rIbYYqKc+vYuMx7j7xnBteSDWEmqvc2dg752WVddnNltHWKiwNLutYk+3U5nv/cNi0vBN9zoRUa25CT0CHJnn8PPKaZYFl5uprkfzIdABQsyGIqEeNbqKv7L6bdFAthV1egvM1zgteB0YcM6aWH3XCEabXec7vL1oIcIkV5xhEKbzl7itFa6fg6BnXNNPe9+H3EyMZ/sfsiloJMGr0d1TuTyPvW7zNy1/InbBX/d18W5j0iFBQsviyrxM6IZWkk3ekVtpJr/rfDgKCqFoVKnuGGs+Y4KyFg4q+F1BT3kFfgtr/Rdg8HgmZyHVzMdAQgvULzfyWgMnIw+FGXg==" ;
    /*
    $cb_encode_path ="/var/www/html/CPClient";
    $plaindata = `$cb_encode_path DEC $sitecode $sitepasswd $enc_data`;
    echo "$cb_encode_path DEC $sitecode $sitepasswd $enc_data";
    var_dump($plaindata);
    return;
    */
    $plaindata = get_decode_data($sitecode, $sitepasswd, $enc_data);
    //  $ret = array('REQ_SEQ','RES_SEQ','AUTH_TYPE','NAME','BIRTHDATE','GENDER','NATIONALINFO','DI','UTF8_NAME','CI','MOBILE_NO');
    $ret = array('REQ_SEQ','RES_SEQ','AUTH_TYPE','NAME','BIRTHDATE','GENDER','NATIONALINFO','DI','UTF8_NAME');
    $data = array();
    foreach($ret as $val){
      $data[$val] = $this->GetValue($plaindata, $val);
    }
    $data['TYPE'] = 'CHECKPLUS';
    /* 임시 blcok
    if(!isset($_SESSION["REQ_SEQ"])||$_SESSION["REQ_SEQ"]=='' || $_SESSION["REQ_SEQ"] != $data['REQ_SEQ']){
             echo( '<script>alert("인증 과정중 오류가 발생하였습니다.")</script>'); return;
    }
    */
    $_SESSION['realnamecheck'] = $data;
  //  $url = "/pnpinvest/?mode=join3&agreement1=&agreement2=&m_blindness=Y";
  //  $this->load->view('alert', array('url'=>$url));
  var_dump($data);
  }
  private function gotojoin($msg='인증 과정중 오류가 발생하였습니다.', $url='/pnpinvest/?mode=join1'){
    $this->load->view('alert', array('msg'=>$msg,'url'=>$url));
  }
  private function GetValue($str , $name){
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
}
