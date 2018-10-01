<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Crol extends CI_Controller {
  function index() {
    if( $this->input->get('idx')){
      $this->db->where('idx >= ', $this->input->get('idx') )  ;
    }
    if( $this->input->get('cate')){
      $this->db->where('cate', $this->input->get('cate') )  ;
    }
    $list = $this->db->get('z_temp_company')->result_array();
    $this->load->view("crol", array("list"=>$list));
  }
  function addrlist(){
    if ( ! session_id() ) @ session_start();
    if(!isset($_SESSION['crol_user']) || $_SESSION['crol_user']==''){
      $this->load->view("crol_user");
      return;
    }
    $user = $_SESSION['crol_user'];
    session_write_close();

    if( $this->input->get('startdate') !='' ) {
      $this->db->where('regdate >=' , $this->input->get('startdate')." 00:00:00");
    }else {
      $this->db->where('regdate >=' , date("Y-m-d")." 00:00:00" );
    }
    if( $this->input->get('enddate') !='' ) {
      $this->db->where('regdate <=' , $this->input->get('enddate')." 23:59:59");
    }else {
      $this->db->where('regdate <=' , date("Y-m-d")." 23:59:59" );
    }
    if( $this->input->get("mylist") != 'off'){
      $this->db->where('user' , $user );
    }
    $list = $this->db->get('z_temp_company')->result_array();
    $this->load->view('crol_addrlist', array("list"=>$list));
  }
  function croling() {
    $data = array();
    if ( ! session_id() ) @ session_start();
    $data['user'] = $_SESSION['crol_user'];
    session_write_close();
    foreach($_POST as $idx=>$val){
      if ($idx != 'callback' && $idx != '_') $data[$idx] = $val;
    }
    preg_match_all('/^\([0-9]{5,6}\)*/', $data['addr'], $match);
    if(isset($match[0][0]) && $match[0][0] != '' ){
      $data['addr'] = trim(str_replace($match[0][0] , '', $data['addr']));
      $data['postnum'] = preg_replace("/[^0-9]*/s", "", $match[0][0]);
    }
    $cnt = $this->db->query( 'select count(1) as cnt from z_temp_company where cname= ?', array( $data['cname']) )->row_array();
    if( isset($cnt['cnt']) &&  $cnt['cnt']> 0 ){
      echo "이미 저장되어있는 회사입니다.";exit;
    }
    $qry = $this->db->insert('z_temp_company', $data);
    $rows = $this->db->affected_rows();
    $last = $this->db->insert_id();
    $code = $rows > 0 ? 200 : 500;
echo $code;exit;
    $this->json(array("code"=> $code ));
  }
  function userreg() {
    if ( ! session_id() ) @ session_start();
    $_SESSION['crol_user']=trim($this->input->post('crol_user'));
    $this->json(array("code"=> 200 ));
  }
  function postnum() {
    if ( ! session_id() ) @ session_start();
    if(!isset($_SESSION['crol_user']) || $_SESSION['crol_user']==''){
      $this->load->view("crol_user");
      return;
    }
    $this->load->view('crol_addpost');
  }
  private function json( $data = '' ){
    //header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
    echo json_encode( $data );
  }
}
