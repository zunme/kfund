<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once APPPATH . '/libraries/JWT.php';
use \Firebase\JWT\JWT;
class Adm extends CI_Controller {
  var $login;
  var $nowdate;
  public function _remap($method) {
    date_default_timezone_set('Asia/Seoul');
    $this->nowdate = new DateTime();
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
  function index(){
  /*{
    show_404();
  }
    function mainindex(){
    */
      $reserv_template = explode('@@val=', $this->load->view('adm_header_reserv_template', array("reservlist"=>$this->basic->reservlist()), true) );

      $this->load->view('adm_header', array("errmsglist"=>$this->jungsanerrorlist(), "reservtemplate"=>$reserv_template ));
      $this->load->view('adm_loanlist', array("loanlist"=>$this->loandatalist() ,'levellist'=>$this->basic->levellist() ));
      $this->load->view('adm_footer',array('js'=>'adm_loanlist.js?ver=20180519095055'));
    }
    function issmsmem(){
      $m_no = (int)$this->input->get('m_no');
      if( $m_no < 1){
        echo json_encode(array('code'=> 500, 'msg'=>'회원정보오류(1)'));return;
      }
      $row = $this->db->select('m_no, m_id, m_name, m_hp, m_sms')->get_where('mari_member', array('m_no'=>$m_no))->row_array();
      if( !isset($row['m_no']) || $row['m_no'] !=  $m_no ){
        echo json_encode(array('code'=> 500, 'msg'=>'회원정보를 찾을 수 없습니다.'));return;
      }
      $row['m_sms'] = $row['m_sms'] != '1' ? 'N' : 'Y';
      $msg = '';
      if( $row['m_sms'] =='Y' ) $msg = $row['m_name'].'('.$row['m_id'].')님의 SMS설정을 [거부] 로 바꾸시겠습니까?';
      else $msg = $row['m_name'].'('.$row['m_id'].')님의 SMS설정을 [승락] 으로 바꾸시겠습니까?';
      echo json_encode(array('code'=> 200, 'msg'=>$msg, 'data'=>$row));return;
    }
    function smsmemchange() {
      if( $this->input->post('m_sms') == 'Y' ) $new_sms='0';
      else if ( $this->input->post('m_sms') == 'N' ) $new_sms='1';
      else {
        echo json_encode(array('code'=> 500, 'msg'=>'필수정보 누락.'));return;
      }
      $res = $this->db
      ->set ('m_sms', $new_sms)
      ->where ( 'm_no', $this->input->post('m_no') )
      ->update('mari_member');
      if( $res === false){
        echo json_encode(array('code'=> 500, 'msg'=>'변경중 오류 발생.'));return;
      }else {
        echo json_encode(array('code'=> 200, 'msg'=>''));return;
      }
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
    /* 투자 오류 리스트 */
    function tujaerror() {
      $sql = "select  * from mari_seyfert_over a
            where ( `status` ='U'  or (`status`='Y' and cancel_tid='0') )
            and date(a.regdate) = curdate()
            group by tid";
      $data = $this->db->query($sql)->result_array();
      echo json_encode(array('cnt'=> count($data), 'data'=>$data));
    }
    function loanlist(){
      $where =' where a.i_view="Y" ';
      $tabledata = $this->datatableparse();
      if($tabledata['search']!='' ) {
        if ( $tabledata['search'] === (string)((int)$tabledata['search']) ) $where .=" and ( a.i_id = '".(int)$tabledata['search']."' or i_subject like '%".$tabledata['search']."%')";
        else $where .=" and i_subject like '%".$tabledata['search']."%'";
      }
      if($tabledata['order'] == '' ) $tabledata['order']= 'a.i_id';
      if($tabledata['order_dir'] =='' ) $tabledata['order_dir']= 'desc';
      $sql = "
      select
          a.i_id,a.m_id,a.i_loan_pay, a.i_loan_day as months , a.i_year_plus
          , a.i_repay, a.i_repay_day, a.i_subject
          , b.i_invest_sday, b.i_invest_eday,b.i_view, b.i_look
          , a.i_loanexecutiondate,c.i_reimbursement_date
          ,date_format(i_loanexecutiondate, '%Y-%m-%d') as i_loanexecutiondate2
          , a.i_pendingsf_use
          ,c.default_profit
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
        , a.m_my_bankcode, a.m_my_bankname, a.m_my_bankacc, if( a.m_verifyaccountuse = 'Y' ,'검증','미검증') m_verifyaccountuse
        ,a.m_emoney, a.m_trAmt , a.m_referee
        , if( a.m_sms != '1' , 0 , 1) as m_sms
        , ifnull(a.m_declaration_01,'') as m_declaration_01
        , ifnull(a.m_declaration_02,'') as m_declaration_02
        , ifnull(a.m_evidence,'') as m_evidence
        , ifnull(a.m_bill,'') as m_bill
        , b.s_accntNo , b.s_bnkCd
        ,if( isnull(b.s_accntNo) or b.s_accntNo = '' , '없음','Y') as virtualacc
        ,( select ifnull(group_concat( trim(substring(mari_invest.i_subject,1,4))),'') as invlist from mari_invest where mari_invest.m_id = a.m_id)as invlist
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
        $row['maximum'] =  (isset($inset[ ( $row['memlabel'] =="대출" ? '일반':$row['memlabel']) ]) ) ? $inset[ ( $row['memlabel'] =="대출" ? '일반':$row['memlabel']) ] : 0;
      }
      $ret['data'] = $userlist;
      echo json_encode($ret);
    }
    //지급여부초기화
    function resetuse() {
      $loanid = (int)($this->input->post('loanid'));
      if($loanid < 1 ) {
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'loand id 가 없습니다.'));
        return;
      }
      $row = $this->db->get_where('mari_loan', array('i_id'=>$loanid))->row_array();
      if(!isset($row['i_id'])){
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'loand 정보를 찾을 수 없습니다.'));
        return;
      }else if($row['i_pendingsf_use'] == 'N' ){
        echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'현재 미지급 상태입니다.'));
        return;
      }else{
        $qry = $this->db->set('i_pendingsf_use','N')->where('i_id', $loanid)->update('mari_loan' );
        if( !$qry){
          echo json_encode(array ( 'code'=>'ERROR', 'msg'=>'변경도중 오류가 발생하였습니다.'));
          return;
        }else {
          echo json_encode(array ( 'code'=>'OK', 'msg'=>'미지급으로 변경을 하였습니다.'));
          return;
        }
      }

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
      $sql = "select i_regdatetime, i_id,a.m_id, a.m_name, b.m_hp, a.i_pay,a.i_subject, if( (select count(1) as cnt from mari_invest c1 where c1.m_id = a.m_id and c1.i_id < a.i_id) = 0 , 1 , 0 ) as isfirst
        from mari_invest a
        join mari_member b on a.m_id = b.m_id
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
    function mreferer() {
      $sheet1= range('A','Z');
      $sheet2= array_merge(array(''), range('A','Z'));
      $len = count($sheet1);
      /*
      while( $j<100){
        echo $sheet[$a2].$sheet[$a1];
        ++$a1;
        if($a1 == $len) {$a1=0; ++$a2;}
        $j++;
      }
      return;
      */
       /** PHPExcel */
       $rows = $this->db->query('select a.m_id, a.m_name, a.m_hp, m_referee, m_datetime, if(a.m_verifyaccountuse="Y", "계좌검증","계좌미검증") as vbank , m_addr1, m_addr2 from mari_member a where a.m_referee !="" order by a.m_no desc')->result_array();
       require_once "../pnpinvest/plugin/exceldownload/PHPExcel/Classes/PHPExcel.php";
       $objPHPExcel = new PHPExcel();
       // Add some data
       foreach( $rows as $idx=>$row ){
           $i = $idx+1;

           $objPHPExcel->setActiveSheetIndex(0)
                       ->setCellValue("A".$i, $row['m_id'])
                       ->setCellValue("B".$i, $row['m_name']);
          //$objPHPExcel->setActiveSheetIndex(0)->setCellValue("C".$i, $row['m_hp'],PHPExcel_Cell_DataType::TYPE_STRING);
          $objPHPExcel->getActiveSheet()->setCellValueExplicit("C".$i,  preg_replace("/(0(?:2|[0-9]{2}))([0-9]+)([0-9]{4}$)/", "\\1-\\2-\\3", $row['m_hp']),  PHPExcel_Cell_DataType::TYPE_STRING);
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("D".$i, $row['m_referee'])
                       ->setCellValue("E".$i, $row['m_datetime'])
                       ->setCellValue("F".$i, $row['vbank']);
                       /*
                       ->setCellValue("G".$i, $row['m_addr1'])
                       ->setCellValue("H".$i, $row['m_addr2'])   ;
                       */

           $rows1 = $this->db->query("select i_subject, i_pay from mari_invest ta where ta.m_id = ? and ta.i_pay_ment='Y' and ta.i_pay>0 ", array($row['m_id']) )->result_array();
           if(count($rows1)>0){
             $a1 = 7;$a2 = 0;
             foreach( $rows1 as $idx2=>$row1){
               $objPHPExcel->setActiveSheetIndex(0)->setCellValue( $sheet1[$a1].$sheet2[$a2].$i , $row1['i_subject']);
               ++$a1;
               if($a1 == $len) {$a1=0; ++$a2;}
               $objPHPExcel->setActiveSheetIndex(0)->setCellValue( $sheet1[$a1].$sheet2[$a2].$i , $row1['i_pay'],PHPExcel_Cell_DataType::TYPE_STRING );
               ++$a1;
               if($a1 == $len) {$a1=0; ++$a2;}
             }
           }
          /*
          $rows1 = $this->db->query("select i_subject, i_pay from mari_invest ta where ta.m_id = ? and ta.i_pay_ment='Y' and ta.i_pay>0 ", array($row['m_id']) )->result_array();
          if(count($rows1)>0){
            foreach( $rows1 as $idx2=>$row1){
              $objPHPExcel->setActiveSheetIndex(0)->setCellValue($sheet[$idx2].$i, $row1['i_subject']."[".$row1['i_pay']."]");
            }
          }
          */
          /*
          $rows1 = $this->db->query("select i_subject, i_pay from mari_invest ta where ta.m_id = ? and ta.i_pay_ment='Y' and ta.i_pay>0 ", array($row['m_id']) )->result_array();
          if(count($rows1)>0){
            $sub = '';$won='';$total=0;
            foreach( $rows1 as $idx2=>$row1){
              $sub .= $row1['i_subject']."\n";
              $won .= $row1['i_pay']."원\n";
              $total +=  $row1['i_pay'];
            }
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue("J".$i, $total);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue("K".$i, $sub);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue("L".$i, $won);
            $objPHPExcel->getActiveSheet()->getStyle('K'.$i)->getAlignment()->setWrapText(true);
            $objPHPExcel->getActiveSheet()->getStyle('L'.$i)->getAlignment()->setWrapText(true);
          }
          */
       }

       $objPHPExcel->getActiveSheet()->setTitle('회원별 추천인 명단');
       $objPHPExcel->createSheet();
       $rows = $this->db->query('select a.m_id, a.m_name, a.m_newsagency ,a.m_hp, m_referee, m_datetime, if(a.m_verifyaccountuse="Y", "계좌검증","계좌미검증") as vbank , m_addr1, m_addr2  from mari_member a  order by a.m_no desc')->result_array();
       foreach( $rows as $idx=>$row ){
           $i = $idx+1;
           $objPHPExcel->setActiveSheetIndex(1)
                       ->setCellValue("A".$i, $row['m_id'])
                       ->setCellValue("B".$i, $row['m_name'])
                       ->setCellValue("C".$i, $row['m_newsagency']);
           $objPHPExcel->getActiveSheet()->setCellValueExplicit("D".$i,  preg_replace("/(0(?:2|[0-9]{2}))([0-9]+)([0-9]{4}$)/", "\\1-\\2-\\3", $row['m_hp']),  PHPExcel_Cell_DataType::TYPE_STRING);
                       //->setCellValue("D".$i, $row['m_hp'])
           $objPHPExcel->getActiveSheet()->setCellValue("E".$i, $row['m_referee'])
                       ->setCellValue("F".$i, $row['m_datetime'])
                       ->setCellValue("G".$i, $row['vbank'])
                       ->setCellValue("H".$i, $row['m_addr1'])
                       ->setCellValue("I".$i, $row['m_addr2'])
                       ;
       }
       $objPHPExcel->getActiveSheet()->setTitle('회원 명단');
       $objPHPExcel->setActiveSheetIndex(0);
       $filename = iconv("UTF-8", "EUC-KR", "추천인명단");

       // Redirect output to a client’s web browser (Excel5)
       header('Content-Type: application/vnd.ms-excel');
       header("Content-Disposition: attachment;filename=".$filename.".xls");
       header('Cache-Control: max-age=0');
       $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
       $objWriter->save('php://output');
    }
    //기간별 세액
    function withholdinglist(){
      $startdate = $this->input->get('startdate');
      $enddate = $this->input->get('enddate');
      $month = $this->input->get('yearmonth');
      if( $month != '' ){
        $date = $month."-01";
        $startdate = date('Y-m', strtotime($date ) ) ."-01";
        $enddate = date('Y-m-t', strtotime($date ) );
      }else {
        $startdate = ($startdate == "") ? date('Y-m', strtotime("-1 month", mktime() ) ) ."-01" : $startdate;
        $enddate = ($enddate == "") ? date('Y-m-t', strtotime("-1 month", mktime() ) ) : $enddate;
      }
      $this->db->query('set @startday = ? , @endday= ?;', array($startdate, $enddate));
      $rows = $this->db->query("select
	date_format(a.o_collectiondate,'%Y-%m-%d') as '발행일'
	,a.sale_id '아이디'
	, m.m_hp '휴대폰'
	,	case
		when (m.m_level> 2) then '법인'
		when (m.m_signpurpose = 'I' ) then '소득적격'
		when (m.m_signpurpose = 'P' ) then '전문투자자'
		when (m.m_signpurpose = 'L2' ) then '개인대부'
		when (m.m_signpurpose = 'C2' ) then '법인대부'
		when (m.m_signpurpose = 'I2' ) then '소득적격대부'
		when (m.m_signpurpose = 'L' ) then '대출회원'
		else '일반'
	end as '구분'

	, m.m_name '이름'
	,m.m_birth as '등록생일'
	,	case when ( MID(m_reginum, 7, 1) = '1' or MID(m_reginum, 7, 1) = '2') then   date_format( str_to_date( concat('19', LEFT(m_reginum, 6)) ,'%Y%m%d') ,'%Y-%m-%d')
		when ( MID(m_reginum, 7, 1) = '4' or MID(m_reginum, 7, 1) = '3' ) then date_format( str_to_date( concat('20', LEFT(m_reginum, 6)) ,'%Y%m%d') ,'%Y-%m-%d')
		else ''
		end as '주민생일'
	, m.m_reginum as '주민번호'
	, m.m_companynum as '사업자등록번호'

	, if ( m.m_level> 2 or m.m_signpurpose = 'C2' , 2 , 1 ) as '개인법인구분'
	,date_format(a.o_collectiondate,'%Y') as '발생년도'
	,date_format(a.o_collectiondate,'%m') as '발생월'
	,date_format(a.o_collectiondate,'%d') as '발생일'

	, if( m.m_verifyaccountuse ='Y' , m.m_my_bankcode , '') as 	'은행코드'
	, if( m.m_verifyaccountuse ='Y' , m.m_my_bankacc , '') as  '계좌번호'
	, if( m.m_verifyaccountuse ='Y' , m.m_my_bankname , '') as 	'예금주'

	, l.i_subject '상품'
	,a.o_ln_money_to '투자액'
	,a.wongum '원금'
	, date_format( str_to_date( @startday ,'%Y-%m-%d'), '%Y') as '검색시작년도'
	, date_format( str_to_date( @startday ,'%Y-%m-%d'), '%m') as '검색시작월'
	, date_format( str_to_date( @startday ,'%Y-%m-%d'), '%d') as '검색시작일'
	, date_format( str_to_date( @endday ,'%Y-%m-%d'), '%Y') as '검색종료년도'
	, date_format( str_to_date( @endday ,'%Y-%m-%d'), '%m') as '검색종료월'
	, date_format( str_to_date( @endday ,'%Y-%m-%d'), '%d') as '검색종료일'
	, a.inv + a.Delinquency as '이자'
	,l.i_year_plus '이율'

	, a.susuryo as '수수료' , a.o_withholding as '원천징수'
  , if(a.o_withholding > 0 , truncate ((a.inv + a.Delinquency)* 0.25,-1),0) as '세액1'
	, if(a.o_withholding > 0 , truncate ((a.inv + a.Delinquency)* 0.025,-1),0) as '세액2'


from view_jungsan a
join mari_member m on a.sale_id = m.m_id
join mari_loan l on a.loan_id = l.i_id
where a.o_collectiondate >= concat( @startday, ' 00:00:00') and a.o_collectiondate <= concat(@endday, ' 23:59:59')
order by a.sale_id;")->result_array();
require_once "../pnpinvest/plugin/exceldownload/PHPExcel/Classes/PHPExcel.php";
$objPHPExcel = new PHPExcel();
$objPHPExcel->setActiveSheetIndex(0)
->setCellValue("A1", "발행일")
->setCellValue("B1", "아이디")
->setCellValue("C1", "휴대폰")
->setCellValue("D1", "구분")
->setCellValue("E1", "이름")
->setCellValue("F1", "등록생일")
->setCellValue("G1", "주민생일")
->setCellValue("H1", "주민번호")
->setCellValue("I1", "사업자등록번호")
->setCellValue("J1", "개인법인구분")
->setCellValue("K1", "발생년도")
->setCellValue("L1", "발생월")
->setCellValue("M1", "발생일")
->setCellValue("N1", "은행코드")
->setCellValue("O1", "계좌번호")
->setCellValue("P1", "예금주")
->setCellValue("Q1", "상품")
->setCellValue("R1", "투자액")
->setCellValue("S1", "원금")
->setCellValue("T1", "검색시작년도")
->setCellValue("U1", "검색시작월")
->setCellValue("V1", "검색시작일")
->setCellValue("W1", "검색종료년도")
->setCellValue("X1", "검색종료월")
->setCellValue("Y1", "검색종료일")
->setCellValue("Z1", "이자")
->setCellValue("AA1", "이율")
->setCellValue("AB1", "수수료")
->setCellValue("AC1", "원천징수")
->setCellValue("AD1", "세액1")
->setCellValue("AE1", "세액2");
foreach( $rows as $idx=>$row ){
    $i = $idx+2;
    $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue("A".$i, $row['발행일'])
                ->setCellValue("B".$i, $row['아이디'])
                ->setCellValue("C".$i, $row['휴대폰'])
                ->setCellValue("D".$i, $row['구분'])
                ->setCellValue("E".$i, $row['이름'])
                ->setCellValue("F".$i, $row['등록생일'])
                ->setCellValue("G".$i, $row['주민생일'])
                ->setCellValue("H".$i, $row['주민번호'])
                ->setCellValue("I".$i, $row['사업자등록번호'])
                ->setCellValue("J".$i, $row['개인법인구분'])
                ->setCellValue("K".$i, $row['발생년도'])
                ->setCellValue("L".$i, $row['발생월'])
                ->setCellValue("M".$i, $row['발생일'])
                ->setCellValue("N".$i, $row['은행코드'])
                ->setCellValue("O".$i, $row['계좌번호'])
                ->setCellValue("P".$i, $row['예금주'])
                ->setCellValue("Q".$i, $row['상품'])
                ->setCellValue("R".$i, $row['투자액'])
                ->setCellValue("S".$i, $row['원금'])
                ->setCellValue("T".$i, $row['검색시작년도'])
                ->setCellValue("U".$i, $row['검색시작월'])
                ->setCellValue("V".$i, $row['검색시작일'])
                ->setCellValue("W".$i, $row['검색종료년도'])
                ->setCellValue("X".$i, $row['검색종료월'])
                ->setCellValue("Y".$i, $row['검색종료일'])
                ->setCellValue("Z".$i, $row['이자'])
                ->setCellValue("AA".$i, $row['이율'])
                ->setCellValue("AB".$i, $row['수수료'])
                ->setCellValue("AC".$i, $row['원천징수'])
                ->setCellValue("AD".$i, $row['세액1'])
                ->setCellValue("AE".$i, $row['세액2'])
                ;
}

$objPHPExcel->getActiveSheet()->setTitle('원천징수명단');
$objPHPExcel->setActiveSheetIndex(0);
$filename = iconv("UTF-8", "EUC-KR", "원천징수명단_".$month);

// Redirect output to a client’s web browser (Excel5)
header('Content-Type: application/vnd.ms-excel');
header("Content-Disposition: attachment;filename=".$filename.".xls");
header('Cache-Control: max-age=0');
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
$objWriter->save('php://output');
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
