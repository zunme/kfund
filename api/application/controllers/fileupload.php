<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Fileupload extends CI_Controller {

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
  public function office()
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
    /*
    $file = $_FILES['userfile'];
    $filename  = strip_tags($file['name']);
    $extension = pathinfo($filename);
    $filename = str_replace(".".$extension['extension'] , '', $filename);
    $filename = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~|\!\?\*$#<>()\[\]\{\}]/i", "",  str_ireplace(" ", "_", $filename) );
    $filename = preg_replace("/\.(php|phtm|htm|cgi|pl|exe|jsp|asp|inc)/i", "$0-x", $filename);
    $filename = $filename.".".$extension['extension'];
    $cnt = $this->db->query('select ifnull(count(1),0) as cnt from mari_invest_file where loan_id = ? and file_name = ? ', array($loanid,$filename) )->row_array();
    if($cnt['cnt']>0){
      $data['error'] = "같은이름의 파일이 존재합니다";
      $data['sql'] = $this->db->last_query();
      $data['file_name']=$_FILES['userfile']['name'];
      $files['files'][] =$data;
      echo json_encode($files);return;
    }
    $config['file_name'] = $filename;
    */
    $config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
    $config['remove_spaces'] = TRUE;
    //$config['overwrite'] = TRUE;


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
      $this->db->insert('mari_invest_file', array('loan_id'=>$loanid, 'file_name'=>$data['file_name'], 'file_regidate'=>date('Y-m-d H:i:s')));
      $data['error']='';
      $data['fileid'] = $this->db->insert_id();
			$this->db->query("set @loan_id=?;", array($loanid));
			$this->db->query("set @rank:=0;");
			$sql = "update mari_invest_file
							set sortnum = @rank:=@rank+1
							where loan_id = @loan_id
							order by sortnum, file_idx";
			$this->db->query($sql);
			$sortnum = $this->db->query("select sortnum from mari_invest_file where file_idx = ? ", array($data['fileid']) )->row_array();
			$data['sortnum']=$sortnum['sortnum'];
      $files['files'][] = $data;
    }
      echo json_encode($files);return;
      $path = "../pnpinvest/data/file/".$loanid."/".$filename;
      var_dump(move_uploaded_file($_FILES['userfile']['tmp_name'], $path));
     //$filename = preg_replace ("/[ #\&\+\-%@=\/\\\:;,\.'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "",  str_ireplace(" ", "", $filename) );
	}
	function officesort() {
		$loanid = (int) ($this->input->post('loanid'));
		if($loanid < 1){
			echo json_encode(array("code"=>404, "msg"=>"LOAN ID ERROR"));return;
		}
		$sort = array();
		foreach ($this->input->post('filetable') as $val ) {
			$sort[] = str_replace("fi_",'', $val);
		}
		$this->db->query("set @rank:=0;");
		$sql = "update mari_invest_file
						set sortnum = @rank:=@rank+1
						where loan_id = ".$loanid."
						order by field (file_idx, ".implode(',', $sort)." )";
		$this->db->query($sql);
		echo json_encode(array("code"=>"OK", "msg"=>""));return;
	}
  function gallery() {
    $loanid = (int) ($this->input->post('loanid'));
		$gallerytype = $this->input->post('gtype') !='' ? $this->input->post('gtype'):'g';
    if($loanid < 1){
      $data['error'] = "LOAN ID ERROR";
      $data['file_name']=$_FILES['userfile']['name'];
      $files['files'][] =$data;
      echo json_encode($files);return;
    }

    $config['upload_path'] = "../pnpinvest/data/file/".$loanid."/gallery/";

    if (!is_dir("../pnpinvest/data/file/".$loanid."/")) {
        mkdir("../pnpinvest/data/file/".$loanid."/", 0777, TRUE);
    }
    if (!is_dir($config['upload_path'])) {
        mkdir($config['upload_path'], 0777, TRUE);
    }
    $config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
    $config['remove_spaces'] = TRUE;
    $config['encrypt_name'] = TRUE;
    //$config['overwrite'] = TRUE;


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
      $orderno = $this->db->query('select ifnull(max(`order_no`),1)+1 as order_no from z_gallery where loanid = ? and gtype = ? ', array($loanid, $gallerytype))->row_array();
      $this->db->insert('z_gallery', array('loanid'=>$loanid, 'gtype'=>$gallerytype,'order_no'=>$orderno['order_no'], 'client_name'=>$data['client_name'],'file_name'=>$data['file_name']));
      $data['error']='';
      $data['idx'] = $this->db->insert_id();;
      $files['files'][] = $data;
    }
      echo json_encode($files);return;
  }
  function gallerylist() {
    $loanid = (int) ($this->input->get('loanid'));
		$gallerytype = $this->input->get('gtype') !='' ? $this->input->get('gtype'):'g';
    $rows = $this->db->query('select * from z_gallery where loanid = ? and gtype = ? order by order_no , idx', array($loanid,$gallerytype) )->result_array();
    echo json_encode( array('cnt'=>count($row), 'data'=>$rows) );
  }
	function galleryview(){
		$loanid = (int) ($this->input->get('loanid'));
		$gallerytype = $this->input->get('gtype') !='' ? $this->input->get('gtype'):'g';
    $rows = $this->db->query('select * from z_gallery where loanid = ? and gtype = ? order by order_no , idx', array($loanid,$gallerytype) )->result_array();
		$loan = $this->db->query('select * from mari_loan where i_id = ? ', array($loanid) )->row_array();
		$this->load->view('popup_gallery',array('data'=>$rows,'info'=>$loan));
	}
	function gallerydel(){
		$idx = $this->input->post("fileidx");
		if($idx > 0){
			$file = $this->db->get_where('z_gallery', array('idx'=>$idx))->row_array();
			if(isset($file['file_name'])){
				if ($this->db->where('idx', $idx)->delete('z_gallery')) {
					unlink("../pnpinvest/data/file/".$file['loanid']."/gallery/".$file['file_name']);
					echo json_encode(array('code'=>"OK","msg"=>"삭제되었습니다."));
				}
				else echo json_encode(array('code'=>"ERROR","msg"=>"DB ERROR OCCURED"));

			}else {
				echo json_encode(array('code'=>"ERROR","msg"=>"파일 정보를 찾을 수 없습니다."));
				return;
			}
		}else echo json_encode(array('code'=>"ERROR","msg"=>"파일 번호가 없습니다."));
	}
	function gallerysort(){
		$gallerytype = $this->input->post('gtype') !='' ? $this->input->post('gtype'):'g';
		$this->db->query("SELECT @rank:=0");
		$order = implode(',', json_decode($this->input->post('idxs')));
		$sql = "
		UPDATE z_gallery SET order_no=@rank:=@rank+1
		where loanid = ? and gtype = ?
		ORDER BY field (idx ,".$order.")
		";
		if( $this->db->query($sql, array((int)($this->input->post('loanid')), $gallerytype)) ) echo json_encode(array('code'=>"OK","msg"=>"변경되었습니다."));
		else echo json_encode(array('code'=>"ERROR","msg"=>"다시 시도해 주세요."));
	}
}
