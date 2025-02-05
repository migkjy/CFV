<%
    Response.Expires = -1
    Response.ExpiresAbsolute = Now() - 1
    Response.AddHeader "pragma", "no-cache"  
    Response.AddHeader "cache-control", "private"
    Response.CacheControl = "no-cache"  
    Session.codepage=65001
    Response.CharSet="utf-8"
  
    dim memnum, memid, pwd, cu_nm_kor

    memnum = Request.Cookies("memnum")
    memid = Request.Cookies("memid")
    cu_nm_kor = Request.Cookies("cu_nm_kor")
    pwd = Request.Cookies("pwd")
    cu_htel= Request.Cookies("cu_htel")
   ' response.write  memid &"<br>"
   ' response.write  cu_nm_kor &"<br>"
   ' response.write  memkind &"<br>"
   ' response.write  memnum &"<br>"
    'response.write  cu_htel &"<br>"
%>
	
