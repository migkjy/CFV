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

<html>
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


    <table width="220" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="31" bgcolor="#F5F5F5" style="font-size:0.875em; padding:0 0 0 15px; border-top:1px solid #E7E7E7; border-bottom:1px solid #E7E7E7;border-left:1px solid #E7E7E7;border-right:1px solid #E7E7E7;"><strong>비밀번호가 맞지 않았습니다.</strong></td>
        </tr>
        <tr>
            <td height="40" style="border-bottom:1px solid #E7E7E7;border-left:1px solid #E7E7E7;border-right:1px solid #E7E7E7;">
                <div align="center"><a href="javascript:history.back();"><img src="/images/community/dat_reok.png" border="0"></div>
            </td>
        </tr>
    </table>
    
</body>
</html>
<% End if %> 