<?

//item data를 생성한다.
class ItemStack {
  var $id;
  var $name;
  var $tprice;
  var $uprice;
  var $option;
  var $count;

	//option이 여러 종류라면, 선택된 옵션을 슬래시(/)로 구분해서 표시하는 것을 권장한다.
  function ItemStack($_id, $_name, $_tprice, $_uprice, $_option, $_count,$_shop_id,$_CouponYn,$_cp_code) {
    $this->id = $_id;
    $this->name = $_name;
    $this->tprice = $_tprice;
    $this->uprice = $_uprice;
    $this->option = $_option;
    $this->count = $_count;
    $this->shop_id = $_shop_id;
		$this->CouponYn = $_CouponYn;
  }

  function makeQueryString($neid) {
    $ret .= 'ITEM_ID=' . urlencode($this->id);
    $ret .= '&EC_MALL_PID=' . urlencode($this->id);

    /*if($this->is_cp_code=='test' || $this->is_cp_code=='minishop') {
      // 쿠폰 연동을 위해 실시간 조회한 해당상품의 카테고리 정보 전달
      $url = "http://dev.etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=pa_brontibay&mallPid=".$this->id;
    }else{
      //http://etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=몰아이디(지식쇼핑ID)&mallPid=상품아이디
      $url = "http://etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=".$this->shop_id."&mallPid=".$this->id;
    }*/

    // 쿠폰 연동을 위해 실시간 조회한 해당상품의 카테고리 정보 전달
    $url = "http://etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=".$neid."&mallPid=".$this->id;

    $match_cate_info = $this->sendNHN($url);
    $match_cate_info = iconv("UTF-8", "euc-kr",$match_cate_info);
    preg_match('/","fullCatId":"([^,]+)","/',$match_cate_info,$match_cate);

    $ret .= '&CAT_ID=' . $match_cate[1];
    $ret .= '&ITEM_NAME=' . urlencode($this->name);
    $ret .= '&ITEM_COUNT=' . $this->count;
    $ret .= '&ITEM_OPTION=' . urlencode($this->option);
    $ret .= '&ITEM_TPRICE=' . $this->tprice;
    $ret .= '&ITEM_UPRICE=' . $this->uprice;

    return $ret;
  }

  //------------------------------------------------------------------------
  // 특정주소 접속
  //------------------------------------------------------------------------
  function sendNHN($url) {

    require_once 'HTTP/Request.php';

    //http post방식으로 요청 전송
    $rq = new HTTP_Request($url);
    $rq->addHeader("Content-Type", "text/xml;charset=UTF-8");
    $rq->setBody($request_body);

    $result = $rq->sendRequest();
    if (PEAR::isError($result)) {
       //echo "ERROR[NHN0001]". $result->toString(). "\n";
       return;
    }

    //응답메시지 확인
    $rcode = $rq->getResponseCode();
    if($rcode!='200'){
       //echo "ERROR[NHN0002]: http response code=". $rcode. "\n";
       return;
    }

    return $rq->getResponseBody();
  }

};

$shopId = $ncs[i][0];
$certiKey = $ncs[s][0];
$MALL_MANAGE_CODE = date("ymd").'-'.time().rand(0,9);

$http_host = $_SERVER[HTTP_HOST];
$backUrl = 'http://'.$http_host.'/?action=Cart';
$queryString = 'SHOP_ID='.urlencode($shopId);
$queryString .= '&CERTI_KEY='.urlencode($certiKey);
$queryString .= '&MALL_MANAGE_CODE='.$MALL_MANAGE_CODE;
$queryString .= '&RESERVE1=';
$queryString .= '&RESERVE2=';
$queryString .= '&RESERVE3=';
$queryString .= '&RESERVE4=';
$queryString .= '&RESERVE5=';
$queryString .= '&BACK_URL='.$backUrl;
$totalMoney = 0;
$Cartlist = $_SESSION[CartList];	//	장바구니정보
$Delivlist = $SaleCostOri = array();

// 에이스카운터 전송용 정보 2011-08-17 남형진
$GoodsCodes = array();
$pcates = array();
$PAUTOFCIDS = array();

