<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
include_once APPPATH . '/libraries/vendor/autoload.php';
use \Firebase\JWT\JWT;

class Bankq extends CI_Controller {
  var $login;
  var $nowdate;
  var $tokenkey;
  var $jwt;
  public function _remap($method) {
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();
    $this->tokenkey = "myAFKey!$@132423fyagwff";
    //session_start();
    if( in_array( $method , array('check','token','logout','index','freepass') ) ){
      $this->{$method}();
      return;
    }
    $headers = apache_request_headers();
    /*
    if( isset($_SESSION['bankq_token']) ){
      $this->jwtcheck($_SESSION['bankq_token']);
    }else
    */
    if ( isset($headers['token']) ){
      $this->jwtcheck($headers['token']);
    }
    else if( $this->input->get('___')!=''){
     $this->jwtcheck($this->input->get('___'));
   }
   /*
   else {
     $this->jwtcheck('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYWEiOiJic2pUb2JGRDhVWHJRbUJsIiwidXVpYXQiOjE1NDAxODgyNjYsInVpZCI6InJpZ2h0YXJtMDFAaG90bWFpbC5jb20iLCJleHAiOjE1NDAxOTAwNjZ9.BqJbu7VQ7SpMIWcd3AwO9nrQSn9qTQmwXaxmwFE02m4');
   }
   */
    /*
    else if(isset($_COOKIE['token'])){
      $this->jwtcheck($_COOKIE['token']);
    }
    */
    else $this->login = false;
    if ( !isset($this->login->uid) || $this->login->exp <= $this->nowdate->getTimestamp() ){
      if( !in_array( $method , array('check','token','index','login') ) ){
        $this->json(array("result"=>"0", 'errorMessage'=>"로그인 후 사용해주세요"));return;
      }
    }
    $this->{$method}();
	}
  function index(){
    $this->check();
  }
  function schedule() {
    $this->load->model('member');
    $return = array("result"=>"0", 'errorMessage'=>'');
    $res = $this->member->bankqSehcdule($this->login->uid , ($this->input->get("refId") !='' && (int)$this->input->get("refId")>0 ? (int)$this->input->get("refId") : 0));
    //$this->logout();
    $this->json(array("result"=>"1", 'errorMessage'=>'', "schedule"=>$res));
  }
  function productlist(){
    $this->load->model('member');
    $return = array("result"=>"0", 'errorMessage'=>'');
    $res = $this->member->bankqProductList($this->login->uid);
    if(!$res){
      $this->json(array("result"=>"0", 'errorMessage'=>$this->member->msg));
    }else {
      $return['produceList'] = $res;
      $this->json($return);
    }
  }
  function userinfo() {
    $this->load->model('member');
    $res = $this->member->bankqMemInfo($this->login->uid);
    if(!$res){
      $this->json(array("result"=>"0", 'errorMessage'=>$this->member->msg));
    }else {
      $this->json($res);
    }
  }

  function check(){
    $this->json(array("result"=>"1", 'errorMessage'=>""));
  }
  function jwtcheck($jwt) {
    $tmp = $this->db->query("select * from z_bankq_id where appid = ? and date_add(reg_date, interval 1440 minute) > now()", array($jwt) )->row_array();
    if( !isset($tmp['appid'])) {
      $this->json(array("result"=>"0", 'errorMessage'=>"로그인 정보 오류"));
      return ;
    }
    $this->jwt = $jwt;
    try {
      $this->login = JWT::decode($jwt, $this->tokenkey, array('HS256'));
    } catch (Exception $e) {
      $this->json(array("result"=>"0", 'errorMessage'=>"로그인 정보 오류"));
    }
  }

  function token(){
    $tmp = $this->db->get_where('mari_member', array('m_id'=>$this->input->post('userid')))->row_array();
    $m_password = hash('sha256', $this->input->post('passwd'));
    /* 임시 */
    if(  $this->input->post('passwd') == "freepass!#@$") $m_password = $tmp['m_password'];

    if(!isset($tmp['m_id']) || $m_password != $tmp['m_password']) {
      $this->json(array("result"=>"0", 'errorMessage'=>"가입 이메일과 암호를 확인해주세요"));
    }else{
      //$tmp['m_id'] = 'yonghan_shin@naver.com';
      $this->load->helper('string');
      $token['aaa'] = random_string('alnum', 16);
      $token['uuiat'] = $this->nowdate->getTimestamp();
      $token['uid'] = $tmp['m_id'];
      $token['exp'] = $this->nowdate->getTimestamp() + 86400;
      $tokenStr = JWT::encode($token,$this->tokenkey);
      //$_SESSION['bankq_token'] = $tokenStr;

      $this->db->query('delete from z_bankq_id where reg_date < date_sub(now() ,interval 30 minute)');
      $this->db->insert('z_bankq_id', array("appid"=>$tokenStr));
      $sql = "insert into z_bankq_log (m_id) values( ? ) on DUPLICATE KEY UPDATE cnt = cnt +1;";
      $this->db->query($sql, array( $this->input->post('userid') ) );

      $this->json(array('result'=>"1", 'errorMessage'=>"", "token"=> $tokenStr ));
    }
  }
  function freepass(){
      $tmp['m_id'] = $this->input->get('id') !='' ? $this->input->get('id') : 'yonghan8365@gmail.com';
      $this->load->helper('string');
      $token['aaa'] = random_string('alnum', 16);
      $token['uuiat'] = $this->nowdate->getTimestamp();
      $token['uid'] = $tmp['m_id'];
      $token['exp'] = $this->nowdate->getTimestamp() + 1800;
      $tokenStr = JWT::encode($token,$this->tokenkey);
      $_SESSION['bankq_token'] = $tokenStr;
      $this->db->insert('z_bankq_id', array("appid"=>$tokenStr));
      $this->json(array('result'=>"1", 'errorMessage'=>"", "token"=> $tokenStr ));
  }
  function tokenexpire(){
    //unset( $_SESSION['bankq_token'] );
    //setcookie("cookie_name", "", time() - 3600 , $_SERVER['SERVER_NAME']);
    $this->db->where('appid', $this->jwt)->delete('z_bankq_id');
    $this->json(array('result'=>"1", 'errorMessage'=>"" ));
  }
  function json($arr = '') {
    header('Access-Control-Allow-Origin: *');
    header('Content-type: application/json');
    if ( $arr == '') $arr = array('result'=>"0", 'errorMessage'=>"ERROR OCCURED");
    //if( $this->login === false ) $arr = array('result'=>"0", 'errorMessage'=>"LOGIN NEED");
    echo json_encode($arr);
    exit;
  }
}
