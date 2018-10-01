<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Cmsinvestlist extends CI_Controller {

	public function _remap($method) {
		if ( ! session_id() ) @ session_start();
		if( !isset($_SESSION['ss_m_id'] ) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"로그인후 사용해주세요") );
		}
		$query = $this->db->query('SELECT * FROM mari_authority where m_id = ? ', array($_SESSION['ss_m_id']) );
		if ( $query->num_rows() < 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		$row = $query->row_array();
		if( !isset($row['au_id']) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
	public function index()
	{
		;
	}
  public function move() {
    $ck = $this->input->post('check');
    if( !is_array($ck) || count($ck) < 1){
      $this->json(array ( 'code'=>501, 'msg'=>'none cheked data'));
      return;
    }

    $cklist = implode(',' , $ck);
    $sql = "insert into mari_invest_moved select * from mari_invest where i_id in ( ".$cklist." )";
    if( $this->db->query($sql) ) {
      $sql = "delete from mari_invest where i_id in ( ".$cklist." )";
      $this->db->query($sql);
      $this->json(array ( 'code'=>200, 'msg'=>'SUCCESS'));
    }
  }
  private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}
