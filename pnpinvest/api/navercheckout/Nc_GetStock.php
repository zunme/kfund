<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 재고 CLASS : 2011-05-02 정수진
//
//  테스트실행주소 : http://stock.nhn.playauto.co.kr/NhnStock.php?TYPE=PAY
//  실제연동주소 : http://stockc.nhn.playauto.co.kr/NhnStock.php?TYPE=PAY
//  stock 주소로 하려하였으나 222가 229로 아이피변경시간이 있어 stockc를 229로 만듬
//-------------------------------------------------------------------------
require_once 'nhnapi-simplecryptlib.php';
require_once 'HTTP/Request.php';
require_once "xml_parser_stock.php";

class NaverCheckOutStock {
  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOutStock($main_sock,$select_sock,$execute_Sock){

    $this->select_sock = $select_sock;
    $this->main_sock = $main_sock;
    $this->execute_sock = $execute_Sock;

  // function - End
  }

  //------------------------------------------------------------------------
  // 네이버 API 기본 셋팅
  //------------------------------------------------------------------------
  function init() {

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
    $dataList2 = array();
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
          $dataList2[$val['MALLUID']][] = $dataList3;
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

    //  배열에 존재하는 필드만 배열로 만듬
    $filed = array('ORDERDATETIME','ORDERID','ORDERSTATUSCODE','ORDERSTATUS','ORDERERNAME','ORDERERID','PAYMENTNUMBER','MALLMANAGECODE','MALLUID','PRODUCTID','PRODUCTOPTION','QUANTITY','NHNORDERID','BUNDLECOUNT');

    if(is_array($dataList2)) {
      foreach($dataList2 as $kv=>$vv) {
        foreach($vv as $k=>$v) {
          foreach($chdata as $k2=>$v2) {
            if($v[$k2] != "") { // 데이터 유무 확인
              $dataList2[$kv][$k][$k2] = $this->scl->decrypt($decryptKey, $v[$k2]);
            }
          }
          unset($dataList[$k]);
          foreach($dataList2[$kv][$k] as $k2=>$v2) {
            if(in_array($k2,$filed)) {
              $dataList4[$kv][$k][$k2] = iconv("utf-8","UHC",$v2);
            }
          }
        }
      }
    }
    return $dataList4;
  }

  //------------------------------------------------------------------------
  // 상태별 주문 수집
  //------------------------------------------------------------------------
  function NHNOrder($thiskey,$type_action) {

    //  조회기간 - 현재시간 +- 30분
    $this->InquiryTimeFrom = date('Y-m-d')."T".date('H:i:s',time() - 1800)."+09:00";
    $this->InquiryTimeTo = date('Y-m-d')."T".date('H:i:s',time() + 1800)."+09:00";

    //$this->InquiryTimeFrom = "2011-05-11T00:00:00+09:00";
    //$this->InquiryTimeTo = "2011-05-12T00:00:00+09:00";

    /*  네이버에서 보내는 값은 다음과 같으며 교환,반품,고객은 사용안함
    UNPAY 미입금 주문
    PAY 결제 완료
    CANCEL 주문 취소
    EXCHANGE 교환 신청
    RETURN 반품 신청
    INQUIRY 고객 문의 등록
    */
    switch($type_action) {
      //  미입금 주문
      case "UNPAY" : $action='UnpaidOrder'; break;
      //  결제완료
      case "PAY" : $action='PaidOrder'; break;

			//case "ORDER" : $action='PlacedOrder'; break;
      //  주문취소
      //case "CANCEL" : $action='CanceledOrder'; break;

      default : echo $this->WebViewData(); exit; break;
    }

    echo $this->WebViewData();

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
    $data = $this->XmlToText($data);

		// 업체별 데이터 저장
    $this->UserDateSave($data);

		/*/  테스트시 업체코드 넣고 실행
		$test_data = array();
		//$td_key = 'BABBDD02-B1E4-4B9E-8EBA-0AE048391583';
		$td_key = '031ED885-D85B-45FB-85FA-94E46AA0D44F';
		$test_data[$td_key] = $data[$td_key];
		if($test_data[$td_key][0]['MALLUID']!='') {
			// 업체별 데이터 저장
			xmp($test_data);
			$this->UserDateSave($test_data);
		}

		// 업체별 데이터 저장
		//$this->UserDateSave($test_data); */

    exit;
  }


