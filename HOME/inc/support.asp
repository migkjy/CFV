<%
 
'--------------------------------------------------------
Function title_cutting(s, m)
Dim bytecnt, charmove, nn
bytecnt = 0 
nn = Len(s)
for charmove = 1 to nn
if ASC(Mid(s,charmove,1)) > 0 then
 bytecnt = bytecnt + 1
elseif ASC(Mid(s,charmove,1)) < 0 then
	bytecnt = bytecnt + 2
end if
if bytecnt >= int(m) then
	 s = Mid(s,1,charmove)&"..."
 charmove = nn
end if
next
title_cutting = s
End Function


'--------------------------------------------------------
Function won_cutting(w)
Dim wcnt, wtemp, nn, wwt
wwt = 0
if w < 0 then
wwt = 1 
w = w *-1
end if
w = Formatcurrency(w) 
nn = Len(w)
for wcnt = 1 to nn
if wcnt > 1 then
	wtemp = wtemp & Mid(w,wcnt,1)
end if
next
if wwt = 1 then
Response.write "-"&wtemp
else
Response.write wtemp
end if
End Function



'-------------------------------------------------------
Function won_cutting2(w)
Dim wcnt, wtemp, nn, wwt
wwt = 0
if w < 0 then
wwt = 1 
w = w *-1
end if
w = Formatcurrency(w) 
nn = Len(w)
for wcnt = 1 to nn
if wcnt > 1 then
	wtemp = wtemp & Mid(w,wcnt,1)
end if
next
if wwt = 1 then
won_cutting2 =  "-"&wtemp
else
won_cutting2 = wtemp
end if
End Function


'요일구하기---------------------------------------------------------
Function getYoil(str)
	yoilNum = WeekDay(str)
	select case yoilNum
		case 1
			yoilStr = "일"
		case 2
			yoilStr = "월"
		case 3
			yoilStr = "화"
		case 4
			yoilStr = "수"
		case 5
			yoilStr = "목"
		case 6
			yoilStr = "금"
		case 7
			yoilStr = "토"
	end select
	getYoil = yoilStr
End Function


Function goPage(a,b,Aspfilename,etc) '페이징 함수

    Dim blockpage, p
    
    blockpage=Int((gotopage-1)/10)*10+1
    If blockPage = 1 Then
        Response.Write "<span class='direction'><<</span>&nbsp;&nbsp;"
    Else
        Response.Write"<a href='"&Aspfilename &"& gotopage=" & blockPage-1 & etc &"' class='direction'>이전</a>&nbsp;&nbsp;" 
    End If
    
    p=1
    Do Until p > 10 or blockpage > Pagecount
        If blockpage=int(gotopage) Then
            Response.Write "<strong>"& blockpage &"</strong>&nbsp;&nbsp;" 
        Else
            Response.Write"<a href='"&Aspfilename &"&gotopage=" & blockpage & etc & "'>" & blockpage & "</a>&nbsp;&nbsp;"
        End If
            
       blockpage=blockpage+1
       p = p + 1
    Loop
    
    If blockpage > Pagecount Then
        Response.write "<span class='direction'>>></span>"
    Else
        Response.write "<a href='"&Aspfilename &"&gotopage=" &  blockpage & etc &"' class='direction'>다음</a>"
    End If 

End Function


 '페이징---------------------------------------------------------
Function fn_goPage(a,b,c,Aspfilename,etc)

   Dim blockpage, p

   if inStr(Aspfilename,"?") > 0 then 
	    strStartArg = "&"
   else
	    strStartArg = "?"
   end if
  

   
   blockpage=Int((gotopage-1)/pageblock)*pageblock+1
   if blockPage = 1 Then
       Response.Write "<span class='direction'><<</span>&nbsp;&nbsp;"
   Else
       Response.Write"<a href='"&Aspfilename&strStartArg &"gotopage=" & blockPage-1 & etc &"' class='direction'>이전</a>&nbsp;&nbsp;"
   End If

   p=1
   Do Until p > pageblock or blockpage > b
      If blockpage=int(gotopage) Then
         Response.Write "<strong>"& blockpage &"</strong>&nbsp;&nbsp;" 
      Else
         Response.Write"<a href='"&Aspfilename&strStartArg &"gotopage=" & blockpage & etc & "'>" & blockpage & "</a>&nbsp;&nbsp;"
      End If
	         
      blockpage=blockpage+1
      p = p + 1
   Loop

   if blockpage > Pagecount Then
      Response.write "<span class='direction'>>></span>"
   Else
      Response.write "<a href='"&Aspfilename&strStartArg &"gotopage=" &  blockpage & etc &"' class='direction'>다음</a>"
   End If 

