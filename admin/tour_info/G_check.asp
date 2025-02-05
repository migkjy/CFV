<!--#include virtual="/admin/conf/config.asp"-->


<%
    OpenF5_DB objConn
    
    Dim sql, rs, cnt, g_check, seq,city_cd
    
    seq = Request("seq")
    gtp = lcase(Request("gtp"))
    idx_v= Request("idx_v")
    city_cd  = Trim(Request("city_cd"))
    
    If gtp="g" then
        Sql = "SELECT g_check FROM TB_ti310 WHERE seq = "&seq
        set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
    
        if trim(Rs("g_check")) = "1" then
            g_check = "0"
        else
            g_check = "1"
        end if
    
        Sql = "UPDATE TB_Ti310 SET g_check = '"&g_check&"' WHERE seq = "&seq 
        objConn.Execute(sql)
    
    
    Elseif gtp="i" then
    
        Sql = "SELECT idx FROM TB_Ti310 WHERE seq = "&seq
        set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
    
        if trim(Rs("idx")) = "" then
            r_idx = "0"
        else
            r_idx = Rs("idx")
        end if
    
        Sql = "UPDATE TB_Ti310 SET idx = '"&idx_v&"' WHERE seq = "&seq 
        objConn.Execute(sql)
    
    
    Elseif gtp="c" then
    
        Sql = "SELECT disp_grade FROM TB_Ti200 WHERE city_cd = '"&city_cd&"'"
        set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
    
        if trim(Rs("disp_grade")) = "" then
            disp_grade = "0"
        else
            disp_grade = Rs("disp_grade")
        end if
    
        Sql = "UPDATE TB_Ti200 SET disp_grade = '"&idx_v&"' WHERE city_cd = '"&city_cd&"'"
        objConn.Execute(sql)    
    
    End if
    CloseF5_DB objConn
%>
 