<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

	idx = Request("idx")
	tbl = request("tbl")
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link rel="stylesheet" type="text/css" href="/css/style.css" />
 
<body>
    
    <form name=reply_del method=post action="dat_pass_ok.asp" style="display:inline; margin:0px;">
    <input type="hidden" name="idx" value="<%=idx%>">
    <input type="hidden" name="tbl" value="<%=tbl%>">

    <table width="230" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #E7E7E7;border-radius:4px;background:#FFF;">
        <tr>
            <td height="40" bgcolor="#F5F5F5" style="font-size:13px; padding:0 0 0 15px; border-bottom:1px solid #E7E7E7;"><strong>댓글 비밀번호확인</strong></td>
        </tr>
        <tr>
            <td height="60" style="border-bottom:1px solid #E7E7E7;">
                <table border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr> 
                        <td><input type="password" name="passwd" style="width:80px;height:20px;border-radius:4px;"></td>
                        <td width="7"></td>
                        <td><img src="/images/board/dat_ok.png" border="0" onclick="chk_form();" style="cursor:pointer;border-radius:4px;"></td>
                        <td width="7"></td>
                        <td><img src="/images/board/dat_close.png" border="0" onclick="javascript:parent.dat_layer('<%=idx%>','off');" style="cursor:pointer;border-radius:4px;"></td>
                    </tr>
                </table>   
            </td>
        </tr>
    </table>

    </form>

    <script type="text/javascript">
    <!--
       function chk_form(){
         f = document.reply_del;
    
    	   if(!f.passwd.value){
             alert("비밀번호를 입력하세요.");
             return false;
    	   }
         f.submit();
      }
    //-->
    </script>

</body>
</html>