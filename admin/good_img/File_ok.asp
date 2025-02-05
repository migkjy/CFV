<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

  OpenF5_DB objConn
  
    Set uploadform  = Server.CreateObject("DEXT.FileUpload")
    Set objImage = Server.CreateObject("DEXT.ImageProc")

    PhysicalImgPath = Server.MapPath("\board\upload")

    UploadForm.DefaultPath = PhysicalImgPath
    UploadForm.MaxFileLen = 4 * 1024 * 1024

    g_seq = Trim(UploadForm("g_seq"))
    p_seq = Trim(UploadForm("p_seq"))
    act_tp = Trim(UploadForm("act_tp"))
    tp = Ucase(Trim(UploadForm("tp")))

   
    PhysicalImgPath2 =PhysicalImgPath&"\"&"tck"

    re_mark   = UploadForm("re_mark")
        re_mark  = replace(re_mark, "'", "''")


    arrTFile_Size =  UploadForm("srcfile").FileLen
    If (arrTFile_Size > UploadForm.MaxFileLen)  Then	
        With Response
            .write "<script language='javascript'>"
            .write " alert('파일제한용량은 4MB 입니다..'); "
            .write " history.back(); "
            .write " </script>	 "
        End With
        uploadform.flush
        Response.End
        
    Else

        p_file_nm = UploadForm("srcfile").FileName
        if Len(p_file_nm) > 3 Then
        
            OldFileName  = Mid(p_file_nm, InstrRev(p_file_nm, "\") + 1)
            OldName = Mid(OldFileName, 1, Instr(OldFileName, ".") - 1)
            Ext = Lcase(Mid(OldFileName, Instr(OldFileName, ".") + 1))
        
            if NOT( (Ext = "jpg") or (Ext = "gif") or (Ext = "jpeg")or (Ext = "png") )Then
                Response.write "<script language=javascript>"	
                Response.write "alert('이미지 파일외에는 등록하실수 없습니다..\n다시 업로드하세요.');"
                Response.write "history.back();"
                Response.write "</script>"
                uploadform.flush
                Response.End
            else
                NewFileName = Replace(date,"-","")&right("0"&Hour(Now),2)&right("0"&Minute(Now),2)&right("0"&Second(Now),2)&"."&Ext
                ImageWidth  = UploadForm("srcfile").ImageWidth
                ImageHeight = UploadForm("srcfile").ImageHeight 
        
                real_file_path = PhysicalImgPath2&"\"&g_seq 
        
                real_filenm  = GetUniqueName( NewFileName ,real_file_path)
                real_filenm2 = Mid(real_filenm, InstrRev(real_filenm, "\") + 1)
        
                UploadForm("srcfile").SaveAs real_filenm, False
        
                thumb_name =Mid(real_filenm2, 1, Instr(real_filenm2, ".") - 1)
                thumb_name_mid =thumb_name&"_m"
        
                img_mid = makeThumbnail(real_file_path, NewFileName, thumb_name_mid, 600,400)
                img_mid_2 = Mid(img_mid, InstrRev(img_mid, "\") + 1)
            end if
            
        end if

    End if


    If act_tp ="I" then
      
        SQL = "Select MAX(p_seq) as m_bseq from ex_good_photo "
        Set Rs=objConn.Execute(sql)

        if isnull(Rs(0)) then
            m_num = 1
        else
            m_num = rs(0) + 1
        end if 
   
        Rs.close   : Set Rs = Nothing

        sql="insert into ex_good_photo (p_seq ,g_seq     , tp,  file_img  ,p_remark  , disp_seq )  "
        sql= sql& " values("&m_num&" ,"&g_seq&" ,'"&tp&"','"&img_mid_2&"','"&re_mark&"', 20 ) "

        objConn.Execute(sql)

    Else

        SQL = "Select file_img from ex_good_photo where p_seq="&p_seq
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql, objConn
     
        if Rs.eof then
            o_file_img= ""
            o_file_img_m= ""
        else
            o_file_img_m = Rs("file_img")
            o_file_img   = Replace(o_file_img_m,"_m","")
        end if

        if arrTFile_Size <> 0 then
            Call file_del(PhysicalImgPath2&"/"&g_seq&"/"&o_file_img_m)
            Call file_del(PhysicalImgPath2&"/"&g_seq&"/"&o_file_img)
        end if

        sql2 = "Update ex_good_photo set p_remark='" & re_mark & "' "
        if arrTFile_Size <> 0 then
            sql2 = sql2 &" , file_img='" & img_mid_2 & "' "
        end if
        
        sql2 = sql2 &" where p_seq="&p_seq
        objConn.Execute(sql2)

   End if

   objConn.close   : Set objConn = nothing

   Set UploadForm = Nothing
%>

<script type="text/javascript">
<!--
	location.href="file_ins.asp?tp=<%=tp%>&g_seq=<%=g_seq%>";
//-->		
</script>

<%
    Function GetUniqueName(byRef strFileName, DirectoryPath)

        Dim strName, strExt
        strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)
        strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)

        Dim Fso
        Set Fso = Server.CreateObject("Scripting.FileSystemObject")
        If Not Fso.FolderExists(DirectoryPath) then		'// 폴더가 없으면 생성
            Fso.CreateFolder(DirectoryPath)
        End If

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
  
        Set Fso = Nothing	
  
    End Function


    Function makeThumbnail(ByVal img_path, ByVal img_name, ByVal thumb_name, ByVal thumb_wsize, ByVal thumb_hsize)
    
        Dim thumb_path, thumb_image, objImage
        Set objImage    = Server.CreateObject("DEXT.ImageProc")
        objImage.Quality = 100

        If objImage.SetSourceFile(img_path &"\"& img_name) Then
            thumb_path = img_path &"\"& thumb_name &".jpg"
            thumb_image = objImage.SaveasThumbnail(thumb_path, thumb_wsize, thumb_hsize, true)
        End If
 
        makeThumbnail = thumb_image
        
    End Function


    Function file_del(fileDir)
    
        Set fso = Server.CreateObject("Scripting.FileSystemObject") 
        If fso.FileExists(fileDir) = True Then 
            fso.DeleteFile fileDir, True 
        End if 
        
    End Function
 %>
 