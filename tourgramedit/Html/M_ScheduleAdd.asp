<%@ Language="VBScript" CodePage="65001" %>
<% Option Explicit %>
<!--#include file="../Include/Config.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<%
    Dim seqNo   
    Dim title,num
    Dim itemCD, contents
   num = Request("num")
    num = Base64_Decode(num)
    Set rs = Server.CreateObject("ADODB.RecordSet")
    Set cmd = Server.CreateObject("ADODB.Command")
   Call dbOpen()
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />
<!--#include file="../Include/IncMeta.asp"-->
<script type="text/javascript" src="../SmartEditorBasic/js/HuskyEZCreator.js"></script>
<!--#include file="../Scripts/GoodsImageBox.asp"-->
   
<script type="text/javascript">
    var oEditor = [];

    $(document).ready(
        function() {
           nhn.husky.EZCreator.createInIFrame(oEditor, "SchdContents", "../SmartEditorBasic/SEditorSkin.html", "createSEditorInIFrame", null, false);
            ImageBox.init(oEditor, "SchdContents");
         
        }
    );
</script>  

<link type="text/css" rel="stylesheet" href="/css/popup.css" />
</head>
<body>
	
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td>
            	
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td class="popup_bg">여권사진 등록</td>
                    </tr>
                </table>

                <!--#include file="../Include/IncImageBox.asp"-->    

                <div  id="EditorBox">
                    <form id="frmBox" method="post" action="ScheduleAddOK.asp">
                        <input type="hidden" name="num" value="<%=num%>" />
                        <input type="hidden" id="SchdContents" name="Contents" value="" />
                    </form>
                </div>  
    
            </td>
        </tr>
    </table>
</body>
</html>
<%
    Set rs = Nothing
    Call dbClose()
%>