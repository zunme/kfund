<?
class xml_parse  {
    var $parser;

    function xml_parse() 
    {
        $this->dataList = array();
        $this->parser = xml_parser_create();

        xml_set_object($this->parser, $this);
        xml_parser_set_option($this->parser,XML_OPTION_CASE_FOLDING,0);
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
        if(sizeof($attributes) > 0 ) {
          $this->dataList = array_merge($this->dataList,$attributes);
        }
    }
    
    // XML 필드당 실제 데이터 발견시
    function cdata($parser, $cdata) 
    {
        if($cdata != ""){
          $this->cdata[] = trim($cdata);
        }
    }

    // XML 닫는테크 발견시
    function tag_close($parser, $tag) 
    {
      if($this->cdata[0] != "") {
        if(array_key_exists($tag,$this->dataList)) {
          if(is_array($this->dataList[$tag])) {
            $this->dataList[$tag][] = trim(@implode('',$this->cdata));
          }else{
            $dtp = $this->dataList[$tag];
            $this->dataList[$tag] = array();
            $this->dataList[$tag][] = $dtp;
            $this->dataList[$tag][] = trim(@implode('',$this->cdata));
          }
        }else{
          $this->dataList[$tag] = trim(@implode('',$this->cdata));
        }
        
        $this->cdata = array();  
      }
    }

} // end of class xml
?>