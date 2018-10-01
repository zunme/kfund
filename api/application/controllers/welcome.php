<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {
  public function index() {
		$this->load->view('test_invest');
	}
  public function event() {
    $this->load->view('test_event');
  }
	public function autologin() {
		//session_start();
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
		if($row['au_member'] != 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}

		$mem = $this->input->get('mid');
		if($this->input->get('pw') != 'fundfund') return false;

		$sql = "select * from mari_member where m_id = ?";
		$mem = $this->db->query($sql, array($mem))->row_array();
		$_SESSION['ss_m_id'] = $mem['m_id'];
		?>
			<script>
				location.replace('/pnpinvest/?mode=mypage_invest_info');
			</script>
		<?php
		//set_session('ss_m_id', $mem['m_id']);
		//set_session('ss_m_key', hash('sha256', $mem['m_datetime'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT']));
	}
	protected function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
		else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
		echo json_encode( $data );
		exit;
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
