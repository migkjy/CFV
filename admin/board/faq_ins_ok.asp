<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    tbl = "trip_faq"
    num = Request("num")

    writer = Request("writer")
    writer = check_html(writer) 

    title = Request("title")
    title = check_html(title) 

    ir_1 = Request("ir_1")	
    ir_1 = Replace(ir_1,"'" ,"''") 


    OpenF5_DB objConn

    If num ="" then

        Sql = "SELECT MAX(num) FROM "&tbl
        Set Rs = objConn.Execute(sql)
	
	    if isnull(Rs(0)) then
		    num = 1
	    else
		    num = rs(0) + 1
	    end if
        Rs.close : Set Rs = Nothing

           sql =       "insert into "&tbl&" (num      , user_id         , user_nm        ,   title      , con_tents          ,hit  ,del_yn ,ins_dt,agent_cd) values "
        sql = sql & " (                " & num & " , N'" & emp_no & "' , N'" & writer & "' , N'"& title &"',N'" & ir_1 & "' , 0   ,'N'  ,getdate(),'9999' )"
        objConn.Execute(sql)

    Else

        sql="UPDATE  "&tbl&" SET  user_nm= N'"&writer&"' , title=N'"&title&"', con_tents= N'"&ir_1&"'  "
        sql= sql& " WHERE num="&num
     
        objConn.Execute Sql

    End if

    CloseF5_DB objConn

%>

<script type="text/javascript">
<!--
    alert("정상적으로 처리되었습니다.");
    location.href="faq_list.asp?gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
//-->
</script>
