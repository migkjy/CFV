<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%
'**************** 정렬 컬럼 추가*****************
'Alter Table ph010 Add DISP_OR SMALLINT
'Alter Table ph020 Add DISP_OR SMALLINT
'************************************************ 
'데이터베이스를 open하기 위한 프로시져
	SUB OpenCSDB(ByRef DB)
		SET DB = Server.CreateObject("ADODB.Connection")
		DB.Provider = "sqloledb"
		DB.CursorLocation = 3
		DB.Open DSNinfoCS
	END SUB

	'데이터베이스를 Close하기 위한 프로시져
	SUB CloseCSDB(ByRef DB)
		DB.Close
		set DB = Nothing
	END SUB
'서버 정보


SUB OpenCSDB(ByRef DB)
	
	CONST str_test = "Data Source=db.cfcation.gabia.io,1433;Network Library=dbmssocn;Initial Catalog=dbcfcation;User ID=cfcation;Password=dragon64^^;"
	
	SET DB = Server.CreateObject("ADODB.Connection")
	DB.Provider = "sqloledb"
	DB.CursorLocation = 3
	DB.Open str_test
END SUB

'Database Close
SUB CloseDB(ByRef DB)
	DB.Close
	SET DB = Nothing
END SUB





'== 이미지 사이즈 구분 코드, 이미지 사이즈 구하기 ===========================================================
Function fnCdSize(fgName, goodType)
	OpenCsDB db
	sql		= "				Select CD_FG, CD, CD_NM, ISNULL(CHAR_FR,'') AS SIZEA, ISNULL(CHAR_TO,'') AS SIZEB "
	sql		= sql & "					,(SELECT COUNT(CD) FROM TB_BA001 WHERE CD_FG='SIZE' "
	sql		= sql & "					) AS SIZECOUNT "
	sql		= sql & "			From TB_Ba001 "
	sql		= sql & "		Where Cd_fg in('"& fgName &"','SIZE') AND DEL_FG='N'"

'RESPONSE.WRITE SQL

	Set Rs	= Db.Execute(sql)

	if Not Rs.Eof Then
		sizeCdCount	= Rs("SizeCount")-1
		ReDim sizeCd(sizeCdCount), sizeCdNm(sizeCdCount)
		i=0
																		'********** 이미지 사이즈 구분 코드 구하기 *********************
		Do Until Rs.Eof or i > sizeCdCount
			if Rs("CD_FG")=Trim(fgName)  Then							'********** 이미지 사이즈 구하기 ******************************
					if Ucase(Rs("CD"))="A" Then 
						imgA = Rs("SIZEA") & "," & Rs("SIZEB")
					ELSEif Ucase(Rs("CD"))="B" Then 
						imgB = Rs("SIZEA") & "," & Rs("SIZEB")
	
					End if
			Else	 															'********** 이미지 사이즈 구하기 ******************************
					sizeCd(i)		= Rs("CD")
					sizeCdNm(i)	= Rs("CD_NM")
				i = i+1
			End if															'********** 이미지 사이즈 구분 코드 구하기 *********************
			Rs.MoveNext	
		Loop
	End if
	Rs.Close
	CloseDB DB

	
	Response.Write "<Select Name='goodSizeS' onChange='fnSizeChange(this.value)'  class='box' style='width:75'>"
	'Response.Write "<option value=''>   선택안함  </option>"

	if g_code<>"" Then
		'For k=0 To sizeCdCount
			Response.Write "<option value='" & sizeCd(k) &"' "
				if Cstr(sizeCd(k))=Cstr(sizeCd1) Then Response.Write " selected "
			Response.Write ">" & sizeCdNm(k) &"</option>"
		'Next
		Response.Write "</Select>"
		Response.Write	"<input type='hidden' name='imgA' value='"&imgA&"'>"		&_
								"<input type='hidden' name='imgB' value='"&imgB&"'>"		&_
								"<input type='hidden' name='imgC' value='"&imgC&"'>"
	Else
		Response.Write "<option value=''>구분없음</option>"
	End if
	Set Rs = Nothing

End Function 
'== 이미지 사이즈 구분 코드, 이미지 사이즈 구하기 ===========================================================

'== 이미지 사이즈 구분 코드, 이미지 사이즈 구하기 ===========================================================
'###14년 12월 29일 수정
'// 이미지 이름 리턴 (자리수+값)  //////////////////////////////////
Function fnImgName(strNum)
	strLen	= Cstr(Len(strNum))
	'response.write strLen
	
	Select Case strLen
		Case "1"
			strNum	= "000" & strNum
		Case "2"
			strNum	= "00" & strNum
		Case "3"
			strNum	= "0" & strNum
		Case Else
			strNum	= strNum		
	End Select
	'response.write strNum&"<br>"
	fnImgName	= strNum
