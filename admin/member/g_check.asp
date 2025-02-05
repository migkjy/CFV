<!--#include file="../conf/config.asp"-->


<%
OpenF5_DB objConn '데이타베이스 오픈

Dim sql, rs, cnt, g_check, seq


num = Request("num")
idx_v= Request("idx_v")

idx_v= UCASE(idx_v)



    Sql = "UPDATE TB_member SET room_group = '"&idx_v&"' WHERE num = "&num 
    objConn.Execute(sql)
'response.write sql

          '  response.write "<script language='javascript'> "
        '    response.write "    alert('"&idx_v&" 로 배정되었습니다.');"
        '    response.write "</script> " 
        '    response.end
            
'CloseF5_DB objConn '데이타베이스 클로즈
%>
<script>
    // 부모 창을 새로고침
    if (window.parent && window.parent !== window) {
        window.parent.location.reload();
    }
</script>