  //-----------------------------------------------------------------------------
  // 업체별 테이블 저장
  //-----------------------------------------------------------------------------
  function UserDateSave($data) {

    //  CP_CODE 검색
    $query = "select cp_code,ncbuttonkey,DBServerNM from ECHost.Minishop_Nckey order by No asc";
    $user_data = $this->main_sock->fetch($query);

    $user_info = array();
    for($i=0; $i<count($user_data); $i++) {
      $user_info[cp_code][$i] = $user_data[$i][cp_code];
      $user_info[ncbuttonkey][$i] = $user_data[$i][ncbuttonkey];
    }

    if (!is_array($data)){ $data = array(); }

    foreach($data as $k=>$v) {

      $cp_code_key = array_search($k,$user_info[ncbuttonkey]);

      if($cp_code_key!==false) {

        //  주문수 많큼 루프
        for($od=0; $od<count($v); $od++) {
          $table = "EC_".$user_info[cp_code][$cp_code_key];

          //  중복 체크
          $duple_result = $this->DuplOrderid($table,$v[$od][PRODUCTID],$v[$od][ORDERID],$v[$od][NHNORDERID],$v[$od][ORDERSTATUSCODE]);

          if($duple_result!='dupl') {

            $insert_array = array();
            $insert_array[no] = '';
            $insert_array[ORDERDATETIME] = $v[$od][ORDERDATETIME];
            $insert_array[NHNORDERID] = $v[$od][NHNORDERID];
            $insert_array[ORDERID] = $v[$od][ORDERID];
            $insert_array[ORDERSTATUSCODE] = $v[$od][ORDERSTATUSCODE];
            $insert_array[PRODUCTID] = $v[$od][PRODUCTID];
            $insert_array[PRODUCTOPTION] = $v[$od][PRODUCTOPTION];
            $insert_array[QUANTITY] = $v[$od][QUANTITY];
            $insert_array[BUNDLECOUNT] = $v[$od][BUNDLECOUNT];
            $result = $this->execute_sock->Array_insert($table.".Goods_Stock_Log",$insert_array,'Success');

            if($result=='Success') {

              //  상품검색
              $goods_query = "select Goods_no,Volume,Stock from ".$table.".Goods_Basic where Goods_no='".$v[$od][PRODUCTID]."';";
              $goods_data = $this->select_sock->fetch($goods_query);

              //  ': [추가구매]' 기준으로 옵션과 추가구매 분리. 추후 추가구매 표시 변경시 재고처리부분도 반드시 변경해야함.
              $user_opt = explode(': [추가구매]',$v[$od][PRODUCTOPTION]);

              //  상품옵션 검색
              $opt_query = "select * from ".$table.".Goods_option where Goods_no='".$v[$od][PRODUCTID]."' and Option_section='1';";
              $opt_data = $this->select_sock->fetch($opt_query);
              $temp = explode("[_Opt_]",$opt_data[0][details]);

              //  디비옵션은 있고 유저옵션이 없는데 입력형도 아니고 상세옵션도 아닐때 처리안함
              if(trim($user_opt[0])=='' && (trim($temp[0])=='manual' || trim($temp[0])=='manual2' || trim($temp[0])=='manual3' || trim($temp[0])=='insert' || trim($temp[1])!='')) {
                // 처리안함
              }
              else {
                //  옵션없음
                if(trim($user_opt[0])=='') {
                  $this->UpdateGoodsStock($table,$v[$od][PRODUCTID],$goods_data[0][volume],$v[$od][QUANTITY]);
                }
                else {
                  //  상세 옵션
                  if($temp[0]=='manual' || $temp[0]=='manual2' || $temp[0]=='manual3') {

                    $manual_opt_result = $this->UpdateManualoptDetail($v[$od][PRODUCTID],$user_opt,$opt_data,$v[$od][QUANTITY],$table);
                    if($manual_opt_result=='Success') {
                      $this->UpdateGoodsStock($table,$v[$od][PRODUCTID],$goods_data[0][volume],$v[$od][QUANTITY]);
                    }
                  }
                  //  입력형 옵션
                  else {
                    $this->UpdateGoodsStock($table,$v[$od][PRODUCTID],$goods_data[0][volume],$v[$od][QUANTITY]);
                  }
                }
              }

            // $result=='Success' end
            }
          // $duple_result!='dupl'
          }
        // $od loop end
        }
      //  $cp_code_key
      }
    //  $data end
    }

  // funciton - End
  }


