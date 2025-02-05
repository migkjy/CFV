<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    tbl = "trip_qna"

    gotopage = Request("gotopage")


    res_tp   = Request("res_tp")
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")
    
    num = Request("num")

    ref = Request("ref")
    ref_level = Request("ref_level")
    deep = Request("deep")
    
    
    writer = Request("writer")
    writer = check_html(writer) 
    
    title = Request("title")
    title =  check_html(title) 
    	
    content = Request("content")
    content  = replace(content,"'","''")
    
    
    regIP = Request.ServerVariables("REMOTE_HOST")


    OpenF5_DB objConn

    If num ="" then
    	
        Sql = "SELECT MAX(num) FROM "&tbl
        Set Rs = objConn.Execute(sql)

            if isnull(Rs(0)) then
                num = 1
            else
                num = rs(0) + 1
            end if

        Rs.close  : Set Rs = Nothing

        ref = num
        ref_level = 0
        deep = 0

        sql =       "insert into "&tbl&" (num      , user_id     , user_nm     , title       , con_tents     , email      , hit ,re_comd  ,ref   ,ref_level      ,deep     ,pwd         ,   secret ,del_yn ,ip ,agent_cd) values "
        sql = sql & " (                " & num & " , '"&emp_no&"' ,N'"&writer&"' , N'"&title&"',N'"& content &"' ,'"&email&"' ,   0  ,'N'  ,"&num&" , "&ref_level&" ,"&deep&" ,'"&memid&"' ,'N'       ,'N'     ,'"&regIP&"' ,'9999')"
        objConn.Execute(sql)

    Else

        if ref<> "" then
            Sql = "SELECT MAX(num) FROM "&tbl
            Set Rs = objConn.Execute(sql)

                if isnull(Rs(0)) then
                    num = 1
                else
                    num = rs(0) + 1
                end if

            Rs.close  : Set Rs = Nothing

            ref = Cint(request("ref"))
            ref_level = Cint(request("ref_level"))
            deep = Cint(request("deep"))

            sqlString = "update "&tbl&" set ref_level = ref_level + 1 where ref = "&ref&" and deep > "&deep
            objConn.Execute(sqlString)

            ref_level = ref_level + 1
            deep = deep + 1

            sql =       "insert into "&tbl&" (num      , user_id     , user_nm     , title      , pwd         ,  con_tents       , email     , hit ,re_comd  ,ref     ,ref_level      ,deep      ,secret  ,del_yn,agent_cd ) values "
            sql = sql & " (                " & num & " , '"&emp_no&"' ,N'"&writer&"' ,N'"&title&"', '"&memid&"' ,N'"& content &"' ,'"&email&"'  ,   0 ,'N'      ,"&ref&" , "&ref_level&" ,"&deep&"  ,'N'     ,'N'  ,'9999'    )"
            objConn.Execute(sql)

        Else

            Sql = " UPDATE "&tbl&" SET user_nm =N'"&writer&"' , title =N'"&title&"'	,con_tents=N'"&content&"' WHERE num="&num
            objConn.Execute Sql

        End if

    End if

    CloseF5_DB objConn
%>

<script type="text/javascript">
<!--
	location.href="qna_list.asp?gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&res_tp=<%=res_tp%>";
//-->
</script>	
