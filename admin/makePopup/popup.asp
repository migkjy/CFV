<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    
    OpenF5_DB objConn


    status    = request("status")
    dia_width = cint(request("width"))
    dia_height = cint(request("height"))

    newwin = 1

    ir_1 = Request("ir_1")
    ir_1 = Replace(ir_1,"'","''")

	if status <> "Y" then
		status = "N"
	end if



	SQLString = "UPDATE newwin SET"
 	SQLString = SQLString& " width = "&dia_width&","
 	SQLString = SQLString& "height = "&dia_height&","
 	SQLString = SQLString& "pop = N'"&status&"',"
 	SQLString = SQLString& "newwin=N'"&ir_1&"'"
 	SQLString = SQLString& " WHERE no="&newwin
 	objConn.Execute(SQLString)
 	
    CloseF5_DB objConn	
%>

<script language="javascript">
<!--
    alert("수정되었습니다.");
    location.href="newwin.asp";

//-->
</script>
