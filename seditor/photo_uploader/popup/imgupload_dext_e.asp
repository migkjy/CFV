<%@ LANGUAGE="VBSCRIPT" %>
<%

   Session.CodePage = 949
   Response.CharSet = "EUC-KR"

   Server.ScriptTimeOut = 7200

   DefaultPath    = Server.mappath("/") & "\board\upload"

   Set uploadform = Server.CreateObject("DEXT.FileUpload")
   uploadform.DefaultPath = DefaultPath
   uploadform.MaxFileLen = 10 * 1024 * 1024 

   arrTFile_Size =  UploadForm("Filedata").FileLen

   if arrTFile_Size >0 then
       
       If (arrTFile_Size > UploadForm.MaxFileLen)  Then	
	      With Response
         .write "<script language='javascript'>"
         .write " alert('�������ѿ뷮�� 10MB �Դϴ�..'); "
         .write " history.back(); "
         .write " </script>	 "
        End With
	      uploadform.flush
        Response.End
	     Else 
	     
	       p_file_nm  = UploadForm("Filedata").FileName
           If Len(p_file_nm) > 3 Then
			       OldFileName = Mid(p_file_nm, InstrRev(p_file_nm, "\") + 1)
			       OldName     = Mid(OldFileName, 1, Instr(OldFileName, ".") - 1)
			       Ext         = lcase(Mid(OldFileName, Instr(OldFileName, ".") + 1))


			       If NOT( (Ext = "jpg") or (Ext = "gif") or (Ext = "jpeg")or (Ext = "png") or (Ext = "bmp"))Then
			       	   Response.write "<script language=javascript>"	
		             Response.write "alert('�̹��� ���Ͽܿ��� ����ϽǼ� �����ϴ�..\n�ٽ� ���ε��ϼ���.');"
		             Response.write "self.close();"
		             Response.write "</script>"
                 uploadform.flush
                 Response.End

			       Else

		             NewFileName  = Replace(date,"-","") & "." & Ext
			           strWidth			= UploadForm("Filedata").ImageWidth
			           strHeight		= UploadForm("Filedata").ImageHeight 

                 real_filenm = GetUniqueName( NewFileName ,DefaultPath)
                 real_filenm2  = Mid(real_filenm, InstrRev(real_filenm, "\") + 1)

                 filepath = "/board/upload"&"/"&real_filenm2
			           UploadForm("Filedata").SaveAs real_filenm, False

			       End if	
 
			     End if
	     
	     End if

   Else

  	 Response.write "<script language=javascript>"	
     Response.write "alert('÷�������� ���ų� �̹��� ���Ͽܿ��� ����ϽǼ� �����ϴ�..\n�ٽ� ���ε��ϼ���.');"
     Response.write "self.close();"
     Response.write "</script>"
     Response.End
   End if
   
   
   if strWidth> 340 then
     img_width="style=width:340px;"	
   end if




%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<link href="../../css/style.css" rel="stylesheet" type="text/css">
</head>

<body  onload="pasteHTML('<%=filepath%>')" >

<script type="text/javascript">
<!--	
function pasteHTML(n){ 
  var sHTML = "<span style=\"color:#000000;\"><img src=\""+n+"\" <%=img_width%>></span>";
  opener.parent.oEditors.getById["ir_1"].exec("PASTE_HTML", [sHTML]); 
  self.close();

}
//-->
</script>


</body>
</html>


<%

Function GetUniqueName(byRef strFileName, DirectoryPath)

  Dim strName, strExt
    strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)
    strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)

  Dim fso
  Set fso = Server.CreateObject("Scripting.FileSystemObject")

  Dim bExist : bExist = True
  Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt 
  Dim countFileName : countFileName = 0 

  Do While bExist
   If (fso.FileExists(strFileWholePath)) Then
    countFileName = countFileName + 1
    strFileName = strName & "(" & countFileName & ")." & strExt
    strFileWholePath = DirectoryPath & "\" & strFileName
   Else
    bExist = False
   End If
  Loop
  GetUniqueName = strFileWholePath

 End Function
 
%>
