<!-- 게시판 시작 -->
<table width='100%' border='0' cellspacing='0' cellpadding='0'>
  <FORM METHOD=POST ACTION="{inst_otm->self_page}" NAME="writeform"  enctype="multipart/form-data"> 
  <INPUT TYPE="hidden" NAME="section" value="{essential.section}">
  <INPUT TYPE="hidden" NAME="action" value="write_save">
  <INPUT TYPE="hidden" NAME="table_name" value="{essential.table_name}">
  <INPUT TYPE="hidden" NAME="U_id" value="{essential.U_id}">
  <INPUT TYPE="hidden" NAME="U_name" value="{essential.U_name}">
  <INPUT TYPE="hidden" NAME="U_Level" value="{essential.U_Level}">
  <INPUT TYPE="hidden" NAME="Thread" value="{essential.Thread}">
  <INPUT TYPE="hidden" NAME="Fid" value="{essential.Fid}">
  {inst_otm->Print_notice_check(essential.U_Level,"",essential.Thread)}
  <tr>
    <td height='2' colspan='2' bgcolor='#EBEBEB'></td>
  </tr>
  <tr>
    <td width='15%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align=center>제목</td>
    <td class='box7' style='padding:5px'><input type='text' name='Title' class='join' size='80' maxlength="80" ></td>
  </tr>
  <tr>
    <td width='770' height='420' colspan='2' style='padding:5px'>{oFCKeditor->Create()}</td>
  </tr>
  </FORM>
  <tr>
    <td height='2' colspan='2' bgcolor='#EBEBEB'></td>
  </tr>
  <tr>
    <td height='60' colspan='2' align='center'><img src='img/page6/bt_img06.gif'  onclick ="Write_submit(document.writeform,'{essential.section}',document.multi1,document.multi2,'write');" style="cursor:hand"> <img src='img/page6/bt_img02.gif'   style="cursor:hand" onclick="document.location.replace('{inst_otm->self_page}?action=list&table_name={essential.table_name}&section={essential.section}');"></td>
  </tr>
</table>