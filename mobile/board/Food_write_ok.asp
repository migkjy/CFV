<!--#include virtual="/home/conf/config.asp"--> 
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<%
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    
    Server.ScriptTimeOut = 1000000
    Response.buffer = true

    Set UploadForm  = Server.CreateObject("DEXT.FileUpload") 
    PhysicalImgPath = Server.MapPath("/board/upload/after")	


    UploadForm.DefaultPath = PhysicalImgPath
    UploadForm.MaxFileLen  = 10 * 1024 * 1024 

     tbl  = "trip_after"  

    writer = UploadForm("writer")
    writer = check_html(writer) 
    
    title = UploadForm("title")
    title = check_html(title) 

    ir_1 = UploadForm("ir_1")
    ir_1 = Replace(ir_1 ,"'","''") 

    regIP = Request.ServerVariables("REMOTE_HOST")

    password    = UploadForm("password")
    captchacode = UploadForm("captchacode")

    regIP = Request.ServerVariables("REMOTE_HOST")

    file_nm = UploadForm("srcfile").FileName
    file_path = PhysicalImgPath

    arrTFile_Size =  UploadForm("srcfile").FileLen
    If (arrTFile_Size > UploadForm.MaxFileLen)  Then	
        With Response
            .write "<script type=""text/javascript"">"
            .write " alert('파일제한용량은 5MB 입니다.'); "
            .write " history.back(); "
            .write " </script>	 "
        End With
        uploadform.flush
        Response.End

    Else  
  
        p_file_nm  = UploadForm("srcfile").FileName
        If Len(p_file_nm) > 3 Then
            OldFileName  = Mid(p_file_nm, InstrRev(p_file_nm, "\") + 1)
            OldName = Mid(OldFileName, 1, Instr(OldFileName, ".") - 1)
            Ext = lcase(Mid(OldFileName, InstrRev(OldFileName, ".") + 1))
        
            File_MimeType = UploadForm("srcfile").MimeType

            If NOT( (Ext = "jpg") or (Ext = "gif") or (Ext = "jpeg")or (Ext = "png") )Then
                Response.write "<script type=""text/javascript"">"	
                Response.write "alert('이미지 파일외에는 등록하실수 없습니다.\n다시 업로드하세요.');"
                Response.write "history.back();"
                Response.write "</script>"
                uploadform.flush
                Response.End
            Else
                fileSize = uploadForm.FileLen
                fileName = setName()
                Set imageTool = Server.CreateObject("DEXT.ImageProc")
                If imageTool.SetSourceFile(uploadForm.TempFilePath) Then
                    imageWidth = CInt(imageTool.ImageWidth)
                    imageHeight = CInt(imageTool.imageHeight)
                    savedResult = uploadForm.SaveAs(savedPath & fileName & "." & uploadForm.FileExtension)
                    fileName = Mid(savedResult, InStrRev(savedResult, "\", -1) + 1, Len(savedResult) - InStrRev(savedResult, "\", -1) + 1)
                End If 
            End if
        End if

    End if
%>

<%
    If TestCaptcha("ASPCAPTCHA",captchacode) then 

        OpenF5_DB objConn

        SQL = "Select MAX(num) as m_bseq from  "&tbl  
        Set Rs=objConn.Execute(sql) 

        If isnull(Rs(0)) then
            num = 1
        Else
            num = rs(0) + 1
        End if
        CloseRs Rs

        sql="insert into "&tbl&" (num , user_id   ,  user_nm   ,    title     ,  con_tents  , img               ,img_w             , img_h                   ,pwd              , ref      ,ref_level , deep , hit ,del_yn ,ip)  "
        sql= sql& " values("&num&",   '"&memid&"', '"&writer&"','"&title&"','"&ir_1&"'   , '"&fileName&"',  '"&int(imageWidth)&"' ,'"&int(imageHeight)&"'  ,'"&password&"'  , "&num&" ,'0'       ,'0'   ,0   ,'N' ,'"&regIP&"') "
        objConn.Execute(sql)

        CloseF5_DB objConn
 %>
    <script type="text/javascript">
    <!--
        alert("맛집 게시판이 등록되었습니다.")
        location.href="food_list.asp" 
    //-->
    </script>
<% Else %>
    <script type="text/javascript">
    <!--
        alert("입력이 올바르지 않습니다. 다시 입력해주세요")
        history.back();
    //-->
	</script>
<% End  if %>

<%
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
 