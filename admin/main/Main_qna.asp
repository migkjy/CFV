
    <%
        tbl = "trip_qna"
        sql2 = "SELECT TOP  10  num,  title, ins_dt "	
        sql2 = sql2 & " FROM "  & tbl   
        sql2 = sql2 & " WHERE del_yn='N' and ref_level=0  "
        sql2 = sql2 & "  ORDER BY num DESC"
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Set Rs = objConn.Execute(sql2)
    %>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr height="26" bgcolor="#E7E7EF">
            <td width="85" class="main_1">번호</td>
            <td width="*" class="main_2">제목</td>
            <td width="85" class="main_2">등록일</td>
        </tr>
        <% If Rs.eof then %>
        <tr>
            <td class="main_bin" colspan="3">등록된 자료가 없습니다</td>
        </tr>
        <% 
            Else 
               i = 1
               Do Until Rs.EOF
        
                  n_num = Rs("num")
                  n_title  = cutStr(Rs("title"),185)
                  n_ins_dt = Rs("ins_dt")
        %>
        <tr height="26" bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';" style="cursor:pointer;" onclick="location.href='/admin/board/qna_list.asp'">
            <td class="main_3"><%=i%></td>
            <td class="main_5"><%=n_title%></td>
            <td class="main_4"><%=left(n_ins_dt,10)%></td>
        </tr>
        <% 
                Rs.MoveNext
                i = i +1
                Loop
                
            Rs.close : Set Rs =  Nothing
            End If 
        %>
    </table>
