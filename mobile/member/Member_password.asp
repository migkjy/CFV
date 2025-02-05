﻿<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
    
<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        Response.write " self.close();"
        response.write "</script>                             " 
        response.end
    End if
%>
        
<!DOCTYPE html>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>

<body>
	
    <div class="pt20"></div>
    
    <form name="pw_mod" action="ok_password.asp" method="post" onSubmit="return chk_pw();" style="display:inline; margin:0px;">
        <div class="board_write"> 
            <table>
                <colgroup>
                    <col width="45%">
                    <col width="*">
                </colgroup>
                <tbody>  
                    <tr>
                        <td class="typ1"><font color="#E9250B">*</font> 기존 비밀번호</td>
                        <td class="typ2"><input type="password" name="m_pw1" style="width:96%;" maxlength="12" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="typ3"><font color="#E9250B">*</font> 변경할 비밀번호</td>
                        <td class="typ4"><input type="password" name="m_pw2" style="width:96%;" maxlength="12" class="input_basic"></td>
                    </tr>  
                    <tr>
                        <td class="typ3"><font color="#E9250B">*</font> 비밀번호 재확인</td>
                        <td class="typ4"><input type="password" name="m_pw3" style="width:96%;" maxlength="12" class="input_basic"></td>
                     </tr>
                </tbody>
            </table>   
        </div>
        <div style="color: #888; font-size:0.83em; padding:10px 0 0 0; ">영문 또는 숫자의 조합으로 최소 10자리!</div>

        <div class="board_btn_w">
            <ul class="btn_r">
                <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>
                <li><input type="image" name="image" src="/mobile/images/member/icon_mok.png" border="0" style="border:0px solid #FFF;border-radius:0px;"></li>
            </ul>
        </div>
    </form>

</body>
</html>
        
<script language="JavaScript">
<!--
    function closeIframe(){
        parent.$('#chain_pwd').dialog('close');
        return false;
    }
    
    function chk_pw(){
        if (pw_mod.m_pw1.value == ""){
            alert("기존 비밀번호를 입력하세요.");
            pw_mod.m_pw1.focus();
            return false;
        }
        else if (pw_mod.m_pw2.value == ""){
            alert("새 비밀번호를 입력하세요.");
            pw_mod.m_pw2.focus();
            return false;
        }
        else if (pw_mod.m_pw2.value != pw_mod.m_pw3.value){
            alert("새로 입력하신 비밀번호가 서로 다릅니다.\n 다시 확인하여 주세요.");
            pw_mod.m_pw2.focus();
            return false;
        }
        if(pw_mod.m_pw2.value.substr(0,1)==" "){                 
            alert("비밀번호의 첫글자에는 공백문자를 넣을 수 없습니다.");                 
            pw_mod.m_pw2.pwd1.focus();                
            return false;                 
        }
        if ( pw_mod.m_pw2.value.length < 4 || pw_mod.m_pw2.value.length > 10 ){                 
            alert("비밀번호는 최소4자이상 최대10자이하로 입력해주세요.");                
            pw_mod.m_pw2.focus();                
            return;         
        }
        return true;
    }
//-->
</script>