<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Findaccount extends CI_Controller {
  public function _remap($method) {
    if ( ! session_id() ) @ session_start();
    if( isset($_SESSION['ss_m_id']) && $_SESSION['ss_m_id'] !='' ) {
      $this->json( array('code'=>'ERROR', 'msg'=>"이미 [".$_SESSION['ss_m_id']."] 아이디로 로그인 중입니다.") );
    }

    if( $method == 'sendconfirm'){
      $type = $this->uri->segment(3);
      $this->{$method.$type}();
    }else $this->{$method}();
  }
  public function index() {
      show_error('404');
  }
  public function sendconfirmid() {
    $this->load->library('form_validation');
    $this->form_validation->set_rules('m-name', '이름', 'trim|required|xss_clean');
    $this->form_validation->set_rules('m-hp', '휴대폰번호', 'required|numeric');
    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('email', '%s (은)는 이메일 형식이 아닙니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }
    $cnt = $this->db->query("select count(1) as cnt from z_find_account a where a.`fa_m-hp` = ? and fa_type='id' and regdate >= DATE_ADD( now() , INTERVAL -12 hour);", array($this->input->post('m-hp')) )->row_array();
    if( isset($cnt['cnt']) && $cnt['cnt'] >= 3 ){
        $this->json(array('code'=>500, 'msg'=> "12시간내에 3번의 시도가 있었습니다.\n나중에 다시 시도해주세요" ));
    }
    $mem = $this->db->where('m_name', $this->input->post('m-name'))->where('m_hp', $this->input->post('m-hp') )->get('mari_member')->row_array();
    if( !isset($mem['m_id']) ){
      $this->json(array('code'=>500, 'msg'=> "인증번호를 발송했습니다. 인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해주세요." ));
    }
    $config['encryption_key'] = "fk20d77su";
    $this->load->library('encrypt');
    $rand_num = sprintf('%06d',rand(010000,999999));
    $encrypted_string = $this->encrypt->encode(date('YmdHis').'|'.$rand_num);
    $_SESSION['findkey'] = $encrypted_string;
    $sms =  $this->aligo( $this->input->post('m-hp'), '[케이펀딩]인증번호 ['.$rand_num.']를 입력해주세요' );
    if( $sms->result_code == 1) {
      $this->db->insert('z_find_account', array('fa_key'=>$encrypted_string,'fa_id'=>$mem['m_id'] ,'fa_m-name'=>$this->input->post('m-name') , 'fa_m-hp'=>$this->input->post('m-hp') , 'fa_confirm_num'=>$rand_num ));
      $this->json( array('code'=>'OK', 'msg'=>'인증번호를 발송하였습니다.') );
    }else {
      $this->json( array('code'=>'OK', 'msg'=>'인증번호 발송 중 오류가 발생하였습니다.\n잠시후에 시도해 주세요') );
    }
  }
  public function sendconfirmpwd() {
    $this->load->library('form_validation');
    $this->form_validation->set_rules('m_id', '이메일 아이디', 'trim|required|email');
    $this->form_validation->set_rules('m_hp', '휴대폰번호', 'required|numeric');
    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('email', '%s (은)는 이메일 형식이 아닙니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }
    $cnt = $this->db->query("select count(1) as cnt from z_find_account a where a.`fa_m-hp` = ? and fa_type='pw' and regdate >= DATE_ADD( now() , INTERVAL -12 hour);", array($this->input->post('m_hp')) )->row_array();
    if( isset($cnt['cnt']) && $cnt['cnt'] >= 3 ){
        //$this->json(array('code'=>500, 'msg'=> "12시간내에 3번의 시도가 있었습니다.\n나중에 다시 시도해주세요" ));
    }
    $mem = $this->db->where('m_id', $this->input->post('m_id'))->where('m_hp', $this->input->post('m_hp') )->get('mari_member')->row_array();
    if( !isset($mem['m_id']) ){
      $this->json(array('code'=>500, 'msg'=> "인증번호를 발송했습니다. 인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해주세요." ));
    }
    $config['encryption_key'] = "fk20d77su";
    $this->load->library('encrypt');
    $rand_num = sprintf('%06d',rand(010000,999999));
    $encrypted_string = $this->encrypt->encode(date('YmdHis').'|'.$rand_num);
    $_SESSION['findpwkey'] = $encrypted_string;

    $this->db->insert('z_find_account', array('fa_type'=>'pw', 'fa_key'=>$encrypted_string,'fa_id'=>$mem['m_id'] ,'fa_m-name'=>'' , 'fa_m-hp'=>$this->input->post('m_hp') , 'fa_confirm_num'=>$rand_num ));
    //$this->json( array('code'=>'OK', 'msg'=>'인증번호를 발송하였습니다.') );
    $sms =  $this->aligo( $this->input->post('m_hp'), '[케이펀딩]인증번호 ['.$rand_num.']를 입력해주세요' );
    if( $sms->result_code == 1) {
      $this->db->insert('z_find_account', array('fa_type'=>'pw', 'fa_key'=>$encrypted_string,'fa_id'=>$mem['m_id'] ,'fa_m-name'=>'' , 'fa_m-hp'=>$this->input->post('m_hp') , 'fa_confirm_num'=>$rand_num ));
      $this->json( array('code'=>'OK', 'msg'=>'인증번호를 발송하였습니다.') );
    }else {
      $this->json( array('code'=>'OK', 'msg'=>'인증번호 발송 중 오류가 발생하였습니다.\n잠시후에 시도해 주세요') );
    }
  }
  public function confirmid() {
    if( !isset($_SESSION['findkey']) || $_SESSION['findkey'] ==''){
      $this->json(array('code'=>500, 'msg'=> '인증번호받기를 먼저 실행해주세요' ));
    }

    $this->load->library('form_validation');
    $this->form_validation->set_rules('m-name', '이름', 'trim|required|xss_clean');
    $this->form_validation->set_rules('m-hp', '휴대폰번호', 'required|numeric');
    $this->form_validation->set_rules('m-confirm', '인증번호', 'required|numeric');
    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('email', '%s (은)는 이메일 형식이 아닙니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }

    $find = $this->db->select ("fa_idx,fa_id, `fa_confirm_num`, if( DATE_ADD( now() , INTERVAL -3 minute) > regdate , 'over', 'in') as timeover", false) ->get_where('z_find_account', array('fa_type'=>'id', 'fa_state'=>'N', 'fa_key'=> $_SESSION['findkey'] , 'fa_m-name'=> $this->input->post('m-name') , 'fa_m-hp'=> $this->input->post('m-hp') ) )->row_array();
    if( !isset($find['fa_idx']) ) {
      $this->json(array('code'=>500, 'msg'=> "인증정보를 찾을 수 없습니다.\n처음부터 다시 시도해 주세요" ));
    }
    if( $find['fa_confirm_num'] != $this->input->post('m-confirm') ) {
      $this->json(array('code'=>500, 'msg'=> "인증번호를 확인해 주세요" ));
    }
    if ($find['timeover'] != 'in' ){
      $this->json(array('code'=>500, 'msg'=> "인증시간이 초과되었습니다.\n인증번호를 다시 받아주세요" ));
    }
    $this->db->set('fa_state', 'Y')->where('fa_idx', $find['fa_idx'])->update('z_find_account' );
      $this->json(array('code'=>200, 'data'=> $find['fa_id'] ,'msg'=> "" ));
  }
  public function confirmpwd() {
    if( !isset($_SESSION['findpwkey']) || $_SESSION['findpwkey'] ==''){
      $this->json(array('code'=>500, 'msg'=> '인증번호받기를 먼저 실행해주세요' ));
    }

    $this->load->library('form_validation');
    $this->form_validation->set_rules('m_id', '이메일아이디', 'trim|required|email|xss_clean');
    $this->form_validation->set_rules('m_hp', '휴대폰번호', 'required|numeric');
    $this->form_validation->set_rules('m-confirm', '인증번호', 'required|numeric');
    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('email', '%s (은)는 이메일 형식이 아닙니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }

    $find = $this->db->select ("fa_idx,fa_id, `fa_confirm_num`, if( DATE_ADD( now() , INTERVAL -3 minute) > regdate , 'over', 'in') as timeover", false) ->get_where('z_find_account', array('fa_type'=>'pw', 'fa_state'=>'N', 'fa_key'=> $_SESSION['findpwkey'] , 'fa_id'=> $this->input->post('m_id') , 'fa_m-hp'=> $this->input->post('m_hp') ) )->row_array();
    if( !isset($find['fa_idx']) ) {
      $this->json(array('code'=>500, 'msg'=> "유효한 인증정보를 찾을 수 없습니다.\n처음부터 다시 시도해 주세요" ));
    }
    if( $find['fa_confirm_num'] != $this->input->post('m-confirm') ) {
      $this->json(array('code'=>500, 'msg'=> "인증번호를 확인해 주세요" ));
    }
    if ($find['timeover'] != 'in' ){
      $this->json(array('code'=>500, 'msg'=> "인증시간이 초과되었습니다.\n인증번호를 다시 받아주세요" ));
    }
    $this->db->set('fa_state', 'Y')->where('fa_idx', $find['fa_idx'])->update('z_find_account' );
      $this->json(array('code'=>200, 'data'=> $_SESSION['findpwkey'] ,'msg'=> "" ));
  }
  public function changepwd() {
    if( !isset($_SESSION['findpwkey']) || $_SESSION['findpwkey'] =='' || $this->input->post('key') != $_SESSION['findpwkey'] ){
      $this->json(array('code'=>500, 'msg'=> "유효한 인증정보를 찾을 수 없습니다.\n처음부터 다시 시도해주세요" ));
    }
    $this->load->library('form_validation');
    $this->form_validation->set_rules('pass', '비밀번호', 'trim|required');
    $this->form_validation->set_rules('pass_re', '비밀번호확인', 'required|matches[pass]');

    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('matches', '%s 이 비밀번호와 동일하지 않습니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>501, 'msg'=> validation_errors() ));
    }
    $info = $this->db->query("select * from z_find_account where fa_key = ? and fa_state='Y' limit 1", array($_SESSION['findpwkey']))->row_array();
    if( !isset($info['fa_idx']) ){
      $this->json(array('code'=>502, 'msg'=> "유효한 인증정보를 찾을 수 없습니다.\n처음부터 다시 시도해 주세요" ));
    }

    $pattern = '/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/';
    if(preg_match($pattern ,trim($this->input->post('pass')) )){
      $this->db->where('m_id', $info['fa_id'])->update('mari_member',array('m_password'=>hash('sha256',trim($this->input->post('pass')) ) ) );
      $this->json(array('code'=>200, 'msg'=> "비밀번호를 수정하였습니다." ));
    }else {
      $this->json(array('code'=>505, 'msg'=> "영대/소문자, 숫자 및 특수문자 조합 비밀번호 8자리이상 15자리 이하의 새로운 비밀번호를 입력해주세요" ));
    }
  }
  private function aligo($phonelist,$msg) {
    $sms['user_id'] = "kfunding"; // SMS 아이디
    $sms['key'] = "p3b154zi0wyurtqeuf4jb3k87bc4nbuj";//인증키
    $sms['sender'] = '025521772';
    $sms['receiver'] = is_array($phonelist) ? implode(',' , $phonelist):$phonelist ;
    $sms['msg'] = $msg;
    $sms_url = "https://apis.aligo.in/send/";
    $oCurl = curl_init();
    curl_setopt($oCurl, CURLOPT_PORT, 443);
    curl_setopt($oCurl, CURLOPT_URL, $sms_url);
    curl_setopt($oCurl, CURLOPT_POST, 1);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS, $sms);
    curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
    $ret = curl_exec($oCurl);
    curl_close($oCurl);
    return json_decode($ret);
  }

  private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}
