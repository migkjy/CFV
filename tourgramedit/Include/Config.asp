<!-- METADATA TYPE="typelib" NAME="ADODB Type Library" UUID="00000205-0000-0010-8000-00AA006D2EA4"-->
<!--#include file="../Include/CommonFunc.asp"-->
<%
	With Response
		.Expires = -1
		.ExpiresAbsolute = Now() - 1
		.AddHeader "pragma", "no-cache"
		.CacheControl = "no-cache"
		.Buffer = true
	End With



    
    '공용변수
    Dim db, rs, cmd

	Sub dbOpen()
	    Set db = Server.CreateObject("ADODB.Connection")
	    db.Open "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=cfcation;Password=dragon64^^;Initial Catalog=dbcfcation;Data Source=db.cfcation.gabia.io,1433"
	End Sub

	Sub dbClose()
		db.Close
		Set db = Nothing
	End Sub
%>