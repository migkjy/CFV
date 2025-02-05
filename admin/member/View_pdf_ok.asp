<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    'Session.codepage=65001
    Response.CharSet = "utf-8" 
    'Response.CharSet = "euc-kr" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    
    ProgID = request.QueryString("ProgressID")
    tot_hp = Trim(Request("tot_hp"))
    
    OpenF5_DB objConn   
    set uploadform=server.CreateObject("DEXT.FileUpload")
    
    uploadform.SetProgress(ProgID)
    filePath ="upload\acc_excel"
    fileRootPath = Server.MapPath("\")
    PhysicalImgPath = fileRootPath & "\" & filePath
    
    UploadForm.DefaultPath = PhysicalImgPath
    
    
    OldFileName = uploadform("file").FileName
    Ext = lcase(Mid(OldFileName, Instr(OldFileName, ".") + 1))

    '##파일확장자채크##
   
    If NOT( (Ext = "xlsx") or (Ext = "xls") or (Ext = "docx")or (Ext = "pdf") or (Ext = "hwp"))Then
        uploadform.DeleteAllSavedFiles	
        Response.write "<script type=""text/javascript"">"	
        Response.write "alert('XLSX,XLS,DOCX,HWP,PDF 파일외에는 등록하실수 없습니다.\n다시 업로드하세요.');"
        Response.write "history.back();"
        Response.write "</script>"
        uploadform.flush
        Response.End
    End If

    '##파일용량채크##
    arrTFile_Size =  uploadform("file").FileLen     
    If (arrTFile_Size > (1*1024*1024)) Then	
        Response.write "<script type=""text/javascript"">"	
        Response.write "alert('전체 파일크기를 1MB 미만으로 다시 올려주시기 바랍니다');"
        Response.write "history.back();"
        Response.write "</script>"
        uploadform.flush
        Response.End
    End If			

    unqname= right(now,8)
    unqname=trim(Replace(unqname,":",""))
    
    NewFileName = Replace(date,"-","") &right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)&tot_hp & "." & Ext
 
    unqProgID= unqname&"_"&ProgID
 
 	SaveFullPath = PhysicalImgPath  &"\"& NewFileName	
 	uploadform("file").SaveAs SaveFullPath, true
 	FileName= uploadform("file").LastSavedFileName 

   'FileName=right("0"&minute(now),2)&right("0"&second(now),2)&FileName
 	sql = "UPDATE TB_member SET  air_pdf_yn='1',air_FileName='"&FileName&"'"
 	sql = sql & " where htel='" & tot_hp&"'"
 	objConn.Execute(sql)

    Set uploadform =nothing
    Session.CodePage = old_codepage
%>


<script language="javascript">
<!--
    alert("첨부파일이 업로드 되었습니다. ");
    parent.location.reload();
    parent.$('#chain_evoa_pop').dialog('close');
//-->
</script> 
