<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Admext extends CI_Controller {

	public function _remap($method) {
		if ( ! session_id() ) @ session_start();
		if( !isset($_SESSION['ss_m_id'] ) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"로그인후 사용해주세요") );
		}
		$query = $this->db->query('SELECT * FROM mari_authority where m_id = ? ', array($_SESSION['ss_m_id']) );
		if ( $query->num_rows() < 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
	public function index()
	{
		;
	}
	public function delimg() {
		$idx = $this->input->post('loan_id');
		if( (int)$idx < 1 ){
		$this->json(array('code'=>500, 'msg'=>'IDX ERROR'.$idx));
		}
		$extinfo = $this->db->query("select * from mari_loan_ext where fk_mari_loan_id= ? ", array($idx) )->row_array();

		if( $this->input->post('imgtype')=='reward') {
			if($extinfo['reward'] !='') unlink("../pnpinvest/data/file/".$idx."/".$extinfo['reward']);
			$this->db->set('reward', '');
		}
		else if ( $this->input->post('imgtype')=='event') {
			if($extinfo['eventfile'] !='') unlink("../pnpinvest/data/file/".$idx."/".$extinfo['eventfile']);
			$this->db->set('eventfile', '');
		}
		else {
			$this->json(array('code'=>500, 'msg'=>'image type ERROR'));
		}
		$this->db->where('fk_mari_loan_id', $idx)->update('mari_loan_ext');

		$this->json(array('code'=>200, 'msg'=>'OK'));
	}
	public function loanappliction() {

		$total = $this->db->count_all("z_loan_application");

		/*
		$config = array();
		$config["base_url"] = "/api/admext/loanappliction";
		$config["total_rows"] = $total;
		$config["per_page"] = 1;
		$config["uri_segment"] = 3;
		$this->load->library('pagination');
		$this->pagination->initialize($config);
		$page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;
*/
		$data = array();
	//	$this->db->limit($config["per_page"], $page);
		$this->db->order_by('loan_apc_idx desc');
		$data['list'] = $this->db->get("z_loan_application")->result_array();
		//$data["links"] = $this->pagination->create_links();

		$this->load->view("adm_loanappliction", $data);
	}
	public function loanapplicationdel() {
		$idx = $this->input->post('idx');
		if( (int)$idx < 1 ){
		$this->json(array('code'=>500, 'msg'=>'IDX ERROR'.$idx));
		}
		$this->db->query('delete from z_loan_application where loan_apc_idx = ?' , array($idx));
		$this->json(array('code'=>200, 'msg'=>'OK'));
	}
	public function maintxt() {
		$loanid = (int) ($this->input->post('loanid'));
		if($loanid < 1){
      $ret['code'] = "ERROR";
      $ret['msg'] = "LOAN ID ERROR";
      echo json_encode($ret);return;
    }
		 $this->load->helper('security');
		 $data = array(
			'i_mainimg_txt1'=>xss_clean($this->input->post('i_mainimg_txt1'))
			,'i_mainimg_txt2'=>xss_clean($this->input->post('i_mainimg_txt2'))
			,'i_mainimg_txt3'=>xss_clean($this->input->post('i_mainimg_txt3'))
			,'i_mainimg_txt4'=>xss_clean($this->input->post('i_mainimg_txt4'))
			,'i_mainimg_txt5'=>xss_clean($this->input->post('i_mainimg_txt5'))
			,'i_mainimg_txt6'=>xss_clean($this->input->post('i_mainimg_txt6'))
		);
		if( !get_magic_quotes_gpc() ){
			foreach ($data as $idx=>$datarow){
				$data[$idx] = addslashes ($datarow);
			}
		}
		$row = $this->db->get_where('mari_invest_progress', array('loan_id'=>$loanid))->row_array();
    if(isset($row['loan_id']) ){
      $res = $this->db->where('loan_id',$loanid)->update ('mari_invest_progress', $data );
    }else {
      $data['loan_id'] = $loanid;
      $res = $this->db->insert ('mari_invest_progress',$data ) ;
    }
		if($res) echo json_encode(array('code'=>'OK'));
		else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
	}



  public function eventfileupload()
	{
    $loanid = (int) ($this->input->post('loanid'));
    if($loanid < 1){
      $data['error'] = "LOAN ID ERROR";
      $data['file_name']=$_FILES['userfile']['name'];
      $files['files'][] =$data;
      echo json_encode($files);return;
    }

    $config['upload_path'] = "../pnpinvest/data/file/".$loanid."/";

    if (!is_dir($config['upload_path'])) {
        mkdir($config['upload_path'], 0777, TRUE);
    }

    $config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
    $config['remove_spaces'] = TRUE;
//    $config['overwrite'] = TRUE;
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
      $extinfo = $this->db->query("select * from mari_loan_ext where fk_mari_loan_id= ? ", array($loanid) )->row_array();
      if( isset($extinfo['fk_mari_loan_id'])){
        $this->db->set('eventfile', $data['file_name'])->where ('fk_mari_loan_id',$loanid)->update('mari_loan_ext');
      }else {
        $this->db->insert('mari_loan_ext', array('fk_mari_loan_id'=>$loanid, 'eventfile'=>$data['file_name'] ) );
      }
      $data['error']='';
      $files['files'][] = $data;
    }
      echo json_encode($files);
      unlink("../pnpinvest/data/file/".$loanid."/".$extinfo['eventfile']);
      return;
      $path = "../pnpinvest/data/file/".$loanid."/".$filename;
      var_dump(move_uploaded_file($_FILES['userfile']['tmp_name'], $path));
     //$filename = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "",  str_ireplace(" ", "", $filename) );
	}

	public function rewardupload()
	{
		$loanid = (int) ($this->input->post('loanid'));
		if($loanid < 1){
			$data['error'] = "LOAN ID ERROR";
			$data['file_name']=$_FILES['userfile']['name'];
			$files['files'][] =$data;
			echo json_encode($files);return;
		}

		$config['upload_path'] = "../pnpinvest/data/file/".$loanid."/";

		if (!is_dir($config['upload_path'])) {
				mkdir($config['upload_path'], 0777, TRUE);
		}

		$config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
		$config['remove_spaces'] = TRUE;
//    $config['overwrite'] = TRUE;
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
			$extinfo = $this->db->query("select * from mari_loan_ext where fk_mari_loan_id= ? ", array($loanid) )->row_array();
			if( isset($extinfo['fk_mari_loan_id'])){
				$this->db->set('reward', $data['file_name'])->where ('fk_mari_loan_id',$loanid)->update('mari_loan_ext');
			}else {
				$this->db->insert('mari_loan_ext', array('fk_mari_loan_id'=>$loanid, 'reward'=>$data['file_name'] ) );
			}
			$data['error']='';
			$files['files'][] = $data;
		}
			echo json_encode($files);
			unlink("../pnpinvest/data/file/".$loanid."/".$extinfo['reward']);
			return;
			$path = "../pnpinvest/data/file/".$loanid."/".$filename;
			var_dump(move_uploaded_file($_FILES['userfile']['tmp_name'], $path));
		 //$filename = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "",  str_ireplace(" ", "", $filename) );
	}

  function form1() {
    $loanid = (int) ($this->input->post('loanid'));
    if($loanid < 1){
      $ret['code'] = "ERROR";
      $ret['msg'] = "LOAN ID ERROR";
      echo json_encode($ret);return;
    }
    $this->load->helper('security');
    $data = array(
      'gaeyo'=>xss_clean($this->input->post('gaeyo'))
      ,'sanghwang'=>xss_clean($this->input->post('sanghwang'))
      ,'dambo'=>xss_clean($this->input->post('dambo'))
      ,'boho'=>xss_clean($this->input->post('boho'))
    );
    if( !get_magic_quotes_gpc() ){
      foreach ($data as $idx=>$datarow){
        $data[$idx] = addslashes ($datarow);
      }
    }

    $row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
    if(isset($row['fk_mari_loan_id']) ){
      $res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
    }else {
      $data['fk_mari_loan_id'] = $loanid;
      $res = $this->db->insert ('mari_loan_ext',$data ) ;
    }
    if($res) echo json_encode(array('code'=>'OK'));
    else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
  }
	function eventetc() {
    $loanid = (int) ($this->input->post('loanid'));
    if($loanid < 1){
      $ret['code'] = "ERROR";
      $ret['msg'] = "LOAN ID ERROR";
      echo json_encode($files);return;
    }
    $this->load->helper('security');
    $data = array(
      'eventetc'=>xss_clean($this->input->post('eventetc'))
    );
    if( !get_magic_quotes_gpc() ){
      foreach ($data as $idx=>$datarow){
        $data[$idx] = addslashes ($datarow);
      }
    }

    $row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
    if(isset($row['fk_mari_loan_id']) ){
      $res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
    }else {
      $data['fk_mari_loan_id'] = $loanid;
      $res = $this->db->insert ('mari_loan_ext',$data ) ;
    }
    if($res) echo json_encode(array('code'=>'OK'));
    else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
  }

  function desc() {
    $loanid = (int) ($this->input->post('loanid'));
    if($loanid < 1){
      $ret['code'] = "ERROR";
      $ret['msg'] = "LOAN ID ERROR";
      echo json_encode($files);return;
    }
    $this->load->helper('security');
    $data = array(
      'descript'=>xss_clean($this->input->post('descript'))
    );
    if( !get_magic_quotes_gpc() ){
      foreach ($data as $idx=>$datarow){
        $data[$idx] = addslashes ($datarow);
      }
    }

    $row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
    if(isset($row['fk_mari_loan_id']) ){
      $res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
    }else {
      $data['fk_mari_loan_id'] = $loanid;
      $res = $this->db->insert ('mari_loan_ext',$data ) ;
    }
    if($res) echo json_encode(array('code'=>'OK'));
    else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
  }
	function gallerydesc() {
		$loanid = (int) ($this->input->post('loanid'));
		if($loanid < 1){
			$ret['code'] = "ERROR";
			$ret['msg'] = "LOAN ID ERROR";
			echo json_encode($files);return;
		}
		$this->load->helper('security');

		if( !get_magic_quotes_gpc() ){
			$data = array(
				'gallerydesc'=>addslashes($this->input->post('gallerydesc'))
			);
		}

		$row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
		if(isset($row['fk_mari_loan_id']) ){
			$res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
		}else {
			$data['fk_mari_loan_id'] = $loanid;
			$res = $this->db->insert ('mari_loan_ext',$data ) ;
		}
		if($res) echo json_encode(array('code'=>'OK'));
		else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
	}
	function extdescsave(){
		$loanid = (int) ($this->input->post('loanid'));
		$desctype = $this->input->post('desctype');

		if($loanid < 1){
			$ret['code'] = "ERROR";
			$ret['msg'] = "LOAN ID ERROR";
			echo json_encode($files);return;
		}
		$this->load->helper('security');

		/*if( !get_magic_quotes_gpc() ){
			$data = array(
				$desctype => addslashes($this->input->post('desc'))
			);
		}else */
		$data = array($desctype => $this->input->post('desc'));

		$row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
		if(isset($row['fk_mari_loan_id']) ){
			$res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
		}else {
			$data['fk_mari_loan_id'] = $loanid;
			$res = $this->db->insert ('mari_loan_ext',$data ) ;
		}
		if($res) echo json_encode(array('code'=>'OK'));
		else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
	}
  function jinhaeng() {
    $loanid = (int) ($this->input->post('loanid'));
    if($loanid < 1){
      $ret['code'] = "ERROR";
      $ret['msg'] = "LOAN ID ERROR";
      echo json_encode($ret);return;
    }
    $this->load->helper('security');
    $data = array(
      'view_jinhaeng'=>$this->input->post('view_jinhaeng') == 'Y' ? 'Y':'N'
      ,'view_slide'=>$this->input->post('view_slide') == 'Y' ? 'Y':'N'
      ,'view_gongjung'=>$this->input->post('view_gongjung') == 'Y' ? 'Y':'N'
      ,'gongjungryul'=>xss_clean($this->input->post('gongjungryul'))
      ,'view_gongjung_slide'=>$this->input->post('view_gongjung_slide') == 'Y' ? 'Y':'N'
      ,'nowstep'=>in_array( $this->input->post('nowstep') , array('N','1','2','3','4')) ? $this->input->post('nowstep'):'N'
			,'nowstepdesc'=>addslashes($this->input->post('nowstepdesc'))
    );

    $row = $this->db->get_where('mari_loan_ext', array('fk_mari_loan_id'=>$loanid))->row_array();
    if(isset($row['fk_mari_loan_id']) ){
      $res = $this->db->where('fk_mari_loan_id',$loanid)->update ('mari_loan_ext', $data );
    }else {
      $data['fk_mari_loan_id'] = $loanid;
      $res = $this->db->insert ('mari_loan_ext',$data ) ;
    }
    if($res) echo json_encode(array('code'=>'OK'));
    else echo json_encode(array('code'=>'ERROR', 'msg'=>'DB UPDATE ERROR'));
  }
	protected function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
		else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
		echo json_encode( $data );
		exit;
	}
}
