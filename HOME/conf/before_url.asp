<%

'현재페이지경로설정

if Request.Cookies("history_url") = "" then
	Response.Cookies("before_url")= "https://www.cfvacation.com/"
elseif Request.Cookies("history_url") = "/home/member/Ok_member.asp" then
	Response.Cookies("before_url")= "https://www.cfvacation.com/"
elseif Request.Cookies("history_url") = "/home/member/index.asp?ts=search_pass" then
	Response.Cookies("before_url")= "https://www.cfvacation.com"
elseif Request.Cookies("history_url") = "/home/member/index.asp?ts=search_id" then
	Response.Cookies("before_url")= "https://www.cfvacation.com"	
else
	Response.Cookies("before_url")= Request.Cookies("history_url")
end if

current_url=request.servervariables("URL")
current_qvalue = request.servervariables("Query_String")

'response.write  Request.Cookies("history_url") &"<br>"
'response.write  Request.Cookies("before_url") &"<br>"
'response.write  current_url &"<br>"
'response.write  current_qvalue &"<br>"
if current_url="/" then
Response.Cookies("history_url") = current_url 
else
Response.Cookies("history_url") = current_url & "?" & current_qvalue
end if

%>
