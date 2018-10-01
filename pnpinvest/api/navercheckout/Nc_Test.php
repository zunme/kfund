<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 주문 CLASS : 2010-12-07 정수진
//
//  실행주소 : http://minishopnc.ecadmin.playautocorp.com/execute/Execute_Admin.php?as=OrderMan&action=NHNtest
//-------------------------------------------------------------------------
require_once 'nhnapi-simplecryptlib.php';
require_once 'HTTP/Request.php';
require_once "xml_parser2.php";

class NaverCheckOutTest {
  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOutTest(){
   
  // function - End
  }
  
  //------------------------------------------------------------------------
  // 네이버 API 기본 셋팅 
  //------------------------------------------------------------------------
  function init() {

    $test = true;

    if($test) {
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

    //조회기간 최대 24시간(1일)입니다.
    $this->InquiryTimeFrom ="2010-01-01T09:18:37+09:00";  //InquiryTimeFrom 조회기간
    $this->InquiryTimeTo ="2010-01-02T09:18:37+09:00"; //InquiryTimeTo 조회기간 

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

    foreach($dataList as $k=>$v) {
      foreach($chdata as $k2=>$v2) {
        if($v[$k2] != "") { // 데이터 유무 확인
          $dataList[$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
        }
      }

      foreach($dataList[$k] as $k2=>$v2) {
        $dataList[$k][$k2] = iconv("utf-8","UHC",$v2);
      }
    }
    return $dataList;
  }
 

  //------------------------------------------------------------------------
  // 테스트
  //------------------------------------------------------------------------
  function NHNTest() {
    $response = '<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:bs="http://base.checkout.platform.nhncorp.com/" xmlns:ma="http://mall.checkout.platform.nhncorp.com/">
    <soapenv:Body>
    <ma:GetPlacedOrderListResponse>
    <bs:RequestID>playauto_20101217110056</bs:RequestID>
    <bs:ResponseType>SUCCESS</bs:ResponseType>
    <bs:ResponseTime>31</bs:ResponseTime>
    <bs:QuotaStatus>
    <bs:RemainingQuota>4998050</bs:RemainingQuota>
    <bs:ExpirationTime>2011-01-07T11:13:24.00Z</bs:ExpirationTime>
    </bs:QuotaStatus>
    <bs:DetailLevel>Full</bs:DetailLevel>
    <bs:Version>2.0</bs:Version>
    <bs:Release>unknown</bs:Release>
    <bs:Timestamp>2010-12-17T02:00:37.62Z</bs:Timestamp>
    <bs:MessageID>4475d414-5e84-4008-9b95-11876eb44b2b</bs:MessageID>
    <bs:ReturnedDataCount>1</bs:ReturnedDataCount>
    <bs:HasMoreData>false</bs:HasMoreData>
    <PlacedOrderList>
    <bs:PlacedOrder>
    <bs:Order>
    <bs:OrderDateTime>2010-12-16T08:07:31.00Z</bs:OrderDateTime>
    <bs:OrderID>101648614</bs:OrderID>
    <bs:OrderStatusCode>OD0007</bs:OrderStatusCode>
    <bs:OrderStatus>발송처리요청</bs:OrderStatus>
    <bs:OrdererName>B7KiPW9MdjR6ArW9e/tDTA==</bs:OrdererName>
    <bs:OrdererID>V6BNdnmKPAVdpYFblt6xCg==</bs:OrdererID>
    <bs:OrdererTel>PJmkUGj0b7ueKYaoZyUZ1Q==</bs:OrdererTel>
    <bs:OrdererEmail>Yqn6oyqzfA1n68GHdVnx7CbxDJBFr8KXBQ/IpQMqZ+c=</bs:OrdererEmail>
    <bs:Repayment>false</bs:Repayment>
    <bs:TotalProductAmount>22000</bs:TotalProductAmount>
    <bs:ShippingFee>3000</bs:ShippingFee>
    <bs:MallOrderAmount>22000</bs:MallOrderAmount>
    <bs:NaverDiscountAmount>0</bs:NaverDiscountAmount>
    <bs:TotalOrderAmount>22000</bs:TotalOrderAmount>
    <bs:CashbackDiscountAmount>0</bs:CashbackDiscountAmount>
    <bs:PaymentAmount>22000</bs:PaymentAmount>
    <bs:PaymentMethod>무통장입금</bs:PaymentMethod>
    <bs:PaymentDate>2010-12-16T08:10:57.00Z</bs:PaymentDate>
    <bs:Escrow>false</bs:Escrow>
    <bs:ShippingFeeType>착불</bs:ShippingFeeType>
    <bs:SaleCompleteDate>2010-12-16T08:11:07.00Z</bs:SaleCompleteDate>
    <bs:PaymentDueDate>2010-12-23T14:59:59.00Z</bs:PaymentDueDate>
    <bs:PaymentNumber>102472225</bs:PaymentNumber>
    <bs:PaymentBank>농협중앙회</bs:PaymentBank>
    <bs:PaymentSender>김은정</bs:PaymentSender>
    <bs:MallUID>A704BAAD-ADC4-4031-90AB-FFDD5D0A60E8</bs:MallUID>
    </bs:Order>
    <bs:OrderProductList>
    <bs:OrderProduct>
    <bs:ProductName>[옵션 구매자입력형 &amp; 착불]</bs:ProductName>
    <bs:ProductID>P10121400016_nc</bs:ProductID>
    <bs:Quantity>1</bs:Quantity>
    <bs:UnitPrice>10000</bs:UnitPrice>
    <bs:ReturnRequested>false</bs:ReturnRequested>
    </bs:OrderProduct>
    <bs:OrderProduct>
    <bs:ProductName>[추가옵션]</bs:ProductName>
    <bs:ProductID>P10121400014_nc</bs:ProductID>
    <bs:Quantity>1</bs:Quantity>
    <bs:UnitPrice>12000</bs:UnitPrice>
    <bs:ReturnRequested>false</bs:ReturnRequested>
    </bs:OrderProduct>
    </bs:OrderProductList>
    <bs:Shipping>
    <bs:Recipient>B7KiPW9MdjR6ArW9e/tDTA==</bs:Recipient>
    <bs:ZipCode>463050</bs:ZipCode>
    <bs:ShippingAddress1>uysKFaWkcU16k/ca6DUxNY3Az1xP+DZL25hy8BlbXG7P/uQaXh+jlJrSu3i9xqWU</bs:ShippingAddress1>
    <bs:ShippingAddress2>5UtIfHIjLY8JVwD5wVlsZJry9nJXKa/HkcPFTPsoLuE=</bs:ShippingAddress2>
    <bs:RecipientTel1>PJmkUGj0b7ueKYaoZyUZ1Q==</bs:RecipientTel1>
    <bs:RecipientTel2>k0X1GHNtFZefBhKZzmUdAA==</bs:RecipientTel2>
    </bs:Shipping>
    </bs:PlacedOrder>
    </PlacedOrderList>
    </ma:GetPlacedOrderListResponse>
    </soapenv:Body>
    </soapenv:Envelope>
    ';
    
    $xml_parse2 =& new xml_parse2("__ALL__","PlacedOrder");

    $dataList = $xml_parse2->parse2($response);
    

    $i=0;
    foreach($dataList as $key=>$val) {
      if(sizeof($val['PRODUCTNAME']) > 1) {
        foreach($val['PRODUCTNAME'] as $key2=>$val2) {
          $dataList3 = array();
          $dataList3 = $val;
          $plus_order_id = $key2+1;
          $dataList3['ORDERID'] = $val['ORDERID']."_".$plus_order_id;
          $dataList3['PRODUCTNAME'] = $val['PRODUCTNAME'][$key2];
          $dataList3['PRODUCTID'] = $val['PRODUCTID'][$key2];
          $dataList3['QUANTITY'] = $val['QUANTITY'][$key2];
          $dataList3['UNITPRICE'] = $val['UNITPRICE'][$key2];
          $dataList3['RETURNREQUESTED'] = $val['RETURNREQUESTED'][$key2];
          $dataList3['ORDERPRODUCT'] = $val['ORDERPRODUCT'][$key2];
          $dataList2[$i] = $dataList3;
          $i++;
        }
      }else{
        $dataList2[$i] = $val;
        $i++;
      }
    }
    print_r($dataList2);
    exit;

  }
  
}  // class - End

?>