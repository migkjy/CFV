<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    admin_action = trim(Request("admin_action"))
    if admin_action="" then
        Alert_Window("주요인자 전송에러!!")
        resposne.end
    end if


    '##################################################################################################
    OpenF5_DB objConn 


    If admin_action="member_modify" then
        memid = request("memid")
        num = request("num")
        pwd1 = request("pwd1")
        pwd1  = Base64_Encode(pwd1)
	      kname = request("kname")
        birthday = request("birthday")
         htel = request("handtel")
 
        Sql = "UPDATE TB_member SET memid = '"&memid&"',pwd = N'"&pwd1&"', kname = N'"&kname&"',birthday = N'"&birthday&"' , htel = N'"&htel&"',gender = '"&gender&"'   WHERE num = "&num  

        objConn.Execute Sql
%>
    <script language="javascript">
        location.href="member_view.asp?num=<%=num%>&memkind=<%=upmemkind%>"
    </script>
<%
    End if
    '##################################################################################################

    '##################################################################################################
    '회원탈퇴
    If admin_action="member_out" then
        num = request("num")
        Sql = "UPDATE TB_member SET memkind = '0' WHERE num = "&num
	
        objConn.Execute Sql
%>
    <script language="javascript">
        alert("탈퇴처리 되었습니다.");
        location.href = "member_list.asp";
    </script>
<%
    End if
    '##################################################################################################

    '##################################################################################################
    '회원재가입
    If admin_action="member_rejoin" then
        num = request("num")
	
        Sql1 = "SELECT memid  FROM TB_member WHERE num = "&num
        Set Rs1 = objConn.Execute(Sql1)
        if Rs1.EOF or Rs1.BOF then
            Alert_Window("선택된 고객의 정보가 없습니다.")
            response.end
        else
            memid= Rs1("memid")
        end if
    
        if  cstr(left(memid,3)) ="201" then
            upmemkind= "2"
        else	
            upmemkind= "1"
        end if   	
  

        Sql = "UPDATE TB_member SET memkind = '"&upmemkind&"' WHERE num = "&num
        objConn.Execute Sql
%>
    <script language="javascript">
        alert("재가입처리 되었습니다.");
        location.href = "member_list.asp";
    </script>
<%
    End if
    '##################################################################################################

    '##################################################################################################
    '회원삭제
    if admin_action="member_del" then
	num = request("num")
	Sql = "DELETE  FROM TB_member WHERE num = "&num
	
	objConn.Execute Sql
%>
    <script language="javascript">
        alert("삭제처리 되었습니다.");
        location.href = "member_list.asp";
    </script>
<%
    End if
    '##################################################################################################
    
    '##################################################################################################
    '회원가입
    If admin_action="member_join" then
        memid = request("memid")
        ent_year = trim(request("ent_year"))
        ent_month = trim(request("ent_month"))
        ent_day = trim(request("ent_day"))
	
        birthday   = ent_year&"-"&ent_month&"-"&ent_day   '예약자생년월일           
        kname = request("kname")
        cugr_cd = request("cugr_cd")
        efname = request("efname")
        elname = request("elname")
        pwd1  = request("pwd1")
        pwd1  = Base64_Encode(pwd1)
        email1		= request("email1")	'//이메일 첫번째 주소 및 풀주소
        email2		= request("email2")	'//이메일 @ 이후 주소 및 9이면 email1이 풀주소
        email	= email1 & "@" & email2
 
        email_yn = request("email_yn")
        comtel = request("comtel")
        htel = request("handtel")
        sms_yn = request("sms_yn")
        memkind = request("memkind")
	
	
        Sql = "SELECT num FROM TB_member WHERE memid = '"&memid&"'"
        Set Rs = objConn.Execute(sql)
	
        if Not Rs.Eof Then
%>
    <script language = "javascript">
        alert("현재 입력하신 아이디는 이미 등록되어 있는 아이디입니다.\n아이디를 변경하신 후 가입해주시기 바랍니다.");
        history.back();
    </script>
<%
        Response.End
        end if
        
        if email<>"" then
            Sql = "SELECT num FROM TB_member WHERE email = '"&email&"'"
            Set Rs = objConn.Execute(sql)

            if Not Rs.Eof Then
%>
    <script language = "javascript">
        alert("현재 입력하신 이메일은  이미 등록되어 있는 이메일입니다.\n자세한 사항은 관리자에게 문의바랍니다.");
        history.back();
    </script>
<%
            Response.End
            end If
        end if	
        
        
        Sql = "SELECT MAX(num) FROM TB_member"
        Set Rs = objConn.Execute(sql)
	
        if isnull(Rs(0)) then
            num = 1
        else
            num = rs(0) + 1
        end if
	
        f = "num,       memid,           pwd,           birthday,         kname,       cugr_cd    ,     elname,          efname,         email,        email_yn,         comtel,          htel,          sms_yn,          memdate, memcnt, memkind "
        v = num&", '"&memid&"', '"&pwd1&"', N'"&birthday&"',  N'"&kname&"','"&cugr_cd&"', N'"&elname&"', N'"&efname&"', N'"&email&"','"&email_yn&"','"&comtel&"', '"&htel&"', '"&sms_yn&"', '"&date&"', 2,  '"&memkind&"'" 
	
        Sql = "INSERT INTO TB_member ( "&f&" )"
        Sql = sql &"VALUES ( "&v&" )"
        objConn.Execute Sql
        Rs.close
	
        Set Rs = Nothing
%>
    <script language="javascript">
        location.href = "member_list.asp";
    </script>
<%
    End if

    CloseF5_DB objConn '데이타베이스 클로즈
%>

