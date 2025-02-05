<!--#include virtual="/admin/conf/config.asp"-->

<%
    na_txt = Trim(Request("na_txt"))
    cont_cd  = Trim(Request("cont_cd"))
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script language="javascript" type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>
	
    <div class="pb15"></div>
    
    <form name="nat_make" method="post" style="display:inline; margin:0px;">
    <input type="hidden" name="admin_action" value="nat_make">
    <input type="hidden" name="cont_cd" value="<%=cont_cd%>">  
        <div class="table_list">
            <table>
                <tr>
                    <td width="20%" class="top1">대륙</td>
                    <td width="24%" class="top2">국가코드 (2자리)</td>
                    <td width="26%" class="top2">국가명</td>
                    <td width="*" class="top2">영문명</td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                    <td class="tob1"><%=na_txt%></td>
                    <td class="tob2"><input type="text" name="nat_cd" style="width:75%" maxlength="2" onKeyUp="toUpCase(this)" class="input_basic"></td>
                    <td class="tob2"><input type="text" name="nm_kor" style="width:85%"maxlength="18" class="input_basic"></td>
                    <td class="tob2"><input type="text" name="nm_eng" style="width:90%"maxlength="18" onKeyUp="toUpCase(this)" class="input_basic"></td>
                </tr>
            </table>
        </div>

        <div align="center" style="padding:25px 0 0px 0;">
            <span class="button_b" style="padding:0px 4px"><a onClick="nat_frm_chk();return false;">등록</a></span>
            <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
    </form>
    
</body>
</html>

<script language="JavaScript" type="text/JavaScript">
<!--
    function closeIframe(){
        parent.$('#chain_schedule27k').dialog('close');
        return false;
    }
    
    
    function nat_frm_chk(){ 
        var frm = document.nat_make;
        if(frm.nat_cd.value == ""){
            alert("국가코드를 입력해주세요.");
            frm.nat_cd.focus()
            return false;
        }
	
        if(frm.nm_kor.value == ""){
            alert("국가명(한글)을 입력해주세요.");
            frm.nm_kor.focus()
            return false;
        }
	
        if(frm.nm_eng.value == ""){
            alert("국가명(영문)을 입력해주세요.");
            frm.nm_eng.focus()
            return false;
        }
        
        if(confirm("국가를 등록하시겠습니까?")){
            frm.action="process.asp";
            frm.target = 'selfWin';
            window.name = 'selfWin';
            frm.submit();
        }
    }


    function toUpCase(object){
        object.value = object.value.toUpperCase();
    }
//-->
</script>