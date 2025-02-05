<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Dim sql, rs, del_yn, nat_cd
    nat_cd = Request("nat_cd")

    OpenF5_DB objConn

    Sql = "SELECT del_yn FROM TB_ti100 WHERE nat_cd = '"&nat_cd&"'"
    Set Rs = objConn.Execute(Sql)

    if Rs("del_yn") = "N" then
        del_yn = "Y"
    else
        del_yn = "N"
    end if

    Sql = "UPDATE TB_ti100 SET del_yn = '"&del_yn&"' WHERE nat_cd = '"&nat_cd&"'"
    objConn.Execute sql

    CloseF5_DB objConn
%>
 
