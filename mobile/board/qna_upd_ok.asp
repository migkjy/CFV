<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Response.Expires = -1
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    Session.codepage=65001
    Response.CharSet = "utf-8" 

   If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        response.write "  window.location.href='/';"
        response.write "</script>"
        response.end
    End if

    tbl  = "trip_qna"

    num = Request("num")
    if Trim(num)="" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('연결이 잘못되었습니다.'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.End
    end if
    
    gotopage = Request("gotopage")

    writer = Request("writer")
    title = Request("title")

    res_hp1 = Request("res_hp1")
    res_hp1 = Replace(res_hp1,"'","")
    
    res_hp2 = Request("res_hp2")
    res_hp2 = Replace(res_hp2,"'","")
    
    res_hp3 = Request("res_hp3")
    res_hp3 = Replace(res_hp3,"'","")
 
    email = Request("email")
    email = Replace(email,"'","''")

    content = Request("content")
    content  = replace(content,"'","''")

    secret = Request("secret")

 
    OpenF5_DB objConn

 
    sql="UPDATE  "&tbl&" SET  user_nm='"&writer&"' , title='"&title&"'  ,con_tents='"&content&"' , secret='"&secret&"'  "
    sql= sql& ", email ='"&email&"' , res_hp1='"&res_hp1&"', res_hp2='"&res_hp2&"', res_hp3='"&res_hp3&"'  "
    sql= sql& " WHERE num="&num

    objConn.Execute Sql

    objConn.close : Set objConn = Nothing
%>
 

<script type="text/javascript">
<!--
    location.href="qna_list.asp";
//-->
</script>	 
