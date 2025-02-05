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

    Dim reserve_code, memer_cnt

    reserve_code  = Request("reserve_code")
    if reserve_code = ""  then
       Response.write "<script type='text/javascript'>"
       Response.write " alert('예약된 상품코드가 없습니다.'); "
       Response.write " history.back();"
       Response.write " </script>	 "
       Response.end
    end if


    prod_cd = Request("prod_cd")
    if prod_cd="" then
        prod_cd =0
    end if

    add_amt = Request("add_amt")
    if add_amt="" or isnull(add_amt) then
        add_amt=0
    end if
    
    dc_amt  = Request("dc_amt")
    if dc_amt="" or isnull(dc_amt) then
        dc_amt=0
    end if

    if prod_cd = "4" then
        add_amt =0
        dc_amt  =0
        res_can ="Y"
    else
       res_can ="N"
    end if


    s_opt_time = Request("s_opt_time")
    s_opt_time  = Replace(s_opt_time,"'","''")

    objConn.BeginTrans


    '예약수정
    sql = "update  w_res_tck001 set  prod_cd ='"&prod_cd&"'  where reserve_code = '"&reserve_code&"' "
    objConn.Execute(sql) 
    
    
     sql = "update  w_res_tckopt set  opt_cancd ='"&res_can&"'  where reserve_code = '"&reserve_code&"' "
    objConn.Execute(sql) 
    
    
     sql = "update  TB_save_money set   can_yn ='"&res_can&"'  where reserve_code = '"&reserve_code&"' "
    objConn.Execute(sql) 
    
    
    
    
    If Err.Number <> 0 then 
        objConn.RollbackTrans
%>
        <script type="text/javascript">
        <!--
            alert("에러가 발생했습니다.\n정확한 데이타를 입력해 주시기 바랍니다.");
            parent.location.reload();
        //-->
        </script>
<% 
    Else 

        objConn.CommitTrans
        objConn.close : Set objConn = nothing
%>
        <script type="text/javascript">
        <!--
            alert("진행현황이 수정 되었습니다");
            parent.location.reload();
        //-->
        </script>
<%   
    End if 
%> 
