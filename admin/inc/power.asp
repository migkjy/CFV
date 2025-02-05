<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn
    pah1 = request.ServerVariables("PATH_INFO")

    sql777 = "	exec proc_TB_ba001_remark_cd  '"&pah1&"' "
    Set Rs777 = objConn.Execute(sql777)
    If  not Rs777.eof or not Rs777.bof  Then
        cd = RS777("cd")
        Rs777.Close : Set Rs777 = Nothing	
    Else
        cd = Request("cd")	
    End if	
%>

<%
    If emp_no="" then
        emp_no = Request("emp_no")
    End if

    If MASTER_USER<>emp_no Then 
        sql913 = "	exec proc_TB_ba001_s01_powermenu2 'PAGE','"&cd&"','"&emp_no&"' "
    Else
        sql913 = "	exec proc_TB_ba001_s01_powermenu 'PAGE','"&cd&"' "
    End if
    
    Set Rs913 = objConn.Execute(sql913)
    If  Rs913.eof or Rs913.bof  Then
        Response.Write("<script language='JScript'>alert('사용 가능한 메뉴가 아닙니다.\n관리자에게 문의 하세요!');location.replace('/admin/Bin_page.html');</script>")
        Rs913.Close : Set Rs913 = Nothing	
        response.end  
    End if	

    CloseF5_DB objConn		 
%>	 