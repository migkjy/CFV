<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->


<%
     With Response
          .CharSet = "utf-8" 
          .Expires = -1
          .ExpiresAbsolute = Now() - 1
          .AddHeader "pragma", "no-cache"
          .CacheControl = "no-cache"
          .Buffer = true
     End With
     
    reserve_code  = Request("reserve_code")
   reserve_code1 = Base64_Encode(reserve_code)

         
    if reserve_code = ""  then
       Response.write "<script type='text/javascript'>"
       Response.write " alert('예약된 상품코드가 없습니다.'); "
       Response.write " history.back();"
       Response.write " </script>	 "
       Response.end
    end if

     OpenF5_DB objConn


 '예약수정
   ' sql = "update  w_res_tck001 set  prod_cd ='4'  where reserve_code = '"&reserve_code&"' "
    'objConn.Execute(sql) 
    
    
     'sql = "update  w_res_tckopt set  opt_cancd ='4'  where reserve_code = '"&reserve_code&"' "
   ' objConn.Execute(sql) 
    
    
    ' sql = "update  TB_save_money set   can_yn ='4'  where reserve_code = '"&reserve_code&"' "
   
  ' response.write sql
  '  objConn.Execute(sql) 
  
          sql3 =  "delete from w_res_tckopt where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql3
        
        sql2 =  "delete from w_res_tck002 where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql2
	      
        sql1 =  "delete from w_res_tck001 where reserve_code ='"&reserve_code&"'"
        objConn.Execute sql1
        
        sql = "update  TB_save_money set   can_yn ='Y'  where reserve_code = '"&reserve_code&"' "
        objConn.Execute(sql) 
    
    
	
     CloseF5_DB objConn
    
     response.write "<script language='javascript'>         "
     response.write "  alert('예약이 취소 되었습니다.');   "
     response.write "  top.location.href='/mobile/mypage/my_page_view.asp?g_kind=10&reserve_code="&reserve_code1&"'; "
     response.write "</script>                                     " 
     response.end
%>


