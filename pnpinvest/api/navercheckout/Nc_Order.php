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
		$this->is_cp_code = $_cp_code;
  }
  function makeQueryString($neid) {

    $ret .= 'ITEM_ID=' . urlencode($this->id);
    $ret .= '&EC_MALL_PID=' . urlencode($this->id);

    /*if($this->is_cp_code=='test' || $this->is_cp_code=='minishop') {
      // 쿠폰 연동을 위해 실시간 조회한 해당상품의 카테고리 정보 전달
      $url = "http://dev.etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=pa_brontibay&mallPid=".$this->id;
    }else{*/
            //http://etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=몰아이디(지식쇼핑ID)&mallPid=상품아이디
      $url = "http://etnlapi.shopping.naver.com/nmp05/external/getProductInfo.nhn?mallId=".$neid."&mallPid=".$this->id;
    /*}*/

    $match_cate_info = $this->sendNHN($url);
    $match_cate_info = iconv("UTF-8", "euc-kr",$match_cate_info);
    preg_match('/","fullCatId":"([^,]+)","/',$match_cate_info,$match_cate);

    if($match_cate[1] != "") {
      $ret .= '&CAT_ID=' . $match_cate[1];
    }

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
    // funciton - End
  }

};

$shopId = $ncs[i][0];
$certiKey = $ncs[s][0];
$MALL_MANAGE_CODE = date("ymd").'-'.time().rand(0,9);

$http_host = $_SERVER[HTTP_HOST];
$backUrl = 'http://'.$http_host.'/?action=Detail%26GoodsCode='.$_POST[GoodsCode];
$queryString = 'SHOP_ID='.urlencode($shopId);
$queryString .= '&CERTI_KEY='.urlencode($certiKey);
$queryString .= '&MALL_MANAGE_CODE='.$MALL_MANAGE_CODE;
$queryString .= '&RESERVE1=';
$queryString .= '&RESERVE2=';
$queryString .= '&RESERVE3=';
$queryString .= '&RESERVE4=';
$queryString .= '&RESERVE5=';
$queryString .= '&BACK_URL='.$backUrl;
$totalMoney = $SaleCostOri = 0;

//할인가 설정
if($_POST[Applycost] != "" ) {
  $_POST[SaleCostOri] = $_POST[Applycost];
}

