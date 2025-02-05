<%
    '메세지출력박스 (JScript)
    '-----------------------------------------
    ' 원하는 멘트로 경고창을 표시
    '----------------------------------------- 
    ' prtText       : 표시할 메시지
    ' locationURL   : 경고창 종료후 취할 액션
    '-----------------------------------------
    Sub showMsgBox(ByVal prtText, ByVal locationURL)
        If IsObject(rs) Then
            If (rs.State = adStateOpen) Then
                rs.Close
            End If

            Set rs = Nothing
        End If

        If IsObject(db) Then
            If (Not db Is Nothing) Then
                If (db.State = adStateOpen) Then
                    db.Close
                End If

                Set db = Nothing
            End If
        End If

        With Response
            .Write("<script type=""text/javascript"">")
            .Write("alert(""" & prtText & """);")
            .Write(locationURL)
            .Write("</script>")
        End With
    End Sub


    '입력값이 숫자인지 검사
    '-------------------------
    Public Function isNum(ByVal checkText)
        Dim partrn : partrn = "^[0-9-]+$"

        If IsNull(checkText) Then
            isNum = False
        Else
            isNum = RegExp_Test(partrn, checkText)
        End If
    End Function


    '입력값이 정수(smallint) 형식인지 확인
    ' -32,768 에서 32,767
    '--------------------------------------
    Public Function isInt16(ByVal checkText)
        Dim test

        If isNum(checkText) Then
            On Error Resume Next
            test = CInt(checkText)
            
            If Len(Err.Description) > 0 Then
                isInt16 = False
            Else
                isInt16 = True
            End If

            Err.Clear
        Else
            isInt16 = False
        End If
    End Function


    '입력값이 정수(Long) 형식인지 확인
    ' -2,147,483,648에서 2,147,483,647까지
    '--------------------------------------
    Public Function isInt32(ByVal checkText)
        Dim test

        If isNum(checkText) Then
            On Error Resume Next
            test = CLng(checkText)
            
            If Len(Err.Description) > 0 Then
                isInt32 = False
            Else
                isInt32 = True
            End If

            Err.Clear
        Else
            isInt32 = False
        End If
    End Function


    '입력값이 숫자 + 영문자인지 검사
    '-----------------------------------
    Public Function isEng(ByVal checkText)
        Dim partrn : partrn = "^[a-zA-Z0-9]+$"

        If IsNull(checkText) Then
            isEng = False
        Else
            checkText = Replace(checkText, " ", "")
            isEng = RegExp_Test(partrn, checkText)
        End If
    End Function

	
    '사용자정의 입력값 *정규표현
    '-------------------------------
    Public Function isVal(ByVal partrn, ByVal checkText)
        If IsNull(checkText) Then
            isVal = False
        Else
            isVal = RegExp_Test(partrn, checkText)
        End If
    End Function


	'날짜출력
	'-------------------------------------------
	' 날짜형 데이터를 해당 형식에 맞게 출력
	' tag       : 날짜출력구분
	' dateText  : 날짜형 데이터
	'
	' * 필요에의해 추가될 수 있음
	'-------------------------------------------
    Public Function prtDate(ByVal tag, ByVal dateText)
        Dim resultText
        Dim yearPrt, monthPrt, dayPrt, hourPrt24, hourPrt12, minutePrt, secondPrt, ampmPrt
        Dim weekNames : weekNames = Array ("", "일", "월", "화", "수", "목", "금", "토")
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
            weekNamePrt = weekNames(DatePart("w", dateText))
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
                Case "KYMD"
                    resultText = yearPrt & "년 " & monthPrt & "월 " & dayPrt & "일"
                Case "YMDW"
                    resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & " (" & weekNamePrt & ")"
                Case "KYMDW"
                    resultText = yearPrt & "년 " & monthPrt & "월 " & dayPrt & "일 " & weekNamePrt & "요일"
                Case "YMDHM"
                    resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt
                Case "YMDHMS"
                    resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt & ":" & secondPrt
                Case "MDW"
                    resultText = monthPrt & "-" & dayPrt & " (" & weekNamePrt & ")"
                Case "MDHM"
                    resultText = monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt
                Case "MDHMS"
                    resultText = monthPrt & "-" & dayPrt & " " & hourPrt24 & ":" & minutePrt & ":" & secondPrt
                Case Else
                    resultText = yearPrt & "-" & monthPrt & "-" & dayPrt & ampmPrt & hourPrt12 & ":" & minutePrt & ":" & secondPrt
                End Select
        Else
            resultText = ""
        End If

        prtDate = resultText
    End Function

	
    '문자열길이 바이트로 계산
    '----------------------------
    ' 바이트단위 계산
    '----------------------------
    Public Function LenByte(ByRef checkText)
        Dim counter, seqNo, currentASC

        counter = 0

        If isNull(checkText) = False Or Len(checkText) > 0 Then
            For seqNo = 1 To Len(checkText)
                currentASC = CInt(Asc(Mid(checkText, seqNo, 1)))

                '아스키코드가 255가 넘어가면 확장코드로 2바이트 문자로 계산됨
                If currentASC <> 10 Then
                    If currentASC > 0 And currentASC < 255 Then
                        counter = counter + 1
                    Else
                        counter = counter + 2
                    End If
                End If
            Next
        End If

        LenByte = counter
    End Function


	'문자열추출 바이트로 계산
	'---------------------------
	' Mid 바이트단위 계산
	'---------------------------
    Public Function MidByte(ByRef checkText, ByVal startPos, ByVal cutLength)
        Dim counter, seqNo, currentChar, currentASC, resultStr

        counter = 0
        resultStr = ""

        If isNull(checkText) = False Or Len(checkText) > 0 Then
            For seqNo = 1 To Len(checkText)
                currentChar = Mid(checkText, seqNo, 1)
                currentASC = CInt(Asc(currentChar))

                If currentASC <> 10 Then
                    If currentASC > 0 And currentASC < 255 Then
                        counter = counter + 1
                    Else
                        counter = counter + 2
                    End If
                End If

                If counter >= startPos Then
                    resultStr = resultStr & currentChar

                    If counter >= (startPos + cutLength - 1) Then
                        Exit For
                    End If
                End If            
            Next
        End If

        MidByte = resultStr
    End Function


    '------------------------------------------
    ' 파일 확장자 가져오기
    '------------------------------------------
    Function getFileExt(ByVal fileName)
        Dim pos

        If Not(fileName = "") Then
            pos = InStrRev(fileName, ".", -1)
            fileName = Mid(fileName, pos + 1, Len(fileName) - pos)
            getFileExt = fileName
        Else
            getFileExt = ""
        End If
    End Function


    '------------------------------------------
    ' 그림크기 크기에 따른 비율 구하기
    '------------------------------------------
    ' imgWidth      : 가로크기
    ' imgHeight     : 세로크기
    ' changeWidth   : 변경할 가로크기
    ' changeHeight  : 변경할 세로크기

    ' * 변경할 가로크기가 0이면 세로크기 구함
    '------------------------------------------
    Function getRatio(ByVal imgWidth, ByVal imgHeight, ByVal changeWidth, ByVal changeHeight)
        Dim mok, result

        result = -1

        If changeHeight = 0 Then
            '------------------
            '세로폭 비율 구하기
            '------------------
            mok = Round(imgWidth / changeWidth, 2)
            result = Round(imgHeight / mok, 0)
        ElseIf changeWidth = 0 Then
            '------------------
            '가로폭 비율 구하기
            '------------------
            mok = Round(imgHeight / changeHeight, 2)
            result = Round(imgWidth / mok, 0)
        End If

        getRatio = CInt(result)
    End Function
	

    '문자열 치한
    '----------------------------------
    ' SQL Injection 방지용
    '
    ' tag
    '   W : 저장할 경우
    '   C : 제한문자를 모두 제거할 경우
    '   V : 페이지에 보여줄 경우
    '   M : 수정할 경우
    '----------------------------------
    Function textConvert(ByVal tag, ByRef sourceText)
        If IsNull(sourceText) Or Len(sourceText) = 0 Then
            sourceText = ""
        Else
            Select Case UCase(tag)
            Case "W"
                sourceText = Trim(sourceText)
                sourceText = Replace(sourceText, "　", "")
                sourceText = Replace(sourceText, "'", "$27")
                sourceText = Replace(sourceText, """", "$27")
            Case "C"
                sourceText = Trim(sourceText)
                sourceText = Replace(sourceText, "　", "")
                sourceText = Replace(sourceText, "'", "")
                sourceText = Replace(sourceText, """", "")
                sourceText = Replace(sourceText, "<", "")
                sourceText = Replace(sourceText, ">", "")
                sourceText = Replace(sourceText, "%", "")
            Case "V"
                sourceText = Replace(sourceText, "&", "&amp;")
                sourceText = Replace(sourceText, "<", "&lt;")
                sourceText = Replace(sourceText, ">", "&gt;")
                sourceText = Replace(sourceText, "$27", "'")
            Case "M"
                sourceText = Replace(sourceText, "$27", "'")
            End Select
        End If

        textConvert = sourceText
    End Function

	
    '본문내용 치한
    '----------------------------------
    ' SQL Injection 방지용
    ' 에디터로 사용되는 본문내용 변환
    '
    ' tag
    '   W : 저장할 경우
    '   C : 제한문자를 모두 제거할 경우
    '   V : 페이지에 보여줄 경우
    '   M : 수정할 경우
    '----------------------------------
    Function contentsConvert(ByVal tag, ByRef sourceText)
        If IsNull(sourceText) Or Len(sourceText) = 0 Then
            sourceText = ""
        Else
            Select Case UCase(tag)
            Case "W"
                sourceText = CheckHTML(sourceText)
                sourceText = Replace(sourceText, "&amp;", "&")
                sourceText = Replace(sourceText, "&amp", "&")
                sourceText = Replace(sourceText, "'", "$27")
                sourceText = Replace(sourceText, """", "$22")
            Case "C"
                sourceText = Replace(sourceText, "$27", "'")
                sourceText = Replace(sourceText, "$22", """")
                sourceText = Replace(sourceText, Chr(13) & Chr(10), "<br>")
            Case "V"
                sourceText = Replace(sourceText, "$27", "'")
                sourceText = Replace(sourceText, "$22", """")
                sourceText = advReplace(sourceText, "<br>", "<br>" & vbCRLF)
            Case "M"
                sourceText = Replace(sourceText, "$27", "'")
                sourceText = Replace(sourceText, "$22", """")
            End Select
        End If

        contentsConvert = sourceText
    End Function

	
    '사용할 수 없는 태그, 이벤트, 자바스크립트 제거
    '----------------------------------------------------
    ' 에디터의 사용된 글의 제한글 삭제
    '----------------------------------------------------
    Public Function CheckHTML(ByRef contentsText)
        Dim notEventStr, notTagStr, pattern, seqNo, S_Idx, E_Idx, Pre_Idx, Work_Str
        Dim Result_Match, Result_Matches_Collection

        '** ASP 사용제한
        contentsText = advReplace(contentsText, Chr(60) & "%", "&lt;%")
        contentsText = advReplace(contentsText, "%" & Chr(62), "%&gt;")

        '** 사용제한할 테그 처리
        notTagStr = Array ("iframe", "applet", "input", "select", "button", "form")

        For seqNo = 0 To UBound(notTagStr)
            pattern = "<" & notTagStr(seqNo) & "[^>]*>"

            Set Result_Matches_Collection = RegExpExec(pattern, contentsText)

            For Each Result_Match In Result_Matches_Collection
                'Response.Write "<XMP>" & Result_Match.Value & "</XMP><br>"
                contentsText = Replace(contentsText, Result_Match.Value, "")
            Next

                contentsText = advReplace(contentsText, "</" & notTagStr(seqNo) & ">", "")
        Next

        '** 이벤트, 속성태그 처리
        notEventStr = Array ("ondblclick", "onload", "onfocus", "onblur", "onmouseover", "onmouseout", "ontextmenu", "id", "class")

        For seqNo = 0 To UBound(notEventStr)
            pattern = notEventStr(seqNo) & "=[\""\']*[^|)|>|\s]*[\""|'|)|\s]*"

            Set Result_Matches_Collection = RegExpExec(pattern, contentsText)

            For Each Result_Match In Result_Matches_Collection
                'Response.Write "<XMP>" & Result_Match.Value & "</XMP><br>"
                contentsText = Replace(contentsText,Result_Match.Value,"")
            Next
        Next

        '** 스크립트 처리
        S_Idx = ""
        E_Idx = ""
        Pre_Idx = ""
        pattern = "<script[^>]+|</s"
        pattern = Split(pattern, "|")

        For seqNo = 0 To UBound(pattern)
            Set Result_Matches_Collection = RegExpExec(pattern(seqNo), contentsText)

            For Each Result_Match In Result_Matches_Collection
                If seqNo = 0 Then
                    S_Idx = S_Idx & Result_Match.FirstIndex & "|"
                Else
                    E_Idx = E_Idx & Result_Match.FirstIndex & "|"
                End If
            Next
        Next

        S_Idx = Split(S_Idx,"|")
        E_Idx = Split(E_Idx,"|")

        For seqNo = 0 To UBound(S_Idx) - 1
            If Pre_Idx = "" Then
                Work_Str = Mid(contentsText, S_Idx(seqNo), E_Idx(seqNo)-S_Idx(seqNo))
            Else
                Work_Str = Mid(contentsText, S_Idx(seqNo)-Pre_Idx, E_Idx(seqNo)-S_Idx(seqNo))
            End If

            contentsText = Replace(contentsText, Work_Str, "")
            Pre_Idx = CInt(E_Idx(seqNo)-S_Idx(seqNo))
        Next

        contentsText = advReplace(contentsText, "</script>", "")
        '** 스크립트 처리 완료

        CheckHTML = contentsText
    End Function


    '정규화 관련 함수
    '------------------
    Public Function RegExp_Test(partrn, checkText)
        Dim oRegExp

        If partrn = "" Or checkText = "" Then
            RegExp_Test = False
        Else
            Set oRegExp = New RegExp

            oRegExp.Pattern = partrn
            oRegExp.IgnoreCase = True

            RegExp_Test = oRegExp.Test(checkText)

            Set oRegExp = Nothing
        End If
    End Function

    Public Function RegExpExec(Patrn, TestStr)
        Dim ObjRegExp

        On Error Resume Next

        Set ObjRegExp = New RegExp

        ObjRegExp.Pattern = Patrn       '** 정규 표현식 패턴
        ObjRegExp.Global = True         '** 문자열 전체를 검색함
        ObjRegExp.IgnoreCase = True     '** 대.소문자 구분 안함

        Set RegExpExec = ObjRegExp.Execute(TestStr)
        Set ObjRegExp = Nothing
    End Function

	'대소문자 구분없이 Replace 적용
	'---------------------------------
    Public Function advReplace(ByRef Str, ByVal Patrn, ByVal ReplStr)
        Dim ObjRegExp

        On Error Resume Next

        Set ObjRegExp = New RegExp

        ObjRegExp.Pattern = Patrn       '** 정규 표현식 패턴
        ObjRegExp.Global = True         '** 문자열 전체를 검색함
        ObjRegExp.IgnoreCase = True     '** 대.소문자 구분 안함

        advReplace = ObjRegExp.Replace(Str, ReplStr)
        Set ObjRegExp = Nothing
    End Function


	'메일발송
	'   title           : 메일제목
	'   fromMail        : 보내는 메일주소
	'   toMail          : 받는 메일주소
	'   mailContents    : 메일내용
	'------------------------------
    Function mailSend(ByVal title, ByVal fromMail, ByVal toMail, ByRef mailContents)
        If (title = "" Or fromMail = "" Or toMail = "" Or mailContents = "") Then
            Send_Mail = False
        Else
            Dim iMsg, iConf

            Const cdoSendUsingPort = 1
            Const strSmartHost = "localhost"	'Host 설정

            'CDO 메시지 개체 생성
            Set iMsg = CreateObject("CDO.Message")

            'SendUsing 속성을 지정하기 위한 개체 생성
            Set iConf = iMsg.Configuration

            With iConf.Fields
                .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
                .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSmartHost
                .item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
                .Update
            End With

            '메일발송
            With iMsg
                .To = toMail
                .From = fromMail
                .Subject = title
                .HTMLBody = mailContents
                .Send
            End With

            Set iConf = Nothing
            Set iMsg = Nothing

            mailSend = True
        End If
    End Function
%>