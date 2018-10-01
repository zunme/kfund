<?
class xml_parse  {
    var $parser;
    var $filter_key;
    var $action;
    var $array_data;
    var $array_count;

    function xml_parse($filter_key,$action)
    {

        $this->filter_key = $filter_key;
        if($action == "GetOrderInfo" || $action == "ShipOrder" || $action == "PlaceOrder" || $action == "CancelShipping") {
			$this->action = "n:".$action."Response";
        }else{
			$this->action = $action;
        }

        $this->dataList = array();
        $this->array_data = false;
        $this->parser = xml_parser_create();

        xml_set_object($this->parser, $this);
        xml_set_element_handler($this->parser, "tag_open", "tag_close");
        xml_set_character_data_handler($this->parser, "cdata");
    }

    function parse($data)
    {
        xml_parse($this->parser, $data);
        return $this->dataList;
    }

    // XML 여는테그 발견시
    function tag_open($parser, $tag, $attributes)
    {
        $this->cdata = array();
        $this->cdata = "";
        $tag = str_replace('N1:','',$tag);

        if($tag == strtoupper($this->action)) {
          $this->data = array();
        }

        //XML문서의 특정 경우 강제 배열 생성을 위한 처리 ORDERPRODUCT 경우 값이 없으면 아예 값이 없어 다른 주문에 엉뚱하게 들어갈수 있어서 적용처리
        if($tag == "ORDERPRODUCT") {
          $this->array_data = true;
        }

        if($tag == "ORDERPRODUCTLIST") {
          $this->array_count = 0;
        }

    }

    // XML 필드당 실제 데이터 발견시
    function cdata($parser, $cdata)
    {
        $this->cdata[] = $cdata;
    }

    // XML 닫는테크 발견시
    function tag_close($parser, $tag)
    {
       $tag = str_replace('N1:','',$tag);
       if($this->array_data == true) { //특정데이터 강제 배열처리
         $this->data[$tag][$this->array_count] = trim(@implode('',$this->cdata));
       }elseif(trim($this->data[$tag]) != "" ) { // 반복 데이터 배열처리
        if(is_array($this->data[$tag])) {
          $this->data[$tag][] = trim(@implode('',$this->cdata));
        }else{
          $ppdata = $this->data[$tag];
          $this->data[$tag] = array();
          $this->data[$tag][] = $ppdata;
          $this->data[$tag][] = trim(@implode('',$this->cdata));
        }
       }else{
        $this->data[$tag] = trim(@implode('',$this->cdata));
       }


       //XML문서의 특정 경우 강제 배열 생성을 위한 처리 ORDERPRODUCT 경우 값이 없으면 아예 값이 없어 다른 주문에 엉뚱하게 들어갈수 있어서 적용처리
       if($tag == "ORDERPRODUCT") {
          $this->array_data = false;
          $this->array_count++;
       }

       if($tag == strtoupper($this->action)) {

          if( $this->data['MALLUID'] == $this->filter_key || $this->filter_key == "__ALL__")
            $this->dataList[] = $this->data;
       }

    }

} // end of class xml
?>