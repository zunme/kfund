function get_editor_w_content()
{
    return oEditors.getById['w_content'].getIR();;
}

function put_editor_w_content(content)
{
    oEditors.getById["w_content"].exec("SET_CONTENTS", [""]);
    //oEditors.getById["wr_content"].exec("SET_IR", [""]);
    oEditors.getById["w_content"].exec("PASTE_HTML", [content]);

    return;
}