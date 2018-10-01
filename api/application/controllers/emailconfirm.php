<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Emailconfirm extends CI_Controller {
  function findpassword() {

    $this->load->library('form_validation');
    $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
    if ($this->form_validation->run() == FALSE)
    {
      echo json_encode(array('code'=>500, 'msg'=>'Email 주소를 확인해 주세요'));
      return;
    }
    $email = $this->input->post('email');
    $idinfo = $this->db->select('m_id')->get_where('mari_member', array('m_id'=>$email))->row_array();
    if( !isset($idinfo['m_id']) ){
      echo json_encode(array('code'=>404, 'msg'=>'등록된 Email 이 없습니다.'));
      return;
    }
    $this->load->helper('string');
    $code = random_string('unique');
    $sql = "update z_changepwd_confirm set confirmeded = 'C' where email = ? and confirmeded='N'";
    $this->db->query($sql, array($email) );
    $this->db->insert('z_changepwd_confirm', array('code'=>$code, 'email'=>$email));
    $msg = "
    <a href=''>엔젤펀딩파트너스</a><br>
    <br>
    <hr>
    아래 링크를 통해 비밀번호를 변경할 수 있습니다.<br>
    <br>
    <a href='https://fundingangel.co.kr:6003/api/index.php/emailconfirm/confirm/".$code."'>패스워드 변경하기</a>
    <br>
    <br>
    <hr>
    회원님의 성원에 보답하고자 더욱 더 열심히 하겠습니다.
    ";
    $this->load->library('email');
    $config['protocol'] = 'sendmail';
    $config['mailpath'] = '/usr/sbin/sendmail';
    $config['charset'] = 'UTF-8';
    $config['wordwrap'] = TRUE;

    $this->email->initialize($config);
    $this->email->from('contact@fundingangel.co.kr', '엔젤펀딩파트너스');
    $this->email->to($email);
    //$this->email->to('zunme@naver.com');

    $this->email->subject('엔젤펀딩파트너스 비밀번호 변경안내');
    $this->email->message($msg);
    $this->email->set_mailtype("html");
    $this->email->send();
    echo json_encode(array('code'=>200,'msg'=>'이메일 발송을 하였습니다.'));
  }
  function confirm() {
    $tmp = explode('/', $this->uri->slash_segment(3));
    $code = $tmp[0];
    if($this->input->post('code') != '' ) $code = $this->input->post('code');
    $sql = "select * from z_changepwd_confirm a where code = ? and a.regdate > date_sub( now() , interval 30 minute)";
    $codeinfo = $this->db->query($sql, array($code))->row_array();

    if($code ==''){
      $head = "비밀번호를 잃어버리셨나요?";
      $body = "가입 시 등록한 이메일 주소로 초기화된 비밀번호를 발송해 드립니다.<br>*[비밀번호 변경하기] 는 이메일을 발송 후 30분 동안만 유효합니다.";
      $this->load->view('emailconfirm', array('msg'=>array('head'=>$head, 'body'=>$body,'title'=>'비밀번호 찾기')));
    }
    else if(!isset($codeinfo['code'])){
      $head = "해당 정보를 찾을 수 없습니다.";
      $body = "비밀번호 찾기를 다시 한 번 시도해 주세요<br>*[비밀번호 변경하기] 는 이메일을 발송 후 30분 동안만 유효합니다.";
      $this->load->view('emailconfirm', array('msg'=>array('head'=>$head, 'body'=>$body)));
    }else if($codeinfo['confirmeded'] != 'N') {
      $head = "이미 종료된 링크입니다";
      $body="비밀번호 찾기를 다시 한 번 시도해 주세요<br>*[비밀번호 변경하기] 는 이메일을 발송 후 30분 동안만 유효하며 마지막 발송된 이메일로만 변경이 가능합니다.";
      $this->load->view('emailconfirm', array('msg'=>array('head'=>$head, 'body'=>$body)));
    }else{
      if($this->input->post('pw') !='' && $this->input->post('pw') == $this->input->post('pw2') ){
        $pattern = '/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/';
        $password = $this->input->post('pw');
        if(preg_match($pattern,$password)){
            $this->db->set('m_password', hash('sha256', $this->input->post('pw')) )->where('m_id', $codeinfo['email'] )->update('mari_member');
            $this->db->set('confirmeded', 'Y' )->where('code', $codeinfo['code'] )->update('z_changepwd_confirm');
        		echo json_encode(array('code'=>200));
        	}else {
          echo json_encode(array('code'=>500,'msg'=>'비밀번호는 영문,숫자,특문( !@#$%^&+= ) 포함 8자리 이상입니다.'));
        }
      }
      else $this->load->view('emailconfirm', array('msg'=>'', 'code'=>$code));
    }
  }
}
