<%
    Response.Expires = -1
    Response.ExpiresAbsolute = Now() - 1
    Response.AddHeader "pragma", "no-cache"  
    Response.AddHeader "cache-control", "private"
    Response.CacheControl = "no-cache"  
    Session.codepage=65001
    Response.CharSet="utf-8"
 
    Response.Cookies("memnum") = ""
    Response.Cookies("memnum").expires = now() 
    Response.Cookies("memid") = ""
    Response.Cookies("memid").expires = now()
    Response.Cookies("pwd") = ""
    Response.Cookies("pwd").expires = now()
    Response.Cookies("cu_nm_kor") = ""
    Response.Cookies("cu_nm_kor").expires = now()
    Response.Cookies("cu_htel") = ""
    Response.Cookies("cu_htel").expires = now()
    
    
%>

<script language="JavaScript">
<!--
	alert("정상적으로 로그아웃 되었습니다.");
	location.href="/"
//--> 
</script> 