  //-----------------------------------------------------------------------------
  // 주문 중복 체크 - 중복일 경우 상태 업데이트 한다
  // $table=데이터베이스명, $goods_no=상품코드, $playauto_orderid=플레이오토 주문번호(unique), $naver_orderid=네이버주문번호, $naver_orderstatus=네이버주문상태
  //-----------------------------------------------------------------------------
  function DuplOrderid($table,$goods_no,$playauto_orderid,$naver_orderid,$naver_orderstatus) {
    //  주문 로그검색
    $log_query = "select PRODUCTID,ORDERID,NHNORDERID from ".$table.".Goods_Stock_Log where PRODUCTID='$goods_no' and ORDERID='$playauto_orderid' and NHNORDERID='$naver_orderid';";

    $log_data = $this->select_sock->fetch($log_query);

    if($log_data[0][orderid]=='') { $log_result = 'ok';}
    else {
      $dupl_update_query = array();
      $dupl_update_query[ORDERSTATUSCODE] = $naver_orderstatus;
      $dupl_update_where = sprintf("PRODUCTID='%s' and ORDERID='%s' and NHNORDERID='%s'",$goods_no,$playauto_orderid,$naver_orderid);
      $dupl_update_data = $this->execute_sock->Array_update($table.".Goods_Stock_Log",$dupl_update_query,$dupl_update_where,"Success",false);

      $log_result = 'dupl';
    }

    return $log_result;

  // funciton - End
  }