//DB와 장바구니에서 상품 정보를 얻어 온다.
//while(...) {
if($_POST[OptStyle]=='manual' || $_POST[OptStyle]=='manual2' || $_POST[OptStyle]=='manual3') {
  for($po=0; $po<count($_POST[Size]); $po++) {
    //  옵션가 표기
    $OptCostView = '';
    $OptCost = $SaleCostOri = 0;
    if(trim($_POST[OptCost][$po]) != '') {
      if($_POST[OptCost][$po] > 0 && $_POST[OptCost][$po] !='') { $OptCostView = " (+".$_POST[OptCost][$po]."원)"; }
      elseif($_POST[OptCost][$po] < 0 && $_POST[OptCost][$po] !='') { $OptCostView = " (".$_POST[OptCost][$po]."원)"; }
      else { $OptCostView = ""; }
      $OptCost = $_POST[OptCost][$po]/$_POST[Amt][0];
    }

    //  옵션처리
    if(trim($_POST[Size][$po])==trim($_POST[Color][$po]) || trim($_POST[Color][$po])=='' || trim($_POST[Color][$po])=='0') {
      $post_option = $_POST[Size][$po].$OptCostView;
    }
    else {
      //  / 에서 || 로 변경 : 2011-05-16 16:57 정수진
      $post_option = $_POST[Size][$po].'||'.$_POST[Color][$po].$OptCostView;
    }

    //  옵션가 포함한 가격
    //if($OptCost > 0) { $SaleCostOri = $_POST[SaleCostOri] + $OptCost; }
	$SaleCostOri = $_POST[SaleCostOri] + $OptCost;
  }

	if($_POST[OptStyle]=='manual2' || $_POST[OptStyle]=='manual3') {
		for($po=0; $po<count($_POST[Size2]); $po++) {
			$OptCost2 = 0;
			if(trim($_POST[OptCost2][$po]) != '') {
				if($_POST[OptCost2][$po] > 0 && $_POST[OptCost2][$po] !='') { $OptCostView2 = " (+".$_POST[OptCost2][$po]."원)"; }
				elseif($_POST[OptCost2][$po] < 0 && $_POST[OptCost2][$po] !='') { $OptCostView2 = " (".$_POST[OptCost2][$po]."원)"; }
				else { $OptCostView2 = ""; }
				$OptCost2 = $_POST[OptCost2][$po]/$_POST[Amt][0];
			}

    //  옵션처리
    if(trim($_POST[Size2][$po])==trim($_POST[Color2][$po]) || trim($_POST[Color2][$po])=='' || trim($_POST[Color2][$po])=='0') {
      $post_option .='____'.$_POST[Size2][$po].$OptCostView2;
    }
    else {
      //  / 에서 || 로 변경 : 2011-05-16 16:57 정수진
      $post_option .= '____'.$_POST[Size2][$po].'||'.$_POST[Color2][$po].$OptCostView2;
    }

			//  옵션가 포함한 가격
			//if($OptCost > 0) { $SaleCostOri = $_POST[SaleCostOri] + $OptCost; }
			$SaleCostOri = $SaleCostOri + $OptCost2;
	 }

	}

	if($_POST[OptStyle]=='manual3') {

		for($po=0; $po<count($_POST[Size3]); $po++) {
			$OptCost3 = 0;
			if(trim($_POST[OptCost3][$po]) != '') {
				if($_POST[OptCost3][$po] > 0 && $_POST[OptCost3][$po] !='') { $OptCostView3 = " (+".$_POST[OptCost3][$po]."원)"; }
				elseif($_POST[OptCost3][$po] < 0 && $_POST[OptCost3][$po] !='') { $OptCostView3 = " (".$_POST[OptCost3][$po]."원)"; }
				else { $OptCostView2 = ""; }
				$OptCost3 = $_POST[OptCost3][$po]/$_POST[Amt][0];
			}

    //  옵션처리
    if(trim($_POST[Size3][$po])==trim($_POST[Color3][$po]) || trim($_POST[Color3][$po])=='' || trim($_POST[Color3][$po])=='0') {
      $post_option .='____'.$_POST[Size3][$po].$OptCostView3;
    }
    else {
      //  / 에서 || 로 변경 : 2011-05-16 16:57 정수진
      $post_option .= '____'.$_POST[Size3][$po].'||'.$_POST[Color3][$po].$OptCostView3;
    }

			//  옵션가 포함한 가격
			//if($OptCost > 0) { $SaleCostOri = $_POST[SaleCostOri] + $OptCost; }
			$SaleCostOri = $SaleCostOri + $OptCost3;
	 }

	}

  $post_count = $_POST[Amt][0];
}
else {
  $post_option = '';
  $post_count = $_POST[Amt];
}

$SaleCostOri = $SaleCostOri > 0 ? $SaleCostOri:$_POST[SaleCostOri];

$addprice2 = 0;
//추가구매 옵션 2011-01-11 김은혜
if(trim($_POST[AdditionTexts])!=""){
  $add_opt=array();
  $add_opt=explode("|",$_POST[AdditionTexts]);

  foreach($add_opt as $akey=>$aval) {
    preg_match("/\+ \(([0-9\,]+)원\)/",$aval,$aprice);
    $addprice = 0;
    $addprice=str_replace(",","",$aprice[1]);
    $addprice2=$addprice2+$addprice;
    //if($addprice > 0) { $SaleCostOri = $SaleCostOri + $addprice; }
  }
  $addpt1=implode(",",$add_opt);
  $addpt1=str_replace("none","",str_replace(",none","",$addpt1));
  if(@trim($addpt1)!='') {
    $post_option= $post_option ." : [추가구매] ". $addpt1 ;
  }
}

if($addprice2 > 0){
  $post_tprice = $SaleCostOri * $post_count + $addprice2;
}else{
  $post_tprice = $SaleCostOri * $post_count;
}
$item = new ItemStack($_POST[GoodsCode], $_POST[Goods_name], $post_tprice, $SaleCostOri, $post_option, $post_count,$shopId,$CouponYn,$this->CP_CODE);
$totalMoney += $post_tprice;

$queryString .= '&'.$item->makeQueryString($ncs[neid][0]);
//}

