<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . 'controllers/adm.php';
class Eventcheck extends Adm {
  function index(){
      $list = $this->db->order_by('eventid', 'desc')->get('z_event_check_cfg')->result_array();
      $reserv_template = explode('@@val=', $this->load->view('adm_header_reserv_template', array("reservlist"=>$this->basic->reservlist()), true) );
      $this->load->view('adm_header', array("errmsglist"=>$this->jungsanerrorlist(), "reservtemplate"=>$reserv_template ));
      $this->load->view('adm_eventcheck', array('list'=>$list));
      //$this->load->view('adm_footer');//$this->load->view('adm_footer',array('js'=>''));
    }
    function savecfg() {
      $eventid = ((int)$this->input->post('eventid')>0) ? (int)$this->input->post('eventid') : 0;
      $data = array();
      if (!$this->valid_date ($this->input->post('startdate') )){
        echo json_encode(array('code'=>500, 'msg'=>'시작일을 확인해주세요'));return;
      }else $data['startdate'] = $this->input->post('startdate');
      $data['title'] = $this->input->post('title')=='' ? $this->nowdate->format('Ymd')."_event": $this->input->post('title');
      $data['charge'] = (int)$this->input->post('charge');
      $data['condition1'] = $this->input->post('condition1');
      $data['condition2'] = $this->input->post('condition2');
      $data['condition3'] = $this->input->post('condition3');
      $data['condition4'] = $this->input->post('condition4');
      if( $eventid == 0 ){
        $isnew = true;
        $this->db->insert('z_event_check_cfg', $data);
        $eventid = $this->db->insert_id();
      }else {
        $isnew = false;
        $this->db->where('eventid', $eventid)->update('z_event_check_cfg', $data);
      }
      $this->getcfg($eventid, $isnew);
    }
    public function getcfg($eventid=0, $isnew=false){
      $eventid  = ($eventid == 0 && (int)$this->input->get('eventid') > 0 ) ? (int)$this->input->get('eventid') : $eventid;
      $ret = array();
      $ret['code']= 200;
      $ret['eventid'] = (string)$eventid;
      $ret['isnew'] = $isnew;
      $ret['cfg'] = $this->db->get_where('z_event_check_cfg', array('eventid'=>$eventid))->row_array();
      $ret['cfglist'] = $this->db->order_by('eventid', 'desc')->get('z_event_check_cfg')->result_array();
      echo json_encode($ret);
    }

    public function getlist() {
      $eventid = $this->input->get('eventid');
      $eventcfg = $this->db->get_where('z_event_check_cfg', array('eventid'=>$eventid))->row_array();
      $sql = "
      select *
      from mari_member a
      left join z_event_list b on b.eventid = ? and a.m_no = b.mem_no
      where a.m_datetime >= ?
      and m_emoney >= ?
      and b.eventlist_idx is null
      order by m_no
      ";
      $list = $this->db->query($sql, array($eventid, $eventcfg['startdate'], $eventcfg['charge']) )->result_array();
      foreach( $list as $row){
        $temp = $this->db->order_by('p_id', 'asc')->get_where('mari_emoney', array('m_id'=>$row['m_id'],'p_content'=>'E-머니 가상계좌 결제 충전') )->result_array();
        foreach( $temp as $emoney){
          if( $emoney['p_top_emoney'] >= $eventcfg['charge']){
            $set = array('eventid'=>$eventid, 'mem_no'=>$row['m_no'], 'basedate'=>$emoney['p_datetime']);
            $this->db->insert('z_event_list', $set);
            break;
          }
        }
      }
      $sql = "
      select *
      from mari_member a
      left join z_event_list b on b.eventid = ? and a.m_no = b.mem_no
      where a.m_datetime >= ?
      and m_emoney >= ?
      order by m_no
      ";
      $list = $this->db->query($sql, array($eventid, $eventcfg['startdate'], $eventcfg['charge']) )->result_array();
      echo json_encode(array('code'=>200, 'cfg'=>$eventcfg, 'data'=>$list));
    }
    public function savetype() {
      $info = $this->db->get_where('z_event_list', array('eventid'=>$this->input->post('eventid'), 'mem_no'=>$this->input->post('m_no')) )->row_array();
      if( !isset($info['eventlist_idx'])){
        echo json_encode(array('code'=>404, "msg"=>"변경할 데이터를 찾을 수 없습니다."));return;
      }
      if($info[$this->input->post('savetype')] != 'N'){
        echo json_encode(array('code'=>200, "msg"=>"이미 체크되어있는 데이터입니다.", "changedate"=>$info[$this->input->post('savetype')."_date"]));return;
      }
      $datetime = $this->nowdate->format('Y-m-d H:i:s');
      $this->db->where('eventlist_idx', $info['eventlist_idx'])->update('z_event_list', array($this->input->post('savetype')=>'Y', $this->input->post('savetype')."_date"=>$datetime) );
      echo json_encode(array('code'=>200, "msg"=>"", "changedate"=>$datetime));return;
    }
    public function valid_date($date)
    {
        $d = DateTime::createFromFormat('Y-m-d', $date);
        return $d && $d->format('Y-m-d') === $date;
    }
}