End Function

Function Func_ClearTag(TargetText)
		set tagfree = New Regexp 
		tagfree.Pattern= "<[^>]+>" 
		tagfree.Global=true 
		Func_ClearTag =tagfree.Replace(TargetText,"")
End Function
 
 
  FUNCTION price_up(byval p,e)

     if p="" or isnull(p) then
 	     p=0
     end if
 
     if e="" or isnull(e) then
 	     e=0
     end if

     tot_amt = Cdbl(p) * e
     tot_amt1 = round(tot_amt)

     price_up = tot_amt1

    End function

'*********************************************************************' 코레일인젝션 처리
Function SQLInj(str)
  Dim txt

  txt = str

  txt = REPLACE( txt, "'", "´" )
	txt = REPLACE( txt, ";", "" )
	txt = REPLACE( txt, "--", "" )
	txt = REPLACE( txt, "select", "", 1, -1, 1 )
	txt = REPLACE( txt, "insert", "", 1, -1, 1 )
	txt = REPLACE( txt, "update", "", 1, -1, 1 )
	txt = REPLACE( txt, "delete", "", 1, -1, 1 )
	txt = REPLACE( txt, "drop", "", 1, -1, 1 )
	txt = REPLACE( txt, "union", "", 1, -1, 1 )
'	txt = REPLACE( txt, "and", "", 1, -1, 1 )
'	txt = REPLACE( txt, "or", "", 1, -1, 1 )
	txt = REPLACE( txt, "1=1", "", 1, -1, 1 )

	txt = REPLACE( txt, "sp_", "", 1, -1, 1 )
	txt = REPLACE( txt, "xp_", "", 1, -1, 1 )
	txt = REPLACE( txt, "@variable", "", 1, -1, 1 )
	txt = REPLACE( txt, "@@variable", "", 1, -1, 1 )
	txt = REPLACE( txt, "exec", "", 1, -1, 1 )
	txt = REPLACE( txt, "sysobject", "", 1, -1, 1 )

  SQLInj = txt

End Function	

'------------ 랜덤비밀번호 생성 ex)str = RndomString(5) ------------
Function RndomString(Cnt)
	str = ""
	Randomize()

	For cntArr = 1 To Cnt
		flg = Int(Rnd() * 10)

	If flg > 5 Then
		tStr = Int(Rnd() * 10)   ' 숫자 넣기
	Else
		tStr = Int(Rnd() * 26) 
		tStr = Chr(asc("a") + tStr)  ' 문자 넣기
	End If

	str = str & tStr
	Next

	RndomString = str
End Function
'------------ 랜덤비밀번호 생성 ex)str = RndomString(5) ------------

'*********************************************************************'html 코드 및 일반 텍스트 혼용일 경우
Function check_html(CheckValue) 
		CheckValue = Replace(CheckValue, "&" ,"&amp;")
		CheckValue = Replace(CheckValue, "<" ,"&lt;")
		CheckValue = Replace(CheckValue, ">" ,"&gt;")
		CheckValue = Replace(CheckValue, "'","''" )
		CheckValue = Replace(CheckValue, Chr(34),"&quot;")
		CheckValue = Replace(CheckValue,  "<br>",chr(13))
	check_html = CheckValue
End Function

Function CheckWord(CheckValue)	
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "&#39;")
		CheckValue = replace(CheckValue, ",", "&#44;")
		CheckWord=CheckValue	
End Function


	'보여줄때 원래대로 보여준다.
