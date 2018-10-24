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
}
