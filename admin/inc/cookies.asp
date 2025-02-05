<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<%
    Dim emp_no, em_pass, nm,dept_cd

    emp_no   = Request.Cookies("emp_no")
    em_pass  = Request.Cookies("em_pass")
    nm       = Request.Cookies("nm")
    dept_cd  = Request.cookies("dept_cd")

    'response.write  emp_no &"<br>"
    'response.write  em_pass &"<br>"
    'response.write  nm &"<br>"
    'response.write  dept_cd &"<br>"
	 
    If emp_no = "" Or em_pass = ""   Then

%>
	<script language="javascript">
		alert("연결이 끊겼습니다.\n다시 로그인해 주십시오!!!.")
		location.href="/admin/login.asp"
	</script>
<%
    End if
%>
