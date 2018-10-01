<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 주문 CLASS : 2010-12-07 정수진
//
//  실행주소 : http://minishop.ecadmin.playautocorp.com/execute/Execute_Admin.php?action=NHNOrder&as=OrderMan&NHNaction=PaidOrder
//-------------------------------------------------------------------------
require_once 'nhnapi-simplecryptlib.php';
require_once 'HTTP/Request.php';
require_once "xml_parser_uisl.php";

class NaverCheckOutOrder {

	var $inst_main;

  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOutOrder($__inst_main){
		$this->inst_main = $__inst_main;
  // function - End
  }

  //------------------------------------------------------------------------
  // 네이버 API 기본 셋팅
  //------------------------------------------------------------------------
  function init() {
    if($this->stype == "AMP") {
      //$this->test = true;
    }

    //$this->test = true;
    if($this->test) {
      //상수 선언
      $accessLicense = "01000100000503b9ecabad8d09c6e718ceaefd1f34033dc7d97db450be663f4686105cb068";  // 비밀 메일로 발송된  라이센트키 입력(테스트)
      $this->key= "AQABAAAVG60l7a89ffqtgHdTg1NGzPlANqc5clH/OMXXo8kG/g==";  // 비밀메일로 발송된 시크릿키 (테스트)
      $this->targetUrl = "http://sandbox.api.naver.com/Checkout/MallService4";
    }else{
      //상수 선언
      $accessLicense = "0100010000e5be7c82a4d24f24e836ac9b1ac177eaa62bbd3ec75d51a1f3b3760fa9346805";  // 비밀 메일로 발송된  라이센트키 입력
      $this->key= "AQABAAD/KPnN8qc4ZRzkg4/jOlgdH8AoAar+K0fxhyDk45CIfA==";  // 비밀메일로 발송된 시크릿키
      $this->targetUrl = "http://api.naver.com/Checkout/MallService4";
    }

    // 기본셋팅
    $this->service = "MallService4";
    $detailLevel = "Full";
    $version = "4.0";
    $RequestID="playauto_".date('Ymdhis');


    //NHNAPISCL 객체생성
    $this->scl = new NHNAPISCL();
    //타임스탬프를 포맷에 맞게 생성
    $this->timestamp = $timestamp = $this->scl->getTimestamp();

    //hmac-sha256서명생성
    $signature = $this->scl->generateSign($timestamp . $this->service . $this->operation, $this->key);

    //soap template에 생성한 값 기본 정보
    $this->request_head="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:mall=\"http://mall.checkout.platform.nhncorp.com/\" xmlns:base=\"http://base.checkout.platform.nhncorp.com/\">
    <soapenv:Header/>
    <soapenv:Body>
    <mall:".$this->operation."Request>
    <base:AccessCredentials>
    <base:AccessLicense>". $accessLicense . "</base:AccessLicense>
    <base:Timestamp>" . $timestamp . "</base:Timestamp>
    <base:Signature>" .$signature . "</base:Signature>
    </base:AccessCredentials>
    <base:RequestID>". $RequestID . "</base:RequestID>
    <base:DetailLevel>" . $detailLevel . "</base:DetailLevel>
    <base:Version>" . $version . "</base:Version>
    ";
  }

  //------------------------------------------------------------------------
  // 네이버에 API로 전송
  //------------------------------------------------------------------------
  function sendNHN($request_data,$debug=false) {
    $request_body=$this->request_head.$request_data;
    
    if($debug) {
      echo $request_body;
      exit;
    }
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

    $re_nhn_data = $rq->getResponseBody();
    if(eregi("ERR-COMMON-000302",$re_nhn_data)) {
      $data_error[error] = "ERR-COMMON-000302";
      echo $this->WebViewData($data_error);
      exit;
    }

    return $re_nhn_data;
    // funciton - End
  }

