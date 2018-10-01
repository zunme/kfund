<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Timer extends CI_Controller {
  function now() {
      $loan_id = $this->uri->segment(3, 0);

      $sql = "set time_zone = '+9:00'";
      $this->db->query($sql);
      $sql = "update mari_invest_progress set i_look = 'Y' where   i_look ='N'  and i_view='Y'  and i_invest_sday <= now()";
      $this->db->query($sql);
      /*자동마감 block
      $sql = "update mari_invest_progress set i_look = 'C' where  i_look ='Y' and i_view='Y' and i_invest_eday <= now()";
      $this->db->query($sql);
      */
      $data = $this->db->select('loan_id,i_look,i_invest_sday,i_invest_eday ')->get_where('mari_invest_progress', array("loan_id"=>$loan_id))->row_array();
      //date_default_timezone_set('Asia/Seoul');
      date_default_timezone_set('Asia/Seoul');
      $dt = new DateTime($data['i_invest_sday'], new DateTimeZone('Asia/Seoul'));
      $now = new DateTime();
      $now->setTimezone(new DateTimeZone('Asia/Seoul'));
      $delta = $dt->diff($now);
      $s_seconds = ($delta->s) + ($delta->i * 60) + ($delta->h * 60 * 60)  + ($delta->d * 60 * 60 * 24) + ($delta->m * 60 * 60 * 24 * 30) + ($delta->y * 60 * 60 * 24 * 365);
      $dt2 = new DateTime($data['i_invest_eday'], new DateTimeZone('Asia/Seoul'));
      $delta = $dt2->diff($now);
      $e_seconds = ($delta->s) + ($delta->i * 60) + ($delta->h * 60 * 60)  + ($delta->d * 60 * 60 * 24) + ($delta->m * 60 * 60 * 24 * 30) + ($delta->y * 60 * 60 * 24 * 365);
      //look N 대기, Y 시작, C 마감, D상환, F 상환완료
      switch ( $data['i_look'] ) {
        /* 마감시간 blcok
        case ('Y') :
          $status = "end"; // 후 마감
          break;
        */
        case ('N') :
          if($dt > $now) $status = "start"; // 후 시작
          else if ( $dt2 > $now )  $status = "end" ;
          else  $status = "drop";
          break;
        default :
          $status = "drop";
      }
      $data = array(
        "loan_id"=>$loan_id,
        "now"=>$now->format('Y-m-d H:i:s'),
        "stime"=> $data['i_invest_sday'],
        "etime"=> $dt2->format('Y-m-d H:i:s'),//$data['i_invest_eday'],
        "look"=>$data['i_look'],
        "status"=>$status,
        "s_seconds"=>$s_seconds,
        "e_seconds"=>$e_seconds
      );
      header('Content-Type: application/json');
  		echo json_encode( array("code"=>200, "data"=>$data) );
  }
  function index(){
    $this->load->view("timer");
  }
}
