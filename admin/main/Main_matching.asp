
    <%
        Response.Expires=0
        
        If Request("pageno")="" then
            PageNo = 1
        Else
            PageNo = CInt(Request("pageno"))
        End if
            
        If Request("startpage")="" then
            StartPage = 1
        Else
            StartPage = CInt(Request("startpage"))
        End if
            	
        sql = "select  num, send_name, send_hp, app_gubn, ins_dt, cu_nm_kor, cu_hp, cu_memid, del_yn from TB_sel_memo where app_gubn='1'"
        sql = sql & " order by ins_dt desc "
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
        
        rs_cnt = rs.RecordCount
        If rs_cnt > 0 then 
            Page_Count = 10
            rs.PageSize = Page_Count
            rs.AbsolutePage = PageNo
            Page_List = 10
        End If
    %>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <% If rs_cnt = 0 then %>
        <tr height="26" bgcolor="#E7E7EF">
            <td width="10%" class="main_1">번호</td>
            <td width="13%" class="main_2">매칭 받은사람</td>
            <td width="16%" class="main_2">휴대전화번호</td>
            <td width="13%" class="main_2">매칭 보낸사람</td>
            <td width="16%" class="main_2">휴대전화번호</td>
            <td width="10%" class="main_2">매칭</td>
            <td width="*%" class="main_2">신청일</td>
        </tr>
        <tr>
            <td class="main_bin" colspan="7">등록된 자료가 없습니다</td>
        </tr>
        <%
                response.end
            End if 
        %> 
        <tr height="26" bgcolor="#E7E7EF">
            <td width="10%" class="main_1">번호</td>
            <td width="13%" class="main_2">매칭 받은사람</td>
            <td width="16%" class="main_2">휴대전화번호</td>
            <td width="13%" class="main_2">매칭 보낸사람</td>
            <td width="16%" class="main_2">휴대전화번호</td>
            <td width="10%" class="main_2">매칭</td>
            <td width="*%" class="main_2">신청일</td>
        </tr>
        <%
            if rs.PageCount = PageNo then
                    
            ListLoop = rs_cnt Mod rs.PageSize
                    
            if ListLoop = 0 then ListLoop = rs.PageSize 
            else 
                ListLoop = rs.PageSize
            end if
                    
            n = rs_cnt - (pageno-1) * rs.PageSize 
                  
                        
            For k = 1 to ListLoop
                    
                knum =rs("num")
                send_name =rs("send_name")
                send_hp =rs("send_hp")
                app_gubn =rs("app_gubn")
                ins_dt =rs("ins_dt")
                k_cu_nm_kor =rs("cu_nm_kor")
                k_cu_hp =rs("cu_hp")
                k_cu_memid =rs("cu_memid")                       
        %>
        <tr height="26" bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';" style="cursor:pointer;">
            <td class="main_3"><%=k%></a></td>
            <td class="main_4"><%=send_name%></td>
            <td class="main_4"><%=send_hp%></td>
            <td class="main_4"><%=k_cu_nm_kor%></td>
            <td class="main_4"><%=k_cu_hp%></td>
            <td class="main_4">확정</td>
            <td class="main_4"><%=ins_dt%></td>
        </tr>
        <%
                n=n-1
                rs.MoveNext
          
            Next
        %>
    </table>
