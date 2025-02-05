<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    num      = Request("num")
    tp 	     = Request("tp")
    g_kind   = Request("g_kind")

    Select Case tp
        Case "af" 
            tbl      = "trip_after"
            re_page  ="after_ins.asp"
        Case "gu" 
            tbl      = "trip_guide"
            re_page  ="guide_ins.asp"
    End Select


    OpenF5_DB objConn

    sql = " select img from "&tbl&"  where num="&num
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    
    Rs.open sql,objConn,3
    If rs.eof Then
       img_file = ""
    Else
       img_file = Rs("img")
    End if

    Rs.close : Set Rs=nothing


    if tp="af" then
  	    filePath = Server.MapPath("/board/upload/after")&"\"&img_file	 
    Elseif tp="gu" then
  	    filePath = Server.MapPath("/board/upload/guide")&"\"&img_file	 
    End if

    	mkk = DeleteExistFile(filePath)

 
    sql = "update "&tbl&" Set img =NULL  , img_w =0, img_h=0   where num = "&num
    objConn.Execute Sql

    CloseF5_DB objConn


    Function DeleteExistFile(filePath) 
        Dim fso, result 
        Set fso = CreateObject("Scripting.FileSystemObject") 
        If fso.FileExists(filePath) Then 
            fso.DeleteFile(filePath) '파일이 존재하면 삭제합니다. 
            result = 1 
        Else 
            result = 0 
        End If 
        DeleteExistFile = result 
    End Function 
%>

<script type="text/javascript">
<!--
    alert("삭제 처리되었습니다.");
    location.href = "<%=re_page%>?num=<%=num%>&g_kind=<%=g_kind%>";
//-->
</script>