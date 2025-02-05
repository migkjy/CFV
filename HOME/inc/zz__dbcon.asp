
<%

Dim objConn
Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Provider = "SQLOLEDB"
	objConn.ConnectionString = "data source=db.nausicaa.gabia.io;user id=nausicaa;password=tourgram5298@;initial catalog=dbnausicaa"
	objConn.open
	


%>
