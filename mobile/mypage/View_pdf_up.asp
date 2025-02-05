<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->  

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    

    dim ProgressID
    set obj = server.CreateObject("DEXT.Progress")

    ProgID = obj.GetProgressID()
    set obj = nothing

    tot_hp = Trim(Request("tot_hp"))
    tot_hp = Base64_Decode(tot_hp)
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
    
    <form name="write_form" enctype="multipart/form-data" method="post" action ="view_pdf_ok.asp?ProgressID=<%=ProgID%>&tot_hp=<%=tot_hp%>" onsubmit="return ShowProgress()" style="display:inline; margin:0px;">
        <div class="board_write">
            <table width="100%">
                <tr>
                    <td width="*" class="typ2"><input type="file" name="file" style="width:100%;height:20px;"  class="input_file"></div></td>
                    <td width="70" class="typ2"><input type=image name="Upload" src="/mobile/images/member/icon_mok.png" border="0" style="border:none;border-radius:0"></td>
                </tr>
            </table>
        </div>

    </form>

    <%
        OpenF5_DB objConn   
        sql = "select pdf_yn from TB_member where htel = '" & tot_hp & "'"
        Set dtRs = objConn.Execute(sql)
        pdf_yn = dtRs(0)
        dtRs.close
        Set dtRs = Nothing	
    %>
    <% if pdf_yn = "1" then%>
        <form name="del_form"  method="post" action ="view_pdf_del.asp?tot_hp=<%=tot_hp%>"  style="display:inline; margin:0px;">
            <div class="board_btn_w">
                <ul class="btn_r">
                    <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>
                    <li><input type=image name="del" src="/mobile/images/member/icon_mdelete.png" border="0" style="border:none;border-radius:0"></li>
                </ul>
            </div>
        </form>
    <% else %>
        <div class="board_btn_w">
            <ul class="btn_r">
                <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>
            </ul>
        </div>
    <% end if %>

</body>
</html>


<script language="javascript">
<!-- //
    function closeIframe(){
        parent.$('#chain_evoa_pop').dialog('close');
    return false;
    } 

    function ShowProgress() {
        var str;
        str = document.write_form.file.value;
        
        if(str == "") {
            alert("PDF 파일을 첨부해 주세요");
            return false;
        }
        
        strAppVersion = navigator.appVersion;
    						
        if (strAppVersion.indexOf('MSIE') != -1 && strAppVersion.substr(strAppVersion.indexOf('MSIE')+5,1) > 4) {
            winstyle = "dialogWidth=400px; dialogHeight:200px; center:yes";
            window.showModelessDialog("progress.asp?Progressid=<%=ProgID%>",null,winstyle);	  
        }
        else {
            winstyle = "dialogWidth=400px; dialogHeight:200px; center:yes";
            window.showModelessDialog("progress.asp?Progressid=<%=ProgID%>",null,winstyle);	  
        }
    			
        return true; 
    }
//-->
</script>