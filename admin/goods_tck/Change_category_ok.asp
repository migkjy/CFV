<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    OpenF5_DB objConn
    On Error Resume Next

    nat_cd   = Request("nat_cd")
    good_num = Request("good_num")

    If good_num="" or isnull(good_num) then
        response.write "<script language='javascript'>  "
        response.write "  alert('카테고리 정보가 없습니다.');"
        response.write "  self.close();   "
        response.write "</script>  " 
        response.end
    End if


    change_cate    = Request("change_cate")
     
    SQL = "UPDATE trip_gtck SET  s_area= '" & change_cate &"'  WHERE num='" & good_num&"' "
    objConn.Execute(SQL)

    If Err.Number <> 0 then 
%>
        <script language="javascript">
        <!--
            alert("에러가 발생했습니다.\n정확한 데이타를 입력해 주시기 바랍니다.");
            history.back();
        //-->
        </script>
<% Else %>
        <script language="javascript">
        <!--
            alert("카테고리가 변경되었습니다");
            parent.location.reload();
            parent.$('#chain_category').dialog('close');
        //-->
        </script>
<%
    End if
    objConn.close  : Set objConn = Nothing 
%>
