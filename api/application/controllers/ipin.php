<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

define("PluginPath",'/home/pnpinvest/www/pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');

class Ipin extends CI_Controller {
  var $userid;
  var $sitecode;
  var $sitepasswd;
  var $reqseq;

  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    if(isset($_SESSION['ss_m_id']) && trim($_SESSION['ss_m_id']) !=''){
      $this->user_info = $this->db->get_where('mari_member', array('m_id'=>$_SESSION['ss_m_id']) )->row_array();
      $this->userid = (isset($this->user_info['m_id']) && $this->user_info['m_id']==$_SESSION['ss_m_id']) ? $_SESSION['ss_m_id']:'';

    } else $this->userid ='';
    $this->reqseq = (isset($_SESSION["REQ_SEQ"])) ? $_SESSION["REQ_SEQ"]:'';
    //session_write_close();

    $this->sitecode   = 'AK24';
    $this->sitepasswd = 'Sodi1234';

    if (!extension_loaded('IPINClient')) {
        dl('IPINClient.' . PHP_SHLIB_SUFFIX);
    }
    $this->{$method}();
  }
  function index() {
    $sCPRequest = get_request_no($this->sitecode);
    $_SESSION['CPREQUEST'] = $sCPRequest;
    $sEncData              = "";
    $sRtnMsg               = "";

    $sReturnURL          = "https://fundingangel.co.kr:6003/api/index.php/ipin/authed";
    $sCPRequest           = "https://fundingangel.co.kr:6003/api/index.php/ipin/authederr";

    $sEncData = get_request_data($this->sitecode, $this->sitepasswd, $sCPRequest, $sReturnURL);
    $this->load->view('ipincheckform', array('sEncData'=>$sEncData));
  }
  function authed() {
    //var_dump($_POST);
    /*
    array(4) { ["enc_data"]=> string(436) "AgAEQUsyNLt5HIolEXJhFbB8DT1u0mzS9PV/J9sVpcS3s4i/GVuTNRfGagCaI7LXoHC4edoPTamOdumkunMCgrzB1RH3Ed/ql+pWSIBDNDrhQbb1BNkgYf0MmPNTmQFoxHA+jD89/gy305jzlHCB9KkA2hnpXfR4NT37TDOgoVGCnKylwUzK5INuG898wobiC5EP9D8vBe6fONStz84qq3ABctF2w0XNDoRv0woMwL9STkhj0YWeNwhWTmtqf8jlqmN7WuxoX8hSnzyVOCt+jhSeU8tMie97XNx8o10/NV1HCeo6n0a76tqNWrLmAf6eSi4Oq9qQtf82XIMBy3tYt9aRrrsL2r3Yxt/1cjKlK1FoKXoVG1EDYJs4R2JnB/d+L+ZlWZKF3hpkJfPWLhQ8l3V05sGsG7j4/An7rHBRYAcFZ24Vb54U" ["param_r1"]=> string(0) "" ["param_r2"]=> string(0) "" ["param_r3"]=> string(0) "" }
    */
  //  $sEncData = "AgAEQUsyNLt5HIolEXJhFbB8DT1u0mzS9PV/J9sVpcS3s4i/GVuTNRfGagCaI7LXoHC4edoPTamOdumkunMCgrzB1RH3Ed/ql+pWSIBDNDrhQbb1BNkgYf0MmPNTmQFoxHA+jD89/gy305jzlHCB9KkA2hnpXfR4NT37TDOgoVGCnKylwUzK5INuG898wobiC5EP9D8vBe6fONStz84qq3ABctF2w0XNDoRv0woMwL9STkhj0YWeNwhWTmtqf8jlqmN7WuxoX8hSnzyVOCt+jhSeU8tMie97XNx8o10/NV1HCeo6n0a76tqNWrLmAf6eSi4Oq9qQtf82XIMBy3tYt9aRrrsL2r3Yxt/1cjKlK1FoKXoVG1EDYJs4R2JnB/d+L+ZlWZKF3hpkJfPWLhQ8l3V05sGsG7j4/An7rHBRYAcFZ24Vb54U";

    if( !isset($_POST['enc_data']) ){
      $this->load->view('nicealert', array('alertmsg'=>"오류가 발생하였습니다.",'reload'=>true) );return;
    }

    $sEncData = $_POST['enc_data'];
    //$sEncData ="AgAEQUsyNCb87fBCz4VklDkk3qtpXc2h4iitHFO8JXJarVXv5fjJNRfGagCaI7LXoHC4edoPTamOdumkunMCgrzB1RH3Ed9Q6YrHstIKuUbmvYX5dGCj/OKF6hCeeM0r3iu3KXYYx82bfvqnbKKlNQmgxyN7K49Toj9E124LIT8im9ijirFMj3BiFzCRy8JkiRUye3KFNSc3V9bUmWt07iHpzMIzw2OTRGMR2SYUssD7gPD5bXg0Y83Zw9dNEHFRIRNGK03RwCg+C+z7u5BA3a7Y80ITPT5lz2uKWWIe0PWwH7AIFCboS3I6KhEsgKLcP5glfs6VdTac8sC4d/KnACkpzQlEgp5wU7mqtZGe8aSHSWRwfh64r0Gp2ykp3sfrxKcKy129T8d7lZkfK2zBBAuuiqPFAs8W0I9HHMj1XL0TPt4Z3hRK";
    $plaindata = get_decode_data($this->sitecode, $this->sitepasswd, $sEncData);
    $tmp = explode("^", $plaindata);
    $data = array();
    $data['CPREQUEST'] = $_SESSION['CPREQUEST'];
    for($i=0; $i < 8;$i++){
      $data["m".$i] = $tmp[$i];
    }
    $this->db->insert('z_ipin_log', $data);
    $this->load->view('nicealert', array('url'=>"/pnpinvest/?mode=join3") );return;
  }
}
