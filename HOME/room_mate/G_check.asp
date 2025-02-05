<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->

<%
    OpenF5_DB objConn

    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    Dim sql, rs, cnt, g_check, knum

    num = Request("knum")
 
 
 
       sql = " SELECT  room_group  FROM TB_member where memid= '"&memid&"' "
       Set Rs = objConn.Execute(sql)
       room_group_k  = Trim(Rs("room_group"))
       Rs.close  : Set Rs = nothing
          
    'response.write num
    'response.end

    Sql = "SELECT memid,kname,htel,room_group FROM TB_member WHERE num = '"&num&"'"
    'response.write sql
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    ' memid= trim(Rs("memid")) 
    kname= trim(Rs("kname")) 
    htel= trim(Rs("htel")) 
    room_group_h= trim(Rs("room_group"))
    
    if room_group_k  <> room_group_h  then
        response.write "<script language='javascript'>  "
        Response.write " alert('동일한팀 끼리 매칭하여야 합니다....'); "
        Response.write " history.back();"
        response.write "</script>                             " 
        response.end
     end if  
  
             
    cntSql = "select * from TB_sel_memo where (send_hp = '"&htel&"' and  cu_hp  = '"&cu_htel&"') and app_gubn = '0' and del_yn='N'"
    '  response.write  cntSql &"<br>"
    ' response.end
    Set cntRs = Server.CreateObject("ADODB.RecordSet")
                                
                                
    cntRs.open cntSql,objConn
    If not cntRs.eof or not cntRs.bof then
      
     
        response.write "<script language='javascript'>  "
        Response.write " alert('룸메이트 매칭 동일인 중복 내역이 있습니다. 마이페이지 확인하세요..'); "
        Response.write " history.back();"
        response.write "</script>                             " 
        response.end

    End if
    CloseRs cntRs
             
             
    cntSql = "select * from TB_sel_memo where (send_hp = '"&cu_htel&"' or  cu_hp  = '"&cu_htel&"') and app_gubn = '1' and del_yn='N'"
    '  response.write  cntSql &"<br>"
    ' response.end
    Set cntRs = Server.CreateObject("ADODB.RecordSet")
                                
    cntRs.open cntSql,objConn
    If not cntRs.eof or not cntRs.bof then
        response.write "<script language='javascript'>  "
        Response.write " alert('룸메이트 매칭 확정 내역이 있습니다. 마이페이지 확인하세요..'); "
        Response.write " history.back();"
        response.write "</script>                             " 
        response.end
    End if
    CloseRs cntRs
                                 
                                 
    sql="insert into TB_sel_memo(send_name,send_hp,app_gubn,cu_nm_kor,cu_hp,cu_memid) values('"&kname&"','"&htel&"','0','"&cu_nm_kor&"','"&cu_htel&"','"&memid&"')"
    ' response.write sql
    objConn.execute SQL
      
    objConn.close
    Set objConn = nothing
%>

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
<script type="text/javascript">
<!--
   alert('룸메이트 매칭 신청이 되었습니다. 마이페이지에서 확인하세요');
   parent.$('#pop_matching').dialog('close');
//-->
</script>

