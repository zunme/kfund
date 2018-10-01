<?
//-------------------------------------------------------------------------
//
//  네이버 체크아웃 상품 CLASS : 2010-12-07 정수진
//
//  체크아웃 주문에 대한 상품정보 연동을 위한 처리
//  요청형식 - http://가맹점도메인/가맹점페이지?ITEM_ID=XXX&ITEM_ID=XXX&ITEM_ID=XXX
//  실행주소 : http://minishop.ec.playautocorp.com/navercheckout/index.html?ITEM_ID=test05
//-------------------------------------------------------------------------

class NaverCheckOut {

  //-------------------------------------------------
  //  생성자
  //-------------------------------------------------
  function NaverCheckOut($CP_CODE){

    //  Sock
    $this->main_Sock = new Mysql(DBTYPE_MAIN,DBHOST_MAIN, DBUSER_MAIN, DBPASS_MAIN, DBNAME_MAIN);
    $this->select_Sock = new Mysql(DBTYPE_SELECT,DBHOST_SELECT, DBUSER_SELECT, DBPASS_SELECT, DBNAME_SELECT);
    
    $this->DataBase = "EC_".$CP_CODE;

    //  class
    $this->inst_NcSelect = new NcSelect(&$this->select_Sock,&$this->DataBase,&$this,$this->MainDataBase,&$this->main_Sock);  // 상품 전용조회 메소드
    include ClassBase."/sql/shop/Shop_select_class.php";	 // Shop조회 클래스
    $this->inst_SelectShop = new ShopSelect(&$this->select_Sock,&$this->DataBase,&$this,&$this->main_Sock);  // 상품 전용조회 메소드

    include ClassBase."/vips/none_class.php";	 // Shop조회 클래스
    include ClassBase."/api/shop/Shop_View_class.php";	 // Shop조회 클래스
    $this->inst_ShopView = new ShopView(&$this);  // 상품 전용조회 메소드

    $this->inst_FileIO = new FileIO(); // 파일 IO 관련
    $this->inst_Cate = new Cate();  // 카테고리

    $this->CP_CODE_VALUE = $CP_CODE;

  // function - End
  }


  //-----------------------------------------------------------------------------
  //  실행 Param
  //-----------------------------------------------------------------------------
  function NaverCheckOut_Execution() {

    $ITEM_ID_TEMP = $_GET[ITEM_ID];

    if(is_array($ITEM_ID_TEMP)) {
      $ITEM_ID = @implode("','",$ITEM_ID_TEMP);
      $this->NaverCheckOut_Prod_Xml($ITEM_ID);
    }
    else {
      if($ITEM_ID_TEMP!='') {
        $ITEM_ID = $ITEM_ID_TEMP;
        $this->NaverCheckOut_Prod_Xml($ITEM_ID);
      }
      else {
        echo "잘못된 값입니다.";
        exit;
      }
    }

  // funciton - End
  }


