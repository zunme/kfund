<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
ini_set("display_errors", 1);
class Cmsloanlist extends CI_Controller {

	public function _remap($method) {
		if ( ! session_id() ) @ session_start();
		if( !isset($_SESSION['ss_m_id'] ) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"로그인후 사용해주세요") );
		}
		$query = $this->db->query('SELECT * FROM mari_authority where m_id = ? ', array($_SESSION['ss_m_id']) );
		if ( $query->num_rows() < 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		$row = $query->row_array();
		if( !isset($row['au_id']) ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		if($row['au_loan'] != 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
	public function index()
	{
		;
	}
	public function getreimbursement() {
		$loan_id = (int)$this->input->get('loanid');
		if($loan_id < 1 ){
			$this->json(array('code'=>'ERROR', 'msg'=>"loan id need") );return;
		}
		$sql = "select a.i_reimbursement_date from mari_loan_ext a where a.fk_mari_loan_id = ?";
		$info = $this->db->query($sql, array($loan_id))->row_array();
		if(!isset($info['i_reimbursement_date'])) $info['i_reimbursement_date'] ='0000-00-00';
		$this->json( array('code'=>'OK', 'data'=>$info) );
	}
	public function postreimbursement() {
		$loan_id = (int)$this->input->post('loanid');
		$date = trim($this->input->post('reimbursement'));

		if($loan_id < 1 ){
			$this->json(array('code'=>'ERROR', 'msg'=>"loan id need") );return;
		}
		if (!$this->valid_date($date) )	{
			$this->json(array('code'=>'ERROR', 'msg'=>"날짜형식이 다르거나 올바르지 않은 날짜 입니다.") );return;
		}
		$data = array('loan_id'=>$loan_id, 'date'=>$date);
		$sql = "select
		      date_format(a.i_loanexecutiondate,'%Y-%m-%d') i_loanexecutiondate,
		      b.i_reimbursement_date, fk_mari_loan_id
		    from mari_loan a
		    left join mari_loan_ext b on a.i_id = b.fk_mari_loan_id
		    where a.i_id = ? ";
		$row = $this->db->query($sql, array($loan_id) )->row_array();
		$start =  strtotime($row['i_loanexecutiondate']);
		$end = strtotime($date);

		if( $start >= $end ){
			$this->json(array('code'=>'ERROR', 'msg'=>"대출만기일이 실행일보다 작습니다.",'data'=>$data) );return;
		}

		//if($row['i_reimbursement_date']==''){
		if((int)$row['fk_mari_loan_id'] > 0 ){
			$this->db->where('fk_mari_loan_id', $loan_id);
      $this->db->update('mari_loan_ext', array('i_reimbursement_date'=>$date) );
		}else {
			$this->db->insert('mari_loan_ext', array('fk_mari_loan_id'=>$loan_id, 'i_reimbursement_date'=>$date) );
		}
		$this->json(array('code'=>'OK', 'msg'=>"test",'data'=>$data) );return;
	}
	protected function valid_date($date){
		$d = DateTime::createFromFormat('Y-m-d', $date);
		return $d && $d->format('Y-m-d') === $date;
	}
	public function getsameowner(){
    $loanid = (int)$this->input->get('lid');
    if($loanid < 1) $this->json(array('code'=>'ERROR', 'msg'=>"loan id") );
    $sql = "
      select tmp.*, pl.i_subject from
      (
      select b.loan_id loanid, b.parents_loan_id parentid, 'son' as stat from mari_loan_same_owner a join mari_loan_same_owner b on a.parents_loan_id = b.parents_loan_id where a.loan_id = ?
      union select c.parents_loan_id loanid, c.parents_loan_id parentid, 'parent' as stat from mari_loan_same_owner c where c.loan_id = ?
      union select d.loan_id loanid, d.parents_loan_id parentid , 'son' as stat from mari_loan_same_owner d where d.parents_loan_id = ?
      union (select e.parents_loan_id, parents_loan_id, 'parent' as stat  from mari_loan_same_owner e where parents_loan_id = ? limit 1)
      ) tmp
      join mari_loan pl on tmp.loanid = pl.i_id
      order by tmp.stat, loanid
    ";
    $qry = $this->db->query($sql, array($loanid,$loanid,$loanid,$loanid));
    $data['samedata'] = $qry->result_array();
    $sql = "
      select a.i_id, a.i_subject from
      mari_loan a
      left join mari_loan_same_owner b on a.i_id = b.loan_id
      where b.loan_id is null
      order by a.i_id desc
    ";
    $data['list'] = $this->db->query($sql, array($loanid,$loanid,$loanid,$loanid))->result_array();
    $this->load->view('getsameowner', $data);
  }
  public function changeowner(){
    $loanid = (int)$this->input->post('lid');
    $changeto =(int)$this->input->post('cid');
    $data = array('lid'=>$loanid, 'cid'=>$changeto);
		if($loanid==$changeto){
			$this->json(array('code'=>'ERROR','msg'=>'자신을 동일상품으로 묶을 수 없습니다.' ,'data'=>$data) );
			return;
		}
		$sql = "select count(1) cnt from mari_loan_same_owner where loan_id = ?";
		$ceck = $this->db->query($sql, array($loanid))->row_array();
		if($ceck['cnt']<1){
			$this->db->insert('mari_loan_same_owner', array('loan_id'=>$loanid, 'parents_loan_id'=>$changeto));
		}else {
			$this->db->where ('loan_id',$loanid)->update('mari_loan_same_owner', array('parents_loan_id'=>$changeto) );
		}
    $this->json(array('code'=>'OK', 'data'=>$data) );
  }
	public function viewover() {
		$loanid = (int)$this->input->get('loanid');
		$sql ="set @loanid = ".$loanid;
		$this->db->query($sql);
		$sql = "select a.parents_loan_id into @parentid from mari_loan_same_owner a where a.loan_id = @loanid limit 1;";
		$this->db->query($sql);
		$sql ="	select
					i_maximum_v, i_maximum,i_maximum_in,i_maximum_pro,i_maximum_personalloan,i_maximum_corporateloan,i_maximum_incomeloan
		  into 	@i_maximum_v, @i_maximum,@i_maximum_in ,@i_maximum_pro,@i_maximum_personalloan,@i_maximum_corporateloan,@i_maximum_incomeloan
		from mari_invest_progress iprg
		where iprg.loan_id = @loanid;";
		$this->db->query($sql);
		$sql = "
		select m_id, total, memlimit memlabel, if( tmplast.total>tmplast.memlimit, 'OVER','') over , isub
		from (
		 select mem.m_id, tmpjoin.total,
		 case
			 when (mem.m_level> 2) then @i_maximum_v
			 when (mem.m_signpurpose = 'I' ) then @i_maximum_in
			 when (mem.m_signpurpose = 'P' ) then @i_maximum_pro
			 when (mem.m_signpurpose = 'L2' ) then @i_maximum_personalloan
			 when (mem.m_signpurpose = 'C2' ) then @i_maximum_corporateloan
			 when (mem.m_signpurpose = 'I2' ) then @i_maximum_incomeloan
			 else @i_maximum
		 end
		 as memlimit,
		 case
			 when (mem.m_level> 2) then '법인'
			 when (mem.m_signpurpose = 'I' ) then '소득적격'
			 when (mem.m_signpurpose = 'P' ) then '전문'
			 when (mem.m_signpurpose = 'L2' ) then '개인대부'
			 when (mem.m_signpurpose = 'C2' ) then '법인대부'
			 when (mem.m_signpurpose = 'I2' ) then '소득적격대부'
			 else '일반'
		 end
		 as memlabel, isub
		 from mari_member mem
		 join
		 (	select i.m_id, sum(i_pay) total, group_concat( i.i_subject separator '###') as isub
				from mari_invest i
			 join
			 (
				 select b.loan_id loans from mari_loan_same_owner b  where b.parents_loan_id = @parentid
				 union
				 select @loanid as loans
				 union
				 select @parentid as loans
			 ) tmpuni on i.loan_id = tmpuni.loans
			 group by m_id
		 ) tmpjoin on mem.m_id = tmpjoin.m_id
	 ) tmplast
	 where tmplast.total>tmplast.memlimit #오버된 사람만 보기
	 order by tmplast.total DESC;
		";
		$rows = $this->db->query($sql)->result_array();
		if(count($rows)> 0){
			foreach( $rows as $row){
				$msg .= 	$row['m_id'].'(한도:'.number_format($row['memlabel']).') - 투자액'.number_format($row['total']).'원\\n';
				$tmp = explode('###',$row['isub'] );
				foreach ($tmp as $isub){
					$msg.='    '.$isub.'\\n';
				}
			}

		}else {
			$msg = "동일차주로 검색시(NO:".$loanid.") OVER 된 사람이 없습니다.";
		}
		$this->json(array('code'=>'OK', 'msg'=>$msg));
	}
	private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}
