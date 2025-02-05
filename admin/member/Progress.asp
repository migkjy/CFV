<%@ Language=VBScript EnableSessionState="False" %>

<%
Option Explicit 

Dim Progress, Percent, TransferBytes, TotalBytes, BytesPer, bWorking, strFileName
'DEXT.Progress 오브젝트를 생성합니다.
Set Progress = Server.CreateObject("DEXT.Progress")
'GET 방식으로 전달된 진행 상태 아이디를 지정합니다.
Progress.SetProgressID( Request.QueryString("ProgressID"))

'현재 업로드 진행 상태 값을 읽습니다. 
Percent = Progress.Percent
TransferBytes = Progress.TransferSize
TotalBytes = Progress.TotalSize

BytesPer = Progress.BytesPerSec
bWorking = Progress.Working
strFileName = Progress.FileName
%>
<HTML>
<HEAD>
<title>파일 업로드 중 입니다...</title>
<%
Response.Write "<Meta HTTP-EQUIV=""Refresh"" CONTENT=1>"
%>
<style type='text/css'> 
td {font-size: 9pt}
</style>
</HEAD>
<body bgcolor=#d4d0c8 topmargin=0>
<%
If bWorking = true Then
'업로드 진행 상태를 출력합니다.
Response.Write "<table border=0 style='FONT-SIZE: 9pt' width=370 cellpadding=0 cellspacing=0 bgcolor=#d4d0c8>"
Response.Write "<tr>"
Response.Write "	<td colspan=2 height=25 valign=bottom><b>파일 업로드 중... </b></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td colspan=2 width=360>"
Response.Write "		<table style='border:solid 1px;' width=370 height=15 cellpadding=0 cellspacing=0 bordercolor=#000000 leftmargin=0 topmargin=0>"
Response.Write "			<tr>"
Response.Write "				<td width=100% height=100% align=left valign=middle style=padding:1;>"
Response.Write "					<table height=100% cellpadding=0 cellspacing=0 width =" & (3.55*Percent) & "></td>"
Response.Write "						<tr><td bgcolor='darkblue'></td></tr>"
Response.Write "					</table>"
Response.Write "				</td>"
Response.Write "			</tr>"
Response.Write "		</table>"
Response.Write "	</td>"
Response.Write "</tr>"
Response.Write "<tr><td>&nbsp;</td></tr>"
Response.Write "<tr>"
Response.Write "	<td align=left>전송 파일 : " & strFileName & "</td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td align=left>전송 속도 : " & round(BytesPer/(1024*1024),2) & " MB / sec </td>"
Response.Write "</tr>"
Response.Write "<tr>" 
Response.Write "	<td align=left>진행률 : " & round(TransferBytes/(1024*1024),2) & " MB / " & round(TotalBytes /(1024*1024),2) & " MB (" & Percent & "%)</td>"
Response.Write "</tr>"
Response.Write "</table>"
Response.Write "<tr><td>&nbsp;</td></tr>"
Response.Write "<table border=0 width=360 cellpadding=0 cellspacing=0 bgcolor=#d4d0c8>"
Response.Write "<tr><td>데이타 전송중입니다... 잠시만 기달려주세요.</td></tr>"
Response.Write "</table>"
Else
	'업로드가 완료 또는 IE 중지 버튼 누를 시
	Response.Write("<body onload='javascript: top.window.close();'>")
End If
%>
</body>
</HTML>
