<?php
defined('BASEPATH') OR exit('No direct script access allowed');
define('useSeyfertTest' , false);
include_once('../pnpinvest/plugin/pg/seyfert/aes.class.php');

class seyfertapi {

  var $seyfertinfo;
  var $CI;
  var $perurl;
  function __construct() {
      $this->CI =& get_instance();
      $this->CI->load->database();
      $this->seyfertinfo['reqMemGuid'] = 'W1GhJgNN5tG5qZH3tvD4uS';
      $this->seyfertinfo['reqMemKey'] = 'KDVDUO6s9rO8Zh3BOD637SdHE2RidmgTBIgXdKNcU9U3udLsEYpM3KrBJf4Ss4NX';
      date_default_timezone_set('Asia/Seoul');
      if(useSeyfertTest){
        $this->preurl = "https://stg5.paygate.net";
      }else {
        $this->preurl = "https://v5.paygate.net";
      }
  }


/* ID 잔액조회 */
  public function displayBalance($mid) {
    $url = "/v5/member/seyfert/inquiry/balance";
    $_method = "POST";
    $this->refid('bal');
    $s_memGuid = $this->getmemguid($mid);
    if ($s_memGuid===false) return array("code"=>404, "msg"=>"멤버키를 찾을 수 없습니다.");

    $ENCODE_PARAMS ="&_method=".$_method."&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['reqMemGuid']."&nonce=".$this->seyfertinfo['nonce']."&refId=".$this->seyfertinfo['refid']
                    ."&dstMemGuid=".$s_memGuid."&crrncy=KRW";
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );

    if( !$res ) return  array('code'=>500 ,'msg'=>'GATE Connection Error','error'=> $data) ;
    else if ( $data['status'] != 'SUCCESS') return array('code'=>410 ,'msg'=>"ERROR OCCURED", 'data'=>$data);
    else {
      $amount = isset( $data['data']["moneyPair"]["amount"] ) ? (int) $data['data']["moneyPair"]["amount"] : '0';
      return array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>array('amount'=>$amount,'han'=>$this->getConvertNumberToKorean($amount), 'data'=>$data) ) ;
    }
  }
  /* Pending 취소 */
  public function canceltid($tid,$refid=''){
    $url="/v5/transaction/seyfertTransferPending/cancel";
    $_method = "POST";
    $this->refid('c');
    $order = $this->CI->db->query("select * from mari_seyfert_order where s_tid = ? ", array($tid) )->row_array();
    $refid = isset($order['s_refId'])&& trim($order['s_refId'])!='' ? $order['s_refId'] : $refid;
    $i_subject = isset($order['i_subject'])&& trim($order['i_subject'])!='' ? $order['i_subject'] : '결제취소';
    $ENCODE_PARAMS="&_method=$_method&desc=desc&_lang=ko&reqMemGuid=".$this->seyfertinfo['reqMemGuid']."&nonce=".$this->seyfertinfo['nonce']."&title=".urlencode($i_subject)."&refId=".$refid."&authType=SMS_MO&timeout=30&parentTid=".$tid;
    list($res, $data) = $this->getres($_method, $url, $ENCODE_PARAMS );
    if( !$res ) return  array('code'=>500 ,'msg'=>'GATE Connection Error','error'=> $data) ;
    else if ( $data['status'] != 'SUCCESS') return array('code'=>410 ,'msg'=>"ERROR OCCURED", 'data'=>$data);
    else {
      return array('code'=>200 ,'msg'=>'SUCCESS', 'data'=>$data) ;
    }
  }

