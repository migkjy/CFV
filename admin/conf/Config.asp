<!-- METADATA TYPE="typelib" NAME="ADODB Type Library" UUID="00000205-0000-0010-8000-00AA006D2EA4"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<%

'#################################'관리자 페이지 기본설정###########################################

Dim title1
title1=" 서아"

'#################################'메인 페이지 기본설정##########################################################

Dim title2
title2=" 서아"


'#################################'전역 상수##########################################################
CONST GLOBAL_NM		                    = "(주)서아"
CONST GLOBAL_COMPANY_TEL       = "070-8832-3896"
CONST GLOBAL_URL			              = "https://www.cfvacation.com"
CONST GLOBAL_URL_WORD			 = "https://www.cfvacation.com"
CONST GLOBAL_SIN			                   = "서아"
CONST GLOBAL_MAIL				   	     = "seoatour@gmail.com"
CONST GLOBAL_TEL					          = "T. 070-8832-3896"
CONST GLOBAL_FAX					     = "F. 02-523-6097"
CONST GLOBAL_JU				              = "서울시 강남구 봉은사로 129-1, 6층 608호(논현동)" 
CONST GLOBAL_BANK				         = "우리은행 : 1005-901-021223 / 예금주 : (주)서아" 

'##################################################################################################

CONST GLOBAL_COM_JU		         = "서울시 강남구 봉은사로 129-1, 6층 608호(논현동)" 
CONST GLOBAL_COM_NM		         = "(주)서아" 
CONST GLOBAL_COM_NU		         = "516-87-02561" 
CONST GLOBAL_TOUR		                  = "제2022-000005호" 
CONST COM_TONG                            = "제2024-서울강남-000호" 
CONST GLOBAL_COM_CEO	             = "김현우 " 
CONST GLOBAL_COM_GE		         = "서비스" 
CONST GLOBAL_JO				              = "일반여행업"
CONST GLOBAL_COM_IN		              = "금액 : 3천만원&nbsp;&nbsp;보험기간 : 매년 10/17 ~ 다음해 10/17&nbsp;피보험자 : 서울시관광협회"
CONST MASTER_USER			              = "20120001"

CONST COPYRIGHT                             = "Copyright @ 2024 SEOATOUR Co.,Ltd. All Right Reserved."

CONST KAKAOKEY                             = "*************"
CONST SMS_ID                                     = "**************"
CONST SMS_KEY                                = "**************"

'##################################################################################################

'#######################################'Database Open############################################# 
SUB OpenF5_DB(ByRef objConn)
	CONST str_F5 = "Provider=SQLOLEDB.1;Password=dragon64^^;Persist Security Info=True;User ID=cfcation;Initial Catalog=dbcfcation;Data Source=db.cfcation.gabia.io,1433"
	SET objConn = Server.CreateObject("ADODB.Connection")
	objConn.Provider = "sqloledb"
	objConn.CursorLocation = 3
	objConn.Open str_F5
END SUB
'#######################################'Database Close############################################# 
SUB CloseF5_DB(ByRef objConn)
	objConn.Close
	SET objConn = Nothing
END SUB


'#################################### Database Close#######################################
	SUB CloseRS(ByRef Rs)
		Rs.Close
		set Rs = Nothing
	END Sub

'#################################### Rs Close#######################################


SUB fnUrl(msg,url)
		If Trim(msg) = "" Then
			msg		= " "
		Else
			msg		= "alert('"& msg &"'); "
		End If

		If Trim(url) = "" Then 
			url1 = "history.back(); "
		Else
			url1 = url & " ;  "
		End if
		
		Response.Write	"<SCRIPT LANGUAGE=javaScript>	"		& VbCrlf		&_
											msg												& VbCrlf		&_
											url1												& VbCrlf		&_
										"</SCRIPT>"
		Response.END
END Sub

SUB ClsPop(msg,url) '// 상품수정시 롤백관련
		If Trim(msg) = "" Then
			msg		= " "
		Else
			msg		= "alert('"& msg &"'); "
		End If

		If Trim(url) = "" Then 
			url1 = "self.close(); "
		Else
			url1 = url & " ;  "
		End if
		
		Response.Write	"<SCRIPT LANGUAGE=javaScript>	"		& VbCrlf		&_
											msg												& VbCrlf		&_
											url1												& VbCrlf		&_
										"</SCRIPT>"
		Response.END
END Sub

Function fnSemSem(value1,value2)	'//셀렉트박스
	If Trim(LCase(value1)) = Trim(LCase(value2)) Then
		msg		= " selected "
	Else
		msg		= ""
	End If
	
	fnSemSem = msg
End Function

Function fnDieDie(value1,value2, chk)		'//체크박스
	If Trim(LCase(value1)) = Trim(LCase(value2)) Then
		msg		= " "& chk
	Else
		msg		= ""
	End If
	
	fnDieDie = msg
End Function


