          <!-- 게시판 시작 -->
          <table width='100%' border='0' cellspacing='0' cellpadding='0'>
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'>
                <table width='100%' border='0' cellspacing='0' cellpadding='0'>
            <tr>
              <td width='5%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align="center">{ data.b_no[0] }</td>
              <td width='65%' bgcolor='#F7F7F7' style='padding:5px' class='box7'>{inst_StringCon->change_gal(inst_StringCon->ugly_han(data.title[0]))}</td>
              <td width='20%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='11px'>{data.writer_name[0]}</font></td>
              <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ inst_StringCon->ext_date(data.regi_date[0],'ymdm') }</font></td>
              <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ data.ref[0] }</font></td>
            </tr>
                </TABLE>
              </td>
            </tr>
            <tr>
              <td width='100%' height='250' colspan='5' style='padding:10px' class='box7' valign='top' >{data.contents[0]} </td>
            </tr>
<FORM METHOD=POST ACTION="{inst_otm->self_page}" NAME="writeform"  enctype="multipart/form-data"> 
	<INPUT TYPE="hidden" NAME="section" value="{essential.section}">
	<INPUT TYPE="hidden" NAME="action" value="write_save">
	<INPUT TYPE="hidden" NAME="table_name" value="{essential.table_name}">
	<INPUT TYPE="hidden" NAME="U_id" value="{essential.U_id}">
	<INPUT TYPE="hidden" NAME="U_name" value="{essential.U_name}">
	<INPUT TYPE="hidden" NAME="U_Level" value="{essential.U_Level}">
	<INPUT TYPE="hidden" NAME="Thread" value="{data.thread[0]}">
	<INPUT TYPE="hidden" NAME="Fid" value="{data.fid[0]}">
{inst_otm->Print_notice_check(essential.U_Level,"",essential.Thread)}
            <tr>
              <td height='1' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
            <tr>
              <td width='15%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align=center>제목</td>
              <td class='box7' style='padding:5px'><input type='text' name='Title' class='join' size='80' maxlength="80" ></td>
            </tr>
            <tr>
              <td width='770' height='320' colspan='5' style='padding:5px'>{oFCKeditor->Create()}</td>
            </tr>
</FORM>
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
            <tr>
              <td height='60' colspan='5' align='center'><img src='img/page6/bt_img06.gif'  onclick ="Write_submit(document.writeform,'{essential.section}',document.multi1,document.multi2,'write');" style="cursor:hand"> <img src='img/page6/bt_img02.gif'   style="cursor:hand" onclick="document.location.replace('{inst_otm->self_page}?action=view&table_name={essential.table_name}&section={essential.section}&No={essential.No}&page={essential.page}');"></td>
            </tr>
          </table>