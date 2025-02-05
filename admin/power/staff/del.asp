<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.CharSet = "utf-8" 
    Response.AddHeader	"Pragma","no-cache"
    Response.AddHeader	"Expires","0"

    
    OpenF5_DB objConn

    emp_no = Request("emp_no")
    tbl = "TB_em001"

    If emp_no<>"" Then 
        sql = " update "& tbl &" set del_fg = 'Y' where emp_no = '"&emp_no&"' "
	
        objConn.Execute(sql)
%>
    <script language="javascript">
        parent.location.reload();
    </script>
<%
    End if
    CloseF5_DB objConn
%>