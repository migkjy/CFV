<!--#include virtual="/admin/conf/config.asp"-->

<%
    OpenF5_DB objConn

    cd = Request("cd")
	emp_no = Request("emp_no")			
	flag = Request("flag")			

    If flag="I" Then
    	
        sql = "	select isNull(max(seq),'') from TB_em300 "
        Set Rs = objConn.Execute(sql)

        If Not Rs.Eof Then
            seq = Rs(0)+1
        Else
            seq = 1
        End if

        Rs.Close : Set Rs = Nothing
	
        sql =	"insert TB_em300(seq, emp_no, menu)	values("&seq&",'"&emp_no&"','"&cd&"') "
        objConn.Execute(sql)
        
    ElseIf flag="N" Then 
    	
        sql =	"	delete TB_em300 where emp_no = '"&emp_no&"' and menu = '"&cd&"' "
        objConn.Execute(sql)
        
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
</head>

<body>

    <form name="contact" method="post" action="power_use.asp" style="display:inline; margin:0px;">
    <input type="hidden" name="emp_no"	value="<%=emp_no%>">
    <input type="hidden" name="cd" value="<%=cd%>">
        <select name="flag" onChange="fnOrder()" class="select_basic" style="width:150px;"><%subPower cd, emp_no%></select>
   </form> 
   
</body>
</html>

<script language=javascript>
	function fnOrder(){
		document.contact.submit();
	}
</script>

<%
	CloseF5_DB objConn
%>