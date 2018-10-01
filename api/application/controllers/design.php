<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Design extends Adm {

  public function _remap($method) {
    $this->{$method}();
  }

	public function index()
	{
		;
	}

  public function main() {
      $this->load->view('cfg_maindesign.php', array("data"=> $this->db->get_where('z_main_design', array('idx'=> 1) )->row_array() ));
  }
  public function safetyimage() {
    $config['upload_path'] = "../pnpinvest/data/safetyplan";
    if (!is_dir($config['upload_path'])) {
        mkdir($config['upload_path'], 0777, TRUE);
    }
    $config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
    $config['remove_spaces'] = TRUE;
    $config['encrypt_name'] = TRUE;

    $this->load->library('upload', $config);
    $files = array();
    if ( ! $this->upload->do_upload())
    {
      $data =  $this->upload->data() ;
      $data['error'] = $this->upload->display_errors('','');
      $data['file_name']=$_FILES['userfile']['name'];
      $files['files'][] =$data;
    }
    else
    {
      $data =  $this->upload->data() ;
      date_default_timezone_set('Asia/Seoul');
      $this->db->where('idx', '1')->update('safety_plan', array('img'=>$data['file_name']));
      $data['last']= $this->db->last_query();
      $data['error']='';
      //$data['fileid'] = $this->db->insert_id();
      $files['files'][] = $data;
    }
      echo json_encode($files);return;

  }

}
