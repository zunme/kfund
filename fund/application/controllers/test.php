<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Test extends CI_Controller{
  function index(){
    header('Content-Type: application/json; charset=UTF-8');
    $msg='{"msg_type":"AL","mt_failover":"N","msg_data":{"senderid":"025521772","to":"821025376460","content":"\ucf00\uc774\ud380\ub529 \uac00\uc0c1\uacc4\uc88c\ub85c \uc6d0\ub9ac\uae08 10,000\uc6d0\uc774 \uc785\uae09\ub418\uc5c8\uc2b5\ub2c8\ub2e4."},"msg_attr":{"sender_key":"7d7181b53eb319a666200b1181dce4a0396b3689","template_code":"J0001","response_method":"push","ad_flag":"Y","button":{"name":"\uc815\uc0b0\ub0b4\uc5ed \ubcf4\uae30","type":"WL","url_pc":"https:\/\/www.kfunding.co.kr\/pnpinvest\/?mode=mypage_invest_info","url_mobile":"https:\/\/www.kfunding.co.kr\/pnpinvest\/?mode=mypage_invest_info"}}}';
    //$msg='{"msg_type":"AL","mt_failover":"N","msg_data":{"senderid":"025521772","to":"821025376460","content":"케이펀딩 가상계좌로 원리금 10,000원이 입급되었습니다."},"msg_attr":{"sender_key":"7d7181b53eb319a666200b1181dce4a0396b3689","template_code":"J0001","response_method":"push","ad_flag":"Y","button":{"name":"정산내역 보기","type":"WL","url_pc":"https:\/\/www.kfunding.co.kr\/pnpinvest\/?mode=mypage_invest_info","url_mobile":"https:\/\/www.kfunding.co.kr\/pnpinvest\/?mode=mypage_invest_info"}}}';
    echo $msg;
  }
  function index2() {
    $this->load->driver('cache', array('adapter' => 'file'));
    header("Content-Type: application/json; charset=UTF-8");
    $inputJSON = file_get_contents('php://input');
    $this->cache->save('kakaoreport', $inputJSON, 1800);
    $this->cache->save('kakaoreport_time', date('Y-m-d'), 1800);
    $arr = json_decode($inputJSON, TRUE);
    $this->db->set('resultCode',$arr['resultCode'])->set('errorText',$arr['errorText'])->where('messageId',$arr['messageId'])->update('z_alimitok');
    echo'{"messageId":"'.$arr['messageId'].'",}';
  }
  function report() {
    $this->load->driver('cache', array('adapter' => 'file'));
    if ( $kakaoreport = $this->cache->get('kakaoreport')) var_dump($kakaoreport);
    else echo "nonereport";
    if ( $kakaoreport_time = $this->cache->get('kakaoreport_time')) var_dump($kakaoreport_time);
  }
  function resetreport(){
    $this->load->driver('cache', array('adapter' => 'file'));
    $this->cache->save('kakaoreport', '', 1800);
    $this->cache->save('kakaoreport_time', '', 1800);
  }
}
