<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
 <!--#include virtual="/home/inc/cookies2.asp"-->
<%
    Response.Expires = -1
    Response.ExpiresAbsolute = Now() - 1
    Response.AddHeader "pragma", "no-cache"  
    Response.AddHeader "cache-control", "private"
    Response.CacheControl = "no-cache"  
    Session.codepage=65001
    Response.CharSet="utf-8"
 
    OpenF5_DB objConn 
    
  
    bank_name = trim(Request.Form("bank_name"))
    bank_name = SQLInj(bank_name)
    bank_name = Replace(bank_name, "'", "''")
    
    account_num =trim(Request.Form("account_num"))
    account_num = SQLInj(account_num)
    account_num = Replace(account_num, "'", "''")
   
    account_number = bank_name &"-"& account_num
    
    if bank_name = "" then
        Alert_Window("은행명을 입력하여 주십시오.")
        Response.END
    end if  
    
    if account_num = "" then
        Alert_Window("계좌번호를 입력하여 주십시오.")
        Response.END
    end if
     
    query = "UPDATE TB_member SET account_number ='"& account_number &"'  WHERE memid = '"& memid &"'"
    objConn.Execute(query)
    
    CloseF5_DB objConn 
%> 

<script language="javascript">
<!--
    alert("계좌등록  되었습니다. ");
    parent.location.reload();
    parent.$('#chain_wallet').dialog('close');
//-->
</script> 
