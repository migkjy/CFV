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
  
  
    tbl = "ex_good_photo"
   
    p_seq = request("p_seq")
    g_seq = request("g_seq")
    tp = request("tp")

    sql = "Select  p_seq, g_seq, file_img from ex_good_photo where p_seq="&p_seq
    Set Rs=objConn.Execute(sql)
    If rs.eof then
    Else
        g_seq = Rs("g_seq")
        file_img = Rs("file_img")
        file_img2 = Replace(file_img,"_m","")
    End If

    Rs.close   : Set Rs = Nothing


    PhysicalImgPath = Server.MapPath("\board\upload\")
    select case tp
        case "T" : PhysicalImgPath2 =PhysicalImgPath&"\"&"ticket"
        case "H" : PhysicalImgPath2 =PhysicalImgPath&"\"&"hotel"
    End select

    r_file_path =PhysicalImgPath2&"\"&g_seq
   
    Call file_del(r_file_path&"/"&file_img)
    Call file_del(r_file_path&"/"&file_img2)

 
    sql2 ="delete from ex_good_photo where p_seq="&p_seq
    objConn.Execute sql2

    objConn.close   : Set objConn = nothing
%>

<script type="text/javascript">
<!--
    alert("삭제되었습니다.");
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
        End If 
        
    End Function
 %>
 