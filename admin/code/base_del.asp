<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    Response.AddHeader	"Expires","0"

    
    OpenF5_DB objConn

    cd = Request("cd")
    cd_nm = Request("cd_nm")
    cd_ = Request("cd_")
    cd_nm_ = Request("cd_nm_")
    
    
    sql =	" delete TB_ba001 "
    sql = sql &	" where cd_fg = '"& cd_		&"' " 
    objConn.BeginTrans
    
    objConn.Execute(sql)
    
    sql =	" delete TB_ba001 "
    sql = sql & " where cd_fg = '!!!!' "
    sql = sql &	" and cd = '"& cd_		&"' " 
    sql = sql &	" and cd_nm = '"& cd_nm_	&"' " 


    objConn.Execute(sql)
        
    If Err.number = 0 Then
	objConn.CommitTrans
%>

    <script language="javascript">
    <!--
        parent.location.reload();
    //-->
    </script>
    
<%
    Else 
    objConn.RollbackTrans
%>

    <script language="javascript">
    <!--
        alert("삭제중 오류가 발생했습니다.         ");
    //-->
    </script>
    
<%
    End If
    CloseF5_DB objConn
%>