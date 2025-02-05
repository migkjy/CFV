<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<% 

    OpenF5_DB objConn

    On Error Resume Next 
 
    g_kind   = Request("g_kind")
    If g_kind=""  or  isnull(g_kind) then
        Response.write "<script language='javascript'>"
        Response.write " alert('카테고리가 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    gotopage = Trim(Request("gotopage"))

    num = Request("num")
    sunseo = Request("sunseo")


    n_cnt = Request.form("num").count
    
    For ii=1 to n_cnt
    
        n_num = Request("num")(ii)
        n_sunseo = Request("sunseo")(ii)
       
        sql = "update  trip_gtck set sunseo ='"&n_sunseo&"'  where num ="&n_num
        objConn.Execute(sql) 

    Next
%>

<script type="text/javascript">
<!--
    location.href="tck_list.asp?g_kind=<%=g_kind%>&gotopage=<%=gotopage%>";
//-->
</script>	
