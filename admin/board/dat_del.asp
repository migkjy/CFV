<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    seq = Request("seq")
    num = Request("num")
    
    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
    cont = Request("cont")
 
    p = lcase(Request("page"))
    Select Case p
        Case "ph"
            tbl_name="trip_photo_dat"
            page="photo"
        Case "af"
            tbl_name="trip_after_dat"
            page="after"
        End Select

    OpenF5_DB objConn

    sql = "DELETE from "&tbl_name&" where seq ="&seq
    objConn.Execute Sql

    CloseF5_DB objConn
%>

<script type="text/javascript">
<!--
    alert("삭제 처리되었습니다.   ")
    location.href = "<%=page%>_view.asp?num=<%=num%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
//-->
</Script> 

