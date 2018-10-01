<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 상품평 CLASS : 2011-03-15 정수진
//
//  실행주소 : http://test.ecadmin.playautocorp.com/execute/Execute_Admin.php?as=OrderMan&action=NHNAfter&NHNaction=PurchaseEvaluationInfo
//-------------------------------------------------------------------------
require_once 'nhnapi-simplecryptlib.php';
require_once 'HTTP/Request.php';
require_once "xml_parser.php";

class NaverCheckOutAfter {
  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOutAfter(){

  // function - End
  }

  //------------------------------------------------------------------------
  // 네이버 API 기본 셋팅
  //------------------------------------------------------------------------
  function init() {

    //$test = true;

    if($test) {
      //상수 선언
      $accessLicense = "01000100000503b9ecabad8d09c6e718ceaefd1f34033dc7d97db450be663f4686105cb068";  // 비밀 메일로 발송된  라이센트키 입력(테스트)
      $this->key= "AQABAAAVG60l7a89ffqtgHdTg1NGzPlANqc5clH/OMXXo8kG/g==";  // 비밀메일로 발송된 시크릿키 (테스트)
      $this->targetUrl = "http://sandbox.api.naver.com/Checkout/MallService3";
    }else{
      //상수 선언
      $accessLicense = "0100010000e5be7c82a4d24f24e836ac9b1ac177eaa62bbd3ec75d51a1f3b3760fa9346805";  // 비밀 메일로 발송된  라이센트키 입력
      $this->key= "AQABAAD/KPnN8qc4ZRzkg4/jOlgdH8AoAar+K0fxhyDk45CIfA==";  // 비밀메일로 발송된 시크릿키
      $this->targetUrl = "http://api.naver.com/Checkout/MallService3";
    }

    // 기본셋팅
    $this->service = "MallService3";
    $detailLevel = "Full";
    $version = "3.0";
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
    <ns2:".$this->operation."Request xmlns=\"http://base.checkout.platform.nhncorp.com/\" xsi:type=\"ns2:".$this->operation."RequestType\"  xmlns:ns2=\"http://mall.checkout.platform.nhncorp.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
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

	//복호화 대상 필드
    $chdata = array(
	  "OrderID" => true,
      "ProductName" => true,
      "ProductOption" => true,
      "PurchaseEvaluationContent" => true,
      );

    //복호화 하기
    $decryptKey = $this->scl->generateKey($this->timestamp , $this->key);

	foreach($dataList as $k=>$v) {
      foreach($chdata as $k2=>$v2) {
        if($v[$k2] != "") { // 데이터 유무 확인
          $dataList[$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
        }
      }

      foreach($dataList[$k] as $k2=>$v2) {
        $dataList[$k][$k2] =iconv("utf-8","UHC",$v2);
      }
    }

	return $dataList;

  }


  //------------------------------------------------------------------------
  // 상품평 수집
  //------------------------------------------------------------------------
  function NHNAfter($thiskey,$action) {

  	$data_list = array();

    for($i=15; $i>=-1; $i--) {
      $s_timestamp = time() - 86400 * ($i+1);
      $e_timestamp = time() - 86400 * $i;
      $d_date = mktime(0,0,0,date('m',$s_timestamp),date('d',$s_timestamp),date('Y',$s_timestamp));
      $p_date = mktime(0,0,0,date('m',$e_timestamp),date('d',$e_timestamp),date('Y',$e_timestamp));
      $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
      $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간

      // 기본셋팅
      $this->action = $action;
      $this->operation = "GetPurchaseEvaluationList";
      $this->init();

      //전송데이터 셋팅
      $request_data="
      <InquiryTimeFrom>" . $this->InquiryTimeFrom . "</InquiryTimeFrom>
      <InquiryTimeTo>" . $this->InquiryTimeTo . "</InquiryTimeTo>
      <InquiryExtraData></InquiryExtraData>
      </ns2:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";

      // 전송
      $data = $this->sendNHN($request_data);
sleep(0.5);
      // XML을 TEXT로 변환
      $data = $this->XmlToText($data,$this->NCkey);
      $data_list = array_merge($data_list,$data);
	}

    // 데이터 노출
    echo('<?xml version="1.0" encoding="utf-8"?>
    <PLAYAUTO_RESPONSE>
      <RESULT>OK</RESULT>
      <MSG></MSG>
      <DATA><![CDATA['.base64_encode(serialize($data_list)).']]></DATA>
    </PLAYAUTO_RESPONSE>
    ');
    exit;
  }

}  // class - End

?>