<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/libraries/JWT.php';
use \Firebase\JWT\JWT;
class Aligo extends CI_Controller {
  var $login;
  var $nowdate;
  var $limit;
  public function _remap($method) {
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();

    /* login 잠시 품 */
    $this->sms['user_id'] = "kfunding"; // SMS 아이디
    $this->sms['key'] = "p3b154zi0wyurtqeuf4jb3k87bc4nbuj";//인증키
    $this->sms['sender'] = '025521772';

    $this->limit = 500;
    $this->{$method}();
    return;
    /* / login 잠시 품 */
//unset($_COOKIE['api']);
    if(isset($_COOKIE['api'])){
      $this->login =  JWT::decode($_COOKIE['api'],'myAFKey132423',array('HS256','HS512','HS384','RS256','RS384','RS512'));
    }else if( $this->input->get('___')!=''){
      $this->login = JWT::decode($this->input->get('___'),'myAFKey132423',array('HS256','HS512','HS384','RS256','RS384','RS512'));
    }

    if(isset($this->login->id) ){
        if( $this->login->exp < $this->nowdate->getTimestamp() ){
          $this->login='';
        }else {
          if($method=='login') {
            ?> <script>location.replace('/api/index.php/adm');</script> <?php
            return;
          }
          /*실디비사용*/
          //$this->db = $this->load->database('real',true);
          $this->sms['user_id'] = "angelfunding"; // SMS 아이디
          $this->sms['key'] = "mmzhvgk77fiyvl3mezn865auaj40rxq4";//인증키

          $this->limit = 500;
      		$this->{$method}();
          return;
        }
    }

    if($this->input->post('userid') !=''){
      //$this->db = $this->load->database('real',true);
      $tmp = $this->db->get_where('mari_member', array('m_id'=>$this->input->post('userid')))->row_array();
      $m_password = hash('sha256', $this->input->post('passwd'));
      if(!isset($tmp['m_id']) || $m_password != $tmp['m_password'] || (int)$tmp['m_level']< 4 ) {
        $this->load->view('adm_login');
        return;
      }
      //$token['iat'] = $date->getTimestamp();
      $token['id'] = $tmp['m_id'];
      $token['exp'] = $this->nowdate->getTimestamp() + 86400*10;
      setcookie('api', JWT::encode($token,'myAFKey132423'), time() + 86400*10,'/',$_SERVER['SERVER_NAME']);
      ?>
        <script>
          location.replace('/api/index.php/adm');
        </script>
      <?php
    }else {
      $this->load->view('adm_login');
      return;
    }
	}
  function layout() {
    $this->load->view('aligo');
  }
  function sendsms(){
    $this->load->library('form_validation');

    $this->form_validation->set_rules('sendtype', 'sendtype', 'required');
    $this->form_validation->set_rules('msg', 'msg', 'required|xss_clean');
    $this->form_validation->set_rules('receipt', 'receipt', 'required');

    if ($this->form_validation->run() == FALSE)
    {
      echo json_encode(array("result_code"=>"FALSE", "message"=>"데이터를 확인해주세요")); return;
    }

    $sendtype = $this->input->post('sendtype');
    $smsmsg = $this->input->post('msg');
    $receipt =$this->input->post('receipt');
    $loanid = $this->input->post('loanid');
    $phonenum = $this->input->post('phonenum');
    $confirm = $this->input->post('confirm');
    //개별보내기
    if( $sendtype =='adddata' || $sendtype =='person' ) {
      $phonelist = $this->conv_phone( preg_split('/\r\n|[\r\n]/', $_POST['phonenum']) );
      if( $phonelist == false ) {echo json_encode(array("result_code"=>"FALSE", "message"=>"받는 전화번호 리스트를 확인해주세요")); return;}
      $msg = "받는전화번호에 기록된 " . $phonelist['total'] . " 명에게 " . count($phonelist['data']) . " 번에 걸쳐 발송";
    }
    //일반회원
    else if( $sendtype =='generalperson' ) {
      $this->db->select ('trimed_hp')->where('grptype', 'N');
      if($receipt == 'Y') {
        $this->db->where('sb_receipt', '1');
      }
      $this->db->where('ismem', 'Y');
      $rows = $this->db->get('view_sms_grouping')->result_array();
      if (count($rows)<1) {
        echo json_encode(array("result_code"=>"FALSE", "message"=>"그룹목록으로 검색이 불가능합니다.")); return;
      }
      $phonelist = $this->conv_phone( $rows,"trimed_hp" );
      if( $phonelist == false ) { echo json_encode(array("result_code"=>"FALSE", "message"=>"받는 전화번호 그룹을 확인해주세요")); return; }
      $msg = "일반회원 [" . (  $receipt == 'Y' ? '동의회원':'전체회원' ) . "] " . $phonelist['total'] . " 명에게 " . count($phonelist['data']) ." 번에 걸쳐 발송";
    }
    // 투자회원
    else if( $sendtype =='tujaperson' ) {
      $this->db->select ('trimed_hp')->where('grptype', 'I');
      if($receipt == 'Y') {
        $this->db->where('sb_receipt', '1');
      }
      $this->db->where('ismem', 'Y');
      $rows = $this->db->get('view_sms_grouping')->result_array();
      if (count($rows)<1) {
        echo json_encode(array("result_code"=>"FALSE", "message"=>"그룹목록으로 검색이 불가능합니다.")); return;
      }
      $phonelist = $this->conv_phone( $rows,"trimed_hp" );
      if( $phonelist == false ) { echo json_encode(array("result_code"=>"FALSE", "message"=>"받는 전화번호 그룹을 확인해주세요")); return; }
      $msg = "투자회원 [" . (  $receipt == 'Y' ? '동의회원':'전체회원' ) . "] " . $phonelist['total'] . " 명에게 " . count($phonelist['data']) . " 번에 걸쳐 발송";
    }
    // 대출회원
    else if( $sendtype =='loanperson' ) {
      $this->db->select ('trimed_hp')->where('grptype', 'L');
      if($receipt == 'Y') {
        $this->db->where('sb_receipt', '1');
      }
      $this->db->where('ismem', 'Y');
      $rows = $this->db->get('view_sms_grouping')->result_array();
      if (count($rows)<1) {
        echo json_encode(array("result_code"=>"FALSE", "message"=>"그룹목록으로 검색이 불가능합니다.")); return;
      }
      $phonelist = $this->conv_phone( $rows,"trimed_hp" );
      if( $phonelist == false ) { echo json_encode(array("result_code"=>"FALSE", "message"=>"받는 전화번호 그룹을 확인해주세요")); return; }
      $msg = "대출회원 [" . (  $receipt == 'Y' ? '동의회원':'전체회원' ) . "] " . $phonelist['total'] . " 명에게 " . count($phonelist['data']) . " 번에 걸쳐 발송";
    }else if($sendtype=="loan"){
      if($receipt == 'Y') {
        $sql = "select replace(replace(`mari_smsbook`.`sb_hp`,' ',''),'-','') AS `trimed_hp`
              from mari_invest
              join mari_smsbook on mari_invest.m_id = mari_smsbook.m_id
              left join mari_member on mari_invest.m_id = mari_member.m_id
              where mari_invest.loan_id = ?
              and sb_receipt = 1
              and mari_member.m_id is not null";
      }else {
        $sql = "
              select replace(replace(`mari_smsbook`.`sb_hp`,' ',''),'-','') AS `trimed_hp`
              from mari_invest
              join mari_smsbook on mari_invest.m_id = mari_smsbook.m_id
              left join mari_member on mari_invest.m_id = mari_member.m_id
              where mari_invest.loan_id = ?
              and mari_member.m_id is not null";
      }
      $rows = $this->db->query($sql , array((int)$loanid)) ->result_array();

      if (count($rows)<1) {
        echo json_encode(array("result_code"=>"FALSE", "message"=>"그룹목록으로 검색이 불가능합니다.")); return;
      }
      $phonelist = $this->conv_phone( $rows,"trimed_hp" );
      if( $phonelist == false ) { echo json_encode(array("result_code"=>"FALSE", "MSG"=>"받는 전화번호 그룹을 확인해주세요")); return; }
      $loaninfo = $this->db->select ('i_subject')->get_where('mari_loan', array('i_id'=>$loanid) )->row_array();

      $msg = $loaninfo['i_subject']. " 에투자한 [" . (  $receipt == 'Y' ? '동의회원':'전체회원' ) . "] " . $phonelist['total'] . " 명에게 " . count($phonelist['data']) . " 번에 걸쳐 발송";

    }else {
      echo json_encode(array("result_code"=>"FALSE", "message"=>"불가능한 타입입니다.")); return;
    }
    /* 컨펌 받은 후 발송 진행 */
    if($confirm != 'Y') {
      echo json_encode(array("result_code"=>1, "message"=>$msg."하시겠습니까?", 'data'=>$phonelist)); return;
    }
    /* 컨펌 받은 후 발송 진행 */
    $sendidxdata = array();
    $smsdata = array("title"=>$msg, "smsmsg"=>$smsmsg);
    if( $this->db->insert('z_sms_log', $smsdata) ) {
      $sms_idx = $this->db->insert_id();
      foreach ($phonelist['data'] as $idx=>$row){
        $smsdata = array('fk_sms_idx'=>$sms_idx, 'cnt'=>$row['cnt'], 'phonenum'=>$row['data']);
        $this->db->insert('z_sms_send_log', $smsdata);
        $sendidxdata[] = $this->db->insert_id();
      }
      $this->sendprc($sms_idx);
    }else {
      echo json_encode(array("result_code"=>"FALSE", "message"=>"발송 오류(DB)로 인해 발송되지 않았습니다.")); return;
    }
  }
  function sendprc($sendidxs){
    if( $sendidxs < 1 ) {
      return;
    }
    $sql = "
      select send_idx, smsmsg as msg, phonenum as receiver
      from z_sms_log
      join z_sms_send_log on z_sms_log.sms_idx = z_sms_send_log.fk_sms_idx
      where
      z_sms_log.sms_idx = ?
      and z_sms_send_log.send_status ='N'
    ";
    $rows = $this->db->query($sql, array($sendidxs))->result_array();

    $totalgrpnum = count($rows);
    $sendgroupnum =$errorgroupnum= 0;

    foreach( $rows as $row){
      $post = array_merge($this->sms, $row);
      $sendres = $this->sendsmscurl($post);
      if( $sendres->result_code == 1){
        $sendgroupnum ++;
        $this->db->set('send_status', 'Y')->where('send_idx', $row['send_idx'])->update('z_sms_send_log');
      }else {
        $errorgroupnum ++;
      }
    }
    if($totalgrpnum == $sendgroupnum) echo json_encode(array("result_code"=>1, "message"=> "발송에 성공하였습니다.") );
    else echo json_encode(array("result_code"=>"FALSE", "message"=> $totalgrpnum."번의 발송중 ".$errorgroupnum." 번의 발송이 실패했습니다." ) );
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
  function conv_phone($arr,$col=''){
    $splitno = $this->limit;
    $res = $ret =$tmp= array();
    $total = 0;
    $indexno = 0;
    foreach ($arr as $idx=>$val){
      if( $indexno >= $splitno ) {
        if(count($tmp)>0 ) $ret[] = $tmp;
        $tmp = array();
        $indexno = 0;
      }
      if($col=='') $num = preg_replace("/[^0-9]*/s", "", $val);
      else $num = preg_replace("/[^0-9]*/s", "", $val[$col]);
      if(trim($num) != '' && strlen($num)>=10 && strlen($num) < 12 && $num[0] =="0"){
        $tmp[] = trim($num);
        $indexno++;
      }
    }
    if( count($tmp) > 0)   $ret[] = $tmp;
    if( count($ret) >0 ){
      foreach ($ret as $idx=>$arr) {
        $res['data'][$idx]['data'] = implode(',', $arr);
        $res['data'][$idx]['cnt'] = count($arr);
        $total += count($arr);
      }
    }else return false;
    $res['total'] = $total;
    return $res;
  }
  /* 문자 남은 갯수 */
  function remain() {
    $sms_url = "https://apis.aligo.in/remain/";

    $oCurl = curl_init();
    curl_setopt($oCurl, CURLOPT_PORT, 443);
    curl_setopt($oCurl, CURLOPT_URL, $sms_url);
    curl_setopt($oCurl, CURLOPT_POST, 1);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS, $this->sms);
    curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
    $ret = curl_exec($oCurl);
    curl_close($oCurl);
    echo $ret;
    /*
    $res = json_decode($ret); // 결과배열
    if( $res['result_code'] == 1) echo $ret;
    */
  }
  function smslist() {
    $sms_url = "https://apis.aligo.in/list/"; // 전송요청 URL
    $sms['page'] = ($this->input->get("page") > 0 ) ? $this->input->get("page") : "1" ;				//조회 시작번호1
    $sms['page_size'] = "20" ;	//출력 갯수
    $sms['start_date'] = "" ;		//조회일 시작
    $sms['limit_day'] = "7" ;		//조회일수
    $sms = array_merge($sms, $this->sms);
    $oCurl = curl_init();
    curl_setopt($oCurl, CURLOPT_PORT, 443);
    curl_setopt($oCurl, CURLOPT_URL, $sms_url);
    curl_setopt($oCurl, CURLOPT_POST, 1);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS, $sms);
    curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
    $ret = curl_exec($oCurl);
    curl_close($oCurl);
    $ret = json_decode($ret);
    foreach ($ret->list as &$row) {
      $row->msg = htmlspecialchars($row->msg,ENT_QUOTES);
      $row->msg = nl2br($row->msg);
    }
    echo json_encode($ret);
  }
  function smsdetail() {
    $this->load->view("aligo_smsdetail");
    return;
  }
  function smsdetailsrc() {
    $sms_url = "https://apis.aligo.in/sms_list/"; // 전송요청 URL
    $sms['mid'] = $this->input->get("smsidx") ;				//조회 시작번호1
    if( $sms['mid'] == "") {return;}
    $sms['page'] = "0" ;//조회 시작번호1
    $sms['page_size'] = "500" ;//출력 갯수
    $sms = array_merge($sms, $this->sms);
    $oCurl = curl_init();
    curl_setopt($oCurl, CURLOPT_PORT, 443);
    curl_setopt($oCurl, CURLOPT_URL, $sms_url);
    curl_setopt($oCurl, CURLOPT_POST, 1);
    curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($oCurl, CURLOPT_POSTFIELDS, $sms);
    curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
    $ret = curl_exec($oCurl);
    curl_close($oCurl);
    $tmp = json_decode($ret,true);
    $data = array();
    foreach ($tmp['list'] as $row){
      $tmp2=array();
      foreach ($row as $idx=>$val){
        if( in_array($idx, array('type', 'receiver', 'sms_state'))  )$tmp2[] = $val;
      }
      $data[] = $tmp2;
    }
//var_dump($data);
echo json_encode(array("data"=>$data));
    //echo json_encode(array("data"=>$tmp['list']));
  }
  function user() {
    $search = $this->input->get('search');
    $sql = "
    select a.m_id, a.m_name, replace(replace(`b`.`sb_hp`,' ',''),'-','') AS `trimed_hp` , b.sb_receipt
    from mari_member a
    join mari_smsbook b on a.m_id = b.m_id
    where a.m_id like ? or a.m_name like ? or b.sb_hp like ?;
    ";
    $rows = $this->db->query($sql, array('%'.$search.'%','%'.$search.'%','%'.$search.'%'))->result_array();
    echo json_encode( array("result_code"=> ( count($rows)>0 )? 1 : 'none', "list"=>$rows ) );
  }
  function loan() {
    $search = $this->input->get('search');
    $sql = "
    select a.i_id, a.i_subject from mari_loan a
    where a.i_id like ? or a.i_subject like ?
    order by i_id
    ";
    $rows = $this->db->query($sql, array('%'.$search.'%','%'.$search.'%'))->result_array();
    echo json_encode( array("result_code"=> ( count($rows)>0 )? 1 : 'none', "list"=>$rows ) );
  }
}
