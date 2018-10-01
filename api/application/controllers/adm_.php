<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/libraries/JWT.php';
use \Firebase\JWT\JWT;
class Adm extends CI_Controller {
  var $login;
  var $nowdate;
  public function _remap($method) {
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();

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
          $this->load->model('basic');
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
      $token['exp'] = $this->nowdate->getTimestamp() + 86400;
      setcookie('api', JWT::encode($token,'myAFKey132423'), time() + 86400);
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

  function index(){
    $reserv_template = explode('@@val=', $this->load->view('adm_header_reserv_template', array("reservlist"=>$this->basic->reservlist()), true) );

    $this->load->view('adm_header', array("errmsglist"=>$this->jungsanerrorlist(), "reservtemplate"=>$reserv_template ));
    $this->load->view('adm_loanlist', array("loanlist"=>$this->loandatalist() ,'levellist'=>$this->basic->levellist() ));
    $this->load->view('adm_footer',array('js'=>'adm_loanlist.js?ver=20180119095055'));
  }
  public function settle () {
    $reserv_template = explode('@@val=', $this->load->view('adm_header_reserv_template', array("reservlist"=>$this->basic->reservlist()), true) );
    $this->load->view('adm_header', array("errmsglist"=>$this->jungsanerrorlist(), "reservtemplate"=>$reserv_template ));

    $this->load->view('adm_settle');
    $this->load->view('adm_footer',array('js'=>'adm_settle.js?ver=20180119095055'));
  }
  public function settledata() {
    $this->load->model('settle');
    $data  = $this->settle->iljungsanTableforCalendar();
    $ret = array();
    foreach ( $data as $row){
       $title = array();
       if ($row['unpayed'] > 0 )  $title[] = "정산예정 : ".$row['unpayed']." 건";
       if ($row['payed'] > 0 )  $title[] = "정산완료 : ".$row['payed']." 건";
      $tmp ['date'] = $row['schdate'];
      $tmp ['badge'] = false;
      $tmp ['title'] =  implode(',',  $title) ;
      $tmp ['body'] =  "";
      $tmp ['footer'] = '';
      $ret[] = $tmp;
    }
    echo json_encode($ret);
  }
  public function settledetail() {
    $this->load->model('settle');
    $data  = $this->settle->iljungsanTableforCalendarDetail($this->input->get('date'));
    echo json_encode($data);
  }
  public function settlejungsantable(){
    $loanid = $this->input->get('loanid');
    if((int)$loanid < 1) {
      echo 'loan id가 필요합니다.';return;
    }
    $this->load->model('ilmangi');
    $this->load->view('adm_setlejungsantable', array('ilmangi'=> $this->ilmangi->loantablebyid((int)$loanid)) );
  }
  public function settlejungsantableDetail(){
    $sql = "select a.*, a.days + datediff( curdate(), a.repaydate ) as nowdiffdays from z_repay_schedule a where a.loanid = ? and cnt = ?";
    $data['info1'] = $this->db->query($sql, array($this->input->get('loanid'),$this->input->get('loancnt') ))->row_array();
    $this->load->view('adm_settlejungsantableDetail', $data);
  }
  public function settleprerun() {
    $this->load->model('settle');

    if( $this->settle->ispayed($this->input->post('loanid'), $this->input->post('o_count')) == "1" ) {
      echo json_encode(array('code'=>500, 'msg'=>"기존 지급 로그가 있습니다.<br> 관리자에게 문의해주세요") ) ;return;
    }
    if( $this->input->post('o_count') > 1 && $this->settle->ispayed($this->input->post('loanid'), $this->input->post('o_count')-1) == "0" ){
      echo json_encode(array('code'=>500, 'msg'=>($this->input->post('o_count')-1)."회차 지급로그가 없습니다. 이전회차부터 정산해주세요") );return;
    }
    $sql = "select idx from z_settlement_history where loan_id = ? and o_count = ? ";
    $log = $this->db->query($sql, array($this->input->post('loanid'),$this->input->post('o_count')))->row_array();
    if( isset($log['idx']) ) {
      $this->db->set(
          array('type'=>$this->input->post('type')
                ,'status'=>'R'
                ,'Reimbursement'=>$this->input->post('Reimbursement')
                ,'rate'=>$this->input->post('rate')
                ,'days'=>$this->input->post('days')
                ,'Delinquency_rate'=>$this->input->post('Delinquency_rate')
                ,'Delinquency_days'=>$this->input->post('Delinquency_days'))
                )
                ->where(array('loan_id'=>$this->input->post('loanid'),'o_count'=>$this->input->post('o_count')) )
                ->update('z_settlement_history');
      $idx =  $log['idx'];
    }else {
      $this->db->set(
          array(
                'loan_id'=>$this->input->post('loanid'),'o_count'=>$this->input->post('o_count')
                ,'type'=>$this->input->post('type')
                ,'status'=>'R'
                ,'Reimbursement'=>$this->input->post('Reimbursement')
                ,'rate'=>$this->input->post('rate')
                ,'days'=>$this->input->post('days')
                ,'Delinquency_rate'=>$this->input->post('Delinquency_rate')
                ,'Delinquency_days'=>$this->input->post('Delinquency_days'))
                )
                ->insert('z_settlement_history');
      $idx = $this->db->insert_id();
    }
    if($idx> 0) $this->settle->makesettledata($idx);
    else {
      echo json_encode(array('code'=>500, 'msg'=>"계산도중 오류가 발생하였습니다.") );return;
    }
  }
public function firstanal() {
  $this->load->model('anal');
  $anal = $this->anal->first($this->input->get('id'));
  $won = array();
  $man = array();
  foreach($anal as $idx=>$row){
    $tmpex = explode(' ', $row['i_subject']);
    $tmp = array('y'=>$tmpex[0].'..', 'a'=>$row['firsttotal'],'b'=>$row['notfirsttotal']);
    $won[] = $tmp;
    $man[] = array('y'=>$tmpex[0].'..', 'a'=>$row['first_count'],'b'=>$row['notfirst_count']);
    if($idx>3) break;
  }
  echo json_encode(array('data'=>$won,'data2'=>$man));
}
public function ilmangitable() {
  $loanid = $this->input->get('loanid');
  if((int)$loanid < 1) {
    echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'loan id가 필요합니다.'));
    return;
  }
  $this->load->model('ilmangi');
  if ( $this->input->get('type') =='json' ) echo json_encode(array('code'=>200, 'msg'=>'', 'data'=>$this->ilmangi->loantablebyid((int)$loanid)));
  else {
    $this->load->view('adm_ilmangitable', array('ilmangi'=> $this->ilmangi->loantablebyid((int)$loanid)) );
  }
}
  public function memlogin() {
		session_start();
		$mem = $this->input->get('mid');
		$sql = "select * from mari_member where m_id = ?";
		$mem = $this->db->query($sql, array($mem))->row_array();
		$_SESSION['ss_m_id'] = $mem['m_id'];
    if($this->input->get('adm')=='Y'){
      ?>
      <script>
				location.replace('/pnpinvest/?cms=member_list');
			</script>
      <?php
      return;
    }
		?>
			<script>
				location.replace('/pnpinvest/?mode=mypage_invest_info');
			</script>
		<?php
	}

    function getreservetemplate() {
      $lastidx = ($this->input->get('lastidx') > 0 ) ? $this->input->get('lastidx') : 0;
      $this->load->view('adm_header_reserv_template', array("reservlist"=>$this->basic->reservlist($lastidx))) ;
    }
    function loandatalist() {
      return $this->db->query('select * from mari_loan a where a.i_view = "Y" order by i_id desc')->result_array();
    }
    /*정산오류리스트*/
    function jungsanerrorlist(){
      return $this->db->query("select * from mari_seyfert_order a where a.loan_id > 0 and s_tid='' and a.s_payuse ='N' and s_type='1' and s_date > DATE_SUB(curdate(), INTERVAL 1 WEEK) and s_subject like '%정산'")->result_array();//and s_date > DATE_SUB(curdate(), INTERVAL 1 WEEK)
    }
    function loanlist(){
      $where =' where a.i_view="Y" ';
      $tabledata = $this->datatableparse();
      if($tabledata['search']!='' ) {
        if ( $tabledata['search'] === (string)((int)$tabledata['search']) ) $where .=" and ( a.i_id = '".(int)$tabledata['search']."' or i_subject like '%".$tabledata['search']."%')";
        else $where .=" and i_subject like '%".$tabledata['search']."%'";
      }
      if($tabledata['order'] == '' ) $tabledata['order']= 'a.i_id';
      if($tabledata['order_dir'] =='' ) $tabledata['order']= 'desc';
      $sql = "
      select
          a.i_id,a.m, a.i_loan_pay, a.i_loan_day as months , a.i_year_plus
          , a.i_repay, a.i_repay_day, a.i_subject
          , b.i_invest_sday, b.i_invest_eday,b.i_view, b.i_look
          , a.i_loanexecutiondate,c.i_reimbursement_date
          ,date_format(i_loanexecutiondate, '%Y-%m-%d') as i_loanexecutiondate2
      from mari_loan a
      inner join mari_invest_progress b on a.i_id = b.loan_id
      left join mari_loan_ext c on a.i_id  = c.fk_mari_loan_id
      $where
      order by ".$tabledata['order']." ".$tabledata['order_dir']."
      limit ".$tabledata['start']." , ".$tabledata['length'];

      $loanlist = $this->db->query($sql)->result_array();
      $sql = "select count(1) as cnt from mari_loan a ".$where;
      $tmp = $this->db->query($sql)->row_array();
      $page = (int)($tmp['cnt']/$tabledata['length'])+1;
      $ret['page'] = '1';
      $ret['draw'] = $this->input->get('draw');
      $ret['recordsFiltered'] =$ret['recordsTotal'] = $data['data']['totalRecord']=$tmp['cnt'];
      $list = array();
      foreach($loanlist as $row){
        $row['i_loanexecutiondate'] = ($row['i_loanexecutiondate']=='0000-00-00 00:00:00') ?'':$row['i_loanexecutiondate'];
        $row['i_look'] =$this->statusparse($row['i_look']);
        $tmp = $this->db->query('select * from mari_loan_same_owner a where a.loan_id = ? or a.parents_loan_id = ?', array($row['i_id'],$row['i_id']))->row_array();
        $row['sameowner'] =  (is_array($tmp)&&isset($tmp['loan_id']) ) ? ( $tmp['loan_id'] == $row['i_id'] ? 'fa-link linkchild' : 'fa-link linkparent') :'fa-unlink';
        $list[] = $row;
      }
      $ret['data'] = $list;
      echo json_encode($ret);
    }
    function userlist() {
      $where =' where 1';
      $where2 ='';
      $tabledata = $this->datatableparse();
      if($tabledata['search']!='') $where .=" and m_id like '%".$tabledata['search']."%' or m_name like '%".$tabledata['search']."%' or m_hp like '%".$tabledata['search']."%'";
      if($tabledata['order'] == '' ) $tabledata['order']= 'm_no';
      if($tabledata['order_dir'] =='' ) $tabledata['order']= 'desc';
      if($this->input->get('searchlevel') !=''){
        if($this->input->get('searchlevel')=='level_morethan_2') $where .= " and mem.m_level = 3 ";
        else $where .= " and mem.m_signpurpose = '".$this->input->get('searchlevel')."' ";
      }
      if($this->input->get('isnotauthed')=='Y') $where .= " and ma.fk_mari_member_m_no is null ";
      $sql = "select i_maximum as 일반,i_maximum_v as 법인,i_maximum_v as 관리자,i_maximum_pro as 전문,i_maximum_in as 소득적격
      ,i_maximum_personalloan as 개인대부,i_maximum_corporateloan as 법인대부,i_maximum_incomeloan as 소득적격대부 from mari_inset a";
      $inset = $this->db->query($sql)->row_array();

      $sql = "
      select
        a.m_no, a.m_id, a.m_name,a.m_hp
        ,case
    			 when (a.m_level> 3) then '관리자'
           when (a.m_level> 2 and a.m_signpurpose = 'L') then '법인대출'
    			 when (a.m_level> 2) then '법인'
    			 when (a.m_signpurpose = 'I' ) then '소득적격'
    			 when (a.m_signpurpose = 'P' ) then '전문'
    			 when (a.m_signpurpose = 'L2' ) then '개인대부'
    			 when (a.m_signpurpose = 'C2' ) then '법인대부'
    			 when (a.m_signpurpose = 'I2' ) then '소득적격대부'
           when (a.m_signpurpose = 'L' ) then '대출'
    			 else '일반'
    		 end as memlabel
        , a.m_my_bankcode, a.m_my_bankname, a.m_my_bankacc, if( a.m_verifyaccountuse = 'Y' ,'검즘','미검증') m_verifyaccountuse
        ,a.m_emoney, a.m_trAmt
        , b.s_accntNo , b.s_bnkCd
        ,if( isnull(b.s_accntNo) or b.s_accntNo = '' , '없음','Y') as virtualacc
        , ( select ifnull(sum(i_pay),0)  as total
          from
          mari_invest tmp1
          join
          ( select t.loan_id from mari_invest_progress t where t.i_look in('Y','C','D') ) tmp2 on tmp1.loan_id = tmp2.loan_id
          where tmp1.m_id=a.m_id ) as payed
          , if(fk_mari_member_m_no is null ,'N','Y' ) as authed
        from ( select ma.fk_mari_member_m_no, mem.* from mari_member mem
        left join mari_member_auth ma on mem.m_no = ma.fk_mari_member_m_no
        $where
        order by ".$tabledata['order']." ".$tabledata['order_dir']." limit ".$tabledata['start']." , ".$tabledata['length']."  ) a
        left join mari_seyfert b on a.m_id = b.m_id and b.s_memuse='Y'
        order by ".$tabledata['order']." ".$tabledata['order_dir'];
      $userlist = $this->db->query($sql)->result_array();
      $sql = " select count(1) as cnt from mari_member mem left join mari_member_auth ma on mem.m_no = ma.fk_mari_member_m_no $where";
      $tmp = $this->db->query($sql)->row_array();
      $page = (int)($tmp['cnt']/$tabledata['length'])+1;
      $ret['page'] = '1';
      $ret['draw'] = $this->input->get('draw');
      $ret['ordering'] = $tabledata['order']." ".$tabledata['order_dir'];
      $ret['recordsFiltered'] =$ret['recordsTotal'] = $data['data']['totalRecord']=$tmp['cnt'];
      foreach ($userlist as &$row){
        $row['maximum'] = $inset[ ( $row['memlabel'] =="대출" ? '일반':$row['memlabel']) ];
      }
      $ret['data'] = $userlist;
      echo json_encode($ret);
    }
    //회원인증
    public function authmem(){
      $m_no = (int)$this->input->post('mno');
      if( $m_no < 1) {
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'Member No ERROR'));
        return;
      }
      if($this->db->insert('mari_member_auth',array('fk_mari_member_m_no'=>$m_no, 'authed'=>'Y')) ) {
        $this->basic->insertmemberlog( array('writer'=>$this->login->id, 'code'=>'C003','msg'=>'회원인증') , $m_no);
        echo json_encode(array ( 'code'=>'OK', 'msg'=>''));
        return;
      }else {
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'DB ERROR OCCURED'));
        return;
      }
    }
    //회원인증취소
    public function authmemcancel(){
      $m_no = (int)$this->input->post('mno');
      if( $m_no < 1) {
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'Member No ERROR'));
        return;
      }

      if($this->db->where ('fk_mari_member_m_no',$m_no) ->delete('mari_member_auth') ) {
        $this->basic->insertmemberlog( array('writer'=>$this->login->id, 'code'=>'C004','msg'=>'회원인증취소') , $m_no);
        echo json_encode(array ( 'code'=>'OK', 'msg'=>''));
        return;
      }else {
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'DB ERROR OCCURED'));
        return;
      }
    }
    //회원 패스워드 변경
    function changepwd() {
      $this->load->library('form_validation');
      $this->form_validation->set_rules('m_id', '받는 이메일', 'trim|required|valid_email');
      $this->form_validation->set_rules('newpwd', '이체내용', 'trim|required|min_length[4]');
      $this->form_validation->set_error_delimiters('', '');
      if ($this->form_validation->run() == FALSE) {
        echo json_encode( array("code"=>500, "msg"=>'비밀번호를 확인해주세요'));//validation_errors()
        return;
      }
      if( $this->basic->changepassword($this->input->post('m_id'),$m_password = $this->input->post('newpwd') ) ) {
        echo json_encode( array("code"=>200, "msg"=>'변경하였습니다.'));
      }else {
        echo json_encode( array("code"=>500, "msg"=>'변경중 오류가 발생하였습니다.'));
      }
    }
    function changelevel() {
      $this->load->view( 'adm_changelevel',array("meminfo" => $this->basic->mem_baseinfo($this->input->get('user')), 'levellist' => $this->basic->levellist() ));
    }
    function changelevelprc() {
      $this->load->library('form_validation');
      $this->form_validation->set_rules('m_id', '변경 아이디', 'trim|required|valid_email');
      $this->form_validation->set_rules('level', '변경 레벨', 'trim|required');
      $this->form_validation->set_error_delimiters('', '');

      if ($this->form_validation->run() == FALSE ||!in_array($this->input->post('level'), array_keys($this->basic->levellist() ) )) {
        echo json_encode( array("code"=>500, "msg"=>'변경 내용을 확인해주세요'));//validation_errors()
        return;
      }
      $meminfo = $this->basic->mem_baseinfo($this->input->post('m_id'));
      if( $meminfo['m_level'] > '3')     {
        echo json_encode( array("code"=>501, "msg"=>'일반 또는 법인 회원이 아닙니다. 변경하실 수 없습니다.'));//validation_errors()
        return;
      }
      $new_purpose = $this->input->post('level');
      if( ($meminfo['m_level'] == '3' && $new_purpose == "level_morethan_2") || ($meminfo['m_signpurpose']) == $new_purpose ){
        echo json_encode( array("code"=>502, "msg"=>'변경전과 같은 등급입니다.'));//validation_errors()
        return;
      }
      if( $meminfo['m_level'] == '3'){
          $data['msg'] = "level : [".$meminfo['m_level']."] =>[2] ,
          purpose : [] => [".$new_purpose."]";
          $newdata ['m_level'] = '2';
          $newdata['m_signpurpose'] = $new_purpose;
      }else {
        if ($new_purpose == "level_morethan_2"){
          $data['msg'] = "level : [".$meminfo['m_level']."] =>[3] ,
          ";
          $newdata ['m_level'] = '3';
          $new_purpose='';
        }
         $data['msg'] .= "purpose : [".$meminfo['m_signpurpose']."] => [".$new_purpose."]";
      }
      $newdata ['m_signpurpose'] = $new_purpose;

      $data['m_id'] = $this->input->post('m_id');$data['code'] = 'C001';$data['writer'] = $this->login->id;

      if(  $this->db->where('m_id',$this->input->post('m_id'))->update('mari_member', $newdata) ) {
        $this->db->insert('mari_member_log', $data);
        echo json_encode( array("code"=>200, "msg"=>'변경되었습니다.'));
      }else echo json_encode( array("code"=>503, "msg"=>'Database Error Occured.'));
    }
    function userlog() {
      $data['m_id'] = $this->input->get('user');
      $sql = "select if( reserv is null ,'', ( if(reserv > now() , 'reserved','reserv-end') ) ) as resvclass , if ( reserv > DATE_SUB(NOW(), INTERVAL 3 DAY) , reserv, reg_date) as orderdate , a.* from mari_member_log a where m_id = ? order by orderdate desc";
      $data['logs'] = $this->db->query($sql, array($data['m_id']))->result_array();
      $data['reservcode'] = $this->basic->reservcode();
      $this->load->view('adm_userlog', $data);
    }
    function userlogwrite() {
      $this->load->library('form_validation');
      $this->form_validation->set_rules('m_id', '대상아이디', 'trim|required|valid_email');
      $this->form_validation->set_rules('message', '내용', 'trim|required|htmlspecialchars|xss_clean');
      $this->form_validation->set_error_delimiters('', '');
      $chekeddate = $this->checkdate($this->input->post('reserv') );
      if ($this->form_validation->run() == FALSE ||  $chekeddate[0] === false  ) {
        echo json_encode( array("code"=>500, "msg"=>'내용/대상아이디를 확인해주세요'));//validation_errors()
        return;
      }
      $data['m_id'] = $this->input->post('m_id');
      $data['msg'] = $this->input->post('message');
      $data['writer'] = $this->login->id;
      if($chekeddate[0] === true) $data['reserv'] = $chekeddate[1];
      $this->db->db_debug = FALSE;
      if( $this->db->insert('mari_member_log', $data) ) {
        echo json_encode( array("code"=>200, "msg"=>'저장되었습니다.'));
      }else {
        echo json_encode( array("code"=>502, "msg"=>'DB ERROR OCCURED',"errormsg"=>$this->db->_error_message()));
      }
    }
    function useremoneylog() {
      $m_id = $this->input->get('user');
      $sql = "select p_datetime,p_content,format(p_emoney,0) p_emoney,format(p_top_emoney,0) p_top_emoney from mari_emoney where m_id = ? order by p_id desc";
      $this->load->view('adm_useremoneylog', array('log'=>$this->db->query($sql , array($m_id) )->result_array()) );
    }
    function todaycharge() {
      $sql = "select a.c_regdatetime, a.m_id, a.m_name as r_name , format(a.c_pay,0) c_pay,a.c_pay as cpayorg, b.m_name, b.m_hp, b.m_trAmt, format(b.m_emoney,0) m_emoney
            from mari_char a
            join mari_member b on a.m_id = b.m_id
            where
            a.c_regdatetime >= CURDATE() and a.m_id <>'' and c_fin='Y' and a.m_name <> '엔젤크라우드대부' and a.m_name <> '주식회사엔젤크라우'
            order by a.c_no desc";
      $this->load->view('adm_todaycharge', array('log'=>$this->db->query($sql )->result_array()) );
    }
    function investlist(){
      $i_id = $this->input->get('i_id');
      $sql = "select i_regdatetime, i_id,a.m_id, a.m_name, a.i_pay,a.i_subject, if( (select count(1) as cnt from mari_invest c1 where c1.m_id = a.m_id and c1.i_id < a.i_id) = 0 , 1 , 0 ) as isfirst
        from mari_invest a
        where a.loan_id = ?  and a.i_pay_ment ='Y'         order by i_regdatetime asc, i_id  asc";
      //$list = $this->db->get_where('mari_invest', array('loan_id'=>$i_id, 'i_pay_ment' =>'Y'))->result_array();
      $list = $this->db->query($sql, array($i_id))->result_array();
      if(count($list) > 0 ) $code = "200";
      else $code = "404";
      if($this->input->get('type')=='json' ) {
        echo json_encode( array("code"=>$code, "data"=>$list));return;
      }
      else {
        $this->load->view('adm_loanlist_table', array("data"=>$list));
      }
    }
    function getseyfertorder(){
      $invest_id = $this->input->POST('invest_id');
      $sql = "select * from mari_invest a where a.i_id = ?";
      $invest = $this->db->query($sql , array($invest_id))->row_array();
      if( !isset( $invest['i_id']) ){
        echo json_encode( array("code"=>500, 'msg'=>'내용을 찾을 수 없습니다.',"data"=>''));return;
      }
      $sql = "select * from mari_seyfert_order where ";
      $sql = "select * from mari_seyfert_order a where a.loan_id = ? and a.s_payuse ='Y' and a.m_id = ?";
      $seyfert_order = $this->db->query($sql , array($invest['loan_id'], $invest['m_id']))->result_array();
      if( count($seyfert_order) < 1 ) {
        echo json_encode( array("code"=>501, 'msg'=>'결제 내용을 찾을 수 없습니다.',"data"=>''));return;
      }else if(count($seyfert_order) > 1){
        echo json_encode( array("code"=>502, 'msg'=>'중복결제 가능성이 있습니다.',"data"=>''));return;
      }
      if( $seyfert_order[0]['trnsctnTp']== 'PENDING_RELEASE'){
        echo json_encode( array("code"=>200, 'msg'=>'종료된 거래입니다 환불/취소 하시겠습니까?.',"data"=>$seyfert_order[0] ));return;
      }else if( $seyfert_order[0]['trnsctnSt']== 'SFRT_TRNSFR_PND_AGRREED') {
        echo json_encode( array("code"=>200, 'msg'=>'거래동의중입니다 취소하시겠습니까?',"data"=>$seyfert_order[0] ));return;
      }else {
        echo json_encode( array("code"=>503, 'msg'=>'상태를 확인 해주세요('.$seyfert_order[0]['trnsctnSt'].')',"data"=>$seyfert_order[0] ));return;
      }

    }

    //retrun check datetime array( result, formated data, msg )
    private function checkdate($date, $format = 'datetime') {
      if( $date =='') return array( 'NONE', '', '' );
      try {
          $date = new DateTime($date);
      } catch (Exception $e) {
          return array( false, '', $date->getMessage() );
      }
      if($format == 'date'){
        $formated = $date->format('Y-m-d');
      }else {
        $formated = $date->format('Y-m-d H:i:s');
      }
      return array( true , $formated , '' );
    }
    //return datatable default search, order
    private function datatableparse(){
      $order = $this->input->get('order');
      $columns = $this->input->get('columns');
      $length = (int)$this->input->get('length');
      $start = (int)$this->input->get('start');
      $search = $this->input->get('search');//search[value]:암

      if(isset ($search['value']) && trim($search['value'])  !=''){
        $data['search'] = trim($search['value']);
      }else $data['search'] ='';
      $data['order'] = $columns[ $order[0]['column'] ]['data'];
      $data['order_dir'] =  $order[0]['dir'];
      $data['length'] = ($length < 1) ? 10 :(int)$length;
      $data['start'] = ($start < 1) ? 0 :(int)$start;
      return $data;
    }
    // return invest status label
    private function statusparse($status){
      $code = array('Y'=>'투자진행','C'=>'투자마감','D'=>'상환중','N'=>'투자대기','F'=>'상환완료');
      return (isset($code[$status])) ? $code[$status] : $status;
    }
    /*
        function tranceform() {
          $this->load->view('adm_header');
          $this->load->view('adm_tranceform');
          $this->load->view('adm_footer');
        }
    */
}
