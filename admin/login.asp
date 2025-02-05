<!--#include virtual="/admin/conf/config.asp"-->

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
<title>ERP 투어그램</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script src="scripts/common.js"></script>
</head>

<body onLoad="default_focus()" style="background: #000;"> 
	
    <div class="back_img">
        <h1><%=GLOBAL_SIN%></h1>
        <h2><%=GLOBAL_SIN%>의 여행 ERP 프로그램입니다.<br>허가된 직원외의 접속은 정보통신관련법에 의해 처벌을<br>받으실 수 있습니다.</h2>
        <h3>
            <form name="form1" method="post" action="login_ok.asp" onSubmit="return chk_frm(document.forms[0])">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="300" class="login_input"><input type="text" name="maid" value="<%=request.cookies("idchk")("id")%>" maxlength="20" placeholder="아이디를 입력하여 주세요." required /></td>
                        <td rowspan="3"><input type="image" src="/admin/images/ico_login.png" border="0" style="cursor:pointer;border-radius:4px;"></td>
                    </tr>
                    <tr>
                        <td colspan="2" height="12"></td>
                    </tr>
                    <tr>
                        <td class="login_input"><input type="password" name="mapass" value="<%=request.cookies("idchk")("pwd")%>" maxlength="20" placeholder="비밀번호를 입력하여 주세요." required/></td>
                    </tr>
                    <tr>
                        <td colspan="2" height="15"></td>
                    </tr>
                    <tr>
                        <td><span class="checks"><input type="checkbox" name="chk" id="chk" value="Y" checked><label for="chk">아이디 저장</label></span></td>
                    </tr>
                </table>
            </form>
        </h3>
    </div>

</body>
</html>


<script language="javascript">
<!--
    function trim(a){
        var search = 0
        while ( a.charAt(search) == " "){
            search = search + 1
        }
        a = a.substring(search, (a.length))
        search = a.length - 1
        while (a.charAt(search) ==" "){
            search = search - 1
        }
        return a.substring(0, search + 1)
    }
    
    function chk_frm(frm){
        if(trim(frm.maid.value)==""){
            alert("아이디를 입력하여 주세요");
            return false;
        }
        if(trim(frm.mapass.value)==""){
            alert("비밀번호를 입력하여 주세요.");
            return false;
        }
        return true;
    }
    
    function default_focus(){
        document.forms[0].maid.focus();
    }
//-->
</script>
