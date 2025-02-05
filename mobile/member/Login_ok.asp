<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
 
<%
    Response.Expires = -1
    Response.ExpiresAbsolute = Now() - 1
    Response.AddHeader "pragma", "no-cache"  
    Response.AddHeader "cache-control", "private"
    Response.CacheControl = "no-cache"  
    Session.codepage=65001
    Response.CharSet="utf-8"
 
    OpenF5_DB objConn 
    
    Dim req_id,req_pw,mem_id,mem_pw,mem_memkind,mem_num,sql,rs,query,ec_chk_pass,cu_pass
   
    req_id = trim(Request.Form("mem_id"))
    req_id = SQLInj(req_id)
    req_id = Replace(req_id, "'", "''")
    
    req_pw =trim(Request.Form("mem_pw"))
    req_pw = SQLInj(req_pw)
    req_pw = Replace(req_pw, "'", "''")
   ' req_pw  = Base64_Encode(req_pw)
    
    
    if req_id = "" then
        Alert_Window("아이디를 입력하여 주십시오.")
        Response.END
    end if  
    
    if req_pw = "" then
        Alert_Window("비밀번호 입력하여 주십시오.")
        Response.END
    end if
     
    
    sql = "SELECT num,memid,pwd,kname as cu_nm_kor,htel FROM TB_member WHERE memid = '"& req_id &"'"
    Set rs = objConn.Execute(sql)
    if rs.eof and rs.bof then
        Alert_Window("입력하신 아이디는 회원아이디가 아닙니다.\n다시확인하여 주세요.")
        Response.END
    else
        mem_id = rs("memid")
        mem_pw = trim(rs("pwd"))
        mem_num = rs("num")
        cu_nm_kor = rs("cu_nm_kor")
         htel = rs("htel")

    end if
    CloseRs Rs
      
  

    if mem_pw = req_pw then
 %>
 
 <!--#include virtual="/home/conf/before_url.asp" -->   
 
 <%
        query = "UPDATE TB_member SET memcnt = memcnt + 1 WHERE memid = '"& mem_id &"' AND pwd = '"& mem_pw &"'"
        objConn.Execute(query)
    
        Response.Cookies("memid") = mem_id
        Response.Cookies("pwd") = mem_pw
        Response.Cookies("memnum") = mem_num
        Response.Cookies("cu_nm_kor") = cu_nm_kor
        Response.Cookies("cu_htel") = htel

        If Request.Cookies("before_url") = "" Then
            response.write "<script language='javascript'>"
            response.write "  location.href='/mobile/index.asp' ;"
            response.write "</script>" 
            response.end
        Else
            'Response.Redirect Request.Cookies("before_url")
            Response.Redirect "/mobile/main.asp"
        End If
       
    else
        Response.Cookies("history_url")= Request.Cookies("before_url")
        Alert_Window("입력하신 아이디에 대한 비밀번호가 일치하지 않습니다.\n다시확인하여 주세요.")
        Response.END
    end if

    CloseF5_DB objConn 
%> 