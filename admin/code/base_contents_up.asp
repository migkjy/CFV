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
    cd_nm = Replace(cd_nm,"&","&amp;")
    cd_nm = Replace(cd_nm,"'","''")
    
    del_fg = Request("del_fg")
    remark = Request("remark")
    remark = Replace(remark,"&","&amp;")
    remark = Replace(remark,"'","''")
    
    char_fr = Request("char_fr")
    char_to = Request("char_to")
    
    num = Request("num")
    count = Request("count")
    
    cd_fg = Request("cd_fg")
    cd_ = Request("cd_")
    cd_nm_ = Request("cd_nm_")
    
    
    
    sql =	" update TB_ba001 set "
    sql = sql & " cd = '"& cd &"'	"
    sql = sql & " ,	cd_nm = '"& cd_nm &"'	"
    sql = sql & " ,	del_fg	= '"& del_fg &"'	"
    sql = sql & " ,	remark	= '"& remark &"'	"
    sql = sql & " ,	char_fr	= '"& char_fr &"'	"
    sql = sql & " ,	char_to	= '"& char_to &"'	"
    sql = sql & " where cd_fg = '"& cd_fg &"' "
    sql = sql &	" and cd = '"& cd_		&"' " 
    sql = sql &	" and cd_nm = '"& cd_nm_	&"' " 
    
    
    objConn.BeginTrans'//트랜잭션
    
    objConn.Execute(sql)
    
    
    If Err.number = 0 Then
	objConn.CommitTrans
%>

    <script language="javascript">
    <!--
        var num		= parent.document.getElementById('con_num').value;
        var count	= parent.document.getElementById('con_count').value;
        parent.location.reload();
        setTimeout("parent.fnChkBaseContents('<%=cd_%>', '<%=cd_nm_%>', '<%=del_fg%>', '<%=remark%>','<%=char_fr%>','<%=char_to%>',num,count)",400);

    //-->
    </script> 
    
<%
    Else 
    objConn.RollbackTrans
%>

    <script language="javascript">
    <!--
        alert("수정중 오류가 발생했습니다.");
    //-->
    </script> 
    
<%
    End If
    CloseF5_DB objConn
%>