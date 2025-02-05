<%
    Dim fileName   '파일명
    Dim filePath   '경로
    Dim fileRootPath  '루트패스
    Dim attachFile   '파일 전체경로
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