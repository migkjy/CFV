<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
   
       OpenF5_DB objConn   
   
   
    tbl = "res_dat"
    
    
    res_tp   = Request("res_tp")
    res_cd   = Request("res_cd")
    emp_no   = Request("emp_no")

    idx      = Request("idx")
    writer   = Request("writer")

    ir_1     = Request("ir_1")
       ir_1    =Replace(ir_1,"'","''")


    if idx ="" then
        msg ="등록 되었습니다."

        sql="insert into "&tbl&" ( res_tp , res_cd   , user_nm   ,  user_id    , con_tents , del_yn, ins_dt )  "
        sql= sql& " values( '"&res_tp&"','"&res_cd&"',N'"&writer&"', N'"&emp_no&"', N'"&ir_1&"' , 'N', getdate() ) "

        objConn.Execute(sql)

    Else

    	  msg ="수정 되었습니다."

        sql = "Update "&tbl&" Set user_nm=N'" & writer & "'  ,  user_id=N'"&emp_no&"' , con_tents=N'" & ir_1 & "' "
        sql = sql &" where idx="&idx

        objConn.Execute(sql)

    End if

    objConn.close : Set objConn = nothing

%>
 
<script type="text/javascript">
<!--
    alert('<%=msg%>');
    parent.location.reload();
    parent.$('#chain_memo').dialog('close');
//-->
</script>