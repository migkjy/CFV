
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <colgroup>
            <col width="8px;">
            <col width="*;">
            <col width="20%;">
        </colgroup>
        <tbody>
            <%
                tbl="trip_notice"
                
                sql = "SELECT TOP 4 num ,title ,ins_dt FROM "&tbl&" where del_yn='N' and g_kind=10 ORDER BY num DESC"
                
                Set Rs = objConn.Execute(Sql)
                if NOt (Rs.eof or Rs.bof) then
                   k=1
                   Do Until Rs.Eof
                     no_num       = Rs("num")
                     no_title     = Rs("title")
                     no_ins_dt    = left(Rs("ins_dt"),10)
                     no_check_new = datediff("d",left(now,10),no_ins_dt)
            %>
            <tr height="30">
                <td>◦</td>
                <td>
                    <span class="com_main3"><a href="/home/board/notice_view.asp?num=<%=no_num%>"><%=title_cutting(no_title,26)%></a></span>
                    <% if no_check_new = 0 then %>
                        <span style="color:#FF0000; font-size:13px;"><i class="xi-new-o xi-x"></i></span>
                    <% end if %>
                </td>
                <td class="com_main4"><%=no_ins_dt%></td>
            </tr>
            <%
                        k = k+1
                        Rs.Movenext
                    Loop
                End if
                    
                CloseRs Rs
            %>     
        </tbody>  
    </table>
