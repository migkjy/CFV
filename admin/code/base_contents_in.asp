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
    cd_fg = UCase(Trim(Request("cd_fg")))
    
    cd_value = Split(value,"@@")
    
    
    objConn.BeginTrans'//트랜잭션
    
    For i=0 to Ubound(cd_value)
        cd_insert2	=	Split(cd_value(i),"||")
    	
        If UBound(cd_insert2)=4 Then 
    		    cd = cd_insert2(0)
    		    cd_nm = cd_insert2(1)
    		    cd_nm = Replace(cd_nm,"'","''")
    		    cd_nm = Replace(cd_nm,"&","&amp;")
    		    cd_remark = Replace(cd_insert2(2),"'","''")
    		    cd_remark = Replace(cd_insert2(2),"&","&amp;")
    		    cd_char_fr	= Trim(cd_insert2(3))
    		    cd_char_to = Trim(cd_insert2(4))
            
            
    		    sql = " select cd_fg	"
    		    sql = sql & " from TB_ba001	"
    		    sql = sql & " where cd_fg = '"& cd_fg &"' "
    		    sql = sql & " and cd = '"& cd &"' "
    		    sql = sql & " and del_fg	= 'N' "
            
    		    Set Rs = objConn.Execute(sql)
    		    
    		    If Not Rs.Eof Then 
    		    	objConn.RollbackTrans
%>
			    <script language="javascript">
			    <!--
			        alert('중복코드를 입력하셨습니다.\n확인후 다시 입력해 주세요.');
			        //parent.fnChkBaseContentsList();
			        //setTimeout("parent.fnChkBaseContentsList()",400);
			    //-->
			    </script>
<%
			    Response.End

    		    End If
    		    Rs.Close : Set Rs = Nothing

    		    sql = "	insert into TB_ba001(cd_fg, cd, cd_nm, num_fr, num_to, remark, char_fr, char_to, del_fg, update_yn)  "
    		    sql = sql & " values('"& cd_fg &"','"& cd &"', '"& cd_nm &"',	 0, 0,'"& cd_remark &"',	'"& cd_char_fr &"',	'"& cd_char_to &"', 'N', 'N') "

    		    objConn.Execute(sql)
        End if
    Next


    If Err.number = 0 Then
	objConn.CommitTrans
%>

    <script language="javascript">
    <!--
        parent.fnChkBaseContentsList();
        setTimeout("parent.fnChkBaseContentsList()",400);
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