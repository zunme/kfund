<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  testk extends Adm {
  function index(){
    require "../pnpinvest/module/sendkakao.php";
    $row['sale_id']='rightarm01@hotmail.com';
    $row['emoney']='500368';
    $msg = array("code"=>"J0001", "m_id"=>$row['sale_id'], "data"=>array("emoney"=>$row['emoney']));
    sendkakao($msg);
  }
}