//========================================================================================================================
public function getmemguid($mid){
  if($mid =='')
  if($mid == 'kfunding'){
    return $this->seyfertinfo['reqMemGuid'];
  }
  $bankck = $this->CI->db->query("select  s_memGuid from mari_seyfert where m_id = ? and s_memuse='Y'" , array($mid) )->row_array();

  if ( !isset( $bankck['s_memGuid']) ) return false;
  else return $bankck['s_memGuid'];
}
protected function refid($pre='rnd'){
  $this->seyfertinfo['nonce'] = $pre. time() . rand(111, 999);
  $this->seyfertinfo['refid'] = $pre."_r" . time() . rand(111, 999);
}
/* seyfert 통신 */
protected function getres($_method,$url, $ENCODE_PARAMS ){
  $cipher = AesCtr::encrypt($ENCODE_PARAMS, $this->seyfertinfo['reqMemKey'], 256);
  $cipherEncoded = urlencode($cipher);
  $requestString = "_method=".$_method."&reqMemGuid=".$this->seyfertinfo['reqMemGuid']."&encReq=".$cipherEncoded;
  $requestPath = $this->preurl.$url."?".$requestString;
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
}
  public function code($code=''){
      $tcode =array('ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체', 'ARS'=>'ARS', 'ASSIGN_VACCNT'=>'가상계좌 발급', 'CHECK_BNK_CD'=>'은행 계좌주 코드 검증', 'CHECK_BNK_NM'=>'은행 계좌주 이름 검증', 'ESCROW_RELEASE'=>'에스크로 해제', 'EXCHANGE_MONEY'=>'환전', 'MO'=>'문자 질의 응답', 'PENDING_RELEASE'=>'세이퍼트 펜딩 해제', 'SEND_MONEY'=>'세이퍼트 송금', 'SEYFERT_PAYIN_VACCNT'=>'세이퍼트 가상계좌 입금 충전', 'SEYFERT_PAYIN_VACCNT_KYC'=>'KYC 집금', 'SEYFERT_RESERVED_PENDING'=>'세이퍼트 펜딩 예약 이체', 'SEYFERT_TRANSFER'=>'세이퍼트 에스크로 이체', 'SEYFERT_TRANSFER_PND'=>'세이퍼트 펜딩 이체', 'SEYFERT_TRANSFER_RESERVED'=>'deprecated', 'SEYFERT_TRANSFER_RSRV'=>'세이퍼트 예약 이체', 'SEYFERT_WITHDRAW'=>'세이퍼트 출금', 'SMS_API'=>'SMS', 'TRNSCTN_RECURRING'=>'세이퍼트 자동 결제', 'UNLIMITED_RESERVE'=>'무한 예약 이체',);
      $scode= array(
 'ACQUIRING_BANK_AGREEMENT'=> '세이퍼트 출금 동의',  'AGREE_FORCED_BY_MERCHANT'=> '세이퍼트 펜딩 이체 완료 (낮은 금액에 대한 미인증 이체) ',  'ARS_DENIED'=> 'ARS 인증 실패 ',  'ARS_FINISHED'=> 'ARS 인증 완료',  'ARS_INIT'=> 'ARS 인증 시작',  'ARS_TRYING'=> 'ARS 인증 고객 응답 대기',  'ASSIGN_VACCNT_FINISHED'=> '가상계좌 할당 성공',  'ASSIGN_VACCNT_INIT'=> '가상계좌 할당 시작',  'BANK_DEPOSIT_PAYIN_FINISHED'=> '은행 입금 입력 완료',  'BANK_DEPOSIT_PAYIN_INIT'=> '은행 입금 입력 시작 ',  'BANK_DEPOSIT_PAYOUT_FINISHED'=> '은행 출금 입력 완료 ',  'BANK_DEPOSIT_PAYOUT_INIT'=> '은행 출금 입력 시작 ',  'BANK_TRAN_ROLL_BACK'=> '세이퍼트 출금 실패에 따른 롤백',  'BANK_TRAN_ROLL_BACK_PASSBOOK'=> '세이퍼트 출금 실패에 따른 롤백',  'BATCH_RCRR_CANCELED'=> '자동이체 취소',  'BATCH_RCRR_ENOUGH_MONEY'=> '자동이체 2일전 잔고 충분 통보',  'BATCH_RCRR_INIT'=> '자동이체 초기화 ',  'BATCH_RCRR_NOTI_MONEY'=> '자동이체 2일전 잔고 부족 통보 ',  'BATCH_RCRR_RUN_DONE'=> '자동이체 완료 ',  'BATCH_RCRR_RUN_FAILED'=> '자동이체 실패',  'BATCH_RCRR_TRYING'=> '자동이체 진행 중',  'BATCH_UNLIMITED_RSRV_CANCELED'=> '무한 예약 이체 취소',  'BATCH_UNLIMITED_RSRV_TRYING'=> '무한 예약이체 처리 중 ',  'CHECK_BNK_ACCNT_FINISHED'=> '예금주 조회 완료',  'CHECK_BNK_EXISTANCE_CHECKED'=> '실계좌 확인 완료',  'CHECK_BNK_CD_FINISHED'=> '예금주 코드 검증 완료',  'CHECK_BNK_CD_INIT'=> '예금주 코드 검증 초기화 ',  'CHECK_BNK_NM_DENIED'=> '예금주명 조회 거절 ',  'CHECK_BNK_NM_FINISHED'=> '예금주명 조회 완료',  'CHECK_BNK_NM_INIT'=> '예금주명 조회 초기화',  'ESCROW_CANCELED'=> '에스크로 취소 ',  'ESCR_RELEASE_CANCELED'=> '에스크로 해제 취소',  'ESCR_RELEASE_CHLD_FINISHED'=> '에스크로 이체 원거래 해제됨',  'ESCR_RELEASE_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_APPROVED'=> '에스크로 해제 요청 승인',  'ESCR_RELEASE_REQ_AUTO_DONE'=> '에스크로 해제 자동 완료 ',  'ESCR_RELEASE_REQ_AUTO_ERROR'=> '에스크로 해제 자동 완료 에러',  'ESCR_RELEASE_REQ_AUTO_FINISHED'=> '에스크로 해제 요청 자동 완료',  'ESCR_RELEASE_REQ_AUTO_PROCESS'=> '에스크로 해제 자동 완료 진행 ',  'ESCR_RELEASE_REQ_CANCELED'=> '에스크로 해제 요청 취소',  'ESCR_RELEASE_REQ_DENIED'=> '에스크로 해제 요청 거부',  'ESCR_RELEASE_REQ_FINISHED'=> '에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_HOLD'=>'에스크로 해제 요청 완료',  'ESCR_RELEASE_REQ_INIT'=>'에스크로 해제 요청 시작',  'ESCR_RELEASE_REQ_TRYING'=>'에스크로 해제 요청 승인 시작',  'ESCR_RELEASE_REQ_TRY_FAILED'=>'에스크로 해제 요청 실패',  'EXCHANGE_MONEY_DENIED'=>'환전 거절',  'EXCHANGE_MONEY_FINISHED'=>'환전 완료',  'EXCHANGE_MONEY_INIT'=>'환전 시작',  'MO_DENIED'=>'MO 요청 거절',  'MO_DONE'=>'MO 요청 완료',  'MO_FINISHED'=>'MO 요청 완료',  'MO_INIT'=>'MO 요청 초기화',  'MO_TRYING'=>'MO 요청 진행중',  'NOT_ENOUGH_BAL_TO_PAY_FEE'=>'거래 실패 (충전금 부족)',  'NOT_VRFY_BNK_CD_KYC'=>'NOT_VRFY_BNK_CD_KYC',  'PAYIN_VACCNT_KYC_ACTIVATED'=>'KYC 가상계좌 입금 활성화',  'PAYIN_VACCNT_KYC_FAILED'=>'KYC 가상계좌 입금 실패',  'PAYIN_VACCNT_KYC_FINISHED'=>'KYC 가상계좌 입금 완료',  'PAYIN_VACCNT_KYC_INIT'=>'KYC 가상계좌 입금 초기화',  'PAYIN_VACCNT_KYC_REQ_TRYING'=>'KYC 가상계좌 입금 요청',  'PAYIN_VACCNT_KYC_SENDING_1WON'=>'KYC 가상계좌 입금 코드 전송',  'REG_RCRR_EXP_DT'=>'등록 중 최초거래보다 경과됨',  'REG_RCRR_INIT'=>'자동이체 등록 초기화',  'REG_RCRR_PARENT_CANCELED'=>'자동이체 부모 거래가 취소',  'REG_RCRR_REQ_FINISHED'=>'자동이체 등록 인증 완료',  'REG_RCRR_REQ_TRYING'=>'자동이체 등록 인증 진행 중',  'REG_RCRR_REQ_TRY_FAILED'=>'자동이체 등록 인증 실패',  'REQUEST_HAS_TIME_OUT'=>'요청 시간 경과',  'SEND_MONEY_FAILED'=>'송금 실패',  'SEND_MONEY_FINISHED'=>'송금 완료',  'SEND_MONEY_INIT'=>'송금 초기화',  'SEND_MONEY_ROLL_BACK'=>'송금 완료 후 은행 거절 반환 (입금 불능)',  'SEND_SMS_BNK_CD_FAILED'=>'SMS 수신 코드 매칭 실패',  'SFRT_PAYIN_RSRV_MATCHED'=>'세이퍼트 예약 입금 완료',  'SFRT_PAYIN_VACCNT_FAILED'=>'세이퍼트 입금 실패',  'SFRT_PAYIN_VACCNT_FINISHED'=>'세이퍼트 입금 완료',  'SFRT_PAYIN_VACCNT_INIT'=>'세이퍼트 입금 시작',  'SFRT_RSRV_PND_INIT'=>'예약 펜딩 거래 시작',  'SFRT_RSRV_PND_TRYING'=>'예약 펜딩 거래 고객 승인 대기',  'SFRT_TRNSFR_CANCELED'=>'세이퍼트 이체 취소',  'SFRT_TRNSFR_CHLD_CANCELED'=>'세이퍼트 펜딩 원거래 취소됨',  'SFRT_TRNSFR_ESCR_AUTO_DONE'=>'에스크로 해제 자동 완료',  'SFRT_TRNSFR_ESCR_DONE'=>'에스크로 해제 완료',  'SFRT_TRNSFR_FINISHED'=>'세이퍼트 이체 완료',  'SFRT_TRNSFR_INIT'=>'세이퍼트 이체 시작',  'SFRT_TRNSFR_PND_AGRREED'=>'세이퍼트 펜딩 거래 동의',  'SFRT_TRNSFR_PND_CANCELED'=>'세이퍼트 펜딩 거래 취소',  'SFRT_TRNSFR_PND_CHLD_RELEASED'=>'세이퍼트 펜딩 원거래 해제됨',  'SFRT_TRNSFR_PND_INIT'=>'세이퍼트 펜딩 거래 초기화',  'SFRT_TRNSFR_PND_RELEASED'=>'세이퍼트 펜딩 거래 해제',  'SFRT_TRNSFR_PND_RELEASE_INIT'=>'세이퍼트 펜딩 거래 해제 초기화',  'SFRT_TRNSFR_PND_TRYING'=>'세이퍼트 펜딩 거래 요청 중',  'SFRT_TRNSFR_REQ_APPROVED'=>'세이퍼트 이체 요청 승인',  'SFRT_TRNSFR_REQ_CANCELED'=>'세이퍼트 이체 요청 취소',  'SFRT_TRNSFR_REQ_DENIED'=>'세이퍼트 이체 요청 거부',  'SFRT_TRNSFR_REQ_FINISHED'=>'세이퍼트 이체 요청 완료',  'SFRT_TRNSFR_REQ_INIT'=>'세이퍼트 이체 요청 시작',  'SFRT_TRNSFR_REQ_TRYING'=>'세이퍼트 이체 요청 승인 처리중',  'SFRT_TRNSFR_REQ_TRY_FAILED'=>'세이퍼트 이체 요청 실패',  'SFRT_TRNSFR_RSRV_EXPIRED'=>'세이퍼트 예약입금이체 입금 시간 경과',  'SFRT_TRNSFR_RSRV_FINISHED'=>'세이퍼트 예약입금이체 실패',  'SFRT_TRNSFR_RSRV_INIT'=>'세이퍼트 예약입금이체 초기화',  'SFRT_TRNSFR_RSRV_MATCHED'=>'세이퍼트 예약입금이체 매칭',  'SFRT_TRNSFR_RSRV_TRYING'=>'세이퍼트 예약입금이체 진행 중',  'SFRT_WITHDRAW_CANCELED'=>'세이퍼트 출금 취소',  'SFRT_WITHDRAW_FAILED'=>'세이퍼트 출금 실패',  'SFRT_WITHDRAW_FINISHED'=>'세이퍼트 출금 완료',  'SFRT_WITHDRAW_FINISH_BNK_CD'=>'세이퍼트 출금 중 계좌주 코드 검증',  'SFRT_WITHDRAW_FINISH_BNK_NM'=>'세이퍼트 출금 중 예금주 이름 검증',  'SFRT_WITHDRAW_INIT'=>'세이퍼트 출금 시작',  'SFRT_WITHDRAW_MONEY_REQUSTED'=>'세이퍼트 출금 처리 전송됨',  'SFRT_WITHDRAW_REQ_TRYING'=>'세이퍼트 출금 요청 진행 중',  'SMS_API_FINISHED'=>'SMS API 완료',  'SMS_API_INIT'=>'SMS API 초기화',  'UNLIMITED_RESERVE_CANCELED'=>'무한 예약 이체 취소',  'UNLIMITED_RESERVE_INIT'=>'무한 예약 이체 초기화',  'UNLIMITED_RESERVE_MATCHED'=>'무한 예약 이체 매치',  'UNLIMITED_RESERVE_RUNNING'=>'무한 예약 이체 실행중',  'VRFY_BNK_CD_COUNT_EXCEED'=>'예금주 권한 검증을 위한 1원 송금 10회 초과',  'VRFY_BNK_CD_DONE'=>'예금주 권한 검증 완료',  'VRFY_BNK_CD_REQ_TRYING'=>'예금주 권한 검증 1원 송금 후 문자 발송',  'VRFY_BNK_CD_SENDING_1WON'=>'예금주 권한 검증을 위한 1원 송금',  'VRFY_BNK_NM_DONE'=>'예금주 이름 검증 완료',  'VRFY_BNK_NM_REQ_TRYING'=>'예금중 이름 검증 진행 중','ASSIGN_VACCNT_UNASSIGNED'=>'가상계좌해지','BNK_NM_NEED_REVIEW'=>'계좌주이름확인팰요'
    );

    return ( isset($scode[$code]) )? $scode[$code]."(".$code.")" :  ( ( isset( $tcode[$code]) ) ? $tcode[$code]."(".$code.")" : $code ) ;
  }
  protected function getConvertNumberToKorean($_number)
  {
    if($_number=='') return "0";
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

}
