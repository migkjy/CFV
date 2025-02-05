<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    Response.AddHeader	"Expires","0"


    OpenF5_DB objConn

    value = Request("value")

    cd_value = Split(value,"@@")

    objConn.BeginTrans

    num = 0
    For i=0 to Ubound(cd_value)
	    cd_insert	=	Split(cd_value(i),"||")
	
	    If UBound(cd_insert)=1 Then 
		    cd = cd_insert(0)
		    cd_nm = cd_insert(1)

		    sql = "	select cd_fg	"
		    sql = sql & " from TB_ba001	"
		    sql = sql & " where cd_fg = '!!!!' "
		    sql = sql & " and cd = '"& cd &"' "

		    Set Rs = objConn.Execute(sql)
		
		    If Not Rs.Eof Then 
		    objConn.RollbackTrans
%>
		        <script language="javascript">
		        <!--
		            var obj = parent.document.left_menu;
		            var cd_ = obj.cd_.value;
		            var cd_nm_ = obj.cd_nm_.value;
		            var num_ = obj.num_.value;
		            var count_	= obj.count_.value;
		            var url = 'base.asp';
            
		            alert('중복코드를 입력하셨습니다.\n확인후 다시 입력해 주세요.');
		        	//-->
		        </script>
<%
		        Response.End

		    End If
		    Rs.Close : Set Rs = Nothing

		    sql = "	insert into TB_ba001(cd_fg,	cd,					cd_nm,		num_fr, num_to, del_fg, update_yn)  "
		    sql = sql & " values('!!!!','"& cd &"', '"& cd_nm &"',	 4,			0,			'N',			'N')"

		    objConn.Execute(sql)
		    
	    End if
    Next


    If Err.number = 0 Then
	objConn.CommitTrans
%>

    <script language="javascript">
    <!--
        var obj = parent.document.left_menu;
        var cd_ = obj.cd_.value;
        var cd_nm_ = obj.cd_nm_.value;
        var num_ = obj.num_.value;
        var count_	= obj.count_.value;
        var url = 'base.asp';

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
        alert("등록중 오류가 발생했습니다.");
    //-->
    </script> 
    
<%
    End If
    CloseF5_DB objConn
%>