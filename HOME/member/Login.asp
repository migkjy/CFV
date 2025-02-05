<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>     

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
    
    <form name="form1" method="post" action="login_ok.asp" target="_parent" onSubmit="return frm_chk()" style="display:inline; margin:0px;"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="20"></td>
            </tr>
            <tr>
                <td><input type="text" name="mem_id" maxlength="40" style="width:345px;" class="input_log" placeholder="아이디를 입력하여 주세요." required /></td>
            </tr>
            <tr>
                <td height="15"></td>
            </tr>
            <tr>
                <td><input type="password"name="mem_pw" maxlength="20" style="width:345px;" class="input_log" placeholder="비밀번호를 입력하여 주세요." required/></td>
            </tr>
            <tr>
                <td height="15"></td>
            </tr> 
            <tr>
                <td><input type="image" name="image" src="/images/member/login_ok.png" border="0" style="border:0px solid #FFF;border-radius:0px;"></td>
            </tr>
            <tr>
                <td height="15"></td>
            </tr> 
          <!--
            <tr>
                <td><span  style="font-size:13px;color:#666;">※ 아이디는 이메일, 비밀번호는휴대폰 뒷4자리 입니다.</span></td>
            </tr> 
            <tr>
                <td><span style="font-size:13px;color:#666;">※ 개인정보보호를 위해</span> <span style="font-size:13px;color:#e64540;font-weight:500;">로그인 후 비밀번호 변경</span> <span style="font-size:13px;color:#666;">부탁 드립니다.</span></td>
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