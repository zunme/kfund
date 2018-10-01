<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
date_default_timezone_set('Asia/Seoul');

class  Admmember extends Adm {
  var $msg;
  var $today;

  public function _remap($method) {
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->{$method}();
  }
  function index(){}

  function memberdoc() {
    $mid = $this->input->get('mid');
    $meminfo = $this->db->get_where('mari_member', array('m_id'=> $mid) )->row_array();
    $this->load->view('admmember_doc.php', array("info"=>$meminfo));
  }
  function officefile() {
    $field = $this->input->post('ind');
    if ( !in_array($field, array('m_declaration_01','m_declaration_02','m_bill','m_evidence') ) ){
      $files[] = array("error"=>"서류구분".$field."에 오류가 발생하였습니다.");
      $this->json(array("files"=>$files) );
    }
    $mid = $this->input->post('mid');
    $meminfo = $this->db->get_where('mari_member', array('m_id'=> $mid) )->row_array();
    if(!isset($meminfo['m_id']) ){
      $files[] = array("error"=>"아이디를 찾을 수 없습니다.");
      $this->json(array("files"=>$files) );
    }
    //Your upload directory, see CI user guide
    $config['upload_path'] = '../pnpinvest/data/file/member/';

    $config['allowed_types'] = 'gif|jpg|png|JPG|GIF|PNG|pdf|PDF|jpeg|JPEG';
    $config['max_size'] = '1000';
    //$config['file_name'] = $name;
    $config['encrypt_name'] = true;

    //Load the upload library
    $this->load->library('upload', $config);

    if ($this->upload->do_upload())
    {
      $data =  $this->upload->data();
      if( $meminfo[$field] !=''){
        unlink('../pnpinvest/data/file/member/'.$meminfo[$field]);
      }
      $this->db->where('m_id',$meminfo['m_id'] )->update('mari_member', array($field=>$data['file_name']) );
      $files[] = array("error"=>"", "name"=>$data['file_name']);
      echo $this->json(array("files"=>$files));
    }else {
      $files[] = array("error"=>$this->upload->display_errors());
      echo $this->json(array("files"=>$files));
    }
  }
  function trashfile() {
    $field = $this->input->post('ind');
    if ( !in_array($field, array('m_declaration_01','m_declaration_02','m_bill','m_evidence') ) ){
      $this->json( array("code"=>500,"error"=>"서류구분".$field."에 오류가 발생하였습니다.") );
    }
    $mid = $this->input->post('mid');
    $meminfo = $this->db->get_where('mari_member', array('m_id'=> $mid) )->row_array();
    if(!isset($meminfo['m_id']) ){
      $this->json(array("code"=>500,"error"=>"아이디를 찾을 수 없습니다.") );
    }
    if( $meminfo[$field] !=''){
      unlink('../pnpinvest/data/file/member/'.$this->user['info'][$field]);
    }
    $this->db->where('m_id',$meminfo['m_id'] )->update('mari_member', array($field => '') );
    $this->json(array("code"=>200, "msg"=>"삭제하였습니다.") );
  }

  protected function json( $data = '' ){
    header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
    echo json_encode( $data );
    exit;
  }
}
