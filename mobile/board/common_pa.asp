<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    g_kind = Lcase(Request("g_kind"))

    num = Request("num")
    f_ts = Request("f_ts")
    gotopage = Request("gotopage")

    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")
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
	
<body style="overflow-x:hidden;"> 
	
     <div class="pop_pass_txt"><font color="#FF0000">비밀번호</font>를 입력하시면<br>게시글을 수정/삭제 하실 수 있습니다.</div>

     <form name="chk_frm" method="post" action="/mobile/board/<%=f_ts%>.asp"  target="_parent" style="display:inline;margin:0px;">
     <input type="hidden" name="num" value="<%=num%>">
     <input type="hidden" name="gotopage" value="<%=gotopage%>">
     <input type="hidden" name="s_cont" value="<%=s_cont%>">
     <input type="hidden" name="cont" value="<%=cont%>">
         <div align="center">
             <div><input type="password"name="password" style="width:270px;" maxlength="20" class="input_sign" placeholder="비밀번호를 입력해 주세요" required/></div>
             <div class="pt15"></div>
             <div class="pop_pass_login"><a href="javascript:;" onclick="chk_pwd();"><font color="#FFF">확인</font></a></div>
         </div>
     </form>

</body>
</html>
    


<script type="text/javascript">
<!--
    function chk_pwd(){
        if(document.chk_frm.password.value == "") {
            alert("비밀번호를 입력하셔야 합니다.");
            document.chk_frm.password.focus();
            return false;
        }

        if (document.chk_frm.password.value.length< 4|| document.chk_frm.password.value.length>10 ) {
            alert("비밀번호는 4글자 이상 10글자 이하 입력하셔야 합니다.");
            document.chk_frm.password.focus();
            return false;
        }
        document.chk_frm.submit();

    }
//-->
</script> 