  //-----------------------------------------------------------------------------
  //  상품 연동 양식 (XML)
  //-----------------------------------------------------------------------------
  function NaverCheckOut_Prod_Xml($Goods_no) {

    //  상품정보
    $data = $this->inst_NcSelect->GetGoodSelect($this->CP_CODE_VALUE, $Goods_no);

    // 할인가 설정 전체상품
    $CouponInfoList = $this->inst_SelectShop->GetCouponInfoNewList('','');
    $this->inst_ShopView->CouponDiscountSet(&$data,$CouponInfoList,'goods_no','sale_cost','cate_no',true);

    // 네이버 체크아웃 쿠폰가 설정 요약상품
    $CouponInfoList = $this->inst_SelectShop->GetCouponInfoNhnList($_GET,$data);
    $this->inst_ShopView->CouponDiscountNhnSet(&$data,$CouponInfoList,'goods_no','sale_cost','cate_no',true);

    //  카테고리 정보
    $temp = $this->inst_NcSelect->GetCategorySelect($this->CP_CODE_VALUE);

    //  카테고리를 카테고리 명과 매칭해서 문자열로
    $Have_Catelist	=	$this->inst_Cate->find_parent($data[cate_no],&$temp);
    $CateCount = count($Have_Catelist[Str]);

    header('Content-Type: application/xml;charset=euc-kr');

    $Str = "";
    $Str = $Str."<?xml version=\"1.0\" encoding=\"euc-kr\" ?>\n";
    $Str = $Str."<response>\n";

    for($i=0; $i<count($data[goods_no]); $i++) {

      $goods_no = $data[goods_no][$i];
      $goods_name = $data[goods_name][$i];
      $price = $data[sale_cost][$i];
      $price2 = $data[sale_costbk_nhn][$i];
      $contents = $data[contents][$i]; //상세설명
      $volume = $data[volume][$i]; //재고수량
      $pgurl = "http://".$_SERVER[HTTP_HOST]."/?action=Detail&GoodsCode=$goods_no";
      $igurl = Img_Domain."/".$this->CP_CODE_VALUE."/Goods/".$data[file_name][$i];
      $sgurl_name=str_replace(".jpg","_s.jpg",$data[file_name][$i]);
      $sgurl = Img_Domain."/".$this->CP_CODE_VALUE."/Goods/".$sgurl_name; //썸네일 이미지
      $temp_cate = explode(" > ",$Have_Catelist[Str][$i]); //카테고리 

      //옵션
      $Opt=explode("^||^",$data[opt][$i]);
      //추가구매옵션
      $AddOpt=explode("^||^",$data[addopt][$i]);

      $opt_data="";
      if(trim($Opt[2])!="" && eregi("manual\[_Opt_\]",$Opt[2])){
        $opt_3=explode("manual[_Opt_]",$Opt[2]);
        $opt_seri=unserialize($opt_3[1]);

        if(trim($Opt[0])==trim($Opt[1])){
          //옵션1
          $opt_data = $opt_data."   <options>\n";// <!-- 상품의 옵션이 없으면 이 내용은 없어도 된다. -->
          if(is_array($opt_seri)){
            $opt_data = $opt_data."    <option name=\"".$this->ChangeWord($Opt[0])."\">\n";// <!-- 옵션 종류 이름 -->
            foreach($opt_seri as $se_k=>$se_v) {
              foreach($se_v as $kk=>$vv) {
                $opt_data = $opt_data."       <select><![CDATA[".$kk."]]></select>\n";// <!-- 해당 옵션의 선택 사항 -->           
              }
              continue;
            }
          }
          $opt_data = $opt_data."     </option>\n";
          $opt_data = $opt_data."   </options>\n";// <!-- 상품의 옵션이 없으면 이 내용은 없어도 된다. -->

        }else{
            //옵션1
            $opt_data = $opt_data."   <options>\n";// <!-- 상품의 옵션이 없으면 이 내용은 없어도 된다. -->
            if(is_array($opt_seri)) {
              $opt_data = $opt_data."    <option name=\"".$this->ChangeWord($Opt[0])."\">\n";// <!-- 옵션 종류 이름 -->
              foreach($opt_seri as $se_k=>$se_v) {
                foreach($se_v as $kk=>$vv) {
                  $opt_data = $opt_data."       <select><![CDATA[".$se_k."]]></select>\n";// <!-- 해당 옵션의 선택 사항 -->           
                }
              }
            }
            $opt_data = $opt_data."     </option>\n";
            
						if(@trim($Opt[1])!='') {
							//옵션2
							//if(sizeof($opt_seri)>1){
								$opt_data = $opt_data."    <option name=\"".$this->ChangeWord($Opt[1])."\">\n";// <!-- 옵션 종류 이름 -->
								foreach($opt_seri as $se_k=>$se_v) {
									foreach($se_v as $kk=>$vv) {
										$opt_data = $opt_data."       <select><![CDATA[".$kk."]]></select>\n";// <!-- 해당 옵션의 선택 사항 -->           
									}
								}
							//}
							$opt_data = $opt_data."     </option>\n";
						}
            $opt_data = $opt_data."   </options>\n";// <!-- 상품의 옵션이 없으면 이 내용은 없어도 된다. -->
        }
      }else{
        //옵션없음
        $opt_data="";
      }     

      $Str = $Str." <item id=\"".$goods_no."\">\n";// <!-- 상품 ID. -->
      $Str = $Str."   <name><![CDATA[".$goods_name."]]></name>\n";
      $Str = $Str."   <url>".$this->ChangeWord($pgurl)."</url>\n";// <!-- 상품 설명 페이지 url -->";
      $Str = $Str."   <description><![CDATA[".$contents."]]></description>\n";//
      $Str = $Str."   <image>".$this->ChangeWord($igurl)."</image>\n";// <!-- 상품 image url -->
      $Str = $Str."   <thumb>".$this->ChangeWord($sgurl)."</thumb>\n";// <!-- 상품 썸네일 image url -->
      $Str = $Str."   <price>".$price."</price>\n";// <!-- 할인가 + 쿠폰가격 -->
      $Str = $Str."   <price2>".$price2."</price2>\n";// <!-- 정상 가격 -->
      $Str = $Str."   <quantity>".$volume."</quantity>\n";// <!-- 재고량 -->
      
      //상품의 옵션이 없으면 옵션 내용은 없어도 된다.
      $Str = $Str.$opt_data;

      $Str = $Str."   <category>\n";// <!-- 카테고리 최대 4단계 카테고리까지 표시 가능하다. (first ~ fourth) --->
      $Str = $Str."     <first>".$this->ChangeWord($temp_cate[0])."</first>\n";
      if($temp_cate[1]!="") $Str = $Str."     <second>".$this->ChangeWord($temp_cate[1])."</second>\n";
      if($temp_cate[2]!="") $Str = $Str."     <first>".$this->ChangeWord($temp_cate[2])."</first>\n";
      if($temp_cate[3]!="") $Str = $Str."     <fourth>".$this->ChangeWord($temp_cate[3])."</fourth>\n";
      $Str = $Str."   </category>\n";
      $Str = $Str." </item>\n";

    // loop - End
    }
    $Str = $Str."</response>";

    echo $Str;

  // funciton - End
  }


