<!--#include virtual="/home/conf/config.asp"--> 

<%
    g_kind = Lcase(Request("g_kind")) 
    Select Case Ucase(g_kind)
        Case "10" : catagory = "데이투어"
        Case "20" : catagory = "할인티켓"
    End select
    
    
    rec_email = request("email")
    send_name = GLOBAL_SS
    send_email = GLOBAL_MAIL
    intro = request("email2")
    intro = replace(intro,chr(13)&chr(10),"<br>")
    data0 = request("data0")
    data1 = request("data1")
    data2 = request("data2")
    data3 = request("data3")
    data = data0 & data1 & data2 & data3
    
    Dim iMsg
    Dim iConf
    Dim Flds
    
    '----------------- 일정표 소개내용을 가져옴 ---------------
    str = 		"<link href='https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap' rel='stylesheet'><link href='https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap' rel='stylesheet'>"
    str = str & "<table width='900px' border='0' cellpadding='0' cellspacing='0'>"
    str = str & "    <tr>"
    str = str & "        <td>" & data &  "</td>"
    str = str & "    </tr>"
    str = str & "    <tr>"
    str = str & "        <td height='20px'></td>"
    str = str & "    </tr>"
    str = str & "    <tr>"
    str = str & "        <td>"
    str = str & "            <table width='900px' border='0' cellpadding='0' cellspacing='1' align='center' bgcolor='#CCCCCC'>"
    str = str & "                <tr>"
    str = str & "                    <td bgcolor='#FFFFFF' style='font-family : verdana; padding:15px;'>" & intro & "</td>"
    str = str & "                </tr>"
    str = str & "            </table>"
    str = str & "        </td>"
    str = str & "    </tr>"
    str = str & "</table>"


	Const cdoSendUsingPickup = 1
	 
	set iMsg  = CreateObject("CDO.Message")
	set iConf = CreateObject("CDO.Configuration")
	
	Set Flds = iConf.Fields
	With Flds
		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPickup
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "c:\inetpub\mailroot\pickup"
		.Update
	End With
	
	With iMsg
	Set .Configuration = iConf
		.To = rec_email  
		.From =""& GLOBAL_SIN &" <"& send_email &">"
		.Subject  = send_name & "에서 발송한  "& catagory &" 입니다."
		.HTMLBody = str
		.BodyPart.Charset="utf-8" 
		.HTMLBodyPart.Charset="utf-8" 
		.Send 
	End With
	
	Set iMsg = Nothing
	Set iConf = Nothing
	Set Flds = Nothing	
%>

<script language="javascript" type="text/javascript" src="/home/js/jquery-1.8.3.min.js"></script>

<script language="javascript">
    alert("<%= rec_email%>로 매일이 전송되었습니다.");
    parent.jQuery.fancybox.close();
</script>

