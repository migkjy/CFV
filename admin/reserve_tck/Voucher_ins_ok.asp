<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->


<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


    OpenF5_DB objConn
    
    
    
    g_kind = Request("g_kind")
    
    reserve_code  = Trim(Request("reserve_code"))
    mod_tp = Trim(Request("mod_tp"))
   
    vaucher_no = Trim(Request("vaucher_no"))
    vaucher_no = Replace(vaucher_no,"'","")

    v_issue_date = Trim(Request("v_issue_date"))
   
    v_remark = Trim(Request("v_remark"))
    v_remark = Replace(v_remark,"'","")

    ir_1  = Trim(Request("ir_1"))
    ir_1    = Replace(ir_1,"'","''")

 
    msg ="정상적으로 등록 되었습니다"


    Sql = " UPDATE w_res_tck001  SET v_vaucher_no ='"&vaucher_no&"',   v_remark=N'"&v_remark&"'  , v_issue_date ='"&v_issue_date&"'	, v_detail =N'"&ir_1&"'	 "
    Sql = Sql& " WHERE reserve_code='"&reserve_code&"' "

    objConn.Execute Sql

    objConn.close : Set objConn = Nothing
%>

<script type="text/javascript">
<!--
    alert("<%=msg%>");
    location.href="voucher_mail.asp?mode=1&g_kind=<%=g_kind%>&reserve_code=<%=reserve_code%>";
//-->
</script>