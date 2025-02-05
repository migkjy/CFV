<!-- METADATA TYPE="typelib" NAME="ADODB Type Library" UUID="00000205-0000-0010-8000-00AA006D2EA4"-->
<% @codepage=65001 %>
<% session.CodePage = "65001" %>

<%
    Response.Expires = -1
    Response.ExpiresAbsolute = Now() - 1
    Response.AddHeader "pragma", "no-cache"  
    Response.AddHeader "cache-control", "private"
    Response.CacheControl = "no-cache"  
    Response.CharSet = "utf-8"



if Request.ServerVariables("HTTPS")="off" Then
    Response.Redirect("https://"&Request.ServerVariables("HTTP_HOST")&Request.ServerVariables("URL"))
End if


 '##########################기본설정############################################################# 
Dim title1
title1=" 크파케이션"
'#######################'메인 페이지 기본설정##################################################### 

Dim title2
title2="크파케이션" 


CONST GLOBAL_NM                         = "주식회사 서아"
CONST GLOBAL_URL                         = "https://www.cfvacation.com"
CONST GLOBAL_IMG_URL               = "https://www.cfvacation.com"
CONST GLOBAL_SIN                          = "서아"
CONST GLOBAL_MAIL                      = "seoatour@gmail.com"
CONST GLOBAL_TEL                         = "T. 070-8832-3896"
CONST GLOBAL_FAX                        = "F. 02-523-6097"
CONST GLOBAL_JU                           = "서울시 강남구 봉은사로 129-1, 6층 608호(논현동)" 
CONST GLOBAL_BANK                     = "우리은행 : 1005-901-021223  / 예금주 : (주)서아" 
CONST GLOBAL_BANK1                     = "우리은행 : 1005-901-021223<br>예금주 : (주)서아" 
CONST GLOBAL_BANK2                     = "우리은행 : 1005-901-021223 / (주)서아" 

CONST GLOBAL_COM_TEL              = " 070-8832-3896"
CONST GLOBAL_COM_FAX             = "02-523-6097"


CONST GLOBAL_SA                           = "516-87-02561" 
CONST GLOBAL_TONG                     = "제2024-서울강남-000호" 
CONST GLOBAL_TOUR		                = "제2024-000005호" 
CONST GLOBAL_CEO                       = "김현우 " 
CONST GLOBAL_UP                          = "서비스" 
CONST GLOBAL_JO                           = "일반여행업" 


CONST GLOBAL_COM_IN		            = "금액 : 3천만원&nbsp;&nbsp;보험기간 : 매년 10/17 ~ 다음해 10/17&nbsp;피보험자 : 서울시관광협회"
CONST COM_IN		                         = "금액 : 3천만원&nbsp;&nbsp;보험기간 : 매년 10/17 ~ 다음해 10/17&nbsp;피보험자 : 서울시관광협회"

CONST GLOBAL_SE                           = "김현우" 
CONST GLOBAL_BU                          = "개인정보관리 담당자" 


CONST PRIVACY_NAME1               = "최선영 " 
CONST PRIVACY_BU1                     = "개인정보관리 책임자" 
CONST PRIVACY_NU1                    = "대표"
CONST PRIVACY_PH1                    = "T. 070-8832-3896"
CONST PRIVACY_ME1                   = "seoatour@gmail.com"

CONST PRIVACY_NAME2             = "김현우 " 
CONST PRIVACY_BU2                   = "개인정보관리 담당자" 
CONST PRIVACY_NU2                  = "차장"
CONST PRIVACY_PH2                  = "T. 070-8832-3896"
CONST PRIVACY_ME2                 = "seoatour@gmail.com"


CONST COPYRIGHT                    = "Copyright @ 2024 SEOATOUR Co.,Ltd. All Right Reserved."

CONST KAKAOKEY                     = "**************"
CONST SMS_ID                            = "**************"
CONST SMS_KEY                         = "**************"


CONST GLOBAL_STA	             = "2024년 08월 01일" 
CONST GLOBAL_DATE	             = "2024년 08월 01일" 

CONST GLOBAL_SS                   = "(주)서아"




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

	SUB CloseRS(ByRef Rs)
		Rs.Close
		set Rs = Nothing
	END Sub




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

Sub subBa001(cd_fg, now_cd)
	If IsNull(now_cd_fg) Then now_cd_fg =""
	sql = "	exec proc_TB_ba001_cd_cdnm	'"&cd_fg&"'"
	
	If cd_fg="city" Then 
			sql = "	exec proc_TB_ba001_cdnm_remark_city	'"&cd_fg&"'"
			response.write sql
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

'==================================== 해당 년 반환 ============================
Sub subYear(start_year, end_year, now_year)

	'For j=start_year To CInt(end_year)
'		Response.write "<option value='"& j &"' "&fnSemSem(j,now_year)&">"& j &"</option>" & VbCrlf
	'Next
	
	 For j=end_year To CInt(start_year) step -1
		Response.write "<option value='"& j &"' "&fnSemSem(j,now_year)&">"& j &"</option>" & VbCrlf
	'response.write j
	Next
	
	
	
'  "& fnSemSem(start_year,now_year) &"

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



'################## 쇼핑몰 설정 #######################

	domain = "cfcation.gabia.i" ' 메일발송시 이미지 출력을 위한 도메인설정
	size_limit = "2" '파일업로드 제한 (기본단위 : Mbyte)
	default_dir = "D:\hosting\f5sys.xyz\shop\" '기본 dir경로명
	recent = "7" '신규상품 정의 (일)
	pagesize = 20 'sc 페이지에서 상품 출력 개수
	site_code = "A" '사이트의 고유코드
	'transport = "2500" '배송비
	'jeju = "5000" '배송지가 제주도일경우 배송비 추가 항공요금 설정(제주도에서사면 5500원이 추가된다는 뜻)
	'average_m = "30000" '배송비 추가 기준(3만원미만이면 배송비가 추가된다는 뜻)

	image_folder = default_dir&"\data" '파일이 저장되는 폴더 (설정 불필요)
	directory = default_dir&"\data\webmail\" '웹메일 저장 디렉토리 (설정불필요)
	DataDir = default_dir&"\data\webmail\" '위즈윅에서 그림저장되는 절대경로 (설정불필요)
	homedirectory = default_dir '홈페이지 수정시 경로 (설정불필요)
	url = Request.ServerVariables("SERVER_NAME") 
	DataUrl="http://"&url&"/data/webmail/" '위즈윅에서 저장된 그림을 보여주기위한 url경로 (설정불필요)
'##################################################################################################
%>

