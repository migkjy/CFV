<%@ Language=VBScript %>

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
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">

<script Language="Javascript">
    function ShowProgress() {
    var str;
       str = document.write_form.file.value;
       if(str == "") {
    		alert("EXCEL 파일을 첨부해 주세요");
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
</script>
</head>

<body>

    <div class="pt15"></div>

    <form name="write_form" enctype="multipart/form-data" method="post" action ="member_excel_up_ok.asp?ProgressID=<%=ProgID%>" onsubmit="return ShowProgress()" style="display:inline; margin:0px;">
        <div class="table_box">
            <table>
                <tr height="44">
                    <td width="15%" class="lop1">EXCEL 파일</td>
                    <td width="*%" class="lop2"><input type="file" name="srcfile" style="width:100%;" class="input_file"></td>
                </tr>
            </table>
        </div>

        <div align="center" style="padding:25px 0 0px 0;">
             <table>
                <tr>
                    <td><input type="image" name="Upload" src="/admin/images/icon_write.png" border="0"></td>
                    <td width="8"></td>
                    <td style="padding:0 0 4px 0;"><span class="button_b"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span></td>
                </tr>
            </table>
        </div>
    
     </form>

</body>
</html>


<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_member').dialog('close');
        return false;
    }
//-->
</script>
