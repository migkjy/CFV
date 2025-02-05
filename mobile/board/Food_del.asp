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

   ' If memid = "" Or pwd = "" Or memnum = ""  Then
      '  response.write "<script language='javascript'>  "
      '  Response.write " alert('로그인정보없습니다..'); "
       ' response.write "  window.location.href='/';"
       ' response.write "</script>"
       ' response.end
   ' End if
 
    tbl = "trip_after"
 
    num = Request.form("num")
    If  Trim(num)=""  then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('연결이 잘못되었습니다.'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.end
    End if

    gotopage = Request.form("gotopage")

    s_cont = Request.form("s_cont")
    s_cont = Replace(s_cont,"'","") 
    
    cont = Request.form("cont")
    cont = Replace(cont,"'","")

    password   = Request.form("password")
    If  Trim(password)=""  then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('비밀번호가 일치하지 않습니다.'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.end
    End if


    OpenF5_DB objConn

    Sql = "SELECT pwd FROM "&tbl&" WHERE num = "&num
    Set Rs = objConn.Execute(Sql)

    r_pwd  = Rs("pwd")

    Rs.close: set Rs=nothing


    If r_pwd = password then

        sql = " delete from "&tbl&" where num ="&num
        objConn.Execute(sql)

        CloseF5_DB objConn
%>

<script type="text/javascript">
<!--
    alert("맛집 게시판이 삭제 되었습니다.");
    location.href = "food_list.asp?gotopage=<%=gotopage%>";
//-->
</script>

<%
    Else
        Response.write "<script type='text/javascript'>"
        Response.write " alert('비밀번호가 일치하지 않습니다.'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.end
    End if
%> 
