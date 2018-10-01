<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Castboard extends CI_Controller {
  function index() {
    $data = array();
    $sql = "select loan.i_id, loan.i_subject
            from mari_loan loan
            join
            	(select ifnull( b.parents_loan_id , a.i_id ) as parentid from 	mari_loan a 	left join mari_loan_same_owner b on a.i_id = b.loan_id) par on loan.i_id = par.parentid
            order by i_id desc";
    $data['select'] = $this->db->query($sql)->result_array();

    foreach( $data['select'] as &$row){
      $pattern[] = '/^(제)*\s*[0-9]+\s*차/';
      $pattern[] = '/^(제)*\s*[0-9]+\s*호/';
      $row['i_subject'] = preg_replace ($pattern, '', $row['i_subject']);
    }

    $data['list'] = $this->db->query('select a.* , b.i_subject from z_cast a left join mari_loan b on a.loan_id = b.i_id order by cast_idx desc')->result_array();
    $this->load->view('cast_board_list', $data);
  }
  function paper() {
    $data = array();
    if($this->input->get('castid') > 0 ){
      $data = $this->db->get_where('z_cast', array('cast_idx'=>$this->input->get('castid')) )->row_array();
    }
    $sql="
      select
      	mari_loan.i_id, mari_loan.i_subject
      from mari_loan
      left join mari_loan_same_owner b on mari_loan.i_id = b.loan_id
      where mari_loan.i_view = 'Y' and b.parents_loan_id is null
    ";
    $list = $this->db->query($sql)->result_array();
    $this->load->view('castboard_write', array("data"=>$data, "list"=>$list));
  }
  function logo() {
    $this->load->view('logotest');
  }
  function uploadimg() {
    $config['upload_path'] = '../pnpinvest/data/cast';
    $config['allowed_types'] = 'gif|jpg|png';
    $config['max_size']	= '10000';
    $config['encrypt_name']	= true;
    $config['remove_spaces']	= true;

    $this->load->library('upload', $config);

    if ( ! $this->upload->do_upload())
    {
      $error = array('error' => $this->upload->display_errors());
      var_dump($error);
    }
    else
    {
      $data = array('upload_data' => $this->upload->data());
    //var_dump("/pnpinvest/data/cast/".$data['upload_data']["file_name"]);
      //echo json_encode( array('image'=>"http://kfunding.co.kr/pnpinvest/data/cast/".$data['upload_data']['file_name']));
      echo "http://kfunding.co.kr/pnpinvest/data/cast/".$data['upload_data']['file_name'];
    }
  }
  function write() {
    $this->load->library('form_validation');

    $this->form_validation->set_rules('casttitle', '제목', 'trim|required|xss_clean');
    $this->form_validation->set_rules('loan_id', '관련상품', 'trim|required|integer');
    $this->form_validation->set_rules('cast_body', '내용', 'trim|required');

    $this->form_validation->set_message('required', '%s은(는) 필수입니다.');

    $this->form_validation->set_error_delimiters('', '');
    if ($this->form_validation->run() == FALSE) {
      echo json_encode( array("code"=>500, "msg"=>validation_errors() ));//
      return;
    }

    preg_match_all("|<p class=\"k-cast-p\">(.*)</p>|U",$this->input->post("cast_body"),$out, PREG_SET_ORDER);
    $contetnts =  ( isset($out[0][1]) ) ? $out[0][1] : "" ;
    preg_match_all("/<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>/i", $this->input->post("cast_body"), $out);
    $img = ( isset($out[1][0]) ) ? $out[1][0] : "" ;

    if( $this->input->post("notice")=='Y' ){
      $this->db->query("update z_cast set notice='N' where notice ='Y'");
    }

    $set = array(
        "loan_id"=>$this->input->post("loan_id")
        ,"notice"=> $this->input->post("notice")=='Y' ? "Y" : "N"
        ,"isview"=> $this->input->post("isview")=='Y' ? "Y" : "N"
        , "cast_title"=>$this->input->post("casttitle")
        , "cast_img" => $img
        , "cast_contents"=>$contetnts
        , "cast_body"=>$this->input->post("cast_body")
    ) ;
    if( $this->input->post('castid') > 0  ){
      $res = $this->db->where('cast_idx', $this->input->post('castid') )->update('z_cast', $set);
      $castid = $this->input->post('castid');
    }else {
      $res = $this->db->insert('z_cast', $set);
      $castid = $this->db->insert_id();
    }
    if( $this->input->post("notice")!='Y' ){
      $cnt = $this->db->query("select ifnull(count(1),0) as cnt from z_cast where isview='Y' and notice='Y'")->row_array();
      if( !isset($cnt['cnt']) || $cnt['cnt']< 1){
        $this->db->query("select cast_idx into @last_cast_idx from z_cast where isview='Y' order by cast_idx desc limit 1");
        $this->db->query("update z_cast set notice='Y' where cast_idx = @last_cast_idx;");
      }
    }
    if (!$res){
      echo json_encode( array("code"=>500, "msg"=>"저장중 에러발생" ));//
    }else {
      echo json_encode( array("code"=>200, "msg"=>"저장하였습니다.", "castid"=>$castid ));//
    }
  }
}
