<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
class  Design extends Adm {

  public function _remap($method) {
    $this->{$method}();
  }

	public function index()
	{
		;
	}

  public function main() {
    $sql = "
    insert IGNORE into z_safetyguide_log
    		select susuryo.loan_id,'수수료' as safety_type, susuryo.o_count, susuryo.safety, b.acceptance_date as safetydate from
    		(select a.loan_id,a.o_count,a.history_idx, sum(a.susuryoPayed) as safety from z_invest_sunap_detail a group by a.loan_id, a.history_idx) susuryo
    		join z_invest_sunap b on susuryo.history_idx = b.idx
    		union all
    		select
    			b.loan_id,'투자' as safety_type, 0 as o_count
    			,floor(sum(b.i_pay)/1000*3) as safety, date_format(i_regdatetime, '%Y-%m-%d') as safetydate
    		from
    			(select loan_id from mari_invest_progress a where loan_id > 11 and i_view ='Y' and i_look in('D','F')) loan
    		join mari_invest b on loan.loan_id = b.loan_id
    		group by b.loan_id
     ;
    ";
    $this->db->query($sql);
    $sql = "
    select
    	a.*, b.i_invest_name
    from z_safetyguide_log a
    join mari_invest_progress b on a.loan_id = b.loan_id
    order by a.safetydate
    ";
    $history = $this->db->query($sql)->result_array();
      $this->load->view('cfg_maindesign.php', array("history"=>$history,"data"=> $this->db->get_where('z_main_design', array('idx'=> 1) )->row_array() ));
  }
  public function safetyimage() {
    $config['upload_path'] = "../pnpinvest/data/safetyplan";
    if (!is_dir($config['upload_path'])) {
        mkdir($config['upload_path'], 0777, TRUE);
    }
    $config['allowed_types'] = 'gif|jpg|png|pdf|jpeg|doc';
    $config['remove_spaces'] = TRUE;
    $config['encrypt_name'] = TRUE;

    $this->load->library('upload', $config);
    $files = array();
    if ( ! $this->upload->do_upload())
    {
      $data =  $this->upload->data() ;
      $data['error'] = $this->upload->display_errors('','');
      $data['file_name']=$_FILES['userfile']['name'];
      $files['files'][] =$data;
    }
    else
    {
      $data =  $this->upload->data() ;
      date_default_timezone_set('Asia/Seoul');
      $this->db->where('idx', '1')->update('safety_plan', array('img'=>$data['file_name']));
      $data['last']= $this->db->last_query();
      $data['error']='';
      //$data['fileid'] = $this->db->insert_id();
      $files['files'][] = $data;
    }
      echo json_encode($files);return;

  }

}
