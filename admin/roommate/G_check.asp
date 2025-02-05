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

    knum = Request("knum")
 
    
            
    sql = "UPDATE TB_sel_memo SET app_gubn='4',del_yn='Y'"
    sql = sql & " where num='" & knum&"'"
    objConn.Execute(sql)
    ' RESPONSE.WRITE  sql
       
    objConn.close
    Set objConn = nothing
%>


<script type="text/javascript">
<!--
   alert('룸메이트 매칭이 취소되었습니다.');
   parent.location.reload();

//-->
</script>

