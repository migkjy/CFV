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
    
    <form name="form1" method="post" action="Account_ok.asp" onSubmit="return frm_chk()" style="display:inline; margin:0px;"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="20"></td>
            </tr>
            <tr>
                <td><input type="text" name="bank_name" maxlength="40" style="width:50%;" class="input_log" placeholder="은행명을 입력하여 주세요." required /></td>
            </tr>
            <tr>
                <td height="15"></td>
            </tr>
            <tr>
                <td><input type="text"name="account_num" maxlength="20" style="width:94%;" class="input_log" placeholder="계좌번호를 입력하여 주세요." required/></td>
            </tr>
        </table>

        <div class="board_btn_w">
            <ul class="btn_r">
                <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>
                <li><input type="image" name="image" src="/images/member/icon_acc.png" border="0" style="border:0px solid #FFF;border-radius:0px;"></li>
            </ul>
        </div>
    </form>

</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_wallet').dialog('close');
    return false;
    } 
 
    function frm_chk(){
        if(document.form1.bank_name.value==""){
            alert("은행명을 입력하여 주세요");
            document.form1.bank_name.focus()
            return false;
        }
        if(document.form1.account_num.value==""){
            alert("계좌번호를 입력하여 주세요.");
            document.form1.account_num.focus()
            return false;
        }
        return true;
    }
//-->
</script>

