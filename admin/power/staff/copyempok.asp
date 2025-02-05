<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn

    c_emp_no   = request.form("c_emp_no") '기존직원 사번
    p_emp_no   = request.form("p_emp_no") '신규직원 사번

    objConn.BeginTrans
    
    	
    sql = "delete from TB_em300  WHERE emp_no = "&p_emp_no
    objConn.execute(sql) 
    If Err.number = 0 Then
        objConn.CommitTrans	
    Else 
        objConn.RollbackTrans
        CloseF5_DB objConn
        fnUrl "등록중 오류가 발생했습니다.      ",""
	End If
   
	objConn.BeginTrans
     
     
	sql="select emp_no,menu from TB_em300 where emp_no ='" & c_emp_no & "'"
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Rs.open sql,objConn,3
	If Err.number = 0 Then
		objConn.CommitTrans		
    Else 
		objConn.RollbackTrans
		CloseF5_DB objConn
		fnUrl "등록중 오류가 발생했습니다.      ",""
	End If
	
	Do while rs.eof=false 
		
    objConn.BeginTrans
    
    Sql = "SELECT MAX(seq) FROM TB_em300"
    Set Rs1 = objConn.Execute(sql) 

    If isnull(Rs1(0)) then
        seq = 1
    Else
        seq = rs1(0) + 1
    End if 
    CloseRs Rs1 
    
    If Err.number = 0 Then
        objConn.CommitTrans		
    Else
        objConn.RollbackTrans
        CloseF5_DB objConn
        fnUrl "등록중 오류가 발생했습니다.      ",""
    End if 
	
    objConn.BeginTrans

		
    sql="insert into TB_em300(seq,emp_no,menu)"
    sql=sql&" values('"&seq
    sql=sql&"','"&p_emp_no
    sql=sql&"','"& rs("menu") &"')"
 

    objConn.execute sql 
    If Err.number = 0 Then
        objConn.CommitTrans	
    Else 
        objConn.RollbackTrans
        CloseF5_DB objConn
        fnUrl "등록중 오류가 발생했습니다.      ",""
	End if

    rs.movenext 
    loop 

    CloseRs Rs 
    CloseF5_DB objConn
%>

<script language = "javascript">
	alert("<%=p_emp_no%>가 <%=c_emp_no%>와 동일하게 권한생성 되었습니다.");
	location.href = "copyemp.asp";
</script> 