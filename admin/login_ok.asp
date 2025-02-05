<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<%

    Dim maid, mapass, sql, rs
    
    maid = Request("maid")
    mapass = Request("mapass")
    mapass_sec = Request("mapass")
    mapass = Base64_Encode(mapass)
    'response.write  mapass
    'response.end

    OpenF5_DB objConn
    Dim Cmd, Param, Ret
    
    Set Cmd   = Server.CreateObject("ADODB.Command")
    Cmd.ActiveConnection = objConn.ConnectionString
    
    Cmd.CommandText = "proc_admin_TB_em001_login"
    Cmd.CommandType = adCmdStoredProc
    
    Set Param = Cmd.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
    Cmd.Parameters.Append Param
    Set Param = Nothing	
    
    Set Param = Cmd.CreateParameter("@maid", adVarChar, adParamInput, 10, maid)
    Cmd.Parameters.Append Param
    Set Param = Nothing
    
    Cmd.Parameters.Append Cmd.CreateParameter("@mapass", adVarChar, adParamInput, 20, mapass)
    
    Cmd.Parameters.Append Cmd.CreateParameter("@nm", adVarChar, adParamOutput, 20, nm)	
    
    Cmd.Parameters.Append Cmd.CreateParameter("@dept_cd", adVarChar, adParamOutput, 10, dept_cd)	
    
    Cmd.Execute , , adExecuteNoRecords
    

    nm = Cmd.Parameters("@nm").Value
    dept_cd = Cmd.Parameters("@dept_cd").Value
    Ret = Cmd.Parameters("return_value").Value 
    
    Select Case Ret
    
        Case -1
            response.write "<script language='javascript'>               "
            response.write "  alert('아이디가 없습니다.');"
            response.write "  history.go(-1);                            "
            response.write "</script>                                    " 
            response.end
        Case -2   
            response.write "<script language='javascript'>               "
            response.write "  alert('비밀번호가 틀렸습니다.');"
            response.write "  history.go(-1);                            "
            response.write "</script>                                    " 
            response.end
        Case 0
            Response.Cookies("emp_no")     = maid		 
            Response.Cookies("em_pass")    = mapass
            Response.Cookies("nm")            = nm
            Response.Cookies("dept_cd")       = dept_cd
            Response.cookies("idchk").expires= date+30
    
            chk= Request("chk")
    
            if Ucase(chk) = "Y" then
                Response.cookies("idchk")("id")  = maid
                Response.cookies("idchk")("pwd") = mapass_sec
            end if
    	
    	
            Response.Redirect "index.asp"
    End select
    
    Set Cmd = Nothing
		
    CloseF5_DB objConn	
%>