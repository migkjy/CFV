<!--#include virtual="/home/conf/config.asp"--> 
<!--include virtual="/admin/inc/dbcon.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    'Response.CharSet = "euc-kr" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    OpenF5_DB objConn
      
    tot_hp = Trim(Request("tot_hp"))

    sql = "UPDATE TB_member SET  pdf_yn='0'"
    	sql = sql & " where htel='"& tot_hp&"'"
    objConn.Execute(sql) 
%>

<script language="javascript">
<!--
    alert("첨부파일이 삭제 되었습니다. ");
    parent.location.reload();
    parent.$('#chain_evoa_pop').dialog('close');
//-->
</script> 
