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
    
    
    sql =	" update TB_ba001 set "
    sql = sql & " cd = '"& cd &"'	"
    sql = sql & " ,	cd_nm = '"& cd_nm &"'	"
    sql = sql & " where cd_fg = '!!!!' "
    sql = sql &	" and cd = '"& cd_		&"' " 
    sql = sql &	" and cd_nm = '"& cd_nm_	&"' " 
    
    objConn.BeginTrans
    
    objConn.Execute(sql)
    

    sql =	" update TB_ba001 set "
    sql = sql & " cd_fg = '"& cd &"'	"
    sql = sql & " where cd_fg <> '!!!!' "
    sql = sql &	" and cd_fg = '"& cd_		&"' " 
    
    objConn.Execute(sql)
    
    
    If Err.number = 0 Then
    objConn.CommitTrans
%>

    <script language="javascript">
    <!--
        var obj			= parent.document.left_menu;
        var cd_			= obj.cd_.value;
        var cd_nm_	= obj.cd_nm_.value;
        var num_		= obj.num_.value;
        var count_	= obj.count_.value;
        var url			= 'base.asp';

        parent.location.reload();
        setTimeout("parent.fnChkBase('<%=cd%>','<%=cd_nm%>',num_,count_)", 400)
    //-->
    </script>
    
<%
    Else 
    objConn.RollbackTrans
%>

    <script language="javascript">
    <!--
        alert("수정중 오류가 발생했습니다.         ");
    //-->
    </script>
    
<%
    End If
    CloseF5_DB objConn
%>