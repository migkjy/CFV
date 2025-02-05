<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/support.asp"-->
<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    Dim tbl ,nav ,ts ,kind ,num
     
    if Ucase(Request.ServerVariables("REQUEST_METHOD")) <> "POST" Then
        Response.write "<script language='javascript'>"
        Response.write " alert('접근하실수 없습니다.'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if
    
    
    tb = Request.form("tb")
        If Trim(tb)="" or isnull(tb) then
            Response.write "<script language='javascript'>"
            Response.write " alert('접근하실수 없습니다.'); "
            Response.write " self.close();"
            Response.write " </script>	 "
            Response.end
        End if
         
        Select Case tb 
            Case "af": tbl2 ="trip_after_dat"
            Case "fe": tbl2 ="trip_festi_dat"
            Case "po": tbl2 ="trip_photo_dat"
        End select
 
    
    ss = Request.form("ss")
        If Trim(ss)="" or isnull(ss) then
            Response.write "<script language='javascript'>"
            Response.write " alert('접근하실수 없습니다.'); "
            Response.write " self.close();"
            Response.write " </script>	 "
            Response.end
        End if
    
        r_ss = Session.SessionID
        
        dat_pass = Trim(Request.form("dat_pass"))
        
        if ss = r_ss then
            regIP    = Request.ServerVariables("REMOTE_HOST")
        	del_yn   = "N"
        
        
        	if len(dat_pass)>=4 then
        	    dat_pass = Trim(Request.form("dat_pass"))
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

        	Else
        	    Response.write "<script language='javascript'>"
        	    Response.write " alert('비밀번호는 4글자 ~10글자 입니다.'); "
        	    Response.write " self.close();"
        	    Response.write " </script>	 "
        	    Response.end 
        	End if
        
        End if
%>
 
<script type="text/javascript">
<!--
    parent.location.reload();
//-->
</script>
