<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->

<%
    OpenF5_DB objConn

    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    Dim sql, rs, cnt, g_check, knum

    cu_hp = Request("cu_hp")
 
    sql_u = "UPDATE TB_sel_memo SET app_gubn='1'"
    sql_u = sql_u & " where cu_hp='" & cu_hp&"' and send_hp='"&cu_htel&"'"
    ' RESPONSE.WRITE  sql_u
    ' response.end
    objConn.Execute(sql_u)
            
    sql = "UPDATE TB_sel_memo SET app_gubn='4',del_yn='Y'"
    sql = sql & " where app_gubn='0' and send_hp='" & cu_htel&"'"
    objConn.Execute(sql)
    ' RESPONSE.WRITE  sql
       
    objConn.close
    Set objConn = nothing
%>

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<script type="text/javascript">
<!--
   alert('룸메이트 매칭이 확정되었습니다. 마이페이지에서 확인하세요');
   parent.location.reload();
   parent.$('#chain_maching').dialog('close');
//-->
</script>

