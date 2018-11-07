<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class main extends CI_Controller {
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    $this->session = $_SESSION;
    $this->member_ck = ( isset($this->session['ss_m_id']) &&  $this->session['ss_m_id'] !='' ) ? true: false;
    session_write_close();
    $this->isajax = $this->input->is_ajax_request();
    if( !$this->isajax )     $this->load->view('header');
    $this->{$method}();
    $this->load->view('footer');
  }
  function index() {
    ;
  }
  function login() {
    $this->load->view('login');
  }
  protected function json( $data = '' ){
    header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
    echo json_encode( $data );
    exit;
  }
}
