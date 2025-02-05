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

    reserve_code  = Request.form("reserve_code")
    If reserve_code="" then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자 전송에러...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if


    g_kind  = Request.form("g_kind")

    
    '-------------------------예약자 정보---------------------------------------
    res_nm  = Trim(Request.form("res_nm"))
    res_nm    = Replace(res_nm,"'","")

    res_eng_nm_F  = Trim(Request.form("res_eng_nm_F"))
    res_eng_nm_F    = Replace(res_eng_nm_F,"'","")
    res_eng_nm_F    = Ucase(res_eng_nm_F)

    res_eng_nm_L  = Trim(Request.form("res_eng_nm_L"))
    res_eng_nm_L    = Replace(res_eng_nm_L,"'","")
    res_eng_nm_L    = Ucase(res_eng_nm_L)
     
    res_hp1      = Trim(Request.form("res_hp1"))
    res_hp1     = Replace(res_hp1,"'","''")
    res_hp2      = Trim(Request.form("res_hp2"))
    res_hp2     = Replace(res_hp2,"'","''")
    res_hp3      = Trim(Request.form("res_hp3"))
    res_hp3     = Replace(res_hp3,"'","''")

    res_email    = Trim(Request.form("res_email"))

    res_hotel    = Trim(Request.form("res_hotel"))
    pick_place   = Trim(Request.form("pick_place"))
    pick_time    = Trim(Request.form("pick_time"))


    objConn.BeginTrans

    m_sql =  " UPDATE w_res_tck001 SET res_nm=N'"&res_nm&"' , res_eng_nm_F=N'"&res_eng_nm_F&"', res_eng_nm_L=N'"&res_eng_nm_L&"' ,res_hp1 ='"&res_hp1&"' ,res_hp2='"&res_hp2&"' ,res_hp3 ='"&res_hp3&"' ,res_email=N'"&res_email&"' "
    If g_kind="10" then
        m_sql = m_sql &" , res_hotel=N'"&res_hotel&"'   WHERE reserve_code='"&reserve_code&"'  "
    Else
        m_sql = m_sql &" , res_pick_place=N'"&pick_place&"', res_pick_time=N'"&pick_time&"'  WHERE reserve_code='"&reserve_code&"'  "
    End if


   objConn.Execute m_sql

     
   If Err.Number <> 0 then 
       objConn.RollbackTrans

%>
        <script type="text/javascript">
        <!--
            alert("에러가 발생했습니다.\n정확한 데이타를 입력해 주십시오");
            history.back();
        //-->
        </script>
<% 
   Else 

      objConn.CommitTrans
      objConn.close : Set objConn = nothing
%>
        <script language="javascript">
        <!--
            alert("예약자가 수정처리 되었습니다.");
            parent.location.reload();
            parent.$('#chain_name').dialog('close');
        //-->
        </script>
<%  
    End if 
%> 