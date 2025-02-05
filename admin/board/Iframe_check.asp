<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    tb_cd = lcase(Request("tb_cd"))
        Select Case tb_cd
        Case "af"
            tbl = "trip_after"
        Case "no"
            tbl = "trip_notice"
        Case "qn"
            tbl = "trip_qna"
        Case "fe"
            tbl = "trip_festi" 
        End Select

    num     = Request("num")
    flag    = Request("flag")
    re_comd = Request("re_comd")

    If re_comd="Y" then 
        other_re_comd="N"
    Else
        other_re_comd="Y"
    End if


     OpenF5_DB objConn

    If flag="up" then
        sql2 = " update "&tbl&" set re_comd ='"&other_re_comd&"' where num ="&num
        objConn.Execute(sql2)
    End if

     sql = "Select re_comd from "&tbl&" where num = "&num
    Set Rs = objConn.Execute(sql)
    
    re_comd = Rs(0)

    CloseRs Rs

    CloseF5_DB objConn
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

    <form name="chkframe" method="post" action="iframe_check.asp" style="display:inline; margin:0px;" >
    <input type="hidden" name="num" value="<%=num%>">
    <input type="hidden" name="flag" value="up">
    <input type="hidden" name="re_comd" value="<%=re_comd%>">
    <input type="hidden" name="tb_cd" value="<%=tb_cd%>">
    <span class="checks"><input type="checkbox" name="inout_view" onclick="check_on()" id="<%=num%>" <% if re_comd="Y" then response.write "checked" end if %>><label for="<%=num%>"></label></span>
    </form>

</body>
</html>

<script type="text/javascript">
<!--
   function check_on(){
      document.chkframe.submit();
   }
//-->
</script>