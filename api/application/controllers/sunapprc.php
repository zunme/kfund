<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//require_once APPPATH . '/libraries/JWT.php';
//use \Firebase\JWT\JWT;
define("PluginPath",'../pnpinvest/plugin/pg/seyfert/aes.class.php');
date_default_timezone_set('Asia/Seoul');
include_once(PluginPath);

class Sunapprc extends CI_Controller {
  public function _remap($method) {
    $_COOKIE['api'];
    $this->seyfertinfo = $this->db->query(" select * from mari_config ")->row_array();
    $this->{$method}();
  }
  public function index(){
    $sql = "
    select a.*, c.s_memGuid, m.m_name as sale_name,m.m_emoney , su.regdate as insdate,b.i_subject,b.i_payment, b.m_id as user_id, b.m_name as user_name
      from z_invest_sunap_detail a
      join z_invest_sunap su on a.history_idx = su.idx
      join mari_loan b on a.loan_id = b.i_id
      join mari_seyfert c on a.sale_id = c.m_id
      join mari_member m on a.sale_id = m.m_id
      left join z_invest_sunap_detail_seyfert s on a.detail_idx = s.fk_detail_idx
      where paystatus='R' and a.tid is null and s.fk_detail_idx is null
      order by a.detail_idx
      ";
      $data['list'] =   $this->db->query($sql)->result_array();
      $this->load->view('adm_sunapprc', $data);
  }
  public function prcstep(){
    $sql = "select a.*, c.s_memGuid, m.m_name as sale_name,m.m_emoney , su.regdate as insdate,b.i_subject,b.i_payment, b.m_id as user_id, b.m_name as user_name
      from z_invest_sunap_detail a
      join z_invest_sunap su on a.history_idx = su.idx
      join mari_loan b on a.loan_id = b.i_id
      join mari_seyfert c on a.sale_id = c.m_id
      join mari_member m on a.sale_id = m.m_id
      left join z_invest_sunap_detail_seyfert s on a.detail_idx = s.fk_detail_idx
      where paystatus='R' and a.tid is null and s.fk_detail_idx is null
      order by a.detail_idx
      limit 1";
    $row = $this->db->query($sql)->row_array();
    sleep(1);
    if(!isset($row['detail_idx']) ) { echo json_encode( array('code'=>404, 'msg'=>'정산할 내용이 없습니다.'));return;}
    $this->prc($row);

  }
  private function prc($row) {
    if($row['tid'] == '') $seyfert = $this->seyfert($row);
    if($seyfert==false) return;
    //here
    $order_data = array(
      'loan_id'=>$row['loan_id']
      //'loan_id'=>0
      ,'o_payment'=>$row['i_payment'],'sale_id'=>$row['sale_id'],'sale_name'=>$row['sale_name'],
      'user_id'=>$row['user_id'],'user_name'=>$row['user_name'],'o_subject'=>$row['i_subject'],'o_count'=>$row['o_count'],
      'o_ln_money_to'=>$row['i_pay'],
      'o_investamount'=>$row['user_name']+$row['total_interest'],
      'o_mh_money'=>0,
      'o_ln_iyul'=> $row['rate'],
      'o_status'=>'입금완료','o_salestatus'=>'정산완료',
      'o_saleln_money'=>$row['i_pay'],'o_saletotalamount'=>$row['wongum'],'o_ipay'=>$row['i_pay'],
      'o_interest'=>$row['total_interest']+$row['wongum'],
      'o_saleamount'=>$row['wongum'],
      'o_datetime'=>$row['insdate'],'o_collectiondate'=>$row['insdate'],
      'o_withholding'=>$row['withholdingPayed'],
      'o_type'=>'sale', 'o_paytype'=>'만기일시상환', 'i_loan_type'=>'real2'
    );
    $this->db->insert('mari_order',$order_data);
    $order_data_idx = $this->db->insert_id();
    $emoney_data = array(
      'm_id'=>$row['sale_id'], 'p_datetime'=>$row['insdate'], 'p_content'=>$row['i_subject']."투자건 ".$row['o_count']."회차 정산"
      ,'p_emoney'=>$row['emoney'], 'p_top_emoney'=>$row['m_emoney'] + $row['emoney'],
      'loan_id'=>$row['loan_id'], 'o_id'=>$order_data_idx
    );
    $this->db->insert('mari_emoney', $emoney_data);
    $this->db->set('m_emoney', $emoney_data['p_top_emoney'])->where('m_id',$row['sale_id'])->update('mari_member');
    $this->json( array('code'=>200 ,'msg'=>'', 'data'=>$row) );
  }
  protected function seyfert($row){
    $res = $this->db->set(array('paystatus'=>'P'))->where('detail_idx',$row['detail_idx'] )->update('z_invest_sunap_detail');
    $from_info = array(
      'm_name'=>'엔젤펀딩','s_memGuid'=>$this->seyfertinfo['c_reqMemGuid']//'NwYqhfe7h52vUpAs8KRFBh'
    );
    $cont = $row['i_subject']."투자건 정산";
    $url = "https://v5.paygate.net/v5/transaction/seyfert/transfer";
    $_method = "POST";
    $order_code      = "SO" . time() . rand(111, 999);
    $refId         = "SR" . time() . rand(111, 999);

    $ENCODE_PARAMS   = "&_method=POST&desc=desc&reqMemGuid=" . $this->seyfertinfo['c_reqMemGuid']
                      . "&nonce=" . $order_code . "&title=" . urlencode($cont) . "&refId=" . $refId
                      . "&authType=SMS_MO&timeout=30&srcMemGuid=" . $this->seyfertinfo['c_reqMemGuid'] . "&dstMemGuid=" . $row['s_memGuid']
                      . "&amount=" . (int)$row['emoney'] . "&crrncy=KRW";

    //TODO

    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if( !$res ) {
      $this->json( array('code'=>202 ,'msg'=>'GATE Connection Error','error'=> $data) );return false;
    }else if ( $data['status'] != 'SUCCESS') {
      $this->json( array('code'=>203 ,'msg'=>$savedata['req_desc'], 'data'=>$data ) );return false;
    }else {
      $tid = $data['data']['tid'];
    }

    $res1 = $this->db->insert('z_invest_sunap_detail_seyfert', array('fk_detail_idx'=>$row['detail_idx'],'tid'=>$tid,'refId'=>$refId ));
    $sey_orderdata = array(
      'm_id'=>$row['sale_id'],'m_name'=>$row['sale_name'],'s_amount'=>(int)$row['emoney'],'loan_id'=>$row['loan_id'],'s_subject'=>$cont,
      's_tid'=>$tid,'s_refId'=>$refId,'s_payuse'=>'N','s_type'=>1
    );
    $res = $this->db->set(array('paystatus'=>'Y', 'tid'=>$tid, 'refId'=>$refId))->where('detail_idx',$row['detail_idx'] )->update('z_invest_sunap_detail');
    if(!$res) {$this->json( array('code'=>204 ,'msg'=>'id:'.$row['i_id'].' - tid:'.$tid.' , refId:'.$refId. '저장중 에러발생') );return false;}

    return true;
  }
  private function getres($_method,$url, $ENCODE_PARAMS ){

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
  private function json( $data = '' ){
    header('Content-Type: application/json');
    if ($data =='') $data = array ( 'code'=>'ERROR', 'msg'=>'Unknown Error Occured');
    echo json_encode( $data );
    exit;
  }
}
/*
정산 view
(
select
 za.detail_idx, za.o_id, za.i_id, za.loan_id, za.history_idx
 ,za.paystatus as `status`, za.tid, za.refId, za.o_count, za.sale_id
 , za.rate as o_ln_iyul, za.Delinquency_rate, date_format(zs.regdate, '%Y-%m-%d') as `date`
 ,  za.i_pay as o_ln_money_to , za.i_pay_remain as before_remaining , za.i_pay_remain - za.wongum as remaining_amount
 , za.wongum , floor(za.interest) as inv, floor(za.under + za.over)  as Delinquency
 ,za.susuryoPayed as susuryo, za.withholdingPayed as o_withholding
 ,za.emoney as p_emoney
 , 0 as p_top_emoney
 , zl.i_repay as o_paytype
 , zl.i_subject as p_contrent
 , zs.regdate as o_collectiondate
from
z_invest_sunap_detail za
join z_invest_sunap zs on za.history_idx = zs.idx
join mari_loan zl on za.loan_id = zl.i_id

)union(
select 0 AS `detail_idx`,`a`.`o_id` AS `o_id`,0 AS `i_id`,`a`.`loan_id` AS `loan_id`,0 AS `history_idx`
,'Y' AS `status`,'' AS `tid`,'' AS `refId`,`a`.`o_count` AS `o_count`
,`a`.`sale_id` AS `sale_id`
,`a`.`o_ln_iyul` AS `o_ln_iyul`,0 AS `Delinquency_rate`
,date_format(`a`.`o_collectiondate`,'%Y-%m-%d') AS `date`
,`a`.`o_ln_money_to` AS `o_ln_money_to`
,`a`.`o_ln_money_to` AS `before_remaining`,(`a`.`o_ln_money_to` - if((`a`.`o_interest` > `a`.`o_ln_money_to`),`a`.`o_ln_money_to`,0)) AS `remaining_amount`
,if((`a`.`o_interest` > `a`.`o_ln_money_to`),`a`.`o_ln_money_to`,0) AS `wongum`
,if((`a`.`o_interest` > `a`.`o_ln_money_to`),(`a`.`o_interest` - `a`.`o_ln_money_to`),`a`.`o_interest`) AS `inv`
,0 AS `Delinquency`,if((((`a`.`o_interest` - `a`.`o_withholding`) - `b`.`p_emoney`) < 0),0,((`a`.`o_interest` - `a`.`o_withholding`) - `b`.`p_emoney`)) AS `susuryo`
,`a`.`o_withholding` AS `o_withholding`,`b`.`p_emoney` AS `p_emoney`,`b`.`p_top_emoney` AS `p_top_emoney`
,`a`.`o_paytype` AS `o_paytype`,`b`.`p_content` AS `p_content`
,`a`.`o_collectiondate` AS `o_collectiondate`
from (`mari_order` `a` join `mari_emoney` `b` on(((`a`.`o_id` = `b`.`o_id`) and (`a`.`sale_id` = `b`.`m_id`)))) where (`a`.`sale_id` <> '' and a.i_loan_type = 'real')
)
order by o_collectiondate desc
*/
