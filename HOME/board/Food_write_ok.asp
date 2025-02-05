<!--#include virtual="/home/conf/config.asp"--> 
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/bbs_imgsize.asp"-->

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

                    NewFileName  = Replace(date,"-","") &right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)& "." & Ext
                    nWidth  = UploadForm("srcfile").ImageWidth
                    nHeight = UploadForm("srcfile").ImageHeight 

                    
                    real_filenm = GetUniqueName( NewFileName ,file_path)
                    real_filenm2 = Mid(real_filenm, InstrRev(real_filenm, "\") + 1)
                    UploadForm("srcfile").SaveAs real_filenm, False


                    If nWidth > fixWidth or nHeight > fixHeight then
            	        
            	         thum_chk=True

                       If nWidth > nHeight Then
                           resizeWidth = fixWidth
                           resizeHeight = nHeight * fixWidth / nWidth
                           If resizeHeight > fixHeight Then
                               resizeWidth = fixHeight * nWidth / nHeight
                               resizeHeight = fixHeight
                           End If

                       Else 

                           resizeHeight = fixHeight
                           resizeWidth = nWidth * fixHeight / nHeight
                           If resizeWidth > fixWidth Then
                               resizeWidth = fixWidth
                               resizeHeight = fixWidth * nHeight / nWidth
                           End If

                       End If

                    Else
                       
                       resizeWidth  = nWidth
                       resizeHeight = nHeight
                       thum_chk=False

                    End If


                        thumb_name =Mid(real_filenm2, 1, Instr(real_filenm2, ".") - 1)
                        thumb_name_mid =thumb_name&"_m"
 
                        img_mid = makeThumbnail(file_path, real_filenm2, thumb_name_mid, resizeWidth,resizeHeight)
                        img_mid_2 = Mid(img_mid, InstrRev(img_mid, "\") + 1)
                        img_nm = img_mid_2 
 
                End If
                
                Call file_del(file_path&"/"&real_filenm2)


           Else
        	    resizeWidth  = 0
              resizeHeight = 0
        	
           End if


    End if




    if TestCaptcha("ASPCAPTCHA",captchacode) then 


    	  OpenF5_DB objConn

        SQL = "Select MAX(num) as m_bseq from  "&tbl  
        Set Rs=objConn.Execute(sql) 

        If isnull(Rs(0)) then
            num = 1
        Else
            num = rs(0) + 1
        End if
        CloseRs Rs

        sql="insert into "&tbl&" (num , user_id   ,  user_nm   ,    title     ,  con_tents  , img               ,img_w             , img_h                   ,pwd              , ref      ,ref_level , deep , hit ,del_yn ,ip,agent_cd)  "
        sql= sql& " values("&num&",   '"&memid&"', N'"&writer&"',N'"&title&"',N'"&ir_1&"'   , '"&img_nm&"',  '"&int(resizeWidth)&"' ,'"&int(resizeHeight)&"'  ,'"&password&"'  , "&num&" ,'0'       ,'0'   ,0   ,'N' ,'"&regIP&"','9999') "
        objConn.Execute(sql)

        CloseF5_DB objConn


 %>
    <script type="text/javascript">
    <!--
        alert("정상적으로 등록되었습니다.")
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
 