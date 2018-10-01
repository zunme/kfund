<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Accounting extends CI_Controller {

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
		if($row['au_sales'] != 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );			
		}	
			
		$this->{$method}();
	}
	public function index()
	{
		;
	}
	public function withholding () {
	   $method = ( $this->uri->segment(3) ===false ) ? 'add' : $this->uri->segment(3) ;
	   if($method ==='add') {
	   	   $checked = $this->input->post('hiddencheck');
	   	   if ($checked === false || count($checked ) < 1 ) $this->json( array('code'=>'ERROR', 'msg'=>'선택된 거래가 없습니다. 먼저 체크후에 사용해 주세요' ) ) ;
		   $idxs = implode(',' , $checked) ;
		   $ins_sql = "insert into mari_order_deleted select * from mari_order where  o_id in ( ".$idxs." ) ";
		   $del_sql = "delete from mari_order where  o_id in ( ".$idxs." ) ";
		   //$sql = "update mari_order set view_status = 'H' where o_id in ( ".$idxs." ) ";
		   $qry = $this->db->query( $ins_sql );
		   $qry = $this->db->query( $del_sql );
		   
		   $this->json(array('code'=>'OK', 'msg'=>'done') ) ;
	   }else if($method ==='hide') {
	   	   $checked = $this->input->post('hiddencheck');
	   	   if ($checked === false || count($checked ) < 1 ) $this->json( array('code'=>'ERROR', 'msg'=>'선택된 거래가 없습니다. 먼저 체크후에 사용해 주세요' ) ) ;
		   $idxs = implode(',' , $checked) ;
		   $up_sql = "update mari_order set view_status = 'H' where o_id in ( ".$idxs." ) ";
		   $qry = $this->db->query( $up_sql );
		   
		   $this->json(array('code'=>'OK', 'msg'=>'done') ) ;
	   }
	}
	private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
