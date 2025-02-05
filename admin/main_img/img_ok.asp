<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    Server.ScriptTimeOut = 1000000
    Response.buffer = true

    Set UploadForm  = Server.CreateObject("DEXT.FileUpload")
    PhysicalImgPath = Server.MapPath("/board/upload/main_img")
    
    UploadForm.DefaultPath = PhysicalImgPath
    UploadForm.MaxFileLen  = 5 * 1024 * 1024 
    
    num      = UploadForm("num")
    g_kind   = UploadForm("g_kind")
    
    
    h_url    = UploadForm("h_url")
    h_url    = Replace(h_url,"'","")
    
    m_url    = UploadForm("m_url")
    m_url    = Replace(m_url,"'","")
    
    
    file_nm  = UploadForm("srcfile").FileName
    
    use_yn    = UploadForm("use_yn")
    if use_yn="" or isnull(use_yn) then
        use_yn="Y"
    End if
    
    nat_nm   = UploadForm("nat_nm")
    nat_nm  = Replace(nat_nm, "'", "''")
    
    nat_cd   = UploadForm("nat_cd")
    
    memo     = UploadForm("memo")
    memo     = Replace(memo,"'","")
    
    
    m_title    = UploadForm("m_title")
    m_title     = Replace(m_title,chr(34),"&#34")
    m_title     = Replace(m_title,"'","")
      
    title    = UploadForm("title")
    title     = Replace(title,chr(34),"&#34")
    title     = Replace(title,"'","")
    
    
    remark  = UploadForm("remark")
    remark    = Replace(remark,"'","")
    
    r_color  = UploadForm("r_color")
    r_color    = Replace(r_color,"'","")
    r_align  = UploadForm("r_align")
    
    
    '###############################################################################################
    file_path = PhysicalImgPath
    
    file_cnt =uploadform("srcfile").Count
    
    Dim FileName(2) ,n_filenm(2)
    
    For i = 1 To file_cnt
        FileName(i)   = uploadform("srcfile")(i).FileName
        arrTFile_Size = uploadform("srcfile")(i).FileLen
     
        If FileName(i) ="" then
            n_filenm(i)= ""
            
        Else
        
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
            	
                If arrTFile_Size > 0 Then
                    o_full_Name = Mid(FileName(i), InstrRev(FileName(i), "\") + 1)
                    o_fil_Name  = Mid(o_full_Name, 1, InstrRev(o_full_Name, ".") - 1)
                    o_fil_Ext   = Ucase(Mid(o_full_Name, InstrRev(o_full_Name, ".") + 1))
    
                    if Chk_Image(o_fil_Ext) then
                        New_File  = Replace(date,"-","") & "." &o_fil_Ext
    
                        real_filenm   = GetUniqueName( New_File ,file_path)
                        real_filenm2  = Mid(real_filenm, InstrRev(real_filenm, "\") + 1)
    
                        UploadForm("srcfile")(i).SaveAs real_filenm, False
                        n_filenm(i)= real_filenm2
                    else
                        With Response
                            .write "<script language='javascript'>"
                            .write " alert('JPG,JPEG,PNG,GIF,BMP 파일만 가능합니다....'); "
                            .write " history.back();"
                            .write " </script>	 "
                        End With
                        uploadform.flush
                        Response.End
                    end if
                End if
    
            End if
          
        End if
    
    Next 
    
    
    OpenF5_DB objConn
    
    sql = "Update  main_new_img  set use_yn='"&use_yn&"'  ,i_url='" & h_url & "'   "
    If n_filenm(1) <> "" then
        sql = sql & " ,i_img= '"&n_filenm(1)&"'  "
    End if
    
    sql = sql &" , title=N'" & title & "' ,remark=N'" & remark & "' ,i_color='" & r_color & "', i_align='" & r_align & "'"  
    sql = sql &" where num="&num&"   "
    
    objConn.Execute(sql)
    objConn.close : set objConn = nothing
    
    Set UploadForm = Nothing
%>

<script language="javascript">
<!--
   alert("수정 처리 되었습니다.");
   parent.location.reload();
//-->
</script>


<%
    Function Chk_Image(sType)
        '------------------------------------------
        ' 이미지파일형식 검사
        '------------------------------------------
        Dim sAllow, Chk_OK, intLoop

        Chk_OK = False
        sAllow = Split("JPG|JPEG|PNG|GIF|BMP","|")

        For intLoop = 0 To UBound(sAllow)
            If sType = sAllow(intLoop) Then
                Chk_OK = True
                Exit For
            End If
        Next

        Chk_Image = Chk_OK

    End Function
%>