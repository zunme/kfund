<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//define("PluginPath",'/home/pnpinvest/www/pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');

class Consulting extends CI_Controller {
  function index(){
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    if(isset($_SESSION['ss_m_id'])) $m_id = $_SESSION['ss_m_id'];
    else $m_id ='';
    $this->load->view("consulting");
  }
  function save(){
    if($this->input->post("agreement") != 'Y'){
      return;
      echo json_encode(array('code'=>500, "msg"=>"개인정보 수집 및 이용에 동의해주세요"));
    }
    $this->load->helper('security');
    $data ['company'] = xss_clean($this->input->post("company_name"));
    $data ['name'] = xss_clean($this->input->post("manager_name"));
    $data ['tel'] = xss_clean($this->input->post("manager_tel"));
    $data ['exp'] =xss_clean($this->input->post("inv_exp"));

    if( $this->db->insert('z_counsult', $data) ) {
      echo json_encode(array('code'=>200, "msg"=>""));
    }else {
      echo json_encode(array('code'=>500, "msg"=>"오류가 발생하였습니다. 잠시후에 시도해주세요"));
    }

  }
}
