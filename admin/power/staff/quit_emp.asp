<!--#include virtual="/admin/conf/config.asp"-->

<%
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.AddHeader "Expires","0"

    OpenF5_DB objConn

    emp_no = Request("emp_no")
    tbl = "TB_em001"
    quit_day=replace(date,"-","") 
    
    If emp_no<>"" Then 
        sql = " update "& tbl &" set quit_day = '"&quit_day&"'  where emp_no = '"&emp_no&"' "
        objConn.Execute(sql)

        CloseF5_DB objConn
%>
	<script language="javascript">
	    alert("퇴사처리 되었습니다.");
	    location.href = "list.asp";
	</script>
<%
    End if
%>