//  배송비 처리
switch($_POST[deliv_type]) {
  //  원 이상 구매시 무료배송
  case "0" :
		if($_POST[DelivTypeSelect]=='3') {
			$shippingPrice = $_POST[DelivTypeSelectCost];
      $shippingType = 'ONDELIVERY';
		} else{
			$shippingPrice = $totalMoney >= $_POST[deliv_common][Free_line][0] ? 0 : $_POST[deliv_common][Cost][0];
			$shippingType = $shippingPrice > 0 ? 'PAYED':'FREE';
		}
  break;
  //  무료배송
  case "1" :
    $shippingPrice = 0;
    $shippingType = 'FREE';
  break;
  //  선,착불 선택
  case "2" :
    if($_POST[DelivTypeSelect]=='3') {
      $shippingPrice = $_POST[DelivTypeSelectCost];
      $shippingType = 'ONDELIVERY';
    }
    else {
      $shippingPrice = $_POST[DelivTypeSelectCost];
      $shippingType = 'PAYED';
    }
  break;
  //  착불 배송
  case "3" :
    $shippingPrice = str_replace('원','',@trim($_POST[deliv_text]));
    $shippingType = 'ONDELIVERY';
  break;
  //  선결제
  case "4" :
    $shippingPrice = $_POST[DelivTypeSelectCost];
    $shippingType = 'PAYED';
  break;
}

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
    echo $bodys;
  }
}
else {
  echo "$errstr ($errno)<br>\n";
  exit(-1);
  //에러처리
}

// 특수주문 저장---------------------------------------------------------------
if($_POST['so_type'] == 'flower' && $_POST['ordertype'] != 'N') {
	$Special1 = array();
	$Special1[type] = $_POST['so_type'];
	$Special1[ordertype] = $_POST['ordertype'];

	$msg = preg_replace("/[\r\n]+/"," ",$_POST['add_msg']);
	$Special1[add_msg] = $msg;

	$insert = array();
	$insert[Order_id] = $MALL_MANAGE_CODE;
	$insert[text1] = serialize($Special1);

	// 특수주문 저장
	$re = $this->execute_Sock->Array_insert("$this->DataBase.Special_order",$insert,"Success",false);
	if($re != 'Success') { // 실패시 한번 재시도
		sleep(2);
		$re = $this->execute_Sock->Array_insert("$this->DataBase.Special_order",$insert,"Success",false);
	}

	if($re != "Success") {
		$this->inst_Location->msg_go($this->Ret_URL,"주문정보(메세지) 저장이 실패되었습니다.\\n고객센터에 문의해 주시기 바랍니다.");
	}
}
// 특수주문 저장 끝------------------------------------------------------------

// 에이스 연동용 정보 DB에저장-------------------------------------------------
if($_POST['PAUTOFCID'] != '') {
	$act_info = array();

	$act_info['wdate'] = "now()";
	$act_info['code'] = $MALL_MANAGE_CODE;
	$act_info['goods_code'] = $_POST[GoodsCode];
	$act_info['ip'] = $_SERVER['REMOTE_ADDR'];
	$act_info['cate'] = $_POST['pcate'];
	$act_info['PAUTOFCID'] = $_POST['PAUTOFCID'];

	// 저장
	$re = $this->execute_Sock->Array_insert("ECHost.ActInfo",$act_info,"Success",false);
	if($re != 'Success') { // 실패시 한번 재시도
		sleep(2);
		$re = $this->execute_Sock->Array_insert("ECHost.ActInfo",$act_info,"Success",false);
	}
}
// 에이스 연동용 정보 DB에저장 끝----------------------------------------------


// 네이버 주문서 URL 생성후 JSON 으로 리턴
$orderUrl = "https://checkout.naver.com/customer/order.nhn?ORDER_ID=".$orderId."&SHOP_ID=".$shopId."&TOTAL_PRICE=".$totalPrice;

/*if($shopId == "pa_brontibay") {
  $orderUrl = "https://test-checkout.naver.com/customer/order.nhn?ORDER_ID=".$orderId."&SHOP_ID=".$shopId."&TOTAL_PRICE=".$totalPrice;
}*/
Header("Location:$orderUrl");
exit;

?>
