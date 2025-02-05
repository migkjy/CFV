<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    
    Dim tbl ,nav ,ts ,kind ,num
    If Ucase(Request.ServerVariables("REQUEST_METHOD")) <> "POST" Then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다.!!!'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if
    
    tb = Request.form("tb")
    If Trim(tb)="" or isnull(tb) then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다.1..'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if
    
    Select Case tb 
        Case "af": tbl2 ="trip_after_dat"
        Case "ph": tbl2 ="trip_photo_dat"
    End select
    
    ss = Request.form("ss")
    If Trim(ss)="" or isnull(ss) then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다.!!!'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if
    
    
    r_ss = Session.SessionID
 
    If ss = r_ss then
        dat_pass = Trim(Request.form("dat_pass"))
        regIP  = Request.ServerVariables("REMOTE_HOST")
        del_yn = "N"

        if len(dat_pass)>=4 then
            num = Request.form("num")
            dat_user_nm = Request.form("dat_user_nm")
            dat_user_nm = replace(dat_user_nm, "'", "")
    	            
            dat_content = Request.form("dat_content")
            dat_content = replace(dat_content, "'", "''")

            OpenF5_DB objConn

            Sql = "INSERT INTO "&tbl2&" ( num, user_nm , user_id ,passwd , content ,ip ,del_yn) "
            Sql = sql &" VALUES ("&num&",'"&dat_user_nm&"','"&ss&"','"&dat_pass&"','"&dat_content&"','"&regIP&"','"&del_yn&"')"
            objConn.Execute Sql
    
            CloseF5_DB objConn
        end if
    
    End if
%>
 
<script type="text/javascript">
<!--
    parent.location.reload();
//-->
</script>
