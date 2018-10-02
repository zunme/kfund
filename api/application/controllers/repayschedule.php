<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
date_default_timezone_set('Asia/Seoul');
class repayschedule extends CI_Controller {
  function index() {

    $this->load->view('repayschedule');
  }
  function getlist() {
    $this->load->driver('cache', array('adapter' => 'file'));
    if ( ! $foo_repayschedule = $this->cache->get('foo_repayschedule'))
    {
      $sql = "
      select
     date_format(a.repaydate,'%Y-%m-%d') as `date`
    #	,regexp_substr(i.i_invest_name, '제(.*?)호') as title
    	,(i.i_invest_name) as body
    	, a.* , b.regdate
    from z_repay_schedule a
    join mari_invest_progress i on a.loanid = i.loan_id and i.i_look = 'D'
    left join z_invest_sunap b on a.loanid = b.loan_id and a.cnt = b.o_count
    # where a.repaydate >= '".$this->input->get('year').'-'.sprintf('%2d',(int)$this->input->get('month')).'-01'."'
    # and a.repaydate <= '".$this->input->get('year').'-'.sprintf('%2d',(int)$this->input->get('month')).'-31'."'
    order by repaydate
      ";
      $list = $this->db->query($sql)->result_array();
      $tmp= $data = array();
      foreach ( $list as $row ) {
        $tmp[$row['date']] .= ( $row['regdate']  != '' ? "<p class='repayed'>[완료]":"<p class='repay_ready'>[예정]").$row["body"]."</p>";
      }
      foreach ($tmp as $idx=>$row){
        $data[] = array("date"=>$this->holiday($idx), "badge"=>true, "title"=>$idx." 정산일정","body"=> $row,"footer"=>"","classname"=>"purple-event");
      }
      $foo_repayschedule=json_encode($data);
      $this->cache->save('foo_repayschedule', $foo_repayschedule, 300);
      echo $foo_repayschedule;
    }else {
      echo $foo_repayschedule;
    }
  }
  function holiday($date){
    $strtotime = strtotime($date);
    $w = date('w',  $strtotime );
    if(  $w == '0' || $w == '6') {
      return $this->holiday( date('Y-m-d', strtotime("+1 day", $strtotime )) );
    }else return $date;
  }
}
