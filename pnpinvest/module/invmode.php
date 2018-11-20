<?php
function tohtmlstring($str){
	if($str != strip_tags($str)) return stripslashes($str);
	else return nl2br($str);
}
function removez($str){
	$str = str_replace("&#8203;", "", $str);
	$str = str_replace("\xE2\x80\x8C", "", $str);
	return str_replace("\xE2\x80\x8B", "", $str);
}
function cdataz($data){
	$chartcolor = array('#FF9800', '#FFEB3B', '#4CAF50', '#2196F3', '#3F51B5');
	if( isset($data['dambo']) && $data['dambo']!='' ){
		$tmpchart = explode("::chart::", $data['dambo']);
		if (count($tmpchart)==3){
      $tmpchart = explode("@@@", $tmpchart[1]);
      if( count($tmpchart)==2 ) {
        $title = removez($tmpchart[0]);
        $tmpchart = $tmpchart[1];
      }else {
        $title ="";
        $tmpchart = $tmpchart[0];
      }

			$tmpchart = explode(":", $tmpchart);
			$chartdata = array();
			$hiddenchartdata = array();

			foreach ($tmpchart as $row){
				$tmpchartsplit = explode('@', $row);
				$tmphidden = explode('##', $tmpchartsplit[0]);
				if( count($tmphidden)==2 ){
					$hiddenchartdata[] = "{name: '".removez($tmphidden[1])."' , data: [".removez($tmpchartsplit[1])."]}";
				}else $chartdata[] = "{name: '".removez($tmpchartsplit[0])."' , data: [".removez($tmpchartsplit[1])."]}";
			}
			$chartdata = "[".implode(",", $chartdata)."]";
			$hiddenchartdatastr = "[".implode(",", $hiddenchartdata)."]";
			?>
			<div class="chartdiv_wrap"><div id="chart_container"></div><div id="chart_detail"></div>
      <script src="https://code.highcharts.com/highcharts.js"></script>
      <script src="https://code.highcharts.com/modules/exporting.js"></script>
      <script src="https://code.highcharts.com/modules/export-data.js"></script>
      <link rel="stylesheet" href="https://www.kfunding.co.kr/pnpinvest/data/resource/investview.css" type="text/css">
			<script>
			var chartdata = <?php echo $chartdata?>;
			var hiddenchartdata = <?php echo $hiddenchartdatastr?>;
			var chartcolor = <?php echo json_encode($chartcolor)?>;
			var linecolor="#000000";

			var _0x3a42=['column','bold','theme','textColor','gray','series','point','normal','dataLabelsColor','white','document','ready','each','<div\x20class=\x27c_d_row\x27\x20/>','append','<div\x20class=\x27c_d_c1\x27>','name','</div>','<div\x20class=\x27c_d_c2\x27>','data','chart','chart_container'];(function(_0x522e09,_0x156462){var _0x4e44a5=function(_0x53130e){while(--_0x53130e){_0x522e09['push'](_0x522e09['shift']());}};_0x4e44a5(++_0x156462);}(_0x3a42,0x112));var _0xe7ec=function(_0x67848d,_0x34d57d){_0x67848d=_0x67848d-0x0;var _0x2eab90=_0x3a42[_0x67848d];return _0x2eab90;};$(_0xe7ec('0x0'))[_0xe7ec('0x1')](function(){$[_0xe7ec('0x2')](chartdata,function(_0x48528d,_0x147b88){var _0x2ff00e=$(_0xe7ec('0x3'));_0x2ff00e[_0xe7ec('0x4')](_0xe7ec('0x5')+_0x147b88[_0xe7ec('0x6')]+_0xe7ec('0x7'));_0x2ff00e[_0xe7ec('0x4')](_0xe7ec('0x8')+_0x147b88[_0xe7ec('0x9')]+_0xe7ec('0x7'));$('#chart_detail')[_0xe7ec('0x4')](_0x2ff00e);console['log'](_0x2ff00e);});});Highcharts[_0xe7ec('0xa')](_0xe7ec('0xb'),{'chart':{'type':_0xe7ec('0xc'),'height':0x168,'animation':!![]},'title':{'text':''},'colors':chartcolor,'xAxis':{'categories':[''],'lineColor':linecolor,'lineWidth':0x1,'tickColor':linecolor,'tickWidth':0x1},'yAxis':{'min':0x0,'title':{'text':''},'stackLabels':{'enabled':!![],'style':{'fontWeight':_0xe7ec('0xd'),'color':Highcharts[_0xe7ec('0xe')]&&Highcharts[_0xe7ec('0xe')][_0xe7ec('0xf')]||_0xe7ec('0x10')}}},'tooltip':{'headerFormat':'','pointFormat':'','formatter':function(){return this[_0xe7ec('0x11')][_0xe7ec('0x6')]+':'+this[_0xe7ec('0x12')]['y']+'원';}},'plotOptions':{'column':{'stacking':_0xe7ec('0x13'),'dataLabels':{'enabled':!![],'color':Highcharts[_0xe7ec('0xe')]&&Highcharts[_0xe7ec('0xe')][_0xe7ec('0x14')]||_0xe7ec('0x15'),'formatter':function(){return this['series'][_0xe7ec('0x6')];}}}},'series':chartdata});
			</script>
			<script>
			$("document").ready (function() {
				$.each( hiddenchartdata , function(ind, val ) {
					$("#chart_detail").prepend('<div class="c_d_row2 row"><div class="c_d_c1 hiddendata col-xs-6">'+ val.name+'</div><div class="c_d_c2 col-xs-6">'+val.data[0]+'</div></div>');
				});
			});
			</script>
			<style>
			<?php
			$hdcount = count($hiddenchartdata);
				for ($i=0; $i < count($chartcolor); $i++ ){
					$childnum = $i + 1 + $hdcount;
					?>

.c_d_row:nth-child(<?php echo $childnum ?>) .c_d_c1:before {
	color: <?php echo $chartcolor[$i] ?>
}
					<?php
				}
			?>
			</style>
			<?php
      if($title !=''){
        ?>
        <script>
        $("#chartitle_th").text("<?php echo $title?>");
        </script>
        <?
      }
			return true;
		} else {
			echo $sanghwang = tohtmlstring($data['dambo']);
			return false;
		}
	}
	return false;
}
