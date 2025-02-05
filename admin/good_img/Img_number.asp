<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
     OpenF5_DB objConn 
    
    g_seq  = Request("g_seq")
    p_seq  = Request("p_seq")
    dp_seq = Request("dp_seq")


    If dp_seq="" or isnull(dp_seq) then
        dp_seq = ""
        sql = "Update ex_good_photo set  disp_seq='"&dp_seq&"' where p_seq="&p_seq
        objConn.Execute(sql)
    Else
        sql = "Update ex_good_photo set disp_seq='"&dp_seq&"' where p_seq="&p_seq
        objConn.Execute(sql)
    End if

    objConn.close   : Set objConn = nothing   
%>

<script type="text/javascript">
<!--
	location.href="img_main.asp?g_seq=<%=g_seq%>";
//-->		
</script>
 