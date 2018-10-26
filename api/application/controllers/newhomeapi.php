<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//define("PluginPath",'/home/pnpinvest/www/pnpinvest/plugin/pg/seyfert/aes.class.php');
//define("PluginPath",'/var/www/html/pnpinvest/plugin/pg/seyfert/aes.class.php');
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');

class Newhomeapi extends CI_Controller {
  var $user;
  var $islogin;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    date_default_timezone_set('Asia/Seoul');
    $this->load->model('mainbase');
    if(isset($_SESSION['ss_m_id'])){
        $user = $this->mainbase->meminfo($_SESSION['ss_m_id']);
        if($user['m_id'] == $_SESSION['ss_m_id']) {$this->user['info'] = $user;$this->islogin=TRUE;}
        else $this->islogin=FALSE;
    }else $this->islogin=FALSE;
    session_write_close();

    $this->seyfertinfo = $config = $this->db->query(" select * from mari_config ")->row_array();
    if($method=='checkmemid'){ $this->{$method}(); return;  }

    if($this->islogin===FALSE){ $this->json('login');return; }

    $this->user['seyfert'] = $this->mainbase->seyfertinfo($_SESSION['ss_m_id']);
    //$this->Guid = $this->mainbase->mariconfig('c_reqMemGuid');

    $this->{$method}();

  }
  function index(){

  }

  // ============================
  function checkmemid() {
    header("Pragma: no-cache");
    header("Cache-Control: no-cache,must-revalidate");

    $this->load->library('form_validation');
    if( !in_array($this->input->post('mode'), array('join3', 'ajax') )){
      $this->load->view('alert', array( 'url'=>'/pnpinvest/?mode=main') );
      return;
    }
    if($this->input->post('m_level') =='2'){
      $this->form_validation->set_rules('m_id', '아이디(이메일)', 'trim|required|email');
      $this->form_validation->set_rules('m_name', '이름', 'trim|required|xss_clean|min_length[2]');
      $this->form_validation->set_rules('m_password', '비밀번호', 'required|matches[m_password_re]|min_length[8]|max_length[20]', array('required'=>'Please enter Text Field Five!'));
      $this->form_validation->set_rules('m_password_re', '비밀번호확인', 'required');

      $this->form_validation->set_rules('birth1', '생년월일(년도)', 'required|numeric');
      $this->form_validation->set_rules('birth2', '생년월일(월)', 'required|numeric');
      $this->form_validation->set_rules('birth3', '생년월일(일)', 'required|numeric');

      $this->form_validation->set_rules('m_sex', '성별', 'required');

      $this->form_validation->set_rules('hp1', '휴대폰번호', 'required|numeric');
      $this->form_validation->set_rules('hp2', '휴대폰번호', 'required|numeric');
      $this->form_validation->set_rules('hp3', '휴대폰번호', 'required|numeric');

      $this->form_validation->set_rules('m_referee', '추천인', 'trim|xss_clean');

      $this->form_validation->set_rules('m_companynum', '사업자등록번호', 'trim|xss_clean');
      $this->form_validation->set_rules('m_company_name', '기업명', 'trim|xss_clean');
    }else if($this->input->post('m_level') =='3'){
      $this->form_validation->set_rules('m_id', '아이디(이메일)', 'trim|required|email');
      $this->form_validation->set_rules('m_name', '담당자명', 'trim|required|xss_clean|min_length[2]');
      $this->form_validation->set_rules('m_password', '비밀번호', 'required|matches[m_password_re]|min_length[8]|max_length[20]', array('required'=>'Please enter Text Field Five!'));
      $this->form_validation->set_rules('m_password_re', '비밀번호확인', 'required');

      $this->form_validation->set_rules('hp1', '휴대폰번호', 'required|numeric');
      $this->form_validation->set_rules('hp2', '휴대폰번호', 'required|numeric');
      $this->form_validation->set_rules('hp3', '휴대폰번호', 'required|numeric');

      $this->form_validation->set_rules('m_referee', '추천인', 'trim|xss_clean');

      $this->form_validation->set_rules('m_companynum', '사업자등록번호', 'trim|required|xss_clean');
      $this->form_validation->set_rules('m_company_name', '기업명', 'trim|required|xss_clean');
    }else {
      $this->json( array('code'=>500, 'msg'=> '올바른 정보가 아닙니다.' ) );
    }

    $this->form_validation->set_message('required', '%s (을)를 입력해주세요');
    $this->form_validation->set_message('min_length', '%s (은)는 %d 글자 이상입니다.');
    $this->form_validation->set_message('max_length', '%s (은)는 %d 글자 이하입니다');
    $this->form_validation->set_message('email', '%s (은)는 이메일 형식이 아닙니다.');
    $this->form_validation->set_message('numeric', '%s (은)는 숫자만 가능합니다.');


    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }
    $sql = "select ifnull(count(1),0) as cnt from mari_member where m_id = ? limit 1";
    $ismem = $this->db->query($sql, array($this->input->post('m_id')) )->row_array();

    if( $ismem['cnt'] > 0 ){
      $this->json(array('code'=>501, 'msg'=> '가입되어있는 아이디입니다.' ));
    }

    $sql = "select ifnull(count(1),0) as cnt from mari_seyfert where m_id = ? and s_memuse ='Y' limit 1";
    $ismem = $this->db->query($sql, array($this->input->post('m_id')) )->row_array();
    if( $ismem['cnt'] > 0 ){
      $this->json(array('code'=>501, 'msg'=> "가입기록이 있는 이메일입니다.\n다른이메일을 사용해 주세요" ));
    }

    $sql    = "select ifnull(count(1),0) as cnt from mari_seyfert where phoneNo = ? ";
    $ismem = $this->db->query($sql, array($this->input->post('hp1').$this->input->post('hp2').$this->input->post('hp3')) )->row_array();
    if( $ismem['cnt'] > 0 ){
      $this->json(array('code'=>501, 'msg'=> "이미 키가 발급된 번호입니다.\n다른 번호를 입력하여 주십시오" ));
    }
    $sql = " select ifnull(count(1),0) as cnt from mari_member where m_hp = ? ";
    $ismem = $this->db->query($sql, array($this->input->post('hp1').$this->input->post('hp2').$this->input->post('hp3')) )->row_array();
    if( $ismem['cnt'] > 0 ){
      $this->json(array('code'=>501, 'msg'=> "존재하는 휴대폰 번호 입니다.\n다른 번호를 입력하여 주십시오" ));
    }
    if( !in_array($this->input->post('m_signpurpose'), array('N','I','P','L')) && $this->input->post('m_level') < 3  ){
      $this->json(array('code'=>501, 'msg'=> "회원 유형을 선택해주세요" ));
    }

    if($this->input->post('mode') !='join3') $this->json(array('code'=>200, 'msg'=> "" ));

    $savedata = array();
    $savedata['m_id'] = $savedata['m_email']= $this->input->post('m_id');
    $savedata['m_name'] = $savedata['m_email']= $this->input->post('m_name');
    $savedata['m_password'] = hash('sha256', trim($this->input->post('m_password')) );
    $savedata['m_level'] = $this->input->post('m_level');
    $savedata['m_birth'] = ($this->input->post('birth1')===false) ? '': $this->input->post('birth1').'-'.$this->input->post('birth2').'-'.$this->input->post('birth3');
    $savedata['m_sex'] = ($this->input->post('m_sex')===false) ? '': $this->input->post('m_sex')=='m' ? 'm' :'w';
    $savedata['m_hp'] = $this->input->post('hp1').$this->input->post('hp2').$this->input->post('hp3');
    $savedata['m_zip']=$savedata['m_with_zip']= ($this->input->post('m_zip')===false) ? '': $this->input->post('m_zip');
    $savedata['m_addr1']=$savedata['m_with_addr1']=  ($this->input->post('m_addr1')===false) ? '':$this->input->post('m_addr1');
    $savedata['m_addr2']=$savedata['m_with_addr2']=  ($this->input->post('m_addr2')===false) ? '':$this->input->post('m_addr2');
    $savedata['m_sms']= $this->input->post('m_sms')=='1' ? '1' : '0';
    $savedata['m_emoney'] = '0';
    $savedata['m_datetime'] = date('Y-m-d H:i:s');
  //  $savedata['m_ip'] = $this->input->ip();
    $savedata['m_blindness']= $this->input->post('m_blindness');
    $savedata['m_ipin']= $this->input->post('m_ipin');
    $savedata['m_signpurpose']= $this->input->post('m_signpurpose');
    $savedata['m_referee']= $this->input->post('m_referee');
    $savedata['m_verifyaccountuse']= 'N';

    $savedata['m_companynum']= ($this->input->post('m_companynum') === false) ?'':$this->input->post('m_companynum');
    $savedata['m_company_name']= ($this->input->post('m_company_name') === false ) ?'':$this->input->post('m_company_name');
    $savedata['m_my_bankcode']= '';
    $savedata['m_my_bankname']= '';
    $savedata['m_my_bankacc']= '';
    $savedata['m_newsagency']= '';

    $url = "https://v5.paygate.net/v5a/member/createMember";
    $_method = "POST";
    $refId =$nonce = "PAul".time().rand(111,99);
    $ENCODE_PARAMS = "&_method=".$_method."&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&desc=desc&nonce=".$nonce."&emailAddrss=".$savedata['m_id']
                    ."&emailTp=PERSONAL&fullname=" . urlencode($savedata['m_name']) . "&nmLangCd=ko&phoneCntryCd=KOR&phoneNo=" . $savedata['m_hp'] . "&phoneTp=MOBILE";

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );

    if(!$res){
      $this->load->view('alert', array('msg'=>'회원가입 도중 오류가 발생하였습니다.', 'url'=>'/pnpinvest/?mode=join01') );
      return;
    }else if ($data['status'] =='SUCCESS'){
      $memGuid = isset($data['data']['memGuid']) ? $data['data']['memGuid'] : '';
      if( $memGuid == ''){
        $this->load->view('alert', array('msg'=>'회원가입 도중 오류가 발생하였습니다.', 'url'=>'/pnpinvest/?mode=join01') );
        return;
      }
      $seyfertdata = array(
        'm_id'=>$savedata['m_id']
        , 'm_name'=>$savedata['m_name']
        , 's_memGuid'=>$memGuid
        , 's_redatetime'=>date('Y-m-d H:i:s')
        , 's_ip'=>$this->input->ip_address()
        , 's_memuse'=>'Y'
        , 's_accntNo'=>''
        , 's_bnkCd'=>''
        , 'custNm'=>''
        , 'inName'=>''
        , 'totAmt'=>'0'
        , 'trAmt'=>'0'
        , 'orgAmt'=>'0'
        , 'trnsctnTp'=>''
        , 'trnsctnSt'=>''
        , 'trDate'=>'0000-00-00'
        , 'trTime'=>'00:00:00'
        , 'redatetime'=>'0000-00-00 00:00:00'
        , 'phoneNo'=>$savedata['m_hp']
        ,'guide'=>'N'
      );
      $smsdata = array(
        'sg_no'=>'1'
        ,'m_id'=>$savedata['m_id']
        , 'sb_name'=>$savedata['m_name']
        , 'sb_hp'=>$savedata['m_hp']
        , 'sb_receipt'=>$savedata['m_sms']
        ,'sb_memo' => '가입시 등록됨'
      );
    }else {
      $this->load->view('alert', array('msg'=>'회원가입 도중 오류가 발생하였습니다.', 'url'=>'/pnpinvest/?mode=join01') );
      return;
    }

    foreach($_FILES as $name =>$fileinfo){
      if ($_FILES[$name]['name'] !='') {
        $ret = $this->joinfileupload($name);
        if(isset($ret['code']) && $ret['code'] ){
          $savedata[$name] = $ret['data']['file_name'];

        }
      }
    }
    $this->db->insert('mari_member',$savedata);
    $this->db->insert('mari_seyfert',$seyfertdata);
    $this->db->insert('mari_smsbook',$smsdata);
    if( $this->input->post('m_blindness') =='Y' ) $this->db->where("REQ_SEQ", $_SESSION['join_req'] )->update('z_nice_log', array("m_id"=> $this->input->post('m_id') ) );//"req"=>$_SESSION['']

    session_start();
    $_SESSION['ss_m_id'] = $savedata['m_id'] ;
      ?>
      <script>
  			location.replace('/pnpinvest/?mode=join04');
  		</script>
      <?php
      return;

  }

  function joinfileupload($name, $path='../pnpinvest/data/file/member/')
	{

    $config['upload_path'] = $path;
    $config['allowed_types'] = 'gif|jpg|png|JPG|GIF|PNG|pdf|PDF|jpeg|JPEG';
    $config['max_size'] = '10000';
    $config['file_name'] = $name;
    $config['remove_spaces'] = true;
    $config['encrypt_name'] = true;
//var_dump($config);
	//	$this->load->library('upload', $config);
  	$this->load->library('upload');
    $this->upload->initialize($config);

		if ( ! $this->upload->do_upload($name))
		{
			return array('code'=>false,'error' => $this->upload->display_errors());
		}
		else
		{
			return array('code'=>true,'data' => $this->upload->data());
		}
	}
  // ============================




  function officefile() {
    //$this->load->library("UploadHandler");
    //$files[] = array("error"=>"", "name"=>"name");
    //echo $this->json(array("files"=>$files));

    $field = $this->input->post('ind');
    if ( !in_array($field, array('m_declaration_01','m_declaration_02','m_bill','m_evidence') ) ){
      $files[] = array("error"=>"서류구분에 오류가 발생하였습니다.");
      $this->json(array("files"=>$files) );
    }

      //Your upload directory, see CI user guide
      $config['upload_path'] = '../pnpinvest/data/file/member/';

      $config['allowed_types'] = 'gif|jpg|png|JPG|GIF|PNG|pdf|PDF|jpeg|JPEG';
      $config['max_size'] = '1000';
      //$config['file_name'] = $name;
      $config['encrypt_name'] = true;

      //Load the upload library
      $this->load->library('upload', $config);

      if ($this->upload->do_upload())
      {
        $data =  $this->upload->data();
        if( $this->user['info'][$field] !=''){
          unlink('../pnpinvest/data/file/member/'.$this->user['info'][$field]);
        }
        $this->db->where('m_id',$this->user['info']['m_id'] )->update('mari_member', array($field=>$data['file_name']) );
        $files[] = array("error"=>"", "name"=>$data['file_name']);
        echo $this->json(array("files"=>$files));
      }else {
        $files[] = array("error"=>$this->upload->display_errors());
        echo $this->json(array("files"=>$files));
      }

  }
  function modifybase() {
      $mem_data = $sms_data = array();
      $this->load->library('form_validation');
      $this->form_validation->set_rules('birth1', '생년월일(년도)', 'numeric');
      $this->form_validation->set_rules('birth2', '생년월일(월)', 'numeric');
      $this->form_validation->set_rules('birth3', '생년월일(일)', 'numeric');
      $this->form_validation->set_error_delimiters('','');
      if ($this->form_validation->run() == FALSE)
      {
        $this->json(array('code'=>500, 'msg'=> validation_errors() ));
      }
      $sms_data['sb_receipt'] = $mem_data['m_sms'] = $this->input->post('m_sms')=="1"  ? "1" : "0";
      $birth1 = $this->input->post('birth1');
      $birth2 = $this->input->post('birth2');
      $birth3 = $this->input->post('birth3');
      if($birth1 == "" && $birth2 =="" && $birth3 == "") {
        ;
      }else if ( !checkdate( (int)$birth2 , (int)$birth3 , (int)$birth1 ) ){
        $this->json(array('code'=>500, 'msg'=> "유효하지 않읂 생년월일 입니다." ));
      }else {
        $birth = sprintf("%04d-%02d-%02d", (int)$birth1 , (int)$birth2 , (int)$birth3);
        if ( $birth != $this->user['info']['m_birth'] ) $mem_data['m_birth'] = $birth;
      }
      $this->db->where('m_id', $this->user['info']['m_id'])->update('mari_member', $mem_data);
      $this->db->where('m_id', $this->user['info']['m_id'])->update('mari_smsbook', $sms_data);

      $msg = "SMS투자알림";
      $msg .= ( $mem_data['m_sms'] == 1) ? "(받기)" :"(거부)";
      if( isset( $mem_data['m_birth'] ) ) $msg .= "와 생년월일을";
      else $msg .= "을";
      $msg .= " 수정하였습니다.";
      $this->json(array('code'=>200, 'msg'=> $msg ));
  }
  function modifypw() {
    if( trim($this->input->post('old_pw1'))=="" ){
      $this->json(array('code'=>501, 'msg'=> "기존 비밀번호를 입력하여주세요." ));
    }
    if( trim($this->input->post('old_pw2'))=="" ){
      $this->json(array('code'=>502, 'msg'=> "새로운 비밀번호를 입력하여주세요." ));
    }
    if( trim($this->input->post('old_pw2'))!=trim($this->input->post('new_pw')) ){
      $this->json(array('code'=>503, 'msg'=> "[새비밀번호 확인]이 [새비밀번호]와 다릅니다. 동일하게 입력해주세요" ));
    }
    if(  hash('sha256', trim($this->input->post('old_pw1')) ) != $this->user['info']['m_password']){
      $this->json(array('code'=>504, 'msg'=> "기존비밀번호를 확인해주세요." ));
    }
    $pattern = '/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/';
    if(preg_match($pattern ,trim($this->input->post('new_pw')) )){
      $this->db->where('m_id', $this->user['info']['m_id'])->update('mari_member',array('m_password'=>hash('sha256',trim($this->input->post('new_pw')) ) ) );
      $this->json(array('code'=>200, 'msg'=> "비밀번호를 수정하였습니다." ));
    }else {
      $this->json(array('code'=>505, 'msg'=> "영대/소문자, 숫자 및 특수문자 조합 비밀번호 8자리이상 15자리 이하의 새로운 비밀번호를 입력해주세요" ));
    }
  }
  function modifywithdraw() {
    $data = array();$msg= array();$addresschange = false;
    $m_reginum = $this->input->post('m_reginum1').$this->input->post('m_reginum2');
    $m_with_zip = str_replace('-','',$this->input->post('m_with_zip'));

    if( !$this->jumincheck($m_reginum) ) {
      $this->json(array('code'=>501, 'msg'=> "주민등록번호가 올바르지 않습니다." ));
    }
    if ($this->user['info']['m_reginum'] != $m_reginum){
      $data['m_reginum'] = $m_reginum;
      $msg[] = "주민등록번호";
    }

    $this->load->library('form_validation');
    $this->form_validation->set_rules('m_with_zip', '우편번호', 'trim|required|numeric|min_length[5]|max_length[6]');
    $this->form_validation->set_rules('m_with_addr1', '주소', 'trim|required|xss_clean');
    $this->form_validation->set_rules('m_with_addr2', '상세주소', 'trim|required|xss_clean');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>503, 'msg'=> "주소를 확인해주세요" ));
    }
    if($this->input->post('m_with_zip') != $this->user['info']['m_with_zip']) {
      $data['m_with_zip'] = $this->input->post('m_with_zip');
      $addresschange = true;
    }
    if($this->input->post('m_with_addr1') != $this->user['info']['m_with_addr1']) {
      $data['m_with_addr1'] = $this->input->post('m_with_addr1');
      $addresschange = true;
    }
    if($this->input->post('m_with_addr2') != $this->user['info']['m_with_addr2']) {
      $data['m_with_addr2'] = $this->input->post('m_with_addr2');
      $addresschange = true;
    }
    if( count($data)<1 ){
        $this->json(array('code'=>503, 'msg'=> "변경된 내용이 없습니다." ));
    }
    if($addresschange){
      $msg[]='주소';
    }
    $msgstr = implode(" / ", $msg)." 를 변경하였습니다.";
    $this->db->where('m_id', $this->user['info']['m_id'])->update('mari_member',$data );
    $this->json(array('code'=>200, 'msg'=> $msgstr ));
  }
  //대출신청 저장
  function joinloanprc() {
    $this->load->library('form_validation');

    $this->form_validation->set_rules('loan_name', '이름', 'required|min_length[3]|max_length[20]');
    $this->form_validation->set_rules('loan_phone', '통신사', 'required');
    $this->form_validation->set_rules('loan_phone2', '전화번호1', 'required|numeric|min_length[3]|max_length[4]');
    $this->form_validation->set_rules('loan_phone3', '전화번호2', 'required|numeric|min_length[3]|max_length[4]');
    $this->form_validation->set_rules('loan_phone4', '전화번호3', 'required|numeric|min_length[4]|max_length[4]');
    $this->form_validation->set_rules('loan_email', '이메일', 'required|valid_email|min_length[5]|max_length[255]');
    $this->form_validation->set_rules('loan_address', '담보물주소', 'xss_clean');
    $this->form_validation->set_rules('loan_price', '담보시세', 'required|xss_clean');
    $this->form_validation->set_rules('loan_sum', '희망금액', 'required|is_natural_no_zero');
    $this->form_validation->set_rules('loan_liabilities', '부채현황', 'required|is_natural');
    $this->form_validation->set_rules('loan_income', '월소득', 'required|is_natural_no_zero');

    $this->form_validation->set_rules('loan_term', '대출기간', 'required|is_natural_no_zero');
    $this->form_validation->set_rules('loan_interest', '희망금리', 'xss_clean');
    $this->form_validation->set_rules('loan_repay', '대출상환일', 'required|is_natural_no_zero');

    $this->form_validation->set_message('required', '%s(을)를 확인해주세요');
    $this->form_validation->set_message('min_length', '%s(은)는 %d글자 이상입니다');
    $this->form_validation->set_message('max_length', '%s(은)는 %d글자까지 가능합니다.');
    $this->form_validation->set_message('numeric', '%s(은)는 숫자만 가능합니다');
    $this->form_validation->set_message('valid_email', '%s(을)를 확인해주세요');
    $this->form_validation->set_message('is_natural_no_zero', '%s(은)는 0 보다 큰 숫자만 가능합니다');
    $this->form_validation->set_message('is_natural', '%s(은)는 숫자만 가능합니다');
    $this->form_validation->set_error_delimiters('','');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }
    $data = array();
    $data['mem_id'] = $this->user['info']['m_id'];
      foreach ($_POST as $idx=>$val) $data[$idx] = $this->input->post($idx);
      $this->db->insert('z_loan_application', $data);
      $this->json(array('code'=>200, 'msg'=> "OK" ));
  }

  function preauthcheck() {
    if(trim($this->user['seyfert']['s_accntNo']) =='' ) {
      $this->json(array('code'=>500, 'msg'=>'투자자가상계좌를 만드신 후 사용가능합니다.'));return;
    }
    $url = "https://v5.paygate.net/v5/transaction/pending/preAuth/register";
    $_method = "GET";
    $refId =$nonce = "PAul".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&authOrg=015&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId."&dstMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&srcMemGuid=".$this->user['seyfert']['s_memGuid'];

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      $trnsctnSt = isset($data['data']['detailList'][0]['trnsctnSt']) ? $data['data']['detailList'][0]['trnsctnSt'] :'';//PRE_AUTH_REG_FINISHED
      $tid = isset($data['data']['detailList'][0]['tid'] ) ? $data['data']['detailList'][0]['tid'] : '';
        //            $ret['cmpltDt']  = date ("Y-m-d", (int)($row['cmpltDt']/1000) );
      if($tid != ''){
        if ($trnsctnSt != '') {
          $ret= $this->preauthcodemap($trnsctnSt);
          if($ret['code']==200){
            $ret['duration']  = date ("Y-m-d", (int)($data['data']['detailList'][0]['cmpltDt']/1000) );
          }
        }else {
            $ret = array('code'=>500,'msg'=>'에러발생 다시 시도해주세요');
        }
      }else {
        $ret = array('code'=>400,'msg'=>'미인증');
        $tmp = $this->db->query("select  a.*, unix_timestamp(now()) as ntime,date_format(date_add(updatetime, interval 90 day),'%Y-%m-%d') as expire  from z_seyfert_preauth a where m_id = ? order by updatetime desc limit 1", array($this->user['info']['m_id']))->row_array();
        if( isset( $tmp['m_id'] ) && $tmp['trnsctnSt']=='' && $tmp['ntime'] < $tmp['expireDt'] ) $ret = array('code'=>202, 'msg'=>'seyfert에 인증 요청을 한 상태입니다.');

      }
    }else {
      $ret = array('code'=>500,'msg'=>'에러발생 다시 시도해주세요');
    }
    $this->json($ret);

  }
  function lnq() {
    $url = "https://v5.paygate.net/v5/member/seyfert/inquiry/balance";
    $_method = "POST";
    $nonce      = "VE" . time() . rand(111, 999);
    $refid      = "VEr" . time() . rand(111, 999);
    $ENCODE_PARAMS ="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refid."&dstMemGuid=".$this->user['seyfert']['s_memGuid']."&crrncy=KRW";
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );

    if( !$res ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );
    }else if ( $data['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>"ERROR OCCURED", 'data'=>$data ) );
    }else {
      $amount = isset( $data['data']["moneyPair"]["amount"] ) ? (int) $data['data']["moneyPair"]["amount"] : '0';
      if($this->input->post('mn') == 'angelfunding') {
          $rows = $this->db->query('select * from z_balance_log order by regdate desc limit 2')->result_array();
          $row = $rows[0];
          $balance = (isset($row['balance']) ) ? $row['balance'] : '0' ;
          if ($balance != $amount ) $this->db->insert ('z_balance_log', array('balance'=>$amount) ) ;
          $data = array(
            'beforebalance'=>$rows[1]['balance'],'beforetime'=>$rows[1]['regdate'], 'amount2'=>number_format($amount - $rows[1]['balance'])
          );
      }
      $this->json( array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>array('amount'=>$amount,'han'=>$this->getConvertNumberToKorean($amount), 'data'=>$data) ) );
    }
  }
  function withdraw () {
    /*188090 p2p 사유코드 로 수정 */
    $this->load->library('form_validation');
    $this->form_validation->set_rules('o_pay', '희망금액', 'required|is_natural_no_zero');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> "출금액을 확인해주세요" ));
    }
    $withdraw_money = (int)$this->input->post('o_pay');
    if( !isset($this->user['seyfert']['s_memGuid'])){
      $this->json(array('code'=>500, 'msg'=> "KEY 를 확인할 수 없습니다. 관리자에게 문의해주세요" ));
    }
    $sql = "select if(m_emoney<1,0,m_emoney) as m_emoney from mari_member where m_id = ?";
    $top_emoney = $this->db->query($sql, array($this->user['info']['m_id']))->row_array();
    if( (int)$top_emoney['m_emoney'] < $withdraw_money){
      $this->json(array('code'=>500, 'msg'=> "출금 가능액은 ".number_format($top_emoney['m_emoney'])."원 입니다." ));
    }
    $title = number_format($withdraw_money)."원 출금신청";

    $url = "https://v5.paygate.net/v5/transaction/seyfert/withdraw/p2p";
    $_method = "POST";
    $refid      = $nonce      = "Wd" . time() . rand(111, 999);
    if( $this->user['info']['m_signpurpose'] =='L'){
      if((int)$this->user['info']['m_level']>=3) $dstMemType = 'BB';//기업대출
      else $dstMemType = 'BA';//개인대출
      $transferReason = "borrower";
    }else if( (int)$this->user['info']['m_level']>=3 ){
      $dstMemType = 'IC';//법인투자
      $transferReason = "investor";
    }else if(  $this->user['info']['m_signpurpose']=='C2' ){
      $dstMemType = 'IC';//법인 투자 , 법인대부사업자투자자
      $transferReason = "investor";
    }else if ( in_array( $this->user['info']['m_signpurpose'], array('I','P','I2') )){
      $dstMemType = 'IB';//소득요건 충족자 일반투자
      $transferReason = "investor";
    }else {
      $dstMemType = 'IA';//일반투자
      $transferReason = "investor";
    }
    $ENCODE_PARAMS   = "&_method=".$_method."&desc=desc&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce. "&refId=".$refid."&dstMemGuid=".$this->user['seyfert']['s_memGuid']. "&crrncy=KRW";
    $ENCODE_PARAMS .= "&authType=SMS_MO&timeout=30"."&title=".urlencode($title)."&amount=".$withdraw_money;
    $ENCODE_PARAMS .= "&dstMemType=".$dstMemType."&transferReason=".$transferReason;
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      if( isset($data['data']['tid']) && $data['data']['tid'] !='') {
        $set = array(
          "s_refId"=>$refid
          ,"m_id"=>$this->user['info']['m_id']
          ,"m_name"=>$this->user['info']['m_name']
          ,"s_subject"=>$title
          ,"s_amount"=>$withdraw_money
          ,"s_type"=>'2'
          ,"s_date"=>date('Y-m-d H:i:s')
          ,"s_tid"=>$data['data']['tid']
        );
        $this->db->insert('mari_seyfert_order', $set);
        $set = array(
          "m_id"=>$this->user['info']['m_id']
          ,"m_name"=>$this->user['info']['m_name']
          ,"o_pay"=>$withdraw_money
          ,"o_fin"=>'N'
          ,"o_refId"=>$refid
          ,"o_ip"=>$this->input->ip_address()
          ,"o_regdatetime"=>date('Y-m-d H:i:s')
        );
        $this->db->insert('mari_outpay', $set);
        $this->json(array('code'=>200, 'msg'=>$title."을 완료하였습니다."));
      }else {
        $this->json(array('code'=>500, 'msg'=>"알 수 없는 에러가 발생했습니다. 잠시후에 시도해주세요"));
      }
    }else $this->json(array('code'=>501, 'msg'=>$data['data']["cdDesc"]));
  }
  function withdraw_ () {
    $this->load->library('form_validation');
    $this->form_validation->set_rules('o_pay', '희망금액', 'required|is_natural_no_zero');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> "출금액을 확인해주세요" ));
    }
    $withdraw_money = (int)$this->input->post('o_pay');
    if( !isset($this->user['seyfert']['s_memGuid'])){
      $this->json(array('code'=>500, 'msg'=> "KEY 를 확인할 수 없습니다. 관리자에게 문의해주세요" ));
    }
    $sql = "select if(m_emoney<1,0,m_emoney) as m_emoney from mari_member where m_id = ?";
    $top_emoney = $this->db->query($sql, array($this->user['info']['m_id']))->row_array();
    if( (int)$top_emoney['m_emoney'] < $withdraw_money){
      $this->json(array('code'=>500, 'msg'=> "출금 가능액은 ".number_format($top_emoney['m_emoney'])."원 입니다." ));
    }
    $title = number_format($withdraw_money)."원 출금신청";

    $url = "https://v5.paygate.net/v5/transaction/seyfert/withdraw";
    $_method = "POST";
    $refid      = $nonce      = "Wd" . time() . rand(111, 999);

    $ENCODE_PARAMS   = "&_method=".$_method."&desc=desc&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce. "&refId=".$refid."&dstMemGuid=".$this->user['seyfert']['s_memGuid']. "&crrncy=KRW";
    $ENCODE_PARAMS .= "&authType=SMS_MO&timeout=30"."&title=".urlencode($title)."&amount=".$withdraw_money;
  //  $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=" . $this->seyfertinfo['c_reqMemGuid'] . "&nonce=n" . $nonce . "&title=" . urlencode($title) . "&refId=" . $refid . "&authType=SMS_MO&timeout=30&dstMemGuid=" . $this->user['seyfert']['s_memGuid'] . "&amount=" . $withdraw_money . "&crrncy=KRW";

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      if( isset($data['data']['tid']) && $data['data']['tid'] !='') {
        $set = array(
          "s_refId"=>$refid
          ,"m_id"=>$this->user['info']['m_id']
          ,"m_name"=>$this->user['info']['m_name']
          ,"s_subject"=>$title
          ,"s_amount"=>$withdraw_money
          ,"s_type"=>'2'
          ,"s_date"=>date('Y-m-d H:i:s')
          ,"s_tid"=>$data['data']['tid']
        );
        $this->db->insert('mari_seyfert_order', $set);
        $set = array(
          "m_id"=>$this->user['info']['m_id']
          ,"m_name"=>$this->user['info']['m_name']
          ,"o_pay"=>$withdraw_money
          ,"o_fin"=>'N'
          ,"o_refId"=>$refid
          ,"o_ip"=>$this->input->ip_address()
          ,"o_regdatetime"=>date('Y-m-d H:i:s')
        );
        $this->db->insert('mari_outpay', $set);
        $this->json(array('code'=>200, 'msg'=>$title."을 완료하였습니다."));
      }else {
        $this->json(array('code'=>500, 'msg'=>"알 수 없는 에러가 발생했습니다. 잠시후에 시도해주세요"));
      }
    }else $this->json(array('code'=>501, 'msg'=>$data['data']["cdDesc"]));
  }
  function translist() {
    $startdate = $this->input->get('startdate') == "" ? date('Y-m-d'):$this->input->get('startdate');
    $endtdate = $this->input->get('endtdate') == "" ?  date('Y-m-d'):$this->input->get('endtdate');
    $ord = $this->input->get('list_top') !="ASC" ? "DESC":"ASC";
    $sql = "select date_format(p_datetime,'%Y-%m-%d') as p_datetime,p_content, FORMAT(p_emoney,0) p_emoney ,FORMAT(p_top_emoney,0) p_top_emoney   from mari_emoney where m_id = ?  and p_datetime >= ? and p_datetime <= ? order by p_datetime ".$ord;
    $list = $this->db->query($sql, array($this->user['info']['m_id'], $startdate." 00:00:00", $endtdate." 23:59:59", $ord))->result_array();
    $this->json( array('cnt'=>count($list), "list"=>$list) );
  }
  function member_bankname($ret= false) {
    $name = trim($this->input->post('m_my_bankname'));
    if($name == '' ){
      $this->json(array('code'=>500, 'msg'=>"계좌주를 확인해주세요"));
    }
    $url = "https://v5.paygate.net/v5a/member/allInfo";
    $_method = "PUT";
    $refId =$nonce = "Ran".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&nmLangCd=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId;
    $ENCODE_PARAMS.="&dstMemGuid=".$this->user['seyfert']['s_memGuid'];
    $ENCODE_PARAMS.="&fullname=".urlencode($name);

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );

    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      if(isset($data['data']['result']['name']['status']) && $data['data']['result']['name']['status']=='STORED'){
        $this->db->where ('m_id', $this->user['info']['m_id'])->update('mari_member', array('m_my_bankname'=> $name) );
        if($ret) return true;
        else $this->json(array('code'=>200, 'msg'=>"요청을 완료하였습니다."));
      }else $this->json(array('code'=>502, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));

    }else $this->json(array('code'=>501, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
  }
  //계좌등록요청
  function changeaccnt() {
    if ( !isset( $this->user['seyfert']['s_memGuid']) ) {
      $this->json( array('code'=>201 ,'msg'=>'NONE GUID') );
      return;
    }
    $this->load->library('form_validation');
    $this->form_validation->set_rules('m_my_bankcode', '은행', 'required|xss_clean');
    $this->form_validation->set_rules('m_my_bankacc', '계좌', 'required|numeric');
    $this->form_validation->set_rules('m_my_bankname', '계좌주', 'required|css_clean|min_length[2]');
    if ($this->form_validation->run() == FALSE)
    {
      $this->json(array('code'=>500, 'msg'=> validation_errors() ));
    }
if( $this->user['info']['m_my_bankname'] != $this->input->post('m_my_bankname') ){
  $this->member_bankname(true);
}
    $url = "https://v5.paygate.net/v5a/member/bnk";
    $_method = "POST";
    $refId =$nonce = "Rac".time().rand(111,99);
    $ENCODE_PARAMS="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&nonce=".$nonce."&refId=".$refId;
    $ENCODE_PARAMS.="&dstMemGuid=".$this->user['seyfert']['s_memGuid'];
    $ENCODE_PARAMS.="&accntNo=".$this->input->post('m_my_bankacc')."&bnkCd=".$this->input->post('m_my_bankcode')."&cntryCd=KOR";

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if(!$res){
      $this->json(array('code'=>500, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));
    }else if ($data['status'] =='SUCCESS'){
      $this->db->where ('m_id', $this->user['info']['m_id'])->update('mari_member', array('m_my_bankcode'=> $this->input->post('m_my_bankcode'),'m_my_bankacc'=> $this->input->post('m_my_bankacc'), 'm_verifyaccountuse'=>'N') );
      $this->json(array('code'=>200, 'msg'=>"요청을 완료하였습니다."));
    }else $this->json(array('code'=>501, 'msg'=>"에러가 발생했습니다. 잠시후에 시도해주세요"));


  }
  protected function json( $data = '' ){
    //header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>500, 'msg'=>'알수없는 오류가 발생하였습니다.');
    else if($data=='login') $data = array ( 'code'=>201, 'msg'=>'로그인 후 사용해 주세요');
    echo json_encode( $data );
    exit;
  }
  /* seyfert 통신 */
  protected function getres($_method,$url, $ENCODE_PARAMS ){
    include_once(PluginPath);
    $cipher = AesCtr::encrypt($ENCODE_PARAMS, $this->seyfertinfo['c_reqMemKey'], 256);
    $cipherEncoded = urlencode($cipher);
    $requestString = "_method=".$_method."&reqMemGuid=".$this->seyfertinfo['c_reqMemGuid']."&encReq=".$cipherEncoded;
    $requestPath = $url."?".$requestString;
    $curl_handlebank = curl_init();
    curl_setopt($curl_handlebank, CURLOPT_URL, $requestPath);
    /*curl_setopt($curl_handle, CURLOPT_ENCODING, 'UTF-8');*/
    curl_setopt($curl_handlebank, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($curl_handlebank, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl_handlebank, CURLOPT_SSL_VERIFYPEER, 0); //CURLOPT_SSL_VERIFYPEER is needed for https request.
    curl_setopt($curl_handlebank, CURLOPT_USERAGENT, $url);
    $result = curl_exec($curl_handlebank);
    if( $result===false ) $curlerror = curl_error($curl_handlebank);
    curl_close($curl_handlebank);
    $decode = json_decode($result, true);
    if( !is_array( $decode) )   return array(false, $curlerror);
    else return array(true, $decode);
  }
  protected function getConvertNumberToKorean($_number)
{
  $number_arr = array('','일','이','삼','사','오','육','칠','팔','구');
  $unit_arr1 = array('','십','백','천');
  $unit_arr2 = array('','만','억','조','경','해');
  $result = array();
  $reverse_arr = str_split(strrev($_number), 4);
  $result_idx =0;
  foreach($reverse_arr as $reverse_idx=>$reverse_number){
    $convert_arr = str_split($reverse_number);
    $convert_idx =0;
    foreach($convert_arr as $split_idx=>$split_number){
      if(!empty($number_arr[$split_number])){
        $result[$result_idx] = $number_arr[$split_number].$unit_arr1[$split_idx];
        if(empty($convert_idx)) $result[$result_idx] .= $unit_arr2[$reverse_idx];
        ++$convert_idx;
      }
      ++$result_idx;
    }
  }
  $result = implode('', array_reverse($result));
  return $result;
}
  protected function preauthcodemap($code){
    if($code=='PRE_AUTH_REG_FINISHED'){
      return array('code'=>200, 'msg'=>'인증완료.');
    }
    if($code=='REQUEST_HAS_TIME_OUT') {
      return array('code'=>400, 'msg'=>'요청시간경과.');//return false; //요청시간 경과
    }
    if($code=='PRE_AUTH_REG_TRYING'){
      return array('code'=>203, 'msg'=>'문자수신대기중');
    }
    if($code=='PRE_AUTH_REG_DEREGED_SELF'){
      return array('code'=>400, 'msg'=>'문자로 해지요청.');//return false; //문자로 해지
    }
    if($code =='PRE_AUTH_REG_DEREGED'){
      return array('code'=>400, 'msg'=>'선인증해지.');//return false; //문자로 해지
    }
    else return array('code'=>400, 'msg'=>'구분없음');
    /*
    $map = array(
      'PRE_AUTH_REG_FINISHED'=>'인증완료','REQUEST_HAS_TIME_OUT'=>'요청시간경과','PRE_AUTH_REG_TRYING'=>'문자응답대기중','PRE_AUTH_REG_DEREGED_SELF'=>'문자로해지'
    );
    return (isset($map[$code])) ? $map[$code] : $code;
    */
  }
    public function code($code=''){
  /*
        $fp = fopen("/var/www/html/tmp/code.txt","r");
        while( !feof($fp) ) {
          $doc_data = fgets($fp);
          $tmp = explode(' ', trim($doc_data) );

          echo"'".array_shift($tmp)."'=>'".implode(' ', $tmp)."',
          ";
        }
        fclose($fp);
        return;*/
        $tcode =array('ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체', 'ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체',);
        $scode= array(
   'ACQUIRING_BANK_AGREEMENT'=> '세이퍼트 출금 동의',  'AGREE_FORCED_BY_MERCHANT'=> '세이퍼트 펜딩 이체 완료 (낮은 금액에 대한 미인증 이체) ',  'ARS_DENIED'=> 'ARS 인증 실패 ',  'ARS_FINISHED'=> 'ARS 인증 완료',  'ARS_INIT'=> 'ARS 인증 시작',  'ARS_TRYING'=> 'ARS 인증 고객 응답 대기',  'ASSIGN_VACCNT_FINISHED'=> '가상계좌 할당 성공',  'ASSIGN_VACCNT_INIT'=> '가상계좌 할당 시작',  'BANK_DEPOSIT_PAYIN_FINISHED'=> '은행 입금 입력 완료',  'BANK_DEPOSIT_PAYIN_INIT'=> '은행 입금 입력 시작 ',  'BANK_DEPOSIT_PAYOUT_FINISHED'=> '은행 출금 입력 완료 ',  'BANK_DEPOSIT_PAYOUT_INIT'=> '은행 출금 입력 시작 ',  'BANK_TRAN_ROLL_BACK'=> '세이퍼트 출금 실패에 따른 롤백',  'BANK_TRAN_ROLL_BACK_PASSBOOK'=> '세이퍼트 출금 실패에 따른 롤백',  'BATCH_RCRR_CANCELED'=> '자동이체 취소',  'BATCH_RCRR_ENOUGH_MONEY'=> '자동이체 2일전 잔고 충분 통보',  'BATCH_RCRR_INIT'=> '자동이체 초기화 ',  'BATCH_RCRR_NOTI_MONEY'=> '자동이체 2일전 잔고 부족 통보 ',  'BATCH_RCRR_RUN_DONE'=> '자동이체 완료 ',  'BATCH_RCRR_RUN_FAILED'=> '자동이체 실패',  'BATCH_RCRR_TRYING'=> '자동이체 진행 중',  'BATCH_UNLIMITED_RSRV_CANCELED'=> '무한 예약 이체 취소',  'BATCH_UNLIMITED_RSRV_TRYING'=> '무한 예약이체 처리 중 ',  'CHECK_BNK_ACCNT_FINISHED'=> '예금주 조회 완료',  'CHECK_BNK_EXISTANCE_CHECKED'=> '실계좌 확인 완료',  'CHECK_BNK_CD_FINISHED'=> '예금주 코드 검증 완료',  'CHECK_BNK_CD_INIT'=> '예금주 코드 검증 초기화 ',  'CHECK_BNK_NM_DENIED'=> '예금주명 조회 거절 ',  'CHECK_BNK_NM_FINISHED'=> '예금주명 조회 완료',  'CHECK_BNK_NM_INIT'=> '예금주명 조회 초기화',  'ESCROW_CANCELED'=> '에스크로 취소 ',  'ESCR_RELEASE_CANCELED'=> '에스크로 해제 취소',  'ESCR_RELEASE_CHLD_FINISHED'=> '에스크로 이체 원거래 해제됨',  'ESCR_RELEASE_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_APPROVED'=> '에스크로 해제 요청 승인',  'ESCR_RELEASE_REQ_AUTO_DONE'=> '에스크로 해제 자동 완료 ',  'ESCR_RELEASE_REQ_AUTO_ERROR'=> '에스크로 해제 자동 완료 에러',  'ESCR_RELEASE_REQ_AUTO_FINISHED'=> '에스크로 해제 요청 자동 완료',  'ESCR_RELEASE_REQ_AUTO_PROCESS'=> '에스크로 해제 자동 완료 진행 ',  'ESCR_RELEASE_REQ_CANCELED'=> '에스크로 해제 요청 취소',  'ESCR_RELEASE_REQ_DENIED'=> '에스크로 해제 요청 거부',  'ESCR_RELEASE_REQ_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_HOLD'=>'에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_INIT'=>'에스크로 해제 요청 시작',  'ESCR_RELEASE_REQ_TRYING'=>'에스크로 해제 요청 승인 시작',  'ESCR_RELEASE_REQ_TRY_FAILED'=>'에스크로 해제 요청 실패',  'EXCHANGE_MONEY_DENIED'=>'환전 거절',  'EXCHANGE_MONEY_FINISHED'=>'환전 완료',  'EXCHANGE_MONEY_INIT'=>'환전 시작',  'MO_DENIED'=>'MO 요청 거절',  'MO_DONE'=>'MO 요청 완료',  'MO_FINISHED'=>'MO 요청 완료',  'MO_INIT'=>'MO 요청 초기화',  'MO_TRYING'=>'MO 요청 진행중',  'NOT_ENOUGH_BAL_TO_PAY_FEE'=>'거래 실패 (충전금 부족)',  'NOT_VRFY_BNK_CD_KYC'=>'NOT_VRFY_BNK_CD_KYC',  'PAYIN_VACCNT_KYC_ACTIVATED'=>'KYC 가상계좌 입금 활성화',  'PAYIN_VACCNT_KYC_FAILED'=>'KYC 가상계좌 입금 실패',  'PAYIN_VACCNT_KYC_FINISHED'=>'KYC 가상계좌 입금 완료',  'PAYIN_VACCNT_KYC_INIT'=>'KYC 가상계좌 입금 초기화',  'PAYIN_VACCNT_KYC_REQ_TRYING'=>'KYC 가상계좌 입금 요청',  'PAYIN_VACCNT_KYC_SENDING_1WON'=>'KYC 가상계좌 입금 코드 전송',  'REG_RCRR_EXP_DT'=>'등록 중 최초거래보다 경과됨',  'REG_RCRR_INIT'=>'자동이체 등록 초기화',  'REG_RCRR_PARENT_CANCELED'=>'자동이체 부모 거래가 취소',  'REG_RCRR_REQ_FINISHED'=>'자동이체 등록 인증 완료',  'REG_RCRR_REQ_TRYING'=>'자동이체 등록 인증 진행 중',  'REG_RCRR_REQ_TRY_FAILED'=>'자동이체 등록 인증 실패',  'REQUEST_HAS_TIME_OUT'=>'요청 시간 경과',  'SEND_MONEY_FAILED'=>'송금 실패',  'SEND_MONEY_FINISHED'=>'송금 완료',  'SEND_MONEY_INIT'=>'송금 초기화',  'SEND_MONEY_ROLL_BACK'=>'송금 완료 후 은행 거절 반환 (입금 불능)',  'SEND_SMS_BNK_CD_FAILED'=>'SMS 수신 코드 매칭 실패',  'SFRT_PAYIN_RSRV_MATCHED'=>'세이퍼트 예약 입금 완료',  'SFRT_PAYIN_VACCNT_FAILED'=>'세이퍼트 입금 실패',  'SFRT_PAYIN_VACCNT_FINISHED'=>'세이퍼트 입금 완료',  'SFRT_PAYIN_VACCNT_INIT'=>'세이퍼트 입금 시작',  'SFRT_RSRV_PND_INIT'=>'예약 펜딩 거래 시작',  'SFRT_RSRV_PND_TRYING'=>'예약 펜딩 거래 고객 승인 대기',  'SFRT_TRNSFR_CANCELED'=>'세이퍼트 이체 취소',  'SFRT_TRNSFR_CHLD_CANCELED'=>'세이퍼트 펜딩 원거래 취소됨',  'SFRT_TRNSFR_ESCR_AUTO_DONE'=>'에스크로 해제 자동 완료',  'SFRT_TRNSFR_ESCR_DONE'=>'에스크로 해제 완료',  'SFRT_TRNSFR_FINISHED'=>'세이퍼트 이체 완료',  'SFRT_TRNSFR_INIT'=>'세이퍼트 이체 시작',  'SFRT_TRNSFR_PND_AGRREED'=>'세이퍼트 펜딩 거래 동의',  'SFRT_TRNSFR_PND_CANCELED'=>'세이퍼트 펜딩 거래 취소',  'SFRT_TRNSFR_PND_CHLD_RELEASED'=>'세이퍼트 펜딩 원거래 해제됨',  'SFRT_TRNSFR_PND_INIT'=>'세이퍼트 펜딩 거래 초기화',  'SFRT_TRNSFR_PND_RELEASED'=>'세이퍼트 펜딩 거래 해제',  'SFRT_TRNSFR_PND_RELEASE_INIT'=>'세이퍼트 펜딩 거래 해제 초기화',  'SFRT_TRNSFR_PND_TRYING'=>'세이퍼트 펜딩 거래 요청 중',  'SFRT_TRNSFR_REQ_APPROVED'=>'세이퍼트 이체 요청 승인',  'SFRT_TRNSFR_REQ_CANCELED'=>'세이퍼트 이체 요청 취소',  'SFRT_TRNSFR_REQ_DENIED'=>'세이퍼트 이체 요청 거부',  'SFRT_TRNSFR_REQ_FINISHED'=>'세이퍼트 이체 요청 완료',  'SFRT_TRNSFR_REQ_INIT'=>'세이퍼트 이체 요청 시작',  'SFRT_TRNSFR_REQ_TRYING'=>'세이퍼트 이체 요청 승인 처리중',  'SFRT_TRNSFR_REQ_TRY_FAILED'=>'세이퍼트 이체 요청 실패',  'SFRT_TRNSFR_RSRV_EXPIRED'=>'세이퍼트 예약입금이체 입금 시간 경과',  'SFRT_TRNSFR_RSRV_FINISHED'=>'세이퍼트 예약입금이체 실패',  'SFRT_TRNSFR_RSRV_INIT'=>'세이퍼트 예약입금이체 초기화',  'SFRT_TRNSFR_RSRV_MATCHED'=>'세이퍼트 예약입금이체 매칭',  'SFRT_TRNSFR_RSRV_TRYING'=>'세이퍼트 예약입금이체 진행 중',  'SFRT_WITHDRAW_CANCELED'=>'세이퍼트 출금 취소',  'SFRT_WITHDRAW_FAILED'=>'세이퍼트 출금 실패',  'SFRT_WITHDRAW_FINISHED'=>'세이퍼트 출금 완료',  'SFRT_WITHDRAW_FINISH_BNK_CD'=>'세이퍼트 출금 중 계좌주 코드 검증',  'SFRT_WITHDRAW_FINISH_BNK_NM'=>'세이퍼트 출금 중 예금주 이름 검증',  'SFRT_WITHDRAW_INIT'=>'세이퍼트 출금 시작',  'SFRT_WITHDRAW_MONEY_REQUSTED'=>'세이퍼트 출금 처리 전송됨',  'SFRT_WITHDRAW_REQ_TRYING'=>'세이퍼트 출금 요청 진행 중',  'SMS_API_FINISHED'=>'SMS API 완료',  'SMS_API_INIT'=>'SMS API 초기화',  'UNLIMITED_RESERVE_CANCELED'=>'무한 예약 이체 취소',  'UNLIMITED_RESERVE_INIT'=>'무한 예약 이체 초기화',  'UNLIMITED_RESERVE_MATCHED'=>'무한 예약 이체 매치',  'UNLIMITED_RESERVE_RUNNING'=>'무한 예약 이체 실행중',  'VRFY_BNK_CD_COUNT_EXCEED'=>'예금주 권한 검증을 위한 1원 송금 10회 초과',  'VRFY_BNK_CD_DONE'=>'예금주 권한 검증 완료',  'VRFY_BNK_CD_REQ_TRYING'=>'예금주 권한 검증 1원 송금 후 문자 발송',  'VRFY_BNK_CD_SENDING_1WON'=>'예금주 권한 검증을 위한 1원 송금',  'VRFY_BNK_NM_DONE'=>'예금주 이름 검증 완료',  'VRFY_BNK_NM_REQ_TRYING'=>'예금중 이름 검증 진행 중','ASSIGN_VACCNT_UNASSIGNED'=>'가상계좌해지','BNK_NM_NEED_REVIEW'=>'계좌주이름확인팰요'
      );

      return ( isset($scode[$code]) )? $scode[$code]."(".$code.")" :  ( ( isset( $tcode[$code]) ) ? $tcode[$code]."(".$code.")" : $code ) ;
    }

    function jumincheck($resno) {
      // 형태 검사: 총 13자리의 숫자, 7번째는 1..4의 값을 가짐
      if (!preg_match('/^[[:digit:]]{6}[1-6][[:digit:]]{6}$/', $resno,$matches))
        return false;
      // 날짜 유효성 검사
      $birthYear = ('2' >= $resno[6]) ? '19' : '20';
      $birthYear += substr($resno, 0, 2);
      $birthMonth = substr($resno, 2, 2);
      $birthDate = substr($resno, 4, 2);
      if (!checkdate($birthMonth, $birthDate, $birthYear))
        return false;
      // Checksum 코드의 유효성 검사
      for ($i = 0; $i < 13; $i++) $buf[$i] = (int) $resno[$i];
      if( $buf[6] > 4){
        return $this->isForeSSN($resno);
      }else {
        $multipliers = array(2,3,4,5,6,7,8,9,2,3,4,5);
        for ($i = $sum = 0; $i < 12; $i++) $sum += ($buf[$i] *= $multipliers[$i]);
        if ((11 - ($sum % 11)) % 10 != $buf[12]) return false;
      }
      // 모든 검사를 통과하면 유효한 주민등록번호임
      return true;
    }
  function  isForeSSN ($socno) {
   $total =0;
   $parity = 0;
   $fgnNo = array();
  for($i=0;$i < 13;$i++) $fgnNo[] = (int)$socno[$i];
  // if($fgnNo[11] < 6) return false;//<---- 이부분 때문에 에러가나는 경우가 있을 것이다.(과거에는 체크해야하지만, 지금은 체크하면 안된다.
   if(($parity = $fgnNo[7]*10 + $fgnNo[8])&1) return false;
   $weight = 2;
   for($i=0,$total=0;$i < 12;$i++)
   {
    $sum = $fgnNo[$i] * $weight;
    $total += $sum;
    if(++$weight > 9) $weight=2;
   }
   if(($total = 11 - ($total%11)) >= 10) $total -= 10;
   if(($total += 2) >= 10) $total -= 10;
   if($total != $fgnNo[12]) return false;
   return true;
  }
}
