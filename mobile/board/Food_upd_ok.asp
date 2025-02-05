<!--#include virtual="/home/conf/config.asp"-->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    
    Server.ScriptTimeOut = 1000000
    Response.buffer = true

    Set UploadForm  = Server.CreateObject("DEXT.FileUpload") 
    PhysicalImgPath = Server.MapPath("/board/upload/after")	


    UploadForm.DefaultPath = PhysicalImgPath
    UploadForm.MaxFileLen  = 5 * 1024 * 1024 

    tbl  = "trip_after"  

    num = UploadForm("num")
    If num="" or isnull(num) then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자오류입니다'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.end
    End if

    gotopage = UploadForm("gotopage")

    s_cont = UploadForm("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = UploadForm("cont")
    cont = Replace(cont,"'","")

    writer = UploadForm("writer")
    writer = check_html(writer) 
   
    title = UploadForm("title")
    title = check_html(title) 

    ir_1 = UploadForm("ir_1")
    ir_1 = Replace(ir_1 ,"'","''") 

    pwd = UploadForm("password")
   
    regIP = Request.ServerVariables("REMOTE_HOST")

    password = UploadForm("password")
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


    OpenF5_DB objConn
   
    If arrTFile_Size>0 then
        sql="select num ,img  from "&tbl&" where num="&num
        Set Rs = objConn.Execute(sql)

        If Rs.eof or Rs.bof then
        Else
            del_img = Rs("img")
        End if
            
        If del_img <> "" then
            Call file_del(file_path&"/"&del_img)
        End if

    End if
    
    
    sql = "Update "&tbl&" Set user_nm='" & writer & "', title='" & title & "', con_tents='" & ir_1 & "' "
    If arrTFile_Size>0 then
        sql = sql & " ,img= '"&fileName&"'  "
        sql = sql & " ,img_w= '"&int(imageWidth)&"'  "
        sql = sql & " ,img_h= '"&int(imageHeight)&"'  "
    End if
    sql = sql &" where num="&num

    objConn.Execute(sql)
   
    CloseF5_DB objConn

    Set UploadForm = Nothing
%>
 
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

<script type="text/javascript">
<!--
    alert("맛집 게시판이 수정 되었습니다.");
    location.href="food_view.asp?num=<%=num%>&gotopage=<%=gotopage%>";
//-->		
</script>