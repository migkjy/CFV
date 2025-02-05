<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/support.asp"-->
 <!--#include virtual="/home/inc/URLTools.asp"-->
 <!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Session.codepage=65001
    Response.CharSet = "utf-8" 

   If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        response.write "  window.location.href='/';"
        response.write "</script>"
        response.end
    End if

    tbl = "trip_qna"
    gotopage = Request("gotopage")

     writer = Request("writer")
    writer  = check_html(writer)

    res_hp1 = Request("res_hp1")
    res_hp1 = Replace(res_hp1,"'","''")
    res_hp2 = Request("res_hp2")
    res_hp2 = Replace(res_hp2,"'","''")
    res_hp3 = Request("res_hp3")
    res_hp3 = Replace(res_hp3,"'","''")
    res_phone= res_hp1&"-"&res_hp2&"-"&res_hp3

    email = Request("email")
    email = Replace(email,"'","''")

    title = Request("title")
    title  = check_html(title)
 
    content = Request("content")
    content  = replace(content,"'","''")

    secret  = Request("secret")

    password    = Request("password")
    captchacode = Request("captchacode")

    regIP = Request.ServerVariables("REMOTE_HOST")



    OpenF5_DB objConn

    Sql = "SELECT MAX(num) FROM "&tbl
    Set Rs = objConn.Execute(sql)
 
    if isnull(Rs(0)) then
        n_num = 1
    else
        n_num = rs(0) + 1
    end if 
 
    CloseRs Rs


    ref = n_num
    ref_level = 0
    deep      = 0


    If TestCaptcha("ASPCAPTCHA",captchacode) then 

       sql =       "insert into "&tbl&" (num, user_nm , res_hp1 ,res_hp2 ,res_hp3, email ,title,  pwd ,con_tents,agent_cd, "
       sql = sql & "   secret     ,re_comd  , ref      ,ref_level    ,deep        ,hit   ) values "
       sql = sql & "("&n_num&", N'"&writer&"','"&res_hp1&"', '"&res_hp2&"', '"&res_hp3&"','"&email&"', N'"&title&"', '"&password&"',N'"&content&"','9999',"
       sql = sql & " '"&secret&"' ,'N'      ,"&ref&"  ,"&ref_level&"  ,"&deep&" , 0 )"

       objConn.Execute(sql)


       CloseF5_DB objConn
%>

    <!--<iframe name="ifmJob" id="ifmJob" src="/home/sms/tour_sms.asp?res_name=<%=URLEncodeUTF8(writer)%>&phone=<%=res_phone%>&tp=q"  width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="yes" frameborder="0" framespacing="0"></iframe>-->

    <script type="text/javascript">
    <!--
        alert("상담 게시판이 등록되었습니다.");
        location.href="qna_list.asp";
     //-->
    </script>

<% Else %>

    <script type="text/javascript">
    <!--
       alert("입력이 올바르지 않습니다. 다시 입력해주세요. ");
       history.back();
     //-->
    </script>

<% End if %>
 