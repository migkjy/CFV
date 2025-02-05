<%@ Language="VBScript" CodePage="65001" %>
<% Option Explicit %>
<!--#include file="../Include/Config.asp"-->
<%
    Dim uploadForm, imageTool, savedPath, temp
    Dim resizeOK, savedResult, fileName, fileSize, imageWidth, imageHeight,num
 
    Set uploadForm = Server.CreateObject("DEXT.FileUpload")

    uploadForm.DefaultPath = Server.MapPath("\") & "\tourgramedit\Data\"
    uploadForm.MaxFileLen = 2 * 1024 * 1024 '(2M)
   
   
  ' if UploadForm.FileLen > UploadForm.MaxFileLen then
	  '    With Response
     '    .write "<script language='javascript'>"
     '    .write " alert('파일제한용량은 2M 입니다..'); "
     '    .write " self.close();"
     '    .write " </script>	 "
     '   End With
	  '    uploadform.flush
     '   Response.End
 '  else
    savedPath = Server.MapPath("\") & "\tourgramedit\Data\GoodsImageBox\"
num							= UploadForm("num")
'end if

    Call dbOpen()

    If uploadForm.IsImageItem Then
        fileSize = uploadForm.FileLen
        fileName = setName()

        Set imageTool = Server.CreateObject("DEXT.ImageProc")
        
        If imageTool.SetSourceFile(uploadForm.TempFilePath) Then
        
            imageWidth = CInt(imageTool.ImageWidth)
            imageHeight = CInt(imageTool.imageHeight)
                savedResult = uploadForm.SaveAs(savedPath & fileName & "." & uploadForm.FileExtension)
               fileName = Mid(savedResult, InStrRev(savedResult, "\", -1) + 1, Len(savedResult) - InStrRev(savedResult, "\", -1) + 1)
       
        End If

       

        Set cmd = Server.CreateObject("ADODB.Command")

        With cmd
            .ActiveConnection = db
            .CommandText = "[dbo].[usp_EWGoodsImageBox_InsertInfo]"
            .CommandType = adCmdStoredProc

            .Parameters.Append .CreateParameter("FileName", adVarChar, adParamInput, 255, fileName)
            .Parameters.Append .CreateParameter("FileSize", adInteger, adParamInput,, fileSize)
            .Parameters.Append .CreateParameter("Width", adSmallInt, adParamInput,, imageWidth)
            .Parameters.Append .CreateParameter("Height", adSmallInt, adParamInput,, imageHeight)
            .Parameters.Append .CreateParameter("SessionID", adVarChar, adParamInput, 30, num)

            .Execute,,adExecuteNoRecords
        End With

        Set cmd = Nothing

        Response.Write("1")
    Else
        Response.Write("3")
    End IF

    Set uploadForm = Nothing

    Call dbClose()


	Public Function setName()
	'------------------------------------------
	' 저장할 파일명 설정
	'------------------------------------------
		Dim serialNo

		Randomize

		'1 ~ 9999 까지중 임의수 가져오기
		'-------------------------------
		serialNo = Int((9999 - 1 + 1) * Rnd + 1)
		'-------------------------------

		setName = Year(Now()) & Month(Now()) & Day(Now()) & Hour(Now()) & Minute(Now()) & Second(Now()) & serialNo
	End Function
%>