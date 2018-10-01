<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
set_time_limit(300);
class Sunapaligo extends CI_Controller {
  public function _remap($method) {
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();

    /* login 잠시 품 */
    $this->sms['user_id'] = "kfunding"; // SMS 아이디
    $this->sms['key'] = "p3b154zi0wyurtqeuf4jb3k87bc4nbuj";//인증키
    $this->sms['sender'] = '025521772';
    $this->sms['testmode_yn']='N';
    $this->limit = 100;
    $this->{$method}();
    return;
  }
  public function getlist() {
    $sql = "
    select
      ifnull(count(1) , 0) as cnt
    from z_invest_sunap a
    join mari_invest_progress p on a.loan_id = p.loan_id
    join z_invest_sunap_detail b on a.idx = b.history_idx and paystatus='Y' and smsstatus = 'N'
    join mari_member m on b.sale_id = m.m_id and m_hp != ''
    where a.regdate >= curdate()";
    $row = $this->db->query($sql)->row_array();
    echo json_encode(array("result_code"=>"OK","data"=>$row['cnt'],"message"=>"오늘 날짜로 ".$row['cnt']." 건이 있습니다.")); return;
  }
  public function sendsms() {
    $sql = "
    select
    	b.detail_idx, b.loan_id
    	,b.sale_id, b.emoney
    	, m.m_name, m.m_hp
    	, p.i_invest_name
    	,a.o_count
    from z_invest_sunap a
    join mari_invest_progress p on a.loan_id = p.loan_id
    join z_invest_sunap_detail b on a.idx = b.history_idx and paystatus='Y' and smsstatus = 'N'
    join mari_member m on b.sale_id = m.m_id and m_hp != ''
    where a.regdate >= curdate()
    limit ".$this->limit;
    $qry = $this->db->query($sql);
    $rows = $qry->result_array();
    $i = 0;
    if( count($rows)> 0 ){
      foreach ($rows as $row){
        $i++;
        $post = $this->sms;
        $post['receiver'] = $row['m_hp'];
        $post['msg']='케이펀딩 가상계좌로 원리금 '.number_format($row['emoney'])."원이 입급되었습니다.
www.kfunding.co.kr";
        $res = $this->sendsmscurl($post);
        if ($res->result_code == "1"){
          $this->db->set('smsstatus', 'Y')->where('detail_idx', $row['detail_idx'])->update('z_invest_sunap_detail');
        }else {
          $this->db->set('smsstatus', 'F')->where('detail_idx', $row['detail_idx'])->update('z_invest_sunap_detail');
        }
        if( $i > 0 &&($i % 10) == 0 ) {sleep(1); echo "sleep..";};
      }
    }
    echo json_encode(array("result_code"=>"OK", "msg"=>$i."건을 보냈습니다.")); return;
  }

  function sendsmscurl($post){
    $sms_url = "https://apis.aligo.in/send/";
    $oCurl = curl_init();
    curl_setopt($oCurl, CURLOPT_PORT, 443);
    curl_setopt($oCurl, CURLOPT_URL, $sms_url);
    curl_setopt($oCurl, CURLOPT_POST, 1);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS, $post);
    curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
    $ret = curl_exec($oCurl);
    curl_close($oCurl);
    return json_decode($ret);
  }
}
