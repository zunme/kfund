<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . 'controllers/adm.php';
class Investcheck extends Adm {
  function index(){
    $list = $this->db->query("select * from mari_invest_progress where i_view='Y' and loan_id>10")->result_array();
    $this->load->view("adm_investcheck", array("list"=>$list));
  }
  function info($loan_id=0) {
    if($loan_id > 0 ){
      $loanid = $loan_id;
    }else $loanid = ((int)$this->input->get('loanid')>0) ? (int)$this->input->get('loanid') : 0;

    if ($loanid < 1){
          echo json_encode(array('code'=>404, 'msg'=>'loan id 를 확인해주세요'));return;
    }

    $sql = "select sum(a.i_pay) as pay from mari_invest a where a.loan_id = ? ";
    $sum = $this->db->query($sql, array($loanid) )->row_array();
    $sql = "select * from mari_invest where loan_id = ? and m_id='test@test.com' and m_name=''";
    $qry = $this->db->query($sql, array($loanid) );
    if($qry->num_rows() > 0 ){
      $list = $qry->result_array();
    }else $list = array();
    echo json_encode(array('code'=>200, 'msg'=>'', 'data'=>array("sum"=>$sum['pay'], "list"=>$list) ));return;
  }
  function additem(){
    $loanid = ((int)$this->input->post('loanid')>0) ? (int)$this->input->post('loanid') : 0;
    if ($loanid < 1){
          echo json_encode(array('code'=>404, 'msg'=>'loan id 를 확인해주세요'));return;
    }
    $pay = ((int)$this->input->post('pay')>0) ? (int)$this->input->post('pay') : 0;
    if ($pay < 1){
          echo json_encode(array('code'=>404, 'msg'=>'금액을 확인해주세요'));return;
    }
    $info = $this->db->query("select * from mari_loan where i_id = ? " ,array($loanid) )->row_array();
    $data = array("loan_id"=> $loanid, "m_id"=>"test@test.com", "m_name"=>"", "i_pay"=>$pay, "i_subject"=>$info['i_subject'], "i_pay_ment"=>'Y');
    if( $this->db->insert('mari_invest', $data) ) {
      echo json_encode(array("code"=>200));
    }else echo json_encode(array("code"=>500, "msg"=>"DB ERROR"));
  }
  function rmitem(){
    $idx = ((int)$this->input->post('idx')>0) ? (int)$this->input->post('idx') : 0;
    if ($idx < 1){
          echo json_encode(array('code'=>404, 'msg'=>'삭제번호가 없습니다.'));return;
    }
    $this->db->delete('mari_invest', array('i_id'=>$idx));
    echo json_encode(array("code"=>200));
  }
}
