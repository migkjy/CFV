<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->  

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>     

<!DOCTYPE html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
</head>

<body>
    
    <form name="form1" method="post" action="login_ok.asp" target="_parent" onSubmit="return frm_chk()" style="display:inline; margin:0px;"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="15"></td>
            </tr>
            <tr>
                <td><input type="text" name="mem_id" maxlength="40" style="width:100%;" class="input_sign" placeholder="아이디를 입력하여 주세요." required /></td>
            </tr>
            <tr>
                <td height="13"></td>
            </tr>
            <tr>
                <td><input type="password"name="mem_pw" maxlength="20" style="width:100%;" class="input_sign" placeholder="비밀번호를 입력하여 주세요." required/></td>
            </tr>
            <tr>
                <td height="13"></td>
            </tr> 
            <tr>
                <td><input type="image" name="image" src="/images/member/login_ok.png" border="0" width="100%" style="border:0px solid #FFF;border-radius:0px;"></td>
            </tr>
            <tr>
                <td height="13"></td>
            </tr> 
          <!--
            <tr>
                <td><span style="font-size:0.75em;color:#666;">※ 아이디는 이메일, 비밀번호는휴대폰 뒷4자리 입니다.</span></td>
            </tr> 
            <tr>
                <td><span style="font-size:0.75em;color:#666;letter-spacing:-0.04em;">※ 개인정보보호를 위해</span> <span style="font-size:0.75em;color:#e64540;font-weight:500;letter-spacing:-0.04em;">로그인 후 비밀번호 변경</span> <span style="font-size:0.75em;color:#666;letter-spacing:-0.04em;">부탁 드립니다.</span></td>
            </tr>-->
        </table>
    </form>

</body>
</html>


<script language="javascript">
    function frm_chk(){
        if(document.form1.mem_id.value==""){
            alert("아이디를 입력하여 주세요");
            document.form1.mem_id.focus()
            return false;
        }
        if(document.form1.mem_pw.value==""){
            alert("비밀번호를 입력하여 주세요.");
            document.form1.mem_pw.focus()
            return false;
        }
        return true;
    }
</script>