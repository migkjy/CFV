<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<%
    Session.codepage=65001
    Response.CharSet = "utf-8" 

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
    writer  = check_html(writer)

    title = Request("title")
    title  = check_html(title)

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


    sql="UPDATE  "&tbl&" SET  user_nm=N'"&writer&"' , title=N'"&title&"'  ,con_tents=N'"&content&"' , secret='"&secret&"'  "
    sql= sql& ", email ='"&email&"' , res_hp1='"&res_hp1&"', res_hp2='"&res_hp2&"', res_hp3='"&res_hp3&"'  "
    sql= sql& " WHERE num="&num

    objConn.Execute Sql

    objConn.close : Set objConn = Nothing
%>
  
<script type="text/javascript">
<!--
    alert("수정 되었습니다.");
    location.href="qna_list.asp?gotopage=<%=gotopage%>";
//-->
</script> 