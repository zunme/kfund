<!-- 게시판 시작 -->
<table width='100%' border='0' cellspacing='0' cellpadding='0'>
  <FORM METHOD=POST ACTION="{inst_otm->self_page}" NAME="writeform"  enctype="multipart/form-data"> 
    <INPUT TYPE="hidden" NAME="section" value="{essential.section}">
    <INPUT TYPE="hidden" NAME="action" value="edit_save">
    <INPUT TYPE="hidden" NAME="table_name" value="{essential.table_name}">
    <INPUT TYPE="hidden" NAME="U_id" value="{essential.U_id}">
    <INPUT TYPE="hidden" NAME="U_name" value="{essential.U_name}">
    <INPUT TYPE="hidden" NAME="U_Level" value="{essential.U_Level}">
    <INPUT TYPE="hidden" NAME="Thread" value="{essential.Thread}">
    <INPUT TYPE="hidden" NAME="Fid" value="{essential.Fid}">
    <INPUT TYPE="hidden" NAME="No" value="{essential.No}">
    <INPUT TYPE="hidden" NAME="addstring" value="">
    <INPUT TYPE="hidden" NAME="charger" value="">
    <INPUT TYPE="hidden" NAME="Collaborator" value="">
    <INPUT TYPE="hidden" NAME="Start_time" value="">
    <INPUT TYPE="hidden" NAME="End_time" value="">
    {inst_otm->Print_notice_check(essential.U_Level,data.top[0],data.thread[0])}
    <tr>
      <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
    </tr>
    <tr>
      <td width='5%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align="center">{ data.b_no[0] }</td>
      <td width='65%' bgcolor='#F7F7F7' style='padding:5px' class='box7'><INPUT TYPE="text" NAME="Title" size="80" maxlength="80" value="{data.title[0]}"  class='join'></td>
      <td width='20%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='11px'>{data.writer_name[0]}</font></td>
      <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ inst_StringCon->ext_date(data.regi_date[0],'ymdm') }</font></td>
      <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ data.ref[0] }</font></td>
    </tr>
    <tr>
      <td width='100%' height='350' colspan='5' style='padding:10px' class='box7' valign='top'>
        {oFCKeditor->Create()}
      </td>
    </tr>
    <tr>
      <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
    </tr>
  </FORM>
    <tr>
      <td height='60' colspan='5' align='center'><img src='img/page6/bt_img06.gif'  onclick ="Write_submit(document.writeform,'{essential.section}',document.multi1,document.multi2,'write');" style="cursor:hand"> <img src='img/page6/bt_img02.gif'  style="cursor:hand" onclick="document.location.replace('{inst_otm->self_page}?action=view&table_name={essential.table_name}&section={essential.section}&No={essential.No}&page={essential.page}');">
      </td>
    </tr>
  </table>