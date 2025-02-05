<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    tbl = "trip_notice"
    num = Request("num")
    
    g_kind   = Request("g_kind")
    if  Trim(num)=""  or g_kind ="" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자전송에러!!!...'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.end
    end if

    gotopage = Request("gotopage")
    
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")

    OpenF5_DB objConn

    sql = " delete from "&tbl&" where num = " &num 
    objConn.Execute Sql

    CloseF5_DB objConn
%>

<script type="text/javascript">
<!--
    alert("삭제 처리되었습니다.   ");
    location.href = "notice_list.asp?gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&g_kind=<%=g_kind%>";
//-->
</Script>
	