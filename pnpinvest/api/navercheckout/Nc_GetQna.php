<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 주문 CLASS : 2010-12-07 정수진
//
//  실행주소 : http://minishop.ecadmin.playautocorp.com/execute/Execute_Admin.php?action=NHNOrder&as=OrderMan&NHNaction=PaidOrder
//-------------------------------------------------------------------------
require_once 'nhnapi-simplecryptlib.php';
require_once 'HTTP/Request.php';
require_once "xml_parser.php";

class NaverCheckOutOrder {
  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOutOrder(){
  // function - End
  }

  //------------------------------------------------------------------------
  // 네이버 API 기본 셋팅
  //------------------------------------------------------------------------
  function init() {
    if($this->stype == "AMP") {
      //$this->test = true;
    }


    if($this->test) {
      //상수 선언
      $accessLicense = "01000100000503b9ecabad8d09c6e718ceaefd1f34033dc7d97db450be663f4686105cb068";  // 비밀 메일로 발송된  라이센트키 입력(테스트)
      $this->key= "AQABAAAVG60l7a89ffqtgHdTg1NGzPlANqc5clH/OMXXo8kG/g==";  // 비밀메일로 발송된 시크릿키 (테스트)
      $this->targetUrl = "http://sandbox.api.naver.com/Checkout/MallService2";
    }else{
      //상수 선언
      $accessLicense = "0100010000e5be7c82a4d24f24e836ac9b1ac177eaa62bbd3ec75d51a1f3b3760fa9346805";  // 비밀 메일로 발송된  라이센트키 입력
      $this->key= "AQABAAD/KPnN8qc4ZRzkg4/jOlgdH8AoAar+K0fxhyDk45CIfA==";  // 비밀메일로 발송된 시크릿키
      $this->targetUrl = "http://api.naver.com/Checkout/MallService2";
    }

    // 기본셋팅
    $this->service = "MallService2";
    $detailLevel = "Full";
    $version = "2.0";
    $RequestID="playauto_".date('Ymdhis');


    //NHNAPISCL 객체생성
    $this->scl = new NHNAPISCL();
    //타임스탬프를 포맷에 맞게 생성
    $this->timestamp = $timestamp = $this->scl->getTimestamp();

    //hmac-sha256서명생성
    $signature = $this->scl->generateSign($timestamp . $this->service . $this->operation, $this->key);

    //soap template에 생성한 값 기본 정보
    $this->request_head="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">
    <soapenv:Body>
    <ns2:".$this->operation."Request xmlns=\"http://base.checkout.platform.nhncorp.com/\" xsi:type=\"ns2:GetPaidOrderListRequestType\" xmlns:ns2=\"http://mall.checkout.platform.nhncorp.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
    <AccessCredentials>
    <AccessLicense>". $accessLicense . "</AccessLicense>
    <Timestamp>" . $timestamp . "</Timestamp>
    <Signature>" .$signature . "</Signature>
    </AccessCredentials>
    <RequestID>". $RequestID . "</RequestID>
    <DetailLevel xmlns:s1=\"http://base.checkout.platform.nhncorp.com/\">" . $detailLevel . "</DetailLevel>
    <Version xmlns:s2=\"http://base.checkout.platform.nhncorp.com/\">" . $version . "</Version>
    ";
  }

  //------------------------------------------------------------------------
  // 네이버에 API로 전송
  //------------------------------------------------------------------------
  function sendNHN($request_data) {
    $request_body=$this->request_head.$request_data;

    //http post방식으로 요청 전송
    $rq = new HTTP_Request($this->targetUrl);
    $rq->addHeader("Content-Type", "text/xml;charset=UTF-8");
    $rq->addHeader("SOAPAction", $this->service . "#" . $this->operation);
    $rq->setBody($request_body);

    $result = $rq->sendRequest();
    if (PEAR::isError($result)) {
       echo "ERROR[NHN0001]". $result->toString(). "\n";
       return;
    }

    //응답메시지 확인
    $rcode = $rq->getResponseCode();
    if($rcode!='200'){
       echo "ERROR[NHN0002]: http response code=". $rcode. "\n";
       return;
    }

    return $rq->getResponseBody();
    // funciton - End
  }

