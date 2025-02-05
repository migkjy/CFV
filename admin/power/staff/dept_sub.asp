<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    OpenF5_DB objConn
 
    dept_cd_k = Trim(Request("dept_cd_k"))
%>

    <select name="c_emp_no" class="select_basic" style="width:200px;">
        <option value="" selected>사원선택</option>
        <%
            sql = "select emp_no,nm from TB_em001  where dept_cd=  '"&dept_cd_k&"' and del_fg='N'  and (quit_day is null or quit_day = '')  order by emp_no"
            set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
            If Rs.eof or Rs.bof then
        %>
        <option>사원이 없습니다.</option>
        <%
            Else
                Do Until Rs.eof
        %>
        <option value="<%=Trim(Rs("emp_no"))%>"  <% if cstr(c_emp_no) = cstr(Trim(Rs("emp_no"))) then response.write "selected" end if %>  ><%=Trim(Rs("nm"))%>(<%=Trim(Rs("emp_no"))%>)</option>
        <%
                Rs.movenext
                Loop
                CloseRs Rs
            End if
        %>
    </select>
    
<%
    CloseF5_DB objConn
%>