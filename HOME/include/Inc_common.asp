<%
	'���ȼ��� ��뿩�� 
	'-----------------
	Public Function isSecurity()
		If Request.ServerVariables("HTTPS") = "on" Then
			isSecurity = True
		Else
			isSecurity = False
		End If
  End Function
	'-----------------
	'���ȼ��� Protocol ��� �ּҷ� �̵�
	'----------------------------------
	Public Sub useSecurity(ByVal returnURL)
		Dim items

		If returnURL = "" Then
			returnURL = Request.ServerVariables("URL") & Request.ServerVariables("QUERY_STRING")
		End If

		With Response
			.Write "<form id=""frmSecurity"" method=""get"" action=""https://" & Request.ServerVariables("HTTP_HOST") & returnURL & """>"

			'Request.Form���� ���۵Ǿ�� ������ �ٽ� ���ȼ����� ����
			'-------------------------------------------------------
			For Each items In Request.Form
				.Write "<input type=""hidden"" name=""" & items & """ values=""" & Request.Form(items) & """>"
			Next
			'-------------------------------------------------------

			.Write "</form>"
			.Write "<script type=""text/javascript""> window.onload = function() { document.getElementById(""frmSecurity"").submit(); }; </script>"
			.End()
		End With
  End Sub
	'----------------------------------


	'������ �Ǻ�
	'-------------
	Function isIE()
		If InStr(1, Request.ServerVariables("HTTP_USER_AGENT"), "MSIE") > 0 Then
			isIE = True
		Else
			isIE = False
		End If
	End Function
	'-------------


	'�޼�����¹ڽ� (JScript)
	'-----------------------------------------
	Sub showMsgBox(ByVal sMsg, ByVal sURL)
		If IsObject(rs) Then
			If (rs.State = adStateOpen) Then
				rs.Close
			End If

			Set rs = Nothing
		End If

		

		With Response
			.Write "<script type=""text/javascript"">"
			.Write "alert(""" & sMsg & """);"
			.Write sURL
			.Write "</script>"
		End With
	End Sub
	'-----------------------------------------


	'���������� ��ο� ���� ��� ��ġ���� Ȯ��
	'-----------------------------------------
	Public Function checkReferURL()
		Dim referURL, currentURL

		referURL = Request.ServerVariables("HTTP_REFERER")
		currentURL = Request.ServerVariables("HTTP_HOST")

		'���������� ȣ��Ʈ�ּ� ��������
		referURL = Replace(referURL, "http://", "")
		referURL = Left(referURL, InStr(1, referURL, "/") - 1)

		If referURL = currentURL Then
			checkReferURL = True
		Else
			checkReferURL = False
		End If
	End Function
	'-----------------------------------------


	'�Է°��� �������� �˻�
	'----------------------
	Public Function isNum(sCheck)
		Dim sPatrn : sPatrn = "^[0-9-]+$"

		If IsNull(sCheck) Then
			isNum = False
		Else
			isNum = RegExp_Test(sPatrn, sCheck)
		End If
  End Function
	'----------------------


	'�Է°��� ���� + ���������� �˻�
	'-------------------------------
	Public Function isEng(sCheck)
		Dim sPatrn : sPatrn = "^[a-zA-Z0-9]+$"

		If IsNull(sCheck) Then
			isEng = False
		Else
			isEng = RegExp_Test(sPatrn, sCheck)
		End If
  End Function
	'-------------------------------

	
	'��������� �Է°� *����ǥ��
	'---------------------------
	Public Function isVal(sPatrn, sCheck)
		isVal = RegExp_Test(sPatrn, sCheck)
  End Function
	'---------------------------


	'�Է°��� ��ȭ��ȣ���� �˻�
	'--------------------------	
	Public Function Chk_Phone(sCheck)
		If isVal("^(?:\d{2}|\d{3})-(?:\d{2}|\d{3}|\d{4})-(?:\d{3}|\d{4})$", sCheck) Then
			Chk_Phone = True
		Else
			Chk_Phone = False
		End If
	End Function
	'--------------------------

 
	'��¥���
	'-------------------
	Public Function prtDate(ByVal tag, ByVal dateText)
		Dim resultText
		Dim yearPrt, monthPrt, dayPrt, hourPrt24, hourPrt12, minutePrt, secondPrt, ampmPrt
		Dim weekNames : weekNames = Array ("", "��", "��", "ȭ", "��", "��", "��", "��")
		Dim weekEngNames : weekEngNames = Array ("", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
		Dim weekNamePrt, weekEngNamePrt

		If IsDate(dateText) Then
			dateText = CDate(dateText)
			yearPrt = Year(dateText)
			monthPrt = Right("0" & Month(dateText), 2)
			dayPrt = Right("0" & Day(dateText), 2)
			hourPrt24 = Right("0" & Hour(dateText), 2)
			minutePrt = Right("0" & Minute(dateText), 2)
			secondPrt = Right("0" & Second(dateText), 2)
			weekEngNamePrt = weekEngNames(DatePart("w", dateText))
			weekNamePrt = " (" & weekNames(DatePart("w", dateText)) & ")"

			hourPrt12 = Hour(dateText)

			If Hour(dateText) > 12 Then
				hourPrt12 = hourPrt12 - 12
			End If

			hourPrt12 = Right("0" & CStr(hourPrt12), 2)

			If Hour(dateText) > 11 Then
				ampmPrt = " PM "
			Else
				ampmPrt = " AM "
			End If

			Select Case tag
			Case "YMD"
				resultText = yearPrt & "-" & monthPrt & "-" & dayPrt
			Case "YMDW"
				resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & weekNamePrt
			Case "YMDHM"
				resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt
			Case "MD"
				resultText = monthPrt & "-" & dayPrt
			Case "MDW"
				resultText = monthPrt & "-" & dayPrt & weekNamePrt
			Case "MDHM"
				resultText = monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt
			Case "MDHMS"
				resultText = monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt & ":" & secondPrt
			Case "KMDW"
				resultText = monthPrt & "�� " & dayPrt & "��" & weekNamePrt
			Case "KMD"
				resultText = monthPrt & "�� " & dayPrt & "��"
			Case "24"
				resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt & ":" & secondPrt
			Case Else
				resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & ampmPrt & hourPrt12 & ":" & minutePrt & ":" & secondPrt
			End Select
		Else
			resultText = ""
		End If

		prtDate = resultText
	End Function
	'-------------------

	
	'���ڿ����� ����Ʈ�� ���
	'------------------------
	Public Function LenByte(ByRef sText)
		Dim nCount, nSeqNo, sChar, nAsc

		nCount = 0

		If isNull(sText) = False Or Len(sText) > 0 Then
			For nSeqNo = 1 To Len(sText)
				sChar = Mid(sText, nSeqNo, 1)
				nAsc = CInt(Asc(sChar))

				If nAsc <> 10 Then
					If nAsc > 0 And nAsc < 255 Then
						nCount = nCount + 1
					Else
						nCount = nCount + 2
					End If
				End If
			Next
		End If

		LenByte = nCount
	End Function
	'------------------------


	'���ڿ����� �ѱ۰������
	'-----------------------
	Public Function MidByte(ByRef sText, ByVal nStart, ByVal nLength)
		Dim nCount, nSeqNo, sChar, nAsc, sResultStr

		nCount = 0
		sResultStr = ""

		If isNull(sText) = False Or Len(sText) > 0 Then
			For nSeqNo = 1 To Len(sText)
				sChar = Mid(sText, nSeqNo, 1)
				nAsc = CInt(Asc(sChar))

				If nAsc <> 10 Then
					If nAsc > 0 And nAsc < 255 Then
						nCount = nCount + 1
					Else
						nCount = nCount + 2
					End If
				End If

				If nCount >= nStart Then
					sResultStr = sResultStr & sChar

					If nCount >= (nStart + nLength - 1) Then
						Exit For
					End If
				End If
			Next
		End If

		MidByte = sResultStr
	End Function
	'-----------------------


	'���ڰ� �ޱ� (SQL Injection ����)
	'--------------------------------
	Public Function Req(ByVal FieldType, ByVal FieldName)
		Dim ReqValue

		'�޴� ���ڰ� ���� ����
		'Q: QueryString, F:Form
		If isVal("^[QF]$", FieldType) Then
			FieldType = UCase(FieldType)
		Else
			FieldType = "Q"
		End If

		Select Case FieldType
		Case "Q"
			ReqValue = Request.QueryString(FieldName)
		Case "F"
			ReqValue = Request.Form(FieldName)
		End Select

		If Len(ReqValue) > 0 Then
			ReqValue = Trim(ReqValue)
			ReqValue = Replace(ReqValue, ";", "")
			ReqValue = Replace(ReqValue, ",", "")
		End If

		Req = ReqValue
	End Function
	'--------------------------------


	'���ε��� ���ڰ� �ޱ� (SQL Injection ����)
	'-----------------------------------------
	Public Function Upload(ByVal FieldName)
		Dim ReqValue

		ReqValue = UploadForm(FieldName)

		If Len(ReqValue) > 0 Then
			ReqValue = Trim(ReqValue)
			ReqValue = Replace(ReqValue, ";", "")
			ReqValue = Replace(ReqValue, ",", "")
		End If

		Upload = ReqValue
	End Function
	'-----------------------------------------


	'���ڿ� ġ��
	'-----------
	Function Text_Convert(ByVal Tag, ByRef Source_Text)
		If Len(Source_Text) > 0 Then
			Select Case UCase(Tag)
			Case "W"
				Source_Text = Trim(Source_Text)
				Source_Text = Replace(Source_Text, "��", "")
				Source_Text = Replace(Source_Text, "'", "$27")
				Source_Text = Replace(Source_Text, """", "$27")
			Case "C"
				Source_Text = Trim(Source_Text)
				Source_Text = Replace(Source_Text, "��", "")
				Source_Text = Replace(Source_Text, "'", "")
				Source_Text = Replace(Source_Text, """", "")
				Source_Text = Replace(Source_Text, "<", "")
				Source_Text = Replace(Source_Text, ">", "")
			Case "V"
				Source_Text = Replace(Source_Text, "&", "&amp;")
				Source_Text = Replace(Source_Text, "<", "&lt;")
				Source_Text = Replace(Source_Text, ">", "&gt;")
				Source_Text = Replace(Source_Text, "$27", "'")
			Case "M"
				Source_Text = Replace(Source_Text, "$27", "'")
			End Select
		End If

		Text_Convert = Source_Text
	End Function
	'-----------

	
	'�������� ġ��
	'-------------
	Function Contents_Convert(ByVal Tag, ByRef Source_Text)
		If Len(Source_Text) > 0 Then
			Select Case UCase(Tag)
			Case "W"
				Source_Text = CheckHTML(Source_Text)

				Source_Text = Replace(Source_Text, "&amp;", "&")
				Source_Text = Replace(Source_Text, "&amp", "&")
				Source_Text = Replace(Source_Text, "'", "$27")
				Source_Text = Replace(Source_Text, """", "$22")
			Case "C"
				Source_Text = Replace(Source_Text, "$27", "'")
				Source_Text = Replace(Source_Text, "$22", """")
				Source_Text = Replace(Source_Text, Chr(13) & Chr(10), "<br>")
			Case "V"
				Source_Text = Replace(Source_Text, "$27", "'")
				Source_Text = Replace(Source_Text, "$22", """")
				Source_Text = advReplace(Source_Text, "<br>", "<br>" & vbCRLF)
			Case "M"
				Source_Text = Replace(Source_Text, "$27", "'")
				Source_Text = Replace(Source_Text, "$22", """")
			End Select
		End If

		Contents_Convert = Source_Text
	End Function
	'-------------

	
	'����� �� ���� �±�, �̺�Ʈ, �ڹٽ�ũ��Ʈ ����
	'----------------------------------------------
	Public Function CheckHTML(ByRef E_Source)
		Dim NotEvent_Str, NotTAG_Str, Pattern, Seq_Num, S_Idx, E_Idx, Pre_Idx, Work_Str
		Dim Result_Match, Result_Matches_Collection

		'** ASP �������
		E_Source = advReplace(E_Source, Chr(60) & "%", "&lt;%")
		E_Source = advReplace(E_Source, "%" & Chr(62), "%&gt;")

		'** ��������� �ױ� ó��
		NotTAG_Str = Array ("iframe", "applet", "input", "select", "button", "form", "div", "span")

		For Seq_Num = 0 To UBound(NotTAG_Str)
			Pattern = "<" & NotTAG_Str(Seq_Num) & "[^>]*>"

			Set Result_Matches_Collection = RegExpExec(Pattern, E_Source)

			For Each Result_Match In Result_Matches_Collection
				'Response.Write "<XMP>" & Result_Match.Value & "</XMP><br>"
				E_Source = Replace(E_Source,Result_Match.Value,"")
			Next

			E_Source = advReplace(E_Source, "</" & NotTAG_Str(Seq_Num) & ">", "")
		Next

		'** �̺�Ʈ, �Ӽ��±� ó��
		NotEvent_Str = Array ("onclick", "ondblclick", "onload", "onfocus", "onblur", "onmouseover", "onmouseout", "ontextmenu", "id", "class")

		For Seq_Num = 0 To UBound(NotEvent_Str)
			Pattern = NotEvent_Str(Seq_Num) & "=[\""\']*[^|)|>|\s]*[\""|'|)|\s]*"

			Set Result_Matches_Collection = RegExpExec(Pattern, E_Source)

			For Each Result_Match In Result_Matches_Collection
				'Response.Write "<XMP>" & Result_Match.Value & "</XMP><br>"
				E_Source = Replace(E_Source,Result_Match.Value,"")
			Next
		Next

		'** ��ũ��Ʈ ó��
		S_Idx = ""
		E_Idx = ""
		Pre_Idx = ""
		Pattern = "<script[^>]+|</s"
		Pattern = Split(Pattern,"|")

		For Seq_Num = 0 To UBound(Pattern)
			Set Result_Matches_Collection = RegExpExec(Pattern(Seq_Num), E_Source)

			For Each Result_Match In Result_Matches_Collection
				If Seq_Num = 0 Then
					S_Idx = S_Idx & Result_Match.FirstIndex & "|"
				Else
					E_Idx = E_Idx & Result_Match.FirstIndex & "|"
				End If
			Next
		Next

		S_Idx = Split(S_Idx,"|")
		E_Idx = Split(E_Idx,"|")

		For Seq_Num = 0 To UBound(S_Idx) - 1
			If Pre_Idx = "" Then
				Work_Str = Mid(E_Source, S_Idx(Seq_Num), E_Idx(Seq_Num)-S_Idx(Seq_Num))
			Else
				Work_Str = Mid(E_Source, S_Idx(Seq_Num)-Pre_Idx, E_Idx(Seq_Num)-S_Idx(Seq_Num))
			End If

			E_Source = Replace(E_Source, Work_Str, "")
			Pre_Idx = CInt(E_Idx(Seq_Num)-S_Idx(Seq_Num))
		Next

		E_Source = advReplace(E_Source, "</script>", "")	
		'** ��ũ��Ʈ ó�� �Ϸ�

		CheckHTML = E_Source
	End Function
	'----------------------------------------------


	'����ȭ ���� �Լ�
	'----------------
	Public Function RegExp_Test(sPatrn, sCheck)
		Dim oRegExp

		If sPatrn = "" Or sCheck = "" Then
			RegExp_Test = False
		Else
			Set oRegExp = New RegExp

			oRegExp.Pattern = sPatrn
			oRegExp.IgnoreCase = True

			RegExp_Test = oRegExp.Test(sCheck)

			Set oRegExp = Nothing
		End If
	End Function
	
	Public Function RegExpExec(Patrn, TestStr)
		Dim ObjRegExp
		
		On Error Resume Next

		Set ObjRegExp = New RegExp

		ObjRegExp.Pattern = Patrn			'** ���� ǥ���� ����
		ObjRegExp.Global = True				'** ���ڿ� ��ü�� �˻���
		ObjRegExp.IgnoreCase = True		'** ��.�ҹ��� ���� ����

		Set RegExpExec = ObjRegExp.Execute(TestStr)
		Set ObjRegExp = Nothing
	End Function

	'------------------------------
	'��ҹ��� ���о��� Replace ����
	'------------------------------
	Public Function advReplace(ByRef Str, ByVal Patrn, ByVal ReplStr)
		Dim ObjRegExp
		
		On Error Resume Next

		Set ObjRegExp = New RegExp

		ObjRegExp.Pattern = Patrn			'** ���� ǥ���� ����
		ObjRegExp.Global = True				'** ���ڿ� ��ü�� �˻���
		ObjRegExp.IgnoreCase = True		'** ��.�ҹ��� ���� ����

		advReplace = ObjRegExp.Replace(Str, ReplStr)
		Set ObjRegExp = Nothing
	End Function
	'----------------
%>