  //------------------------------------------------------------------------
  // 네이버 API로 받은 XML TEXT로 변환
  //------------------------------------------------------------------------
  function XmlToText($data,$thiskey='__ALL__') {

    $xml_parse =& new xml_parse($thiskey,$this->action);
    $dataList = $xml_parse->parse($data);

    //묶음 주문 분할 처리
    $i=0;
    foreach($dataList as $key=>$val) {
      if($val['PRODUCTNAME'] != "") {
        foreach($val['PRODUCTNAME'] as $key2=>$val2) {
          $dataList3 = array();
          $dataList3 = $val;
          $plus_order_id = $key2+1;
          $dataList3['NHNORDERID'] = $val['ORDERID']; // 네이버 주문 번호 변수 생성 및 저장
          $dataList3['BUNDLECOUNT'] = sizeof($val['PRODUCTNAME']); // 묶음 주문 여부 변수 생성 및 저장
          $dataList3['ORDERID'] = $val['ORDERID']."_".$plus_order_id;
          $dataList3['PRODUCTNAME'] = $val['PRODUCTNAME'][$key2];
          $dataList3['PRODUCTID'] = $val['PRODUCTID'][$key2];
          $dataList3['QUANTITY'] = $val['QUANTITY'][$key2];
          $dataList3['UNITPRICE'] = $val['UNITPRICE'][$key2];
          $dataList3['RETURNREQUESTED'] = $val['RETURNREQUESTED'][$key2];
          $dataList3['ORDERPRODUCT'] = $val['ORDERPRODUCT'][$key2];
          $dataList3['PRODUCTOPTION'] = $val['PRODUCTOPTION'][$key2];
          $dataList2[$i] = $dataList3;
          $i++;
        }
      }
    }

    //복호화 대상 필드
    $chdata = array(
      "ORDERERNAME" => true,
      "ORDERERID" => true,
      "ORDERERTEL" => true,
      "ORDEREREMAIL" => true,
      "RECIPIENT" => true,
      "SHIPPINGADDRESS1" => true,
      "SHIPPINGADDRESS2" => true,
      "RECIPIENTTEL1" => true,
      );


    //복호화 하기
    $decryptKey = $this->scl->generateKey($this->timestamp , $this->key);
    if(is_array($dataList2)) {
      foreach($dataList2 as $k=>$v) {
        foreach($chdata as $k2=>$v2) {
          if($v[$k2] != "") { // 데이터 유무 확인
            $dataList2[$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
          }
        }

        if($this->stype == "AMP") {
          foreach($dataList2[$k] as $k2=>$v2) {
            $dataList[$k][$k2] = $v2;
          }
        }else{
          unset($dataList[$k]);
          foreach($dataList2[$k] as $k2=>$v2) {
            $dataList[$k][$k2] = iconv("utf-8","UHC",$v2);
          }
        }
      }
    }

    return $dataList;
  }

  //------------------------------------------------------------------------
  // 주문번호로 주문 정보 검색
  //------------------------------------------------------------------------
  function NHNPOrderSearch($OrderID) {

    // 기본셋팅

    $this->action = "GetOrderInfo";
    $this->operation = $this->action;

    $this->init();

    //전송데이터 셋팅 및 전송
    $request_data="
    <OrderID>$OrderID</OrderID>
    </ns2:".$this->operation."Request>
    </soapenv:Body>
    </soapenv:Envelope>";
    $data = $this->sendNHN($request_data);

    // XML을 TEXT로 변환
    $data = $this->XmlToText($data);

    // 데이터 노출
    echo $this->WebViewData($data);
    exit;
  }



  //------------------------------------------------------------------------
  // 1:1 문의 수집.
  //------------------------------------------------------------------------
  function NHNQna($thiskey,$action) {

    /*
    if( $thiskey == "" ) {
      echo "ERROR[NHN0003]: 업체고유코드 누락";
      exit;
    }

    if( $action == "" ) {
      echo "ERROR[NHN0004]: 주문 진행 명령 누락";
      exit;
    }
    */

    if($action == "uislamp") {
      $uisltest = true;
    }

    $data_list = array();
    for($i=15; $i>=-1; $i--) {

    // 조회기간 최대 24시간(1일)입니다.
    // 네이버 시간은 GMT(한국시간+9)시간 입니다
    if($this->test) {
      $d_date = mktime(0,0,0,01,03,2010);
      $p_date = mktime(0,0,0,01,04,2010);
      $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
      $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간
    }else{
      $s_timestamp = time() - 86400 * ($i+1);
      $e_timestamp = time() - 86400 * $i;
      $d_date = mktime(0,0,0,date('m',$s_timestamp),date('d',$s_timestamp),date('Y',$s_timestamp));
      $p_date = mktime(0,0,0,date('m',$e_timestamp),date('d',$e_timestamp),date('Y',$e_timestamp));
      $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
      $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간
    }

      // 기본셋팅
      $this->action = $action;
      $this->operation = "Get".$this->action."List";
      $this->init();

      //전송데이터 셋팅
      $request_data="
      <InquiryTimeFrom>" . $this->InquiryTimeFrom . "</InquiryTimeFrom>
      <InquiryTimeTo>" . $this->InquiryTimeTo . "</InquiryTimeTo>
      <InquiryExtraData></InquiryExtraData>
	  <IsAnswered> boolean </IsAnswered>
      </ns2:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";

      // 전송
      $data = $this->sendNHN($request_data);

      // XML을 TEXT로 변환
      $data = $this->XmlToText($data,$this->NCkey);

      $data_list = array_merge($data_list,$data);
    }

    // 주문 약식 매칭정보 저장하기
    if($this->action == "PlacedOrder") {
      // 신규주문일때
      $this->OrderMatchInsert($data_list);
    }else{
      // 동기화 일때
    }

    echo $this->WebViewData($data_list);
    exit;
  }


  //------------------------------------------------------------------------
  // 송장전송
  // $OrderID : 주문 번호 ( * 단 아래의 규칙을 따라야함 )
  //   - type이 save는 "_"이후가 들어간 플레이오토 주문 번호
  //   - type이 exec는 "_"이후가 제거된 네이버 주문 번호
  //------------------------------------------------------------------------
  function NHNShipOrder($para) {

    $data = array(); // 결과 메세지 초기화
    $up_data = array(); // SET 정보 초기화
    if($para['type'] == "save") {

      $where = "pa_ocode = '".$para['OrdID']."' and cp_code='".$this->CP_CODE."'";
      $up_data['paNumber'] = $para['psNumber']; // 솔루션 별로 주문 넘버
      $up_data['pa_sender'] = $para['pa_sender'];
      $up_data['nhn_sender'] = $para['nhn_sender'];
      $up_data['sendno'] = $para['sendno'];
      $up_data['sendInfoKey'] = $para['sendInfoKey'];
      $result = $this->sock->Array_update("$this->DataBase.Order_Match",$up_data,$where,"Success" ,false);

      if($result == "Success") {
        $data['msg'] = "Save-Ok";
      }else{
        $data['msg'] = "Save-False";
      }

      // 결과 노출
      echo $this->WebViewData($data);
      exit;

    }elseif($para['type'] == "exec") {

      // 송장전송
      // 토탈 묶음 방법
      $sql = "select * from $this->DataBase.Order_Match where sendInfoKey = '".$para['sendInfoKey']."' ";
      $re = $this->sock->fetch($sql);

      //부분 배송여부 확인
      $partDeliv = array();
      if(is_array($re)) {

        foreach($re as $key=>$val) {
          $partDeliv[$val['nhn_ocode']]++;
        }

        foreach($re as $key=>$val) {
          // 부분 배송 주문 택배사 변경
          if($partDeliv[$val['nhn_ocode']] != $val['bundle_count']) {
            $val['nhn_sender'] = "z_delegation";
            $val['sendno'] = "";

            //----------------------------------------------------------------------------
            // 주문번호와 업체코드 매칭정보 랭크디비에 저장
            $this->OrderMatchShortInsert($val['nhn_ocode']);
            $real_data = $this->NHNShipOrderRe($val['nhn_ocode'],$val['nhn_sender'],$val['sendno']);
            $real_data[0]['RESPONSETYPE'] = "SUCCESS";
          }else{
            //기타 택배(z_etc), 퀵서비스(z_quick), 직배송(z_direct), 방문 수령(z_visit), 업체별 배송(z_delegation)인 경우 운송장번호(TrackingNumber)는 비어있어야 합니다.
            if($val['nhn_sender'] == "z_etc" || $val['nhn_sender'] == "z_quick" || $val['nhn_sender'] == "z_direct" || $val['nhn_sender'] == "z_visit" || $val['nhn_sender'] == "z_delegation"){
              $val['sendno']="";
            }
            $real_data = $this->NHNShipOrderRe($val['nhn_ocode'],$val['nhn_sender'],$val['sendno']);
          }


          if( eregi("SUCCESS",$real_data[0]['RESPONSETYPE']) ) {
            $all_ret[ocode] = $val['pa_ocode']; // 네이버용 특별 변수
            $all_ret[result] = true;

            $where = "number='".$val['number']."'";
            $up_data['state'] = "발송완료";

            $result = $this->sock->Array_update("$this->DataBase.Order_Match",$up_data,$where,"Success" ,false);

          } else {
            if($real_data[0]['MESSAGE'] == "") {
              $all_ret[msg] = "[실패] 오류확인 불가";
            }else{
              $all_ret[msg] = "(NHN) ".$real_data[0]['MESSAGE'];
            }
            $all_ret[result] = false;
          }
          $dataView[$val['panumber']] = $all_ret;
        }
      }

      // 결과 노출
      echo $this->WebViewData($dataView);
      exit;

    }else{

      $data['type'] = $type;
      $data['msg'] = "type-error";
      echo $this->WebViewData($data);
      exit;

    }

  }


  //------------------------------------------------------------------------
  // 송장전송
  // $OrderID : 주문 번호 ( * 단 아래의 규칙을 따라야함 )
  //   - type이 save는 "_"가 들어간 플레이오토 주문 번호
  //   - type이 exec는 "_"가 제거된 네이버 주문 번호
  //------------------------------------------------------------------------
  function NHNShipOrderRe($OrderID,$ShippingCompany,$TrackingNumber) {
    // 기본셋팅
    $this->action = "ShipOrder";
    $this->operation = $this->action;
    $this->init();

    $ShippingCompleteDate = date("Y-m-d\TH:i:s",strtotime("-9hour"));;

    //전송데이터 셋팅 및 전송
    $request_data="
    <OrderID> $OrderID </OrderID>
    <ShippingCompleteDate> $ShippingCompleteDate </ShippingCompleteDate>
    <ShippingCompany> $ShippingCompany </ShippingCompany>
    <TrackingNumber> $TrackingNumber </TrackingNumber>
    </ns2:".$this->operation."Request>
    </soapenv:Body>
    </soapenv:Envelope>";

    $data = $this->sendNHN($request_data);

    // XML을 TEXT로 변환
    $data = $this->XmlToText($data);

    return $data;
  }

  //------------------------------------------------------------------------
  // 발송 취소
  // 배송 정보 오류 상태 주문 미발송으로 처리 하기 목적
  //------------------------------------------------------------------------
  function NHNCancelShipping($OrderID) {

    // 기본셋팅
    $this->action = "CancelShipping";
    $this->operation = $this->action;
    $this->init();

    $ShippingCompleteDate = date("Y-m-d\TH:i:s",strtotime("-9hour"));;

    //전송데이터 셋팅 및 전송
    $request_data="
    <OrderID> $OrderID </OrderID>
    </ns2:".$this->operation."Request>
    </soapenv:Body>
    </soapenv:Envelope>";

    $data = $this->sendNHN($request_data);

    // XML을 TEXT로 변환
    $data = $this->XmlToText($data);

    // 데이터 노출
    echo $this->WebViewData($data);
    exit;
  }



  //------------------------------------------------------------------------
  // 최종 노출 데이터
  //------------------------------------------------------------------------
  function WebViewData($data) {

    if($this->stype == "AMP") {
      $ViewDataEncode = base64_encode(json_encode($data));
    }else{
      $ViewDataEncode = base64_encode(serialize($data));
    }

    $ViewData = '<?xml version="1.0" encoding="utf-8"?>
    <PLAYAUTO_RESPONSE>
      <RESULT>OK</RESULT>
      <MSG></MSG>
      <DATA><![CDATA['.$ViewDataEncode.']]></DATA>
    </PLAYAUTO_RESPONSE>
    ';

    return $ViewData;
  }

  //------------------------------------------------------------------------
  // 주문 매칭정보 저장
  //------------------------------------------------------------------------
  function OrderMatchInsert($data) {
    // 저장할 데이터 지정
    $in_data = array();
    $result_re = true;
    foreach($data as $key=>$val) {
      $in_data['wdate'] = date('Y-m-d H:i:s');
      $in_data['state'] = "발송전";
      $in_data['cp_code'] = $this->CP_CODE;
      $in_data['nhn_ocode'] = $val['NHNORDERID'];
      $in_data['pa_ocode'] = $val['ORDERID'];
      $in_data['goods_code'] = $val['PRODUCTID'];
      $in_data['bundle_count'] = $val['BUNDLECOUNT'];
      $result = $this->sock->Array_insert("$this->DataBase.Order_Match",$in_data,"Success" ,false);

      if($result != "Success") {
        for($i=0; $i<10; $i++) {
          $result = $this->sock->Array_insert("$this->DataBase.Order_Match",$in_data,"Success" ,false);
          if($result == "Success") {
            break;
          }
        }
      }
    }

    return $result_re;
  }


  //------------------------------------------------------------------------
  // 주문 약식 매칭정보 저장
  //------------------------------------------------------------------------
  function OrderMatchShortInsert($ORDER_ID) {
/*
    // 연결정보 - 기본 미니샵외 다른 디비서버 접속이라 여기서 바로 연결 처리함
    $rank_sock = @mysql_connect('rankdb','playauto','ahffkdy;;');
    if(!$rank_sock) {
     echo("서버 연결에 실패하였습니다.");
     exit;
    }

    $status=@mysql_select_db("nhn",$rank_sock);
    if(!$status) {
     echo("데이터 베이스 연결에 실패하였습니다.");
     exit;
    }

    $sql = "INSERT INTO nhn.orderMatch (nhn_ocode, cp_code) VALUES ('".$ORDER_ID."', '".$this->CP_CODE."');";

    if(!mysql_query($sql,$rank_sock)) {
      for($i=0; $i<10; $i++) {
        if(mysql_query($sql,$rank_sock)) {
          break;
        }
      }
    }
  }

*/
}  // class - End




?>