End Function

Function fnImgName_k(strNum)
	strLen	= Cstr(Len(strNum))
	'response.write strLen&"<br>"
	
	Select Case strLen
		Case "1"
			strNum	= "00" & strNum
		Case "2"
			strNum	= "0" & strNum
		Case "3"
			strNum	= "" & strNum
		Case Else
			strNum	= strNum		
	End Select
	'response.write strNum&"<br>"
	fnImgName_k	= strNum
End Function

Function fnImgName_j(strNum)
	strLen	= Cstr(Len(strNum))
	'response.write strLen&"<br>"
	
	Select Case strLen
		Case "1"
			strNum	= "0" & strNum
		Case "2"
			strNum	= "" & strNum
		Case "3"
			strNum	= "" & strNum
		Case Else
			strNum	= strNum		
	End Select
	'response.write strNum&"<br>"
	fnImgName_j	= strNum
End Function
'// 이미지 이름 리턴 (자리수+값)  //////////////////////////////////

Function fnImgName_f(strNum)
	strLen	= Cstr(Len(strNum))
	'response.write strLen&"<br>"
	Select Case strLen
	  Case "3"
			strNum	= "000000" & strNum
	  Case "4"
			strNum	= "00000" & strNum
	  Case "5"
			strNum	= "0000" & strNum
		Case "6"
			strNum	= "000" & strNum
		Case "7"
			strNum	= "00" & strNum
		Case "8"
			strNum	= "0" & strNum
		Case Else
			strNum	= strNum		
	End Select
	'response.write strNum&"<br>"
	'response.end
	fnImgName_f	= strNum
	
	'###14년 12월 29일 수정끝
End Function

SUB fnAlert(ByRef data1, ByRef msg1,ByRef data2, ByRef msg2,ByRef data3, ByRef msg3,ByRef data4, ByRef msg4)
	IF data1="" THEN Response.Write	msg1 &"(이)가 비었습니다. <br>"
	IF data2="" THEN Response.Write	msg2 &"(이)가 비었습니다. <br>"
	IF data3="" THEN Response.Write	msg3 &"(이)가 비었습니다. <br>"
	IF data4="" THEN Response.Write	msg4 &"(이)가 비었습니다. <br>"
	Response.End
END SUB

'==	이미지 크기  구하기	=============================================================
Function fnFsoSize(byval getUrl1, byval imgPath, byval noImgPath)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
		strMapPath = server.mapPath("../")
		getUrl	= strMapPath & getUrl1 & ImgPath												'== 사이즈 이미지

		if fso.FileExists(getUrl) Then
			Set file			= fso.GetFile(getUrl)
			fileSize			= file.Size 
		Else
			fileSize			= 0
		End if
	Set fso = Nothing
	fnFsoSize = fileSize
End Function
'==	이미지 크기  구하기	=============================================================

'==	이미지 가상 경로  구하기	=============================================================
Function fnFsoContents(byval getUrl1, byval imgPath, byval noImgPath)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
		strMapPath = server.mapPath("../")
		getUrl	= strMapPath & getUrl1 & ImgPath												'== 사이즈 이미지
		imgUrl	= getUrl1 & ImgPath

		if fso.FileExists(getUrl) Then
			imgContents	= imgUrl
		Else
			imgContents	= noImgPath
		End if
	Set fso = Nothing
	fnFsoContents	 = Replace(imgContents,"\","/")
End Function
'==	이미지 가상 경로  구하기	=============================================================

'==	이미지 물리적 경로  구하기	=============================================================
Function fnFsoUrl(byval getUrl1, byval imgPath, byval noImgPath)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
		strMapPath = server.mapPath("../")
		getUrl	= strMapPath & getUrl1 & ImgPath												'== 사이즈 이미지

		if fso.FileExists(getUrl) Then
			imgContents	= getUrl
		Else
			imgContents	= noImgPath
		End if
	Set fso = Nothing
	fnFsoUrl	 = imgContents
End Function
'==	이미지 물리적 경로  구하기	=============================================================

'==	이미지 삭제	=============================================================
Function fnFsoDelete(byval filePath)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
		if FSO.FileExists(filePath) Then  FSO.DeleteFile(filePath)
	Set fso = Nothing
End Function
'==	이미지 삭제	=============================================================

'==	결과 페이지 보내기	=============================================================
Function fnGoUrl(byval Url)
response.Redirect(url)			
	Response.End
End Function 
'==	결과 페이지 보내기	=============================================================

'==	뒤로 보내기	=============================================================
Function fnGoBack(byval msg)
	Response.Write	"	<Script language=Javascript>		"	&_
							"		alert('"& msg &"');					"	&_			
							"		history.back();						"	&_
							"	</Script>									"
	Response.End
End Function 
'==	뒤로 보내기	=============================================================
 
%>