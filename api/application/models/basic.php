<?php
class basic extends CI_Model {
  //level list
  function levellist(){
    $data = array(
      'level_morethan_2'=>'법인회원'
      ,'N'=>'일반일반개인투자자'
      ,'L'=>'대출회원'
      ,'I'=>'소득적격투자자'
      ,'P'=>'전문투자자'
      ,'L2'=>'개인대부사업자투자자'
      ,'C2'=>'법인대부사업자투자자'
      ,'I2'=>'소득적격대부업자투자자'
    );
    return $data;
  }
  function reservlist($lastidx=0){
    $where = ((int)$lastidx > 0) ? " idx > ".(int)$lastidx." and " : '';
    return $this->db->query('select * from mari_member_log where '.$where.' reserv >= curdate() order by reserv desc')->result_array();
  }
  function reservcode() {
    return array("L000"=>"일반기록", "L001"=>"일반기록","R001"=>"시간예약","R002"=>"ToDo","C001"=>"level변경","C002"=>"비밀번호변경","C003"=>"회원인증","C004"=>"회원인증취소");
  }
  function insertmemberlog($data, $idno=0){
    if($idno > 0 ) {
      $mem = $this->mem_baseinfo_by_no($idno);
      $data['m_id'] = $mem['m_id'];
    }
    $this->db->insert('mari_member_log', $data);
  }
  function logtitle($code,$reserv){
    $reservcode = $this->reservcode();
    switch($code){
      case ('L000'):
      case ('L001'):
        $title ='';
      break;
      case('R001'):
      case('R002'):
        $title = (trim($reserv) !='') ? $reserv : $reservcode[$code];
        break;
      default :
        $title = $reservcode[$code];
    }
    return $title;
  }

  function mem_baseinfo($memid){
    $mem = $this->db->get_where('mari_member', array('m_id'=>$memid))->row_array();
    if(!isset($mem['m_id'])) return false;
    else return $mem;
  }
  function mem_baseinfo_by_no($memid){
    $mem = $this->db->get_where('mari_member', array('m_no'=>$memid))->row_array();
    if(!isset($mem['m_id'])) return false;
    else return $mem;
  }
  function changepassword($memid, $newpassword) {
    $sha = hash('sha256', $newpassword);
    if(!$meminfo = $this->mem_baseinfo($memid)) return false;
    $data['m_id'] = $memid;$data['code'] = 'C002';$data['msg'] = "ORG:".$meminfo['m_password'];$data['writer'] = $this->login->id;
    if( $this->db->where('m_id',$memid)->set('m_password',$sha)->update('mari_member') ) {
        $this->db->insert('mari_member_log', $data);
        return true;
    }else return false;
  }
  //동일차주 제외 리스트
  function parentloanlist() {
    $sql = "select a.*
      from mari_loan a
      left join mari_loan_same_owner b on a.i_id = b.loan_id
      where a.i_view ='Y' and b.loan_id is null
      order by i_id desc";
      return $this->db->query($sql)->result_array();
  }
}
