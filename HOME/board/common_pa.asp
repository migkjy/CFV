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
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
</head>
	
<body style="overflow-x:hidden;"> 

     <div class="pop_pass_txt"><font color="#FF0000">비밀번호</font>를 입력하시면<br>게시글을 수정/삭제 하실 수 있습니다.</div>

     <form name="chk_frm" method="post" action="/home/board/<%=f_ts%>.asp"  target="_parent" style="display:inline;margin:0px;">
     <input type="hidden" name="num" value="<%=num%>">
     <input type="hidden" name="gotopage" value="<%=gotopage%>">
     <input type="hidden" name="s_cont" value="<%=s_cont%>">
     <input type="hidden" name="cont" value="<%=cont%>">
         <div align="center">
             <div><input type="password"name="password" style="width:250px;font-size:14px;" maxlength="20" class="pop_pass_input" placeholder="비밀번호를 입력해 주세요" required/></div>
             <div class="pt20"></div>
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