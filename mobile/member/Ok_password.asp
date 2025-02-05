<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
  
<% 
    Session.codepage=65001
    Response.CharSet="utf-8"

    OpenF5_DB objConn 
  
    Dim m_pw1,m_pw2,m_pw3,sql,rs,req_id,query,objRs,member_pwd
    m_pw1 = Request.Form("m_pw1")
   ' m_pw1  = Base64_Encode(m_pw1)
    m_pw2 = Request.Form("m_pw2")
   ' m_pw2  = Base64_Encode(m_pw2)
    m_pw3 = Request.Form("m_pw3")
  '  m_pw3  = Base64_Encode(m_pw3)
    
    if m_pw1 = "" then
        Alert_Window("기존 비밀번호를 입력하세요.")
        Response.END
    end if
    if m_pw2 = "" then
        Alert_Window("신규 비밀번호를 입력하세요.")
        Response.END
    end if
    if m_pw2 <> m_pw3 then
        Alert_Window("신규 비밀번호가 서로 다릅니다.")
        Response.END
    end if
    
    req_id = Request.Cookies("memid")
        if req_id = "" then
            Call Alert_Window_Location("회원님의 정보를 확인할 수 없습니다.\n다시 로그인 하여주세요.","index.asp?ts=login")
            Response.END
        end if
    
    query = "Select pwd from TB_member where memid = '"& req_id &"'"
    Set objRs = objConn.Execute(query)
    
    if objRs.eof and objRs.bof then
        Call Alert_Window_Location("회원님의 정보를 확인할 수 없습니다.\n다시 로그인 하여주세요.","index.asp?ts=login")
        Response.End
    else
        member_pwd = objRs(0)
    end if

    if member_pwd = m_pw1 then
        sql = "Update TB_member Set pwd = '"& m_pw2 &"' WHERE memid = '"& req_id &"'"
        objConn.Execute(sql)
        Response.Cookies("pwd") = m_pw2
    else
        Alert_Window("입력하신 기존비밀번호가 현재 사용하시는 비밀번호와 맞지 않습니다.\n다시 확인하여 주세요.")
        Response.END
    end if
    
    CloseF5_DB objConn
%>
   <script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
<script language="javascript">
<!--
    alert("회원님의 비밀번호가 수정되었습니다\n 고객님의 정보는 암호화 되어 안전하게 보관됩니다."); 
   parent.$('#chain_pwd').dialog('close');
//-->
</script>
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   