  //-----------------------------------------------------------------------------
  // 상세옵션 수량 차감
  // $umd_goods_code=상품코드, $umd_user_opt=주문옵션, $umd_db_opt=상품옵션, $umd_user_quantity=주문수량, $table=업체데이터베이스
  //-----------------------------------------------------------------------------
  function UpdateManualoptDetail($umd_goods_code, $umd_user_opt, $umd_db_opt, $umd_user_quantity, $table) {

		$temp = explode("[_Opt_]",$umd_db_opt[0][details]);

		if(trim($temp[0]) == 'manual' || trim($temp[0]) == 'manual2' || trim($temp[0]) == 'manual3') {

			$opt_temp = explode("[_Opt_]",$umd_db_opt[0][details]);
			$opt_db = unserialize($opt_temp[1]);

			$user_temp = explode("____",$umd_user_opt[0]);

			$user_opt_part = explode('||',$user_temp[0]);

			$user_opt_part[0] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[0])); //  옵션가 제거
			$user_opt_part[1] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[1])); //  옵션가 제거

			foreach($opt_db as $od_k=>$od_v) {

				//  구분1이 같을때
				if(trim($od_k) == trim($user_opt_part[0])) {

					//  구분2값 확인
					$udp_flag = 0;
					//	같은 구분명이 두번들어감
					if(trim($umd_db_opt[0][opt_name1]!='') && trim($umd_db_opt[0][opt_name2]!='')) {
						$od_v_key = array_keys($od_v);
						if(trim($od_v_key[0])==trim($user_opt_part[0])) {
							$udp_flag = 1;						
						}
					}
					//	구분명이 한번만 들어감
					elseif(trim($umd_db_opt[0][opt_name1]!='') && trim($umd_db_opt[0][opt_name2]=='')) {
						$udp_flag = 2;
					}

					//  옵션이 하나인 주문일 경우
					if(trim($user_opt_part[1])=='' && count($opt_db[$od_k])=='1' && ($udp_flag=='1' || $udp_flag=='2')) {

						if($udp_flag=='2') { 
							$one_opt = explode('|',$opt_db[$od_k][0]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][0] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}
						else {
							$one_opt = explode('|',$opt_db[$od_k][$od_k]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][$od_k] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}

						//  옵션수량 차감 업데이트
						$opt_update_array = array();
						$opt_update_array[Details] = $opt_update;
						$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
						$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);
					}
					//  옵션이 두개인 주문일 경우
					else {
						//  구분2 검색
						foreach($opt_db[$user_opt_part[0]] as $odk_k=>$odk_v) {
							//  구분2가 같은경우
							if(trim($odk_k)==trim($user_opt_part[1])) {

								$two_opt = explode('|',$odk_v);
								$quantity = $two_opt[0] - $umd_user_quantity;
								$opt_db[$user_opt_part[0]][$odk_k] = $quantity.'|'.$two_opt[1];
								$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);

								//  옵션수량 차감 업데이트
								$opt_update_array = array();
								$opt_update_array[Details] = $opt_update;
								$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
								$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);

							}
						}
					}
				}
			// foreach end
			}

		}

		if(trim($temp[0]) == 'manual2' || trim($temp[0]) == 'manual3') {

			$opt_temp = explode("[_Opt_]",$umd_db_opt[0][details2]);
			$opt_db = unserialize($opt_temp[1]);

			$user_opt_part = explode('||',$user_temp[1]);
			$user_opt_part[0] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[0])); //  옵션가 제거
			$user_opt_part[1] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[1])); //  옵션가 제거

			foreach($opt_db as $od_k=>$od_v) {
				//  구분1이 같을때

				if(trim($od_k) == trim($user_opt_part[0])) {

					//  구분2값 확인
					$udp_flag = 0;
					//	같은 구분명이 두번들어감
					if(trim($umd_db_opt[0][opt_name3]!='') && trim($umd_db_opt[0][opt_name4]!='')) {
						$od_v_key = array_keys($od_v);
						if(trim($od_v_key[0])==trim($user_opt_part[0])) {
							$udp_flag = 1;						
						}
					}
					//	구분명이 한번만 들어감
					elseif(trim($umd_db_opt[0][opt_name3]!='') && trim($umd_db_opt[0][opt_name4]=='')) {
						$udp_flag = 2;
					}

					//  옵션이 하나인 주문일 경우
					if(trim($user_opt_part[1])=='' && count($opt_db[$od_k])=='1' && ($udp_flag=='1' || $udp_flag=='2')) {

						if($udp_flag=='2') { 
							$one_opt = explode('|',$opt_db[$od_k][0]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][0] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}
						else {
							$one_opt = explode('|',$opt_db[$od_k][$od_k]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][$od_k] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}

						//  옵션수량 차감 업데이트
						$opt_update_array = array();
						$opt_update_array[Details2] = $opt_update;
						$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
						$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);
					}
					//  옵션이 두개인 주문일 경우
					else {
						//  구분2 검색
						foreach($opt_db[$user_opt_part[0]] as $odk_k=>$odk_v) {
							//  구분2가 같은경우
							if(trim($odk_k)==trim($user_opt_part[1])) {

								$two_opt = explode('|',$odk_v);
								$quantity = $two_opt[0] - $umd_user_quantity;
								$opt_db[$user_opt_part[0]][$odk_k] = $quantity.'|'.$two_opt[1];
								$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);

								//  옵션수량 차감 업데이트
								$opt_update_array = array();
								$opt_update_array[Details2] = $opt_update;
								$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
								$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);

							}
						}
					}
				}
			// foreach end
			}

		}

		if(trim($temp[0]) == 'manual3') {

			$opt_temp = explode("[_Opt_]",$umd_db_opt[0][details3]);
			$opt_db = unserialize($opt_temp[1]);

			$user_opt_part = explode('||',$user_temp[2]);
			$user_opt_part[0] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[0])); //  옵션가 제거
			$user_opt_part[1] = trim(ereg_replace(' \(.*원\)','',$user_opt_part[1])); //  옵션가 제거

			foreach($opt_db as $od_k=>$od_v) {
				//  구분1이 같을때

				if(trim($od_k) == trim($user_opt_part[0])) {

					//  구분2값 확인
					$udp_flag = 0;
					//	같은 구분명이 두번들어감
					if(trim($umd_db_opt[0][opt_name5]!='') && trim($umd_db_opt[0][opt_name6]!='')) {
						$od_v_key = array_keys($od_v);
						if(trim($od_v_key[0])==trim($user_opt_part[0])) {
							$udp_flag = 1;						
						}
					}
					//	구분명이 한번만 들어감
					elseif(trim($umd_db_opt[0][opt_name5]!='') && trim($umd_db_opt[0][opt_name6]=='')) {
						$udp_flag = 2;
					}

					//  옵션이 하나인 주문일 경우
					if(trim($user_opt_part[1])=='' && count($opt_db[$od_k])=='1' && ($udp_flag=='1' || $udp_flag=='2')) {

						if($udp_flag=='2') { 
							$one_opt = explode('|',$opt_db[$od_k][0]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][0] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}
						else {
							$one_opt = explode('|',$opt_db[$od_k][$od_k]);
							$quantity = $one_opt[0] - $umd_user_quantity;
							$opt_db[$od_k][$od_k] = $quantity.'|'.$one_opt[1];
							$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);
						}

						//  옵션수량 차감 업데이트
						$opt_update_array = array();
						$opt_update_array[Details3] = $opt_update;
						$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
						$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);
					}
					//  옵션이 두개인 주문일 경우
					else {

						//  구분2 검색
						foreach($opt_db[$user_opt_part[0]] as $odk_k=>$odk_v) {
							//  구분2가 같은경우
							if(trim($odk_k)==trim($user_opt_part[1])) {

								$two_opt = explode('|',$odk_v);
								$quantity = $two_opt[0] - $umd_user_quantity;
								$opt_db[$user_opt_part[0]][$odk_k] = $quantity.'|'.$two_opt[1];
								$opt_update = $temp[0]."[_Opt_]".serialize($opt_db);

								//  옵션수량 차감 업데이트
								$opt_update_array = array();
								$opt_update_array[Details3] = $opt_update;
								$opt_where = sprintf("Goods_no='%s' and Option_section='1'",$umd_goods_code);
								$opt_result = $this->execute_sock->Array_update($table.".Goods_option",$opt_update_array,$opt_where,"Success",false);

							}
						}
					}
				}
			// foreach end
			}

		}

    Return $opt_result;

  // funciton - End
  }

  //-----------------------------------------------------------------------------
  // 상품총재고 차감
  // $table=데이터베이스, $ugs_goods_no=상품코드, $ugs_db_volume=디비수량, $ugs_user_volume=유저수량
  //-----------------------------------------------------------------------------
  function UpdateGoodsStock($table,$ugs_goods_no,$ugs_db_volume,$ugs_user_volume) {

    //  상품수량 차감 업데이트
    $update_array = array();
    $update_array[Volume] = $ugs_db_volume - $ugs_user_volume;
    if($update_array[Volume] < 1) { $update_array[Stock] = '0'; }
    $where = sprintf("Goods_no='%s'",$ugs_goods_no);
    $goosd_result = $this->execute_sock->Array_update($table.".Goods_Basic",$update_array,$where,"Success",false);

  // funciton - End
  }


  //------------------------------------------------------------------------
  // 네이버 응답 데이터
  //------------------------------------------------------------------------
  function WebViewData() {
    $ViewData = 'RESULT=TRUE';
    return $ViewData;
  }


}  // class - End


?>