   //------------------------------------------------------------------------
  // 네이버 API로 받은 XML TEXT로 변환
  //------------------------------------------------------------------------
  function XmlToText($data,$thiskey='__ALL__',$search_array = array()) {

    $xml_parse =& new xml_parse_uisl($thiskey,$this->action);
    $dataList = $xml_parse->parse($data);
    $dataList2 = $dataList[$this->action];

    if(sizeof($search_array) > 0 && $search_array != "" ) {
      foreach($search_array as $key=>$val) {
        if($dataList[$key] != $val) {
          unset($dataList[$key]);
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
	    "RECIPIENTTEL2" => true,
      "ORDERERTEL1" => true,
      "MALLMEMBERID" => true,
      "BASEADDRESS" => true,
      "DETAILEDADDRESS" => true,
      "NAME" => true,
      "TEL1" => true,
      );

    //복호화 하기
    $decryptKey = $this->scl->generateKey($this->timestamp , $this->key);

    if(is_array($dataList2)) {
      foreach($dataList2 as $k=>$v) {
        
        // $search_array 값이 있을 경우 해당 정보의 데이터만 추출 되도록 나머진 삭제 처리
        if(sizeof($search_array) > 0 && $search_array != "") {
          $loop_ch = false;
          foreach($search_array as $sa_k=>$sa_v) {
            if($v[$sa_k] != $sa_v) { // 특정대상 내용이 아니면 삭제 처리
              unset($dataList2[$k]);
              $loop_ch = true;
            }
          }

          // 삭제된 정보는 아래 처리가 무의미 하므로 다음 배열순서로 넘김
          if($loop_ch) {
            continue;
          }
        }

        foreach($chdata as $k2=>$v2) {
          if($v[$k2] != "") { // 데이터 유무 확인
            $dataList2[$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
						// 주소에 " 삭제 : 2011-12-09 정수진
						if($k2=='SHIPPINGADDRESS2') { $dataList2[$k][$k2] = str_replace('"','',$dataList2[$k][$k2]); }
          }
        }

        if($this->stype == "AMP") {
          unset($dataList[$k]);
		      foreach($dataList2[$k] as $k2=>$v2) {
            $dataList[$k][$k2] = $v2;
          }
        }elseif($this->stype == "rese") {
          unset($dataList[$k]);
		      foreach($dataList2[$k] as $k2=>$v2) {
            $dataList[$k][$k2] = base64_encode(iconv("utf-8","UHC//IGNORE",$v2));
          }
        }else{
          unset($dataList[$k]);
          foreach($dataList2[$k] as $k2=>$v2) {
            $dataList2[$k][$k2] = iconv("utf-8","UHC//IGNORE",$v2);
          }
        }
      }
    }
    
    $dataList[$this->action] = $dataList2;
    return $dataList;
  }

  //------------------------------------------------------------------------
  // 네이버 API로 받은 XML TEXT로 변환 (묶음 주문 분할 처리 안함)
  //------------------------------------------------------------------------
  function XmlToText2($data,$thiskey='__ALL__') {

    $xml_parse =& new xml_parse($thiskey,$this->action);
    $dataList = $xml_parse->parse($data);
	$dataList2 = $dataList;

    //복호화 대상 필드
    // 네이버에서 정보 전달시 보안관련 정보는 암호화 해서줌 따라서 일부 정보들만 해독처리하게 필드 지정함
    $chdata = array(
      "ORDERERNAME" => true,
      "ORDERERID" => true,
      "ORDERERTEL" => true,
      "ORDEREREMAIL" => true,
      "RECIPIENT" => true,
      "SHIPPINGADDRESS1" => true,
      "SHIPPINGADDRESS2" => true,
      "RECIPIENTTEL1" => true,
	  "RECIPIENTTEL2" => true,
      );

    //복호화 인증기 생성
    $decryptKey = $this->scl->generateKey($this->timestamp , $this->key);

	if(is_array($dataList2)) {
		foreach($dataList2 as $k=>$v) {
			foreach($chdata as $k2=>$v2) {
				if($v[$k2] != "") { // 데이터 유무 확인
					// 인증키와 함께전달하여 암호 해독함
					$dataList2[$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
				}
			}
			unset($dataList[$k]);
			foreach($dataList2[$k] as $k2=>$v2) {
				if(is_array($v2)) {
					foreach($dataList2[$k][$k2] as $k3=>$v3) {
						$dataList[$k][$k2][$k3] = iconv("utf-8","UHC//IGNORE",$v3);
					}
				}else{
					$dataList[$k][$k2] = iconv("utf-8","UHC//IGNORE",$v2);
				}
			}
		}
	}

    return $dataList;
  }

  //------------------------------------------------------------------------
  // 상품주문번호로 주문 정보 검색
  // data_product_id_list : 상품주문번호 배열
  //------------------------------------------------------------------------
  function NHNPOrderSearch($data_product_id_list,$viewType = false,$action2 = array()) {

    $data_product_id_list = explode(",",$data_product_id_list);
    $this->action = strtoupper("ProductOrderInfoList");
    $this->operation = "GetProductOrderInfoList";

    $data_list = array();
    $data_product_id_list_array = array_chunk($data_product_id_list,1000);
    foreach($data_product_id_list_array as $key=>$val) {
      
      $this->init();
      $request_data = "";
      foreach($val as $key2=>$val2) {
        $request_data.="
          <mall:ProductOrderIDList>$val2</mall:ProductOrderIDList>
        ";
      }

      $request_data.="
      </mall:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";
           
      $data = $this->sendNHN($request_data); // 전송
      $data = $this->XmlToText($data,$this->NCkey,$action2); // XML을 배열로 변환
      
      $data_list = @array_merge($data_list,$data[$this->action]);
      sleep(0.5);
    }

     // 데이터 노출
    if($viewType) {
      return $data_list;
    }else{
      echo $this->WebViewData($data_list);
    }
    exit;
  }

  //------------------------------------------------------------------------
  // 배송지시 확인 처리
  //------------------------------------------------------------------------
  function NHNPlaceOrder($OrderID) {

    // 기본셋팅
    $this->action = "PlaceProductOrder";
    $this->operation = $this->action;

    $this->init();

    //전송데이터 셋팅 및 전송
    $request_data="
    <mall:ProductOrderID>$OrderID</mall:ProductOrderID>
    </mall:".$this->operation."Request>
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
  // 구주문번호(API 3.0)로 현재 (API 4.0)주문 정보 수집
  //------------------------------------------------------------------------
  function NHNPlaceOrder2($OrderID) {

    // 기본셋팅
    $this->action = strtoupper("MigratedProductOrderList");
    $this->operation = "GetMigratedProductOrderList";

    $this->init();

    //전송데이터 셋팅 및 전송
    $request_data="
    <mall:OldOrderID>100000001</mall:OldOrderID>
    </mall:".$this->operation."Request>
    </soapenv:Body>
    </soapenv:Envelope>";
    $data = $this->sendNHN($request_data);

    // XML을 TEXT로 변환
    $data = $this->XmlToText($data);

    return $data;
  }

  //------------------------------------------------------------------------
  // 상태별 주문 수집
  //------------------------------------------------------------------------
  function NHNOrder($thiskey,$action,$dday='') {
    
    set_time_limit(0);
    // --------------------------------
    // 기간설정
		if( $dday =='') $dday =-1;

    if( $this->CP_CODE == "street0" ) {
      $dday = 8;
    }
    
    // --------------------------------
    // 리셀러 사용자문제로 인해 체크아웃API3.0버전의 상태 코드값 유지해야함 
    // 그래서 체크아웃API3.0버전코드와 체크아웃API4.0버전 코드를 매칭해줌
    $action2 = array(); // 특정 조건에 해당하는 데이터만 추출시 사용
    if($action == "PlacedOrder") {
      $action = "PAYED"; // 송장정보 입력전 
      $action2[strtoupper('PlaceOrderStatus')] = "OK"; // 발주확인된 주문
    }elseif($action == "PaidOrder") {
      $action = "PAYED"; // 송장정보 입력전 
      $action2[strtoupper('PlaceOrderStatus')] = "NOT_YET"; // 발주확인 안된 주문
    }elseif($action == "ShippedOrder" || $action == "CompletedOrder") {
      $action = "DISPATCHED"; //배송후 구매확전 전까지
    }elseif($action == "ReturnOrder") {
      $action = "RETURN_REQUESTED"; // 반품요청
    }elseif($action == "ExchangOrder") {
      $action = "EXCHANGE_REQUESTED"; // 교환요청
    }elseif($action == "CancelOrder") {
      $action = "CANCEL_REQUESTED"; // 취소요청
    }elseif($action == "CanceledOrder") {
      $action = "CANCELED"; // 취소마감
    }elseif($action == "ReturnedOrder") {
      $action = "RETURNED"; // 반품마감
    }elseif($action == "ExchangedOrder") {
      $action = "EXCHANGED"; // 교환마감
    }

    

    $data_list = array();
    $data_product_id_list = array();
    for($i=$dday; $i>=-1; $i--) {

      // 조회기간 최대 24시간(1일)입니다.
      // 네이버 시간은 GMT(한국시간+9)시간 입니다
      $this->test = true;
      if($this->test) {
        $d_date = mktime(0,0,0,02,14,2012);
        $p_date = mktime(0,0,0,02,15,2012);
        $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
        $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간
      }else{
        $this->InquiryTimeFrom = date('Y-m-d',time() - 86400 * ($i+1))."T00:00:00+09:00";
        $this->InquiryTimeTo = date('Y-m-d',time() - 86400 * $i)."T00:00:00+09:00";
      }
      $this->test = false;
      // --------------------------------
      // 기간안에 해당하는 주문 번호 추출
      $this->operation = "GetChangedProductOrderList";
      $this->init();

      //전송데이터 셋팅
      $request_data="
      <base:InquiryTimeFrom>" . $this->InquiryTimeFrom . "</base:InquiryTimeFrom>
      <base:InquiryTimeTo>" . $this->InquiryTimeTo . "</base:InquiryTimeTo>
      <base:InquiryExtraData></base:InquiryExtraData>
      <mall:LastChangedStatusCode>$action</mall:LastChangedStatusCode>
     
      
      </mall:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";

      $data = $this->sendNHN($request_data); // 전송
      $data = $this->XmlToText($data,$this->NCkey); // XML을 배열로 변환

      sleep(0.5);
      $product_id_nm = 'PRODUCTORDERID';

      $data_product_id_list = @array_merge($data_product_id_list,$data[$product_id_nm]);  
      // 체크아웃 자체 조회결과가 최대 1000개만 가능하며 그 이상은 1000개이후부터 아래와 같이처리해야함
      if($data['HASMOREDATA'][0] == "true" ) {
        for($ii=0; $ii<20; $ii++) {
          $this->init();
          //전송데이터 셋팅
          $request_data="
          <base:InquiryTimeFrom>".$data['MOREDATATIMEFROM'][0]."</base:InquiryTimeFrom>
          <base:InquiryTimeTo>" . $this->InquiryTimeTo . "</base:InquiryTimeTo>
          <base:InquiryExtraData>".$data['INQUIRYEXTRADATA'][0]."</base:InquiryExtraData>
          </mall:".$this->operation."Request>
          </soapenv:Body>
          </soapenv:Envelope>";
          $data = $this->sendNHN($request_data); // 전송
          $data = $this->XmlToText($data,$this->NCkey); // XML을 배열로 변환

          sleep(0.5);
          $data_product_id_list = array_merge($data_product_id_list,$data[$product_id_nm]);

          if($data['HASMOREDATA'][0] != "true" ) {
            break;
          }
        }
      }
    }

    /*
    if($action != "ShippedOrder" && $action != "CompletedOrder") {
      // --------------------------------
      // 추출한 주문 번호로 주문상세정보 추출 하기
      if(sizeof($data_product_id_list) > 0 ) {
        $data_product_id_list = implode(",",array_unique($data_product_id_list));
        $data_list = $this->NHNPOrderSearch($data_product_id_list,true,$action2);
        //sleep(0.5);
      }
    }
    */

    if(sizeof($data_product_id_list) > 0 ) {
      $data_product_id_list_old = array();
      $data_product_id_list_new = array();
      // 구주분 번호와 신주문 번호 구별하기
      foreach($data_product_id_list as $key=>$val) {
        if(strlen($val) < 10) {
          $data_product_id_list_old[$key] = $val;
        }else{
          $data_product_id_list_new[$key] = $val;
        }
      }

      if($action != "ShippedOrder" && $action != "CompletedOrder") {
        // --------------------------------
        // 추출한 주문 번호로 주문상세정보 추출 하기
        if(sizeof($data_product_id_list_old) > 0 ) {
          foreach($data_product_id_list_old as $key=>$val) {
            $data_list_old = $this->NHNPOrderSearch2($val);
            $data_list = array_merge($data_list,$data_list_old);
          }
        }


        // 추출한 주문 번호로 주문상세정보 추출 하기
        if(sizeof($data_product_id_list_new) > 0 ) {
          $data_product_id_list_new = implode(",",array_unique($data_product_id_list_new));
          print_r(sizeof($data_product_id_list_new));
          exit;
          $data_list_new = $this->NHNPOrderSearch($data_product_id_list_new,true,$action2);
          $data_list = @array_merge($data_list,$data_list_new);
          //sleep(0.5);
        }
      }
    }

    // --------------------------------
    // 주문 약식 매칭정보 저장하기
    if($this->action == "PlacedOrder") {

    if(sizeof($data_list)>0) {
      foreach($data_list as $k=>$v) {
        if($v['MALLMANAGECODE'] != '') {
          // 특수주문 조회
          $msg = $this->MatchSpecialOrder($v['MALLMANAGECODE']);
          $data_list[$k]['SHIPPINGMESSAGE'] = $data_list[$k]['SHIPPINGMESSAGE'].' '.$msg;
        }
      // loop - End
      }
    }

    // 신규주문일때
      $this->OrderMatchInsert($data_list);
    }else{
      // 동기화 일때
    }

    echo $this->WebViewData($data_list);
    exit;
  }

  //------------------------------------------------------------------------
  // 에이스 카운터 전송용 상태별 주문 수집 2011-08-16 남형진
  //------------------------------------------------------------------------
  function NHNOrder_ACT($action,$Shop_key,$dday='14') {

	$Shop_key = $Shop_key == "" ? "ALL":$Shop_key;
    $data_list = array();
	$dday = 1;
	for($i=0; $i<$dday; $i++) {

		// 조회기간 최대 24시간(1일)입니다.
		// 네이버 시간은 GMT(한국시간+9)시간 입니다
		// $this->InquiryTimeFrom = date('Y-m-d',time() - 86400 * ($i+1))."T".date('H:i:s')."+09:00";
		// $this->InquiryTimeTo = date('Y-m-d',time() - 86400 * $i)."T".date('H:i:s')."+09:00";
		$this->InquiryTimeFrom = date('Y-m-d',time() - 7200)."T".date('H:i:s',time() - 7200)."+09:00";
		$this->InquiryTimeTo = date('Y-m-d',time() - 3000)."T".date('H:i:s',time() - 3000)."+09:00";

		// 기본셋팅
		$this->action = $action;
		$this->operation = "Get".$this->action."List";
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

		// XML을 TEXT로 변환
		$data = $this->XmlToText2($data);
		$counts = sizeof($data);

		$re_data = array();
		if($counts > 0 ) {
			// 묶음 배송중에 부분 배송처리 유무 판단
			$kk = 0;
			for($j=0; $j<$counts; $j++) {
				// 주문번호가 숫자가 아닐때 패쓰 2011-08-04 우형기
				// 이상한 주문이 수집되는것을 방지.
				if($this->stype != "rese") {
					$check_order = str_replace("_","",$data[$j][ORDERID]);
					if(!is_numeric($check_order)) {	unset($data[$j]); continue;	}
				}

				if(eregi($data[$j][MALLUID],$Shop_key) || $Shop_key == 'ALL') {
					$re_data[$kk][MALLUID]				= $data[$j][MALLUID];			// 업체키
					$re_data[$kk][ORDERID]				= $data[$j][ORDERID];			// 주문번호
					$re_data[$kk][MALLMANAGECODE]		= $data[$j][MALLMANAGECODE];	// 마스터 상품코드
					$re_data[$kk][ORDERDATETIME]		= $this->GMTToKTime($data[$j][ORDERDATETIME]);		// 주문일
					$re_data[$kk][PAYMENTDATE]			= $this->GMTToKTime($data[$j][PAYMENTDATE]);		// 결제일
					$re_data[$kk][PRODUCTID]			= $data[$j][PRODUCTID];			// 상품코드
					$re_data[$kk][PRODUCTNAME]			= $data[$j][PRODUCTNAME];		// 상품명
					$re_data[$kk][QUANTITY]				= $data[$j][QUANTITY];			// 수량
					$re_data[$kk][UNITPRICE]			= $data[$j][UNITPRICE];			// 상품단가
					$re_data[$kk][TOTALORDERAMOUNT]		= $data[$j][TOTALORDERAMOUNT];	// 실제결제가
					$re_data[$kk][ORDERSTATUS]			= $data[$j][ORDERSTATUS];		// 주문상태
					$kk++;
				}

			// loop - End
			}
		}

		$data_list = array_merge($data_list,$re_data);
    }

    // 주문 약식 매칭정보 저장하기
    if($this->action == "PlacedOrder") {

    }else{
    // 동기화 일때
    }

    echo $this->WebViewData($data_list);
    exit;
  }

  /*
  //------------------------------------------------------------------------
  // 송장전송
  //------------------------------------------------------------------------
  function NHNShipOrder($OrderID,$ShippingCompany,$TrackingNumber) {

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

    // 데이터 노출
    echo $this->WebViewData($data);
    exit;
  }
*/

  //------------------------------------------------------------------------
  // 송장전송
  // $ProductOrderID : 상품 주문번호
  // $DeliveryMethodCode : 배송방법 코드
  // $DeliveryCompanyCode : 택배사 코드
  // TrackingNumber : 송장번호
  //------------------------------------------------------------------------
  function NHNShipOrder($para) {
    
   // 기본셋팅
    $this->action = "ShipProductOrder";
    $this->operation = $this->action;
    $this->init();

    $DispatchDate = date("Y-m-d\TH:i:s",strtotime("-9hour"));

    //전송데이터 셋팅 및 전송
    $request_data="
    <mall:ProductOrderID>".$para['OrderID']."</mall:ProductOrderID>
    <mall:DeliveryMethodCode>".$para['DeliveryMethodCode']."</mall:DeliveryMethodCode>
    <mall:DeliveryCompanyCode>".$para['DeliveryCompanyCode']."</mall:DeliveryCompanyCode>
    <mall:TrackingNumber>".$para['TrackingNumber']."</mall:TrackingNumber>
    <mall:DispatchDate>".$DispatchDate."</mall:DispatchDate>
    </mall:".$this->operation."Request>
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
    }elseif($this->stype == "rese") {
      $ViewDataEncode = json_encode($data);
    }else{
      $ViewDataEncode = base64_encode(serialize($data));
    }

    if($this->stype == "rese") {
      $ViewData = $ViewDataEncode;
    }else{
      $ViewData = '<?xml version="1.0" encoding="utf-8"?>
      <PLAYAUTO_RESPONSE>
        <RESULT>OK</RESULT>
        <MSG></MSG>
        <DATA><![CDATA['.$ViewDataEncode.']]></DATA>
      </PLAYAUTO_RESPONSE>
      ';
    }


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
      if($this->stype == "rese") {
        $in_data['wdate'] = date('Y-m-d H:i:s');
        $in_data['state'] = "발송전";
        $in_data['cp_code'] = $this->CP_CODE;
        $in_data['nhn_ocode'] = base64_decode($val['NHNORDERID']);
        $in_data['pa_ocode'] = base64_decode($val['ORDERID']);
        $in_data['goods_code'] = base64_decode($val['PRODUCTID']);
        $in_data['bundle_count'] = base64_decode($val['BUNDLECOUNT']);
      }else{
        $in_data['wdate'] = date('Y-m-d H:i:s');
        $in_data['state'] = "발송전";
        $in_data['cp_code'] = $this->CP_CODE;
        $in_data['nhn_ocode'] = $val['NHNORDERID'];
        $in_data['pa_ocode'] = $val['ORDERID'];
        $in_data['goods_code'] = $val['PRODUCTID'];
        $in_data['bundle_count'] = $val['BUNDLECOUNT'];
      }
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

    // 연결정보 - 기본 미니샵외 다른 디비서버 접속이라 여기서 바로 연결 처리함
    $in_data['nhn_ocode'] = $ORDER_ID;
    $in_data['cp_code'] = $this->CP_CODE;

    $re = $this->sock->Array_insert("ECHost.orderMatch",$in_data,"Success" ,false);

    if($re != "Success") {
      for($i=0; $i<10; $i++) {
        $re = $this->sock->Array_insert("ECHost.orderMatch",$in_data,"Success" ,false);
        if($re == "Success") {
          break;
        }
      }
    }

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
    */


  }

  //-----------------------------------------------------------------------------
  //  특수 주문 저장된값 가져오기
  //-----------------------------------------------------------------------------
  function MatchSpecialOrder($MALLMANAGECODE) {

	$sql = "select * from $this->DataBase.Special_order where Order_id = '".$MALLMANAGECODE."' ";
	$re = $this->sock->fetch($sql);

	$msg = "";
	if(sizeof($re)>0 && $re[0][text1] != '') {
		$data = unserialize($re[0][text1]);
		if($data[type] == 'flower') {
			$msg = "선물메세지:".$data[ordertype]."(".$data[add_msg].")";
		}
	}
	return $msg;

  // funciton - End
  }

  //-----------------------------------------------------------------------------
  //  날짜 형식변환
  //-----------------------------------------------------------------------------
  function GMTToKTime($dateData) {
	$dateData = str_replace(".00Z","",$dateData);
	$array_time = explode("T",$dateData);
	$array_time1 = explode("-",$array_time[0]);
	$array_time2 = explode(":",$array_time[1]);

	$array_time3 = mktime($array_time2[0],$array_time2[1],$array_time2[2],$array_time1[1],$array_time1[2],$array_time1[0]);
	$ktime = date('Y-m-d H:i:s',$array_time3 + 32400);
	return $ktime;
  }

}  // class - End




?>