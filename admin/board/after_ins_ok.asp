<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/home/inc/bbs_imgsize.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    Server.ScriptTimeOut = 1000000
    Response.buffer = true

    Set UploadForm = Server.CreateObject("DEXT.FileUpload") 

    PhysicalImgPath = Server.MapPath("/board/upload/after")	
    UploadForm.DefaultPath = PhysicalImgPath
    UploadForm.MaxFileLen  = 5 * 1024 * 1024 

 
    tbl    = "trip_after"

    num    = UploadForm("num")

    gotopage = UploadForm("gotopage")
    s_cont   = UploadForm("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont     = UploadForm("cont")
    cont   = Replace(cont,"'","")

    writer   = UploadForm("writer")
    writer  = check_html(writer)

    title    = UploadForm("title")
    title   = check_html(title)

    ir_1     = UploadForm("ir_1")
    ir_1   = Replace(ir_1,"'","''")

    regIP    = Request.ServerVariables("REMOTE_HOST")


    file_nm   = UploadForm("srcfile").FileName
    file_path = PhysicalImgPath

    arrTFile_Size =  UploadForm("srcfile").FileLen
    If (arrTFile_Size > UploadForm.MaxFileLen)  Then	
        With Response
            .write "<script language='javascript'>"
            .write " alert('파일제한용량은 5MB 입니다..'); "
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
                Response.write "<script language=javascript>"	
                Response.write "alert('이미지 파일외에는 등록하실수 없습니다..\n다시 업로드하세요.');"
                Response.write "history.back();"
                Response.write "</script>"
                uploadform.flush
                Response.End
            Else
                NewFileName  = Replace(date,"-","") &right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)& "." & Ext
                nWidth  = UploadForm("srcfile").ImageWidth
                nHeight = UploadForm("srcfile").ImageHeight
                         
                real_filenm = GetUniqueName( NewFileName ,file_path)
                real_filenm2  = Mid(real_filenm, InstrRev(real_filenm, "\") + 1)
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
                         
                img_mid = makeThumbnail(file_path, NewFileName, thumb_name_mid, resizeWidth,resizeHeight)
                img_mid_2 = Mid(img_mid, InstrRev(img_mid, "\") + 1)
                img_nm = img_mid_2

            End If

            Call file_del(file_path&"/"&real_filenm2)

        Else
        	
            resizeWidth		= 0
            resizeHeight	= 0
       
        End if
        
    End if


    OpenF5_DB objConn

    If num ="" then

        msg="등록 되었습니다"

        SQL = "Select MAX(num) as m_bseq from  "&tbl
        Set Rs=objConn.Execute(sql)

        If isnull(Rs(0)) then
                n_num = 1
        Else
                n_num = rs(0) + 1
        End if

        CLOSERS RS

        num = n_num
        sql="insert into "&tbl&" (num , user_id , user_nm     ,  title      ,con_tents   , img              ,img_w            , img_h              ,ref     , ref_level, deep , pwd        , hit ,ip,agent_cd )  "
        sql= sql& " values("&n_num&",  N'"&emp_no&"', N'"&writer&"',N'"&title&"',N'"&ir_1&"'  , '"&img_nm&"' ,'"&int(resizeWidth)&"' ,'"&int(resizeHeight)&"'  ,"&n_num&" ,   0      , 0    , '"&emp_no&"', 0 ,'"&regIP&"' ,'9999') "

        objConn.Execute(sql)
        
        CloseF5_DB objConn

    Else
    	
        msg="수정 되었습니다"

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


        sql = "Update "&tbl&" Set user_nm=N'" & writer & "' , title=N'" & title & "' ,con_tents=N'" & ir_1 & "' "
        if arrTFile_Size >0 then
            sql = sql & " ,img= '"&img_nm&"'  "
            sql = sql & " ,img_w= '"&int(resizeWidth)&"'  "
            sql = sql & " ,img_h= '"&int(resizeHeight)&"'  "
        End if

        sql = sql &" where num="&num

        objConn.Execute(sql)

        CloseF5_DB objConn

    End if
%>

<script type="text/javascript">
<!--
    alert("<%=msg%>");
	location.href="after_view.asp?num=<%=num%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
//-->		
</script> 