  //-----------------------------------------------------------------------------
  //  예약어 변환처리
  //-----------------------------------------------------------------------------
  function ChangeWord($word) {
    if(ereg('\&',$word)) { $word = str_replace('&','&amp;',$word); }
    if(ereg('<',$word)) { $word = str_replace('<','&lt;',$word); }
    if(ereg('>',$word)) { $word = str_replace('>','&gt;',$word); }
    if(ereg('"',$word)) { $word = str_replace('"','&quot;',$word); }
    Return $word;
  // funciton - End
  }


  function NHNViewOrder() {

    // --------------------------------------------------------
    // 파라메타 정리 
    @preg_match_all( '/(.*)=(.*)&/Umsi' , $_SERVER['QUERY_STRING'].='&' , $re );
    $order_id = $_GET['ORDER_ID'];
    $item_ids = array();
    foreach($re[1] as $key=>$val) {
      if( $val == 'ITEM_ID' && trim($re[2][$key])!='' ) $item_ids[] = trim($re[2][$key]);
    }

    // --------------------------------------------------------
    // 기본정보
    $Mini_Info = $this->inst_NcSelect->MiniInfoSelect();
    $com_name = trim($Mini_Info[com_name]);
    $address = trim($Mini_Info[address1])." ".trim($Mini_Info[address2]);

    // --------------------------------------------------------
    // 체크아웃 기본 정보 
    $Checkout_Info = $this->inst_NcSelect->NCInfoSelect();
      
    // --------------------------------------------------------
    // 주문 정보
    $Order_Match_Info = $this->inst_NcSelect->SelectOrder($_GET['ORDER_ID'],$_GET['ITEM_ID']);

    // --------------------------------------------------------
    // 최종조합

    // 반품지 설정
    $re_addr = trim($Checkout_Info[re_deliv_addr1][0])." ".trim($Checkout_Info[re_deliv_addr2][0]);
    if(trim($re_addr) == "") { // 반품지 주소가 없을때 기본 정보 사용
      $re_addr = $address;
    }

    $enckey = urlencode(base64_encode(time()));
    
    if(trim($Order_Match_Info[number]) != "") {
      $xml_header = '<?xml version="1.0" encoding="euc-kr" ?> <deliveries> ';
      $str = "";
      

      // 반복 xml 
      foreach($Order_Match_Info[number] as $key=>$val) {

        $itemID = trim($Order_Match_Info['goods_code'][$key]);
        $companyName = trim($Order_Match_Info['pa_sender'][$key]);
        $companyNameEncode = urlencode(trim($Order_Match_Info['pa_sender'][$key])); // 네이버에서 utf-8 보내 문제가 되어 urlencode cjflgka 2011-01-27 연충욱
        $trackingNumber = trim($Order_Match_Info['sendno'][$key]);
        $status = trim($Order_Match_Info['state'][$key]);


// 이대로 내용 나옴 간격 유지 요망
$str.= <<<xmlstr

<delivery>
<itemID><![CDATA[$itemID]]></itemID>
<companyName><![CDATA[$companyName]]></companyName>
<trackingNumber><![CDATA[$trackingNumber]]></trackingNumber>
<status><![CDATA[$status]]></status>
<sellerName><![CDATA[$com_name]]></sellerName>
<senderAddress><![CDATA[$address]]></senderAddress>
<senderName><![CDATA[$com_name]]></senderName>
<returnAddress><![CDATA[$re_addr]]></returnAddress>
<returnName><![CDATA[$com_name]]></returnName>
<statusURL type="new">
<![CDATA[http://www.playauto.co.kr/nhn/tracking.html?sn=$companyNameEncode&so=$trackingNumber&enckey=$enckey]]>
</statusURL>
</delivery>

xmlstr;
      }
      $xml_footer = '</deliveries> ';
      echo $xml_header.$str.$xml_footer;
    }
    exit;
  // funciton - End
  }

  //-----------------------------------------------------------------------------
  //  네이버 쿠폰 정보 받아 디비에 저장하기
  //-----------------------------------------------------------------------------
  function NhnCouponInfo() {
        
    require "xml_parser_coupon.php";

    if($_GET[uisl] == "uisl" ) {
      require_once 'HTTP/Request.php';
      //http post방식으로 요청 전송
      $rq = new HTTP_Request("http://dd.playauto.co.kr/uisl/nhn_cou3.xml");
      $rq->addHeader("Content-Type", "text/xml;charset=UTF-8");
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
      $xml_parse =& new xml_parse();
      $dataList = $xml_parse->parse($rq->getResponseBody());
    }else{
      $xml_parse =& new xml_parse();
      $dataList = $xml_parse->parse($_REQUEST['xml_data']);
    }

    $insert_array = array();
    $insert_array['wdate'] = date('Y-m-d H:i:s');
    $insert_array['templateId'] = $dataList['templateId']; //쿠폰템플릿의유일키
    $insert_array['type'] = $dataList['productId'] == "" && $dataList['categoryId'] == "" ? 0:1; // rate=>정율, fix=>고정가
    $insert_array['dc_type'] = $dataList['type']; // rate=>정율, fix=>고정가
    $insert_array['dc'] = $dataList['dc']; //할인가 및 할인율
    $insert_array['maxPrice'] = $dataList['maxPrice']; // 정율적용시최대금액
    $insert_array['issueMain'] = $dataList['issueMain']; // 발행주체NBP/FRAN(가맹점)
    $insert_array['beginDttm'] = $dataList['beginDttm']; // 발행적용시작시간
    $insert_array['endDttm'] = $dataList['endDttm']; // 발행적용종료시간
    $insert_array['status'] = $dataList['status']; // PUBLS(발행)/PAUSE(일시정지)/TERM(중단)
    $insert_array['mbrIsueQty'] = $dataList['mbrIsueQty']; // 최대할인개수 0이면무한/ 0 이아니면개별최대할인개수

    if($dataList['templateId'] != "") {
	    $goreal = "not";
      $pa_templateId = $this->select_Sock->fetch_key("select templateId from Coupon_Basic_Nhn where templateId='".$dataList['templateId']."'");
      if(trim($pa_templateId[templateid][0]) != ""){
  	    if($insert_array['status'] != "READY"){
          $sql = "update ".$this->DataBase.".Coupon_Range_Nhn set cancel=1 where templateId='".$dataList['templateId']."'" ;
          $this->select_Sock->execute($sql);
        }
        $update_array = array();
        $result = $this->select_Sock->Array_update($this->DataBase.".Coupon_Basic_Nhn",$insert_array,"templateId='".$dataList['templateId']."'");
        if($result == "Success") {
          $re_msg = $_REQUEST['xml_data'];

          // 쿠폰 정보중 종료일만 adb에 넣기 - 쿠폰 종료시 네이버에 전달하기위한 조회용
          $update_aa = array();
          if($insert_array['status'] != "READY"){
            $update_aa[state] = 5;
						$update_aa[cdate] = date('Y-m-d H:i:s');
          }else{
            $update_aa[state] = 2;
          }
          $result = $this->main_Sock->Array_update("ECHost.coupon_edate_info",$update_aa,"templateId='".$dataList['templateId']."' and cp_code='".$this->CP_CODE_VALUE."'");

		    $goreal = $insert_array['status'] == "READY" ?"go":$goreal;
        }else{
          $re_msg = "N";
        }
      }
	  if(trim($pa_templateId[templateid][0]) == "" || $goreal == "go"){
        $result = $this->select_Sock->Array_insert($this->DataBase.".Coupon_Basic_Nhn",$insert_array);
        if($result == "Success" || $goreal == "go") {

          if($dataList['templateId'] != "") {

            //상품 코드별 일때
            if(is_array($dataList['productId'])) {
              foreach($dataList['productId'] as $key=>$val) {
                // 상품별 처리 내역 넣기
                $insert_array2 = array();
                $insert_array2['wdate'] = $insert_array['wdate'];
                $insert_array2['templateId'] = $insert_array['templateId']; //쿠폰템플릿의유일키
                $insert_array2['v_type'] = 1;
                $insert_array2['productId'] = $val;
                $this->select_Sock->Array_insert($this->DataBase.".Coupon_Range_Nhn",$insert_array2);                
              }
            }else{
              // 상품별 처리 내역 넣기
              $insert_array2 = array();
              $insert_array2['wdate'] = $insert_array['wdate'];
              $insert_array2['templateId'] = $insert_array['templateId']; //쿠폰템플릿의유일키
              $insert_array2['v_type'] = 1;
              $insert_array2['productId'] = $dataList['productId']; // 상품코드
              $this->select_Sock->Array_insert($this->DataBase.".Coupon_Range_Nhn",$insert_array2);
            }

            //카테고리별 일대
            if(is_array($dataList['categoryId'])) {
              foreach($dataList['categoryId'] as $key=>$val) {
                // 상품별 처리 내역 넣기
                $insert_array2 = array();
                $insert_array2['wdate'] = $insert_array['wdate'];
                $insert_array2['templateId'] = $insert_array['templateId']; //쿠폰템플릿의유일키
                $insert_array2['v_type'] = 2;
                $insert_array2['categoryId'] = $val;
                $this->select_Sock->Array_insert($this->DataBase.".Coupon_Range_Nhn",$insert_array2);
              }

            }else{
              // 상품별 처리 내역 넣기
              $insert_array2 = array();
              $insert_array2['wdate'] = $insert_array['wdate'];
              $insert_array2['templateId'] = $insert_array['templateId']; //쿠폰템플릿의유일키
              $insert_array2['v_type'] = 2;
              $insert_array2['categoryId'] = $dataList['categoryId'];
              $this->select_Sock->Array_insert($this->DataBase.".Coupon_Range_Nhn",$insert_array2);
            }
          }
          $re_msg =  $_REQUEST['xml_data'];
        }else{
          $re_msg =  "N";
        }
        
        // 쿠폰 정보중 종료일만 adb에 넣기 - 쿠폰 종료시 네이버에 전달하기위한 조회용
        $insert_aa = array();
        $insert_aa['wdate'] = $insert_array['wdate'];
        $insert_aa['cp_code'] = $this->CP_CODE_VALUE;
        $insert_aa['templateId'] = $insert_array['templateId']; //쿠폰템플릿의유일키
        $insert_aa['sdate'] = $dataList['beginDttm'];
        $insert_aa['edate'] = $dataList['endDttm'];
        $this->main_Sock->Array_insert("ECHost.coupon_edate_info",$insert_aa);
      }
     }else{
      $re_msg =  "N";
    }

    echo $re_msg;
    
  // funciton - End
  }

  //-----------------------------------------------------------------------------
  //  네이버 쿠폰에 의해 변경된 상품 로그내용을 상품의 변경 여부 업데이트 하기 
  //-----------------------------------------------------------------------------
  function NhnGoodsEditUpdate() {
    // 업데이트 내용
    $up_goods_dt = array();
    $up_goods_dt['edit_prg'] = "1";
    $up_log_dt = array();
    $up_log_dt['state'] = "1";

    $goods_update_all = $this->select_Sock->fetch("select number from ".$this->DataBase.".Coupon_Goods_Update_Log where state=0 and goods_no = 'ALL' and wdate > DATE_ADD(now(), interval -1 day) ");
    if($goods_update_all[0]['number'] != "") {
      // 전체 쿠폰의 경우 전상품 적용이라 전체 적용하면됨
			$ugel = array();
			$ugel[Goods_no] = '__all__';
			$ugel[Goods_edit_type] = '1';
			$ugel[Goods_edit_date] = "now()";
			$this->select_Sock->Array_insert_dupl("$this->DataBase.Goods_Edit_Log",$ugel,"Success",false);
    }else{

      // 업데이트 대상 상품 추출
      $goods_update_list = $this->select_Sock->fetch("select number,goods_no from ".$this->DataBase.".Coupon_Goods_Update_Log where state=0 and wdate > DATE_ADD(now(), interval -1 day) ");
      $goods_update_list2 = @array_chunk($goods_update_list,"500");
      
      if(is_array($goods_update_list2)) {
        // 500건씩 대상 상품에 변경여부 업데이트 
        foreach($goods_update_list2 as $key=>$val) {
          $dataList = array();
          foreach($val as $key2=>$val2) {
            if($val2['goods_no'] != "") {
							$ugel = array();
							$ugel[Goods_no] = $val2['goods_no'];
							$ugel[Goods_edit_type] = '1';
							$ugel[Goods_edit_date] = "now()";
							$result = $this->select_Sock->Array_insert_dupl("$this->DataBase.Goods_Edit_Log",$ugel,"Success",false);
              if($result == "Success") {
                $dataList[] = $val2['number'];
              }
            }
          }
          // 업데이트 확인 된것만 적용 완료 상태인 1 로 변경
          $result = $this->select_Sock->Array_update($this->DataBase.".Coupon_Goods_Update_Log",$up_log_dt,"number in ('".implode("','",$dataList)."')");
          if($result == "Success") {
            echo "<li> ".$key." : 500건 업로드 완료";
          }
        }
      }
    }
    echo "<li> 모두 업로드 완료";
  }

  //-----------------------------------------------------------------------------
  //  네이버 쿠폰에 의해 변경된 상품 찾아 대상 상품 변경 여부 업데이트 하기
  //  ※ 쿠폰 변경시 기존 적용 상품과 현재 적용상품이 다를수 있어 찾기 위해 로그에 저장후 진행함
  //-----------------------------------------------------------------------------
  function NhnCouponToGoodsEdit($data) {
    $coupon_Info = array();
    if($data[type] == "MATCHING_CATE") {
      $coupon_Info['MATCHING_CATE'] = "OK";
      $coupon_Info['goods_no_array'] = $data['goods_no_array'];
    }else{
      // 신규 쿠폰
      $templateId = str_replace(",","','",$data['templateId']);
      $where = "and a.templateId in ('$templateId')";
      $where_type = $data[type];
      if($data[type2] == "END") {
        $coupon_Info = $this->inst_SelectShop->GetCouponInfoNhnList("","",$where,$where_type,"1");
      }else{
        $coupon_Info = $this->inst_SelectShop->GetCouponInfoNhnList("","",$where,$where_type);
      }
    }

    echo "<li> 신규쿠폰 적용시작 - ".date('Y-m-d H:i:s');
    // 타입별 처리
    if( $data[type] == "NEW" ) {
      $this->NhnCouponToGoodsEditUpLog($coupon_Info); // 변경 여부 로그에 기록
      $this->NhnGoodsEditUpdate(); // 변경 여부 상품에 기록
    }elseif( $data[type] == "EDIT" ) {
      // 변경 쿠폰
      $up_log_dt = array();
      $up_log_dt['state'] = "0";
      $result = $this->select_Sock->Array_update($this->DataBase.".Coupon_Goods_Update_Log",$up_log_dt,"templateId in ('$templateId')");

      // 전체 적용 쿠폰이 있으면 어차피 모든 상품 업데이트 해야 하니 다른 쿠폰 적용할 필요 없음
      if(array_search("0",$coupon_Info[type]) === false) {
        $this->NhnCouponToGoodsEditUpLog($coupon_Info); // 변경 여부 로그에 기록
      }
      $this->NhnGoodsEditUpdate(); // 변경 여부 상품에 기록
    }elseif( $data[type] == "END" ) {
      // 종료 쿠폰
      $this->NhnCouponToGoodsEditUpLog($coupon_Info); // 변경 여부 로그에 기록
      $this->NhnGoodsEditUpdate(); // 변경 여부 상품에 기록
      if($data[type2] == "END") {
        $this->select_Sock->execute("delete from Coupon_Range_Nhn where cancel=1 and templateId in ('$templateId')"); // 네이버가 취소한 쿠폰 정보 삭제하기 2011-11-30 연충욱
      }
      $this->select_Sock->execute("delete from Coupon_Goods_Update_Log where state=1 and templateId in ('$templateId')");
    }elseif( $data[type] == "MATCHING_CATE" ) {
      // 매칭 카테고리
      $this->NhnCouponToGoodsEditUpLog($coupon_Info); // 변경 여부 로그에 기록
    }elseif( $data[type] == "reflash" ) { 
      // Coupon_Goods_Update_Log에 쌓아논 디비정보가 정상적으로 Goods_Edit_Log 에 안들어 갈경우 재시도 할때쓰임 2011-08-11 연충욱
			// http://[cp_code].ec.playautocorp.com/navercheckout/goods_edit_coupon_prg.html?type=reflash
      $this->NhnGoodsEditUpdate(); // 변경 여부 상품에 기록
    }
  }
  //-----------------------------------------------------------------------------
  //  네이버 쿠폰에 의해 변경된 상품 로그 테이블에 적용하기
  //-----------------------------------------------------------------------------
  function NhnCouponToGoodsEditUpLog($coupon_Info) {
    
    echo "<li> 적용쿠폰 정보 추출후 쿠폰 타입에 따라 적용 시작 - ".date('Y-m-d H:i:s');
    
    // 쿠폰 적용이 전체일경우 모든 판매중 상품 변경 기록 
    if(@array_search("0",$coupon_Info[type]) !== false) {
      // 상품별 처리 내역 넣기
      $insert_log = array();
      $insert_log['wdate'] = date('Y-m-d H:i:s');
      $insert_log['templateId'] = $coupon_Info['templateid'];
      $insert_log['goods_no'] = "ALL";
      $insert_log['state'] = 0;
      $result = $this->select_Sock->Array_insertToUpdate($this->DataBase.".Coupon_Goods_Update_Log",$insert_log);
      if($result == "Success") {
        echo "<li> 쿠폰 타입 : 전체 == 적용완료 - ".date('Y-m-d H:i:s');
      }else{
        echo "<li><b><font color=red>쿠폰 타입 : 전체 == 적용실패 - ".date('Y-m-d H:i:s')."</font></b>";
      }
    }else{
      if($coupon_Info[MATCHING_CATE] == "OK") {
        // 네이버 카테고리 변경에 의한 적용으로 쿠폰 정보와 무관하여 따로 소스처리함
        $goods_no_array = explode(",",$coupon_Info['goods_no_array']);
        $up_field = array();
        foreach($goods_no_array as $key=>$val) {
          $up_field[productid][] = trim($val);
          $up_field[productid_pid][] = "nhn_cate";  
        }

      }else{
        $up_field = array();
        
        echo "<li> 쿠폰 타입 중 상품과 카테고리 분리 저장 - ".date('Y-m-d H:i:s');
        foreach($coupon_Info[number] as $key=>$val) {
          // 상품코드
          if( trim($coupon_Info[productid][$key]) != "" && trim($coupon_Info[v_type][$key]) == "1") {
            $up_field[productid][] = trim($coupon_Info[productid][$key]);
            $up_field[productid_pid][] = trim($coupon_Info[templateid][$key]);
          }
          //카테고리
          if( trim($coupon_Info[categoryid][$key]) != "" && trim($coupon_Info[v_type][$key]) == "2") {
            $up_field[categoryid][] = trim($coupon_Info[categoryid][$key]);
            $up_field[categoryid_pid][] = trim($coupon_Info[templateid][$key]);
          }          
        }
      }

      if(sizeof($up_field[productid]) > 0 ) {
        // 상품 코드
        echo "<li> 쿠폰 타입 : 상품코드 == 적용시작 - ".date('Y-m-d H:i:s');
        foreach($up_field[productid] as $key=>$val) {
          $insert_log = array();
          $insert_log['wdate'] = date('Y-m-d H:i:s');
          $insert_log['templateId'] = $up_field[productid_pid][$key];
          $insert_log['goods_no'] = $val;
          $insert_log['state'] = 0;
          $result = $this->select_Sock->Array_insertToUpdate($this->DataBase.".Coupon_Goods_Update_Log",$insert_log); 
          if($result == "Success") {
            echo "<li> 쿠폰 타입 : 상품코드 == $key 건 적용완료 - ".date('Y-m-d H:i:s');
          }else{
            echo "<li><b><font color=red>쿠폰 타입 : 상품코드 == $key 건 적용실패 ( $result )- ".date('Y-m-d H:i:s')."</font></b>";
          }
        }
        echo "<li> 쿠폰 타입 : 상품코드 - 모두 처리완료 - ".date('Y-m-d H:i:s');
      }elseif(sizeof($up_field[categoryid]) > 0 ) {
        // 카테고리
        echo "<li> 쿠폰 타입 : 카테고리 == 적용시작 - ".date('Y-m-d H:i:s');
        $up_categoryid_array = array();
        foreach($up_field[categoryid] as $key=>$val) {
          $where = array();
          for($i=1; $i<=4; $i++) {
            $where[] = "cate_code".$i." = '".$val."'"; // 카테고리 분류별 where절 정리
          }
          $where = implode(" or ",$where);
          $cate_m_list = $this->select_Sock->fetch_keynm("select site_code from Nhn_Cate_Info where ".$where , "site_code");
          $up_categoryid_array[$up_field[categoryid_pid][$key]] = is_array($up_categoryid_array[$up_field[categoryid_pid][$key]]) ? $up_categoryid_array[$up_field[categoryid_pid][$key]]:array();
          $up_categoryid_array[$up_field[categoryid_pid][$key]] = @array_merge($up_categoryid_array[$up_field[categoryid_pid][$key]],$cate_m_list[site_code]);
          echo "<li> 쿠폰 타입 : 카테고리( $val ) == 적용 상품 추출 완료 - ".date('Y-m-d H:i:s');
        }
        
        $ii = 0;
        foreach($up_categoryid_array as $key=>$val) {
          foreach($val as $key2=>$val2) {
            $insert_log = array();
            $insert_log['wdate'] = date('Y-m-d H:i:s');
            $insert_log['templateId'] = $key;
            $insert_log['goods_no'] = $val2;
            $insert_log['state'] = 0;
            $result = $this->select_Sock->Array_insertToUpdate($this->DataBase.".Coupon_Goods_Update_Log",$insert_log); 
            if($result == "Success") {
              echo "<li> 쿠폰 타입 : 카테고리 == $ii 건 적용완료 - ".date('Y-m-d H:i:s');
            }else{
              echo "<li><b><font color=red>쿠폰 타입 : 카테고리 == $ii 건 적용실패 - ".date('Y-m-d H:i:s')."</font></b>";
            }
            $ii++;
          }
        }
        echo "<li> 쿠폰 타입 : 카테고리 == 모두 처리완료 - ".date('Y-m-d H:i:s');
      }else{
        // 무 처리
        echo "<li><b><font color=red> 적용할 카테고리 정보 없음 - ".date('Y-m-d H:i:s')."</font></b>";
      }
    }
  }

}  // class - End

?>