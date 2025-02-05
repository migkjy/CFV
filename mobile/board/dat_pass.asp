<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

	idx = Request("idx")
	tbl = request("tbl")
%>
<html>
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    
    <form name=reply_del method=post action="dat_pass_ok.asp" style="display:inline; margin:0px;">
    <input type="hidden" name="idx" value="<%=idx%>">
    <input type="hidden" name="tbl" value="<%=tbl%>">

    <table width="220" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="31" bgcolor="#F5F5F5" style="font-size:0.875em; padding:0 0 0 15px; border-top:1px solid #E7E7E7; border-bottom:1px solid #E7E7E7;border-left:1px solid #E7E7E7;border-right:1px solid #E7E7E7;"><strong>댓글 비밀번호확인</strong></td>
        </tr>
        <tr>
            <td style="border-bottom:1px solid #E7E7E7;border-left:1px solid #E7E7E7;border-right:1px solid #E7E7E7;padding:7px 10px;">
                <span><input type="password" name="passwd" style="width:90px" class="input_basic"></span>
                <span style="padding:0 2px 0 5px;"><img src="/images/community/dat_ok.png" border="0" onclick="chk_form();"></span>
                <span><img src="/images/community/dat_close.png" border="0" onclick="javascript:parent.dat_layer('<%=idx%>','off');"></span>
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