// 로그인 회원인경우 디비에 백업본 불러오기 2012-03-06 남형진
$__flag = true;
if($_SESSION['UID'] != "") {
	$Cartlist = array();
	$data_array = $this->inst_SelectShop->GetCheckOutData($_POST[OrderID]);

	for($i=0; $i<$data_array[1]; $i++) {
		if($data_array[0][checkout_data][$i] == "") {
			$__flag = false;
			break;
		}
		$checkout_data = unserialize($data_array[0][checkout_data][$i]);
		$Cartlist[$i] = $checkout_data;
	// loop - End
	}
}

if($__flag == false) {
    echo"<script type=\"text/javascript\">
      window.alert(\"구매시 오류가 발생되었습니다. 장바구니를 비운후 다시담아 결제하여 주시기 바랍니다.\");
      history.go(-1);
      </script>";
    exit;
}

//DB와 장바구니에서 상품 정보를 얻어 온다.
for($i=0; $i<count($Cartlist); $i++) {

  if($Cartlist[$i][Applycost] != "" || $Cartlist[$i][Applycost] > 0) {
    $Cartlist[$i][SaleCostOri] = $Cartlist[$i][Applycost];
  }

	//	옵션정보
  $goodsopt = unserialize($Cartlist[$i][GoodsOpt]);

  if($goodsopt[Size]!='' ) {
    for($po=0; $po<count($goodsopt[Size]); $po++) {
      //  옵션가 표기
      $OptCostView = '';
      $OptCost = $SaleCostOri[$i] = 0;
			//	옵션가 처리
      if(trim($goodsopt[OptCost][$po]) != '') {
        if($goodsopt[OptCost][$po] > 0 && $goodsopt[OptCost][$po]!='') { $OptCostView = " (+".$goodsopt[OptCost][$po]."원)"; }
				//	- 금액일 경우 - 넘어오니까 바꾸지 마셈. 보지도 않고 +로 누가바꿔논거야--^
        elseif($goodsopt[OptCost][$po] < 0 && $goodsopt[OptCost][$po]!='') { $OptCostView = " (".$goodsopt[OptCost][$po]."원)"; }
        else { $OptCostView = ""; }
        $OptCost = $goodsopt[OptCost][$po]/$goodsopt[Amt][0];
      }
      if(trim($goodsopt[Size][$po])==trim($goodsopt[Color][$po]) || trim($goodsopt[Color][$po])=='' || trim($goodsopt[Color][$po])=='0') {
        $post_option = $goodsopt[Size][$po].$OptCostView;
      }
      else {
        //  옵션명 구분 / 에서 || 로 변경 : 2011-05-16 16:57 정수진
        $post_option = $goodsopt[Size][$po].'||'.$goodsopt[Color][$po].$OptCostView;
      }
      //  옵션가 포함한 가격
		  $SaleCostOri[$i] = $Cartlist[$i][SaleCostOri] + $OptCost; // 바로위에있던 처리 if($OptCost > 0) { $SaleCostOri[$i] = $Cartlist[$i][SaleCostOri] + $OptCost; }
    }

    $post_count = $goodsopt[Amt][0];

		if($goodsopt[Size2]!='') {
			for($po=0; $po<count($goodsopt[Size2]); $po++) {
				//  옵션가 표기
				$OptCost2 = 0;
				if(trim($goodsopt[OptCost2][$po]) != '') {
					if($goodsopt[OptCost2][$po] > 0 && $goodsopt[OptCost2][$po]!='') { $OptCostView2 = " (+".$goodsopt[OptCost2][$po]."원)"; }
					//	- 금액일 경우 - 넘어오니까 바꾸지 마셈. 보지도 않고 +로 누가바꿔논거야--^
					elseif($goodsopt[OptCost2][$po] < 0 && $goodsopt[OptCost2][$po]!='') { $OptCostView2 = " (".$goodsopt[OptCost2][$po]."원)"; }
					else { $OptCostView2 = ""; }
					$OptCost2 = $goodsopt[OptCost2][$po]/$goodsopt[Amt][0];
				}
				if(trim($goodsopt[Size2][$po])==trim($goodsopt[Color2][$po]) || trim($goodsopt[Color2][$po])=='' || trim($goodsopt[Color2][$po])=='0') {
					$post_option .= '____'.$goodsopt[Size2][$po].$OptCostView2;
				}
				else {
					//  / 에서 || 로 변경 : 2011-05-16 16:57 정수진
					$post_option .= '____'.$goodsopt[Size2][$po].'||'.$goodsopt[Color2][$po].$OptCostView2;
				}
				//  옵션가 포함한 가격
				$SaleCostOri[$i] = $SaleCostOri[$i] + $OptCost2; // 바로위에있던 처리 if($OptCost > 0) { $SaleCostOri[$i] = $Cartlist[$i][SaleCostOri] + $OptCost; }
			}
			$post_count = $goodsopt[Amt][0];

			if($goodsopt[Size3]!='') {

				for($po=0; $po<count($goodsopt[Size3]); $po++) {
					$OptCost3 = 0;
					if(trim($goodsopt[OptCost3][$po]) != '') {
						if($goodsopt[OptCost3][$po] > 0 && $goodsopt[OptCost3][$po]!='') { $OptCostView3 = " (+".$goodsopt[OptCost3][$po]."원)"; }
						//	- 금액일 경우 - 넘어오니까 바꾸지 마셈. 보지도 않고 +로 누가바꿔논거야--^
						elseif($goodsopt[OptCost3][$po] < 0 && $goodsopt[OptCost3][$po]!='') { $OptCostView3 = " (".$goodsopt[OptCost3][$po]."원)"; }
						else { $OptCostView3 = ""; }
						$OptCost3 = $goodsopt[OptCost3][$po]/$goodsopt[Amt][0];
					}
					if(trim($goodsopt[Size3][$po])==trim($goodsopt[Color3][$po]) || trim($goodsopt[Color3][$po])=='' || trim($goodsopt[Color3][$po])=='0') {
						$post_option .= '____'.$goodsopt[Size3][$po].$OptCostView3;
					}
					else {
						//  / 에서 || 로 변경 : 2011-05-16 16:57 정수진
						$post_option .= '____'.$goodsopt[Size3][$po].'||'.$goodsopt[Color3][$po].$OptCostView3;
					}
					//  옵션가 포함한 가격
					$SaleCostOri[$i] = $SaleCostOri[$i] + $OptCost3; // 바로위에있던 처리 if($OptCost > 0) { $SaleCostOri[$i] = $Cartlist[$i][SaleCostOri] + $OptCost; }
				}
				$post_count = $goodsopt[Amt][0];
			}
		}
  }
  else {
    $post_option = '';
    $post_count = $goodsopt[Amt];
  } // goodsopt end

  $SaleCostOri[$i] = $SaleCostOri[$i] > 0 ? $SaleCostOri[$i]:$Cartlist[$i][SaleCostOri];

  //추가구매 옵션 2011-01-11 김은혜
  $Addition = unserialize($Cartlist[$i][Addition]);
  if(is_array($Addition[OptText])){
    $addpt="";
    $addpt= implode(",",$Addition[OptText]);
    $addpt=str_replace("none","",str_replace(",none","",$addpt));
    if(@trim($addpt)!='') {
      $post_option= $post_option ." : [추가구매] ". $addpt ;
    }
    //if($Addition[OptCostSum] > 0) { $SaleCostOri[$i] = $SaleCostOri[$i] + $Addition[OptCostSum]; }
  }

  if($Addition[OptCostSum] > 0 ) {
    $post_tprice = $SaleCostOri[$i] * $post_count + $Addition[OptCostSum];
  }else{
    $post_tprice = $SaleCostOri[$i] * $post_count;
  }
  $item = new ItemStack($Cartlist[$i][GoodsCode], $Cartlist[$i][Goods_name], $post_tprice, $SaleCostOri[$i], $post_option, $post_count,$shopId,$CouponYn,$this->CP_CODE);
  $totalMoney += $post_tprice;

  $queryString .= '&'.$item->makeQueryString($ncs[neid][0]);

  if($Cartlist[$i][PAUTOFCID] != '') {
		$GoodsCodes[] = $Cartlist[$i][GoodsCode];
		$pcates[] = $Cartlist[$i][pcate];
		$PAUTOFCIDS[] = $Cartlist[$i][PAUTOFCID];
  }

	//	업체별 배송
	if($_SESSION[CartDelivCostType]=='2') {
		//	상품별로 정리할게 없기때문에 처리없음. 세션에 업체별로 정보 넘어옴.
	}
	//	일반배송
	else {
		//  각 상품별 배송비 처리
		$Delivlist[goodsdelivtype][$i] = $Cartlist[$i][Delivery_pay];
		$Delivlist[goodsdelivselect][$i] = $Cartlist[$i][DelivTypeSelect] == "" ? '4' : $Cartlist[$i][DelivTypeSelect];

		if($Cartlist[$i][Delivery_pay] > 0) {
			if($Cartlist[$i][Delivery_pay] == 3) { $Delivlist[goodsdelivprice][$i] = trim(str_replace('원','',$Cartlist[$i][Delivery_text])); }
			else { $Delivlist[goodsdelivprice][$i] = $Cartlist[$i][Delivery_cost]; }
		}
		else {
			$Delivlist[goodsdelivprice][$i] = $_POST[deliv_common][Cost][0];
		}
	}

// loop - End
}



//	업체별 배송
if($_SESSION[CartDelivCostType]=='2') {

	/* 업체별 묶음 배송비 기준 - 업체별 묶음은 무료와 선불만 가능
	배송유형        SHIPPING_TYPE   SHIPPING_PRICE
	무료+무료       FREE            0원
	선불+무료       PAYED           0원 이상
	선불+선불       PAYED           0원 이상
	*/

	if (!is_array($_SESSION[totalcartdelivprice_sub])){ $_SESSION[totalcartdelivprice_sub] = array(); }
	foreach($_SESSION[totalcartdelivprice_sub] as $tcdp_k=>$tcdp_v) {
		$Delivlist[goodsdelivtype][] = $_SESSION[totalcartdelivprice_sub][$tcdp_k][pay];
		$Delivlist[goodsdelivprice][] = $_SESSION[totalcartdelivprice_sub][$tcdp_k][price];
	}

	$acv = @array_count_values($Delivlist[goodsdelivtype]);
	$delivlist_count = count($Delivlist[goodsdelivtype]);

	//	$acv[1] 무료, $acv[2] 선결제, $acv[3] 착불
	//  전부 무료배송
	if($delivlist_count == $acv[1]) {
		$shippingPrice = 0;
		$shippingType = 'FREE';
	}
	//  전부 선결제
	elseif($delivlist_count == $acv[2]) {
		$shippingPrice = array_sum($Delivlist[goodsdelivprice]);
		$shippingType = 'PAYED';
	}
	elseif($delivlist_count == ($acv[1]+$acv[2])) {
		$shippingPrice = array_sum($Delivlist[goodsdelivprice]);
		$shippingType = 'PAYED';
	}
	else {
		echo"<script type=\"text/javascript\">
		  window.alert(\"배송비 처리중 오류가 발생하였습니다. 관리자에게 문의하여 주시기 바랍니다.\");
		  history.go(-1);
		  </script>";
		exit;
	}
}
//	일반배송
else {

	/* 일반 묶음 배송비 기준
	배송유형        SHIPPING_TYPE   SHIPPING_PRICE
	무료+무료       FREE            0원
	선불+무료       FREE            0원
	착불+무료       FREE            0원
	선불+무료+착불  FREE            0원
	착불+착불       ONDELIVERY      0원 이상
	선불+선불       PAYED           0원 이상
	착불+선불       PAYED           0원 이상
	*/

	//  배송비 처리
	$gds_acv = @array_count_values($Delivlist[goodsdelivselect]);
	$acv = @array_count_values($Delivlist[goodsdelivtype]);
	$delivlist_count = count($Delivlist[goodsdelivtype]);

	//  조건부 무료배송
	if($acv[0] > 0) {
		if($totalMoney >= $_POST[deliv_common][Free_line][0]) {
			$shippingPrice = 0;
			$shippingType = 'FREE';

			$flag = 1;
		}
		else {
			for($ii=0; $ii<$delivlist_count; $ii++) {
				if($Delivlist[goodsdelivtype][$ii]=='0') {

					if($Delivlist[goodsdelivselect][$ii] == '3') {
						$Delivlist[goodsdelivtype][$ii] = 3;
						$Delivlist[goodsdelivprice][$ii] = $_POST[deliv_common][Cost][0];
					} else {
						$Delivlist[goodsdelivtype][$ii] = 4;
						$Delivlist[goodsdelivselect][$ii] = 4;
						$Delivlist[goodsdelivprice][$ii] = $_POST[deliv_common][Cost][0];
					}
				}
			}
			$acv = array_count_values($Delivlist[goodsdelivtype]);		//$acv = array_count_values($Delivlist[goodsdelivselect]); // 이전소스
		}
	}

	//	$acv[1] 무료만, $acv[2] 선착불($gds_acv[3] 착불, $gds_acv[2] 선불), $acv[3] 착불만, $acv[4] 선결제만(기본배송일 경우 기준금액에 맞으면 $acv[4]로 변경)
	//  조건부 무료에 부합하지 않을경우
	if($flag < 1) {
		//  무료배송
		if($delivlist_count == $acv[1] || $acv[1] > 0) {
			$shippingPrice = 0;
			$shippingType = 'FREE';
		}
		//  전부 착불
		elseif($delivlist_count == $acv[3] || ($delivlist_count == $acv[2] && $delivlist_count == $gds_acv[3])) {
			$Delivlist3 = $Delivlist[goodsdelivprice];
			rsort($Delivlist3);
			$shippingPrice = $Delivlist3[0];
			$shippingType = 'ONDELIVERY';
		}
		//  전부 선결제
		elseif($delivlist_count == $acv[4] || ($delivlist_count == $acv[2] && $delivlist_count != $gds_acv[3]) || $delivlist_count == (($delivlist_count == $acv[2] && $delivlist_count != $gds_acv[3])+$acv[4])) {
			$Delivlist5 = $Delivlist[goodsdelivprice];
			rsort($Delivlist5);
			$shippingPrice = $Delivlist5[0];
			$shippingType = 'PAYED';
		}
		elseif($delivlist_count == ($acv[2]+$acv[4]+$acv[3])) {
			$Delivlist4 = array();
			//  선불이 여러개일 경우 선불금액 합계
			for($iii=0; $iii<$delivlist_count; $iii++) {
				if($Delivlist[goodsdelivselect][$iii]==2 || $Delivlist[goodsdelivselect][$iii]==4) {
					$Delivlist4[] = $Delivlist[goodsdelivprice][$iii];
				}
			}
			rsort($Delivlist4);
			$shippingPrice = $Delivlist4[0];
			$shippingType = 'PAYED';
		}
		else {
			echo"<script type=\"text/javascript\">
			  window.alert(\"배송비 처리중 오류가 발생하였습니다. 관리자에게 문의하여 주시기 바랍니다.\");
			  history.go(-1);
			  </script>";
			exit;
		}
	}	
}	// 일반배송 end

$queryString .= '&SHIPPING_TYPE='.$shippingType;
$queryString .= '&SHIPPING_PRICE='.$shippingPrice;

if($shippingType=='ONDELIVERY') {
  $totalPrice = (int)$totalMoney;
}
else {
  $totalPrice = (int)$totalMoney + (int)$shippingPrice;
}
$queryString .= '&TOTAL_PRICE='.$totalPrice;

//	네이버 마일리지 연동 : 2011-07-07 정수진
if($_SESSION["MileageCheck"]=='1') {
	$queryString .= '&NMILEAGE_INFLOW_CODE='.$_SESSION['Ncisy'];
}
else {
	if( $_SERVER['REMOTE_ADDR'] == "111.91.139.55" || $_SERVER['REMOTE_ADDR'] == "58.72.239.56" ) {
		$queryString .= '&NMILEAGE_INFLOW_CODE='.$_SESSION['Ncisy'];
	}
}

// 네이버 유입루트 체킹값 보내기 : 2011-08-09 남형진
$queryString .= '&SALES_CODE='.$_COOKIE['SALES_CODE'];

$req_addr = 'ssl://checkout.naver.com';
//$req_url = 'POST /customer/api/order.nhn HTTP/1.1'; // utf-8
$req_url = 'POST /customer/api/CP949/order.nhn HTTP/1.1'; // euc-kr
$req_host = 'checkout.naver.com';

/*if($shopId == "pa_brontibay") {
  $req_addr = 'ssl://test-checkout.naver.com';
  $req_host = 'test-checkout.naver.com';
}*/

$req_port = 443;
$nc_sock = fsockopen($req_addr, $req_port, $errno, $errstr);

if ($nc_sock) {
  fwrite($nc_sock, $req_url."\r\n" );
  fwrite($nc_sock, "Host: ".$req_host.":".$req_port."\r\n" );
  //fwrite($nc_sock, "Content-type: application/x-www-form-urlencoded; charset=utf-8\r\n");
  fwrite($nc_sock, "Content-type: application/x-www-form-urlencoded;charset=CP949\r\n");
  fwrite($nc_sock, "Content-length: ".strlen($queryString)."\r\n");
  fwrite($nc_sock, "Accept: */*\r\n");
  fwrite($nc_sock, "\r\n");
  fwrite($nc_sock, $queryString."\r\n");
  fwrite($nc_sock, "\r\n");

  // get header
  while(!feof($nc_sock)){
    $header=fgets($nc_sock,4096);
    if($header=="\r\n"){
    break;
    } else {
    $headers .= $header;
    }
  }
  // get body
  while(!feof($nc_sock)){
    $bodys.=fgets($nc_sock,4096);
  }
  fclose($nc_sock);
  $resultCode = substr($headers,9,3);
  if ($resultCode == 200) {
    // success
    $orderId = $bodys;
  } else {
    // fail
    echo"<script type=\"text/javascript\">
      window.alert(\"구매시 오류가 발생되었습니다. 관리자에게 문의하여 주시기 바랍니다.\");
      history.go(-1);
      </script>";
    exit;
    // 체크아웃 오류 검증
    echo "<XMP>".iconv("UTF-8","UHC",$bodys);
    exit;
  }
}
else {
    echo"<script type=\"text/javascript\">
      window.alert(\"구매시 오류가 발생되었습니다. 관리자에게 문의하여 주시기 바랍니다.\");
      history.go(-1);
      </script>";
    exit;
    // 에러 처리 2010-12-09 김형섭 수정
    echo "$errstr ($errno)";
    exit;
}

// 에이스 연동용 정보 DB에저장-------------------------------------------------
if(sizeof($PAUTOFCIDS) > 0) {
	$act_info = array();
	for($i=0; $i<sizeof($GoodsCodes); $i++) {
		$act_info['wdate'][]	  = "now()";
		$act_info['code'][]		  = $MALL_MANAGE_CODE;
		$act_info['goods_code'][] = $GoodsCodes[$i];
		$act_info['ip'][]		  = $_SERVER['REMOTE_ADDR'];
		$act_info['cate'][]		  = $pcates[$i];
		$act_info['PAUTOFCID'][]  = $PAUTOFCIDS[$i];
	// loop - End
	}
	// 저장
	$re = $this->execute_Sock->Array_insert_multi("ECHost.ActInfo",$act_info,"Success",false);
	if($re != 'Success') { // 실패시 한번 재시도
		sleep(2);
		$re = $this->execute_Sock->Array_insert_multi("ECHost.ActInfo",$act_info,"Success",false);
	}
}
// 에이스 연동용 정보 DB에저장 끝----------------------------------------------


//리턴받은 order_id로 주문서 page를 호출한다.
//echo ($orderId."<br>\n");

// 네이버 주문서 URL 생성후 JSON 으로 리턴
$orderUrl = "https://checkout.naver.com/customer/order.nhn?ORDER_ID=".$orderId."&SHOP_ID=".$shopId."&TOTAL_PRICE=".$totalPrice;

/*if($shopId == "pa_brontibay") {
  $orderUrl = "https://test-checkout.naver.com/customer/order.nhn?ORDER_ID=".$orderId."&SHOP_ID=".$shopId."&TOTAL_PRICE=".$totalPrice;
}*/
Header("Location:$orderUrl");
exit;

$ret = array(
  'RESULT' => true,
  'URL' => $orderUrl,
);
echo json_encode($ret);
exit;


/* 네이버 요청 배송비 처리기준 - 개별배송 -_-;
중요도순: 선불> 착불> 무료

배송유형        SHIPPING_TYPE   SHIPPING_PRICE
무료+무료       FREE            0원
선불+선불       PAYED           0원 이상
착불+착불       ONDELIVERY      0원 이상
선불+무료       PAYED           0원 이상
선불+무료+무료  PAYED           0원 이상
착불+무료       ONDELIVERY      0원 이상
착불+무료+무료  ONDELIVERY      0원 이상
착불+선불       PAYED           0원 이상
선불+무료+착불  PAYED           0원 이상
*/
?>