<%
    Dim fileName   '���ϸ�
    Dim filePath   '���
    Dim fileRootPath  '��Ʈ�н�
    Dim attachFile   '���� ��ü���
    Dim fso    'FileSystemObject
    Dim objStream   'ADODB.Stream Object
    
    
    fileName ="member_sample.xls"
    filePath ="upload\res_excel"
    fileRootPath = Server.MapPath("\")
    
    attachFile = fileRootPath & "\" & filePath
        If filePath <> "" Then
            attachFile = attachFile & "\" & fileName
        Else
            attachFile = attachFile & fileName
        End If
    

    Set fso = CreateObject("Scripting.FileSystemObject")
        Response.Clear
        Response.ContentType = "application/unknown"
        Response.AddHeader "Pragma", "no-cache"
        Response.AddHeader "Expires", "0"
        Response.AddHeader "Content-Transfer-Encoding", "binary"
        Response.AddHeader "Content-Disposition","attachment; filename = " & fileName 
    
    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    
    objStream.Type = 1 
    objStream.LoadFromFile attachFile 
    
        Response.BinaryWrite objStream.Read
        Response.Flush
    
    objStream.Close : Set objStream = nothing
    
    Set fso = nothing
%>