Function CheckWordre(CheckValue)	
		CheckValue = replace(CheckValue, "&amp;", "&")
		CheckValue = replace(CheckValue, "&lt;", "<")
		CheckValue = replace(CheckValue, "&gt;", ">")
		CheckValue = replace(CheckValue, "&quot;", Chr(34))
		CheckValue = replace(CheckValue, "&#39;", "'")
		CheckValue = replace(CheckValue, "&#44;", ",")
		CheckWordre=CheckValue	
End Function



 

 Function GetUniqueName(byRef strFileName, DirectoryPath)

  Dim strName, strExt
    strName= Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)
    strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)

  Dim fso
  Set fso = Server.CreateObject("Scripting.FileSystemObject")

  Dim bExist : bExist = True
  Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt 
  Dim countFileName : countFileName = 0 

  Do While bExist
   If (fso.FileExists(strFileWholePath)) Then
    countFileName = countFileName + 1
    strFileName = strName & "(" & countFileName & ")." & strExt
    strFileWholePath = DirectoryPath & "\" & strFileName
   Else
    bExist = False
   End If
  Loop

  GetUniqueName = strFileWholePath
 
 End Function


 Function makeThumbnail(ByVal img_path, ByVal img_name, ByVal thumb_name, ByVal thumb_wsize, ByVal thumb_hsize)

     Dim thumb_path, thumb_image, objImage
     Set objImage    = Server.CreateObject("DEXT.ImageProc")
     objImage.Quality =100

     IF objImage.SetSourceFile(img_path &"\"& img_name) Then

          thumb_path = img_path &"\"& thumb_name &".jpg"
          thumb_image = objImage.SaveasThumbnail(thumb_path, thumb_wsize, thumb_hsize, true)
     End IF

     makeThumbnail = thumb_image

 End Function


 FUNCTION file_del(fileDir)

  Set fso = Server.CreateObject("Scripting.FileSystemObject") 
  
    If fso.FileExists(fileDir) = True Then 
       fso.DeleteFile fileDir, True 
    end if

 END FUNCTION





FUNCTION TestCaptcha(byval valSession, byval valCaptcha)
	dim tmpSession
	valSession = Trim(valSession)
	valCaptcha = Trim(valCaptcha)

	if (valSession = vbNullString) or (valCaptcha = vbNullString) then
		TestCaptcha = false
	else
		tmpSession = valSession
		valSession = Trim(Session(valSession))
		Session(tmpSession) = vbNullString
		if valSession = vbNullString then
			TestCaptcha = false
		else
			valCaptcha = Replace(valCaptcha,"i","I")
			if StrComp(valSession,valCaptcha,1) = 0 then
				TestCaptcha = true
			else
				TestCaptcha = false
			end if
		end if		
	end if
END FUNCTION
 

 
 Function bank_chkname(byval s_bank)
  Select case s_bank
  	CASE "0" : s_bank_nm="은행입금"
  	CASE "1" : s_bank_nm="현금"
  	CASE "2" : s_bank_nm="카드"
  	CASE "3" : s_bank_nm="전자결제"
  End Select
	 bank_chkname = s_bank_nm
End function


Function iogubun_chkname(byval iogubun)
   Select case iogubun 
      Case "I" : iio_nm="입금"
      Case "O" : iio_nm="환불"
   End select 

	 iogubun_chkname = iio_nm
End function

   
FUNCTION ch_changeday(byval s_procd)
    if Len(s_procd)=8 then
      s_change_day = Left(s_procd,4)&"-"&Mid(s_procd,5,2)&"-"&Right(s_procd,2)
    Else
  	  s_change_day = s_procd
    End if
	
	  ch_changeday = s_change_day

End function


FUNCTION ch_changetime(byval t)

  real_t = Trim(t)
  
  if real_t ="" or isnull(real_t) then
     s_change_time = real_t
  else
  	
    if Len(real_t)=4 then
      s_change_time = Left(real_t,2)&":"&Right(real_t,2)
    Else
  	  s_change_time = real_t
    End if
	
	End if

	  ch_changetime = s_change_time

End function


FUNCTION ch_procd_hnm(byval s_procd)
   Select Case s_procd 
      Case "0" : prod_cd_nm= "예약신청"
      Case "1" : prod_cd_nm= "예약확인"
      Case "3" : prod_cd_nm= "예약완료"
      Case "4" : prod_cd_nm= "예약취소"
      Case "5" : prod_cd_nm= "대기예약"
   End select

	 ch_procd_hnm = prod_cd_nm
End function





FUNCTION ch_order_subnm(byval s_procd)
   Select Case s_procd 
      Case "10" : prod_cd_nm= "단체여행"
      Case "20" : prod_cd_nm= "가족여행"
      Case "30" : prod_cd_nm= "온천여행"
      Case "40" : prod_cd_nm= "자유여행"
      Case "50" : prod_cd_nm= "문화탐방"
      Case "60" : prod_cd_nm= "트래킹"
      Case "70" : prod_cd_nm= "골프투어"
      Case "80" : prod_cd_nm= "패스티켓"
      Case Else : prod_cd_nm= "기타문의"
   End select

	    ch_order_subnm = prod_cd_nm
End function
    

FUNCTION ch_order_hotelnm(byval s_procd)
   Select Case s_procd 
         Case "A" : prod_cd_nm= "3성급"
         Case "B" : prod_cd_nm= "준4성급"
         Case "C" : prod_cd_nm= "4성급"
         Case "D" : prod_cd_nm= "준5성급"
         Case "E" : prod_cd_nm= "5성급"
         Case "F" : prod_cd_nm= "료칸"
         Case Else : prod_cd_nm= "기타숙소"
   End select
	 ch_order_hotelnm = prod_cd_nm

End function

Function gender_chkname(byval gender)
   Select case gender 
      Case "M" : gender_nm="남자"
      Case "F" : gender_nm="여자"
   End select 

	 gender_chkname = gender_nm
End function
  
 
 
FUNCTION  order_sub_areanm(byval s_area)
   Select Case s_area 
      Case "10" : area_cd_nm= "가이드 일정"
      Case "20" : area_cd_nm= "자유 일정"
      Case "30" : area_cd_nm= "가이드+자유일정"
   End select

	    order_sub_areanm = area_cd_nm
End function


FUNCTION order_sub_tripnm(byval s_trip)
   Select Case s_trip 
      Case "10" : tp_trip_nm= "허니문"
      Case "20" : tp_trip_nm= "가족여행"
      Case "30" : tp_trip_nm= "일반여행"
      Case "40" : tp_trip_nm= "골프여행"
      Case "50" : tp_trip_nm= "트래킹"
      Case "60" : tp_trip_nm= "그 외"
      Case Else : tp_trip_nm= "기타문의"
   End select

	    order_sub_tripnm = tp_trip_nm
End function
    
 


'지정된 숫자만큼 문자열을 출력해 준다.
	FUNCTION cutStr(str, cutLen)
		Dim strLen, strByte, strCut, strRes, char, i
		strLen = 0
		strByte = 0
		strLen = Len(str)
			for i = 1 to strLen
				char = ""
				
				strCut = Mid(str, i, 1)	'	일단 1만큼 잘라서 strRes에 저장한다.
				char = Asc(strCut)		'	아스키 코드값 읽어오기
				char = Left(char, 1)
				IF char = "-" Then			'	"-"이면 2바이트 문자로 처리
					strByte = strByte + 2
				ELSE
					strByte = strByte + 1
				END IF

				IF cutLen < strByte Then
					strRes = strRes & ".."
					exit for
				ELSE
					strRes = strRes & strCut
				END IF
			next
		cutStr = strRes
	END FUNCTION



  FUNCTION castMoney(str)
		Dim strTemp

		if len(str) > 0 then str = trim(str)

		IF str = "" or isNull(str) or str = 0 THEN
			castMoney = "전화문의"
		ELSE
			'castMoney = "￦" & FormatNumber(str,0,0) & ""
			castMoney =  FormatNumber(str,0,0) & ""
		END IF
	END FUNCTION

'#####################################################################
'경고창 띄우는 함수
Sub Alert_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "history.back();"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_No_Back_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_Close_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "window.close();"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_Window_Location(args1,args2)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args1 &"');"
  write_String = write_String & "location.href='"& args2 &"';"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

%>