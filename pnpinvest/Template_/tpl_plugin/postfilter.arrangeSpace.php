<?php

/* POSTFILTER EXAMPLE */

function arrangeSpace($source, $tpl)
{
	$sql = " select  * from  mari_goods order by g_datetime ASC";
	$product = sql_query($sql, false);
}
?>