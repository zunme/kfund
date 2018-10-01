          <!-- 게시판 시작 -->
          <table width='100%' border='0' cellspacing='0' cellpadding='0' style="overflow: hidden; word-wrap:break-word; word-break:break-all;">
            <tr>
              <td height='2' colspan='5'  bgcolor='#EBEBEB'></td>
            </tr>
             <tr>
              <td width='5%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align="center">{ data.b_no[0] }</td>
              <td width='55%' bgcolor='#F7F7F7' style='padding:5px' class='box7'>{inst_StringCon->change_gal(inst_StringCon->ugly_han(data.title[0]))}</td>
              <td width='20%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='11px'>{data.writer_name[0]}</font></td>
              <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ inst_StringCon->ext_date(data.regi_date[0],'ymdm') }</font></td>
              <td width='10%' bgcolor='#F7F7F7' style='padding:5px' class='box7' align='center'><font class='eng2'>{ data.ref[0] }</font></td>
            </tr>
            <tr>
              <td width='100%' height='350' colspan='5'  style='padding:10px' valign='top' >{data.contents[0]} </td>
            </tr>
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
             {inst_otm->Print_viewfunction(essential.mysql,data.filename[0],essential.action,essential.table_name,essential.section,
             data.b_no[0],essential.U_id,data.writer_id[0],data.top[0],data.thread[0],data.fid[0])}
             <!-- 댓글 -->
            <tr>
              <td colspan='5' >
                 <table width='100%' border='0' cellspacing='0' cellpadding='0'>
{ @ cdata }
                  <tr style='padding:10px' onmouseover="this.style.backgroundColor='#FFF2F2' "onmouseout="this.style.backgroundColor=''">
                    <td width='10%' class='box7' align='center'><font class='11px'>{ cdata.c_name }</font></td>
                    <td width='73%' align='left' class='box7' style='table-layout:fixed'>{ inst_StringCon->change_gal(inst_StringCon->ugly_han(inst_StringCon->url_decoder(cdata.comment))) }</td>
                    <td width='17%' class='box7' align='center'>{ inst_StringCon->ext_date(cdata.regi_date,'ymdhi') } 
                    {? cdata.c_id == essential.U_id }
                    <img src='img/page5/bt_img09.gif' align='absmiddle' style='cursor:hand' onclick="if(confirm('삭제 하시겠습니까?')){return document.location.replace('{inst_otm->self_page}?action=comdele&table_name={essential.table_name}&section={essential.section}&No={essential.No}&Cno={cdata.c_no}&ID={cdata.c_id}');}else{return false;}"> </td>
                    {/}
                  </tr>
{ / }
                 </table>
              </td>
            </tr>
            <!-- 댓글 작성 -->
            <tr>
              <td height='10' colspan='5' ></td>
            </tr>
              { ? essential.U_id !="" }
               <FORM METHOD=POST ACTION="{inst_otm->self_page}" NAME="commentform">
                 <INPUT TYPE="hidden" NAME="section" value="{essential.section}">
                 <INPUT TYPE="hidden" NAME="action" value="addcom">
                 <INPUT TYPE="hidden" NAME="table_name" value="{essential.table_name}">
                 <INPUT TYPE="hidden" NAME="U_id" value="{essential.U_id}">
                 <INPUT TYPE="hidden" NAME="U_name" value="{essential.U_name}">
                 <INPUT TYPE="hidden" NAME="No" value="{essential.No}">
                 <tr>
                   <td colspan='5'  bgcolor='#EBEBEB' style='padding:5px'><textarea name='Comment' cols='97' rows='4'></textarea> <img src='img/page5/bt_img10.gif' align='absmiddle' style="cursor:hand" onclick="submitcomadd(document.commentform);"></td>
                 </tr>
               </FORM>
               { : }
                <tr>
                  <td colspan='5'  bgcolor='#EBEBEB' style='padding:5px' align='center'><font class='11px2'>로그인하셔야 댓글을 쓰실수 있습니다.</font></td>
                </tr>
              {/}
            <tr>
              <td height='2' colspan='5' >&nbsp;</td>
            </tr>
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
{? data_sub_count > 1 }
            <!-- 관련글 출력 -->
            <tr>
              <td colspan='5'>
                 <TABLE width='100%' border='0' cellspacing='0' cellpadding='0'>
                  {@ data_sub}
                  <tr style='padding:5px' onmouseover="this.style.backgroundColor='#FFF2F2'" onmouseout="this.style.backgroundColor=''" on=>
                  <td width='70%' class='box7'>{inst_otm->Print_arrow(essential.No,data_sub.b_no)}{inst_otm->Make_space(data_sub.thread)}
                  {inst_otm->Sep_level(inst_StringCon,inst_auth,essential.table_name,essential.section,data_sub.b_no,inst_page->page,'',essential.U_id,data_sub.writer_id,data_sub.title)} {? data_sub.c_count > 0}<font class='eng3'>[{data_sub.c_count}] </font> {/}</td>
                  <td width='10%' align='center' class='box7'> { inst_StringCon->change_gal(inst_StringCon->ugly_han(inst_StringCon->clear_text(data_sub.writer_name))) } </td>
                  <td width='10%' align='center' class='box7'> { inst_StringCon->ext_date(data_sub.regi_date,'ymdm') }</td>
                  <td width='10%' align='center' class='box7'> { data_sub.ref }</td>
                  </tr>
                  { / }
                </TABLE>
              </td>
            </tr>
{/}
          </table>