'==================================== 권한관리 =================================
Sub subPower(cd, emp_no)
    

		sql = "	exec proc_TB_em300_s01_power '"&cd&"', '"&emp_no&"' "

		Set Rs5 = objConn.Execute(sql)

		If Not Rs5.Eof Then
			use_fg="Y"
			Response.write "<option value='Y' "&fnSemSem(use_fg,"Y")&">사용중</option>" & VbCrlf
			Response.write "<option value='N' "&fnSemSem(use_fg,"N")&">사용안함</option>" & VbCrlf
		Else
			use_fg="N"
			Response.write "<option value='I' "&fnSemSem(use_fg,"N")&">사용하기</option>" & VbCrlf
			Response.write "<option value='' "&fnSemSem(use_fg,"N")&">사용안함</option>" & VbCrlf
		End if
			CloseRs Rs5 '레코드셋클로즈

End Sub

'==================================== 권한관리 ================================= 

'==================================== 기초코드 =================================
Sub subBa001_Email(cd_fg, now_cd)
	If IsNull(now_cd_fg) Then now_cd_fg =""

	If cd_fg="city" Then 
			sql = "	exec proc_TB_ba001_cdnm_remark_city	'"&cd_fg&"'"
			
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd_nm") &"'>"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
			
		CloseRs Rs5 '레코드셋클로즈
	Else
			sql = "	exec proc_TB_ba001_cdnm_remark	'"&cd_fg&"'"
			
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd_nm") &"'>"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
					CloseRs Rs5 '레코드셋클로즈
	End if

End Sub


'==================================== 기초코드 =================================
Sub subBa001(cd_fg, now_cd)
	If IsNull(now_cd_fg) Then now_cd_fg =""
	sql = "	exec proc_TB_ba001_cd_cdnm	'"&cd_fg&"'"
	
	If cd_fg="city" Then 
			sql = "	exec proc_TB_ba001_cdnm_remark_city	'"&cd_fg&"'"
			'response.write sql
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd") &"' "&fnSemSem(Rs5("cd"),now_cd)&">"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
			CloseRs Rs5 '레코드셋클로즈
	Else
			sql = "	exec proc_TB_ba001_cd_cdnm	'"&cd_fg&"'"
			
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd") &"' "&fnSemSem(Rs5("cd"),now_cd)&">"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
			CloseRs Rs5 '레코드셋클로즈
	End if
End Sub


'==================================== 기초코드 =================================
Sub subBa001_PH(ph, now_cd)

	
	If cd_fg="P" Then 
			sql = "	exec proc_TB_ba001_cd_cdnm_PH	'"&ph&"'"
			'response.write sql
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd") &"' "&fnSemSem(Rs5("cd"),now_cd)&">"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
			CloseRs Rs5 '레코드셋클로즈
	Else
			sql = "	exec proc_TB_ba001_cd_cdnm_PH	'"&ph&"'"
			
			Set Rs5 = objConn.Execute(sql)
			If Not Rs5.Eof Then
				Do Until Rs5.Eof
				
					Response.write "<option value='"& Rs5("cd") &"' "&fnSemSem(Rs5("cd"),now_cd)&">"& Rs5("cd_nm") &"</option>" & VbCrlf

				Rs5.MoveNext
				Loop
			Else
					Response.write "<option value=''>선택하기</option>" & VbCrlf
			End if
			CloseRs Rs5 '레코드셋클로즈
	End if
End Sub

'==================================== 기초코드 =================================
'==================  메뉴 불러오기 ================================
Function fnTitle(cd)
	sql =	"	proc_TB_ba001_s01_leftlist	'PAGE','"& cd &"' "
	Set Rs9 = objConn.Execute(sql)
	If Not Rs9.Eof Then 
		title			= Rs9("cd_nm")	
	End If
	CloseRs Rs9 '레코드셋클로즈
	fnTitle = title
End Function
'==================  메뉴 불러오기 ================================
'==================================== 해당 년 반환 ============================

Sub subYear(start_year, end_year, now_year)

	For j=end_year To CInt(start_year) step -1
		Response.write "<option value='"& j &"' "&fnSemSem(j,now_year)&">"& j &"</option>" & VbCrlf
	'response.write j
	Next
End Sub
'==================================== 해당 년 반환 ============================

'==================================== 해당 월 반환 ============================
Sub subMonth(now_month)

	For j=1 To 12
		sel_month	= Right("0"&j,2)
		Response.write "<option value='"& sel_month &"' "&fnSemSem(sel_month,now_month)&">"& Right("0"&j,2) &"</option>" & VbCrlf
	Next
'	"& fnSemSem(Right("0"&j,2),now_year) &"
End Sub
'==================================== 해당 월 반환 ============================



Sub subDay(sel_year,mon) 
		mon		= CInt(mon)
		
		if mon=1 Or mon=3 Or mon=5 Or mon=7 Or mon=8 Or mon=10 Or mon=12 Then 
			sel_day = 31
		ElseIf mon=2 Then 
			if sel_year  Mod 4=0 Then 
				sel_day = 29 
			Else 
				sel_day = 28  '// 2월처리
			End if
		Else  
			sel_day = 30
		End If
		

		opt = "<option value=''>--</option>"
		For j=1 To sel_day
			opt = opt & "<option "
			if i < 10 Then
				opt = opt & "value='0" & i + "'>" & i & "</option>" & VbCrlf
			Else 
				opt = opt & "value='" & i + "'>" & i & "</option>" & VbCrlf
			End if
		Next

		Response.write opt

End Sub


%>
 

