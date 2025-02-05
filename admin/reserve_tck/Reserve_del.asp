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
     
     
    reserve_code 	= Request("reserve_code")
    If reserve_code="" or isnull(reserve_code) THEN
        response.write "<script language='javascript'>  "
        response.write "alert('정확한 예약정보가 없습니다...');"
        response.write "history.back();"
        response.write "</script>  " 
        response.end
    End if

    reserve_gubun ="30"
  
    nat_cd     = Request("nat_cd")
    gotopage	 = Request("gotopage")
    start_ymd  = Request("start_ymd")
    start_ymd2 = Request("start_ymd2")


    SQL ="SELECT COUNT(pay_seq) from w_res_pay where reserve_code ='"&reserve_code&"' and reserve_gubun='"& reserve_gubun &"'  and del_yn='N' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
     Rs.open sql,objConn,3
 
    If Rs.eof or Rs.bof then
        r_cnt =0
    Else
        r_cnt =Rs(0)
    End if


    If r_cnt = 0 then
    
        '############################################################################삭제
        sql3 =  "delete from w_res_tckopt where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql3
        
        sql2 =  "delete from w_res_tck002 where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql2
	      
        sql1 =  "delete from w_res_tck001 where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql1
        
          sql = "update  TB_save_money set   can_yn ='Y'  where reserve_code = '"&reserve_code&"' "
        objConn.Execute(sql) 
        
        objConn.close  : Set objConn = Nothing
%>

        <script language=javascript> 
        <!--
            alert("삭제 처리되었습니다.   ");
            location.href = "reserve_list.asp?start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>";
        //-->
        </script>
<% Else  %>
        <script language=javascript> 
        <!--
            alert("입금된 데이타가 있습니다.\n삭제하시기전 입금/환불 삭제후 가능하십니다.  ");
            history.back()

        //-->
        </script>
<% End if %> 