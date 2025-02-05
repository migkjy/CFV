<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

	idx    = Request("idx")
	tbl    = Request("tbl")
	passwd = Request("passwd")

	Select Case tbl 
		Case "af": tbl2 ="trip_after_dat"
	End select

    OpenF5_DB objConn

	sql = "Select seq from "&tbl2&" where seq=" & idx & " and passwd='" & passwd & "'"
	Set Rs = objConn.Execute(sql)
	If not rs.EOF Then
	    sql = "delete   from "&tbl2&"  where seq=" & idx
	    objConn.Execute Sql

	     
	     
	    CloseF5_DB objConn
	    

%>
	    <script type="text/javascript">
	    <!--
	        alert("삭제되었습니다.");
	        parent.location.reload();
	    //-->
	    </script>
<% Else %>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link rel="stylesheet" type="text/css" href="/css/style.css" />

<body>

    <table width="230" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #E7E7E7;border-radius:4px;background:#FFF;">
        <tr>
            <td height="40" bgcolor="#F5F5F5" style="font-size:13px; padding:0 0 0 15px; border-bottom:1px solid #E7E7E7;"><strong>비밀번호가 맞지 않았습니다.</strong></td>
        </tr>
        <tr>
            <td height="50" style="border-bottom:1px solid #E7E7E7;">
                <table border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                        <td><a href="javascript:history.back();"><img src="/images/board/dat_reok.png" border="0" style="border-radius:4px;"></a></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
</body>
</html>
<% End if %> 