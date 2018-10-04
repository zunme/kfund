<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Copyloan extends CI_Controller {

	public function _remap($method) {
		if ( ! session_id() ) @ session_start();
		if( !isset($_SESSION['ss_m_id'] ) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"로그인후 사용해주세요") );
		}
		$query = $this->db->query('SELECT * FROM mari_authority where m_id = ? ', array($_SESSION['ss_m_id']) );
		if ( $query->num_rows() < 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
  public function index() {
    $data = $this->db->get_where('mari_loan', array('i_id'=>$this->input->get('i_id') ))->row_array();
    $this->load->view('copyloan', array('data'=>$data) );
  }
	public function copy()
	{
    $loanid=$this->input->post('i_id');
    $title = $this->input->post('i_subject');
    $loan_pay = $this->input->post('i_loan_pay');

		$col = $this->db->query("SHOW COLUMNS FROM mari_loan")->result_array();
    $cols = array();
    $exceptarr = array('i_id','i_subject' ,'i_loan_pay','i_view', 'i_look','i_regdatetime','i_invest_eday', 'i_loanexecutiondate','i_pendingsf_use','i_loanapproval' );
    foreach ($col as $row){
      if( !in_array($row['Field'], $exceptarr) ){
        $cols[] = $row['Field'];
      }
    }

    $sql = "
    insert into mari_loan (".  implode(',', array_merge( $exceptarr, $cols )).")
    select
    0 as i_id, ? as i_subject, ? as i_loan_pay, 'N' as i_view, 'N' as i_look, now() as i_regdatetime, '' as i_invest_eday, '' as i_loanexecutiondate
    , 'N' as i_pendingsf_use, 'N' as i_loanapproval, ".implode(',' , $cols)." from mari_loan where i_id = ".$loanid;
    //$sql = $this->db->select( $cols )->where('i_id', $loanid)->get_compiled_select('mari_loan');
    $this->db->query($sql, array($title, $loan_pay ));
    $newloanid = $this->db->insert_id();

    $col = $this->db->query("SHOW COLUMNS FROM mari_invest_progress")->result_array();
    $cols = array();
    $exceptarr = array('i_id','loan_id', 'i_invest_name','i_invest_pay', 'i_look', 'i_view', 'i_invest_sday', 'i_invest_eday','i_regdatetime', 'i_modidatetime', 'i_repay_plan','i_invest_endtime');
    foreach ($col as $row){
      if( !in_array($row['Field'], $exceptarr) ){
        $cols[] = $row['Field'];
      }
    }
    $sql = "
    insert into mari_invest_progress (".  implode(',', array_merge( $exceptarr, $cols )).")
    select
      0 as i_id, $newloanid as loan_id , ? as i_invest_name ,? as i_invest_pay, 'N' as i_view, 'N' as i_look
      , now() as i_invest_sday, now() as i_invest_eday, now() as i_regdatetime,now() as i_modidatetime
      , '' as i_replay_plan, '' as i_invest_endtime, "
      .implode(',' , $cols)." from mari_invest_progress where loan_id = ".$loanid;
    $this->db->query($sql, array($title, $loan_pay ));
    $new_progress_id = $this->db->insert_id();

    $col = $this->db->query("SHOW COLUMNS FROM mari_loan_ext")->result_array();
    $cols = array();
    $exceptarr = array('fk_mari_loan_id','i_reimbursement_date', 'default_profit');
    foreach ($col as $row){
      if( !in_array($row['Field'], $exceptarr) ){
        $cols[] = $row['Field'];
      }
    }
    $sql = "
    insert into mari_loan_ext ( fk_mari_loan_id, ".implode(',' , $cols).")
    select  ".$newloanid ." as fk_mari_loan_id , ".implode(',' , $cols)." from mari_loan_ext where fk_mari_loan_id = ".$loanid;
    $this->db->query($sql);

    $sql = "
    insert into mari_loan_same_owner
    select  ? as loan_id , ifnull(parents_loan_id, ? ) as  parents_loan_id from mari_loan_same_owner where loan_id = ?
    ";
    $this->db->query($sql, array($newloanid, $loanid, $loanid) );

    $this->copymainimg($loanid, $new_progress_id);
    $this->copyfiles($loanid, $new_progress_id);
    echo "<script>parent.document.location.reload();</script>";
	}
  //메인이미지 카피
  function copymainimg( $oldloanid=12, $new_progress_id=14) {
    $prg = $this->db->get_where( 'mari_invest_progress', array('i_id'=> $new_progress_id) )->row_array();
    if ($prg['i_creditratingviews'] !='' ){
      mkdir("../pnpinvest/data/photoreviewers/".$prg['loan_id']);
      $res = copy("../pnpinvest/data/photoreviewers/".$oldloanid."/".$prg['i_creditratingviews'], "../pnpinvest/data/photoreviewers/".$prg['loan_id']."/".$prg['i_creditratingviews']);
    }
  }
  //첨부파일 카피
  function copyfiles( $oldloanid=12, $new_progress_id=14) {
    $prg = $this->db->get_where( 'mari_invest_progress', array('i_id'=> $new_progress_id) )->row_array();
    $sql = "
    insert into mari_invest_file (loan_id,sortnum ,file_name,file_regidate)
    select ".$prg['loan_id'].", sortnum, file_name, file_regidate from mari_invest_file where loan_id = ".$oldloanid;
    $this->db->query($sql);
    $sql = "
     insert into z_gallery (loanid, gtype, order_no, client_name, file_name)
      select ".$prg['loan_id']." as loanid, gtype, order_no, client_name, file_name
      from z_gallery where loanid = ".$oldloanid;
    $this->db->query($sql);
    $this->xcopy( "../pnpinvest/data/file/".$oldloanid, "../pnpinvest/data/file/".$prg['loan_id']);
  }


  private function xcopy($source, $dest, $permissions = 0755)
  {
    if (is_link($source)) {
        return symlink(readlink($source), $dest);
    }
    if (is_file($source)) {
        return copy($source, $dest);
    }
    if (!is_dir($dest)) {
        mkdir($dest, $permissions);
    }
    $dir = dir($source);
    while (false !== $entry = $dir->read()) {
        // Skip pointers
        if ($entry == '.' || $entry == '..') {
            continue;
        }
        $this->xcopy("$source/$entry", "$dest/$entry", $permissions);
    }
    $dir->close();
    return true;
  }
}
