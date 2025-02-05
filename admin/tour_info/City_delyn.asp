<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    OpenF5_DB objConn
    Dim sql, rs, del_yn, city_cd
    city_cd  = Trim(Request("city_cd"))

    Sql = "SELECT del_yn FROM TB_ti200 WHERE city_cd = '"&city_cd&"'"
    Set Rs = objConn.Execute(Sql)

    if Rs("del_yn") = "N" then
        del_yn = "Y"
    else
        del_yn = "N"
    end if

    Sql = "UPDATE TB_ti200 SET del_yn = '"&del_yn&"' WHERE city_cd = '"&city_cd&"'"
    objConn.Execute sql

    CloseRs Rs
    CloseF5_DB objConn
%> 
