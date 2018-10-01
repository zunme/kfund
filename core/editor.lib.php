<?php
if (!defined('_MARICMS_')) exit; 


function editor_html($id, $content)
{
    return "<textarea id=\"$id\" name=\"$id\" style=\"width:100%;\" maxlength=\"65536\">$content</textarea>";
}


// textarea 로 값을 넘긴다. javascript 반드시 필요
function get_editor_js($id)
{
    return "var {$id}_editor = document.getElementById('{$id}');\n";
}


//  textarea 의 값이 비어 있는지 검사
function chk_editor_js($id)
{
    return "if (!{$id}_editor.value) { alert(\"내용을 입력해 주십시오.\"); {$id}_editor.focus(); return false; }\n";
}
?>