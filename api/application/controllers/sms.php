<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Sms extends CI_Controller {

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
    /*
		if($row['au_member'] != 1 ) {
			$this->json( array('code'=>'ERROR', 'msg'=>"사용권한이 없습니다.") );
		}
    */
		session_write_close();//session_write_close();//session_abort();// ajax pending 막기위해 ssession 정지
		$this->{$method}();
	}
	public function index()
	{
		;
	}
  public function groupmember() {
    $check = $this->input->get('check');
    if(!is_array($check) ) $this->json( array ( 'code'=>'ERROR', 'msg'=>'그룹을 선택하여 주세요') );
		$data = array();
		foreach ($check as $val){
			$tmp = explode('_', $val);
			if($tmp[1]=='0'){
				$sql1 = "
					select * from view_sms_grouping
					where grptype= ? and sb_receipt = '1'
				";
				$sql2 ="
					select * from view_sms_grouping
					where grptype= ?
				";
				$sql = ( $this->input->get('receipt')=='Y' ) ? $sql1 : $sql2;
				$rows = $this->db->query($sql, array($tmp[0] ) )->result_array();
				//$rows = $this->db->select('*')->where('grptype', $tmp[0])->get('view_sms_grouping')->result_array();
				//var_dump($this->db->last_query());
			}else {
				$sql1 = "
				select *
					from
				(
					select * from view_sms_grouping
					where grptype= ?
					order by m_id
					limit ?, 499
				) tmp
				where sb_receipt = '1'
				";
				$sql2 ="
					select * from view_sms_grouping
					where grptype= ?
					order by m_id
					limit ?, 499
				";
				$sql = ( $this->input->get('receipt')=='Y' ) ? $sql1 : $sql2;
				$rows = $this->db->query($sql, array($tmp[0] , ($tmp[1]-1)*499) )->result_array();

				//$rows = $this->db->select('*')->where('grptype', $tmp[0])->limit(499,($tmp[1]-1)*499 )->get('view_sms_grouping')->result_array();
				//var_dump($this->db->last_query());
			}
			$data = array_merge($data, $rows);
		}

/*
    $this->db->select('*');
    foreach ($check as $val) $this->db->or_where('grptype', $val);
    #$this->db->limit(10);
    $data = $this->db->get('view_sms_grouping')->result_array();
		*/
    $list = $this->groupcount(false);
    $this->json( array ( 'code'=>'OK', 'data'=>$data,'cnt'=> count($data), 'list'=>$list) );
  }
  public function searchgroupmember() {
    $search = trim($this->input->get('search') );
    if($search == '' ) $this->json( array ( 'code'=>'ERROR', 'msg'=>'검색할 전화번호를 적어주세요') );

    $sql = "
    select
     case
		  when grptype = 'L' then '대출회원'
	     when grptype = 'I' then '투자회원'
	     when grptype = 'N' then '일반회원'
	     else 'unknown'
     end as grpname
	  , a.m_id, a.sb_name, a.trimed_hp, a.ismem
    from view_sms_grouping a
    where trimed_hp like ?
    ";
    $data =$this->db->query($sql , array( '%'.$this->db->escape_like_str($search).'%' ) )->result_array();
    //$data =$this->db->query($sql , array( $search ) )->result_array();
    if( count($data) < 1) $msg ="해당 전화번호가 없습니다.";
    else {
      $msg = '';
      foreach ($data as $row){
        $msg .= $row['grpname'].'-'.$row['sb_name']. '-' . $row['trimed_hp'] .'('. ($row['ismem']=='Y'?'회원':'탈퇴회원').')\\n';
      }
    }
    $this->json( array ( 'code'=>'OK','msg'=>$msg ,'data'=>$data , 'cnt'=>count($data) ) );
  }
  public function groupcount($jsontype=true) {
    $groupNameIng = array(
          "L"=>array("label"=>'대출회원', 'cnt'=>0 , 'receipt'=>0),
          "I"=>array("label"=>'투자회원', 'cnt'=>0 , 'receipt'=>0),
          "N"=>array("label"=>'일반회원', 'cnt'=>0 , 'receipt'=>0)
    );
    $sql = "
      select
      g.grptype , count(1) cnt
      from view_sms_grouping g
      group by g.grptype
			order by field (g.grptype ,'L' ,'N','I')
    ";
    $newgrpqry = $this->db->query($sql)->result_array();
    foreach ($newgrpqry as $row){

				if($row['cnt'] > 499 ){
					$tmpcnt = ceil ( $row['cnt']/499);
					for($i = 1 ; $i <= $tmpcnt ;$i++) {
					$groupNameIng2[ $row['grptype'].'_'.$i ]['label'] = $groupNameIng[ $row['grptype'] ]['label'];
					$groupNameIng2[ $row['grptype'].'_'.$i ]['label2']="(".$i.")";
					$groupNameIng2[ $row['grptype'].'_'.$i ]['cnt'] = ($i*499>$row['cnt'])? $row['cnt'] - ($i-1)*499 : '499';
					$sql = "
					select count(1) as cnt
						from
					(
						select * from view_sms_grouping
						where grptype= ?
						order by m_id
						limit ?, 499
					) tmp
					where sb_receipt = '1'
					";
					$cnt = $this->db->query($sql, array($row['grptype'] , ($i-1)*499) )->row_array();
					$groupNameIng2[ $row['grptype'].'_'.$i ]['receipt'] = $cnt['cnt'];
					}
				}else {
					$groupNameIng2[ $row['grptype'].'_0' ]['label'] = $groupNameIng[ $row['grptype'] ]['label'];
					$groupNameIng2[ $row['grptype'].'_0']['label2']="";
					$groupNameIng2[ $row['grptype'].'_0' ]['cnt'] = $row['cnt'];
					$sql = "
						select count(1) as cnt from view_sms_grouping
						where grptype= ? and sb_receipt = '1'
					";
					$cnt = $this->db->query($sql, array($row['grptype'] ) )->row_array();
					$groupNameIng2[ $row['grptype'].'_0' ]['receipt'] = $cnt['cnt'];
				}

    }

    if($jsontype) $this->json( array ( 'code'=>'OK', 'data'=>$groupNameIng2) );
    else return $groupNameIng2;
  }

	private function json( $data = '' ){
		header('Content-Type: application/json');
		if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
		echo json_encode( $data );
		exit;
	}
}
