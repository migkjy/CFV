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

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!--#include file="../Include/IncMeta.asp"-->
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
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
</head>
<body style="overflow-Y:hidden;">
	
    <!--#include file="../Include/IncImageBox.asp"-->    
    <div  id="EditorBox">
        <form id="frmBox" method="post" action="ScheduleAddOK.asp">
            <input type="hidden" name="num" value="<%=num%>" />
            <input type="hidden" name="Contents" id="SchdContents" value="" />
        </form>
    </div>    
    
</body>
</html>
<%
    Set rs = Nothing
    Call dbClose()
%>