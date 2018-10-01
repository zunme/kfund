<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Meminfo extends CI_Controller {

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
		if($row['au_member'] != 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
	public function index()
	{
		;
	}
	/* 회원인증 */
	public function authmem(){
		$m_no = (int)$this->input->post('mno');
		if( $m_no < 1) {
			$this->json(array ( 'code'=>'ERROR', 'msg'=>'Member No ERROR'));
			return;
		}

		if($this->db->insert('mari_member_auth',array('fk_mari_member_m_no'=>$m_no, 'authed'=>'Y')) ) {
			$this->json(array ( 'code'=>'OK', 'msg'=>''));
			return;
		}else {
			$this->json(array ( 'code'=>'ERROR', 'msg'=>'DB ERROR OCCURED'));
			return;
		}
	}
	public function authmemcancel(){
		$m_no = (int)$this->input->post('mno');
		if( $m_no < 1) {
			$this->json(array ( 'code'=>'ERROR', 'msg'=>'Member No ERROR'));
			return;
		}

		if($this->db->where ('fk_mari_member_m_no',$m_no) ->delete('mari_member_auth') ) {
			$this->json(array ( 'code'=>'OK', 'msg'=>''));
			return;
		}else {
			$this->json(array ( 'code'=>'ERROR', 'msg'=>'DB ERROR OCCURED'));
			return;
		}
	}


	public function lnq() {
		if ( !$this->input->post('mn') ) {
				$this->json( array('code'=>500 ,'msg'=>'POST ERROR') );return;
		}
		$nonce_lnq_mem = time().rand(111,99);
		/*페이게이트 주문번호 생성*/
		$g_code_mem = "P".time().rand(111,999);

		include_once('../pnpinvest/plugin/pg/seyfert/aes.class.php');
		$sql = "select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'";
	//	$qry = $this->db->query($sql , $this->input->post('mn') );
		$bankck = $this->db->query($sql , $this->input->post('mn') )->row_array();
		if ( !isset( $bankck['s_memGuid']) ) {
			$this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
			return;
		}
		$config = $this->db->query(" select * from mari_config ")->row_array();
		$KEY_ENC    = $config[c_reqMemKey];

		$ENCODE_PARAMS_lnq="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config[c_reqMemGuid]."&nonce=".$nonce_lnq_mem."&refId=".$g_code_mem."&dstMemGuid=".$bankck[s_memGuid]."&crrncy=KRW";
		$cipher_lnq = AesCtr::encrypt($ENCODE_PARAMS_lnq, $KEY_ENC, 256);
		$cipherEncoded_lnq = urlencode($cipher_lnq);
		$requestString_lnq = "_method=GET&reqMemGuid=".$config[c_reqMemGuid]."&encReq=".$cipherEncoded_lnq;

		/*파싱할URL Seyfert API 공통 필수파라미터 => reqMemGuid=".$config[c_lnqqMemGuid]."&_method=POST&desc=desc&nonce=".$nonce."*/
		$requestPath_lnq = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance?".$requestString_lnq;

		$curl_handlebank_lnq = curl_init();
		curl_setopt($curl_handlebank_lnq, CURLOPT_URL, $requestPath_lnq);
		/*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
		curl_setopt($curl_handlebank_lnq, CURLOPT_CONNECTTIMEOUT, 2);
		curl_setopt($curl_handlebank_lnq, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curl_handlebank_lnq, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
		curl_setopt($curl_handlebank_lnq, CURLOPT_USERAGENT, 'https://v5.paygate.net/v5/member/seyfert/inquiry/balance');
		$result_lnq = curl_exec($curl_handlebank_lnq);
		if( $result_lnq===false ) $curlerror = curl_error($curl_handlebank_lnq);
		curl_close($curl_handlebank_lnq);
		$decode_lnq = json_decode($result_lnq, true);
		if( !is_array( $decode_lnq) ) {
			$this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $curlerror) );return;
		}else if ( $decode_lnq['status'] != 'SUCCESS') {
			$this->json( array('code'=>203 ,'msg'=>'GATE ERROR', 'data'=>array('status'=>$decode_lnq['status']) ) );return;
		}else {
			$amount = isset( $decode_lnq['data']["moneyPair"]["amount"] ) ? (int) $decode_lnq['data']["moneyPair"]["amount"] : '0';
			$this->json( array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>array('amount'=>$amount) ) );return;
		}

	}
	private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}
