          <!-- 게시판 시작 -->
          <table width='100%' border='0' cellspacing='0' cellpadding='0'>
<FORM METHOD="POST" ACTION="{inst_otm->self_page}" Name="boardlist" onsubmit="return find_word(document.boardlist.Key,document.boardlist);"> 
<INPUT TYPE="hidden" NAME="section" value="{essential.section}">
<INPUT TYPE="hidden" NAME="action" value="{essential.action}">
<INPUT TYPE="hidden" NAME="table_name" value="{essential.table_name}">
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
            <tr style='padding:10px'>
              <td width='5%' align='center' class='box7'><font class='11pxb'>no</font></td>
              <td width='65%' align='center' class='box7'><font class='11pxb'>제목</font></td>
              <td width='10%' align='center' class='box7'><font class='11pxb'>이름</font></td>
              <td width='10%' align='center' class='box7'><font class='11pxb'>날짜</font></td>
              <td width='10%' align='center' class='box7'><font class='11pxb'>조회</font></td>
            </tr>
{@ trlist}
            <tr style='padding:5px' onmouseover="this.style.backgroundColor='#FFF2F2'" onmouseout="this.style.backgroundColor=''">
              <td width='5%' align='center' class='box7'>{( inst_page->total -(inst_page->page-1)*inst_page->block_set )- trlist.index_} </td>
              <td width='65%' class='box7'>{inst_otm->Make_space(trlist.thread)}
{inst_otm->Sep_level(inst_StringCon,inst_auth,essential.table_name,essential.section,trlist.b_no,inst_page->page,'',essential.U_id,trlist.writer_id,trlist.title)} {? trlist.c_count > 0}<font class='eng3'>[{trlist.c_count}] </font> {/}</td>
              <td width='10%' align='center' class='box7'> { inst_StringCon->change_gal(inst_StringCon->ugly_han(inst_StringCon->clear_text(trlist.writer_name))) } </td>
              <td width='10%' align='center' class='box7'> { inst_StringCon->ext_date(trlist.regi_date,'ymdm') }</td>
              <td width='10%' align='center' class='box7'> { trlist.ref }</td>
            </tr>
{ / }
            <tr>
              <td height='50' colspan='5' align='right' style='padding-right:20px'>
              { ? essential.U_id !="" }<img src='img/page5/bt_img01.gif' onclick="write_record('{inst_otm->self_page}','{essential.table_name}','{essential.section}');" style="cursor:hand">
               { : }
               <font class='11px2'>로그인 하셔야 글을 쓰실 수 있습니다.</font>
              {/}
              </td>
            </tr>
            <tr>
              <td height='2' colspan='5' bgcolor='#EBEBEB'></td>
            </tr>
            <tr>
              <td height='40' colspan='5' align='center'>{inst_page->print_page()}</td>
            </tr>
            <tr>
              <td height='20' colspan='5' align='center'>
                <select name="Field" class='search'>
                <OPTION VALUE="Title" >제  목</OPTION>
                <OPTION VALUE="Contents" >내  용</OPTION>
                <OPTION VALUE="Writer_name" >작성자</OPTION>
                </select>
                <input type='text' name='Key' class='search' size='28' MAXLENGTH="28"> <img src='img/page5/bt_img02.gif' align='absmiddle' onclick = "find_word(document.boardlist.Key,document.boardlist);" style="cursor:hand">&nbsp;&nbsp;{essential.total_view}</td>
            </tr>
          </table>