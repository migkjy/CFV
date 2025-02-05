<% @LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>

<%
    Response.Buffer = False 
    dim filepath, file_path1
    dim fso
	filepath  = "D:\hosting\cfvacation.com\upload\goods\"& request("filename")
	

	Set FSO=CreateObject("Scripting.FilesystemObject")
	if (fso.FileExists(filepath)) then
		fso.DeleteFile(filepath)
			img_url = "https://www.cfvacation.com/upload/goods/"& request("filename")
        response.write "1|" & img_url
      
    else
        response.write "0|delete file error..."
	end if
	set fso = nothing
	
	
%>

