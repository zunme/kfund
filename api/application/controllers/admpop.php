<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//require_once APPPATH . '/controllers/adm.php';
date_default_timezone_set('Asia/Seoul');
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');
class  Admpop extends CI_Controller {
  var $msg;
  var $today;

  public function _remap($method) {
    $this->today = strtotime(date('Y-m-d',strtotime('now')));
    $this->db = $this->load->database('real',true);
    $this->{$method}();
  }
  function ipgum() {
    $this->load->view('adm_pop_ipgum');
  }
  function ipgumlist(){
    $tabledata = $this->datatableparse();
    $where='';
    if($tabledata['search3']!='') $where .=" and m_id like '%".$tabledata['search3']."%' or m_name like '%".$tabledata['search3']."%' ";
    if($tabledata['trnsctnSt']!='') $where .=" and trnsctnSt ='".$tabledata['trnsctnSt']."' ";

    if($tabledata['startdate']!='') $where .=" and s_date >='".$tabledata['startdate']." 00:00:00' ";
    if($tabledata['enddate']!='') $where .=" and s_date <='".$tabledata['enddate']." 23:59:59' ";

    if($tabledata['order'] == '' ) $tabledata['order']= 's_id';
    if($tabledata['order_dir'] =='' ) $tabledata['order']= 'desc';

    $limit = ( $tabledata['length'] =="All") ? "" : " limit ".$tabledata['start']." , ".$tabledata['length'];
    $sql = "select
    a.s_id ,a.m_id , a.m_name , a.s_amount , a.s_tid, a.s_date,a.trnsctnTp, a.trnsctnSt
    , case
    	when( a.trnsctnSt = 'SFRT_PAYIN_PVACCNT_FINISHED' ) then '입금'
    	when( a.trnsctnSt = 'SFRT_PAYIN_VACCNT_FINISHED' ) then '충전'
    	when( trim(a.trnsctnSt) = '' ) then '확인필요'
    	else 'UNKNOWN'
    	end as ipgum_type
      , mem.m_emoney
    from mari_seyfert_order a
    left join mari_member mem on a.m_id = mem.m_id and a.trnsctnSt =  'SFRT_PAYIN_VACCNT_FINISHED'
    where s_type=4
    ".$where."
    order by ".$tabledata['order']." ".$tabledata['order_dir'].$limit;

    $userlist = $this->db->query($sql)->result_array();

    $sql = " select ifnull(count(1),0) as cnt , ifnull(sum(s_amount),0) as total2
    , ifnull( sum(
       case
       when (m_name != '주식회사엔젤크라우' and m_name != '주식회사엔젤크라우드') then s_amount
       else 0 end) ,0) as total
    from mari_seyfert_order a where s_type=4 ".$where;

    $tmp = $this->db->query($sql)->row_array();
    $page = ( $tabledata['length'] =="All") ? "1" : (int)($tmp['cnt']/$tabledata['length'])+1;

    $ret['page'] = '1';
    $ret['draw'] = $this->input->get('draw');
    $ret['ordering'] = $tabledata['order']." ".$tabledata['order_dir'];
    $ret['recordsFiltered'] =$ret['recordsTotal'] = $data['data']['totalRecord']=$tmp['cnt'];
    $ret['sum'] = $tmp['total'];
    $ret['data'] = $userlist;
    $ret['table'] = $tabledata;
    echo json_encode($ret);
  }
  function changedata() {
    $set = array();
    $set['m_id'] = trim($this->input->post('new_id'));
    $set['m_name'] = trim($this->input->post('new_name'));
    $where = trim($this->input->post('s_id'));
    if ((int)$where < 0 ){
      echo json_encode( array('code'=>400, 'msg'=>'KEY ERROR') );
    }else {
      $this->db->where('s_id', $where)->update('mari_seyfert_order', $set);
      echo json_encode( array('code'=>200, 'msg'=>'') );
    }

  }
  function tiddesc(){
    include_once(PluginPath);
    $url = "https://v5.paygate.net/v5a/admin/transaction/detail";
//$url = "https://v5.paygate.net/v5a/admin/transaction/list";
    $config = $this->db->query(" select * from mari_config ")->row_array();
    $KEY_ENC    = $config['c_reqMemKey'];
    $ENCODE_PARAMS="&_method=GET&desc=desc&_lang=ko&reqMemGuid=".$config['c_reqMemGuid']."&tid=".$this->input->get('tid');
    $cipher = AesCtr::encrypt($ENCODE_PARAMS, $KEY_ENC, 256);
    $cipherEncoded = urlencode($cipher);
    $requestString = "_method=GET&reqMemGuid=".$config['c_reqMemGuid']."&encReq=".$cipherEncoded;

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
    if ($result===false) echo json_encode( array('code'=>500, 'msg'=>$curlerror) );
    else {
      $decode = json_decode($result, true);
      if( isset($decode['data']['detailList'][0])) {
        $user = array();
        $data = $decode['data']['detailList'][0];
        if($decode['data']['detailList'][0]['srcMemGuid'] !='' ) {
          $user = $this->db->select('m_id,m_name')->get_where('mari_seyfert', array('s_memGuid'=>$decode['data']['detailList'][0]['srcMemGuid']))->row_array();
          $tmp2 = $this->db->select('m_name')->get_where('mari_member', array('m_id'=>$user['m_id']))->row_array();
          $user['m_name2'] = $tmp2['m_name'];
        }
        else {$user['m_id']='';$user['m_name']='';$user['m_name2']='';}
        $data =array_merge($data, $user);
        echo json_encode( array('code'=>200, 'msg'=>'', 'data'=>$data) );
      }else {
        echo json_encode( array('code'=>501, 'msg'=>'NONE') );
      }
    }

  }
  private function datatableparse(){
    $order = $this->input->get('order');
    $columns = $this->input->get('columns');
    $length = $this->input->get('length')=='All'? 'All' : (int)$this->input->get('length');
    $start = (int)$this->input->get('start');
    $search = $this->input->get('search');//search[value]:암
    $data['startdate'] = $this->input->get('startdate');
    $data['enddate'] = $this->input->get('enddate');
    $data['trnsctnSt'] = $this->input->get('trnsctnSt');
    $data['search3'] = $this->input->get('search3');
    if(isset ($search['value']) && trim($search['value'])  !=''){
      $data['search'] = trim($search['value']);
    }else $data['search'] ='';
    $data['order'] = $columns[ $order[0]['column'] ]['data'];
    $data['order_dir'] =  $order[0]['dir'];
    $data['length'] = $length !='All' && $length < 1 ? 10 : $length;
    $data['start'] = ($start < 1) ? 0 :(int)$start;

    return $data;
  }
}
