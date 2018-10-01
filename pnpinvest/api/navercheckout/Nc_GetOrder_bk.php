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

    if($this->test) {
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
    <ns2:".$this->operation."Request xmlns=\"http://base.checkout.platform.nhncorp.com/\" xsi:type=\"ns2:".$this->operation."RequestType\" xmlns:ns2=\"http://mall.checkout.platform.nhncorp.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
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
          $dataList3['PRODUCTNAME'] = iconv("euc-kr","utf-8","[체크아웃]").$val['PRODUCTNAME'][$key2];
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
	  "RECIPIENTTEL2" => true,
      );

    //복호화 하기
    $decryptKey = $this->scl->generateKey($this->timestamp , $this->key);

    if(is_array($dataList2)) {
      foreach($dataList2 as $k=>$v) {
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
            $dataList[$k][$k2] = iconv("utf-8","UHC//IGNORE",$v2);
          }
        }
      }
    }
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
  // 주문번호로 주문 정보 검색
  //------------------------------------------------------------------------
  function NHNPOrderSearch($OrderID) {
    
    if( eregi("-",$OrderID) ) {
      $post = array();
      $OrderID_array = explode(" ",$OrderID);
      $post['Cart_id'] = $OrderID_array[1];
      $data2 = $this->inst_main->inst_OrderSelect->OMP_order(&$post,&$this->CP_CODE);

      if($data2[0]['status'] == "19") {
        $data[0]['ORDERSTATUSCODE'] = "OD0008";
      }elseif($data2[0]['status'] == "22") {
        $data[0]['ORDERSTATUSCODE'] = "OD0010";
      }elseif($data2[0]['status'] != "") {
        $data[0]['ORDERSTATUSCODE'] = "dd_order";
      }else{
        $data[0]['ORDERSTATUSCODE'] = "";
      }
    }else{
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
    }

    // 데이터 노출
    echo $this->WebViewData($data);
    exit;
  }

  //------------------------------------------------------------------------
  // 배송지시 확인 처리
  //------------------------------------------------------------------------
  function NHNPlaceOrder($OrderID) {
    
    if( eregi("-",$OrderID) ) {
      $OrderID_array = explode(" ",$OrderID);
      $UpdateArray[0][Cart_id] = $OrderID;
      $UpdateArray[0][Status] = "19";
      $UpdateArray[0][Cart_id] = $OrderID_array[1];

      $this->inst_main->inst_OrderExecute->UpdateOrderCartInfo(&$UpdateArray);
      $data[msg] = "Success";

    }else{
      // 기본셋팅
      $this->action = "PlaceOrder";
      $this->operation = $this->action;

      $this->init();

      //전송데이터 셋팅 및 전송
      $request_data="
      <OrderID> $OrderID </OrderID>
      </ns2:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";
      $data = $this->sendNHN($request_data);

      // XML을 TEXT로 변환
      $data = $this->XmlToText($data);
    }
    // 데이터 노출
    echo $this->WebViewData($data);
    exit;
  }

  //------------------------------------------------------------------------
  // 상태별 주문 수집
  //------------------------------------------------------------------------
  function NHNOrder($thiskey,$action,$dday='') {

    // -----------------------------------------------------------
    // 네이버 체크아웃
		// 2011년 7월 21일 목요일 우형기 추가 날짜
		if( $dday =='') $dday =10;

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

    if( $this->CP_CODE == "street0" ) {
      $dday = 8;
    }

    $data_list = array();
    for($i=$dday; $i>=-1; $i--) {

    // 조회기간 최대 24시간(1일)입니다.
    // 네이버 시간은 GMT(한국시간+9)시간 입니다
    if($this->test) {
      $d_date = mktime(0,0,0,01,03,2010);
      $p_date = mktime(0,0,0,01,04,2010);
      $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
      $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간
    }else{
      /*
      $s_timestamp = time() - 86400 * ($i+1);
      $e_timestamp = time() - 86400 * $i;
      $d_date = mktime(0,0,0,date('m',$s_timestamp),date('d',$s_timestamp),date('Y',$s_timestamp));
      $p_date = mktime(0,0,0,date('m',$e_timestamp),date('d',$e_timestamp),date('Y',$e_timestamp));
      $this->InquiryTimeFrom = date('Y-m-d',$d_date - 32400)."T".date('H:i:s',$d_date - 32400);  //InquiryTimeFrom 조회기간
      $this->InquiryTimeTo = date('Y-m-d',$p_date - 32400)."T".date('H:i:s',$p_date - 32400); //InquiryTimeTo 조회기간
      */

      $this->InquiryTimeFrom = date('Y-m-d',time() - 86400 * ($i+1))."T00:00:00+09:00";
      $this->InquiryTimeTo = date('Y-m-d',time() - 86400 * $i)."T00:00:00+09:00";
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
			<MallUID>".$this->NCkey."</MallUID>
      </ns2:".$this->operation."Request>
      </soapenv:Body>
      </soapenv:Envelope>";

      // 전송
      $data = $this->sendNHN($request_data);
sleep(0.5);
      // XML을 TEXT로 변환
      $data = $this->XmlToText($data,$this->NCkey);

			// 2011-06-21 우형기 추가 부분------------- 시작 ------------------------
			$counts = sizeof($data);

			if($counts > 0 ) {
				// 묶음 배송중에 부분 배송처리 유무 판단

				for($j=0; $j<$counts; $j++) {

					// 주문번호가 숫자가 아닐때 패쓰 2011-08-04 우형기
					// 이상한 주문이 수집되는것을 방지.
					if($this->stype != "rese") {
						$check_order = str_replace("_","",$data[$j][ORDERID]);

						if(!is_numeric($check_order)) {	unset($data[$j]); continue;	}
					}

					// 묶음 배송 이면서 배송코드가 OD0037 배송 처리 완료 일때
					// DB와 비교해서 정말 발송이 되었는지 확인 해서 아니면 OD0008 미발송 값을 바꾸준다.
					if($data[$j]['BUNDLECOUNT'] > 1 && $data[$j]['ORDERSTATUSCODE'] =='OD0037' ) {

						$Goods_query = "select * from $this->DataBase.Order_Match where nhn_ocode  = '".$data[$j]['NHNORDERID']."' AND ( nhn_sender != '' OR pa_sender !='' OR  sendno != '') ";
						$this->sock->reset_rownum();
						$this->sock->fetch($Goods_query);
						$Goods_sql = $this->sock->rownum;

						// 만약 프로그램을 쓰지 않고 배송했을때 그냥 동기화 되도록 넘어간다.
						if($Goods_sql == '0') continue;

						$sql = "select * from $this->DataBase.Order_Match where pa_ocode = '".$data[$j]['ORDERID']."' ";
						$re = $this->sock->fetch($sql);

						if( $re[0][state] != "발송완료" ) {
							$data[$j][ORDERSTATUSCODE] = "OD0008";
							$data[$j][ORDERSTATUS] = "미발송";
						}

					}

				// loop - End
				}
			}



			// 2011-06-21 우형기 추가 부분------------- 끝 ------------------------

			$data_list = array_merge($data_list,$data);
    }

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
            
    // -----------------------------------------------------------
    // 미니샵 자체주문

    if($action == "PlacedOrder") { // 발주확인 처리할 대상 주문 
      $state_list = "predeliv";
    }elseif($action == "PaidOrder") { //송장번호 입력할 신규주문 
      $state_list = "accountok";
    }elseif($action == "ShippedOrder") { //배송중,수취확인
      $state_list = "deliv,orderget";
    }elseif($action == "CompletedOrder") { //정산완료
      $state_list = "orderok";
    }elseif($action == "ReturnedOrder") { //반품요청 , 반품마감
      $state_list = "askreturn,okreturn";
    }elseif($action == "ExchangedOrder") { //교환요청 , 교환마감
      $state_list = "askchange,okchangecross";
    }elseif($action == "CancelOrder") { //취소요청
      $state_list = "askRcancle";
    }elseif($action == "CanceledOrder") { //취소마감
      $state_list = "askRcancleok";
    }

    // 미니샵 주문건 최종 합체
    if($this->stype == "AMP") {
      $incodig_type = "utf-8";
    }else{
      $incodig_type = "euc-kr";
    }

    $data_list = @array_merge($data_list,$this->getAutoMall($state_list,$incodig_type));
		
    // 웹에 뿌리기
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
  // $OrderID : 주문 번호 ( * 단 아래의 규칙을 따라야함 )
  //   - type이 save는 "_"이후가 들어간 플레이오토 주문 번호
  //   - type이 exec는 "_"이후가 제거된 네이버 주문 번호
  //------------------------------------------------------------------------
  function NHNShipOrder($para) {
    $data = array(); // 결과 메세지 초기화

    if( eregi("-",$para['OrdID']) ) {
      // ----------------------------------------------
      // 오토몰 송장처리
      
      // 오토몰 배송사 조회 처리
      $data2 = $this->inst_main->inst_OrderSelect->GetDelivCostInfo(&$this->CP_CODE);

      $sender_code = "";
      for($i=0; $i<sizeof($data2[0][field3]); $i++) {
        if( eregi($para['pa_sender'],$data2[0][field3][$i]) ) {
          $sender_code = $data2[0][field1][$i];
        }
      // loop - End
      }

      $Order_id = explode(" ",$para['OrdID']);
      $InsertOrder_Array = $Order_Array = array();
      $Order_Array[Order_id][0] = $Order_id[0];
      $Order_Array[Cart_id][0] = $Order_id[1];
      $Order_Array[Delivery_code][0] = $sender_code;
      $Order_Array[Delivery_com][0] = $para['sendno'];
      $Order_Array[Regi_date][0] = "now()";
      $Order_Array[Delivery_status][0] = "정상";

      $InsertOrder_Array[Cart_id][] = $Order_id[1];
      $InsertOrder_Array[Delivery_com][] = $sender_code;
      $InsertOrder_Array[Delivery_code][] = $para['sendno'];
      $InsertOrder_Array[Regi_date][] = "now()";

      $result = $this->inst_main->inst_OrderExecute->InsertCart_id_Excel(&$Order_Array,&$InsertOrder_Array,array(),&$this->inst_main);

      if($result == "error") {
        $data['msg'] = "Save-False";
      }else{
        $data['msg'] = "Save-Ok";
      }

      echo $this->WebViewData($data);
      exit;

    }else{
      // ----------------------------------------------
      // 체크아웃 송장처리
      
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


            // 성공여부 조건 미리 만들기
            $re_data_y = false;
            if(eregi("SUCCESS",$real_data[0]['RESPONSETYPE'])) {
              $re_data_y = true;
            }elseif($real_data[0]['CODE'] == "ERR-NC-101002" && eregi("주문 상태: 배송처리완료", iconv("utf-8","UHC",$real_data[0]['MESSAGE'])) ) {
              $re_data_y = true;
            }

            if($re_data_y) {
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
  sleep(0.5);
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

  //-----------------------------------------------------------------------------
  //  날짜 형식변환
  //-----------------------------------------------------------------------------
  function getAutoMall($state,$incodig_type) {
    $state_array = explode(",",$state);
    $mini_data_list = array();
    foreach($state_array as $key=>$val) {
      $_POST = array();
      $_POST['as'] = "OrderMan";
      $_POST['Cart_lists'] ="OMP";            // OMP로 보내면 배송준비 상태 전체주문건 받아옴
      $_POST['Fields_lists'] = "Order_id/Cart_id/Delivery_com/Delivery_code/Order_date/Status/Order_name/Order_mobile/Order_email/Receiver_name/Receiver_zipcode/Receiver_desty/Receiver_tell/Receiver_mobile/Goods_name/Goods_no/Selected_opt/Selected_addition/Amount/Delivery_cost/Account_method/Money/Delivery_date";
      $_POST['omp_state'] = "Y";
      $_POST['mini_state'] = $val;
      $mini_data = $this->inst_main->inst_Order->ExcelDownLoadOMP(&$this->inst_main,$incodig_type);
      if($mini_data != "") {
        $mini_data_list = @array_merge($mini_data_list,$mini_data);  
      }
    }
   
    return $mini_data_list;
  }

}  // class - End




?>