<?
class xml_parse  {
  var $parser;
  var $filter_key;
  var $action;
  var $array_data;
  var $array_count;

  function xml_parse($filter_key,$action)
  {
    $this->dataList = array();
    $this->action = $action;
    $this->cd = 0;

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
    $ppd = false;
    $tag = str_replace("N1:","",$tag);
    $tag = str_replace("N:","",$tag);

    if($tag == $this->action) {
      $this->ppd = true;
      $this->data = array();
    }
    
  }

  // XML 필드당 실제 데이터 발견시
  function cdata($parser, $cdata)
  {
    $cdata = $cdata == "" ? "NULL":$cdata;
    $this->cdata[] = $cdata;
    $this->cd++;
  }

  // XML 닫는테크 발견시
  function tag_close($parser, $tag)
  {
    $tag = str_replace("N1:","",$tag);
    $tag = str_replace("N:","",$tag);

    if($this->ppd) {
      
      $this->data[$tag] = @implode('',$this->cdata);
      if($tag == $this->action) {
        $this->ppd = false;
        $this->dataList[$tag][] = $this->data;
      }
    }else{
      $this->data = @implode('',$this->cdata);
      $this->dataList[$tag][] = $this->data;
    }
    $this->cdata = array();  
  }

} // end of class xml
?>