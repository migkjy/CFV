<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

      OpenF5_DB objConn 
      
    On Error Resume Next
  
    Dim step, cd_type

    idx  = Trim(Request("idx"))


    objConn.BeginTrans

    'sql ="update res_dat set del_yn='Y' where idx="&idx
    sql ="delete from res_dat where idx="&idx
    objConn.Execute(sql)

    If Err.Number <> 0 then
        objConn.RollbackTrans
        response.write Err.Number
    Else
        objConn.CommitTrans
        objConn.close : Set objConn = nothing
        response.write "0"
    End if
%>
 
