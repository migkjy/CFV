<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    tbl    = "trip_notice"
    num = Request("num")
        
    g_kind = Request("g_kind")
    If Trim(g_kind)="" or isnull(g_kind) then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    writer = Request("writer")
    writer = check_html(writer) 

    title = Request("title")
    title = check_html(title) 

    ir_1  = Request("ir_1")
    ir_1   = Replace(ir_1,"'","''")

    regIP = Request.ServerVariables("REMOTE_HOST")


    OpenF5_DB objConn
    
    If num ="" then
        msg="정상적으로 등록 되었습니다"
        	
        Sql = "SELECT MAX(num) FROM "&tbl
        Set Rs  = Server.CreateObject("ADODB.RecordSet")
        Rs.Open sql, objConn,3,1

        if isnull(Rs(0)) then
            n_num = 1
        else
            n_num = rs(0) + 1
        end if 

        CLOSERS RS

        sql =       "insert into "&tbl&" (num      , user_id         ,  user_nm          , dept_cd       , title       , con_tents      , g_kind         , hit  ,re_comd  ,del_yn ,ins_dt  ,ip ,agent_cd) values "
        sql = sql & " (                " & n_num & " , N'" & emp_no & "' , N'" & writer & "' , '"& dept_cd &"',N'"& title &"','" & ir_1 & "' , " & g_kind & " , 0    ,'N'      ,'N'     ,getdate() ,'" & regIP & "' ,'"&agent_cd&"')"
        objConn.Execute(sql)

    Else
        msg="정상적으로 수정 되었습니다"

        sql="UPDATE  "&tbl&" SET  user_nm= N'"&writer&"' , title=N'"&title&"' , con_tents= N'"&ir_1&"' WHERE num="&num
        objConn.Execute Sql

    End if


    CloseF5_DB objConn		
%>
	
<script type="text/javascript">
<!--
    alert("<%=msg%>");
    location.href="notice_list.asp?g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
//-->
</script>

